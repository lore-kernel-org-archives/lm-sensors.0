From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 18 Feb 2014 01:29:29 +0000
Subject: [lm-sensors] [PATCH] hwmon: (ltc4215) Convert to devm_hwmon_device_register_with_groups
Message-Id: <1392686969-26703-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Simplify code, reduce code size, and attach sysfs attributes to hwmon device.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/ltc4215.c |   51 ++++++++++++-----------------------------------
 1 file changed, 13 insertions(+), 38 deletions(-)

diff --git a/drivers/hwmon/ltc4215.c b/drivers/hwmon/ltc4215.c
index 8a14296..c8a9bd9 100644
--- a/drivers/hwmon/ltc4215.c
+++ b/drivers/hwmon/ltc4215.c
@@ -33,7 +33,7 @@ enum ltc4215_cmd {
 };
 
 struct ltc4215_data {
-	struct device *hwmon_dev;
+	struct i2c_client *client;
 
 	struct mutex update_lock;
 	bool valid;
@@ -45,8 +45,8 @@ struct ltc4215_data {
 
 static struct ltc4215_data *ltc4215_update_device(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct ltc4215_data *data = i2c_get_clientdata(client);
+	struct ltc4215_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	s32 val;
 	int i;
 
@@ -214,7 +214,7 @@ static SENSOR_DEVICE_ATTR(in2_min_alarm, S_IRUGO, ltc4215_show_alarm, NULL,
  * Finally, construct an array of pointers to members of the above objects,
  * as required for sysfs_create_group()
  */
-static struct attribute *ltc4215_attributes[] = {
+static struct attribute *ltc4215_attrs[] = {
 	&sensor_dev_attr_curr1_input.dev_attr.attr,
 	&sensor_dev_attr_curr1_max_alarm.dev_attr.attr,
 
@@ -229,57 +229,33 @@ static struct attribute *ltc4215_attributes[] = {
 
 	NULL,
 };
-
-static const struct attribute_group ltc4215_group = {
-	.attrs = ltc4215_attributes,
-};
+ATTRIBUTE_GROUPS(ltc4215);
 
 static int ltc4215_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
 	struct i2c_adapter *adapter = client->adapter;
+	struct device *dev = &client->dev;
 	struct ltc4215_data *data;
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
 
 	/* Initialize the LTC4215 chip */
 	i2c_smbus_write_byte_data(client, LTC4215_FAULT, 0x00);
 
-	/* Register sysfs hooks */
-	ret = sysfs_create_group(&client->dev.kobj, &ltc4215_group);
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
-	sysfs_remove_group(&client->dev.kobj, &ltc4215_group);
-	return ret;
-}
-
-static int ltc4215_remove(struct i2c_client *client)
-{
-	struct ltc4215_data *data = i2c_get_clientdata(client);
-
-	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&client->dev.kobj, &ltc4215_group);
-
-	return 0;
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
+							   data,
+							   ltc4215_groups);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
 static const struct i2c_device_id ltc4215_id[] = {
@@ -294,7 +270,6 @@ static struct i2c_driver ltc4215_driver = {
 		.name	= "ltc4215",
 	},
 	.probe		= ltc4215_probe,
-	.remove		= ltc4215_remove,
 	.id_table	= ltc4215_id,
 };
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
