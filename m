From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 09 Dec 2008 15:32:31 +0000
Subject: [lm-sensors] [PATCH] hwmon: Check for ACPI resource conflicts
Message-Id: <20081209163231.46fa6ade@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Check for ACPI resource conflicts in hwmon drivers. I've included
all Super-I/O and PCI drivers.

I've voluntarily left out:
* Vendor-specific drivers: if they conflicted on any system, this would
  pretty much mean that they conflict on all systems, and we would know
  by now.
* Legacy ISA drivers (lm78 and w83781d): they only support chips found
  on old designs were ACPI either wasn't supported or didn't deal with
  thermal management.
* Drivers accessing the I/O resources indirectly (e.g. through SMBus):
  the checks are already done where they belong, i.e. in the bus drivers.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
---
 drivers/hwmon/dme1737.c    |    5 +++++
 drivers/hwmon/f71805f.c    |    5 +++++
 drivers/hwmon/f71882fg.c   |    5 +++++
 drivers/hwmon/it87.c       |    5 +++++
 drivers/hwmon/pc87360.c    |    6 ++++++
 drivers/hwmon/pc87427.c    |    5 +++++
 drivers/hwmon/sis5595.c    |    5 +++++
 drivers/hwmon/smsc47b397.c |    5 +++++
 drivers/hwmon/smsc47m1.c   |    5 +++++
 drivers/hwmon/via686a.c    |    5 +++++
 drivers/hwmon/vt1211.c     |    5 +++++
 drivers/hwmon/vt8231.c     |    5 +++++
 drivers/hwmon/w83627ehf.c  |    6 ++++++
 drivers/hwmon/w83627hf.c   |    5 +++++
 14 files changed, 72 insertions(+)

--- linux-2.6.28-rc7.orig/drivers/hwmon/dme1737.c	2008-10-24 09:27:56.000000000 +0200
+++ linux-2.6.28-rc7/drivers/hwmon/dme1737.c	2008-12-04 16:49:29.000000000 +0100
@@ -34,6 +34,7 @@
 #include <linux/hwmon-vid.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
+#include <linux/acpi.h>
 #include <asm/io.h>
 
 /* ISA device, if found */
@@ -2361,6 +2362,10 @@ static int __init dme1737_isa_device_add
 	};
 	int err;
 
+	err = acpi_check_resource_conflict(&res);
+	if (err)
+		goto exit;
+
 	if (!(pdev = platform_device_alloc("dme1737", addr))) {
 		printk(KERN_ERR "dme1737: Failed to allocate device.\n");
 		err = -ENOMEM;
--- linux-2.6.28-rc7.orig/drivers/hwmon/f71805f.c	2008-04-17 04:49:44.000000000 +0200
+++ linux-2.6.28-rc7/drivers/hwmon/f71805f.c	2008-12-04 16:49:29.000000000 +0100
@@ -39,6 +39,7 @@
 #include <linux/mutex.h>
 #include <linux/sysfs.h>
 #include <linux/ioport.h>
+#include <linux/acpi.h>
 #include <asm/io.h>
 
 static unsigned short force_id;
@@ -1455,6 +1456,10 @@ static int __init f71805f_device_add(uns
 	}
 
 	res.name = pdev->name;
+	err = acpi_check_resource_conflict(&res);
+	if (err)
+		goto exit_device_put;
+
 	err = platform_device_add_resources(pdev, &res, 1);
 	if (err) {
 		printk(KERN_ERR DRVNAME ": Device resource addition failed "
--- linux-2.6.28-rc7.orig/drivers/hwmon/it87.c	2008-12-02 10:16:05.000000000 +0100
+++ linux-2.6.28-rc7/drivers/hwmon/it87.c	2008-12-04 16:49:44.000000000 +0100
@@ -49,6 +49,7 @@
 #include <linux/sysfs.h>
 #include <linux/string.h>
 #include <linux/dmi.h>
+#include <linux/acpi.h>
 #include <asm/io.h>
 
 #define DRVNAME "it87"
@@ -1552,6 +1553,10 @@ static int __init it87_device_add(unsign
 	};
 	int err;
 
+	err = acpi_check_resource_conflict(&res);
+	if (err)
+		goto exit;
+
 	pdev = platform_device_alloc(DRVNAME, address);
 	if (!pdev) {
 		err = -ENOMEM;
--- linux-2.6.28-rc7.orig/drivers/hwmon/pc87360.c	2008-10-24 09:27:57.000000000 +0200
+++ linux-2.6.28-rc7/drivers/hwmon/pc87360.c	2008-12-04 16:49:29.000000000 +0100
@@ -43,6 +43,7 @@
 #include <linux/hwmon-vid.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
+#include <linux/acpi.h>
 #include <asm/io.h>
 
 static u8 devid;
@@ -1627,6 +1628,11 @@ static int __init pc87360_device_add(uns
 			continue;
 		res.start = extra_isa[i];
 		res.end = extra_isa[i] + PC87360_EXTENT - 1;
+
+		err = acpi_check_resource_conflict(&res);
+		if (err)
+			goto exit_device_put;
+
 		err = platform_device_add_resources(pdev, &res, 1);
 		if (err) {
 			printk(KERN_ERR "pc87360: Device resource[%d] "
--- linux-2.6.28-rc7.orig/drivers/hwmon/pc87427.c	2008-04-17 04:49:44.000000000 +0200
+++ linux-2.6.28-rc7/drivers/hwmon/pc87427.c	2008-12-04 16:49:29.000000000 +0100
@@ -32,6 +32,7 @@
 #include <linux/mutex.h>
 #include <linux/sysfs.h>
 #include <linux/ioport.h>
+#include <linux/acpi.h>
 #include <asm/io.h>
 
 static unsigned short force_id;
@@ -524,6 +525,10 @@ static int __init pc87427_device_add(uns
 	};
 	int err;
 
+	err = acpi_check_resource_conflict(&res);
+	if (err)
+		goto exit;
+
 	pdev = platform_device_alloc(DRVNAME, address);
 	if (!pdev) {
 		err = -ENOMEM;
--- linux-2.6.28-rc7.orig/drivers/hwmon/sis5595.c	2008-04-17 04:49:44.000000000 +0200
+++ linux-2.6.28-rc7/drivers/hwmon/sis5595.c	2008-12-04 16:49:29.000000000 +0100
@@ -62,6 +62,7 @@
 #include <linux/jiffies.h>
 #include <linux/mutex.h>
 #include <linux/sysfs.h>
+#include <linux/acpi.h>
 #include <asm/io.h>
 
 
@@ -727,6 +728,10 @@ static int __devinit sis5595_device_add(
 	};
 	int err;
 
+	err = acpi_check_resource_conflict(&res);
+	if (err)
+		goto exit;
+
 	pdev = platform_device_alloc("sis5595", address);
 	if (!pdev) {
 		err = -ENOMEM;
--- linux-2.6.28-rc7.orig/drivers/hwmon/smsc47b397.c	2008-10-10 09:21:53.000000000 +0200
+++ linux-2.6.28-rc7/drivers/hwmon/smsc47b397.c	2008-12-04 16:49:29.000000000 +0100
@@ -36,6 +36,7 @@
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/mutex.h>
+#include <linux/acpi.h>
 #include <asm/io.h>
 
 static unsigned short force_id;
@@ -303,6 +304,10 @@ static int __init smsc47b397_device_add(
 	};
 	int err;
 
+	err = acpi_check_resource_conflict(&res);
+	if (err)
+		goto exit;
+
 	pdev = platform_device_alloc(DRVNAME, address);
 	if (!pdev) {
 		err = -ENOMEM;
--- linux-2.6.28-rc7.orig/drivers/hwmon/smsc47m1.c	2008-12-03 16:23:34.000000000 +0100
+++ linux-2.6.28-rc7/drivers/hwmon/smsc47m1.c	2008-12-04 16:49:29.000000000 +0100
@@ -37,6 +37,7 @@
 #include <linux/init.h>
 #include <linux/mutex.h>
 #include <linux/sysfs.h>
+#include <linux/acpi.h>
 #include <asm/io.h>
 
 static unsigned short force_id;
@@ -705,6 +706,10 @@ static int __init smsc47m1_device_add(un
 	};
 	int err;
 
+	err = acpi_check_resource_conflict(&res);
+	if (err)
+		goto exit;
+
 	pdev = platform_device_alloc(DRVNAME, address);
 	if (!pdev) {
 		err = -ENOMEM;
--- linux-2.6.28-rc7.orig/drivers/hwmon/via686a.c	2008-04-17 04:49:44.000000000 +0200
+++ linux-2.6.28-rc7/drivers/hwmon/via686a.c	2008-12-04 16:49:29.000000000 +0100
@@ -41,6 +41,7 @@
 #include <linux/init.h>
 #include <linux/mutex.h>
 #include <linux/sysfs.h>
+#include <linux/acpi.h>
 #include <asm/io.h>
 
 
@@ -783,6 +784,10 @@ static int __devinit via686a_device_add(
 	};
 	int err;
 
+	err = acpi_check_resource_conflict(&res);
+	if (err)
+		goto exit;
+
 	pdev = platform_device_alloc("via686a", address);
 	if (!pdev) {
 		err = -ENOMEM;
--- linux-2.6.28-rc7.orig/drivers/hwmon/vt1211.c	2008-04-17 04:49:44.000000000 +0200
+++ linux-2.6.28-rc7/drivers/hwmon/vt1211.c	2008-12-04 16:49:29.000000000 +0100
@@ -32,6 +32,7 @@
 #include <linux/err.h>
 #include <linux/mutex.h>
 #include <linux/ioport.h>
+#include <linux/acpi.h>
 #include <asm/io.h>
 
 static int uch_config = -1;
@@ -1259,6 +1260,10 @@ static int __init vt1211_device_add(unsi
 	}
 
 	res.name = pdev->name;
+	err = acpi_check_resource_conflict(&res);
+	if (err)
+		goto EXIT;
+
 	err = platform_device_add_resources(pdev, &res, 1);
 	if (err) {
 		printk(KERN_ERR DRVNAME ": Device resource addition failed "
--- linux-2.6.28-rc7.orig/drivers/hwmon/vt8231.c	2008-04-17 04:49:44.000000000 +0200
+++ linux-2.6.28-rc7/drivers/hwmon/vt8231.c	2008-12-04 16:49:29.000000000 +0100
@@ -35,6 +35,7 @@
 #include <linux/hwmon-vid.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
+#include <linux/acpi.h>
 #include <asm/io.h>
 
 static int force_addr;
@@ -894,6 +895,10 @@ static int __devinit vt8231_device_add(u
 	};
 	int err;
 
+	err = acpi_check_resource_conflict(&res);
+	if (err)
+		goto exit;
+
 	pdev = platform_device_alloc("vt8231", address);
 	if (!pdev) {
 		err = -ENOMEM;
--- linux-2.6.28-rc7.orig/drivers/hwmon/w83627ehf.c	2008-04-17 04:49:44.000000000 +0200
+++ linux-2.6.28-rc7/drivers/hwmon/w83627ehf.c	2008-12-04 16:49:29.000000000 +0100
@@ -48,6 +48,7 @@
 #include <linux/hwmon-vid.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
+#include <linux/acpi.h>
 #include <asm/io.h>
 #include "lm75.h"
 
@@ -1544,6 +1545,11 @@ static int __init sensors_w83627ehf_init
 	res.start = address + IOREGION_OFFSET;
 	res.end = address + IOREGION_OFFSET + IOREGION_LENGTH - 1;
 	res.flags = IORESOURCE_IO;
+
+	err = acpi_check_resource_conflict(&res);
+	if (err)
+		goto exit;
+
 	err = platform_device_add_resources(pdev, &res, 1);
 	if (err) {
 		printk(KERN_ERR DRVNAME ": Device resource addition failed "
--- linux-2.6.28-rc7.orig/drivers/hwmon/w83627hf.c	2008-10-10 09:27:55.000000000 +0200
+++ linux-2.6.28-rc7/drivers/hwmon/w83627hf.c	2008-12-04 16:49:29.000000000 +0100
@@ -50,6 +50,7 @@
 #include <linux/err.h>
 #include <linux/mutex.h>
 #include <linux/ioport.h>
+#include <linux/acpi.h>
 #include <asm/io.h>
 #include "lm75.h"
 
@@ -1793,6 +1794,10 @@ static int __init w83627hf_device_add(un
 	};
 	int err;
 
+	err = acpi_check_resource_conflict(&res);
+	if (err)
+		goto exit;
+
 	pdev = platform_device_alloc(DRVNAME, address);
 	if (!pdev) {
 		err = -ENOMEM;
--- linux-2.6.28-rc7.orig/drivers/hwmon/f71882fg.c	2008-12-02 10:16:03.000000000 +0100
+++ linux-2.6.28-rc7/drivers/hwmon/f71882fg.c	2008-12-04 16:50:05.000000000 +0100
@@ -28,6 +28,7 @@
 #include <linux/err.h>
 #include <linux/mutex.h>
 #include <linux/io.h>
+#include <linux/acpi.h>
 
 #define DRVNAME "f71882fg"
 
@@ -1681,6 +1682,10 @@ static int __init f71882fg_device_add(un
 		return -ENOMEM;
 
 	res.name = f71882fg_pdev->name;
+	err = acpi_check_resource_conflict(&res);
+	if (err)
+		return err;
+
 	err = platform_device_add_resources(f71882fg_pdev, &res, 1);
 	if (err) {
 		printk(KERN_ERR DRVNAME ": Device resource addition failed\n");


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
