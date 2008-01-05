From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 05 Jan 2008 14:37:05 +0000
Subject: [lm-sensors] [PATCH 2/3] hwmon: (lm80) De-macro the sysfs callbacks
Message-Id: <20080105153705.515f89b4@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use standard dynamic sysfs callbacks instead of macro-generated
functions. This makes the code more readable, and the binary smaller
(by about 34%).

As a side note, another benefit of this type of cleanup is that they
shrink the build time. For example, this cleanup saves about 29% of
the lm80 driver build time.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
Tested using i2c-stub.

 drivers/hwmon/lm80.c |  245 ++++++++++++++++++++++----------------------------
 1 file changed, 111 insertions(+), 134 deletions(-)

--- linux-2.6.24-rc6.orig/drivers/hwmon/lm80.c	2008-01-05 15:16:33.000000000 +0100
+++ linux-2.6.24-rc6/drivers/hwmon/lm80.c	2008-01-05 15:22:49.000000000 +0100
@@ -27,6 +27,7 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
 
@@ -158,105 +159,74 @@ static struct i2c_driver lm80_driver = {
 #define show_in(suffix, value) \
 static ssize_t show_in_##suffix(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
+	int nr = to_sensor_dev_attr(attr)->index; \
 	struct lm80_data *data = lm80_update_device(dev); \
-	return sprintf(buf, "%d\n", IN_FROM_REG(data->value)); \
+	return sprintf(buf, "%d\n", IN_FROM_REG(data->value[nr])); \
 }
-show_in(min0, in_min[0]);
-show_in(min1, in_min[1]);
-show_in(min2, in_min[2]);
-show_in(min3, in_min[3]);
-show_in(min4, in_min[4]);
-show_in(min5, in_min[5]);
-show_in(min6, in_min[6]);
-show_in(max0, in_max[0]);
-show_in(max1, in_max[1]);
-show_in(max2, in_max[2]);
-show_in(max3, in_max[3]);
-show_in(max4, in_max[4]);
-show_in(max5, in_max[5]);
-show_in(max6, in_max[6]);
-show_in(input0, in[0]);
-show_in(input1, in[1]);
-show_in(input2, in[2]);
-show_in(input3, in[3]);
-show_in(input4, in[4]);
-show_in(input5, in[5]);
-show_in(input6, in[6]);
+show_in(min, in_min)
+show_in(max, in_max)
+show_in(input, in)
 
 #define set_in(suffix, value, reg) \
 static ssize_t set_in_##suffix(struct device *dev, struct device_attribute *attr, const char *buf, \
 	size_t count) \
 { \
+	int nr = to_sensor_dev_attr(attr)->index; \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct lm80_data *data = i2c_get_clientdata(client); \
 	long val = simple_strtol(buf, NULL, 10); \
  \
 	mutex_lock(&data->update_lock);\
-	data->value = IN_TO_REG(val); \
-	lm80_write_value(client, reg, data->value); \
+	data->value[nr] = IN_TO_REG(val); \
+	lm80_write_value(client, reg(nr), data->value[nr]); \
 	mutex_unlock(&data->update_lock);\
 	return count; \
 }
-set_in(min0, in_min[0], LM80_REG_IN_MIN(0));
-set_in(min1, in_min[1], LM80_REG_IN_MIN(1));
-set_in(min2, in_min[2], LM80_REG_IN_MIN(2));
-set_in(min3, in_min[3], LM80_REG_IN_MIN(3));
-set_in(min4, in_min[4], LM80_REG_IN_MIN(4));
-set_in(min5, in_min[5], LM80_REG_IN_MIN(5));
-set_in(min6, in_min[6], LM80_REG_IN_MIN(6));
-set_in(max0, in_max[0], LM80_REG_IN_MAX(0));
-set_in(max1, in_max[1], LM80_REG_IN_MAX(1));
-set_in(max2, in_max[2], LM80_REG_IN_MAX(2));
-set_in(max3, in_max[3], LM80_REG_IN_MAX(3));
-set_in(max4, in_max[4], LM80_REG_IN_MAX(4));
-set_in(max5, in_max[5], LM80_REG_IN_MAX(5));
-set_in(max6, in_max[6], LM80_REG_IN_MAX(6));
+set_in(min, in_min, LM80_REG_IN_MIN)
+set_in(max, in_max, LM80_REG_IN_MAX)
 
-#define show_fan(suffix, value, div) \
+#define show_fan(suffix, value) \
 static ssize_t show_fan_##suffix(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
+	int nr = to_sensor_dev_attr(attr)->index; \
 	struct lm80_data *data = lm80_update_device(dev); \
-	return sprintf(buf, "%d\n", FAN_FROM_REG(data->value, \
-		       DIV_FROM_REG(data->div))); \
+	return sprintf(buf, "%d\n", FAN_FROM_REG(data->value[nr], \
+		       DIV_FROM_REG(data->fan_div[nr]))); \
 }
-show_fan(min1, fan_min[0], fan_div[0]);
-show_fan(min2, fan_min[1], fan_div[1]);
-show_fan(input1, fan[0], fan_div[0]);
-show_fan(input2, fan[1], fan_div[1]);
+show_fan(min, fan_min)
+show_fan(input, fan)
 
-#define show_fan_div(suffix, value) \
-static ssize_t show_fan_div##suffix(struct device *dev, struct device_attribute *attr, char *buf) \
-{ \
-	struct lm80_data *data = lm80_update_device(dev); \
-	return sprintf(buf, "%d\n", DIV_FROM_REG(data->value)); \
+static ssize_t show_fan_div(struct device *dev, struct device_attribute *attr,
+	char *buf)
+{
+	int nr = to_sensor_dev_attr(attr)->index;
+	struct lm80_data *data = lm80_update_device(dev);
+	return sprintf(buf, "%d\n", DIV_FROM_REG(data->fan_div[nr]));
 }
-show_fan_div(1, fan_div[0]);
-show_fan_div(2, fan_div[1]);
 
-#define set_fan(suffix, value, reg, div) \
-static ssize_t set_fan_##suffix(struct device *dev, struct device_attribute *attr, const char *buf, \
-	size_t count) \
-{ \
-	struct i2c_client *client = to_i2c_client(dev); \
-	struct lm80_data *data = i2c_get_clientdata(client); \
-	long val = simple_strtoul(buf, NULL, 10); \
- \
-	mutex_lock(&data->update_lock);\
-	data->value = FAN_TO_REG(val, DIV_FROM_REG(data->div)); \
-	lm80_write_value(client, reg, data->value); \
-	mutex_unlock(&data->update_lock);\
-	return count; \
+static ssize_t set_fan_min(struct device *dev, struct device_attribute *attr,
+	const char *buf, size_t count)
+{
+	int nr = to_sensor_dev_attr(attr)->index;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm80_data *data = i2c_get_clientdata(client);
+	long val = simple_strtoul(buf, NULL, 10);
+
+	mutex_lock(&data->update_lock);
+	data->fan_min[nr] = FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
+	lm80_write_value(client, LM80_REG_FAN_MIN(nr + 1), data->fan_min[nr]);
+	mutex_unlock(&data->update_lock);
+	return count;
 }
-set_fan(min1, fan_min[0], LM80_REG_FAN_MIN(1), fan_div[0]);
-set_fan(min2, fan_min[1], LM80_REG_FAN_MIN(2), fan_div[1]);
 
 /* Note: we save and restore the fan minimum here, because its value is
    determined in part by the fan divisor.  This follows the principle of
    least surprise; the user doesn't expect the fan minimum to change just
    because the divisor changed. */
-static ssize_t set_fan_div(struct device *dev, const char *buf,
-	size_t count, int nr)
+static ssize_t set_fan_div(struct device *dev, struct device_attribute *attr,
+	const char *buf, size_t count)
 {
+	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm80_data *data = i2c_get_clientdata(client);
 	unsigned long min, val = simple_strtoul(buf, NULL, 10);
@@ -291,15 +261,6 @@ static ssize_t set_fan_div(struct device
 	return count;
 }
 
-#define set_fan_div(number) \
-static ssize_t set_fan_div##number(struct device *dev, struct device_attribute *attr, const char *buf, \
-	size_t count) \
-{ \
-	return set_fan_div(dev, buf, count, number - 1); \
-}
-set_fan_div(1);
-set_fan_div(2);
-
 static ssize_t show_temp_input1(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct lm80_data *data = lm80_update_device(dev);
@@ -343,35 +304,51 @@ static ssize_t show_alarms(struct device
 	return sprintf(buf, "%u\n", data->alarms);
 }
 
-static DEVICE_ATTR(in0_min, S_IWUSR | S_IRUGO, show_in_min0, set_in_min0);
-static DEVICE_ATTR(in1_min, S_IWUSR | S_IRUGO, show_in_min1, set_in_min1);
-static DEVICE_ATTR(in2_min, S_IWUSR | S_IRUGO, show_in_min2, set_in_min2);
-static DEVICE_ATTR(in3_min, S_IWUSR | S_IRUGO, show_in_min3, set_in_min3);
-static DEVICE_ATTR(in4_min, S_IWUSR | S_IRUGO, show_in_min4, set_in_min4);
-static DEVICE_ATTR(in5_min, S_IWUSR | S_IRUGO, show_in_min5, set_in_min5);
-static DEVICE_ATTR(in6_min, S_IWUSR | S_IRUGO, show_in_min6, set_in_min6);
-static DEVICE_ATTR(in0_max, S_IWUSR | S_IRUGO, show_in_max0, set_in_max0);
-static DEVICE_ATTR(in1_max, S_IWUSR | S_IRUGO, show_in_max1, set_in_max1);
-static DEVICE_ATTR(in2_max, S_IWUSR | S_IRUGO, show_in_max2, set_in_max2);
-static DEVICE_ATTR(in3_max, S_IWUSR | S_IRUGO, show_in_max3, set_in_max3);
-static DEVICE_ATTR(in4_max, S_IWUSR | S_IRUGO, show_in_max4, set_in_max4);
-static DEVICE_ATTR(in5_max, S_IWUSR | S_IRUGO, show_in_max5, set_in_max5);
-static DEVICE_ATTR(in6_max, S_IWUSR | S_IRUGO, show_in_max6, set_in_max6);
-static DEVICE_ATTR(in0_input, S_IRUGO, show_in_input0, NULL);
-static DEVICE_ATTR(in1_input, S_IRUGO, show_in_input1, NULL);
-static DEVICE_ATTR(in2_input, S_IRUGO, show_in_input2, NULL);
-static DEVICE_ATTR(in3_input, S_IRUGO, show_in_input3, NULL);
-static DEVICE_ATTR(in4_input, S_IRUGO, show_in_input4, NULL);
-static DEVICE_ATTR(in5_input, S_IRUGO, show_in_input5, NULL);
-static DEVICE_ATTR(in6_input, S_IRUGO, show_in_input6, NULL);
-static DEVICE_ATTR(fan1_min, S_IWUSR | S_IRUGO, show_fan_min1,
-    set_fan_min1);
-static DEVICE_ATTR(fan2_min, S_IWUSR | S_IRUGO, show_fan_min2,
-    set_fan_min2);
-static DEVICE_ATTR(fan1_input, S_IRUGO, show_fan_input1, NULL);
-static DEVICE_ATTR(fan2_input, S_IRUGO, show_fan_input2, NULL);
-static DEVICE_ATTR(fan1_div, S_IWUSR | S_IRUGO, show_fan_div1, set_fan_div1);
-static DEVICE_ATTR(fan2_div, S_IWUSR | S_IRUGO, show_fan_div2, set_fan_div2);
+static SENSOR_DEVICE_ATTR(in0_min, S_IWUSR | S_IRUGO,
+		show_in_min, set_in_min, 0);
+static SENSOR_DEVICE_ATTR(in1_min, S_IWUSR | S_IRUGO,
+		show_in_min, set_in_min, 1);
+static SENSOR_DEVICE_ATTR(in2_min, S_IWUSR | S_IRUGO,
+		show_in_min, set_in_min, 2);
+static SENSOR_DEVICE_ATTR(in3_min, S_IWUSR | S_IRUGO,
+		show_in_min, set_in_min, 3);
+static SENSOR_DEVICE_ATTR(in4_min, S_IWUSR | S_IRUGO,
+		show_in_min, set_in_min, 4);
+static SENSOR_DEVICE_ATTR(in5_min, S_IWUSR | S_IRUGO,
+		show_in_min, set_in_min, 5);
+static SENSOR_DEVICE_ATTR(in6_min, S_IWUSR | S_IRUGO,
+		show_in_min, set_in_min, 6);
+static SENSOR_DEVICE_ATTR(in0_max, S_IWUSR | S_IRUGO,
+		show_in_max, set_in_max, 0);
+static SENSOR_DEVICE_ATTR(in1_max, S_IWUSR | S_IRUGO,
+		show_in_max, set_in_max, 1);
+static SENSOR_DEVICE_ATTR(in2_max, S_IWUSR | S_IRUGO,
+		show_in_max, set_in_max, 2);
+static SENSOR_DEVICE_ATTR(in3_max, S_IWUSR | S_IRUGO,
+		show_in_max, set_in_max, 3);
+static SENSOR_DEVICE_ATTR(in4_max, S_IWUSR | S_IRUGO,
+		show_in_max, set_in_max, 4);
+static SENSOR_DEVICE_ATTR(in5_max, S_IWUSR | S_IRUGO,
+		show_in_max, set_in_max, 5);
+static SENSOR_DEVICE_ATTR(in6_max, S_IWUSR | S_IRUGO,
+		show_in_max, set_in_max, 6);
+static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, show_in_input, NULL, 0);
+static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, show_in_input, NULL, 1);
+static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, show_in_input, NULL, 2);
+static SENSOR_DEVICE_ATTR(in3_input, S_IRUGO, show_in_input, NULL, 3);
+static SENSOR_DEVICE_ATTR(in4_input, S_IRUGO, show_in_input, NULL, 4);
+static SENSOR_DEVICE_ATTR(in5_input, S_IRUGO, show_in_input, NULL, 5);
+static SENSOR_DEVICE_ATTR(in6_input, S_IRUGO, show_in_input, NULL, 6);
+static SENSOR_DEVICE_ATTR(fan1_min, S_IWUSR | S_IRUGO,
+		show_fan_min, set_fan_min, 0);
+static SENSOR_DEVICE_ATTR(fan2_min, S_IWUSR | S_IRUGO,
+		show_fan_min, set_fan_min, 1);
+static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, show_fan_input, NULL, 0);
+static SENSOR_DEVICE_ATTR(fan2_input, S_IRUGO, show_fan_input, NULL, 1);
+static SENSOR_DEVICE_ATTR(fan1_div, S_IWUSR | S_IRUGO,
+		show_fan_div, set_fan_div, 0);
+static SENSOR_DEVICE_ATTR(fan2_div, S_IWUSR | S_IRUGO,
+		show_fan_div, set_fan_div, 1);
 static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_input1, NULL);
 static DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_hot_max,
     set_temp_hot_max);
@@ -395,33 +372,33 @@ static int lm80_attach_adapter(struct i2
 }
 
 static struct attribute *lm80_attributes[] = {
-	&dev_attr_in0_min.attr,
-	&dev_attr_in1_min.attr,
-	&dev_attr_in2_min.attr,
-	&dev_attr_in3_min.attr,
-	&dev_attr_in4_min.attr,
-	&dev_attr_in5_min.attr,
-	&dev_attr_in6_min.attr,
-	&dev_attr_in0_max.attr,
-	&dev_attr_in1_max.attr,
-	&dev_attr_in2_max.attr,
-	&dev_attr_in3_max.attr,
-	&dev_attr_in4_max.attr,
-	&dev_attr_in5_max.attr,
-	&dev_attr_in6_max.attr,
-	&dev_attr_in0_input.attr,
-	&dev_attr_in1_input.attr,
-	&dev_attr_in2_input.attr,
-	&dev_attr_in3_input.attr,
-	&dev_attr_in4_input.attr,
-	&dev_attr_in5_input.attr,
-	&dev_attr_in6_input.attr,
-	&dev_attr_fan1_min.attr,
-	&dev_attr_fan2_min.attr,
-	&dev_attr_fan1_input.attr,
-	&dev_attr_fan2_input.attr,
-	&dev_attr_fan1_div.attr,
-	&dev_attr_fan2_div.attr,
+	&sensor_dev_attr_in0_min.dev_attr.attr,
+	&sensor_dev_attr_in1_min.dev_attr.attr,
+	&sensor_dev_attr_in2_min.dev_attr.attr,
+	&sensor_dev_attr_in3_min.dev_attr.attr,
+	&sensor_dev_attr_in4_min.dev_attr.attr,
+	&sensor_dev_attr_in5_min.dev_attr.attr,
+	&sensor_dev_attr_in6_min.dev_attr.attr,
+	&sensor_dev_attr_in0_max.dev_attr.attr,
+	&sensor_dev_attr_in1_max.dev_attr.attr,
+	&sensor_dev_attr_in2_max.dev_attr.attr,
+	&sensor_dev_attr_in3_max.dev_attr.attr,
+	&sensor_dev_attr_in4_max.dev_attr.attr,
+	&sensor_dev_attr_in5_max.dev_attr.attr,
+	&sensor_dev_attr_in6_max.dev_attr.attr,
+	&sensor_dev_attr_in0_input.dev_attr.attr,
+	&sensor_dev_attr_in1_input.dev_attr.attr,
+	&sensor_dev_attr_in2_input.dev_attr.attr,
+	&sensor_dev_attr_in3_input.dev_attr.attr,
+	&sensor_dev_attr_in4_input.dev_attr.attr,
+	&sensor_dev_attr_in5_input.dev_attr.attr,
+	&sensor_dev_attr_in6_input.dev_attr.attr,
+	&sensor_dev_attr_fan1_min.dev_attr.attr,
+	&sensor_dev_attr_fan2_min.dev_attr.attr,
+	&sensor_dev_attr_fan1_input.dev_attr.attr,
+	&sensor_dev_attr_fan2_input.dev_attr.attr,
+	&sensor_dev_attr_fan1_div.dev_attr.attr,
+	&sensor_dev_attr_fan2_div.dev_attr.attr,
 	&dev_attr_temp1_input.attr,
 	&dev_attr_temp1_max.attr,
 	&dev_attr_temp1_max_hyst.attr,


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
