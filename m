From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 27 Jan 2011 18:10:22 +0000
Subject: Re: [lm-sensors] Fwd: Re: LM95234
Message-Id: <20110127181022.GB17116@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D41A19E.5000108@sedsystems.ca>
In-Reply-To: <4D41A19E.5000108@sedsystems.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Kendrick,

On Thu, Jan 27, 2011 at 11:47:26AM -0500, Kendrick Hamilton wrote:
> Hello,
>   I have been working on a linux driver for the lm95234. I can cat the sys filesystem files for this device and see the temperature readings. They seem to behave in a sane manner. I have been discussing some with Wolfram and he suggested sending the patch to the hwmon group. I think it is you. Please let me know if I am on track or way off.
> 
Yes, this is the correct mailing list.

Bunch of comments below.

> Thank You
> Kendrick
> 
> On 11-01-24 09:18 AM, Wolfram Sang wrote:
> 
> 
> I haven't checked the datasheets, yet it sounds like the two drivers could be
> merged into one. Please check if that is possible.
> 
Temperature registers are all the same for the local and the first two external 
sensors, but command/status registers are all different. So I think separate drivers
are the better solution here.

> Also, don't be afraid to send your driver to the hwmon-list. Release early, you
> know? ;) They people on this list are more specialized to the topic than me.
> And reviews are better done in public.
> 
> All the best,
> 
>    Wolfram
> 
> 
> -------- Original Message --------
> Subject:        Re: LM95234
> Date:   Mon, 24 Jan 2011 16:29:02 -0600
> From:   Kendrick Hamilton <hamilton@sedsystems.ca><mailto:hamilton@sedsystems.ca>
> To:     Wolfram Sang <w.sang@pengutronix.de><mailto:w.sang@pengutronix.de>
> 
> 
> 
> I modified the lm95241 kernel driver to run the LM95234. I can read some
> sys filesystem entries to read the temperatures and applying cold spray
> to the sensors indicates the driver is polling the sensor. Attached is
> the patch, I don't think it is ready for distribution.
> 
> Kendrick
> 
> On 11-01-24 09:18 AM, Wolfram Sang wrote:
> > Kendrick,
> >
> > On Mon, Jan 24, 2011 at 09:00:34AM -0600, Kendrick Hamilton wrote:
> >
> >> Thank you both for answering. I will look at what I can do with
> >> lm-sensor. If I get that working, I will submit back the results. I
> > Thanks.
> >
> >> also need to use a LM95234. If I need to patch the kernel to support
> >> that part, I will submit back that patch. I am working with an NXP
> > I cannot find an existing driver for this chip, unfortunately.
> >
> >> 3240 processor and am using the 2.6.34.8 kernel as that has a kernel
> >> patch for the 3240 (I have not tried a newer kernel to see if all
> >> support is in the newest kernel).
> > There is only basic support in mainline. I once had a 3250-project and
> > tried to help. Still, it seems the push from NXP has stalled at the
> > moment :(
> >
> > Kind regards,
> >
> >     Wolfram
> >
> 
> 

> diff -Naur linux-2.6.34.8.orig/drivers/hwmon/Kconfig linux-2.6.34.8/drivers/hwmon/Kconfig
> --- linux-2.6.34.8.orig/drivers/hwmon/Kconfig	2011-01-24 15:17:34.000000000 -0600
> +++ linux-2.6.34.8/drivers/hwmon/Kconfig	2011-01-24 15:19:57.000000000 -0600
> @@ -632,6 +632,15 @@
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called lm95241.
>  
> +config SENSORS_LM95234
> +	tristate "National Semiconductor LM95234 sensor chip"
> +	depends on I2C
> +	help
> +	  If you say yes here you get support for LM95234 sensor chip.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called lm95234.
> +
>  config SENSORS_MAX1111
>  	tristate "Maxim MAX1111 Multichannel, Serial 8-bit ADC chip"
>  	depends on SPI_MASTER
> diff -Naur linux-2.6.34.8.orig/drivers/hwmon/Makefile linux-2.6.34.8/drivers/hwmon/Makefile
> --- linux-2.6.34.8.orig/drivers/hwmon/Makefile	2011-01-24 15:17:34.000000000 -0600
> +++ linux-2.6.34.8/drivers/hwmon/Makefile	2011-01-24 15:20:39.000000000 -0600
> @@ -72,6 +72,7 @@
>  obj-$(CONFIG_SENSORS_LM92)	+= lm92.o
>  obj-$(CONFIG_SENSORS_LM93)	+= lm93.o
>  obj-$(CONFIG_SENSORS_LM95241)	+= lm95241.o
> +obj-$(CONFIG_SENSORS_LM95234)	+= lm95234.o
>  obj-$(CONFIG_SENSORS_LTC4215)	+= ltc4215.o
>  obj-$(CONFIG_SENSORS_LTC4245)	+= ltc4245.o
>  obj-$(CONFIG_SENSORS_MAX1111)	+= max1111.o
> diff -Naur linux-2.6.34.8.orig/drivers/hwmon/lm95234.c linux-2.6.34.8/drivers/hwmon/lm95234.c
> --- linux-2.6.34.8.orig/drivers/hwmon/lm95234.c	1969-12-31 18:00:00.000000000 -0600
> +++ linux-2.6.34.8/drivers/hwmon/lm95234.c	2011-01-24 15:36:10.000000000 -0600
> @@ -0,0 +1,366 @@
> +/*
> + * lm95234.c - Part of lm_sensors, Linux kernel modules for hardware
> + *             monitoring
> + * Copyright (C) 2010 SED Systems <hamilton@sedsystems.ca>
> + *
> + * Based on the lm95234 driver. The LM95234 is a sensor chip made by National
> + *   Semiconductors.

Presumably it is based on the LM95241 driver.

> + * It reports up to five temperatures (its own plus up to
> + * four external ones). Complete datasheet can be
> + * obtained from National's website at:
> + *  http://www.national.com/ds/LM/LM95234.pdf
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
> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/jiffies.h>
> +#include <linux/i2c.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/err.h>
> +#include <linux/mutex.h>
> +#include <linux/sysfs.h>
> +
> +static const unsigned short normal_i2c[] = {
> +	0x18, 0x4d, 0x4e, I2C_CLIENT_END};
> +
> +/* LM95234 registers */
> +#define LM95234_REG_R_MAN_ID		0xFE
> +#define LM95234_REG_R_CHIP_ID		0xFF
> +#define LM95234_REG_RW_CONFIG		0x03
> +#define LM95234_REG_CONV_RATE       0x04
> +#define LM95234_REG_RW_REM_FILTER	0x06
> +#define NUM_LM95234_TEMP_CHANNEL    5   /* 0 is local temperature. */

Blanks instead of tabs. Indicates that you did not run the patch through
scripts/checkpatch.pl. Please do and fix all errors and warnings.
You might also run the code through scripts/Lindent to clean up some
of the formatting problems (that isn't perfect, though, and the result
may need some tweaking).

> +#define LM95234_REG_R_LOCAL_TEMPH	0x10
> +#define LM95234_REG_R_LOCAL_TEMPL	0x20
> +#define LM95234_REG_RW_REMOTE_MODEL	0x30
> +
> +/* LM95234 specific bitfields */
> +#define CFG_CR0076 0x00
> +#define TT1_SHIFT 0
> +#define TT2_SHIFT 4
> +#define TT_OFF 0
> +#define TT_ON 1
> +#define TT_MASK 7
> +#define MANUFACTURER_ID 0x01
> +#define DEFAULT_REVISION 0x79
> +
Please use tabs for cleaner formatting.

> +/* Conversions and various macros */
> +#define TEMP_FROM_REG(val_h, val_l) (((val_h) & 0x80 ? (val_h) - 0x100 : \
> +    (val_h)) * 1000 + (val_l) * 1000 / 256)
> +
#define TEMP_FROM_REG	(((s16)(((val_h) << 8) | (val_l))) * 1000 / 256)

would be a bit simpler and easier to understand.

> +/* Functions declaration */
> +static void lm95234_init_client(struct i2c_client *client);
> +static struct lm95234_data *lm95234_update_device(struct device *dev);
> +
Please rearrange code to not require forward declarations.

> +/* Client data (each client gets its own) */
> +struct lm95234_data {
> +	struct device *hwmon_dev;
> +	struct mutex update_lock;
> +	unsigned long last_updated, rate; /* in jiffies */
> +	char valid; /* zero until following fields are valid */

Can be bool.

> +	/* registers values */
> +    /* Temperature registers */
> +    u8 temp_h[NUM_LM95234_TEMP_CHANNEL];
> +    u8 temp_l[NUM_LM95234_TEMP_CHANNEL];
> +	u8 model;
> +};
> +
> +/* Sysfs stuff */
> +#define show_temp(channel) \
> +static ssize_t show_temp##channel(struct device *dev, \
> +    struct device_attribute *attr, char *buf) \
> +{ \
> +	struct lm95234_data *data = lm95234_update_device(dev); \
> +	snprintf(buf, PAGE_SIZE - 1, "%d\n", \
> +		TEMP_FROM_REG(data->temp_h[channel], data->temp_l[channel])); \
> +	return strlen(buf); \

	return snprintf() is simpler.

> +}
> +show_temp(0);
> +show_temp(1);
> +show_temp(2);
> +show_temp(3);
> +show_temp(4);
> +
Please don't use macros to define show and set functions. Use SENSOR_DEVICE_ATTR
instead of DEVICE_ATTR to define the attribute, and use the index field of
SENSOR_DEVICE_ATTR to determine the sensor index. 

> +static ssize_t show_rate(struct device *dev, struct device_attribute *attr,
> +			 char *buf)
> +{
> +	struct lm95234_data *data = lm95234_update_device(dev);
> +
> +	snprintf(buf, PAGE_SIZE - 1, "%lu\n", 1000 * data->rate / HZ);
> +	return strlen(buf);

	return snprintf() is simpler.

> +}
> +
> +static ssize_t set_rate(struct device *dev, struct device_attribute *attr,
> +			const char *buf, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct lm95234_data *data = i2c_get_clientdata(client);
> +
> +	strict_strtol(buf, 10, &data->rate);

Check return code and return an error if the value is bad.

> +	data->rate = data->rate * HZ / 1000;
> +
> +	return count;
> +}
> +
> +#define show_type(flag) \
> +static ssize_t show_type##flag(struct device *dev, \
> +				   struct device_attribute *attr, char *buf) \
> +{ \
> +	struct i2c_client *client = to_i2c_client(dev); \
> +	struct lm95234_data *data = i2c_get_clientdata(client); \
> +\
> +	snprintf(buf, PAGE_SIZE - 1, \
> +		data->model & (0x01 << flag) ? "1\n" : "2\n"); \
> +	return strlen(buf); \

	return snprintf() is simpler.

> +}
> +show_type(1);
> +show_type(2);
> +show_type(3);
> +show_type(4);
> +
> +#define set_type(flag) \
> +static ssize_t set_type##flag(struct device *dev, \
> +				  struct device_attribute *attr, \
> +				  const char *buf, size_t count) \
> +{ \
> +	struct i2c_client *client = to_i2c_client(dev); \
> +	struct lm95234_data *data = i2c_get_clientdata(client); \
> +\
> +	long val; \
> +	strict_strtol(buf, 10, &val); \
> +\
> +	if ((val = 1) || (val = 2)) { \

Unnecessary ( ).

> +\
> +		mutex_lock(&data->update_lock); \
> +\
> +		if (val = 1) { \
> +			data->model |= (1 << flag); \
> +		} \
> +		else { \
> +			data->model &= ~(1 << flag); \
> +		} \
> +\
Unnecessary { }

> +		data->valid = 0; \
> +\
> +		i2c_smbus_write_byte_data(client, LM95234_REG_RW_REMOTE_MODEL, \
> +					  data->model); \
> +\
> +		mutex_unlock(&data->update_lock); \
> +\
> +	} \

Return error if val is invalid and if strict_strtol fails.
Besides, use strict_strtoul.

	err = strict_strtoul(buf, 10, &val);
	if (err < 0)
		return err;
	if (val < 1 || val > 2)
		return -EINVAL;

	...

> +	return count; \
> +}
> +set_type(1);
> +set_type(2);
> +set_type(3);
> +set_type(4);
> +
> +static DEVICE_ATTR(temp0_input, S_IRUGO, show_temp0, NULL);
> +static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp1, NULL);
> +static DEVICE_ATTR(temp2_input, S_IRUGO, show_temp2, NULL);
> +static DEVICE_ATTR(temp3_input, S_IRUGO, show_temp3, NULL);
> +static DEVICE_ATTR(temp4_input, S_IRUGO, show_temp4, NULL);
> +
> +static DEVICE_ATTR(temp1_type, S_IWUSR | S_IRUGO, show_type1, set_type1);
> +static DEVICE_ATTR(temp2_type, S_IWUSR | S_IRUGO, show_type2, set_type2);
> +static DEVICE_ATTR(temp3_type, S_IWUSR | S_IRUGO, show_type3, set_type3);
> +static DEVICE_ATTR(temp4_type, S_IWUSR | S_IRUGO, show_type4, set_type4);
> +
Since the chip supports limits as well as overtemperature status and fault conditions,
it would be great if you can add support for those as well. Not mandatory, though.

> +static DEVICE_ATTR(rate, S_IWUSR | S_IRUGO, show_rate, set_rate);
> +
Standard attribute name is update_interval. Please use it. Also, if you want to support
this attribute, pelase set the matching value in the conversion rate register. You can
find an example how to match the available chip conversion rates to update_interval
in lm90.c.

> +static struct attribute *lm95234_attributes[] = {
> +	&dev_attr_temp0_input.attr,
> +	&dev_attr_temp1_input.attr,
> +	&dev_attr_temp2_input.attr,
> +	&dev_attr_temp3_input.attr,
> +	&dev_attr_temp4_input.attr,
> +
> +	&dev_attr_temp1_type.attr,
> +	&dev_attr_temp2_type.attr,
> +	&dev_attr_temp3_type.attr,
> +	&dev_attr_temp4_type.attr,
> +
> +	&dev_attr_rate.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group lm95234_group = {
> +	.attrs = lm95234_attributes,
> +};
> +
> +/* Return 0 if detection is successful, -ENODEV otherwise */
> +static int lm95234_detect(struct i2c_client *new_client,
> +			  struct i2c_board_info *info)
> +{
> +	struct i2c_adapter *adapter = new_client->adapter;
> +	int address = new_client->addr;
> +	const char *name;
> +
> +	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
> +		return -ENODEV;
> +
> +	if ((i2c_smbus_read_byte_data(new_client, LM95234_REG_R_MAN_ID)
> +	     = MANUFACTURER_ID)
> +	 && (i2c_smbus_read_byte_data(new_client, LM95234_REG_R_CHIP_ID)
> +	     >= DEFAULT_REVISION)) {

Unfortunately, this will identify lm95241 (revision code 0xa4) as lm95234,
so you'll have to use = instead of >= (That the lm95241 code does the same
isn't a good idea either).

Also, 
	if (i2c_smbus_read_byte_data(new_client,
				     LM95234_REG_R_MAN_ID) != MANUFACTURER_ID ||
	    i2c_smbus_read_byte_data(new_client,
				     LM95234_REG_R_CHIP_ID) != DEFAULT_REVISION) {
		dev_dbg(&adapter->dev, "LM95234 detection failed at 0x%02x\n",
			address);
		return -ENODEV;
	}
	strlcpy(info->type, "lm95234", I2C_NAME_SIZE);
	return 0;

would be a bit simpler.

> +		name = "lm95234";
> +	} else {
> +		dev_dbg(&adapter->dev, "LM95234 detection failed at 0x%02x\n",
> +			address);
> +		return -ENODEV;
> +	}
> +
> +	/* Fill the i2c board info */
> +	strlcpy(info->type, name, I2C_NAME_SIZE);
> +	return 0;
> +}
> +
> +static int lm95234_probe(struct i2c_client *new_client,
> +			 const struct i2c_device_id *id)
> +{
> +	struct lm95234_data *data;
> +	int err;
> +
> +	data = kzalloc(sizeof(struct lm95234_data), GFP_KERNEL);
> +	if (!data) {
> +		err = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	i2c_set_clientdata(new_client, data);
> +	mutex_init(&data->update_lock);
> +
> +	/* Initialize the LM95234 chip */
> +	lm95234_init_client(new_client);
> +
> +	/* Register sysfs hooks */
> +	err = sysfs_create_group(&new_client->dev.kobj, &lm95234_group);
> +	if (err)
> +		goto exit_free;
> +
> +	data->hwmon_dev = hwmon_device_register(&new_client->dev);
> +	if (IS_ERR(data->hwmon_dev)) {
> +		err = PTR_ERR(data->hwmon_dev);
> +		goto exit_remove_files;
> +	}
> +
> +	return 0;
> +
> +exit_remove_files:
> +	sysfs_remove_group(&new_client->dev.kobj, &lm95234_group);
> +exit_free:
> +	kfree(data);
> +exit:
> +	return err;
> +}
> +
> +static void lm95234_init_client(struct i2c_client *client)
> +{
> +	struct lm95234_data *data = i2c_get_clientdata(client);
> +
> +	data->rate = HZ;    /* 1 sec default */
> +	data->valid = 0;
> +	data->model = 0;
> +
> +	i2c_smbus_write_byte_data(client, LM95234_REG_RW_CONFIG, 0);
> +	i2c_smbus_write_byte_data(client, LM95234_REG_CONV_RATE, 0x02); //1 sec
> +
> +	i2c_smbus_write_byte_data(client, LM95234_REG_RW_REM_FILTER,
> +                  0x0f); //Enable enhanced filtering

No C++ style comments, please.

> +	i2c_smbus_write_byte_data(client, LM95234_REG_RW_REMOTE_MODEL,
> +				  data->model);
> +}
> +
> +static int lm95234_remove(struct i2c_client *client)
> +{
> +	struct lm95234_data *data = i2c_get_clientdata(client);
> +
> +	hwmon_device_unregister(data->hwmon_dev);
> +	sysfs_remove_group(&client->dev.kobj, &lm95234_group);
> +
> +	i2c_set_clientdata(client, NULL);

No longer needed, please remove.

> +	kfree(data);
> +	return 0;
> +}
> +
> +static struct lm95234_data *lm95234_update_device(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct lm95234_data *data = i2c_get_clientdata(client);
> +
> +	mutex_lock(&data->update_lock);
> +
> +	if (time_after(jiffies, data->last_updated + data->rate) ||
> +	    !data->valid) {
> +        int i;
> +		dev_dbg(&client->dev, "Updating lm95234 data.\n");

Looks like formatting is way off here.

> +        for(i = 0; i < NUM_LM95234_TEMP_CHANNEL; ++i)
> +        {

Opening brackets at end of line.

> +		    data->temp_h[i] > +			    i2c_smbus_read_byte_data(client,
> +						    LM95234_REG_R_LOCAL_TEMPH + i);
> +            data->temp_l[i] > +                i2c_smbus_read_byte_data(client,
> +                        LM95234_REG_R_LOCAL_TEMPL + i);
> +        }
> +
> +		data->last_updated = jiffies;
> +		data->valid = 1;
> +	}

The function does not return an error if i2c_smbus_read_byte_data() fails. 
It is not really mandatory to do that, but quite useful. You can find an 
example for simple error handling in ltc4261.c. Please consider using it.

> +
> +	mutex_unlock(&data->update_lock);
> +
> +	return data;
> +}
> +
> +/* Driver data (common to all clients) */
> +static const struct i2c_device_id lm95234_id[] = {
> +	{ "lm95234", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, lm95234_id);
> +
> +static struct i2c_driver lm95234_driver = {
> +	.class		= I2C_CLASS_HWMON,
> +	.driver = {
> +		.name   = "lm95234",
> +	},
> +	.probe		= lm95234_probe,
> +	.remove		= lm95234_remove,
> +	.id_table	= lm95234_id,
> +	.detect		= lm95234_detect,
> +	.address_list	= normal_i2c,
> +};
> +
> +static int __init sensors_lm95234_init(void)
> +{
> +	return i2c_add_driver(&lm95234_driver);
> +}
> +
> +static void __exit sensors_lm95234_exit(void)
> +{
> +	i2c_del_driver(&lm95234_driver);
> +}
> +
> +MODULE_AUTHOR("SED Systems <hamilton@sedsystems.ca>");
> +MODULE_DESCRIPTION("LM95234 sensor driver");
> +MODULE_LICENSE("GPL");
> +
> +module_init(sensors_lm95234_init);
> +module_exit(sensors_lm95234_exit);
> 

> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors


-- 
Guenter Roeck
Distinguished Engineer
PDU IP Systems

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
