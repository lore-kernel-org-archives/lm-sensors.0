From: jcromie@divsol.com (Jim Cromie)
Date: Thu, 04 Aug 2005 02:21:35 +0000
Subject: [lm-sensors] [patch pc87360 reroll 2/6]  function renames,
Message-Id: <42F15F80.6070003@divsol.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> getter-setter callback-function renames (preparation for 
> de-macro-ization)
>    avoid name-clashes when we de-macro-ize later, and improve clarity
>
>    Currently we have:
>
>    423 #define show_and_set_therm(offset) \
>    424 static ssize_t show_temp##offset##_input(struct device *dev, 
> struct device_attribute *attr, char *buf    424 ) \
>    425 { \
>
>    537 #define show_and_set_temp(offset) \
>    538 static ssize_t show_temp##offset##_input(struct device *dev, 
> struct device_attribute *attr, char *buf    538 ) \
>    539 { \
>
> these are distinguished purely by the ##offset## in the callback name,
> which will go away in next patch, so we get ready by changing temp to 
> therm
> in the show_and_set_therm macro.
>
> 2nd situation is similar, this time with one of the fan callbacks and 
> a fan-helper function.
>
>    248
>    249 static ssize_t set_fan_min(struct device *dev, const char *buf,
>    250         size_t count, int nr)
>    251 {
>
>    302 } \
>    303 static ssize_t set_fan##offset##_min(struct device *dev, struct 
> device_attribute *attr, const char *b    303 uf, \
>    304         size_t count) \
>

$ diffstat 02-pc87360-fn-renames
 pc87360.c |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

Signed-off-by:  Jim Cromie <jcromie@divsol.com>
-------------- next part --------------
diff -ruNp -X exclude-diffs gc-1/drivers/hwmon/pc87360.c gc-2/drivers/hwmon/pc87360.c
--- gc-1/drivers/hwmon/pc87360.c	2005-08-03 17:11:16.000000000 -0600
+++ gc-2/drivers/hwmon/pc87360.c	2005-08-03 17:12:16.000000000 -0600
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
