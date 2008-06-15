From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 15 Jun 2008 21:11:13 +0000
Subject: Re: [lm-sensors] [PATCH] ad7414 driver
Message-Id: <20080615231113.12902af4@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080613221221.50c642ee@lappy.seanm.ca>
In-Reply-To: <20080613221221.50c642ee@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Sean,

On Sun, 15 Jun 2008 13:13:31 -0400, Sean MacLennan wrote:
> On Sun, 15 Jun 2008 10:09:25 +0200
> Jean Delvare <khali@linux-fr.org> wrote:
> 
> > I'm a bit confused now... This version of the driver doesn't look as
> > good as the one you submitted on April 30th:
> > http://lists.lm-sensors.org/pipermail/lm-sensors/2008-April/022999.html
> 
> YIKES! I forgot to put that version back in PIKA's mainline kernel tree.
> 
> This should be the *correct* version, with the id table patch.
> 
> Cheers,
>    Sean

Review:

> 
> Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 00ff533..3c21d57 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -57,6 +57,16 @@ config SENSORS_ABITUGURU3
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called abituguru3.
>  
> +config SENSORS_AD7414
> +	tristate "Analog Devices AD7414"
> +	depends on I2C && EXPERIMENTAL
> +	help
> +	  If you say yes here you get support for the Analog Devices
> +	  AD7414 temperature monitoring chip.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called ad7414.
> +
>  config SENSORS_AD7418
>  	tristate "Analog Devices AD7416, AD7417 and AD7418"
>  	depends on I2C && EXPERIMENTAL
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index d098677..7943e5c 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_SENSORS_W83791D)	+= w83791d.o
>  
>  obj-$(CONFIG_SENSORS_ABITUGURU)	+= abituguru.o
>  obj-$(CONFIG_SENSORS_ABITUGURU3)+= abituguru3.o
> +obj-$(CONFIG_SENSORS_AD7414)	+= ad7414.o
>  obj-$(CONFIG_SENSORS_AD7418)	+= ad7418.o
>  obj-$(CONFIG_SENSORS_ADM1021)	+= adm1021.o
>  obj-$(CONFIG_SENSORS_ADM1025)	+= adm1025.o
> diff --git a/drivers/hwmon/ad7414.c b/drivers/hwmon/ad7414.c
> new file mode 100644
> index 0000000..5408b04
> --- /dev/null
> +++ b/drivers/hwmon/ad7414.c
> @@ -0,0 +1,251 @@
> +/*
> + * An hwmon driver for the Analog Devices AD7414
> + *
> + * Copyright 2006 Stefan Roese <sr at denx.de>, DENX Software Engineering
> + *
> + * Copyright (c) 2008 PIKA Technologies
> + *   Sean MacLennan <smaclennan@pikatech.com>
> + *
> + * Copyright (c) 2008 Spansion Inc.
> + *   Frank Edelhaeuser <frank.edelhaeuser at spansion.com>
> + *   (converted to "new style" I2C driver model, removed checkpatch.pl warnings)
> + *
> + * Based on ad7418.c
> + * Copyright 2006 Tower Technologies, Alessandro Zummo <a.zummo at towertech.it>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/jiffies.h>
> +#include <linux/i2c.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/err.h>
> +#include <linux/mutex.h>

You should also include <linux/sysfs.h> (for sysfs_create_group).

> +
> +
> +#define DRV_VERSION "0.3"

Once a driver is merged in the kernel, having a version isn't terribly
useful. My experience is that nobody will remember updating it when
doing changes to the driver, so the kernel version is always more
reliable than the driver version.

> +
> +/* AD7414 registers */
> +#define AD7414_REG_TEMP		0x00
> +#define AD7414_REG_CONF		0x01

You never access the configuration register. The driver apparently
assumes that the chip is in continuous conversion mode, so it would
probably be a good idea to ensure that it really is, and switch it on
if not.

> +#define AD7414_REG_T_HIGH	0x02
> +#define AD7414_REG_T_LOW	0x03
> +
> +
> +struct ad7414_data {
> +	struct device		*hwmon_dev;
> +	struct mutex		lock;	/* atomic read data updates */
> +	char			valid;	/* !=0 if following fields are valid */
> +	unsigned long		next_update;	/* In jiffies */
> +	s16			temp_input;	/* Register values */
> +	s8			temp_max;
> +	s8			temp_min;
> +};
> +
> +/* REG: (0.25C/bit, two's complement) << 6 */
> +static inline int AD7414_TEMP_FROM_REG(u16 reg)

reg should be s16. I also suggest using lower-case for the function
name.

> +{
> +	/* use integer division instead of equivalent right shift to
> +	 * guarantee arithmetic shift and preserve the sign
> +	 */
> +	return ((s64)reg / 64) * 250;

This cast to s64 is a bad idea. 64-bit integers are costly on on 32-bit
machines. Casting to an int would be enough.

> +}
> +
> +static inline int ad7414_read(struct i2c_client *client, u8 reg)
> +{
> +	if (reg = AD7414_REG_TEMP)
> +		return swab16(i2c_smbus_read_word_data(client, reg));

This will return random values if i2c_smbus_read_word_data returns an
error. The lm75 driver has just been fixed:
http://lists.lm-sensors.org/pipermail/lm-sensors/2008-May/023040.html
You could do something similar.

> +	else
> +		return i2c_smbus_read_byte_data(client, reg);
> +}
> +
> +static inline int ad7414_write(struct i2c_client *client, u8 reg, u16 value)

value could be u8, as you only ever write 8-bit values.

> +{
> +	return i2c_smbus_write_byte_data(client, reg, value);
> +}
> +
> +struct ad7414_data *ad7414_update_device(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct ad7414_data *data = i2c_get_clientdata(client);
> +
> +	mutex_lock(&data->lock);
> +
> +	if (time_after(jiffies, data->next_update) || !data->valid) {
> +		dev_dbg(&client->dev, "starting ad7414 update\n");
> +
> +		data->temp_input = ad7414_read(client, AD7414_REG_TEMP);
> +		data->temp_max = ad7414_read(client, AD7414_REG_T_HIGH);
> +		data->temp_min = ad7414_read(client, AD7414_REG_T_LOW);
> +
> +		data->next_update = jiffies + HZ + HZ / 2;
> +		data->valid = 1;
> +	}
> +
> +	mutex_unlock(&data->lock);
> +
> +	return data;
> +}
> +
> +static ssize_t show_temp_input(struct device *dev,
> +			       struct device_attribute *attr, char *buf)
> +{
> +	struct ad7414_data *data = ad7414_update_device(dev);
> +	return sprintf(buf, "%d\n", AD7414_TEMP_FROM_REG(data->temp_input));
> +}
> +
> +#define show_8(value)	\
> +static ssize_t show_##value(struct device *dev, \
> +	struct device_attribute *attr, char *buf)		\
> +{								\
> +	struct ad7414_data *data = ad7414_update_device(dev);	\
> +	return sprintf(buf, "%d\n", data->value);		\

You are supposed to multiply the value by 1000! Was this driver never
tested with libsensors?

> +}
> +show_8(temp_max);
> +show_8(temp_min);
> +
> +#define set(value, reg)	\
> +static ssize_t set_##value(struct device *dev, \
> +	struct device_attribute *attr, \
> +	const char *buf, size_t count)	\
> +{								\
> +	struct i2c_client *client = to_i2c_client(dev);		\
> +	struct ad7414_data *data = i2c_get_clientdata(client);	\
> +	long temp = simple_strtol(buf, NULL, 10);		\
> +								\
> +	mutex_lock(&data->lock);				\
> +	data->value = temp;					\

This lacks conversion and boundary checking! Obviously writing to these
files was never tested :( For one thing you need to divide the input
value by 1000, and for another one you must clamp the values that don't
fit in the register (or that are below or above what the chip can
measure.)

> +	ad7414_write(client, reg, data->value);			\
> +	mutex_unlock(&data->lock);				\
> +	return count;						\
> +}
> +set(temp_max, AD7414_REG_T_HIGH);
> +set(temp_min, AD7414_REG_T_LOW);

Would be nice to use "dynamic" callbacks (as you do below for alarms)
instead of macro-generated ones. All you'd have to do is put the min
and max temperatures in an array (see the lm90 driver for an example.)
This would make a smaller and more readable driver.

> +
> +static DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_max, set_temp_max);
> +static DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO, show_temp_min, set_temp_min);
> +static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_input, NULL);
> +
> +static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
> +			  char *buf)
> +{
> +	int bitnr = to_sensor_dev_attr(attr)->index;
> +	struct ad7414_data *data = ad7414_update_device(dev);
> +	int value = (data->temp_input >> bitnr) & 1;
> +
> +	/* alert is active low */
> +	if (bitnr = 5)
> +		value ^= 1;

Alert is in fact active high or low depending on a bit in the
configuration file. You have to check it.

> +
> +
> +	return sprintf(buf, "%d\n", value);
> +}
> +
> +static SENSOR_DEVICE_ATTR(temp1_min_alarm, S_IRUGO, show_alarm, NULL, 3);
> +static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_alarm, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp1_alert, S_IRUGO, show_alarm, NULL, 5);

As explained before, temp1_alert is not a standard sysfs file name so
libsensors won't pick it. Also, this bit seems to trigger when the high
alarm flag triggers, so it's somewhat redundant. The only difference if
I read the datasheet correctly is that the high alarm flag clears
itself automatically while the alert flag does not. As the driver never
clears it, it doesn't seem very useful to me.

> +
> +
> +static struct attribute *ad7414_attributes[] = {
> +	&dev_attr_temp1_input.attr,
> +	&dev_attr_temp1_max.attr,
> +	&dev_attr_temp1_min.attr,
> +	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
> +	&sensor_dev_attr_temp1_min_alarm.dev_attr.attr,
> +	&sensor_dev_attr_temp1_alert.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group ad7414_group = {
> +	.attrs = ad7414_attributes,
> +};
> +
> +static int ad7414_probe(struct i2c_client *client,
> +			const struct i2c_device_id *dev_id)
> +{
> +	struct ad7414_data *data;
> +	int err = 0;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA |
> +				     I2C_FUNC_SMBUS_READ_WORD_DATA))
> +		goto exit;
> +
> +	data = kzalloc(sizeof(struct ad7414_data), GFP_KERNEL);
> +	if (!data) {
> +		err = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	i2c_set_clientdata(client, data);
> +	mutex_init(&data->lock);
> +
> +	dev_info(&client->dev, "chip found, driver version " DRV_VERSION "\n");
> +
> +	/* Register sysfs hooks */
> +	err = sysfs_create_group(&client->dev.kobj, &ad7414_group);
> +	if (err)
> +		goto exit_free;
> +
> +	data->hwmon_dev = hwmon_device_register(&client->dev);
> +	if (IS_ERR(data->hwmon_dev)) {
> +		err = PTR_ERR(data->hwmon_dev);
> +		goto exit_remove;
> +	}
> +
> +	return 0;
> +
> +exit_remove:
> +	sysfs_remove_group(&client->dev.kobj, &ad7414_group);
> +exit_free:
> +	kfree(data);
> +exit:
> +	return err;
> +}
> +
> +static int __devexit ad7414_remove(struct i2c_client *client)
> +{
> +	struct ad7414_data *data = i2c_get_clientdata(client);
> +
> +	hwmon_device_unregister(data->hwmon_dev);
> +	sysfs_remove_group(&client->dev.kobj, &ad7414_group);
> +	kfree(data);
> +	return 0;
> +}
> +
> +static const struct i2c_device_id ad7414_id[] = {
> +	{ "ad7414", 0 },
> +	{}
> +};
> +
> +static struct i2c_driver ad7414_driver = {
> +	.driver = {
> +		.name	= "ad7414",
> +	},
> +	.probe	= ad7414_probe,
> +	.remove	= __devexit_p(ad7414_remove),
> +	.id_table = ad7414_id,
> +};
> +
> +static int __init ad7414_init(void)
> +{
> +	return i2c_add_driver(&ad7414_driver);
> +}
> +module_init(ad7414_init);
> +
> +static void __exit ad7414_exit(void)
> +{
> +	i2c_del_driver(&ad7414_driver);
> +}
> +module_exit(ad7414_exit);
> +
> +MODULE_AUTHOR("Stefan Roese <sr at denx.de>, "
> +	      "Frank Edelhaeuser <frank.edelhaeuser at spansion.com>");
> +
> +MODULE_DESCRIPTION("AD7414 driver");
> +MODULE_LICENSE("GPL");
> +MODULE_VERSION(DRV_VERSION);


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
