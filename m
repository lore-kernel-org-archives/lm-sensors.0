From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 17 Jul 2014 11:21:44 +0000
Subject: [lm-sensors] [RFT][PATCH 2/2] hwmon: (smsc47m192) Convert to devm_hwmon_device_register_with_groups
Message-Id: <1405596104.13586.12.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use devm_hwmon_device_register_with_groups() to simplify the code a bit.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/smsc47m192.c | 77 +++++++++++++++-------------------------------
 1 file changed, 25 insertions(+), 52 deletions(-)

diff --git a/drivers/hwmon/smsc47m192.c b/drivers/hwmon/smsc47m192.c
index 7ab1659..5c59f8b 100644
--- a/drivers/hwmon/smsc47m192.c
+++ b/drivers/hwmon/smsc47m192.c
@@ -95,7 +95,8 @@ static inline int TEMP_FROM_REG(s8 val)
 }
 
 struct smsc47m192_data {
-	struct device *hwmon_dev;
+	struct i2c_client *client;
+	const struct attribute_group *groups[3];
 	struct mutex update_lock;
 	char valid;		/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
@@ -114,8 +115,8 @@ struct smsc47m192_data {
 
 static struct smsc47m192_data *smsc47m192_update_device(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct smsc47m192_data *data = i2c_get_clientdata(client);
+	struct smsc47m192_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int i, config;
 
 	mutex_lock(&data->update_lock);
@@ -209,8 +210,8 @@ static ssize_t set_in_min(struct device *dev, struct device_attribute *attr,
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
 	int nr = sensor_attr->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct smsc47m192_data *data = i2c_get_clientdata(client);
+	struct smsc47m192_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	unsigned long val;
 	int err;
 
@@ -231,8 +232,8 @@ static ssize_t set_in_max(struct device *dev, struct device_attribute *attr,
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
 	int nr = sensor_attr->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct smsc47m192_data *data = i2c_get_clientdata(client);
+	struct smsc47m192_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	unsigned long val;
 	int err;
 
@@ -298,8 +299,8 @@ static ssize_t set_temp_min(struct device *dev, struct device_attribute *attr,
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
 	int nr = sensor_attr->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct smsc47m192_data *data = i2c_get_clientdata(client);
+	struct smsc47m192_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long val;
 	int err;
 
@@ -320,8 +321,8 @@ static ssize_t set_temp_max(struct device *dev, struct device_attribute *attr,
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
 	int nr = sensor_attr->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct smsc47m192_data *data = i2c_get_clientdata(client);
+	struct smsc47m192_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long val;
 	int err;
 
@@ -351,8 +352,8 @@ static ssize_t set_temp_offset(struct device *dev, struct device_attribute
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
 	int nr = sensor_attr->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct smsc47m192_data *data = i2c_get_clientdata(client);
+	struct smsc47m192_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	u8 sfr = i2c_smbus_read_byte_data(client, SMSC47M192_REG_SFR);
 	long val;
 	int err;
@@ -589,59 +590,32 @@ static int smsc47m192_detect(struct i2c_client *client,
 static int smsc47m192_probe(struct i2c_client *client,
 			    const struct i2c_device_id *id)
 {
+	struct device *dev = &client->dev;
+	struct device *hwmon_dev;
 	struct smsc47m192_data *data;
 	int config;
-	int err;
 
-	data = devm_kzalloc(&client->dev, sizeof(struct smsc47m192_data),
-			    GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(struct smsc47m192_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	i2c_set_clientdata(client, data);
+	data->client = client;
 	data->vrm = vid_which_vrm();
 	mutex_init(&data->update_lock);
 
 	/* Initialize the SMSC47M192 chip */
 	smsc47m192_init_client(client);
 
-	/* Register sysfs hooks */
-	err = sysfs_create_group(&client->dev.kobj, &smsc47m192_group);
-	if (err)
-		return err;
-
+	/* sysfs hooks */
+	data->groups[0] = &smsc47m192_group;
 	/* Pin 110 is either in4 (+12V) or VID4 */
 	config = i2c_smbus_read_byte_data(client, SMSC47M192_REG_CONFIG);
-	if (!(config & 0x20)) {
-		err = sysfs_create_group(&client->dev.kobj,
-					 &smsc47m192_group_in4);
-		if (err)
-			goto exit_remove_files;
-	}
-
-	data->hwmon_dev = hwmon_device_register(&client->dev);
-	if (IS_ERR(data->hwmon_dev)) {
-		err = PTR_ERR(data->hwmon_dev);
-		goto exit_remove_files;
-	}
+	if (!(config & 0x20))
+		data->groups[1] = &smsc47m192_group_in4;
 
-	return 0;
-
-exit_remove_files:
-	sysfs_remove_group(&client->dev.kobj, &smsc47m192_group);
-	sysfs_remove_group(&client->dev.kobj, &smsc47m192_group_in4);
-	return err;
-}
-
-static int smsc47m192_remove(struct i2c_client *client)
-{
-	struct smsc47m192_data *data = i2c_get_clientdata(client);
-
-	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&client->dev.kobj, &smsc47m192_group);
-	sysfs_remove_group(&client->dev.kobj, &smsc47m192_group_in4);
-
-	return 0;
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
+							   data, data->groups);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
 static const struct i2c_device_id smsc47m192_id[] = {
@@ -656,7 +630,6 @@ static struct i2c_driver smsc47m192_driver = {
 		.name	= "smsc47m192",
 	},
 	.probe		= smsc47m192_probe,
-	.remove		= smsc47m192_remove,
 	.id_table	= smsc47m192_id,
 	.detect		= smsc47m192_detect,
 	.address_list	= normal_i2c,
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
