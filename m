From: jcromie@divsol.com (Jim Cromie)
Date: Thu, 04 Aug 2005 02:16:56 +0000
Subject: [lm-sensors] [patch pc87360 reroll 1/6] sensor-dev-attr rework per
Message-Id: <42F15E1D.4060707@divsol.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Yani  form  change.
> a.    declare  SENSOR_DEVICE_ATTR, not DEVICE_ATTR
> b.    in device_create_file() calls, pass &dev_attr member of the 
> sensor-dev-attr type.
> c.    in sensor-attr [gs]etter callback-functions,
>     use to_sensor_dev-attr() to get sensor_dev_attr *attr
>     use attr->index instead of offset
> d.   include hwmon-sysfs.h, needed for a.
>
> Note that this isnt a global replace.  Only those attrs that would 
> benefit from
> having an index member have been converted; ie those which are 
> macro-repeated.

$ diffstat 01-pc87360-yani-callback-form
 pc87360.c |  432 
+++++++++++++++++++++++++++++++++-----------------------------
 1 files changed, 231 insertions(+), 201 deletions(-)

Signed-off-by:  Jim Cromie <jcromie@divsol.com>
-------------- next part --------------
diff -ruNp -X exclude-diffs ../linux-2.6.13-rc4-mm1/drivers/hwmon/pc87360.c gc-1/drivers/hwmon/pc87360.c
--- ../linux-2.6.13-rc4-mm1/drivers/hwmon/pc87360.c	2005-08-01 19:30:57.000000000 -0600
+++ gc-1/drivers/hwmon/pc87360.c	2005-08-03 17:11:16.000000000 -0600
@@ -41,6 +41,7 @@
 #include <linux/i2c-isa.h>
 #include <linux/i2c-vid.h>
 #include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <asm/io.h>
 
@@ -275,138 +276,151 @@ static ssize_t set_fan_min(struct device
 }
 
 #define show_and_set_fan(offset) \
-static ssize_t show_fan##offset##_input(struct device *dev, struct device_attribute *attr, char *buf) \
+static ssize_t show_fan##offset##_input(struct device *dev, struct device_attribute *devattr, char *buf) \
 { \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
-	return sprintf(buf, "%u\n", FAN_FROM_REG(data->fan[offset-1], \
-		       FAN_DIV_FROM_REG(data->fan_status[offset-1]))); \
+	return sprintf(buf, "%u\n", FAN_FROM_REG(data->fan[attr->index-1], \
+		       FAN_DIV_FROM_REG(data->fan_status[attr->index-1]))); \
 } \
-static ssize_t show_fan##offset##_min(struct device *dev, struct device_attribute *attr, char *buf) \
+static ssize_t show_fan##offset##_min(struct device *dev, struct device_attribute *devattr, char *buf) \
 { \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
-	return sprintf(buf, "%u\n", FAN_FROM_REG(data->fan_min[offset-1], \
-		       FAN_DIV_FROM_REG(data->fan_status[offset-1]))); \
+	return sprintf(buf, "%u\n", FAN_FROM_REG(data->fan_min[attr->index-1], \
+		       FAN_DIV_FROM_REG(data->fan_status[attr->index-1]))); \
 } \
-static ssize_t show_fan##offset##_div(struct device *dev, struct device_attribute *attr, char *buf) \
+static ssize_t show_fan##offset##_div(struct device *dev, struct device_attribute *devattr, char *buf) \
 { \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%u\n", \
-		       FAN_DIV_FROM_REG(data->fan_status[offset-1])); \
+		       FAN_DIV_FROM_REG(data->fan_status[attr->index-1])); \
 } \
-static ssize_t show_fan##offset##_status(struct device *dev, struct device_attribute *attr, char *buf) \
+static ssize_t show_fan##offset##_status(struct device *dev, struct device_attribute *devattr, char *buf) \
 { \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%u\n", \
-		       FAN_STATUS_FROM_REG(data->fan_status[offset-1])); \
+		       FAN_STATUS_FROM_REG(data->fan_status[attr->index-1])); \
 } \
-static ssize_t set_fan##offset##_min(struct device *dev, struct device_attribute *attr, const char *buf, \
+static ssize_t set_fan##offset##_min(struct device *dev, struct device_attribute *devattr, const char *buf, \
 	size_t count) \
 { \
-	return set_fan_min(dev, buf, count, offset-1); \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
+	return set_fan_min(dev, buf, count, attr->index-1); \
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
 
 #define show_and_set_pwm(offset) \
-static ssize_t show_pwm##offset(struct device *dev, struct device_attribute *attr, char *buf) \
+static ssize_t show_pwm##offset(struct device *dev, struct device_attribute *devattr, char *buf) \
 { \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%u\n", \
-		       PWM_FROM_REG(data->pwm[offset-1], \
+		       PWM_FROM_REG(data->pwm[attr->index-1], \
 				    FAN_CONFIG_INVERT(data->fan_conf, \
 						      offset-1))); \
 } \
-static ssize_t set_pwm##offset(struct device *dev, struct device_attribute *attr, const char *buf, \
+static ssize_t set_pwm##offset(struct device *dev, struct device_attribute *devattr, const char *buf, \
 	size_t count) \
 { \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct pc87360_data *data = i2c_get_clientdata(client); \
 	long val = simple_strtol(buf, NULL, 10); \
  \
 	down(&data->update_lock); \
-	data->pwm[offset-1] = PWM_TO_REG(val, \
+	data->pwm[attr->index-1] = PWM_TO_REG(val, \
 			      FAN_CONFIG_INVERT(data->fan_conf, offset-1)); \
 	pc87360_write_value(data, LD_FAN, NO_BANK, PC87360_REG_PWM(offset-1), \
-			    data->pwm[offset-1]); \
+			    data->pwm[attr->index-1]); \
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
 
 #define show_and_set_in(offset) \
-static ssize_t show_in##offset##_input(struct device *dev, struct device_attribute *attr, char *buf) \
+static ssize_t show_in##offset##_input(struct device *dev, struct device_attribute *devattr, char *buf) \
 { \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
-	return sprintf(buf, "%u\n", IN_FROM_REG(data->in[offset], \
+	return sprintf(buf, "%u\n", IN_FROM_REG(data->in[attr->index], \
 		       data->in_vref)); \
 } \
-static ssize_t show_in##offset##_min(struct device *dev, struct device_attribute *attr, char *buf) \
+static ssize_t show_in##offset##_min(struct device *dev, struct device_attribute *devattr, char *buf) \
 { \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
-	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_min[offset], \
+	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_min[attr->index], \
 		       data->in_vref)); \
 } \
-static ssize_t show_in##offset##_max(struct device *dev, struct device_attribute *attr, char *buf) \
+static ssize_t show_in##offset##_max(struct device *dev, struct device_attribute *devattr, char *buf) \
 { \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
-	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_max[offset], \
+	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_max[attr->index], \
 		       data->in_vref)); \
 } \
-static ssize_t show_in##offset##_status(struct device *dev, struct device_attribute *attr, char *buf) \
+static ssize_t show_in##offset##_status(struct device *dev, struct device_attribute *devattr, char *buf) \
 { \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
-	return sprintf(buf, "%u\n", data->in_status[offset]); \
+	return sprintf(buf, "%u\n", data->in_status[attr->index]); \
 } \
-static ssize_t set_in##offset##_min(struct device *dev, struct device_attribute *attr, const char *buf, \
+static ssize_t set_in##offset##_min(struct device *dev, struct device_attribute *devattr, const char *buf, \
 	size_t count) \
 { \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct pc87360_data *data = i2c_get_clientdata(client); \
 	long val = simple_strtol(buf, NULL, 10); \
  \
 	down(&data->update_lock); \
-	data->in_min[offset] = IN_TO_REG(val, data->in_vref); \
-	pc87360_write_value(data, LD_IN, offset, PC87365_REG_IN_MIN, \
-			    data->in_min[offset]); \
+	data->in_min[attr->index] = IN_TO_REG(val, data->in_vref); \
+	pc87360_write_value(data, LD_IN, attr->index, PC87365_REG_IN_MIN, \
+			    data->in_min[attr->index]); \
 	up(&data->update_lock); \
 	return count; \
 } \
-static ssize_t set_in##offset##_max(struct device *dev, struct device_attribute *attr, const char *buf, \
+static ssize_t set_in##offset##_max(struct device *dev, struct device_attribute *devattr, const char *buf, \
 	size_t count) \
 { \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct pc87360_data *data = i2c_get_clientdata(client); \
 	long val = simple_strtol(buf, NULL, 10); \
  \
 	down(&data->update_lock); \
-	data->in_max[offset] = IN_TO_REG(val, \
+	data->in_max[attr->index] = IN_TO_REG(val, \
 			       data->in_vref); \
-	pc87360_write_value(data, LD_IN, offset, PC87365_REG_IN_MAX, \
-			    data->in_max[offset]); \
+	pc87360_write_value(data, LD_IN, attr->index, PC87365_REG_IN_MAX, \
+			    data->in_max[attr->index]); \
 	up(&data->update_lock); \
 	return count; \
 } \
-static DEVICE_ATTR(in##offset##_input, S_IRUGO, \
-	show_in##offset##_input, NULL); \
-static DEVICE_ATTR(in##offset##_min, S_IWUSR | S_IRUGO, \
-	show_in##offset##_min, set_in##offset##_min); \
-static DEVICE_ATTR(in##offset##_max, S_IWUSR | S_IRUGO, \
-	show_in##offset##_max, set_in##offset##_max); \
-static DEVICE_ATTR(in##offset##_status, S_IRUGO, \
-	show_in##offset##_status, NULL);
+static SENSOR_DEVICE_ATTR(in##offset##_input, S_IRUGO, \
+	show_in##offset##_input, NULL, offset); \
+static SENSOR_DEVICE_ATTR(in##offset##_min, S_IWUSR | S_IRUGO, \
+	show_in##offset##_min, set_in##offset##_min, offset); \
+static SENSOR_DEVICE_ATTR(in##offset##_max, S_IWUSR | S_IRUGO, \
+	show_in##offset##_max, set_in##offset##_max, offset); \
+static SENSOR_DEVICE_ATTR(in##offset##_status, S_IRUGO, \
+	show_in##offset##_status, NULL, offset);
 show_and_set_in(0)
 show_and_set_in(1)
 show_and_set_in(2)
@@ -420,87 +434,95 @@ show_and_set_in(9)
 show_and_set_in(10)
 
 #define show_and_set_therm(offset) \
-static ssize_t show_temp##offset##_input(struct device *dev, struct device_attribute *attr, char *buf) \
+static ssize_t show_temp##offset##_input(struct device *dev, struct device_attribute *devattr, char *buf) \
 { \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
-	return sprintf(buf, "%u\n", IN_FROM_REG(data->in[offset+7], \
+	return sprintf(buf, "%u\n", IN_FROM_REG(data->in[attr->index+7], \
 		       data->in_vref)); \
 } \
-static ssize_t show_temp##offset##_min(struct device *dev, struct device_attribute *attr, char *buf) \
+static ssize_t show_temp##offset##_min(struct device *dev, struct device_attribute *devattr, char *buf) \
 { \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
-	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_min[offset+7], \
+	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_min[attr->index+7], \
 		       data->in_vref)); \
 } \
-static ssize_t show_temp##offset##_max(struct device *dev, struct device_attribute *attr, char *buf) \
+static ssize_t show_temp##offset##_max(struct device *dev, struct device_attribute *devattr, char *buf) \
 { \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
-	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_max[offset+7], \
+	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_max[attr->index+7], \
 		       data->in_vref)); \
 } \
-static ssize_t show_temp##offset##_crit(struct device *dev, struct device_attribute *attr, char *buf) \
+static ssize_t show_temp##offset##_crit(struct device *dev, struct device_attribute *devattr, char *buf) \
 { \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
-	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_crit[offset-4], \
+	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_crit[attr->index-4], \
 		       data->in_vref)); \
 } \
-static ssize_t show_temp##offset##_status(struct device *dev, struct device_attribute *attr, char *buf) \
+static ssize_t show_temp##offset##_status(struct device *dev, struct device_attribute *devattr, char *buf) \
 { \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
-	return sprintf(buf, "%u\n", data->in_status[offset+7]); \
+	return sprintf(buf, "%u\n", data->in_status[attr->index+7]); \
 } \
-static ssize_t set_temp##offset##_min(struct device *dev, struct device_attribute *attr, const char *buf, \
+static ssize_t set_temp##offset##_min(struct device *dev, struct device_attribute *devattr, const char *buf, \
 	size_t count) \
 { \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct pc87360_data *data = i2c_get_clientdata(client); \
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
-static ssize_t set_temp##offset##_max(struct device *dev, struct device_attribute *attr, const char *buf, \
+static ssize_t set_temp##offset##_max(struct device *dev, struct device_attribute *devattr, const char *buf, \
 	size_t count) \
 { \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct pc87360_data *data = i2c_get_clientdata(client); \
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
-static ssize_t set_temp##offset##_crit(struct device *dev, struct device_attribute *attr, const char *buf, \
+static ssize_t set_temp##offset##_crit(struct device *dev, struct device_attribute *devattr, const char *buf, \
 	size_t count) \
 { \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct pc87360_data *data = i2c_get_clientdata(client); \
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
-static DEVICE_ATTR(temp##offset##_input, S_IRUGO, \
-	show_temp##offset##_input, NULL); \
-static DEVICE_ATTR(temp##offset##_min, S_IWUSR | S_IRUGO, \
-	show_temp##offset##_min, set_temp##offset##_min); \
-static DEVICE_ATTR(temp##offset##_max, S_IWUSR | S_IRUGO, \
-	show_temp##offset##_max, set_temp##offset##_max); \
-static DEVICE_ATTR(temp##offset##_crit, S_IWUSR | S_IRUGO, \
-	show_temp##offset##_crit, set_temp##offset##_crit); \
-static DEVICE_ATTR(temp##offset##_status, S_IRUGO, \
-	show_temp##offset##_status, NULL);
+static SENSOR_DEVICE_ATTR(temp##offset##_input, S_IRUGO, \
+	show_temp##offset##_input, NULL, offset); \
+static SENSOR_DEVICE_ATTR(temp##offset##_min, S_IWUSR | S_IRUGO, \
+	show_temp##offset##_min, set_temp##offset##_min, offset); \
+static SENSOR_DEVICE_ATTR(temp##offset##_max, S_IWUSR | S_IRUGO, \
+	show_temp##offset##_max, set_temp##offset##_max, offset); \
+static SENSOR_DEVICE_ATTR(temp##offset##_crit, S_IWUSR | S_IRUGO, \
+	show_temp##offset##_crit, set_temp##offset##_crit, offset); \
+static SENSOR_DEVICE_ATTR(temp##offset##_status, S_IRUGO, \
+	show_temp##offset##_status, NULL, offset);
 show_and_set_therm(4)
 show_and_set_therm(5)
 show_and_set_therm(6)
@@ -534,83 +556,91 @@ static ssize_t show_in_alarms(struct dev
 static DEVICE_ATTR(alarms_in, S_IRUGO, show_in_alarms, NULL);
 
 #define show_and_set_temp(offset) \
-static ssize_t show_temp##offset##_input(struct device *dev, struct device_attribute *attr, char *buf) \
+static ssize_t show_temp##offset##_input(struct device *dev, struct device_attribute *devattr, char *buf) \
 { \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[offset-1])); \
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[attr->index-1])); \
 } \
-static ssize_t show_temp##offset##_min(struct device *dev, struct device_attribute *attr, char *buf) \
+static ssize_t show_temp##offset##_min(struct device *dev, struct device_attribute *devattr, char *buf) \
 { \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_min[offset-1])); \
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_min[attr->index-1])); \
 } \
-static ssize_t show_temp##offset##_max(struct device *dev, struct device_attribute *attr, char *buf) \
+static ssize_t show_temp##offset##_max(struct device *dev, struct device_attribute *devattr, char *buf) \
 { \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_max[offset-1])); \
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_max[attr->index-1])); \
 }\
-static ssize_t show_temp##offset##_crit(struct device *dev, struct device_attribute *attr, char *buf) \
+static ssize_t show_temp##offset##_crit(struct device *dev, struct device_attribute *devattr, char *buf) \
 { \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_crit[offset-1])); \
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_crit[attr->index-1])); \
 }\
-static ssize_t show_temp##offset##_status(struct device *dev, struct device_attribute *attr, char *buf) \
+static ssize_t show_temp##offset##_status(struct device *dev, struct device_attribute *devattr, char *buf) \
 { \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
-	return sprintf(buf, "%d\n", data->temp_status[offset-1]); \
+	return sprintf(buf, "%d\n", data->temp_status[attr->index-1]); \
 }\
-static ssize_t set_temp##offset##_min(struct device *dev, struct device_attribute *attr, const char *buf, \
+static ssize_t set_temp##offset##_min(struct device *dev, struct device_attribute *devattr, const char *buf, \
 	size_t count) \
 { \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct pc87360_data *data = i2c_get_clientdata(client); \
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
-static ssize_t set_temp##offset##_max(struct device *dev, struct device_attribute *attr, const char *buf, \
+static ssize_t set_temp##offset##_max(struct device *dev, struct device_attribute *devattr, const char *buf, \
 	size_t count) \
 { \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct pc87360_data *data = i2c_get_clientdata(client); \
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
-static ssize_t set_temp##offset##_crit(struct device *dev, struct device_attribute *attr, const char *buf, \
+static ssize_t set_temp##offset##_crit(struct device *dev, struct device_attribute *devattr, const char *buf, \
 	size_t count) \
 { \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct pc87360_data *data = i2c_get_clientdata(client); \
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
-static DEVICE_ATTR(temp##offset##_input, S_IRUGO, \
-	show_temp##offset##_input, NULL); \
-static DEVICE_ATTR(temp##offset##_min, S_IWUSR | S_IRUGO, \
-	show_temp##offset##_min, set_temp##offset##_min); \
-static DEVICE_ATTR(temp##offset##_max, S_IWUSR | S_IRUGO, \
-	show_temp##offset##_max, set_temp##offset##_max); \
-static DEVICE_ATTR(temp##offset##_crit, S_IWUSR | S_IRUGO, \
-	show_temp##offset##_crit, set_temp##offset##_crit); \
-static DEVICE_ATTR(temp##offset##_status, S_IRUGO, \
-	show_temp##offset##_status, NULL);
+static SENSOR_DEVICE_ATTR(temp##offset##_input, S_IRUGO, \
+	show_temp##offset##_input, NULL, offset); \
+static SENSOR_DEVICE_ATTR(temp##offset##_min, S_IWUSR | S_IRUGO, \
+	show_temp##offset##_min, set_temp##offset##_min, offset); \
+static SENSOR_DEVICE_ATTR(temp##offset##_max, S_IWUSR | S_IRUGO, \
+	show_temp##offset##_max, set_temp##offset##_max, offset); \
+static SENSOR_DEVICE_ATTR(temp##offset##_crit, S_IWUSR | S_IRUGO, \
+	show_temp##offset##_crit, set_temp##offset##_crit, offset); \
+static SENSOR_DEVICE_ATTR(temp##offset##_status, S_IRUGO, \
+	show_temp##offset##_status, NULL, offset);
 show_and_set_temp(1)
 show_and_set_temp(2)
 show_and_set_temp(3)
@@ -829,50 +859,50 @@ static int pc87360_detect(struct i2c_ada
 	}
 
 	if (data->innr) {
-		device_create_file(&new_client->dev, &dev_attr_in0_input);
-		device_create_file(&new_client->dev, &dev_attr_in1_input);
-		device_create_file(&new_client->dev, &dev_attr_in2_input);
-		device_create_file(&new_client->dev, &dev_attr_in3_input);
-		device_create_file(&new_client->dev, &dev_attr_in4_input);
-		device_create_file(&new_client->dev, &dev_attr_in5_input);
-		device_create_file(&new_client->dev, &dev_attr_in6_input);
-		device_create_file(&new_client->dev, &dev_attr_in7_input);
-		device_create_file(&new_client->dev, &dev_attr_in8_input);
-		device_create_file(&new_client->dev, &dev_attr_in9_input);
-		device_create_file(&new_client->dev, &dev_attr_in10_input);
-		device_create_file(&new_client->dev, &dev_attr_in0_min);
-		device_create_file(&new_client->dev, &dev_attr_in1_min);
-		device_create_file(&new_client->dev, &dev_attr_in2_min);
-		device_create_file(&new_client->dev, &dev_attr_in3_min);
-		device_create_file(&new_client->dev, &dev_attr_in4_min);
-		device_create_file(&new_client->dev, &dev_attr_in5_min);
-		device_create_file(&new_client->dev, &dev_attr_in6_min);
-		device_create_file(&new_client->dev, &dev_attr_in7_min);
-		device_create_file(&new_client->dev, &dev_attr_in8_min);
-		device_create_file(&new_client->dev, &dev_attr_in9_min);
-		device_create_file(&new_client->dev, &dev_attr_in10_min);
-		device_create_file(&new_client->dev, &dev_attr_in0_max);
-		device_create_file(&new_client->dev, &dev_attr_in1_max);
-		device_create_file(&new_client->dev, &dev_attr_in2_max);
-		device_create_file(&new_client->dev, &dev_attr_in3_max);
-		device_create_file(&new_client->dev, &dev_attr_in4_max);
-		device_create_file(&new_client->dev, &dev_attr_in5_max);
-		device_create_file(&new_client->dev, &dev_attr_in6_max);
-		device_create_file(&new_client->dev, &dev_attr_in7_max);
-		device_create_file(&new_client->dev, &dev_attr_in8_max);
-		device_create_file(&new_client->dev, &dev_attr_in9_max);
-		device_create_file(&new_client->dev, &dev_attr_in10_max);
-		device_create_file(&new_client->dev, &dev_attr_in0_status);
-		device_create_file(&new_client->dev, &dev_attr_in1_status);
-		device_create_file(&new_client->dev, &dev_attr_in2_status);
-		device_create_file(&new_client->dev, &dev_attr_in3_status);
-		device_create_file(&new_client->dev, &dev_attr_in4_status);
-		device_create_file(&new_client->dev, &dev_attr_in5_status);
-		device_create_file(&new_client->dev, &dev_attr_in6_status);
-		device_create_file(&new_client->dev, &dev_attr_in7_status);
-		device_create_file(&new_client->dev, &dev_attr_in8_status);
-		device_create_file(&new_client->dev, &dev_attr_in9_status);
-		device_create_file(&new_client->dev, &dev_attr_in10_status);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in0_input.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in1_input.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in2_input.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in3_input.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in4_input.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in5_input.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in6_input.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in7_input.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in8_input.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in9_input.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in10_input.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in0_min.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in1_min.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in2_min.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in3_min.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in4_min.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in5_min.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in6_min.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in7_min.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in8_min.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in9_min.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in10_min.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in0_max.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in1_max.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in2_max.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in3_max.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in4_max.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in5_max.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in6_max.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in7_max.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in8_max.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in9_max.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in10_max.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in0_status.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in1_status.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in2_status.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in3_status.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in4_status.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in5_status.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in6_status.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in7_status.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in8_status.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in9_status.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in10_status.dev_attr);
 
 		device_create_file(&new_client->dev, &dev_attr_cpu0_vid);
 		device_create_file(&new_client->dev, &dev_attr_vrm);
@@ -880,86 +910,86 @@ static int pc87360_detect(struct i2c_ada
 	}
 
 	if (data->tempnr) {
-		device_create_file(&new_client->dev, &dev_attr_temp1_input);
-		device_create_file(&new_client->dev, &dev_attr_temp2_input);
-		device_create_file(&new_client->dev, &dev_attr_temp1_min);
-		device_create_file(&new_client->dev, &dev_attr_temp2_min);
-		device_create_file(&new_client->dev, &dev_attr_temp1_max);
-		device_create_file(&new_client->dev, &dev_attr_temp2_max);
-		device_create_file(&new_client->dev, &dev_attr_temp1_crit);
-		device_create_file(&new_client->dev, &dev_attr_temp2_crit);
-		device_create_file(&new_client->dev, &dev_attr_temp1_status);
-		device_create_file(&new_client->dev, &dev_attr_temp2_status);
+		device_create_file(&new_client->dev, &sensor_dev_attr_temp1_input.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_temp2_input.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_temp1_min.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_temp2_min.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_temp1_max.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_temp2_max.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_temp1_crit.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_temp2_crit.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_temp1_status.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_temp2_status.dev_attr);
 
 		device_create_file(&new_client->dev, &dev_attr_alarms_temp);
 	}
 	if (data->tempnr = 3) {
-		device_create_file(&new_client->dev, &dev_attr_temp3_input);
-		device_create_file(&new_client->dev, &dev_attr_temp3_min);
-		device_create_file(&new_client->dev, &dev_attr_temp3_max);
-		device_create_file(&new_client->dev, &dev_attr_temp3_crit);
-		device_create_file(&new_client->dev, &dev_attr_temp3_status);
+		device_create_file(&new_client->dev, &sensor_dev_attr_temp3_input.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_temp3_min.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_temp3_max.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_temp3_crit.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_temp3_status.dev_attr);
 	}
 	if (data->innr = 14) {
-		device_create_file(&new_client->dev, &dev_attr_temp4_input);
-		device_create_file(&new_client->dev, &dev_attr_temp5_input);
-		device_create_file(&new_client->dev, &dev_attr_temp6_input);
-		device_create_file(&new_client->dev, &dev_attr_temp4_min);
-		device_create_file(&new_client->dev, &dev_attr_temp5_min);
-		device_create_file(&new_client->dev, &dev_attr_temp6_min);
-		device_create_file(&new_client->dev, &dev_attr_temp4_max);
-		device_create_file(&new_client->dev, &dev_attr_temp5_max);
-		device_create_file(&new_client->dev, &dev_attr_temp6_max);
-		device_create_file(&new_client->dev, &dev_attr_temp4_crit);
-		device_create_file(&new_client->dev, &dev_attr_temp5_crit);
-		device_create_file(&new_client->dev, &dev_attr_temp6_crit);
-		device_create_file(&new_client->dev, &dev_attr_temp4_status);
-		device_create_file(&new_client->dev, &dev_attr_temp5_status);
-		device_create_file(&new_client->dev, &dev_attr_temp6_status);
+		device_create_file(&new_client->dev, &sensor_dev_attr_temp4_input.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_temp5_input.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_temp6_input.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_temp4_min.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_temp5_min.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_temp6_min.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_temp4_max.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_temp5_max.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_temp6_max.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_temp4_crit.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_temp5_crit.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_temp6_crit.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_temp4_status.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_temp5_status.dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_temp6_status.dev_attr);
 	}
 
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
