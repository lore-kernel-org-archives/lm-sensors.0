From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 19 Apr 2014 22:28:13 +0000
Subject: [lm-sensors] [PATCH 5/5] hwmon: (max1619) Convert to use devm_hwmon_device_register_with_groups
Message-Id: <1397946493-4455-5-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use devm_hwmon_device_register_with_groups API to attach attributes
to hwmon device, simplify code, and reduce code size.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/max1619.c |   53 +++++++++++++----------------------------------
 1 file changed, 14 insertions(+), 39 deletions(-)

diff --git a/drivers/hwmon/max1619.c b/drivers/hwmon/max1619.c
index 699c57d..e115b68 100644
--- a/drivers/hwmon/max1619.c
+++ b/drivers/hwmon/max1619.c
@@ -86,7 +86,7 @@ enum temp_index {
  */
 
 struct max1619_data {
-	struct device *hwmon_dev;
+	struct i2c_client *client;
 	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
@@ -114,8 +114,8 @@ static u8 regs_write[] = {
 
 static struct max1619_data *max1619_update_device(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct max1619_data *data = i2c_get_clientdata(client);
+	struct max1619_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int config, i;
 
 	mutex_lock(&data->update_lock);
@@ -158,8 +158,8 @@ static ssize_t set_temp(struct device *dev, struct device_attribute *devattr,
 			   const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct max1619_data *data = i2c_get_clientdata(client);
+	struct max1619_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long val;
 	int err = kstrtol(buf, 10, &val);
 	if (err)
@@ -205,7 +205,7 @@ static SENSOR_DEVICE_ATTR(temp2_fault, S_IRUGO, show_alarm, NULL, 2);
 static SENSOR_DEVICE_ATTR(temp2_min_alarm, S_IRUGO, show_alarm, NULL, 3);
 static SENSOR_DEVICE_ATTR(temp2_max_alarm, S_IRUGO, show_alarm, NULL, 4);
 
-static struct attribute *max1619_attributes[] = {
+static struct attribute *max1619_attrs[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
 	&sensor_dev_attr_temp2_input.dev_attr.attr,
 	&sensor_dev_attr_temp2_min.dev_attr.attr,
@@ -220,10 +220,7 @@ static struct attribute *max1619_attributes[] = {
 	&sensor_dev_attr_temp2_max_alarm.dev_attr.attr,
 	NULL
 };
-
-static const struct attribute_group max1619_group = {
-	.attrs = max1619_attributes,
-};
+ATTRIBUTE_GROUPS(max1619);
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
 static int max1619_detect(struct i2c_client *client,
@@ -280,45 +277,24 @@ static int max1619_probe(struct i2c_client *new_client,
 			 const struct i2c_device_id *id)
 {
 	struct max1619_data *data;
-	int err;
+	struct device *hwmon_dev;
 
 	data = devm_kzalloc(&new_client->dev, sizeof(struct max1619_data),
 			    GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	i2c_set_clientdata(new_client, data);
+	data->client = new_client;
 	mutex_init(&data->update_lock);
 
 	/* Initialize the MAX1619 chip */
 	max1619_init_client(new_client);
 
-	/* Register sysfs hooks */
-	err = sysfs_create_group(&new_client->dev.kobj, &max1619_group);
-	if (err)
-		return err;
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
-	sysfs_remove_group(&new_client->dev.kobj, &max1619_group);
-	return err;
-}
-
-static int max1619_remove(struct i2c_client *client)
-{
-	struct max1619_data *data = i2c_get_clientdata(client);
-
-	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&client->dev.kobj, &max1619_group);
-
-	return 0;
+	hwmon_dev = devm_hwmon_device_register_with_groups(&new_client->dev,
+							   new_client->name,
+							   data,
+							   max1619_groups);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
 static const struct i2c_device_id max1619_id[] = {
@@ -333,7 +309,6 @@ static struct i2c_driver max1619_driver = {
 		.name	= "max1619",
 	},
 	.probe		= max1619_probe,
-	.remove		= max1619_remove,
 	.id_table	= max1619_id,
 	.detect		= max1619_detect,
 	.address_list	= normal_i2c,
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
