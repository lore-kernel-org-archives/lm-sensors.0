From: Steve Sakoman <sakoman@gmail.com>
Date: Fri, 09 Dec 2011 14:20:10 +0000
Subject: Re: [lm-sensors] [PATCH] omap: beagle: Don't register madc twice
Message-Id: <CAGDS+nmKy4Xn_rEpzD+QRSWKgv80OXCOmbThJKHMd+eBy_H+Xw@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAGDS+n=zapd+aEAGnK5sUn=Vdna8Fjvsd7K9jJZQuvSZ8BsFBA@mail.gmail.com>
In-Reply-To: <CAGDS+n=zapd+aEAGnK5sUn=Vdna8Fjvsd7K9jJZQuvSZ8BsFBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@lm-sensors.org, linux-omap@vger.kernel.org
Cc: Keerthy <j-keerthy@ti.com>, Kyle Manna <kyle@kylemanna.com>

On Fri, Dec 9, 2011 at 6:12 AM, Steve Sakoman <sakoman@gmail.com> wrote:
> Specifying TWL_COMMON_PDATA_MADC is adequate, don't also add
> platform device
>
> Otherwise:
>
> ------------[ cut here ]------------
> WARNING: at fs/sysfs/dir.c:481 sysfs_add_one+0x6c/0x8c()
> sysfs: cannot create duplicate filename
> '/bus/platform/devices/twl4030_madc_hwmon'
> Modules linked in:
> [<c0012b48>] (unwind_backtrace+0x0/0x11c) from [<c0038450>]
> (warn_slowpath_common+0x4c/0x64)
> [<c0038450>] (warn_slowpath_common+0x4c/0x64) from [<c00384e8>]
> (warn_slowpath_fmt+0x2c/0x3c)
> [<c00384e8>] (warn_slowpath_fmt+0x2c/0x3c) from [<c01043d4>]
> (sysfs_add_one+0x6c/0x8c)
> [<c01043d4>] (sysfs_add_one+0x6c/0x8c) from [<c0104b50>]
> (sysfs_do_create_link+0xec/0x1cc)
> [<c0104b50>] (sysfs_do_create_link+0xec/0x1cc) from [<c025577c>]
> (bus_add_device+0xd4/0x158)
> [<c025577c>] (bus_add_device+0xd4/0x158) from [<c0253e08>]
> (device_add+0x378/0x560)
> [<c0253e08>] (device_add+0x378/0x560) from [<c0257a40>]
> (platform_device_add+0x140/0x1a4)
> [<c0257a40>] (platform_device_add+0x140/0x1a4) from [<c0265624>]
> (add_numbered_child+0x144/0x1a4)
> [<c0265624>] (add_numbered_child+0x144/0x1a4) from [<c02657cc>]
> (add_children+0xc4/0x808)
> [<c02657cc>] (add_children+0xc4/0x808) from [<c040df88>] (twl_probe+0x390=
/0x418)
> [<c040df88>] (twl_probe+0x390/0x418) from [<c02dbb9c>]
> (i2c_device_probe+0xa0/0xd4)
> [<c02dbb9c>] (i2c_device_probe+0xa0/0xd4) from [<c02561dc>]
> (driver_probe_device+0x144/0x29c)
> [<c02561dc>] (driver_probe_device+0x144/0x29c) from [<c0254f9c>]
> (bus_for_each_drv+0x4c/0x84)
> [<c0254f9c>] (bus_for_each_drv+0x4c/0x84) from [<c0255f80>]
> (device_attach+0x74/0xa0)
> [<c0255f80>] (device_attach+0x74/0xa0) from [<c0255824>]
> (bus_probe_device+0x24/0x40)
> [<c0255824>] (bus_probe_device+0x24/0x40) from [<c0253e5c>]
> (device_add+0x3cc/0x560)
> [<c0253e5c>] (device_add+0x3cc/0x560) from [<c02dc5a8>]
> (i2c_new_device+0x10c/0x1b0)
> [<c02dc5a8>] (i2c_new_device+0x10c/0x1b0) from [<c02dca04>]
> (i2c_register_adapter+0x160/0x218)
> [<c02dca04>] (i2c_register_adapter+0x160/0x218) from [<c02dcbe4>]
> (i2c_add_numbered_adapter+0x9c/0xb8)
> [<c02dcbe4>] (i2c_add_numbered_adapter+0x9c/0xb8) from [<c04106fc>]
> (omap_i2c_probe+0x2b8/0x384)
> [<c04106fc>] (omap_i2c_probe+0x2b8/0x384) from [<c025741c>]
> (platform_drv_probe+0x14/0x18)
> [<c025741c>] (platform_drv_probe+0x14/0x18) from [<c02561dc>]
> (driver_probe_device+0x144/0x29c)
> [<c02561dc>] (driver_probe_device+0x144/0x29c) from [<c0256394>]
> (__driver_attach+0x60/0x84)
> [<c0256394>] (__driver_attach+0x60/0x84) from [<c025525c>]
> (bus_for_each_dev+0x4c/0x78)
> [<c025525c>] (bus_for_each_dev+0x4c/0x78) from [<c02559c4>]
> (bus_add_driver+0xc0/0x240)
> [<c02559c4>] (bus_add_driver+0xc0/0x240) from [<c02568c0>]
> (driver_register+0xa0/0x120)
> [<c02568c0>] (driver_register+0xa0/0x120) from [<c000863c>]
> (do_one_initcall+0x90/0x160)
> [<c000863c>] (do_one_initcall+0x90/0x160) from [<c05f47b4>]
> (kernel_init+0x78/0x11c)
> [<c05f47b4>] (kernel_init+0x78/0x11c) from [<c000e918>]
> (kernel_thread_exit+0x0/0x8)
> ---[ end trace 1b75b31a2719ed1c ]---
> dummy 1-004a: can't add twl4030_madc_hwmon dev
>
> Signed-off-by: Steve Sakoman <steve@sakoman.com>
> ---
>
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c
> b/arch/arm/mach-omap2/board-omap3beagle.c
> index d47470e..91c1a7c 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -634,15 +634,9 @@ static struct platform_device keys_gpio =3D {
> =A0 =A0 =A0 =A0},
> =A0};
>
> -static struct platform_device madc_hwmon =3D {
> - =A0 =A0 =A0 .name =A0 =3D "twl4030_madc_hwmon",
> - =A0 =A0 =A0 .id =A0 =A0 =3D -1,
> -};
> -
> =A0static struct platform_device *omap3_beagle_devices[] __initdata =3D {
> =A0 =A0 =A0 =A0&leds_gpio,
> =A0 =A0 =A0 =A0&keys_gpio,
> - =A0 =A0 =A0 &madc_hwmon,
> =A0};
>
> =A0static const struct usbhs_omap_board_data usbhs_bdata __initconst =3D {

Just realized that this issue occurs because I am carrying the patch
below in my repository.

Keerthy, did this patch get lost somehow, or have you decided not to use it?

From: Keerthy <j-keerthy@ti.com>
Date: Tue, 3 May 2011 19:44:50 +0000 (+0530)
Subject: Enabling Hwmon driver for twl4030-madc
X-Git-Url: http://www.sakoman.com/cgi-bin/gitweb.cgi?p=3Dlinux-omap-2.6.git=
;a=3Dcommitdiff_plain;h=3Dcf09adceae8f3d9fc2f9e21bb90f20403a45ad0f

Enabling Hwmon driver for twl4030-madc

Signed-off-by: Keerthy <j-keerthy@ti.com>
---

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 50a6d2e..e718ae2 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -84,6 +84,13 @@
 #define twl_has_madc()	false
 #endif

+#if defined(CONFIG_SENSORS_TWL4030_MADC) ||\
+	 defined(CONFIG_SENSORS_TWL4030_MADC_MODULE)
+#define twl_has_madc_hwmon()  true
+#else
+#define twl_has_madc_hwmon()  false
+#endif
+
 #ifdef CONFIG_TWL4030_POWER
 #define twl_has_power()        true
 #else
@@ -680,6 +687,14 @@ add_children(struct twl4030_platform_data *pdata,
unsigned long features)
 			return PTR_ERR(child);
 	}

+if (twl_has_madc_hwmon()) {
+		child =3D add_child(2, "twl4030_madc_hwmon",
+				NULL, 0,
+				true, pdata->irq_base + MADC_INTR_OFFSET, 0);
+		if (IS_ERR(child))
+			return PTR_ERR(child);
+	}
+
 	if (twl_has_rtc()) {
 		/*
 		 * REVISIT platform_data here currently might expose the

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
