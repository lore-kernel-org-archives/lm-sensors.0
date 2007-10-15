From: Ivo Manca <pinkel@gmail.com>
Date: Mon, 15 Oct 2007 11:27:13 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon/sis5595: Split sis5595_attributes_opt
Message-Id: <47134E91.6040009@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Ivo Manca <pinkel@gmail.com>

Use sysfs_create_group instead of individual calls to device_create_file by splitting sis5595_attributes_opt into sis5595_attributes_in4 and sis5595_attributes_temp1.

Signed-off-by: Ivo Manca <pinkel@gmail.com>
---
 sis5595.c |   39 ++++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

--- linux-2.6.23.1.orig/drivers/hwmon/sis5595.c	2007-10-15 12:52:47.359375000 +0200
+++ linux-2.6.23.1/drivers/hwmon/sis5595.c	2007-10-15 12:58:48.187500000 +0200
@@ -494,12 +494,19 @@ static const struct attribute_group sis5
 	.attrs = sis5595_attributes,
 };
 
-static struct attribute *sis5595_attributes_opt[] = {
+static struct attribute *sis5595_attributes_in4[] = {
 	&sensor_dev_attr_in4_input.dev_attr.attr,
 	&sensor_dev_attr_in4_min.dev_attr.attr,
 	&sensor_dev_attr_in4_max.dev_attr.attr,
 	&sensor_dev_attr_in4_alarm.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group sis5595_group_in4 = {
+	.attrs = sis5595_attributes_in4,
+};
 
+static struct attribute *sis5595_attributes_temp1[] = {
 	&dev_attr_temp1_input.attr,
 	&dev_attr_temp1_max.attr,
 	&dev_attr_temp1_max_hyst.attr,
@@ -507,8 +514,8 @@ static struct attribute *sis5595_attribu
 	NULL
 };
 
-static const struct attribute_group sis5595_group_opt = {
-	.attrs = sis5595_attributes_opt,
+static const struct attribute_group sis5595_group_temp1 = {
+	.attrs = sis5595_attributes_temp1,
 };
  
 /* This is called when the module is loaded */
@@ -563,24 +570,12 @@ static int __devinit sis5595_probe(struc
 	if ((err = sysfs_create_group(&pdev->dev.kobj, &sis5595_group)))
 		goto exit_free;
 	if (data->maxins = 4) {
-		if ((err = device_create_file(&pdev->dev,
-					&sensor_dev_attr_in4_input.dev_attr))
-		 || (err = device_create_file(&pdev->dev,
-					&sensor_dev_attr_in4_min.dev_attr))
-		 || (err = device_create_file(&pdev->dev,
-					&sensor_dev_attr_in4_max.dev_attr))
-		 || (err = device_create_file(&pdev->dev,
-					&sensor_dev_attr_in4_alarm.dev_attr)))
+		if ((err = sysfs_create_group(&pdev->dev.kobj,
+					      &sis5595_group_in4)))
 			goto exit_remove_files;
 	} else {
-		if ((err = device_create_file(&pdev->dev,
-					      &dev_attr_temp1_input))
-		 || (err = device_create_file(&pdev->dev,
-					      &dev_attr_temp1_max))
-		 || (err = device_create_file(&pdev->dev,
-					      &dev_attr_temp1_max_hyst))
-		 || (err = device_create_file(&pdev->dev,
-				&sensor_dev_attr_temp1_alarm.dev_attr)))
+		if ((err = sysfs_create_group(&pdev->dev.kobj,
+					      &sis5595_group_temp1)))
 			goto exit_remove_files;
 	}
 
@@ -594,7 +589,8 @@ static int __devinit sis5595_probe(struc
 
 exit_remove_files:
 	sysfs_remove_group(&pdev->dev.kobj, &sis5595_group);
-	sysfs_remove_group(&pdev->dev.kobj, &sis5595_group_opt);
+	sysfs_remove_group(&pdev->dev.kobj, &sis5595_group_in4);
+	sysfs_remove_group(&pdev->dev.kobj, &sis5595_group_temp1);
 exit_free:
 	kfree(data);
 exit_release:
@@ -609,7 +605,8 @@ static int __devexit sis5595_remove(stru
 
 	hwmon_device_unregister(data->class_dev);
 	sysfs_remove_group(&pdev->dev.kobj, &sis5595_group);
-	sysfs_remove_group(&pdev->dev.kobj, &sis5595_group_opt);
+	sysfs_remove_group(&pdev->dev.kobj, &sis5595_group_in4);
+	sysfs_remove_group(&pdev->dev.kobj, &sis5595_group_temp1);
 
 	release_region(data->addr, SIS5595_EXTENT);
 	platform_set_drvdata(pdev, NULL);



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
