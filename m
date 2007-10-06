From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 06 Oct 2007 18:22:02 +0000
Subject: Re: [lm-sensors] PATCH: hwmon-fschmd-new-driver.patch
Message-Id: <20071006202202.307b00be@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <46F3D714.1030104@hhs.nl>
In-Reply-To: <46F3D714.1030104@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Hans,

On Fri, 21 Sep 2007 16:37:08 +0200, Hans de Goede wrote:
> This patch adds a new merged driver for FSC sensor chips, it merges the f=
scher
> and fscpos drivers and adds support for the FSC Scylla, Heracles and Heim=
dall
> chips.
>=20
> This version of the driver has the following changes compared to the last
> version posted to the lm-sensors list:
> -bitmasks used changed from 0x0X to defines for better readability
> -fan#_fault fault entries were added, these signal wether or not a fan is
>   detected on the tachometer of fan#.
>=20
> Signed-off-by: Hans de Goede <j.w.r.degoede@hhs.nl>
>=20
> Reviews much appreciated!

Here you go.

First of all: you need to update your driver to comply with the recent
changes that were made to hwmon_device_register(). The patch in
question is in Mark's testing tree under the name "hwmon: Convert from
class_device to device".

> diff -urN linux-2.6.23-rc6.git4/drivers/hwmon.orig/Kconfig linux-2.6.23-r=
c6.git4/drivers/hwmon/Kconfig
> --- linux-2.6.23-rc6.git4/drivers/hwmon.orig/Kconfig	2007-09-21 15:33:20.=
000000000 +0200
> +++ linux-2.6.23-rc6.git4/drivers/hwmon/Kconfig	2007-09-21 16:26:34.00000=
0000 +0200
> @@ -236,6 +236,20 @@
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called fscpos.
> =20
> +config SENSORS_FSCHMD
> +	tristate "FSC Poseidon, Hermes, Scylla, Heracles and Heimdall"

In chronological order, Scylla would come before Hermes, and Heracles
would be last.

> +	depends on I2C && HWMON && EXPERIMENTAL

Dependency upon HWMON is now handled at menu level, so you don't have
to mention it here.

You could depend on X86 as I did for fscpos and fscher recently, so
that this configuration entry is hidden for architectures where this
family of chips simply can't be there.

> +	help
> +	  If you say yes here you get support for various Fujitsu Siemens
> +	  Computers sensor chips.
> +
> +	  This is a new merged driver for FSC sensor chips which is intended
> +	  as replacment for the fscpos and fscher drivers and adds support
> +	  for several other FCS sensor chips.

It also replaces the fscscy driver (which was never ported to Linux 2.6
but still existed for Linux 2.4 in lm-sensors).

> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called fschmd.
> +
>  config SENSORS_GL518SM
>  	tristate "Genesys Logic GL518SM"
>  	depends on I2C
> diff -urN linux-2.6.23-rc6.git4/drivers/hwmon.orig/Makefile linux-2.6.23-=
rc6.git4/drivers/hwmon/Makefile
> --- linux-2.6.23-rc6.git4/drivers/hwmon.orig/Makefile	2007-09-21 15:33:20=
.000000000 +0200
> +++ linux-2.6.23-rc6.git4/drivers/hwmon/Makefile	2007-09-21 16:27:45.0000=
00000 +0200
> @@ -30,6 +30,7 @@
>  obj-$(CONFIG_SENSORS_DS1621)	+=3D ds1621.o
>  obj-$(CONFIG_SENSORS_F71805F)	+=3D f71805f.o
>  obj-$(CONFIG_SENSORS_FSCHER)	+=3D fscher.o
> +obj-$(CONFIG_SENSORS_FSCHMD)	+=3D fschmd.o
>  obj-$(CONFIG_SENSORS_FSCPOS)	+=3D fscpos.o
>  obj-$(CONFIG_SENSORS_GL518SM)	+=3D gl518sm.o
>  obj-$(CONFIG_SENSORS_GL520SM)	+=3D gl520sm.o
> diff -urN linux-2.6.23-rc6.git4/drivers/hwmon.orig/fschmd.c linux-2.6.23-=
rc6.git4/drivers/hwmon/fschmd.c
> --- linux-2.6.23-rc6.git4/drivers/hwmon.orig/fschmd.c	1970-01-01 01:00:00=
.000000000 +0100
> +++ linux-2.6.23-rc6.git4/drivers/hwmon/fschmd.c	2007-09-21 15:57:58.0000=
00000 +0200
> @@ -0,0 +1,762 @@
> +/*
> + * fschmd.c - Part of lm_sensors, Linux kernel modules for hardware
> + * monitoring

Technically speaking, Linux 2.6 drivers are no longer part of
lm-sensors.

> + * Copyright (C) 2007 Hans de Goede <j.w.r.degoede@hhs.nl>
> + *=20
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *=20
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *=20
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +/*=20
> + *  New merged Fujitsu Siemens hwmon driver, supporting the Poseidon, He=
rmes,

"New" doesn't really belong there. When people read this 10 years from
now, your driver will no longer be new.

> + *  Scylla, Heracles and Heimdall chips
> + *
> + *  Based on the original 2.4 fscscy, 2.6 fscpos, 2.6 fscher and 2.6
> + *  (candidate) fschmd drivers:
> + *  Copyright (C) 2006 Thilo Cestonaro <thilo.cestonaro.external@fujitsu=
-siemens.com>

Line longer than 80 columns.

> + *  Copyright (C) 2003, 2004 Reinhard Nissl <rnissl@gmx.de>
> + *  Copyright (C) 2000 Hermann Jung <hej@odn.de>
> + *  Copyright (C) 1998, 1999 Frodo Looijaard <frodol@dds.nl>
> + *  and Philip Edelbrock <phil@netroedge.com>

Frodo and Philip were credited only because the fsc drivers were
conceptually based on theirs. There's so little in common between these
old Linux 2.4 drivers and what we do now that you can probably omit
them here.

OTOH it would seem fair to credit Stefan Ott for the Linux 2.6 fscpos
driver, and possibly Martin Knoblauch for the Linux 2.4 fscscy driver.

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
> +static unsigned short normal_i2c[] =3D { 0x73, I2C_CLIENT_END };
> +
> +/* Insmod parameters */
> +I2C_CLIENT_INSMOD_5(fscpos, fscher, fscscy, fschrc, fschmd);
> +
> +/*
> + * The FSCHMD registers and other defines
> + */
> +
> +/* chip identification */
> +#define FSCHMD_REG_IDENT_0		0x00
> +#define FSCHMD_REG_IDENT_1		0x01
> +#define FSCHMD_REG_IDENT_2		0x02
> +#define FSCHMD_REG_REVISION		0x03
> +
> +/* global control and status */
> +#define FSCHMD_REG_EVENT_STATE		0x04
> +#define FSCHMD_REG_CONTROL		0x05
> +
> +/* watchdog (support to be implemented) */
> +#define FSCHMD_REG_WDOG_PRESET		0x28
> +#define FSCHMD_REG_WDOG_STATE		0x23
> +#define FSCHMD_REG_WDOG_CONTROL		0x21
> +
> +/* voltage supervision */
> +#define FSCHMD_REG_VOLT_12		0x45
> +#define FSCHMD_REG_VOLT_5		0x42
> +#define FSCHMD_REG_VOLT_BATT		0x48

Putting these in an array as you do for fan and temperature values
would allow for code cleanups.

> +
> +/* minimum pwm at which the fan is driven (pwm can by increased dependin=
g on
> +   the temp. Notice that for the scy some fans share there minimum speed.
> +   Also notice that with the scy the sensor order is different then with=
 the
> +   other chips, this order was in the 2.4 driver and kept for consistenc=
y. */
> +static const u8 FSCHMD_REG_FAN_MIN[5][6] =3D {
> +	{ 0x55, 0x65 },					/* pos */

If you want to be consistent with the definition of
FSCHMD_REG_TEMP_LIMIT[0] below, you should add a 0 in 3rd position.

> +	{ 0x55, 0x65, 0xb5 },				/* her */
> +	{ 0x65, 0x65, 0x55, 0xa5, 0x55, 0xa5 },		/* scy */
> +	{ 0x55, 0x65, 0xa5, 0xb5 },			/* hrc */
> +	{ 0x55, 0x65, 0xa5, 0xb5, 0xc5 } };		/* hmd */

The closing curly brace and semicolon should go to the next line, with
a comma at the end of this line, so that support for a new chip can be
added with minimum noise. Same for all other defines below.

> +
> +/* actual fan speed */=09
> +static const u8 FSCHMD_REG_FAN_ACT[5][6] =3D {
> +	{ 0x0e, 0x6b, 0xab },				/* pos */
> +	{ 0x0e, 0x6b, 0xbb },				/* her */
> +	{ 0x6b, 0x6c, 0x0e, 0xab, 0x5c, 0xbb },		/* scy */
> +	{ 0x0e, 0x6b, 0xab, 0xbb },			/* hrc */
> +	{ 0x5b, 0x6b, 0xab, 0xbb, 0xcb } };		/* hmd */
> +
> +/* fan status registers */
> +static const u8 FSCHMD_REG_FAN_STATE[5][6] =3D {
> +	{ 0x0d, 0x62, 0xa2 },				/* pos */
> +	{ 0x0d, 0x62, 0xb2 },				/* her */
> +	{ 0x62, 0x61, 0x0d, 0xa2, 0x52, 0xb2 },		/* scy */
> +	{ 0x0d, 0x62, 0xa2, 0xb2 },			/* hrc */
> +	{ 0x52, 0x62, 0xa2, 0xb2, 0xc2 } };		/* hmd */
> +=09
> +/* fan ripple / divider registers */=09
> +static const u8 FSCHMD_REG_FAN_RIPPLE[5][6] =3D {
> +	{ 0x0f, 0x6f, 0xaf },				/* pos */
> +	{ 0x0f, 0x6f, 0xbf },				/* her */
> +	{ 0x6f, 0x6f, 0x0f, 0xaf, 0x0f, 0xbf },		/* scy */
> +	{ 0x0f, 0x6f, 0xaf, 0xbf },			/* hrc */
> +	{ 0x5f, 0x6f, 0xaf, 0xbf, 0xcf } };		/* hmd */
> +
> +static const int FSCHMD_NO_FAN_SENSORS[5] =3D { 3, 3, 6, 4, 5 };
> +
> +/* Fan status register bitmasks */
> +#define FSCHMD_FAN_ALARM_MASK		0x04 /* called fault by FSC! */
> +#define FSCHMD_FAN_NOT_PRESENT_MASK	0x08 /* not documented */
> +
> +
> +/* actual temperature registers */
> +static const u8 FSCHMD_REG_TEMP_ACT[5][5] =3D {
> +	{ 0x64, 0x32, 0x35 },				/* pos */
> +	{ 0x64, 0x32, 0x35 },				/* her */
> +	{ 0x64, 0xD0, 0x32, 0x35 },			/* scy */
> +	{ 0x64, 0x32, 0x35 },				/* hrc */
> +	{ 0x70, 0x80, 0x90, 0xd0, 0xe0 } };		/* hmd */
> +
> +/* temperature state registers */
> +static const u8 FSCHMD_REG_TEMP_STATE[5][5] =3D {
> +	{ 0x71, 0x81, 0x91 },				/* pos */
> +	{ 0x71, 0x81, 0x91 },				/* her */
> +	{ 0x71, 0xd1, 0x81, 0x91 },			/* scy */
> +	{ 0x71, 0x81, 0x91 },				/* hrc */
> +	{ 0x71, 0x81, 0x91, 0xd1, 0xe1 } };		/*=A0hmd */
> +
> +/* temperature high limit registers, FSC does not document these. Proven=
 to be
> +   there with field testing on the fscher and fschrc, already supported =
/ used
> +   in the fscscy 2.4 driver. FSC has confirmed that the fschmd has regis=
ters
> +   at these addresses, but doesn't want to confirm they are the same as =
with
> +   the fscher?? */
> +static const u8 FSCHMD_REG_TEMP_LIMIT[5][5] =3D {
> +	{ 0, 0, 0 },					/* pos */
> +	{ 0x76, 0x86, 0x96 },				/* her */
> +	{ 0x76, 0xd6, 0x86, 0x96 },			/* scy */
> +	{ 0x76, 0x86, 0x96 },				/* hrc */
> +	{ 0x76, 0x86, 0x96, 0xd6, 0xe6 } };		/*=A0hmd */=09
> +
> +/* These were found through experimenting with an fscher, currently they=
 are
> +   not used, but we keep them around for future reference.
> +static const u8 FSCHER_REG_TEMP_AUTOP1[] =3D	{ 0x73, 0x83, 0x93 };
> +static const u8 FSCHER_REG_TEMP_AUTOP2[] =3D	{ 0x75, 0x85, 0x95 }; */
> +
> +static const int FSCHMD_NO_TEMP_SENSORS[5] =3D { 3, 3, 4, 3, 5 };
> +
> +/* temp status register bitmasks */
> +#define FSCHMD_TEMP_WORKING_MASK	0x01
> +#define FSCHMD_TEMP_ALERT_MASK		0x02
> +/* there only really is an alarm if the sensor is working and alert =3D =
1 */
> +#define FSCHMD_TEMP_ALARM_MASK \
> +	(FSCHMD_TEMP_WORKING_MASK | FSCHMD_TEMP_ALERT_MASK)
> +
> +/* our driver name */
> +#define FSCHMD_NAME "fschmd"
> +
> +/*
> + * Functions declarations
> + */
> +
> +static int fschmd_attach_adapter(struct i2c_adapter *adapter);
> +static int fschmd_detach_client(struct i2c_client *client);
> +static struct fschmd_data *fschmd_update_device(struct device *dev);
> +
> +/*
> + * Driver data (common to all clients)
> + */
> +
> +static struct i2c_driver fschmd_driver =3D {
> +	.driver =3D {
> +		.name	=3D FSCHMD_NAME,
> +	},
> +	.attach_adapter	=3D fschmd_attach_adapter,
> +	.detach_client	=3D fschmd_detach_client,
> +};
> +
> +/*
> + * Client data (each client gets its own)
> + */
> +
> +struct fschmd_data {
> +	enum chips kind;
> +	struct i2c_client client;

ISTR that the compiler can do some optimizations if the struct
i2c_client comes first.

> +	struct class_device *class_dev;
> +	struct mutex update_lock;
> +	char valid; /* zero until following fields are valid */
> +	unsigned long last_updated; /* in jiffies */
> +
> +	/* register values */
> +	u8 global_control;	/* global control register */
> +	u8 volt[3];		/* 12, 5, battery voltage */=20
> +	u8 temp_act[5];		/* temperature */
> +	u8 temp_status[5];	/* status of sensor */
> +	u8 temp_max[6];		/* high temp limit, notice: undocumented! */

Should be [5]?

> +	u8 fan_act[6];		/* fans revolutions per second */
> +	u8 fan_status[6];	/* fan status */
> +	u8 fan_min[6];		/* fan min value for rps */
> +	u8 fan_ripple[6];	/* divider for rps */
> +};
> +
> +/*
> + * Sysfs attr show / store functions
> + */
> +
> +static ssize_t show_in_value(struct device *dev,
> +	struct device_attribute *devattr, char *buf)
> +{
> +	const int max_reading[3] =3D { 14200, 6600, 3300 };

Could be static.

> +	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);

What about:

	int index =3D to_sensor_dev_attr(devattr)->index;

as suggested by Mark M. Hoffman some times ago?

> +	struct fschmd_data *data =3D fschmd_update_device(dev);
> +
> +	return sprintf(buf, "%d\n", (data->volt[attr->index] *
> +		max_reading[attr->index]) / 255);

Adding 128 before dividing would round the value properly.

> +}
> +
> +
> +#define TEMP_FROM_REG(val)	(((val) - 128) * 1000)
> +
> +static ssize_t show_temp_value(struct device *dev,
> +	struct device_attribute *devattr, char *buf)
> +{
> +	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
> +	struct fschmd_data *data =3D fschmd_update_device(dev);
> +
> +	return sprintf(buf, "%d\n",
> +		TEMP_FROM_REG(data->temp_act[attr->index]));
> +}
> +
> +static ssize_t show_temp_max(struct device *dev,
> +	struct device_attribute *devattr, char *buf)
> +{
> +	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
> +	struct fschmd_data *data =3D fschmd_update_device(dev);
> +
> +	return sprintf(buf, "%d\n", TEMP_FROM_REG(
> +		data->temp_max[attr->index]));

I don't much like moving to the next line right after an opening
parenthesis, and this is inconsistent with what you did in
show_temp_value() right above.

> +}
> +
> +static ssize_t store_temp_max(struct device *dev, struct device_attribute
> +	*devattr, const char *buf, size_t count)
> +{
> +	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
> +	struct fschmd_data *data =3D i2c_get_clientdata(to_i2c_client(dev));

Can be abbreviated into dev_get_drvdata().

> +	long v =3D simple_strtol(buf, NULL, 10) / 1000;
> +
> +	SENSORS_LIMIT(v, -128, 127);

This is a no-op!

> +	v +=3D 128;
> +
> +	mutex_lock(&data->update_lock);
> +	i2c_smbus_write_byte_data(&data->client,
> +		FSCHMD_REG_TEMP_LIMIT[data->kind][attr->index], v);
> +	data->temp_max[attr->index] =3D v;
> +	mutex_unlock(&data->update_lock);
> +
> +	return count;
> +}
> +
> +static ssize_t show_temp_fault(struct device *dev,
> +	struct device_attribute *devattr, char *buf)
> +{
> +	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
> +	struct fschmd_data *data =3D fschmd_update_device(dev);
> +
> +	/* bit 0 set means sensor working ok, so no fault! */
> +	if (data->temp_status[attr->index] & FSCHMD_TEMP_WORKING_MASK)
> +		return sprintf(buf, "0\n");
> +	else
> +		return sprintf(buf, "1\n");
> +}
> +
> +static ssize_t show_temp_alarm(struct device *dev,
> +	struct device_attribute *devattr, char *buf)
> +{
> +	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
> +	struct fschmd_data *data =3D fschmd_update_device(dev);
> +
> +	if ((data->temp_status[attr->index] & FSCHMD_TEMP_ALARM_MASK) =3D
> +			FSCHMD_TEMP_ALARM_MASK)
> +		return sprintf(buf, "1\n");
> +	else
> +		return sprintf(buf, "0\n");
> +}
> +
> +
> +#define RPM_FROM_REG(val)	(val*60)

Missing parentheses around "val", suggested spaces around the "*".

> +
> +static ssize_t show_fan_value(struct device *dev,
> +	struct device_attribute *devattr, char *buf)
> +{
> +	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
> +	struct fschmd_data *data =3D fschmd_update_device(dev);
> +
> +	return sprintf(buf, "%u\n", RPM_FROM_REG(data->fan_act[attr->index]));
> +}
> +
> +static ssize_t show_fan_div(struct device *dev,
> +	struct device_attribute *devattr, char *buf)
> +{
> +	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
> +	struct fschmd_data *data =3D fschmd_update_device(dev);
> +
> +	/* bits 2..7 reserved =3D> mask with 3 */ =20
> +	return sprintf(buf, "%d\n", 1 << (data->fan_ripple[attr->index] & 3));
> +}
> +
> +static ssize_t store_fan_div(struct device *dev, struct device_attribute
> +	*devattr, const char *buf, size_t count)
> +{
> +	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
> +	struct fschmd_data *data =3D fschmd_update_device(dev);

You shouldn't call the update function in "store" callbacks, it's very
expensive I/O-wise and slows down "sensors -s" quite a bit. Just
manually read the register you need.

> +	/* supported values: 2, 4, 8 */
> +	unsigned long v =3D simple_strtoul(buf, NULL, 10);
> +
> +	switch (v) {
> +		case 2: v =3D 1; break;

CodingStyle says that the cases should be at the same indentation level
as the switch.

> +		case 4: v =3D 2; break;
> +		case 8: v =3D 3; break;
> +		default:
> +			dev_err(&data->client.dev, "fan_div value %lu not "

You can use just "dev".

> +				 "supported. Choose one of 2, 4 or 8!\n", v);
> +			return -EINVAL;
> +	}
> +
> +	mutex_lock(&data->update_lock);
> +
> +	/* bits 2..7 reserved =3D> mask with 0x03 */
> +	data->fan_ripple[attr->index] &=3D ~0x03;
> +	data->fan_ripple[attr->index] |=3D v;
> +
> +	i2c_smbus_write_byte_data(&data->client,
> +		FSCHMD_REG_FAN_RIPPLE[data->kind][attr->index],
> +		data->fan_ripple[attr->index]);
> +
> +	mutex_unlock(&data->update_lock);
> +
> +	return count;
> +}
> +
> +static ssize_t show_fan_alarm(struct device *dev,
> +	struct device_attribute *devattr, char *buf)
> +{
> +	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
> +	struct fschmd_data *data =3D fschmd_update_device(dev);
> +
> +	if (data->fan_status[attr->index] & FSCHMD_FAN_ALARM_MASK)
> +		return sprintf(buf, "1\n");
> +	else
> +		return sprintf(buf, "0\n");
> +}
> +
> +static ssize_t show_fan_fault(struct device *dev,
> +	struct device_attribute *devattr, char *buf)
> +{
> +	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
> +	struct fschmd_data *data =3D fschmd_update_device(dev);
> +
> +	if (data->fan_status[attr->index] & FSCHMD_FAN_NOT_PRESENT_MASK)
> +		return sprintf(buf, "1\n");
> +	else
> +		return sprintf(buf, "0\n");
> +}
> +
> +
> +static ssize_t show_pwm_auto_point1_pwm(struct device *dev,
> +	struct device_attribute *devattr, char *buf)
> +{
> +	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
> +	int val =3D fschmd_update_device(dev)->fan_min[attr->index];
> +
> +	/* 0 =3D allow turning off, 1-255 =3D 50-100% */
> +	if (val)
> +		val =3D val / 2 + 128;
> +=09
> +	return sprintf(buf, "%d\n", val);
> +}
> +
> +static ssize_t store_pwm_auto_point1_pwm(struct device *dev,
> +	struct device_attribute *devattr, const char *buf, size_t count)
> +{
> +	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
> +	struct fschmd_data *data =3D i2c_get_clientdata(to_i2c_client(dev));
> +	unsigned long v =3D simple_strtoul(buf, NULL, 10);
> +=09
> +	/* register: 0 =3D allow turning off, 1-255 =3D 50-100% */
> +	if (v) {
> +		SENSORS_LIMIT(v, 128, 255);

No-op!

> +		v =3D (v - 128) * 2 + 1;
> +	}
> +
> +	mutex_lock(&data->update_lock);
> +
> +	i2c_smbus_write_byte_data(&data->client,
> +		FSCHMD_REG_FAN_MIN[data->kind][attr->index], v);
> +	data->fan_min[attr->index] =3D v;
> +
> +	mutex_unlock(&data->update_lock);
> +=09
> +	return count;
> +}
> +
> +
> +/* The FSC hwmon family has the ability to force an attached alert led t=
o flash
> +   from software, we export this as an alert_led sysfs attr */
> +static ssize_t show_alert_led(struct device *dev,
> +	struct device_attribute *devattr, char *buf)
> +{
> +	struct fschmd_data *data =3D fschmd_update_device(dev);
> +
> +	if (data->global_control & 0x01)
> +		return sprintf(buf, "1\n");
> +	else
> +		return sprintf(buf, "0\n");
> +}
> +
> +static ssize_t store_alert_led(struct device *dev,
> +	struct device_attribute *devattr, const char *buf, size_t count)
> +{
> +	struct fschmd_data *data =3D fschmd_update_device(dev);

Read just data->global_control.

> +	unsigned long v =3D simple_strtoul(buf, NULL, 10);
> +
> +	mutex_lock(&data->update_lock);
> +=09
> +	if (v)
> +		data->global_control |=3D 0x01;
> +	else
> +		data->global_control &=3D ~0x01;
> +
> +	i2c_smbus_write_byte_data(&data->client, FSCHMD_REG_CONTROL, v);
> +	mutex_unlock(&data->update_lock);
> +
> +	return count;
> +}
> +
> +static struct sensor_device_attribute fschmd_attr[] =3D {
> +	SENSOR_ATTR(in0_input, 0444, show_in_value, NULL, 0),
> +	SENSOR_ATTR(in1_input, 0444, show_in_value, NULL, 1),
> +	SENSOR_ATTR(in2_input, 0444, show_in_value, NULL, 2),
> +	SENSOR_ATTR(alert_led, 0644, show_alert_led, store_alert_led, 0),
> +};
> +
> +static struct sensor_device_attribute fschmd_temp_attr[] =3D {
> +	SENSOR_ATTR(temp1_input, 0444, show_temp_value, NULL, 0),
> +	SENSOR_ATTR(temp1_max,   0644, show_temp_max, store_temp_max, 0),
> +	SENSOR_ATTR(temp1_fault, 0444, show_temp_fault, NULL, 0),
> +	SENSOR_ATTR(temp1_alarm, 0444, show_temp_alarm, NULL, 0),
> +	SENSOR_ATTR(temp2_input, 0444, show_temp_value, NULL, 1),
> +	SENSOR_ATTR(temp2_max,   0644, show_temp_max, store_temp_max, 1),
> +	SENSOR_ATTR(temp2_fault, 0444, show_temp_fault, NULL, 1),
> +	SENSOR_ATTR(temp2_alarm, 0444, show_temp_alarm, NULL, 1),
> +	SENSOR_ATTR(temp3_input, 0444, show_temp_value, NULL, 2),
> +	SENSOR_ATTR(temp3_max,   0644, show_temp_max, store_temp_max, 2),
> +	SENSOR_ATTR(temp3_fault, 0444, show_temp_fault, NULL, 2),
> +	SENSOR_ATTR(temp3_alarm, 0444, show_temp_alarm, NULL, 2),
> +	SENSOR_ATTR(temp4_input, 0444, show_temp_value, NULL, 3),
> +	SENSOR_ATTR(temp4_max,   0644, show_temp_max, store_temp_max, 3),
> +	SENSOR_ATTR(temp4_fault, 0444, show_temp_fault, NULL, 3),
> +	SENSOR_ATTR(temp4_alarm, 0444, show_temp_alarm, NULL, 3),
> +	SENSOR_ATTR(temp5_input, 0444, show_temp_value, NULL, 4),
> +	SENSOR_ATTR(temp5_max,   0644, show_temp_max, store_temp_max, 4),
> +	SENSOR_ATTR(temp5_fault, 0444, show_temp_fault, NULL, 4),
> +	SENSOR_ATTR(temp5_alarm, 0444, show_temp_alarm, NULL, 4),
> +};
> +
> +static struct sensor_device_attribute fschmd_fan_attr[] =3D {
> +	SENSOR_ATTR(fan1_input, 0444, show_fan_value, NULL, 0),
> +	SENSOR_ATTR(fan1_div,   0644, show_fan_div, store_fan_div, 0),
> +	SENSOR_ATTR(fan1_alarm, 0444, show_fan_alarm, NULL, 0),
> +	SENSOR_ATTR(fan1_fault, 0444, show_fan_fault, NULL, 0),
> +	SENSOR_ATTR(pwm1_auto_point1_pwm, 0644, show_pwm_auto_point1_pwm,
> +		store_pwm_auto_point1_pwm, 0),
> +	SENSOR_ATTR(fan2_input, 0444, show_fan_value, NULL, 1),
> +	SENSOR_ATTR(fan2_div,   0644, show_fan_div, store_fan_div, 1),
> +	SENSOR_ATTR(fan2_alarm, 0444, show_fan_alarm, NULL, 1),
> +	SENSOR_ATTR(fan2_fault, 0444, show_fan_fault, NULL, 1),
> +	SENSOR_ATTR(pwm2_auto_point1_pwm, 0644, show_pwm_auto_point1_pwm,
> +		store_pwm_auto_point1_pwm, 1),
> +	SENSOR_ATTR(fan3_input, 0444, show_fan_value, NULL, 2),
> +	SENSOR_ATTR(fan3_div,   0644, show_fan_div, store_fan_div, 2),
> +	SENSOR_ATTR(fan3_alarm, 0444, show_fan_alarm, NULL, 2),
> +	SENSOR_ATTR(fan3_fault, 0444, show_fan_fault, NULL, 2),
> +	SENSOR_ATTR(pwm3_auto_point1_pwm, 0644, show_pwm_auto_point1_pwm,
> +		store_pwm_auto_point1_pwm, 2),
> +	SENSOR_ATTR(fan4_input, 0444, show_fan_value, NULL, 3),
> +	SENSOR_ATTR(fan4_div,   0644, show_fan_div, store_fan_div, 3),
> +	SENSOR_ATTR(fan4_alarm, 0444, show_fan_alarm, NULL, 3),
> +	SENSOR_ATTR(fan4_fault, 0444, show_fan_fault, NULL, 3),
> +	SENSOR_ATTR(pwm4_auto_point1_pwm, 0644, show_pwm_auto_point1_pwm,
> +		store_pwm_auto_point1_pwm, 3),
> +	SENSOR_ATTR(fan5_input, 0444, show_fan_value, NULL, 4),
> +	SENSOR_ATTR(fan5_div,   0644, show_fan_div, store_fan_div, 4),
> +	SENSOR_ATTR(fan5_alarm, 0444, show_fan_alarm, NULL, 4),
> +	SENSOR_ATTR(fan5_fault, 0444, show_fan_fault, NULL, 4),
> +	SENSOR_ATTR(pwm5_auto_point1_pwm, 0644, show_pwm_auto_point1_pwm,
> +		store_pwm_auto_point1_pwm, 4),
> +	SENSOR_ATTR(fan6_input, 0444, show_fan_value, NULL, 5),
> +	SENSOR_ATTR(fan6_div,   0644, show_fan_div, store_fan_div, 5),
> +	SENSOR_ATTR(fan6_alarm, 0444, show_fan_alarm, NULL, 5),
> +	SENSOR_ATTR(fan6_fault, 0444, show_fan_fault, NULL, 5),
> +	SENSOR_ATTR(pwm6_auto_point1_pwm, 0644, show_pwm_auto_point1_pwm,
> +		store_pwm_auto_point1_pwm, 5),
> +};
> +
> +
> +/*
> + * Real code
> + */
> +
> +static int fschmd_detect(struct i2c_adapter *adapter, int address, int k=
ind)
> +{
> +	struct i2c_client *new_client;

Pretty please, rename this to just "client". This "new_client" name is
a disease.

> +	struct fschmd_data *data;
> +	u8 revision;
> +	const char *names[5] =3D { "Scylla", "Poseidon", "Hermes", "Heracles",
> +			"Heimdall" };

Could be static.

> +	int i, err =3D 0;
> +
> +	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
> +		return 0;
> +
> +	/* OK. For now, we presume we have a valid client. We now create the
> +	 * client structure, even though we cannot fill it completely yet.
> +	 * But it allows us to access i2c_smbus_read_byte_data. */
> +	if (!(data =3D kzalloc(sizeof(struct fschmd_data), GFP_KERNEL)))
> +		return -ENOMEM;
> +
> +	/* The common I2C client data is placed right before the
> +	 * Poseidon-specific data. */

Even though this is technically correct, this is an implementation
detail which doesn't actually matter, so this comment could be omitted.

> +	new_client =3D &data->client;
> +	i2c_set_clientdata(new_client, data);
> +	new_client->addr =3D address;
> +	new_client->adapter =3D adapter;
> +	new_client->driver =3D &fschmd_driver;
> +	new_client->flags =3D 0;

Useless initialization, kzalloc() above did it for you.

> +	strlcpy(new_client->name, FSCHMD_NAME, I2C_NAME_SIZE);

No! The _client_ name goes there, not the driver name. You want the
Poseidon to appear as "fscpos", etc.

> +	data->valid =3D 0;

Useless initialization.

> +	mutex_init(&data->update_lock);
> +
> +	/* Detect & Identify the chip */
> +	if (kind <=3D 0) {
> +		char id[4];
> +	=09
> +		id[0] =3D i2c_smbus_read_byte_data(new_client,
> +				FSCHMD_REG_IDENT_0);
> +		id[1] =3D i2c_smbus_read_byte_data(new_client,
> +				FSCHMD_REG_IDENT_1);
> +		id[2] =3D i2c_smbus_read_byte_data(new_client,
> +				FSCHMD_REG_IDENT_2);
> +		id[3] =3D 0;

Better written '\0'.

> +	=09
> +		if (!strcmp(id, "PEG")) {
> +			kind =3D fscpos;
> +			/* The Poseidon has hardwired temp limits, fill these
> +			   in for the alarm resetting code */=20
> +			data->temp_max[0] =3D 70 + 128;
> +			data->temp_max[1] =3D 50 + 128;
> +			data->temp_max[2] =3D 50 + 128;

This code should be moved further down. If someone loads the driver with
force_fscpos, this detection part will be skipped and you'll end up
exposing uninitialized limits.

> +		} else if (!strcmp(id, "HER"))
> +			kind =3D fscher;
> +		else if (!strcmp(id, "SCY"))
> +			kind =3D fscscy;
> +		else if (!strcmp(id, "HRC"))
> +			kind =3D fschrc;
> +		else if (!strcmp(id, "HMD"))
> +			kind =3D fschmd;
> +		else
> +			goto exit_free;
> +	}
> +
> +	/* i2c kind goes from 1-5, we want from 0-4 to address arrays */
> +	data->kind =3D kind - 1;

data->kind should be an int then, not an enum chips, otherwise
debugging can become very confusing.

> +
> +	/* Tell the I2C layer a new client has arrived */
> +	if ((err =3D i2c_attach_client(new_client)))
> +		goto exit_free;
> +	=09
> +	for (i =3D 0; i < ARRAY_SIZE(fschmd_attr); i++) {
> +		err =3D device_create_file(&new_client->dev,
> +					&fschmd_attr[i].dev_attr);
> +		if (err)
> +			goto exit_remove_files;
> +	}
> +
> +	for (i =3D 0; i < (FSCHMD_NO_TEMP_SENSORS[data->kind] * 4); i++) {
> +		/* Poseidon doesn't have TEMP_LIMIT registers */
> +		if (kind =3D fscpos && (i % 4) =3D 1)
> +			continue;
> +	=09
> +		err =3D device_create_file(&new_client->dev,
> +					&fschmd_temp_attr[i].dev_attr);
> +		if (err)
> +			goto exit_remove_files;
> +	}
> +
> +	for (i =3D 0; i < (FSCHMD_NO_FAN_SENSORS[data->kind] * 5); i++) {
> +		/* Poseidon doesn't have a FAN_MIN register for its 3th fan */

3rd

> +		if (kind =3D fscpos && i =3D (2 * 5 + 4))
> +			continue;
> +	=09
> +		err =3D device_create_file(&new_client->dev,
> +					&fschmd_fan_attr[i].dev_attr);
> +		if (err)
> +			goto exit_remove_files;
> +	}
> +
> +	data->class_dev =3D hwmon_device_register(&new_client->dev);
> +	if (IS_ERR(data->class_dev)) {
> +		err =3D PTR_ERR(data->class_dev);
> +		goto exit_remove_files;
> +	}
> +
> +	revision =3D i2c_smbus_read_byte_data(new_client, FSCHMD_REG_REVISION);
> +	printk(KERN_INFO "fschmd: Detected FSC %s chip, revision: %d\n",
> +		names[data->kind], (int) revision);

You could use FSCHMD_NAME here, otherwise it was hardly worth defining.

> +
> +	return 0;
> +
> +exit_remove_files:
> +	for (i =3D 0; i < ARRAY_SIZE(fschmd_attr); i++)
> +		device_remove_file(&new_client->dev, &fschmd_attr[i].dev_attr);
> +	for (i =3D 0; i < (FSCHMD_NO_TEMP_SENSORS[data->kind] * 4); i++)
> +		device_remove_file(&new_client->dev,
> +					&fschmd_temp_attr[i].dev_attr);
> +	for (i =3D 0; i < (FSCHMD_NO_FAN_SENSORS[data->kind] * 5); i++)
> +		device_remove_file(&new_client->dev,
> +					&fschmd_fan_attr[i].dev_attr);

This file removal code is similar to the one below in
fschmd_detach_client(), this could be moved to a separate function.

> +	i2c_detach_client(new_client);
> +exit_free:
> +	kfree(data);
> +	return err;
> +}
> +
> +static int fschmd_attach_adapter(struct i2c_adapter *adapter)
> +{
> +	if (!(adapter->class & I2C_CLASS_HWMON))
> +		return 0;
> +	return i2c_probe(adapter, &addr_data, fschmd_detect);
> +}
> +
> +static int fschmd_detach_client(struct i2c_client *client)
> +{
> +	struct fschmd_data *data =3D i2c_get_clientdata(client);
> +	int i, err;
> +
> +	hwmon_device_unregister(data->class_dev);
> +	for (i =3D 0; i < ARRAY_SIZE(fschmd_attr); i++)
> +		device_remove_file(&client->dev, &fschmd_attr[i].dev_attr);
> +	for (i =3D 0; i < (FSCHMD_NO_TEMP_SENSORS[data->kind] * 4); i++)
> +		device_remove_file(&client->dev,
> +					&fschmd_temp_attr[i].dev_attr);
> +	for (i =3D 0; i < (FSCHMD_NO_FAN_SENSORS[data->kind] * 5); i++)
> +		device_remove_file(&client->dev,
> +					&fschmd_fan_attr[i].dev_attr);
> +
> +	if ((err =3D i2c_detach_client(client)))
> +		return err;
> +
> +	kfree(data);
> +	return 0;
> +}
> +
> +static struct fschmd_data *fschmd_update_device(struct device *dev)
> +{
> +	struct i2c_client *client =3D to_i2c_client(dev);
> +	struct fschmd_data *data =3D i2c_get_clientdata(client);
> +	int i;
> +
> +	mutex_lock(&data->update_lock);
> +
> +	if (time_after(jiffies, data->last_updated + 2 * HZ) || !data->valid) {
> +	=09
> +		for (i =3D 0; i < FSCHMD_NO_TEMP_SENSORS[data->kind]; i++) {
> +			data->temp_act[i] =3D i2c_smbus_read_byte_data(client,
> +					FSCHMD_REG_TEMP_ACT[data->kind][i]);
> +			data->temp_status[i] =3D i2c_smbus_read_byte_data(client,
> +					FSCHMD_REG_TEMP_STATE[data->kind][i]);
> +
> +			/* The fscpos doesn't have TEMP_LIMIT registers */
> +			if (FSCHMD_REG_TEMP_LIMIT[data->kind][i])
> +				data->temp_max[i] =3D i2c_smbus_read_byte_data(
> +					client,
> +					FSCHMD_REG_TEMP_LIMIT[data->kind][i]);
> +			=09
> +			/* reset alarm if the alarm condition is gone,
> +			   the chip doesn't do this itself */
> +			if ((data->temp_status[i] & FSCHMD_TEMP_ALARM_MASK) =3D
> +					FSCHMD_TEMP_ALARM_MASK &&
> +					data->temp_act[i] < data->temp_max[i])
> +				i2c_smbus_write_byte_data(client,
> +					FSCHMD_REG_TEMP_STATE[data->kind][i],
> +					FSCHMD_TEMP_ALERT_MASK);
> +		}
> +				=09
> +		for (i =3D 0; i < FSCHMD_NO_FAN_SENSORS[data->kind]; i++) {
> +			data->fan_act[i] =3D i2c_smbus_read_byte_data(client,
> +					FSCHMD_REG_FAN_ACT[data->kind][i]);
> +			data->fan_status[i] =3D i2c_smbus_read_byte_data(client,
> +					FSCHMD_REG_FAN_STATE[data->kind][i]);
> +			data->fan_ripple[i] =3D i2c_smbus_read_byte_data(client,
> +					FSCHMD_REG_FAN_RIPPLE[data->kind][i]);
> +
> +			/* The fscpos third fan doesn't have a fan_min */
> +			if (FSCHMD_REG_FAN_MIN[data->kind][i])
> +				data->fan_min[i] =3D i2c_smbus_read_byte_data(
> +					client,
> +					FSCHMD_REG_FAN_MIN[data->kind][i]);
> +
> +			/* reset fan status if speed is back to > 0 */
> +			if ((data->fan_status[i] & FSCHMD_FAN_ALARM_MASK) &&
> +					data->fan_act[i])
> +				i2c_smbus_write_byte_data(client,
> +					FSCHMD_REG_FAN_STATE[data->kind][i],
> +					FSCHMD_FAN_ALARM_MASK);
> +		}
> +
> +		data->global_control =3D i2c_smbus_read_byte_data(client,
> +						FSCHMD_REG_CONTROL);
> +
> +		data->volt[0] =3D i2c_smbus_read_byte_data(client,
> +						FSCHMD_REG_VOLT_12);
> +		data->volt[1] =3D i2c_smbus_read_byte_data(client,
> +						FSCHMD_REG_VOLT_5);
> +		data->volt[2] =3D i2c_smbus_read_byte_data(client,
> +						FSCHMD_REG_VOLT_BATT);
> +
> +		/* To be implemented in the future
> +		data->watchdog[0] =3D i2c_smbus_read_byte_data(client,
> +						FSCHMD_REG_WDOG_PRESET);
> +		data->watchdog[1] =3D i2c_smbus_read_byte_data(client,
> +						FSCHMD_REG_WDOG_STATE);
> +		data->watchdog[2] =3D i2c_smbus_read_byte_data(client,
> +						FSCHMD_REG_WDOG_CONTROL); */
> +
> +		data->last_updated =3D jiffies;
> +		data->valid =3D 1;
> +	}
> +
> +	mutex_unlock(&data->update_lock);
> +
> +	return data;
> +}
> +
> +static int __init fschmd_init(void)
> +{
> +	return i2c_add_driver(&fschmd_driver);
> +}
> +
> +static void __exit fschmd_exit(void)
> +{
> +	i2c_del_driver(&fschmd_driver);
> +}
> +
> +MODULE_AUTHOR("Hans de Goede <j.w.r.degoede@hhs.nl>");
> +MODULE_DESCRIPTION("FSC Poseidon, Hermes, Scylla, Heracles and Heimdall =
driver");

Line longer that 80 characters.

> +MODULE_LICENSE("GPL");
> +
> +module_init(fschmd_init);
> +module_exit(fschmd_exit);


--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
