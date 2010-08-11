From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 11 Aug 2010 15:14:23 +0000
Subject: [lm-sensors] [PATCH 6/6] hwmon: (pc87427) Move sysfs file removal
Message-Id: <20100811171423.01720059@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The sysfs file removal code is the same in the probe error path and in
the remove function, so move it to a separate function to avoid code
duplication.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/pc87427.c |   58 +++++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 32 deletions(-)

--- linux-2.6.35-rc4.orig/drivers/hwmon/pc87427.c	2010-07-11 10:13:07.000000000 +0200
+++ linux-2.6.35-rc4/drivers/hwmon/pc87427.c	2010-07-11 10:17:44.000000000 +0200
@@ -1045,6 +1045,29 @@ static void __devinit pc87427_init_devic
 	}
 }
 
+static void pc87427_remove_files(struct device *dev)
+{
+	struct pc87427_data *data = dev_get_drvdata(dev);
+	int i;
+
+	device_remove_file(dev, &dev_attr_name);
+	for (i = 0; i < 8; i++) {
+		if (!(data->fan_enabled & (1 << i)))
+			continue;
+		sysfs_remove_group(&dev->kobj, &pc87427_group_fan[i]);
+	}
+	for (i = 0; i < 4; i++) {
+		if (!(data->pwm_enabled & (1 << i)))
+			continue;
+		sysfs_remove_group(&dev->kobj, &pc87427_group_pwm[i]);
+	}
+	for (i = 0; i < 6; i++) {
+		if (!(data->temp_enabled & (1 << i)))
+			continue;
+		sysfs_remove_group(&dev->kobj, &pc87427_group_temp[i]);
+	}
+}
+
 static int __devinit pc87427_probe(struct platform_device *pdev)
 {
 	struct pc87427_sio_data *sio_data = pdev->dev.platform_data;
@@ -1110,21 +1133,7 @@ static int __devinit pc87427_probe(struc
 	return 0;
 
 exit_remove_files:
-	for (i = 0; i < 8; i++) {
-		if (!(data->fan_enabled & (1 << i)))
-			continue;
-		sysfs_remove_group(&pdev->dev.kobj, &pc87427_group_fan[i]);
-	}
-	for (i = 0; i < 4; i++) {
-		if (!(data->pwm_enabled & (1 << i)))
-			continue;
-		sysfs_remove_group(&pdev->dev.kobj, &pc87427_group_pwm[i]);
-	}
-	for (i = 0; i < 6; i++) {
-		if (!(data->temp_enabled & (1 << i)))
-			continue;
-		sysfs_remove_group(&pdev->dev.kobj, &pc87427_group_temp[i]);
-	}
+	pc87427_remove_files(&pdev->dev);
 exit_release_region:
 	pc87427_release_regions(pdev, res_count);
 exit_kfree:
@@ -1137,27 +1146,12 @@ exit:
 static int __devexit pc87427_remove(struct platform_device *pdev)
 {
 	struct pc87427_data *data = platform_get_drvdata(pdev);
-	int i, res_count;
+	int res_count;
 
 	res_count = (data->address[0] != 0) + (data->address[1] != 0);
 
 	hwmon_device_unregister(data->hwmon_dev);
-	device_remove_file(&pdev->dev, &dev_attr_name);
-	for (i = 0; i < 8; i++) {
-		if (!(data->fan_enabled & (1 << i)))
-			continue;
-		sysfs_remove_group(&pdev->dev.kobj, &pc87427_group_fan[i]);
-	}
-	for (i = 0; i < 4; i++) {
-		if (!(data->pwm_enabled & (1 << i)))
-			continue;
-		sysfs_remove_group(&pdev->dev.kobj, &pc87427_group_pwm[i]);
-	}
-	for (i = 0; i < 6; i++) {
-		if (!(data->temp_enabled & (1 << i)))
-			continue;
-		sysfs_remove_group(&pdev->dev.kobj, &pc87427_group_temp[i]);
-	}
+	pc87427_remove_files(&pdev->dev);
 	platform_set_drvdata(pdev, NULL);
 	kfree(data);
 

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
