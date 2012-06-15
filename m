From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:23:47 +0000
Subject: [lm-sensors] [PATCH 66/95] hwmon: (pc87360) Convert to use devm_ functions
Message-Id: <1339773856-3443-67-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Cc: Jim Cromie <jim.cromie@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pc87360.c |   41 +++++++++++++----------------------------
 1 file changed, 13 insertions(+), 28 deletions(-)

diff --git a/drivers/hwmon/pc87360.c b/drivers/hwmon/pc87360.c
index 79ba48c..91d5b2a 100644
--- a/drivers/hwmon/pc87360.c
+++ b/drivers/hwmon/pc87360.c
@@ -1230,7 +1230,7 @@ static int __devinit pc87360_probe(struct platform_device *pdev)
 	int use_thermistors = 0;
 	struct device *dev = &pdev->dev;
 
-	data = kzalloc(sizeof(struct pc87360_data), GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(struct pc87360_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
@@ -1269,15 +1269,12 @@ static int __devinit pc87360_probe(struct platform_device *pdev)
 	for (i = 0; i < LDNI_MAX; i++) {
 		data->address[i] = extra_isa[i];
 		if (data->address[i]
-		 && !request_region(extra_isa[i], PC87360_EXTENT,
-				    pc87360_driver.driver.name)) {
+		 && !devm_request_region(dev, extra_isa[i], PC87360_EXTENT,
+					 pc87360_driver.driver.name)) {
 			dev_err(dev, "Region 0x%x-0x%x already "
 				"in use!\n", extra_isa[i],
 				extra_isa[i]+PC87360_EXTENT-1);
-			for (i--; i >= 0; i--)
-				release_region(extra_isa[i], PC87360_EXTENT);
-			err = -EBUSY;
-			goto ERROR1;
+			return -EBUSY;
 		}
 	}
 
@@ -1325,13 +1322,13 @@ static int __devinit pc87360_probe(struct platform_device *pdev)
 	if (data->innr) {
 		err = sysfs_create_group(&dev->kobj, &pc8736x_vin_group);
 		if (err)
-			goto ERROR3;
+			goto error;
 	}
 
 	if (data->innr = 14) {
 		err = sysfs_create_group(&dev->kobj, &pc8736x_therm_group);
 		if (err)
-			goto ERROR3;
+			goto error;
 	}
 
 	/* create device attr-files for varying sysfs groups */
@@ -1341,11 +1338,11 @@ static int __devinit pc87360_probe(struct platform_device *pdev)
 			err = sysfs_create_group(&dev->kobj,
 						 &pc8736x_temp_attr_group[i]);
 			if (err)
-				goto ERROR3;
+				goto error;
 		}
 		err = device_create_file(dev, &dev_attr_alarms_temp);
 		if (err)
-			goto ERROR3;
+			goto error;
 	}
 
 	for (i = 0; i < data->fannr; i++) {
@@ -1353,49 +1350,37 @@ static int __devinit pc87360_probe(struct platform_device *pdev)
 			err = sysfs_create_group(&dev->kobj,
 						 &pc8736x_fan_attr_group[i]);
 			if (err)
-				goto ERROR3;
+				goto error;
 		}
 		if (FAN_CONFIG_CONTROL(data->fan_conf, i)) {
 			err = device_create_file(dev, &pwm[i].dev_attr);
 			if (err)
-				goto ERROR3;
+				goto error;
 		}
 	}
 
 	err = device_create_file(dev, &dev_attr_name);
 	if (err)
-		goto ERROR3;
+		goto error;
 
 	data->hwmon_dev = hwmon_device_register(dev);
 	if (IS_ERR(data->hwmon_dev)) {
 		err = PTR_ERR(data->hwmon_dev);
-		goto ERROR3;
+		goto error;
 	}
 	return 0;
 
-ERROR3:
+error:
 	pc87360_remove_files(dev);
-	for (i = 0; i < 3; i++) {
-		if (data->address[i])
-			release_region(data->address[i], PC87360_EXTENT);
-	}
-ERROR1:
-	kfree(data);
 	return err;
 }
 
 static int __devexit pc87360_remove(struct platform_device *pdev)
 {
 	struct pc87360_data *data = platform_get_drvdata(pdev);
-	int i;
 
 	hwmon_device_unregister(data->hwmon_dev);
 	pc87360_remove_files(&pdev->dev);
-	for (i = 0; i < 3; i++) {
-		if (data->address[i])
-			release_region(data->address[i], PC87360_EXTENT);
-	}
-	kfree(data);
 
 	return 0;
 }
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
