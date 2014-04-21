From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 21 Apr 2014 23:46:56 +0000
Subject: [lm-sensors] [PATCH] hwmon: (lm75) Convert to use hwmon_device_register_with_groups
Message-Id: <1398124016-30079-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Simplify code and attach hwmon attributes to hwmon device.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm75.c |   51 ++++++++++++++++++++------------------------------
 1 file changed, 20 insertions(+), 31 deletions(-)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index 84a55ea..479ffbe 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -72,6 +72,7 @@ static const u8 LM75_REG_TEMP[3] = {
 
 /* Each client has this additional data */
 struct lm75_data {
+	struct i2c_client	*client;
 	struct device		*hwmon_dev;
 	struct thermal_zone_device	*tz;
 	struct mutex		update_lock;
@@ -130,8 +131,8 @@ static ssize_t set_temp(struct device *dev, struct device_attribute *da,
 			const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm75_data *data = i2c_get_clientdata(client);
+	struct lm75_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int nr = attr->index;
 	long temp;
 	int error;
@@ -165,17 +166,14 @@ static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IWUSR | S_IRUGO,
 			show_temp, set_temp, 2);
 static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);
 
-static struct attribute *lm75_attributes[] = {
+static struct attribute *lm75_attrs[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
 	&sensor_dev_attr_temp1_max.dev_attr.attr,
 	&sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
 
 	NULL
 };
-
-static const struct attribute_group lm75_group = {
-	.attrs = lm75_attributes,
-};
+ATTRIBUTE_GROUPS(lm75);
 
 /*-----------------------------------------------------------------------*/
 
@@ -184,6 +182,7 @@ static const struct attribute_group lm75_group = {
 static int
 lm75_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
+	struct device *dev = &client->dev;
 	struct lm75_data *data;
 	int status;
 	u8 set_mask, clr_mask;
@@ -194,10 +193,11 @@ lm75_probe(struct i2c_client *client, const struct i2c_device_id *id)
 			I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA))
 		return -EIO;
 
-	data = devm_kzalloc(&client->dev, sizeof(struct lm75_data), GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(struct lm75_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
+	data->client = client;
 	i2c_set_clientdata(client, data);
 	mutex_init(&data->update_lock);
 
@@ -269,7 +269,7 @@ lm75_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	/* configure as specified */
 	status = lm75_read_value(client, LM75_REG_CONF);
 	if (status < 0) {
-		dev_dbg(&client->dev, "Can't read config? %d\n", status);
+		dev_dbg(dev, "Can't read config? %d\n", status);
 		return status;
 	}
 	data->orig_conf = status;
@@ -277,43 +277,32 @@ lm75_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	new |= set_mask;
 	if (status != new)
 		lm75_write_value(client, LM75_REG_CONF, new);
-	dev_dbg(&client->dev, "Config %02x\n", new);
+	dev_dbg(dev, "Config %02x\n", new);
 
-	/* Register sysfs hooks */
-	status = sysfs_create_group(&client->dev.kobj, &lm75_group);
-	if (status)
-		return status;
+	data->hwmon_dev = hwmon_device_register_with_groups(dev, client->name,
+							    data, lm75_groups);
+	if (IS_ERR(data->hwmon_dev))
+		return PTR_ERR(data->hwmon_dev);
 
-	data->hwmon_dev = hwmon_device_register(&client->dev);
-	if (IS_ERR(data->hwmon_dev)) {
-		status = PTR_ERR(data->hwmon_dev);
-		goto exit_remove;
-	}
-
-	data->tz = thermal_zone_of_sensor_register(&client->dev,
+	data->tz = thermal_zone_of_sensor_register(data->hwmon_dev,
 						   0,
-						   &client->dev,
+						   data->hwmon_dev,
 						   lm75_read_temp, NULL);
 	if (IS_ERR(data->tz))
 		data->tz = NULL;
 
-	dev_info(&client->dev, "%s: sensor '%s'\n",
+	dev_info(dev, "%s: sensor '%s'\n",
 		 dev_name(data->hwmon_dev), client->name);
 
 	return 0;
-
-exit_remove:
-	sysfs_remove_group(&client->dev.kobj, &lm75_group);
-	return status;
 }
 
 static int lm75_remove(struct i2c_client *client)
 {
 	struct lm75_data *data = i2c_get_clientdata(client);
 
-	thermal_zone_of_sensor_unregister(&client->dev, data->tz);
+	thermal_zone_of_sensor_unregister(data->hwmon_dev, data->tz);
 	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&client->dev.kobj, &lm75_group);
 	lm75_write_value(client, LM75_REG_CONF, data->orig_conf);
 	return 0;
 }
@@ -507,8 +496,8 @@ static int lm75_write_value(struct i2c_client *client, u8 reg, u16 value)
 
 static struct lm75_data *lm75_update_device(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm75_data *data = i2c_get_clientdata(client);
+	struct lm75_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	struct lm75_data *ret = data;
 
 	mutex_lock(&data->update_lock);
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
