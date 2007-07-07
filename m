From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sat, 07 Jul 2007 08:21:57 +0000
Subject: Re: [lm-sensors] [PATCH] First cut of a adt7470 driver
Message-Id: <468F4D25.2030609@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070706211144.GI3435@tree.beaverton.ibm.com>
In-Reply-To: <20070706211144.GI3435@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Darrick J. Wong wrote:
> Hi there,
> 
> Below is a first draft of a driver for the ADT7470 chip.  I've tested
> the driver against the adt7470 in the IBM IntelliStation Z30 and as far
> as I can tell it's good for controlling the speed of the CPU heatsink
> fans and monitor CPU temperature.  Please let me know what you think of
> the driver.  The patch should apply cleanly against 2.6.22-rc7.
> 

Hi,

Below is a review of your driver.

> --- /dev/null
> +++ b/drivers/hwmon/adt7470.c
> @@ -0,0 +1,875 @@
> +/*
> + * A hwmon driver for the Analog Devices ADT7470
> + * Copyright (C) 2007 IBM
> + *
> + * Author: Darrick J. Wong <djwong@us.ibm.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License,
> + * as published by the Free Software Foundation - version 2.
> + */
> +

Are you sure you want this to be GPL version 2 only? The kernel as a whole is 
GPL version 2 only, but many drivers / subsystems have the "or any later 
version" language, this will make it much easier for the kerenl to go GPL v3, 
if the kernel community ever decides todo so.

> +#include <linux/module.h>
> +#include <linux/jiffies.h>
> +#include <linux/i2c.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/err.h>
> +#include <linux/mutex.h>
> +#include <linux/delay.h>
> +#include <linux/log2.h>
> +
> +#define DRV_VERSION "0.22"
> +

No driver version defines and prints please. Once the driver is in the kernel 
it may seem fixes by others too and your own versioning + changelog will become 
stale and thus useless.

> +/* Addresses to scan */
> +static unsigned short normal_i2c[] = { 0x2C, 0x2E, 0x2F, I2C_CLIENT_END };
> +
> +/* Insmod parameters */
> +I2C_CLIENT_INSMOD_1(adt7470);
> +
> +/* ADT7470 registers */
> +#define ADT7470_REG_BASE		0x20
> +#define ADT7470_REG_TEMP_BASE		0x20
> +#define ADT7470_REG_TEMP_MAX		0x29
> +#define ADT7470_REG_FAN_BASE		0x2A
> +#define ADT7470_REG_FAN_MAX		0x31
> +#define ADT7470_REG_PWM_BASE		0x32
> +//#define ADT7470_REG_PWM_MAX		0x35

No c++ style comments please, also even if this is not used its fine to leave 
it uncommented.

> +#define ADT7470_REG_PWM_MAX_BASE	0x38
> +#define ADT7470_REG_PWM_MAX_MAX		0x3B
> +#define ADT7470_REG_CFG			0x40
> +#define		ADT7470_FSPD_MASK	0x04
> +#define ADT7470_REG_ALARM1		0x41
> +#define ADT7470_REG_ALARM2		0x42
> +#define ADT7470_REG_TEMP_LIMITS_BASE	0x44
> +#define ADT7470_REG_TEMP_LIMITS_MAX	0x57
> +#define ADT7470_REG_FAN_MIN_BASE	0x58
> +#define ADT7470_REG_FAN_MIN_MAX		0x5F
> +#define ADT7470_REG_FAN_MAX_BASE	0x60
> +#define ADT7470_REG_FAN_MAX_MAX		0x67
> +#define ADT7470_REG_PWM_CFG_BASE	0x68
> +#define ADT7470_REG_PWM12_CFG		0x68
> +#define		ADT7470_PWM1_AUTO_MASK	0x40
> +#define		ADT7470_PWM2_AUTO_MASK	0x80
> +#define ADT7470_REG_PWM34_CFG		0x69
> +#define		ADT7470_PWM3_AUTO_MASK	0x40
> +#define		ADT7470_PWM4_AUTO_MASK	0x80
> +#define	ADT7470_REG_PWM_MIN_BASE	0x6A
> +#define ADT7470_REG_PWM_MIN_MAX		0x6D
> +#define ADT7470_REG_PWM_TEMP_MIN_BASE	0x6E
> +#define ADT7470_REG_PWM_TEMP_MIN_MAX	0x71
> +#define ADT7470_REG_ACOUSTICS12		0x75
> +#define ADT7470_REG_ACOUSTICS34		0x76
> +#define ADT7470_REG_DEVICE		0x3D
> +#define ADT7470_REG_VENDOR		0x3E
> +#define ADT7470_REG_REVISION		0x3F
> +#define ADT7470_REG_ALARM1_MASK		0x72
> +#define ADT7470_REG_ALARM2_MASK		0x73
> +#define ADT7470_REG_PWM_AUTO_TEMP_BASE	0x7C
> +#define ADT7470_REG_PWM_AUTO_TEMP_MAX	0x7D
> +#define ADT7470_REG_MAX			0x81
> +
> +#define ADT7470_TEMP_COUNT	10
> +#define ADT7470_TEMP_REG(x)	(ADT7470_REG_TEMP_BASE + (x))
> +#define ADT7470_TEMP_MIN_REG(x) (ADT7470_REG_TEMP_LIMITS_BASE + (2 * (x)))
> +#define ADT7470_TEMP_MAX_REG(x) (ADT7470_REG_TEMP_LIMITS_BASE + (2 * (x)) + 1)
> +
> +#define ADT7470_FAN_COUNT	4
> +
> +#define ADT7470_PWM_COUNT	4
> +#define ADT7470_REG_PWM(x)	(ADT7470_REG_PWM_BASE + (x))
> +#define ADT7470_REG_PWM_MAX(x)	(ADT7470_REG_PWM_MAX_BASE + (x))
> +#define ADT7470_REG_PWM_MIN(x)	(ADT7470_REG_PWM_MIN_BASE + (x))
> +#define ADT7470_REG_PWM_TMIN(x)	(ADT7470_REG_PWM_TEMP_MIN_BASE + (x))
> +

Why all the base defines? Why not put the base address directly in the () 
macros? You do not seem to use them anywhere else.

> +#define ADT7470_VENDOR		0x41
> +#define ADT7470_DEVICE		0x70
> +#define ADT7470_REVISION	0x02
> +

Are you sure you only want to support revision 2? What are the differences? 
Shouldn't the driver be able to support other revisions too? Maybe only print a 
warning when its used with an untested revision?

> +#define ADT7470_PWM_ALL_TEMPS	0x3FF		/* "all temps" according to hwmon sysfs interface spec */
> +
> +#define REFRESH_INTERVAL	(2 * HZ)
> +#define TEMP_COLLECTION_TIME	1000		/* sleep 1s while gathering temperature data */
> +

Keep lines within 80 chars please, put long comments above the defines.

> +#define power_of_2(x)	(((x) & ((x) - 1)) = 0)
> +
> +struct adt7470_data {
> +	struct i2c_client	client;
> +	struct class_device	*class_dev;
> +	struct attribute_group	attrs;
> +	enum chips		type;

You do not seem to have an enum chips defined and you do not use type anywhere, 
maybe this can be removed?

> +	struct mutex		lock;
> +	char			valid;
> +	unsigned long		last_updated;	/* In jiffies */
> +
> +	u8			temp[ADT7470_TEMP_COUNT];
> +	u8			temp_min[ADT7470_TEMP_COUNT];
> +	u8			temp_max[ADT7470_TEMP_COUNT];
> +	u16			fan[ADT7470_FAN_COUNT];
> +	u16			fan_min[ADT7470_FAN_COUNT];
> +	u16			fan_max[ADT7470_FAN_COUNT];
> +	u16			alarms, alarms_mask;
> +	u8			force_pwm_max;
> +	u8			pwm[ADT7470_PWM_COUNT];
> +	u8			pwm_max[ADT7470_PWM_COUNT];
> +	u8			pwm_automatic[ADT7470_PWM_COUNT];
> +	u8			pwm_min[ADT7470_PWM_COUNT];
> +	u8			pwm_tmin[ADT7470_PWM_COUNT];
> +	u8			pwm_auto_temp[ADT7470_PWM_COUNT];
> +
> +	u8			raw[256];
> +};
> +
> +static int adt7470_attach_adapter(struct i2c_adapter *adapter);
> +static int adt7470_detect(struct i2c_adapter *adapter, int address, int kind);
> +static int adt7470_detach_client(struct i2c_client *client);
> +
> +static struct i2c_driver adt7470_driver = {
> +	.driver = {
> +		.name	= "adt7470",
> +	},
> +	.attach_adapter	= adt7470_attach_adapter,
> +	.detach_client	= adt7470_detach_client,
> +};
> +
> +/* 16-bit registers on the ADT7470 are low-byte first. */
> +static inline int adt7470_read16(struct i2c_client *client, u8 reg)
> +{
> +	u16 foo;
> +	foo = i2c_smbus_read_byte_data(client, reg) | ((u16)i2c_smbus_read_byte_data(client, reg + 1) << 8);
> +	return foo;
> +}
> +
> +static inline int adt7470_write16(struct i2c_client *client, u8 reg, u16 value)
> +{
> +	return i2c_smbus_write_word_data(client, reg, cpu_to_le16(value));
> +}
> +

Why use read_byte twice in read16, but write_word in write16?

> +static void adt7470_init_client(struct i2c_client *client)
> +{
> +	//struct adt7470_data *data = i2c_get_clientdata(client);
> +

Again no c+= style comments please, and why not just remove this line?

> +	int reg = i2c_smbus_read_byte_data(client, ADT7470_REG_CFG);

Insert a white line between declarations and statements please

> +	if (reg < 0) {
> +		dev_err(&client->dev, "cannot read configuration register\n");
> +	} else {
> +		// start monitoring (and do a self-test)

No c++ style comments please

> +		i2c_smbus_write_byte_data(client, ADT7470_REG_CFG, reg | 3);
> +	}
> +}
> +
> +static u16 adt7470_read_fan_min(struct i2c_client *client, int fan)
> +{
> +	return adt7470_read16(client, ADT7470_REG_FAN_MIN_BASE + (2 * fan));
> +}
> +
> +static u16 adt7470_read_fan_max(struct i2c_client *client, int fan)
> +{
> +	return adt7470_read16(client, ADT7470_REG_FAN_MAX_BASE + (2 * fan));
> +}
> +
> +static u16 adt7470_read_fan(struct i2c_client *client, int fan)
> +{
> +	return adt7470_read16(client, ADT7470_REG_FAN_BASE + (2 * fan));
> +}
> +

Why not have ADT7470_REG_FAN()  ADT7470_REG_FAN_MIN() and ADT7470_REG_FAN_MAX() 
macros, like you have for example ADT7470_TEMP_REG(x), ADT7470_TEMP_MIN_REG()

Also notice that your not being consistent with where you put the REG please 
either put the REG always directly behind ADT7470_ or always at the end.

Also why have these functions at all, why not put the single line the consist 
of directly at the place where you call them (especially if you have 
ADT7470_REG_FAN() & friends macros

> +static struct adt7470_data *adt7470_update_device(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct adt7470_data *data = i2c_get_clientdata(client);
> +
> +	mutex_lock(&data->lock);
> +
> +	if (time_after(jiffies, data->last_updated + REFRESH_INTERVAL)
> +		|| !data->valid) {
> +		u8 cfg;
> +		int i;
> +
> +		/* start reading temperature sensors */
> +		cfg = i2c_smbus_read_byte_data(client, ADT7470_REG_CFG);
> +		cfg |= 0x80;
> +		i2c_smbus_write_byte_data(client, ADT7470_REG_CFG, cfg);
> +
> +		/* delay is 200ms * number of tmp05 sensors */
> +		udelay(TEMP_COLLECTION_TIME);
> +

ugh, sleep here please.

> +		/* done reading temperature sensors */
> +		cfg = i2c_smbus_read_byte_data(client, ADT7470_REG_CFG);
> +		cfg &= ~0x80;
> +		i2c_smbus_write_byte_data(client, ADT7470_REG_CFG, cfg);
> +
> +		for (i = 0; i < ADT7470_TEMP_COUNT; i++) {
> +			data->temp[i] = i2c_smbus_read_byte_data(client, ADT7470_TEMP_REG(i));
> +			data->temp_min[i] = i2c_smbus_read_byte_data(client, ADT7470_TEMP_MIN_REG(i));
> +			data->temp_max[i] = i2c_smbus_read_byte_data(client, ADT7470_TEMP_MAX_REG(i));
> +		}
> +
> +		for (i = 0; i < ADT7470_FAN_COUNT; i++) {
> +			data->fan[i] = adt7470_read_fan(client, i);
> +			data->fan_min[i] = adt7470_read_fan_min(client, i);
> +			data->fan_max[i] = adt7470_read_fan_max(client, i);
> +		}
> +

again, you're inconsistent, notice how you use i2c_smbus_read_byte_data 
directly for the temp sensors, but utility functions for the fans

> +		for (i = ADT7470_REG_BASE; i <= ADT7470_REG_MAX; i++) {
> +			data->raw[i - ADT7470_REG_BASE] = i2c_smbus_read_byte_data(client, i);
> +		}
> +
> +		for (i = 0; i < ADT7470_PWM_COUNT; i++) {
> +			int reg = ADT7470_REG_PWM_CFG_BASE + (i / 2);
> +			int reg_mask = ADT7470_PWM1_AUTO_MASK;
> +			if (!(i % 2))
> +				reg_mask <<= 1;
> +
> +			data->pwm[i] = i2c_smbus_read_byte_data(client, ADT7470_REG_PWM(i));
> +			data->pwm_max[i] = i2c_smbus_read_byte_data(client, ADT7470_REG_PWM_MAX(i));
> +			data->pwm_min[i] = i2c_smbus_read_byte_data(client, ADT7470_REG_PWM_MIN(i));
> +			data->pwm_tmin[i] = i2c_smbus_read_byte_data(client, ADT7470_REG_PWM_TMIN(i));
> +			data->pwm_automatic[i] = ((i2c_smbus_read_byte_data(client, reg) & reg_mask) = reg_mask);
> +			reg = ADT7470_REG_PWM_AUTO_TEMP_BASE + (i / 2);
> +			if (!(i % 2))
> +				data->pwm_auto_temp[i] = i2c_smbus_read_byte_data(client, reg) >> 4;
> +			else
> +				data->pwm_auto_temp[i] = i2c_smbus_read_byte_data(client, reg) & 0xF;
> +		}
> +
> +		data->force_pwm_max = ((i2c_smbus_read_byte_data(client, ADT7470_REG_CFG) & ADT7470_FSPD_MASK) = ADT7470_FSPD_MASK);
> +
> +		data->alarms = adt7470_read16(client, ADT7470_REG_ALARM1);
> +		data->alarms_mask = adt7470_read16(client, ADT7470_REG_ALARM1_MASK);
> +
> +		data->last_updated = jiffies;
> +		data->valid = 1;
> +	}
> +
> +	mutex_unlock(&data->lock);
> +
> +	return data;
> +}
> +
> +static ssize_t show_temp_min(struct device *dev, struct device_attribute *devattr,
> +			char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct adt7470_data *data = adt7470_update_device(dev);
> +	return sprintf(buf, "%d\n", 1000 * data->temp_min[attr->index]);
> +}
> +
> +static ssize_t set_temp_min(struct device *dev, struct device_attribute *devattr,
> +			const char *buf, size_t count)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct adt7470_data *data = i2c_get_clientdata(client);
> +	int temp = simple_strtol(buf, NULL, 10) / 1000;
> +
> +	mutex_lock(&data->lock);
> +	data->temp_min[attr->index] = temp;
> +	i2c_smbus_write_byte_data(client, ADT7470_TEMP_MIN_REG(attr->index), temp);
> +	mutex_unlock(&data->lock);
> +
> +	return count;
> +}
> +
> +static ssize_t show_temp_max(struct device *dev, struct device_attribute *devattr,
> +			char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct adt7470_data *data = adt7470_update_device(dev);
> +	return sprintf(buf, "%d\n", 1000 * data->temp_max[attr->index]);
> +}
> +
> +static ssize_t set_temp_max(struct device *dev, struct device_attribute *devattr,
> +			const char *buf, size_t count)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct adt7470_data *data = i2c_get_clientdata(client);
> +	int temp = simple_strtol(buf, NULL, 10) / 1000;
> +
> +	mutex_lock(&data->lock);
> +	data->temp_max[attr->index] = temp;
> +	i2c_smbus_write_byte_data(client, ADT7470_TEMP_MAX_REG(attr->index), temp);
> +	mutex_unlock(&data->lock);
> +
> +	return count;
> +}
> +
> +static ssize_t show_temp(struct device *dev, struct device_attribute *devattr,
> +			char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct adt7470_data *data = adt7470_update_device(dev);
> +	return sprintf(buf, "%d\n", 1000 * data->temp[attr->index]);
> +}
> +
> +static ssize_t show_alarms(struct device *dev, struct device_attribute *devattr,
> +			char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct adt7470_data *data = adt7470_update_device(dev);
> +
> +	if (attr->index)
> +		return sprintf(buf, "%x\n", data->alarms);
> +	else
> +		return sprintf(buf, "%x\n", data->alarms_mask);
> +}
> +
> +static ssize_t show_fan_max(struct device *dev, struct device_attribute *devattr,
> +			char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct adt7470_data *data = adt7470_update_device(dev);
> +
> +	if (data->fan_max[attr->index])
> +		return sprintf(buf, "%d\n", (90000 * 60) / data->fan_max[attr->index]);
> +	else
> +		return sprintf(buf, "0\n");
> +}
> +
> +static ssize_t show_fan_min(struct device *dev, struct device_attribute *devattr,
> +			char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct adt7470_data *data = adt7470_update_device(dev);
> +
> +	if (data->fan_min[attr->index])
> +		return sprintf(buf, "%d\n", (90000 * 60) / data->fan_min[attr->index]);
> +	else
> +		return sprintf(buf, "0\n");
> +}
> +

This may be a stupid question (I haven't fully read the datasheet) but why no 
store functions for fan_min and fan_max?

> +static ssize_t show_fan(struct device *dev, struct device_attribute *devattr,
> +			char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct adt7470_data *data = adt7470_update_device(dev);
> +
> +	if (data->fan[attr->index] && data->fan[attr->index] != 65535)
> +		return sprintf(buf, "%d\n", (90000 * 60) / data->fan[attr->index]);
> +	else
> +		return sprintf(buf, "0\n");
> +}
> +
> +static ssize_t show_raw(struct device *dev, struct device_attribute *devattr,
> +			char *buf)
> +{
> +	struct adt7470_data *data = adt7470_update_device(dev);
> +	int i;
> +	char *b = buf;
> +
> +	for (i = ADT7470_REG_BASE; i <= ADT7470_REG_MAX; i++)
> +		b += sprintf(b, "0x%X: 0x%X\n", i, data->raw[i - ADT7470_REG_BASE]);
> +
> +	return b - buf;
> +}
> +

Don't do this please, we have i2cdump for this

> +static ssize_t show_force_pwm_max(struct device *dev, struct device_attribute *devattr,
> +			char *buf)
> +{
> +	struct adt7470_data *data = adt7470_update_device(dev);
> +	return sprintf(buf, "%d\n", data->force_pwm_max);
> +}
> +
> +static ssize_t set_force_pwm_max(struct device *dev, struct device_attribute *devattr,
> +			const char *buf, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct adt7470_data *data = i2c_get_clientdata(client);
> +	int temp = simple_strtol(buf, NULL, 10);
> +	u8 reg;
> +
> +	mutex_lock(&data->lock);
> +	data->force_pwm_max = temp;
> +	reg = i2c_smbus_read_byte_data(client, ADT7470_REG_CFG);

> +	reg &= ~ADT7470_FSPD_MASK;
> +	reg |= (temp ? ADT7470_FSPD_MASK : 0);

I think this would be (much) easier to read as:
if (temp)
   reg |= ADT7470_FSPD_MASK;
else
   reg &= ~ADT7470_FSPD_MASK;

> +	i2c_smbus_write_byte_data(client, ADT7470_REG_CFG, reg);
> +	mutex_unlock(&data->lock);
> +
> +	return count;
> +}
> +
> +static ssize_t show_pwm(struct device *dev, struct device_attribute *devattr,
> +			char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct adt7470_data *data = adt7470_update_device(dev);
> +	return sprintf(buf, "%d\n", data->pwm[attr->index]);
> +}
> +
> +static ssize_t set_pwm(struct device *dev, struct device_attribute *devattr,
> +			const char *buf, size_t count)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct adt7470_data *data = i2c_get_clientdata(client);
> +	int temp = simple_strtol(buf, NULL, 10);
> +
> +	mutex_lock(&data->lock);
> +	data->pwm[attr->index] = temp;
> +	i2c_smbus_write_byte_data(client, ADT7470_REG_PWM(attr->index), temp);
> +	mutex_unlock(&data->lock);
> +
> +	return count;
> +}
> +
> +static ssize_t show_pwm_max(struct device *dev, struct device_attribute *devattr,
> +			char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct adt7470_data *data = adt7470_update_device(dev);
> +	return sprintf(buf, "%d\n", data->pwm_max[attr->index]);
> +}
> +
> +static ssize_t set_pwm_max(struct device *dev, struct device_attribute *devattr,
> +			const char *buf, size_t count)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct adt7470_data *data = i2c_get_clientdata(client);
> +	int temp = simple_strtol(buf, NULL, 10);
> +
> +	mutex_lock(&data->lock);
> +	data->pwm_max[attr->index] = temp;
> +	i2c_smbus_write_byte_data(client, ADT7470_REG_PWM_MAX(attr->index), temp);
> +	mutex_unlock(&data->lock);
> +
> +	return count;
> +}
> +
> +static ssize_t show_pwm_min(struct device *dev, struct device_attribute *devattr,
> +			char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct adt7470_data *data = adt7470_update_device(dev);
> +	return sprintf(buf, "%d\n", data->pwm_min[attr->index]);
> +}
> +
> +static ssize_t set_pwm_min(struct device *dev, struct device_attribute *devattr,
> +			const char *buf, size_t count)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct adt7470_data *data = i2c_get_clientdata(client);
> +	int temp = simple_strtol(buf, NULL, 10);
> +
> +	mutex_lock(&data->lock);
> +	data->pwm_min[attr->index] = temp;
> +	i2c_smbus_write_byte_data(client, ADT7470_REG_PWM_MIN(attr->index), temp);
> +	mutex_unlock(&data->lock);
> +
> +	return count;
> +}
> +
> +static ssize_t show_pwm_tmax(struct device *dev, struct device_attribute *devattr,
> +			char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct adt7470_data *data = adt7470_update_device(dev);
> +	return sprintf(buf, "%d\n", 1000 * (20 + data->pwm_tmin[attr->index]));
> +}
> +
> +static ssize_t show_pwm_tmin(struct device *dev, struct device_attribute *devattr,
> +			char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct adt7470_data *data = adt7470_update_device(dev);
> +	return sprintf(buf, "%d\n", 1000 * data->pwm_tmin[attr->index]);
> +}
> +
> +static ssize_t set_pwm_tmin(struct device *dev, struct device_attribute *devattr,
> +			const char *buf, size_t count)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct adt7470_data *data = i2c_get_clientdata(client);
> +	int temp = simple_strtol(buf, NULL, 10) / 1000;
> +
> +	mutex_lock(&data->lock);
> +	data->pwm_tmin[attr->index] = temp;
> +	i2c_smbus_write_byte_data(client, ADT7470_REG_PWM_TMIN(attr->index), temp);
> +	mutex_unlock(&data->lock);
> +
> +	return count;
> +}
> +
> +static ssize_t show_pwm_auto(struct device *dev, struct device_attribute *devattr,
> +			char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct adt7470_data *data = adt7470_update_device(dev);
> +	return sprintf(buf, "%d\n", 1 + data->pwm_automatic[attr->index]);
> +}
> +
> +static ssize_t set_pwm_auto(struct device *dev, struct device_attribute *devattr,
> +			const char *buf, size_t count)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct adt7470_data *data = i2c_get_clientdata(client);
> +	int temp = simple_strtol(buf, NULL, 10);
> +	int pwm_auto_reg = ADT7470_REG_PWM_CFG_BASE + (attr->index / 2);

please create and use a ADT7470_REG_PWM_CFG() macro for this. Again consistency 
is key here, to make it easier for others to read your code.

> +	int pwm_auto_reg_mask = ADT7470_PWM1_AUTO_MASK;
> +	u8 reg;
> +
> +	if (!(attr->index % 2))
> +		pwm_auto_reg_mask <<= 1;

It took me a while to understand what you're doing here, because its a bit 
convoluted, and its wrong.

pwm1 has attr->index = 0, so the if is true, thus the mask gets shifted making 
it ADT7470_PWM2_AUTO_MASK, but for pwm1 we want ADT7470_PWM1_AUTO_MASK 
ofcourse. So the test should be inverted / the '!' should be removed.

I believe this error is caused by the current code being hard to read, I 
believe that something like this is better:
int pwm_auto_reg_mask;
u8 reg;

if (attr->index & 0x01)
   pwm_auto_reg_mask = ADT7470_PWM2_AUTO_MASK;
else
   pwm_auto_reg_mask = ADT7470_PWM1_AUTO_MASK;

> +
> +	if (temp != 2 && temp != 1)
> +		return -EINVAL;
> +	temp--;
> +
> +	mutex_lock(&data->lock);
> +	data->pwm_automatic[attr->index] = temp;
> +	reg = i2c_smbus_read_byte_data(client, pwm_auto_reg);

> +	reg &= ~pwm_auto_reg_mask;
> +	reg |= (temp ? pwm_auto_reg_mask : 0);
Same as with the FSPD mask.

> +	i2c_smbus_write_byte_data(client, pwm_auto_reg, reg);
> +	mutex_unlock(&data->lock);
> +
> +	return count;
> +}
> +
> +static ssize_t show_pwm_auto_temp(struct device *dev, struct device_attribute *devattr,
> +			char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct adt7470_data *data = adt7470_update_device(dev);
> +	u8 ctrl = data->pwm_auto_temp[attr->index];
> +
> +	if (ctrl)
> +		return sprintf(buf, "%d\n", 1 << (ctrl - 1));
> +	else
> +		return sprintf(buf, "%d\n", ADT7470_PWM_ALL_TEMPS);
> +}
> +
> +static int cvt_auto_temp(int input)
> +{
> +	if (input = ADT7470_PWM_ALL_TEMPS)
> +		return 0;
> +	if (input < 1 || !power_of_2(input))
> +		return -EINVAL;
> +	return ilog2(input) + 1;
> +}
> +
> +static ssize_t set_pwm_auto_temp(struct device *dev, struct device_attribute *devattr,
> +			const char *buf, size_t count)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct adt7470_data *data = i2c_get_clientdata(client);
> +	int temp = cvt_auto_temp(simple_strtol(buf, NULL, 10));
> +	int pwm_auto_reg = ADT7470_REG_PWM_AUTO_TEMP_BASE + (attr->index / 2);
Again, for consistency use a ADT7470_REG_PWM_AUTO_TEMP() macro please

> +	u8 reg;
> +
> +	if (temp < 0)
> +		return temp;
> +
> +	mutex_lock(&data->lock);
> +	data->pwm_automatic[attr->index] = temp;
> +	reg = i2c_smbus_read_byte_data(client, pwm_auto_reg);
> +
> +	if (!(attr->index % 2)) {
> +		reg &= 0xF;
> +		reg |= (temp << 4) & 0xF0;
> +	} else {
> +		reg &= 0xF0;
> +		reg |= temp & 0xF;
> +	}
> +
> +	i2c_smbus_write_byte_data(client, pwm_auto_reg, reg);
> +	mutex_unlock(&data->lock);
> +
> +	return count;
> +}
> +
> +static SENSOR_DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL, 0);
> +static SENSOR_DEVICE_ATTR(alarm_mask, S_IRUGO, show_alarms, NULL, 1);
> +
> +static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_max, set_temp_max, 0);
> +static SENSOR_DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_temp_max, set_temp_max, 1);
> +static SENSOR_DEVICE_ATTR(temp3_max, S_IWUSR | S_IRUGO, show_temp_max, set_temp_max, 2);
> +static SENSOR_DEVICE_ATTR(temp4_max, S_IWUSR | S_IRUGO, show_temp_max, set_temp_max, 3);
> +static SENSOR_DEVICE_ATTR(temp5_max, S_IWUSR | S_IRUGO, show_temp_max, set_temp_max, 4);
> +static SENSOR_DEVICE_ATTR(temp6_max, S_IWUSR | S_IRUGO, show_temp_max, set_temp_max, 5);
> +static SENSOR_DEVICE_ATTR(temp7_max, S_IWUSR | S_IRUGO, show_temp_max, set_temp_max, 6);
> +static SENSOR_DEVICE_ATTR(temp8_max, S_IWUSR | S_IRUGO, show_temp_max, set_temp_max, 7);
> +static SENSOR_DEVICE_ATTR(temp9_max, S_IWUSR | S_IRUGO, show_temp_max, set_temp_max, 8);
> +static SENSOR_DEVICE_ATTR(temp10_max, S_IWUSR | S_IRUGO, show_temp_max, set_temp_max, 9);
> +
> +static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO, show_temp_min, set_temp_min, 0);
> +static SENSOR_DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_temp_min, set_temp_min, 1);
> +static SENSOR_DEVICE_ATTR(temp3_min, S_IWUSR | S_IRUGO, show_temp_min, set_temp_min, 2);
> +static SENSOR_DEVICE_ATTR(temp4_min, S_IWUSR | S_IRUGO, show_temp_min, set_temp_min, 3);
> +static SENSOR_DEVICE_ATTR(temp5_min, S_IWUSR | S_IRUGO, show_temp_min, set_temp_min, 4);
> +static SENSOR_DEVICE_ATTR(temp6_min, S_IWUSR | S_IRUGO, show_temp_min, set_temp_min, 5);
> +static SENSOR_DEVICE_ATTR(temp7_min, S_IWUSR | S_IRUGO, show_temp_min, set_temp_min, 6);
> +static SENSOR_DEVICE_ATTR(temp8_min, S_IWUSR | S_IRUGO, show_temp_min, set_temp_min, 7);
> +static SENSOR_DEVICE_ATTR(temp9_min, S_IWUSR | S_IRUGO, show_temp_min, set_temp_min, 8);
> +static SENSOR_DEVICE_ATTR(temp10_min, S_IWUSR | S_IRUGO, show_temp_min, set_temp_min, 9);
> +
> +static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);
> +static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 1);
> +static SENSOR_DEVICE_ATTR(temp3_input, S_IRUGO, show_temp, NULL, 2);
> +static SENSOR_DEVICE_ATTR(temp4_input, S_IRUGO, show_temp, NULL, 3);
> +static SENSOR_DEVICE_ATTR(temp5_input, S_IRUGO, show_temp, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp6_input, S_IRUGO, show_temp, NULL, 5);
> +static SENSOR_DEVICE_ATTR(temp7_input, S_IRUGO, show_temp, NULL, 6);
> +static SENSOR_DEVICE_ATTR(temp8_input, S_IRUGO, show_temp, NULL, 7);
> +static SENSOR_DEVICE_ATTR(temp9_input, S_IRUGO, show_temp, NULL, 8);
> +static SENSOR_DEVICE_ATTR(temp10_input, S_IRUGO, show_temp, NULL, 9);
> +
> +static SENSOR_DEVICE_ATTR(fan1_max, S_IRUGO, show_fan_max, NULL, 0);
> +static SENSOR_DEVICE_ATTR(fan2_max, S_IRUGO, show_fan_max, NULL, 1);
> +static SENSOR_DEVICE_ATTR(fan3_max, S_IRUGO, show_fan_max, NULL, 2);
> +static SENSOR_DEVICE_ATTR(fan4_max, S_IRUGO, show_fan_max, NULL, 3);
> +
> +static SENSOR_DEVICE_ATTR(fan1_min, S_IRUGO, show_fan_min, NULL, 0);
> +static SENSOR_DEVICE_ATTR(fan2_min, S_IRUGO, show_fan_min, NULL, 1);
> +static SENSOR_DEVICE_ATTR(fan3_min, S_IRUGO, show_fan_min, NULL, 2);
> +static SENSOR_DEVICE_ATTR(fan4_min, S_IRUGO, show_fan_min, NULL, 3);
> +
> +static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, show_fan, NULL, 0);
> +static SENSOR_DEVICE_ATTR(fan2_input, S_IRUGO, show_fan, NULL, 1);
> +static SENSOR_DEVICE_ATTR(fan3_input, S_IRUGO, show_fan, NULL, 2);
> +static SENSOR_DEVICE_ATTR(fan4_input, S_IRUGO, show_fan, NULL, 3);
> +
> +static SENSOR_DEVICE_ATTR(raw_input, S_IRUGO, show_raw, NULL, 0);
> +static SENSOR_DEVICE_ATTR(force_pwm_max, S_IWUSR | S_IRUGO, show_force_pwm_max, set_force_pwm_max, 0);
> +
> +static SENSOR_DEVICE_ATTR(pwm1, S_IWUSR | S_IRUGO, show_pwm, set_pwm, 0);
> +static SENSOR_DEVICE_ATTR(pwm2, S_IWUSR | S_IRUGO, show_pwm, set_pwm, 1);
> +static SENSOR_DEVICE_ATTR(pwm3, S_IWUSR | S_IRUGO, show_pwm, set_pwm, 2);
> +static SENSOR_DEVICE_ATTR(pwm4, S_IWUSR | S_IRUGO, show_pwm, set_pwm, 3);
> +
> +static SENSOR_DEVICE_ATTR(pwm1_auto_point1_pwm, S_IWUSR | S_IRUGO, show_pwm_min, set_pwm_min, 0);
> +static SENSOR_DEVICE_ATTR(pwm2_auto_point1_pwm, S_IWUSR | S_IRUGO, show_pwm_min, set_pwm_min, 1);
> +static SENSOR_DEVICE_ATTR(pwm3_auto_point1_pwm, S_IWUSR | S_IRUGO, show_pwm_min, set_pwm_min, 2);
> +static SENSOR_DEVICE_ATTR(pwm4_auto_point1_pwm, S_IWUSR | S_IRUGO, show_pwm_min, set_pwm_min, 3);
> +
> +static SENSOR_DEVICE_ATTR(pwm1_auto_point2_pwm, S_IWUSR | S_IRUGO, show_pwm_max, set_pwm_max, 0);
> +static SENSOR_DEVICE_ATTR(pwm2_auto_point2_pwm, S_IWUSR | S_IRUGO, show_pwm_max, set_pwm_max, 1);
> +static SENSOR_DEVICE_ATTR(pwm3_auto_point2_pwm, S_IWUSR | S_IRUGO, show_pwm_max, set_pwm_max, 2);
> +static SENSOR_DEVICE_ATTR(pwm4_auto_point2_pwm, S_IWUSR | S_IRUGO, show_pwm_max, set_pwm_max, 3);
> +
> +static SENSOR_DEVICE_ATTR(pwm1_auto_point1_temp, S_IWUSR | S_IRUGO, show_pwm_tmin, set_pwm_tmin, 0);
> +static SENSOR_DEVICE_ATTR(pwm2_auto_point1_temp, S_IWUSR | S_IRUGO, show_pwm_tmin, set_pwm_tmin, 1);
> +static SENSOR_DEVICE_ATTR(pwm3_auto_point1_temp, S_IWUSR | S_IRUGO, show_pwm_tmin, set_pwm_tmin, 2);
> +static SENSOR_DEVICE_ATTR(pwm4_auto_point1_temp, S_IWUSR | S_IRUGO, show_pwm_tmin, set_pwm_tmin, 3);
> +
> +static SENSOR_DEVICE_ATTR(pwm1_auto_point2_temp, S_IRUGO, show_pwm_tmax, NULL, 0);
> +static SENSOR_DEVICE_ATTR(pwm2_auto_point2_temp, S_IRUGO, show_pwm_tmax, NULL, 1);
> +static SENSOR_DEVICE_ATTR(pwm3_auto_point2_temp, S_IRUGO, show_pwm_tmax, NULL, 2);
> +static SENSOR_DEVICE_ATTR(pwm4_auto_point2_temp, S_IRUGO, show_pwm_tmax, NULL, 3);
> +
> +static SENSOR_DEVICE_ATTR(pwm1_enable, S_IWUSR | S_IRUGO, show_pwm_auto, set_pwm_auto, 0);
> +static SENSOR_DEVICE_ATTR(pwm2_enable, S_IWUSR | S_IRUGO, show_pwm_auto, set_pwm_auto, 1);
> +static SENSOR_DEVICE_ATTR(pwm3_enable, S_IWUSR | S_IRUGO, show_pwm_auto, set_pwm_auto, 2);
> +static SENSOR_DEVICE_ATTR(pwm4_enable, S_IWUSR | S_IRUGO, show_pwm_auto, set_pwm_auto, 3);
> +
> +static SENSOR_DEVICE_ATTR(pwm1_auto_channels_temp, S_IWUSR | S_IRUGO, show_pwm_auto_temp, set_pwm_auto_temp, 0);
> +static SENSOR_DEVICE_ATTR(pwm2_auto_channels_temp, S_IWUSR | S_IRUGO, show_pwm_auto_temp, set_pwm_auto_temp, 1);
> +static SENSOR_DEVICE_ATTR(pwm3_auto_channels_temp, S_IWUSR | S_IRUGO, show_pwm_auto_temp, set_pwm_auto_temp, 2);
> +static SENSOR_DEVICE_ATTR(pwm4_auto_channels_temp, S_IWUSR | S_IRUGO, show_pwm_auto_temp, set_pwm_auto_temp, 3);
> +
> +static int adt7470_attach_adapter(struct i2c_adapter *adapter)
> +{
> +	if (!(adapter->class & I2C_CLASS_HWMON))
> +		return 0;
> +	return i2c_probe(adapter, &addr_data, adt7470_detect);
> +}
> +
> +static struct attribute *adt7470_attributes[] = {
> +	&sensor_dev_attr_force_pwm_max.dev_attr.attr,
> +	&sensor_dev_attr_alarms.dev_attr.attr,
> +	&sensor_dev_attr_alarm_mask.dev_attr.attr,
> +	&sensor_dev_attr_temp1_max.dev_attr.attr,
> +	&sensor_dev_attr_temp2_max.dev_attr.attr,
> +	&sensor_dev_attr_temp3_max.dev_attr.attr,
> +	&sensor_dev_attr_temp4_max.dev_attr.attr,
> +	&sensor_dev_attr_temp5_max.dev_attr.attr,
> +	&sensor_dev_attr_temp6_max.dev_attr.attr,
> +	&sensor_dev_attr_temp7_max.dev_attr.attr,
> +	&sensor_dev_attr_temp8_max.dev_attr.attr,
> +	&sensor_dev_attr_temp9_max.dev_attr.attr,
> +	&sensor_dev_attr_temp10_max.dev_attr.attr,
> +	&sensor_dev_attr_temp1_min.dev_attr.attr,
> +	&sensor_dev_attr_temp2_min.dev_attr.attr,
> +	&sensor_dev_attr_temp3_min.dev_attr.attr,
> +	&sensor_dev_attr_temp4_min.dev_attr.attr,
> +	&sensor_dev_attr_temp5_min.dev_attr.attr,
> +	&sensor_dev_attr_temp6_min.dev_attr.attr,
> +	&sensor_dev_attr_temp7_min.dev_attr.attr,
> +	&sensor_dev_attr_temp8_min.dev_attr.attr,
> +	&sensor_dev_attr_temp9_min.dev_attr.attr,
> +	&sensor_dev_attr_temp10_min.dev_attr.attr,
> +	&sensor_dev_attr_temp1_input.dev_attr.attr,
> +	&sensor_dev_attr_temp2_input.dev_attr.attr,
> +	&sensor_dev_attr_temp3_input.dev_attr.attr,
> +	&sensor_dev_attr_temp4_input.dev_attr.attr,
> +	&sensor_dev_attr_temp5_input.dev_attr.attr,
> +	&sensor_dev_attr_temp6_input.dev_attr.attr,
> +	&sensor_dev_attr_temp7_input.dev_attr.attr,
> +	&sensor_dev_attr_temp8_input.dev_attr.attr,
> +	&sensor_dev_attr_temp9_input.dev_attr.attr,
> +	&sensor_dev_attr_temp10_input.dev_attr.attr,
> +	&sensor_dev_attr_fan1_max.dev_attr.attr,
> +	&sensor_dev_attr_fan2_max.dev_attr.attr,
> +	&sensor_dev_attr_fan3_max.dev_attr.attr,
> +	&sensor_dev_attr_fan4_max.dev_attr.attr,
> +	&sensor_dev_attr_fan1_min.dev_attr.attr,
> +	&sensor_dev_attr_fan2_min.dev_attr.attr,
> +	&sensor_dev_attr_fan3_min.dev_attr.attr,
> +	&sensor_dev_attr_fan4_min.dev_attr.attr,
> +	&sensor_dev_attr_fan1_input.dev_attr.attr,
> +	&sensor_dev_attr_fan2_input.dev_attr.attr,
> +	&sensor_dev_attr_fan3_input.dev_attr.attr,
> +	&sensor_dev_attr_fan4_input.dev_attr.attr,
> +	&sensor_dev_attr_raw_input.dev_attr.attr,
> +	&sensor_dev_attr_pwm1.dev_attr.attr,
> +	&sensor_dev_attr_pwm2.dev_attr.attr,
> +	&sensor_dev_attr_pwm3.dev_attr.attr,
> +	&sensor_dev_attr_pwm4.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point1_pwm.dev_attr.attr,
> +	&sensor_dev_attr_pwm2_auto_point1_pwm.dev_attr.attr,
> +	&sensor_dev_attr_pwm3_auto_point1_pwm.dev_attr.attr,
> +	&sensor_dev_attr_pwm4_auto_point1_pwm.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point2_pwm.dev_attr.attr,
> +	&sensor_dev_attr_pwm2_auto_point2_pwm.dev_attr.attr,
> +	&sensor_dev_attr_pwm3_auto_point2_pwm.dev_attr.attr,
> +	&sensor_dev_attr_pwm4_auto_point2_pwm.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point1_temp.dev_attr.attr,
> +	&sensor_dev_attr_pwm2_auto_point1_temp.dev_attr.attr,
> +	&sensor_dev_attr_pwm3_auto_point1_temp.dev_attr.attr,
> +	&sensor_dev_attr_pwm4_auto_point1_temp.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point2_temp.dev_attr.attr,
> +	&sensor_dev_attr_pwm2_auto_point2_temp.dev_attr.attr,
> +	&sensor_dev_attr_pwm3_auto_point2_temp.dev_attr.attr,
> +	&sensor_dev_attr_pwm4_auto_point2_temp.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_enable.dev_attr.attr,
> +	&sensor_dev_attr_pwm2_enable.dev_attr.attr,
> +	&sensor_dev_attr_pwm3_enable.dev_attr.attr,
> +	&sensor_dev_attr_pwm4_enable.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_channels_temp.dev_attr.attr,
> +	&sensor_dev_attr_pwm2_auto_channels_temp.dev_attr.attr,
> +	&sensor_dev_attr_pwm3_auto_channels_temp.dev_attr.attr,
> +	&sensor_dev_attr_pwm4_auto_channels_temp.dev_attr.attr,
> +	NULL
> +};
> +

Maybe just but all the sensor_attr directly into an array and use a for loop on 
that array to register / unregister instead of sysfs attribute groups?

That would save you the above array.


> +static int adt7470_detect(struct i2c_adapter *adapter, int address, int kind)
> +{
> +	struct i2c_client *client;
> +	struct adt7470_data *data;
> +	int err = 0;
> +
> +	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
> +				     I2C_FUNC_SMBUS_WORD_DATA))
> +		goto exit;
> +
> +	if (!(data = kzalloc(sizeof(struct adt7470_data), GFP_KERNEL))) {
> +		err = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	client = &data->client;
> +	client->addr = address;
> +	client->adapter = adapter;
> +	client->driver = &adt7470_driver;
> +
> +	i2c_set_clientdata(client, data);
> +
> +	mutex_init(&data->lock);
> +
> +	if (kind <= 0) {
> +		int vendor, device, revision;
> +
> +		vendor = i2c_smbus_read_byte_data(client, ADT7470_REG_VENDOR);
> +		if (vendor != ADT7470_VENDOR) {
> +			printk(KERN_ERR "%s: vendor=%x\n", __FUNCTION__, vendor);
> +			err = -ENODEV;
> +			goto exit_free;
> +		}
> +
> +		device = i2c_smbus_read_byte_data(client, ADT7470_REG_DEVICE);
> +		if (device != ADT7470_DEVICE) {
> +			printk(KERN_ERR "%s: device=%x\n", __FUNCTION__, device);
> +			err = -ENODEV;
> +			goto exit_free;
> +		}
> +
> +		revision = i2c_smbus_read_byte_data(client, ADT7470_REG_REVISION);
> +		if (revision != ADT7470_REVISION) {
> +			printk(KERN_ERR "%s: revision=%x\n", __FUNCTION__, revision);
> +			err = -ENODEV;
> +			goto exit_free;
> +		}
> +
> +		data->type = adt7470;
> +	} else {
> +		dev_dbg(&adapter->dev, "detection forced\n");
> +	}
> +
> +	if (kind > 0)
> +		data->type = kind;
> +
> +	data->attrs.attrs = adt7470_attributes;
> +	strlcpy(client->name, "adt7470", I2C_NAME_SIZE);
> +
> +	if ((err = i2c_attach_client(client)))
> +		goto exit_free;
> +
> +	dev_info(&client->dev, "%s chip found\n", client->name);
> +
> +	/* Initialize the ADT7470 chip */
> +	adt7470_init_client(client);
> +
> +	/* Register sysfs hooks */
> +	if ((err = sysfs_create_group(&client->dev.kobj, &data->attrs)))
> +		goto exit_detach;
> +
> +	data->class_dev = hwmon_device_register(&client->dev);
> +	if (IS_ERR(data->class_dev)) {
> +		err = PTR_ERR(data->class_dev);
> +		goto exit_remove;
> +	}
> +
> +	return 0;
> +
> +exit_remove:
> +	sysfs_remove_group(&client->dev.kobj, &data->attrs);
> +exit_detach:
> +	i2c_detach_client(client);
> +exit_free:
> +	kfree(data);
> +exit:
> +	return err;
> +}
> +
> +static int adt7470_detach_client(struct i2c_client *client)
> +{
> +	struct adt7470_data *data = i2c_get_clientdata(client);
> +	hwmon_device_unregister(data->class_dev);
> +	sysfs_remove_group(&client->dev.kobj, &data->attrs);
> +	i2c_detach_client(client);
> +	kfree(data);
> +	return 0;
> +}
> +
> +static int __init adt7470_init(void)
> +{
> +	return i2c_add_driver(&adt7470_driver);
> +}
> +
> +static void __exit adt7470_exit(void)
> +{
> +	i2c_del_driver(&adt7470_driver);
> +}
> +
> +MODULE_AUTHOR("Darrick J. Wong <djwong@us.ibm.com>");
> +MODULE_DESCRIPTION("ADT7470 driver");
> +MODULE_LICENSE("GPL");
> +MODULE_VERSION(DRV_VERSION);
> +
> +module_init(adt7470_init);
> +module_exit(adt7470_exit);
> 
> 

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
