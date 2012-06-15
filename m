From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:24:03 +0000
Subject: [lm-sensors] [PATCH 82/95] hwmon: (w83627hf) Convert to use devm_ functions
Message-Id: <1339773856-3443-83-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/w83627hf.c |   46 ++++++++++++++++------------------------------
 1 file changed, 16 insertions(+), 30 deletions(-)

diff --git a/drivers/hwmon/w83627hf.c b/drivers/hwmon/w83627hf.c
index 5ce54a2..2cb403c 100644
--- a/drivers/hwmon/w83627hf.c
+++ b/drivers/hwmon/w83627hf.c
@@ -1359,19 +1359,17 @@ static int __devinit w83627hf_probe(struct platform_device *pdev)
 	};
 
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
-	if (!request_region(res->start, WINB_REGION_SIZE, DRVNAME)) {
+	if (!devm_request_region(dev, res->start, WINB_REGION_SIZE, DRVNAME)) {
 		dev_err(dev, "Failed to request region 0x%lx-0x%lx\n",
 			(unsigned long)res->start,
 			(unsigned long)(res->start + WINB_REGION_SIZE - 1));
-		err = -EBUSY;
-		goto ERROR0;
+		return -EBUSY;
 	}
 
-	data = kzalloc(sizeof(struct w83627hf_data), GFP_KERNEL);
-	if (!data) {
-		err = -ENOMEM;
-		goto ERROR1;
-	}
+	data = devm_kzalloc(dev, sizeof(struct w83627hf_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
 	data->addr = res->start;
 	data->type = sio_data->type;
 	data->name = names[sio_data->type];
@@ -1391,7 +1389,7 @@ static int __devinit w83627hf_probe(struct platform_device *pdev)
 	/* Register common device attributes */
 	err = sysfs_create_group(&dev->kobj, &w83627hf_group);
 	if (err)
-		goto ERROR3;
+		return err;
 
 	/* Register chip-specific device attributes */
 	if (data->type = w83627hf || data->type = w83697hf)
@@ -1419,7 +1417,7 @@ static int __devinit w83627hf_probe(struct platform_device *pdev)
 				&sensor_dev_attr_pwm1_freq.dev_attr))
 		 || (err = device_create_file(dev,
 				&sensor_dev_attr_pwm2_freq.dev_attr)))
-			goto ERROR4;
+			goto error;
 
 	if (data->type != w83697hf)
 		if ((err = device_create_file(dev,
@@ -1454,7 +1452,7 @@ static int __devinit w83627hf_probe(struct platform_device *pdev)
 				&sensor_dev_attr_temp3_beep.dev_attr))
 		 || (err = device_create_file(dev,
 				&sensor_dev_attr_temp3_type.dev_attr)))
-			goto ERROR4;
+			goto error;
 
 	if (data->type != w83697hf && data->vid != 0xff) {
 		/* Convert VID to voltage based on VRM */
@@ -1462,14 +1460,14 @@ static int __devinit w83627hf_probe(struct platform_device *pdev)
 
 		if ((err = device_create_file(dev, &dev_attr_cpu0_vid))
 		 || (err = device_create_file(dev, &dev_attr_vrm)))
-			goto ERROR4;
+			goto error;
 	}
 
 	if (data->type = w83627thf || data->type = w83637hf
 	    || data->type = w83687thf) {
 		err = device_create_file(dev, &sensor_dev_attr_pwm3.dev_attr);
 		if (err)
-			goto ERROR4;
+			goto error;
 	}
 
 	if (data->type = w83637hf || data->type = w83687thf)
@@ -1479,57 +1477,45 @@ static int __devinit w83627hf_probe(struct platform_device *pdev)
 				&sensor_dev_attr_pwm2_freq.dev_attr))
 		 || (err = device_create_file(dev,
 				&sensor_dev_attr_pwm3_freq.dev_attr)))
-			goto ERROR4;
+			goto error;
 
 	if (data->type != w83627hf)
 		if ((err = device_create_file(dev,
 				&sensor_dev_attr_pwm1_enable.dev_attr))
 		 || (err = device_create_file(dev,
 				&sensor_dev_attr_pwm2_enable.dev_attr)))
-			goto ERROR4;
+			goto error;
 
 	if (data->type = w83627thf || data->type = w83637hf
 	    || data->type = w83687thf) {
 		err = device_create_file(dev,
 					 &sensor_dev_attr_pwm3_enable.dev_attr);
 		if (err)
-			goto ERROR4;
+			goto error;
 	}
 
 	data->hwmon_dev = hwmon_device_register(dev);
 	if (IS_ERR(data->hwmon_dev)) {
 		err = PTR_ERR(data->hwmon_dev);
-		goto ERROR4;
+		goto error;
 	}
 
 	return 0;
 
-      ERROR4:
+error:
 	sysfs_remove_group(&dev->kobj, &w83627hf_group);
 	sysfs_remove_group(&dev->kobj, &w83627hf_group_opt);
-      ERROR3:
-	platform_set_drvdata(pdev, NULL);
-	kfree(data);
-      ERROR1:
-	release_region(res->start, WINB_REGION_SIZE);
-      ERROR0:
 	return err;
 }
 
 static int __devexit w83627hf_remove(struct platform_device *pdev)
 {
 	struct w83627hf_data *data = platform_get_drvdata(pdev);
-	struct resource *res;
 
 	hwmon_device_unregister(data->hwmon_dev);
 
 	sysfs_remove_group(&pdev->dev.kobj, &w83627hf_group);
 	sysfs_remove_group(&pdev->dev.kobj, &w83627hf_group_opt);
-	platform_set_drvdata(pdev, NULL);
-	kfree(data);
-
-	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
-	release_region(res->start, WINB_REGION_SIZE);
 
 	return 0;
 }
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
