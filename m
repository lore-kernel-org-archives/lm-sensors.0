From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 18 Apr 2014 22:51:24 +0000
Subject: [lm-sensors] [PATCH 3/4] hwmon: (lm92) Drop function macros
Message-Id: <1397861485-31740-3-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Function macros obfuscate code and increase code size, so drop them.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm92.c |  165 +++++++++++++++++++++++++-------------------------
 1 file changed, 82 insertions(+), 83 deletions(-)

diff --git a/drivers/hwmon/lm92.c b/drivers/hwmon/lm92.c
index 7193a92..faa9a65 100644
--- a/drivers/hwmon/lm92.c
+++ b/drivers/hwmon/lm92.c
@@ -89,6 +89,23 @@ static inline u8 ALARMS_FROM_REG(s16 reg)
 	return reg & 0x0007;
 }
 
+enum temp_index {
+	t_input,
+	t_crit,
+	t_min,
+	t_max,
+	t_hyst,
+	t_num_regs,
+};
+
+static u8 regs[] = {
+	[t_input] = LM92_REG_TEMP,
+	[t_crit] = LM92_REG_TEMP_CRIT,
+	[t_min] = LM92_REG_TEMP_LOW,
+	[t_max] = LM92_REG_TEMP_HIGH,
+	[t_hyst] = LM92_REG_TEMP_HYST,
+};
+
 /* Client data (each client gets its own) */
 struct lm92_data {
 	struct device *hwmon_dev;
@@ -97,10 +114,9 @@ struct lm92_data {
 	unsigned long last_updated; /* in jiffies */
 
 	/* registers values */
-	s16 temp1_input, temp1_crit, temp1_min, temp1_max, temp1_hyst;
+	s16 temp[t_num_regs];	/* index with enum temp_index */
 };
 
-
 /*
  * Sysfs attributes and callback functions
  */
@@ -109,23 +125,17 @@ static struct lm92_data *lm92_update_device(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm92_data *data = i2c_get_clientdata(client);
+	int i;
 
 	mutex_lock(&data->update_lock);
 
 	if (time_after(jiffies, data->last_updated + HZ)
 	 || !data->valid) {
 		dev_dbg(&client->dev, "Updating lm92 data\n");
-		data->temp1_input = i2c_smbus_read_word_swapped(client,
-				    LM92_REG_TEMP);
-		data->temp1_hyst = i2c_smbus_read_word_swapped(client,
-				    LM92_REG_TEMP_HYST);
-		data->temp1_crit = i2c_smbus_read_word_swapped(client,
-				    LM92_REG_TEMP_CRIT);
-		data->temp1_min = i2c_smbus_read_word_swapped(client,
-				    LM92_REG_TEMP_LOW);
-		data->temp1_max = i2c_smbus_read_word_swapped(client,
-				    LM92_REG_TEMP_HIGH);
-
+		for (i = 0; i < t_num_regs; i++) {
+			data->temp[i] +				i2c_smbus_read_word_swapped(client, regs[i]);
+		}
 		data->last_updated = jiffies;
 		data->valid = 1;
 	}
@@ -135,66 +145,56 @@ static struct lm92_data *lm92_update_device(struct device *dev)
 	return data;
 }
 
-#define show_temp(value) \
-static ssize_t show_##value(struct device *dev, struct device_attribute *attr, \
-			    char *buf) \
-{ \
-	struct lm92_data *data = lm92_update_device(dev); \
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->value)); \
-}
-show_temp(temp1_input);
-show_temp(temp1_crit);
-show_temp(temp1_min);
-show_temp(temp1_max);
-
-#define set_temp(value, reg) \
-static ssize_t set_##value(struct device *dev, struct device_attribute *attr, \
-			   const char *buf, \
-	size_t count) \
-{ \
-	struct i2c_client *client = to_i2c_client(dev); \
-	struct lm92_data *data = i2c_get_clientdata(client); \
-	long val; \
-	int err = kstrtol(buf, 10, &val); \
-	if (err) \
-		return err; \
-\
-	mutex_lock(&data->update_lock); \
-	data->value = TEMP_TO_REG(val); \
-	i2c_smbus_write_word_swapped(client, reg, data->value); \
-	mutex_unlock(&data->update_lock); \
-	return count; \
+static ssize_t show_temp(struct device *dev, struct device_attribute *devattr,
+			 char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct lm92_data *data = lm92_update_device(dev);
+
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[attr->index]));
 }
-set_temp(temp1_crit, LM92_REG_TEMP_CRIT);
-set_temp(temp1_min, LM92_REG_TEMP_LOW);
-set_temp(temp1_max, LM92_REG_TEMP_HIGH);
 
-static ssize_t show_temp1_crit_hyst(struct device *dev,
-				    struct device_attribute *attr, char *buf)
+static ssize_t set_temp(struct device *dev, struct device_attribute *devattr,
+			   const char *buf, size_t count)
 {
-	struct lm92_data *data = lm92_update_device(dev);
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp1_crit)
-		       - TEMP_FROM_REG(data->temp1_hyst));
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm92_data *data = i2c_get_clientdata(client);
+	int nr = attr->index;
+	long val;
+	int err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
+
+	mutex_lock(&data->update_lock);
+	data->temp[nr] = TEMP_TO_REG(val);
+	i2c_smbus_write_word_swapped(client, regs[nr], data->temp[nr]);
+	mutex_unlock(&data->update_lock);
+	return count;
 }
-static ssize_t show_temp1_max_hyst(struct device *dev,
-				   struct device_attribute *attr, char *buf)
+
+static ssize_t show_temp_hyst(struct device *dev,
+			      struct device_attribute *devattr, char *buf)
 {
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct lm92_data *data = lm92_update_device(dev);
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp1_max)
-		       - TEMP_FROM_REG(data->temp1_hyst));
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[attr->index])
+		       - TEMP_FROM_REG(data->temp[t_hyst]));
 }
-static ssize_t show_temp1_min_hyst(struct device *dev,
-				   struct device_attribute *attr, char *buf)
+
+static ssize_t show_temp_min_hyst(struct device *dev,
+				  struct device_attribute *attr, char *buf)
 {
 	struct lm92_data *data = lm92_update_device(dev);
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp1_min)
-		       + TEMP_FROM_REG(data->temp1_hyst));
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[t_min])
+		       + TEMP_FROM_REG(data->temp[t_hyst]));
 }
 
-static ssize_t set_temp1_crit_hyst(struct device *dev,
-				   struct device_attribute *attr,
-				   const char *buf, size_t count)
+static ssize_t set_temp_hyst(struct device *dev,
+			     struct device_attribute *devattr,
+			     const char *buf, size_t count)
 {
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm92_data *data = i2c_get_clientdata(client);
 	long val;
@@ -205,9 +205,9 @@ static ssize_t set_temp1_crit_hyst(struct device *dev,
 		return err;
 
 	mutex_lock(&data->update_lock);
-	data->temp1_hyst = TEMP_FROM_REG(data->temp1_crit) - val;
+	data->temp[t_hyst] = TEMP_FROM_REG(data->temp[attr->index]) - val;
 	i2c_smbus_write_word_swapped(client, LM92_REG_TEMP_HYST,
-				     TEMP_TO_REG(data->temp1_hyst));
+				     TEMP_TO_REG(data->temp[t_hyst]));
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -216,7 +216,7 @@ static ssize_t show_alarms(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
 	struct lm92_data *data = lm92_update_device(dev);
-	return sprintf(buf, "%d\n", ALARMS_FROM_REG(data->temp1_input));
+	return sprintf(buf, "%d\n", ALARMS_FROM_REG(data->temp[t_input]));
 }
 
 static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
@@ -224,26 +224,25 @@ static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
 {
 	int bitnr = to_sensor_dev_attr(attr)->index;
 	struct lm92_data *data = lm92_update_device(dev);
-	return sprintf(buf, "%d\n", (data->temp1_input >> bitnr) & 1);
+	return sprintf(buf, "%d\n", (data->temp[t_input] >> bitnr) & 1);
 }
 
-static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp1_input, NULL);
-static DEVICE_ATTR(temp1_crit, S_IWUSR | S_IRUGO, show_temp1_crit,
-	set_temp1_crit);
-static DEVICE_ATTR(temp1_crit_hyst, S_IWUSR | S_IRUGO, show_temp1_crit_hyst,
-	set_temp1_crit_hyst);
-static DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO, show_temp1_min,
-	set_temp1_min);
-static DEVICE_ATTR(temp1_min_hyst, S_IRUGO, show_temp1_min_hyst, NULL);
-static DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp1_max,
-	set_temp1_max);
-static DEVICE_ATTR(temp1_max_hyst, S_IRUGO, show_temp1_max_hyst, NULL);
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, t_input);
+static SENSOR_DEVICE_ATTR(temp1_crit, S_IWUSR | S_IRUGO, show_temp, set_temp,
+			  t_crit);
+static SENSOR_DEVICE_ATTR(temp1_crit_hyst, S_IWUSR | S_IRUGO, show_temp_hyst,
+			  set_temp_hyst, t_crit);
+static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO, show_temp, set_temp,
+			  t_min);
+static DEVICE_ATTR(temp1_min_hyst, S_IRUGO, show_temp_min_hyst, NULL);
+static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp, set_temp,
+			  t_max);
+static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IRUGO, show_temp_hyst, NULL, t_max);
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
 static SENSOR_DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_alarm, NULL, 2);
 static SENSOR_DEVICE_ATTR(temp1_min_alarm, S_IRUGO, show_alarm, NULL, 0);
 static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_alarm, NULL, 1);
 
-
 /*
  * Detection and registration
  */
@@ -316,13 +315,13 @@ static int max6635_check(struct i2c_client *client)
 }
 
 static struct attribute *lm92_attributes[] = {
-	&dev_attr_temp1_input.attr,
-	&dev_attr_temp1_crit.attr,
-	&dev_attr_temp1_crit_hyst.attr,
-	&dev_attr_temp1_min.attr,
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_temp1_crit.dev_attr.attr,
+	&sensor_dev_attr_temp1_crit_hyst.dev_attr.attr,
+	&sensor_dev_attr_temp1_min.dev_attr.attr,
 	&dev_attr_temp1_min_hyst.attr,
-	&dev_attr_temp1_max.attr,
-	&dev_attr_temp1_max_hyst.attr,
+	&sensor_dev_attr_temp1_max.dev_attr.attr,
+	&sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
 	&dev_attr_alarms.attr,
 	&sensor_dev_attr_temp1_crit_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp1_min_alarm.dev_attr.attr,
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
