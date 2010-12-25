From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 25 Dec 2010 18:34:25 +0000
Subject: Re: [lm-sensors] [PATCH] Support for DS620
Message-Id: <20101225183425.GA2459@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D0FB795.3010006@antcom.de>
In-Reply-To: <4D0FB795.3010006@antcom.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Dec 25, 2010 at 08:24:55AM -0500, Roland Stigge wrote:
> Hi,
> 
> On 23/12/10 20:55, Guenter Roeck wrote:
> > Please run your patch through scripts/checkpatch.pl and ensure it reports
> > no errors or warnings. Also please provide Documentation/hwmon/ds620.
> 
> Thanks for the hint!
> 
> I revised the patch and included Documentation/hwmon/ds620. See attachment.
> 
> bye,
>   Roland

> Signed-off-by: Roland Stigge <stigge@antcom.de>

Did you apply your patch ? All the above will show up in the patch log,
which isn't really a good idea. Also, you still have a whitespace error 
(blank line at end of the Documentation/hwmon/ds620).

Formatting isn't always consistent, mostly where you replaced ds1620 with ds620.
Best might be to run ds620.c through scripts/Lindent and do a little post-cleanup
(Lindent tends to screw up static initializations for some reason).

Couple of other comments inline.

> diff --git a/Documentation/hwmon/ds620 b/Documentation/hwmon/ds620
> new file mode 100644
> index 0000000..ba4c6bc
> --- /dev/null
> +++ b/Documentation/hwmon/ds620
> @@ -0,0 +1,24 @@
> +Kernel driver ds620
> +=========> +
> +Supported chips:
> +  * Dallas Semiconductor DS620
> +    Prefix: 'ds620'
> +    Addresses scanned: I2C 0x48 - 0x4f
> +    Datasheet: Publicly available at the Dallas Semiconductor website
> +               http://www.dalsemi.com/
> +
> +Authors:
> +        Roland Stigge <stigge@antcom.de>
> +        based on ds1621.c by
> +        Christian W. Zuckschwerdt <zany@triq.net>
> +
> +Description
> +-----------
> +
> +The DS620 is a (one instance) digital thermometer and thermostat. It has both
> +high and low temperature limits which can be user defined (i.e.  programmed
> +into non-volatile on-chip registers). Temperature range is -55 degree Celsius
> +to +125. Between 0 and 70 degree Celsius, accuracy is 0.5 Kelvin. The value
> +returned via sysfs displays post decimal positions.
> +
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index a56f6ad..700389a 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -274,6 +274,16 @@ config SENSORS_ATXP1
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called atxp1.
>  
> +config SENSORS_DS620
> +	tristate "Dallas Semiconductor DS620"
> +	depends on I2C
> +	help
> +	  If you say yes here you get support for Dallas Semiconductor
> +	  DS620 sensor chip.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called ds620.
> +
>  config SENSORS_DS1621
>  	tristate "Dallas Semiconductor DS1621 and DS1625"
>  	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 2479b3d..42542d7 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -41,6 +41,7 @@ obj-$(CONFIG_SENSORS_ATXP1)	+= atxp1.o
>  obj-$(CONFIG_SENSORS_CORETEMP)	+= coretemp.o
>  obj-$(CONFIG_SENSORS_PKGTEMP)	+= pkgtemp.o
>  obj-$(CONFIG_SENSORS_DME1737)	+= dme1737.o
> +obj-$(CONFIG_SENSORS_DS620)	+= ds620.o
>  obj-$(CONFIG_SENSORS_DS1621)	+= ds1621.o
>  obj-$(CONFIG_SENSORS_EMC1403)	+= emc1403.o
>  obj-$(CONFIG_SENSORS_EMC2103)	+= emc2103.o
> diff --git a/drivers/hwmon/ds620.c b/drivers/hwmon/ds620.c
> new file mode 100644
> index 0000000..2fbd193
> --- /dev/null
> +++ b/drivers/hwmon/ds620.c
> @@ -0,0 +1,357 @@
> +/*
> +    ds620.c - Support for temperature sensor and thermostat DS620
> +
> +    Copyright (C) 2010 Roland Stigge <stigge@antcom.de>
> +
> +    based on ds1621.c by Christian W. Zuckschwerdt  <zany@triq.net>
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
> +#include <linux/jiffies.h>
> +#include <linux/i2c.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/err.h>
> +#include <linux/mutex.h>
> +#include <linux/sysfs.h>
> +
> +/* Addresses to scan */
> +static const unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b, 0x4c,
> +					0x4d, 0x4e, 0x4f, I2C_CLIENT_END };
> +
> +/* Many DS620 constants specified below */
> +/* Config register used for detection          */
> +/*  15   14   13   12   11   10   09    08     */
> +/* |Done|NVB |THF |TLF |R1  |R0  |AUTOC|1SHOT| */
> +
> +/*  07   06   05   04   03   02   01    00     */
> +/* |PO2 |PO1 |A2  |A1  |A0  |    |     |     | */
> +#define DS620_REG_CONFIG_DONE		0x8000
> +#define DS620_REG_CONFIG_NVB		0x4000
> +#define DS620_REG_CONFIG_THF		0x2000
> +#define DS620_REG_CONFIG_TLF		0x1000
> +#define DS620_REG_CONFIG_R1		0x0800
> +#define DS620_REG_CONFIG_R0		0x0400
> +#define DS620_REG_CONFIG_AUTOC          0x0200
> +#define DS620_REG_CONFIG_1SHOT		0x0100
> +#define DS620_REG_CONFIG_PO2		0x0080
> +#define DS620_REG_CONFIG_PO1		0x0040
> +#define DS620_REG_CONFIG_A2		0x0020
> +#define DS620_REG_CONFIG_A1		0x0010
> +#define DS620_REG_CONFIG_A0		0x0008
> +
> +/* The DS620 registers */
> +static const u8 DS620_REG_TEMP[3] = {
> +	0xAA,		/* input, word, RO */
> +	0xA2,		/* min, word, RW */
> +	0xA0,		/* max, word, RW */
> +};
> +#define DS620_REG_CONF		0xAC /* word, RW */
> +#define DS620_COM_START		0x51 /* no data */
> +#define DS620_COM_STOP		0x22 /* no data */
> +
> +/* Conversions */
> +#define ALARMS_FROM_REG(val) ((val) & \
> +				(DS620_REG_CONFIG_THF | DS620_REG_CONFIG_TLF))
> +
> +/* Each client has this additional data */
> +struct ds620_data {
> +	struct device *hwmon_dev;
> +	struct mutex update_lock;
> +	char valid;			/* !=0 if following fields are valid */
> +	unsigned long last_updated;	/* In jiffies */
> +
> +	u16 temp[3];			/* Register values, word */
> +	u16 conf;			/* Register encoding, combined */
> +};
> +
> +/* Temperature registers are word-sized.
> +   DS620 uses a high-byte first convention, which is exactly opposite to
> +   the SMBus standard. */
> +static int ds620_read_temp(struct i2c_client *client, u8 reg)
> +{
> +	int ret;
> +
> +	ret = i2c_smbus_read_word_data(client, reg);
> +	if (ret < 0)
> +		return ret;
> +	return swab16(ret);
> +}
> +
> +static int ds620_write_temp(struct i2c_client *client, u8 reg, u16 value)
> +{
> +	return i2c_smbus_write_word_data(client, reg, swab16(value));
> +}
> +
> +static void ds620_init_client(struct i2c_client *client)
> +{
> +	u16 conf, new_conf;
> +
> +	new_conf = conf > +		swab16(i2c_smbus_read_word_data(client, DS620_REG_CONF));
> +
> +	/* switch to continuous conversion mode */
> +	new_conf &= ~DS620_REG_CONFIG_1SHOT;
> +	/* with highest precision */
> +	new_conf |= DS620_REG_CONFIG_R1 | DS620_REG_CONFIG_R0;
> +
> +	if (conf != new_conf) {
> +		i2c_smbus_write_word_data(
> +				client, DS620_REG_CONF, swab16(new_conf));
> +	}
> +
> +	/* start conversion */
> +	i2c_smbus_write_byte(client, DS620_COM_START);
> +}
> +
> +static struct ds620_data *ds620_update_client(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct ds620_data *data = i2c_get_clientdata(client);
> +	u16 new_conf;
> +
> +	mutex_lock(&data->update_lock);
> +
> +	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
> +	    || !data->valid) {
> +		int i;
> +
> +		dev_dbg(&client->dev, "Starting ds620 update\n");
> +
> +		data->conf = swab16(i2c_smbus_read_word_data(client,
> +							     DS620_REG_CONF));
> +
> +		for (i = 0; i < ARRAY_SIZE(data->temp); i++)
> +			data->temp[i] = ds620_read_temp(client,
> +							 DS620_REG_TEMP[i]);
> +
I know this is code matches exactly the ds1621 code. Yet, it ignores errors
returned by ds620_read_temp() and i2c_smbus_read_word_data(), so it is not
really clean. Worth thinking about a fix. One possible solution might be
to keep conf and temp[i] as int and return its value as error if it is below 0.
Another solution would be to return the error from ds620_update_client()
using ERR_PTR() and handle the condition in the calling code; see
drivers/hwmon/ltc4261.c for an example.


> +		/* reset alarms if necessary */
> +		new_conf = data->conf;
> +		if (data->temp[0] > data->temp[1])	/* input > min */
> +			new_conf &= ~DS620_REG_CONFIG_TLF;
> +		if (data->temp[0] < data->temp[2])	/* input < max */
> +			new_conf &= ~DS620_REG_CONFIG_THF;
> +		if (data->conf != new_conf)
> +			i2c_smbus_write_word_data(client, DS620_REG_CONF,
> +						  swab16(new_conf));

This code resets alarms even if those are not shown to the user.
The idea is for the alarms to be reset only after the matching alarm
has been shown. So the above code should be moved to the show_alarm().

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
> +static ssize_t show_temp(struct device *dev, struct device_attribute *da,
> +			 char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
> +	struct ds620_data *data = ds620_update_client(dev);
> +	return sprintf(buf, "%d\n",
> 			((data->temp[attr->index] / 8) * 625) / 10);
> +}
> +
> +static ssize_t set_temp(struct device *dev, struct device_attribute *da,
> +			const char *buf, size_t count)
> +{
> +	int res;
> +	long val;
> +
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct ds620_data *data = i2c_get_clientdata(client);
> +
> +	res = strict_strtol(buf, 10, &val);
> +
Should be
	if (res)
		return res;

	val = (val * 10 / 625) * 8;
	...

> +	if (!res) {
> +		val = (val * 10 / 625) * 8;
> +
> +		mutex_lock(&data->update_lock);
> +		data->temp[attr->index] = val;
> +		ds620_write_temp(client, DS620_REG_TEMP[attr->index],
> +				  data->temp[attr->index]);
> +		mutex_unlock(&data->update_lock);
> +	}
> +	return count;
> +}
> +
> +static ssize_t show_alarms(struct device *dev, struct device_attribute *da,
> +			   char *buf)
> +{
> +	struct ds620_data *data = ds620_update_client(dev);
> +	return sprintf(buf, "%d\n", ALARMS_FROM_REG(data->conf));
> +}
> +
_alarms is deprecated. Please remove.

> +static ssize_t show_alarm(struct device *dev, struct device_attribute *da,
> +			  char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
> +	struct ds620_data *data = ds620_update_client(dev);
> +	return sprintf(buf, "%d\n", !!(data->conf & attr->index));
> +}
> +
> +static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
> +static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);
> +static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO, show_temp, set_temp, 1);
> +static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp, set_temp, 2);
> +static SENSOR_DEVICE_ATTR(temp1_min_alarm, S_IRUGO, show_alarm, NULL,
> +		DS620_REG_CONFIG_TLF);
> +static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_alarm, NULL,
> +		DS620_REG_CONFIG_THF);
> +
> +static struct attribute *ds620_attributes[] = {
> +	&sensor_dev_attr_temp1_input.dev_attr.attr,
> +	&sensor_dev_attr_temp1_min.dev_attr.attr,
> +	&sensor_dev_attr_temp1_max.dev_attr.attr,
> +	&sensor_dev_attr_temp1_min_alarm.dev_attr.attr,
> +	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
> +	&dev_attr_alarms.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group ds620_group = {
> +	.attrs = ds620_attributes,
> +};
> +
> +
Extra blank line (Lindent would take care of that).

> +/* Return 0 if detection is successful, -ENODEV otherwise */
> +static int ds620_detect(struct i2c_client *client,
> +			 struct i2c_board_info *info)
> +{
> +	struct i2c_adapter *adapter = client->adapter;
> +	int result, conf, temp;
> +	int i;
> +
> +	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA
> +				     | I2C_FUNC_SMBUS_WORD_DATA
> +				     | I2C_FUNC_SMBUS_WRITE_BYTE))
> +		return -ENODEV;
> +
> +	/* Now, we do the remaining detection. */
> +	result = i2c_smbus_read_word_data(client, DS620_REG_CONF);
> +	conf = swab16(result);
> +	if (result < 0 || conf & DS620_REG_CONFIG_NVB ||
> +			((conf & DS620_REG_CONFIG_DONE) &&
> +			 (conf & DS620_REG_CONFIG_AUTOC)) ||
> +			!((conf & DS620_REG_CONFIG_DONE) &&
> +			!(conf & DS620_REG_CONFIG_AUTOC)))
> +		return -ENODEV;
> +	/* The 3 lowest bits of a temperature should always be 0. */
> +	for (i = 0; i < ARRAY_SIZE(DS620_REG_TEMP); i++) {
> +		temp = i2c_smbus_read_word_data(client, DS620_REG_TEMP[i]);
> +		if (temp < 0 || (temp & 0x0700))
> +			return -ENODEV;
> +	}
> +
> +	strlcpy(info->type, "ds620", I2C_NAME_SIZE);
> +
> +	return 0;
> +}
> +
> +static int ds620_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	struct ds620_data *data;
> +	int err;
> +
> +	data = kzalloc(sizeof(struct ds620_data), GFP_KERNEL);
> +	if (!data) {
> +		err = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	i2c_set_clientdata(client, data);
> +	mutex_init(&data->update_lock);
> +
> +	/* Initialize the DS620 chip */
> +	ds620_init_client(client);
> +
> +	/* Register sysfs hooks */
> +	err = sysfs_create_group(&client->dev.kobj, &ds620_group);
> +	if (err)
> +		goto exit_free;
> +
> +	data->hwmon_dev = hwmon_device_register(&client->dev);
> +	if (IS_ERR(data->hwmon_dev)) {
> +		err = PTR_ERR(data->hwmon_dev);
> +		goto exit_remove_files;
> +	}
> +
> +	dev_info(&client->dev, "temperature sensor found\n");
> +
> +	return 0;
> +
> +exit_remove_files:
> +	sysfs_remove_group(&client->dev.kobj, &ds620_group);
> +exit_free:
> +	kfree(data);
> +exit:
> +	return err;
> +}
> +
> +static int ds620_remove(struct i2c_client *client)
> +{
> +	struct ds620_data *data = i2c_get_clientdata(client);
> +
> +	hwmon_device_unregister(data->hwmon_dev);
> +	sysfs_remove_group(&client->dev.kobj, &ds620_group);
> +
> +	kfree(data);
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id ds620_id[] = {
> +	{ "ds620", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, ds620_id);
> +
> +/* This is the driver that will be inserted */
> +static struct i2c_driver ds620_driver = {
> +	.class		= I2C_CLASS_HWMON,
> +	.driver = {
> +		.name	= "ds620",
> +	},
> +	.probe		= ds620_probe,
> +	.remove		= ds620_remove,
> +	.id_table	= ds620_id,
> +	.detect		= ds620_detect,
> +	.address_list	= normal_i2c,
> +};
> +
> +static int __init ds620_init(void)
> +{
> +	return i2c_add_driver(&ds620_driver);
> +}
> +
> +static void __exit ds620_exit(void)
> +{
> +	i2c_del_driver(&ds620_driver);
> +}
> +
> +
> +MODULE_AUTHOR("Roland Stigge <stigge@antcom.de>");
> +MODULE_DESCRIPTION("DS620 driver");
> +MODULE_LICENSE("GPL");
> +
> +module_init(ds620_init);
> +module_exit(ds620_exit);


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
