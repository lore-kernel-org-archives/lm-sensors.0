From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 16 Feb 2014 01:26:35 +0000
Subject: [lm-sensors] [PATCH 3/3] hwmon: (lm90) Convert to use hwmon_device_register_with_groups
Message-Id: <1392513995-30712-3-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Simplify code, reduce code size, and attach hwmon attributes to hwmon device.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm90.c |   51 ++++++++++++++++++++++++--------------------------
 1 file changed, 24 insertions(+), 27 deletions(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 5ddfab0..9abc915 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -365,6 +365,7 @@ enum lm90_temp11_reg_index {
  */
 
 struct lm90_data {
+	struct i2c_client *client;
 	struct device *hwmon_dev;
 	const struct attribute_group *groups[7];
 	struct mutex update_lock;
@@ -514,8 +515,8 @@ static void lm90_set_convrate(struct i2c_client *client, struct lm90_data *data,
 
 static struct lm90_data *lm90_update_device(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm90_data *data = i2c_get_clientdata(client);
+	struct lm90_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	unsigned long next_update;
 
 	mutex_lock(&data->update_lock);
@@ -794,8 +795,8 @@ static ssize_t set_temp8(struct device *dev, struct device_attribute *devattr,
 	};
 
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm90_data *data = i2c_get_clientdata(client);
+	struct lm90_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int nr = attr->index;
 	long val;
 	int err;
@@ -861,8 +862,8 @@ static ssize_t set_temp11(struct device *dev, struct device_attribute *devattr,
 	};
 
 	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm90_data *data = i2c_get_clientdata(client);
+	struct lm90_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int nr = attr->nr;
 	int index = attr->index;
 	long val;
@@ -923,8 +924,8 @@ static ssize_t show_temphyst(struct device *dev,
 static ssize_t set_temphyst(struct device *dev, struct device_attribute *dummy,
 			    const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm90_data *data = i2c_get_clientdata(client);
+	struct lm90_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long val;
 	int err;
 	int temp;
@@ -977,8 +978,8 @@ static ssize_t set_update_interval(struct device *dev,
 				   struct device_attribute *attr,
 				   const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct lm90_data *data = i2c_get_clientdata(client);
+	struct lm90_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	unsigned long val;
 	int err;
 
@@ -1153,14 +1154,17 @@ static const struct attribute_group lm90_temp3_group = {
 static ssize_t show_pec(struct device *dev, struct device_attribute *dummy,
 			char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
+	struct lm90_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
+
 	return sprintf(buf, "%d\n", !!(client->flags & I2C_CLIENT_PEC));
 }
 
 static ssize_t set_pec(struct device *dev, struct device_attribute *dummy,
 		       const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
+	struct lm90_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long val;
 	int err;
 
@@ -1421,10 +1425,9 @@ static void lm90_restore_conf(struct i2c_client *client, struct lm90_data *data)
 				  data->config_orig);
 }
 
-static void lm90_init_client(struct i2c_client *client)
+static void lm90_init_client(struct lm90_data *data, struct i2c_client *client)
 {
 	u8 config, convrate;
-	struct lm90_data *data = i2c_get_clientdata(client);
 
 	if (lm90_read_reg(client, LM90_REG_R_CONVRATE, &convrate) < 0) {
 		dev_warn(&client->dev, "Failed to read convrate register!\n");
@@ -1531,15 +1534,15 @@ static int lm90_probe(struct i2c_client *client,
 
 	err = regulator_enable(regulator);
 	if (err < 0) {
-		dev_err(&client->dev,
-			"Failed to enable regulator: %d\n", err);
+		dev_err(dev, "Failed to enable regulator: %d\n", err);
 		return err;
 	}
 
-	data = devm_kzalloc(&client->dev, sizeof(struct lm90_data), GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(struct lm90_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
+	data->client = client;
 	i2c_set_clientdata(client, data);
 	mutex_init(&data->update_lock);
 
@@ -1566,7 +1569,7 @@ static int lm90_probe(struct i2c_client *client,
 	data->max_convrate = lm90_params[data->kind].max_convrate;
 
 	/* Initialize the LM90 chip */
-	lm90_init_client(client);
+	lm90_init_client(data, client);
 
 	/* Register sysfs hooks */
 	data->groups[groups++] = &lm90_group;
@@ -1586,14 +1589,11 @@ static int lm90_probe(struct i2c_client *client,
 	if (data->flags & LM90_HAVE_TEMP3)
 		data->groups[groups++] = &lm90_temp3_group;
 
-	err = sysfs_create_groups(&client->dev.kobj, data->groups);
-	if (err)
-		goto exit_restore;
-
-	data->hwmon_dev = hwmon_device_register(dev);
+	data->hwmon_dev = hwmon_device_register_with_groups(dev, client->name,
+							    data, data->groups);
 	if (IS_ERR(data->hwmon_dev)) {
 		err = PTR_ERR(data->hwmon_dev);
-		goto exit_remove_files;
+		goto exit_restore;
 	}
 
 	if (client->irq) {
@@ -1612,8 +1612,6 @@ static int lm90_probe(struct i2c_client *client,
 
 exit_unregister:
 	hwmon_device_unregister(data->hwmon_dev);
-exit_remove_files:
-	sysfs_remove_groups(&client->dev.kobj, data->groups);
 exit_restore:
 	lm90_restore_conf(client, data);
 	regulator_disable(data->regulator);
@@ -1626,7 +1624,6 @@ static int lm90_remove(struct i2c_client *client)
 	struct lm90_data *data = i2c_get_clientdata(client);
 
 	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_groups(&client->dev.kobj, data->groups);
 	lm90_restore_conf(client, data);
 	regulator_disable(data->regulator);
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
