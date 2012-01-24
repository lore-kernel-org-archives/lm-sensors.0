From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 24 Jan 2012 02:48:46 +0000
Subject: [lm-sensors] [PATCH 07/79] hwmon: (lm92) Fix checkpatch issues
Message-Id: <1327373398-997-8-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

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

Modify multi-line comments to follow Documentation/CodingStyle.

Cc: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm92.c |   98 +++++++++++++++++++++++++++++++------------------
 1 files changed, 62 insertions(+), 36 deletions(-)

diff --git a/drivers/hwmon/lm92.c b/drivers/hwmon/lm92.c
index 92f2d46..fdc691a 100644
--- a/drivers/hwmon/lm92.c
+++ b/drivers/hwmon/lm92.c
@@ -49,8 +49,10 @@
 #include <linux/err.h>
 #include <linux/mutex.h>
 
-/* The LM92 and MAX6635 have 2 two-state pins for address selection,
-   resulting in 4 possible addresses. */
+/*
+ * The LM92 and MAX6635 have 2 two-state pins for address selection,
+ * resulting in 4 possible addresses.
+ */
 static const unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b,
 						I2C_CLIENT_END };
 
@@ -63,11 +65,13 @@ static const unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b,
 #define LM92_REG_TEMP_HIGH		0x05 /* 16-bit, RW */
 #define LM92_REG_MAN_ID			0x07 /* 16-bit, RO, LM92 only */
 
-/* The LM92 uses signed 13-bit values with LSB = 0.0625 degree Celsius,
-   left-justified in 16-bit registers. No rounding is done, with such
-   a resolution it's just not worth it. Note that the MAX6635 doesn't
-   make use of the 4 lower bits for limits (i.e. effective resolution
-   for limits is 1 degree Celsius). */
+/*
+ * The LM92 uses signed 13-bit values with LSB = 0.0625 degree Celsius,
+ * left-justified in 16-bit registers. No rounding is done, with such
+ * a resolution it's just not worth it. Note that the MAX6635 doesn't
+ * make use of the 4 lower bits for limits (i.e. effective resolution
+ * for limits is 1 degree Celsius).
+ */
 static inline int TEMP_FROM_REG(s16 reg)
 {
 	return reg / 8 * 625 / 10;
@@ -138,7 +142,8 @@ static struct lm92_data *lm92_update_device(struct device *dev)
 }
 
 #define show_temp(value) \
-static ssize_t show_##value(struct device *dev, struct device_attribute *attr, char *buf) \
+static ssize_t show_##value(struct device *dev, struct device_attribute *attr, \
+			    char *buf) \
 { \
 	struct lm92_data *data = lm92_update_device(dev); \
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->value)); \
@@ -149,13 +154,17 @@ show_temp(temp1_min);
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
@@ -166,31 +175,40 @@ set_temp(temp1_crit, LM92_REG_TEMP_CRIT);
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
@@ -200,7 +218,8 @@ static ssize_t set_temp1_crit_hyst(struct device *dev, struct device_attribute *
 	return count;
 }
 
-static ssize_t show_alarms(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_alarms(struct device *dev, struct device_attribute *attr,
+			   char *buf)
 {
 	struct lm92_data *data = lm92_update_device(dev);
 	return sprintf(buf, "%d\n", ALARMS_FROM_REG(data->temp1_input));
@@ -246,26 +265,30 @@ static void lm92_init_client(struct i2c_client *client)
 					  config & 0xFE);
 }
 
-/* The MAX6635 has no identification register, so we have to use tricks
-   to identify it reliably. This is somewhat slow.
-   Note that we do NOT rely on the 2 MSB of the configuration register
-   always reading 0, as suggested by the datasheet, because it was once
-   reported not to be true. */
+/*
+ * The MAX6635 has no identification register, so we have to use tricks
+ * to identify it reliably. This is somewhat slow.
+ * Note that we do NOT rely on the 2 MSB of the configuration register
+ * always reading 0, as suggested by the datasheet, because it was once
+ * reported not to be true.
+ */
 static int max6635_check(struct i2c_client *client)
 {
 	u16 temp_low, temp_high, temp_hyst, temp_crit;
 	u8 conf;
 	int i;
 
-	/* No manufacturer ID register, so a read from this address will
-	   always return the last read value. */
+	/*
+	 * No manufacturer ID register, so a read from this address will
+	 * always return the last read value.
+	 */
 	temp_low = i2c_smbus_read_word_data(client, LM92_REG_TEMP_LOW);
 	if (i2c_smbus_read_word_data(client, LM92_REG_MAN_ID) != temp_low)
 		return 0;
 	temp_high = i2c_smbus_read_word_data(client, LM92_REG_TEMP_HIGH);
 	if (i2c_smbus_read_word_data(client, LM92_REG_MAN_ID) != temp_high)
 		return 0;
-	
+
 	/* Limits are stored as integer values (signed, 9-bit). */
 	if ((temp_low & 0x7f00) || (temp_high & 0x7f00))
 		return 0;
@@ -274,22 +297,24 @@ static int max6635_check(struct i2c_client *client)
 	if ((temp_hyst & 0x7f00) || (temp_crit & 0x7f00))
 		return 0;
 
-	/* Registers addresses were found to cycle over 16-byte boundaries.
-	   We don't test all registers with all offsets so as to save some
-	   reads and time, but this should still be sufficient to dismiss
-	   non-MAX6635 chips. */
+	/*
+	 * Registers addresses were found to cycle over 16-byte boundaries.
+	 * We don't test all registers with all offsets so as to save some
+	 * reads and time, but this should still be sufficient to dismiss
+	 * non-MAX6635 chips.
+	 */
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
 
@@ -362,7 +387,8 @@ static int lm92_probe(struct i2c_client *new_client,
 	lm92_init_client(new_client);
 
 	/* Register sysfs hooks */
-	if ((err = sysfs_create_group(&new_client->dev.kobj, &lm92_group)))
+	err = sysfs_create_group(&new_client->dev.kobj, &lm92_group);
+	if (err)
 		goto exit_free;
 
 	data->hwmon_dev = hwmon_device_register(&new_client->dev);
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
