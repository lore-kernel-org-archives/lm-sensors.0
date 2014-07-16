From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 16 Jul 2014 15:10:46 +0000
Subject: [lm-sensors] [RFT][PATCH 2/2] hwmon: (adt7462) Convert to devm_hwmon_device_register_with_groups
Message-Id: <1405523446.6874.2.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
simplify the code a bit.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/adt7462.c | 106 +++++++++++++++++++-----------------------------
 1 file changed, 42 insertions(+), 64 deletions(-)

diff --git a/drivers/hwmon/adt7462.c b/drivers/hwmon/adt7462.c
index c4a1784..5929e12 100644
--- a/drivers/hwmon/adt7462.c
+++ b/drivers/hwmon/adt7462.c
@@ -202,8 +202,7 @@ static const unsigned short normal_i2c[] = { 0x58, 0x5C, I2C_CLIENT_END };
 	(((value) & prefix##_MASK) >> prefix##_SHIFT)
 
 struct adt7462_data {
-	struct device		*hwmon_dev;
-	struct attribute_group	attrs;
+	struct i2c_client	*client;
 	struct mutex		lock;
 	char			sensors_valid;
 	char			limits_valid;
@@ -681,8 +680,8 @@ static int find_trange_value(int trange)
 
 static struct adt7462_data *adt7462_update_device(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adt7462_data *data = i2c_get_clientdata(client);
+	struct adt7462_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	unsigned long local_jiffies = jiffies;
 	int i;
 
@@ -804,8 +803,8 @@ static ssize_t set_temp_min(struct device *dev,
 			    size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adt7462_data *data = i2c_get_clientdata(client);
+	struct adt7462_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long temp;
 
 	if (kstrtol(buf, 10, &temp) || !temp_enabled(data, attr->index))
@@ -842,8 +841,8 @@ static ssize_t set_temp_max(struct device *dev,
 			    size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adt7462_data *data = i2c_get_clientdata(client);
+	struct adt7462_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long temp;
 
 	if (kstrtol(buf, 10, &temp) || !temp_enabled(data, attr->index))
@@ -905,8 +904,8 @@ static ssize_t set_volt_max(struct device *dev,
 			    size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adt7462_data *data = i2c_get_clientdata(client);
+	struct adt7462_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int x = voltage_multiplier(data, attr->index);
 	long temp;
 
@@ -947,8 +946,8 @@ static ssize_t set_volt_min(struct device *dev,
 			    size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adt7462_data *data = i2c_get_clientdata(client);
+	struct adt7462_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int x = voltage_multiplier(data, attr->index);
 	long temp;
 
@@ -1037,8 +1036,8 @@ static ssize_t set_fan_min(struct device *dev,
 			   const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adt7462_data *data = i2c_get_clientdata(client);
+	struct adt7462_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long temp;
 
 	if (kstrtol(buf, 10, &temp) || !temp ||
@@ -1085,8 +1084,8 @@ static ssize_t set_force_pwm_max(struct device *dev,
 				 const char *buf,
 				 size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adt7462_data *data = i2c_get_clientdata(client);
+	struct adt7462_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long temp;
 	u8 reg;
 
@@ -1118,8 +1117,8 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute *devattr,
 			const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adt7462_data *data = i2c_get_clientdata(client);
+	struct adt7462_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long temp;
 
 	if (kstrtol(buf, 10, &temp))
@@ -1148,8 +1147,8 @@ static ssize_t set_pwm_max(struct device *dev,
 			   const char *buf,
 			   size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adt7462_data *data = i2c_get_clientdata(client);
+	struct adt7462_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long temp;
 
 	if (kstrtol(buf, 10, &temp))
@@ -1180,8 +1179,8 @@ static ssize_t set_pwm_min(struct device *dev,
 			   size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adt7462_data *data = i2c_get_clientdata(client);
+	struct adt7462_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long temp;
 
 	if (kstrtol(buf, 10, &temp))
@@ -1214,8 +1213,8 @@ static ssize_t set_pwm_hyst(struct device *dev,
 			    size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adt7462_data *data = i2c_get_clientdata(client);
+	struct adt7462_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long temp;
 
 	if (kstrtol(buf, 10, &temp))
@@ -1259,8 +1258,8 @@ static ssize_t set_pwm_tmax(struct device *dev,
 {
 	int temp;
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adt7462_data *data = i2c_get_clientdata(client);
+	struct adt7462_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int tmin, trange_value;
 	long trange;
 
@@ -1300,8 +1299,8 @@ static ssize_t set_pwm_tmin(struct device *dev,
 			    size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adt7462_data *data = i2c_get_clientdata(client);
+	struct adt7462_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long temp;
 
 	if (kstrtol(buf, 10, &temp))
@@ -1357,8 +1356,8 @@ static ssize_t set_pwm_auto(struct device *dev,
 			    size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adt7462_data *data = i2c_get_clientdata(client);
+	struct adt7462_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long temp;
 
 	if (kstrtol(buf, 10, &temp))
@@ -1416,8 +1415,8 @@ static ssize_t set_pwm_auto_temp(struct device *dev,
 				 size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adt7462_data *data = i2c_get_clientdata(client);
+	struct adt7462_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long temp;
 
 	if (kstrtol(buf, 10, &temp))
@@ -1701,7 +1700,7 @@ static SENSOR_DEVICE_ATTR(pwm3_auto_channels_temp, S_IWUSR | S_IRUGO,
 static SENSOR_DEVICE_ATTR(pwm4_auto_channels_temp, S_IWUSR | S_IRUGO,
 		    show_pwm_auto_temp, set_pwm_auto_temp, 3);
 
-static struct attribute *adt7462_attr[] = {
+static struct attribute *adt7462_attrs[] = {
 	&sensor_dev_attr_temp1_max.dev_attr.attr,
 	&sensor_dev_attr_temp2_max.dev_attr.attr,
 	&sensor_dev_attr_temp3_max.dev_attr.attr,
@@ -1872,6 +1871,8 @@ static struct attribute *adt7462_attr[] = {
 	NULL
 };
 
+ATTRIBUTE_GROUPS(adt7462);
+
 /* Return 0 if detection is successful, -ENODEV otherwise */
 static int adt7462_detect(struct i2c_client *client,
 			  struct i2c_board_info *info)
@@ -1902,45 +1903,23 @@ static int adt7462_detect(struct i2c_client *client,
 static int adt7462_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
+	struct device *dev = &client->dev;
 	struct adt7462_data *data;
-	int err;
+	struct device *hwmon_dev;
 
-	data = devm_kzalloc(&client->dev, sizeof(struct adt7462_data),
-			    GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(struct adt7462_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	i2c_set_clientdata(client, data);
+	data->client = client;
 	mutex_init(&data->lock);
 
 	dev_info(&client->dev, "%s chip found\n", client->name);
 
-	/* Register sysfs hooks */
-	data->attrs.attrs = adt7462_attr;
-	err = sysfs_create_group(&client->dev.kobj, &data->attrs);
-	if (err)
-		return err;
-
-	data->hwmon_dev = hwmon_device_register(&client->dev);
-	if (IS_ERR(data->hwmon_dev)) {
-		err = PTR_ERR(data->hwmon_dev);
-		goto exit_remove;
-	}
-
-	return 0;
-
-exit_remove:
-	sysfs_remove_group(&client->dev.kobj, &data->attrs);
-	return err;
-}
-
-static int adt7462_remove(struct i2c_client *client)
-{
-	struct adt7462_data *data = i2c_get_clientdata(client);
-
-	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&client->dev.kobj, &data->attrs);
-	return 0;
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
+							   data,
+							   adt7462_groups);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
 static const struct i2c_device_id adt7462_id[] = {
@@ -1955,7 +1934,6 @@ static struct i2c_driver adt7462_driver = {
 		.name	= "adt7462",
 	},
 	.probe		= adt7462_probe,
-	.remove		= adt7462_remove,
 	.id_table	= adt7462_id,
 	.detect		= adt7462_detect,
 	.address_list	= normal_i2c,
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
