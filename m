From: jcromie@divsol.com (Jim Cromie)
Date: Thu, 04 Aug 2005 02:26:10 +0000
Subject: [lm-sensors] [patch pc87360 reroll 4/6] declarative attr
Message-Id: <42F16090.2090804@divsol.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> callback-fn offset de-skew
>    temp, therm, fan, pwm callbacks all have an offset skew in the code
>    which accommodates attribute numbering conventions under
>    /sys/bus/i2c/devices/9191-6620/   (ie they start at 1)
>
>    here, we move that skew into the declaration, and out of the functions
>    (except for therm, where we simpify from 2 skews to 1)
>    The declarative skew is clearer, less error-prone, and more efficient.
>
$ diffstat 04-pc87360-mv-offset-skew-2-init.patch
 pc87360.c |  104 
+++++++++++++++++++++++++++++++-------------------------------
 1 files changed, 52 insertions(+), 52 deletions(-)


Signed-off-by:  Jim Cromie <jcromie@divsol.com>
-------------- next part --------------
diff -ruNp -X exclude-diffs gc-3/drivers/hwmon/pc87360.c gc-4/drivers/hwmon/pc87360.c
--- gc-3/drivers/hwmon/pc87360.c	2005-08-03 17:12:38.000000000 -0600
+++ gc-4/drivers/hwmon/pc87360.c	2005-08-03 17:13:04.000000000 -0600
@@ -279,46 +279,46 @@ static ssize_t show_fan_input(struct dev
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct pc87360_data *data = pc87360_update_device(dev);
-	return sprintf(buf, "%u\n", FAN_FROM_REG(data->fan[attr->index-1],
-		       FAN_DIV_FROM_REG(data->fan_status[attr->index-1])));
+	return sprintf(buf, "%u\n", FAN_FROM_REG(data->fan[attr->index],
+		       FAN_DIV_FROM_REG(data->fan_status[attr->index])));
 }
 static ssize_t show_fan_min(struct device *dev, struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct pc87360_data *data = pc87360_update_device(dev);
-	return sprintf(buf, "%u\n", FAN_FROM_REG(data->fan_min[attr->index-1],
-		       FAN_DIV_FROM_REG(data->fan_status[attr->index-1])));
+	return sprintf(buf, "%u\n", FAN_FROM_REG(data->fan_min[attr->index],
+		       FAN_DIV_FROM_REG(data->fan_status[attr->index])));
 }
 static ssize_t show_fan_div(struct device *dev, struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct pc87360_data *data = pc87360_update_device(dev);
 	return sprintf(buf, "%u\n",
-		       FAN_DIV_FROM_REG(data->fan_status[attr->index-1]));
+		       FAN_DIV_FROM_REG(data->fan_status[attr->index]));
 }
 static ssize_t show_fan_status(struct device *dev, struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct pc87360_data *data = pc87360_update_device(dev);
 	return sprintf(buf, "%u\n",
-		       FAN_STATUS_FROM_REG(data->fan_status[attr->index-1]));
+		       FAN_STATUS_FROM_REG(data->fan_status[attr->index]));
 }
 static ssize_t set_fan_min(struct device *dev, struct device_attribute *devattr, const char *buf,
 	size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	return _set_fan_min(dev, buf, count, attr->index-1);
+	return _set_fan_min(dev, buf, count, attr->index);
 }
 
 #define show_and_set_fan(offset) \
 static SENSOR_DEVICE_ATTR(fan##offset##_input, S_IRUGO, \
-	show_fan_input, NULL, offset); \
+	show_fan_input, NULL, offset-1); \
 static SENSOR_DEVICE_ATTR(fan##offset##_min, S_IWUSR | S_IRUGO, \
-	show_fan_min, set_fan_min, offset); \
+	show_fan_min, set_fan_min, offset-1); \
 static SENSOR_DEVICE_ATTR(fan##offset##_div, S_IRUGO, \
-	show_fan_div, NULL, offset); \
+	show_fan_div, NULL, offset-1); \
 static SENSOR_DEVICE_ATTR(fan##offset##_status, S_IRUGO, \
-	show_fan_status, NULL, offset);
+	show_fan_status, NULL, offset-1);
 show_and_set_fan(1)
 show_and_set_fan(2)
 show_and_set_fan(3)
@@ -328,9 +328,9 @@ static ssize_t show_pwm(struct device *d
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct pc87360_data *data = pc87360_update_device(dev);
 	return sprintf(buf, "%u\n",
-		       PWM_FROM_REG(data->pwm[attr->index-1],
+		       PWM_FROM_REG(data->pwm[attr->index],
 				    FAN_CONFIG_INVERT(data->fan_conf,
-						      attr->index-1)));
+						      attr->index)));
 }
 static ssize_t set_pwm(struct device *dev, struct device_attribute *devattr, const char *buf,
 	size_t count)
@@ -341,17 +341,17 @@ static ssize_t set_pwm(struct device *de
 	long val = simple_strtol(buf, NULL, 10);
 
 	down(&data->update_lock);
-	data->pwm[attr->index-1] = PWM_TO_REG(val,
-			      FAN_CONFIG_INVERT(data->fan_conf, attr->index-1));
-	pc87360_write_value(data, LD_FAN, NO_BANK, PC87360_REG_PWM(attr->index-1),
-			    data->pwm[attr->index-1]);
+	data->pwm[attr->index] = PWM_TO_REG(val,
+			      FAN_CONFIG_INVERT(data->fan_conf, attr->index));
+	pc87360_write_value(data, LD_FAN, NO_BANK, PC87360_REG_PWM(attr->index),
+			    data->pwm[attr->index]);
 	up(&data->update_lock);
 	return count;
 }
 
 #define show_and_set_pwm(offset) \
 static SENSOR_DEVICE_ATTR(pwm##offset, S_IWUSR | S_IRUGO, \
-	show_pwm, set_pwm, offset);
+	show_pwm, set_pwm, offset-1);
 show_and_set_pwm(1)
 show_and_set_pwm(2)
 show_and_set_pwm(3)
@@ -439,21 +439,21 @@ static ssize_t show_therm_input(struct d
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct pc87360_data *data = pc87360_update_device(dev);
-	return sprintf(buf, "%u\n", IN_FROM_REG(data->in[attr->index+7],
+	return sprintf(buf, "%u\n", IN_FROM_REG(data->in[attr->index+11],
 		       data->in_vref));
 }
 static ssize_t show_therm_min(struct device *dev, struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct pc87360_data *data = pc87360_update_device(dev);
-	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_min[attr->index+7],
+	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_min[attr->index+11],
 		       data->in_vref));
 }
 static ssize_t show_therm_max(struct device *dev, struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct pc87360_data *data = pc87360_update_device(dev);
-	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_max[attr->index+7],
+	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_max[attr->index+11],
 		       data->in_vref));
 }
 static ssize_t show_therm_crit(struct device *dev, struct device_attribute *devattr, char *buf)
@@ -467,7 +467,7 @@ static ssize_t show_therm_status(struct 
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct pc87360_data *data = pc87360_update_device(dev);
-	return sprintf(buf, "%u\n", data->in_status[attr->index+7]);
+	return sprintf(buf, "%u\n", data->in_status[attr->index+11]);
 }
 static ssize_t set_therm_min(struct device *dev, struct device_attribute *devattr, const char *buf,
 	size_t count)
@@ -478,9 +478,9 @@ static ssize_t set_therm_min(struct devi
 	long val = simple_strtol(buf, NULL, 10);
 
 	down(&data->update_lock);
-	data->in_min[attr->index+7] = IN_TO_REG(val, data->in_vref);
-	pc87360_write_value(data, LD_IN, attr->index+7, PC87365_REG_TEMP_MIN,
-			    data->in_min[attr->index+7]);
+	data->in_min[attr->index+11] = IN_TO_REG(val, data->in_vref);
+	pc87360_write_value(data, LD_IN, attr->index+11, PC87365_REG_TEMP_MIN,
+			    data->in_min[attr->index+11]);
 	up(&data->update_lock);
 	return count;
 }
@@ -493,9 +493,9 @@ static ssize_t set_therm_max(struct devi
 	long val = simple_strtol(buf, NULL, 10);
 
 	down(&data->update_lock);
-	data->in_max[attr->index+7] = IN_TO_REG(val, data->in_vref);
-	pc87360_write_value(data, LD_IN, attr->index+7, PC87365_REG_TEMP_MAX,
-			    data->in_max[attr->index+7]);
+	data->in_max[attr->index+11] = IN_TO_REG(val, data->in_vref);
+	pc87360_write_value(data, LD_IN, attr->index+11, PC87365_REG_TEMP_MAX,
+			    data->in_max[attr->index+11]);
 	up(&data->update_lock);
 	return count;
 }
@@ -517,15 +517,15 @@ static ssize_t set_therm_crit(struct dev
 
 #define show_and_set_therm(offset) \
 static SENSOR_DEVICE_ATTR(temp##offset##_input, S_IRUGO, \
-	show_therm_input, NULL, offset); \
+	show_therm_input, NULL, offset-4); \
 static SENSOR_DEVICE_ATTR(temp##offset##_min, S_IWUSR | S_IRUGO, \
-	show_therm_min, set_therm_min, offset); \
+	show_therm_min, set_therm_min, offset-4); \
 static SENSOR_DEVICE_ATTR(temp##offset##_max, S_IWUSR | S_IRUGO, \
-	show_therm_max, set_therm_max, offset); \
+	show_therm_max, set_therm_max, offset-4); \
 static SENSOR_DEVICE_ATTR(temp##offset##_crit, S_IWUSR | S_IRUGO, \
-	show_therm_crit, set_therm_crit, offset); \
+	show_therm_crit, set_therm_crit, offset-4); \
 static SENSOR_DEVICE_ATTR(temp##offset##_status, S_IRUGO, \
-	show_therm_status, NULL, offset);
+	show_therm_status, NULL, offset-4);
 show_and_set_therm(4)
 show_and_set_therm(5)
 show_and_set_therm(6)
@@ -563,31 +563,31 @@ static ssize_t show_temp_input(struct de
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct pc87360_data *data = pc87360_update_device(dev);
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[attr->index-1]));
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[attr->index]));
 }
 static ssize_t show_temp_min(struct device *dev, struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct pc87360_data *data = pc87360_update_device(dev);
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_min[attr->index-1]));
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_min[attr->index]));
 }
 static ssize_t show_temp_max(struct device *dev, struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct pc87360_data *data = pc87360_update_device(dev);
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_max[attr->index-1]));
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_max[attr->index]));
 }
 static ssize_t show_temp_crit(struct device *dev, struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct pc87360_data *data = pc87360_update_device(dev);
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_crit[attr->index-1]));
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_crit[attr->index]));
 }
 static ssize_t show_temp_status(struct device *dev, struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct pc87360_data *data = pc87360_update_device(dev);
-	return sprintf(buf, "%d\n", data->temp_status[attr->index-1]);
+	return sprintf(buf, "%d\n", data->temp_status[attr->index]);
 }
 static ssize_t set_temp_min(struct device *dev, struct device_attribute *devattr, const char *buf,
 	size_t count)
@@ -598,9 +598,9 @@ static ssize_t set_temp_min(struct devic
 	long val = simple_strtol(buf, NULL, 10);
 
 	down(&data->update_lock);
-	data->temp_min[attr->index-1] = TEMP_TO_REG(val);
-	pc87360_write_value(data, LD_TEMP, attr->index-1, PC87365_REG_TEMP_MIN,
-			    data->temp_min[attr->index-1]);
+	data->temp_min[attr->index] = TEMP_TO_REG(val);
+	pc87360_write_value(data, LD_TEMP, attr->index, PC87365_REG_TEMP_MIN,
+			    data->temp_min[attr->index]);
 	up(&data->update_lock);
 	return count;
 }
@@ -613,9 +613,9 @@ static ssize_t set_temp_max(struct devic
 	long val = simple_strtol(buf, NULL, 10);
 
 	down(&data->update_lock);
-	data->temp_max[attr->index-1] = TEMP_TO_REG(val);
-	pc87360_write_value(data, LD_TEMP, attr->index-1, PC87365_REG_TEMP_MAX,
-			    data->temp_max[attr->index-1]);
+	data->temp_max[attr->index] = TEMP_TO_REG(val);
+	pc87360_write_value(data, LD_TEMP, attr->index, PC87365_REG_TEMP_MAX,
+			    data->temp_max[attr->index]);
 	up(&data->update_lock);
 	return count;
 }
@@ -628,24 +628,24 @@ static ssize_t set_temp_crit(struct devi
 	long val = simple_strtol(buf, NULL, 10);
 
 	down(&data->update_lock);
-	data->temp_crit[attr->index-1] = TEMP_TO_REG(val);
-	pc87360_write_value(data, LD_TEMP, attr->index-1, PC87365_REG_TEMP_CRIT,
-			    data->temp_crit[attr->index-1]);
+	data->temp_crit[attr->index] = TEMP_TO_REG(val);
+	pc87360_write_value(data, LD_TEMP, attr->index, PC87365_REG_TEMP_CRIT,
+			    data->temp_crit[attr->index]);
 	up(&data->update_lock);
 	return count;
 }
 
 #define show_and_set_temp(offset) \
 static SENSOR_DEVICE_ATTR(temp##offset##_input, S_IRUGO, \
-	show_temp_input, NULL, offset); \
+	show_temp_input, NULL, offset-1); \
 static SENSOR_DEVICE_ATTR(temp##offset##_min, S_IWUSR | S_IRUGO, \
-	show_temp_min, set_temp_min, offset); \
+	show_temp_min, set_temp_min, offset-1); \
 static SENSOR_DEVICE_ATTR(temp##offset##_max, S_IWUSR | S_IRUGO, \
-	show_temp_max, set_temp_max, offset); \
+	show_temp_max, set_temp_max, offset-1); \
 static SENSOR_DEVICE_ATTR(temp##offset##_crit, S_IWUSR | S_IRUGO, \
-	show_temp_crit, set_temp_crit, offset); \
+	show_temp_crit, set_temp_crit, offset-1); \
 static SENSOR_DEVICE_ATTR(temp##offset##_status, S_IRUGO, \
-	show_temp_status, NULL, offset);
+	show_temp_status, NULL, offset-1);
 show_and_set_temp(1)
 show_and_set_temp(2)
 show_and_set_temp(3)
