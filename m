From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 21 Feb 2007 19:12:08 +0000
Subject: [lm-sensors] [PATCH] hwmon: Request the I/O regions in platform
Message-Id: <20070221201208.0420dc7d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

My understanding of the resource management in the Linux 2.6 device
driver model is that the devices should declare their resources, and
then when a driver attaches to a device, it should request the
resources it will be using, so as to mark them busy. This is how the
PCI and PNP subsystems work, you can clearly see the two levels of
resources (declaration and request) in /proc/ioports for these
devices.

So I believe that our platform hardware monitoring drivers should
follow the same logic. At the moment, we only declare the resources
but we do not request them. This patch adds the I/O regions request
and release calls.

It works fine with my Fintek F71805F chip. Juerg, can you please test
this patch with your VIA VT1211 chip?

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/hwmon/f71805f.c |   16 +++++++++++++++-
 drivers/hwmon/pc87427.c |   15 ++++++++++++++-
 drivers/hwmon/vt1211.c  |   13 +++++++++++++
 3 files changed, 42 insertions(+), 2 deletions(-)

--- linux-2.6.21-rc1.orig/drivers/hwmon/f71805f.c	2007-02-21 08:34:22.000000000 +0100
+++ linux-2.6.21-rc1/drivers/hwmon/f71805f.c	2007-02-21 19:41:56.000000000 +0100
@@ -35,6 +35,7 @@
 #include <linux/err.h>
 #include <linux/mutex.h>
 #include <linux/sysfs.h>
+#include <linux/ioport.h>
 #include <asm/io.h>
 
 static struct platform_device *pdev;
@@ -1140,6 +1141,13 @@ static int __devinit f71805f_probe(struc
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
+	if (!request_region(res->start + ADDR_REG_OFFSET, 2, DRVNAME)) {
+		err = -EBUSY;
+		dev_err(&pdev->dev, "Failed to request region 0x%lx-0x%lx\n",
+			(unsigned long)(res->start + ADDR_REG_OFFSET),
+			(unsigned long)(res->start + ADDR_REG_OFFSET + 1));
+		goto exit_free;
+	}
 	data->addr = res->start;
 	data->name = names[sio_data->kind];
 	mutex_init(&data->update_lock);
@@ -1165,7 +1173,7 @@ static int __devinit f71805f_probe(struc
 
 	/* Register sysfs interface files */
 	if ((err = sysfs_create_group(&pdev->dev.kobj, &f71805f_group)))
-		goto exit_free;
+		goto exit_release_region;
 	if (data->has_in & (1 << 4)) { /* in4 */
 		if ((err = sysfs_create_group(&pdev->dev.kobj,
 					      &f71805f_group_optin[0])))
@@ -1219,6 +1227,8 @@ exit_remove_files:
 	for (i = 0; i < 4; i++)
 		sysfs_remove_group(&pdev->dev.kobj, &f71805f_group_optin[i]);
 	sysfs_remove_group(&pdev->dev.kobj, &f71805f_group_pwm_freq);
+exit_release_region:
+	release_region(res->start + ADDR_REG_OFFSET, 2);
 exit_free:
 	platform_set_drvdata(pdev, NULL);
 	kfree(data);
@@ -1229,6 +1239,7 @@ exit:
 static int __devexit f71805f_remove(struct platform_device *pdev)
 {
 	struct f71805f_data *data = platform_get_drvdata(pdev);
+	struct resource *res;
 	int i;
 
 	platform_set_drvdata(pdev, NULL);
@@ -1239,6 +1250,9 @@ static int __devexit f71805f_remove(stru
 	sysfs_remove_group(&pdev->dev.kobj, &f71805f_group_pwm_freq);
 	kfree(data);
 
+	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
+	release_region(res->start + ADDR_REG_OFFSET, 2);
+
 	return 0;
 }
 
--- linux-2.6.21-rc1.orig/drivers/hwmon/pc87427.c	2007-02-04 19:44:54.000000000 +0100
+++ linux-2.6.21-rc1/drivers/hwmon/pc87427.c	2007-02-21 19:21:16.000000000 +0100
@@ -31,6 +31,7 @@
 #include <linux/err.h>
 #include <linux/mutex.h>
 #include <linux/sysfs.h>
+#include <linux/ioport.h>
 #include <asm/io.h>
 
 static struct platform_device *pdev;
@@ -429,6 +430,12 @@ static int __devinit pc87427_probe(struc
 	/* This will need to be revisited when we add support for
 	   temperature and voltage monitoring. */
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
+	if (!request_region(res->start, res->end - res->start + 1, DRVNAME)) {
+		err = -EBUSY;
+		dev_err(&pdev->dev, "Failed to request region 0x%lx-0x%lx\n",
+			(unsigned long)res->start, (unsigned long)res->end);
+		goto exit_kfree;
+	}
 	data->address[0] = res->start;
 
 	mutex_init(&data->lock);
@@ -438,7 +445,7 @@ static int __devinit pc87427_probe(struc
 
 	/* Register sysfs hooks */
 	if ((err = device_create_file(&pdev->dev, &dev_attr_name)))
-		goto exit_kfree;
+		goto exit_release_region;
 	for (i = 0; i < 8; i++) {
 		if (!(data->fan_enabled & (1 << i)))
 			continue;
@@ -462,6 +469,8 @@ exit_remove_files:
 			continue;
 		sysfs_remove_group(&pdev->dev.kobj, &pc87427_group_fan[i]);
 	}
+exit_release_region:
+	release_region(res->start, res->end - res->start + 1);
 exit_kfree:
 	platform_set_drvdata(pdev, NULL);
 	kfree(data);
@@ -472,6 +481,7 @@ exit:
 static int __devexit pc87427_remove(struct platform_device *pdev)
 {
 	struct pc87427_data *data = platform_get_drvdata(pdev);
+	struct resource *res;
 	int i;
 
 	platform_set_drvdata(pdev, NULL);
@@ -484,6 +494,9 @@ static int __devexit pc87427_remove(stru
 	}
 	kfree(data);
 
+	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
+	release_region(res->start, res->end - res->start + 1);
+
 	return 0;
 }
 
--- linux-2.6.21-rc1.orig/drivers/hwmon/vt1211.c	2007-02-21 08:34:22.000000000 +0100
+++ linux-2.6.21-rc1/drivers/hwmon/vt1211.c	2007-02-21 19:45:36.000000000 +0100
@@ -31,6 +31,7 @@
 #include <linux/hwmon-vid.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
+#include <linux/ioport.h>
 #include <asm/io.h>
 
 static int uch_config = -1;
@@ -1130,6 +1131,12 @@ static int __devinit vt1211_probe(struct
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
+	if (!request_region(res->start, res->end - res->start + 1, DRVNAME)) {
+		err = -EBUSY;
+		dev_err(dev, "Failed to request region 0x%lx-0x%lx\n",
+			(unsigned long)res->start, (unsigned long)res->end);
+		goto EXIT_KFREE;
+	}
 	data->addr = res->start;
 	data->name = DRVNAME;
 	mutex_init(&data->update_lock);
@@ -1197,6 +1204,8 @@ EXIT_DEV_REMOVE:
 	dev_err(dev, "Sysfs interface creation failed (%d)\n", err);
 EXIT_DEV_REMOVE_SILENT:
 	vt1211_remove_sysfs(pdev);
+	release_region(res->start, res->end - res->start + 1);
+EXIT_KFREE:
 	platform_set_drvdata(pdev, NULL);
 	kfree(data);
 EXIT:
@@ -1206,12 +1215,16 @@ EXIT:
 static int __devexit vt1211_remove(struct platform_device *pdev)
 {
 	struct vt1211_data *data = platform_get_drvdata(pdev);
+	struct resource *res;
 
 	hwmon_device_unregister(data->class_dev);
 	vt1211_remove_sysfs(pdev);
 	platform_set_drvdata(pdev, NULL);
 	kfree(data);
 
+	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
+	release_region(res->start, res->end - res->start + 1);
+
 	return 0;
 }
 


-- 
Jean Delvare

