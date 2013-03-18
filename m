From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 18 Mar 2013 15:55:06 +0000
Subject: [lm-sensors] [PATCH] hwmon: (max6697) Use is_visible and sysfs_create_group
Message-Id: <1363622106-30752-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Simplify the code and reduce its size by using is_visible to determine
valid attributes, and sysfs_create_group to create all of them with
a single call.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/max6697.c |  209 +++++++++++++++++++++--------------------------
 1 file changed, 93 insertions(+), 116 deletions(-)

diff --git a/drivers/hwmon/max6697.c b/drivers/hwmon/max6697.c
index bf4aa37..328fb03 100644
--- a/drivers/hwmon/max6697.c
+++ b/drivers/hwmon/max6697.c
@@ -399,82 +399,95 @@ static SENSOR_DEVICE_ATTR(temp6_fault, S_IRUGO, show_alarm, NULL, 5);
 static SENSOR_DEVICE_ATTR(temp7_fault, S_IRUGO, show_alarm, NULL, 6);
 static SENSOR_DEVICE_ATTR(temp8_fault, S_IRUGO, show_alarm, NULL, 7);
 
-static struct attribute *max6697_attributes[8][7] = {
-	{
-		&sensor_dev_attr_temp1_input.dev_attr.attr,
-		&sensor_dev_attr_temp1_max.dev_attr.attr,
-		&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
-		&sensor_dev_attr_temp1_crit.dev_attr.attr,
-		&sensor_dev_attr_temp1_crit_alarm.dev_attr.attr,
-		NULL
-	}, {
-		&sensor_dev_attr_temp2_input.dev_attr.attr,
-		&sensor_dev_attr_temp2_max.dev_attr.attr,
-		&sensor_dev_attr_temp2_max_alarm.dev_attr.attr,
-		&sensor_dev_attr_temp2_crit.dev_attr.attr,
-		&sensor_dev_attr_temp2_crit_alarm.dev_attr.attr,
-		&sensor_dev_attr_temp2_fault.dev_attr.attr,
-		NULL
-	}, {
-		&sensor_dev_attr_temp3_input.dev_attr.attr,
-		&sensor_dev_attr_temp3_max.dev_attr.attr,
-		&sensor_dev_attr_temp3_max_alarm.dev_attr.attr,
-		&sensor_dev_attr_temp3_crit.dev_attr.attr,
-		&sensor_dev_attr_temp3_crit_alarm.dev_attr.attr,
-		&sensor_dev_attr_temp3_fault.dev_attr.attr,
-		NULL
-	}, {
-		&sensor_dev_attr_temp4_input.dev_attr.attr,
-		&sensor_dev_attr_temp4_max.dev_attr.attr,
-		&sensor_dev_attr_temp4_max_alarm.dev_attr.attr,
-		&sensor_dev_attr_temp4_crit.dev_attr.attr,
-		&sensor_dev_attr_temp4_crit_alarm.dev_attr.attr,
-		&sensor_dev_attr_temp4_fault.dev_attr.attr,
-		NULL
-	}, {
-		&sensor_dev_attr_temp5_input.dev_attr.attr,
-		&sensor_dev_attr_temp5_max.dev_attr.attr,
-		&sensor_dev_attr_temp5_max_alarm.dev_attr.attr,
-		&sensor_dev_attr_temp5_crit.dev_attr.attr,
-		&sensor_dev_attr_temp5_crit_alarm.dev_attr.attr,
-		&sensor_dev_attr_temp5_fault.dev_attr.attr,
-		NULL
-	}, {
-		&sensor_dev_attr_temp6_input.dev_attr.attr,
-		&sensor_dev_attr_temp6_max.dev_attr.attr,
-		&sensor_dev_attr_temp6_max_alarm.dev_attr.attr,
-		&sensor_dev_attr_temp6_crit.dev_attr.attr,
-		&sensor_dev_attr_temp6_crit_alarm.dev_attr.attr,
-		&sensor_dev_attr_temp6_fault.dev_attr.attr,
-		NULL
-	}, {
-		&sensor_dev_attr_temp7_input.dev_attr.attr,
-		&sensor_dev_attr_temp7_max.dev_attr.attr,
-		&sensor_dev_attr_temp7_max_alarm.dev_attr.attr,
-		&sensor_dev_attr_temp7_crit.dev_attr.attr,
-		&sensor_dev_attr_temp7_crit_alarm.dev_attr.attr,
-		&sensor_dev_attr_temp7_fault.dev_attr.attr,
-		NULL
-	}, {
-		&sensor_dev_attr_temp8_input.dev_attr.attr,
-		&sensor_dev_attr_temp8_max.dev_attr.attr,
-		&sensor_dev_attr_temp8_max_alarm.dev_attr.attr,
-		&sensor_dev_attr_temp8_crit.dev_attr.attr,
-		&sensor_dev_attr_temp8_crit_alarm.dev_attr.attr,
-		&sensor_dev_attr_temp8_fault.dev_attr.attr,
-		NULL
-	}
+static DEVICE_ATTR(dummy, 0, NULL, NULL);
+
+static umode_t max6697_is_visible(struct kobject *kobj, struct attribute *attr,
+				  int index)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct max6697_data *data = i2c_get_clientdata(client);
+	const struct max6697_chip_data *chip = data->chip;
+	int channel = index / 6;	/* channel number */
+	int nr = index % 6;		/* attribute index within channel */
+
+	if (channel >= chip->channels)
+		return 0;
+
+	if ((nr = 3 || nr = 4) && !(chip->have_crit & (1 << channel)))
+		return 0;
+	if (nr = 5 && !(chip->have_fault & (1 << channel)))
+		return 0;
+
+	return attr->mode;
+}
+
+/*
+ * max6697_is_visible uses the index into the following array to determine
+ * if attributes should be created or not. Any change in order or content
+ * must be matched in max6697_is_visible.
+ */
+static struct attribute *max6697_attributes[] = {
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_temp1_max.dev_attr.attr,
+	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp1_crit.dev_attr.attr,
+	&sensor_dev_attr_temp1_crit_alarm.dev_attr.attr,
+	&dev_attr_dummy.attr,
+
+	&sensor_dev_attr_temp2_input.dev_attr.attr,
+	&sensor_dev_attr_temp2_max.dev_attr.attr,
+	&sensor_dev_attr_temp2_max_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp2_crit.dev_attr.attr,
+	&sensor_dev_attr_temp2_crit_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp2_fault.dev_attr.attr,
+
+	&sensor_dev_attr_temp3_input.dev_attr.attr,
+	&sensor_dev_attr_temp3_max.dev_attr.attr,
+	&sensor_dev_attr_temp3_max_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp3_crit.dev_attr.attr,
+	&sensor_dev_attr_temp3_crit_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp3_fault.dev_attr.attr,
+
+	&sensor_dev_attr_temp4_input.dev_attr.attr,
+	&sensor_dev_attr_temp4_max.dev_attr.attr,
+	&sensor_dev_attr_temp4_max_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp4_crit.dev_attr.attr,
+	&sensor_dev_attr_temp4_crit_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp4_fault.dev_attr.attr,
+
+	&sensor_dev_attr_temp5_input.dev_attr.attr,
+	&sensor_dev_attr_temp5_max.dev_attr.attr,
+	&sensor_dev_attr_temp5_max_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp5_crit.dev_attr.attr,
+	&sensor_dev_attr_temp5_crit_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp5_fault.dev_attr.attr,
+
+	&sensor_dev_attr_temp6_input.dev_attr.attr,
+	&sensor_dev_attr_temp6_max.dev_attr.attr,
+	&sensor_dev_attr_temp6_max_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp6_crit.dev_attr.attr,
+	&sensor_dev_attr_temp6_crit_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp6_fault.dev_attr.attr,
+
+	&sensor_dev_attr_temp7_input.dev_attr.attr,
+	&sensor_dev_attr_temp7_max.dev_attr.attr,
+	&sensor_dev_attr_temp7_max_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp7_crit.dev_attr.attr,
+	&sensor_dev_attr_temp7_crit_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp7_fault.dev_attr.attr,
+
+	&sensor_dev_attr_temp8_input.dev_attr.attr,
+	&sensor_dev_attr_temp8_max.dev_attr.attr,
+	&sensor_dev_attr_temp8_max_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp8_crit.dev_attr.attr,
+	&sensor_dev_attr_temp8_crit_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp8_fault.dev_attr.attr,
+	NULL
 };
 
-static const struct attribute_group max6697_group[8] = {
-	{ .attrs = max6697_attributes[0] },
-	{ .attrs = max6697_attributes[1] },
-	{ .attrs = max6697_attributes[2] },
-	{ .attrs = max6697_attributes[3] },
-	{ .attrs = max6697_attributes[4] },
-	{ .attrs = max6697_attributes[5] },
-	{ .attrs = max6697_attributes[6] },
-	{ .attrs = max6697_attributes[7] },
+static const struct attribute_group max6697_group = {
+	.attrs = max6697_attributes, .is_visible = max6697_is_visible,
 };
 
 static void max6697_get_config_of(struct device_node *node,
@@ -606,21 +619,13 @@ done:
 	return 0;
 }
 
-static void max6697_remove_files(struct i2c_client *client)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(max6697_group); i++)
-		sysfs_remove_group(&client->dev.kobj, &max6697_group[i]);
-}
-
 static int max6697_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
 	struct i2c_adapter *adapter = client->adapter;
 	struct device *dev = &client->dev;
 	struct max6697_data *data;
-	int i, err;
+	int err;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -ENODEV;
@@ -639,37 +644,9 @@ static int max6697_probe(struct i2c_client *client,
 	if (err)
 		return err;
 
-	for (i = 0; i < data->chip->channels; i++) {
-		err = sysfs_create_file(&dev->kobj,
-					max6697_attributes[i][0]);
-		if (err)
-			goto error;
-		err = sysfs_create_file(&dev->kobj,
-					max6697_attributes[i][1]);
-		if (err)
-			goto error;
-		err = sysfs_create_file(&dev->kobj,
-					max6697_attributes[i][2]);
-		if (err)
-			goto error;
-
-		if (data->chip->have_crit & (1 << i)) {
-			err = sysfs_create_file(&dev->kobj,
-						max6697_attributes[i][3]);
-			if (err)
-				goto error;
-			err = sysfs_create_file(&dev->kobj,
-						max6697_attributes[i][4]);
-			if (err)
-				goto error;
-		}
-		if (data->chip->have_fault & (1 << i)) {
-			err = sysfs_create_file(&dev->kobj,
-						max6697_attributes[i][5]);
-			if (err)
-				goto error;
-		}
-	}
+	err = sysfs_create_group(&client->dev.kobj, &max6697_group);
+	if (err)
+		return err;
 
 	data->hwmon_dev = hwmon_device_register(dev);
 	if (IS_ERR(data->hwmon_dev)) {
@@ -680,7 +657,7 @@ static int max6697_probe(struct i2c_client *client,
 	return 0;
 
 error:
-	max6697_remove_files(client);
+	sysfs_remove_group(&client->dev.kobj, &max6697_group);
 	return err;
 }
 
@@ -689,7 +666,7 @@ static int max6697_remove(struct i2c_client *client)
 	struct max6697_data *data = i2c_get_clientdata(client);
 
 	hwmon_device_unregister(data->hwmon_dev);
-	max6697_remove_files(client);
+	sysfs_remove_group(&client->dev.kobj, &max6697_group);
 
 	return 0;
 }
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
