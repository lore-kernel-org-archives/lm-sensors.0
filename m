From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 16 Jan 2012 08:49:22 +0000
Subject: [lm-sensors] [PATCH 20/39] hwmon: (lm92) Fix checkpatch issues
Message-Id: <1326703781-14272-21-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fixed:
ERROR: code indent should use tabs where possible
ERROR: do not use assignment in if condition
ERROR: spaces required around that '<' (ctx:VxV)
ERROR: spaces required around that '=' (ctx:VxV)
ERROR: spaces required around that '*=' (ctx:VxV)
ERROR: trailing whitespace
WARNING: line over 80 characters
WARNING: please, no space before tabs
WARNING: please, no spaces at the start of a line
WARNING: simple_strtol is obsolete, use kstrtol instead

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm92.c |   52 ++++++++++++++++++++++++++++++++-----------------
 1 files changed, 34 insertions(+), 18 deletions(-)

diff --git a/drivers/hwmon/lm92.c b/drivers/hwmon/lm92.c
index 8fcbd4d4..95cda41 100644
--- a/drivers/hwmon/lm92.c
+++ b/drivers/hwmon/lm92.c
@@ -138,7 +138,8 @@ static struct lm92_data *lm92_update_device(struct device *dev)
 }
 
 #define show_temp(value) \
-static ssize_t show_##value(struct device *dev, struct device_attribute *attr, char *buf) \
+static ssize_t show_##value(struct device *dev, struct device_attribute *attr, \
+			    char *buf) \
 { \
 	struct lm92_data *data = lm92_update_device(dev); \
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->value)); \
@@ -149,13 +150,17 @@ show_temp(temp1_min);
 show_temp(temp1_max);
 
 #define set_temp(value, reg) \
-static ssize_t set_##value(struct device *dev, struct device_attribute *attr, const char *buf, \
+static ssize_t set_##value(struct device *dev, struct device_attribute *attr, \
+			   const char *buf, \
 	size_t count) \
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct lm92_data *data = i2c_get_clientdata(client); \
-	long val = simple_strtol(buf, NULL, 10); \
- \
+	long val; \
+	int err = kstrtol(buf, 10, &val); \
+	if (err) \
+		return err; \
+\
 	mutex_lock(&data->update_lock); \
 	data->value = TEMP_TO_REG(val); \
 	i2c_smbus_write_word_swapped(client, reg, data->value); \
@@ -166,31 +171,40 @@ set_temp(temp1_crit, LM92_REG_TEMP_CRIT);
 set_temp(temp1_min, LM92_REG_TEMP_LOW);
 set_temp(temp1_max, LM92_REG_TEMP_HIGH);
 
-static ssize_t show_temp1_crit_hyst(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_temp1_crit_hyst(struct device *dev,
+				    struct device_attribute *attr, char *buf)
 {
 	struct lm92_data *data = lm92_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp1_crit)
 		       - TEMP_FROM_REG(data->temp1_hyst));
 }
-static ssize_t show_temp1_max_hyst(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_temp1_max_hyst(struct device *dev,
+				   struct device_attribute *attr, char *buf)
 {
 	struct lm92_data *data = lm92_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp1_max)
 		       - TEMP_FROM_REG(data->temp1_hyst));
 }
-static ssize_t show_temp1_min_hyst(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_temp1_min_hyst(struct device *dev,
+				   struct device_attribute *attr, char *buf)
 {
 	struct lm92_data *data = lm92_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp1_min)
 		       + TEMP_FROM_REG(data->temp1_hyst));
 }
 
-static ssize_t set_temp1_crit_hyst(struct device *dev, struct device_attribute *attr, const char *buf,
-	size_t count)
+static ssize_t set_temp1_crit_hyst(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm92_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->temp1_hyst = TEMP_FROM_REG(data->temp1_crit) - val;
@@ -200,7 +214,8 @@ static ssize_t set_temp1_crit_hyst(struct device *dev, struct device_attribute *
 	return count;
 }
 
-static ssize_t show_alarms(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_alarms(struct device *dev, struct device_attribute *attr,
+			   char *buf)
 {
 	struct lm92_data *data = lm92_update_device(dev);
 	return sprintf(buf, "%d\n", ALARMS_FROM_REG(data->temp1_input));
@@ -265,7 +280,7 @@ static int max6635_check(struct i2c_client *client)
 	temp_high = i2c_smbus_read_word_data(client, LM92_REG_TEMP_HIGH);
 	if (i2c_smbus_read_word_data(client, LM92_REG_MAN_ID) != temp_high)
 		return 0;
-	
+
 	/* Limits are stored as integer values (signed, 9-bit). */
 	if ((temp_low & 0x7f00) || (temp_high & 0x7f00))
 		return 0;
@@ -279,17 +294,17 @@ static int max6635_check(struct i2c_client *client)
 	   reads and time, but this should still be sufficient to dismiss
 	   non-MAX6635 chips. */
 	conf = i2c_smbus_read_byte_data(client, LM92_REG_CONFIG);
-	for (i; i<96; i*=2) {
+	for (i = 16; i < 96; i *= 2) {
 		if (temp_hyst != i2c_smbus_read_word_data(client,
-		 		 LM92_REG_TEMP_HYST + i - 16)
+				 LM92_REG_TEMP_HYST + i - 16)
 		 || temp_crit != i2c_smbus_read_word_data(client,
-		 		 LM92_REG_TEMP_CRIT + i)
+				 LM92_REG_TEMP_CRIT + i)
 		 || temp_low != i2c_smbus_read_word_data(client,
 				LM92_REG_TEMP_LOW + i + 16)
 		 || temp_high != i2c_smbus_read_word_data(client,
-		 		 LM92_REG_TEMP_HIGH + i + 32)
+				 LM92_REG_TEMP_HIGH + i + 32)
 		 || conf != i2c_smbus_read_byte_data(client,
-		 	    LM92_REG_CONFIG + i))
+			    LM92_REG_CONFIG + i))
 			return 0;
 	}
 
@@ -362,7 +377,8 @@ static int lm92_probe(struct i2c_client *new_client,
 	lm92_init_client(new_client);
 
 	/* Register sysfs hooks */
-	if ((err = sysfs_create_group(&new_client->dev.kobj, &lm92_group)))
+	err = sysfs_create_group(&new_client->dev.kobj, &lm92_group);
+	if (err)
 		goto exit_free;
 
 	data->hwmon_dev = hwmon_device_register(&new_client->dev);
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
