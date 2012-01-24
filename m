From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 24 Jan 2012 02:49:52 +0000
Subject: [lm-sensors] [PATCH 73/79] hwmon: (w83781d) Fix: do not use assignment in if condition
Message-Id: <1327373398-997-74-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

Fix checkpatch issue:
ERROR: do not use assignment in if condition

Replace repeated calls to device_create_file() with calls to sysfs_create_group.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/w83781d.c |  140 ++++++++++++++++++++++++-----------------------
 1 files changed, 72 insertions(+), 68 deletions(-)

diff --git a/drivers/hwmon/w83781d.c b/drivers/hwmon/w83781d.c
index cbed525..b03d54a 100644
--- a/drivers/hwmon/w83781d.c
+++ b/drivers/hwmon/w83781d.c
@@ -975,23 +975,58 @@ static const struct attribute_group w83781d_group = {
 	.attrs = w83781d_attributes,
 };
 
-static struct attribute *w83781d_attributes_opt[] = {
+static struct attribute *w83781d_attributes_in1[] = {
 	IN_UNIT_ATTRS(1),
+	NULL
+};
+static const struct attribute_group w83781d_group_in1 = {
+	.attrs = w83781d_attributes_in1,
+};
+
+static struct attribute *w83781d_attributes_in78[] = {
 	IN_UNIT_ATTRS(7),
 	IN_UNIT_ATTRS(8),
+	NULL
+};
+static const struct attribute_group w83781d_group_in78 = {
+	.attrs = w83781d_attributes_in78,
+};
+
+static struct attribute *w83781d_attributes_temp3[] = {
 	TEMP_UNIT_ATTRS(3),
+	NULL
+};
+static const struct attribute_group w83781d_group_temp3 = {
+	.attrs = w83781d_attributes_temp3,
+};
+
+static struct attribute *w83781d_attributes_pwm12[] = {
 	&sensor_dev_attr_pwm1.dev_attr.attr,
 	&sensor_dev_attr_pwm2.dev_attr.attr,
+	&dev_attr_pwm2_enable.attr,
+	NULL
+};
+static const struct attribute_group w83781d_group_pwm12 = {
+	.attrs = w83781d_attributes_pwm12,
+};
+
+static struct attribute *w83781d_attributes_pwm34[] = {
 	&sensor_dev_attr_pwm3.dev_attr.attr,
 	&sensor_dev_attr_pwm4.dev_attr.attr,
-	&dev_attr_pwm2_enable.attr,
+	NULL
+};
+static const struct attribute_group w83781d_group_pwm34 = {
+	.attrs = w83781d_attributes_pwm34,
+};
+
+static struct attribute *w83781d_attributes_other[] = {
 	&sensor_dev_attr_temp1_type.dev_attr.attr,
 	&sensor_dev_attr_temp2_type.dev_attr.attr,
 	&sensor_dev_attr_temp3_type.dev_attr.attr,
 	NULL
 };
-static const struct attribute_group w83781d_group_opt = {
-	.attrs = w83781d_attributes_opt,
+static const struct attribute_group w83781d_group_other = {
+	.attrs = w83781d_attributes_other,
 };
 
 /* No clean up is done on error, it's up to the caller */
@@ -1005,52 +1040,18 @@ w83781d_create_files(struct device *dev, int kind, int is_isa)
 		return err;
 
 	if (kind != w83783s) {
-		if ((err = device_create_file(dev,
-				&sensor_dev_attr_in1_input.dev_attr))
-		    || (err = device_create_file(dev,
-				&sensor_dev_attr_in1_min.dev_attr))
-		    || (err = device_create_file(dev,
-				&sensor_dev_attr_in1_max.dev_attr))
-		    || (err = device_create_file(dev,
-				&sensor_dev_attr_in1_alarm.dev_attr))
-		    || (err = device_create_file(dev,
-				&sensor_dev_attr_in1_beep.dev_attr)))
+		err = sysfs_create_group(&dev->kobj, &w83781d_group_in1);
+		if (err)
 			return err;
 	}
 	if (kind != as99127f && kind != w83781d && kind != w83783s) {
-		if ((err = device_create_file(dev,
-				&sensor_dev_attr_in7_input.dev_attr))
-		    || (err = device_create_file(dev,
-				&sensor_dev_attr_in7_min.dev_attr))
-		    || (err = device_create_file(dev,
-				&sensor_dev_attr_in7_max.dev_attr))
-		    || (err = device_create_file(dev,
-				&sensor_dev_attr_in7_alarm.dev_attr))
-		    || (err = device_create_file(dev,
-				&sensor_dev_attr_in7_beep.dev_attr))
-		    || (err = device_create_file(dev,
-				&sensor_dev_attr_in8_input.dev_attr))
-		    || (err = device_create_file(dev,
-				&sensor_dev_attr_in8_min.dev_attr))
-		    || (err = device_create_file(dev,
-				&sensor_dev_attr_in8_max.dev_attr))
-		    || (err = device_create_file(dev,
-				&sensor_dev_attr_in8_alarm.dev_attr))
-		    || (err = device_create_file(dev,
-				&sensor_dev_attr_in8_beep.dev_attr)))
+		err = sysfs_create_group(&dev->kobj, &w83781d_group_in78);
+		if (err)
 			return err;
 	}
 	if (kind != w83783s) {
-		if ((err = device_create_file(dev,
-				&sensor_dev_attr_temp3_input.dev_attr))
-		    || (err = device_create_file(dev,
-				&sensor_dev_attr_temp3_max.dev_attr))
-		    || (err = device_create_file(dev,
-				&sensor_dev_attr_temp3_max_hyst.dev_attr))
-		    || (err = device_create_file(dev,
-				&sensor_dev_attr_temp3_alarm.dev_attr))
-		    || (err = device_create_file(dev,
-				&sensor_dev_attr_temp3_beep.dev_attr)))
+		err = sysfs_create_group(&dev->kobj, &w83781d_group_temp3);
+		if (err)
 			return err;
 
 		if (kind != w83781d) {
@@ -1063,30 +1064,28 @@ w83781d_create_files(struct device *dev, int kind, int is_isa)
 	}
 
 	if (kind != w83781d && kind != as99127f) {
-		if ((err = device_create_file(dev,
-				&sensor_dev_attr_pwm1.dev_attr))
-		    || (err = device_create_file(dev,
-				&sensor_dev_attr_pwm2.dev_attr))
-		    || (err = device_create_file(dev, &dev_attr_pwm2_enable)))
+		err = sysfs_create_group(&dev->kobj, &w83781d_group_pwm12);
+		if (err)
 			return err;
 	}
 	if (kind = w83782d && !is_isa) {
-		if ((err = device_create_file(dev,
-				&sensor_dev_attr_pwm3.dev_attr))
-		    || (err = device_create_file(dev,
-				&sensor_dev_attr_pwm4.dev_attr)))
+		err = sysfs_create_group(&dev->kobj, &w83781d_group_pwm34);
+		if (err)
 			return err;
 	}
 
 	if (kind != as99127f && kind != w83781d) {
-		if ((err = device_create_file(dev,
-				&sensor_dev_attr_temp1_type.dev_attr))
-		    || (err = device_create_file(dev,
-				&sensor_dev_attr_temp2_type.dev_attr)))
+		err = device_create_file(dev,
+					 &sensor_dev_attr_temp1_type.dev_attr);
+		if (err)
+			return err;
+		err = device_create_file(dev,
+					 &sensor_dev_attr_temp2_type.dev_attr);
+		if (err)
 			return err;
 		if (kind != w83783s) {
 			err = device_create_file(dev,
-				&sensor_dev_attr_temp3_type.dev_attr);
+					&sensor_dev_attr_temp3_type.dev_attr);
 			if (err)
 				return err;
 		}
@@ -1196,6 +1195,17 @@ w83781d_detect(struct i2c_client *client, struct i2c_board_info *info)
 	return -ENODEV;
 }
 
+static void w83781d_remove_files(struct device *dev)
+{
+	sysfs_remove_group(&dev->kobj, &w83781d_group);
+	sysfs_remove_group(&dev->kobj, &w83781d_group_in1);
+	sysfs_remove_group(&dev->kobj, &w83781d_group_in78);
+	sysfs_remove_group(&dev->kobj, &w83781d_group_temp3);
+	sysfs_remove_group(&dev->kobj, &w83781d_group_pwm12);
+	sysfs_remove_group(&dev->kobj, &w83781d_group_pwm34);
+	sysfs_remove_group(&dev->kobj, &w83781d_group_other);
+}
+
 static int
 w83781d_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
@@ -1238,9 +1248,7 @@ w83781d_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	return 0;
 
 ERROR4:
-	sysfs_remove_group(&dev->kobj, &w83781d_group);
-	sysfs_remove_group(&dev->kobj, &w83781d_group_opt);
-
+	w83781d_remove_files(dev);
 	if (data->lm75[0])
 		i2c_unregister_device(data->lm75[0]);
 	if (data->lm75[1])
@@ -1258,9 +1266,7 @@ w83781d_remove(struct i2c_client *client)
 	struct device *dev = &client->dev;
 
 	hwmon_device_unregister(data->hwmon_dev);
-
-	sysfs_remove_group(&dev->kobj, &w83781d_group);
-	sysfs_remove_group(&dev->kobj, &w83781d_group_opt);
+	w83781d_remove_files(dev);
 
 	if (data->lm75[0])
 		i2c_unregister_device(data->lm75[0]);
@@ -1821,8 +1827,7 @@ w83781d_isa_probe(struct platform_device *pdev)
 	return 0;
 
  exit_remove_files:
-	sysfs_remove_group(&pdev->dev.kobj, &w83781d_group);
-	sysfs_remove_group(&pdev->dev.kobj, &w83781d_group_opt);
+	w83781d_remove_files(&pdev->dev);
 	device_remove_file(&pdev->dev, &dev_attr_name);
 	kfree(data);
  exit_release_region:
@@ -1837,8 +1842,7 @@ w83781d_isa_remove(struct platform_device *pdev)
 	struct w83781d_data *data = platform_get_drvdata(pdev);
 
 	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&pdev->dev.kobj, &w83781d_group);
-	sysfs_remove_group(&pdev->dev.kobj, &w83781d_group_opt);
+	w83781d_remove_files(&pdev->dev);
 	device_remove_file(&pdev->dev, &dev_attr_name);
 	release_region(data->isa_addr + W83781D_ADDR_REG_OFFSET, 2);
 	kfree(data);
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
