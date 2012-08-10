From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 10 Aug 2012 05:46:31 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: Driver for ADT7410
Message-Id: <20120810054631.GA19116@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <501BA87C.2020907@gmx.de>
In-Reply-To: <501BA87C.2020907@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Fri, Aug 10, 2012 at 12:32:15AM +0200, Hartmut Knaack wrote:
> New driver for ADT7410 temperature sensor
>=20
> This patch brings basic support for the Analog Devices ADT7410 temperature
> sensor, based on the lm75 hwmon driver and the adt7410 iio driver. The fo=
llowing
> functionality has been implemented:
>=20
>   * get current temperature
>   * get/set minimum, maximum and critical temperature
>   * get/set hysteresis
>   * get alarm events for minimum, maximum and critical temperature
>=20
> All implemented sysfs-symbols have been successfully tested at temperatur=
es of
> 15=B0C to 40=B0C.
>=20
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>

Hi Hartmut,

almost there. Couple of additional comments below. As usual for me, I keep =
finding
stuff, and there are some new problems.

Thanks,
Guenter

> ---
> v3:
> Rework based on Guenter Roecks review:
> - fixed format issues
> - changed some variable types
> - optimized sleep delay of adt7410_temp_ready
> - always return original error codes
> - set hysteresis with SENSORS_LIMIT
> - drop adt7410_detect
>=20
> v2:
> Applied changes recommended by Guenter Roeck:
> - use devm_ function for allocation
> - use i2c_smbus functions instead of wrapper functions
> - change "valid" from char to bool
> - move delay code to adt7410_temp_ready and use sleep
> - improved detect function
> - merge show_xxx_alarm functions
> - improve format, drop variables
>=20
> diff --git a/Documentation/hwmon/adt7410 b/Documentation/hwmon/adt7410
> new file mode 100644
> index 0000000..a70cea7
> --- /dev/null
> +++ b/Documentation/hwmon/adt7410
> @@ -0,0 +1,50 @@
> +Kernel driver adt7410
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Supported chips:
> +  * Analog Devices ADT7410
> +    Prefix: 'adt7410'
> +    Addresses scanned: I2C 0x48 - 0x4B
> +    Datasheet: Publicly available at the Analog Devices website
> +               http://www.analog.com/static/imported-files/data_sheets/A=
DT7410.pdf
> +
> +Author: Hartmut Knaack <knaack.h@gmx.de>
> +
> +Description
> +-----------
> +
> +The ADT7410 is a temperature sensor with rated temperature range of -55=
=B0C to
> ++150=B0C. It has a high accuracy of +/-0.5=B0C and can be operated at a =
resolution
> +of 13 bits (0.0625=B0C) or 16 bits (0.0078=B0C). The sensor provides an =
INT pin to
> +indicate an excession of a set minimum or maximum temperature, as well a=
s a

excession - that word does not seeem to exist (except as a book written by =
Ian
Banks ;). Do you mean the noun associated with "exceed" ? If so, maybe reph=
rase
the sentence to

	to indicate that a minimum or maximum temperature set point has been excee=
ded

> +critical temperature (CT) pin to indicate an excession of a set critical

Same here.

> +temperature. Both pins can be set up with a common hysteresis of 0=B0C -=
 15=B0C
> +and a fault queue ranging from 1 to 4 events. Both pins can individually=
 set
> +to be active-low or active-high, while the whole device can either run in
> +comparator mode or interrupt mode. The ADT7410 supports continuous tempe=
rature
> +sampling, as well as sampling one temperature value per second or even j=
ust
> +get one sample on demand for power saving. Besides, it can completely po=
wer
> +down its ADC, if power management is required.
> +
> +Configuration Notes
> +-------------------
> +
> +Since the device uses one hysteresis value, which is an offset to minimu=
m,
> +maximum and critical temperature, it can only be set for temp#_max_hyst.
> +However, temp#_min_hyst and temp#_crit_hyst show their corresponding
> +hysteresis.
> +The device is set to 16 bit resolution and comparator mode.
> +
> +sysfs-Interface
> +---------------
> +
> +temp#_input		- temperature input
> +temp#_min		- temperature minimum setpoint
> +temp#_max		- temperature maximum setpoint
> +temp#_crit		- critical temperature setpoint
> +temp#_min_hyst		- hysteresis for temperature minimum (read-only)
> +temp#_max_hyst		- hysteresis for temperature maximum (read/write)
> +temp#_crit_hyst		- hysteresis for critical temperature (read-only)

The idea was to make the hysteresis writable for all attributes. More on th=
at
below.

> +temp#_min_alarm		- temperature minimum alarm flag
> +temp#_max_alarm		- temperature maximum alarm flag
> +temp#_crit_alarm	- critical temperature alarm flag
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 6f1d167..7ed1989 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -179,6 +179,16 @@ config SENSORS_ADM9240
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called adm9240.
> =20
> +config SENSORS_ADT7410
> +	tristate "Analog Devices ADT7410"
> +	depends on I2C && EXPERIMENTAL
> +	help
> +	  If you say yes here you get support for the Analog Devices
> +	  ADT7410 temperature monitoring chip.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called adt7410.
> +
>  config SENSORS_ADT7411
>  	tristate "Analog Devices ADT7411"
>  	depends on I2C && EXPERIMENTAL
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index e1eeac1..112ce3a 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -34,6 +34,7 @@ obj-$(CONFIG_SENSORS_ADM9240)	+=3D adm9240.o
>  obj-$(CONFIG_SENSORS_ADS1015)	+=3D ads1015.o
>  obj-$(CONFIG_SENSORS_ADS7828)	+=3D ads7828.o
>  obj-$(CONFIG_SENSORS_ADS7871)	+=3D ads7871.o
> +obj-$(CONFIG_SENSORS_ADT7410)	+=3D adt7410.o
>  obj-$(CONFIG_SENSORS_ADT7411)	+=3D adt7411.o
>  obj-$(CONFIG_SENSORS_ADT7462)	+=3D adt7462.o
>  obj-$(CONFIG_SENSORS_ADT7470)	+=3D adt7470.o
> diff --git a/drivers/hwmon/adt7410.c b/drivers/hwmon/adt7410.c
> new file mode 100644
> index 0000000..9069ad9
> --- /dev/null
> +++ b/drivers/hwmon/adt7410.c
> @@ -0,0 +1,465 @@
> +/*
> + * adt7410.c - Part of lm_sensors, Linux kernel modules for hardware
> + *	 monitoring
> + * This driver handles the ADT7410 and compatible digital temperature se=
nsors.
> + * Hartmut Knaack <knaack.h@gmx.de> 2012-07-22
> + * based on lm75.c by Frodo Looijaard <frodol@dds.nl>
> + * and adt7410.c from iio-staging by Sonic Zhang <sonic.zhang@analog.com>
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
> +#include <linux/delay.h>
> +
> +/*
> + * ADT7410 registers definition
> + */
> +
> +#define ADT7410_TEMPERATURE		0
> +#define ADT7410_STATUS			2
> +#define ADT7410_CONFIG			3
> +#define ADT7410_T_ALARM_HIGH		4
> +#define ADT7410_T_ALARM_LOW		6
> +#define ADT7410_T_CRIT			8
> +#define ADT7410_T_HYST			0xA
> +
> +/*
> + * ADT7410 status
> + */
> +#define ADT7410_STAT_T_LOW		(1 << 4)
> +#define ADT7410_STAT_T_HIGH		(1 << 5)
> +#define ADT7410_STAT_T_CRIT		(1 << 6)
> +#define ADT7410_STAT_NOT_RDY		(1 << 7)
> +
> +/*
> + * ADT7410 config
> + */
> +#define ADT7410_FAULT_QUEUE_MASK	(1 << 0 | 1 << 1)
> +#define ADT7410_CT_POLARITY		(1 << 2)
> +#define ADT7410_INT_POLARITY		(1 << 3)
> +#define ADT7410_EVENT_MODE		(1 << 4)
> +#define ADT7410_MODE_MASK		(1 << 5 | 1 << 6)
> +#define ADT7410_FULL			(0 << 5 | 0 << 6)
> +#define ADT7410_PD			(1 << 5 | 1 << 6)
> +#define ADT7410_RESOLUTION		(1 << 7)
> +
> +/*
> + * ADT7410 masks
> + */
> +#define ADT7410_T13_VALUE_MASK			0xFFF8
> +#define ADT7410_T_HYST_MASK			0xF
> +
> +/* straight from the datasheet */
> +#define ADT7410_TEMP_MIN (-55000)
> +#define ADT7410_TEMP_MAX 150000
> +
> +enum adt7410_type {		/* keep sorted in alphabetical order */
> +	adt7410,
> +};
> +
> +/* Addresses scanned */
> +static const unsigned short normal_i2c[] =3D { 0x48, 0x49, 0x4a, 0x4b,
> +					I2C_CLIENT_END };
> +
> +static const u8 ADT7410_REG_TEMP[4] =3D {
> +	ADT7410_TEMPERATURE,		/* input */
> +	ADT7410_T_ALARM_HIGH,		/* high */
> +	ADT7410_T_ALARM_LOW,		/* low */
> +	ADT7410_T_CRIT,			/* critical */
> +};
> +
> +/* Each client has this additional data */
> +struct adt7410_data {
> +	struct device		*hwmon_dev;
> +	struct mutex		update_lock;
> +	u8			config;
> +	u8			oldconfig;
> +	bool			valid;		/* true if registers valid */
> +	unsigned long		last_updated;	/* In jiffies */
> +	s16			temp[4];	/* Register values,
> +						   0 =3D input
> +						   1 =3D high
> +						   2 =3D low
> +						   3 =3D critical */
> +	u8			hyst;		/* hysteresis offset */
> +};
> +
> +/*
> + * adt7410 register access by I2C
> + */
> +static int adt7410_temp_ready(struct i2c_client *client)
> +{
> +	int i, status;
> +
> +	for (i =3D 0; i < 6; i++) {
> +		status =3D i2c_smbus_read_byte_data(client, ADT7410_STATUS);
> +		if (status < 0)
> +			return status;
> +		if (!(status & ADT7410_STAT_NOT_RDY))
> +			return 0;
> +		msleep(60);
> +	}
> +	return -EIO;

-ETIMEDOUT might be better here, and give the user a better hint about the =
problem.

> +}
> +
> +static struct adt7410_data *adt7410_update_device(struct device *dev)
> +{
> +	struct i2c_client *client =3D to_i2c_client(dev);
> +	struct adt7410_data *data =3D i2c_get_clientdata(client);
> +	struct adt7410_data *ret =3D data;
> +	mutex_lock(&data->update_lock);
> +
> +	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
> +	    || !data->valid) {
> +		int i, status;
> +
> +		dev_dbg(&client->dev, "Starting update\n");
> +
> +		status =3D adt7410_temp_ready(client); /* check for new value */
> +		if (status)
> +			return ERR_PTR(status);

missing unlock, and you might use unlikely since you do it elsewhere as wel=
l.

> +		for (i =3D 0; i < ARRAY_SIZE(data->temp); i++) {
> +			status =3D i2c_smbus_read_word_swapped(client,
> +							 ADT7410_REG_TEMP[i]);
> +			if (unlikely(status < 0)) {
> +				dev_dbg(dev,
> +					"ADT7410: Failed to read value: reg %d, error %d\n",

In general, you don't need the ADT7410: in the messages. That is what dev_d=
bg is
foe.

> +					ADT7410_REG_TEMP[i], status);
> +				ret =3D ERR_PTR(status);
> +				goto abort;
> +			}
> +			data->temp[i] =3D status;
> +		}
> +		status =3D i2c_smbus_read_byte_data(client, ADT7410_T_HYST);
> +			if (unlikely(status < 0)) {
> +				dev_dbg(dev,
> +					"ADT7410: Failed to read value: reg %d, error %d\n",
> +					ADT7410_T_HYST, status);
> +				ret =3D ERR_PTR(status);
> +				goto abort;
> +			}
> +			data->hyst =3D status;

Is there some alignment problem above or does it just look like it ?

> +		data->last_updated =3D jiffies;
> +		data->valid =3D true;
> +	}
> +
> +abort:
> +	mutex_unlock(&data->update_lock);
> +	return ret;
> +}
> +
> +static u16 ADT7410_TEMP_TO_REG(long temp)
> +{
> +	return DIV_ROUND_CLOSEST(SENSORS_LIMIT(temp, ADT7410_TEMP_MIN,
> +				    ADT7410_TEMP_MAX) * 128, 1000);
> +}
> +
> +static int ADT7410_REG_TO_TEMP(struct adt7410_data *data, u16 reg)
> +{
> +	/* in 13 bit mode, bits 0-2 are status flags - mask them out */
> +	if (!(data->config & ADT7410_RESOLUTION))
> +		reg &=3D ADT7410_T13_VALUE_MASK;
> +	/*
> +	 * temperature is stored in twos complement format, in steps of
> +	 * 1/128=B0C
> +	 */
> +	return DIV_ROUND_CLOSEST((s16)reg * 1000, 128);
> +}
> +
> +/*----------------------------------------------------------------------=
-*/
> +
> +/* sysfs attributes for hwmon */
> +
> +static ssize_t adt7410_show_temp(struct device *dev,
> +				 struct device_attribute *da, char *buf)
> +{
> +	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(da);
> +	struct adt7410_data *data =3D adt7410_update_device(dev);
> +
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
> +	return sprintf(buf, "%d\n", ADT7410_REG_TO_TEMP(data,
> +		       data->temp[attr->index]));
> +}
> +
> +static ssize_t adt7410_set_temp(struct device *dev,
> +				struct device_attribute *da,
> +				const char *buf, size_t count)
> +{
> +	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(da);
> +	struct i2c_client *client =3D to_i2c_client(dev);
> +	struct adt7410_data *data =3D i2c_get_clientdata(client);
> +	int nr =3D attr->index;
> +	long temp;
> +	int ret;
> +
> +	ret =3D kstrtol(buf, 10, &temp);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&data->update_lock);
> +	data->temp[nr] =3D ADT7410_TEMP_TO_REG(temp);
> +	ret =3D i2c_smbus_write_word_swapped(client, ADT7410_REG_TEMP[nr],
> +				     data->temp[nr]);
> +	if (ret)
> +		return ret;

Missing unlock. One possibility might be
	if (ret)
		count =3D ret;

> +	mutex_unlock(&data->update_lock);
> +	return count;
> +}
> +
> +static ssize_t adt7410_show_t_hyst(struct device *dev,
> +				   struct device_attribute *da,
> +				   char *buf)
> +{
> +	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(da);
> +	struct adt7410_data *data =3D adt7410_update_device(dev);
> +	int nr =3D attr->index;
> +
> +	/*
> +	 * hysteresis is stored as a 4 bit offset in the device, convert it
> +	 * to an absolute value
> +	 */
> +	if (nr =3D=3D 2)	/* min has positive offset, others have negative */
> +		return sprintf(buf, "%d\n",
> +			       ADT7410_REG_TO_TEMP(data, data->temp[nr])
> +			       + (data->hyst & ADT7410_T_HYST_MASK) * 1000);
> +	return sprintf(buf, "%d\n", ADT7410_REG_TO_TEMP(data, data->temp[nr])
> +		       - (data->hyst & ADT7410_T_HYST_MASK) * 1000);

How about this ?

	int hyst =3D (data->hyst & ADT7410_T_HYST_MASK) * 1000;

	if (nr =3D=3D 2)	/* min has positive offset, others have negative */
		hyst =3D -hyst;
=09
	return sprintf(buf, "%d\n",
		       ADT7410_REG_TO_TEMP(data, data->temp[nr]) - hyst);

> +}
> +
> +static ssize_t adt7410_set_t_hyst(struct device *dev,
> +				  struct device_attribute *da,
> +				  const char *buf, size_t count)
> +{
> +	struct i2c_client *client =3D to_i2c_client(dev);
> +	struct adt7410_data *data =3D i2c_get_clientdata(client);
> +	int ret;
> +	long hyst;
> +
> +	ret =3D kstrtol(buf, 10, &hyst);
> +	if (ret)
> +		return ret;
> +	/* convert absolute hysteresis value to a 4 bit delta value */
> +	hyst =3D DIV_ROUND_CLOSEST((data->temp[1] * 1000) / 128
> +				 - SENSORS_LIMIT(hyst, ADT7410_TEMP_MIN,
> +						 ADT7410_TEMP_MAX), 1000);
> +	data->hyst =3D SENSORS_LIMIT(hyst, 0, ADT7410_T_HYST_MASK);

I think there may be some sign problems in there again, if data->temp[1] is
negative.

This might work a bit better:

	int limit =3D ADT7410_REG_TO_TEMP(data, data->temp[attr->index]);
	hyst =3D SENSORS_LIMIT(hyst, ADT7410_TEMP_MIN, ADT7410_TEMP_MAX);
	if (attr->index =3D=3D 2)
		hyst =3D hyst - limit;
	else
		hyst =3D limit - hyst;

	data->hyst =3D SENSORS_LIMIT(DIV_ROUND_CLOSEST(hyst, 1000), 0,
				   ADT7410_T_HYST_MASK);

With this code, you can make all hyst attributes read-write, and even thoug=
h it
needs an additional variable I think it is a bit easier to read.

> +	ret =3D i2c_smbus_write_byte_data(client, ADT7410_T_HYST, data->hyst);
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +
> +static ssize_t adt7410_show_alarm(struct device *dev,
> +				  struct device_attribute *da,
> +				  char *buf)
> +{
> +	struct i2c_client *client =3D to_i2c_client(dev);
> +	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(da);
> +	int ret;
> +
> +	ret =3D i2c_smbus_read_byte_data(client, ADT7410_STATUS);
> +	if (ret < 0)
> +		return ret;
> +
> +	return sprintf(buf, "%d\n", !!(ret & attr->index));
> +}
> +
> +static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, adt7410_show_temp, NULL,=
 0);
> +static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO,
> +			  adt7410_show_temp, adt7410_set_temp, 1);
> +static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO,
> +			  adt7410_show_temp, adt7410_set_temp, 2);
> +static SENSOR_DEVICE_ATTR(temp1_crit, S_IWUSR | S_IRUGO,
> +			  adt7410_show_temp, adt7410_set_temp, 3);
> +static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IWUSR | S_IRUGO,
> +			  adt7410_show_t_hyst, adt7410_set_t_hyst, 1);
> +static SENSOR_DEVICE_ATTR(temp1_min_hyst, S_IWUSR | S_IRUGO,
> +			  adt7410_show_t_hyst, NULL, 2);
> +static SENSOR_DEVICE_ATTR(temp1_crit_hyst, S_IWUSR | S_IRUGO,
> +			  adt7410_show_t_hyst, NULL, 3);

Not a problem if you make all hyst attributes writable, but the current code
might have trouble with S_IWUSR and no write function.

> +static SENSOR_DEVICE_ATTR(temp1_min_alarm, S_IRUGO, adt7410_show_alarm,
> +			    NULL, ADT7410_STAT_T_LOW);
> +static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, adt7410_show_alarm,
> +			    NULL, ADT7410_STAT_T_HIGH);
> +static SENSOR_DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, adt7410_show_alarm,
> +			    NULL, ADT7410_STAT_T_CRIT);
> +
> +static struct attribute *adt7410_attributes[] =3D {
> +	&sensor_dev_attr_temp1_input.dev_attr.attr,
> +	&sensor_dev_attr_temp1_max.dev_attr.attr,
> +	&sensor_dev_attr_temp1_min.dev_attr.attr,
> +	&sensor_dev_attr_temp1_crit.dev_attr.attr,
> +	&sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
> +	&sensor_dev_attr_temp1_min_hyst.dev_attr.attr,
> +	&sensor_dev_attr_temp1_crit_hyst.dev_attr.attr,
> +	&sensor_dev_attr_temp1_min_alarm.dev_attr.attr,
> +	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
> +	&sensor_dev_attr_temp1_crit_alarm.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group adt7410_group =3D {
> +	.attrs =3D adt7410_attributes,
> +};
> +
> +/*----------------------------------------------------------------------=
-*/
> +
> +/* device probe and removal */
> +
> +static int adt7410_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
> +{
> +	struct adt7410_data *data;
> +	int ret, res;
> +
> +	if (!i2c_check_functionality(client->adapter,
> +			I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA))
> +		return -ENODEV;
> +
> +	data =3D devm_kzalloc(&client->dev, sizeof(struct adt7410_data),
> +			    GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, data);
> +	mutex_init(&data->update_lock);
> +
> +	/* configure as specified */
> +	ret =3D i2c_smbus_read_byte_data(client, ADT7410_CONFIG);
> +	if (ret < 0) {
> +		dev_dbg(&client->dev, "Can't read config? %d\n", ret);
> +		return ret;
> +	}
> +	data->oldconfig =3D ret;
> +	/*
> +	 * Set to 16 bit resolution, continous conversion and comparator mode.
> +	 */
> +	data->config =3D ret | ADT7410_FULL | ADT7410_RESOLUTION |
> +		       ADT7410_EVENT_MODE;
> +	if (data->config !=3D data->oldconfig) {
> +		ret =3D i2c_smbus_write_byte_data(client, ADT7410_CONFIG,
> +						data->config);
> +		if (ret)
> +			return ret;
> +	}
> +	dev_dbg(&client->dev, "Config %02x\n", data->config);
> +
> +	/* Register sysfs hooks */
> +	ret =3D sysfs_create_group(&client->dev.kobj, &adt7410_group);
> +	if (ret)
> +		goto exit_restore;
> +
> +	data->hwmon_dev =3D hwmon_device_register(&client->dev);
> +	if (IS_ERR(data->hwmon_dev)) {
> +		ret =3D PTR_ERR(data->hwmon_dev);
> +		goto exit_remove;
> +	}
> +
> +	dev_info(&client->dev, "sensor '%s'\n", client->name);
> +
> +	return 0;
> +
> +exit_remove:
> +	sysfs_remove_group(&client->dev.kobj, &adt7410_group);
> +exit_restore:
> +	res =3D i2c_smbus_write_byte_data(client, ADT7410_CONFIG,
> +					data->oldconfig);
> +	if (res)
> +		return res;

Don't check for an i2c error here. You are hiding the real error, and the c=
onfig
restore error is really irrelevant at this point.

> +	return ret;
> +}
> +
> +static int adt7410_remove(struct i2c_client *client)
> +{
> +	struct adt7410_data *data =3D i2c_get_clientdata(client);
> +	int ret;
> +
> +	hwmon_device_unregister(data->hwmon_dev);
> +	sysfs_remove_group(&client->dev.kobj, &adt7410_group);
> +	if (data->oldconfig !=3D data->config) {
> +		ret =3D i2c_smbus_write_byte_data(client, ADT7410_CONFIG,
> +						data->oldconfig);
> +		if (ret)
> +			return ret;

Returning an error here means the driver won't unload, which will cause all
kinds of problems. Just ignore the i2c error here, and don't return an erro=
r.

> +	}
> +	return 0;
> +}
> +
> +static const struct i2c_device_id adt7410_ids[] =3D {
> +	{ "adt7410", adt7410, },
> +	{ /* LIST END */ }
> +};
> +MODULE_DEVICE_TABLE(i2c, adt7410_ids);
> +
> +#ifdef CONFIG_PM
> +static int adt7410_suspend(struct device *dev)
> +{
> +	int ret;
> +	struct i2c_client *client =3D to_i2c_client(dev);
> +	struct adt7410_data *data =3D i2c_get_clientdata(client);
> +
> +	ret =3D i2c_smbus_write_byte_data(client, ADT7410_CONFIG,
> +					data->config | ADT7410_PD);
> +	return ret;
> +}
> +
> +static int adt7410_resume(struct device *dev)
> +{
> +	int ret;
> +	struct i2c_client *client =3D to_i2c_client(dev);
> +	struct adt7410_data *data =3D i2c_get_clientdata(client);
> +
> +	ret =3D i2c_smbus_write_byte_data(client, ADT7410_CONFIG, data->config);
> +	return ret;
> +}
> +
> +static const struct dev_pm_ops adt7410_dev_pm_ops =3D {
> +	.suspend	=3D adt7410_suspend,
> +	.resume		=3D adt7410_resume,
> +};
> +#define ADT7410_DEV_PM_OPS (&adt7410_dev_pm_ops)
> +#else
> +#define ADT7410_DEV_PM_OPS NULL
> +#endif /* CONFIG_PM */
> +
> +static struct i2c_driver adt7410_driver =3D {
> +	.class		=3D I2C_CLASS_HWMON,
> +	.driver =3D {
> +		.name	=3D "adt7410",
> +		.pm	=3D ADT7410_DEV_PM_OPS,
> +	},
> +	.probe		=3D adt7410_probe,
> +	.remove		=3D adt7410_remove,
> +	.id_table	=3D adt7410_ids,
> +	.address_list	=3D normal_i2c,
> +};
> +
> +module_i2c_driver(adt7410_driver);
> +
> +MODULE_AUTHOR("Hartmut Knaack");
> +MODULE_DESCRIPTION("ADT7410 driver");
> +MODULE_LICENSE("GPL");
>=20
>=20

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
