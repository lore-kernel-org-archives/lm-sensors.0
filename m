From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 24 Jan 2012 02:49:23 +0000
Subject: [lm-sensors] [PATCH 44/79] hwmon: (gl520sm) Fix: do not use assignment in if condition
Message-Id: <1327373398-997-45-git-send-email-guenter.roeck@ericsson.com>
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
 drivers/hwmon/gl520sm.c |   50 ++++++++++++++++++----------------------------
 1 files changed, 20 insertions(+), 30 deletions(-)

diff --git a/drivers/hwmon/gl520sm.c b/drivers/hwmon/gl520sm.c
index 01a4949..5ff452b 100644
--- a/drivers/hwmon/gl520sm.c
+++ b/drivers/hwmon/gl520sm.c
@@ -720,13 +720,16 @@ static const struct attribute_group gl520_group = {
 	.attrs = gl520_attributes,
 };
 
-static struct attribute *gl520_attributes_opt[] = {
+static struct attribute *gl520_attributes_in4[] = {
 	&sensor_dev_attr_in4_input.dev_attr.attr,
 	&sensor_dev_attr_in4_min.dev_attr.attr,
 	&sensor_dev_attr_in4_max.dev_attr.attr,
 	&sensor_dev_attr_in4_alarm.dev_attr.attr,
 	&sensor_dev_attr_in4_beep.dev_attr.attr,
+	NULL
+};
 
+static struct attribute *gl520_attributes_temp2[] = {
 	&sensor_dev_attr_temp2_input.dev_attr.attr,
 	&sensor_dev_attr_temp2_max.dev_attr.attr,
 	&sensor_dev_attr_temp2_max_hyst.dev_attr.attr,
@@ -735,8 +738,12 @@ static struct attribute *gl520_attributes_opt[] = {
 	NULL
 };
 
-static const struct attribute_group gl520_group_opt = {
-	.attrs = gl520_attributes_opt,
+static const struct attribute_group gl520_group_in4 = {
+	.attrs = gl520_attributes_in4,
+};
+
+static const struct attribute_group gl520_group_temp2 = {
+	.attrs = gl520_attributes_temp2,
 };
 
 
@@ -789,32 +796,13 @@ static int gl520_probe(struct i2c_client *client,
 	if (err)
 		goto exit_free;
 
-	if (data->two_temps) {
-		if ((err = device_create_file(&client->dev,
-				&sensor_dev_attr_temp2_input.dev_attr))
-		 || (err = device_create_file(&client->dev,
-				&sensor_dev_attr_temp2_max.dev_attr))
-		 || (err = device_create_file(&client->dev,
-				&sensor_dev_attr_temp2_max_hyst.dev_attr))
-		 || (err = device_create_file(&client->dev,
-				&sensor_dev_attr_temp2_alarm.dev_attr))
-		 || (err = device_create_file(&client->dev,
-				&sensor_dev_attr_temp2_beep.dev_attr)))
-			goto exit_remove_files;
-	} else {
-		if ((err = device_create_file(&client->dev,
-				&sensor_dev_attr_in4_input.dev_attr))
-		 || (err = device_create_file(&client->dev,
-				&sensor_dev_attr_in4_min.dev_attr))
-		 || (err = device_create_file(&client->dev,
-				&sensor_dev_attr_in4_max.dev_attr))
-		 || (err = device_create_file(&client->dev,
-				&sensor_dev_attr_in4_alarm.dev_attr))
-		 || (err = device_create_file(&client->dev,
-				&sensor_dev_attr_in4_beep.dev_attr)))
-			goto exit_remove_files;
-	}
+	if (data->two_temps)
+		err = sysfs_create_group(&client->dev.kobj, &gl520_group_temp2);
+	else
+		err = sysfs_create_group(&client->dev.kobj, &gl520_group_in4);
 
+	if (err)
+		goto exit_remove_files;
 
 	data->hwmon_dev = hwmon_device_register(&client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
@@ -826,7 +814,8 @@ static int gl520_probe(struct i2c_client *client,
 
 exit_remove_files:
 	sysfs_remove_group(&client->dev.kobj, &gl520_group);
-	sysfs_remove_group(&client->dev.kobj, &gl520_group_opt);
+	sysfs_remove_group(&client->dev.kobj, &gl520_group_in4);
+	sysfs_remove_group(&client->dev.kobj, &gl520_group_temp2);
 exit_free:
 	kfree(data);
 exit:
@@ -878,7 +867,8 @@ static int gl520_remove(struct i2c_client *client)
 
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &gl520_group);
-	sysfs_remove_group(&client->dev.kobj, &gl520_group_opt);
+	sysfs_remove_group(&client->dev.kobj, &gl520_group_in4);
+	sysfs_remove_group(&client->dev.kobj, &gl520_group_temp2);
 
 	kfree(data);
 	return 0;
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
