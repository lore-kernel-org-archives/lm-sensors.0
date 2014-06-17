From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 17 Jun 2014 07:38:23 +0000
Subject: [lm-sensors] [PATCH RFT] hwmon: (ads7828) Convert to devm_hwmon_device_register_with_groups
Message-Id: <1402990703.1589.1.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
simplify the code a bit.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/ads7828.c | 52 +++++++++++++------------------------------------
 1 file changed, 14 insertions(+), 38 deletions(-)

diff --git a/drivers/hwmon/ads7828.c b/drivers/hwmon/ads7828.c
index 7092c78..a622d40 100644
--- a/drivers/hwmon/ads7828.c
+++ b/drivers/hwmon/ads7828.c
@@ -50,7 +50,7 @@ enum ads7828_chips { ads7828, ads7830 };
 
 /* Client specific data */
 struct ads7828_data {
-	struct device *hwmon_dev;
+	struct i2c_client *client;
 	struct mutex update_lock;	/* Mutex protecting updates */
 	unsigned long last_updated;	/* Last updated time (in jiffies) */
 	u16 adc_input[ADS7828_NCH];	/* ADS7828_NCH samples */
@@ -72,8 +72,8 @@ static inline u8 ads7828_cmd_byte(u8 cmd, int ch)
 /* Update data for the device (all 8 channels) */
 static struct ads7828_data *ads7828_update_device(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct ads7828_data *data = i2c_get_clientdata(client);
+	struct ads7828_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 
 	mutex_lock(&data->update_lock);
 
@@ -116,7 +116,7 @@ static SENSOR_DEVICE_ATTR(in5_input, S_IRUGO, ads7828_show_in, NULL, 5);
 static SENSOR_DEVICE_ATTR(in6_input, S_IRUGO, ads7828_show_in, NULL, 6);
 static SENSOR_DEVICE_ATTR(in7_input, S_IRUGO, ads7828_show_in, NULL, 7);
 
-static struct attribute *ads7828_attributes[] = {
+static struct attribute *ads7828_attrs[] = {
 	&sensor_dev_attr_in0_input.dev_attr.attr,
 	&sensor_dev_attr_in1_input.dev_attr.attr,
 	&sensor_dev_attr_in2_input.dev_attr.attr,
@@ -128,29 +128,17 @@ static struct attribute *ads7828_attributes[] = {
 	NULL
 };
 
-static const struct attribute_group ads7828_group = {
-	.attrs = ads7828_attributes,
-};
-
-static int ads7828_remove(struct i2c_client *client)
-{
-	struct ads7828_data *data = i2c_get_clientdata(client);
-
-	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&client->dev.kobj, &ads7828_group);
-
-	return 0;
-}
+ATTRIBUTE_GROUPS(ads7828);
 
 static int ads7828_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
-	struct ads7828_platform_data *pdata = dev_get_platdata(&client->dev);
+	struct device *dev = &client->dev;
+	struct ads7828_platform_data *pdata = dev_get_platdata(dev);
 	struct ads7828_data *data;
-	int err;
+	struct device *hwmon_dev;
 
-	data = devm_kzalloc(&client->dev, sizeof(struct ads7828_data),
-			    GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(struct ads7828_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
@@ -182,24 +170,13 @@ static int ads7828_probe(struct i2c_client *client,
 	if (!data->diff_input)
 		data->cmd_byte |= ADS7828_CMD_SD_SE;
 
-	i2c_set_clientdata(client, data);
+	data->client = client;
 	mutex_init(&data->update_lock);
 
-	err = sysfs_create_group(&client->dev.kobj, &ads7828_group);
-	if (err)
-		return err;
-
-	data->hwmon_dev = hwmon_device_register(&client->dev);
-	if (IS_ERR(data->hwmon_dev)) {
-		err = PTR_ERR(data->hwmon_dev);
-		goto error;
-	}
-
-	return 0;
-
-error:
-	sysfs_remove_group(&client->dev.kobj, &ads7828_group);
-	return err;
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
+							   data,
+							   ads7828_groups);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
 static const struct i2c_device_id ads7828_device_ids[] = {
@@ -216,7 +193,6 @@ static struct i2c_driver ads7828_driver = {
 
 	.id_table = ads7828_device_ids,
 	.probe = ads7828_probe,
-	.remove = ads7828_remove,
 };
 
 module_i2c_driver(ads7828_driver);
-- 
1.8.3.2




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
