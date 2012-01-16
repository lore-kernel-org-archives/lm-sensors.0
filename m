From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 16 Jan 2012 08:49:20 +0000
Subject: [lm-sensors] [PATCH 18/39] hwmon: (lm85) Fix checkpatch issues
Message-Id: <1326703781-14272-19-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fixed:
ERROR: code indent should use tabs where possible
ERROR: do not use assignment in if condition
WARNING: simple_strtol is obsolete, use kstrtol instead
WARNING: simple_strtoul is obsolete, use kstrtoul instead

Not fixed (false positive):
ERROR: Macros with multiple statements should be enclosed in a do - while loop

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm85.c |  130 +++++++++++++++++++++++++++++++++++++++++---------
 1 files changed, 107 insertions(+), 23 deletions(-)

diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
index da72dc1..240b7f9 100644
--- a/drivers/hwmon/lm85.c
+++ b/drivers/hwmon/lm85.c
@@ -1,6 +1,6 @@
 /*
     lm85.c - Part of lm_sensors, Linux kernel modules for hardware
-             monitoring
+	monitoring
     Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl>
     Copyright (c) 2002, 2003  Philip Pokorny <ppokorny@penguincomputing.com>
     Copyright (c) 2003        Margit Schubert-While <margitsw@t-online.de>
@@ -391,7 +391,12 @@ static ssize_t set_fan_min(struct device *dev, struct device_attribute *attr,
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
-	unsigned long val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->fan_min[nr] = FAN_TO_REG(val);
@@ -443,7 +448,14 @@ static ssize_t store_vrm_reg(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
 {
 	struct lm85_data *data = dev_get_drvdata(dev);
-	data->vrm = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
+
+	data->vrm = SENSORS_LIMIT(val, 0, 255);
 	return count;
 }
 
@@ -500,7 +512,12 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->pwm[nr] = PWM_TO_REG(val);
@@ -537,8 +554,13 @@ static ssize_t set_pwm_enable(struct device *dev, struct device_attribute
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
 	u8 config;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	switch (val) {
 	case 0:
@@ -588,7 +610,12 @@ static ssize_t set_pwm_freq(struct device *dev,
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	/* The ADT7468 has a special high-frequency PWM output mode,
@@ -648,7 +675,12 @@ static ssize_t set_in_min(struct device *dev, struct device_attribute *attr,
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->in_min[nr] = INS_TO_REG(nr, val);
@@ -671,7 +703,12 @@ static ssize_t set_in_max(struct device *dev, struct device_attribute *attr,
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->in_max[nr] = INS_TO_REG(nr, val);
@@ -722,7 +759,12 @@ static ssize_t set_temp_min(struct device *dev, struct device_attribute *attr,
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	if (IS_ADT7468_OFF64(data))
 		val += 64;
@@ -748,7 +790,12 @@ static ssize_t set_temp_max(struct device *dev, struct device_attribute *attr,
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	if (IS_ADT7468_OFF64(data))
 		val += 64;
@@ -789,7 +836,12 @@ static ssize_t set_pwm_auto_channels(struct device *dev,
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->autofan[nr].config = (data->autofan[nr].config & (~0xe0))
@@ -814,7 +866,12 @@ static ssize_t set_pwm_auto_pwm_min(struct device *dev,
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->autofan[nr].min_pwm = PWM_TO_REG(val);
@@ -838,8 +895,13 @@ static ssize_t set_pwm_auto_pwm_minctl(struct device *dev,
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
 	u8 tmp;
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->autofan[nr].min_off = val;
@@ -885,7 +947,12 @@ static ssize_t set_temp_auto_temp_off(struct device *dev,
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
 	int min;
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	min = TEMP_FROM_REG(data->zone[nr].limit);
@@ -916,7 +983,12 @@ static ssize_t set_temp_auto_temp_min(struct device *dev,
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->zone[nr].limit = TEMP_TO_REG(val);
@@ -951,7 +1023,12 @@ static ssize_t set_temp_auto_temp_max(struct device *dev,
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
 	int min;
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	min = TEMP_FROM_REG(data->zone[nr].limit);
@@ -979,7 +1056,12 @@ static ssize_t set_temp_auto_temp_crit(struct device *dev,
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm85_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->zone[nr].critical = TEMP_TO_REG(val);
@@ -1346,16 +1428,18 @@ static int lm85_probe(struct i2c_client *client,
 			data->has_vid5 = true;
 	}
 
-	if (!data->has_vid5)
-		if ((err = sysfs_create_group(&client->dev.kobj,
-					&lm85_group_in4)))
+	if (!data->has_vid5) {
+		err = sysfs_create_group(&client->dev.kobj, &lm85_group_in4);
+		if (err)
 			goto err_remove_files;
+	}
 
 	/* The EMC6D100 has 3 additional voltage inputs */
-	if (data->type = emc6d100)
-		if ((err = sysfs_create_group(&client->dev.kobj,
-					&lm85_group_in567)))
+	if (data->type = emc6d100) {
+		err = sysfs_create_group(&client->dev.kobj, &lm85_group_in567);
+		if (err)
 			goto err_remove_files;
+	}
 
 	data->hwmon_dev = hwmon_device_register(&client->dev);
 	if (IS_ERR(data->hwmon_dev)) {
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
