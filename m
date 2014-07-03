From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 03 Jul 2014 13:53:01 +0000
Subject: [lm-sensors] [RFT][PATCH 2/2] hwmon: (adm1026) Convert to devm_hwmon_device_register_with_groups
Message-Id: <1404395581.4895.8.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
simplify the code a bit.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/adm1026.c | 140 +++++++++++++++++++-----------------------------
 1 file changed, 55 insertions(+), 85 deletions(-)

diff --git a/drivers/hwmon/adm1026.c b/drivers/hwmon/adm1026.c
index cf3ed299..ca8430f 100644
--- a/drivers/hwmon/adm1026.c
+++ b/drivers/hwmon/adm1026.c
@@ -266,7 +266,8 @@ struct pwm_data {
 };
 
 struct adm1026_data {
-	struct device *hwmon_dev;
+	struct i2c_client *client;
+	const struct attribute_group *groups[3];
 
 	struct mutex update_lock;
 	int valid;		/* !=0 if following fields are valid */
@@ -328,8 +329,8 @@ static int adm1026_write_value(struct i2c_client *client, u8 reg, int value)
 
 static struct adm1026_data *adm1026_update_device(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm1026_data *data = i2c_get_clientdata(client);
+	struct adm1026_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int i;
 	long value, alarms, gpio;
 
@@ -495,8 +496,8 @@ static ssize_t set_in_min(struct device *dev, struct device_attribute *attr,
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
 	int nr = sensor_attr->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm1026_data *data = i2c_get_clientdata(client);
+	struct adm1026_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long val;
 	int err;
 
@@ -523,8 +524,8 @@ static ssize_t set_in_max(struct device *dev, struct device_attribute *attr,
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
 	int nr = sensor_attr->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm1026_data *data = i2c_get_clientdata(client);
+	struct adm1026_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long val;
 	int err;
 
@@ -582,8 +583,8 @@ static ssize_t show_in16_min(struct device *dev, struct device_attribute *attr,
 static ssize_t set_in16_min(struct device *dev, struct device_attribute *attr,
 			    const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm1026_data *data = i2c_get_clientdata(client);
+	struct adm1026_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long val;
 	int err;
 
@@ -607,8 +608,8 @@ static ssize_t show_in16_max(struct device *dev, struct device_attribute *attr,
 static ssize_t set_in16_max(struct device *dev, struct device_attribute *attr,
 			    const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm1026_data *data = i2c_get_clientdata(client);
+	struct adm1026_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long val;
 	int err;
 
@@ -655,8 +656,8 @@ static ssize_t set_fan_min(struct device *dev, struct device_attribute *attr,
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
 	int nr = sensor_attr->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm1026_data *data = i2c_get_clientdata(client);
+	struct adm1026_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long val;
 	int err;
 
@@ -690,8 +691,8 @@ fan_offset(8);
 /* Adjust fan_min to account for new fan divisor */
 static void fixup_fan_min(struct device *dev, int fan, int old_div)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm1026_data *data = i2c_get_clientdata(client);
+	struct adm1026_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int new_min;
 	int new_div = data->fan_div[fan];
 
@@ -719,8 +720,8 @@ static ssize_t set_fan_div(struct device *dev, struct device_attribute *attr,
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
 	int nr = sensor_attr->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm1026_data *data = i2c_get_clientdata(client);
+	struct adm1026_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long val;
 	int orig_div, new_div;
 	int err;
@@ -791,8 +792,8 @@ static ssize_t set_temp_min(struct device *dev, struct device_attribute *attr,
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
 	int nr = sensor_attr->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm1026_data *data = i2c_get_clientdata(client);
+	struct adm1026_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long val;
 	int err;
 
@@ -820,8 +821,8 @@ static ssize_t set_temp_max(struct device *dev, struct device_attribute *attr,
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
 	int nr = sensor_attr->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm1026_data *data = i2c_get_clientdata(client);
+	struct adm1026_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long val;
 	int err;
 
@@ -864,8 +865,8 @@ static ssize_t set_temp_offset(struct device *dev,
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
 	int nr = sensor_attr->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm1026_data *data = i2c_get_clientdata(client);
+	struct adm1026_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long val;
 	int err;
 
@@ -920,8 +921,8 @@ static ssize_t set_temp_auto_point1_temp(struct device *dev,
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
 	int nr = sensor_attr->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm1026_data *data = i2c_get_clientdata(client);
+	struct adm1026_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long val;
 	int err;
 
@@ -959,8 +960,8 @@ static ssize_t show_temp_crit_enable(struct device *dev,
 static ssize_t set_temp_crit_enable(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm1026_data *data = i2c_get_clientdata(client);
+	struct adm1026_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	unsigned long val;
 	int err;
 
@@ -1000,8 +1001,8 @@ static ssize_t set_temp_crit(struct device *dev, struct device_attribute *attr,
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
 	int nr = sensor_attr->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm1026_data *data = i2c_get_clientdata(client);
+	struct adm1026_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long val;
 	int err;
 
@@ -1035,8 +1036,8 @@ static ssize_t set_analog_out_reg(struct device *dev,
 				  struct device_attribute *attr,
 				  const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm1026_data *data = i2c_get_clientdata(client);
+	struct adm1026_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long val;
 	int err;
 
@@ -1145,8 +1146,8 @@ static ssize_t show_alarm_mask(struct device *dev,
 static ssize_t set_alarm_mask(struct device *dev, struct device_attribute *attr,
 			      const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm1026_data *data = i2c_get_clientdata(client);
+	struct adm1026_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	unsigned long mask;
 	long val;
 	int err;
@@ -1187,8 +1188,8 @@ static ssize_t show_gpio(struct device *dev, struct device_attribute *attr,
 static ssize_t set_gpio(struct device *dev, struct device_attribute *attr,
 			const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm1026_data *data = i2c_get_clientdata(client);
+	struct adm1026_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long gpio;
 	long val;
 	int err;
@@ -1220,8 +1221,8 @@ static ssize_t show_gpio_mask(struct device *dev, struct device_attribute *attr,
 static ssize_t set_gpio_mask(struct device *dev, struct device_attribute *attr,
 			     const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm1026_data *data = i2c_get_clientdata(client);
+	struct adm1026_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long mask;
 	long val;
 	int err;
@@ -1254,8 +1255,8 @@ static ssize_t show_pwm_reg(struct device *dev, struct device_attribute *attr,
 static ssize_t set_pwm_reg(struct device *dev, struct device_attribute *attr,
 			   const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm1026_data *data = i2c_get_clientdata(client);
+	struct adm1026_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 
 	if (data->pwm1.enable = 1) {
 		long val;
@@ -1284,8 +1285,8 @@ static ssize_t set_auto_pwm_min(struct device *dev,
 				struct device_attribute *attr, const char *buf,
 				size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm1026_data *data = i2c_get_clientdata(client);
+	struct adm1026_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	unsigned long val;
 	int err;
 
@@ -1320,8 +1321,8 @@ static ssize_t show_pwm_enable(struct device *dev,
 static ssize_t set_pwm_enable(struct device *dev, struct device_attribute *attr,
 			      const char *buf, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adm1026_data *data = i2c_get_clientdata(client);
+	struct adm1026_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int old_enable;
 	unsigned long val;
 	int err;
@@ -1800,15 +1801,16 @@ static void adm1026_init_client(struct i2c_client *client)
 static int adm1026_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
+	struct device *dev = &client->dev;
+	struct device *hwmon_dev;
 	struct adm1026_data *data;
-	int err;
 
-	data = devm_kzalloc(&client->dev, sizeof(struct adm1026_data),
-			    GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(struct adm1026_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
 	i2c_set_clientdata(client, data);
+	data->client = client;
 	mutex_init(&data->update_lock);
 
 	/* Set the VRM version */
@@ -1817,47 +1819,16 @@ static int adm1026_probe(struct i2c_client *client,
 	/* Initialize the ADM1026 chip */
 	adm1026_init_client(client);
 
-	/* Register sysfs hooks */
-	err = sysfs_create_group(&client->dev.kobj, &adm1026_group);
-	if (err)
-		return err;
-	if (data->config1 & CFG1_AIN8_9)
-		err = sysfs_create_group(&client->dev.kobj,
-					 &adm1026_group_in8_9);
-	else
-		err = sysfs_create_group(&client->dev.kobj,
-					 &adm1026_group_temp3);
-	if (err)
-		goto exitremove;
-
-	data->hwmon_dev = hwmon_device_register(&client->dev);
-	if (IS_ERR(data->hwmon_dev)) {
-		err = PTR_ERR(data->hwmon_dev);
-		goto exitremove;
-	}
-
-	return 0;
-
-	/* Error out and cleanup code */
-exitremove:
-	sysfs_remove_group(&client->dev.kobj, &adm1026_group);
+	/* sysfs hooks */
+	data->groups[0] = &adm1026_group;
 	if (data->config1 & CFG1_AIN8_9)
-		sysfs_remove_group(&client->dev.kobj, &adm1026_group_in8_9);
+		data->groups[1] = &adm1026_group_in8_9;
 	else
-		sysfs_remove_group(&client->dev.kobj, &adm1026_group_temp3);
-	return err;
-}
+		data->groups[1] = &adm1026_group_temp3;
 
-static int adm1026_remove(struct i2c_client *client)
-{
-	struct adm1026_data *data = i2c_get_clientdata(client);
-	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&client->dev.kobj, &adm1026_group);
-	if (data->config1 & CFG1_AIN8_9)
-		sysfs_remove_group(&client->dev.kobj, &adm1026_group_in8_9);
-	else
-		sysfs_remove_group(&client->dev.kobj, &adm1026_group_temp3);
-	return 0;
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
+							   data, data->groups);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
 static const struct i2c_device_id adm1026_id[] = {
@@ -1872,7 +1843,6 @@ static struct i2c_driver adm1026_driver = {
 		.name	= "adm1026",
 	},
 	.probe		= adm1026_probe,
-	.remove		= adm1026_remove,
 	.id_table	= adm1026_id,
 	.detect		= adm1026_detect,
 	.address_list	= normal_i2c,
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
