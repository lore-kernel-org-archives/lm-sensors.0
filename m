From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 03 Jul 2014 13:57:44 +0000
Subject: [lm-sensors] [RFT][PATCH 2/2] hwmon: (adm1031) Convert to devm_hwmon_device_register_with_groups
Message-Id: <1404395864.4895.11.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
simplify the code a bit.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/adm1031.c | 101 ++++++++++++++++++------------------------------
 1 file changed, 38 insertions(+), 63 deletions(-)

diff --git a/drivers/hwmon/adm1031.c b/drivers/hwmon/adm1031.c
index 80c07c9..65ed9d6 100644
--- a/drivers/hwmon/adm1031.c
+++ b/drivers/hwmon/adm1031.c
@@ -74,7 +74,8 @@ typedef u8 auto_chan_table_t[8][2];
 
 /* Each client has this additional data */
 struct adm1031_data {
-	struct device *hwmon_dev;
+	struct i2c_client *client;
+	const struct attribute_group *groups[3];
 	struct mutex update_lock;
 	int chip_type;
 	char valid;		/* !=0 if following fields are valid */
@@ -118,8 +119,8 @@ adm1031_write_value(struct i2c_client *client, u8 reg, unsigned int value)
 
 static struct adm1031_data *adm1031_update_device(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm1031_data *data = i2c_get_clientdata(client);
+	struct adm1031_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	unsigned long next_update;
 	int chan;
 
@@ -342,8 +343,8 @@ static ssize_t
 set_fan_auto_channel(struct device *dev, struct device_attribute *attr,
 		     const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm1031_data *data = i2c_get_clientdata(client);
+	struct adm1031_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int nr = to_sensor_dev_attr(attr)->index;
 	long val;
 	u8 reg;
@@ -417,8 +418,8 @@ static ssize_t
 set_auto_temp_min(struct device *dev, struct device_attribute *attr,
 		  const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm1031_data *data = i2c_get_clientdata(client);
+	struct adm1031_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int nr = to_sensor_dev_attr(attr)->index;
 	long val;
 	int ret;
@@ -446,8 +447,8 @@ static ssize_t
 set_auto_temp_max(struct device *dev, struct device_attribute *attr,
 		  const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm1031_data *data = i2c_get_clientdata(client);
+	struct adm1031_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int nr = to_sensor_dev_attr(attr)->index;
 	long val;
 	int ret;
@@ -488,8 +489,8 @@ static ssize_t show_pwm(struct device *dev,
 static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
 		       const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm1031_data *data = i2c_get_clientdata(client);
+	struct adm1031_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int nr = to_sensor_dev_attr(attr)->index;
 	long val;
 	int ret, reg;
@@ -601,8 +602,8 @@ static ssize_t show_fan_min(struct device *dev,
 static ssize_t set_fan_min(struct device *dev, struct device_attribute *attr,
 			   const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm1031_data *data = i2c_get_clientdata(client);
+	struct adm1031_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int nr = to_sensor_dev_attr(attr)->index;
 	long val;
 	int ret;
@@ -625,8 +626,8 @@ static ssize_t set_fan_min(struct device *dev, struct device_attribute *attr,
 static ssize_t set_fan_div(struct device *dev, struct device_attribute *attr,
 			   const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm1031_data *data = i2c_get_clientdata(client);
+	struct adm1031_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int nr = to_sensor_dev_attr(attr)->index;
 	long val;
 	u8 tmp;
@@ -727,8 +728,8 @@ static ssize_t set_temp_offset(struct device *dev,
 			       struct device_attribute *attr, const char *buf,
 			       size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm1031_data *data = i2c_get_clientdata(client);
+	struct adm1031_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int nr = to_sensor_dev_attr(attr)->index;
 	long val;
 	int ret;
@@ -748,8 +749,8 @@ static ssize_t set_temp_offset(struct device *dev,
 static ssize_t set_temp_min(struct device *dev, struct device_attribute *attr,
 			    const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm1031_data *data = i2c_get_clientdata(client);
+	struct adm1031_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int nr = to_sensor_dev_attr(attr)->index;
 	long val;
 	int ret;
@@ -769,8 +770,8 @@ static ssize_t set_temp_min(struct device *dev, struct device_attribute *attr,
 static ssize_t set_temp_max(struct device *dev, struct device_attribute *attr,
 			    const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm1031_data *data = i2c_get_clientdata(client);
+	struct adm1031_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int nr = to_sensor_dev_attr(attr)->index;
 	long val;
 	int ret;
@@ -790,8 +791,8 @@ static ssize_t set_temp_max(struct device *dev, struct device_attribute *attr,
 static ssize_t set_temp_crit(struct device *dev, struct device_attribute *attr,
 			     const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm1031_data *data = i2c_get_clientdata(client);
+	struct adm1031_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int nr = to_sensor_dev_attr(attr)->index;
 	long val;
 	int ret;
@@ -867,8 +868,7 @@ static const unsigned int update_intervals[] = {
 static ssize_t show_update_interval(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm1031_data *data = i2c_get_clientdata(client);
+	struct adm1031_data *data = dev_get_drvdata(dev);
 
 	return sprintf(buf, "%u\n", data->update_interval);
 }
@@ -877,8 +877,8 @@ static ssize_t set_update_interval(struct device *dev,
 				   struct device_attribute *attr,
 				   const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm1031_data *data = i2c_get_clientdata(client);
+	struct adm1031_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	unsigned long val;
 	int i, err;
 	u8 reg;
@@ -1044,15 +1044,16 @@ static void adm1031_init_client(struct i2c_client *client)
 static int adm1031_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
+	struct device *dev = &client->dev;
+	struct device *hwmon_dev;
 	struct adm1031_data *data;
-	int err;
 
-	data = devm_kzalloc(&client->dev, sizeof(struct adm1031_data),
-			    GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(struct adm1031_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
 	i2c_set_clientdata(client, data);
+	data->client = client;
 	data->chip_type = id->driver_data;
 	mutex_init(&data->update_lock);
 
@@ -1064,39 +1065,14 @@ static int adm1031_probe(struct i2c_client *client,
 	/* Initialize the ADM1031 chip */
 	adm1031_init_client(client);
 
-	/* Register sysfs hooks */
-	err = sysfs_create_group(&client->dev.kobj, &adm1031_group);
-	if (err)
-		return err;
-
-	if (data->chip_type = adm1031) {
-		err = sysfs_create_group(&client->dev.kobj, &adm1031_group_opt);
-		if (err)
-			goto exit_remove;
-	}
-
-	data->hwmon_dev = hwmon_device_register(&client->dev);
-	if (IS_ERR(data->hwmon_dev)) {
-		err = PTR_ERR(data->hwmon_dev);
-		goto exit_remove;
-	}
+	/* sysfs hooks */
+	data->groups[0] = &adm1031_group;
+	if (data->chip_type = adm1031)
+		data->groups[1] = &adm1031_group_opt;
 
-	return 0;
-
-exit_remove:
-	sysfs_remove_group(&client->dev.kobj, &adm1031_group);
-	sysfs_remove_group(&client->dev.kobj, &adm1031_group_opt);
-	return err;
-}
-
-static int adm1031_remove(struct i2c_client *client)
-{
-	struct adm1031_data *data = i2c_get_clientdata(client);
-
-	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&client->dev.kobj, &adm1031_group);
-	sysfs_remove_group(&client->dev.kobj, &adm1031_group_opt);
-	return 0;
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
+							   data, data->groups);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
 static const struct i2c_device_id adm1031_id[] = {
@@ -1112,7 +1088,6 @@ static struct i2c_driver adm1031_driver = {
 		.name = "adm1031",
 	},
 	.probe		= adm1031_probe,
-	.remove		= adm1031_remove,
 	.id_table	= adm1031_id,
 	.detect		= adm1031_detect,
 	.address_list	= normal_i2c,
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
