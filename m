From: jim.cromie@gmail.com (Jim Cromie)
Date: Wed, 31 Aug 2005 20:29:41 +0000
Subject: [lm-sensors] [patch-A 2/5] pc87360 SDA callbacks - function renames
Message-Id: <200508311828.j7VIS7vj006814@harpo.jimc.earth>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


02	i2c-pc87360-sda-02-fn-renames.patch

Several of the macro-d functions rely on the ##offset## in the name to
disambiguate them from others, this patch alters the names so we can
drop the ##offset## in the next patch.

 pc87360.c |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)



Signed-off-by:  Jim Cromie <jim.cromie@gmail.com>




diff -ruNp -X exclude-diffs B-1/drivers/hwmon/pc87360.c B-2/drivers/hwmon/pc87360.c
--- B-1/drivers/hwmon/pc87360.c	2005-08-31 10:26:00.000000000 -0600
+++ B-2/drivers/hwmon/pc87360.c	2005-08-31 10:28:29.000000000 -0600
@@ -246,7 +246,7 @@ static struct i2c_driver pc87360_driver 
  * Sysfs stuff
  */
 
-static ssize_t set_fan_min(struct device *dev, const char *buf,
+static ssize_t _set_fan_min(struct device *dev, const char *buf,
 	size_t count, int nr)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -308,7 +308,7 @@ static ssize_t set_fan##offset##_min(str
 	size_t count) \
 { \
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
-	return set_fan_min(dev, buf, count, attr->index-1); \
+	return _set_fan_min(dev, buf, count, attr->index-1); \
 } \
 static SENSOR_DEVICE_ATTR(fan##offset##_input, S_IRUGO, \
 	show_fan##offset##_input, NULL, offset); \
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
