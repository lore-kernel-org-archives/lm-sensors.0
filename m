From: jcromie@divsol.com (Jim Cromie)
Date: Mon, 01 Aug 2005 23:49:36 +0000
Subject: [lm-sensors] [patchset 12/23] pc87360 rename thermistor get-set
Message-Id: <42EE988A.9070400@divsol.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


get-set macros for thermistors use the same name as those for temp units.
This is confusing, and needs to be fixed prior to turning them into 
functions

[jimc@harpo pset]$ diffstat 07-mv-temp-macros-2therm
 pc87360.c |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)


Signed-off-by:  Jim Cromie <jcromie@divsol.com>


-------------- next part --------------
diff -ruNp -X exclude-diffs lxC-11/drivers/hwmon/pc87360.c lxC-12/drivers/hwmon/pc87360.c
--- lxC-11/drivers/hwmon/pc87360.c	2005-07-31 15:51:55.000000000 -0600
+++ lxC-12/drivers/hwmon/pc87360.c	2005-07-31 19:13:52.000000000 -0600
@@ -434,41 +434,41 @@ show_and_set_in(9)
 show_and_set_in(10)
 
 #define show_and_set_therm(offset) \
-static ssize_t show_temp##offset##_input(struct device *dev, struct device_attribute *devattr, char *buf) \
+static ssize_t show_therm##offset##_input(struct device *dev, struct device_attribute *devattr, char *buf) \
 { \
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%u\n", IN_FROM_REG(data->in[attr->index+7], \
 		       data->in_vref)); \
 } \
-static ssize_t show_temp##offset##_min(struct device *dev, struct device_attribute *devattr, char *buf) \
+static ssize_t show_therm##offset##_min(struct device *dev, struct device_attribute *devattr, char *buf) \
 { \
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_min[attr->index+7], \
 		       data->in_vref)); \
 } \
-static ssize_t show_temp##offset##_max(struct device *dev, struct device_attribute *devattr, char *buf) \
+static ssize_t show_therm##offset##_max(struct device *dev, struct device_attribute *devattr, char *buf) \
 { \
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_max[attr->index+7], \
 		       data->in_vref)); \
 } \
-static ssize_t show_temp##offset##_crit(struct device *dev, struct device_attribute *devattr, char *buf) \
+static ssize_t show_therm##offset##_crit(struct device *dev, struct device_attribute *devattr, char *buf) \
 { \
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_crit[attr->index-4], \
 		       data->in_vref)); \
 } \
-static ssize_t show_temp##offset##_status(struct device *dev, struct device_attribute *devattr, char *buf) \
+static ssize_t show_therm##offset##_status(struct device *dev, struct device_attribute *devattr, char *buf) \
 { \
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%u\n", data->in_status[attr->index+7]); \
 } \
-static ssize_t set_temp##offset##_min(struct device *dev, struct device_attribute *devattr, const char *buf, \
+static ssize_t set_therm##offset##_min(struct device *dev, struct device_attribute *devattr, const char *buf, \
 	size_t count) \
 { \
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
@@ -483,7 +483,7 @@ static ssize_t set_temp##offset##_min(st
 	up(&data->update_lock); \
 	return count; \
 } \
-static ssize_t set_temp##offset##_max(struct device *dev, struct device_attribute *devattr, const char *buf, \
+static ssize_t set_therm##offset##_max(struct device *dev, struct device_attribute *devattr, const char *buf, \
 	size_t count) \
 { \
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
@@ -498,7 +498,7 @@ static ssize_t set_temp##offset##_max(st
 	up(&data->update_lock); \
 	return count; \
 } \
-static ssize_t set_temp##offset##_crit(struct device *dev, struct device_attribute *devattr, const char *buf, \
+static ssize_t set_therm##offset##_crit(struct device *dev, struct device_attribute *devattr, const char *buf, \
 	size_t count) \
 { \
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
@@ -514,15 +514,15 @@ static ssize_t set_temp##offset##_crit(s
 	return count; \
 } \
 static SENSOR_DEVICE_ATTR(temp##offset##_input, S_IRUGO, \
-	show_temp##offset##_input, NULL, offset); \
+	show_therm##offset##_input, NULL, offset); \
 static SENSOR_DEVICE_ATTR(temp##offset##_min, S_IWUSR | S_IRUGO, \
-	show_temp##offset##_min, set_temp##offset##_min, offset); \
+	show_therm##offset##_min, set_therm##offset##_min, offset); \
 static SENSOR_DEVICE_ATTR(temp##offset##_max, S_IWUSR | S_IRUGO, \
-	show_temp##offset##_max, set_temp##offset##_max, offset); \
+	show_therm##offset##_max, set_therm##offset##_max, offset); \
 static SENSOR_DEVICE_ATTR(temp##offset##_crit, S_IWUSR | S_IRUGO, \
-	show_temp##offset##_crit, set_temp##offset##_crit, offset); \
+	show_therm##offset##_crit, set_therm##offset##_crit, offset); \
 static SENSOR_DEVICE_ATTR(temp##offset##_status, S_IRUGO, \
-	show_temp##offset##_status, NULL, offset);
+	show_therm##offset##_status, NULL, offset);
 show_and_set_therm(4)
 show_and_set_therm(5)
 show_and_set_therm(6)
