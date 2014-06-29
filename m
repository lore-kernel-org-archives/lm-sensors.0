From: Axel Lin <axel.lin@ingics.com>
Date: Sun, 29 Jun 2014 02:33:34 +0000
Subject: [lm-sensors] [RFT][PATCH 2/2] hwmon: (amc6821) Convert to devm_hwmon_device_register_with_groups
Message-Id: <1404009214.19191.5.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
simplify the code a bit.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/amc6821.c | 70 ++++++++++++++++++-------------------------------
 1 file changed, 25 insertions(+), 45 deletions(-)

diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
index 7b055a4..cb84fb9 100644
--- a/drivers/hwmon/amc6821.c
+++ b/drivers/hwmon/amc6821.c
@@ -152,7 +152,7 @@ static const u8 fan_reg_hi[] = {AMC6821_REG_TDATA_HI,
  */
 
 struct amc6821_data {
-	struct device *hwmon_dev;
+	struct i2c_client *client;
 	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
@@ -176,8 +176,8 @@ struct amc6821_data {
 
 static struct amc6821_data *amc6821_update_device(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct amc6821_data *data = i2c_get_clientdata(client);
+	struct amc6821_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int timeout = HZ;
 	u8 reg;
 	int i;
@@ -294,8 +294,8 @@ static ssize_t set_temp(
 		const char *buf,
 		size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct amc6821_data *data = i2c_get_clientdata(client);
+	struct amc6821_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int ix = to_sensor_dev_attr(attr)->index;
 	long val;
 
@@ -379,8 +379,8 @@ static ssize_t set_pwm1(
 		const char *buf,
 		size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct amc6821_data *data = i2c_get_clientdata(client);
+	struct amc6821_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long val;
 	int ret = kstrtol(buf, 10, &val);
 	if (ret)
@@ -408,8 +408,8 @@ static ssize_t set_pwm1_enable(
 		const char *buf,
 		size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct amc6821_data *data = i2c_get_clientdata(client);
+	struct amc6821_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long val;
 	int config = kstrtol(buf, 10, &val);
 	if (config)
@@ -516,8 +516,8 @@ static ssize_t set_temp_auto_point_temp(
 		const char *buf,
 		size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
 	struct amc6821_data *data = amc6821_update_device(dev);
+	struct i2c_client *client = data->client;
 	int ix = to_sensor_dev_attr_2(attr)->index;
 	int nr = to_sensor_dev_attr_2(attr)->nr;
 	u8 *ptemp;
@@ -588,8 +588,8 @@ static ssize_t set_pwm1_auto_point_pwm(
 		const char *buf,
 		size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct amc6821_data *data = i2c_get_clientdata(client);
+	struct amc6821_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int dpwm;
 	long val;
 	int ret = kstrtol(buf, 10, &val);
@@ -651,8 +651,8 @@ static ssize_t set_fan(
 		struct device_attribute *attr,
 		const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct amc6821_data *data = i2c_get_clientdata(client);
+	struct amc6821_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long val;
 	int ix = to_sensor_dev_attr(attr)->index;
 	int ret = kstrtol(buf, 10, &val);
@@ -692,8 +692,8 @@ static ssize_t set_fan1_div(
 		struct device_attribute *attr,
 		const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct amc6821_data *data = i2c_get_clientdata(client);
+	struct amc6821_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long val;
 	int config = kstrtol(buf, 10, &val);
 	if (config)
@@ -829,9 +829,7 @@ static struct attribute *amc6821_attrs[] = {
 	NULL
 };
 
-static struct attribute_group amc6821_attr_grp = {
-	.attrs = amc6821_attrs,
-};
+ATTRIBUTE_GROUPS(amc6821);
 
 /* Return 0 if detection is successful, -ENODEV otherwise */
 static int amc6821_detect(
@@ -968,15 +966,16 @@ static int amc6821_init_client(struct i2c_client *client)
 static int amc6821_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
+	struct device *dev = &client->dev;
 	struct amc6821_data *data;
+	struct device *hwmon_dev;
 	int err;
 
-	data = devm_kzalloc(&client->dev, sizeof(struct amc6821_data),
-			    GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(struct amc6821_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	i2c_set_clientdata(client, data);
+	data->client = client;
 	mutex_init(&data->update_lock);
 
 	/*
@@ -986,28 +985,10 @@ static int amc6821_probe(struct i2c_client *client,
 	if (err)
 		return err;
 
-	err = sysfs_create_group(&client->dev.kobj, &amc6821_attr_grp);
-	if (err)
-		return err;
-
-	data->hwmon_dev = hwmon_device_register(&client->dev);
-	if (!IS_ERR(data->hwmon_dev))
-		return 0;
-
-	err = PTR_ERR(data->hwmon_dev);
-	dev_err(&client->dev, "error registering hwmon device.\n");
-	sysfs_remove_group(&client->dev.kobj, &amc6821_attr_grp);
-	return err;
-}
-
-static int amc6821_remove(struct i2c_client *client)
-{
-	struct amc6821_data *data = i2c_get_clientdata(client);
-
-	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&client->dev.kobj, &amc6821_attr_grp);
-
-	return 0;
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
+							   data,
+							   amc6821_groups);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
 static const struct i2c_device_id amc6821_id[] = {
@@ -1023,7 +1004,6 @@ static struct i2c_driver amc6821_driver = {
 		.name	= "amc6821",
 	},
 	.probe = amc6821_probe,
-	.remove = amc6821_remove,
 	.id_table = amc6821_id,
 	.detect = amc6821_detect,
 	.address_list = normal_i2c,
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
