From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 01 Jul 2014 02:57:38 +0000
Subject: [lm-sensors] [RFT][PATCH 2/2] hwmon: (g760a) Convert to devm_hwmon_device_register_with_groups
Message-Id: <1404183458.17083.3.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
simplify the code a bit.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/g760a.c | 53 +++++++++++++--------------------------------------
 1 file changed, 13 insertions(+), 40 deletions(-)

diff --git a/drivers/hwmon/g760a.c b/drivers/hwmon/g760a.c
index 8460f80..ec6a77d 100644
--- a/drivers/hwmon/g760a.c
+++ b/drivers/hwmon/g760a.c
@@ -38,7 +38,6 @@ enum g760a_regs {
 
 struct g760a_data {
 	struct i2c_client *client;
-	struct device *hwmon_dev;
 	struct mutex update_lock;
 
 	/* board specific parameters */
@@ -86,8 +85,8 @@ static int g760a_write_value(struct i2c_client *client, enum g760a_regs reg,
 
 static struct g760a_data *g760a_update_client(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct g760a_data *data = i2c_get_clientdata(client);
+	struct g760a_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 
 	mutex_lock(&data->update_lock);
 
@@ -143,8 +142,8 @@ static ssize_t get_pwm(struct device *dev, struct device_attribute *da,
 static ssize_t set_pwm(struct device *dev, struct device_attribute *da,
 		       const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
 	struct g760a_data *data = g760a_update_client(dev);
+	struct i2c_client *client = data->client;
 	unsigned long val;
 
 	if (kstrtoul(buf, 10, &val))
@@ -162,16 +161,14 @@ static DEVICE_ATTR(pwm1, S_IWUSR | S_IRUGO, get_pwm, set_pwm);
 static DEVICE_ATTR(fan1_input, S_IRUGO, show_fan, NULL);
 static DEVICE_ATTR(fan1_alarm, S_IRUGO, show_fan_alarm, NULL);
 
-static struct attribute *g760a_attributes[] = {
+static struct attribute *g760a_attrs[] = {
 	&dev_attr_pwm1.attr,
 	&dev_attr_fan1_input.attr,
 	&dev_attr_fan1_alarm.attr,
 	NULL
 };
 
-static const struct attribute_group g760a_group = {
-	.attrs = g760a_attributes,
-};
+ATTRIBUTE_GROUPS(g760a);
 
 /*
  * new-style driver model code
@@ -180,20 +177,17 @@ static const struct attribute_group g760a_group = {
 static int g760a_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
+	struct device *dev = &client->dev;
 	struct g760a_data *data;
-	int err;
+	struct device *hwmon_dev;
 
-	if (!i2c_check_functionality(client->adapter,
-				     I2C_FUNC_SMBUS_BYTE_DATA))
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -EIO;
 
-	data = devm_kzalloc(&client->dev, sizeof(struct g760a_data),
-			    GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(struct g760a_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	i2c_set_clientdata(client, data);
-
 	data->client = client;
 	mutex_init(&data->update_lock);
 
@@ -201,30 +195,10 @@ static int g760a_probe(struct i2c_client *client,
 	data->fan_div = G760A_DEFAULT_FAN_DIV;
 	data->clk = G760A_DEFAULT_CLK;
 
-	/* Register sysfs hooks */
-	err = sysfs_create_group(&client->dev.kobj, &g760a_group);
-	if (err)
-		return err;
-
-	data->hwmon_dev = hwmon_device_register(&client->dev);
-	if (IS_ERR(data->hwmon_dev)) {
-		err = PTR_ERR(data->hwmon_dev);
-		goto error_hwmon_device_register;
-	}
-
-	return 0;
-
-error_hwmon_device_register:
-	sysfs_remove_group(&client->dev.kobj, &g760a_group);
-	return err;
-}
-
-static int g760a_remove(struct i2c_client *client)
-{
-	struct g760a_data *data = i2c_get_clientdata(client);
-	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&client->dev.kobj, &g760a_group);
-	return 0;
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
+							   data,
+							   g760a_groups);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
 static const struct i2c_device_id g760a_id[] = {
@@ -238,7 +212,6 @@ static struct i2c_driver g760a_driver = {
 		.name	= "g760a",
 	},
 	.probe	  = g760a_probe,
-	.remove	  = g760a_remove,
 	.id_table = g760a_id,
 };
 
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
