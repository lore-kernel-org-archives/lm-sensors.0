From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 09 Jul 2007 18:03:06 +0000
Subject: Re: [lm-sensors] [PATCH] THMC50 support for 2.6 (4th revision)
Message-Id: <20070709200306.27f4c610@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070708224300.4507035b.krzysztof.h1@wp.pl>
In-Reply-To: <20070708224300.4507035b.krzysztof.h1@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Krzysztof,

On Sun, 8 Jul 2007 22:43:00 +0200, Krzysztof Helt wrote:
> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> This patch adds support for THMC50 and ADM1022 chips to 2.6 kernels.
> 
> Special thanks to Jean Delavare and Mark M. Hoffman for reviews of previous versions of the patch.
                         ^^^^^^^^

Typo in my name! ;)

> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> ---
> This patch incorporates all suggestions and requests to the previously sent patches.
> 
> I deliberately left the adm1022 always with 3 temperatures. It can be changed later if the 3 temperatures
> should be available only in 3 temperatures mode. It is simpler to ignore unused one with config file at the
> moment.

I already expressed my disagreement. I really believe that the files
for the 3rd temperature should only be created in 3 temperature mode.

But for the rest, your code looks OK to me now, so:

Acked-by: Jean Delvare <khali@linux-fr.org>

> 
> diff -urpN linux-2.6.21/Documentation/hwmon/thmc50 linux-2.6.22/Documentation/hwmon/thmc50
> --- linux-2.6.21/Documentation/hwmon/thmc50	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.22/Documentation/hwmon/thmc50	2007-07-08 21:53:56.045938678 +0200
> @@ -0,0 +1,74 @@
> +Kernel driver thmc50
> +==========> +
> +Supported chips:
> +  * Analog Devices ADM1022
> +    Prefix: 'adm1022'
> +    Addresses scanned: I2C 0x2c - 0x2e
> +    Datasheet: http://www.analog.com/en/prod/0,2877,ADM1022,00.html
> +  * Texas Instruments THMC50
> +    Prefix: 'thmc50'
> +    Addresses scanned: I2C 0x2c - 0x2e
> +    Datasheet: http://focus.ti.com/docs/prod/folders/print/thmc50.html
> +
> +Author: Krzysztof Helt <krzysztof.h1@wp.pl>
> +
> +This driver was derived from the 2.4 kernel thmc50.c source file.
> +
> +Credits:
> +  thmc50.c (2.4 kernel):
> +	Frodo Looijaard <frodol@dds.nl>
> +	Philip Edelbrock <phil@netroedge.com>
> +
> +Module Parameters
> +-----------------
> +
> +* adm1022_temp3: short array
> +  List of adapter,address pairs to force chips into ADM1022 mode with
> +  second remote temperature. This does not work for original THMC50 chips.
> +
> +Description
> +-----------
> +
> +The THMC50 implements: an internal temperature sensor, support for an
> +external diode-type temperature sensor (compatible w/ the diode sensor inside
> +many processors), and a controllable fan/analog_out DAC. For the temperature
> +sensors, limits can be set through the appropriate Overtemperature Shutdown
> +register and Hysteresis register. Each value can be set and read to half-degree
> +accuracy.  An alarm is issued (usually to a connected LM78) when the
> +temperature gets higher then the Overtemperature Shutdown value; it stays on
> +until the temperature falls below the Hysteresis value. All temperatures are in
> +degrees Celsius, and are guaranteed within a range of -55 to +125 degrees.
> +
> +The THMC50 only updates its values each 1.5 seconds; reading it more often
> +will do no harm, but will return 'old' values.
> +
> +The THMC50 is usually used in combination with LM78-like chips, to measure
> +the temperature of the processor(s).
> +
> +The ADM1022 works the same as THMC50 but it is faster (5 Hz instead of
> +1 Hz for THMC50). It can be also put in a new mode to handle additional
> +remote temperature sensor. The driver use the mode set by BIOS by default.
> +
> +In case the BIOS is broken and the mode is set incorrectly, you can force 
> +the mode with additional remote temperature with adm1022_temp3 parameter.
> +A typical symptom of wrong setting is a fan forced to full speed.
> +
> +Driver Features
> +---------------
> +
> +The driver provides up to three temperatures:
> +
> +temp1		-- internal
> +temp2		-- remote
> +temp3		-- 2nd remote only for ADM1022
> +
> +pwm1		-- fan speed (0 = stop, 255 = full)
> +pwm1_mode	-- always 0 (DC mode)
> +
> +The value of 0 for pwm1 also forces FAN_OFF signal from the chip,
> +so it stops fans even if the value 0 into the ANALOG_OUT register does not.
> +
> +The driver was tested on Compaq AP550 with two ADM1022 chips (one works 
> +in the temp3 mode), five temperature readings and two fans.
> +
> diff -urpN linux-2.6.21/drivers/hwmon/Kconfig linux-2.6.22/drivers/hwmon/Kconfig
> --- linux-2.6.21/drivers/hwmon/Kconfig	2007-06-24 22:14:45.824824857 +0200
> +++ linux-2.6.22/drivers/hwmon/Kconfig	2007-06-24 22:24:58.859759689 +0200
> @@ -485,6 +485,16 @@ config SENSORS_SMSC47B397
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called smsc47b397.
>  
> +config SENSORS_THMC50
> +	tristate "Texas Instruments THMC50 / Analog Devices ADM1022"
> +	depends on I2C && EXPERIMENTAL
> +	help
> +	  If you say yes here you get support for Texas Instruments THMC50
> +	  sensor chips and clones: the Analog Devices ADM1022.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called thmc50.
> +
>  config SENSORS_VIA686A
>  	tristate "VIA686A"
>  	depends on I2C && PCI
> diff -urpN linux-2.6.21/drivers/hwmon/Makefile linux-2.6.22/drivers/hwmon/Makefile
> --- linux-2.6.21/drivers/hwmon/Makefile	2007-06-24 22:14:45.824824857 +0200
> +++ linux-2.6.22/drivers/hwmon/Makefile	2007-06-24 22:22:56.852806945 +0200
> @@ -53,6 +53,7 @@ obj-$(CONFIG_SENSORS_SIS5595)	+= sis5595
>  obj-$(CONFIG_SENSORS_SMSC47B397)+= smsc47b397.o
>  obj-$(CONFIG_SENSORS_SMSC47M1)	+= smsc47m1.o
>  obj-$(CONFIG_SENSORS_SMSC47M192)+= smsc47m192.o
> +obj-$(CONFIG_SENSORS_THMC50)	+= thmc50.o
>  obj-$(CONFIG_SENSORS_VIA686A)	+= via686a.o
>  obj-$(CONFIG_SENSORS_VT1211)	+= vt1211.o
>  obj-$(CONFIG_SENSORS_VT8231)	+= vt8231.o
> diff -urpN linux-2.6.21/drivers/hwmon/thmc50.c linux-2.6.22/drivers/hwmon/thmc50.c
> --- linux-2.6.21/drivers/hwmon/thmc50.c	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.22/drivers/hwmon/thmc50.c	2007-07-08 22:23:59.148691613 +0200
> @@ -0,0 +1,440 @@
> +/*
> +    thmc50.c - Part of lm_sensors, Linux kernel modules for hardware
> +             monitoring
> +    Copyright (C) 2007 Krzysztof Helt <krzysztof.h1@wp.pl>
> +    Based on 2.4 driver by Frodo Looijaard <frodol@dds.nl> and
> +    Philip Edelbrock <phil@netroedge.com>
> +
> +    This program is free software; you can redistribute it and/or modify
> +    it under the terms of the GNU General Public License as published by
> +    the Free Software Foundation; either version 2 of the License, or
> +    (at your option) any later version.
> +
> +    This program is distributed in the hope that it will be useful,
> +    but WITHOUT ANY WARRANTY; without even the implied warranty of
> +    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +    GNU General Public License for more details.
> +
> +    You should have received a copy of the GNU General Public License
> +    along with this program; if not, write to the Free Software
> +    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> +*/
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/i2c.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/err.h>
> +#include <linux/mutex.h>
> +
> +MODULE_LICENSE("GPL");
> +
> +/* Addresses to scan */
> +static unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
> +
> +/* Insmod parameters */
> +I2C_CLIENT_INSMOD_2(thmc50, adm1022);
> +I2C_CLIENT_MODULE_PARM(adm1022_temp3, "List of adapter,address pairs "
> +			"to enable 3rd temperature (ADM1022 only)");
> +
> +/* Many THMC50 constants specified below */
> +
> +/* The THMC50 registers */
> +#define THMC50_REG_CONF				0x40
> +#define THMC50_REG_COMPANY_ID			0x3E
> +#define THMC50_REG_DIE_CODE			0x3F
> +#define THMC50_REG_ANALOG_OUT			0x19
> +
> +const static u8 THMC50_REG_TEMP[] = { 0x27, 0x26, 0x20 };
> +const static u8 THMC50_REG_TEMP_MIN[] = { 0x3A, 0x38, 0x2C };
> +const static u8 THMC50_REG_TEMP_MAX[] = { 0x39, 0x37, 0x2B };
> +
> +#define THMC50_REG_CONF_nFANOFF			0x20
> +
> +/* Each client has this additional data */
> +struct thmc50_data {
> +	struct i2c_client client;
> +	struct class_device *class_dev;
> +
> +	struct mutex update_lock;
> +	enum chips type;
> +	unsigned long last_updated;	/* In jiffies */
> +	char has_temp3;		/* !=0 if it is ADM1022 in temp3 mode */
> +	char valid;		/* !=0 if following fields are valid */
> +
> +	/* Register values */
> +	s8 temp_input[3];
> +	s8 temp_max[3];
> +	s8 temp_min[3];
> +	u8 analog_out;
> +};
> +
> +static int thmc50_attach_adapter(struct i2c_adapter *adapter);
> +static int thmc50_detach_client(struct i2c_client *client);
> +static void thmc50_init_client(struct i2c_client *client);
> +static struct thmc50_data *thmc50_update_device(struct device *dev);
> +
> +static struct i2c_driver thmc50_driver = {
> +	.driver = {
> +		.name = "thmc50",
> +	},
> +	.attach_adapter = thmc50_attach_adapter,
> +	.detach_client = thmc50_detach_client,
> +};
> +
> +static ssize_t show_analog_out(struct device *dev,
> +			       struct device_attribute *attr, char *buf)
> +{
> +	struct thmc50_data *data = thmc50_update_device(dev);
> +	return sprintf(buf, "%d\n", data->analog_out);
> +}
> +
> +static ssize_t set_analog_out(struct device *dev,
> +			      struct device_attribute *attr,
> +			      const char *buf, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct thmc50_data *data = i2c_get_clientdata(client);
> +	int tmp = simple_strtoul(buf, NULL, 10);
> +	int config;
> +
> +	mutex_lock(&data->update_lock);
> +	data->analog_out = SENSORS_LIMIT(tmp, 0, 255);
> +	i2c_smbus_write_byte_data(client, THMC50_REG_ANALOG_OUT,
> +				  data->analog_out);
> +
> +	config = i2c_smbus_read_byte_data(client, THMC50_REG_CONF);
> +	if (data->analog_out = 0)
> +		config &= ~THMC50_REG_CONF_nFANOFF;
> +	else
> +		config |= THMC50_REG_CONF_nFANOFF;
> +	i2c_smbus_write_byte_data(client, THMC50_REG_CONF, config);
> +
> +	mutex_unlock(&data->update_lock);
> +	return count;
> +}
> +
> +/* There is only one PWM mode = DC */
> +static ssize_t show_pwm_mode(struct device *dev, struct device_attribute *attr,
> +			     char *buf)
> +{
> +	return sprintf(buf, "0\n");
> +}
> +
> +/* Temperatures */
> +static ssize_t show_temp(struct device *dev, struct device_attribute *attr,
> +			 char *buf)
> +{
> +	int nr = to_sensor_dev_attr(attr)->index;
> +	struct thmc50_data *data = thmc50_update_device(dev);
> +	return sprintf(buf, "%d\n", data->temp_input[nr] * 1000);
> +}
> +
> +static ssize_t show_temp_min(struct device *dev, struct device_attribute *attr,
> +			     char *buf)
> +{
> +	int nr = to_sensor_dev_attr(attr)->index;
> +	struct thmc50_data *data = thmc50_update_device(dev);
> +	return sprintf(buf, "%d\n", data->temp_min[nr] * 1000);
> +}
> +
> +static ssize_t set_temp_min(struct device *dev, struct device_attribute *attr,
> +			    const char *buf, size_t count)
> +{
> +	int nr = to_sensor_dev_attr(attr)->index;
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct thmc50_data *data = i2c_get_clientdata(client);
> +	int val = simple_strtol(buf, NULL, 10);
> +
> +	mutex_lock(&data->update_lock);
> +	data->temp_min[nr] = SENSORS_LIMIT(val / 1000, -128, 127);
> +	i2c_smbus_write_byte_data(client, THMC50_REG_TEMP_MIN[nr],
> +				  data->temp_min[nr]);
> +	mutex_unlock(&data->update_lock);
> +	return count;
> +}
> +
> +static ssize_t show_temp_max(struct device *dev, struct device_attribute *attr,
> +			     char *buf)
> +{
> +	int nr = to_sensor_dev_attr(attr)->index;
> +	struct thmc50_data *data = thmc50_update_device(dev);
> +	return sprintf(buf, "%d\n", data->temp_max[nr] * 1000);
> +}
> +
> +static ssize_t set_temp_max(struct device *dev, struct device_attribute *attr,
> +			    const char *buf, size_t count)
> +{
> +	int nr = to_sensor_dev_attr(attr)->index;
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct thmc50_data *data = i2c_get_clientdata(client);
> +	int val = simple_strtol(buf, NULL, 10);
> +
> +	mutex_lock(&data->update_lock);
> +	data->temp_max[nr] = SENSORS_LIMIT(val / 1000, -128, 127);
> +	i2c_smbus_write_byte_data(client, THMC50_REG_TEMP_MAX[nr],
> +				  data->temp_max[nr]);
> +	mutex_unlock(&data->update_lock);
> +	return count;
> +}
> +
> +#define temp_reg(offset)						\
> +static SENSOR_DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_temp,	\
> +			NULL, offset - 1);				\
> +static SENSOR_DEVICE_ATTR(temp##offset##_min, S_IRUGO | S_IWUSR,	\
> +			show_temp_min, set_temp_min, offset - 1);	\
> +static SENSOR_DEVICE_ATTR(temp##offset##_max, S_IRUGO | S_IWUSR,	\
> +			show_temp_max, set_temp_max, offset - 1);
> +
> +temp_reg(1);
> +temp_reg(2);
> +temp_reg(3);
> +
> +static SENSOR_DEVICE_ATTR(pwm1, S_IRUGO | S_IWUSR, show_analog_out,
> +			  set_analog_out, 0);
> +static SENSOR_DEVICE_ATTR(pwm1_mode, S_IRUGO, show_pwm_mode, NULL, 0);
> +
> +static struct attribute *thmc50_attributes[] = {
> +	&sensor_dev_attr_temp1_max.dev_attr.attr,
> +	&sensor_dev_attr_temp1_min.dev_attr.attr,
> +	&sensor_dev_attr_temp1_input.dev_attr.attr,
> +	&sensor_dev_attr_temp2_max.dev_attr.attr,
> +	&sensor_dev_attr_temp2_min.dev_attr.attr,
> +	&sensor_dev_attr_temp2_input.dev_attr.attr,
> +	&sensor_dev_attr_pwm1.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_mode.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group thmc50_group = {
> +	.attrs = thmc50_attributes,
> +};
> +
> +/* for ADM1022 3rd temperature mode */
> +static struct attribute *adm1022_attributes[] = {
> +	&sensor_dev_attr_temp3_max.dev_attr.attr,
> +	&sensor_dev_attr_temp3_min.dev_attr.attr,
> +	&sensor_dev_attr_temp3_input.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group adm1022_group = {
> +	.attrs = adm1022_attributes,
> +};
> +
> +static int thmc50_detect(struct i2c_adapter *adapter, int address, int kind)
> +{
> +	unsigned company;
> +	unsigned revision;
> +	unsigned config;
> +	struct i2c_client *client;
> +	struct thmc50_data *data;
> +	struct device *dev;
> +	int err = 0;
> +	const char *type_name = "";
> +
> +	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
> +		pr_debug("thmc50: detect failed, "
> +			 "smbus byte data not supported!\n");
> +		goto exit;
> +	}
> +
> +	/* OK. For now, we presume we have a valid client. We now create the
> +	   client structure, even though we cannot fill it completely yet.
> +	   But it allows us to access thmc50 registers. */
> +	if (!(data = kzalloc(sizeof(struct thmc50_data), GFP_KERNEL))) {
> +		pr_debug("thmc50: detect failed, kzalloc failed!\n");
> +		err = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	client = &data->client;
> +	i2c_set_clientdata(client, data);
> +	client->addr = address;
> +	client->adapter = adapter;
> +	client->driver = &thmc50_driver;
> +	dev = &client->dev;
> +
> +	pr_debug("thmc50: Probing for THMC50 at 0x%2X on bus %d\n",
> +		 client->addr, i2c_adapter_id(client->adapter));
> +
> +	/* Now, we do the remaining detection. */
> +	company = i2c_smbus_read_byte_data(client, THMC50_REG_COMPANY_ID);
> +	revision = i2c_smbus_read_byte_data(client, THMC50_REG_DIE_CODE);
> +	config = i2c_smbus_read_byte_data(client, THMC50_REG_CONF);
> +
> +	if (kind = 0)
> +		kind = thmc50;
> +	else if (kind < 0) {
> +		err = -ENODEV;
> +		if (revision >= 0xc0 && ((config & 0x10) = 0)) {
> +			if (company = 0x49) {
> +				kind = thmc50;
> +				err = 0;
> +			} else if (company = 0x41) {
> +				kind = adm1022;
> +				err = 0;
> +			}
> +		}
> +	}
> +	if (err = -ENODEV) {
> +		pr_debug("thmc50: Detection of THMC50/ADM1022 failed\n");
> +		goto exit_free;
> +	}
> +	pr_debug("thmc50: Detected %s (version %x, revision %x)\n",
> +		 type_name, (revision >> 4) - 0xc, revision & 0xf);
> +	data->type = kind;
> +
> +	if (kind = thmc50)
> +		type_name = "thmc50";
> +	else if (kind = adm1022) {
> +		int id = i2c_adapter_id(client->adapter);
> +		int i;
> +
> +		type_name = "adm1022";
> +		data->has_temp3 = (config >> 7) & 1;	/* config MSB */
> +		for (i = 0; i + 1 < adm1022_temp3_num; i += 2)
> +			if (adm1022_temp3[i] = id &&
> +			    adm1022_temp3[i + 1] = address) {
> +				/* enable 2nd remote temp */
> +				data->has_temp3 = 1;
> +				break;
> +			}
> +	}
> +
> +	/* Fill in the remaining client fields & put it into the global list */
> +	strlcpy(client->name, type_name, I2C_NAME_SIZE);
> +	mutex_init(&data->update_lock);
> +
> +	/* Tell the I2C layer a new client has arrived */
> +	if ((err = i2c_attach_client(client)))
> +		goto exit_free;
> +
> +	thmc50_init_client(client);
> +
> +	/* Register sysfs hooks */
> +	if ((err = sysfs_create_group(&client->dev.kobj, &thmc50_group)))
> +		goto exit_detach;
> +
> +	/* Register ADM1022 sysfs hooks */
> +	if (data->type = adm1022)
> +		if ((err = sysfs_create_group(&client->dev.kobj,
> +					      &adm1022_group)))
> +			goto exit_remove_sysfs_thmc50;
> +
> +	/* Register a new directory entry with module sensors */
> +	data->class_dev = hwmon_device_register(&client->dev);
> +	if (IS_ERR(data->class_dev)) {
> +		err = PTR_ERR(data->class_dev);
> +		goto exit_remove_sysfs;
> +	}
> +
> +	return 0;
> +
> +exit_remove_sysfs:
> +	if (data->type = adm1022)
> +		sysfs_remove_group(&client->dev.kobj, &adm1022_group);
> +exit_remove_sysfs_thmc50:
> +	sysfs_remove_group(&client->dev.kobj, &thmc50_group);
> +exit_detach:
> +	i2c_detach_client(client);
> +exit_free:
> +	kfree(data);
> +exit:
> +	return err;
> +}
> +
> +static int thmc50_attach_adapter(struct i2c_adapter *adapter)
> +{
> +	if (!(adapter->class & I2C_CLASS_HWMON))
> +		return 0;
> +	return i2c_probe(adapter, &addr_data, thmc50_detect);
> +}
> +
> +static int thmc50_detach_client(struct i2c_client *client)
> +{
> +	struct thmc50_data *data = i2c_get_clientdata(client);
> +	int err;
> +
> +	hwmon_device_unregister(data->class_dev);
> +	sysfs_remove_group(&client->dev.kobj, &thmc50_group);
> +	if (data->type = adm1022)
> +		sysfs_remove_group(&client->dev.kobj, &adm1022_group);
> +
> +	if ((err = i2c_detach_client(client)))
> +		return err;
> +
> +	kfree(data);
> +
> +	return 0;
> +}
> +
> +static void thmc50_init_client(struct i2c_client *client)
> +{
> +	struct thmc50_data *data = i2c_get_clientdata(client);
> +	int config;
> +
> +	data->analog_out = i2c_smbus_read_byte_data(client,
> +						    THMC50_REG_ANALOG_OUT);
> +	/* set up to at least 1 */
> +	if (data->analog_out = 0) {
> +		data->analog_out = 1;
> +		i2c_smbus_write_byte_data(client, THMC50_REG_ANALOG_OUT,
> +					  data->analog_out);
> +	}
> +	config = i2c_smbus_read_byte_data(client, THMC50_REG_CONF);
> +	config |= 0x1;	/* start the chip if it is in standby mode */
> +	if (data->has_temp3)
> +		config |= 0x80;		/* enable 2nd remote temp */
> +	i2c_smbus_write_byte_data(client, THMC50_REG_CONF, config);
> +}
> +
> +static struct thmc50_data *thmc50_update_device(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct thmc50_data *data = i2c_get_clientdata(client);
> +	int timeout = HZ / 5 + (data->type = thmc50 ? HZ : 0);
> +
> +	mutex_lock(&data->update_lock);
> +
> +	if (time_after(jiffies, data->last_updated + timeout)
> +	    || !data->valid) {
> +
> +		int temps = data->has_temp3 ? 3 : 2;
> +		int i;
> +		for (i = 0; i < temps; i++) {
> +			data->temp_input[i] = i2c_smbus_read_byte_data(client,
> +						THMC50_REG_TEMP[i]);
> +			data->temp_max[i] = i2c_smbus_read_byte_data(client,
> +						THMC50_REG_TEMP_MAX[i]);
> +			data->temp_min[i] = i2c_smbus_read_byte_data(client,
> +						THMC50_REG_TEMP_MIN[i]);
> +		}
> +		data->analog_out > +		    i2c_smbus_read_byte_data(client, THMC50_REG_ANALOG_OUT);
> +		data->last_updated = jiffies;
> +		data->valid = 1;
> +	}
> +
> +	mutex_unlock(&data->update_lock);
> +
> +	return data;
> +}
> +
> +static int __init sm_thmc50_init(void)
> +{
> +	return i2c_add_driver(&thmc50_driver);
> +}
> +
> +static void __exit sm_thmc50_exit(void)
> +{
> +	i2c_del_driver(&thmc50_driver);
> +}
> +
> +MODULE_AUTHOR("Krzysztof Helt <krzysztof.h1@wp.pl>");
> +MODULE_DESCRIPTION("THMC50 driver");
> +
> +module_init(sm_thmc50_init);
> +module_exit(sm_thmc50_exit);
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
