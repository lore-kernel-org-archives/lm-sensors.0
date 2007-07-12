From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Thu, 12 Jul 2007 09:42:43 +0000
Subject: Re: [lm-sensors] [PATCH] v3 of a adt7470 driver
Message-Id: <4695F793.9060605@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070711183825.GP3435@tree.beaverton.ibm.com>
In-Reply-To: <20070711183825.GP3435@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Darrick J. Wong wrote:
> Resend with correct title and patch included just once.
> ---
> adt7470: new hwmon driver for adt7470 chip.
> 
> Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>

Looks good now, as far I'm concerned this is ready to get merged.
Acked-by: Hans de Goede <j.w.r.degoede@hhs.nl>

Mark, any chance you can pick this up soonish, maybe it can make 2.6.23 then.

Darrick, have you already written support for this driver for libsensors and 
sensors? If not could you please do that ASAP? Then I'll review it and with 
some luck and Jean's permission we can still get support for this chip included 
into lm_sensors 2.10.4

Regards,

Hans


> ---
> 
>  drivers/hwmon/Kconfig   |   10 
>  drivers/hwmon/Makefile  |    1 
>  drivers/hwmon/adt7470.c |  956 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 967 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 13eea47..bb57beb 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -40,6 +40,16 @@ config SENSORS_ABITUGURU
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called abituguru.
>  
> +config SENSORS_ADT7470
> +	tristate "Analog Devices ADT7470"
> +	depends on I2C && EXPERIMENTAL
> +	help
> +	  If you say yes here you get support for the Analog Devices
> +	  ADT7470 temperature monitoring chips.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called adt7470.
> +
>  config SENSORS_AD7418
>  	tristate "Analog Devices AD7416, AD7417 and AD7418"
>  	depends on I2C && EXPERIMENTAL
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index cfaf338..e5fc251 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_SENSORS_W83781D)	+= w83781d.o
>  obj-$(CONFIG_SENSORS_W83791D)	+= w83791d.o
>  
>  obj-$(CONFIG_SENSORS_ABITUGURU)	+= abituguru.o
> +obj-$(CONFIG_SENSORS_ADT7470)	+= adt7470.o
>  obj-$(CONFIG_SENSORS_AD7418)	+= ad7418.o
>  obj-$(CONFIG_SENSORS_ADM1021)	+= adm1021.o
>  obj-$(CONFIG_SENSORS_ADM1025)	+= adm1025.o
> diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
> new file mode 100644
> index 0000000..d31e023
> --- /dev/null
> +++ b/drivers/hwmon/adt7470.c
> @@ -0,0 +1,956 @@
> +/*
> + * A hwmon driver for the Analog Devices ADT7470
> + * Copyright (C) 2007 IBM
> + *
> + * Author: Darrick J. Wong <djwong@us.ibm.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +
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
> +/* Addresses to scan */
> +static unsigned short normal_i2c[] = { 0x2C, 0x2E, 0x2F, I2C_CLIENT_END };
> +
> +/* Insmod parameters */
> +I2C_CLIENT_INSMOD_1(adt7470);
> +
> +/* ADT7470 registers */
> +#define ADT7470_REG_BASE_ADDR			0x20
> +#define ADT7470_REG_TEMP_BASE_ADDR		0x20
> +#define ADT7470_REG_TEMP_MAX_ADDR		0x29
> +#define ADT7470_REG_FAN_BASE_ADDR		0x2A
> +#define ADT7470_REG_FAN_MAX_ADDR		0x31
> +#define ADT7470_REG_PWM_BASE_ADDR		0x32
> +#define ADT7470_REG_PWM_MAX_ADDR		0x35
> +#define ADT7470_REG_PWM_MAX_BASE_ADDR		0x38
> +#define ADT7470_REG_PWM_MAX_MAX_ADDR		0x3B
> +#define ADT7470_REG_CFG				0x40
> +#define		ADT7470_FSPD_MASK		0x04
> +#define ADT7470_REG_ALARM1			0x41
> +#define ADT7470_REG_ALARM2			0x42
> +#define ADT7470_REG_TEMP_LIMITS_BASE_ADDR	0x44
> +#define ADT7470_REG_TEMP_LIMITS_MAX_ADDR	0x57
> +#define ADT7470_REG_FAN_MIN_BASE_ADDR		0x58
> +#define ADT7470_REG_FAN_MIN_MAX_ADDR		0x5F
> +#define ADT7470_REG_FAN_MAX_BASE_ADDR		0x60
> +#define ADT7470_REG_FAN_MAX_MAX_ADDR		0x67
> +#define ADT7470_REG_PWM_CFG_BASE_ADDR		0x68
> +#define ADT7470_REG_PWM12_CFG			0x68
> +#define		ADT7470_PWM2_AUTO_MASK		0x40
> +#define		ADT7470_PWM1_AUTO_MASK		0x80
> +#define ADT7470_REG_PWM34_CFG			0x69
> +#define		ADT7470_PWM3_AUTO_MASK		0x40
> +#define		ADT7470_PWM4_AUTO_MASK		0x80
> +#define	ADT7470_REG_PWM_MIN_BASE_ADDR		0x6A
> +#define ADT7470_REG_PWM_MIN_MAX_ADDR		0x6D
> +#define ADT7470_REG_PWM_TEMP_MIN_BASE_ADDR	0x6E
> +#define ADT7470_REG_PWM_TEMP_MIN_MAX_ADDR	0x71
> +#define ADT7470_REG_ACOUSTICS12			0x75
> +#define ADT7470_REG_ACOUSTICS34			0x76
> +#define ADT7470_REG_DEVICE			0x3D
> +#define ADT7470_REG_VENDOR			0x3E
> +#define ADT7470_REG_REVISION			0x3F
> +#define ADT7470_REG_ALARM1_MASK			0x72
> +#define ADT7470_REG_ALARM2_MASK			0x73
> +#define ADT7470_REG_PWM_AUTO_TEMP_BASE_ADDR	0x7C
> +#define ADT7470_REG_PWM_AUTO_TEMP_MAX_ADDR	0x7D
> +#define ADT7470_REG_MAX_ADDR			0x81
> +
> +#define ADT7470_TEMP_COUNT	10
> +#define ADT7470_TEMP_REG(x)	(ADT7470_REG_TEMP_BASE_ADDR + (x))
> +#define ADT7470_TEMP_MIN_REG(x) (ADT7470_REG_TEMP_LIMITS_BASE_ADDR + ((x) * 2))
> +#define ADT7470_TEMP_MAX_REG(x) (ADT7470_REG_TEMP_LIMITS_BASE_ADDR + \
> +				((x) * 2) + 1)
> +
> +#define ADT7470_FAN_COUNT	4
> +#define ADT7470_REG_FAN(x)	(ADT7470_REG_FAN_BASE_ADDR + ((x) * 2))
> +#define ADT7470_REG_FAN_MIN(x)	(ADT7470_REG_FAN_MIN_BASE_ADDR + ((x) * 2))
> +#define ADT7470_REG_FAN_MAX(x)	(ADT7470_REG_FAN_MAX_BASE_ADDR + ((x) * 2))
> +
> +#define ADT7470_PWM_COUNT	4
> +#define ADT7470_REG_PWM(x)	(ADT7470_REG_PWM_BASE_ADDR + (x))
> +#define ADT7470_REG_PWM_MAX(x)	(ADT7470_REG_PWM_MAX_BASE_ADDR + (x))
> +#define ADT7470_REG_PWM_MIN(x)	(ADT7470_REG_PWM_MIN_BASE_ADDR + (x))
> +#define ADT7470_REG_PWM_TMIN(x)	(ADT7470_REG_PWM_TEMP_MIN_BASE_ADDR + (x))
> +#define ADT7470_REG_PWM_CFG(x)	(ADT7470_REG_PWM_CFG_BASE_ADDR + ((x) / 2))
> +#define ADT7470_REG_PWM_AUTO_TEMP(x)	(ADT7470_REG_PWM_AUTO_TEMP_BASE_ADDR + \
> +					((x) / 2))
> +
> +#define ADT7470_VENDOR		0x41
> +#define ADT7470_DEVICE		0x70
> +/* datasheet only mentions a revision 2 */
> +#define ADT7470_REVISION	0x02
> +
> +/* "all temps" according to hwmon sysfs interface spec */
> +#define ADT7470_PWM_ALL_TEMPS	0x3FF
> +
> +#define REFRESH_INTERVAL	(2 * HZ)
> +
> +/* sleep 1s while gathering temperature data */
> +#define TEMP_COLLECTION_TIME	1000
> +
> +#define power_of_2(x)	(((x) & ((x) - 1)) = 0)
> +
> +/* datasheet says to divide this number by the fan reading to get fan rpm */
> +#define FAN_PERIOD_TO_RPM(x)	((90000 * 60) / (x))
> +#define FAN_RPM_TO_PERIOD	FAN_PERIOD_TO_RPM
> +#define FAN_PERIOD_INVALID	65535
> +#define FAN_DATA_VALID(x)	((x) && (x) != FAN_PERIOD_INVALID)
> +
> +struct adt7470_data {
> +	struct i2c_client	client;
> +	struct class_device	*class_dev;
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
> +/*
> + * 16-bit registers on the ADT7470 are low-byte first.  The data sheet says
> + * that the low byte must be read before the high byte.
> + */
> +static inline int adt7470_read_word_data(struct i2c_client *client, u8 reg)
> +{
> +	u16 foo;
> +	foo = i2c_smbus_read_byte_data(client, reg);
> +	foo |= ((u16)i2c_smbus_read_byte_data(client, reg + 1) << 8);
> +	return foo;
> +}
> +
> +static inline int adt7470_write_word_data(struct i2c_client *client, u8 reg,
> +					  u16 value)
> +{
> +	return i2c_smbus_write_byte_data(client, reg, value & 0xFF)
> +	       && i2c_smbus_write_byte_data(client, reg + 1, value >> 8);
> +}
> +
> +static void adt7470_init_client(struct i2c_client *client)
> +{
> +	int reg = i2c_smbus_read_byte_data(client, ADT7470_REG_CFG);
> +
> +	if (reg < 0) {
> +		dev_err(&client->dev, "cannot read configuration register\n");
> +	} else {
> +		/* start monitoring (and do a self-test) */
> +		i2c_smbus_write_byte_data(client, ADT7470_REG_CFG, reg | 3);
> +	}
> +}
> +
> +static struct adt7470_data *adt7470_update_device(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct adt7470_data *data = i2c_get_clientdata(client);
> +	u8 cfg;
> +	int i;
> +
> +	mutex_lock(&data->lock);
> +	if (time_before(jiffies, data->last_updated + REFRESH_INTERVAL)
> +		&& data->valid)
> +		goto out;
> +
> +	/* start reading temperature sensors */
> +	cfg = i2c_smbus_read_byte_data(client, ADT7470_REG_CFG);
> +	cfg |= 0x80;
> +	i2c_smbus_write_byte_data(client, ADT7470_REG_CFG, cfg);
> +
> +	/*
> +	 * Delay is 200ms * number of tmp05 sensors.  Too bad
> +	 * there's no way to figure out how many are connected.
> +	 * For now, assume 1s will work.
> +	 */
> +	msleep(TEMP_COLLECTION_TIME);
> +
> +	/* done reading temperature sensors */
> +	cfg = i2c_smbus_read_byte_data(client, ADT7470_REG_CFG);
> +	cfg &= ~0x80;
> +	i2c_smbus_write_byte_data(client, ADT7470_REG_CFG, cfg);
> +
> +	for (i = 0; i < ADT7470_TEMP_COUNT; i++) {
> +		data->temp[i] = i2c_smbus_read_byte_data(client,
> +						ADT7470_TEMP_REG(i));
> +		data->temp_min[i] = i2c_smbus_read_byte_data(client,
> +						ADT7470_TEMP_MIN_REG(i));
> +		data->temp_max[i] = i2c_smbus_read_byte_data(client,
> +						ADT7470_TEMP_MAX_REG(i));
> +	}
> +
> +	for (i = 0; i < ADT7470_FAN_COUNT; i++) {
> +		data->fan[i] = adt7470_read_word_data(client,
> +						ADT7470_REG_FAN(i));
> +		data->fan_min[i] = adt7470_read_word_data(client,
> +						ADT7470_REG_FAN_MIN(i));
> +		data->fan_max[i] = adt7470_read_word_data(client,
> +						ADT7470_REG_FAN_MAX(i));
> +	}
> +
> +	for (i = 0; i < ADT7470_PWM_COUNT; i++) {
> +		int reg = ADT7470_REG_PWM_CFG(i);
> +		int reg_mask;
> +
> +		if (i % 2)
> +			reg_mask = ADT7470_PWM2_AUTO_MASK;
> +		else
> +			reg_mask = ADT7470_PWM1_AUTO_MASK;
> +
> +		data->pwm[i] = i2c_smbus_read_byte_data(client,
> +						ADT7470_REG_PWM(i));
> +		data->pwm_max[i] = i2c_smbus_read_byte_data(client,
> +						ADT7470_REG_PWM_MAX(i));
> +		data->pwm_min[i] = i2c_smbus_read_byte_data(client,
> +						ADT7470_REG_PWM_MIN(i));
> +		data->pwm_tmin[i] = i2c_smbus_read_byte_data(client,
> +						ADT7470_REG_PWM_TMIN(i));
> +
> +		if (i2c_smbus_read_byte_data(client, reg) & reg_mask)
> +			data->pwm_automatic[i] = 1;
> +		else
> +			data->pwm_automatic[i] = 0;
> +
> +		reg = ADT7470_REG_PWM_AUTO_TEMP(i);
> +		cfg = i2c_smbus_read_byte_data(client, reg);
> +		if (!(i % 2))
> +			data->pwm_auto_temp[i] = cfg >> 4;
> +		else
> +			data->pwm_auto_temp[i] = cfg & 0xF;
> +	}
> +
> +	if (i2c_smbus_read_byte_data(client, ADT7470_REG_CFG) &
> +	    ADT7470_FSPD_MASK)
> +		data->force_pwm_max = 1;
> +	else
> +		data->force_pwm_max = 0;
> +
> +	data->alarms = adt7470_read_word_data(client, ADT7470_REG_ALARM1);
> +	data->alarms_mask = adt7470_read_word_data(client,
> +						   ADT7470_REG_ALARM1_MASK);
> +
> +	data->last_updated = jiffies;
> +	data->valid = 1;
> +
> +out:
> +	mutex_unlock(&data->lock);
> +	return data;
> +}
> +
> +static ssize_t show_temp_min(struct device *dev,
> +			     struct device_attribute *devattr,
> +			     char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct adt7470_data *data = adt7470_update_device(dev);
> +	return sprintf(buf, "%d\n", 1000 * data->temp_min[attr->index]);
> +}
> +
> +static ssize_t set_temp_min(struct device *dev,
> +			    struct device_attribute *devattr,
> +			    const char *buf,
> +			    size_t count)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct adt7470_data *data = i2c_get_clientdata(client);
> +	int temp = simple_strtol(buf, NULL, 10) / 1000;
> +
> +	mutex_lock(&data->lock);
> +	data->temp_min[attr->index] = temp;
> +	i2c_smbus_write_byte_data(client, ADT7470_TEMP_MIN_REG(attr->index),
> +				  temp);
> +	mutex_unlock(&data->lock);
> +
> +	return count;
> +}
> +
> +static ssize_t show_temp_max(struct device *dev,
> +			     struct device_attribute *devattr,
> +			     char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct adt7470_data *data = adt7470_update_device(dev);
> +	return sprintf(buf, "%d\n", 1000 * data->temp_max[attr->index]);
> +}
> +
> +static ssize_t set_temp_max(struct device *dev,
> +			    struct device_attribute *devattr,
> +			    const char *buf,
> +			    size_t count)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct adt7470_data *data = i2c_get_clientdata(client);
> +	int temp = simple_strtol(buf, NULL, 10) / 1000;
> +
> +	mutex_lock(&data->lock);
> +	data->temp_max[attr->index] = temp;
> +	i2c_smbus_write_byte_data(client, ADT7470_TEMP_MAX_REG(attr->index),
> +				  temp);
> +	mutex_unlock(&data->lock);
> +
> +	return count;
> +}
> +
> +static ssize_t show_temp(struct device *dev, struct device_attribute *devattr,
> +			 char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct adt7470_data *data = adt7470_update_device(dev);
> +	return sprintf(buf, "%d\n", 1000 * data->temp[attr->index]);
> +}
> +
> +static ssize_t show_alarms(struct device *dev,
> +			   struct device_attribute *devattr,
> +			   char *buf)
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
> +static ssize_t show_fan_max(struct device *dev,
> +			    struct device_attribute *devattr,
> +			    char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct adt7470_data *data = adt7470_update_device(dev);
> +
> +	if (FAN_DATA_VALID(data->fan_max[attr->index]))
> +		return sprintf(buf, "%d\n",
> +			       FAN_PERIOD_TO_RPM(data->fan_max[attr->index]));
> +	else
> +		return sprintf(buf, "0\n");
> +}
> +
> +static ssize_t set_fan_max(struct device *dev,
> +			   struct device_attribute *devattr,
> +			   const char *buf, size_t count)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct adt7470_data *data = i2c_get_clientdata(client);
> +	int temp = simple_strtol(buf, NULL, 10);
> +
> +	if (!temp)
> +		return -EINVAL;
> +	temp = FAN_RPM_TO_PERIOD(temp);
> +
> +	mutex_lock(&data->lock);
> +	data->fan_max[attr->index] = temp;
> +	adt7470_write_word_data(client, ADT7470_REG_FAN_MAX(attr->index), temp);
> +	mutex_unlock(&data->lock);
> +
> +	return count;
> +}
> +
> +static ssize_t show_fan_min(struct device *dev,
> +			    struct device_attribute *devattr,
> +			    char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct adt7470_data *data = adt7470_update_device(dev);
> +
> +	if (FAN_DATA_VALID(data->fan_min[attr->index]))
> +		return sprintf(buf, "%d\n",
> +			       FAN_PERIOD_TO_RPM(data->fan_min[attr->index]));
> +	else
> +		return sprintf(buf, "0\n");
> +}
> +
> +static ssize_t set_fan_min(struct device *dev,
> +			   struct device_attribute *devattr,
> +			   const char *buf, size_t count)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct adt7470_data *data = i2c_get_clientdata(client);
> +	int temp = simple_strtol(buf, NULL, 10);
> +
> +	if (!temp)
> +		return -EINVAL;
> +	temp = FAN_RPM_TO_PERIOD(temp);
> +
> +	mutex_lock(&data->lock);
> +	data->fan_min[attr->index] = temp;
> +	adt7470_write_word_data(client, ADT7470_REG_FAN_MIN(attr->index), temp);
> +	mutex_unlock(&data->lock);
> +
> +	return count;
> +}
> +
> +static ssize_t show_fan(struct device *dev, struct device_attribute *devattr,
> +			char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct adt7470_data *data = adt7470_update_device(dev);
> +
> +	if (FAN_DATA_VALID(data->fan[attr->index]))
> +		return sprintf(buf, "%d\n",
> +			       FAN_PERIOD_TO_RPM(data->fan[attr->index]));
> +	else
> +		return sprintf(buf, "0\n");
> +}
> +
> +static ssize_t show_force_pwm_max(struct device *dev,
> +				  struct device_attribute *devattr,
> +				  char *buf)
> +{
> +	struct adt7470_data *data = adt7470_update_device(dev);
> +	return sprintf(buf, "%d\n", data->force_pwm_max);
> +}
> +
> +static ssize_t set_force_pwm_max(struct device *dev,
> +				 struct device_attribute *devattr,
> +				 const char *buf,
> +				 size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct adt7470_data *data = i2c_get_clientdata(client);
> +	int temp = simple_strtol(buf, NULL, 10);
> +	u8 reg;
> +
> +	mutex_lock(&data->lock);
> +	data->force_pwm_max = temp;
> +	reg = i2c_smbus_read_byte_data(client, ADT7470_REG_CFG);
> +	if (temp)
> +		reg |= ADT7470_FSPD_MASK;
> +	else
> +		reg &= ~ADT7470_FSPD_MASK;
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
> +static ssize_t show_pwm_max(struct device *dev,
> +			    struct device_attribute *devattr,
> +			    char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct adt7470_data *data = adt7470_update_device(dev);
> +	return sprintf(buf, "%d\n", data->pwm_max[attr->index]);
> +}
> +
> +static ssize_t set_pwm_max(struct device *dev,
> +			   struct device_attribute *devattr,
> +			   const char *buf,
> +			   size_t count)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct adt7470_data *data = i2c_get_clientdata(client);
> +	int temp = simple_strtol(buf, NULL, 10);
> +
> +	mutex_lock(&data->lock);
> +	data->pwm_max[attr->index] = temp;
> +	i2c_smbus_write_byte_data(client, ADT7470_REG_PWM_MAX(attr->index),
> +				  temp);
> +	mutex_unlock(&data->lock);
> +
> +	return count;
> +}
> +
> +static ssize_t show_pwm_min(struct device *dev,
> +			    struct device_attribute *devattr,
> +			    char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct adt7470_data *data = adt7470_update_device(dev);
> +	return sprintf(buf, "%d\n", data->pwm_min[attr->index]);
> +}
> +
> +static ssize_t set_pwm_min(struct device *dev,
> +			   struct device_attribute *devattr,
> +			   const char *buf,
> +			   size_t count)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct adt7470_data *data = i2c_get_clientdata(client);
> +	int temp = simple_strtol(buf, NULL, 10);
> +
> +	mutex_lock(&data->lock);
> +	data->pwm_min[attr->index] = temp;
> +	i2c_smbus_write_byte_data(client, ADT7470_REG_PWM_MIN(attr->index),
> +				  temp);
> +	mutex_unlock(&data->lock);
> +
> +	return count;
> +}
> +
> +static ssize_t show_pwm_tmax(struct device *dev,
> +			     struct device_attribute *devattr,
> +			     char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct adt7470_data *data = adt7470_update_device(dev);
> +	/* the datasheet says that tmax = tmin + 20C */
> +	return sprintf(buf, "%d\n", 1000 * (20 + data->pwm_tmin[attr->index]));
> +}
> +
> +static ssize_t show_pwm_tmin(struct device *dev,
> +			     struct device_attribute *devattr,
> +			     char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct adt7470_data *data = adt7470_update_device(dev);
> +	return sprintf(buf, "%d\n", 1000 * data->pwm_tmin[attr->index]);
> +}
> +
> +static ssize_t set_pwm_tmin(struct device *dev,
> +			    struct device_attribute *devattr,
> +			    const char *buf,
> +			    size_t count)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct adt7470_data *data = i2c_get_clientdata(client);
> +	int temp = simple_strtol(buf, NULL, 10) / 1000;
> +
> +	mutex_lock(&data->lock);
> +	data->pwm_tmin[attr->index] = temp;
> +	i2c_smbus_write_byte_data(client, ADT7470_REG_PWM_TMIN(attr->index),
> +				  temp);
> +	mutex_unlock(&data->lock);
> +
> +	return count;
> +}
> +
> +static ssize_t show_pwm_auto(struct device *dev,
> +			     struct device_attribute *devattr,
> +			     char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct adt7470_data *data = adt7470_update_device(dev);
> +	return sprintf(buf, "%d\n", 1 + data->pwm_automatic[attr->index]);
> +}
> +
> +static ssize_t set_pwm_auto(struct device *dev,
> +			    struct device_attribute *devattr,
> +			    const char *buf,
> +			    size_t count)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct adt7470_data *data = i2c_get_clientdata(client);
> +	int temp = simple_strtol(buf, NULL, 10);
> +	int pwm_auto_reg = ADT7470_REG_PWM_CFG(attr->index);
> +	int pwm_auto_reg_mask;
> +	u8 reg;
> +
> +	if (attr->index % 2)
> +		pwm_auto_reg_mask = ADT7470_PWM2_AUTO_MASK;
> +	else
> +		pwm_auto_reg_mask = ADT7470_PWM1_AUTO_MASK;
> +
> +	if (temp != 2 && temp != 1)
> +		return -EINVAL;
> +	temp--;
> +
> +	mutex_lock(&data->lock);
> +	data->pwm_automatic[attr->index] = temp;
> +	reg = i2c_smbus_read_byte_data(client, pwm_auto_reg);
> +	if (temp)
> +		reg |= pwm_auto_reg_mask;
> +	else
> +		reg &= ~pwm_auto_reg_mask;
> +	i2c_smbus_write_byte_data(client, pwm_auto_reg, reg);
> +	mutex_unlock(&data->lock);
> +
> +	return count;
> +}
> +
> +static ssize_t show_pwm_auto_temp(struct device *dev,
> +				  struct device_attribute *devattr,
> +				  char *buf)
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
> +static ssize_t set_pwm_auto_temp(struct device *dev,
> +				 struct device_attribute *devattr,
> +				 const char *buf,
> +				 size_t count)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct adt7470_data *data = i2c_get_clientdata(client);
> +	int temp = cvt_auto_temp(simple_strtol(buf, NULL, 10));
> +	int pwm_auto_reg = ADT7470_REG_PWM_AUTO_TEMP(attr->index);
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
> +static struct sensor_device_attribute adt7470_attr[] > +{
> +	SENSOR_ATTR(alarms, S_IRUGO, show_alarms, NULL, 0),
> +	SENSOR_ATTR(alarm_mask, S_IRUGO, show_alarms, NULL, 1),
> +
> +	SENSOR_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_max,
> +		    set_temp_max, 0),
> +	SENSOR_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_temp_max,
> +		    set_temp_max, 1),
> +	SENSOR_ATTR(temp3_max, S_IWUSR | S_IRUGO, show_temp_max,
> +		    set_temp_max, 2),
> +	SENSOR_ATTR(temp4_max, S_IWUSR | S_IRUGO, show_temp_max,
> +		    set_temp_max, 3),
> +	SENSOR_ATTR(temp5_max, S_IWUSR | S_IRUGO, show_temp_max,
> +		    set_temp_max, 4),
> +	SENSOR_ATTR(temp6_max, S_IWUSR | S_IRUGO, show_temp_max,
> +		    set_temp_max, 5),
> +	SENSOR_ATTR(temp7_max, S_IWUSR | S_IRUGO, show_temp_max,
> +		    set_temp_max, 6),
> +	SENSOR_ATTR(temp8_max, S_IWUSR | S_IRUGO, show_temp_max,
> +		    set_temp_max, 7),
> +	SENSOR_ATTR(temp9_max, S_IWUSR | S_IRUGO, show_temp_max,
> +		    set_temp_max, 8),
> +	SENSOR_ATTR(temp10_max, S_IWUSR | S_IRUGO, show_temp_max,
> +		    set_temp_max, 9),
> +
> +	SENSOR_ATTR(temp1_min, S_IWUSR | S_IRUGO, show_temp_min,
> +		    set_temp_min, 0),
> +	SENSOR_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_temp_min,
> +		    set_temp_min, 1),
> +	SENSOR_ATTR(temp3_min, S_IWUSR | S_IRUGO, show_temp_min,
> +		    set_temp_min, 2),
> +	SENSOR_ATTR(temp4_min, S_IWUSR | S_IRUGO, show_temp_min,
> +		    set_temp_min, 3),
> +	SENSOR_ATTR(temp5_min, S_IWUSR | S_IRUGO, show_temp_min,
> +		    set_temp_min, 4),
> +	SENSOR_ATTR(temp6_min, S_IWUSR | S_IRUGO, show_temp_min,
> +		    set_temp_min, 5),
> +	SENSOR_ATTR(temp7_min, S_IWUSR | S_IRUGO, show_temp_min,
> +		    set_temp_min, 6),
> +	SENSOR_ATTR(temp8_min, S_IWUSR | S_IRUGO, show_temp_min,
> +		    set_temp_min, 7),
> +	SENSOR_ATTR(temp9_min, S_IWUSR | S_IRUGO, show_temp_min,
> +		    set_temp_min, 8),
> +	SENSOR_ATTR(temp10_min, S_IWUSR | S_IRUGO, show_temp_min,
> +		    set_temp_min, 9),
> +
> +	SENSOR_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0),
> +	SENSOR_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 1),
> +	SENSOR_ATTR(temp3_input, S_IRUGO, show_temp, NULL, 2),
> +	SENSOR_ATTR(temp4_input, S_IRUGO, show_temp, NULL, 3),
> +	SENSOR_ATTR(temp5_input, S_IRUGO, show_temp, NULL, 4),
> +	SENSOR_ATTR(temp6_input, S_IRUGO, show_temp, NULL, 5),
> +	SENSOR_ATTR(temp7_input, S_IRUGO, show_temp, NULL, 6),
> +	SENSOR_ATTR(temp8_input, S_IRUGO, show_temp, NULL, 7),
> +	SENSOR_ATTR(temp9_input, S_IRUGO, show_temp, NULL, 8),
> +	SENSOR_ATTR(temp10_input, S_IRUGO, show_temp, NULL, 9),
> +
> +	SENSOR_ATTR(fan1_max, S_IWUSR | S_IRUGO, show_fan_max,
> +		    set_fan_max, 0),
> +	SENSOR_ATTR(fan2_max, S_IWUSR | S_IRUGO, show_fan_max,
> +		    set_fan_max, 1),
> +	SENSOR_ATTR(fan3_max, S_IWUSR | S_IRUGO, show_fan_max,
> +		    set_fan_max, 2),
> +	SENSOR_ATTR(fan4_max, S_IWUSR | S_IRUGO, show_fan_max,
> +		    set_fan_max, 3),
> +
> +	SENSOR_ATTR(fan1_min, S_IWUSR | S_IRUGO, show_fan_min,
> +		    set_fan_min, 0),
> +	SENSOR_ATTR(fan2_min, S_IWUSR | S_IRUGO, show_fan_min,
> +		    set_fan_min, 1),
> +	SENSOR_ATTR(fan3_min, S_IWUSR | S_IRUGO, show_fan_min,
> +		    set_fan_min, 2),
> +	SENSOR_ATTR(fan4_min, S_IWUSR | S_IRUGO, show_fan_min,
> +		    set_fan_min, 3),
> +
> +	SENSOR_ATTR(fan1_input, S_IRUGO, show_fan, NULL, 0),
> +	SENSOR_ATTR(fan2_input, S_IRUGO, show_fan, NULL, 1),
> +	SENSOR_ATTR(fan3_input, S_IRUGO, show_fan, NULL, 2),
> +	SENSOR_ATTR(fan4_input, S_IRUGO, show_fan, NULL, 3),
> +
> +	SENSOR_ATTR(force_pwm_max, S_IWUSR | S_IRUGO,
> +		    show_force_pwm_max, set_force_pwm_max, 0),
> +
> +	SENSOR_ATTR(pwm1, S_IWUSR | S_IRUGO, show_pwm, set_pwm, 0),
> +	SENSOR_ATTR(pwm2, S_IWUSR | S_IRUGO, show_pwm, set_pwm, 1),
> +	SENSOR_ATTR(pwm3, S_IWUSR | S_IRUGO, show_pwm, set_pwm, 2),
> +	SENSOR_ATTR(pwm4, S_IWUSR | S_IRUGO, show_pwm, set_pwm, 3),
> +
> +	SENSOR_ATTR(pwm1_auto_point1_pwm, S_IWUSR | S_IRUGO,
> +		    show_pwm_min, set_pwm_min, 0),
> +	SENSOR_ATTR(pwm2_auto_point1_pwm, S_IWUSR | S_IRUGO,
> +		    show_pwm_min, set_pwm_min, 1),
> +	SENSOR_ATTR(pwm3_auto_point1_pwm, S_IWUSR | S_IRUGO,
> +		    show_pwm_min, set_pwm_min, 2),
> +	SENSOR_ATTR(pwm4_auto_point1_pwm, S_IWUSR | S_IRUGO,
> +		    show_pwm_min, set_pwm_min, 3),
> +
> +	SENSOR_ATTR(pwm1_auto_point2_pwm, S_IWUSR | S_IRUGO,
> +		    show_pwm_max, set_pwm_max, 0),
> +	SENSOR_ATTR(pwm2_auto_point2_pwm, S_IWUSR | S_IRUGO,
> +		    show_pwm_max, set_pwm_max, 1),
> +	SENSOR_ATTR(pwm3_auto_point2_pwm, S_IWUSR | S_IRUGO,
> +		    show_pwm_max, set_pwm_max, 2),
> +	SENSOR_ATTR(pwm4_auto_point2_pwm, S_IWUSR | S_IRUGO,
> +		    show_pwm_max, set_pwm_max, 3),
> +
> +	SENSOR_ATTR(pwm1_auto_point1_temp, S_IWUSR | S_IRUGO,
> +		    show_pwm_tmin, set_pwm_tmin, 0),
> +	SENSOR_ATTR(pwm2_auto_point1_temp, S_IWUSR | S_IRUGO,
> +		    show_pwm_tmin, set_pwm_tmin, 1),
> +	SENSOR_ATTR(pwm3_auto_point1_temp, S_IWUSR | S_IRUGO,
> +		    show_pwm_tmin, set_pwm_tmin, 2),
> +	SENSOR_ATTR(pwm4_auto_point1_temp, S_IWUSR | S_IRUGO,
> +		    show_pwm_tmin, set_pwm_tmin, 3),
> +
> +	SENSOR_ATTR(pwm1_auto_point2_temp, S_IRUGO, show_pwm_tmax,
> +		    NULL, 0),
> +	SENSOR_ATTR(pwm2_auto_point2_temp, S_IRUGO, show_pwm_tmax,
> +		    NULL, 1),
> +	SENSOR_ATTR(pwm3_auto_point2_temp, S_IRUGO, show_pwm_tmax,
> +		    NULL, 2),
> +	SENSOR_ATTR(pwm4_auto_point2_temp, S_IRUGO, show_pwm_tmax,
> +		    NULL, 3),
> +
> +	SENSOR_ATTR(pwm1_enable, S_IWUSR | S_IRUGO, show_pwm_auto,
> +		    set_pwm_auto, 0),
> +	SENSOR_ATTR(pwm2_enable, S_IWUSR | S_IRUGO, show_pwm_auto,
> +		    set_pwm_auto, 1),
> +	SENSOR_ATTR(pwm3_enable, S_IWUSR | S_IRUGO, show_pwm_auto,
> +		    set_pwm_auto, 2),
> +	SENSOR_ATTR(pwm4_enable, S_IWUSR | S_IRUGO, show_pwm_auto,
> +		    set_pwm_auto, 3),
> +
> +	SENSOR_ATTR(pwm1_auto_channels_temp, S_IWUSR | S_IRUGO,
> +		    show_pwm_auto_temp, set_pwm_auto_temp, 0),
> +	SENSOR_ATTR(pwm2_auto_channels_temp, S_IWUSR | S_IRUGO,
> +		    show_pwm_auto_temp, set_pwm_auto_temp, 1),
> +	SENSOR_ATTR(pwm3_auto_channels_temp, S_IWUSR | S_IRUGO,
> +		    show_pwm_auto_temp, set_pwm_auto_temp, 2),
> +	SENSOR_ATTR(pwm4_auto_channels_temp, S_IWUSR | S_IRUGO,
> +		    show_pwm_auto_temp, set_pwm_auto_temp, 3)
> +};
> +
> +static int adt7470_attach_adapter(struct i2c_adapter *adapter)
> +{
> +	if (!(adapter->class & I2C_CLASS_HWMON))
> +		return 0;
> +	return i2c_probe(adapter, &addr_data, adt7470_detect);
> +}
> +
> +static int adt7470_detect(struct i2c_adapter *adapter, int address, int kind)
> +{
> +	struct i2c_client *client;
> +	struct adt7470_data *data;
> +	int err = 0;
> +	int i;
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
> +			err = -ENODEV;
> +			goto exit_free;
> +		}
> +
> +		device = i2c_smbus_read_byte_data(client, ADT7470_REG_DEVICE);
> +		if (device != ADT7470_DEVICE) {
> +			err = -ENODEV;
> +			goto exit_free;
> +		}
> +
> +		revision = i2c_smbus_read_byte_data(client,
> +						    ADT7470_REG_REVISION);
> +		if (revision != ADT7470_REVISION) {
> +			err = -ENODEV;
> +			goto exit_free;
> +		}
> +	} else
> +		dev_dbg(&adapter->dev, "detection forced\n");
> +
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
> +	for (i = 0; i < ARRAY_SIZE(adt7470_attr); i++) {
> +		err = device_create_file(&client->dev,
> +					 &adt7470_attr[i].dev_attr);
> +		if (err)
> +			goto exit_remove;
> +	}
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
> +	for (i = 0; i < ARRAY_SIZE(adt7470_attr); i++)
> +		device_remove_file(&client->dev, &adt7470_attr[i].dev_attr);
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
> +	int i;
> +
> +	hwmon_device_unregister(data->class_dev);
> +	for (i = 0; i < ARRAY_SIZE(adt7470_attr); i++)
> +		device_remove_file(&client->dev, &adt7470_attr[i].dev_attr);
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
> +
> +module_init(adt7470_init);
> +module_exit(adt7470_exit);
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
