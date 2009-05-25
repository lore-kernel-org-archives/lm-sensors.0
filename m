From: Ramax Lo <ramaxlo@gmail.com>
Date: Mon, 25 May 2009 09:39:03 +0000
Subject: Re: [lm-sensors] HWMON: S3C24XX series ADC driver
Message-Id: <901c91090905250239o436f969ate182cad8ef80cb95@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090520215029.692678819@fluff.org.uk>
In-Reply-To: <20090520215029.692678819@fluff.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

2009/5/21 Ben Dooks <ben@simtec.co.uk>
>
> Add support for the ADC controller on the S3C
> series of processors to drivers/hwmon for use with
> hardware monitoring systems.
>
> Signed-off-by: Ben Dooks <ben@simtec.co.uk>
>
> Index: linux.git/drivers/hwmon/Kconfig
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- linux.git.orig/drivers/hwmon/Kconfig =A0 =
=A0 =A0 =A02009-05-20 22:02:06.000000000 +0100
> +++ linux.git/drivers/hwmon/Kconfig =A0 =A0 2009-05-20 22:02:43.000000000=
 +0100
> @@ -702,6 +702,16 @@ config SENSORS_SHT15
> =A0 =A0 =A0 =A0 =A0This driver can also be built as a module. =A0If so, t=
he module
> =A0 =A0 =A0 =A0 =A0will be called sht15.
>
> +config SENSORS_S3C_ADC
> + =A0 =A0 =A0 tristate "S3C24XX/S3C64XX Inbuilt ADC"
> + =A0 =A0 =A0 depends on HWMON && (ARCH_S3C2410 || ARCH_S3C64XX)
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 If you say yes here you get support for the on-board AD=
Cs of
> + =A0 =A0 =A0 =A0 the Samsung S3C24XX or S3C64XX series of SoC
> +
> + =A0 =A0 =A0 =A0 This driver can also be built as a module. If so, the m=
odule
> + =A0 =A0 =A0 =A0 will be called s3c-adc.
> +
> =A0config SENSORS_SIS5595
> =A0 =A0 =A0 =A0tristate "Silicon Integrated Systems Corp. SiS5595"
> =A0 =A0 =A0 =A0depends on PCI
> Index: linux.git/drivers/hwmon/Makefile
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- linux.git.orig/drivers/hwmon/Makefile =A0 =
=A0 =A0 2009-05-20 22:02:06.000000000 +0100
> +++ linux.git/drivers/hwmon/Makefile =A0 =A02009-05-20 22:02:43.000000000=
 +0100
> @@ -76,6 +76,7 @@ obj-$(CONFIG_SENSORS_MAX6650) +=3D max6650
> =A0obj-$(CONFIG_SENSORS_PC87360) =A0+=3D pc87360.o
> =A0obj-$(CONFIG_SENSORS_PC87427) =A0+=3D pc87427.o
> =A0obj-$(CONFIG_SENSORS_PCF8591) =A0+=3D pcf8591.o
> +obj-$(CONFIG_SENSORS_S3C_ADC) =A0+=3D s3c-adc.o
> =A0obj-$(CONFIG_SENSORS_SHT15) =A0 =A0+=3D sht15.o
> =A0obj-$(CONFIG_SENSORS_SIS5595) =A0+=3D sis5595.o
> =A0obj-$(CONFIG_SENSORS_SMSC47B397)+=3D smsc47b397.o
> Index: linux.git/drivers/hwmon/s3c-adc.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- /dev/null =A0 1970-01-01 00:00:00.00000000=
0 +0000
> +++ linux.git/drivers/hwmon/s3c-adc.c =A0 2009-05-20 22:20:32.000000000 +=
0100
> @@ -0,0 +1,371 @@
> +/* linux/drivers/hwmon/s3c-adc.c
> + *
> + * Copyright (C) 2005, 2008, 2009 Simtec Electronics
> + * =A0 =A0 http://armlinux.simtec.co.uk/
> + * =A0 =A0 Ben Dooks <ben@simtec.co.uk>
> + *
> + * S3C24XX/S3C64XX ADC hwmon support
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA =A002111-130=
7 =A0USA
> +*/
> +
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/init.h>
> +#include <linux/err.h>
> +#include <linux/clk.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +
> +#include <plat/adc.h>
> +#include <plat/hwmon.h>
> +
> +/**
> + * struct s3c_hwmon - ADC hwmon client information
> + * @lock: Access lock for conversion.
> + * @wait: Wait queue for conversions to complete.
> + * @client: The client we registered with the S3C ADC core.
> + * @dev: The platform device we bound to.
> + * @hwmon_dev: The hwmon device we created.
> + * @in_attr: The device attributes we created.
> +*/
> +struct s3c_hwmon {
> + =A0 =A0 =A0 struct semaphore =A0 =A0 =A0 =A0lock;
> + =A0 =A0 =A0 wait_queue_head_t =A0 =A0 =A0 wait;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 val;
> +
> + =A0 =A0 =A0 struct s3c_hwmon_client *client;
> + =A0 =A0 =A0 struct platform_device =A0*dev;
> + =A0 =A0 =A0 struct device =A0 =A0 =A0 =A0 =A0 *hwmon_dev;
> +
> + =A0 =A0 =A0 struct sensor_device_attribute *in_attr[8];
> +};
> +
> +static inline struct s3c_hwmon *dev_to_ourhwmon(struct platform_device *=
dev)
> +{
> + =A0 =A0 =A0 return (struct s3c_hwmon *)platform_get_drvdata(dev);
> +}
> +
> +static struct s3c_hwmon *done_adc;
> +
> +/**
> + * s3c_hwmon_adcdone - ADC core callback
> + * @value: The value that we got from the ADC core
> + * @ignore: Only used for the touchscreen client.
> + * @left: The number of conversions left (not used here).
> + *
> + * This is called when the ADC has finished its conversion to
> + * inform us of the result.
> + */
> +static void s3c_hwmon_adcdone(unsigned value, unsigned ignore, unsigned =
*left)
> +{
> + =A0 =A0 =A0 struct s3c_hwmon *adc =3D done_adc;
> +
> + =A0 =A0 =A0 hwmon->val =3D value;
> + =A0 =A0 =A0 wake_up(&hwmon->wait);

The variable should be 'adc'?

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
