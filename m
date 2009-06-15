From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 15 Jun 2009 20:52:24 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: Add driver tmp421 for TI's
Message-Id: <20090615225224.5daab5b6@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090615074320.GB4667@ubuntu>
In-Reply-To: <20090615074320.GB4667@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andre,

On Mon, 15 Jun 2009 09:43:20 +0200, Andre Prendel wrote:
> TI's TMP421/422/423 are I2C temperature sensor chips. These chips are
> similar to TI's TMP401/411 chips, but with reduced functionality (only
> temperature measurement). The chips have one local sensor and up to
> three (TMP423) remote sensors.

Overall good, please see my review below.

> 
> Notes:
> Hans, I've dropped two checks in tmp421_detect(). These checks came
> from tmp401 (copied by your students).
> 
> 1. Are reserved bits set to 0 in configuration register?
> 2. Are unused bits in conversion rate register set to 0?
> 
> I haven't any experience with real chips, so my question: Do we need
> these checks. Isn't the device id check enough? If so, I will bring
> back these checks.

In favor of the checks:
* I2C has no standard chip identification method, so just because a
  chip match a few register checks doesn't mean it's the chip you were
  looking for.
* Your driver checks several addresses, which increases the risk of
  false positives.

Against the checks:
* Slow down driver loading.
* I2C probing is restricted by classes, which should limit the risk of
  false positives.

So there is no absolute rule, other than the fact that any false
positive reported will result in an improved (and slower) detection
routine to prevent it.

> 
> Signed-off-by: Andre Prendel <andre.prendel@gmx.de>
> ---
>  Kconfig  |   10 +
>  Makefile |    1 
>  tmp421.c |  331 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 342 insertions(+)
> 
> Index: linux-2.6/drivers/hwmon/tmp421.c
> =================================> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6/drivers/hwmon/tmp421.c	2009-06-12 22:13:34.000000000 +0200
> @@ -0,0 +1,331 @@
> +/* tmp421.c
> + *
> + * Copyright (C) 2009 Andre Prendel <andre.prendel@gmx.de>
> + * Preliminary support by:
> + * Melvin Rook, Raymond Ng
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
> +/*
> + * Driver for the Texas Instruments TMP421 SMBUS temperature sensor IC.

Spelling: SMBus.

> + * Supported models: TMP421, TMP422, TMP423
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
> +/* Addresses to scan */
> +static unsigned short normal_i2c[] = { 0x2a, 0x4c, 0x4d, 0x4e, 0x4f,
> +				       I2C_CLIENT_END };
> +
> +/* Insmod parameters */
> +I2C_CLIENT_INSMOD_3(tmp421, tmp422, tmp423);
> +
> +/* The TMP421 registers */
> +#define TMP421_STATUS_REG			0x08
> +#define TMP421_CONFIG_REG_1			0x09
> +#define TMP421_CONFIG_REG_2			0x0A

You don't seem to use TMP421_STATUS_REG nor TMP421_CONFIG_REG_2
anywhere, so why define them?

> +#define TMP421_CONVERSION_RATE_REG		0x0B
> +#define TMP421_MANUFACTURER_ID_REG		0xFE
> +#define TMP421_DEVICE_ID_REG			0xFF
> +
> +static const u8 TMP421_TEMP_MSB[4]		= { 0x00, 0x01, 0x02, 0x03 };
> +static const u8 TMP421_TEMP_LSB[4]		= { 0x10, 0x11, 0x12, 0x13 };
> +
> +/* Flags */
> +#define TMP421_CONFIG_SHUTDOWN			0x40
> +#define TMP421_CONFIG_RANGE			0x04
> +
> +/* Manufacturer / Device ID's */
> +#define TMP421_MANUFACTURER_ID			0x55
> +#define TMP421_DEVICE_ID			0x21
> +#define TMP422_DEVICE_ID			0x22
> +#define TMP423_DEVICE_ID			0x23
> +
> +static int tmp421_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id);
> +static int tmp421_detect(struct i2c_client *client, int kind,
> +			 struct i2c_board_info *info);
> +static int tmp421_remove(struct i2c_client *client);
> +static struct tmp421_data *tmp421_update_device(struct device *dev);

Please reorder the functions so that these forward declarations are no
longer needed.

> +
> +static const struct i2c_device_id tmp421_id[] = {
> +	{ "tmp421", tmp421 },
> +	{ "tmp422", tmp422 },
> +	{ "tmp423", tmp423 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, tmp421_id);
> +
> +static struct i2c_driver tmp421_driver = {
> +	.class = I2C_CLASS_HWMON,
> +	.driver = {
> +		.name	= "tmp421",
> +	},
> +	.probe = tmp421_probe,
> +	.remove = tmp421_remove,
> +	.id_table = tmp421_id,
> +	.detect = tmp421_detect,
> +	.address_data = &addr_data,
> +};
> +
> +struct tmp421_data {
> +	struct device *hwmon_dev;
> +	struct mutex update_lock;
> +	char valid;
> +	unsigned long last_updated;
> +	int kind;
> +	u8 config;
> +	s16 temp[4];
> +};
> +
> +static int temp_from_s16(s16 reg)
> +{
> +	int temp = reg;
> +
> +	return (temp * 1000 + 128) / 256;
> +}
> +
> +static int temp_from_u16(u16 reg)
> +{
> +	int temp = reg;
> +
> +	/* Add offset for extended temperature range. */
> +	temp -= 64 * 256;
> +
> +	return (temp * 1000 + 128) / 256;
> +}
> +
> +static ssize_t show_temp_value(struct device *dev,
> +			       struct device_attribute *devattr, char *buf)
> +{
> +	int index = to_sensor_dev_attr(devattr)->index;
> +	struct tmp421_data *data = tmp421_update_device(dev);
> +	int temp;
> +
> +	if (data->config & TMP421_CONFIG_RANGE)
> +		temp = temp_from_u16(data->temp[index]);
> +	else
> +		temp = temp_from_s16(data->temp[index]);

This lacks protection: you have no guarantee that data->config and
data->temp[index] belong to the same read cycle.

> +
> +	return sprintf(buf, "%d\n", temp);
> +}
> +
> +static ssize_t show_fault(struct device *dev,
> +			  struct device_attribute *devattr, char *buf)
> +{
> +	int index = to_sensor_dev_attr(devattr)->index;
> +	struct tmp421_data *data = tmp421_update_device(dev);
> +
> +	/*
> +	 * The OPEN bit signals a fault. This is bit 0 of the temperature
> +	 * register (low byte).
> +	 */
> +	if (data->temp[index] & 0x01)
> +		return sprintf(buf, "1\n");
> +	else
> +		return sprintf(buf, "0\n");
> +}
> +
> +static struct sensor_device_attribute tmp421_attr[] = {
> +	SENSOR_ATTR(temp1_input, 0444, show_temp_value, NULL, 0),

This is S_IRUGO.

> +	SENSOR_ATTR(temp2_input, 0444, show_temp_value, NULL, 1),
> +	SENSOR_ATTR(temp2_fault, 0444, show_fault, NULL, 1),
> +	SENSOR_ATTR(temp3_input, 0444, show_temp_value, NULL, 2),
> +	SENSOR_ATTR(temp3_fault, 0444, show_fault, NULL, 2),
> +	SENSOR_ATTR(temp4_input, 0444, show_temp_value, NULL, 3),
> +	SENSOR_ATTR(temp4_fault, 0444, show_fault, NULL, 3),
> +};
> +
> +static void tmp421_init_client(struct i2c_client *client)
> +{
> +	int config, config_orig;
> +
> +	/* Set the conversion rate to 2 Hz */
> +	i2c_smbus_write_byte_data(client, TMP421_CONVERSION_RATE_REG, 0x05);
> +
> +	/* Start conversions (disable shutdown if necessary) */
> +	config = i2c_smbus_read_byte_data(client, TMP421_CONFIG_REG_1);
> +	if (config < 0) {
> +		dev_warn(&client->dev, "Could not read configuration"

Missing space between string fragments.

> +			 "register (%d)\n", config);
> +		return;
> +	}

Is this really only a warning? if you can't read from the chip, this is
a sign that something is really wrong, and it might be better to plain
fail.

> +
> +	config_orig = config;
> +	config &= ~TMP421_CONFIG_SHUTDOWN;
> +
> +	if (config != config_orig)
> +		i2c_smbus_write_byte_data(client, TMP421_CONFIG_REG_1, config);

Maybe log when you have to enable the monitoring?

> +}
> +
> +static int tmp421_detect(struct i2c_client *client, int kind,
> +			 struct i2c_board_info *info)
> +{
> +	struct i2c_adapter *adapter = client->adapter;
> +
> +	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
> +		return -ENODEV;
> +
> +	if (kind <= 0) {
> +		u8 reg;
> +
> +		reg = i2c_smbus_read_byte_data(client,
> +					       TMP421_MANUFACTURER_ID_REG);
> +

Extra blank line.

> +		if (reg != TMP421_MANUFACTURER_ID)
> +			return -ENODEV;
> +
> +		reg = i2c_smbus_read_byte_data(client,
> +					       TMP421_DEVICE_ID_REG);
> +

Extra blank line.

> +		switch (reg) {
> +		case TMP421_DEVICE_ID:
> +			kind = tmp421;
> +			break;
> +		case TMP422_DEVICE_ID:
> +			kind = tmp422;
> +			break;
> +		case TMP423_DEVICE_ID:
> +			kind = tmp423;
> +			break;
> +		default:
> +			return -ENODEV;
> +

Extra blank line.

> +		}
> +	}
> +	strlcpy(info->type, tmp421_id[kind - 1].name, I2C_NAME_SIZE);
> +
> +	return 0;
> +}
> +
> +static int tmp421_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	struct tmp421_data *data;
> +	const char *names[] = { "TMP421", "TMP422", "TMP423" };
> +	int i, err;
> +
> +	data = kzalloc(sizeof(struct tmp421_data), GFP_KERNEL);
> +	if (!data)
> +		return -ENODEV;

This would rather me -ENOMEM.

> +
> +	i2c_set_clientdata(client, data);
> +	mutex_init(&data->update_lock);
> +	data->kind = id->driver_data;
> +
> +	tmp421_init_client(client);
> +
> +	for (i = 0; i < ARRAY_SIZE(tmp421_attr); i++) {
> +		err = device_create_file(&client->dev,
> +					 &tmp421_attr[i].dev_attr);
> +

Extra blank line.

> +		if (err)
> +			goto exit_remove;
> +
> +		/*
> +		 * Create only necessary sysfs files.
> +		 * TMP421 up to one remote sensor
> +		 * TMP422 up to two remote sensors
> +		 * TMP423 up to three remote sensors.
> +		 */
> +		if (i >= data->kind * 2)

Huh, I don't like this, this is pretty fragile. Better have a struct
field dedicated to the number of inputs and fill it based on the chip
type. I also strongly suggests that you either rework your
tmp421_attr[] data structure, either by splitting the attributes to
per-sensor arrays, or by implementing an attribute group with
a .is_visible callback (the latter would probably be cleaner.)

> +			break;
> +	}
> +
> +	data->hwmon_dev = hwmon_device_register(&client->dev);
> +	if (IS_ERR(data->hwmon_dev)) {
> +		err = PTR_ERR(data->hwmon_dev);
> +		data->hwmon_dev = NULL;
> +		goto exit_remove;
> +	}
> +
> +	dev_info(&client->dev, "Detected TI %s chip\n", names[data->kind - 1]);

You didn't really detect anything in this function, so this message
should either move to tmp421_detect(), or be reworded a bit.

> +	return 0;
> +
> +exit_remove:
> +	tmp421_remove(client);
> +	return err;
> +}
> +
> +static int tmp421_remove(struct i2c_client *client)
> +{
> +	struct tmp421_data *data = i2c_get_clientdata(client);
> +	int i;
> +
> +	if (data->hwmon_dev)
> +		hwmon_device_unregister(data->hwmon_dev);
> +
> +	for (i = 0; i < ARRAY_SIZE(tmp421_attr); i++)
> +		device_remove_file(&client->dev, &tmp421_attr[i].dev_attr);
> +

Please add:
	i2c_set_clientdata(client, NULL);
to avoid leaving a dangling pointer behind.

> +	kfree(data);
> +
> +	return 0;
> +}
> +
> +static struct tmp421_data *tmp421_update_device(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct tmp421_data *data = i2c_get_clientdata(client);
> +	int i;
> +
> +	mutex_lock(&data->update_lock);
> +
> +	if (time_after(jiffies, data->last_updated + 2 * HZ) || !data->valid) {
> +		data->config = i2c_smbus_read_byte_data(client,
> +			TMP421_CONFIG_REG_1);
> +
> +		for (i = 0; i <= data->kind; i++) {
> +			data->temp[i] = i2c_smbus_read_byte_data(client,
> +				TMP421_TEMP_MSB[i]) << 8;
> +			data->temp[i] |= i2c_smbus_read_byte_data(client,
> +				TMP421_TEMP_LSB[i]);
> +		}
> +		data->last_updated = jiffies;
> +		data->valid = 1;
> +	}
> +
> +	mutex_unlock(&data->update_lock);
> +
> +	return data;
> +}
> +
> +static int __init tmp421_init(void)
> +{
> +	return i2c_add_driver(&tmp421_driver);
> +}
> +
> +static void __exit tmp421_exit(void)
> +{
> +	i2c_del_driver(&tmp421_driver);
> +}
> +
> +MODULE_AUTHOR("Andre Prendel");

No e-mail address?

> +MODULE_DESCRIPTION("Texas Instruments TMP421/422/423 temperature sensor"
> +		   "driver");

Missing space between string fragments.

> +MODULE_LICENSE("GPL");
> +
> +module_init(tmp421_init);
> +module_exit(tmp421_exit);
> Index: linux-2.6/drivers/hwmon/Kconfig
> =================================> --- linux-2.6.orig/drivers/hwmon/Kconfig	2009-06-11 21:50:46.000000000 +0200
> +++ linux-2.6/drivers/hwmon/Kconfig	2009-06-11 21:50:46.000000000 +0200
> @@ -797,6 +797,16 @@
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called tmp401.
>  
> +config SENSORS_TMP421
> +	tristate "Texas Instruments TMP421 and compatibles"
> +	depends on I2C && EXPERIMENTAL
> +	help
> +	  If you say yes here you get support for Texas Instruments TMP421
> +	  temperature sensor chips.

Please also list the TMP422 and TMP423.

> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called tmp421.
> +
>  config SENSORS_VIA686A
>  	tristate "VIA686A"
>  	depends on PCI
> Index: linux-2.6/drivers/hwmon/Makefile
> =================================> --- linux-2.6.orig/drivers/hwmon/Makefile	2009-06-11 21:50:46.000000000 +0200
> +++ linux-2.6/drivers/hwmon/Makefile	2009-06-11 21:50:46.000000000 +0200
> @@ -83,6 +83,7 @@
>  obj-$(CONFIG_SENSORS_SMSC47M192)+= smsc47m192.o
>  obj-$(CONFIG_SENSORS_THMC50)	+= thmc50.o
>  obj-$(CONFIG_SENSORS_TMP401)	+= tmp401.o
> +obj-$(CONFIG_SENSORS_TMP421)	+= tmp421.o
>  obj-$(CONFIG_SENSORS_VIA686A)	+= via686a.o
>  obj-$(CONFIG_SENSORS_VT1211)	+= vt1211.o
>  obj-$(CONFIG_SENSORS_VT8231)	+= vt8231.o


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
