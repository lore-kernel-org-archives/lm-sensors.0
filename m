From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 03 Jun 2007 15:43:09 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon/sis5595: Use dynamic sysfs callbacks
Message-Id: <20070603174309.607aaff3@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This lets us get rid of macro-generated functions and shrinks the
driver size by about 7%.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/sis5595.c |  184 +++++++++++++++++++----------------------------
 1 file changed, 78 insertions(+), 106 deletions(-)

--- linux-2.6.22-rc3.orig/drivers/hwmon/sis5595.c	2007-06-03 17:36:56.000000000 +0200
+++ linux-2.6.22-rc3/drivers/hwmon/sis5595.c	2007-06-03 17:37:18.000000000 +0200
@@ -56,6 +56,7 @@
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/jiffies.h>
@@ -204,28 +205,39 @@ static struct platform_driver sis5595_dr
 };
 
 /* 4 Voltages */
-static ssize_t show_in(struct device *dev, char *buf, int nr)
+static ssize_t show_in(struct device *dev, struct device_attribute *da,
+		       char *buf)
 {
 	struct sis5595_data *data = sis5595_update_device(dev);
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	int nr = attr->index;
 	return sprintf(buf, "%d\n", IN_FROM_REG(data->in[nr]));
 }
 
-static ssize_t show_in_min(struct device *dev, char *buf, int nr)
+static ssize_t show_in_min(struct device *dev, struct device_attribute *da,
+			   char *buf)
 {
 	struct sis5595_data *data = sis5595_update_device(dev);
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	int nr = attr->index;
 	return sprintf(buf, "%d\n", IN_FROM_REG(data->in_min[nr]));
 }
 
-static ssize_t show_in_max(struct device *dev, char *buf, int nr)
+static ssize_t show_in_max(struct device *dev, struct device_attribute *da,
+			   char *buf)
 {
 	struct sis5595_data *data = sis5595_update_device(dev);
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	int nr = attr->index;
 	return sprintf(buf, "%d\n", IN_FROM_REG(data->in_max[nr]));
 }
 
-static ssize_t set_in_min(struct device *dev, const char *buf,
-	       size_t count, int nr)
+static ssize_t set_in_min(struct device *dev, struct device_attribute *da,
+			  const char *buf, size_t count)
 {
 	struct sis5595_data *data = dev_get_drvdata(dev);
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	int nr = attr->index;
 	unsigned long val = simple_strtoul(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
@@ -235,10 +247,12 @@ static ssize_t set_in_min(struct device 
 	return count;
 }
 
-static ssize_t set_in_max(struct device *dev, const char *buf,
-	       size_t count, int nr)
+static ssize_t set_in_max(struct device *dev, struct device_attribute *da,
+			  const char *buf, size_t count)
 {
 	struct sis5595_data *data = dev_get_drvdata(dev);
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	int nr = attr->index;
 	unsigned long val = simple_strtoul(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
@@ -249,37 +263,12 @@ static ssize_t set_in_max(struct device 
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
-	show_in##offset##_min (struct device *dev, struct device_attribute *attr, char *buf)	\
-{								\
-	return show_in_min(dev, buf, offset);			\
-}								\
-static ssize_t							\
-	show_in##offset##_max (struct device *dev, struct device_attribute *attr, char *buf)	\
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
+static SENSOR_DEVICE_ATTR(in##offset##_input, S_IRUGO,		\
+		show_in, NULL, offset);				\
+static SENSOR_DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR,	\
+		show_in_min, set_in_min, offset);		\
+static SENSOR_DEVICE_ATTR(in##offset##_max, S_IRUGO | S_IWUSR,	\
+		show_in_max, set_in_max, offset);
 
 show_in_offset(0);
 show_in_offset(1);
@@ -337,24 +326,32 @@ static DEVICE_ATTR(temp1_max_hyst, S_IRU
 		show_temp_hyst, set_temp_hyst);
 
 /* 2 Fans */
-static ssize_t show_fan(struct device *dev, char *buf, int nr)
+static ssize_t show_fan(struct device *dev, struct device_attribute *da,
+			char *buf)
 {
 	struct sis5595_data *data = sis5595_update_device(dev);
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	int nr = attr->index;
 	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[nr],
 		DIV_FROM_REG(data->fan_div[nr])) );
 }
 
-static ssize_t show_fan_min(struct device *dev, char *buf, int nr)
+static ssize_t show_fan_min(struct device *dev, struct device_attribute *da,
+			    char *buf)
 {
 	struct sis5595_data *data = sis5595_update_device(dev);
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	int nr = attr->index;
 	return sprintf(buf,"%d\n", FAN_FROM_REG(data->fan_min[nr],
 		DIV_FROM_REG(data->fan_div[nr])) );
 }
 
-static ssize_t set_fan_min(struct device *dev, const char *buf,
-		size_t count, int nr)
+static ssize_t set_fan_min(struct device *dev, struct device_attribute *da,
+			   const char *buf, size_t count)
 {
 	struct sis5595_data *data = dev_get_drvdata(dev);
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	int nr = attr->index;
 	unsigned long val = simple_strtoul(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
@@ -364,9 +361,12 @@ static ssize_t set_fan_min(struct device
 	return count;
 }
 
-static ssize_t show_fan_div(struct device *dev, char *buf, int nr)
+static ssize_t show_fan_div(struct device *dev, struct device_attribute *da,
+			    char *buf)
 {
 	struct sis5595_data *data = sis5595_update_device(dev);
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	int nr = attr->index;
 	return sprintf(buf, "%d\n", DIV_FROM_REG(data->fan_div[nr]) );
 }
 
@@ -374,10 +374,12 @@ static ssize_t show_fan_div(struct devic
    determined in part by the fan divisor.  This follows the principle of
    least surprise; the user doesn't expect the fan minimum to change just
    because the divisor changed. */
-static ssize_t set_fan_div(struct device *dev, const char *buf,
-	size_t count, int nr)
+static ssize_t set_fan_div(struct device *dev, struct device_attribute *da,
+			   const char *buf, size_t count)
 {
 	struct sis5595_data *data = dev_get_drvdata(dev);
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	int nr = attr->index;
 	unsigned long min;
 	unsigned long val = simple_strtoul(buf, NULL, 10);
 	int reg;
@@ -416,46 +418,16 @@ static ssize_t set_fan_div(struct device
 }
 
 #define show_fan_offset(offset)						\
-static ssize_t show_fan_##offset (struct device *dev, struct device_attribute *attr, char *buf)	\
-{									\
-	return show_fan(dev, buf, offset - 1);			\
-}									\
-static ssize_t show_fan_##offset##_min (struct device *dev, struct device_attribute *attr, char *buf)	\
-{									\
-	return show_fan_min(dev, buf, offset - 1);			\
-}									\
-static ssize_t show_fan_##offset##_div (struct device *dev, struct device_attribute *attr, char *buf)	\
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
+static SENSOR_DEVICE_ATTR(fan##offset##_input, S_IRUGO,			\
+		show_fan, NULL, offset - 1);				\
+static SENSOR_DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR,		\
+		show_fan_min, set_fan_min, offset - 1);			\
+static SENSOR_DEVICE_ATTR(fan##offset##_div, S_IRUGO | S_IWUSR,		\
+		show_fan_div, set_fan_div, offset - 1);
 
 show_fan_offset(1);
 show_fan_offset(2);
 
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
-static DEVICE_ATTR(fan1_div, S_IRUGO | S_IWUSR,
-		show_fan_1_div, set_fan_1_div);
-static DEVICE_ATTR(fan2_div, S_IRUGO | S_IWUSR,
-		show_fan_2_div, set_fan_2_div);
-
 /* Alarms */
 static ssize_t show_alarms(struct device *dev, struct device_attribute *attr, char *buf)
 {
@@ -473,25 +445,25 @@ static ssize_t show_name(struct device *
 static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
 
 static struct attribute *sis5595_attributes[] = {
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
-
-	&dev_attr_fan1_input.attr,
-	&dev_attr_fan1_min.attr,
-	&dev_attr_fan1_div.attr,
-	&dev_attr_fan2_input.attr,
-	&dev_attr_fan2_min.attr,
-	&dev_attr_fan2_div.attr,
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
+
+	&sensor_dev_attr_fan1_input.dev_attr.attr,
+	&sensor_dev_attr_fan1_min.dev_attr.attr,
+	&sensor_dev_attr_fan1_div.dev_attr.attr,
+	&sensor_dev_attr_fan2_input.dev_attr.attr,
+	&sensor_dev_attr_fan2_min.dev_attr.attr,
+	&sensor_dev_attr_fan2_div.dev_attr.attr,
 
 	&dev_attr_alarms.attr,
 	&dev_attr_name.attr,
@@ -503,9 +475,9 @@ static const struct attribute_group sis5
 };
 
 static struct attribute *sis5595_attributes_opt[] = {
-	&dev_attr_in4_input.attr,
-	&dev_attr_in4_min.attr,
-	&dev_attr_in4_max.attr,
+	&sensor_dev_attr_in4_input.dev_attr.attr,
+	&sensor_dev_attr_in4_min.dev_attr.attr,
+	&sensor_dev_attr_in4_max.dev_attr.attr,
 
 	&dev_attr_temp1_input.attr,
 	&dev_attr_temp1_max.attr,
@@ -570,11 +542,11 @@ static int __devinit sis5595_probe(struc
 		goto exit_free;
 	if (data->maxins = 4) {
 		if ((err = device_create_file(&pdev->dev,
-					      &dev_attr_in4_input))
+					&sensor_dev_attr_in4_input.dev_attr))
 		 || (err = device_create_file(&pdev->dev,
-					      &dev_attr_in4_min))
+					&sensor_dev_attr_in4_min.dev_attr))
 		 || (err = device_create_file(&pdev->dev,
-					      &dev_attr_in4_max)))
+					&sensor_dev_attr_in4_max.dev_attr)))
 			goto exit_remove_files;
 	} else {
 		if ((err = device_create_file(&pdev->dev,


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
