From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 26 Jan 2012 14:43:24 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: (lm87) Get rid of macro-generated functions
Message-Id: <20120126154324.1c7d0702@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use SENSORS_DEVICE_ATTR instead of DEVICE_ATTR for most attributes,
so that the attribute number can be retrieved and it is no longer
necessary to generate functions using macros.

This shaves about 2 kB on the binary module size.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
Tested on an emulated LM87 chip.

 drivers/hwmon/lm87.c |  350 ++++++++++++++++++++++----------------------------
 1 file changed, 160 insertions(+), 190 deletions(-)

--- linux-3.3-rc1.orig/drivers/hwmon/lm87.c	2012-01-26 15:29:21.000000000 +0100
+++ linux-3.3-rc1/drivers/hwmon/lm87.c	2012-01-26 15:34:38.650952104 +0100
@@ -276,45 +276,41 @@ static struct lm87_data *lm87_update_dev
  * Sysfs stuff
  */
 
-#define show_in(offset) \
-static ssize_t show_in##offset##_input(struct device *dev, \
-				       struct device_attribute *attr, \
-				       char *buf) \
-{ \
-	struct lm87_data *data = lm87_update_device(dev); \
-	return sprintf(buf, "%u\n", IN_FROM_REG(data->in[offset], \
-		       data->in_scale[offset])); \
-} \
-static ssize_t show_in##offset##_min(struct device *dev, \
-				     struct device_attribute *attr, char *buf) \
-{ \
-	struct lm87_data *data = lm87_update_device(dev); \
-	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_min[offset], \
-		       data->in_scale[offset])); \
-} \
-static ssize_t show_in##offset##_max(struct device *dev, \
-				     struct device_attribute *attr, char *buf) \
-{ \
-	struct lm87_data *data = lm87_update_device(dev); \
-	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_max[offset], \
-		       data->in_scale[offset])); \
-} \
-static DEVICE_ATTR(in##offset##_input, S_IRUGO, \
-		show_in##offset##_input, NULL);
-show_in(0);
-show_in(1);
-show_in(2);
-show_in(3);
-show_in(4);
-show_in(5);
-show_in(6);
-show_in(7);
+static ssize_t show_in_input(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	struct lm87_data *data = lm87_update_device(dev);
+	int nr = to_sensor_dev_attr(attr)->index;
 
-static ssize_t set_in_min(struct device *dev, const char *buf, int nr,
-			  size_t count)
+	return sprintf(buf, "%u\n", IN_FROM_REG(data->in[nr],
+		       data->in_scale[nr]));
+}
+
+static ssize_t show_in_min(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct lm87_data *data = lm87_update_device(dev);
+	int nr = to_sensor_dev_attr(attr)->index;
+
+	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_min[nr],
+		       data->in_scale[nr]));
+}
+static ssize_t show_in_max(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct lm87_data *data = lm87_update_device(dev);
+	int nr = to_sensor_dev_attr(attr)->index;
+
+	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_max[nr],
+		       data->in_scale[nr]));
+}
+
+static ssize_t set_in_min(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm87_data *data = i2c_get_clientdata(client);
+	int nr = to_sensor_dev_attr(attr)->index;
 	long val;
 	int err;
 
@@ -330,11 +326,12 @@ static ssize_t set_in_min(struct device
 	return count;
 }
 
-static ssize_t set_in_max(struct device *dev, const char *buf, int nr,
-			  size_t count)
+static ssize_t set_in_max(struct device *dev,  struct device_attribute *attr,
+			  const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm87_data *data = i2c_get_clientdata(client);
+	int nr = to_sensor_dev_attr(attr)->index;
 	long val;
 	int err;
 
@@ -351,22 +348,12 @@ static ssize_t set_in_max(struct device
 }
 
 #define set_in(offset) \
-static ssize_t set_in##offset##_min(struct device *dev, \
-				    struct device_attribute *attr, \
-				    const char *buf, size_t count) \
-{ \
-	return set_in_min(dev, buf, offset, count); \
-} \
-static ssize_t set_in##offset##_max(struct device *dev, \
-				    struct device_attribute *attr, \
-				    const char *buf, size_t count) \
-{ \
-	return set_in_max(dev, buf, offset, count); \
-} \
-static DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR, \
-		show_in##offset##_min, set_in##offset##_min); \
-static DEVICE_ATTR(in##offset##_max, S_IRUGO | S_IWUSR, \
-		show_in##offset##_max, set_in##offset##_max);
+static SENSOR_DEVICE_ATTR(in##offset##_input, S_IRUGO, \
+		show_in_input, NULL, offset); \
+static SENSOR_DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR, \
+		show_in_min, set_in_min, offset); \
+static SENSOR_DEVICE_ATTR(in##offset##_max, S_IRUGO | S_IWUSR, \
+		show_in_max, set_in_max, offset)
 set_in(0);
 set_in(1);
 set_in(2);
@@ -376,41 +363,41 @@ set_in(5);
 set_in(6);
 set_in(7);
 
-#define show_temp(offset) \
-static ssize_t show_temp##offset##_input(struct device *dev, \
-					 struct device_attribute *attr, \
-					 char *buf) \
-{ \
-	struct lm87_data *data = lm87_update_device(dev); \
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[offset - 1])); \
-} \
-static ssize_t show_temp##offset##_low(struct device *dev, \
-				       struct device_attribute *attr, \
-				       char *buf) \
-{ \
-	struct lm87_data *data = lm87_update_device(dev); \
-	return sprintf(buf, "%d\n", \
-		       TEMP_FROM_REG(data->temp_low[offset - 1])); \
-} \
-static ssize_t show_temp##offset##_high(struct device *dev, \
-					struct device_attribute *attr, \
-					char *buf) \
-{ \
-	struct lm87_data *data = lm87_update_device(dev); \
-	return sprintf(buf, "%d\n", \
-		       TEMP_FROM_REG(data->temp_high[offset - 1])); \
-} \
-static DEVICE_ATTR(temp##offset##_input, S_IRUGO, \
-		show_temp##offset##_input, NULL);
-show_temp(1);
-show_temp(2);
-show_temp(3);
+static ssize_t show_temp_input(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct lm87_data *data = lm87_update_device(dev);
+	int nr = to_sensor_dev_attr(attr)->index;
 
-static ssize_t set_temp_low(struct device *dev, const char *buf, int nr,
-			    size_t count)
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[nr]));
+}
+
+static ssize_t show_temp_low(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	struct lm87_data *data = lm87_update_device(dev);
+	int nr = to_sensor_dev_attr(attr)->index;
+
+	return sprintf(buf, "%d\n",
+		       TEMP_FROM_REG(data->temp_low[nr]));
+}
+
+static ssize_t show_temp_high(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct lm87_data *data = lm87_update_device(dev);
+	int nr = to_sensor_dev_attr(attr)->index;
+
+	return sprintf(buf, "%d\n",
+		       TEMP_FROM_REG(data->temp_high[nr]));
+}
+
+static ssize_t set_temp_low(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm87_data *data = i2c_get_clientdata(client);
+	int nr = to_sensor_dev_attr(attr)->index;
 	long val;
 	int err;
 
@@ -425,11 +412,12 @@ static ssize_t set_temp_low(struct devic
 	return count;
 }
 
-static ssize_t set_temp_high(struct device *dev, const char *buf, int nr,
-			     size_t count)
+static ssize_t set_temp_high(struct device *dev, struct device_attribute *attr,
+			     const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm87_data *data = i2c_get_clientdata(client);
+	int nr = to_sensor_dev_attr(attr)->index;
 	long val;
 	int err;
 
@@ -445,22 +433,12 @@ static ssize_t set_temp_high(struct devi
 }
 
 #define set_temp(offset) \
-static ssize_t set_temp##offset##_low(struct device *dev, \
-				      struct device_attribute *attr, \
-				      const char *buf, size_t count) \
-{ \
-	return set_temp_low(dev, buf, offset - 1, count); \
-} \
-static ssize_t set_temp##offset##_high(struct device *dev, \
-				       struct device_attribute *attr, \
-				       const char *buf, size_t count) \
-{ \
-	return set_temp_high(dev, buf, offset - 1, count); \
-} \
-static DEVICE_ATTR(temp##offset##_max, S_IRUGO | S_IWUSR, \
-		show_temp##offset##_high, set_temp##offset##_high); \
-static DEVICE_ATTR(temp##offset##_min, S_IRUGO | S_IWUSR, \
-		show_temp##offset##_low, set_temp##offset##_low);
+static SENSOR_DEVICE_ATTR(temp##offset##_input, S_IRUGO, \
+		show_temp_input, NULL, offset - 1); \
+static SENSOR_DEVICE_ATTR(temp##offset##_max, S_IRUGO | S_IWUSR, \
+		show_temp_high, set_temp_high, offset - 1); \
+static SENSOR_DEVICE_ATTR(temp##offset##_min, S_IRUGO | S_IWUSR, \
+		show_temp_low, set_temp_low, offset - 1)
 set_temp(1);
 set_temp(2);
 set_temp(3);
@@ -483,41 +461,42 @@ static DEVICE_ATTR(temp1_crit, S_IRUGO,
 static DEVICE_ATTR(temp2_crit, S_IRUGO, show_temp_crit_ext, NULL);
 static DEVICE_ATTR(temp3_crit, S_IRUGO, show_temp_crit_ext, NULL);
 
-#define show_fan(offset) \
-static ssize_t show_fan##offset##_input(struct device *dev, \
-					struct device_attribute *attr, \
-					char *buf) \
-{ \
-	struct lm87_data *data = lm87_update_device(dev); \
-	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[offset - 1], \
-		       FAN_DIV_FROM_REG(data->fan_div[offset - 1]))); \
-} \
-static ssize_t show_fan##offset##_min(struct device *dev, \
-				      struct device_attribute *attr, \
-				      char *buf) \
-{ \
-	struct lm87_data *data = lm87_update_device(dev); \
-	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan_min[offset - 1], \
-		       FAN_DIV_FROM_REG(data->fan_div[offset - 1]))); \
-} \
-static ssize_t show_fan##offset##_div(struct device *dev, \
-				      struct device_attribute *attr, \
-				      char *buf) \
-{ \
-	struct lm87_data *data = lm87_update_device(dev); \
-	return sprintf(buf, "%d\n", \
-		       FAN_DIV_FROM_REG(data->fan_div[offset - 1])); \
-} \
-static DEVICE_ATTR(fan##offset##_input, S_IRUGO, \
-		show_fan##offset##_input, NULL);
-show_fan(1);
-show_fan(2);
+static ssize_t show_fan_input(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct lm87_data *data = lm87_update_device(dev);
+	int nr = to_sensor_dev_attr(attr)->index;
 
-static ssize_t set_fan_min(struct device *dev, const char *buf, int nr,
-			   size_t count)
+	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[nr],
+		       FAN_DIV_FROM_REG(data->fan_div[nr])));
+}
+
+static ssize_t show_fan_min(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	struct lm87_data *data = lm87_update_device(dev);
+	int nr = to_sensor_dev_attr(attr)->index;
+
+	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan_min[nr],
+		       FAN_DIV_FROM_REG(data->fan_div[nr])));
+}
+
+static ssize_t show_fan_div(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	struct lm87_data *data = lm87_update_device(dev);
+	int nr = to_sensor_dev_attr(attr)->index;
+
+	return sprintf(buf, "%d\n",
+		       FAN_DIV_FROM_REG(data->fan_div[nr]));
+}
+
+static ssize_t set_fan_min(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm87_data *data = i2c_get_clientdata(client);
+	int nr = to_sensor_dev_attr(attr)->index;
 	long val;
 	int err;
 
@@ -539,11 +518,12 @@ static ssize_t set_fan_min(struct device
  * of least surprise; the user doesn't expect the fan minimum to change just
  * because the divider changed.
  */
-static ssize_t set_fan_div(struct device *dev, const char *buf,
-		size_t count, int nr)
+static ssize_t set_fan_div(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm87_data *data = i2c_get_clientdata(client);
+	int nr = to_sensor_dev_attr(attr)->index;
 	long val;
 	int err;
 	unsigned long min;
@@ -595,22 +575,12 @@ static ssize_t set_fan_div(struct device
 }
 
 #define set_fan(offset) \
-static ssize_t set_fan##offset##_min(struct device *dev, \
-				     struct device_attribute *attr, \
-				     const char *buf, size_t count) \
-{ \
-	return set_fan_min(dev, buf, offset - 1, count); \
-} \
-static ssize_t set_fan##offset##_div(struct device *dev, \
-				     struct device_attribute *attr, \
-				     const char *buf, size_t count) \
-{ \
-	return set_fan_div(dev, buf, count, offset - 1); \
-} \
-static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR, \
-		show_fan##offset##_min, set_fan##offset##_min); \
-static DEVICE_ATTR(fan##offset##_div, S_IRUGO | S_IWUSR, \
-		show_fan##offset##_div, set_fan##offset##_div);
+static SENSOR_DEVICE_ATTR(fan##offset##_input, S_IRUGO, \
+		show_fan_input, NULL, offset - 1); \
+static SENSOR_DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR, \
+		show_fan_min, set_fan_min, offset - 1); \
+static SENSOR_DEVICE_ATTR(fan##offset##_div, S_IRUGO | S_IWUSR, \
+		show_fan_div, set_fan_div, offset - 1)
 set_fan(1);
 set_fan(2);
 
@@ -705,31 +675,31 @@ static SENSOR_DEVICE_ATTR(temp3_fault, S
  */
 
 static struct attribute *lm87_attributes[] = {
-	&dev_attr_in1_input.attr,
-	&dev_attr_in1_min.attr,
-	&dev_attr_in1_max.attr,
+	&sensor_dev_attr_in1_input.dev_attr.attr,
+	&sensor_dev_attr_in1_min.dev_attr.attr,
+	&sensor_dev_attr_in1_max.dev_attr.attr,
 	&sensor_dev_attr_in1_alarm.dev_attr.attr,
-	&dev_attr_in2_input.attr,
-	&dev_attr_in2_min.attr,
-	&dev_attr_in2_max.attr,
+	&sensor_dev_attr_in2_input.dev_attr.attr,
+	&sensor_dev_attr_in2_min.dev_attr.attr,
+	&sensor_dev_attr_in2_max.dev_attr.attr,
 	&sensor_dev_attr_in2_alarm.dev_attr.attr,
-	&dev_attr_in3_input.attr,
-	&dev_attr_in3_min.attr,
-	&dev_attr_in3_max.attr,
+	&sensor_dev_attr_in3_input.dev_attr.attr,
+	&sensor_dev_attr_in3_min.dev_attr.attr,
+	&sensor_dev_attr_in3_max.dev_attr.attr,
 	&sensor_dev_attr_in3_alarm.dev_attr.attr,
-	&dev_attr_in4_input.attr,
-	&dev_attr_in4_min.attr,
-	&dev_attr_in4_max.attr,
+	&sensor_dev_attr_in4_input.dev_attr.attr,
+	&sensor_dev_attr_in4_min.dev_attr.attr,
+	&sensor_dev_attr_in4_max.dev_attr.attr,
 	&sensor_dev_attr_in4_alarm.dev_attr.attr,
 
-	&dev_attr_temp1_input.attr,
-	&dev_attr_temp1_max.attr,
-	&dev_attr_temp1_min.attr,
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_temp1_max.dev_attr.attr,
+	&sensor_dev_attr_temp1_min.dev_attr.attr,
 	&dev_attr_temp1_crit.attr,
 	&sensor_dev_attr_temp1_alarm.dev_attr.attr,
-	&dev_attr_temp2_input.attr,
-	&dev_attr_temp2_max.attr,
-	&dev_attr_temp2_min.attr,
+	&sensor_dev_attr_temp2_input.dev_attr.attr,
+	&sensor_dev_attr_temp2_max.dev_attr.attr,
+	&sensor_dev_attr_temp2_min.dev_attr.attr,
 	&dev_attr_temp2_crit.attr,
 	&sensor_dev_attr_temp2_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp2_fault.dev_attr.attr,
@@ -745,9 +715,9 @@ static const struct attribute_group lm87
 };
 
 static struct attribute *lm87_attributes_in6[] = {
-	&dev_attr_in6_input.attr,
-	&dev_attr_in6_min.attr,
-	&dev_attr_in6_max.attr,
+	&sensor_dev_attr_in6_input.dev_attr.attr,
+	&sensor_dev_attr_in6_min.dev_attr.attr,
+	&sensor_dev_attr_in6_max.dev_attr.attr,
 	&sensor_dev_attr_in6_alarm.dev_attr.attr,
 	NULL
 };
@@ -757,9 +727,9 @@ static const struct attribute_group lm87
 };
 
 static struct attribute *lm87_attributes_fan1[] = {
-	&dev_attr_fan1_input.attr,
-	&dev_attr_fan1_min.attr,
-	&dev_attr_fan1_div.attr,
+	&sensor_dev_attr_fan1_input.dev_attr.attr,
+	&sensor_dev_attr_fan1_min.dev_attr.attr,
+	&sensor_dev_attr_fan1_div.dev_attr.attr,
 	&sensor_dev_attr_fan1_alarm.dev_attr.attr,
 	NULL
 };
@@ -769,9 +739,9 @@ static const struct attribute_group lm87
 };
 
 static struct attribute *lm87_attributes_in7[] = {
-	&dev_attr_in7_input.attr,
-	&dev_attr_in7_min.attr,
-	&dev_attr_in7_max.attr,
+	&sensor_dev_attr_in7_input.dev_attr.attr,
+	&sensor_dev_attr_in7_min.dev_attr.attr,
+	&sensor_dev_attr_in7_max.dev_attr.attr,
 	&sensor_dev_attr_in7_alarm.dev_attr.attr,
 	NULL
 };
@@ -781,9 +751,9 @@ static const struct attribute_group lm87
 };
 
 static struct attribute *lm87_attributes_fan2[] = {
-	&dev_attr_fan2_input.attr,
-	&dev_attr_fan2_min.attr,
-	&dev_attr_fan2_div.attr,
+	&sensor_dev_attr_fan2_input.dev_attr.attr,
+	&sensor_dev_attr_fan2_min.dev_attr.attr,
+	&sensor_dev_attr_fan2_div.dev_attr.attr,
 	&sensor_dev_attr_fan2_alarm.dev_attr.attr,
 	NULL
 };
@@ -793,9 +763,9 @@ static const struct attribute_group lm87
 };
 
 static struct attribute *lm87_attributes_temp3[] = {
-	&dev_attr_temp3_input.attr,
-	&dev_attr_temp3_max.attr,
-	&dev_attr_temp3_min.attr,
+	&sensor_dev_attr_temp3_input.dev_attr.attr,
+	&sensor_dev_attr_temp3_max.dev_attr.attr,
+	&sensor_dev_attr_temp3_min.dev_attr.attr,
 	&dev_attr_temp3_crit.attr,
 	&sensor_dev_attr_temp3_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp3_fault.dev_attr.attr,
@@ -807,13 +777,13 @@ static const struct attribute_group lm87
 };
 
 static struct attribute *lm87_attributes_in0_5[] = {
-	&dev_attr_in0_input.attr,
-	&dev_attr_in0_min.attr,
-	&dev_attr_in0_max.attr,
+	&sensor_dev_attr_in0_input.dev_attr.attr,
+	&sensor_dev_attr_in0_min.dev_attr.attr,
+	&sensor_dev_attr_in0_max.dev_attr.attr,
 	&sensor_dev_attr_in0_alarm.dev_attr.attr,
-	&dev_attr_in5_input.attr,
-	&dev_attr_in5_min.attr,
-	&dev_attr_in5_max.attr,
+	&sensor_dev_attr_in5_input.dev_attr.attr,
+	&sensor_dev_attr_in5_min.dev_attr.attr,
+	&sensor_dev_attr_in5_max.dev_attr.attr,
 	&sensor_dev_attr_in5_alarm.dev_attr.attr,
 	NULL
 };


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
