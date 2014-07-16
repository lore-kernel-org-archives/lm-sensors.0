From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 16 Jul 2014 15:12:54 +0000
Subject: [lm-sensors] [RFT][PATCH 2/2] hwmon: (adt7470) Convert to devm_hwmon_device_register_with_groups
Message-Id: <1405523574.6874.4.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
simplify the code a bit.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/adt7470.c | 97 +++++++++++++++++++++----------------------------
 1 file changed, 42 insertions(+), 55 deletions(-)

diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
index 9965fdb..239c361 100644
--- a/drivers/hwmon/adt7470.c
+++ b/drivers/hwmon/adt7470.c
@@ -143,8 +143,7 @@ static const unsigned short normal_i2c[] = { 0x2C, 0x2E, 0x2F, I2C_CLIENT_END };
 #define FAN_DATA_VALID(x)	((x) && (x) != FAN_PERIOD_INVALID)
 
 struct adt7470_data {
-	struct device		*hwmon_dev;
-	struct attribute_group	attrs;
+	struct i2c_client	*client;
 	struct mutex		lock;
 	char			sensors_valid;
 	char			limits_valid;
@@ -278,8 +277,8 @@ static int adt7470_update_thread(void *p)
 
 static struct adt7470_data *adt7470_update_device(struct device *dev)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adt7470_data *data = i2c_get_clientdata(client);
+	struct adt7470_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	unsigned long local_jiffies = jiffies;
 	u8 cfg;
 	int i;
@@ -409,8 +408,7 @@ static ssize_t set_auto_update_interval(struct device *dev,
 					const char *buf,
 					size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adt7470_data *data = i2c_get_clientdata(client);
+	struct adt7470_data *data = dev_get_drvdata(dev);
 	long temp;
 
 	if (kstrtol(buf, 10, &temp))
@@ -438,8 +436,7 @@ static ssize_t set_num_temp_sensors(struct device *dev,
 				    const char *buf,
 				    size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adt7470_data *data = i2c_get_clientdata(client);
+	struct adt7470_data *data = dev_get_drvdata(dev);
 	long temp;
 
 	if (kstrtol(buf, 10, &temp))
@@ -471,8 +468,8 @@ static ssize_t set_temp_min(struct device *dev,
 			    size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adt7470_data *data = i2c_get_clientdata(client);
+	struct adt7470_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long temp;
 
 	if (kstrtol(buf, 10, &temp))
@@ -505,8 +502,8 @@ static ssize_t set_temp_max(struct device *dev,
 			    size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adt7470_data *data = i2c_get_clientdata(client);
+	struct adt7470_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long temp;
 
 	if (kstrtol(buf, 10, &temp))
@@ -560,8 +557,8 @@ static ssize_t set_fan_max(struct device *dev,
 			   const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adt7470_data *data = i2c_get_clientdata(client);
+	struct adt7470_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long temp;
 
 	if (kstrtol(buf, 10, &temp) || !temp)
@@ -597,8 +594,8 @@ static ssize_t set_fan_min(struct device *dev,
 			   const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adt7470_data *data = i2c_get_clientdata(client);
+	struct adt7470_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long temp;
 
 	if (kstrtol(buf, 10, &temp) || !temp)
@@ -641,8 +638,8 @@ static ssize_t set_force_pwm_max(struct device *dev,
 				 const char *buf,
 				 size_t count)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adt7470_data *data = i2c_get_clientdata(client);
+	struct adt7470_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long temp;
 	u8 reg;
 
@@ -674,8 +671,8 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute *devattr,
 			const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adt7470_data *data = i2c_get_clientdata(client);
+	struct adt7470_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long temp;
 
 	if (kstrtol(buf, 10, &temp))
@@ -706,8 +703,8 @@ static ssize_t set_pwm_max(struct device *dev,
 			   size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adt7470_data *data = i2c_get_clientdata(client);
+	struct adt7470_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long temp;
 
 	if (kstrtol(buf, 10, &temp))
@@ -739,8 +736,8 @@ static ssize_t set_pwm_min(struct device *dev,
 			   size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adt7470_data *data = i2c_get_clientdata(client);
+	struct adt7470_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long temp;
 
 	if (kstrtol(buf, 10, &temp))
@@ -782,8 +779,8 @@ static ssize_t set_pwm_tmin(struct device *dev,
 			    size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adt7470_data *data = i2c_get_clientdata(client);
+	struct adt7470_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	long temp;
 
 	if (kstrtol(buf, 10, &temp))
@@ -816,8 +813,8 @@ static ssize_t set_pwm_auto(struct device *dev,
 			    size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adt7470_data *data = i2c_get_clientdata(client);
+	struct adt7470_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int pwm_auto_reg = ADT7470_REG_PWM_CFG(attr->index);
 	int pwm_auto_reg_mask;
 	long temp;
@@ -877,8 +874,8 @@ static ssize_t set_pwm_auto_temp(struct device *dev,
 				 size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct adt7470_data *data = i2c_get_clientdata(client);
+	struct adt7470_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
 	int pwm_auto_reg = ADT7470_REG_PWM_AUTO_TEMP(attr->index);
 	long temp;
 	u8 reg;
@@ -1095,7 +1092,7 @@ static SENSOR_DEVICE_ATTR(pwm3_auto_channels_temp, S_IWUSR | S_IRUGO,
 static SENSOR_DEVICE_ATTR(pwm4_auto_channels_temp, S_IWUSR | S_IRUGO,
 		    show_pwm_auto_temp, set_pwm_auto_temp, 3);
 
-static struct attribute *adt7470_attr[] = {
+static struct attribute *adt7470_attrs[] = {
 	&dev_attr_alarm_mask.attr,
 	&dev_attr_num_temp_sensors.attr,
 	&dev_attr_auto_update_interval.attr,
@@ -1187,6 +1184,8 @@ static struct attribute *adt7470_attr[] = {
 	NULL
 };
 
+ATTRIBUTE_GROUPS(adt7470);
+
 /* Return 0 if detection is successful, -ENODEV otherwise */
 static int adt7470_detect(struct i2c_client *client,
 			  struct i2c_board_info *info)
@@ -1229,11 +1228,11 @@ static void adt7470_init_client(struct i2c_client *client)
 static int adt7470_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
+	struct device *dev = &client->dev;
 	struct adt7470_data *data;
-	int err;
+	struct device *hwmon_dev;
 
-	data = devm_kzalloc(&client->dev, sizeof(struct adt7470_data),
-			    GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(struct adt7470_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
@@ -1241,6 +1240,7 @@ static int adt7470_probe(struct i2c_client *client,
 	data->auto_update_interval = AUTO_UPDATE_INTERVAL;
 
 	i2c_set_clientdata(client, data);
+	data->client = client;
 	mutex_init(&data->lock);
 
 	dev_info(&client->dev, "%s chip found\n", client->name);
@@ -1249,32 +1249,21 @@ static int adt7470_probe(struct i2c_client *client,
 	adt7470_init_client(client);
 
 	/* Register sysfs hooks */
-	data->attrs.attrs = adt7470_attr;
-	err = sysfs_create_group(&client->dev.kobj, &data->attrs);
-	if (err)
-		return err;
-
-	data->hwmon_dev = hwmon_device_register(&client->dev);
-	if (IS_ERR(data->hwmon_dev)) {
-		err = PTR_ERR(data->hwmon_dev);
-		goto exit_remove;
-	}
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
+							   data,
+							   adt7470_groups);
+
+	if (IS_ERR(hwmon_dev))
+		return PTR_ERR(hwmon_dev);
 
 	init_completion(&data->auto_update_stop);
 	data->auto_update = kthread_run(adt7470_update_thread, client, "%s",
-					dev_name(data->hwmon_dev));
+					dev_name(hwmon_dev));
 	if (IS_ERR(data->auto_update)) {
-		err = PTR_ERR(data->auto_update);
-		goto exit_unregister;
+		return PTR_ERR(data->auto_update);
 	}
 
 	return 0;
-
-exit_unregister:
-	hwmon_device_unregister(data->hwmon_dev);
-exit_remove:
-	sysfs_remove_group(&client->dev.kobj, &data->attrs);
-	return err;
 }
 
 static int adt7470_remove(struct i2c_client *client)
@@ -1283,8 +1272,6 @@ static int adt7470_remove(struct i2c_client *client)
 
 	kthread_stop(data->auto_update);
 	wait_for_completion(&data->auto_update_stop);
-	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&client->dev.kobj, &data->attrs);
 	return 0;
 }
 
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
