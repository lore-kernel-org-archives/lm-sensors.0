From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 20 Jan 2012 19:39:15 +0000
Subject: [lm-sensors] [PATCH 03/13] hwmon: (smsc47m1) Fix: do not use assignment in if condition
Message-Id: <1327088365-11149-4-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fix checkpatch issue:
ERROR: do not use assignment in if condition

Replace repeated calls to device_create_file() with calls to sysfs_create_group.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/smsc47m1.c |  127 ++++++++++++++++++++++++++++-----------------
 1 files changed, 79 insertions(+), 48 deletions(-)

diff --git a/drivers/hwmon/smsc47m1.c b/drivers/hwmon/smsc47m1.c
index b2da582..d265a51 100644
--- a/drivers/hwmon/smsc47m1.c
+++ b/drivers/hwmon/smsc47m1.c
@@ -415,32 +415,73 @@ static ssize_t show_name(struct device *dev, struct device_attribute
 }
 static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
 
-/*
- * Almost all sysfs files may or may not be created depending on the chip
- * setup so we create them individually. It is still convenient to define a
- * group to remove them all at once.
- */
-static struct attribute *smsc47m1_attributes[] = {
+static struct attribute *smsc47m1_attributes_fan1[] = {
 	&sensor_dev_attr_fan1_input.dev_attr.attr,
 	&sensor_dev_attr_fan1_min.dev_attr.attr,
 	&sensor_dev_attr_fan1_div.dev_attr.attr,
 	&sensor_dev_attr_fan1_alarm.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group smsc47m1_group_fan1 = {
+	.attrs = smsc47m1_attributes_fan1,
+};
+
+static struct attribute *smsc47m1_attributes_fan2[] = {
 	&sensor_dev_attr_fan2_input.dev_attr.attr,
 	&sensor_dev_attr_fan2_min.dev_attr.attr,
 	&sensor_dev_attr_fan2_div.dev_attr.attr,
 	&sensor_dev_attr_fan2_alarm.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group smsc47m1_group_fan2 = {
+	.attrs = smsc47m1_attributes_fan2,
+};
+
+static struct attribute *smsc47m1_attributes_fan3[] = {
 	&sensor_dev_attr_fan3_input.dev_attr.attr,
 	&sensor_dev_attr_fan3_min.dev_attr.attr,
 	&sensor_dev_attr_fan3_div.dev_attr.attr,
 	&sensor_dev_attr_fan3_alarm.dev_attr.attr,
+	NULL
+};
 
+static const struct attribute_group smsc47m1_group_fan3 = {
+	.attrs = smsc47m1_attributes_fan3,
+};
+
+static struct attribute *smsc47m1_attributes_pwm1[] = {
 	&sensor_dev_attr_pwm1.dev_attr.attr,
 	&sensor_dev_attr_pwm1_enable.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group smsc47m1_group_pwm1 = {
+	.attrs = smsc47m1_attributes_pwm1,
+};
+
+static struct attribute *smsc47m1_attributes_pwm2[] = {
 	&sensor_dev_attr_pwm2.dev_attr.attr,
 	&sensor_dev_attr_pwm2_enable.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group smsc47m1_group_pwm2 = {
+	.attrs = smsc47m1_attributes_pwm2,
+};
+
+static struct attribute *smsc47m1_attributes_pwm3[] = {
 	&sensor_dev_attr_pwm3.dev_attr.attr,
 	&sensor_dev_attr_pwm3_enable.dev_attr.attr,
+	NULL
+};
 
+static const struct attribute_group smsc47m1_group_pwm3 = {
+	.attrs = smsc47m1_attributes_pwm3,
+};
+
+static struct attribute *smsc47m1_attributes[] = {
 	&dev_attr_alarms.attr,
 	&dev_attr_name.attr,
 	NULL
@@ -622,6 +663,17 @@ static int smsc47m1_handle_resources(unsigned short address, enum chips type,
 	return 0;
 }
 
+static void smsc47m1_remove_files(struct device *dev)
+{
+	sysfs_remove_group(&dev->kobj, &smsc47m1_group);
+	sysfs_remove_group(&dev->kobj, &smsc47m1_group_fan1);
+	sysfs_remove_group(&dev->kobj, &smsc47m1_group_fan2);
+	sysfs_remove_group(&dev->kobj, &smsc47m1_group_fan3);
+	sysfs_remove_group(&dev->kobj, &smsc47m1_group_pwm1);
+	sysfs_remove_group(&dev->kobj, &smsc47m1_group_pwm2);
+	sysfs_remove_group(&dev->kobj, &smsc47m1_group_pwm3);
+}
+
 static int __init smsc47m1_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -697,75 +749,54 @@ static int __init smsc47m1_probe(struct platform_device *pdev)
 
 	/* Register sysfs hooks */
 	if (fan1) {
-		if ((err = device_create_file(dev,
-				&sensor_dev_attr_fan1_input.dev_attr))
-		 || (err = device_create_file(dev,
-				&sensor_dev_attr_fan1_min.dev_attr))
-		 || (err = device_create_file(dev,
-				&sensor_dev_attr_fan1_div.dev_attr))
-		 || (err = device_create_file(dev,
-				&sensor_dev_attr_fan1_alarm.dev_attr)))
+		err = sysfs_create_group(&dev->kobj,
+					 &smsc47m1_group_fan1);
+		if (err)
 			goto error_remove_files;
 	} else
 		dev_dbg(dev, "Fan 1 not enabled by hardware, skipping\n");
 
 	if (fan2) {
-		if ((err = device_create_file(dev,
-				&sensor_dev_attr_fan2_input.dev_attr))
-		 || (err = device_create_file(dev,
-				&sensor_dev_attr_fan2_min.dev_attr))
-		 || (err = device_create_file(dev,
-				&sensor_dev_attr_fan2_div.dev_attr))
-		 || (err = device_create_file(dev,
-				&sensor_dev_attr_fan2_alarm.dev_attr)))
+		err = sysfs_create_group(&dev->kobj,
+					 &smsc47m1_group_fan2);
+		if (err)
 			goto error_remove_files;
 	} else
 		dev_dbg(dev, "Fan 2 not enabled by hardware, skipping\n");
 
 	if (fan3) {
-		if ((err = device_create_file(dev,
-				&sensor_dev_attr_fan3_input.dev_attr))
-		 || (err = device_create_file(dev,
-				&sensor_dev_attr_fan3_min.dev_attr))
-		 || (err = device_create_file(dev,
-				&sensor_dev_attr_fan3_div.dev_attr))
-		 || (err = device_create_file(dev,
-				&sensor_dev_attr_fan3_alarm.dev_attr)))
+		err = sysfs_create_group(&dev->kobj,
+					 &smsc47m1_group_fan3);
+		if (err)
 			goto error_remove_files;
 	} else if (data->type = smsc47m2)
 		dev_dbg(dev, "Fan 3 not enabled by hardware, skipping\n");
 
 	if (pwm1) {
-		if ((err = device_create_file(dev,
-				&sensor_dev_attr_pwm1.dev_attr))
-		 || (err = device_create_file(dev,
-				&sensor_dev_attr_pwm1_enable.dev_attr)))
+		err = sysfs_create_group(&dev->kobj,
+					 &smsc47m1_group_pwm1);
+		if (err)
 			goto error_remove_files;
 	} else
 		dev_dbg(dev, "PWM 1 not enabled by hardware, skipping\n");
 
 	if (pwm2) {
-		if ((err = device_create_file(dev,
-				&sensor_dev_attr_pwm2.dev_attr))
-		 || (err = device_create_file(dev,
-				&sensor_dev_attr_pwm2_enable.dev_attr)))
+		err = sysfs_create_group(&dev->kobj,
+					 &smsc47m1_group_pwm2);
+		if (err)
 			goto error_remove_files;
 	} else
 		dev_dbg(dev, "PWM 2 not enabled by hardware, skipping\n");
 
 	if (pwm3) {
-		if ((err = device_create_file(dev,
-				&sensor_dev_attr_pwm3.dev_attr))
-		 || (err = device_create_file(dev,
-				&sensor_dev_attr_pwm3_enable.dev_attr)))
+		err = sysfs_create_group(&dev->kobj,
+					 &smsc47m1_group_pwm3);
+		if (err)
 			goto error_remove_files;
 	} else if (data->type = smsc47m2)
 		dev_dbg(dev, "PWM 3 not enabled by hardware, skipping\n");
 
-	err = device_create_file(dev, &dev_attr_alarms);
-	if (err)
-		goto error_remove_files;
-	err = device_create_file(dev, &dev_attr_name);
+	err = sysfs_create_group(&dev->kobj, &smsc47m1_group);
 	if (err)
 		goto error_remove_files;
 
@@ -778,7 +809,7 @@ static int __init smsc47m1_probe(struct platform_device *pdev)
 	return 0;
 
 error_remove_files:
-	sysfs_remove_group(&dev->kobj, &smsc47m1_group);
+	smsc47m1_remove_files(dev);
 error_free:
 	platform_set_drvdata(pdev, NULL);
 	kfree(data);
@@ -793,7 +824,7 @@ static int __exit smsc47m1_remove(struct platform_device *pdev)
 	struct resource *res;
 
 	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&pdev->dev.kobj, &smsc47m1_group);
+	smsc47m1_remove_files(&pdev->dev);
 
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
 	smsc47m1_handle_resources(res->start, data->type, RELEASE, &pdev->dev);
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
