From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 23 Jul 2014 04:29:11 +0000
Subject: [lm-sensors] [RFT][PATCH 2/2] hwmon: (lm85) Convert to devm_hwmon_device_register_with_groups
Message-Id: <1406089751.15290.3.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use devm_hwmon_device_register_with_groups() to simplify the code a bit.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/lm85.c | 144 ++++++++++++++++++---------------------------------
 1 file changed, 51 insertions(+), 93 deletions(-)

diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
index da6ef1e..6fff299 100644
--- a/drivers/hwmon/lm85.c
+++ b/drivers/hwmon/lm85.c
@@ -302,7 +302,8 @@ struct lm85_autofan {
  * The structure is dynamically allocated.
  */
 struct lm85_data {
-	struct device *hwmon_dev;
+	struct i2c_client *client;
+	const struct attribute_group *groups[6];
 	const int *freq_map;
 	enum chips type;
 
@@ -382,8 +383,8 @@ static void lm85_write_value(struct i2c_client *client, u8 reg, int value)
 
 static struct lm85_data *lm85_update_device(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm85_data *data = i2c_get_clientdata(client);
+	struct lm85_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int i;
 
 	mutex_lock(&data->update_lock);
@@ -584,8 +585,8 @@ static ssize_t set_fan_min(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
 {
 	int nr = to_sensor_dev_attr(attr)->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm85_data *data = i2c_get_clientdata(client);
+	struct lm85_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	unsigned long val;
 	int err;
 
@@ -705,8 +706,8 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
 {
 	int nr = to_sensor_dev_attr(attr)->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm85_data *data = i2c_get_clientdata(client);
+	struct lm85_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	unsigned long val;
 	int err;
 
@@ -747,8 +748,8 @@ static ssize_t set_pwm_enable(struct device *dev, struct device_attribute
 		*attr, const char *buf, size_t count)
 {
 	int nr = to_sensor_dev_attr(attr)->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm85_data *data = i2c_get_clientdata(client);
+	struct lm85_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	u8 config;
 	unsigned long val;
 	int err;
@@ -805,8 +806,8 @@ static ssize_t set_pwm_freq(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	int nr = to_sensor_dev_attr(attr)->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm85_data *data = i2c_get_clientdata(client);
+	struct lm85_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	unsigned long val;
 	int err;
 
@@ -872,8 +873,8 @@ static ssize_t set_in_min(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
 {
 	int nr = to_sensor_dev_attr(attr)->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm85_data *data = i2c_get_clientdata(client);
+	struct lm85_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long val;
 	int err;
 
@@ -900,8 +901,8 @@ static ssize_t set_in_max(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
 {
 	int nr = to_sensor_dev_attr(attr)->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm85_data *data = i2c_get_clientdata(client);
+	struct lm85_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long val;
 	int err;
 
@@ -956,8 +957,8 @@ static ssize_t set_temp_min(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
 {
 	int nr = to_sensor_dev_attr(attr)->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm85_data *data = i2c_get_clientdata(client);
+	struct lm85_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long val;
 	int err;
 
@@ -987,8 +988,8 @@ static ssize_t set_temp_max(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
 {
 	int nr = to_sensor_dev_attr(attr)->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm85_data *data = i2c_get_clientdata(client);
+	struct lm85_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long val;
 	int err;
 
@@ -1033,8 +1034,8 @@ static ssize_t set_pwm_auto_channels(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	int nr = to_sensor_dev_attr(attr)->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm85_data *data = i2c_get_clientdata(client);
+	struct lm85_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long val;
 	int err;
 
@@ -1063,8 +1064,8 @@ static ssize_t set_pwm_auto_pwm_min(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	int nr = to_sensor_dev_attr(attr)->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm85_data *data = i2c_get_clientdata(client);
+	struct lm85_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	unsigned long val;
 	int err;
 
@@ -1092,8 +1093,8 @@ static ssize_t set_pwm_auto_pwm_minctl(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	int nr = to_sensor_dev_attr(attr)->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm85_data *data = i2c_get_clientdata(client);
+	struct lm85_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	u8 tmp;
 	long val;
 	int err;
@@ -1143,8 +1144,8 @@ static ssize_t set_temp_auto_temp_off(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	int nr = to_sensor_dev_attr(attr)->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm85_data *data = i2c_get_clientdata(client);
+	struct lm85_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int min;
 	long val;
 	int err;
@@ -1180,8 +1181,8 @@ static ssize_t set_temp_auto_temp_min(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	int nr = to_sensor_dev_attr(attr)->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm85_data *data = i2c_get_clientdata(client);
+	struct lm85_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long val;
 	int err;
 
@@ -1219,8 +1220,8 @@ static ssize_t set_temp_auto_temp_max(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	int nr = to_sensor_dev_attr(attr)->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm85_data *data = i2c_get_clientdata(client);
+	struct lm85_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int min;
 	long val;
 	int err;
@@ -1253,8 +1254,8 @@ static ssize_t set_temp_auto_temp_crit(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	int nr = to_sensor_dev_attr(attr)->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm85_data *data = i2c_get_clientdata(client);
+	struct lm85_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long val;
 	int err;
 
@@ -1545,30 +1546,18 @@ static int lm85_detect(struct i2c_client *client, struct i2c_board_info *info)
 	return 0;
 }
 
-static void lm85_remove_files(struct i2c_client *client, struct lm85_data *data)
-{
-	sysfs_remove_group(&client->dev.kobj, &lm85_group);
-	if (data->type != emc6d103s) {
-		sysfs_remove_group(&client->dev.kobj, &lm85_group_minctl);
-		sysfs_remove_group(&client->dev.kobj, &lm85_group_temp_off);
-	}
-	if (!data->has_vid5)
-		sysfs_remove_group(&client->dev.kobj, &lm85_group_in4);
-	if (data->type = emc6d100)
-		sysfs_remove_group(&client->dev.kobj, &lm85_group_in567);
-}
-
-static int lm85_probe(struct i2c_client *client,
-		      const struct i2c_device_id *id)
+static int lm85_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
+	struct device *dev = &client->dev;
+	struct device *hwmon_dev;
 	struct lm85_data *data;
-	int err;
+	int idx = 0;
 
-	data = devm_kzalloc(&client->dev, sizeof(struct lm85_data), GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(struct lm85_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	i2c_set_clientdata(client, data);
+	data->client = client;
 	data->type = id->driver_data;
 	mutex_init(&data->update_lock);
 
@@ -1593,20 +1582,13 @@ static int lm85_probe(struct i2c_client *client,
 	/* Initialize the LM85 chip */
 	lm85_init_client(client);
 
-	/* Register sysfs hooks */
-	err = sysfs_create_group(&client->dev.kobj, &lm85_group);
-	if (err)
-		return err;
+	/* sysfs hooks */
+	data->groups[idx++] = &lm85_group;
 
 	/* minctl and temp_off exist on all chips except emc6d103s */
 	if (data->type != emc6d103s) {
-		err = sysfs_create_group(&client->dev.kobj, &lm85_group_minctl);
-		if (err)
-			goto err_remove_files;
-		err = sysfs_create_group(&client->dev.kobj,
-					 &lm85_group_temp_off);
-		if (err)
-			goto err_remove_files;
+		data->groups[idx++] = &lm85_group_minctl;
+		data->groups[idx++] = &lm85_group_temp_off;
 	}
 
 	/*
@@ -1619,39 +1601,16 @@ static int lm85_probe(struct i2c_client *client,
 			data->has_vid5 = true;
 	}
 
-	if (!data->has_vid5) {
-		err = sysfs_create_group(&client->dev.kobj, &lm85_group_in4);
-		if (err)
-			goto err_remove_files;
-	}
+	if (!data->has_vid5)
+		data->groups[idx++] = &lm85_group_in4;
 
 	/* The EMC6D100 has 3 additional voltage inputs */
-	if (data->type = emc6d100) {
-		err = sysfs_create_group(&client->dev.kobj, &lm85_group_in567);
-		if (err)
-			goto err_remove_files;
-	}
-
-	data->hwmon_dev = hwmon_device_register(&client->dev);
-	if (IS_ERR(data->hwmon_dev)) {
-		err = PTR_ERR(data->hwmon_dev);
-		goto err_remove_files;
-	}
-
-	return 0;
-
-	/* Error out and cleanup code */
- err_remove_files:
-	lm85_remove_files(client, data);
-	return err;
-}
+	if (data->type = emc6d100)
+		data->groups[idx++] = &lm85_group_in567;
 
-static int lm85_remove(struct i2c_client *client)
-{
-	struct lm85_data *data = i2c_get_clientdata(client);
-	hwmon_device_unregister(data->hwmon_dev);
-	lm85_remove_files(client, data);
-	return 0;
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
+							   data, data->groups);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
 static const struct i2c_device_id lm85_id[] = {
@@ -1676,7 +1635,6 @@ static struct i2c_driver lm85_driver = {
 		.name   = "lm85",
 	},
 	.probe		= lm85_probe,
-	.remove		= lm85_remove,
 	.id_table	= lm85_id,
 	.detect		= lm85_detect,
 	.address_list	= normal_i2c,
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
