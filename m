From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 18 Apr 2007 19:02:40 +0000
Subject: [lm-sensors] [PATCH 2/2] smsc47b397: Use dynamic sysfs callbacks
Message-Id: <20070418210240.080a0c16@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This lets us get rid of macro-generated functions and shrinks the
driver size by a small amount.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
Testers wanted!

 drivers/hwmon/smsc47b397.c |   64 +++++++++++++++++---------------------------
 1 file changed, 26 insertions(+), 38 deletions(-)

--- linux-2.6.21-rc6.orig/drivers/hwmon/smsc47b397.c	2007-04-18 20:34:12.000000000 +0200
+++ linux-2.6.21-rc6/drivers/hwmon/smsc47b397.c	2007-04-18 20:51:38.000000000 +0200
@@ -32,6 +32,7 @@
 #include <linux/jiffies.h>
 #include <linux/platform_device.h>
 #include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/mutex.h>
@@ -156,24 +157,18 @@ static int temp_from_reg(u8 reg)
 	return (s8)reg * 1000;
 }
 
-/* 0 <= nr <= 3 */
-static ssize_t show_temp(struct device *dev, char *buf, int nr)
+static ssize_t show_temp(struct device *dev, struct device_attribute
+			 *devattr, char *buf)
 {
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct smsc47b397_data *data = smsc47b397_update_device(dev);
-	return sprintf(buf, "%d\n", temp_from_reg(data->temp[nr]));
+	return sprintf(buf, "%d\n", temp_from_reg(data->temp[attr->index]));
 }
 
-#define sysfs_temp(num) \
-static ssize_t show_temp##num(struct device *dev, struct device_attribute *attr, char *buf) \
-{ \
-	return show_temp(dev, buf, num-1); \
-} \
-static DEVICE_ATTR(temp##num##_input, S_IRUGO, show_temp##num, NULL)
-
-sysfs_temp(1);
-sysfs_temp(2);
-sysfs_temp(3);
-sysfs_temp(4);
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 1);
+static SENSOR_DEVICE_ATTR(temp3_input, S_IRUGO, show_temp, NULL, 2);
+static SENSOR_DEVICE_ATTR(temp4_input, S_IRUGO, show_temp, NULL, 3);
 
 /* FAN: 1 RPM/bit
    REG: count of 90kHz pulses / revolution */
@@ -182,24 +177,17 @@ static int fan_from_reg(u16 reg)
 	return 90000 * 60 / reg;
 }
 
-/* 0 <= nr <= 3 */
-static ssize_t show_fan(struct device *dev, char *buf, int nr)
+static ssize_t show_fan(struct device *dev, struct device_attribute
+			*devattr, char *buf)
 {
-        struct smsc47b397_data *data = smsc47b397_update_device(dev);
-        return sprintf(buf, "%d\n", fan_from_reg(data->fan[nr]));
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct smsc47b397_data *data = smsc47b397_update_device(dev);
+	return sprintf(buf, "%d\n", fan_from_reg(data->fan[attr->index]));
 }
-
-#define sysfs_fan(num) \
-static ssize_t show_fan##num(struct device *dev, struct device_attribute *attr, char *buf) \
-{ \
-	return show_fan(dev, buf, num-1); \
-} \
-static DEVICE_ATTR(fan##num##_input, S_IRUGO, show_fan##num, NULL)
-
-sysfs_fan(1);
-sysfs_fan(2);
-sysfs_fan(3);
-sysfs_fan(4);
+static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, show_fan, NULL, 0);
+static SENSOR_DEVICE_ATTR(fan2_input, S_IRUGO, show_fan, NULL, 1);
+static SENSOR_DEVICE_ATTR(fan3_input, S_IRUGO, show_fan, NULL, 2);
+static SENSOR_DEVICE_ATTR(fan4_input, S_IRUGO, show_fan, NULL, 3);
 
 static ssize_t show_name(struct device *dev, struct device_attribute
 			 *devattr, char *buf)
@@ -210,14 +198,14 @@ static ssize_t show_name(struct device *
 static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
 
 static struct attribute *smsc47b397_attributes[] = {
-	&dev_attr_temp1_input.attr,
-	&dev_attr_temp2_input.attr,
-	&dev_attr_temp3_input.attr,
-	&dev_attr_temp4_input.attr,
-	&dev_attr_fan1_input.attr,
-	&dev_attr_fan2_input.attr,
-	&dev_attr_fan3_input.attr,
-	&dev_attr_fan4_input.attr,
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_temp2_input.dev_attr.attr,
+	&sensor_dev_attr_temp3_input.dev_attr.attr,
+	&sensor_dev_attr_temp4_input.dev_attr.attr,
+	&sensor_dev_attr_fan1_input.dev_attr.attr,
+	&sensor_dev_attr_fan2_input.dev_attr.attr,
+	&sensor_dev_attr_fan3_input.dev_attr.attr,
+	&sensor_dev_attr_fan4_input.dev_attr.attr,
 
 	&dev_attr_name.attr,
 	NULL


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
