From: jcromie@divsol.com (Jim Cromie)
Date: Thu, 04 Aug 2005 02:26:15 +0000
Subject: [lm-sensors] [patch pc87360 reroll 3/6] de-macro-ize dev-attr
Message-Id: <42F16043.7020706@divsol.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> convert macro-repeated callback-fns to single declaration
>    theyre already using attr->index (patch 1)
>    so this is close to a white-space patch.
>
$ diffstat 03-pc87360-attr-callback-demacro.patch
 pc87360.c |  586 
+++++++++++++++++++++++++++++++-------------------------------
 1 files changed, 296 insertions(+), 290 deletions(-)

Signed-off-by:  Jim Cromie <jcromie@divsol.com>
-------------- next part --------------
diff -ruNp -X exclude-diffs gc-2/drivers/hwmon/pc87360.c gc-3/drivers/hwmon/pc87360.c
--- gc-2/drivers/hwmon/pc87360.c	2005-08-03 17:12:16.000000000 -0600
+++ gc-3/drivers/hwmon/pc87360.c	2005-08-03 17:12:38.000000000 -0600
@@ -275,152 +275,154 @@ static ssize_t _set_fan_min(struct devic
 	return count;
 }
 
+static ssize_t show_fan_input(struct device *dev, struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct pc87360_data *data = pc87360_update_device(dev);
+	return sprintf(buf, "%u\n", FAN_FROM_REG(data->fan[attr->index-1],
+		       FAN_DIV_FROM_REG(data->fan_status[attr->index-1])));
+}
+static ssize_t show_fan_min(struct device *dev, struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct pc87360_data *data = pc87360_update_device(dev);
+	return sprintf(buf, "%u\n", FAN_FROM_REG(data->fan_min[attr->index-1],
+		       FAN_DIV_FROM_REG(data->fan_status[attr->index-1])));
+}
+static ssize_t show_fan_div(struct device *dev, struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct pc87360_data *data = pc87360_update_device(dev);
+	return sprintf(buf, "%u\n",
+		       FAN_DIV_FROM_REG(data->fan_status[attr->index-1]));
+}
+static ssize_t show_fan_status(struct device *dev, struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct pc87360_data *data = pc87360_update_device(dev);
+	return sprintf(buf, "%u\n",
+		       FAN_STATUS_FROM_REG(data->fan_status[attr->index-1]));
+}
+static ssize_t set_fan_min(struct device *dev, struct device_attribute *devattr, const char *buf,
+	size_t count)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	return _set_fan_min(dev, buf, count, attr->index-1);
+}
+
 #define show_and_set_fan(offset) \
-static ssize_t show_fan##offset##_input(struct device *dev, struct device_attribute *devattr, char *buf) \
-{ \
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
-	struct pc87360_data *data = pc87360_update_device(dev); \
-	return sprintf(buf, "%u\n", FAN_FROM_REG(data->fan[attr->index-1], \
-		       FAN_DIV_FROM_REG(data->fan_status[attr->index-1]))); \
-} \
-static ssize_t show_fan##offset##_min(struct device *dev, struct device_attribute *devattr, char *buf) \
-{ \
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
-	struct pc87360_data *data = pc87360_update_device(dev); \
-	return sprintf(buf, "%u\n", FAN_FROM_REG(data->fan_min[attr->index-1], \
-		       FAN_DIV_FROM_REG(data->fan_status[attr->index-1]))); \
-} \
-static ssize_t show_fan##offset##_div(struct device *dev, struct device_attribute *devattr, char *buf) \
-{ \
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
-	struct pc87360_data *data = pc87360_update_device(dev); \
-	return sprintf(buf, "%u\n", \
-		       FAN_DIV_FROM_REG(data->fan_status[attr->index-1])); \
-} \
-static ssize_t show_fan##offset##_status(struct device *dev, struct device_attribute *devattr, char *buf) \
-{ \
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
-	struct pc87360_data *data = pc87360_update_device(dev); \
-	return sprintf(buf, "%u\n", \
-		       FAN_STATUS_FROM_REG(data->fan_status[attr->index-1])); \
-} \
-static ssize_t set_fan##offset##_min(struct device *dev, struct device_attribute *devattr, const char *buf, \
-	size_t count) \
-{ \
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
-	return _set_fan_min(dev, buf, count, attr->index-1); \
-} \
 static SENSOR_DEVICE_ATTR(fan##offset##_input, S_IRUGO, \
-	show_fan##offset##_input, NULL, offset); \
+	show_fan_input, NULL, offset); \
 static SENSOR_DEVICE_ATTR(fan##offset##_min, S_IWUSR | S_IRUGO, \
-	show_fan##offset##_min, set_fan##offset##_min, offset); \
+	show_fan_min, set_fan_min, offset); \
 static SENSOR_DEVICE_ATTR(fan##offset##_div, S_IRUGO, \
-	show_fan##offset##_div, NULL, offset); \
+	show_fan_div, NULL, offset); \
 static SENSOR_DEVICE_ATTR(fan##offset##_status, S_IRUGO, \
-	show_fan##offset##_status, NULL, offset);
+	show_fan_status, NULL, offset);
 show_and_set_fan(1)
 show_and_set_fan(2)
 show_and_set_fan(3)
 
+static ssize_t show_pwm(struct device *dev, struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct pc87360_data *data = pc87360_update_device(dev);
+	return sprintf(buf, "%u\n",
+		       PWM_FROM_REG(data->pwm[attr->index-1],
+				    FAN_CONFIG_INVERT(data->fan_conf,
+						      attr->index-1)));
+}
+static ssize_t set_pwm(struct device *dev, struct device_attribute *devattr, const char *buf,
+	size_t count)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct pc87360_data *data = i2c_get_clientdata(client);
+	long val = simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
+	data->pwm[attr->index-1] = PWM_TO_REG(val,
+			      FAN_CONFIG_INVERT(data->fan_conf, attr->index-1));
+	pc87360_write_value(data, LD_FAN, NO_BANK, PC87360_REG_PWM(attr->index-1),
+			    data->pwm[attr->index-1]);
+	up(&data->update_lock);
+	return count;
+}
+
 #define show_and_set_pwm(offset) \
-static ssize_t show_pwm##offset(struct device *dev, struct device_attribute *devattr, char *buf) \
-{ \
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
-	struct pc87360_data *data = pc87360_update_device(dev); \
-	return sprintf(buf, "%u\n", \
-		       PWM_FROM_REG(data->pwm[attr->index-1], \
-				    FAN_CONFIG_INVERT(data->fan_conf, \
-						      offset-1))); \
-} \
-static ssize_t set_pwm##offset(struct device *dev, struct device_attribute *devattr, const char *buf, \
-	size_t count) \
-{ \
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
-	struct i2c_client *client = to_i2c_client(dev); \
-	struct pc87360_data *data = i2c_get_clientdata(client); \
-	long val = simple_strtol(buf, NULL, 10); \
- \
-	down(&data->update_lock); \
-	data->pwm[attr->index-1] = PWM_TO_REG(val, \
-			      FAN_CONFIG_INVERT(data->fan_conf, offset-1)); \
-	pc87360_write_value(data, LD_FAN, NO_BANK, PC87360_REG_PWM(offset-1), \
-			    data->pwm[attr->index-1]); \
-	up(&data->update_lock); \
-	return count; \
-} \
 static SENSOR_DEVICE_ATTR(pwm##offset, S_IWUSR | S_IRUGO, \
-	show_pwm##offset, set_pwm##offset, offset);
+	show_pwm, set_pwm, offset);
 show_and_set_pwm(1)
 show_and_set_pwm(2)
 show_and_set_pwm(3)
 
+static ssize_t show_in_input(struct device *dev, struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct pc87360_data *data = pc87360_update_device(dev);
+	return sprintf(buf, "%u\n", IN_FROM_REG(data->in[attr->index],
+		       data->in_vref));
+}
+static ssize_t show_in_min(struct device *dev, struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct pc87360_data *data = pc87360_update_device(dev);
+	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_min[attr->index],
+		       data->in_vref));
+}
+static ssize_t show_in_max(struct device *dev, struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct pc87360_data *data = pc87360_update_device(dev);
+	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_max[attr->index],
+		       data->in_vref));
+}
+static ssize_t show_in_status(struct device *dev, struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct pc87360_data *data = pc87360_update_device(dev);
+	return sprintf(buf, "%u\n", data->in_status[attr->index]);
+}
+static ssize_t set_in_min(struct device *dev, struct device_attribute *devattr, const char *buf,
+	size_t count)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct pc87360_data *data = i2c_get_clientdata(client);
+	long val = simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
+	data->in_min[attr->index] = IN_TO_REG(val, data->in_vref);
+	pc87360_write_value(data, LD_IN, attr->index, PC87365_REG_IN_MIN,
+			    data->in_min[attr->index]);
+	up(&data->update_lock);
+	return count;
+}
+static ssize_t set_in_max(struct device *dev, struct device_attribute *devattr, const char *buf,
+	size_t count)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct pc87360_data *data = i2c_get_clientdata(client);
+	long val = simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
+	data->in_max[attr->index] = IN_TO_REG(val,
+			       data->in_vref);
+	pc87360_write_value(data, LD_IN, attr->index, PC87365_REG_IN_MAX,
+			    data->in_max[attr->index]);
+	up(&data->update_lock);
+	return count;
+}
 #define show_and_set_in(offset) \
-static ssize_t show_in##offset##_input(struct device *dev, struct device_attribute *devattr, char *buf) \
-{ \
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
-	struct pc87360_data *data = pc87360_update_device(dev); \
-	return sprintf(buf, "%u\n", IN_FROM_REG(data->in[attr->index], \
-		       data->in_vref)); \
-} \
-static ssize_t show_in##offset##_min(struct device *dev, struct device_attribute *devattr, char *buf) \
-{ \
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
-	struct pc87360_data *data = pc87360_update_device(dev); \
-	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_min[attr->index], \
-		       data->in_vref)); \
-} \
-static ssize_t show_in##offset##_max(struct device *dev, struct device_attribute *devattr, char *buf) \
-{ \
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
-	struct pc87360_data *data = pc87360_update_device(dev); \
-	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_max[attr->index], \
-		       data->in_vref)); \
-} \
-static ssize_t show_in##offset##_status(struct device *dev, struct device_attribute *devattr, char *buf) \
-{ \
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
-	struct pc87360_data *data = pc87360_update_device(dev); \
-	return sprintf(buf, "%u\n", data->in_status[attr->index]); \
-} \
-static ssize_t set_in##offset##_min(struct device *dev, struct device_attribute *devattr, const char *buf, \
-	size_t count) \
-{ \
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
-	struct i2c_client *client = to_i2c_client(dev); \
-	struct pc87360_data *data = i2c_get_clientdata(client); \
-	long val = simple_strtol(buf, NULL, 10); \
- \
-	down(&data->update_lock); \
-	data->in_min[attr->index] = IN_TO_REG(val, data->in_vref); \
-	pc87360_write_value(data, LD_IN, attr->index, PC87365_REG_IN_MIN, \
-			    data->in_min[attr->index]); \
-	up(&data->update_lock); \
-	return count; \
-} \
-static ssize_t set_in##offset##_max(struct device *dev, struct device_attribute *devattr, const char *buf, \
-	size_t count) \
-{ \
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
-	struct i2c_client *client = to_i2c_client(dev); \
-	struct pc87360_data *data = i2c_get_clientdata(client); \
-	long val = simple_strtol(buf, NULL, 10); \
- \
-	down(&data->update_lock); \
-	data->in_max[attr->index] = IN_TO_REG(val, \
-			       data->in_vref); \
-	pc87360_write_value(data, LD_IN, attr->index, PC87365_REG_IN_MAX, \
-			    data->in_max[attr->index]); \
-	up(&data->update_lock); \
-	return count; \
-} \
 static SENSOR_DEVICE_ATTR(in##offset##_input, S_IRUGO, \
-	show_in##offset##_input, NULL, offset); \
+	show_in_input, NULL, offset); \
 static SENSOR_DEVICE_ATTR(in##offset##_min, S_IWUSR | S_IRUGO, \
-	show_in##offset##_min, set_in##offset##_min, offset); \
+	show_in_min, set_in_min, offset); \
 static SENSOR_DEVICE_ATTR(in##offset##_max, S_IWUSR | S_IRUGO, \
-	show_in##offset##_max, set_in##offset##_max, offset); \
+	show_in_max, set_in_max, offset); \
 static SENSOR_DEVICE_ATTR(in##offset##_status, S_IRUGO, \
-	show_in##offset##_status, NULL, offset);
+	show_in_status, NULL, offset);
 show_and_set_in(0)
 show_and_set_in(1)
 show_and_set_in(2)
@@ -433,96 +435,97 @@ show_and_set_in(8)
 show_and_set_in(9)
 show_and_set_in(10)
 
+static ssize_t show_therm_input(struct device *dev, struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct pc87360_data *data = pc87360_update_device(dev);
+	return sprintf(buf, "%u\n", IN_FROM_REG(data->in[attr->index+7],
+		       data->in_vref));
+}
+static ssize_t show_therm_min(struct device *dev, struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct pc87360_data *data = pc87360_update_device(dev);
+	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_min[attr->index+7],
+		       data->in_vref));
+}
+static ssize_t show_therm_max(struct device *dev, struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct pc87360_data *data = pc87360_update_device(dev);
+	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_max[attr->index+7],
+		       data->in_vref));
+}
+static ssize_t show_therm_crit(struct device *dev, struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct pc87360_data *data = pc87360_update_device(dev);
+	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_crit[attr->index-4],
+		       data->in_vref));
+}
+static ssize_t show_therm_status(struct device *dev, struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct pc87360_data *data = pc87360_update_device(dev);
+	return sprintf(buf, "%u\n", data->in_status[attr->index+7]);
+}
+static ssize_t set_therm_min(struct device *dev, struct device_attribute *devattr, const char *buf,
+	size_t count)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct pc87360_data *data = i2c_get_clientdata(client);
+	long val = simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
+	data->in_min[attr->index+7] = IN_TO_REG(val, data->in_vref);
+	pc87360_write_value(data, LD_IN, attr->index+7, PC87365_REG_TEMP_MIN,
+			    data->in_min[attr->index+7]);
+	up(&data->update_lock);
+	return count;
+}
+static ssize_t set_therm_max(struct device *dev, struct device_attribute *devattr, const char *buf,
+	size_t count)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct pc87360_data *data = i2c_get_clientdata(client);
+	long val = simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
+	data->in_max[attr->index+7] = IN_TO_REG(val, data->in_vref);
+	pc87360_write_value(data, LD_IN, attr->index+7, PC87365_REG_TEMP_MAX,
+			    data->in_max[attr->index+7]);
+	up(&data->update_lock);
+	return count;
+}
+static ssize_t set_therm_crit(struct device *dev, struct device_attribute *devattr, const char *buf,
+	size_t count)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct pc87360_data *data = i2c_get_clientdata(client);
+	long val = simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
+	data->in_crit[attr->index-4] = IN_TO_REG(val, data->in_vref);
+	pc87360_write_value(data, LD_IN, attr->index+7, PC87365_REG_TEMP_CRIT,
+			    data->in_crit[attr->index-4]);
+	up(&data->update_lock);
+	return count;
+}
+
 #define show_and_set_therm(offset) \
-static ssize_t show_therm##offset##_input(struct device *dev, struct device_attribute *devattr, char *buf) \
-{ \
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
-	struct pc87360_data *data = pc87360_update_device(dev); \
-	return sprintf(buf, "%u\n", IN_FROM_REG(data->in[attr->index+7], \
-		       data->in_vref)); \
-} \
-static ssize_t show_therm##offset##_min(struct device *dev, struct device_attribute *devattr, char *buf) \
-{ \
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
-	struct pc87360_data *data = pc87360_update_device(dev); \
-	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_min[attr->index+7], \
-		       data->in_vref)); \
-} \
-static ssize_t show_therm##offset##_max(struct device *dev, struct device_attribute *devattr, char *buf) \
-{ \
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
-	struct pc87360_data *data = pc87360_update_device(dev); \
-	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_max[attr->index+7], \
-		       data->in_vref)); \
-} \
-static ssize_t show_therm##offset##_crit(struct device *dev, struct device_attribute *devattr, char *buf) \
-{ \
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
-	struct pc87360_data *data = pc87360_update_device(dev); \
-	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_crit[attr->index-4], \
-		       data->in_vref)); \
-} \
-static ssize_t show_therm##offset##_status(struct device *dev, struct device_attribute *devattr, char *buf) \
-{ \
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
-	struct pc87360_data *data = pc87360_update_device(dev); \
-	return sprintf(buf, "%u\n", data->in_status[attr->index+7]); \
-} \
-static ssize_t set_therm##offset##_min(struct device *dev, struct device_attribute *devattr, const char *buf, \
-	size_t count) \
-{ \
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
-	struct i2c_client *client = to_i2c_client(dev); \
-	struct pc87360_data *data = i2c_get_clientdata(client); \
-	long val = simple_strtol(buf, NULL, 10); \
- \
-	down(&data->update_lock); \
-	data->in_min[attr->index+7] = IN_TO_REG(val, data->in_vref); \
-	pc87360_write_value(data, LD_IN, attr->index+7, PC87365_REG_TEMP_MIN, \
-			    data->in_min[attr->index+7]); \
-	up(&data->update_lock); \
-	return count; \
-} \
-static ssize_t set_therm##offset##_max(struct device *dev, struct device_attribute *devattr, const char *buf, \
-	size_t count) \
-{ \
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
-	struct i2c_client *client = to_i2c_client(dev); \
-	struct pc87360_data *data = i2c_get_clientdata(client); \
-	long val = simple_strtol(buf, NULL, 10); \
- \
-	down(&data->update_lock); \
-	data->in_max[attr->index+7] = IN_TO_REG(val, data->in_vref); \
-	pc87360_write_value(data, LD_IN, attr->index+7, PC87365_REG_TEMP_MAX, \
-			    data->in_max[attr->index+7]); \
-	up(&data->update_lock); \
-	return count; \
-} \
-static ssize_t set_therm##offset##_crit(struct device *dev, struct device_attribute *devattr, const char *buf, \
-	size_t count) \
-{ \
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
-	struct i2c_client *client = to_i2c_client(dev); \
-	struct pc87360_data *data = i2c_get_clientdata(client); \
-	long val = simple_strtol(buf, NULL, 10); \
- \
-	down(&data->update_lock); \
-	data->in_crit[attr->index-4] = IN_TO_REG(val, data->in_vref); \
-	pc87360_write_value(data, LD_IN, attr->index+7, PC87365_REG_TEMP_CRIT, \
-			    data->in_crit[attr->index-4]); \
-	up(&data->update_lock); \
-	return count; \
-} \
 static SENSOR_DEVICE_ATTR(temp##offset##_input, S_IRUGO, \
-	show_therm##offset##_input, NULL, offset); \
+	show_therm_input, NULL, offset); \
 static SENSOR_DEVICE_ATTR(temp##offset##_min, S_IWUSR | S_IRUGO, \
-	show_therm##offset##_min, set_therm##offset##_min, offset); \
+	show_therm_min, set_therm_min, offset); \
 static SENSOR_DEVICE_ATTR(temp##offset##_max, S_IWUSR | S_IRUGO, \
-	show_therm##offset##_max, set_therm##offset##_max, offset); \
+	show_therm_max, set_therm_max, offset); \
 static SENSOR_DEVICE_ATTR(temp##offset##_crit, S_IWUSR | S_IRUGO, \
-	show_therm##offset##_crit, set_therm##offset##_crit, offset); \
+	show_therm_crit, set_therm_crit, offset); \
 static SENSOR_DEVICE_ATTR(temp##offset##_status, S_IRUGO, \
-	show_therm##offset##_status, NULL, offset);
+	show_therm_status, NULL, offset);
 show_and_set_therm(4)
 show_and_set_therm(5)
 show_and_set_therm(6)
@@ -555,96 +558,99 @@ static ssize_t show_in_alarms(struct dev
 }
 static DEVICE_ATTR(alarms_in, S_IRUGO, show_in_alarms, NULL);
 
+
+static ssize_t show_temp_input(struct device *dev, struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct pc87360_data *data = pc87360_update_device(dev);
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[attr->index-1]));
+}
+static ssize_t show_temp_min(struct device *dev, struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct pc87360_data *data = pc87360_update_device(dev);
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_min[attr->index-1]));
+}
+static ssize_t show_temp_max(struct device *dev, struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct pc87360_data *data = pc87360_update_device(dev);
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_max[attr->index-1]));
+}
+static ssize_t show_temp_crit(struct device *dev, struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct pc87360_data *data = pc87360_update_device(dev);
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_crit[attr->index-1]));
+}
+static ssize_t show_temp_status(struct device *dev, struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct pc87360_data *data = pc87360_update_device(dev);
+	return sprintf(buf, "%d\n", data->temp_status[attr->index-1]);
+}
+static ssize_t set_temp_min(struct device *dev, struct device_attribute *devattr, const char *buf,
+	size_t count)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct pc87360_data *data = i2c_get_clientdata(client);
+	long val = simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
+	data->temp_min[attr->index-1] = TEMP_TO_REG(val);
+	pc87360_write_value(data, LD_TEMP, attr->index-1, PC87365_REG_TEMP_MIN,
+			    data->temp_min[attr->index-1]);
+	up(&data->update_lock);
+	return count;
+}
+static ssize_t set_temp_max(struct device *dev, struct device_attribute *devattr, const char *buf,
+	size_t count)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct pc87360_data *data = i2c_get_clientdata(client);
+	long val = simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
+	data->temp_max[attr->index-1] = TEMP_TO_REG(val);
+	pc87360_write_value(data, LD_TEMP, attr->index-1, PC87365_REG_TEMP_MAX,
+			    data->temp_max[attr->index-1]);
+	up(&data->update_lock);
+	return count;
+}
+static ssize_t set_temp_crit(struct device *dev, struct device_attribute *devattr, const char *buf,
+	size_t count)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct pc87360_data *data = i2c_get_clientdata(client);
+	long val = simple_strtol(buf, NULL, 10);
+
+	down(&data->update_lock);
+	data->temp_crit[attr->index-1] = TEMP_TO_REG(val);
+	pc87360_write_value(data, LD_TEMP, attr->index-1, PC87365_REG_TEMP_CRIT,
+			    data->temp_crit[attr->index-1]);
+	up(&data->update_lock);
+	return count;
+}
+
 #define show_and_set_temp(offset) \
-static ssize_t show_temp##offset##_input(struct device *dev, struct device_attribute *devattr, char *buf) \
-{ \
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
-	struct pc87360_data *data = pc87360_update_device(dev); \
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[attr->index-1])); \
-} \
-static ssize_t show_temp##offset##_min(struct device *dev, struct device_attribute *devattr, char *buf) \
-{ \
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
-	struct pc87360_data *data = pc87360_update_device(dev); \
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_min[attr->index-1])); \
-} \
-static ssize_t show_temp##offset##_max(struct device *dev, struct device_attribute *devattr, char *buf) \
-{ \
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
-	struct pc87360_data *data = pc87360_update_device(dev); \
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_max[attr->index-1])); \
-}\
-static ssize_t show_temp##offset##_crit(struct device *dev, struct device_attribute *devattr, char *buf) \
-{ \
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
-	struct pc87360_data *data = pc87360_update_device(dev); \
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_crit[attr->index-1])); \
-}\
-static ssize_t show_temp##offset##_status(struct device *dev, struct device_attribute *devattr, char *buf) \
-{ \
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
-	struct pc87360_data *data = pc87360_update_device(dev); \
-	return sprintf(buf, "%d\n", data->temp_status[attr->index-1]); \
-}\
-static ssize_t set_temp##offset##_min(struct device *dev, struct device_attribute *devattr, const char *buf, \
-	size_t count) \
-{ \
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
-	struct i2c_client *client = to_i2c_client(dev); \
-	struct pc87360_data *data = i2c_get_clientdata(client); \
-	long val = simple_strtol(buf, NULL, 10); \
- \
-	down(&data->update_lock); \
-	data->temp_min[attr->index-1] = TEMP_TO_REG(val); \
-	pc87360_write_value(data, LD_TEMP, offset-1, PC87365_REG_TEMP_MIN, \
-			    data->temp_min[attr->index-1]); \
-	up(&data->update_lock); \
-	return count; \
-} \
-static ssize_t set_temp##offset##_max(struct device *dev, struct device_attribute *devattr, const char *buf, \
-	size_t count) \
-{ \
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
-	struct i2c_client *client = to_i2c_client(dev); \
-	struct pc87360_data *data = i2c_get_clientdata(client); \
-	long val = simple_strtol(buf, NULL, 10); \
- \
-	down(&data->update_lock); \
-	data->temp_max[attr->index-1] = TEMP_TO_REG(val); \
-	pc87360_write_value(data, LD_TEMP, offset-1, PC87365_REG_TEMP_MAX, \
-			    data->temp_max[attr->index-1]); \
-	up(&data->update_lock); \
-	return count; \
-} \
-static ssize_t set_temp##offset##_crit(struct device *dev, struct device_attribute *devattr, const char *buf, \
-	size_t count) \
-{ \
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
-	struct i2c_client *client = to_i2c_client(dev); \
-	struct pc87360_data *data = i2c_get_clientdata(client); \
-	long val = simple_strtol(buf, NULL, 10); \
- \
-	down(&data->update_lock); \
-	data->temp_crit[attr->index-1] = TEMP_TO_REG(val); \
-	pc87360_write_value(data, LD_TEMP, offset-1, PC87365_REG_TEMP_CRIT, \
-			    data->temp_crit[attr->index-1]); \
-	up(&data->update_lock); \
-	return count; \
-} \
 static SENSOR_DEVICE_ATTR(temp##offset##_input, S_IRUGO, \
-	show_temp##offset##_input, NULL, offset); \
+	show_temp_input, NULL, offset); \
 static SENSOR_DEVICE_ATTR(temp##offset##_min, S_IWUSR | S_IRUGO, \
-	show_temp##offset##_min, set_temp##offset##_min, offset); \
+	show_temp_min, set_temp_min, offset); \
 static SENSOR_DEVICE_ATTR(temp##offset##_max, S_IWUSR | S_IRUGO, \
-	show_temp##offset##_max, set_temp##offset##_max, offset); \
+	show_temp_max, set_temp_max, offset); \
 static SENSOR_DEVICE_ATTR(temp##offset##_crit, S_IWUSR | S_IRUGO, \
-	show_temp##offset##_crit, set_temp##offset##_crit, offset); \
+	show_temp_crit, set_temp_crit, offset); \
 static SENSOR_DEVICE_ATTR(temp##offset##_status, S_IRUGO, \
-	show_temp##offset##_status, NULL, offset);
+	show_temp_status, NULL, offset);
 show_and_set_temp(1)
 show_and_set_temp(2)
 show_and_set_temp(3)
 
+
 static ssize_t show_temp_alarms(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct pc87360_data *data = pc87360_update_device(dev);
