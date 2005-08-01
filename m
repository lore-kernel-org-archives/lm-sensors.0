From: jcromie@divsol.com (Jim Cromie)
Date: Mon, 01 Aug 2005 23:44:54 +0000
Subject: [lm-sensors] [patchset 11/23] pc87360 thermistor use attr->index
Message-Id: <42EE97A9.5090507@divsol.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


use attr->index instead of offset in thermistor get/set macros

[jimc@harpo pset]$ diffstat 06x-sda-therm-quell-warns
 pc87360.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)


Signed-off-by:  Jim Cromie <jcromie@divsol.com>


-------------- next part --------------
diff -ruNp -X exclude-diffs lxD-10/drivers/hwmon/pc87360.c lxD-11/drivers/hwmon/pc87360.c
--- lxD-10/drivers/hwmon/pc87360.c	2005-07-31 14:48:00.000000000 -0600
+++ lxD-11/drivers/hwmon/pc87360.c	2005-07-31 15:16:05.000000000 -0600
@@ -438,35 +438,35 @@ static ssize_t show_temp##offset##_input
 { \
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
-	return sprintf(buf, "%u\n", IN_FROM_REG(data->in[offset+7], \
+	return sprintf(buf, "%u\n", IN_FROM_REG(data->in[attr->index+7], \
 		       data->in_vref)); \
 } \
 static ssize_t show_temp##offset##_min(struct device *dev, struct device_attribute *devattr, char *buf) \
 { \
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
-	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_min[offset+7], \
+	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_min[attr->index+7], \
 		       data->in_vref)); \
 } \
 static ssize_t show_temp##offset##_max(struct device *dev, struct device_attribute *devattr, char *buf) \
 { \
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
-	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_max[offset+7], \
+	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_max[attr->index+7], \
 		       data->in_vref)); \
 } \
 static ssize_t show_temp##offset##_crit(struct device *dev, struct device_attribute *devattr, char *buf) \
 { \
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
-	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_crit[offset-4], \
+	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_crit[attr->index-4], \
 		       data->in_vref)); \
 } \
 static ssize_t show_temp##offset##_status(struct device *dev, struct device_attribute *devattr, char *buf) \
 { \
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
-	return sprintf(buf, "%u\n", data->in_status[offset+7]); \
+	return sprintf(buf, "%u\n", data->in_status[attr->index+7]); \
 } \
 static ssize_t set_temp##offset##_min(struct device *dev, struct device_attribute *devattr, const char *buf, \
 	size_t count) \
@@ -477,9 +477,9 @@ static ssize_t set_temp##offset##_min(st
 	long val = simple_strtol(buf, NULL, 10); \
  \
 	down(&data->update_lock); \
-	data->in_min[offset+7] = IN_TO_REG(val, data->in_vref); \
-	pc87360_write_value(data, LD_IN, offset+7, PC87365_REG_TEMP_MIN, \
-			    data->in_min[offset+7]); \
+	data->in_min[attr->index+7] = IN_TO_REG(val, data->in_vref); \
+	pc87360_write_value(data, LD_IN, attr->index+7, PC87365_REG_TEMP_MIN, \
+			    data->in_min[attr->index+7]); \
 	up(&data->update_lock); \
 	return count; \
 } \
@@ -492,9 +492,9 @@ static ssize_t set_temp##offset##_max(st
 	long val = simple_strtol(buf, NULL, 10); \
  \
 	down(&data->update_lock); \
-	data->in_max[offset+7] = IN_TO_REG(val, data->in_vref); \
-	pc87360_write_value(data, LD_IN, offset+7, PC87365_REG_TEMP_MAX, \
-			    data->in_max[offset+7]); \
+	data->in_max[attr->index+7] = IN_TO_REG(val, data->in_vref); \
+	pc87360_write_value(data, LD_IN, attr->index+7, PC87365_REG_TEMP_MAX, \
+			    data->in_max[attr->index+7]); \
 	up(&data->update_lock); \
 	return count; \
 } \
@@ -507,9 +507,9 @@ static ssize_t set_temp##offset##_crit(s
 	long val = simple_strtol(buf, NULL, 10); \
  \
 	down(&data->update_lock); \
-	data->in_crit[offset-4] = IN_TO_REG(val, data->in_vref); \
-	pc87360_write_value(data, LD_IN, offset+7, PC87365_REG_TEMP_CRIT, \
-			    data->in_crit[offset-4]); \
+	data->in_crit[attr->index-4] = IN_TO_REG(val, data->in_vref); \
+	pc87360_write_value(data, LD_IN, attr->index+7, PC87365_REG_TEMP_CRIT, \
+			    data->in_crit[attr->index-4]); \
 	up(&data->update_lock); \
 	return count; \
 } \
