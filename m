From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 26 Apr 2014 05:29:51 +0000
Subject: [lm-sensors] [PATCH 2/3] hwmon: (jc42) Convert function macros into functions
Message-Id: <1398490192-593-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert function macros into functions to make the code
easier to read and reduce code size.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/jc42.c |  182 ++++++++++++++++++++------------------------------
 1 file changed, 72 insertions(+), 110 deletions(-)

diff --git a/drivers/hwmon/jc42.c b/drivers/hwmon/jc42.c
index ba1a3f7..baa912a 100644
--- a/drivers/hwmon/jc42.c
+++ b/drivers/hwmon/jc42.c
@@ -161,6 +161,21 @@ static struct jc42_chips jc42_chips[] = {
 	{ STM_MANID, STTS3000_DEVID, STTS3000_DEVID_MASK },
 };
 
+enum temp_index {
+	t_input = 0,
+	t_crit,
+	t_min,
+	t_max,
+	t_num_temp
+};
+
+static const u8 temp_regs[t_num_temp] = {
+	[t_input] = JC42_REG_TEMP,
+	[t_crit] = JC42_REG_TEMP_CRITICAL,
+	[t_min] = JC42_REG_TEMP_LOWER,
+	[t_max] = JC42_REG_TEMP_UPPER,
+};
+
 /* Each client has this additional data */
 struct jc42_data {
 	struct i2c_client *client;
@@ -170,10 +185,7 @@ struct jc42_data {
 	unsigned long	last_updated;	/* In jiffies */
 	u16		orig_config;	/* original configuration */
 	u16		config;		/* current configuration */
-	u16		temp_input;	/* Temperatures */
-	u16		temp_crit;
-	u16		temp_min;
-	u16		temp_max;
+	u16		temp[t_num_temp];/* Temperatures */
 };
 
 #define JC42_TEMP_MIN_EXTENDED	(-40000)
@@ -207,40 +219,19 @@ static struct jc42_data *jc42_update_device(struct device *dev)
 	struct jc42_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
 	struct jc42_data *ret = data;
-	int val;
+	int i, val;
 
 	mutex_lock(&data->update_lock);
 
 	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
-		val = i2c_smbus_read_word_swapped(client, JC42_REG_TEMP);
-		if (val < 0) {
-			ret = ERR_PTR(val);
-			goto abort;
-		}
-		data->temp_input = val;
-
-		val = i2c_smbus_read_word_swapped(client,
-						  JC42_REG_TEMP_CRITICAL);
-		if (val < 0) {
-			ret = ERR_PTR(val);
-			goto abort;
-		}
-		data->temp_crit = val;
-
-		val = i2c_smbus_read_word_swapped(client, JC42_REG_TEMP_LOWER);
-		if (val < 0) {
-			ret = ERR_PTR(val);
-			goto abort;
+		for (i = 0; i < t_num_temp; i++) {
+			val = i2c_smbus_read_word_swapped(client, temp_regs[i]);
+			if (val < 0) {
+				ret = ERR_PTR(val);
+				goto abort;
+			}
+			data->temp[i] = val;
 		}
-		data->temp_min = val;
-
-		val = i2c_smbus_read_word_swapped(client, JC42_REG_TEMP_UPPER);
-		if (val < 0) {
-			ret = ERR_PTR(val);
-			goto abort;
-		}
-		data->temp_max = val;
-
 		data->last_updated = jiffies;
 		data->valid = true;
 	}
@@ -249,79 +240,55 @@ abort:
 	return ret;
 }
 
-/* sysfs stuff */
-
-/* read routines for temperature limits */
-#define show(value)	\
-static ssize_t show_##value(struct device *dev,				\
-			    struct device_attribute *attr,		\
-			    char *buf)					\
-{									\
-	struct jc42_data *data = jc42_update_device(dev);		\
-	if (IS_ERR(data))						\
-		return PTR_ERR(data);					\
-	return sprintf(buf, "%d\n", jc42_temp_from_reg(data->value));	\
-}
+/* sysfs functions */
 
-show(temp_input);
-show(temp_crit);
-show(temp_min);
-show(temp_max);
-
-/* read routines for hysteresis values */
-static ssize_t show_temp_crit_hyst(struct device *dev,
-				   struct device_attribute *attr, char *buf)
+static ssize_t show_temp(struct device *dev, struct device_attribute *devattr,
+			 char *buf)
 {
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct jc42_data *data = jc42_update_device(dev);
-	int temp, hyst;
-
 	if (IS_ERR(data))
 		return PTR_ERR(data);
-
-	temp = jc42_temp_from_reg(data->temp_crit);
-	hyst = jc42_hysteresis[(data->config & JC42_CFG_HYST_MASK)
-			       >> JC42_CFG_HYST_SHIFT];
-	return sprintf(buf, "%d\n", temp - hyst);
+	return sprintf(buf, "%d\n",
+		       jc42_temp_from_reg(data->temp[attr->index]));
 }
 
-static ssize_t show_temp_max_hyst(struct device *dev,
-				  struct device_attribute *attr, char *buf)
+static ssize_t show_temp_hyst(struct device *dev,
+			      struct device_attribute *devattr, char *buf)
 {
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct jc42_data *data = jc42_update_device(dev);
 	int temp, hyst;
 
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
-	temp = jc42_temp_from_reg(data->temp_max);
+	temp = jc42_temp_from_reg(data->temp[attr->index]);
 	hyst = jc42_hysteresis[(data->config & JC42_CFG_HYST_MASK)
 			       >> JC42_CFG_HYST_SHIFT];
 	return sprintf(buf, "%d\n", temp - hyst);
 }
 
-/* write routines */
-#define set(value, reg)	\
-static ssize_t set_##value(struct device *dev,				\
-			   struct device_attribute *attr,		\
-			   const char *buf, size_t count)		\
-{									\
-	struct jc42_data *data = dev_get_drvdata(dev);			\
-	int err, ret = count;						\
-	long val;							\
-	if (kstrtol(buf, 10, &val) < 0)					\
-		return -EINVAL;						\
-	mutex_lock(&data->update_lock);					\
-	data->value = jc42_temp_to_reg(val, data->extended);		\
-	err = i2c_smbus_write_word_swapped(data->client, reg, data->value); \
-	if (err < 0)							\
-		ret = err;						\
-	mutex_unlock(&data->update_lock);				\
-	return ret;							\
-}
+static ssize_t set_temp(struct device *dev, struct device_attribute *devattr,
+			const char *buf, size_t count)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct jc42_data *data = dev_get_drvdata(dev);
+	int err, ret = count;
+	int nr = attr->index;
+	long val;
 
-set(temp_min, JC42_REG_TEMP_LOWER);
-set(temp_max, JC42_REG_TEMP_UPPER);
-set(temp_crit, JC42_REG_TEMP_CRITICAL);
+	if (kstrtol(buf, 10, &val) < 0)
+		return -EINVAL;
+	mutex_lock(&data->update_lock);
+	data->temp[nr] = jc42_temp_to_reg(val, data->extended);
+	err = i2c_smbus_write_word_swapped(data->client, temp_regs[nr],
+					   data->temp[nr]);
+	if (err < 0)
+		ret = err;
+	mutex_unlock(&data->update_lock);
+	return ret;
+}
 
 /*
  * JC42.4 compliant chips only support four hysteresis values.
@@ -340,7 +307,7 @@ static ssize_t set_temp_crit_hyst(struct device *dev,
 	if (kstrtoul(buf, 10, &val) < 0)
 		return -EINVAL;
 
-	diff = jc42_temp_from_reg(data->temp_crit) - val;
+	diff = jc42_temp_from_reg(data->temp[t_crit]) - val;
 	hyst = 0;
 	if (diff > 0) {
 		if (diff < 2250)
@@ -372,25 +339,20 @@ static ssize_t show_alarm(struct device *dev,
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
-	val = data->temp_input;
+	val = data->temp[t_input];
 	if (bit != JC42_ALARM_CRIT_BIT && (data->config & JC42_CFG_CRIT_ONLY))
 		val = 0;
 	return sprintf(buf, "%u\n", (val >> bit) & 1);
 }
 
-static DEVICE_ATTR(temp1_input, S_IRUGO,
-		   show_temp_input, NULL);
-static DEVICE_ATTR(temp1_crit, S_IRUGO,
-		   show_temp_crit, set_temp_crit);
-static DEVICE_ATTR(temp1_min, S_IRUGO,
-		   show_temp_min, set_temp_min);
-static DEVICE_ATTR(temp1_max, S_IRUGO,
-		   show_temp_max, set_temp_max);
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, t_input);
+static SENSOR_DEVICE_ATTR(temp1_crit, S_IRUGO, show_temp, set_temp, t_crit);
+static SENSOR_DEVICE_ATTR(temp1_min, S_IRUGO, show_temp, set_temp, t_min);
+static SENSOR_DEVICE_ATTR(temp1_max, S_IRUGO, show_temp, set_temp, t_max);
 
-static DEVICE_ATTR(temp1_crit_hyst, S_IRUGO,
-		   show_temp_crit_hyst, set_temp_crit_hyst);
-static DEVICE_ATTR(temp1_max_hyst, S_IRUGO,
-		   show_temp_max_hyst, NULL);
+static SENSOR_DEVICE_ATTR(temp1_crit_hyst, S_IRUGO, show_temp_hyst,
+			  set_temp_crit_hyst, t_crit);
+static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IRUGO, show_temp_hyst, NULL, t_max);
 
 static SENSOR_DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_alarm, NULL,
 			  JC42_ALARM_CRIT_BIT);
@@ -400,12 +362,12 @@ static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_alarm, NULL,
 			  JC42_ALARM_MAX_BIT);
 
 static struct attribute *jc42_attributes[] = {
-	&dev_attr_temp1_input.attr,
-	&dev_attr_temp1_crit.attr,
-	&dev_attr_temp1_min.attr,
-	&dev_attr_temp1_max.attr,
-	&dev_attr_temp1_crit_hyst.attr,
-	&dev_attr_temp1_max_hyst.attr,
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_temp1_crit.dev_attr.attr,
+	&sensor_dev_attr_temp1_min.dev_attr.attr,
+	&sensor_dev_attr_temp1_max.dev_attr.attr,
+	&sensor_dev_attr_temp1_crit_hyst.dev_attr.attr,
+	&sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
 	&sensor_dev_attr_temp1_crit_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp1_min_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
@@ -420,12 +382,12 @@ static umode_t jc42_attribute_mode(struct kobject *kobj,
 	unsigned int config = data->config;
 	bool readonly;
 
-	if (attr = &dev_attr_temp1_crit.attr)
+	if (attr = &sensor_dev_attr_temp1_crit.dev_attr.attr)
 		readonly = config & JC42_CFG_TCRIT_LOCK;
-	else if (attr = &dev_attr_temp1_min.attr ||
-		 attr = &dev_attr_temp1_max.attr)
+	else if (attr = &sensor_dev_attr_temp1_min.dev_attr.attr ||
+		 attr = &sensor_dev_attr_temp1_max.dev_attr.attr)
 		readonly = config & JC42_CFG_EVENT_LOCK;
-	else if (attr = &dev_attr_temp1_crit_hyst.attr)
+	else if (attr = &sensor_dev_attr_temp1_crit_hyst.dev_attr.attr)
 		readonly = config & (JC42_CFG_EVENT_LOCK | JC42_CFG_TCRIT_LOCK);
 	else
 		readonly = true;
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
