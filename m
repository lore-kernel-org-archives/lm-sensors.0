From: jim.cromie@gmail.com (Jim Cromie)
Date: Mon, 21 Aug 2006 03:00:09 +0000
Subject: [lm-sensors] [patch 2/3] hwmon/pc87360: use SENSOR_ATTR_2,
Message-Id: <44E921B9.10305@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


2. hwmon-pc87360-use-sensor-attr-2.patch

Converts SENSOR_ATTRs to SENSOR_ATTR_2s for most sysfs-callbacks.
Also adds a number of #define FN_$(SENSOR)_($ATTR)s which provide
symbolic values used in the sensor array initializations.

Signed-off-by:  Jim Cromie  <jim.cromie at gmail.com>

[jimc at harpo pc-set]$ diffstat hwmon-pc87360-use-sensor-attr-2.patch
 pc87360.c |  409 ++++++++++++++++++++++++++++++++++----------------------------
 1 files changed, 230 insertions(+), 179 deletions(-)

--

diff -ruNp -X dontdiff -X exclude-diffs ad-1/drivers/hwmon/pc87360.c ad-2/drivers/hwmon/pc87360.c
--- ad-1/drivers/hwmon/pc87360.c	2006-08-18 20:23:53.000000000 -0600
+++ ad-2/drivers/hwmon/pc87360.c	2006-08-20 17:10:04.000000000 -0600
@@ -248,30 +248,39 @@ static struct i2c_driver pc87360_driver 
  * Sysfs stuff
  */
 
+/* define constants for _nr parameter in SENSOR_DEV_2.  With this, we
+   can replace many show callbacks with one containing a switch() to
+   select the operation (FN) to perform.
+*/
+#define FN_FAN_INPUT	0
+#define FN_FAN_MIN	1
+#define FN_FAN_STATUS	2
+#define FN_FAN_DIV	3
+
 static ssize_t show_fan_input(struct device *dev, struct device_attribute *devattr, char *buf)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
 	struct pc87360_data *data = pc87360_update_device(dev);
 	return sprintf(buf, "%u\n", FAN_FROM_REG(data->fan[attr->index],
 		       FAN_DIV_FROM_REG(data->fan_status[attr->index])));
 }
 static ssize_t show_fan_min(struct device *dev, struct device_attribute *devattr, char *buf)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
 	struct pc87360_data *data = pc87360_update_device(dev);
 	return sprintf(buf, "%u\n", FAN_FROM_REG(data->fan_min[attr->index],
 		       FAN_DIV_FROM_REG(data->fan_status[attr->index])));
 }
 static ssize_t show_fan_div(struct device *dev, struct device_attribute *devattr, char *buf)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
 	struct pc87360_data *data = pc87360_update_device(dev);
 	return sprintf(buf, "%u\n",
 		       FAN_DIV_FROM_REG(data->fan_status[attr->index]));
 }
 static ssize_t show_fan_status(struct device *dev, struct device_attribute *devattr, char *buf)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
 	struct pc87360_data *data = pc87360_update_device(dev);
 	return sprintf(buf, "%u\n",
 		       FAN_STATUS_FROM_REG(data->fan_status[attr->index]));
@@ -279,7 +288,7 @@ static ssize_t show_fan_status(struct de
 static ssize_t set_fan_min(struct device *dev, struct device_attribute *devattr, const char *buf,
 	size_t count)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
 	struct i2c_client *client = to_i2c_client(dev);
 	struct pc87360_data *data = i2c_get_clientdata(client);
 	long fan_min = simple_strtol(buf, NULL, 10);
@@ -306,25 +315,32 @@ static ssize_t set_fan_min(struct device
 	return count;
 }
 
-static struct sensor_device_attribute fan_input[] = {
-	SENSOR_ATTR(fan1_input, S_IRUGO, show_fan_input, NULL, 0),
-	SENSOR_ATTR(fan2_input, S_IRUGO, show_fan_input, NULL, 1),
-	SENSOR_ATTR(fan3_input, S_IRUGO, show_fan_input, NULL, 2),
-};
-static struct sensor_device_attribute fan_status[] = {
-	SENSOR_ATTR(fan1_status, S_IRUGO, show_fan_status, NULL, 0),
-	SENSOR_ATTR(fan2_status, S_IRUGO, show_fan_status, NULL, 1),
-	SENSOR_ATTR(fan3_status, S_IRUGO, show_fan_status, NULL, 2),
-};
-static struct sensor_device_attribute fan_div[] = {
-	SENSOR_ATTR(fan1_div, S_IRUGO, show_fan_div, NULL, 0),
-	SENSOR_ATTR(fan2_div, S_IRUGO, show_fan_div, NULL, 1),
-	SENSOR_ATTR(fan3_div, S_IRUGO, show_fan_div, NULL, 2),
-};
-static struct sensor_device_attribute fan_min[] = {
-	SENSOR_ATTR(fan1_min, S_IWUSR | S_IRUGO, show_fan_min, set_fan_min, 0),
-	SENSOR_ATTR(fan2_min, S_IWUSR | S_IRUGO, show_fan_min, set_fan_min, 1),
-	SENSOR_ATTR(fan3_min, S_IWUSR | S_IRUGO, show_fan_min, set_fan_min, 2),
+static struct sensor_device_attribute_2 fan_input[] = {
+	SENSOR_ATTR_2(fan1_input, S_IRUGO, show_fan_input, NULL, FN_FAN_INPUT, 0),
+	SENSOR_ATTR_2(fan2_input, S_IRUGO, show_fan_input, NULL, FN_FAN_INPUT, 1),
+	SENSOR_ATTR_2(fan3_input, S_IRUGO, show_fan_input, NULL, FN_FAN_INPUT, 2),
+};
+static struct sensor_device_attribute_2 fan_status[] = {
+	SENSOR_ATTR_2(fan1_status, S_IRUGO, show_fan_status, NULL, FN_FAN_STATUS, 0),
+	SENSOR_ATTR_2(fan2_status, S_IRUGO, show_fan_status, NULL, FN_FAN_STATUS, 1),
+	SENSOR_ATTR_2(fan3_status, S_IRUGO, show_fan_status, NULL, FN_FAN_STATUS, 2),
+		      
+};
+static struct sensor_device_attribute_2 fan_div[] = {
+	SENSOR_ATTR_2(fan1_div, S_IRUGO,
+		      show_fan_div, NULL, FN_FAN_DIV, 0),
+	SENSOR_ATTR_2(fan2_div, S_IRUGO,
+		      show_fan_div, NULL, FN_FAN_DIV, 1),
+	SENSOR_ATTR_2(fan3_div, S_IRUGO,
+		      show_fan_div, NULL, FN_FAN_DIV, 2),
+};
+static struct sensor_device_attribute_2 fan_min[] = {
+	SENSOR_ATTR_2(fan1_min, S_IWUSR | S_IRUGO,
+		      show_fan_min, set_fan_min, FN_FAN_MIN, 0),
+	SENSOR_ATTR_2(fan2_min, S_IWUSR | S_IRUGO,
+		      show_fan_min, set_fan_min, FN_FAN_MIN, 1),
+	SENSOR_ATTR_2(fan3_min, S_IWUSR | S_IRUGO,
+		      show_fan_min, set_fan_min, FN_FAN_MIN, 2),
 };
 
 #define FAN_UNIT_ATTRS(X)	\
@@ -333,9 +349,11 @@ static struct sensor_device_attribute fa
 	&fan_div[X].dev_attr.attr,	\
 	&fan_min[X].dev_attr.attr
 
+#define FN_PWM		4
+
 static ssize_t show_pwm(struct device *dev, struct device_attribute *devattr, char *buf)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
 	struct pc87360_data *data = pc87360_update_device(dev);
 	return sprintf(buf, "%u\n",
 		       PWM_FROM_REG(data->pwm[attr->index],
@@ -359,7 +377,7 @@ static ssize_t set_pwm(struct device *de
 	return count;
 }
 
-static struct sensor_device_attribute pwm[] = {
+static struct sensor_device_attribute_2 pwm[] = {
 	SENSOR_ATTR(pwm1, S_IWUSR | S_IRUGO, show_pwm, set_pwm, 0),
 	SENSOR_ATTR(pwm2, S_IWUSR | S_IRUGO, show_pwm, set_pwm, 1),
 	SENSOR_ATTR(pwm3, S_IWUSR | S_IRUGO, show_pwm, set_pwm, 2),
@@ -378,37 +396,42 @@ static const struct attribute_group pc87
 	.attrs = pc8736x_fan_attr_array,
 };
 
+#define FN_IN_INPUT	5
+#define FN_IN_MIN	6
+#define FN_IN_MAX	7
+#define FN_IN_STATUS	8
+
 static ssize_t show_in_input(struct device *dev, struct device_attribute *devattr, char *buf)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
 	struct pc87360_data *data = pc87360_update_device(dev);
 	return sprintf(buf, "%u\n", IN_FROM_REG(data->in[attr->index],
 		       data->in_vref));
 }
 static ssize_t show_in_min(struct device *dev, struct device_attribute *devattr, char *buf)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
 	struct pc87360_data *data = pc87360_update_device(dev);
 	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_min[attr->index],
 		       data->in_vref));
 }
 static ssize_t show_in_max(struct device *dev, struct device_attribute *devattr, char *buf)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
 	struct pc87360_data *data = pc87360_update_device(dev);
 	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_max[attr->index],
 		       data->in_vref));
 }
 static ssize_t show_in_status(struct device *dev, struct device_attribute *devattr, char *buf)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
 	struct pc87360_data *data = pc87360_update_device(dev);
 	return sprintf(buf, "%u\n", data->in_status[attr->index]);
 }
 static ssize_t set_in_min(struct device *dev, struct device_attribute *devattr, const char *buf,
 	size_t count)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
 	struct i2c_client *client = to_i2c_client(dev);
 	struct pc87360_data *data = i2c_get_clientdata(client);
 	long val = simple_strtol(buf, NULL, 10);
@@ -423,7 +446,7 @@ static ssize_t set_in_min(struct device 
 static ssize_t set_in_max(struct device *dev, struct device_attribute *devattr, const char *buf,
 	size_t count)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
 	struct i2c_client *client = to_i2c_client(dev);
 	struct pc87360_data *data = i2c_get_clientdata(client);
 	long val = simple_strtol(buf, NULL, 10);
@@ -437,57 +460,57 @@ static ssize_t set_in_max(struct device 
 	return count;
 }
 
-static struct sensor_device_attribute in_input[] = {
-	SENSOR_ATTR(in0_input, S_IRUGO, show_in_input, NULL, 0),
-	SENSOR_ATTR(in1_input, S_IRUGO, show_in_input, NULL, 1),
-	SENSOR_ATTR(in2_input, S_IRUGO, show_in_input, NULL, 2),
-	SENSOR_ATTR(in3_input, S_IRUGO, show_in_input, NULL, 3),
-	SENSOR_ATTR(in4_input, S_IRUGO, show_in_input, NULL, 4),
-	SENSOR_ATTR(in5_input, S_IRUGO, show_in_input, NULL, 5),
-	SENSOR_ATTR(in6_input, S_IRUGO, show_in_input, NULL, 6),
-	SENSOR_ATTR(in7_input, S_IRUGO, show_in_input, NULL, 7),
-	SENSOR_ATTR(in8_input, S_IRUGO, show_in_input, NULL, 8),
-	SENSOR_ATTR(in9_input, S_IRUGO, show_in_input, NULL, 9),
-	SENSOR_ATTR(in10_input, S_IRUGO, show_in_input, NULL, 10),
-};
-static struct sensor_device_attribute in_status[] = {
-	SENSOR_ATTR(in0_status, S_IRUGO, show_in_status, NULL, 0),
-	SENSOR_ATTR(in1_status, S_IRUGO, show_in_status, NULL, 1),
-	SENSOR_ATTR(in2_status, S_IRUGO, show_in_status, NULL, 2),
-	SENSOR_ATTR(in3_status, S_IRUGO, show_in_status, NULL, 3),
-	SENSOR_ATTR(in4_status, S_IRUGO, show_in_status, NULL, 4),
-	SENSOR_ATTR(in5_status, S_IRUGO, show_in_status, NULL, 5),
-	SENSOR_ATTR(in6_status, S_IRUGO, show_in_status, NULL, 6),
-	SENSOR_ATTR(in7_status, S_IRUGO, show_in_status, NULL, 7),
-	SENSOR_ATTR(in8_status, S_IRUGO, show_in_status, NULL, 8),
-	SENSOR_ATTR(in9_status, S_IRUGO, show_in_status, NULL, 9),
-	SENSOR_ATTR(in10_status, S_IRUGO, show_in_status, NULL, 10),
-};
-static struct sensor_device_attribute in_min[] = {
-	SENSOR_ATTR(in0_min, S_IWUSR | S_IRUGO, show_in_min, set_in_min, 0),
-	SENSOR_ATTR(in1_min, S_IWUSR | S_IRUGO, show_in_min, set_in_min, 1),
-	SENSOR_ATTR(in2_min, S_IWUSR | S_IRUGO, show_in_min, set_in_min, 2),
-	SENSOR_ATTR(in3_min, S_IWUSR | S_IRUGO, show_in_min, set_in_min, 3),
-	SENSOR_ATTR(in4_min, S_IWUSR | S_IRUGO, show_in_min, set_in_min, 4),
-	SENSOR_ATTR(in5_min, S_IWUSR | S_IRUGO, show_in_min, set_in_min, 5),
-	SENSOR_ATTR(in6_min, S_IWUSR | S_IRUGO, show_in_min, set_in_min, 6),
-	SENSOR_ATTR(in7_min, S_IWUSR | S_IRUGO, show_in_min, set_in_min, 7),
-	SENSOR_ATTR(in8_min, S_IWUSR | S_IRUGO, show_in_min, set_in_min, 8),
-	SENSOR_ATTR(in9_min, S_IWUSR | S_IRUGO, show_in_min, set_in_min, 9),
-	SENSOR_ATTR(in10_min, S_IWUSR | S_IRUGO, show_in_min, set_in_min, 10),
-};
-static struct sensor_device_attribute in_max[] = {
-	SENSOR_ATTR(in0_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, 0),
-	SENSOR_ATTR(in1_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, 1),
-	SENSOR_ATTR(in2_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, 2),
-	SENSOR_ATTR(in3_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, 3),
-	SENSOR_ATTR(in4_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, 4),
-	SENSOR_ATTR(in5_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, 5),
-	SENSOR_ATTR(in6_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, 6),
-	SENSOR_ATTR(in7_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, 7),
-	SENSOR_ATTR(in8_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, 8),
-	SENSOR_ATTR(in9_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, 9),
-	SENSOR_ATTR(in10_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, 10),
+static struct sensor_device_attribute_2 in_input[] = {
+	SENSOR_ATTR_2(in0_input, S_IRUGO, show_in_input, NULL, FN_IN_INPUT, 0),
+	SENSOR_ATTR_2(in1_input, S_IRUGO, show_in_input, NULL, FN_IN_INPUT, 1),
+	SENSOR_ATTR_2(in2_input, S_IRUGO, show_in_input, NULL, FN_IN_INPUT, 2),
+	SENSOR_ATTR_2(in3_input, S_IRUGO, show_in_input, NULL, FN_IN_INPUT, 3),
+	SENSOR_ATTR_2(in4_input, S_IRUGO, show_in_input, NULL, FN_IN_INPUT, 4),
+	SENSOR_ATTR_2(in5_input, S_IRUGO, show_in_input, NULL, FN_IN_INPUT, 5),
+	SENSOR_ATTR_2(in6_input, S_IRUGO, show_in_input, NULL, FN_IN_INPUT, 6),
+	SENSOR_ATTR_2(in7_input, S_IRUGO, show_in_input, NULL, FN_IN_INPUT, 7),
+	SENSOR_ATTR_2(in8_input, S_IRUGO, show_in_input, NULL, FN_IN_INPUT, 8),
+	SENSOR_ATTR_2(in9_input, S_IRUGO, show_in_input, NULL, FN_IN_INPUT, 9),
+	SENSOR_ATTR_2(in10_input, S_IRUGO, show_in_input, NULL, FN_IN_INPUT, 10),
+};
+static struct sensor_device_attribute_2 in_status[] = {
+	SENSOR_ATTR_2(in0_status, S_IRUGO, show_in_status, NULL, FN_IN_STATUS, 0),
+	SENSOR_ATTR_2(in1_status, S_IRUGO, show_in_status, NULL, FN_IN_STATUS, 1),
+	SENSOR_ATTR_2(in2_status, S_IRUGO, show_in_status, NULL, FN_IN_STATUS, 2),
+	SENSOR_ATTR_2(in3_status, S_IRUGO, show_in_status, NULL, FN_IN_STATUS, 3),
+	SENSOR_ATTR_2(in4_status, S_IRUGO, show_in_status, NULL, FN_IN_STATUS, 4),
+	SENSOR_ATTR_2(in5_status, S_IRUGO, show_in_status, NULL, FN_IN_STATUS, 5),
+	SENSOR_ATTR_2(in6_status, S_IRUGO, show_in_status, NULL, FN_IN_STATUS, 6),
+	SENSOR_ATTR_2(in7_status, S_IRUGO, show_in_status, NULL, FN_IN_STATUS, 7),
+	SENSOR_ATTR_2(in8_status, S_IRUGO, show_in_status, NULL, FN_IN_STATUS, 8),
+	SENSOR_ATTR_2(in9_status, S_IRUGO, show_in_status, NULL, FN_IN_STATUS, 9),
+	SENSOR_ATTR_2(in10_status, S_IRUGO, show_in_status, NULL, FN_IN_STATUS, 10),
+};
+static struct sensor_device_attribute_2 in_min[] = {
+	SENSOR_ATTR_2(in0_min, S_IWUSR | S_IRUGO, show_in_min, set_in_min, FN_IN_MIN, 0),
+	SENSOR_ATTR_2(in1_min, S_IWUSR | S_IRUGO, show_in_min, set_in_min, FN_IN_MIN, 1),
+	SENSOR_ATTR_2(in2_min, S_IWUSR | S_IRUGO, show_in_min, set_in_min, FN_IN_MIN, 2),
+	SENSOR_ATTR_2(in3_min, S_IWUSR | S_IRUGO, show_in_min, set_in_min, FN_IN_MIN, 3),
+	SENSOR_ATTR_2(in4_min, S_IWUSR | S_IRUGO, show_in_min, set_in_min, FN_IN_MIN, 4),
+	SENSOR_ATTR_2(in5_min, S_IWUSR | S_IRUGO, show_in_min, set_in_min, FN_IN_MIN, 5),
+	SENSOR_ATTR_2(in6_min, S_IWUSR | S_IRUGO, show_in_min, set_in_min, FN_IN_MIN, 6),
+	SENSOR_ATTR_2(in7_min, S_IWUSR | S_IRUGO, show_in_min, set_in_min, FN_IN_MIN, 7),
+	SENSOR_ATTR_2(in8_min, S_IWUSR | S_IRUGO, show_in_min, set_in_min, FN_IN_MIN, 8),
+	SENSOR_ATTR_2(in9_min, S_IWUSR | S_IRUGO, show_in_min, set_in_min, FN_IN_MIN, 9),
+	SENSOR_ATTR_2(in10_min, S_IWUSR | S_IRUGO, show_in_min, set_in_min, FN_IN_MIN, 10),
+};
+static struct sensor_device_attribute_2 in_max[] = {
+	SENSOR_ATTR_2(in0_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, FN_IN_MAX, 0),
+	SENSOR_ATTR_2(in1_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, FN_IN_MAX, 1),
+	SENSOR_ATTR_2(in2_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, FN_IN_MAX, 2),
+	SENSOR_ATTR_2(in3_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, FN_IN_MAX, 3),
+	SENSOR_ATTR_2(in4_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, FN_IN_MAX, 4),
+	SENSOR_ATTR_2(in5_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, FN_IN_MAX, 5),
+	SENSOR_ATTR_2(in6_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, FN_IN_MAX, 6),
+	SENSOR_ATTR_2(in7_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, FN_IN_MAX, 7),
+	SENSOR_ATTR_2(in8_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, FN_IN_MAX, 8),
+	SENSOR_ATTR_2(in9_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, FN_IN_MAX, 9),
+	SENSOR_ATTR_2(in10_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, FN_IN_MAX, 10),
 };
 
 #define VIN_UNIT_ATTRS(X) \
@@ -545,44 +568,50 @@ static const struct attribute_group pc87
 	.attrs = pc8736x_vin_attr_array,
 };
 
+#define FN_THERM_INPUT	9
+#define FN_THERM_MIN	10
+#define FN_THERM_MAX	11
+#define FN_THERM_STATUS	12
+#define FN_THERM_CRIT	13
+
 static ssize_t show_therm_input(struct device *dev, struct device_attribute *devattr, char *buf)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
 	struct pc87360_data *data = pc87360_update_device(dev);
 	return sprintf(buf, "%u\n", IN_FROM_REG(data->in[attr->index],
 		       data->in_vref));
 }
 static ssize_t show_therm_min(struct device *dev, struct device_attribute *devattr, char *buf)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
 	struct pc87360_data *data = pc87360_update_device(dev);
 	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_min[attr->index],
 		       data->in_vref));
 }
 static ssize_t show_therm_max(struct device *dev, struct device_attribute *devattr, char *buf)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
 	struct pc87360_data *data = pc87360_update_device(dev);
 	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_max[attr->index],
 		       data->in_vref));
 }
 static ssize_t show_therm_crit(struct device *dev, struct device_attribute *devattr, char *buf)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
 	struct pc87360_data *data = pc87360_update_device(dev);
 	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_crit[attr->index-11],
 		       data->in_vref));
 }
 static ssize_t show_therm_status(struct device *dev, struct device_attribute *devattr, char *buf)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
 	struct pc87360_data *data = pc87360_update_device(dev);
 	return sprintf(buf, "%u\n", data->in_status[attr->index]);
 }
 static ssize_t set_therm_min(struct device *dev, struct device_attribute *devattr, const char *buf,
 	size_t count)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
 	struct i2c_client *client = to_i2c_client(dev);
 	struct pc87360_data *data = i2c_get_clientdata(client);
 	long val = simple_strtol(buf, NULL, 10);
@@ -597,7 +626,7 @@ static ssize_t set_therm_min(struct devi
 static ssize_t set_therm_max(struct device *dev, struct device_attribute *devattr, const char *buf,
 	size_t count)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
 	struct i2c_client *client = to_i2c_client(dev);
 	struct pc87360_data *data = i2c_get_clientdata(client);
 	long val = simple_strtol(buf, NULL, 10);
@@ -612,7 +641,7 @@ static ssize_t set_therm_max(struct devi
 static ssize_t set_therm_crit(struct device *dev, struct device_attribute *devattr, const char *buf,
 	size_t count)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
 	struct i2c_client *client = to_i2c_client(dev);
 	struct pc87360_data *data = i2c_get_clientdata(client);
 	long val = simple_strtol(buf, NULL, 10);
@@ -628,39 +657,41 @@ static ssize_t set_therm_crit(struct dev
 /* the +11 term below reflects the fact that VLM units 11,12,13 are
    used in the chip to measure voltage across the thermistors
 */
-static struct sensor_device_attribute therm_input[] = {
-	SENSOR_ATTR(temp4_input, S_IRUGO, show_therm_input, NULL, 0+11),
-	SENSOR_ATTR(temp5_input, S_IRUGO, show_therm_input, NULL, 1+11),
-	SENSOR_ATTR(temp6_input, S_IRUGO, show_therm_input, NULL, 2+11),
-};
-static struct sensor_device_attribute therm_status[] = {
-	SENSOR_ATTR(temp4_status, S_IRUGO, show_therm_status, NULL, 0+11),
-	SENSOR_ATTR(temp5_status, S_IRUGO, show_therm_status, NULL, 1+11),
-	SENSOR_ATTR(temp6_status, S_IRUGO, show_therm_status, NULL, 2+11),
-};
-static struct sensor_device_attribute therm_min[] = {
-	SENSOR_ATTR(temp4_min, S_IRUGO | S_IWUSR,
-		    show_therm_min, set_therm_min, 0+11),
-	SENSOR_ATTR(temp5_min, S_IRUGO | S_IWUSR,
-		    show_therm_min, set_therm_min, 1+11),
-	SENSOR_ATTR(temp6_min, S_IRUGO | S_IWUSR,
-		    show_therm_min, set_therm_min, 2+11),
-};
-static struct sensor_device_attribute therm_max[] = {
-	SENSOR_ATTR(temp4_max, S_IRUGO | S_IWUSR,
-		    show_therm_max, set_therm_max, 0+11),
-	SENSOR_ATTR(temp5_max, S_IRUGO | S_IWUSR,
-		    show_therm_max, set_therm_max, 1+11),
-	SENSOR_ATTR(temp6_max, S_IRUGO | S_IWUSR,
-		    show_therm_max, set_therm_max, 2+11),
-};
-static struct sensor_device_attribute therm_crit[] = {
-	SENSOR_ATTR(temp4_crit, S_IRUGO | S_IWUSR,
-		    show_therm_crit, set_therm_crit, 0+11),
-	SENSOR_ATTR(temp5_crit, S_IRUGO | S_IWUSR,
-		    show_therm_crit, set_therm_crit, 1+11),
-	SENSOR_ATTR(temp6_crit, S_IRUGO | S_IWUSR,
-		    show_therm_crit, set_therm_crit, 2+11),
+
+static struct sensor_device_attribute_2 therm_input[] = {
+	SENSOR_ATTR_2(temp4_input, S_IRUGO, show_therm_input, NULL, FN_THERM_INPUT, 0+11),
+	SENSOR_ATTR_2(temp5_input, S_IRUGO, show_therm_input, NULL, FN_THERM_INPUT, 1+11),
+	SENSOR_ATTR_2(temp6_input, S_IRUGO, show_therm_input, NULL, FN_THERM_INPUT, 2+11),
+};
+
+static struct sensor_device_attribute_2 therm_status[] = {
+	SENSOR_ATTR_2(temp4_status, S_IRUGO, show_therm_status, NULL, FN_THERM_STATUS, 0+11),
+	SENSOR_ATTR_2(temp5_status, S_IRUGO, show_therm_status, NULL, FN_THERM_STATUS, 1+11),
+	SENSOR_ATTR_2(temp6_status, S_IRUGO, show_therm_status, NULL, FN_THERM_STATUS, 2+11),
+};
+static struct sensor_device_attribute_2 therm_min[] = {
+	SENSOR_ATTR_2(temp4_min, S_IRUGO | S_IWUSR,
+		      show_therm_min, set_therm_min, FN_THERM_MIN, 0+11),
+	SENSOR_ATTR_2(temp5_min, S_IRUGO | S_IWUSR,
+		      show_therm_min, set_therm_min, FN_THERM_MIN, 1+11),
+	SENSOR_ATTR_2(temp6_min, S_IRUGO | S_IWUSR,
+		      show_therm_min, set_therm_min, FN_THERM_MIN, 2+11),
+};
+static struct sensor_device_attribute_2 therm_max[] = {
+	SENSOR_ATTR_2(temp4_max, S_IRUGO | S_IWUSR,
+		      show_therm_max, set_therm_max, FN_THERM_MAX, 0+11),
+	SENSOR_ATTR_2(temp5_max, S_IRUGO | S_IWUSR,
+		      show_therm_max, set_therm_max, FN_THERM_MAX, 1+11),
+	SENSOR_ATTR_2(temp6_max, S_IRUGO | S_IWUSR,
+		      show_therm_max, set_therm_max, FN_THERM_MAX, 2+11),
+};
+static struct sensor_device_attribute_2 therm_crit[] = {
+	SENSOR_ATTR_2(temp4_crit, S_IRUGO | S_IWUSR,
+		      show_therm_crit, set_therm_crit, FN_THERM_CRIT, 0+11),
+	SENSOR_ATTR_2(temp5_crit, S_IRUGO | S_IWUSR,
+		      show_therm_crit, set_therm_crit, FN_THERM_CRIT, 1+11),
+	SENSOR_ATTR_2(temp6_crit, S_IRUGO | S_IWUSR,
+		      show_therm_crit, set_therm_crit, FN_THERM_CRIT, 2+11),
 };
 
 #define THERM_UNIT_ATTRS(X) \
@@ -680,115 +711,135 @@ static const struct attribute_group pc87
 	.attrs = pc8736x_therm_attr_array,
 };
 
+#define FN_TEMP_INPUT	14
+#define FN_TEMP_MIN	15
+#define FN_TEMP_MAX	16
+#define FN_TEMP_STATUS	17
+#define FN_TEMP_CRIT	18
+
 static ssize_t show_temp_input(struct device *dev, struct device_attribute *devattr, char *buf)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
+	int idx = attr->index;
 	struct pc87360_data *data = pc87360_update_device(dev);
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[attr->index]));
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[idx]));
 }
 static ssize_t show_temp_min(struct device *dev, struct device_attribute *devattr, char *buf)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
+	int idx = attr->index;
 	struct pc87360_data *data = pc87360_update_device(dev);
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_min[attr->index]));
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_min[idx]));
 }
 static ssize_t show_temp_max(struct device *dev, struct device_attribute *devattr, char *buf)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
+	int idx = attr->index;
 	struct pc87360_data *data = pc87360_update_device(dev);
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_max[attr->index]));
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_max[idx]));
 }
 static ssize_t show_temp_crit(struct device *dev, struct device_attribute *devattr, char *buf)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
+	int idx = attr->index;
 	struct pc87360_data *data = pc87360_update_device(dev);
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_crit[attr->index]));
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_crit[idx]));
 }
 static ssize_t show_temp_status(struct device *dev, struct device_attribute *devattr, char *buf)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
+	int idx = attr->index;
 	struct pc87360_data *data = pc87360_update_device(dev);
-	return sprintf(buf, "%d\n", data->temp_status[attr->index]);
+	return sprintf(buf, "%d\n", data->temp_status[idx]);
 }
 static ssize_t set_temp_min(struct device *dev, struct device_attribute *devattr, const char *buf,
 	size_t count)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
+	int idx = attr->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct pc87360_data *data = i2c_get_clientdata(client);
 	long val = simple_strtol(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
-	data->temp_min[attr->index] = TEMP_TO_REG(val);
-	pc87360_write_value(data, LD_TEMP, attr->index, PC87365_REG_TEMP_MIN,
-			    data->temp_min[attr->index]);
+	data->temp_min[idx] = TEMP_TO_REG(val);
+	pc87360_write_value(data, LD_TEMP, idx, PC87365_REG_TEMP_MIN,
+			    data->temp_min[idx]);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
 static ssize_t set_temp_max(struct device *dev, struct device_attribute *devattr, const char *buf,
 	size_t count)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
+	int idx = attr->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct pc87360_data *data = i2c_get_clientdata(client);
 	long val = simple_strtol(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
-	data->temp_max[attr->index] = TEMP_TO_REG(val);
-	pc87360_write_value(data, LD_TEMP, attr->index, PC87365_REG_TEMP_MAX,
-			    data->temp_max[attr->index]);
+	data->temp_max[idx] = TEMP_TO_REG(val);
+	pc87360_write_value(data, LD_TEMP, idx, PC87365_REG_TEMP_MAX,
+			    data->temp_max[idx]);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
 static ssize_t set_temp_crit(struct device *dev, struct device_attribute *devattr, const char *buf,
 	size_t count)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
+	int idx = attr->index;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct pc87360_data *data = i2c_get_clientdata(client);
 	long val = simple_strtol(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
-	data->temp_crit[attr->index] = TEMP_TO_REG(val);
-	pc87360_write_value(data, LD_TEMP, attr->index, PC87365_REG_TEMP_CRIT,
-			    data->temp_crit[attr->index]);
+	data->temp_crit[idx] = TEMP_TO_REG(val);
+	pc87360_write_value(data, LD_TEMP, idx, PC87365_REG_TEMP_CRIT,
+			    data->temp_crit[idx]);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
 
-static struct sensor_device_attribute temp_input[] = {
-	SENSOR_ATTR(temp1_input, S_IRUGO, show_temp_input, NULL, 0),
-	SENSOR_ATTR(temp2_input, S_IRUGO, show_temp_input, NULL, 1),
-	SENSOR_ATTR(temp3_input, S_IRUGO, show_temp_input, NULL, 2),
-};
-static struct sensor_device_attribute temp_status[] = {
-	SENSOR_ATTR(temp1_status, S_IRUGO, show_temp_status, NULL, 0),
-	SENSOR_ATTR(temp2_status, S_IRUGO, show_temp_status, NULL, 1),
-	SENSOR_ATTR(temp3_status, S_IRUGO, show_temp_status, NULL, 2),
-};
-static struct sensor_device_attribute temp_min[] = {
-	SENSOR_ATTR(temp1_min, S_IRUGO | S_IWUSR,
-		    show_temp_min, set_temp_min, 0),
-	SENSOR_ATTR(temp2_min, S_IRUGO | S_IWUSR,
-		    show_temp_min, set_temp_min, 1),
-	SENSOR_ATTR(temp3_min, S_IRUGO | S_IWUSR,
-		    show_temp_min, set_temp_min, 2),
-};
-static struct sensor_device_attribute temp_max[] = {
-	SENSOR_ATTR(temp1_max, S_IRUGO | S_IWUSR,
-		    show_temp_max, set_temp_max, 0),
-	SENSOR_ATTR(temp2_max, S_IRUGO | S_IWUSR,
-		    show_temp_max, set_temp_max, 1),
-	SENSOR_ATTR(temp3_max, S_IRUGO | S_IWUSR,
-		    show_temp_max, set_temp_max, 2),
-};
-static struct sensor_device_attribute temp_crit[] = {
-	SENSOR_ATTR(temp1_crit, S_IRUGO | S_IWUSR,
-		    show_temp_crit, set_temp_crit, 0),
-	SENSOR_ATTR(temp2_crit, S_IRUGO | S_IWUSR,
-		    show_temp_crit, set_temp_crit, 1),
-	SENSOR_ATTR(temp3_crit, S_IRUGO | S_IWUSR,
-		    show_temp_crit, set_temp_crit, 2),
+static struct sensor_device_attribute_2 temp_input[] = {
+	SENSOR_ATTR_2(temp1_input, S_IRUGO,
+		      show_temp_input, NULL, FN_TEMP_INPUT, 0),
+	SENSOR_ATTR_2(temp2_input, S_IRUGO,
+		      show_temp_input, NULL, FN_TEMP_INPUT, 1),
+	SENSOR_ATTR_2(temp3_input, S_IRUGO,
+		      show_temp_input, NULL, FN_TEMP_INPUT, 2),
+};
+static struct sensor_device_attribute_2 temp_status[] = {
+	SENSOR_ATTR_2(temp1_status, S_IRUGO,
+		      show_temp_status, NULL, FN_TEMP_STATUS, 0),
+	SENSOR_ATTR_2(temp2_status, S_IRUGO,
+		      show_temp_status, NULL, FN_TEMP_STATUS, 1),
+	SENSOR_ATTR_2(temp3_status, S_IRUGO,
+		      show_temp_status, NULL, FN_TEMP_STATUS, 2),
+};
+static struct sensor_device_attribute_2 temp_min[] = {
+	SENSOR_ATTR_2(temp1_min, S_IRUGO | S_IWUSR,
+		    show_temp_min, set_temp_min, FN_TEMP_MIN, 0),
+	SENSOR_ATTR_2(temp2_min, S_IRUGO | S_IWUSR,
+		    show_temp_min, set_temp_min, FN_TEMP_MIN, 1),
+	SENSOR_ATTR_2(temp3_min, S_IRUGO | S_IWUSR,
+		    show_temp_min, set_temp_min, FN_TEMP_MIN, 2),
+};
+static struct sensor_device_attribute_2 temp_max[] = {
+	SENSOR_ATTR_2(temp1_max, S_IRUGO | S_IWUSR,
+		    show_temp_max, set_temp_max, FN_TEMP_MAX, 0),
+	SENSOR_ATTR_2(temp2_max, S_IRUGO | S_IWUSR,
+		    show_temp_max, set_temp_max, FN_TEMP_MAX, 1),
+	SENSOR_ATTR_2(temp3_max, S_IRUGO | S_IWUSR,
+		    show_temp_max, set_temp_max, FN_TEMP_MAX, 2),
+};
+static struct sensor_device_attribute_2 temp_crit[] = {
+	SENSOR_ATTR_2(temp1_crit, S_IRUGO | S_IWUSR,
+		    show_temp_crit, set_temp_crit, FN_TEMP_CRIT, 0),
+	SENSOR_ATTR_2(temp2_crit, S_IRUGO | S_IWUSR,
+		    show_temp_crit, set_temp_crit, FN_TEMP_CRIT, 1),
+	SENSOR_ATTR_2(temp3_crit, S_IRUGO | S_IWUSR,
+		    show_temp_crit, set_temp_crit, FN_TEMP_CRIT, 2),
 };
 
 static ssize_t show_temp_alarms(struct device *dev, struct device_attribute *attr, char *buf)



