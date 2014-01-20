From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 20 Jan 2014 18:53:19 +0000
Subject: [lm-sensors] [PATCH] hwmon: (lm95241) Convert to use devm_hwmon_device_register_with_groups
Message-Id: <1390243999-20286-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Simplify code, reduce code size, and attach hwmon attributes
to hwmon device.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm95241.c |   89 +++++++++++++++--------------------------------
 1 file changed, 29 insertions(+), 60 deletions(-)

diff --git a/drivers/hwmon/lm95241.c b/drivers/hwmon/lm95241.c
index 4b68fb2..7060b40 100644
--- a/drivers/hwmon/lm95241.c
+++ b/drivers/hwmon/lm95241.c
@@ -89,7 +89,7 @@ static const u8 lm95241_reg_address[] = {
 
 /* Client data (each client gets its own) */
 struct lm95241_data {
-	struct device *hwmon_dev;
+	struct i2c_client *client;
 	struct mutex update_lock;
 	unsigned long last_updated, interval;	/* in jiffies */
 	char valid;		/* zero until following fields are valid */
@@ -113,8 +113,8 @@ static int temp_from_reg_unsigned(u8 val_h, u8 val_l)
 
 static struct lm95241_data *lm95241_update_device(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm95241_data *data = i2c_get_clientdata(client);
+	struct lm95241_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 
 	mutex_lock(&data->update_lock);
 
@@ -153,8 +153,7 @@ static ssize_t show_input(struct device *dev, struct device_attribute *attr,
 static ssize_t show_type(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm95241_data *data = i2c_get_clientdata(client);
+	struct lm95241_data *data = dev_get_drvdata(dev);
 
 	return snprintf(buf, PAGE_SIZE - 1,
 		data->model & to_sensor_dev_attr(attr)->index ? "1\n" : "2\n");
@@ -163,8 +162,8 @@ static ssize_t show_type(struct device *dev, struct device_attribute *attr,
 static ssize_t set_type(struct device *dev, struct device_attribute *attr,
 			const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm95241_data *data = i2c_get_clientdata(client);
+	struct lm95241_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	unsigned long val;
 	int shift;
 	u8 mask = to_sensor_dev_attr(attr)->index;
@@ -201,8 +200,7 @@ static ssize_t set_type(struct device *dev, struct device_attribute *attr,
 static ssize_t show_min(struct device *dev, struct device_attribute *attr,
 			char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm95241_data *data = i2c_get_clientdata(client);
+	struct lm95241_data *data = dev_get_drvdata(dev);
 
 	return snprintf(buf, PAGE_SIZE - 1,
 			data->config & to_sensor_dev_attr(attr)->index ?
@@ -212,8 +210,7 @@ static ssize_t show_min(struct device *dev, struct device_attribute *attr,
 static ssize_t set_min(struct device *dev, struct device_attribute *attr,
 		       const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm95241_data *data = i2c_get_clientdata(client);
+	struct lm95241_data *data = dev_get_drvdata(dev);
 	long val;
 
 	if (kstrtol(buf, 10, &val) < 0)
@@ -229,7 +226,8 @@ static ssize_t set_min(struct device *dev, struct device_attribute *attr,
 		data->config &= ~to_sensor_dev_attr(attr)->index;
 	data->valid = 0;
 
-	i2c_smbus_write_byte_data(client, LM95241_REG_RW_CONFIG, data->config);
+	i2c_smbus_write_byte_data(data->client, LM95241_REG_RW_CONFIG,
+				  data->config);
 
 	mutex_unlock(&data->update_lock);
 
@@ -239,8 +237,7 @@ static ssize_t set_min(struct device *dev, struct device_attribute *attr,
 static ssize_t show_max(struct device *dev, struct device_attribute *attr,
 			char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm95241_data *data = i2c_get_clientdata(client);
+	struct lm95241_data *data = dev_get_drvdata(dev);
 
 	return snprintf(buf, PAGE_SIZE - 1,
 			data->config & to_sensor_dev_attr(attr)->index ?
@@ -250,8 +247,7 @@ static ssize_t show_max(struct device *dev, struct device_attribute *attr,
 static ssize_t set_max(struct device *dev, struct device_attribute *attr,
 		       const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm95241_data *data = i2c_get_clientdata(client);
+	struct lm95241_data *data = dev_get_drvdata(dev);
 	long val;
 
 	if (kstrtol(buf, 10, &val) < 0)
@@ -267,7 +263,8 @@ static ssize_t set_max(struct device *dev, struct device_attribute *attr,
 		data->config &= ~to_sensor_dev_attr(attr)->index;
 	data->valid = 0;
 
-	i2c_smbus_write_byte_data(client, LM95241_REG_RW_CONFIG, data->config);
+	i2c_smbus_write_byte_data(data->client, LM95241_REG_RW_CONFIG,
+				  data->config);
 
 	mutex_unlock(&data->update_lock);
 
@@ -286,8 +283,7 @@ static ssize_t show_interval(struct device *dev, struct device_attribute *attr,
 static ssize_t set_interval(struct device *dev, struct device_attribute *attr,
 			    const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm95241_data *data = i2c_get_clientdata(client);
+	struct lm95241_data *data = dev_get_drvdata(dev);
 	unsigned long val;
 
 	if (kstrtoul(buf, 10, &val) < 0)
@@ -316,7 +312,7 @@ static SENSOR_DEVICE_ATTR(temp3_max, S_IWUSR | S_IRUGO, show_max, set_max,
 static DEVICE_ATTR(update_interval, S_IWUSR | S_IRUGO, show_interval,
 		   set_interval);
 
-static struct attribute *lm95241_attributes[] = {
+static struct attribute *lm95241_attrs[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
 	&sensor_dev_attr_temp2_input.dev_attr.attr,
 	&sensor_dev_attr_temp3_input.dev_attr.attr,
@@ -329,10 +325,7 @@ static struct attribute *lm95241_attributes[] = {
 	&dev_attr_update_interval.attr,
 	NULL
 };
-
-static const struct attribute_group lm95241_group = {
-	.attrs = lm95241_attributes,
-};
+ATTRIBUTE_GROUPS(lm95241);
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
 static int lm95241_detect(struct i2c_client *new_client,
@@ -366,10 +359,9 @@ static int lm95241_detect(struct i2c_client *new_client,
 	return 0;
 }
 
-static void lm95241_init_client(struct i2c_client *client)
+static void lm95241_init_client(struct i2c_client *client,
+				struct lm95241_data *data)
 {
-	struct lm95241_data *data = i2c_get_clientdata(client);
-
 	data->interval = HZ;	/* 1 sec default */
 	data->valid = 0;
 	data->config = CFG_CR0076;
@@ -385,49 +377,27 @@ static void lm95241_init_client(struct i2c_client *client)
 				  data->model);
 }
 
-static int lm95241_probe(struct i2c_client *new_client,
+static int lm95241_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
+	struct device *dev = &client->dev;
 	struct lm95241_data *data;
-	int err;
+	struct device *hwmon_dev;
 
-	data = devm_kzalloc(&new_client->dev, sizeof(struct lm95241_data),
-			    GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(struct lm95241_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	i2c_set_clientdata(new_client, data);
+	data->client = client;
 	mutex_init(&data->update_lock);
 
 	/* Initialize the LM95241 chip */
-	lm95241_init_client(new_client);
-
-	/* Register sysfs hooks */
-	err = sysfs_create_group(&new_client->dev.kobj, &lm95241_group);
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
-	sysfs_remove_group(&new_client->dev.kobj, &lm95241_group);
-	return err;
-}
+	lm95241_init_client(client, data);
 
-static int lm95241_remove(struct i2c_client *client)
-{
-	struct lm95241_data *data = i2c_get_clientdata(client);
-
-	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&client->dev.kobj, &lm95241_group);
-
-	return 0;
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
+							   data,
+							   lm95241_groups);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
 /* Driver data (common to all clients) */
@@ -444,7 +414,6 @@ static struct i2c_driver lm95241_driver = {
 		.name	= DEVNAME,
 	},
 	.probe		= lm95241_probe,
-	.remove		= lm95241_remove,
 	.id_table	= lm95241_id,
 	.detect		= lm95241_detect,
 	.address_list	= normal_i2c,
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
