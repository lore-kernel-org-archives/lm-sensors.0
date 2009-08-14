From: XingChao Wang <wxc200@gmail.com>
Date: Fri, 14 Aug 2009 11:05:26 +0000
Subject: Re: [lm-sensors] [PATCH] adxl345 accelerometer hwmon driver
Message-Id: <fd6b62c10908140405q63de0229l57b16df72175d119@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Acn6eDhBoTUmzVqOSVGG9a2LiwqVrA==> <68FBE0F3CE97264395875AC1C468F22C152BE8@mail03.cyberswitching.local>
In-Reply-To: <68FBE0F3CE97264395875AC1C468F22C152BE8@mail03.cyberswitching.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Chris Verges <chrisv@cyberswitching.com>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

2009/7/2 Chris Verges <chrisv@cyberswitching.com>
>
> Hi kernel hackers,
>
> Here is a patch that adds support to the Linux kernel for Analog
> Device's ADXL345 chip. =A0It is an accelerometer that uses I2C and HWMON.
> When I looked into the MAINTAINERS file for the appropriate list, the
> "Orphan" status of "Hardware Monitoring" confused me as to the proper
> list for this patch ... please let me know if I need to forward it
> elsewhere.
>
> ALPHA Warning: THIS CODE COMPILES WITHOUT ERROR, BUT HAS NOT BEEN TESTED
> YET.
>
> I'd appreciate feedback from those who have the time/interest to help!
> Code review would be great, someone with hardware for testing would be
> excellent.
>
> Thanks,
> Chris
>
>
> --- PATCH BELOW ---
>
> Signed-off-by: Chris Verges <chrisv@cyberswitching.com>
> Index: drivers/hwmon/Makefile
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- linux-2.6.29.3-orig/drivers/hwmon/Makefile=
 =A0(revision 33)
> +++ linux-2.6.29.3/drivers/hwmon/Makefile =A0 =A0 =A0 (revision 49)
> @@ -29,6 +29,7 @@
> =A0obj-$(CONFIG_SENSORS_ADT7470) =A0+=3D adt7470.o
> =A0obj-$(CONFIG_SENSORS_ADT7473) =A0+=3D adt7473.o
> =A0obj-$(CONFIG_SENSORS_ADT7475) =A0+=3D adt7475.o
> +obj-$(CONFIG_SENSORS_ADXL345) =A0+=3D adxl345.o
>
> =A0obj-$(CONFIG_SENSORS_APPLESMC) +=3D applesmc.o
> =A0obj-$(CONFIG_SENSORS_AMS) =A0 =A0 =A0+=3D ams/
> Index: drivers/hwmon/Kconfig
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- linux-2.6.29.3-orig/drivers/hwmon/Kconfig =
=A0 (revision 33)
> +++ linux-2.6.29.3/drivers/hwmon/Kconfig =A0 =A0 =A0 =A0(revision 49)
> @@ -199,6 +199,16 @@
> =A0 =A0 =A0 =A0 =A0This driver can also be build as a module. =A0If so, t=
he module
> =A0 =A0 =A0 =A0 =A0will be called adt7475.
>
> +config SENSORS_ADXL345
> + =A0 =A0 =A0 tristate "Analog Devices ADXL345"
> + =A0 =A0 =A0 depends on I2C && EXPERIMENTAL
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 If you say yes here, you get support for the Analog Dev=
ices
> + =A0 =A0 =A0 =A0 ADXL345 digital accelerometer chip.
> +
> + =A0 =A0 =A0 =A0 This driver can also be build as a module. =A0If so, th=
e module
> + =A0 =A0 =A0 =A0 will be called adxl345.
> +
> =A0config SENSORS_K8TEMP
> =A0 =A0 =A0 =A0tristate "AMD Athlon64/FX or Opteron temperature sensor"
> =A0 =A0 =A0 =A0depends on X86 && PCI && EXPERIMENTAL
> Index: drivers/hwmon/adxl345.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- linux-2.6.29.3-orig/drivers/hwmon/adxl345.=
c (revision 0)
> +++ linux-2.6.29.3/drivers/hwmon/adxl345.c =A0 =A0 =A0(revision 49)
> @@ -0,0 +1,521 @@
> +/*
> + * A hwmon driver for the Analog Devices ADXL345
> + *
> + * Copyright (c) 2009 Cyber Switching, Inc.
> + * Author: Robert Mehranfar <robertme@earthlink.net>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
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
> +#include <linux/hwmon-vid.h>
> +#include <linux/err.h>
> +#include <linux/mutex.h>
> +#include <linux/kernel.h>
> +
> +#define DRV_NAME =A0 =A0 =A0 "adxl345"
> +#define DRV_VERSION =A0 =A0"0.1"
> +
> +#define SIMULATE 1
> +
> +/*
> + * The ADXL345 registers
> + */
> +#define ADXL345_REG_DEV_ID =A0 =A0 =A0 =A0 =A0 =A0 0x00
> +#define ADXL345_REG_OFS(nr) =A0 =A0 =A0 =A0 =A0 =A0(0x1E + (nr))
> +#define ADXL345_REG_DATA(nr) =A0 =A0 =A0 =A0 =A0 (0x32 + (nr))
> +#define ADXL345_REG_DATA_FORMAT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x31
> +
> +/*
> + * See ADXL345 specification
> + */
> +#define OFFSET_SCALE_FACTOR_WHOLE 15
> +#define OFFSET_SCALE_FACTOR_FRACTIONAL 6
> +
> +#define MAX_OFFSET 1988
> +#define MIN_OFFSET -1998
> +
> +/*
> + * Based on 10-bit resolution +/-16 range set in the DATA FORMAT
> register
> + */
> +#define DATA_SCALE_FACTOR_WHOLE 15
> +#define DATA_SCALE_FACTOR_FRACTIONAL 6
> +#define NUMBER_OF_AXES 3
> +
> +#define X_AXIS 0
> +#define Y_AXIS 1
> +#define Z_AXIS 2
> +
> +/* Position in the sysfs attribute array */
> +#define X_AXIS_ATTR 0
> +#define Y_AXIS_ATTR 1
> +#define Z_AXIS_ATTR 2
> +#define DATA_ATTR 3
> +
> +/*
> + * Functions declaration
> + */
> +static void adxl345_init_client(struct i2c_client *client);
> +static struct adxl345_data *adxl345_update_device(struct device *dev);
> +static void convert_to_fraction(s16 data, u8 whole_scale, u8
> fraction_scale,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 int *decimal, int *fraction);
> +
> +/*
> + * Client data (each client gets its own)
> + */
> +struct adxl345_data {
> + =A0 =A0 =A0 struct i2c_client =A0 =A0 =A0 client;
> + =A0 =A0 =A0 struct device =A0 =A0 =A0 =A0 =A0 *hwmon_dev;
> + =A0 =A0 =A0 struct mutex =A0 =A0 =A0 =A0 =A0 =A0update_lock; =A0 =A0/* =
lock on the structure
> */
> + =A0 =A0 =A0 char =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0valid; =A0 =A0 =
=A0 =A0 =A0/* 0 until below are
> valid */
> + =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 last_updated; =A0 /* in j=
iffies */
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* ADXL345 Data
> + =A0 =A0 =A0 =A0* In two's complement, data coming in from or going out =
to
> user-space
> + =A0 =A0 =A0 =A0* must be converted.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0offset[NUMBER=
_OF_AXES];
> + =A0 =A0 =A0 u16 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data[NUMBER_OF_=
AXES];
> +};
> +
> +
> +/*
> + * Converts internal data to a decimal-fraction value.
> + * Notes: Must already be converted out of twos complement
> + *
> + * @param data =A0Data to be converted
> + * @param whole_scale Scale factor for whole number part. (Set to 1 for
> no scaling).
> + * @param fraction_scale Scale factor for fractional number part. (Set
> to 1 for no scaling).
> + * @param decimal Pointer to location to store decimal part.
> + * @param fraction Pointer to location to store fractional part.
> + */
> +static void convert_to_fraction(s16 data, u8 whole_scale, u8
> fraction_scale,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 int *decimal, int *fraction)
> +{
> + =A0 =A0 =A0 int temp_decimal, temp_fraction, temp;
> + =A0 =A0 =A0 int sign =3D 1;
> +
> + =A0 =A0 =A0 /* Scale the decimal and fractional parts */
> + =A0 =A0 =A0 temp_decimal =3D data * whole_scale * 10;
> + =A0 =A0 =A0 temp_fraction =3D data * fraction_scale;
> +
> + =A0 =A0 =A0 /* get rid of the sign for negative fractions */
> + =A0 =A0 =A0 if (temp_fraction < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sign =3D -1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_fraction *=3D sign;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* If necessary, carry */
> + =A0 =A0 =A0 if (temp_fraction >=3D 10) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Add to the decimal part */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_decimal +=3D sign * temp_fraction;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Amount to be subtracted from the fractio=
nal part */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp =3D temp_fraction / 10;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_fraction -=3D temp * 10;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 temp_decimal /=3D 10;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* If at least 10 still remains in the fractional part, o=
ne
> + =A0 =A0 =A0 =A0* last carry
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (temp_fraction >=3D 10) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_decimal +=3D sign;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_fraction -=3D 10;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Pass the values up */
> + =A0 =A0 =A0 *decimal =3D temp_decimal;
> + =A0 =A0 =A0 *fraction =3D temp_fraction;
> +}
> +
> +/*
> + * Called in response to cat ofs(x,y,z) in sysfs
> + *
> + * @param dev Pointer to device
> + * @param attr Pointer to the device attributes
> + * @param buf Pointer to string shown in user space
> + * @return Number of chars copied to buffer
> +*/
> +static ssize_t show_offset(struct device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct devi=
ce_attribute *attr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 char *buf)
> +{
> + =A0 =A0 =A0 int index =3D to_sensor_dev_attr(attr)->index;
> + =A0 =A0 =A0 struct adxl345_data *data =3D adxl345_update_device(dev);
> + =A0 =A0 =A0 int decimal, fraction;
> + =A0 =A0 =A0 s8 temp_data;
> +
> + =A0 =A0 =A0 dev_dbg(dev, "%s\n", __func__);
> +
> + =A0 =A0 =A0 /* Convert from 2's complement */
> + =A0 =A0 =A0 temp_data =3D ~(data->offset[index] - 1);
> +
> + =A0 =A0 =A0 dev_dbg(dev, "temp_data=3D%d\n", temp_data);
> +
> + =A0 =A0 =A0 convert_to_fraction(temp_data,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OFFSET_SCALE_FACTOR_WHOLE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OFFSET_SCALE_FACTOR_FRACTIO=
NAL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &decimal,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &fraction);
> +
> + =A0 =A0 =A0 return snprintf(buf, PAGE_SIZE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%4d.%1d\n", decimal, fract=
ion);
> +}
> +
> +/*
> + * Called in response to echoing data to ofs(x,y,z) in sysfs
> + * Note: Input range is -1998 to 1998 milli-g's
> + *
> + * @param dev Pointer to device
> + * @param attr Pointer to the device attributes
> + * @param buf Pointer to string passed in from user space
> + * @param count Number of chars passed in from user space..
> + * @return Number of chars passed in from user space.
> + */
> +static ssize_t set_offset(struct device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct devi=
ce_attribute *attr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char =
*buf,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 size_t coun=
t)
> +{
> + =A0 =A0 =A0 int index =3D to_sensor_dev_attr(attr)->index;
> + =A0 =A0 =A0 struct i2c_client *client =3D to_i2c_client(dev);
> + =A0 =A0 =A0 struct adxl345_data *data =3D i2c_get_clientdata(client);
> + =A0 =A0 =A0 long val;
> + =A0 =A0 =A0 long temp_val;
> +
> + =A0 =A0 =A0 dev_dbg(dev, "%s\n", __func__);
> +
> + =A0 =A0 =A0 if (!strict_strtol(buf, 10, &val)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, "error in converting string '%=
s' to
> long\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* If outside offset range, clip to max or min value */
> + =A0 =A0 =A0 if (val < MIN_OFFSET)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D MIN_OFFSET;
> + =A0 =A0 =A0 else if (val > MAX_OFFSET)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D MAX_OFFSET;
> +
> + =A0 =A0 =A0 temp_val =3D (val * 100) %
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((OFFSET_SCALE_FACTOR_WHOLE=
 * 100) +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (OFFSET_SCALE_FACTOR_FRACTI=
ONAL * 10));
> + =A0 =A0 =A0 if (temp_val < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_val *=3D -1;
> +
> + =A0 =A0 =A0 /* Get rid of scale for internal storage */
> + =A0 =A0 =A0 val =3D (val * 100) /
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((OFFSET_SCALE_FACTOR_WHOLE=
 * 100) +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (OFFSET_SCALE_FACTOR_FRACTI=
ONAL * 10));
> +
> + =A0 =A0 =A0 if (temp_val > (OFFSET_SCALE_FACTOR_WHOLE * 100) / 2 && val=
 > 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ++val;
> + =A0 =A0 =A0 else if (temp_val > (OFFSET_SCALE_FACTOR_WHOLE * 100) / 2 &=
& val
> < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 --val;
> +
> + =A0 =A0 =A0 val =3D ~val + 1; =A0/* convert to two's complement */
> +
> + =A0 =A0 =A0 mutex_lock(&data->update_lock);
> +
> + =A0 =A0 =A0 data->offset[index] =3D val;
> +
> + =A0 =A0 =A0 dev_dbg(dev, "offset[%d]=3D%d\n", index, data->offset[index=
]);
> +
> + =A0 =A0 =A0 /* Write the avlue to the chip via I2C */
> + =A0 =A0 =A0 i2c_smbus_write_byte_data(client,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ADXL345_REG_OFS(index),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->offset[index]);
> +
> + =A0 =A0 =A0 mutex_unlock(&data->update_lock);
> +
> + =A0 =A0 =A0 return count;
> +}
> +
> +/*
> + * Called in response to cat data in sysfs
> + *
> + * @param dev Pointer to device
> + * @param attr Pointer to the device attributes
> + * @param buf Pointer to string shown in user space
> + * @return Number of chars copied to buffer
> +*/
> +static ssize_t show_data(struct device *dev, struct device_attribute
> *attr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 char *buf)
> +{
> + =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 s16 temp_data;
> + =A0 =A0 =A0 int decimal[NUMBER_OF_AXES], fraction[NUMBER_OF_AXES];
> +
> + =A0 =A0 =A0 struct adxl345_data *data =3D adxl345_update_device(dev);
> +
> + =A0 =A0 =A0 /* Convert x,y,z values */
> + =A0 =A0 =A0 for (i =3D 0; i < NUMBER_OF_AXES; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Convert from 2's complement */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_data =3D ~(data->data[i] - 1);
> +

it doesn't need convertion if data->data[i] with bit16=3D0.

--wxc200
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 convert_to_fraction(temp_data,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DATA_SCALE_=
FACTOR_WHOLE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DATA_SCALE_=
FACTOR_FRACTIONAL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &decimal[i],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &fraction[i=
]);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return snprintf(buf, PAGE_SIZE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "x:%5d.%1d y:%5d.%1d z:%5d.=
%1d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 decimal[X_AXIS], fraction[X=
_AXIS],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 decimal[Y_AXIS], fraction[Y=
_AXIS],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 decimal[Z_AXIS], fraction[Z=
_AXIS]);
> +}
> +
> +/* =A0Attributes of the sysfs entries */
> +static SENSOR_DEVICE_ATTR(ofsx, S_IWUSR | S_IRUGO,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 show_offset=
, set_offset, X_AXIS_ATTR);
> +static SENSOR_DEVICE_ATTR(ofsy, S_IWUSR | S_IRUGO,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 show_offset=
, set_offset, Y_AXIS_ATTR);
> +static SENSOR_DEVICE_ATTR(ofsz, S_IWUSR | S_IRUGO,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 show_offset=
, set_offset, Z_AXIS_ATTR);
> +static SENSOR_DEVICE_ATTR(data, S_IRUGO,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 show_data, =
NULL, DATA_ATTR);
> +
> +static struct attribute *adxl345_attributes[] =3D {
> + =A0 =A0 =A0 &sensor_dev_attr_ofsx.dev_attr.attr,
> + =A0 =A0 =A0 &sensor_dev_attr_ofsy.dev_attr.attr,
> + =A0 =A0 =A0 &sensor_dev_attr_ofsz.dev_attr.attr,
> + =A0 =A0 =A0 &sensor_dev_attr_data.dev_attr.attr,
> + =A0 =A0 =A0 NULL
> +};
> +
> +static const struct attribute_group adxl345_group =3D {
> + =A0 =A0 =A0 .attrs =3D adxl345_attributes,
> +};
> +
> +/*
> + * Initialize the chip
> + *
> + * @param client Pointer to the client structure
> + */
> +static void adxl345_init_client(struct i2c_client *client)
> +{
> + =A0 =A0 =A0 dev_dbg(&client->dev, "%s\n", __func__);
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Set up the device, No self test, Dont care about SPI or
> + =A0 =A0 =A0 =A0* interrupt, 10 bit resoltion, +/- 16g range
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 i2c_smbus_write_byte_data(client, ADXL345_REG_DATA_FORMAT,
> 0x03);
> +}
> +
> +/*
> + * Does more than just detection. If detection succeeds, it also
> + * registers the new chip.
> + *
> + * @param adapter Pointer to the adapter
> + * @param address I2C address
> + * @return Zero, upon success
> + */
> +static int adxl345_probe(struct i2c_client *client,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const struc=
t i2c_device_id *id)
> +{
> + =A0 =A0 =A0 struct adxl345_data *data;
> + =A0 =A0 =A0 int err =3D 0;
> + =A0 =A0 =A0 u8 dev_id;
> +
> + =A0 =A0 =A0 dev_dbg(&client->dev, "%s\n", __func__);
> +
> + =A0 =A0 =A0 if (!i2c_check_functionality(client->adapter,
> I2C_FUNC_SMBUS_BYTE_DATA))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> +
> + =A0 =A0 =A0 data =3D kzalloc(sizeof(struct adxl345_data), GFP_KERNEL);
> + =A0 =A0 =A0 if (!data)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> +
> + =A0 =A0 =A0 i2c_set_clientdata(client, data);
> +
> + =A0 =A0 =A0 #ifdef SIMULATE
> + =A0 =A0 =A0 dev_id =3D 0xE5; /* Spoof the Analog Devices device ID */
> + =A0 =A0 =A0 dev_dbg(&client->dev, "Simulating ADXL345 device\n");
> + =A0 =A0 =A0 #else
> + =A0 =A0 =A0 dev_id =3D i2c_smbus_read_byte_data(client, ADXL345_REG_DEV=
_ID);
> + =A0 =A0 =A0 #endif
> +
> + =A0 =A0 =A0 /* If the chip is not from Analog Devices, report an error =
*/
> + =A0 =A0 =A0 if (dev_id !=3D 0xE5) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "Unsupported chip
> (dev_id=3D0x%02X)\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_id);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_mem;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 dev_info(&client->dev, "chip found, driver version "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DRV_VERSION "\n");
> +
> + =A0 =A0 =A0 /* We can fill in the remaining client fields */
> + =A0 =A0 =A0 mutex_init(&data->update_lock);
> +
> + =A0 =A0 =A0 /* Initialize the ADXL345 chip */
> + =A0 =A0 =A0 adxl345_init_client(client);
> +
> + =A0 =A0 =A0 /* Register sysfs hooks */
> + =A0 =A0 =A0 err =3D sysfs_create_group(&client->dev.kobj, &adxl345_grou=
p);
> + =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_mem;
> +
> + =A0 =A0 =A0 data->hwmon_dev =3D hwmon_device_register(&client->dev);
> + =A0 =A0 =A0 if (IS_ERR(data->hwmon_dev)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D PTR_ERR(data->hwmon_dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_remove;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +
> +err_remove:
> + =A0 =A0 =A0 sysfs_remove_group(&client->dev.kobj, &adxl345_group);
> +err_free_mem:
> + =A0 =A0 =A0 kfree(data);
> +
> + =A0 =A0 =A0 return err;
> +}
> +
> +/*
> + * Unregister device, remove the sysfs entries, and detach the client
> + * from I2C bus.
> + *
> + * @param client Pointer to the client structure
> + * @return Zero, upon success.
> + */
> +static int adxl345_remove(struct i2c_client *client)
> +{
> + =A0 =A0 =A0 struct adxl345_data *data =3D i2c_get_clientdata(client);
> +
> + =A0 =A0 =A0 hwmon_device_unregister(data->hwmon_dev);
> + =A0 =A0 =A0 sysfs_remove_group(&client->dev.kobj, &adxl345_group);
> +
> + =A0 =A0 =A0 i2c_unregister_device(client);
> +
> + =A0 =A0 =A0 kfree(data);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/*
> + * Gets the data from the chip.
> + *
> + * @param client Pointer to the device
> + * @return Pointer to structure containing the data
> + */
> +static struct adxl345_data *adxl345_update_device(struct device *dev)
> +{
> + =A0 =A0 =A0 struct i2c_client *client =3D to_i2c_client(dev);
> + =A0 =A0 =A0 struct adxl345_data *data =3D i2c_get_clientdata(client);
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 dev_dbg(dev, "%s\n", __func__);
> +
> + =A0 =A0 =A0 mutex_lock(&data->update_lock);
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* This delay is 500ms, based on a default value of 100 f=
or HZ
> + =A0 =A0 =A0 =A0* in ARM kernels
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (time_after(jiffies, data->last_updated + HZ * 50) ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 !data->valid) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < NUMBER_OF_AXES; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->offset[i] > i2c_smbus=
_read_byte_data(client,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 ADXL345_REG_OFS(i));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, "offset[%d]=3D=
%d\n", i,
> data->offset[i]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Concatenate the data from each registe=
r pair
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Indexing logic is needed as per ADXL34=
5 spec, LSB is
> first
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* INDEX(reg) =A0LSB =A0MSB
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* =A0 =A0 0 =A0 =A0 =A0 =A00 =A0 =A01
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* =A0 =A0 1 =A0 =A0 =A0 =A02 =A0 =A03
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* =A0 =A0 2 =A0 =A0 =A0 =A04 =A0 =A05
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < NUMBER_OF_AXES; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Get the MSB, shift by 8,=
 and then get the LSB
> */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->data[i] =3D i2c_smbus=
_read_byte_data(client,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 ADXL345_REG_DATA(i*2+1))
> << 8;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->data[i] |> i2c_smbus_=
read_byte_data(client,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 ADXL345_REG_DATA(i*2));
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, "data[%d]=3D%d=
\n", i, data->data[i]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->last_updated =3D jiffies;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->valid =3D 1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 mutex_unlock(&data->update_lock);
> +
> + =A0 =A0 =A0 return data;
> +}
> +
> +/*
> + * Driver data (common to all clients)
> + */
> +
> +static const struct i2c_device_id adxl345_id[] =3D {
> + =A0 =A0 =A0 { "adxl345", 0 },
> + =A0 =A0 =A0 { }
> +};
> +MODULE_DEVICE_TABLE(i2c, adxl345_id);
> +
> +static struct i2c_driver adxl345_driver =3D {
> + =A0 =A0 =A0 .driver =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D DRV_NAME,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D adxl345_probe,
> + =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D adxl345_remove,
> + =A0 =A0 =A0 .id_table =A0 =A0 =A0 =3D adxl345_id,
> +};
> +
> +/*
> + * Initialize the module
> + *
> + * @return Zero, upon success
> + */
> +static int __init adxl345_init(void)
> +{
> + =A0 =A0 =A0 return i2c_add_driver(&adxl345_driver);
> +}
> +
> +/*
> + * Remove the module
> + */
> +static void __exit adxl345_exit(void)
> +{
> + =A0 =A0 =A0 i2c_del_driver(&adxl345_driver);
> +}
> +
> +MODULE_AUTHOR("Robert Mehranfar <robertme@earthlink.net>");
> +MODULE_DESCRIPTION("Analog Devices ADXL345 driver");
> +MODULE_LICENSE("GPL");
> +MODULE_VERSION(DRV_VERSION);
> +
> +module_init(adxl345_init);
> +module_exit(adxl345_exit);

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
