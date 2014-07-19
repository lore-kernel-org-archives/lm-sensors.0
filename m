From: Axel Lin <axel.lin@ingics.com>
Date: Sat, 19 Jul 2014 14:42:33 +0000
Subject: [lm-sensors] [RFT][PATCH] hwmon: (adt7411) Convert to devm_hwmon_device_register_with_groups
Message-Id: <1405780953.15902.6.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
simplify the code a bit.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/adt7411.c | 59 +++++++++++++++++--------------------------------
 1 file changed, 20 insertions(+), 39 deletions(-)

diff --git a/drivers/hwmon/adt7411.c b/drivers/hwmon/adt7411.c
index d9299de..827c037 100644
--- a/drivers/hwmon/adt7411.c
+++ b/drivers/hwmon/adt7411.c
@@ -51,7 +51,7 @@ struct adt7411_data {
 	struct mutex update_lock;
 	unsigned long next_update;
 	int vref_cached;
-	struct device *hwmon_dev;
+	struct i2c_client *client;
 };
 
 /*
@@ -111,7 +111,8 @@ static int adt7411_modify_bit(struct i2c_client *client, u8 reg, u8 bit,
 static ssize_t adt7411_show_vdd(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
+	struct adt7411_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int ret = adt7411_read_10_bit(client, ADT7411_REG_INT_TEMP_VDD_LSB,
 			ADT7411_REG_VDD_MSB, 2);
 
@@ -121,7 +122,8 @@ static ssize_t adt7411_show_vdd(struct device *dev,
 static ssize_t adt7411_show_temp(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
+	struct adt7411_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int val = adt7411_read_10_bit(client, ADT7411_REG_INT_TEMP_VDD_LSB,
 			ADT7411_REG_INT_TEMP_MSB, 0);
 
@@ -137,8 +139,8 @@ static ssize_t adt7411_show_input(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
 	int nr = to_sensor_dev_attr(attr)->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adt7411_data *data = i2c_get_clientdata(client);
+	struct adt7411_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int val;
 	u8 lsb_reg, lsb_shift;
 
@@ -180,7 +182,8 @@ static ssize_t adt7411_show_bit(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	struct sensor_device_attribute_2 *attr2 = to_sensor_dev_attr_2(attr);
-	struct i2c_client *client = to_i2c_client(dev);
+	struct adt7411_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int ret = i2c_smbus_read_byte_data(client, attr2->index);
 
 	return ret < 0 ? ret : sprintf(buf, "%u\n", !!(ret & attr2->nr));
@@ -191,8 +194,8 @@ static ssize_t adt7411_set_bit(struct device *dev,
 			       size_t count)
 {
 	struct sensor_device_attribute_2 *s_attr2 = to_sensor_dev_attr_2(attr);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adt7411_data *data = i2c_get_clientdata(client);
+	struct adt7411_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int ret;
 	unsigned long flag;
 
@@ -245,9 +248,7 @@ static struct attribute *adt7411_attrs[] = {
 	NULL
 };
 
-static const struct attribute_group adt7411_attr_grp = {
-	.attrs = adt7411_attrs,
-};
+ATTRIBUTE_GROUPS(adt7411);
 
 static int adt7411_detect(struct i2c_client *client,
 			  struct i2c_board_info *info)
@@ -281,14 +282,17 @@ static int adt7411_detect(struct i2c_client *client,
 static int adt7411_probe(struct i2c_client *client,
 				   const struct i2c_device_id *id)
 {
+	struct device *dev = &client->dev;
 	struct adt7411_data *data;
+	struct device *hwmon_dev;
 	int ret;
 
-	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
 	i2c_set_clientdata(client, data);
+	data->client = client;
 	mutex_init(&data->device_lock);
 	mutex_init(&data->update_lock);
 
@@ -300,32 +304,10 @@ static int adt7411_probe(struct i2c_client *client,
 	/* force update on first occasion */
 	data->next_update = jiffies;
 
-	ret = sysfs_create_group(&client->dev.kobj, &adt7411_attr_grp);
-	if (ret)
-		return ret;
-
-	data->hwmon_dev = hwmon_device_register(&client->dev);
-	if (IS_ERR(data->hwmon_dev)) {
-		ret = PTR_ERR(data->hwmon_dev);
-		goto exit_remove;
-	}
-
-	dev_info(&client->dev, "successfully registered\n");
-
-	return 0;
-
- exit_remove:
-	sysfs_remove_group(&client->dev.kobj, &adt7411_attr_grp);
-	return ret;
-}
-
-static int adt7411_remove(struct i2c_client *client)
-{
-	struct adt7411_data *data = i2c_get_clientdata(client);
-
-	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&client->dev.kobj, &adt7411_attr_grp);
-	return 0;
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
+							   data,
+							   adt7411_groups);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
 static const struct i2c_device_id adt7411_id[] = {
@@ -339,7 +321,6 @@ static struct i2c_driver adt7411_driver = {
 		.name		= "adt7411",
 	},
 	.probe  = adt7411_probe,
-	.remove	= adt7411_remove,
 	.id_table = adt7411_id,
 	.detect = adt7411_detect,
 	.address_list = normal_i2c,
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
