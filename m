From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 16 Apr 2014 02:28:51 +0000
Subject: [lm-sensors] [PATCH 3/6] hwmon: (lm80) Convert temperature display function macros into functions
Message-Id: <1397615334-30317-3-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert temperature display function macros into functions to reduce
code size and improve code readability.

Code size reduction is about 2k on x86_64.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm80.c |  134 ++++++++++++++++++++++----------------------------
 1 file changed, 59 insertions(+), 75 deletions(-)

diff --git a/drivers/hwmon/lm80.c b/drivers/hwmon/lm80.c
index fe980d6..a9749fd 100644
--- a/drivers/hwmon/lm80.c
+++ b/drivers/hwmon/lm80.c
@@ -92,6 +92,23 @@ static inline unsigned char FAN_TO_REG(unsigned rpm, unsigned div)
 
 #define DIV_FROM_REG(val)		(1 << (val))
 
+enum temp_index {
+	t_input = 0,
+	t_hot_max,
+	t_hot_hyst,
+	t_os_max,
+	t_os_hyst,
+	t_num_temp
+};
+
+static u8 temp_regs[] = {
+	[t_input] = LM80_REG_TEMP,
+	[t_hot_max] = LM80_REG_TEMP_HOT_MAX,
+	[t_hot_hyst] = LM80_REG_TEMP_HOT_HYST,
+	[t_os_max] = LM80_REG_TEMP_OS_MAX,
+	[t_os_hyst] = LM80_REG_TEMP_OS_HYST,
+};
+
 /*
  * Client data (each client gets its own)
  */
@@ -109,11 +126,7 @@ struct lm80_data {
 	u8 fan[2];		/* Register value */
 	u8 fan_min[2];		/* Register value */
 	u8 fan_div[2];		/* Register encoding, shifted right */
-	s16 temp;		/* Register values */
-	s16 temp_hot_max;	/* Register value, left shifted */
-	s16 temp_hot_hyst;	/* Register value, left shifted */
-	s16 temp_os_max;	/* Register value, left shifted */
-	s16 temp_os_hyst;	/* Register value, left shifted */
+	s16 temp[t_num_temp];	/* Register values, normalized to 16 bit */
 	u16 alarms;		/* Register encoding, combined */
 };
 
@@ -288,50 +301,34 @@ static ssize_t set_fan_div(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-static ssize_t show_temp_input1(struct device *dev,
-	struct device_attribute *attr, char *buf)
+static ssize_t show_temp(struct device *dev, struct device_attribute *devattr,
+			 char *buf)
 {
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct lm80_data *data = lm80_update_device(dev);
 	if (IS_ERR(data))
 		return PTR_ERR(data);
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp));
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[attr->index]));
 }
 
-#define show_temp(suffix, value) \
-static ssize_t show_temp_##suffix(struct device *dev, \
-	struct device_attribute *attr, char *buf) \
-{ \
-	struct lm80_data *data = lm80_update_device(dev); \
-	if (IS_ERR(data)) \
-		return PTR_ERR(data); \
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->value)); \
-}
-show_temp(hot_max, temp_hot_max);
-show_temp(hot_hyst, temp_hot_hyst);
-show_temp(os_max, temp_os_max);
-show_temp(os_hyst, temp_os_hyst);
+static ssize_t set_temp(struct device *dev, struct device_attribute *devattr,
+			const char *buf, size_t count)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct lm80_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
+	int nr = attr->index;
+	long val;
+	int err = kstrtol(buf, 10, &val);
+	if (err < 0)
+		return err;
 
-#define set_temp(suffix, value, reg) \
-static ssize_t set_temp_##suffix(struct device *dev, \
-	struct device_attribute *attr, const char *buf, size_t count) \
-{ \
-	struct lm80_data *data = dev_get_drvdata(dev); \
-	struct i2c_client *client = data->client; \
-	long val; \
-	int err = kstrtol(buf, 10, &val); \
-	if (err < 0) \
-		return err; \
-\
-	mutex_lock(&data->update_lock); \
-	data->value = TEMP_TO_REG(val); \
-	lm80_write_value(client, reg, data->value >> 8); \
-	mutex_unlock(&data->update_lock); \
-	return count; \
+	mutex_lock(&data->update_lock);
+	data->temp[nr] = TEMP_TO_REG(val);
+	lm80_write_value(client, temp_regs[nr], data->temp[nr] >> 8);
+	mutex_unlock(&data->update_lock);
+	return count;
 }
-set_temp(hot_max, temp_hot_max, LM80_REG_TEMP_HOT_MAX);
-set_temp(hot_hyst, temp_hot_hyst, LM80_REG_TEMP_HOT_HYST);
-set_temp(os_max, temp_os_max, LM80_REG_TEMP_OS_MAX);
-set_temp(os_hyst, temp_os_hyst, LM80_REG_TEMP_OS_HYST);
 
 static ssize_t show_alarms(struct device *dev, struct device_attribute *attr,
 			   char *buf)
@@ -397,15 +394,15 @@ static SENSOR_DEVICE_ATTR(fan1_div, S_IWUSR | S_IRUGO,
 		show_fan_div, set_fan_div, 0);
 static SENSOR_DEVICE_ATTR(fan2_div, S_IWUSR | S_IRUGO,
 		show_fan_div, set_fan_div, 1);
-static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_input1, NULL);
-static DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_hot_max,
-	set_temp_hot_max);
-static DEVICE_ATTR(temp1_max_hyst, S_IWUSR | S_IRUGO, show_temp_hot_hyst,
-	set_temp_hot_hyst);
-static DEVICE_ATTR(temp1_crit, S_IWUSR | S_IRUGO, show_temp_os_max,
-	set_temp_os_max);
-static DEVICE_ATTR(temp1_crit_hyst, S_IWUSR | S_IRUGO, show_temp_os_hyst,
-	set_temp_os_hyst);
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, t_input);
+static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp,
+		set_temp, t_hot_max);
+static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IWUSR | S_IRUGO, show_temp,
+		set_temp, t_hot_hyst);
+static SENSOR_DEVICE_ATTR(temp1_crit, S_IWUSR | S_IRUGO, show_temp,
+		set_temp, t_os_max);
+static SENSOR_DEVICE_ATTR(temp1_crit_hyst, S_IWUSR | S_IRUGO, show_temp,
+		set_temp, t_os_hyst);
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
 static SENSOR_DEVICE_ATTR(in0_alarm, S_IRUGO, show_alarm, NULL, 0);
 static SENSOR_DEVICE_ATTR(in1_alarm, S_IRUGO, show_alarm, NULL, 1);
@@ -451,11 +448,11 @@ static struct attribute *lm80_attrs[] = {
 	&sensor_dev_attr_fan2_input.dev_attr.attr,
 	&sensor_dev_attr_fan1_div.dev_attr.attr,
 	&sensor_dev_attr_fan2_div.dev_attr.attr,
-	&dev_attr_temp1_input.attr,
-	&dev_attr_temp1_max.attr,
-	&dev_attr_temp1_max_hyst.attr,
-	&dev_attr_temp1_crit.attr,
-	&dev_attr_temp1_crit_hyst.attr,
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_temp1_max.dev_attr.attr,
+	&sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
+	&sensor_dev_attr_temp1_crit.dev_attr.attr,
+	&sensor_dev_attr_temp1_crit_hyst.dev_attr.attr,
 	&dev_attr_alarms.attr,
 	&sensor_dev_attr_in0_alarm.dev_attr.attr,
 	&sensor_dev_attr_in1_alarm.dev_attr.attr,
@@ -630,27 +627,14 @@ static struct lm80_data *lm80_update_device(struct device *dev)
 		rv = lm80_read_value(client, LM80_REG_RES);
 		if (rv < 0)
 			goto abort;
-		data->temp = (prev_rv << 8) | (rv & 0xf0);
+		data->temp[t_input] = (prev_rv << 8) | (rv & 0xf0);
 
-		rv = lm80_read_value(client, LM80_REG_TEMP_OS_MAX);
-		if (rv < 0)
-			goto abort;
-		data->temp_os_max = rv << 8;
-
-		rv = lm80_read_value(client, LM80_REG_TEMP_OS_HYST);
-		if (rv < 0)
-			goto abort;
-		data->temp_os_hyst = rv << 8;
-
-		rv = lm80_read_value(client, LM80_REG_TEMP_HOT_MAX);
-		if (rv < 0)
-			goto abort;
-		data->temp_hot_max = rv << 8;
-
-		rv = lm80_read_value(client, LM80_REG_TEMP_HOT_HYST);
-		if (rv < 0)
-			goto abort;
-		data->temp_hot_hyst = rv << 8;
+		for (i = t_input + 1; i < t_num_temp; i++) {
+			rv = lm80_read_value(client, temp_regs[i]);
+			if (rv < 0)
+				goto abort;
+			data->temp[i] = rv << 8;
+		}
 
 		rv = lm80_read_value(client, LM80_REG_FANDIV);
 		if (rv < 0)
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
