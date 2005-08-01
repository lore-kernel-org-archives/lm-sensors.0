From: jcromie@divsol.com (Jim Cromie)
Date: Mon, 01 Aug 2005 23:28:46 +0000
Subject: [lm-sensors] [patchset 9/23] pc87360  temp use attr->index
Message-Id: <42EE93E8.1070701@divsol.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


use attr->index instead of offset in pwm get/set macros

[jimc@harpo pset]$ diffstat 05x-sda-temp-quell-warns
 pc87360.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

Signed-off-by:  Jim Cromie <jcromie@divsol.com>
-------------- next part --------------
diff -ruNp -X exclude-diffs lxC-8/drivers/hwmon/pc87360.c lxC-9/drivers/hwmon/pc87360.c
--- lxC-8/drivers/hwmon/pc87360.c	2005-07-31 12:12:43.000000000 -0600
+++ lxC-9/drivers/hwmon/pc87360.c	2005-07-31 12:13:26.000000000 -0600
@@ -552,31 +552,31 @@ static ssize_t show_temp##offset##_input
 { \
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[offset-1])); \
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[attr->index-1])); \
 } \
 static ssize_t show_temp##offset##_min(struct device *dev, struct device_attribute *devattr, char *buf) \
 { \
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_min[offset-1])); \
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_min[attr->index-1])); \
 } \
 static ssize_t show_temp##offset##_max(struct device *dev, struct device_attribute *devattr, char *buf) \
 { \
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_max[offset-1])); \
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_max[attr->index-1])); \
 }\
 static ssize_t show_temp##offset##_crit(struct device *dev, struct device_attribute *devattr, char *buf) \
 { \
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_crit[offset-1])); \
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_crit[attr->index-1])); \
 }\
 static ssize_t show_temp##offset##_status(struct device *dev, struct device_attribute *devattr, char *buf) \
 { \
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
-	return sprintf(buf, "%d\n", data->temp_status[offset-1]); \
+	return sprintf(buf, "%d\n", data->temp_status[attr->index-1]); \
 }\
 static ssize_t set_temp##offset##_min(struct device *dev, struct device_attribute *devattr, const char *buf, \
 	size_t count) \
@@ -587,9 +587,9 @@ static ssize_t set_temp##offset##_min(st
 	long val = simple_strtol(buf, NULL, 10); \
  \
 	down(&data->update_lock); \
-	data->temp_min[offset-1] = TEMP_TO_REG(val); \
+	data->temp_min[attr->index-1] = TEMP_TO_REG(val); \
 	pc87360_write_value(data, LD_TEMP, offset-1, PC87365_REG_TEMP_MIN, \
-			    data->temp_min[offset-1]); \
+			    data->temp_min[attr->index-1]); \
 	up(&data->update_lock); \
 	return count; \
 } \
@@ -602,9 +602,9 @@ static ssize_t set_temp##offset##_max(st
 	long val = simple_strtol(buf, NULL, 10); \
  \
 	down(&data->update_lock); \
-	data->temp_max[offset-1] = TEMP_TO_REG(val); \
+	data->temp_max[attr->index-1] = TEMP_TO_REG(val); \
 	pc87360_write_value(data, LD_TEMP, offset-1, PC87365_REG_TEMP_MAX, \
-			    data->temp_max[offset-1]); \
+			    data->temp_max[attr->index-1]); \
 	up(&data->update_lock); \
 	return count; \
 } \
@@ -617,9 +617,9 @@ static ssize_t set_temp##offset##_crit(s
 	long val = simple_strtol(buf, NULL, 10); \
  \
 	down(&data->update_lock); \
-	data->temp_crit[offset-1] = TEMP_TO_REG(val); \
+	data->temp_crit[attr->index-1] = TEMP_TO_REG(val); \
 	pc87360_write_value(data, LD_TEMP, offset-1, PC87365_REG_TEMP_CRIT, \
-			    data->temp_crit[offset-1]); \
+			    data->temp_crit[attr->index-1]); \
 	up(&data->update_lock); \
 	return count; \
 } \
