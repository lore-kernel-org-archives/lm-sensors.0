From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 21 Jun 2012 18:42:44 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Honeywell Humidicon HIH-6130/HIH-6131 humidity and temperature senso
Message-Id: <20120621184244.GA14302@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4FE1E507.9040108@gmail.com>
In-Reply-To: <4FE1E507.9040108@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jun 20, 2012 at 02:58:15PM +0000, Iain Paton wrote:
> Hi,
> 
> This is a new driver for the Honeywell Humidicon HIH-6130 humidity sensor.
> 
> I don't claim originality, the driver is mostly identical to the existing Sensiron sht21 
> driver with the necessary changes to the probe, update_measurements and conversion functions
> necessary to use the Honeywell sensors.
> 
> My first kernel patch, please go easy on me as I'm bound to be doing something stupid :)
> 

Hi Iain,

It is pretty good, actually, especially for a first patch. Just a bunch of nitpicks.

Please run the patch through checkpatch and fix the warnings and errors (too
long lines and missing sign-off).

Please provide Documentation/hwmon/hih613x (or, rather, hih6130 - see next
paragraph).

Please spell out the chip types. "hih613x" could include anything from HIH6130
to HIH6139 (or even HIH613Z); if any of those is ever released, things would get
confusing. I would suggest to name the driver hih6130 and refer to the chips
as HIH6130/6131 as in the data sheet.

> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 6f1d167..2b13375 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -433,6 +433,16 @@ config SENSORS_GPIO_FAN
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called gpio-fan.
>  
> +config SENSORS_HIH613X
> +	tristate "Honeywell Humidicon HIH-613x humidity/temperature sensor"
> +	depends on I2C

	&& EXPERIMENTAL, at least for a couple of releases.

> +	help
> +	  If you say yes here you get support for Honeywell HIH-613x
> +	  Humidicon humidity sensors.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called hih613x.
> +
>  config SENSORS_CORETEMP
>  	tristate "Intel Core/Core2/Atom temperature sensor"
>  	depends on X86 && PCI && EXPERIMENTAL
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index e1eeac1..b92447c 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -58,6 +58,7 @@ obj-$(CONFIG_SENSORS_G760A)	+= g760a.o
>  obj-$(CONFIG_SENSORS_GL518SM)	+= gl518sm.o
>  obj-$(CONFIG_SENSORS_GL520SM)	+= gl520sm.o
>  obj-$(CONFIG_SENSORS_GPIO_FAN)	+= gpio-fan.o
> +obj-$(CONFIG_SENSORS_HIH613X)	+= hih613x.o
>  obj-$(CONFIG_SENSORS_ULTRA45)	+= ultra45_env.o
>  obj-$(CONFIG_SENSORS_I5K_AMB)	+= i5k_amb.o
>  obj-$(CONFIG_SENSORS_IBMAEM)	+= ibmaem.o
> diff --git a/drivers/hwmon/hih613x.c b/drivers/hwmon/hih613x.c
> new file mode 100644
> index 0000000..0c8693c
> --- /dev/null
> +++ b/drivers/hwmon/hih613x.c
> @@ -0,0 +1,297 @@
> +/* Honeywell HIH-613x humidity and temperature sensor driver
> + *
> + * Copyright (C) 2012 Iain Paton <ipaton0@gmail.com>
> + *
> + * heavily based on the sht21 driver
> + * Copyright (C) 2010 Urs Fleisch <urs.fleisch@sensirion.com>
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
> + * Foundation, Inc., 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA
> + *
> + * Data sheets available (6/2012) at
> + * http://sensing.honeywell.com/index.php?ci_id106&la_id=1&defIdD872
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/i2c.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/err.h>
> +#include <linux/mutex.h>
> +#include <linux/device.h>
> +#include <linux/delay.h>
> +
> +/**
> + * struct hih613x - HIH-613x device specific data
> + * @hwmon_dev: device registered with hwmon
> + * @lock: mutex to protect measurement values
> + * @valid: only 0 before first measurement is taken
> + * @last_update: time of last update (jiffies)
> + * @temperature: cached temperature measurement value
> + * @humidity: cached humidity measurement value
> + */
> +struct hih613x {
> +	struct device *hwmon_dev;
> +	struct mutex lock;
> +	char valid;

char is more expensive than bool on many platforms. I would suggest to use bool
instead.

> +	unsigned long last_update;
> +	int temperature;
> +	int humidity;
> +};
> +
> +/**
> + * hih613x_temp_ticks_to_millicelsius() - convert raw temperature ticks to
> + * milli celsius
> + * @ticks: temperature ticks value received from sensor
> + */
> +static inline int hih613x_temp_ticks_to_millicelsius(int ticks)
> +{
> +
> +	ticks &= ~0x0003; /* clear unused bits */

The above code is unnecessary; the shift gets rid of the unused bits.

> +	ticks = ticks >> 2;
> +	/*
> +	 * Formula T = ( ticks / ( 2^14 - 2 ) ) * 165 -40 from data sheet section 5.0,
> +	 */
> +	return ((ticks * 165000) / 16382) - 40000;

Would DIV_ROUND_CLOSEST make sense here ? Also, is it guaranteed that you don't
get an integer overflow ?

> +}
> +
> +/**
> + * hih613x_rh_ticks_to_per_cent_mille() - convert raw humidity ticks to
> + * one-thousandths of a percent relative humidity
> + * @ticks: humidity ticks value received from sensor
> + */
> +static inline int hih613x_rh_ticks_to_per_cent_mille(int ticks)
> +{
> +
> +	ticks &= ~0xC000; /* clear status bits */
> +	/*
> +	 * Formula RH = ( ticks / ( 2^14 -2 ) ) * 100 from data sheet section 4.0,
> +	 */
> +	return (ticks * 100000) / 16382;

Would DIV_ROUND_CLOSEST make sense here ?
Is it guaranteed that there won't be an integer overflow ?

> +}
> +
> +/**
> + * hih613x_update_measurements() - get updated measurements from device
> + * @client: I2C client device
> + *
> + * Returns 0 on success, else negative errno.
> + */
> +static int hih613x_update_measurements(struct i2c_client *client)
> +{
> +	int ret = 0;
> +	int t;
> +	struct hih613x *hih613x = i2c_get_clientdata(client);
> +
This empty line is not really needed.

> +	unsigned char tmp[4];
> +	struct i2c_msg msgs[1] = {
> +		{
> +			.addr = client->addr,
> +			.flags = I2C_M_RD,
> +			.len = 4,
> +			.buf = tmp,
> +		}
> +	};
> +
> +	mutex_lock(&hih613x->lock);
> +
> +	/*
> +	 * Unlike the SHT2x the HIH-613x datasheet doesn't give limits on the number of
> +	 * measurements per second we can make. However it makes no sense to allow polling
> +	 * for humidity or temperature more than a couple of times a second anyway.
> +	 */

It isn't really relevant what SHT2x does here. More important would be to
mention that a measurement takes a long time, so you want to limit it. Since a
measurement cycle takes 40 ms, you might actually want to consider increasing
the timeout to HZ or even HZ + HZ/2.

> +	if (time_after(jiffies, hih613x->last_update + HZ / 2) || !hih613x->valid) {
> +
> +		/* write to slave address, no data, to request a measurement */
> +		ret = i2c_master_send(client, tmp, 0);
> +		if (ret < 0)
> +			goto out;
> +
> +		/* for default 14 bit accuracy the measurement cycle time is ~36.65msec
> +		 * we can either simply wait, or could loop polling the status bits
> +		 */

Multi-line comment style.

Also, is there another accuracy ? I didn't find it in the documentation.
If the measurement cycle can be longer based on the configuration, reading
the measurement results might always fail, which would be bad.

> +		msleep(40);
> +
> +		ret = i2c_transfer(client->adapter, msgs, 1);
> +		if (ret < 0)
> +			goto out;
> +
> +		if ((tmp[0] & 0xC0) != 0) {
> +			dev_err(&client->dev, "Error while reading measurement result\n");
> +			ret = -EIO;
> +			goto out;
> +		}
> +
> +		t = (tmp[0]<<8) + tmp[1];

Coding style: spaces before and after <<

> +		hih613x->humidity = hih613x_rh_ticks_to_per_cent_mille(t);
> +
> +		t = (tmp[2]<<8) + tmp[3];

Coding style: spaces before and after <<

> +		hih613x->temperature = hih613x_temp_ticks_to_millicelsius(t);
> +
> +		hih613x->last_update = jiffies;
> +		hih613x->valid = 1;
> +
Unnecessary empty line

> +	}
> +out:
> +	mutex_unlock(&hih613x->lock);
> +
> +	return ret >= 0 ? 0 : ret;
> +}
> +
> +/**
> + * hih613x_show_temperature() - show temperature measurement value in sysfs
> + * @dev: device
> + * @attr: device attribute
> + * @buf: sysfs buffer (PAGE_SIZE) where measurement values are written to
> + *
> + * Will be called on read access to temp1_input sysfs attribute.
> + * Returns number of bytes written into buffer, negative errno on error.
> + */
> +static ssize_t hih613x_show_temperature(struct device *dev,
> +	struct device_attribute *attr,
> +	char *buf)

I don't really like the alignment here. I would suggest to align with (, and use
one less line.

> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct hih613x *hih613x = i2c_get_clientdata(client);
> +	int ret = hih613x_update_measurements(client);
> +	if (ret < 0)
> +		return ret;
> +	return sprintf(buf, "%d\n", hih613x->temperature);
> +}
> +
> +/**
> + * hih613x_show_humidity() - show humidity measurement value in sysfs
> + * @dev: device
> + * @attr: device attribute
> + * @buf: sysfs buffer (PAGE_SIZE) where measurement values are written to
> + *
> + * Will be called on read access to humidity1_input sysfs attribute.
> + * Returns number of bytes written into buffer, negative errno on error.
> + */
> +static ssize_t hih613x_show_humidity(struct device *dev,
> +	struct device_attribute *attr,
> +	char *buf)

Same here.

> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct hih613x *hih613x = i2c_get_clientdata(client);
> +	int ret = hih613x_update_measurements(client);
> +	if (ret < 0)
> +		return ret;
> +	return sprintf(buf, "%d\n", hih613x->humidity);
> +}
> +
> +/* sysfs attributes */
> +static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, hih613x_show_temperature,
> +	NULL, 0);
> +static SENSOR_DEVICE_ATTR(humidity1_input, S_IRUGO, hih613x_show_humidity,
> +	NULL, 0);
> +
> +static struct attribute *hih613x_attributes[] = {
> +	&sensor_dev_attr_temp1_input.dev_attr.attr,
> +	&sensor_dev_attr_humidity1_input.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group hih613x_attr_group = {
> +	.attrs = hih613x_attributes,
> +};
> +
> +/**
> + * hih613x_probe() - probe device
> + * @client: I2C client device
> + * @id: device ID
> + *
> + * Called by the I2C core when an entry in the ID table matches a
> + * device's name.
> + * Returns 0 on success.
> + */
> +static int __devinit hih613x_probe(struct i2c_client *client,
> +	const struct i2c_device_id *id)
> +{
> +	struct hih613x *hih613x;
> +	int err;
> +
> +	if (!i2c_check_functionality(client->adapter,
> +				     I2C_FUNC_I2C)) {

This does not need two lines.

> +		dev_err(&client->dev,
> +			"adapter does not support true I2C\n");

Does not need two lines.

> +		return -ENODEV;
> +	}
> +
> +	hih613x = devm_kzalloc(&client->dev, sizeof(*hih613x), GFP_KERNEL);
> +	if (!hih613x) {
> +		dev_dbg(&client->dev, "devm_kzalloc failed\n");

The calling code dumps a message, so this dev_dbg is unnecessary.

> +		return -ENOMEM;
> +	}
> +
> +	i2c_set_clientdata(client, hih613x);
> +
> +	mutex_init(&hih613x->lock);
> +
> +	err = sysfs_create_group(&client->dev.kobj, &hih613x_attr_group);
> +	if (err) {
> +		dev_dbg(&client->dev, "could not create sysfs files\n");
> +		return err;
> +	}
> +
> +	hih613x->hwmon_dev = hwmon_device_register(&client->dev);
> +	if (IS_ERR(hih613x->hwmon_dev)) {
> +		dev_dbg(&client->dev, "unable to register hwmon device\n");
> +		err = PTR_ERR(hih613x->hwmon_dev);
> +		goto fail_remove_sysfs;
> +	}
> +
> +	dev_info(&client->dev, "initialized\n");

Is this valuable or just noise ?

> +
> +	return 0;
> +
> +fail_remove_sysfs:
> +	sysfs_remove_group(&client->dev.kobj, &hih613x_attr_group);
> +	return err;
> +}
> +
> +/**
> + * hih613x_remove() - remove device
> + * @client: I2C client device
> + */
> +static int __devexit hih613x_remove(struct i2c_client *client)
> +{
> +	struct hih613x *hih613x = i2c_get_clientdata(client);
> +
> +	hwmon_device_unregister(hih613x->hwmon_dev);
> +	sysfs_remove_group(&client->dev.kobj, &hih613x_attr_group);
> +
> +	return 0;
> +}
> +
> +/* Device ID table */
> +static const struct i2c_device_id hih613x_id[] = {
> +	{ "hih613x", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, hih613x_id);
> +
> +static struct i2c_driver hih613x_driver = {
> +	.driver.name = "hih613x",
> +	.probe       = hih613x_probe,
> +	.remove      = __devexit_p(hih613x_remove),
> +	.id_table    = hih613x_id,
> +};
> +
> +module_i2c_driver(hih613x_driver);
> +
> +MODULE_AUTHOR("Iain Paton <ipaton0@gmail.com>");
> +MODULE_DESCRIPTION("Honeywell HIH-613x humidity and temperature sensor driver");
> +MODULE_LICENSE("GPL");
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
