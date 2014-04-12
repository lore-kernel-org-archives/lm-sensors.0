From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 12 Apr 2014 04:39:56 +0000
Subject: [lm-sensors] [PATCH] hwmon: (tmp421) Convert to use devm_hwmon_device_register_with_groups
Message-Id: <1397277596-27648-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use devm_hwmon_device_register_with_groups API to attach attributes
to hwmon device, simplify code, and reduce code size.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/tmp421.c |   47 +++++++++++++++--------------------------------
 1 file changed, 15 insertions(+), 32 deletions(-)

diff --git a/drivers/hwmon/tmp421.c b/drivers/hwmon/tmp421.c
index ae26b06..7bab7a9 100644
--- a/drivers/hwmon/tmp421.c
+++ b/drivers/hwmon/tmp421.c
@@ -69,7 +69,7 @@ static const struct i2c_device_id tmp421_id[] = {
 MODULE_DEVICE_TABLE(i2c, tmp421_id);
 
 struct tmp421_data {
-	struct device *hwmon_dev;
+	struct i2c_client *client;
 	struct mutex update_lock;
 	char valid;
 	unsigned long last_updated;
@@ -99,8 +99,8 @@ static int temp_from_u16(u16 reg)
 
 static struct tmp421_data *tmp421_update_device(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct tmp421_data *data = i2c_get_clientdata(client);
+	struct tmp421_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int i;
 
 	mutex_lock(&data->update_lock);
@@ -198,6 +198,11 @@ static const struct attribute_group tmp421_group = {
 	.is_visible = tmp421_is_visible,
 };
 
+static const struct attribute_group *tmp421_groups[] = {
+	&tmp421_group,
+	NULL
+};
+
 static int tmp421_init_client(struct i2c_client *client)
 {
 	int config, config_orig;
@@ -264,47 +269,26 @@ static int tmp421_detect(struct i2c_client *client,
 static int tmp421_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
+	struct device *dev = &client->dev;
+	struct device *hwmon_dev;
 	struct tmp421_data *data;
 	int err;
 
-	data = devm_kzalloc(&client->dev, sizeof(struct tmp421_data),
-			    GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(struct tmp421_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	i2c_set_clientdata(client, data);
 	mutex_init(&data->update_lock);
 	data->channels = id->driver_data;
+	data->client = client;
 
 	err = tmp421_init_client(client);
 	if (err)
 		return err;
 
-	err = sysfs_create_group(&client->dev.kobj, &tmp421_group);
-	if (err)
-		return err;
-
-	data->hwmon_dev = hwmon_device_register(&client->dev);
-	if (IS_ERR(data->hwmon_dev)) {
-		err = PTR_ERR(data->hwmon_dev);
-		data->hwmon_dev = NULL;
-		goto exit_remove;
-	}
-	return 0;
-
-exit_remove:
-	sysfs_remove_group(&client->dev.kobj, &tmp421_group);
-	return err;
-}
-
-static int tmp421_remove(struct i2c_client *client)
-{
-	struct tmp421_data *data = i2c_get_clientdata(client);
-
-	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&client->dev.kobj, &tmp421_group);
-
-	return 0;
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
+							   data, tmp421_groups);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
 static struct i2c_driver tmp421_driver = {
@@ -313,7 +297,6 @@ static struct i2c_driver tmp421_driver = {
 		.name	= "tmp421",
 	},
 	.probe = tmp421_probe,
-	.remove = tmp421_remove,
 	.id_table = tmp421_id,
 	.detect = tmp421_detect,
 	.address_list = normal_i2c,
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
