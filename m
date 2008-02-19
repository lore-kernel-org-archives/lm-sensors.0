From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 19 Feb 2008 11:35:18 +0000
Subject: Re: [lm-sensors] [PATCH] Update: Add driver for AD7414 i2c
Message-Id: <20080219123518.404b39d4@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <A42C17A8FF150C4DB98BFD6497D1D00008096EC6@ussvlexmbpf1.spansion.com>
In-Reply-To: <A42C17A8FF150C4DB98BFD6497D1D00008096EC6@ussvlexmbpf1.spansion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Frank,

On Mon, 18 Feb 2008 23:53:30 -0800, Edelhaeuser, Frank wrote:
> Hi Sean,
>=20
> Thanks for trying, reviewing, commenting on this patch. I made the
> changes you suggested. See updated patch below.
>=20
> ---
> Signed-off-by: Frank Edelhaeuser <frank.edelhaeuser@spansion.com>

Here comes a second review:

> ---
> diff -Nur a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> --- a/drivers/hwmon/Kconfig	2007-11-11 21:49:02.000000000 +0100
> +++ b/drivers/hwmon/Kconfig	2008-02-01 11:54:48.000000000 +0100
> @@ -57,6 +57,16 @@
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called abituguru3.
>=20
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
> diff -Nur a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> --- a/drivers/hwmon/Makefile	2007-11-11 21:49:02.000000000 +0100
> +++ b/drivers/hwmon/Makefile	2008-02-01 11:54:48.000000000 +0100
> @@ -15,6 +15,7 @@
>=20
>  obj-$(CONFIG_SENSORS_ABITUGURU)	+=3D abituguru.o
>  obj-$(CONFIG_SENSORS_ABITUGURU3)+=3D abituguru3.o
> +obj-$(CONFIG_SENSORS_AD7414)	+=3D ad7414.o
>  obj-$(CONFIG_SENSORS_AD7418)	+=3D ad7418.o
>  obj-$(CONFIG_SENSORS_ADM1021)	+=3D adm1021.o
>  obj-$(CONFIG_SENSORS_ADM1025)	+=3D adm1025.o
> @@ -66,4 +67,3 @@
>  ifeq ($(CONFIG_HWMON_DEBUG_CHIP),y)
>  EXTRA_CFLAGS +=3D -DDEBUG
>  endif
> -
> diff -Nur a/drivers/hwmon/ad7414.c b/drivers/hwmon/ad7414.c
> --- a/drivers/hwmon/ad7414.c	1970-01-01 01:00:00.000000000 +0100
> +++ b/drivers/hwmon/ad7414.c	2008-02-19 08:20:27.000000000 +0100
> @@ -0,0 +1,258 @@
> +/*
> + * An hwmon driver for the Analog Devices AD7414
> + *
> + * Copyright 2006 Stefan Roese <sr at denx.de>, DENX Software
> Engineering

As Sean already reported, your e-mail client is wrapping long lines,
corrupting your patch so I can't apply it. Please address the problem
and resubmit. If you can't get inline patches to work, use a text
attachment.

> + *
> + * Copyright (c) 2008 PIKA Technologies
> + *   Sean MacLennan <smaclennan at pikatech.com>
> + *
> + * Copyright (c) 2008 Spansion Inc.
> + *   Frank Edelhaeuser <frank.edelhaeuser at spansion.com>
> + *   (converted to "new style" I2C driver model, removed checkpatch.pl
> warnings)
> + *
> + * Based on ad7418.c
> + * Copyright 2006 Tower Technologies, Alessandro Zummo <a.zummo at
> towertech.it>
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
> +#include <linux/err.h>
> +#include <linux/mutex.h>
> +#include <linux/delay.h>

May I ask what you need <linux/delay.h> for?

> +
> +
> +#define DRV_VERSION "0.3"
> +
> +/* straight from the datasheet */
> +#define AD7414_TEMP_MIN (-55000)

The datasheet actually says -40=B0C.

> +#define AD7414_TEMP_MAX 125000
> +
> +/* AD7414 registers */
> +#define AD7414_REG_TEMP		0x00
> +#define AD7414_REG_CONF		0x01
> +#define AD7414_REG_T_HIGH	0x02
> +#define AD7414_REG_T_LOW	0x03
> +
> +
> +struct ad7414_data {
> +	struct i2c_client	client;

You don't actually use this anywhere (which is expected for a new-style
i2c driver.)

> +	struct device	*dev;

Other drivers name it hwmon_dev, and I suggest that you do the same to
avoid confusion.

> +
> +	/* atomic read data updates */
> +	struct mutex	lock;
> +	/* !=3D0 if following fields are valid */
> +	char			valid;
> +	/* In jiffies */
> +	unsigned long	last_updated;

Alignments are a bit jerky.

> +	/* Register values */
> +	u16			temp_input;
> +	u8			temp_max;
> +	u8			temp_min;

Temperature values can be negative, so these should be s16 and s8
respectively.

> +	u8			temp_alert;
> +	u8			temp_max_flag;
> +	u8			temp_min_flag;
> +};
> +
> +/*
> + * TEMP: 0.001C/bit (-55C to +125C)
> + * REG: (0.5C/bit, two's complement) << 7

The datasheet actually says that the temperature is a 10-bit value,
i.e. it has a 0.25=B0C resolution. That would be reg / 64 * 250.

> + */
> +static inline int AD7414_TEMP_FROM_REG(u16 reg)
> +{
> +	/* use integer division instead of equivalent right shift to
> +	 * guarantee arithmetic shift and preserve the sign
> +	 */
> +	return ((s16)reg / 128) * 500;
> +}
> +
> +/* All registers are word-sized, except for the configuration
> registers.
> + * AD7414 uses a high-byte first convention, which is exactly opposite
> to
> + * the usual practice.
> + */

I guess that you copied this comment from another driver, but it's not
correct. High-byte first is actually the usual practice, but it is
opposite to the SMBus standard.

On top of that, the code below doesn't really match the comment above:
It looks like all registers are _byte-sized_ and only the current
temperature register is word-sized.

> +static int ad7414_read(struct i2c_client *client, u8 reg)
> +{
> +	if (reg =3D AD7414_REG_TEMP)
> +		return swab16(i2c_smbus_read_word_data(client, reg));
> +	else
> +		return i2c_smbus_read_byte_data(client, reg);
> +}
> +
> +static int ad7414_write(struct i2c_client *client, u8 reg, u16 value)
> +{
> +	return i2c_smbus_write_byte_data(client, reg, value);
> +}

You can probably inline both functions above for a smaller and faster
driver.

> +
> +static struct ad7414_data *ad7414_update_device(struct device *dev)
> +{
> +	struct i2c_client *client =3D to_i2c_client(dev);
> +	struct ad7414_data *data =3D i2c_get_clientdata(client);
> +
> +	mutex_lock(&data->lock);
> +
> +	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
> +		|| !data->valid) {
> +		dev_dbg(&client->dev, "starting ad7414 update\n");
> +
> +		data->temp_input =3D ad7414_read(client, AD7414_REG_TEMP);
> +		data->temp_alert =3D (data->temp_input >> 5) & 0x01;
> +		data->temp_max_flag =3D (data->temp_input >> 4) & 0x01;
> +		data->temp_min_flag =3D (data->temp_input >> 3) & 0x01;

This is wasting memory in struct ad7414_data. You could instead extract
the right bit in the sysfs callbacks. This would even let you use a
single callback for all 3 flags. See this example from the lm92 driver:

static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
			  char *buf)
{
	int bitnr =3D to_sensor_dev_attr(attr)->index;
	struct lm92_data *data =3D lm92_update_device(dev);
	return sprintf(buf, "%d\n", (data->temp1_input >> bitnr) & 1);
}

static SENSOR_DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_alarm, NULL, 2);
static SENSOR_DEVICE_ATTR(temp1_min_alarm, S_IRUGO, show_alarm, NULL, 0);
static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_alarm, NULL, 1);

> +		data->temp_max =3D ad7414_read(client, AD7414_REG_T_HIGH);
> +		data->temp_min =3D ad7414_read(client, AD7414_REG_T_LOW);
> +
> +		data->last_updated =3D jiffies;
> +		data->valid =3D 1;
> +	}
> +
> +	mutex_unlock(&data->lock);
> +
> +	return data;
> +}
> +
> +#define show(value) \
> +static ssize_t show_##value(struct device *dev, \
> +	struct device_attribute *attr, char *buf)		\
> +{
> \
> +	struct ad7414_data *data =3D ad7414_update_device(dev);
> \
> +	return sprintf(buf, "%d\n", AD7414_TEMP_FROM_REG(data->value));
> \
> +}
> +show(temp_input);
> +
> +#define show_8(value)	\
> +static ssize_t show_##value(struct device *dev, \
> +	struct device_attribute *attr, char *buf)		\
> +{								\
> +	struct ad7414_data *data =3D ad7414_update_device(dev);	\
> +	return sprintf(buf, "%d\n", data->value);		\
> +}
> +show_8(temp_max);
> +show_8(temp_min);
> +show_8(temp_alert);
> +show_8(temp_max_flag);
> +show_8(temp_min_flag);
> +
> +#define set(value, reg)	\
> +static ssize_t set_##value(struct device *dev, \
> +	struct device_attribute *attr, \
> +	const char *buf, size_t count)	\
> +{								\
> +	struct i2c_client *client =3D to_i2c_client(dev);		\
> +	struct ad7414_data *data =3D i2c_get_clientdata(client);	\
> +	int temp =3D simple_strtoul(buf, NULL, 10);		\

simple_strtoul won't let you set negative limits, you should use
simple_strtol instead. And temp should be a long not int.

> +								\
> +	mutex_lock(&data->lock);				\
> +	data->value =3D temp;					\
> +	ad7414_write(client, reg, data->value);			\
> +	mutex_unlock(&data->lock);				\
> +	return count;						\
> +}
> +set(temp_max, AD7414_REG_T_HIGH);
> +set(temp_min, AD7414_REG_T_LOW);
> +
> +static DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_max,
> set_temp_max);
> +static DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO, show_temp_min,
> set_temp_min);
> +static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_input, NULL);
> +static DEVICE_ATTR(temp1_alert, S_IRUGO, show_temp_alert, NULL);

The behavior of temp1_alert is pretty confusing... If I read the
datasheet properly, it acts as if temp1_min was an hysteresis limit for
temp1_max (while the temp1_min flag really behaves as if temp1_min was
a low temperature limit.) I guess that this makes the AD7414 chip a
polyvalent device, but from the driver's point of view this is really
confusing.

I think that the platform code should provide private data to specify
which behavior it wants. Based on that, the driver would create either
temp1_min and temp1_min_alarm (ignoring the alert flag), or
temp1_max_hyst (ignoring the T_high and T_low flags). For now, you can
just implement the mode you need for yourself.

> +static DEVICE_ATTR(temp1_max_flag, S_IRUGO, show_temp_max_flag, NULL);
> +static DEVICE_ATTR(temp1_min_flag, S_IRUGO, show_temp_min_flag, NULL);

These should be temp1_max_alarm and temp1_min_alarm, respectively, to
comply with Documentation/hwmon/sysfs-interface.

> +
> +
> +static struct attribute *ad7414_attributes[] =3D {
> +	&dev_attr_temp1_input.attr,
> +	&dev_attr_temp1_max.attr,
> +	&dev_attr_temp1_min.attr,
> +	&dev_attr_temp1_alert.attr,
> +	&dev_attr_temp1_max_flag.attr,
> +	&dev_attr_temp1_min_flag.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group ad7414_group =3D {
> +	.attrs =3D ad7414_attributes,
> +};
> +
> +static int ad7414_probe(struct i2c_client *client)
> +{
> +	struct ad7414_data *data;
> +	int err =3D 0;
> +
> +	if (!i2c_check_functionality(client->adapter,
> I2C_FUNC_SMBUS_BYTE_DATA |
> +					I2C_FUNC_SMBUS_WORD_DATA))

The driver doesn't need I2C_FUNC_SMBUS_WORD_DATA but only
I2C_FUNC_SMBUS_READ_WORD_DATA (it never writes to 16-bit registers.)

> +		goto exit;
> +
> +	data =3D kzalloc(sizeof(struct ad7414_data), GFP_KERNEL);
> +	if (!data) {
> +		err =3D -ENOMEM;
> +		goto exit;
> +	}
> +
> +	i2c_set_clientdata(client, data);
> +	mutex_init(&data->lock);
> +
> +	dev_info(&client->dev, "chip found, driver version " DRV_VERSION
> "\n");

It could be convenient to mention that an AD7414 chip was found. Your
driver could be extended later to support more devices (e.g. the
compatible AD7415).

> +
> +	/* Register sysfs hooks */
> +	err =3D sysfs_create_group(&client->dev.kobj, &ad7414_group);
> +	if (err)
> +		goto exit_free;
> +
> +	data->dev =3D hwmon_device_register(&client->dev);
> +	if (IS_ERR(data->dev)) {
> +		err =3D PTR_ERR(data->dev);
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
> +	struct ad7414_data *data =3D i2c_get_clientdata(client);
> +
> +	hwmon_device_unregister(data->dev);
> +	sysfs_remove_group(&client->dev.kobj, &ad7414_group);
> +	kfree(data);
> +	return 0;
> +}
> +
> +static struct i2c_driver ad7414_driver =3D {
> +	.driver =3D {
> +		.name	=3D "ad7414",
> +	},
> +	.probe	=3D ad7414_probe,
> +	.remove	=3D __devexit_p(ad7414_remove),
> +};
> +
> +static int __init ad7414_init(void)
> +{
> +	return i2c_add_driver(&ad7414_driver);
> +}
> +
> +static void __exit ad7414_exit(void)
> +{
> +	i2c_del_driver(&ad7414_driver);
> +}
> +
> +MODULE_AUTHOR("Stefan Roese <sr at denx.de>, "
> +		"Frank Edelhaeuser <frank.edelhaeuser@spansion.com>");
> +
> +MODULE_DESCRIPTION("AD7414 driver");
> +MODULE_LICENSE("GPL");
> +MODULE_VERSION(DRV_VERSION);
> +
> +module_init(ad7414_init);
> +module_exit(ad7414_exit);


--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
