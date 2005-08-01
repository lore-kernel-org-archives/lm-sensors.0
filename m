From: jcromie@divsol.com (Jim Cromie)
Date: Mon, 01 Aug 2005 22:10:26 +0000
Subject: [lm-sensors] Re: [patchset 5/23] pc87360 fan , use attr->index
Message-Id: <42EE814C.1010407@divsol.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


use attr->index instead of offset in fan get/set macros

[jimc@harpo pset]$ diffstat 03x-sda-fan-quell-warns
 pc87360.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

Signed-off-by:  Jim Cromie <jcromie@divsol.com>
-------------- next part --------------
diff -ruNp -X exclude-diffs lxC-4/drivers/hwmon/pc87360.c lxC-5/drivers/hwmon/pc87360.c
--- lxC-4/drivers/hwmon/pc87360.c	2005-07-31 15:42:45.000000000 -0600
+++ lxC-5/drivers/hwmon/pc87360.c	2005-07-31 15:54:43.000000000 -0600
@@ -246,7 +246,7 @@ static struct i2c_driver pc87360_driver 
  * Sysfs stuff
  */
 
-static ssize_t set_fan_min(struct device *dev, const char *buf,
+static ssize_t _set_fan_min(struct device *dev, const char *buf,
 	size_t count, int nr)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -280,35 +280,35 @@ static ssize_t show_fan##offset##_input(
 { \
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
-	return sprintf(buf, "%u\n", FAN_FROM_REG(data->fan[offset-1], \
-		       FAN_DIV_FROM_REG(data->fan_status[offset-1]))); \
+	return sprintf(buf, "%u\n", FAN_FROM_REG(data->fan[attr->index-1], \
+		       FAN_DIV_FROM_REG(data->fan_status[attr->index-1]))); \
 } \
 static ssize_t show_fan##offset##_min(struct device *dev, struct device_attribute *devattr, char *buf) \
 { \
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
-	return sprintf(buf, "%u\n", FAN_FROM_REG(data->fan_min[offset-1], \
-		       FAN_DIV_FROM_REG(data->fan_status[offset-1]))); \
+	return sprintf(buf, "%u\n", FAN_FROM_REG(data->fan_min[attr->index-1], \
+		       FAN_DIV_FROM_REG(data->fan_status[attr->index-1]))); \
 } \
 static ssize_t show_fan##offset##_div(struct device *dev, struct device_attribute *devattr, char *buf) \
 { \
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%u\n", \
-		       FAN_DIV_FROM_REG(data->fan_status[offset-1])); \
+		       FAN_DIV_FROM_REG(data->fan_status[attr->index-1])); \
 } \
 static ssize_t show_fan##offset##_status(struct device *dev, struct device_attribute *devattr, char *buf) \
 { \
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%u\n", \
-		       FAN_STATUS_FROM_REG(data->fan_status[offset-1])); \
+		       FAN_STATUS_FROM_REG(data->fan_status[attr->index-1])); \
 } \
 static ssize_t set_fan##offset##_min(struct device *dev, struct device_attribute *devattr, const char *buf, \
 	size_t count) \
 { \
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
-	return set_fan_min(dev, buf, count, offset-1); \
+	return _set_fan_min(dev, buf, count, attr->index-1); \
 } \
 static SENSOR_DEVICE_ATTR(fan##offset##_input, S_IRUGO, \
 	show_fan##offset##_input, NULL, offset); \
