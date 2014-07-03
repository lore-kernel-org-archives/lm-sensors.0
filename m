From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 03 Jul 2014 13:49:27 +0000
Subject: [lm-sensors] [RFT][PATCH 2/2] hwmon: (adm1025) Convert to devm_hwmon_device_register_with_groups
Message-Id: <1404395367.4895.5.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
simplify the code a bit.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/adm1025.c | 71 ++++++++++++++++---------------------------------
 1 file changed, 23 insertions(+), 48 deletions(-)

diff --git a/drivers/hwmon/adm1025.c b/drivers/hwmon/adm1025.c
index 0533c2c..d3d0e8c 100644
--- a/drivers/hwmon/adm1025.c
+++ b/drivers/hwmon/adm1025.c
@@ -107,7 +107,8 @@ static const int in_scale[6] = { 2500, 2250, 3300, 5000, 12000, 3300 };
  */
 
 struct adm1025_data {
-	struct device *hwmon_dev;
+	struct i2c_client *client;
+	const struct attribute_group *groups[3];
 	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
@@ -125,8 +126,8 @@ struct adm1025_data {
 
 static struct adm1025_data *adm1025_update_device(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm1025_data *data = i2c_get_clientdata(client);
+	struct adm1025_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 
 	mutex_lock(&data->update_lock);
 
@@ -227,8 +228,8 @@ static ssize_t set_in_min(struct device *dev, struct device_attribute *attr,
 			  const char *buf, size_t count)
 {
 	int index = to_sensor_dev_attr(attr)->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm1025_data *data = i2c_get_clientdata(client);
+	struct adm1025_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long val;
 	int err;
 
@@ -248,8 +249,8 @@ static ssize_t set_in_max(struct device *dev, struct device_attribute *attr,
 			  const char *buf, size_t count)
 {
 	int index = to_sensor_dev_attr(attr)->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm1025_data *data = i2c_get_clientdata(client);
+	struct adm1025_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long val;
 	int err;
 
@@ -283,8 +284,8 @@ static ssize_t set_temp_min(struct device *dev, struct device_attribute *attr,
 			    const char *buf, size_t count)
 {
 	int index = to_sensor_dev_attr(attr)->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm1025_data *data = i2c_get_clientdata(client);
+	struct adm1025_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long val;
 	int err;
 
@@ -304,8 +305,8 @@ static ssize_t set_temp_max(struct device *dev, struct device_attribute *attr,
 	const char *buf, size_t count)
 {
 	int index = to_sensor_dev_attr(attr)->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm1025_data *data = i2c_get_clientdata(client);
+	struct adm1025_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long val;
 	int err;
 
@@ -525,57 +526,32 @@ static void adm1025_init_client(struct i2c_client *client)
 static int adm1025_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
+	struct device *dev = &client->dev;
+	struct device *hwmon_dev;
 	struct adm1025_data *data;
-	int err;
 	u8 config;
 
-	data = devm_kzalloc(&client->dev, sizeof(struct adm1025_data),
-			    GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(struct adm1025_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
 	i2c_set_clientdata(client, data);
+	data->client = client;
 	mutex_init(&data->update_lock);
 
 	/* Initialize the ADM1025 chip */
 	adm1025_init_client(client);
 
-	/* Register sysfs hooks */
-	err = sysfs_create_group(&client->dev.kobj, &adm1025_group);
-	if (err)
-		return err;
-
+	/* sysfs hooks */
+	data->groups[0] = &adm1025_group;
 	/* Pin 11 is either in4 (+12V) or VID4 */
 	config = i2c_smbus_read_byte_data(client, ADM1025_REG_CONFIG);
-	if (!(config & 0x20)) {
-		err = sysfs_create_group(&client->dev.kobj, &adm1025_group_in4);
-		if (err)
-			goto exit_remove;
-	}
-
-	data->hwmon_dev = hwmon_device_register(&client->dev);
-	if (IS_ERR(data->hwmon_dev)) {
-		err = PTR_ERR(data->hwmon_dev);
-		goto exit_remove;
-	}
-
-	return 0;
+	if (!(config & 0x20))
+		data->groups[1] = &adm1025_group_in4;
 
-exit_remove:
-	sysfs_remove_group(&client->dev.kobj, &adm1025_group);
-	sysfs_remove_group(&client->dev.kobj, &adm1025_group_in4);
-	return err;
-}
-
-static int adm1025_remove(struct i2c_client *client)
-{
-	struct adm1025_data *data = i2c_get_clientdata(client);
-
-	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&client->dev.kobj, &adm1025_group);
-	sysfs_remove_group(&client->dev.kobj, &adm1025_group_in4);
-
-	return 0;
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
+							   data, data->groups);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
 static const struct i2c_device_id adm1025_id[] = {
@@ -591,7 +567,6 @@ static struct i2c_driver adm1025_driver = {
 		.name	= "adm1025",
 	},
 	.probe		= adm1025_probe,
-	.remove		= adm1025_remove,
 	.id_table	= adm1025_id,
 	.detect		= adm1025_detect,
 	.address_list	= normal_i2c,
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
