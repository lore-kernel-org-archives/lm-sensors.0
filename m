From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 25 Jan 2012 16:26:46 +0000
Subject: [lm-sensors] [PATCH v3] hwmon: (lm87) Fix checkpatch issues
Message-Id: <1327508806-23953-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

Fixed:
ERROR: do not use assignment in if condition
ERROR: space required after that close brace '}'
ERROR: space required after that ',' (ctx:VxV)
ERROR: spaces required around that '<' (ctx:VxV)
ERROR: trailing statements should be on next line
WARNING: line over 80 characters
WARNING: simple_strtol is obsolete, use kstrtol instead
WARNING: simple_strtoul is obsolete, use kstrtoul instead

Modify multi-line comments to follow Documentation/CodingStyle.

Not fixed everywhere (code complexity):
ERROR: do not use assignment in if condition

As a side effect of the changes made, attribute set functions now return an
error if an attempt is made to write a non-numeric value. Previously, such
writes were interpreted as writing 0.

Cc: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Merged checkpatch and multi-line comment patches into a single patch
v3: Fixed some alignment issues. Added note to commit log describing that
    set functions now return error codes.

 drivers/hwmon/lm87.c |  257 ++++++++++++++++++++++++++++++++++----------------
 1 files changed, 174 insertions(+), 83 deletions(-)

diff --git a/drivers/hwmon/lm87.c b/drivers/hwmon/lm87.c
index 126d0cc..0216592 100644
--- a/drivers/hwmon/lm87.c
+++ b/drivers/hwmon/lm87.c
@@ -119,20 +119,21 @@ static u8 LM87_REG_TEMP_LOW[3] = { 0x3A, 0x38, 0x2C };
  * The LM87 uses signed 8-bit values for temperatures.
  */
 
-#define IN_FROM_REG(reg,scale)	(((reg) * (scale) + 96) / 192)
-#define IN_TO_REG(val,scale)	((val) <= 0 ? 0 : \
+#define IN_FROM_REG(reg, scale)	(((reg) * (scale) + 96) / 192)
+#define IN_TO_REG(val, scale)	((val) <= 0 ? 0 : \
 				 (val) * 192 >= (scale) * 255 ? 255 : \
-				 ((val) * 192 + (scale)/2) / (scale))
+				 ((val) * 192 + (scale) / 2) / (scale))
 
 #define TEMP_FROM_REG(reg)	((reg) * 1000)
 #define TEMP_TO_REG(val)	((val) <= -127500 ? -128 : \
 				 (val) >= 126500 ? 127 : \
-				 (((val) < 0 ? (val)-500 : (val)+500) / 1000))
+				 (((val) < 0 ? (val) - 500 : \
+				   (val) + 500) / 1000))
 
-#define FAN_FROM_REG(reg,div)	((reg) = 255 || (reg) = 0 ? 0 : \
-				 (1350000 + (reg)*(div) / 2) / ((reg)*(div)))
-#define FAN_TO_REG(val,div)	((val)*(div) * 255 <= 1350000 ? 255 : \
-				 (1350000 + (val)*(div) / 2) / ((val)*(div)))
+#define FAN_FROM_REG(reg, div)	((reg) = 255 || (reg) = 0 ? 0 : \
+				 (1350000 + (reg)*(div) / 2) / ((reg) * (div)))
+#define FAN_TO_REG(val, div)	((val) * (div) * 255 <= 1350000 ? 255 : \
+				 (1350000 + (val)*(div) / 2) / ((val) * (div)))
 
 #define FAN_DIV_FROM_REG(reg)	(1 << (reg))
 
@@ -232,19 +233,23 @@ static inline int lm87_write_value(struct i2c_client *client, u8 reg, u8 value)
 }
 
 #define show_in(offset) \
-static ssize_t show_in##offset##_input(struct device *dev, struct device_attribute *attr, char *buf) \
+static ssize_t show_in##offset##_input(struct device *dev, \
+				       struct device_attribute *attr, \
+				       char *buf) \
 { \
 	struct lm87_data *data = lm87_update_device(dev); \
 	return sprintf(buf, "%u\n", IN_FROM_REG(data->in[offset], \
 		       data->in_scale[offset])); \
 } \
-static ssize_t show_in##offset##_min(struct device *dev, struct device_attribute *attr, char *buf) \
+static ssize_t show_in##offset##_min(struct device *dev, \
+				     struct device_attribute *attr, char *buf) \
 { \
 	struct lm87_data *data = lm87_update_device(dev); \
 	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_min[offset], \
 		       data->in_scale[offset])); \
 } \
-static ssize_t show_in##offset##_max(struct device *dev, struct device_attribute *attr, char *buf) \
+static ssize_t show_in##offset##_max(struct device *dev, \
+				     struct device_attribute *attr, char *buf) \
 { \
 	struct lm87_data *data = lm87_update_device(dev); \
 	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_max[offset], \
@@ -261,44 +266,58 @@ show_in(5);
 show_in(6);
 show_in(7);
 
-static void set_in_min(struct device *dev, const char *buf, int nr)
+static ssize_t set_in_min(struct device *dev, const char *buf, int nr,
+			  size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm87_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->in_min[nr] = IN_TO_REG(val, data->in_scale[nr]);
-	lm87_write_value(client, nr<6 ? LM87_REG_IN_MIN(nr) :
-			 LM87_REG_AIN_MIN(nr-6), data->in_min[nr]);
+	lm87_write_value(client, nr < 6 ? LM87_REG_IN_MIN(nr) :
+			 LM87_REG_AIN_MIN(nr - 6), data->in_min[nr]);
 	mutex_unlock(&data->update_lock);
+	return count;
 }
 
-static void set_in_max(struct device *dev, const char *buf, int nr)
+static ssize_t set_in_max(struct device *dev, const char *buf, int nr,
+			  size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm87_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->in_max[nr] = IN_TO_REG(val, data->in_scale[nr]);
-	lm87_write_value(client, nr<6 ? LM87_REG_IN_MAX(nr) :
-			 LM87_REG_AIN_MAX(nr-6), data->in_max[nr]);
+	lm87_write_value(client, nr < 6 ? LM87_REG_IN_MAX(nr) :
+			 LM87_REG_AIN_MAX(nr - 6), data->in_max[nr]);
 	mutex_unlock(&data->update_lock);
+	return count;
 }
 
 #define set_in(offset) \
-static ssize_t set_in##offset##_min(struct device *dev, struct device_attribute *attr, \
-		const char *buf, size_t count) \
+static ssize_t set_in##offset##_min(struct device *dev, \
+				    struct device_attribute *attr, \
+				    const char *buf, size_t count) \
 { \
-	set_in_min(dev, buf, offset); \
-	return count; \
+	return set_in_min(dev, buf, offset, count); \
 } \
-static ssize_t set_in##offset##_max(struct device *dev, struct device_attribute *attr, \
-		const char *buf, size_t count) \
+static ssize_t set_in##offset##_max(struct device *dev, \
+				    struct device_attribute *attr, \
+				    const char *buf, size_t count) \
 { \
-	set_in_max(dev, buf, offset); \
-	return count; \
+	return set_in_max(dev, buf, offset, count); \
 } \
 static DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR, \
 		show_in##offset##_min, set_in##offset##_min); \
@@ -314,63 +333,85 @@ set_in(6);
 set_in(7);
 
 #define show_temp(offset) \
-static ssize_t show_temp##offset##_input(struct device *dev, struct device_attribute *attr, char *buf) \
+static ssize_t show_temp##offset##_input(struct device *dev, \
+					 struct device_attribute *attr, \
+					 char *buf) \
 { \
 	struct lm87_data *data = lm87_update_device(dev); \
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[offset-1])); \
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[offset - 1])); \
 } \
-static ssize_t show_temp##offset##_low(struct device *dev, struct device_attribute *attr, char *buf) \
+static ssize_t show_temp##offset##_low(struct device *dev, \
+				       struct device_attribute *attr, \
+				       char *buf) \
 { \
 	struct lm87_data *data = lm87_update_device(dev); \
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_low[offset-1])); \
+	return sprintf(buf, "%d\n", \
+		       TEMP_FROM_REG(data->temp_low[offset - 1])); \
 } \
-static ssize_t show_temp##offset##_high(struct device *dev, struct device_attribute *attr, char *buf) \
+static ssize_t show_temp##offset##_high(struct device *dev, \
+					struct device_attribute *attr, \
+					char *buf) \
 { \
 	struct lm87_data *data = lm87_update_device(dev); \
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_high[offset-1])); \
-}\
+	return sprintf(buf, "%d\n", \
+		       TEMP_FROM_REG(data->temp_high[offset - 1])); \
+} \
 static DEVICE_ATTR(temp##offset##_input, S_IRUGO, \
 		show_temp##offset##_input, NULL);
 show_temp(1);
 show_temp(2);
 show_temp(3);
 
-static void set_temp_low(struct device *dev, const char *buf, int nr)
+static ssize_t set_temp_low(struct device *dev, const char *buf, int nr,
+			    size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm87_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->temp_low[nr] = TEMP_TO_REG(val);
 	lm87_write_value(client, LM87_REG_TEMP_LOW[nr], data->temp_low[nr]);
 	mutex_unlock(&data->update_lock);
+	return count;
 }
 
-static void set_temp_high(struct device *dev, const char *buf, int nr)
+static ssize_t set_temp_high(struct device *dev, const char *buf, int nr,
+			     size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm87_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->temp_high[nr] = TEMP_TO_REG(val);
 	lm87_write_value(client, LM87_REG_TEMP_HIGH[nr], data->temp_high[nr]);
 	mutex_unlock(&data->update_lock);
+	return count;
 }
 
 #define set_temp(offset) \
-static ssize_t set_temp##offset##_low(struct device *dev, struct device_attribute *attr, \
-		const char *buf, size_t count) \
+static ssize_t set_temp##offset##_low(struct device *dev, \
+				      struct device_attribute *attr, \
+				      const char *buf, size_t count) \
 { \
-	set_temp_low(dev, buf, offset-1); \
-	return count; \
+	return set_temp_low(dev, buf, offset - 1, count); \
 } \
-static ssize_t set_temp##offset##_high(struct device *dev, struct device_attribute *attr, \
-		const char *buf, size_t count) \
+static ssize_t set_temp##offset##_high(struct device *dev, \
+				       struct device_attribute *attr, \
+				       const char *buf, size_t count) \
 { \
-	set_temp_high(dev, buf, offset-1); \
-	return count; \
+	return set_temp_high(dev, buf, offset - 1, count); \
 } \
 static DEVICE_ATTR(temp##offset##_max, S_IRUGO | S_IWUSR, \
 		show_temp##offset##_high, set_temp##offset##_high); \
@@ -380,13 +421,15 @@ set_temp(1);
 set_temp(2);
 set_temp(3);
 
-static ssize_t show_temp_crit_int(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_temp_crit_int(struct device *dev,
+				  struct device_attribute *attr, char *buf)
 {
 	struct lm87_data *data = lm87_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_crit_int));
 }
 
-static ssize_t show_temp_crit_ext(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_temp_crit_ext(struct device *dev,
+				  struct device_attribute *attr, char *buf)
 {
 	struct lm87_data *data = lm87_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_crit_ext));
@@ -397,63 +440,92 @@ static DEVICE_ATTR(temp2_crit, S_IRUGO, show_temp_crit_ext, NULL);
 static DEVICE_ATTR(temp3_crit, S_IRUGO, show_temp_crit_ext, NULL);
 
 #define show_fan(offset) \
-static ssize_t show_fan##offset##_input(struct device *dev, struct device_attribute *attr, char *buf) \
+static ssize_t show_fan##offset##_input(struct device *dev, \
+					struct device_attribute *attr, \
+					char *buf) \
 { \
 	struct lm87_data *data = lm87_update_device(dev); \
-	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[offset-1], \
-		       FAN_DIV_FROM_REG(data->fan_div[offset-1]))); \
+	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[offset - 1], \
+		       FAN_DIV_FROM_REG(data->fan_div[offset - 1]))); \
 } \
-static ssize_t show_fan##offset##_min(struct device *dev, struct device_attribute *attr, char *buf) \
+static ssize_t show_fan##offset##_min(struct device *dev, \
+				      struct device_attribute *attr, \
+				      char *buf) \
 { \
 	struct lm87_data *data = lm87_update_device(dev); \
-	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan_min[offset-1], \
-		       FAN_DIV_FROM_REG(data->fan_div[offset-1]))); \
+	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan_min[offset - 1], \
+		       FAN_DIV_FROM_REG(data->fan_div[offset - 1]))); \
 } \
-static ssize_t show_fan##offset##_div(struct device *dev, struct device_attribute *attr, char *buf) \
+static ssize_t show_fan##offset##_div(struct device *dev, \
+				      struct device_attribute *attr, \
+				      char *buf) \
 { \
 	struct lm87_data *data = lm87_update_device(dev); \
-	return sprintf(buf, "%d\n", FAN_DIV_FROM_REG(data->fan_div[offset-1])); \
+	return sprintf(buf, "%d\n", \
+		       FAN_DIV_FROM_REG(data->fan_div[offset - 1])); \
 } \
 static DEVICE_ATTR(fan##offset##_input, S_IRUGO, \
 		show_fan##offset##_input, NULL);
 show_fan(1);
 show_fan(2);
 
-static void set_fan_min(struct device *dev, const char *buf, int nr)
+static ssize_t set_fan_min(struct device *dev, const char *buf, int nr,
+			   size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm87_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->fan_min[nr] = FAN_TO_REG(val,
 			    FAN_DIV_FROM_REG(data->fan_div[nr]));
 	lm87_write_value(client, LM87_REG_FAN_MIN(nr), data->fan_min[nr]);
 	mutex_unlock(&data->update_lock);
+	return count;
 }
 
-/* Note: we save and restore the fan minimum here, because its value is
-   determined in part by the fan clock divider.  This follows the principle
-   of least surprise; the user doesn't expect the fan minimum to change just
-   because the divider changed. */
+/*
+ * Note: we save and restore the fan minimum here, because its value is
+ * determined in part by the fan clock divider.  This follows the principle
+ * of least surprise; the user doesn't expect the fan minimum to change just
+ * because the divider changed.
+ */
 static ssize_t set_fan_div(struct device *dev, const char *buf,
 		size_t count, int nr)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm87_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
 	unsigned long min;
 	u8 reg;
 
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
+
 	mutex_lock(&data->update_lock);
 	min = FAN_FROM_REG(data->fan_min[nr],
 			   FAN_DIV_FROM_REG(data->fan_div[nr]));
 
 	switch (val) {
-	case 1: data->fan_div[nr] = 0; break;
-	case 2: data->fan_div[nr] = 1; break;
-	case 4: data->fan_div[nr] = 2; break;
-	case 8: data->fan_div[nr] = 3; break;
+	case 1:
+		data->fan_div[nr] = 0;
+		break;
+	case 2:
+		data->fan_div[nr] = 1;
+		break;
+	case 4:
+		data->fan_div[nr] = 2;
+		break;
+	case 8:
+		data->fan_div[nr] = 3;
+		break;
 	default:
 		mutex_unlock(&data->update_lock);
 		return -EINVAL;
@@ -479,16 +551,17 @@ static ssize_t set_fan_div(struct device *dev, const char *buf,
 }
 
 #define set_fan(offset) \
-static ssize_t set_fan##offset##_min(struct device *dev, struct device_attribute *attr, const char *buf, \
-		size_t count) \
+static ssize_t set_fan##offset##_min(struct device *dev, \
+				     struct device_attribute *attr, \
+				     const char *buf, size_t count) \
 { \
-	set_fan_min(dev, buf, offset-1); \
-	return count; \
+	return set_fan_min(dev, buf, offset - 1, count); \
 } \
-static ssize_t set_fan##offset##_div(struct device *dev, struct device_attribute *attr, const char *buf, \
-		size_t count) \
+static ssize_t set_fan##offset##_div(struct device *dev, \
+				     struct device_attribute *attr, \
+				     const char *buf, size_t count) \
 { \
-	return set_fan_div(dev, buf, count, offset-1); \
+	return set_fan_div(dev, buf, count, offset - 1); \
 } \
 static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR, \
 		show_fan##offset##_min, set_fan##offset##_min); \
@@ -497,43 +570,60 @@ static DEVICE_ATTR(fan##offset##_div, S_IRUGO | S_IWUSR, \
 set_fan(1);
 set_fan(2);
 
-static ssize_t show_alarms(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_alarms(struct device *dev, struct device_attribute *attr,
+			   char *buf)
 {
 	struct lm87_data *data = lm87_update_device(dev);
 	return sprintf(buf, "%d\n", data->alarms);
 }
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
 
-static ssize_t show_vid(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_vid(struct device *dev, struct device_attribute *attr,
+			char *buf)
 {
 	struct lm87_data *data = lm87_update_device(dev);
 	return sprintf(buf, "%d\n", vid_from_reg(data->vid, data->vrm));
 }
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
 
-static ssize_t show_vrm(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_vrm(struct device *dev, struct device_attribute *attr,
+			char *buf)
 {
 	struct lm87_data *data = dev_get_drvdata(dev);
 	return sprintf(buf, "%d\n", data->vrm);
 }
-static ssize_t set_vrm(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+static ssize_t set_vrm(struct device *dev, struct device_attribute *attr,
+		       const char *buf, size_t count)
 {
 	struct lm87_data *data = dev_get_drvdata(dev);
-	data->vrm = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
+	data->vrm = val;
 	return count;
 }
 static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm, set_vrm);
 
-static ssize_t show_aout(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_aout(struct device *dev, struct device_attribute *attr,
+			 char *buf)
 {
 	struct lm87_data *data = lm87_update_device(dev);
 	return sprintf(buf, "%d\n", AOUT_FROM_REG(data->aout));
 }
-static ssize_t set_aout(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+static ssize_t set_aout(struct device *dev, struct device_attribute *attr,
+			const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm87_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	mutex_lock(&data->update_lock);
 	data->aout = AOUT_TO_REG(val);
@@ -721,7 +811,8 @@ static int lm87_probe(struct i2c_client *new_client,
 	data->in_scale[7] = 1875;
 
 	/* Register sysfs hooks */
-	if ((err = sysfs_create_group(&new_client->dev.kobj, &lm87_group)))
+	err = sysfs_create_group(&new_client->dev.kobj, &lm87_group);
+	if (err)
 		goto exit_free;
 
 	if (data->channel & CHAN_NO_FAN(0)) {
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
