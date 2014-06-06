From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 06 Jun 2014 23:55:10 +0000
Subject: [lm-sensors] [PATCH v3] hwmon: (atxp1) Convert to devm_hwmon_device_register_with_groups
Message-Id: <1402098910.13153.0.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups.
This simplifies the code a bit.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/atxp1.c | 76 ++++++++++++++-------------------------------------
 1 file changed, 21 insertions(+), 55 deletions(-)

diff --git a/drivers/hwmon/atxp1.c b/drivers/hwmon/atxp1.c
index 2ae8a30..4c829bb 100644
--- a/drivers/hwmon/atxp1.c
+++ b/drivers/hwmon/atxp1.c
@@ -46,7 +46,7 @@ MODULE_AUTHOR("Sebastian Witt <se.witt@gmx.net>");
 static const unsigned short normal_i2c[] = { 0x37, 0x4e, I2C_CLIENT_END };
 
 struct atxp1_data {
-	struct device *hwmon_dev;
+	struct i2c_client *client;
 	struct mutex update_lock;
 	unsigned long last_updated;
 	u8 valid;
@@ -61,11 +61,8 @@ struct atxp1_data {
 
 static struct atxp1_data *atxp1_update_device(struct device *dev)
 {
-	struct i2c_client *client;
-	struct atxp1_data *data;
-
-	client = to_i2c_client(dev);
-	data = i2c_get_clientdata(client);
+	struct atxp1_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 
 	mutex_lock(&data->update_lock);
 
@@ -105,15 +102,12 @@ static ssize_t atxp1_storevcore(struct device *dev,
 				struct device_attribute *attr,
 				const char *buf, size_t count)
 {
-	struct atxp1_data *data;
-	struct i2c_client *client;
+	struct atxp1_data *data = atxp1_update_device(dev);
+	struct i2c_client *client = data->client;
 	int vid, cvid;
 	unsigned long vcore;
 	int err;
 
-	client = to_i2c_client(dev);
-	data = atxp1_update_device(dev);
-
 	err = kstrtoul(buf, 10, &vcore);
 	if (err)
 		return err;
@@ -184,14 +178,11 @@ static ssize_t atxp1_storegpio1(struct device *dev,
 				struct device_attribute *attr, const char *buf,
 				size_t count)
 {
-	struct atxp1_data *data;
-	struct i2c_client *client;
+	struct atxp1_data *data = atxp1_update_device(dev);
+	struct i2c_client *client = data->client;
 	unsigned long value;
 	int err;
 
-	client = to_i2c_client(dev);
-	data = atxp1_update_device(dev);
-
 	err = kstrtoul(buf, 16, &value);
 	if (err)
 		return err;
@@ -234,7 +225,7 @@ static ssize_t atxp1_storegpio2(struct device *dev,
 				const char *buf, size_t count)
 {
 	struct atxp1_data *data = atxp1_update_device(dev);
-	struct i2c_client *client = to_i2c_client(dev);
+	struct i2c_client *client = data->client;
 	unsigned long value;
 	int err;
 
@@ -260,17 +251,13 @@ static ssize_t atxp1_storegpio2(struct device *dev,
  */
 static DEVICE_ATTR(gpio2, S_IRUGO | S_IWUSR, atxp1_showgpio2, atxp1_storegpio2);
 
-static struct attribute *atxp1_attributes[] = {
+static struct attribute *atxp1_attrs[] = {
 	&dev_attr_gpio1.attr,
 	&dev_attr_gpio2.attr,
 	&dev_attr_cpu0_vid.attr,
 	NULL
 };
-
-static const struct attribute_group atxp1_group = {
-	.attrs = atxp1_attributes,
-};
-
+ATTRIBUTE_GROUPS(atxp1);
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
 static int atxp1_detect(struct i2c_client *new_client,
@@ -314,50 +301,30 @@ static int atxp1_detect(struct i2c_client *new_client,
 	return 0;
 }
 
-static int atxp1_probe(struct i2c_client *new_client,
+static int atxp1_probe(struct i2c_client *client,
 		       const struct i2c_device_id *id)
 {
+	struct device *dev = &client->dev;
 	struct atxp1_data *data;
-	int err;
+	struct device *hwmon_dev;
 
-	data = devm_kzalloc(&new_client->dev, sizeof(struct atxp1_data),
-			    GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(struct atxp1_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
 	/* Get VRM */
 	data->vrm = vid_which_vrm();
 
-	i2c_set_clientdata(new_client, data);
+	data->client = client;
 	mutex_init(&data->update_lock);
 
-	/* Register sysfs hooks */
-	err = sysfs_create_group(&new_client->dev.kobj, &atxp1_group);
-	if (err)
-		return err;
-
-	data->hwmon_dev = hwmon_device_register(&new_client->dev);
-	if (IS_ERR(data->hwmon_dev)) {
-		err = PTR_ERR(data->hwmon_dev);
-		goto exit_remove_files;
-	}
-
-	dev_info(&new_client->dev, "Using VRM: %d.%d\n",
-			 data->vrm / 10, data->vrm % 10);
-
-	return 0;
-
-exit_remove_files:
-	sysfs_remove_group(&new_client->dev.kobj, &atxp1_group);
-	return err;
-};
-
-static int atxp1_remove(struct i2c_client *client)
-{
-	struct atxp1_data *data = i2c_get_clientdata(client);
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
+							   data,
+							   atxp1_groups);
+	if (IS_ERR(hwmon_dev))
+		return PTR_ERR(hwmon_dev);
 
-	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&client->dev.kobj, &atxp1_group);
+	dev_info(dev, "Using VRM: %d.%d\n", data->vrm / 10, data->vrm % 10);
 
 	return 0;
 };
@@ -374,7 +341,6 @@ static struct i2c_driver atxp1_driver = {
 		.name	= "atxp1",
 	},
 	.probe		= atxp1_probe,
-	.remove		= atxp1_remove,
 	.id_table	= atxp1_id,
 	.detect		= atxp1_detect,
 	.address_list	= normal_i2c,
-- 
1.8.3.2




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
