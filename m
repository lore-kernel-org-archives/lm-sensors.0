From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date: Fri, 21 Dec 2007 19:00:30 +0000
Subject: Re: [lm-sensors] 2.6.24-rc4 hwmon it87 probe fails
Message-Id: <200712211200.30947.bjorn.helgaas@hp.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071204215154.7f26285e.mikeserv@bmts.com> <200712171014.44360.bjorn.helgaas@hp.com> <20071218185918.5d2d4c7d@hyperion.delvare>
In-Reply-To: <20071218185918.5d2d4c7d@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Jean Delvare <khali@linux-fr.org>
Cc: Shaohua Li <shaohua.li@intel.com>, Mike Houston <mikeserv@bmts.com>, Adrian Bunk <bunk@stusta.de>, Elvis Pranskevichus <el@prans.net>, mhoffman@lightlink.com, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Adam Belay <ambx1@neo.rr.com>, Zhao Yakui <yakui.zhao@intel.com>, Thomas Renninger <trenn@suse.de>, lenb@kernel.org, linux-acpi@vger.kernel.org

On Tuesday 18 December 2007 10:59:18 am Jean Delvare wrote:
> My initial idea was to identify the faulty motherboard using DMI and to
> force pnpacpi=3Doff on the faulty motherboards. If this is considered too
> aggressive, maybe we can just reject resource declarations that
> intersect (but don't match) 0x290-0x297 for these motherboards. Either
> way, we have to do something, and we have to do it quickly. 2.6.24
> final isn't too far away, and more importantly, the patch that revealed
> the problem has been backported to 2.6.23.10 so people are experiencing
> regressions already.

What do you think of something like the following patch?  If we do
this, I don't think we'd need to force pnpacpi=3Doff or change the
way PNP reserves resources.

I'll be on vacation until about January 2, so I won't be able to
do much with this until then.



[patch] it87: request only Environment Controller ports

The IT8705F and related parts are Super I/O controllers that contain
many separate devices.

Some BIOSes describe IT8705F I/O port usage under a motherboard device
(PNP0C02) with overlapping regions, e.g., 0x290-0x29f and 0x290-0x294.

The it87 driver supports only the Environment Controller, which requires
only two ISA ports, but it used to request an eight-port range.  If that
range exceeds a range reported by the BIOS, as 0x290-0x297 would, the
request fails, and the it87 driver cannot claim the device.

This patch makes the it87 driver request only the two ports used for the
Environment Controller device.

Systems where this problem has been reported:
    Gigabyte GA-K8N Ultra 9
    Gigabyte M56S-S3
    Gigabyte GA-965G-DS3

Kernel bug reports:
    http://bugzilla.kernel.org/show_bug.cgi?id=9514
    http://lkml.org/lkml/2007/12/4/466

Related change:
    http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
commitdiff;h=A7839e960675b549f06209d18283d5cee2ce9261

    The patch above increases the number of PNP port resources we support.
    Prior to this patch, we ignored some port resources, which masked the
    it87 problem.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work4/drivers/hwmon/it87.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- work4.orig/drivers/hwmon/it87.c	2007-12-21 10:3=
8:46.000000000 -0700
+++ work4/drivers/hwmon/it87.c	2007-12-21 11:43:50.000000000 -0700
@@ -2,6 +2,14 @@
     it87.c - Part of lm_sensors, Linux kernel modules for hardware
              monitoring.
=20
+    The IT8705F is an LPC-based Super I/O part that contains UARTs, a
+    parallel port, an IR port, a MIDI port, a floppy controller, etc., in
+    addition to an Environment Controller (Enhanced Hardware Monitor and
+    Fan Controller)
+
+    This driver supports only the Environment Controller in the IT8705F and
+    similar parts.  The other devices are supported by different drivers.
+
     Supports: IT8705F  Super I/O chip w/LPC interface
               IT8712F  Super I/O chip w/LPC interface
               IT8716F  Super I/O chip w/LPC interface
@@ -118,9 +126,15 @@
 /* Length of ISA address segment */
 #define IT87_EXTENT 8
=20
-/* Where are the ISA address/data registers relative to the base address */
-#define IT87_ADDR_REG_OFFSET 5
-#define IT87_DATA_REG_OFFSET 6
+/* Length of ISA address segment for Environmental Controller */
+#define IT87_EC_EXTENT 2
+
+/* Offset of EC registers from ISA base address */
+#define IT87_EC_OFFSET 5
+
+/* Where are the ISA address/data registers relative to the EC base addres=
s */
+#define IT87_ADDR_REG_OFFSET 0
+#define IT87_DATA_REG_OFFSET 1
=20
 /*----- The IT87 registers -----*/
=20
@@ -968,10 +982,10 @@
 	};
=20
 	res =3D platform_get_resource(pdev, IORESOURCE_IO, 0);
-	if (!request_region(res->start, IT87_EXTENT, DRVNAME)) {
+	if (!request_region(res->start, IT87_EC_EXTENT, DRVNAME)) {
 		dev_err(dev, "Failed to request region 0x%lx-0x%lx\n",
 			(unsigned long)res->start,
-			(unsigned long)(res->start + IT87_EXTENT - 1));
+			(unsigned long)(res->start + IT87_EC_EXTENT - 1));
 		err =3D -EBUSY;
 		goto ERROR0;
 	}
@@ -1124,7 +1138,7 @@
 	platform_set_drvdata(pdev, NULL);
 	kfree(data);
 ERROR1:
-	release_region(res->start, IT87_EXTENT);
+	release_region(res->start, IT87_EC_EXTENT);
 ERROR0:
 	return err;
 }
@@ -1137,7 +1151,7 @@
 	sysfs_remove_group(&pdev->dev.kobj, &it87_group);
 	sysfs_remove_group(&pdev->dev.kobj, &it87_group_opt);
=20
-	release_region(data->addr, IT87_EXTENT);
+	release_region(data->addr, IT87_EC_EXTENT);
 	platform_set_drvdata(pdev, NULL);
 	kfree(data);
=20
@@ -1402,8 +1416,8 @@
 				  const struct it87_sio_data *sio_data)
 {
 	struct resource res =3D {
-		.start	=3D address ,
-		.end	=3D address + IT87_EXTENT - 1,
+		.start	=3D address + IT87_EC_OFFSET,
+		.end	=3D address + IT87_EC_OFFSET + IT87_EC_EXTENT - 1,
 		.name	=3D DRVNAME,
 		.flags	=3D IORESOURCE_IO,
 	};

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
