From: jcromie@divsol.com (Jim Cromie)
Date: Mon, 01 Aug 2005 21:58:26 +0000
Subject: [lm-sensors] [patchset 4/23] pc87360 fan device_attributes -->
Message-Id: <42EE7EBD.7060806@divsol.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



upgrade fan device_attributes to sensor-device-attributes, following 
Yani's form
  a. change declarations: DEVICE_ATTR -> SENSOR_DEVICE_ATTR
  b. compute sensor_dev_attr from dev_attr, with 
to_sensor_dev_attr(devattr)
  c. change calls to device_create_file() to match.

[jimc@harpo pset]$ diffstat 03-sda-fan
  pc87360.c |   65 
+++++++++++++++++++++++++++++++++-----------------------------
 1 files changed, 35 insertions(+), 30 deletions(-)


Signed-off-by:  Jim Cromie <jcromie@divsol.com>
-------------- next part --------------
diff -ruNp -X exclude-diffs lxC-3/drivers/hwmon/pc87360.c lxC-4/drivers/hwmon/pc87360.c
--- lxC-3/drivers/hwmon/pc87360.c	2005-07-31 12:09:03.000000000 -0600
+++ lxC-4/drivers/hwmon/pc87360.c	2005-07-31 12:09:44.000000000 -0600
@@ -276,43 +276,48 @@ static ssize_t set_fan_min(struct device
 }
 
 #define show_and_set_fan(offset) \
-static ssize_t show_fan##offset##_input(struct device *dev, struct device_attribute *attr, char *buf) \
+static ssize_t show_fan##offset##_input(struct device *dev, struct device_attribute *devattr, char *buf) \
 { \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%u\n", FAN_FROM_REG(data->fan[offset-1], \
 		       FAN_DIV_FROM_REG(data->fan_status[offset-1]))); \
 } \
-static ssize_t show_fan##offset##_min(struct device *dev, struct device_attribute *attr, char *buf) \
+static ssize_t show_fan##offset##_min(struct device *dev, struct device_attribute *devattr, char *buf) \
 { \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%u\n", FAN_FROM_REG(data->fan_min[offset-1], \
 		       FAN_DIV_FROM_REG(data->fan_status[offset-1]))); \
 } \
-static ssize_t show_fan##offset##_div(struct device *dev, struct device_attribute *attr, char *buf) \
+static ssize_t show_fan##offset##_div(struct device *dev, struct device_attribute *devattr, char *buf) \
 { \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%u\n", \
 		       FAN_DIV_FROM_REG(data->fan_status[offset-1])); \
 } \
-static ssize_t show_fan##offset##_status(struct device *dev, struct device_attribute *attr, char *buf) \
+static ssize_t show_fan##offset##_status(struct device *dev, struct device_attribute *devattr, char *buf) \
 { \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%u\n", \
 		       FAN_STATUS_FROM_REG(data->fan_status[offset-1])); \
 } \
-static ssize_t set_fan##offset##_min(struct device *dev, struct device_attribute *attr, const char *buf, \
+static ssize_t set_fan##offset##_min(struct device *dev, struct device_attribute *devattr, const char *buf, \
 	size_t count) \
 { \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	return set_fan_min(dev, buf, count, offset-1); \
 } \
-static DEVICE_ATTR(fan##offset##_input, S_IRUGO, \
-	show_fan##offset##_input, NULL); \
-static DEVICE_ATTR(fan##offset##_min, S_IWUSR | S_IRUGO, \
-	show_fan##offset##_min, set_fan##offset##_min); \
-static DEVICE_ATTR(fan##offset##_div, S_IRUGO, \
-	show_fan##offset##_div, NULL); \
-static DEVICE_ATTR(fan##offset##_status, S_IRUGO, \
-	show_fan##offset##_status, NULL);
+static SENSOR_DEVICE_ATTR(fan##offset##_input, S_IRUGO, \
+	show_fan##offset##_input, NULL, offset); \
+static SENSOR_DEVICE_ATTR(fan##offset##_min, S_IWUSR | S_IRUGO, \
+	show_fan##offset##_min, set_fan##offset##_min, offset); \
+static SENSOR_DEVICE_ATTR(fan##offset##_div, S_IRUGO, \
+	show_fan##offset##_div, NULL, offset); \
+static SENSOR_DEVICE_ATTR(fan##offset##_status, S_IRUGO, \
+	show_fan##offset##_status, NULL, offset);
 show_and_set_fan(1)
 show_and_set_fan(2)
 show_and_set_fan(3)
@@ -341,8 +346,8 @@ static ssize_t set_pwm##offset(struct de
 	up(&data->update_lock); \
 	return count; \
 } \
-static DEVICE_ATTR(pwm##offset, S_IWUSR | S_IRUGO, \
-	show_pwm##offset, set_pwm##offset);
+static SENSOR_DEVICE_ATTR(pwm##offset, S_IWUSR | S_IRUGO, \
+	show_pwm##offset, set_pwm##offset, offset);
 show_and_set_pwm(1)
 show_and_set_pwm(2)
 show_and_set_pwm(3)
@@ -928,45 +933,45 @@ static int pc87360_detect(struct i2c_ada
 	if (data->fannr) {
 		if (FAN_CONFIG_MONITOR(data->fan_conf, 0)) {
 			device_create_file(&new_client->dev,
-					   &dev_attr_fan1_input);
+					   &sensor_dev_attr_fan1_input.dev_attr);
 			device_create_file(&new_client->dev,
-					   &dev_attr_fan1_min);
+					   &sensor_dev_attr_fan1_min.dev_attr);
 			device_create_file(&new_client->dev,
-					   &dev_attr_fan1_div);
+					   &sensor_dev_attr_fan1_div.dev_attr);
 			device_create_file(&new_client->dev,
-					   &dev_attr_fan1_status);
+					   &sensor_dev_attr_fan1_status.dev_attr);
 		}
 
 		if (FAN_CONFIG_MONITOR(data->fan_conf, 1)) {
 			device_create_file(&new_client->dev,
-					   &dev_attr_fan2_input);
+					   &sensor_dev_attr_fan2_input.dev_attr);
 			device_create_file(&new_client->dev,
-					   &dev_attr_fan2_min);
+					   &sensor_dev_attr_fan2_min.dev_attr);
 			device_create_file(&new_client->dev,
-					   &dev_attr_fan2_div);
+					   &sensor_dev_attr_fan2_div.dev_attr);
 			device_create_file(&new_client->dev,
-					   &dev_attr_fan2_status);
+					   &sensor_dev_attr_fan2_status.dev_attr);
 		}
 
 		if (FAN_CONFIG_CONTROL(data->fan_conf, 0))
-			device_create_file(&new_client->dev, &dev_attr_pwm1);
+			device_create_file(&new_client->dev, &sensor_dev_attr_pwm1.dev_attr);
 		if (FAN_CONFIG_CONTROL(data->fan_conf, 1))
-			device_create_file(&new_client->dev, &dev_attr_pwm2);
+			device_create_file(&new_client->dev, &sensor_dev_attr_pwm2.dev_attr);
 	}
 	if (data->fannr = 3) {
 		if (FAN_CONFIG_MONITOR(data->fan_conf, 2)) {
 			device_create_file(&new_client->dev,
-					   &dev_attr_fan3_input);
+					   &sensor_dev_attr_fan3_input.dev_attr);
 			device_create_file(&new_client->dev,
-					   &dev_attr_fan3_min);
+					   &sensor_dev_attr_fan3_min.dev_attr);
 			device_create_file(&new_client->dev,
-					   &dev_attr_fan3_div);
+					   &sensor_dev_attr_fan3_div.dev_attr);
 			device_create_file(&new_client->dev,
-					   &dev_attr_fan3_status);
+					   &sensor_dev_attr_fan3_status.dev_attr);
 		}
 
 		if (FAN_CONFIG_CONTROL(data->fan_conf, 2))
-			device_create_file(&new_client->dev, &dev_attr_pwm3);
+			device_create_file(&new_client->dev, &sensor_dev_attr_pwm3.dev_attr);
 	}
 
 	return 0;
