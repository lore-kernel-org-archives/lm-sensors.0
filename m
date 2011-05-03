From: Govindraj <govindraj.ti@gmail.com>
Date: Tue, 03 May 2011 06:16:36 +0000
Subject: Re: [lm-sensors] [RFC 4/5] leds: add support for Technologic
Message-Id: <BANLkTikeVpHcG5c3rJDsMNW4PbnRG8NE0A@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1304115712-5299-1-git-send-email-vivien.didelot@savoirfairelinux.com>
 <1304115712-5299-5-git-send-email-vivien.didelot@savoirfairelinux.com>
In-Reply-To: <1304115712-5299-5-git-send-email-vivien.didelot@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Cc: linux-kernel@vger.kernel.org, Jonas Fonseca <jonas.fonseca@savoirfairelinux.com>, platform-driver-x86@vger.kernel.org, linux-serial@vger.kernel.org, lm-sensors@lm-sensors.org

Looks fine some minor comments.


On Sat, Apr 30, 2011 at 3:51 AM, Vivien Didelot
<vivien.didelot@savoirfairelinux.com> wrote:
> From: Jonas Fonseca <jonas.fonseca@savoirfairelinux.com>
>

Missing Patch description.

>
> Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
> ---
> =A0MAINTAINERS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
> =A0drivers/leds/Kconfig =A0 =A0 =A0 | =A0 12 +++
> =A0drivers/leds/Makefile =A0 =A0 =A0| =A0 =A01 +
> =A0drivers/leds/leds-ts5500.c | =A0211 ++++++++++++++++++++++++++++++++++=
++++++++++
> =A04 files changed, 225 insertions(+), 0 deletions(-)
> =A0create mode 100644 drivers/leds/leds-ts5500.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index da3b6d3..c0a646d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6061,6 +6061,7 @@ F: =A0 =A0 =A0 =A0include/linux/ts5xxx-sbcinfo.h
> =A0F: =A0 =A0 drivers/gpio/ts5500-gpio.c
> =A0F: =A0 =A0 include/linux/ts5500-gpio.h
> =A0F: =A0 =A0 drivers/tty/serial/ts5500-auto485.c
> +F: =A0 =A0 drivers/leds/leds-ts5500.c
>
> =A0TEGRA SUPPORT
> =A0M: =A0 =A0 Colin Cross <ccross@android.com>
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index 9bec869..14144df 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -379,6 +379,18 @@ config LEDS_NETXBIG
> =A0 =A0 =A0 =A0 =A0and 5Big Network v2 boards. The LEDs are wired to a CP=
LD and are
> =A0 =A0 =A0 =A0 =A0controlled through a GPIO extension bus.
>
> +config LEDS_TS5500
> + =A0 =A0 =A0 tristate "LED Support for TS-5500 SBCs"
> + =A0 =A0 =A0 depends on LEDS_CLASS && TS5500_SBC
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 This option enables support for on-chip LED drivers fou=
nd
> + =A0 =A0 =A0 =A0 on Technologic Systems TS-5500 SBCs.
> +
> + =A0 =A0 =A0 =A0 To compile this driver as a module, choose M here: the =
module will
> + =A0 =A0 =A0 =A0 be called leds-ts5500.
> +
> +comment "LED Triggers"
> +
> =A0config LEDS_TRIGGERS
> =A0 =A0 =A0 =A0bool "LED Trigger support"
> =A0 =A0 =A0 =A0depends on LEDS_CLASS
> diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> index 39c80fc..ce5a25f 100644
> --- a/drivers/leds/Makefile
> +++ b/drivers/leds/Makefile
> @@ -42,6 +42,7 @@ obj-$(CONFIG_LEDS_DELL_NETBOOKS) =A0 =A0 =A0+=3D dell-l=
ed.o
> =A0obj-$(CONFIG_LEDS_MC13783) =A0 =A0 =A0 =A0 =A0 =A0 +=3D leds-mc13783.o
> =A0obj-$(CONFIG_LEDS_NS2) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D leds-ns2.o
> =A0obj-$(CONFIG_LEDS_NETXBIG) =A0 =A0 =A0 =A0 =A0 =A0 +=3D leds-netxbig.o
> +obj-$(CONFIG_LEDS_TS5500) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D leds-ts5500.o
>
> =A0# LED SPI Drivers
> =A0obj-$(CONFIG_LEDS_DAC124S085) =A0 =A0 =A0 =A0 =A0+=3D leds-dac124s085.o
> diff --git a/drivers/leds/leds-ts5500.c b/drivers/leds/leds-ts5500.c
> new file mode 100644
> index 0000000..aec6d71
> --- /dev/null
> +++ b/drivers/leds/leds-ts5500.c
> @@ -0,0 +1,211 @@
> +/*
> + * Technologic Systems TS-5500 boards - LED driver
> + *
> + * Copyright (c) 2010 Savoir-faire Linux Inc.
> + * =A0 =A0 Jonas Fonseca <jonas.fonseca@savoirfairelinux.com>
> + *
> + * Portions Copyright (c) 2008 Compulab, Ltd.
> + * =A0 =A0 Mike Rapoport <mike@compulab.co.il>
> + *
> + * Portions Copyright (c) 2006-2008 Marvell International Ltd.
> + * =A0 =A0 Eric Miao <eric.miao@marvell.com>
> + *
> + * Based on drivers/leds/leds-da903x.c from linux-2.6.32.8.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/leds.h>
> +#include <linux/workqueue.h>
> +#include <linux/ts5xxx-sbcinfo.h>
> +#include <linux/io.h>
> +
> +#define DRIVER_NAME "leds-ts5500"
> +
> +/**
> + * struct ts5500_led - LED structure
> + * @cdev: =A0 =A0 =A0 =A0 =A0 =A0 =A0LED class device structure.
> + * @work: =A0 =A0 =A0 =A0 =A0 =A0 =A0Work structure.
> + * @new_brightness: =A0 =A0LED brightness.
> + * @ioaddr: =A0 =A0 =A0 =A0 =A0 =A0LED I/O address.
> + */
> +struct ts5500_led {
> + =A0 =A0 =A0 struct led_classdev =A0 =A0 cdev;
> + =A0 =A0 =A0 struct work_struct =A0 =A0 =A0work;
> + =A0 =A0 =A0 enum led_brightness =A0 =A0 new_brightness;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ioaddr;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bit;
> +};
> +
> +static void ts5500_led_work(struct work_struct *work)
> +{
> + =A0 =A0 =A0 struct ts5500_led *led =3D container_of(work, struct ts5500=
_led, work);
> + =A0 =A0 =A0 u8 val =3D led->new_brightness ? led->bit : 0;
> +
> + =A0 =A0 =A0 outb(val, led->ioaddr);
> +}
> +
> +static void ts5500_led_set(struct led_classdev *led_cdev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0enum led_brightness =
value)
> +{
> + =A0 =A0 =A0 struct ts5500_led *led =3D container_of(led_cdev, struct ts=
5500_led,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 cdev);
> +
> + =A0 =A0 =A0 led->new_brightness =3D value;
> + =A0 =A0 =A0 schedule_work(&led->work);
> +}
> +
> +static int __devinit ts5500_led_probe(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct led_platform_data *pdata =3D pdev->dev.platform_data;
> + =A0 =A0 =A0 struct ts5500_led *led;
> + =A0 =A0 =A0 struct resource *res;
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 if (pdata =3D NULL || !pdata->num_leds) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "No platform data avail=
able\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 res =3D platform_get_resource(pdev, IORESOURCE_IO, 0);
> + =A0 =A0 =A0 if (!res) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Failed to get I/O reso=
urce\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 led =3D kzalloc(sizeof(struct ts5500_led), GFP_KERNEL);
> + =A0 =A0 =A0 if (led =3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Failed to alloc memory=
 for LED device\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 led->cdev.name =3D pdata->leds[0].name;
> + =A0 =A0 =A0 led->cdev.default_trigger =3D pdata->leds[0].default_trigge=
r;
> + =A0 =A0 =A0 led->cdev.brightness_set =3D ts5500_led_set;
> + =A0 =A0 =A0 led->cdev.brightness =3D LED_OFF;
> +
> + =A0 =A0 =A0 led->ioaddr =3D res->start;
> + =A0 =A0 =A0 led->bit =3D pdata->leds[0].flags;
> + =A0 =A0 =A0 led->new_brightness =3D LED_OFF;
> +
> + =A0 =A0 =A0 INIT_WORK(&led->work, ts5500_led_work);
> +
> + =A0 =A0 =A0 ret =3D led_classdev_register(pdev->dev.parent, &led->cdev);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Failed to register LED=
\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 platform_set_drvdata(pdev, led);
> + =A0 =A0 =A0 return 0;
> +
> +err:
> + =A0 =A0 =A0 kfree(led);
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static int __devexit ts5500_led_remove(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct ts5500_led *led =3D platform_get_drvdata(pdev);
> +
> + =A0 =A0 =A0 platform_set_drvdata(pdev, NULL);
> + =A0 =A0 =A0 led_classdev_unregister(&led->cdev);
> + =A0 =A0 =A0 kfree(led);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static struct platform_driver ts5500_led_driver =3D {
> + =A0 =A0 =A0 .driver =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D DRIVER_NAME,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D ts5500_led_probe,
> + =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __devexit_p(ts5500_led_remove),
> +};
> +
> +

Extra Line here

> +static struct led_info ts5500_led_info =3D {
> + =A0 =A0 =A0 .name =3D DRIVER_NAME,
> + =A0 =A0 =A0 .default_trigger =3D DRIVER_NAME,
> + =A0 =A0 =A0 .flags =3D 0x01,

Magic value for flag.

A descriptive macro will be better.

> +};
> +
> +static struct led_platform_data ts5500_led_platform_data =3D {
> + =A0 =A0 =A0 .num_leds =A0 =A0 =A0 =3D 1,
> + =A0 =A0 =A0 .leds =A0 =A0 =A0 =A0 =A0 =3D &ts5500_led_info,
> +};
> +
> +static struct resource ts5500_led_resources[] =3D {
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D DRIVER_NAME,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .start =A0=3D 0x77,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =A0=3D 0x77,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0=3D IORESOURCE_IO,
> + =A0 =A0 =A0 }
> +};
> +
> +static void ts5500_led_release(struct device *dev)
> +{
> + =A0 =A0 =A0 /* noop */
> +}
> +
> +static struct platform_device ts5500_led_device =3D {
> + =A0 =A0 =A0 .name =3D DRIVER_NAME,
> + =A0 =A0 =A0 .resource =3D ts5500_led_resources,
> + =A0 =A0 =A0 .num_resources =3D ARRAY_SIZE(ts5500_led_resources),
> + =A0 =A0 =A0 .id =3D -1,
> + =A0 =A0 =A0 .dev =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .platform_data =3D &ts5500_led_platform_dat=
a,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .release =3D ts5500_led_release,
> + =A0 =A0 =A0 },
> +};
> +
> +static int __init ts5500_led_init(void)
> +{
> + =A0 =A0 =A0 struct ts5xxx_sbcinfo sbcinfo;
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 ts5xxx_sbcinfo_set(&sbcinfo);
> +
> + =A0 =A0 =A0 if (sbcinfo.board_id !=3D 5500) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR DRIVER_NAME
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0": Expected TS5500 but TS-SB=
C reported TS%d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sbcinfo.board_id);

You also consider using pr_err.

Feel free to add.

Reviewed-by: Govindraj.R <govindraj.raja@ti.com>


> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ret =3D platform_driver_register(&ts5500_led_driver);
> + =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error_out;
> +
> + =A0 =A0 =A0 ret =3D platform_device_register(&ts5500_led_device);
> + =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error_device_register;
> +
> + =A0 =A0 =A0 return 0;
> +
> +error_device_register:
> + =A0 =A0 =A0 platform_driver_unregister(&ts5500_led_driver);
> +error_out:
> + =A0 =A0 =A0 return ret;
> +}
> +module_init(ts5500_led_init);
> +
> +static void __exit ts5500_led_exit(void)
> +{
> + =A0 =A0 =A0 platform_driver_unregister(&ts5500_led_driver);
> + =A0 =A0 =A0 platform_device_unregister(&ts5500_led_device);
> +}
> +module_exit(ts5500_led_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("LED driver for Technologic Systems TS5500");
> +MODULE_AUTHOR("Jonas Fonseca <jonas.fonseca@savoirfairelinux.com>");
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
