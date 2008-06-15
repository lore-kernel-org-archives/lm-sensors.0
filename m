From: Ben Dooks <ben-linux@fluff.org>
Date: Sun, 15 Jun 2008 18:23:11 +0000
Subject: Re: [lm-sensors] PATCH: hwmon-new-driver-ti-tmp401.patch
Message-Id: <20080615182311.GQ31817@trinity.fluff.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4853E081.1020109@hhs.nl>
In-Reply-To: <4853E081.1020109@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Jun 14, 2008 at 05:15:13PM +0200, Hans de Goede wrote:
> Hi All,
> 
> This is a new hwmon driver for TI's TMP401 temperature sensor IC. This 
> driver
> was written on behalf of an embedded systems vendor under the
> linuxdriverproject.
> 
> It has been tested using a TI TMP401 sample attached to a i2c-tiny-usb 
> adapter.
> Which was provided by Till Harbaum, many thanks to him for this!
> 
> Signed-off-by: Hans de Goede <j.w.r.degoede@hhs.nl>
> 
> Regards,
> 
> Hans

> This is a new hwmon driver for TI's TMP401 temperature sensor IC. This driver
> was written on behalf of an embedded systems vendor under the
> linuxdriverproject.
> 
> It has been tested using a TI TMP401 sample attached to a i2c-tiny-usb adapter.
> Which was provided by Till Harbaum, many thanks to him for this! 
> 
> Signed-off-by: Hans de Goede <j.w.r.degoede@hhs.nl>
> diff -up vanilla-2.6.26-rc5-git2/drivers/hwmon/Kconfig~ vanilla-2.6.26-rc5-git2/drivers/hwmon/Kconfig
> --- vanilla-2.6.26-rc5-git2/drivers/hwmon/Kconfig~	2008-06-14 16:51:14.000000000 +0200
> +++ vanilla-2.6.26-rc5-git2/drivers/hwmon/Kconfig	2008-06-14 16:51:14.000000000 +0200
> @@ -633,6 +633,16 @@ config SENSORS_THMC50
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called thmc50.
>  
> +config SENSORS_TMP401
> +	tristate "Texas Instruments TMP401"
> +	depends on I2C && EXPERIMENTAL
> +	help
> +	  If you say yes here you get support for Texas Instruments TMP401
> +	  temperature sensor chips.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called tmp401.
> +
>  config SENSORS_VIA686A
>  	tristate "VIA686A"
>  	depends on PCI
> diff -up vanilla-2.6.26-rc5-git2/drivers/hwmon/Makefile~ vanilla-2.6.26-rc5-git2/drivers/hwmon/Makefile
> --- vanilla-2.6.26-rc5-git2/drivers/hwmon/Makefile~	2008-06-14 16:52:19.000000000 +0200
> +++ vanilla-2.6.26-rc5-git2/drivers/hwmon/Makefile	2008-06-14 16:52:19.000000000 +0200
> @@ -66,6 +66,7 @@ obj-$(CONFIG_SENSORS_SMSC47B397)+= smsc4
>  obj-$(CONFIG_SENSORS_SMSC47M1)	+= smsc47m1.o
>  obj-$(CONFIG_SENSORS_SMSC47M192)+= smsc47m192.o
>  obj-$(CONFIG_SENSORS_THMC50)	+= thmc50.o
> +obj-$(CONFIG_SENSORS_TMP401)	+= tmp401.o
>  obj-$(CONFIG_SENSORS_VIA686A)	+= via686a.o
>  obj-$(CONFIG_SENSORS_VT1211)	+= vt1211.o
>  obj-$(CONFIG_SENSORS_VT8231)	+= vt8231.o
> diff -up vanilla-2.6.26-rc5-git2/drivers/hwmon/tmp401.c~ vanilla-2.6.26-rc5-git2/drivers/hwmon/tmp401.c
> --- vanilla-2.6.26-rc5-git2/drivers/hwmon/tmp401.c~	2008-06-14 17:04:10.000000000 +0200
> +++ vanilla-2.6.26-rc5-git2/drivers/hwmon/tmp401.c	2008-06-14 17:10:13.000000000 +0200
> @@ -0,0 +1,566 @@
> +/* tmp401.c
> + *
> + * Copyright (C) 2007 Hans de Goede <j.w.r.degoede@hhs.nl>
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
> + * Driver for the Texas Instruments TMP401 SMBUS temperature sensor IC.
> + *
> + * Note this IC is in some aspect similar to the lm90, but it has quite a
> + * few differences too, for example the local temp has a higher resolution
> + * and thus has 16 bits registers for its value and limit instead of 8 bits.
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
> +static unsigned short normal_i2c[] = { 0x4c, I2C_CLIENT_END };
> +
> +/* Insmod parameters */
> +I2C_CLIENT_INSMOD_1(tmp401);
> +
> +
> +/*
> + * The TMP401 registers, note some registers have different addresses for
> + * reading and writing
> + */
> +#define TMP401_STATUS				0x02
> +#define TMP401_CONFIG_READ			0x03
> +#define TMP401_CONFIG_WRITE			0x09
> +#define TMP401_CONVERSION_RATE_READ		0x04
> +#define TMP401_CONVERSION_RATE_WRITE		0x0A
> +#define TMP401_ONE_SHOT_START_WRITE		0x0F
> +#define TMP401_RESOLUTION			0x1A
> +#define TMP401_TEMP_CRIT_HYST			0x21
> +#define TMP401_CONSECUTIVE_ALERT		0x22
> +#define TMP401_MANUFACTURER_ID_REG		0xFE
> +#define TMP401_DEVICE_ID_REG			0xFF
> +
> +static const u8 TMP401_TEMP_MSB[2]			= { 0x00, 0x01 };
> +static const u8 TMP401_TEMP_LSB[2]			= { 0x15, 0x10 };
> +static const u8 TMP401_TEMP_LOW_LIMIT_MSB_READ[2]	= { 0x06, 0x08 };
> +static const u8 TMP401_TEMP_LOW_LIMIT_MSB_WRITE[2]	= { 0x0C, 0x0E };
> +static const u8 TMP401_TEMP_LOW_LIMIT_LSB[2]		= { 0x17, 0x14 };
> +static const u8 TMP401_TEMP_HIGH_LIMIT_MSB_READ[2]	= { 0x05, 0x07 };
> +static const u8 TMP401_TEMP_HIGH_LIMIT_MSB_WRITE[2]	= { 0x0B, 0x0D };
> +static const u8 TMP401_TEMP_HIGH_LIMIT_LSB[2]		= { 0x16, 0x13 };
> +/* These are called the THERM limit / hysteresis / mask in the datasheets */
> +static const u8 TMP401_TEMP_CRIT_LIMIT[2]		= { 0x20, 0x19 };
> +
> +/* Bit masks */
> +#define TMP401_CONFIG_RANGE_MASK		0x04
> +#define TMP401_CONFIG_SHUTDOWN_MASK		0x40
> +#define TMP401_STATUS_LOCAL_CRIT_MASK		0x01
> +#define TMP401_STATUS_REMOTE_CRIT_MASK		0x02
> +#define TMP401_STATUS_REMOTE_OPEN_MASK		0x04
> +#define TMP401_STATUS_REMOTE_LOW_MASK		0x08
> +#define TMP401_STATUS_REMOTE_HIGH_MASK		0x10
> +#define TMP401_STATUS_LOCAL_LOW_MASK		0x20
> +#define TMP401_STATUS_LOCAL_HIGH_MASK		0x40
> +
> +/* Manufacturer / Device ID's */
> +#define TMP401_MANUFACTURER_ID			0x55
> +#define TMP401_DEVICE_ID			0x11
> +
> +/* our driver name */
> +#define TMP401_NAME "tmp401"
> +
> +/*
> + * Functions declarations
> + */
> +
> +static void tmp401_init_client(struct i2c_client *client);
> +static int tmp401_attach_adapter(struct i2c_adapter *adapter);
> +static int tmp401_detach_client(struct i2c_client *client);
> +static struct tmp401_data *tmp401_update_device(struct device *dev);
> +
> +/*
> + * Driver data (common to all clients)
> + */
> +
> +static struct i2c_driver tmp401_driver = {
> +	.driver = {
> +		.name	= TMP401_NAME,

the .owner field is missing, ie:
		.owner	= THIS_MODULE,

> +	},
> +	.attach_adapter	= tmp401_attach_adapter,
> +	.detach_client	= tmp401_detach_client,
> +};

you should be using the new method of attaching the clients, as the
old driver methods are being removed as soon as possible. 

[snip]


> +
> +	if (data->status & mask)
> +		return sprintf(buf, "1\n");
> +	else
> +		return sprintf(buf, "0\n");
> +}

you should be using snprintf() or some other bounded printf method
against PAGE_SIZE, the return should be the length of the buffer.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
