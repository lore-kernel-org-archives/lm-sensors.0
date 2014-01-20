From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 20 Jan 2014 18:47:51 +0000
Subject: [lm-sensors] [PATCH] hwmon: (lm95245) Convert to use devm_hwmon_device_register_with_groups
Message-Id: <1390243671-20086-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Simplify code, reduce code size, and attach hwmon attributes
to hwmon device.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm95245.c |   87 +++++++++++++++--------------------------------
 1 file changed, 28 insertions(+), 59 deletions(-)

diff --git a/drivers/hwmon/lm95245.c b/drivers/hwmon/lm95245.c
index a6c85f0..1fdd573 100644
--- a/drivers/hwmon/lm95245.c
+++ b/drivers/hwmon/lm95245.c
@@ -115,7 +115,7 @@ static const u8 lm95245_reg_address[] = {
 
 /* Client data (each client gets its own) */
 struct lm95245_data {
-	struct device *hwmon_dev;
+	struct i2c_client *client;
 	struct mutex update_lock;
 	unsigned long last_updated;	/* in jiffies */
 	unsigned long interval;	/* in msecs */
@@ -140,8 +140,8 @@ static int temp_from_reg_signed(u8 val_h, u8 val_l)
 
 static struct lm95245_data *lm95245_update_device(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm95245_data *data = i2c_get_clientdata(client);
+	struct lm95245_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 
 	mutex_lock(&data->update_lock);
 
@@ -249,8 +249,7 @@ static ssize_t show_limit(struct device *dev, struct device_attribute *attr,
 static ssize_t set_limit(struct device *dev, struct device_attribute *attr,
 			const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm95245_data *data = i2c_get_clientdata(client);
+	struct lm95245_data *data = dev_get_drvdata(dev);
 	int index = to_sensor_dev_attr(attr)->index;
 	unsigned long val;
 
@@ -265,7 +264,8 @@ static ssize_t set_limit(struct device *dev, struct device_attribute *attr,
 
 	data->valid = 0;
 
-	i2c_smbus_write_byte_data(client, lm95245_reg_address[index], val);
+	i2c_smbus_write_byte_data(data->client, lm95245_reg_address[index],
+				  val);
 
 	mutex_unlock(&data->update_lock);
 
@@ -275,8 +275,7 @@ static ssize_t set_limit(struct device *dev, struct device_attribute *attr,
 static ssize_t set_crit_hyst(struct device *dev, struct device_attribute *attr,
 			const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm95245_data *data = i2c_get_clientdata(client);
+	struct lm95245_data *data = dev_get_drvdata(dev);
 	unsigned long val;
 
 	if (kstrtoul(buf, 10, &val) < 0)
@@ -291,8 +290,8 @@ static ssize_t set_crit_hyst(struct device *dev, struct device_attribute *attr,
 	data->valid = 0;
 
 	/* shared crit hysteresis */
-	i2c_smbus_write_byte_data(client, LM95245_REG_RW_COMMON_HYSTERESIS,
-		val);
+	i2c_smbus_write_byte_data(data->client,
+				  LM95245_REG_RW_COMMON_HYSTERESIS, val);
 
 	mutex_unlock(&data->update_lock);
 
@@ -302,8 +301,7 @@ static ssize_t set_crit_hyst(struct device *dev, struct device_attribute *attr,
 static ssize_t show_type(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm95245_data *data = i2c_get_clientdata(client);
+	struct lm95245_data *data = dev_get_drvdata(dev);
 
 	return snprintf(buf, PAGE_SIZE - 1,
 		data->config2 & CFG2_REMOTE_TT ? "1\n" : "2\n");
@@ -312,8 +310,7 @@ static ssize_t show_type(struct device *dev, struct device_attribute *attr,
 static ssize_t set_type(struct device *dev, struct device_attribute *attr,
 			const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm95245_data *data = i2c_get_clientdata(client);
+	struct lm95245_data *data = dev_get_drvdata(dev);
 	unsigned long val;
 
 	if (kstrtoul(buf, 10, &val) < 0)
@@ -330,7 +327,7 @@ static ssize_t set_type(struct device *dev, struct device_attribute *attr,
 
 	data->valid = 0;
 
-	i2c_smbus_write_byte_data(client, LM95245_REG_RW_CONFIG2,
+	i2c_smbus_write_byte_data(data->client, LM95245_REG_RW_CONFIG2,
 				  data->config2);
 
 	mutex_unlock(&data->update_lock);
@@ -359,8 +356,7 @@ static ssize_t show_interval(struct device *dev, struct device_attribute *attr,
 static ssize_t set_interval(struct device *dev, struct device_attribute *attr,
 			    const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm95245_data *data = i2c_get_clientdata(client);
+	struct lm95245_data *data = dev_get_drvdata(dev);
 	unsigned long val;
 
 	if (kstrtoul(buf, 10, &val) < 0)
@@ -368,7 +364,7 @@ static ssize_t set_interval(struct device *dev, struct device_attribute *attr,
 
 	mutex_lock(&data->update_lock);
 
-	data->interval = lm95245_set_conversion_rate(client, val);
+	data->interval = lm95245_set_conversion_rate(data->client, val);
 
 	mutex_unlock(&data->update_lock);
 
@@ -398,7 +394,7 @@ static SENSOR_DEVICE_ATTR(temp2_fault, S_IRUGO, show_alarm, NULL,
 static DEVICE_ATTR(update_interval, S_IWUSR | S_IRUGO, show_interval,
 		set_interval);
 
-static struct attribute *lm95245_attributes[] = {
+static struct attribute *lm95245_attrs[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
 	&sensor_dev_attr_temp1_crit.dev_attr.attr,
 	&sensor_dev_attr_temp1_crit_hyst.dev_attr.attr,
@@ -412,10 +408,7 @@ static struct attribute *lm95245_attributes[] = {
 	&dev_attr_update_interval.attr,
 	NULL
 };
-
-static const struct attribute_group lm95245_group = {
-	.attrs = lm95245_attributes,
-};
+ATTRIBUTE_GROUPS(lm95245);
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
 static int lm95245_detect(struct i2c_client *new_client,
@@ -436,10 +429,9 @@ static int lm95245_detect(struct i2c_client *new_client,
 	return 0;
 }
 
-static void lm95245_init_client(struct i2c_client *client)
+static void lm95245_init_client(struct i2c_client *client,
+				struct lm95245_data *data)
 {
-	struct lm95245_data *data = i2c_get_clientdata(client);
-
 	data->valid = 0;
 	data->interval = lm95245_read_conversion_rate(client);
 
@@ -456,49 +448,27 @@ static void lm95245_init_client(struct i2c_client *client)
 	}
 }
 
-static int lm95245_probe(struct i2c_client *new_client,
+static int lm95245_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
+	struct device *dev = &client->dev;
 	struct lm95245_data *data;
-	int err;
+	struct device *hwmon_dev;
 
-	data = devm_kzalloc(&new_client->dev, sizeof(struct lm95245_data),
-			    GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(struct lm95245_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	i2c_set_clientdata(new_client, data);
+	data->client = client;
 	mutex_init(&data->update_lock);
 
 	/* Initialize the LM95245 chip */
-	lm95245_init_client(new_client);
-
-	/* Register sysfs hooks */
-	err = sysfs_create_group(&new_client->dev.kobj, &lm95245_group);
-	if (err)
-		return err;
-
-	data->hwmon_dev = hwmon_device_register(&new_client->dev);
-	if (IS_ERR(data->hwmon_dev)) {
-		err = PTR_ERR(data->hwmon_dev);
-		goto exit_remove_files;
-	}
+	lm95245_init_client(client, data);
 
-	return 0;
-
-exit_remove_files:
-	sysfs_remove_group(&new_client->dev.kobj, &lm95245_group);
-	return err;
-}
-
-static int lm95245_remove(struct i2c_client *client)
-{
-	struct lm95245_data *data = i2c_get_clientdata(client);
-
-	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&client->dev.kobj, &lm95245_group);
-
-	return 0;
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
+							   data,
+							   lm95245_groups);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
 /* Driver data (common to all clients) */
@@ -514,7 +484,6 @@ static struct i2c_driver lm95245_driver = {
 		.name	= DEVNAME,
 	},
 	.probe		= lm95245_probe,
-	.remove		= lm95245_remove,
 	.id_table	= lm95245_id,
 	.detect		= lm95245_detect,
 	.address_list	= normal_i2c,
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
