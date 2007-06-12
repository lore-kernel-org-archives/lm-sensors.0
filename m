From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 12 Jun 2007 11:57:19 +0000
Subject: [lm-sensors] [PATCH] hwmon: Fix a potential race condition on unload
Message-Id: <20070612135719.3f4c61a5@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fix a potential race condition when some hardware monitoring platform
drivers are being unloaded. I believe that the driver data pointer
shouldn't be cleared before all the sysfs files are removed, otherwise
a sysfs callback might attempt to dereference a NULL pointer. I'm not
sure exactly what the driver core protects drivers against, so let's
play it safe.

While we're here, clear the driver data pointer when probe fails, so
as to not leave an invalid pointer behind us.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/abituguru.c |    3 ++-
 drivers/hwmon/f71805f.c   |    2 +-
 drivers/hwmon/pc87427.c   |    2 +-
 drivers/hwmon/smsc47m1.c  |    3 ++-
 drivers/hwmon/w83627hf.c  |    3 ++-
 5 files changed, 8 insertions(+), 5 deletions(-)

--- linux-2.6.22-rc4.orig/drivers/hwmon/abituguru.c	2007-04-26 18:29:52.000000000 +0200
+++ linux-2.6.22-rc4/drivers/hwmon/abituguru.c	2007-06-12 11:13:27.000000000 +0200
@@ -1287,6 +1287,7 @@ abituguru_probe_error:
 	for (i = 0; i < ARRAY_SIZE(abituguru_sysfs_attr); i++)
 		device_remove_file(&pdev->dev,
 			&abituguru_sysfs_attr[i].dev_attr);
+	platform_set_drvdata(pdev, NULL);
 	kfree(data);
 	return res;
 }
@@ -1296,13 +1297,13 @@ static int __devexit abituguru_remove(st
 	int i;
 	struct abituguru_data *data = platform_get_drvdata(pdev);
 
-	platform_set_drvdata(pdev, NULL);
 	hwmon_device_unregister(data->class_dev);
 	for (i = 0; data->sysfs_attr[i].dev_attr.attr.name; i++)
 		device_remove_file(&pdev->dev, &data->sysfs_attr[i].dev_attr);
 	for (i = 0; i < ARRAY_SIZE(abituguru_sysfs_attr); i++)
 		device_remove_file(&pdev->dev,
 			&abituguru_sysfs_attr[i].dev_attr);
+	platform_set_drvdata(pdev, NULL);
 	kfree(data);
 
 	return 0;
--- linux-2.6.22-rc4.orig/drivers/hwmon/f71805f.c	2007-06-12 10:15:31.000000000 +0200
+++ linux-2.6.22-rc4/drivers/hwmon/f71805f.c	2007-06-12 11:14:03.000000000 +0200
@@ -1242,12 +1242,12 @@ static int __devexit f71805f_remove(stru
 	struct resource *res;
 	int i;
 
-	platform_set_drvdata(pdev, NULL);
 	hwmon_device_unregister(data->class_dev);
 	sysfs_remove_group(&pdev->dev.kobj, &f71805f_group);
 	for (i = 0; i < 4; i++)
 		sysfs_remove_group(&pdev->dev.kobj, &f71805f_group_optin[i]);
 	sysfs_remove_group(&pdev->dev.kobj, &f71805f_group_pwm_freq);
+	platform_set_drvdata(pdev, NULL);
 	kfree(data);
 
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
--- linux-2.6.22-rc4.orig/drivers/hwmon/pc87427.c	2007-05-13 10:01:15.000000000 +0200
+++ linux-2.6.22-rc4/drivers/hwmon/pc87427.c	2007-06-12 11:14:13.000000000 +0200
@@ -484,7 +484,6 @@ static int __devexit pc87427_remove(stru
 	struct resource *res;
 	int i;
 
-	platform_set_drvdata(pdev, NULL);
 	hwmon_device_unregister(data->class_dev);
 	device_remove_file(&pdev->dev, &dev_attr_name);
 	for (i = 0; i < 8; i++) {
@@ -492,6 +491,7 @@ static int __devexit pc87427_remove(stru
 			continue;
 		sysfs_remove_group(&pdev->dev.kobj, &pc87427_group_fan[i]);
 	}
+	platform_set_drvdata(pdev, NULL);
 	kfree(data);
 
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
--- linux-2.6.22-rc4.orig/drivers/hwmon/smsc47m1.c	2007-06-12 10:15:31.000000000 +0200
+++ linux-2.6.22-rc4/drivers/hwmon/smsc47m1.c	2007-06-12 11:13:54.000000000 +0200
@@ -597,6 +597,7 @@ static int __devinit smsc47m1_probe(stru
 error_remove_files:
 	sysfs_remove_group(&dev->kobj, &smsc47m1_group);
 error_free:
+	platform_set_drvdata(pdev, NULL);
 	kfree(data);
 error_release:
 	release_region(res->start, SMSC_EXTENT);
@@ -608,12 +609,12 @@ static int __devexit smsc47m1_remove(str
 	struct smsc47m1_data *data = platform_get_drvdata(pdev);
 	struct resource *res;
 
-	platform_set_drvdata(pdev, NULL);
 	hwmon_device_unregister(data->class_dev);
 	sysfs_remove_group(&pdev->dev.kobj, &smsc47m1_group);
 
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
 	release_region(res->start, SMSC_EXTENT);
+	platform_set_drvdata(pdev, NULL);
 	kfree(data);
 
 	return 0;
--- linux-2.6.22-rc4.orig/drivers/hwmon/w83627hf.c	2007-06-12 10:15:39.000000000 +0200
+++ linux-2.6.22-rc4/drivers/hwmon/w83627hf.c	2007-06-12 11:13:38.000000000 +0200
@@ -1306,6 +1306,7 @@ static int __devinit w83627hf_probe(stru
 	sysfs_remove_group(&dev->kobj, &w83627hf_group);
 	sysfs_remove_group(&dev->kobj, &w83627hf_group_opt);
       ERROR3:
+	platform_set_drvdata(pdev, NULL);
 	kfree(data);
       ERROR1:
 	release_region(res->start, WINB_REGION_SIZE);
@@ -1318,11 +1319,11 @@ static int __devexit w83627hf_remove(str
 	struct w83627hf_data *data = platform_get_drvdata(pdev);
 	struct resource *res;
 
-	platform_set_drvdata(pdev, NULL);
 	hwmon_device_unregister(data->class_dev);
 
 	sysfs_remove_group(&pdev->dev.kobj, &w83627hf_group);
 	sysfs_remove_group(&pdev->dev.kobj, &w83627hf_group_opt);
+	platform_set_drvdata(pdev, NULL);
 	kfree(data);
 
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
