From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 06 Apr 2013 01:02:54 +0000
Subject: [lm-sensors] [PATCH 2/5] hwmon: (tmp401) Use sysfs_create_group / sysfs_remove_group
Message-Id: <1365210177-24656-3-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

instead of creating and removing sysfs attribute files individually.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/tmp401.c |  151 +++++++++++++++++++++++++++++-------------------
 1 file changed, 90 insertions(+), 61 deletions(-)

diff --git a/drivers/hwmon/tmp401.c b/drivers/hwmon/tmp401.c
index ef04cf8..f07fc40 100644
--- a/drivers/hwmon/tmp401.c
+++ b/drivers/hwmon/tmp401.c
@@ -464,38 +464,64 @@ static ssize_t reset_temp_history(struct device *dev,
 	return count;
 }
 
-static struct sensor_device_attribute tmp401_attr[] = {
-	SENSOR_ATTR(temp1_input, S_IRUGO, show_temp_value, NULL, 0),
-	SENSOR_ATTR(temp1_min, S_IWUSR | S_IRUGO, show_temp_min,
-		    store_temp_min, 0),
-	SENSOR_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_max,
-		    store_temp_max, 0),
-	SENSOR_ATTR(temp1_crit, S_IWUSR | S_IRUGO, show_temp_crit,
-		    store_temp_crit, 0),
-	SENSOR_ATTR(temp1_crit_hyst, S_IWUSR | S_IRUGO, show_temp_crit_hyst,
-		    store_temp_crit_hyst, 0),
-	SENSOR_ATTR(temp1_min_alarm, S_IRUGO, show_status, NULL,
-		    TMP401_STATUS_LOCAL_LOW),
-	SENSOR_ATTR(temp1_max_alarm, S_IRUGO, show_status, NULL,
-		    TMP401_STATUS_LOCAL_HIGH),
-	SENSOR_ATTR(temp1_crit_alarm, S_IRUGO, show_status, NULL,
-		    TMP401_STATUS_LOCAL_CRIT),
-	SENSOR_ATTR(temp2_input, S_IRUGO, show_temp_value, NULL, 1),
-	SENSOR_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_temp_min,
-		    store_temp_min, 1),
-	SENSOR_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_temp_max,
-		    store_temp_max, 1),
-	SENSOR_ATTR(temp2_crit, S_IWUSR | S_IRUGO, show_temp_crit,
-		    store_temp_crit, 1),
-	SENSOR_ATTR(temp2_crit_hyst, S_IRUGO, show_temp_crit_hyst, NULL, 1),
-	SENSOR_ATTR(temp2_fault, S_IRUGO, show_status, NULL,
-		    TMP401_STATUS_REMOTE_OPEN),
-	SENSOR_ATTR(temp2_min_alarm, S_IRUGO, show_status, NULL,
-		    TMP401_STATUS_REMOTE_LOW),
-	SENSOR_ATTR(temp2_max_alarm, S_IRUGO, show_status, NULL,
-		    TMP401_STATUS_REMOTE_HIGH),
-	SENSOR_ATTR(temp2_crit_alarm, S_IRUGO, show_status, NULL,
-		    TMP401_STATUS_REMOTE_CRIT),
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_value, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO, show_temp_min,
+			  store_temp_min, 0);
+static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_max,
+			  store_temp_max, 0);
+static SENSOR_DEVICE_ATTR(temp1_crit, S_IWUSR | S_IRUGO, show_temp_crit,
+			  store_temp_crit, 0);
+static SENSOR_DEVICE_ATTR(temp1_crit_hyst, S_IWUSR | S_IRUGO,
+			  show_temp_crit_hyst, store_temp_crit_hyst, 0);
+static SENSOR_DEVICE_ATTR(temp1_min_alarm, S_IRUGO, show_status, NULL,
+			  TMP401_STATUS_LOCAL_LOW);
+static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_status, NULL,
+			  TMP401_STATUS_LOCAL_HIGH);
+static SENSOR_DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_status, NULL,
+			  TMP401_STATUS_LOCAL_CRIT);
+static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp_value, NULL, 1);
+static SENSOR_DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_temp_min,
+			  store_temp_min, 1);
+static SENSOR_DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_temp_max,
+			  store_temp_max, 1);
+static SENSOR_DEVICE_ATTR(temp2_crit, S_IWUSR | S_IRUGO, show_temp_crit,
+			  store_temp_crit, 1);
+static SENSOR_DEVICE_ATTR(temp2_crit_hyst, S_IRUGO, show_temp_crit_hyst,
+			  NULL, 1);
+static SENSOR_DEVICE_ATTR(temp2_fault, S_IRUGO, show_status, NULL,
+			  TMP401_STATUS_REMOTE_OPEN);
+static SENSOR_DEVICE_ATTR(temp2_min_alarm, S_IRUGO, show_status, NULL,
+			  TMP401_STATUS_REMOTE_LOW);
+static SENSOR_DEVICE_ATTR(temp2_max_alarm, S_IRUGO, show_status, NULL,
+			  TMP401_STATUS_REMOTE_HIGH);
+static SENSOR_DEVICE_ATTR(temp2_crit_alarm, S_IRUGO, show_status, NULL,
+			  TMP401_STATUS_REMOTE_CRIT);
+
+static struct attribute *tmp401_attributes[] = {
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_temp1_min.dev_attr.attr,
+	&sensor_dev_attr_temp1_max.dev_attr.attr,
+	&sensor_dev_attr_temp1_crit.dev_attr.attr,
+	&sensor_dev_attr_temp1_crit_hyst.dev_attr.attr,
+	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp1_min_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp1_crit_alarm.dev_attr.attr,
+
+	&sensor_dev_attr_temp2_input.dev_attr.attr,
+	&sensor_dev_attr_temp2_min.dev_attr.attr,
+	&sensor_dev_attr_temp2_max.dev_attr.attr,
+	&sensor_dev_attr_temp2_crit.dev_attr.attr,
+	&sensor_dev_attr_temp2_crit_hyst.dev_attr.attr,
+	&sensor_dev_attr_temp2_fault.dev_attr.attr,
+	&sensor_dev_attr_temp2_max_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp2_min_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp2_crit_alarm.dev_attr.attr,
+
+	NULL
+};
+
+static const struct attribute_group tmp401_group = {
+	.attrs = tmp401_attributes,
 };
 
 /*
@@ -505,12 +531,24 @@ static struct sensor_device_attribute tmp401_attr[] = {
  * minimum and maximum register reset for both the local
  * and remote channels.
  */
-static struct sensor_device_attribute tmp411_attr[] = {
-	SENSOR_ATTR(temp1_highest, S_IRUGO, show_temp_highest, NULL, 0),
-	SENSOR_ATTR(temp1_lowest, S_IRUGO, show_temp_lowest, NULL, 0),
-	SENSOR_ATTR(temp2_highest, S_IRUGO, show_temp_highest, NULL, 1),
-	SENSOR_ATTR(temp2_lowest, S_IRUGO, show_temp_lowest, NULL, 1),
-	SENSOR_ATTR(temp_reset_history, S_IWUSR, NULL, reset_temp_history, 0),
+static SENSOR_DEVICE_ATTR(temp1_highest, S_IRUGO, show_temp_highest, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp1_lowest, S_IRUGO, show_temp_lowest, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp2_highest, S_IRUGO, show_temp_highest, NULL, 1);
+static SENSOR_DEVICE_ATTR(temp2_lowest, S_IRUGO, show_temp_lowest, NULL, 1);
+static SENSOR_DEVICE_ATTR(temp_reset_history, S_IWUSR, NULL, reset_temp_history,
+			  0);
+
+static struct attribute *tmp411_attributes[] = {
+	&sensor_dev_attr_temp1_highest.dev_attr.attr,
+	&sensor_dev_attr_temp1_lowest.dev_attr.attr,
+	&sensor_dev_attr_temp2_highest.dev_attr.attr,
+	&sensor_dev_attr_temp2_lowest.dev_attr.attr,
+	&sensor_dev_attr_temp_reset_history.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group tmp411_group = {
+	.attrs = tmp411_attributes,
 };
 
 /*
@@ -601,20 +639,16 @@ static int tmp401_detect(struct i2c_client *client,
 
 static int tmp401_remove(struct i2c_client *client)
 {
+	struct device *dev = &client->dev;
 	struct tmp401_data *data = i2c_get_clientdata(client);
-	int i;
 
 	if (data->hwmon_dev)
 		hwmon_device_unregister(data->hwmon_dev);
 
-	for (i = 0; i < ARRAY_SIZE(tmp401_attr); i++)
-		device_remove_file(&client->dev, &tmp401_attr[i].dev_attr);
+	sysfs_remove_group(&dev->kobj, &tmp401_group);
 
-	if (data->kind = tmp411) {
-		for (i = 0; i < ARRAY_SIZE(tmp411_attr); i++)
-			device_remove_file(&client->dev,
-					   &tmp411_attr[i].dev_attr);
-	}
+	if (data->kind = tmp411)
+		sysfs_remove_group(&dev->kobj, &tmp411_group);
 
 	return 0;
 }
@@ -622,7 +656,8 @@ static int tmp401_remove(struct i2c_client *client)
 static int tmp401_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
-	int i, err = 0;
+	struct device *dev = &client->dev;
+	int err;
 	struct tmp401_data *data;
 	const char *names[] = { "TMP401", "TMP411", "TMP431" };
 
@@ -639,31 +674,25 @@ static int tmp401_probe(struct i2c_client *client,
 	tmp401_init_client(client);
 
 	/* Register sysfs hooks */
-	for (i = 0; i < ARRAY_SIZE(tmp401_attr); i++) {
-		err = device_create_file(&client->dev,
-					 &tmp401_attr[i].dev_attr);
-		if (err)
-			goto exit_remove;
-	}
+	err = sysfs_create_group(&dev->kobj, &tmp401_group);
+	if (err)
+		return err;
 
 	/* Register additional tmp411 sysfs hooks */
 	if (data->kind = tmp411) {
-		for (i = 0; i < ARRAY_SIZE(tmp411_attr); i++) {
-			err = device_create_file(&client->dev,
-						 &tmp411_attr[i].dev_attr);
-			if (err)
-				goto exit_remove;
-		}
+		err = sysfs_create_group(&dev->kobj, &tmp411_group);
+		if (err)
+			goto exit_remove;
 	}
 
-	data->hwmon_dev = hwmon_device_register(&client->dev);
+	data->hwmon_dev = hwmon_device_register(dev);
 	if (IS_ERR(data->hwmon_dev)) {
 		err = PTR_ERR(data->hwmon_dev);
 		data->hwmon_dev = NULL;
 		goto exit_remove;
 	}
 
-	dev_info(&client->dev, "Detected TI %s chip\n", names[data->kind]);
+	dev_info(dev, "Detected TI %s chip\n", names[data->kind]);
 
 	return 0;
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
