From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 19 Apr 2014 22:27:45 +0000
Subject: [lm-sensors] [PATCH 3/3] hwmon: (lm83) Convert to use devm_hwmon_device_register_with_groups
Message-Id: <1397946465-4396-3-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use devm_hwmon_device_register_with_groups API to attach attributes
to hwmon device, simplify code, and reduce code size.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm83.c |   59 ++++++++++++++------------------------------------
 1 file changed, 16 insertions(+), 43 deletions(-)

diff --git a/drivers/hwmon/lm83.c b/drivers/hwmon/lm83.c
index f9fcc91..9e4d0e1 100644
--- a/drivers/hwmon/lm83.c
+++ b/drivers/hwmon/lm83.c
@@ -111,7 +111,8 @@ static const u8 LM83_REG_W_HIGH[] = {
  */
 
 struct lm83_data {
-	struct device *hwmon_dev;
+	struct i2c_client *client;
+	const struct attribute_group *groups[3];
 	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
@@ -125,8 +126,8 @@ struct lm83_data {
 
 static struct lm83_data *lm83_update_device(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm83_data *data = i2c_get_clientdata(client);
+	struct lm83_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 
 	mutex_lock(&data->update_lock);
 
@@ -169,8 +170,8 @@ static ssize_t set_temp(struct device *dev, struct device_attribute *devattr,
 			const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm83_data *data = i2c_get_clientdata(client);
+	struct lm83_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long val;
 	int nr = attr->index;
 	int err;
@@ -332,15 +333,15 @@ static int lm83_detect(struct i2c_client *new_client,
 static int lm83_probe(struct i2c_client *new_client,
 		      const struct i2c_device_id *id)
 {
+	struct device *hwmon_dev;
 	struct lm83_data *data;
-	int err;
 
 	data = devm_kzalloc(&new_client->dev, sizeof(struct lm83_data),
 			    GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	i2c_set_clientdata(new_client, data);
+	data->client = new_client;
 	mutex_init(&data->update_lock);
 
 	/*
@@ -349,41 +350,14 @@ static int lm83_probe(struct i2c_client *new_client,
 	 * at the same register as the LM83 temp3 entry - so we
 	 * declare 1 and 3 common, and then 2 and 4 only for the LM83.
 	 */
-
-	err = sysfs_create_group(&new_client->dev.kobj, &lm83_group);
-	if (err)
-		return err;
-
-	if (id->driver_data = lm83) {
-		err = sysfs_create_group(&new_client->dev.kobj,
-					 &lm83_group_opt);
-		if (err)
-			goto exit_remove_files;
-	}
-
-	data->hwmon_dev = hwmon_device_register(&new_client->dev);
-	if (IS_ERR(data->hwmon_dev)) {
-		err = PTR_ERR(data->hwmon_dev);
-		goto exit_remove_files;
-	}
-
-	return 0;
-
-exit_remove_files:
-	sysfs_remove_group(&new_client->dev.kobj, &lm83_group);
-	sysfs_remove_group(&new_client->dev.kobj, &lm83_group_opt);
-	return err;
-}
-
-static int lm83_remove(struct i2c_client *client)
-{
-	struct lm83_data *data = i2c_get_clientdata(client);
-
-	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&client->dev.kobj, &lm83_group);
-	sysfs_remove_group(&client->dev.kobj, &lm83_group_opt);
-
-	return 0;
+	data->groups[0] = &lm83_group;
+	if (id->driver_data = lm83)
+		data->groups[1] = &lm83_group_opt;
+
+	hwmon_dev = devm_hwmon_device_register_with_groups(&new_client->dev,
+							   new_client->name,
+							   data, data->groups);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
 /*
@@ -403,7 +377,6 @@ static struct i2c_driver lm83_driver = {
 		.name	= "lm83",
 	},
 	.probe		= lm83_probe,
-	.remove		= lm83_remove,
 	.id_table	= lm83_id,
 	.detect		= lm83_detect,
 	.address_list	= normal_i2c,
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
