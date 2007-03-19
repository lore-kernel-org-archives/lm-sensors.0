From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 19 Mar 2007 12:35:48 +0000
Subject: [lm-sensors] [PATCH 3/3] lm78: Use dynamic sysfs callbacks
Message-Id: <20070319133548.beed0044.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This lets us get rid of macro-generated functions and shrinks the
driver size significantly (about 10%).

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/hwmon/lm78.c |  225 ++++++++++++++++++++++----------------------------
 1 file changed, 101 insertions(+), 124 deletions(-)

--- linux-2.6.21-rc4.orig/drivers/hwmon/lm78.c	2007-03-19 10:07:19.000000000 +0100
+++ linux-2.6.21-rc4/drivers/hwmon/lm78.c	2007-03-19 10:32:20.000000000 +0100
@@ -28,6 +28,7 @@
 #include <linux/ioport.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-vid.h>
+#include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
 #include <asm/io.h>
@@ -185,29 +186,37 @@ static struct platform_driver lm78_isa_d
 
 
 /* 7 Voltages */
-static ssize_t show_in(struct device *dev, char *buf, int nr)
+static ssize_t show_in(struct device *dev, struct device_attribute *da,
+		       char *buf)
 {
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct lm78_data *data = lm78_update_device(dev);
-	return sprintf(buf, "%d\n", IN_FROM_REG(data->in[nr]));
+	return sprintf(buf, "%d\n", IN_FROM_REG(data->in[attr->index]));
 }
 
-static ssize_t show_in_min(struct device *dev, char *buf, int nr)
+static ssize_t show_in_min(struct device *dev, struct device_attribute *da,
+			   char *buf)
 {
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct lm78_data *data = lm78_update_device(dev);
-	return sprintf(buf, "%d\n", IN_FROM_REG(data->in_min[nr]));
+	return sprintf(buf, "%d\n", IN_FROM_REG(data->in_min[attr->index]));
 }
 
-static ssize_t show_in_max(struct device *dev, char *buf, int nr)
+static ssize_t show_in_max(struct device *dev, struct device_attribute *da,
+			   char *buf)
 {
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct lm78_data *data = lm78_update_device(dev);
-	return sprintf(buf, "%d\n", IN_FROM_REG(data->in_max[nr]));
+	return sprintf(buf, "%d\n", IN_FROM_REG(data->in_max[attr->index]));
 }
 
-static ssize_t set_in_min(struct device *dev, const char *buf,
-		size_t count, int nr)
+static ssize_t set_in_min(struct device *dev, struct device_attribute *da,
+			  const char *buf, size_t count)
 {
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct lm78_data *data = dev_get_drvdata(dev);
 	unsigned long val = simple_strtoul(buf, NULL, 10);
+	int nr = attr->index;
 
 	mutex_lock(&data->update_lock);
 	data->in_min[nr] = IN_TO_REG(val);
@@ -216,11 +225,13 @@ static ssize_t set_in_min(struct device 
 	return count;
 }
 
-static ssize_t set_in_max(struct device *dev, const char *buf,
-		size_t count, int nr)
+static ssize_t set_in_max(struct device *dev, struct device_attribute *da,
+			  const char *buf, size_t count)
 {
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct lm78_data *data = dev_get_drvdata(dev);
 	unsigned long val = simple_strtoul(buf, NULL, 10);
+	int nr = attr->index;
 
 	mutex_lock(&data->update_lock);
 	data->in_max[nr] = IN_TO_REG(val);
@@ -230,37 +241,12 @@ static ssize_t set_in_max(struct device 
 }
 	
 #define show_in_offset(offset)					\
-static ssize_t							\
-	show_in##offset (struct device *dev, struct device_attribute *attr, char *buf)		\
-{								\
-	return show_in(dev, buf, offset);			\
-}								\
-static DEVICE_ATTR(in##offset##_input, S_IRUGO, 		\
-		show_in##offset, NULL);				\
-static ssize_t							\
-	show_in##offset##_min (struct device *dev, struct device_attribute *attr, char *buf)   \
-{								\
-	return show_in_min(dev, buf, offset);			\
-}								\
-static ssize_t							\
-	show_in##offset##_max (struct device *dev, struct device_attribute *attr, char *buf)   \
-{								\
-	return show_in_max(dev, buf, offset);			\
-}								\
-static ssize_t set_in##offset##_min (struct device *dev, struct device_attribute *attr,	\
-		const char *buf, size_t count)			\
-{								\
-	return set_in_min(dev, buf, count, offset);		\
-}								\
-static ssize_t set_in##offset##_max (struct device *dev, struct device_attribute *attr,	\
-		const char *buf, size_t count)			\
-{								\
-	return set_in_max(dev, buf, count, offset);		\
-}								\
-static DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR,		\
-		show_in##offset##_min, set_in##offset##_min);	\
-static DEVICE_ATTR(in##offset##_max, S_IRUGO | S_IWUSR,		\
-		show_in##offset##_max, set_in##offset##_max);
+static SENSOR_DEVICE_ATTR(in##offset##_input, S_IRUGO, 		\
+		show_in, NULL, offset);				\
+static SENSOR_DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR,	\
+		show_in_min, set_in_min, offset);		\
+static SENSOR_DEVICE_ATTR(in##offset##_max, S_IRUGO | S_IWUSR,	\
+		show_in_max, set_in_max, offset);
 
 show_in_offset(0);
 show_in_offset(1);
@@ -271,19 +257,22 @@ show_in_offset(5);
 show_in_offset(6);
 
 /* Temperature */
-static ssize_t show_temp(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_temp(struct device *dev, struct device_attribute *da,
+			 char *buf)
 {
 	struct lm78_data *data = lm78_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp));
 }
 
-static ssize_t show_temp_over(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_temp_over(struct device *dev, struct device_attribute *da,
+			      char *buf)
 {
 	struct lm78_data *data = lm78_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_over));
 }
 
-static ssize_t set_temp_over(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+static ssize_t set_temp_over(struct device *dev, struct device_attribute *da,
+			     const char *buf, size_t count)
 {
 	struct lm78_data *data = dev_get_drvdata(dev);
 	long val = simple_strtol(buf, NULL, 10);
@@ -295,13 +284,15 @@ static ssize_t set_temp_over(struct devi
 	return count;
 }
 
-static ssize_t show_temp_hyst(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_temp_hyst(struct device *dev, struct device_attribute *da,
+			      char *buf)
 {
 	struct lm78_data *data = lm78_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_hyst));
 }
 
-static ssize_t set_temp_hyst(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+static ssize_t set_temp_hyst(struct device *dev, struct device_attribute *da,
+			     const char *buf, size_t count)
 {
 	struct lm78_data *data = dev_get_drvdata(dev);
 	long val = simple_strtol(buf, NULL, 10);
@@ -320,24 +311,32 @@ static DEVICE_ATTR(temp1_max_hyst, S_IRU
 		show_temp_hyst, set_temp_hyst);
 
 /* 3 Fans */
-static ssize_t show_fan(struct device *dev, char *buf, int nr)
+static ssize_t show_fan(struct device *dev, struct device_attribute *da,
+			char *buf)
 {
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct lm78_data *data = lm78_update_device(dev);
+	int nr = attr->index;
 	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[nr],
 		DIV_FROM_REG(data->fan_div[nr])) );
 }
 
-static ssize_t show_fan_min(struct device *dev, char *buf, int nr)
+static ssize_t show_fan_min(struct device *dev, struct device_attribute *da,
+			    char *buf)
 {
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct lm78_data *data = lm78_update_device(dev);
+	int nr = attr->index;
 	return sprintf(buf,"%d\n", FAN_FROM_REG(data->fan_min[nr],
 		DIV_FROM_REG(data->fan_div[nr])) );
 }
 
-static ssize_t set_fan_min(struct device *dev, const char *buf,
-		size_t count, int nr)
+static ssize_t set_fan_min(struct device *dev, struct device_attribute *da,
+			   const char *buf, size_t count)
 {
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct lm78_data *data = dev_get_drvdata(dev);
+	int nr = attr->index;
 	unsigned long val = simple_strtoul(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
@@ -347,20 +346,24 @@ static ssize_t set_fan_min(struct device
 	return count;
 }
 
-static ssize_t show_fan_div(struct device *dev, char *buf, int nr)
+static ssize_t show_fan_div(struct device *dev, struct device_attribute *da,
+			    char *buf)
 {
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct lm78_data *data = lm78_update_device(dev);
-	return sprintf(buf, "%d\n", DIV_FROM_REG(data->fan_div[nr]) );
+	return sprintf(buf, "%d\n", DIV_FROM_REG(data->fan_div[attr->index]));
 }
 
 /* Note: we save and restore the fan minimum here, because its value is
    determined in part by the fan divisor.  This follows the principle of
    least surprise; the user doesn't expect the fan minimum to change just
    because the divisor changed. */
-static ssize_t set_fan_div(struct device *dev, const char *buf,
-	size_t count, int nr)
+static ssize_t set_fan_div(struct device *dev, struct device_attribute *da,
+			   const char *buf, size_t count)
 {
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct lm78_data *data = dev_get_drvdata(dev);
+	int nr = attr->index;
 	unsigned long val = simple_strtoul(buf, NULL, 10);
 	unsigned long min;
 	u8 reg;
@@ -400,53 +403,26 @@ static ssize_t set_fan_div(struct device
 	return count;
 }
 
-#define show_fan_offset(offset)						\
-static ssize_t show_fan_##offset (struct device *dev, struct device_attribute *attr, char *buf)	\
-{									\
-	return show_fan(dev, buf, offset - 1);				\
-}									\
-static ssize_t show_fan_##offset##_min (struct device *dev, struct device_attribute *attr, char *buf)  \
-{									\
-	return show_fan_min(dev, buf, offset - 1);			\
-}									\
-static ssize_t show_fan_##offset##_div (struct device *dev, struct device_attribute *attr, char *buf)  \
-{									\
-	return show_fan_div(dev, buf, offset - 1);			\
-}									\
-static ssize_t set_fan_##offset##_min (struct device *dev, struct device_attribute *attr,		\
-		const char *buf, size_t count)				\
-{									\
-	return set_fan_min(dev, buf, count, offset - 1);		\
-}									\
-static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_fan_##offset, NULL);\
-static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR,		\
-		show_fan_##offset##_min, set_fan_##offset##_min);
-
-static ssize_t set_fan_1_div(struct device *dev, struct device_attribute *attr, const char *buf,
-		size_t count)
-{
-	return set_fan_div(dev, buf, count, 0) ;
-}
-
-static ssize_t set_fan_2_div(struct device *dev, struct device_attribute *attr, const char *buf,
-		size_t count)
-{
-	return set_fan_div(dev, buf, count, 1) ;
-}
+#define show_fan_offset(offset) 				\
+static SENSOR_DEVICE_ATTR(fan##offset##_input, S_IRUGO,		\
+		show_fan, NULL, offset - 1);			\
+static SENSOR_DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR,	\
+		show_fan_min, set_fan_min, offset - 1);
 
 show_fan_offset(1);
 show_fan_offset(2);
 show_fan_offset(3);
 
 /* Fan 3 divisor is locked in H/W */
-static DEVICE_ATTR(fan1_div, S_IRUGO | S_IWUSR,
-		show_fan_1_div, set_fan_1_div);
-static DEVICE_ATTR(fan2_div, S_IRUGO | S_IWUSR,
-		show_fan_2_div, set_fan_2_div);
-static DEVICE_ATTR(fan3_div, S_IRUGO, show_fan_3_div, NULL);
+static SENSOR_DEVICE_ATTR(fan1_div, S_IRUGO | S_IWUSR,
+		show_fan_div, set_fan_div, 0);
+static SENSOR_DEVICE_ATTR(fan2_div, S_IRUGO | S_IWUSR,
+		show_fan_div, set_fan_div, 1);
+static SENSOR_DEVICE_ATTR(fan3_div, S_IRUGO, show_fan_div, NULL, 2);
 
 /* VID */
-static ssize_t show_vid(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_vid(struct device *dev, struct device_attribute *da,
+			char *buf)
 {
 	struct lm78_data *data = lm78_update_device(dev);
 	return sprintf(buf, "%d\n", vid_from_reg(data->vid, 82));
@@ -454,7 +430,8 @@ static ssize_t show_vid(struct device *d
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
 
 /* Alarms */
-static ssize_t show_alarms(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_alarms(struct device *dev, struct device_attribute *da,
+			   char *buf)
 {
 	struct lm78_data *data = lm78_update_device(dev);
 	return sprintf(buf, "%u\n", data->alarms);
@@ -473,39 +450,39 @@ static int lm78_attach_adapter(struct i2
 }
 
 static struct attribute *lm78_attributes[] = {
-	&dev_attr_in0_input.attr,
-	&dev_attr_in0_min.attr,
-	&dev_attr_in0_max.attr,
-	&dev_attr_in1_input.attr,
-	&dev_attr_in1_min.attr,
-	&dev_attr_in1_max.attr,
-	&dev_attr_in2_input.attr,
-	&dev_attr_in2_min.attr,
-	&dev_attr_in2_max.attr,
-	&dev_attr_in3_input.attr,
-	&dev_attr_in3_min.attr,
-	&dev_attr_in3_max.attr,
-	&dev_attr_in4_input.attr,
-	&dev_attr_in4_min.attr,
-	&dev_attr_in4_max.attr,
-	&dev_attr_in5_input.attr,
-	&dev_attr_in5_min.attr,
-	&dev_attr_in5_max.attr,
-	&dev_attr_in6_input.attr,
-	&dev_attr_in6_min.attr,
-	&dev_attr_in6_max.attr,
+	&sensor_dev_attr_in0_input.dev_attr.attr,
+	&sensor_dev_attr_in0_min.dev_attr.attr,
+	&sensor_dev_attr_in0_max.dev_attr.attr,
+	&sensor_dev_attr_in1_input.dev_attr.attr,
+	&sensor_dev_attr_in1_min.dev_attr.attr,
+	&sensor_dev_attr_in1_max.dev_attr.attr,
+	&sensor_dev_attr_in2_input.dev_attr.attr,
+	&sensor_dev_attr_in2_min.dev_attr.attr,
+	&sensor_dev_attr_in2_max.dev_attr.attr,
+	&sensor_dev_attr_in3_input.dev_attr.attr,
+	&sensor_dev_attr_in3_min.dev_attr.attr,
+	&sensor_dev_attr_in3_max.dev_attr.attr,
+	&sensor_dev_attr_in4_input.dev_attr.attr,
+	&sensor_dev_attr_in4_min.dev_attr.attr,
+	&sensor_dev_attr_in4_max.dev_attr.attr,
+	&sensor_dev_attr_in5_input.dev_attr.attr,
+	&sensor_dev_attr_in5_min.dev_attr.attr,
+	&sensor_dev_attr_in5_max.dev_attr.attr,
+	&sensor_dev_attr_in6_input.dev_attr.attr,
+	&sensor_dev_attr_in6_min.dev_attr.attr,
+	&sensor_dev_attr_in6_max.dev_attr.attr,
 	&dev_attr_temp1_input.attr,
 	&dev_attr_temp1_max.attr,
 	&dev_attr_temp1_max_hyst.attr,
-	&dev_attr_fan1_input.attr,
-	&dev_attr_fan1_min.attr,
-	&dev_attr_fan1_div.attr,
-	&dev_attr_fan2_input.attr,
-	&dev_attr_fan2_min.attr,
-	&dev_attr_fan2_div.attr,
-	&dev_attr_fan3_input.attr,
-	&dev_attr_fan3_min.attr,
-	&dev_attr_fan3_div.attr,
+	&sensor_dev_attr_fan1_input.dev_attr.attr,
+	&sensor_dev_attr_fan1_min.dev_attr.attr,
+	&sensor_dev_attr_fan1_div.dev_attr.attr,
+	&sensor_dev_attr_fan2_input.dev_attr.attr,
+	&sensor_dev_attr_fan2_min.dev_attr.attr,
+	&sensor_dev_attr_fan2_div.dev_attr.attr,
+	&sensor_dev_attr_fan3_input.dev_attr.attr,
+	&sensor_dev_attr_fan3_min.dev_attr.attr,
+	&sensor_dev_attr_fan3_div.dev_attr.attr,
 	&dev_attr_alarms.attr,
 	&dev_attr_cpu0_vid.attr,
 

-- 
Jean Delvare

