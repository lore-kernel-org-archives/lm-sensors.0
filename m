From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 17 Jul 2014 11:06:08 +0000
Subject: [lm-sensors] [RFT][PATCH 2/2] hwmon: (thmc50) Convert to devm_hwmon_device_register_with_groups
Message-Id: <1405595168.13586.4.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use devm_hwmon_device_register_with_groups() to simplify the code a bit.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/thmc50.c | 78 ++++++++++++++++----------------------------------
 1 file changed, 25 insertions(+), 53 deletions(-)

diff --git a/drivers/hwmon/thmc50.c b/drivers/hwmon/thmc50.c
index bb538da..6a0ee90 100644
--- a/drivers/hwmon/thmc50.c
+++ b/drivers/hwmon/thmc50.c
@@ -68,7 +68,8 @@ static const u8 THMC50_REG_TEMP_DEFAULT[] = { 0x17, 0x18, 0x18 };
 
 /* Each client has this additional data */
 struct thmc50_data {
-	struct device *hwmon_dev;
+	struct i2c_client *client;
+	const struct attribute_group *groups[3];
 
 	struct mutex update_lock;
 	enum chips type;
@@ -87,8 +88,8 @@ struct thmc50_data {
 
 static struct thmc50_data *thmc50_update_device(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct thmc50_data *data = i2c_get_clientdata(client);
+	struct thmc50_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int timeout = HZ / 5 + (data->type = thmc50 ? HZ : 0);
 
 	mutex_lock(&data->update_lock);
@@ -138,8 +139,8 @@ static ssize_t set_analog_out(struct device *dev,
 			      struct device_attribute *attr,
 			      const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct thmc50_data *data = i2c_get_clientdata(client);
+	struct thmc50_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int config;
 	unsigned long tmp;
 	int err;
@@ -192,8 +193,8 @@ static ssize_t set_temp_min(struct device *dev, struct device_attribute *attr,
 			    const char *buf, size_t count)
 {
 	int nr = to_sensor_dev_attr(attr)->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct thmc50_data *data = i2c_get_clientdata(client);
+	struct thmc50_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long val;
 	int err;
 
@@ -221,8 +222,8 @@ static ssize_t set_temp_max(struct device *dev, struct device_attribute *attr,
 			    const char *buf, size_t count)
 {
 	int nr = to_sensor_dev_attr(attr)->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct thmc50_data *data = i2c_get_clientdata(client);
+	struct thmc50_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long val;
 	int err;
 
@@ -370,9 +371,9 @@ static int thmc50_detect(struct i2c_client *client,
 	return 0;
 }
 
-static void thmc50_init_client(struct i2c_client *client)
+static void thmc50_init_client(struct thmc50_data *data)
 {
-	struct thmc50_data *data = i2c_get_clientdata(client);
+	struct i2c_client *client = data->client;
 	int config;
 
 	data->analog_out = i2c_smbus_read_byte_data(client,
@@ -393,59 +394,31 @@ static void thmc50_init_client(struct i2c_client *client)
 static int thmc50_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
+	struct device *dev = &client->dev;
 	struct thmc50_data *data;
-	int err;
+	struct device *hwmon_dev;
+	int idx = 0;
 
-	data = devm_kzalloc(&client->dev, sizeof(struct thmc50_data),
-			    GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(struct thmc50_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	i2c_set_clientdata(client, data);
+	data->client = client;
 	data->type = id->driver_data;
 	mutex_init(&data->update_lock);
 
-	thmc50_init_client(client);
+	thmc50_init_client(data);
 
-	/* Register sysfs hooks */
-	err = sysfs_create_group(&client->dev.kobj, &thmc50_group);
-	if (err)
-		return err;
-
-	/* Register ADM1022 sysfs hooks */
-	if (data->has_temp3) {
-		err = sysfs_create_group(&client->dev.kobj, &temp3_group);
-		if (err)
-			goto exit_remove_sysfs_thmc50;
-	}
-
-	/* Register a new directory entry with module sensors */
-	data->hwmon_dev = hwmon_device_register(&client->dev);
-	if (IS_ERR(data->hwmon_dev)) {
-		err = PTR_ERR(data->hwmon_dev);
-		goto exit_remove_sysfs;
-	}
+	/* sysfs hooks */
+	data->groups[idx++] = &thmc50_group;
 
-	return 0;
-
-exit_remove_sysfs:
-	if (data->has_temp3)
-		sysfs_remove_group(&client->dev.kobj, &temp3_group);
-exit_remove_sysfs_thmc50:
-	sysfs_remove_group(&client->dev.kobj, &thmc50_group);
-	return err;
-}
-
-static int thmc50_remove(struct i2c_client *client)
-{
-	struct thmc50_data *data = i2c_get_clientdata(client);
-
-	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&client->dev.kobj, &thmc50_group);
+	/* Register additional ADM1022 sysfs hooks */
 	if (data->has_temp3)
-		sysfs_remove_group(&client->dev.kobj, &temp3_group);
+		data->groups[idx++] = &temp3_group;
 
-	return 0;
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
+							   data, data->groups);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
 static const struct i2c_device_id thmc50_id[] = {
@@ -461,7 +434,6 @@ static struct i2c_driver thmc50_driver = {
 		.name = "thmc50",
 	},
 	.probe = thmc50_probe,
-	.remove = thmc50_remove,
 	.id_table = thmc50_id,
 	.detect = thmc50_detect,
 	.address_list = normal_i2c,
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
