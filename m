From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 16 Apr 2014 02:28:52 +0000
Subject: [lm-sensors] [PATCH 4/6] hwmon: (lm80) Convert voltage display function macros into functions
Message-Id: <1397615334-30317-4-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert voltage display function macros into functions to reduce
code size and improve code readability.

Code size reduction is about 600 bytes on x86_64.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm80.c |  148 ++++++++++++++++++++++++++------------------------
 1 file changed, 76 insertions(+), 72 deletions(-)

diff --git a/drivers/hwmon/lm80.c b/drivers/hwmon/lm80.c
index a9749fd..ed062ad 100644
--- a/drivers/hwmon/lm80.c
+++ b/drivers/hwmon/lm80.c
@@ -109,6 +109,13 @@ static u8 temp_regs[] = {
 	[t_os_hyst] = LM80_REG_TEMP_OS_HYST,
 };
 
+enum in_index {
+	i_input = 0,
+	i_max,
+	i_min,
+	i_num_in
+};
+
 /*
  * Client data (each client gets its own)
  */
@@ -120,9 +127,7 @@ struct lm80_data {
 	char valid;		/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
 
-	u8 in[7];		/* Register value */
-	u8 in_max[7];		/* Register value */
-	u8 in_min[7];		/* Register value */
+	u8 in[i_num_in][7];	/* Register value, 1st index is enum in_index */
 	u8 fan[2];		/* Register value */
 	u8 fan_min[2];		/* Register value */
 	u8 fan_div[2];		/* Register encoding, shifted right */
@@ -168,40 +173,39 @@ static struct i2c_driver lm80_driver = {
  * Sysfs stuff
  */
 
-#define show_in(suffix, value) \
-static ssize_t show_in_##suffix(struct device *dev, \
-	struct device_attribute *attr, char *buf) \
-{ \
-	int nr = to_sensor_dev_attr(attr)->index; \
-	struct lm80_data *data = lm80_update_device(dev); \
-	if (IS_ERR(data)) \
-		return PTR_ERR(data); \
-	return sprintf(buf, "%d\n", IN_FROM_REG(data->value[nr])); \
+static ssize_t show_in(struct device *dev, struct device_attribute *attr,
+		       char *buf)
+{
+	struct lm80_data *data = lm80_update_device(dev);
+	int index = to_sensor_dev_attr_2(attr)->index;
+	int nr = to_sensor_dev_attr_2(attr)->nr;
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+	return sprintf(buf, "%d\n", IN_FROM_REG(data->in[nr][index]));
 }
-show_in(min, in_min)
-show_in(max, in_max)
-show_in(input, in)
 
-#define set_in(suffix, value, reg) \
-static ssize_t set_in_##suffix(struct device *dev, \
-	struct device_attribute *attr, const char *buf, size_t count) \
-{ \
-	int nr = to_sensor_dev_attr(attr)->index; \
-	struct lm80_data *data = dev_get_drvdata(dev); \
-	struct i2c_client *client = data->client; \
-	long val; \
-	int err = kstrtol(buf, 10, &val); \
-	if (err < 0) \
-		return err; \
-\
-	mutex_lock(&data->update_lock);\
-	data->value[nr] = IN_TO_REG(val); \
-	lm80_write_value(client, reg(nr), data->value[nr]); \
-	mutex_unlock(&data->update_lock);\
-	return count; \
+static ssize_t set_in(struct device *dev, struct device_attribute *attr,
+		      const char *buf, size_t count)
+{
+	struct lm80_data *data = dev_get_drvdata(dev);
+	struct i2c_client *client = data->client;
+	int index = to_sensor_dev_attr_2(attr)->index;
+	int nr = to_sensor_dev_attr_2(attr)->nr;
+	long val;
+	u8 reg;
+	int err = kstrtol(buf, 10, &val);
+	if (err < 0)
+		return err;
+
+	reg = nr = i_min ? LM80_REG_IN_MIN(index) : LM80_REG_IN_MAX(index);
+
+	mutex_lock(&data->update_lock);
+	data->in[nr][index] = IN_TO_REG(val);
+	lm80_write_value(client, reg, data->in[nr][index]);
+	mutex_unlock(&data->update_lock);
+	return count;
 }
-set_in(min, in_min, LM80_REG_IN_MIN)
-set_in(max, in_max, LM80_REG_IN_MAX)
 
 #define show_fan(suffix, value) \
 static ssize_t show_fan_##suffix(struct device *dev, \
@@ -349,41 +353,41 @@ static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
 	return sprintf(buf, "%u\n", (data->alarms >> bitnr) & 1);
 }
 
-static SENSOR_DEVICE_ATTR(in0_min, S_IWUSR | S_IRUGO,
-		show_in_min, set_in_min, 0);
-static SENSOR_DEVICE_ATTR(in1_min, S_IWUSR | S_IRUGO,
-		show_in_min, set_in_min, 1);
-static SENSOR_DEVICE_ATTR(in2_min, S_IWUSR | S_IRUGO,
-		show_in_min, set_in_min, 2);
-static SENSOR_DEVICE_ATTR(in3_min, S_IWUSR | S_IRUGO,
-		show_in_min, set_in_min, 3);
-static SENSOR_DEVICE_ATTR(in4_min, S_IWUSR | S_IRUGO,
-		show_in_min, set_in_min, 4);
-static SENSOR_DEVICE_ATTR(in5_min, S_IWUSR | S_IRUGO,
-		show_in_min, set_in_min, 5);
-static SENSOR_DEVICE_ATTR(in6_min, S_IWUSR | S_IRUGO,
-		show_in_min, set_in_min, 6);
-static SENSOR_DEVICE_ATTR(in0_max, S_IWUSR | S_IRUGO,
-		show_in_max, set_in_max, 0);
-static SENSOR_DEVICE_ATTR(in1_max, S_IWUSR | S_IRUGO,
-		show_in_max, set_in_max, 1);
-static SENSOR_DEVICE_ATTR(in2_max, S_IWUSR | S_IRUGO,
-		show_in_max, set_in_max, 2);
-static SENSOR_DEVICE_ATTR(in3_max, S_IWUSR | S_IRUGO,
-		show_in_max, set_in_max, 3);
-static SENSOR_DEVICE_ATTR(in4_max, S_IWUSR | S_IRUGO,
-		show_in_max, set_in_max, 4);
-static SENSOR_DEVICE_ATTR(in5_max, S_IWUSR | S_IRUGO,
-		show_in_max, set_in_max, 5);
-static SENSOR_DEVICE_ATTR(in6_max, S_IWUSR | S_IRUGO,
-		show_in_max, set_in_max, 6);
-static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, show_in_input, NULL, 0);
-static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, show_in_input, NULL, 1);
-static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, show_in_input, NULL, 2);
-static SENSOR_DEVICE_ATTR(in3_input, S_IRUGO, show_in_input, NULL, 3);
-static SENSOR_DEVICE_ATTR(in4_input, S_IRUGO, show_in_input, NULL, 4);
-static SENSOR_DEVICE_ATTR(in5_input, S_IRUGO, show_in_input, NULL, 5);
-static SENSOR_DEVICE_ATTR(in6_input, S_IRUGO, show_in_input, NULL, 6);
+static SENSOR_DEVICE_ATTR_2(in0_min, S_IWUSR | S_IRUGO,
+		show_in, set_in, i_min, 0);
+static SENSOR_DEVICE_ATTR_2(in1_min, S_IWUSR | S_IRUGO,
+		show_in, set_in, i_min, 1);
+static SENSOR_DEVICE_ATTR_2(in2_min, S_IWUSR | S_IRUGO,
+		show_in, set_in, i_min, 2);
+static SENSOR_DEVICE_ATTR_2(in3_min, S_IWUSR | S_IRUGO,
+		show_in, set_in, i_min, 3);
+static SENSOR_DEVICE_ATTR_2(in4_min, S_IWUSR | S_IRUGO,
+		show_in, set_in, i_min, 4);
+static SENSOR_DEVICE_ATTR_2(in5_min, S_IWUSR | S_IRUGO,
+		show_in, set_in, i_min, 5);
+static SENSOR_DEVICE_ATTR_2(in6_min, S_IWUSR | S_IRUGO,
+		show_in, set_in, i_min, 6);
+static SENSOR_DEVICE_ATTR_2(in0_max, S_IWUSR | S_IRUGO,
+		show_in, set_in, i_max, 0);
+static SENSOR_DEVICE_ATTR_2(in1_max, S_IWUSR | S_IRUGO,
+		show_in, set_in, i_max, 1);
+static SENSOR_DEVICE_ATTR_2(in2_max, S_IWUSR | S_IRUGO,
+		show_in, set_in, i_max, 2);
+static SENSOR_DEVICE_ATTR_2(in3_max, S_IWUSR | S_IRUGO,
+		show_in, set_in, i_max, 3);
+static SENSOR_DEVICE_ATTR_2(in4_max, S_IWUSR | S_IRUGO,
+		show_in, set_in, i_max, 4);
+static SENSOR_DEVICE_ATTR_2(in5_max, S_IWUSR | S_IRUGO,
+		show_in, set_in, i_max, 5);
+static SENSOR_DEVICE_ATTR_2(in6_max, S_IWUSR | S_IRUGO,
+		show_in, set_in, i_max, 6);
+static SENSOR_DEVICE_ATTR_2(in0_input, S_IRUGO, show_in, NULL, i_input, 0);
+static SENSOR_DEVICE_ATTR_2(in1_input, S_IRUGO, show_in, NULL, i_input, 1);
+static SENSOR_DEVICE_ATTR_2(in2_input, S_IRUGO, show_in, NULL, i_input, 2);
+static SENSOR_DEVICE_ATTR_2(in3_input, S_IRUGO, show_in, NULL, i_input, 3);
+static SENSOR_DEVICE_ATTR_2(in4_input, S_IRUGO, show_in, NULL, i_input, 4);
+static SENSOR_DEVICE_ATTR_2(in5_input, S_IRUGO, show_in, NULL, i_input, 5);
+static SENSOR_DEVICE_ATTR_2(in6_input, S_IRUGO, show_in, NULL, i_input, 6);
 static SENSOR_DEVICE_ATTR(fan1_min, S_IWUSR | S_IRUGO,
 		show_fan_min, set_fan_min, 0);
 static SENSOR_DEVICE_ATTR(fan2_min, S_IWUSR | S_IRUGO,
@@ -588,17 +592,17 @@ static struct lm80_data *lm80_update_device(struct device *dev)
 			rv = lm80_read_value(client, LM80_REG_IN(i));
 			if (rv < 0)
 				goto abort;
-			data->in[i] = rv;
+			data->in[i_input][i] = rv;
 
 			rv = lm80_read_value(client, LM80_REG_IN_MIN(i));
 			if (rv < 0)
 				goto abort;
-			data->in_min[i] = rv;
+			data->in[i_min][i] = rv;
 
 			rv = lm80_read_value(client, LM80_REG_IN_MAX(i));
 			if (rv < 0)
 				goto abort;
-			data->in_max[i] = rv;
+			data->in[i_max][i] = rv;
 		}
 
 		rv = lm80_read_value(client, LM80_REG_FAN1);
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
