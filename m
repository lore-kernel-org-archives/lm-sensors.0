From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 24 Jan 2012 02:48:45 +0000
Subject: [lm-sensors] [PATCH 06/79] hwmon: (lm87) Fix: do not use assignment in if condition
Message-Id: <1327373398-997-7-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

Fix checkpatch issue:
ERROR: do not use assignment in if condition

Replace repeated calls to device_create_file() with calls to sysfs_create_group.

Cc: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm87.c |  152 ++++++++++++++++++++++++++------------------------
 1 files changed, 80 insertions(+), 72 deletions(-)

diff --git a/drivers/hwmon/lm87.c b/drivers/hwmon/lm87.c
index 2aa5e1a..2f9f472 100644
--- a/drivers/hwmon/lm87.c
+++ b/drivers/hwmon/lm87.c
@@ -702,34 +702,69 @@ static const struct attribute_group lm87_group = {
 	.attrs = lm87_attributes,
 };
 
-static struct attribute *lm87_attributes_opt[] = {
+static struct attribute *lm87_attributes_in6[] = {
 	&dev_attr_in6_input.attr,
 	&dev_attr_in6_min.attr,
 	&dev_attr_in6_max.attr,
 	&sensor_dev_attr_in6_alarm.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group lm87_group_in6 = {
+	.attrs = lm87_attributes_in6,
+};
 
+static struct attribute *lm87_attributes_fan1[] = {
 	&dev_attr_fan1_input.attr,
 	&dev_attr_fan1_min.attr,
 	&dev_attr_fan1_div.attr,
 	&sensor_dev_attr_fan1_alarm.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group lm87_group_fan1 = {
+	.attrs = lm87_attributes_fan1,
+};
 
+static struct attribute *lm87_attributes_in7[] = {
 	&dev_attr_in7_input.attr,
 	&dev_attr_in7_min.attr,
 	&dev_attr_in7_max.attr,
 	&sensor_dev_attr_in7_alarm.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group lm87_group_in7 = {
+	.attrs = lm87_attributes_in7,
+};
 
+static struct attribute *lm87_attributes_fan2[] = {
 	&dev_attr_fan2_input.attr,
 	&dev_attr_fan2_min.attr,
 	&dev_attr_fan2_div.attr,
 	&sensor_dev_attr_fan2_alarm.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group lm87_group_fan2 = {
+	.attrs = lm87_attributes_fan2,
+};
 
+static struct attribute *lm87_attributes_temp3[] = {
 	&dev_attr_temp3_input.attr,
 	&dev_attr_temp3_max.attr,
 	&dev_attr_temp3_min.attr,
 	&dev_attr_temp3_crit.attr,
 	&sensor_dev_attr_temp3_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp3_fault.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group lm87_group_temp3 = {
+	.attrs = lm87_attributes_temp3,
+};
 
+static struct attribute *lm87_attributes_in0_5[] = {
 	&dev_attr_in0_input.attr,
 	&dev_attr_in0_min.attr,
 	&dev_attr_in0_max.attr,
@@ -738,15 +773,21 @@ static struct attribute *lm87_attributes_opt[] = {
 	&dev_attr_in5_min.attr,
 	&dev_attr_in5_max.attr,
 	&sensor_dev_attr_in5_alarm.dev_attr.attr,
+	NULL
+};
 
+static const struct attribute_group lm87_group_in0_5 = {
+	.attrs = lm87_attributes_in0_5,
+};
+
+static struct attribute *lm87_attributes_vid[] = {
 	&dev_attr_cpu0_vid.attr,
 	&dev_attr_vrm.attr,
-
 	NULL
 };
 
-static const struct attribute_group lm87_group_opt = {
-	.attrs = lm87_attributes_opt,
+static const struct attribute_group lm87_group_vid = {
+	.attrs = lm87_attributes_vid,
 };
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
@@ -784,6 +825,18 @@ static int lm87_detect(struct i2c_client *new_client,
 	return 0;
 }
 
+static void lm87_remove_files(struct i2c_client *client)
+{
+	sysfs_remove_group(&client->dev.kobj, &lm87_group);
+	sysfs_remove_group(&client->dev.kobj, &lm87_group_in6);
+	sysfs_remove_group(&client->dev.kobj, &lm87_group_fan1);
+	sysfs_remove_group(&client->dev.kobj, &lm87_group_in7);
+	sysfs_remove_group(&client->dev.kobj, &lm87_group_fan2);
+	sysfs_remove_group(&client->dev.kobj, &lm87_group_temp3);
+	sysfs_remove_group(&client->dev.kobj, &lm87_group_in0_5);
+	sysfs_remove_group(&client->dev.kobj, &lm87_group_vid);
+}
+
 static int lm87_probe(struct i2c_client *new_client,
 		      const struct i2c_device_id *id)
 {
@@ -818,89 +871,46 @@ static int lm87_probe(struct i2c_client *new_client,
 		goto exit_free;
 
 	if (data->channel & CHAN_NO_FAN(0)) {
-		if ((err = device_create_file(&new_client->dev,
-					&dev_attr_in6_input))
-		 || (err = device_create_file(&new_client->dev,
-					&dev_attr_in6_min))
-		 || (err = device_create_file(&new_client->dev,
-					&dev_attr_in6_max))
-		 || (err = device_create_file(&new_client->dev,
-					&sensor_dev_attr_in6_alarm.dev_attr)))
+		err = sysfs_create_group(&new_client->dev.kobj,
+					 &lm87_group_in6);
+		if (err)
 			goto exit_remove;
 	} else {
-		if ((err = device_create_file(&new_client->dev,
-					&dev_attr_fan1_input))
-		 || (err = device_create_file(&new_client->dev,
-					&dev_attr_fan1_min))
-		 || (err = device_create_file(&new_client->dev,
-					&dev_attr_fan1_div))
-		 || (err = device_create_file(&new_client->dev,
-					&sensor_dev_attr_fan1_alarm.dev_attr)))
+		err = sysfs_create_group(&new_client->dev.kobj,
+					 &lm87_group_fan1);
+		if (err)
 			goto exit_remove;
 	}
 
 	if (data->channel & CHAN_NO_FAN(1)) {
-		if ((err = device_create_file(&new_client->dev,
-					&dev_attr_in7_input))
-		 || (err = device_create_file(&new_client->dev,
-					&dev_attr_in7_min))
-		 || (err = device_create_file(&new_client->dev,
-					&dev_attr_in7_max))
-		 || (err = device_create_file(&new_client->dev,
-					&sensor_dev_attr_in7_alarm.dev_attr)))
+		err = sysfs_create_group(&new_client->dev.kobj,
+					 &lm87_group_in7);
+		if (err)
 			goto exit_remove;
 	} else {
-		if ((err = device_create_file(&new_client->dev,
-					&dev_attr_fan2_input))
-		 || (err = device_create_file(&new_client->dev,
-					&dev_attr_fan2_min))
-		 || (err = device_create_file(&new_client->dev,
-					&dev_attr_fan2_div))
-		 || (err = device_create_file(&new_client->dev,
-					&sensor_dev_attr_fan2_alarm.dev_attr)))
+		err = sysfs_create_group(&new_client->dev.kobj,
+					 &lm87_group_fan2);
+		if (err)
 			goto exit_remove;
 	}
 
 	if (data->channel & CHAN_TEMP3) {
-		if ((err = device_create_file(&new_client->dev,
-					&dev_attr_temp3_input))
-		 || (err = device_create_file(&new_client->dev,
-					&dev_attr_temp3_max))
-		 || (err = device_create_file(&new_client->dev,
-					&dev_attr_temp3_min))
-		 || (err = device_create_file(&new_client->dev,
-					&dev_attr_temp3_crit))
-		 || (err = device_create_file(&new_client->dev,
-					&sensor_dev_attr_temp3_alarm.dev_attr))
-		 || (err = device_create_file(&new_client->dev,
-					&sensor_dev_attr_temp3_fault.dev_attr)))
+		err = sysfs_create_group(&new_client->dev.kobj,
+					 &lm87_group_temp3);
+		if (err)
 			goto exit_remove;
 	} else {
-		if ((err = device_create_file(&new_client->dev,
-					&dev_attr_in0_input))
-		 || (err = device_create_file(&new_client->dev,
-					&dev_attr_in0_min))
-		 || (err = device_create_file(&new_client->dev,
-					&dev_attr_in0_max))
-		 || (err = device_create_file(&new_client->dev,
-					&sensor_dev_attr_in0_alarm.dev_attr))
-		 || (err = device_create_file(&new_client->dev,
-					&dev_attr_in5_input))
-		 || (err = device_create_file(&new_client->dev,
-					&dev_attr_in5_min))
-		 || (err = device_create_file(&new_client->dev,
-					&dev_attr_in5_max))
-		 || (err = device_create_file(&new_client->dev,
-					&sensor_dev_attr_in5_alarm.dev_attr)))
+		err = sysfs_create_group(&new_client->dev.kobj,
+					 &lm87_group_in0_5);
+		if (err)
 			goto exit_remove;
 	}
 
 	if (!(data->channel & CHAN_NO_VID)) {
 		data->vrm = vid_which_vrm();
-		if ((err = device_create_file(&new_client->dev,
-					&dev_attr_cpu0_vid))
-		 || (err = device_create_file(&new_client->dev,
-					&dev_attr_vrm)))
+		err = sysfs_create_group(&new_client->dev.kobj,
+					 &lm87_group_vid);
+		if (err)
 			goto exit_remove;
 	}
 
@@ -913,8 +923,7 @@ static int lm87_probe(struct i2c_client *new_client,
 	return 0;
 
 exit_remove:
-	sysfs_remove_group(&new_client->dev.kobj, &lm87_group);
-	sysfs_remove_group(&new_client->dev.kobj, &lm87_group_opt);
+	lm87_remove_files(new_client);
 exit_free:
 	lm87_write_value(new_client, LM87_REG_CONFIG, data->config);
 	kfree(data);
@@ -969,8 +978,7 @@ static int lm87_remove(struct i2c_client *client)
 	struct lm87_data *data = i2c_get_clientdata(client);
 
 	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&client->dev.kobj, &lm87_group);
-	sysfs_remove_group(&client->dev.kobj, &lm87_group_opt);
+	lm87_remove_files(client);
 
 	lm87_write_value(client, LM87_REG_CONFIG, data->config);
 	kfree(data);
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
