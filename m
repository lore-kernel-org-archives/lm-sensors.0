From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 07 Jul 2008 11:03:07 +0000
Subject: Re: [lm-sensors] [PATCH] max664x: New driver for Maxim
Message-Id: <20080707130307.2320b669@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080609111352.GC11300@solarflare.com>
In-Reply-To: <20080609111352.GC11300@solarflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ben,

On Mon, 9 Jun 2008 12:13:53 +0100, Ben Hutchings wrote:
> 
> Signed-off-by: Ben Hutchings <bhutchings@solarflare.com>
> ---
>  drivers/hwmon/Kconfig   |   10 ++
>  drivers/hwmon/Makefile  |    1 +
>  drivers/hwmon/max664x.c |  355 +++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/max664x.h |   92 ++++++++++++
>  4 files changed, 458 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/hwmon/max664x.c
>  create mode 100644 include/linux/max664x.h

First of all: please rename the driver to max6646. We don't use "x" in
hwmon driver names, because this tends to get confusing: your driver
doesn't support the MAX6640, MAX6641, etc. chips while the max664x
"mask" suggests it would. So the rule is to pick the name of the first
supported chip as the driver name.

Second preliminary note: these chips look suspiciously similar to the
LM90, ADM1032 and MAX6657 chips which are supported by the lm90 driver.
Are you certain that you need a new driver for them? I've still
reviewed your driver, but my feeling is that it may be less work for
you to add support for the new chips to the lm90 driver, than to fix
your new driver. As far as I can see the only significant difference is
the encoding of the temperatures (signed vs. unsigned), and support for
that kind of difference has been added to the lm90 driver a few weeks
ago. You can look at my pending lm90 patches here:
  http://jdelvare.pck.nerim.net/sensors/lm90/
I also have parallel work to support new-style i2c devices with this
driver (same as for the lm87 driver, this will be merged in 2.6.27-rc1):
  http://khali.linux-fr.org/devel/linux-2.6/jdelvare-i2c/hwmon-lm90-convert-to-new-style.patch

Can you please also send me a dump of one of these chips? I keep a
collection of hwmon chip dumps, it helps me when reviewing a driver or
testing changes I make to the driver later on. You can take a dump of
the chip using the i2c-dev driver and the i2cdump user-space tool, part
of the i2c-tools package.

> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 00ff533..fad29c0 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -512,6 +512,16 @@ config SENSORS_MAX1619
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called max1619.
>  
> +config SENSORS_MAX664X
> +	tristate "Maxim MAX6646/6647/6649 sensor chips"
> +	depends on I2C
> +	help
> +	  If you say yes here you get support for MAX6646/6647/6649

Please spell out MAX6647 and MAX6649 in full in the help text. This
makes it possible for users to search for part names while configuring
their kernel.

> +	  sensor chips.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called max664x.
> +
>  config SENSORS_MAX6650
>  	tristate "Maxim MAX6650 sensor chip"
>  	depends on I2C && EXPERIMENTAL
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index d098677..24b907e 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -58,6 +58,7 @@ obj-$(CONFIG_SENSORS_LM90)	+= lm90.o
>  obj-$(CONFIG_SENSORS_LM92)	+= lm92.o
>  obj-$(CONFIG_SENSORS_LM93)	+= lm93.o
>  obj-$(CONFIG_SENSORS_MAX1619)	+= max1619.o
> +obj-$(CONFIG_SENSORS_MAX664X)	+= max664x.o
>  obj-$(CONFIG_SENSORS_MAX6650)	+= max6650.o
>  obj-$(CONFIG_SENSORS_PC87360)	+= pc87360.o
>  obj-$(CONFIG_SENSORS_PC87427)	+= pc87427.o
> diff --git a/drivers/hwmon/max664x.c b/drivers/hwmon/max664x.c
> new file mode 100644
> index 0000000..c5cd365
> --- /dev/null
> +++ b/drivers/hwmon/max664x.c
> @@ -0,0 +1,355 @@
> +/****************************************************************************
> + * Driver for Maxim MAX6646/6647/6649 sensor chips
> + * Copyright 2008 Solarflare Communications Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published
> + * by the Free Software Foundation, incorporated herein by reference.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/err.h>
> +#include <linux/jiffies.h>
> +#include <linux/i2c.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/max664x.h>

I don't think we want hardware-specific header files to go directly in
include/linux. There could virtually be 45 such header files in the
future, that would be a big mess. It's probably time to create
include/linux/hwmon or even include/hwmon? I don't know what others
think?

> +
> +/* Data sheet: <http://datasheets.maxim-ic.com/en/ds/MAX6646-MAX6649.pdf> */
> +
> +#define MAX664X_REG_RLTS	0x00
> +#define MAX664X_REG_RRTE	0x01
> +#define MAX664X_REG_RSL		0x02
> +#define MAX664X_REG_RCL		0x03
> +#define MAX664X_REG_RCRA	0x04
> +#define MAX664X_REG_RLHN	0x05
> +#define MAX664X_REG_RLLI	0x06
> +#define MAX664X_REG_RRHI	0x07
> +#define MAX664X_REG_RRLS	0x08
> +#define MAX664X_REG_WCA		0x09
> +#define MAX664X_REG_WCRW	0x0a
> +#define MAX664X_REG_WLHO	0x0b
> +#define MAX664X_REG_WLLM	0x0c
> +#define MAX664X_REG_WRHA	0x0d
> +#define MAX664X_REG_WRLN	0x0e
> +#define MAX664X_REG_OSHT	0x0f
> +#define	MAX664X_REG_REET	0x10
> +#define	MAX664X_REG_RIET	0x11
> +#define	MAX664X_REG_RWOE	0x19
> +#define	MAX664X_REG_RWOI	0x20
> +#define	MAX664X_REG_HYS		0x21
> +#define	MAX664X_REG_QUEUE	0x22
> +#define	MAX664X_REG_MFID	0xfe
> +#define	MAX664X_REG_REVID	0xff

You apparently used tabs instead of spaces for the last 8 defines.

Also, it looks like many of these defines aren't used in your driver.

> +
> +struct max664x_data {
> +	struct device *hwmon_dev;
> +	struct mutex update_lock;
> +	int valid;
> +	unsigned long last_updated; /* in jiffies */
> +	struct max664x_settings set;
> +	struct max664x_values val;
> +};
> +
> +#define TEMP_FROM_REG(val) ((val) * 1000)
> +#define TEMP_TO_REG(val) ((val) / 1000)

This lacks proper rounding.

> +#define PERIOD_FROM_RATE_REG(val) (16000 >> min_t(int, val, 6))
> +#define PERIOD_TO_RATE_REG(val) SENSORS_LIMIT(7 - ffs(val / 250), 0, 6)

Note that in general we try to move away from macros. Using (possibly
inline) functions for these conversions is preferred, as it is more
readable and lets the compiler do type checks. And less error-prone:
your macros lack some parentheses.

> +
> +static struct max664x_data *max664x_update_device(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct max664x_data *data = i2c_get_clientdata(client);
> +
> +	mutex_lock(&data->update_lock);
> +
> +	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
> +		data->set.rate > +			i2c_smbus_read_byte_data(client, MAX664X_REG_RCRA);
> +		data->val.temp[0] > +			i2c_smbus_read_byte_data(client, MAX664X_REG_RLTS);
> +		data->set.temp_overt[0] > +			i2c_smbus_read_byte_data(client, MAX664X_REG_RWOI);
> +		data->set.temp_high_alert[0] > +			i2c_smbus_read_byte_data(client, MAX664X_REG_RLHN);
> +		data->set.temp_low_alert[0] > +			i2c_smbus_read_byte_data(client, MAX664X_REG_RLLI);
> +		data->val.temp[1] > +			i2c_smbus_read_byte_data(client, MAX664X_REG_RRTE);
> +		data->set.temp_overt[1] > +			i2c_smbus_read_byte_data(client, MAX664X_REG_RWOE);
> +		data->set.temp_high_alert[1] > +			i2c_smbus_read_byte_data(client, MAX664X_REG_RRHI);
> +		data->set.temp_low_alert[1] > +			i2c_smbus_read_byte_data(client, MAX664X_REG_RRLS);
> +		data->set.temp_overt_hyst > +			i2c_smbus_read_byte_data(client, MAX664X_REG_HYS);
> +
> +		data->last_updated = jiffies;
> +		data->valid = 1;
> +	}
> +
> +	mutex_unlock(&data->update_lock);
> +
> +	return data;
> +}
> +
> +struct max664x_values *max664x_update_values(struct i2c_client *client)
> +{
> +	struct max664x_data *data = max664x_update_device(&client->dev);
> +	return &data->val;
> +}
> +EXPORT_SYMBOL(max664x_update_values);

This should rather be named max6646_get_values. "Update" makes sense in
the driver because we know we are caching the values and "update"
refers to the cache, but from the user's perspective, all the function
does is reading register values.

> +
> +static void
> +set_temp_limit(struct device *dev, const char *buf, int offset, int reg)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct max664x_data *data = i2c_get_clientdata(client);
> +	long val = simple_strtol(buf, NULL, 10);
> +	u8 reg_val = TEMP_TO_REG(val);
> +
> +	mutex_lock(&data->update_lock);
> +	((u8 *)&data->set)[offset] = reg_val;
> +	i2c_smbus_write_byte_data(client, reg, reg_val);
> +	mutex_unlock(&data->update_lock);
> +}
> +
> +#define TEMP_LIMIT_ATTR(offset, limit, array_name, reg_name)		\
> +	static ssize_t							\
> +	show_temp##offset##_##limit(struct device *dev,			\
> +				    struct device_attribute *attr, char *buf) \
> +	{								\
> +		struct max664x_data *data = max664x_update_device(dev); \
> +		return sprintf(buf, "%u\n",				\
> +			       TEMP_FROM_REG(data->set.array_name[offset - 1])); \
> +	}								\
> +	static ssize_t							\
> +	set_temp##offset##_##limit(struct device *dev,			\
> +				   struct device_attribute *attr,	\
> +				   const char *buf, size_t count)	\
> +	{								\
> +		set_temp_limit(dev, buf,				\
> +			       offsetof(struct max664x_settings,	\
> +					array_name[offset - 1]),	\
> +			       MAX664X_REG_##reg_name);			\
> +		return count;						\
> +	}								\
> +	static DEVICE_ATTR(temp##offset##_##limit, S_IRUGO | S_IWUSR,	\
> +			   show_temp##offset##_##limit,			\
> +			   set_temp##offset##_##limit);

Argh, no, please, not these macro-generated functions again :( It has
been a lot of work to get rid of almost all the these ugly constructs
in the hwmon drivers, let's not reintroduce them in new drivers.

Please make use of SENSOR_DEVICE_ATTR() and to_sensor_dev_attr(attr) to
pass private data from sysfs attributes to their callbacks. The adm1025
driver is one of many drivers doing this properly if you want to get an
idea how this works. This will let you get rid of all macro-generated
functions, which is very desirable for code readability, code
maintainability, compilation time and binary size.

> +
> +static ssize_t show_temp_crit_hyst(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct max664x_data *data = max664x_update_device(dev);
> +	return sprintf(buf, "%u\n", TEMP_FROM_REG(data->set.temp_overt_hyst));
> +}
> +
> +static ssize_t
> +set_temp_crit_hyst(struct device *dev, struct device_attribute *attr,
> +		   const char *buf, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct max664x_data *data = i2c_get_clientdata(client);
> +	long val = simple_strtol(buf, NULL, 10);
> +	u8 reg_val = TEMP_TO_REG(val);
> +
> +	mutex_lock(&data->update_lock);
> +	data->set.temp_overt_hyst = reg_val;
> +	i2c_smbus_write_byte_data(client, MAX664X_REG_HYS, reg_val);
> +	mutex_unlock(&data->update_lock);
> +	return count;
> +}

This violates the standard. All temperature values in sysfs should be
absolute, not relative.

> +
> +#define TEMP_ATTRS(offset, overt_reg, high_alert_reg, low_alert_reg)	\
> +	static ssize_t							\
> +	show_temp##offset##_input(struct device *dev,			\
> +				  struct device_attribute *attr, char *buf) \
> +	{								\
> +		struct max664x_data *data = max664x_update_device(dev);	\
> +		return sprintf(buf, "%u\n",				\
> +			       TEMP_FROM_REG(data->val.temp[offset - 1])); \
> +	}								\
> +	static DEVICE_ATTR(temp##offset##_input, S_IRUGO,		\
> +			   show_temp##offset##_input, NULL);		\
> +	TEMP_LIMIT_ATTR(offset, crit, temp_overt, overt_reg)		\
> +	static DEVICE_ATTR(temp##offset##_crit_hyst, S_IRUGO,		\
> +			   show_temp_crit_hyst, set_temp_crit_hyst);	\
> +	TEMP_LIMIT_ATTR(offset, max, temp_high_alert, high_alert_reg)	\
> +	TEMP_LIMIT_ATTR(offset, min, temp_low_alert, low_alert_reg)
> +
> +TEMP_ATTRS(1, RWOI, WLHO, WLLM)
> +TEMP_ATTRS(2, RWOE, WRHA, WRLN)

Please define static const arrays with these registers, for example:

static const u8 MAX6646_REG_ROI[2] = { MAX6646_REG_RWOI, MAX6646_REG_RWOE };

Then you can just use an index value to select the channel. This will
allow for code refactoring all over the driver.

> +
> +static ssize_t
> +show_period(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct max664x_data *data = max664x_update_device(dev);
> +	return sprintf(buf, "%u\n", PERIOD_FROM_RATE_REG(data->set.rate));
> +}
> +static ssize_t set_period(struct device *dev, struct device_attribute *attr,
> +			  const char *buf, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct max664x_data *data = i2c_get_clientdata(client);
> +	long val = simple_strtol(buf, NULL, 10);
> +	u8 reg_val = PERIOD_TO_RATE_REG(val);
> +
> +	mutex_lock(&data->update_lock);
> +	data->set.rate = reg_val;
> +	i2c_smbus_write_byte_data(client, MAX664X_REG_WCRW, reg_val);
> +	mutex_unlock(&data->update_lock);
> +	return count;
> +}
> +static DEVICE_ATTR(period, S_IRUGO | S_IWUSR, show_period, set_period);

Not a standard hwmon attribute, and "period" is a pretty vague term.
Other drivers don't bother exposing this value to user-space, as the
default setting is usually fine and people don't really care.

> +
> +/*
> + * Status is read-to-clear, so it is not world-readable and is not
> + * updated with the other fields.
> + */
> +static ssize_t show_status(struct device *dev,
> +			   struct device_attribute *attr, char *buf)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	int val = i2c_smbus_read_byte_data(client, MAX664X_REG_RSL);
> +	return val >= 0 ? sprintf(buf, "0x%x\n", val) : val;
> +}
> +static DEVICE_ATTR(status, S_IRUSR, show_status, NULL);

Alarms bit are to be split into individual files according to
Documentation/hwmon/sysfs-interface. And other drivers make this
information publicly readable - but you can't do that safely without
caching the value.

> +
> +int max664x_read_status(struct i2c_client *client)
> +{
> +	return i2c_smbus_read_byte_data(client, MAX664X_REG_RSL);
> +}
> +EXPORT_SYMBOL(max664x_read_status);

I fail to see the point of making this separate from max6646_get_values
(or whatever it ends up being called)?

> +
> +static struct attribute *max664x_attributes[] = {
> +	&dev_attr_temp1_input.attr,
> +	&dev_attr_temp1_crit.attr,
> +	&dev_attr_temp1_crit_hyst.attr,
> +	&dev_attr_temp1_max.attr,
> +	&dev_attr_temp1_min.attr,
> +	&dev_attr_temp2_input.attr,
> +	&dev_attr_temp2_crit.attr,
> +	&dev_attr_temp2_crit_hyst.attr,
> +	&dev_attr_temp2_max.attr,
> +	&dev_attr_temp2_min.attr,
> +
> +	&dev_attr_period.attr,
> +	&dev_attr_status.attr,
> +
> +	NULL
> +};
> +
> +static const struct attribute_group max664x_group = {
> +	.attrs = max664x_attributes,
> +};
> +
> +static int
> +max664x_probe(struct i2c_client *client, const struct i2c_device_id *id)
> +{
> +	const struct max664x_platform_data *plat_data > +		client->dev.platform_data;
> +	struct max664x_data *data;
> +	int err;
> +
> +	if (!i2c_check_functionality(client->adapter,
> +				     I2C_FUNC_SMBUS_BYTE_DATA))
> +		return -EIO;

That's not an I/O error. -EOPNOTSUPP would be more suitable, methinks.

> +
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->valid = 0;

Pointless initialization, given that kzalloc() zero'd the whole
structure already.

> +	mutex_init(&data->update_lock);
> +	if (plat_data)
> +		data->set = plat_data->set;

These values will never be used, except by yourself in this function.
It would be more efficient to not set data->set, and use plat_data->set
instead. It would also make more sense, as right now you write to
data->set values which you may not write to the chip (if any of
set_rate or set_limits isn't set) so the chip and cache are out of sync.

> +	i2c_set_clientdata(client, data);
> +
> +	if (plat_data && plat_data->set_rate)
> +		i2c_smbus_write_byte_data(client, MAX664X_REG_WCRW,
> +					  data->set.rate);
> +	if (plat_data && plat_data->set_limits) {
> +		i2c_smbus_write_byte_data(client, MAX664X_REG_RWOI,
> +					  data->set.temp_overt[0]);
> +		i2c_smbus_write_byte_data(client, MAX664X_REG_WLHO,
> +					  data->set.temp_high_alert[0]);
> +		i2c_smbus_write_byte_data(client, MAX664X_REG_WLLM,
> +					  data->set.temp_low_alert[0]);
> +		i2c_smbus_write_byte_data(client, MAX664X_REG_RWOE,
> +					  data->set.temp_overt[1]);
> +		i2c_smbus_write_byte_data(client, MAX664X_REG_WRHA,
> +					  data->set.temp_high_alert[1]);
> +		i2c_smbus_write_byte_data(client, MAX664X_REG_WRLN,
> +					  data->set.temp_low_alert[1]);
> +		i2c_smbus_write_byte_data(client, MAX664X_REG_HYS,
> +					  data->set.temp_overt_hyst);
> +	}
> +
> +	err = sysfs_create_group(&client->dev.kobj, &max664x_group);
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
> +	sysfs_remove_group(&client->dev.kobj, &max664x_group);
> +exit_free:
> +	kfree(data);
> +	i2c_set_clientdata(client, NULL);
> +	return err;
> +}
> +
> +static int max664x_remove(struct i2c_client *client)
> +{
> +	struct max664x_data *data = i2c_get_clientdata(client);
> +
> +	hwmon_device_unregister(data->hwmon_dev);
> +	sysfs_remove_group(&client->dev.kobj, &max664x_group);
> +
> +	kfree(data);
> +	i2c_set_clientdata(client, NULL);
> +	return 0;
> +}
> +
> +static const struct i2c_device_id max664x_id[] = {
> +	{ "max6646" },
> +	{ "max6647" },
> +	{ "max6649" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, max664x_id);
> +
> +struct i2c_driver max664x_driver = {
> +	.driver = {
> +		.name	= "max664x",
> +	},
> +	.probe		= max664x_probe,
> +	.remove		= max664x_remove,
> +	.id_table	= max664x_id,
> +};
> +
> +static int __init max664x_init(void)
> +{
> +	return i2c_add_driver(&max664x_driver);
> +}
> +
> +static void __exit max664x_exit(void)
> +{
> +	i2c_del_driver(&max664x_driver);
> +}
> +
> +MODULE_AUTHOR("Solarflare Communications");
> +MODULE_DESCRIPTION("MAX6646/6647/6649 driver");
> +MODULE_LICENSE("GPL v2");
> +
> +module_init(max664x_init);
> +module_exit(max664x_exit);
> diff --git a/include/linux/max664x.h b/include/linux/max664x.h
> new file mode 100644
> index 0000000..0b05903
> --- /dev/null
> +++ b/include/linux/max664x.h
> @@ -0,0 +1,92 @@
> +/****************************************************************************
> + * Interface to max664x driver
> + * Copyright 2008 Solarflare Communications Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published
> + * by the Free Software Foundation, incorporated herein by reference.
> + */
> +
> +#ifndef _MAX664X_H_
> +#define _MAX664X_H_
> +
> +#ifdef __KERNEL__
> +
> +#include <linux/types.h>
> +#include <linux/i2c.h>
> +
> +/* Status register */
> +#define MAX664X_STATUS_IOT	(1 << 0)
> +#define MAX664X_STATUS_EOT	(1 << 1)
> +#define MAX664X_STATUS_FAULT	(1 << 2)
> +#define MAX664X_STATUS_RLOW	(1 << 3)
> +#define MAX664X_STATUS_RHIGH	(1 << 4)
> +#define MAX664X_STATUS_LLOW	(1 << 5)
> +#define MAX664X_STATUS_LHIGH	(1 << 6)
> +#define MAX664X_STATUS_BUSY	(1 << 7)
> +
> +#define MAX664X_TEMP_INT	0
> +#define MAX664X_TEMP_EXT	1

Nice defines... but not used in your driver. This raises the question
of how useful they are. Not much IMHO, as each channel can be used for
something different depending on how the chip is used.

> +
> +/**
> + * struct max664x_settings - settings for MAX6646/6647/6649 hardware monitor
> + * @rate: Conversion rate setting
> + * @temp_overt: High temperature to set OVERT
> + * @temp_high_alert: High temperature to set ALERT
> + * @temp_low_alert: Low temperature to set ALERT
> + * @temp_overt_hyst: Hysteresis for resetting OVERT
> + *
> + * All values are raw register values.

... which doesn't sound good (see below.)

> + */
> +struct max664x_settings {
> +	u8 rate;
> +	u8 temp_overt[2];
> +	u8 temp_high_alert[2];
> +	u8 temp_low_alert[2];
> +	u8 temp_overt_hyst;
> +};
> +
> +/**
> + * struct max664x_values - values from MAX6646/6647/6649 hardware monitor
> + * @temp: Current temperature
> + *
> + * All values are raw register values.
> + */
> +struct max664x_values {
> +	u8 temp[2];
> +};
> +
> +/**
> + * struct max664x_platform_data - platform data for MAX6646/6647/6649 hardware monitor
> + * @set_rate: Flag for whether to set rate register
> + * @set_limits: Flag for whether to set limit registers
> + * @set: Settings to be applied depending on the above flags
> + *
> + * This platform data is optional.  If not provided, the driver will
> + * assume that the MAX6646/6647/6649 was properly configured by firmware
> + * or the power-on-reset defaults.
> + */
> +struct max664x_platform_data {
> +	unsigned set_rate : 1;
> +	unsigned set_limits : 1;
> +	struct max664x_settings set;
> +};
> +
> +/**
> + * max664x_update_values() - update and return current values
> + * @client: I2C client to which the max664x driver is bound
> + */
> +struct max664x_values *max664x_update_values(struct i2c_client *client);

I think you should return a const pointer. The caller really shouldn't
be allowed to change the values.

> +
> +/**
> + * max664x_read_status() - read status register
> + * @client: I2C client to which the max664x driver is bound
> + *
> + * Read the status register, which automatically clears any stuck alarm
> + * bits.

Why "stuck"? They are simply set.

> + */
> +int max664x_read_status(struct i2c_client *client);
> +
> +#endif
> +
> +#endif

Please add comments on what each #endif closes.

Note that I don't expect this API you just defined to live long. It's
completely hardware-specific and will show up its limitations quickly as
more drivers will offer similar interfaces, and I suspect the users
will ask for some level of abstraction. We have a nice, standard sysfs
interface by now, so going back to hardware-specific definitions on the
kernel side sounds pretty wrong.

That being said, I do not have the time to work on such a standard
specification at the moment, nor do I think that it makes sense to
specify anything until we have at least 3 drivers offering a similar
interface and 3 users thereof. So I am fine with taking your API for
now, as long as you realize that it is very likely temporary only.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
