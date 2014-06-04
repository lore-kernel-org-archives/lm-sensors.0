From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 04 Jun 2014 23:47:12 +0000
Subject: [lm-sensors] [RFT][PATCH] hwmon: (ltc4151) Convert to devm_hwmon_device_register_with_groups
Message-Id: <1401925632.5828.1.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups to
simplify the code a bit.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
Hi,
I don't have the h/w to test, I'd appreciate if someone can review and test this
patch.
Thanks,
Axel
 drivers/hwmon/ltc4151.c | 51 +++++++++++++------------------------------------
 1 file changed, 13 insertions(+), 38 deletions(-)

diff --git a/drivers/hwmon/ltc4151.c b/drivers/hwmon/ltc4151.c
index af81be1..c86a184 100644
--- a/drivers/hwmon/ltc4151.c
+++ b/drivers/hwmon/ltc4151.c
@@ -47,7 +47,7 @@
 #define LTC4151_ADIN_L	0x05
 
 struct ltc4151_data {
-	struct device *hwmon_dev;
+	struct i2c_client *client;
 
 	struct mutex update_lock;
 	bool valid;
@@ -59,8 +59,8 @@ struct ltc4151_data {
 
 static struct ltc4151_data *ltc4151_update_device(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct ltc4151_data *data = i2c_get_clientdata(client);
+	struct ltc4151_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	struct ltc4151_data *ret = data;
 
 	mutex_lock(&data->update_lock);
@@ -159,7 +159,7 @@ static SENSOR_DEVICE_ATTR(curr1_input, S_IRUGO, ltc4151_show_value, NULL,
  * Finally, construct an array of pointers to members of the above objects,
  * as required for sysfs_create_group()
  */
-static struct attribute *ltc4151_attributes[] = {
+static struct attribute *ltc4151_attrs[] = {
 	&sensor_dev_attr_in1_input.dev_attr.attr,
 	&sensor_dev_attr_in2_input.dev_attr.attr,
 
@@ -167,54 +167,30 @@ static struct attribute *ltc4151_attributes[] = {
 
 	NULL,
 };
-
-static const struct attribute_group ltc4151_group = {
-	.attrs = ltc4151_attributes,
-};
+ATTRIBUTE_GROUPS(ltc4151);
 
 static int ltc4151_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
 	struct i2c_adapter *adapter = client->adapter;
+	struct device *dev = &client->dev;
 	struct ltc4151_data *data;
-	int ret;
+	struct device *hwmon_dev;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -ENODEV;
 
-	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	i2c_set_clientdata(client, data);
+	data->client = client;
 	mutex_init(&data->update_lock);
 
-	/* Register sysfs hooks */
-	ret = sysfs_create_group(&client->dev.kobj, &ltc4151_group);
-	if (ret)
-		return ret;
-
-	data->hwmon_dev = hwmon_device_register(&client->dev);
-	if (IS_ERR(data->hwmon_dev)) {
-		ret = PTR_ERR(data->hwmon_dev);
-		goto out_hwmon_device_register;
-	}
-
-	return 0;
-
-out_hwmon_device_register:
-	sysfs_remove_group(&client->dev.kobj, &ltc4151_group);
-	return ret;
-}
-
-static int ltc4151_remove(struct i2c_client *client)
-{
-	struct ltc4151_data *data = i2c_get_clientdata(client);
-
-	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&client->dev.kobj, &ltc4151_group);
-
-	return 0;
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
+							   data,
+							   ltc4151_groups);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
 static const struct i2c_device_id ltc4151_id[] = {
@@ -229,7 +205,6 @@ static struct i2c_driver ltc4151_driver = {
 		.name	= "ltc4151",
 	},
 	.probe		= ltc4151_probe,
-	.remove		= ltc4151_remove,
 	.id_table	= ltc4151_id,
 };
 
-- 
1.8.3.2




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
