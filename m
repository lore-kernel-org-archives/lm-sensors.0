From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 16 Jan 2012 08:49:10 +0000
Subject: [lm-sensors] [PATCH 08/39] hwmon: (asb100): Fix checkpatch issues
Message-Id: <1326703781-14272-9-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fixed:
ERROR: code indent should use tabs where possible
ERROR: do not use assignment in if condition
ERROR: space prohibited after that open parenthesis '('
ERROR: spaces required around that '<' (ctx:VxV)
ERROR: spaces required around that '=' (ctx:VxV)
WARNING: please, no spaces at the start of a line
WARNING: simple_strtol is obsolete, use kstrtol instead
WARNING: simple_strtoul is obsolete, use kstrtoul instead

Not fixed (false positive):
ERROR: Macros with multiple statements should be enclosed in a do - while loop

Cc: Mark M. Hoffman <mhoffman@lightlink.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/asb100.c |   67 +++++++++++++++++++++++++++++++++++-------------
 1 files changed, 49 insertions(+), 18 deletions(-)

diff --git a/drivers/hwmon/asb100.c b/drivers/hwmon/asb100.c
index d7bd1f3..a5f1642 100644
--- a/drivers/hwmon/asb100.c
+++ b/drivers/hwmon/asb100.c
@@ -1,6 +1,6 @@
 /*
     asb100.c - Part of lm_sensors, Linux kernel modules for hardware
-	        monitoring
+		monitoring
 
     Copyright (C) 2004 Mark M. Hoffman <mhoffman@lightlink.com>
 
@@ -103,8 +103,8 @@ static const u16 asb100_reg_temp_hyst[]	= {0, 0x3a, 0x153, 0x253, 0x19};
    Rounding and limit checking is only done on the TO_REG variants. */
 
 /* These constants are a guess, consistent w/ w83781d */
-#define ASB100_IN_MIN (   0)
-#define ASB100_IN_MAX (4080)
+#define ASB100_IN_MIN		0
+#define ASB100_IN_MAX		4080
 
 /* IN: 1/1000 V (0V to 4.08V)
    REG: 16mV/bit */
@@ -131,19 +131,19 @@ static u8 FAN_TO_REG(long rpm, int div)
 
 static int FAN_FROM_REG(u8 val, int div)
 {
-	return val=0 ? -1 : val=255 ? 0 : 1350000/(val*div);
+	return val = 0 ? -1 : val = 255 ? 0 : 1350000 / (val * div);
 }
 
 /* These constants are a guess, consistent w/ w83781d */
-#define ASB100_TEMP_MIN (-128000)
-#define ASB100_TEMP_MAX ( 127000)
+#define ASB100_TEMP_MIN		-128000
+#define ASB100_TEMP_MAX		127000
 
 /* TEMP: 0.001C/bit (-128C to +127C)
    REG: 1C/bit, two's complement */
 static u8 TEMP_TO_REG(long temp)
 {
 	int ntemp = SENSORS_LIMIT(temp, ASB100_TEMP_MIN, ASB100_TEMP_MAX);
-	ntemp += (ntemp<0 ? -500 : 500);
+	ntemp += (ntemp < 0 ? -500 : 500);
 	return (u8)(ntemp / 1000);
 }
 
@@ -171,7 +171,7 @@ static int ASB100_PWM_FROM_REG(u8 reg)
    REG: 0, 1, 2, or 3 (respectively) (defaults to 1) */
 static u8 DIV_TO_REG(long val)
 {
-	return val=8 ? 3 : val=4 ? 2 : val=1 ? 0 : 1;
+	return val = 8 ? 3 : val = 4 ? 2 : val = 1 ? 0 : 1;
 }
 
 /* For each registered client, we need to keep some data in memory. That
@@ -253,8 +253,10 @@ static ssize_t set_in_##reg(struct device *dev, struct device_attribute *attr, \
 	int nr = to_sensor_dev_attr(attr)->index; \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct asb100_data *data = i2c_get_clientdata(client); \
-	unsigned long val = simple_strtoul(buf, NULL, 10); \
- \
+	unsigned long val; \
+	int err = kstrtoul(buf, 10, &val); \
+	if (err) \
+		return err; \
 	mutex_lock(&data->update_lock); \
 	data->in_##reg[nr] = IN_TO_REG(val); \
 	asb100_write_value(client, ASB100_REG_IN_##REG(nr), \
@@ -315,7 +317,12 @@ static ssize_t set_fan_min(struct device *dev, struct device_attribute *attr,
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct asb100_data *data = i2c_get_clientdata(client);
-	u32 val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->fan_min[nr] = FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
@@ -335,8 +342,13 @@ static ssize_t set_fan_div(struct device *dev, struct device_attribute *attr,
 	struct i2c_client *client = to_i2c_client(dev);
 	struct asb100_data *data = i2c_get_clientdata(client);
 	unsigned long min;
-	unsigned long val = simple_strtoul(buf, NULL, 10);
 	int reg;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 
@@ -421,8 +433,10 @@ static ssize_t set_##reg(struct device *dev, struct device_attribute *attr, \
 	int nr = to_sensor_dev_attr(attr)->index; \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct asb100_data *data = i2c_get_clientdata(client); \
-	long val = simple_strtol(buf, NULL, 10); \
- \
+	long val; \
+	int err = kstrtol(buf, 10, &val); \
+	if (err) \
+		return err; \
 	mutex_lock(&data->update_lock); \
 	switch (nr) { \
 	case 1: case 2: \
@@ -476,7 +490,13 @@ static ssize_t set_vrm(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
 {
 	struct asb100_data *data = dev_get_drvdata(dev);
-	data->vrm = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
+	data->vrm = SENSORS_LIMIT(val, 0, 255);
 	return count;
 }
 
@@ -524,7 +544,12 @@ static ssize_t set_pwm1(struct device *dev, struct device_attribute *attr,
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct asb100_data *data = i2c_get_clientdata(client);
-	unsigned long val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->pwm &= 0x80; /* keep the enable bit */
@@ -546,7 +571,12 @@ static ssize_t set_pwm_enable1(struct device *dev,
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct asb100_data *data = i2c_get_clientdata(client);
-	unsigned long val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->pwm &= 0x0f; /* keep the duty cycle bits */
@@ -768,7 +798,8 @@ static int asb100_probe(struct i2c_client *client,
 	data->fan_min[2] = asb100_read_value(client, ASB100_REG_FAN_MIN(2));
 
 	/* Register sysfs hooks */
-	if ((err = sysfs_create_group(&client->dev.kobj, &asb100_group)))
+	err = sysfs_create_group(&client->dev.kobj, &asb100_group);
+	if (err)
 		goto ERROR3;
 
 	data->hwmon_dev = hwmon_device_register(&client->dev);
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
