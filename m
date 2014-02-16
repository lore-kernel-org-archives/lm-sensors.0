From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 16 Feb 2014 02:08:01 +0000
Subject: [lm-sensors] [PATCH 3/3] hwmon: (max1668) Convert to use devm_hwmon_device_register_with_groups
Message-Id: <1392516481-16548-3-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Simplify code, reduce code size, and attach hwmon attributes to hwmon device.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/max1668.c |   67 +++++++++++++----------------------------------
 1 file changed, 18 insertions(+), 49 deletions(-)

diff --git a/drivers/hwmon/max1668.c b/drivers/hwmon/max1668.c
index bbbe340..e3ed0a5 100644
--- a/drivers/hwmon/max1668.c
+++ b/drivers/hwmon/max1668.c
@@ -66,7 +66,8 @@ MODULE_PARM_DESC(read_only, "Don't set any values, read only mode");
 enum chips { max1668, max1805, max1989 };
 
 struct max1668_data {
-	struct device *hwmon_dev;
+	struct i2c_client *client;
+	const struct attribute_group *groups[3];
 	enum chips type;
 
 	struct mutex update_lock;
@@ -82,8 +83,8 @@ struct max1668_data {
 
 static struct max1668_data *max1668_update_device(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct max1668_data *data = i2c_get_clientdata(client);
+	struct max1668_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	struct max1668_data *ret = data;
 	s32 val;
 	int i;
@@ -205,8 +206,8 @@ static ssize_t set_temp_max(struct device *dev,
 			    const char *buf, size_t count)
 {
 	int index = to_sensor_dev_attr(devattr)->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct max1668_data *data = i2c_get_clientdata(client);
+	struct max1668_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long temp;
 	int ret;
 
@@ -231,8 +232,8 @@ static ssize_t set_temp_min(struct device *dev,
 			    const char *buf, size_t count)
 {
 	int index = to_sensor_dev_attr(devattr)->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct max1668_data *data = i2c_get_clientdata(client);
+	struct max1668_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long temp;
 	int ret;
 
@@ -407,60 +408,29 @@ static int max1668_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
 	struct i2c_adapter *adapter = client->adapter;
+	struct device *dev = &client->dev;
+	struct device *hwmon_dev;
 	struct max1668_data *data;
-	int err;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -ENODEV;
 
-	data = devm_kzalloc(&client->dev, sizeof(struct max1668_data),
-			    GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(struct max1668_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	i2c_set_clientdata(client, data);
+	data->client = client;
 	data->type = id->driver_data;
 	mutex_init(&data->update_lock);
 
-	/* Register sysfs hooks */
-	err = sysfs_create_group(&client->dev.kobj, &max1668_group_common);
-	if (err)
-		return err;
-
-	if (data->type = max1668 || data->type = max1989) {
-		err = sysfs_create_group(&client->dev.kobj,
-					 &max1668_group_unique);
-		if (err)
-			goto error_sysrem0;
-	}
-
-	data->hwmon_dev = hwmon_device_register(&client->dev);
-	if (IS_ERR(data->hwmon_dev)) {
-		err = PTR_ERR(data->hwmon_dev);
-		goto error_sysrem1;
-	}
-
-	return 0;
-
-error_sysrem1:
-	if (data->type = max1668 || data->type = max1989)
-		sysfs_remove_group(&client->dev.kobj, &max1668_group_unique);
-error_sysrem0:
-	sysfs_remove_group(&client->dev.kobj, &max1668_group_common);
-	return err;
-}
-
-static int max1668_remove(struct i2c_client *client)
-{
-	struct max1668_data *data = i2c_get_clientdata(client);
-
-	hwmon_device_unregister(data->hwmon_dev);
+	/* sysfs hooks */
+	data->groups[0] = &max1668_group_common;
 	if (data->type = max1668 || data->type = max1989)
-		sysfs_remove_group(&client->dev.kobj, &max1668_group_unique);
+		data->groups[1] = &max1668_group_unique;
 
-	sysfs_remove_group(&client->dev.kobj, &max1668_group_common);
-
-	return 0;
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
+							   data, data->groups);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
 static const struct i2c_device_id max1668_id[] = {
@@ -478,7 +448,6 @@ static struct i2c_driver max1668_driver = {
 		  .name	= "max1668",
 		  },
 	.probe = max1668_probe,
-	.remove	= max1668_remove,
 	.id_table = max1668_id,
 	.detect	= max1668_detect,
 	.address_list = max1668_addr_list,
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
