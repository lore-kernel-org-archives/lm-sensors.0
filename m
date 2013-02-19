From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 19 Feb 2013 01:30:03 +0000
Subject: Re: [lm-sensors] [PATCH v2 2/4] hwmon: (adt7410) Add support for the adt7310/adt7320
Message-Id: <20130219013003.GB25124@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1361194739-16525-1-git-send-email-lars@metafoo.de>
 <1361194739-16525-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1361194739-16525-2-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jean Delvare <khali@linux-fr.org>, Hartmut Knaack <knaack.h@gmx.de>, Jonathan Cameron <jic23@cam.ac.uk>, lm-sensors@lm-sensors.org, linux-iio@vger.kernel.org

On Mon, Feb 18, 2013 at 02:38:57PM +0100, Lars-Peter Clausen wrote:
> The adt7310/adt7320 is the SPI version of the adt7410/adt7420. The regist=
er map
> layout is a bit different, i.e. the register addresses differ between the=
 two
> variants, but the bit layouts of the individual registers are identical. =
So both
> chip variants can easily be supported by the same driver. The issue of non
> matching register address layouts is solved by a simple look-up table whi=
ch
> translates the I2C addresses to the SPI addresses.
>=20
> The patch moves the bulk of the adt7410 driver to a common module that wi=
ll be
> shared by the adt7410 and adt7310 drivers. This common module implements =
the
> driver logic and uses a set of virtual functions to perform IO access. The
> adt7410 and adt7310 driver modules provide proper implementations of thes=
e IO
> accessor functions for I2C respective SPI.
>=20
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>=20
> ---
> Changes since v1:
> 	* Update the driver documentation to include ADT7310/ADT7320/ADT7420
> 	* Pass the result of the read methods via the return value instead of a
> 	  pointer argument
> 	* Simplify spi read methods by using spi_w8r8 and spi_w8r16
> 	* Update module description of the shared module
> 	* Fix some typos
> ---
>  Documentation/hwmon/adt7410 |  42 ++--
>  drivers/hwmon/Kconfig       |  20 ++
>  drivers/hwmon/Makefile      |   2 +
>  drivers/hwmon/adt7310.c     | 115 +++++++++++
>  drivers/hwmon/adt7410.c     | 464 +++-----------------------------------=
----
>  drivers/hwmon/adt7x10.c     | 476 ++++++++++++++++++++++++++++++++++++++=
++++++
>  drivers/hwmon/adt7x10.h     |  48 +++++
>  7 files changed, 720 insertions(+), 447 deletions(-)
>  create mode 100644 drivers/hwmon/adt7310.c
>  create mode 100644 drivers/hwmon/adt7x10.c
>  create mode 100644 drivers/hwmon/adt7x10.h
>=20
> diff --git a/Documentation/hwmon/adt7410 b/Documentation/hwmon/adt7410
> index 9600400..e452ae0 100644
> --- a/Documentation/hwmon/adt7410
> +++ b/Documentation/hwmon/adt7410
> @@ -7,25 +7,41 @@ Supported chips:
>      Addresses scanned: I2C 0x48 - 0x4B
>      Datasheet: Publicly available at the Analog Devices website
>                 http://www.analog.com/static/imported-files/data_sheets/A=
DT7410.pdf
> +  * Analog Devices ADT7420
> +    Prefix: 'adt7420'
> +    Addresses scanned: I2C 0x48 - 0x4B
> +    Datasheet: Publicly available at the Analog Devices website
> +               http://www.analog.com/static/imported-files/data_sheets/A=
DT7420.pdf
> +  * Analog Devices ADT7310
> +    Prefix: 'adt7310'
> +    Addresses scanned: I2C 0x48 - 0x4B
> +    Datasheet: Publicly available at the Analog Devices website
> +               http://www.analog.com/static/imported-files/data_sheets/A=
DT7310.pdf
> +  * Analog Devices ADT7320
> +    Prefix: 'adt7320'
> +    Addresses scanned: I2C 0x48 - 0x4B
> +    Datasheet: Publicly available at the Analog Devices website
> +               http://www.analog.com/static/imported-files/data_sheets/A=
DT7320.pdf
> =20
>  Author: Hartmut Knaack <knaack.h@gmx.de>
> =20
>  Description
>  -----------
> =20
> -The ADT7410 is a temperature sensor with rated temperature range of -55=
=B0C to
> -+150=B0C. It has a high accuracy of +/-0.5=B0C and can be operated at a =
resolution
> -of 13 bits (0.0625=B0C) or 16 bits (0.0078=B0C). The sensor provides an =
INT pin to
> -indicate that a minimum or maximum temperature set point has been exceed=
ed, as
> -well as a critical temperature (CT) pin to indicate that the critical
> -temperature set point has been exceeded. Both pins can be set up with a =
common
> -hysteresis of 0=B0C - 15=B0C and a fault queue, ranging from 1 to 4 even=
ts. Both
> -pins can individually set to be active-low or active-high, while the who=
le
> -device can either run in comparator mode or interrupt mode. The ADT7410
> -supports continous temperature sampling, as well as sampling one tempera=
ture
> -value per second or even justget one sample on demand for power saving.
> -Besides, it can completely power down its ADC, if power management is
> -required.
> +The ADT7410 and similar are a temperature sensors with rated temperature=
 range
> +of -55=B0C to +150=B0C (ADT7310/ADT7410) or -40=B0C to +150=B0C (ADT7320=
/ADT7420). They
> +have a high accuracy of +/-0.5=B0C (ADT7310/ADT7410) or +/-0.2C (ADT7430=
/ADT7420)
> +and can be operated at a resolution of 13 bits (0.0625=B0C) or 16 bits (=
0.0078=B0C).
> +The sensor provides an INT pin to indicate that a minimum or maximum tem=
perature
> +set point has been exceeded, as well as a critical temperature (CT) pin =
to
> +indicate that the critical temperature set point has been exceeded. Both=
 pins
> +can be set up with a common hysteresis of 0=B0C - 15=B0C and a fault que=
ue, ranging
> +from 1 to 4 events. Both pins can individually set to be active-low or
> +active-high, while the whole device can either run in comparator mode or
> +interrupt mode. The ADT7410 supports continous temperature sampling, as =
well as
> +sampling one temperature value per second or even justget one sample on =
demand
> +for power saving.  Besides, it can completely power down its ADC, if pow=
er
> +management is required.
> =20
>  Configuration Notes
>  -------------------
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 89ac1cb..aaa14f4 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -179,9 +179,29 @@ config SENSORS_ADM9240
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called adm9240.
> =20
> +config SENSORS_ADT7X10
> +	tristate
> +	help
> +	  This module contains common code shared by the ADT7310/ADT7320 and
> +	  ADT7410/ADT7420 temperature monitoring chip drivers.
> +
> +	  If build as a module, the module will be called adt7x10.
> +
> +config SENSORS_ADT7310
> +	tristate "Analog Devices ADT7310/ADT7320"
> +	depends on SPI_MASTER
> +	select SENSORS_ADT7X10
> +	help
> +	  If you say yes here you get support for the Analog Devices
> +	  ADT7310 and ADT7320 temperature monitoring chips.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called adt7310.
> +
>  config SENSORS_ADT7410
>  	tristate "Analog Devices ADT7410/ADT7420"
>  	depends on I2C
> +	select SENSORS_ADT7X10
>  	help
>  	  If you say yes here you get support for the Analog Devices
>  	  ADT7410 and ADT7420 temperature monitoring chips.
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 8d6d97e..5d36a57 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -34,6 +34,8 @@ obj-$(CONFIG_SENSORS_ADM9240)	+=3D adm9240.o
>  obj-$(CONFIG_SENSORS_ADS1015)	+=3D ads1015.o
>  obj-$(CONFIG_SENSORS_ADS7828)	+=3D ads7828.o
>  obj-$(CONFIG_SENSORS_ADS7871)	+=3D ads7871.o
> +obj-$(CONFIG_SENSORS_ADT7X10)	+=3D adt7x10.o
> +obj-$(CONFIG_SENSORS_ADT7310)	+=3D adt7310.o
>  obj-$(CONFIG_SENSORS_ADT7410)	+=3D adt7410.o
>  obj-$(CONFIG_SENSORS_ADT7411)	+=3D adt7411.o
>  obj-$(CONFIG_SENSORS_ADT7462)	+=3D adt7462.o
> diff --git a/drivers/hwmon/adt7310.c b/drivers/hwmon/adt7310.c
> new file mode 100644
> index 0000000..2196ac3
> --- /dev/null
> +++ b/drivers/hwmon/adt7310.c
> @@ -0,0 +1,115 @@
> +/*
> + * ADT7310/ADT7310 digital temperature sensor driver
> + *
> + * Copyright 2010-2013 Analog Devices Inc.

Not really; copyright is yours, unless you are signing it off to analog or =
if
you are working for them and have permission (or the duty) to sign off the
copyright. Even then it should be 2013 only for this file.

> + *   Author: Lars-Peter Clausen <lars@metafoo.de>
> + *
> + * Licensed under the GPL-2 or later.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/spi/spi.h>
> +#include <asm/unaligned.h>
> +
> +#include "adt7x10.h"
> +
> +static const u8 adt7310_reg_table[] =3D {
> +	[ADT7410_TEMPERATURE]   =3D ADT7310_TEMPERATURE,
> +	[ADT7410_STATUS]	=3D ADT7310_STATUS,
> +	[ADT7410_CONFIG]	=3D ADT7310_CONFIG,
> +	[ADT7410_T_ALARM_HIGH]	=3D ADT7310_T_ALARM_HIGH,
> +	[ADT7410_T_ALARM_LOW]	=3D ADT7310_T_ALARM_LOW,
> +	[ADT7410_T_CRIT]	=3D ADT7310_T_CRIT,
> +	[ADT7410_T_HYST]	=3D ADT7310_T_HYST,
> +	[ADT7410_ID]		=3D ADT7310_ID,
> +};
> +
> +#define ADT7310_CMD_REG_OFFSET	3
> +#define ADT7310_CMD_READ	0x40
> +
> +#define AD7310_COMMAND(reg) (adt7310_reg_table[(reg)] << ADT7310_CMD_REG=
_OFFSET)
> +
> +static int adt7310_spi_read_word(struct device *dev, u8 reg)
> +{
> +	struct spi_device *spi =3D to_spi_device(dev);
> +	int ret;
> +
> +	ret =3D spi_w8r16(spi, AD7310_COMMAND(reg) | ADT7310_CMD_READ);
> +	if (ret < 0)
> +		return ret;
> +
> +	return be16_to_cpu(ret);
> +}
> +
> +static int adt7310_spi_write_word(struct device *dev, u8 reg,
> +	u16 data)
> +{
> +	struct spi_device *spi =3D to_spi_device(dev);
> +	u8 buf[3];
> +
> +	buf[0] =3D AD7310_COMMAND(reg);
> +	put_unaligned_be16(data, &buf[1]);
> +
> +	return spi_write(spi, buf, sizeof(buf));
> +}
> +
> +static int adt7310_spi_read_byte(struct device *dev, u8 reg)
> +{
> +	struct spi_device *spi =3D to_spi_device(dev);
> +
> +	return spi_w8r8(spi, AD7310_COMMAND(reg) | ADT7310_CMD_READ);
> +}
> +
> +static int adt7310_spi_write_byte(struct device *dev, u8 reg,
> +	u8 data)
> +{
> +	struct spi_device *spi =3D to_spi_device(dev);
> +	u8 buf[2];
> +
> +	buf[0] =3D AD7310_COMMAND(reg);
> +	buf[1] =3D data;
> +
> +	return spi_write(spi, buf, sizeof(buf));
> +}
> +
> +static const struct adt7410_ops adt7310_spi_ops =3D {
> +	.read_word =3D adt7310_spi_read_word,
> +	.write_word =3D adt7310_spi_write_word,
> +	.read_byte =3D adt7310_spi_read_byte,
> +	.write_byte =3D adt7310_spi_write_byte,
> +};
> +
> +static int adt7310_spi_probe(struct spi_device *spi)
> +{
> +	return adt7410_probe(&spi->dev, spi_get_device_id(spi)->name,
> +			&adt7310_spi_ops);
> +}
> +
> +static int adt7310_spi_remove(struct spi_device *spi)
> +{
> +	return adt7410_remove(&spi->dev);
> +}
> +
> +static const struct spi_device_id adt7310_id[] =3D {
> +	{ "adt7310", 0 },
> +	{ "adt7320", 0 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(spi, adt7310_id);
> +
> +static struct spi_driver adt7310_driver =3D {
> +	.driver =3D {
> +		.name =3D "adt7310",
> +		.owner =3D THIS_MODULE,
> +		.pm	=3D ADT7410_DEV_PM_OPS,

Should probably be named ADT7X10_DEV_PM_OPS to avoid confusion.

> +	},
> +	.probe =3D adt7310_spi_probe,
> +	.remove =3D adt7310_spi_remove,
> +	.id_table =3D adt7310_id,
> +};
> +module_spi_driver(adt7310_driver);
> +
> +MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
> +MODULE_DESCRIPTION("ADT7310/ADT7320 driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/hwmon/adt7410.c b/drivers/hwmon/adt7410.c
> index b6acfa4..b500ab3 100644
> --- a/drivers/hwmon/adt7410.c
> +++ b/drivers/hwmon/adt7410.c
> @@ -1,485 +1,81 @@
>  /*
> - * adt7410.c - Part of lm_sensors, Linux kernel modules for hardware
> - *	 monitoring
> - * This driver handles the ADT7410 and compatible digital temperature se=
nsors.
> - * Hartmut Knaack <knaack.h@gmx.de> 2012-07-22
> - * based on lm75.c by Frodo Looijaard <frodol@dds.nl>
> - * and adt7410.c from iio-staging by Sonic Zhang <sonic.zhang@analog.com>
> + * ADT7410/ADT7420 digital temperature sensor driver
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> + * Copyright 2010-2013 Analog Devices Inc.
> + *   Author: Lars-Peter Clausen <lars@metafoo.de>

Same as before.

>   *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + * Licensed under the GPL-2 or later.
>   */
> =20
>  #include <linux/module.h>
>  #include <linux/init.h>
> -#include <linux/slab.h>
> -#include <linux/jiffies.h>
>  #include <linux/i2c.h>
> -#include <linux/hwmon.h>
> -#include <linux/hwmon-sysfs.h>
> -#include <linux/err.h>
> -#include <linux/mutex.h>
> -#include <linux/delay.h>
> -
> -/*
> - * ADT7410 registers definition
> - */
> -
> -#define ADT7410_TEMPERATURE		0
> -#define ADT7410_STATUS			2
> -#define ADT7410_CONFIG			3
> -#define ADT7410_T_ALARM_HIGH		4
> -#define ADT7410_T_ALARM_LOW		6
> -#define ADT7410_T_CRIT			8
> -#define ADT7410_T_HYST			0xA
> -
> -/*
> - * ADT7410 status
> - */
> -#define ADT7410_STAT_T_LOW		(1 << 4)
> -#define ADT7410_STAT_T_HIGH		(1 << 5)
> -#define ADT7410_STAT_T_CRIT		(1 << 6)
> -#define ADT7410_STAT_NOT_RDY		(1 << 7)
> =20
> -/*
> - * ADT7410 config
> - */
> -#define ADT7410_FAULT_QUEUE_MASK	(1 << 0 | 1 << 1)
> -#define ADT7410_CT_POLARITY		(1 << 2)
> -#define ADT7410_INT_POLARITY		(1 << 3)
> -#define ADT7410_EVENT_MODE		(1 << 4)
> -#define ADT7410_MODE_MASK		(1 << 5 | 1 << 6)
> -#define ADT7410_FULL			(0 << 5 | 0 << 6)
> -#define ADT7410_PD			(1 << 5 | 1 << 6)
> -#define ADT7410_RESOLUTION		(1 << 7)
> +#include "adt7x10.h"
> =20
> -/*
> - * ADT7410 masks
> - */
> -#define ADT7410_T13_VALUE_MASK			0xFFF8
> -#define ADT7410_T_HYST_MASK			0xF
> -
> -/* straight from the datasheet */
> -#define ADT7410_TEMP_MIN (-55000)
> -#define ADT7410_TEMP_MAX 150000
> -
> -enum adt7410_type {		/* keep sorted in alphabetical order */
> -	adt7410,
> -};
> -
> -static const u8 ADT7410_REG_TEMP[4] =3D {
> -	ADT7410_TEMPERATURE,		/* input */
> -	ADT7410_T_ALARM_HIGH,		/* high */
> -	ADT7410_T_ALARM_LOW,		/* low */
> -	ADT7410_T_CRIT,			/* critical */
> -};
> -
> -/* Each client has this additional data */
> -struct adt7410_data {
> -	struct device		*hwmon_dev;
> -	struct mutex		update_lock;
> -	u8			config;
> -	u8			oldconfig;
> -	bool			valid;		/* true if registers valid */
> -	unsigned long		last_updated;	/* In jiffies */
> -	s16			temp[4];	/* Register values,
> -						   0 =3D input
> -						   1 =3D high
> -						   2 =3D low
> -						   3 =3D critical */
> -	u8			hyst;		/* hysteresis offset */
> -};
> -
> -/*
> - * adt7410 register access by I2C
> - */
> -static int adt7410_temp_ready(struct i2c_client *client)
> +static int adt7410_i2c_read_word(struct device *dev, u8 reg)
>  {
> -	int i, status;
> -
> -	for (i =3D 0; i < 6; i++) {
> -		status =3D i2c_smbus_read_byte_data(client, ADT7410_STATUS);
> -		if (status < 0)
> -			return status;
> -		if (!(status & ADT7410_STAT_NOT_RDY))
> -			return 0;
> -		msleep(60);
> -	}
> -	return -ETIMEDOUT;
> +	return i2c_smbus_read_word_swapped(to_i2c_client(dev), reg);
>  }
> =20
> -static int adt7410_update_temp(struct device *dev)
> +static int adt7410_i2c_write_word(struct device *dev, u8 reg, u16 data)
>  {
> -	struct i2c_client *client =3D to_i2c_client(dev);
> -	struct adt7410_data *data =3D i2c_get_clientdata(client);
> -	int ret =3D 0;
> -
> -	mutex_lock(&data->update_lock);
> -
> -	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
> -	    || !data->valid) {
> -		int temp;
> -
> -		dev_dbg(&client->dev, "Starting update\n");
> -
> -		ret =3D adt7410_temp_ready(client); /* check for new value */
> -		if (ret)
> -			goto abort;
> -
> -		temp =3D i2c_smbus_read_word_swapped(client, ADT7410_REG_TEMP[0]);
> -		if (temp < 0) {
> -			ret =3D temp;
> -			dev_dbg(dev, "Failed to read value: reg %d, error %d\n",
> -				ADT7410_REG_TEMP[0], ret);
> -			goto abort;
> -		}
> -		data->temp[0] =3D temp;
> -
> -		data->last_updated =3D jiffies;
> -		data->valid =3D true;
> -	}
> -
> -abort:
> -	mutex_unlock(&data->update_lock);
> -	return ret;
> -}
> -
> -static int adt7410_fill_cache(struct i2c_client *client)
> -{
> -	struct adt7410_data *data =3D i2c_get_clientdata(client);
> -	int ret;
> -	int i;
> -
> -	for (i =3D 1; i < ARRAY_SIZE(ADT7410_REG_TEMP); i++) {
> -		ret =3D i2c_smbus_read_word_swapped(client, ADT7410_REG_TEMP[i]);
> -		if (ret < 0) {
> -			dev_dbg(&client->dev,
> -				"Failed to read value: reg %d, error %d\n",
> -				ADT7410_REG_TEMP[0], ret);
> -			return ret;
> -		}
> -		data->temp[i] =3D ret;
> -	}
> -
> -	ret =3D i2c_smbus_read_byte_data(client, ADT7410_T_HYST);
> -	if (ret < 0) {
> -		dev_dbg(&client->dev,
> -			"Failed to read value: hyst reg, error %d\n",
> -			ret);
> -		return ret;
> -	}
> -	data->hyst =3D ret;
> -
> -	return 0;
> +	return i2c_smbus_write_word_swapped(to_i2c_client(dev), reg, data);
>  }
> =20
> -static s16 ADT7410_TEMP_TO_REG(long temp)
> +static int adt7410_i2c_read_byte(struct device *dev, u8 reg)
>  {
> -	return DIV_ROUND_CLOSEST(clamp_val(temp, ADT7410_TEMP_MIN,
> -					   ADT7410_TEMP_MAX) * 128, 1000);
> +	return i2c_smbus_read_byte_data(to_i2c_client(dev), reg);
>  }
> =20
> -static int ADT7410_REG_TO_TEMP(struct adt7410_data *data, s16 reg)
> +static int adt7410_i2c_write_byte(struct device *dev, u8 reg, u8 data)
>  {
> -	/* in 13 bit mode, bits 0-2 are status flags - mask them out */
> -	if (!(data->config & ADT7410_RESOLUTION))
> -		reg &=3D ADT7410_T13_VALUE_MASK;
> -	/*
> -	 * temperature is stored in twos complement format, in steps of
> -	 * 1/128=B0C
> -	 */
> -	return DIV_ROUND_CLOSEST(reg * 1000, 128);
> +	return i2c_smbus_write_byte_data(to_i2c_client(dev), reg, data);
>  }
> =20
> -/*----------------------------------------------------------------------=
-*/
> -
> -/* sysfs attributes for hwmon */
> -
> -static ssize_t adt7410_show_temp(struct device *dev,
> -				 struct device_attribute *da, char *buf)
> -{
> -	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(da);
> -	struct i2c_client *client =3D to_i2c_client(dev);
> -	struct adt7410_data *data =3D i2c_get_clientdata(client);
> -
> -	if (attr->index =3D=3D 0) {
> -		int ret;
> -
> -		ret =3D adt7410_update_temp(dev);
> -		if (ret)
> -			return ret;
> -	}
> -
> -	return sprintf(buf, "%d\n", ADT7410_REG_TO_TEMP(data,
> -		       data->temp[attr->index]));
> -}
> -
> -static ssize_t adt7410_set_temp(struct device *dev,
> -				struct device_attribute *da,
> -				const char *buf, size_t count)
> -{
> -	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(da);
> -	struct i2c_client *client =3D to_i2c_client(dev);
> -	struct adt7410_data *data =3D i2c_get_clientdata(client);
> -	int nr =3D attr->index;
> -	long temp;
> -	int ret;
> -
> -	ret =3D kstrtol(buf, 10, &temp);
> -	if (ret)
> -		return ret;
> -
> -	mutex_lock(&data->update_lock);
> -	data->temp[nr] =3D ADT7410_TEMP_TO_REG(temp);
> -	ret =3D i2c_smbus_write_word_swapped(client, ADT7410_REG_TEMP[nr],
> -					   data->temp[nr]);
> -	if (ret)
> -		count =3D ret;
> -	mutex_unlock(&data->update_lock);
> -	return count;
> -}
> -
> -static ssize_t adt7410_show_t_hyst(struct device *dev,
> -				   struct device_attribute *da,
> -				   char *buf)
> -{
> -	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(da);
> -	struct i2c_client *client =3D to_i2c_client(dev);
> -	struct adt7410_data *data =3D i2c_get_clientdata(client);
> -	int nr =3D attr->index;
> -	int hyst;
> -
> -	hyst =3D (data->hyst & ADT7410_T_HYST_MASK) * 1000;
> -
> -	/*
> -	 * hysteresis is stored as a 4 bit offset in the device, convert it
> -	 * to an absolute value
> -	 */
> -	if (nr =3D=3D 2)	/* min has positive offset, others have negative */
> -		hyst =3D -hyst;
> -	return sprintf(buf, "%d\n",
> -		       ADT7410_REG_TO_TEMP(data, data->temp[nr]) - hyst);
> -}
> -
> -static ssize_t adt7410_set_t_hyst(struct device *dev,
> -				  struct device_attribute *da,
> -				  const char *buf, size_t count)
> -{
> -	struct i2c_client *client =3D to_i2c_client(dev);
> -	struct adt7410_data *data =3D i2c_get_clientdata(client);
> -	int limit, ret;
> -	long hyst;
> -
> -	ret =3D kstrtol(buf, 10, &hyst);
> -	if (ret)
> -		return ret;
> -	/* convert absolute hysteresis value to a 4 bit delta value */
> -	limit =3D ADT7410_REG_TO_TEMP(data, data->temp[1]);
> -	hyst =3D clamp_val(hyst, ADT7410_TEMP_MIN, ADT7410_TEMP_MAX);
> -	data->hyst =3D clamp_val(DIV_ROUND_CLOSEST(limit - hyst, 1000), 0,
> -			       ADT7410_T_HYST_MASK);
> -	ret =3D i2c_smbus_write_byte_data(client, ADT7410_T_HYST, data->hyst);
> -	if (ret)
> -		return ret;
> -
> -	return count;
> -}
> -
> -static ssize_t adt7410_show_alarm(struct device *dev,
> -				  struct device_attribute *da,
> -				  char *buf)
> -{
> -	struct i2c_client *client =3D to_i2c_client(dev);
> -	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(da);
> -	int ret;
> -
> -	ret =3D i2c_smbus_read_byte_data(client, ADT7410_STATUS);
> -	if (ret < 0)
> -		return ret;
> -
> -	return sprintf(buf, "%d\n", !!(ret & attr->index));
> -}
> -
> -static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, adt7410_show_temp, NULL,=
 0);
> -static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO,
> -			  adt7410_show_temp, adt7410_set_temp, 1);
> -static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO,
> -			  adt7410_show_temp, adt7410_set_temp, 2);
> -static SENSOR_DEVICE_ATTR(temp1_crit, S_IWUSR | S_IRUGO,
> -			  adt7410_show_temp, adt7410_set_temp, 3);
> -static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IWUSR | S_IRUGO,
> -			  adt7410_show_t_hyst, adt7410_set_t_hyst, 1);
> -static SENSOR_DEVICE_ATTR(temp1_min_hyst, S_IRUGO,
> -			  adt7410_show_t_hyst, NULL, 2);
> -static SENSOR_DEVICE_ATTR(temp1_crit_hyst, S_IRUGO,
> -			  adt7410_show_t_hyst, NULL, 3);
> -static SENSOR_DEVICE_ATTR(temp1_min_alarm, S_IRUGO, adt7410_show_alarm,
> -			  NULL, ADT7410_STAT_T_LOW);
> -static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, adt7410_show_alarm,
> -			  NULL, ADT7410_STAT_T_HIGH);
> -static SENSOR_DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, adt7410_show_alarm,
> -			  NULL, ADT7410_STAT_T_CRIT);
> -
> -static struct attribute *adt7410_attributes[] =3D {
> -	&sensor_dev_attr_temp1_input.dev_attr.attr,
> -	&sensor_dev_attr_temp1_max.dev_attr.attr,
> -	&sensor_dev_attr_temp1_min.dev_attr.attr,
> -	&sensor_dev_attr_temp1_crit.dev_attr.attr,
> -	&sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
> -	&sensor_dev_attr_temp1_min_hyst.dev_attr.attr,
> -	&sensor_dev_attr_temp1_crit_hyst.dev_attr.attr,
> -	&sensor_dev_attr_temp1_min_alarm.dev_attr.attr,
> -	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
> -	&sensor_dev_attr_temp1_crit_alarm.dev_attr.attr,
> -	NULL
> -};
> -
> -static const struct attribute_group adt7410_group =3D {
> -	.attrs =3D adt7410_attributes,
> +static const struct adt7410_ops adt7410_i2c_ops =3D {
> +	.read_word =3D adt7410_i2c_read_word,
> +	.write_word =3D adt7410_i2c_write_word,
> +	.read_byte =3D adt7410_i2c_read_byte,
> +	.write_byte =3D adt7410_i2c_write_byte,
>  };
> =20
> -/*----------------------------------------------------------------------=
-*/
> -
> -/* device probe and removal */
> -
> -static int adt7410_probe(struct i2c_client *client,
> -			 const struct i2c_device_id *id)
> +static int adt7410_i2c_probe(struct i2c_client *client,
> +	const struct i2c_device_id *id)
>  {
> -	struct adt7410_data *data;
> -	int ret;
> =20
>  	if (!i2c_check_functionality(client->adapter,
>  			I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA))
>  		return -ENODEV;
> =20
> -	data =3D devm_kzalloc(&client->dev, sizeof(struct adt7410_data),
> -			    GFP_KERNEL);
> -	if (!data)
> -		return -ENOMEM;
> -
> -	i2c_set_clientdata(client, data);
> -	mutex_init(&data->update_lock);
> -
> -	/* configure as specified */
> -	ret =3D i2c_smbus_read_byte_data(client, ADT7410_CONFIG);
> -	if (ret < 0) {
> -		dev_dbg(&client->dev, "Can't read config? %d\n", ret);
> -		return ret;
> -	}
> -	data->oldconfig =3D ret;
> -	/*
> -	 * Set to 16 bit resolution, continous conversion and comparator mode.
> -	 */
> -	ret &=3D ~ADT7410_MODE_MASK;
> -	data->config =3D ret | ADT7410_FULL | ADT7410_RESOLUTION |
> -			ADT7410_EVENT_MODE;
> -	if (data->config !=3D data->oldconfig) {
> -		ret =3D i2c_smbus_write_byte_data(client, ADT7410_CONFIG,
> -						data->config);
> -		if (ret)
> -			return ret;
> -	}
> -	dev_dbg(&client->dev, "Config %02x\n", data->config);
> -
> -	ret =3D adt7410_fill_cache(client);
> -	if (ret)
> -		goto exit_restore;
> -
> -	/* Register sysfs hooks */
> -	ret =3D sysfs_create_group(&client->dev.kobj, &adt7410_group);
> -	if (ret)
> -		goto exit_restore;
> -
> -	data->hwmon_dev =3D hwmon_device_register(&client->dev);
> -	if (IS_ERR(data->hwmon_dev)) {
> -		ret =3D PTR_ERR(data->hwmon_dev);
> -		goto exit_remove;
> -	}
> -
> -	dev_info(&client->dev, "sensor '%s'\n", client->name);
> -
> -	return 0;
> -
> -exit_remove:
> -	sysfs_remove_group(&client->dev.kobj, &adt7410_group);
> -exit_restore:
> -	i2c_smbus_write_byte_data(client, ADT7410_CONFIG, data->oldconfig);
> -	return ret;
> +	return adt7410_probe(&client->dev, NULL, &adt7410_i2c_ops);
>  }
> =20
> -static int adt7410_remove(struct i2c_client *client)
> +static int adt7410_i2c_remove(struct i2c_client *client)
>  {
> -	struct adt7410_data *data =3D i2c_get_clientdata(client);
> -
> -	hwmon_device_unregister(data->hwmon_dev);
> -	sysfs_remove_group(&client->dev.kobj, &adt7410_group);
> -	if (data->oldconfig !=3D data->config)
> -		i2c_smbus_write_byte_data(client, ADT7410_CONFIG,
> -					  data->oldconfig);
> -	return 0;
> +	return adt7410_remove(&client->dev);
>  }
> =20
>  static const struct i2c_device_id adt7410_ids[] =3D {
> -	{ "adt7410", adt7410, },
> -	{ "adt7420", adt7410, },
> -	{ /* LIST END */ }
> +	{ "adt7410", 0 },
> +	{ "adt7420", 0 },
> +	{}
>  };
>  MODULE_DEVICE_TABLE(i2c, adt7410_ids);
> =20
> -#ifdef CONFIG_PM_SLEEP
> -static int adt7410_suspend(struct device *dev)
> -{
> -	int ret;
> -	struct i2c_client *client =3D to_i2c_client(dev);
> -	struct adt7410_data *data =3D i2c_get_clientdata(client);
> -
> -	ret =3D i2c_smbus_write_byte_data(client, ADT7410_CONFIG,
> -					data->config | ADT7410_PD);
> -	return ret;
> -}
> -
> -static int adt7410_resume(struct device *dev)
> -{
> -	int ret;
> -	struct i2c_client *client =3D to_i2c_client(dev);
> -	struct adt7410_data *data =3D i2c_get_clientdata(client);
> -
> -	ret =3D i2c_smbus_write_byte_data(client, ADT7410_CONFIG, data->config);
> -	return ret;
> -}
> -
> -static SIMPLE_DEV_PM_OPS(adt7410_dev_pm_ops, adt7410_suspend, adt7410_re=
sume);
> -
> -#define ADT7410_DEV_PM_OPS (&adt7410_dev_pm_ops)
> -#else
> -#define ADT7410_DEV_PM_OPS NULL
> -#endif /* CONFIG_PM */
> -
>  static struct i2c_driver adt7410_driver =3D {
>  	.class		=3D I2C_CLASS_HWMON,
>  	.driver =3D {
>  		.name	=3D "adt7410",
>  		.pm	=3D ADT7410_DEV_PM_OPS,
>  	},
> -	.probe		=3D adt7410_probe,
> -	.remove		=3D adt7410_remove,
> +	.probe		=3D adt7410_i2c_probe,
> +	.remove		=3D adt7410_i2c_remove,
>  	.id_table	=3D adt7410_ids,
>  	.address_list	=3D I2C_ADDRS(0x48, 0x49, 0x4a, 0x4b),
>  };
> -
>  module_i2c_driver(adt7410_driver);
> =20
> -MODULE_AUTHOR("Hartmut Knaack");
> -MODULE_DESCRIPTION("ADT7410/ADT7420 driver");
> +MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
> +MODULE_DESCRIPTION("ADT7410/AD7420 driver");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/hwmon/adt7x10.c b/drivers/hwmon/adt7x10.c
> new file mode 100644
> index 0000000..eeff198c
> --- /dev/null
> +++ b/drivers/hwmon/adt7x10.c
> @@ -0,0 +1,476 @@
> +/*
> + * adt7410.c - Part of lm_sensors, Linux kernel modules for hardware

Needs file name and purpose update

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
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/err.h>
> +#include <linux/mutex.h>
> +#include <linux/delay.h>
> +
> +#include "adt7x10.h"
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
> +/* Each client has this additional data */
> +struct adt7410_data {
> +	const struct adt7410_ops *ops;
> +	const char		*name;
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
> +static int adt7410_read_byte(struct device *dev, u8 reg)
> +{
> +	struct adt7410_data *d =3D dev_get_drvdata(dev);
> +	return d->ops->read_byte(dev, reg);
> +}
> +
> +static int adt7410_write_byte(struct device *dev, u8 reg, u8 data)
> +{
> +	struct adt7410_data *d =3D dev_get_drvdata(dev);
> +	return d->ops->write_byte(dev, reg, data);
> +}
> +
> +static int adt7410_read_word(struct device *dev, u8 reg)
> +{
> +	struct adt7410_data *d =3D dev_get_drvdata(dev);
> +	return d->ops->read_word(dev, reg);
> +}
> +
> +static int adt7410_write_word(struct device *dev, u8 reg, u16 data)
> +{
> +	struct adt7410_data *d =3D dev_get_drvdata(dev);
> +	return d->ops->write_word(dev, reg, data);
> +}
> +
> +static const u8 ADT7410_REG_TEMP[4] =3D {
> +	ADT7410_TEMPERATURE,		/* input */
> +	ADT7410_T_ALARM_HIGH,		/* high */
> +	ADT7410_T_ALARM_LOW,		/* low */
> +	ADT7410_T_CRIT,			/* critical */
> +};
> +
> +static int adt7410_temp_ready(struct device *dev)
> +{
> +	int i, status;
> +
> +	for (i =3D 0; i < 6; i++) {
> +		status =3D adt7410_read_byte(dev, ADT7410_STATUS);
> +		if (status < 0)
> +			return status;
> +		if (!(status & ADT7410_STAT_NOT_RDY))
> +			return 0;
> +		msleep(60);
> +	}
> +	return -ETIMEDOUT;
> +}
> +
> +static int adt7410_update_temp(struct device *dev)
> +{
> +	struct adt7410_data *data =3D dev_get_drvdata(dev);
> +	int ret =3D 0;
> +
> +	mutex_lock(&data->update_lock);
> +
> +	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
> +	    || !data->valid) {
> +		int temp;
> +
> +		dev_dbg(dev, "Starting update\n");
> +
> +		ret =3D adt7410_temp_ready(dev); /* check for new value */
> +		if (ret)
> +			goto abort;
> +
> +		temp =3D adt7410_read_word(dev, ADT7410_REG_TEMP[0]);
> +		if (temp < 0) {
> +			ret =3D temp;
> +			dev_dbg(dev, "Failed to read value: reg %d, error %d\n",
> +				ADT7410_REG_TEMP[0], ret);
> +			goto abort;
> +		}
> +		data->temp[0] =3D temp;
> +		data->last_updated =3D jiffies;
> +		data->valid =3D true;
> +	}
> +
> +abort:
> +	mutex_unlock(&data->update_lock);
> +	return ret;
> +}
> +
> +static int adt7410_fill_cache(struct device *dev)
> +{
> +	struct adt7410_data *data =3D dev_get_drvdata(dev);
> +	int ret;
> +	int i;
> +
> +	for (i =3D 1; i < ARRAY_SIZE(data->temp); i++) {
> +		ret =3D adt7410_read_word(dev, ADT7410_REG_TEMP[i]);
> +		if (ret < 0) {
> +			dev_dbg(dev, "Failed to read value: reg %d, error %d\n",
> +				ADT7410_REG_TEMP[0], ret);

ADT7410_REG_TEMP[i] as Hartmut pointed out

> +			return ret;
> +		}
> +		data->temp[i] =3D ret;
> +	}
> +
> +	ret =3D adt7410_read_byte(dev, ADT7410_T_HYST);
> +	if (ret < 0) {
> +		dev_dbg(dev, "Failed to read value: reg %d, error %d\n",
> +				ADT7410_T_HYST, ret);
> +		return ret;
> +	}
> +	data->hyst =3D ret;
> +
> +	return 0;
> +}
> +
> +static s16 ADT7410_TEMP_TO_REG(long temp)
> +{
> +	return DIV_ROUND_CLOSEST(clamp_val(temp, ADT7410_TEMP_MIN,
> +					       ADT7410_TEMP_MAX) * 128, 1000);
> +}
> +
> +static int ADT7410_REG_TO_TEMP(struct adt7410_data *data, s16 reg)
> +{
> +	/* in 13 bit mode, bits 0-2 are status flags - mask them out */
> +	if (!(data->config & ADT7410_RESOLUTION))
> +		reg &=3D ADT7410_T13_VALUE_MASK;
> +	/*
> +	 * temperature is stored in twos complement format, in steps of
> +	 * 1/128=B0C
> +	 */
> +	return DIV_ROUND_CLOSEST(reg * 1000, 128);
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
> +	struct adt7410_data *data =3D dev_get_drvdata(dev);
> +
> +
> +	if (attr->index =3D=3D 0) {
> +		int ret;
> +
> +		ret =3D adt7410_update_temp(dev);
> +		if (ret)
> +			return ret;
> +	}
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
> +	struct adt7410_data *data =3D dev_get_drvdata(dev);
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
> +	ret =3D adt7410_write_word(dev, ADT7410_REG_TEMP[nr], data->temp[nr]);
> +	if (ret)
> +		count =3D ret;
> +	mutex_unlock(&data->update_lock);
> +	return count;
> +}
> +
> +static ssize_t adt7410_show_t_hyst(struct device *dev,
> +				   struct device_attribute *da,
> +				   char *buf)
> +{
> +	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(da);
> +	struct adt7410_data *data =3D dev_get_drvdata(dev);
> +	int nr =3D attr->index;
> +	int hyst;
> +
> +	hyst =3D (data->hyst & ADT7410_T_HYST_MASK) * 1000;
> +
> +	/*
> +	 * hysteresis is stored as a 4 bit offset in the device, convert it
> +	 * to an absolute value
> +	 */
> +	if (nr =3D=3D 2)	/* min has positive offset, others have negative */
> +		hyst =3D -hyst;
> +	return sprintf(buf, "%d\n",
> +		       ADT7410_REG_TO_TEMP(data, data->temp[nr]) - hyst);
> +}
> +
> +static ssize_t adt7410_set_t_hyst(struct device *dev,
> +				  struct device_attribute *da,
> +				  const char *buf, size_t count)
> +{
> +	struct adt7410_data *data =3D dev_get_drvdata(dev);
> +	int limit, ret;
> +	long hyst;
> +
> +	ret =3D kstrtol(buf, 10, &hyst);
> +	if (ret)
> +		return ret;
> +	/* convert absolute hysteresis value to a 4 bit delta value */
> +	limit =3D ADT7410_REG_TO_TEMP(data, data->temp[1]);
> +	hyst =3D clamp_val(hyst, ADT7410_TEMP_MIN, ADT7410_TEMP_MAX);
> +	data->hyst =3D clamp_val(DIV_ROUND_CLOSEST(limit - hyst, 1000),
> +				   0, ADT7410_T_HYST_MASK);
> +	ret =3D adt7410_write_byte(dev, ADT7410_T_HYST, data->hyst);
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
> +	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(da);
> +	int ret;
> +
> +	ret =3D adt7410_read_byte(dev, ADT7410_STATUS);
> +	if (ret < 0)
> +		return ret;
> +
> +	return sprintf(buf, "%d\n", !!(ret & attr->index));
> +}
> +
> +static ssize_t adt7410_show_name(struct device *dev,
> +				  struct device_attribute *da, char *buf)
> +{
> +	struct adt7410_data *data =3D dev_get_drvdata(dev);
> +
> +	return sprintf(buf, "%s\n", data->name);
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
> +static SENSOR_DEVICE_ATTR(temp1_min_hyst, S_IRUGO,
> +			  adt7410_show_t_hyst, NULL, 2);
> +static SENSOR_DEVICE_ATTR(temp1_crit_hyst, S_IRUGO,
> +			  adt7410_show_t_hyst, NULL, 3);
> +static SENSOR_DEVICE_ATTR(temp1_min_alarm, S_IRUGO, adt7410_show_alarm,
> +			  NULL, ADT7410_STAT_T_LOW);
> +static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, adt7410_show_alarm,
> +			  NULL, ADT7410_STAT_T_HIGH);
> +static SENSOR_DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, adt7410_show_alarm,
> +			  NULL, ADT7410_STAT_T_CRIT);
> +static DEVICE_ATTR(name, S_IRUGO, adt7410_show_name, NULL);
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
> +int adt7410_probe(struct device *dev, const char *name,
> +	const struct adt7410_ops *ops)

Preferred alignment is to have the second line start at the (. Usually I do=
n't
complain but since you'll have to do another rev anyway maybe you can fix t=
his
whereever it occurs.

> +{
> +	struct adt7410_data *data;
> +	int ret;
> +
> +	data =3D devm_kzalloc(dev, sizeof(struct adt7410_data),
> +			    GFP_KERNEL);

No need to split the line above.

> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->ops =3D ops;
> +	data->name =3D name;
> +
> +	dev_set_drvdata(dev, data);
> +	mutex_init(&data->update_lock);
> +
> +	/* configure as specified */
> +	ret =3D adt7410_read_byte(dev, ADT7410_CONFIG);
> +	if (ret < 0) {
> +		dev_dbg(dev, "Can't read config? %d\n", ret);
> +		return ret;
> +	}
> +	data->oldconfig =3D ret;
> +
> +	/*
> +	 * Set to 16 bit resolution, continous conversion and comparator mode.
> +	 */
> +	data->config =3D data->oldconfig;
> +	data->config &=3D ~ADT7410_MODE_MASK;
> +	data->config |=3D ADT7410_FULL | ADT7410_RESOLUTION | ADT7410_EVENT_MOD=
E;
> +	if (data->config !=3D data->oldconfig) {
> +		ret =3D adt7410_write_byte(dev, ADT7410_CONFIG, data->config);
> +		if (ret)
> +			return ret;
> +	}
> +	dev_dbg(dev, "Config %02x\n", data->config);
> +
> +	ret =3D adt7410_fill_cache(dev);
> +	if (ret)
> +		goto exit_restore;
> +
> +	/* Register sysfs hooks */
> +	ret =3D sysfs_create_group(&dev->kobj, &adt7410_group);
> +	if (ret)
> +		goto exit_restore;
> +
> +	/*
> +	 * The I2C device will already have it's own 'name' attribute, but for
> +	 * the SPI device we need to register it. name will only be non NULL if
> +	 * the device doesn't register the 'name' attribute on its own.
> +	 */
> +	if (name) {
> +		ret =3D device_create_file(dev, &dev_attr_name);
> +		if (ret)
> +			goto exit_remove;
> +	}
> +
> +	data->hwmon_dev =3D hwmon_device_register(dev);
> +	if (IS_ERR(data->hwmon_dev)) {
> +		ret =3D PTR_ERR(data->hwmon_dev);
> +		goto exit_remove_name;
> +	}
> +
> +	return 0;
> +
> +exit_remove_name:
> +	if (name)
> +		device_remove_file(dev, &dev_attr_name);
> +exit_remove:
> +	sysfs_remove_group(&dev->kobj, &adt7410_group);
> +exit_restore:
> +	adt7410_write_byte(dev, ADT7410_CONFIG, data->oldconfig);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(adt7410_probe);
> +
> +int adt7410_remove(struct device *dev)
> +{
> +	struct adt7410_data *data =3D dev_get_drvdata(dev);
> +
> +	hwmon_device_unregister(data->hwmon_dev);
> +	if (data->name)
> +		device_remove_file(dev, &dev_attr_name);
> +	sysfs_remove_group(&dev->kobj, &adt7410_group);
> +	if (data->oldconfig !=3D data->config)
> +		adt7410_write_byte(dev, ADT7410_CONFIG,
> +					  data->oldconfig);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(adt7410_remove);
> +
> +#ifdef CONFIG_PM_SLEEP
> +
> +static int adt7410_suspend(struct device *dev)
> +{
> +	struct adt7410_data *data =3D dev_get_drvdata(dev);
> +
> +	return adt7410_write_byte(dev, ADT7410_CONFIG,
> +		data->config | ADT7410_PD);
> +}
> +
> +static int adt7410_resume(struct device *dev)
> +{
> +	struct adt7410_data *data =3D dev_get_drvdata(dev);
> +
> +	return adt7410_write_byte(dev, ADT7410_CONFIG, data->config);
> +}
> +
> +SIMPLE_DEV_PM_OPS(adt7410_dev_pm_ops, adt7410_suspend, adt7410_resume);
> +EXPORT_SYMBOL_GPL(adt7410_dev_pm_ops);
> +
> +#endif /* CONFIG_PM_SLEEP */
> +
> +MODULE_AUTHOR("Hartmut Knaack");
> +MODULE_DESCRIPTION("ADT7410/ADT7420, ADT7310/ADT7320 common code");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/hwmon/adt7x10.h b/drivers/hwmon/adt7x10.h
> new file mode 100644
> index 0000000..a7165e6
> --- /dev/null
> +++ b/drivers/hwmon/adt7x10.h
> @@ -0,0 +1,48 @@
> +#ifndef __HWMON_ADT7X10_H__
> +#define __HWMON_ADT7X10_H__
> +
> +#include <linux/types.h>
> +#include <linux/pm.h>
> +
> +/* ADT7410 registers definition */
> +#define ADT7410_TEMPERATURE		0
> +#define ADT7410_STATUS			2
> +#define ADT7410_CONFIG			3
> +#define ADT7410_T_ALARM_HIGH		4
> +#define ADT7410_T_ALARM_LOW		6
> +#define ADT7410_T_CRIT			8
> +#define ADT7410_T_HYST			0xA
> +#define ADT7410_ID			0xB
> +
> +/* ADT7310 registers definition */
> +#define ADT7310_STATUS			0
> +#define ADT7310_CONFIG			1
> +#define ADT7310_TEMPERATURE		2
> +#define ADT7310_ID			3
> +#define ADT7310_T_CRIT			4
> +#define ADT7310_T_HYST			5
> +#define ADT7310_T_ALARM_HIGH		6
> +#define ADT7310_T_ALARM_LOW		7
> +
> +struct device;
> +
> +struct adt7410_ops {
> +	int (*read_byte)(struct device *, u8 reg);
> +	int (*write_byte)(struct device *, u8 reg, u8 data);
> +	int (*read_word)(struct device *, u8 reg);
> +	int (*write_word)(struct device *, u8 reg, u16 data);
> +};
> +
> +int adt7410_probe(struct device *dev, const char *name,
> +	const struct adt7410_ops *ops);
> +int adt7410_remove(struct device *dev);
> +

I think the above should be adt7x10_ops, adt7x10_probe and adt7x10_remove, =
to
indicate that those are common functions.

I would actually suggest to rename all functions in adt7x10.c (not just the
exported ones).

> +
> +#ifdef CONFIG_PM_SLEEP
> +extern const struct dev_pm_ops adt7410_dev_pm_ops;
> +#define ADT7410_DEV_PM_OPS (&adt7410_dev_pm_ops)

As mentioned above, I think ADT7X10_DEV_PM_OPS would be better here.

> +#else
> +#define ADT7410_DEV_PM_OPS NULL
> +#endif
> +
> +#endif
> --=20
> 1.8.0
>=20
>=20

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
