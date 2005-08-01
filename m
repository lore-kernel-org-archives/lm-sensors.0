From: jcromie@divsol.com (Jim Cromie)
Date: Mon, 01 Aug 2005 21:43:25 +0000
Subject: [lm-sensors] Re: [patchset 2/23] voltage device attrs -->
Message-Id: <42EE7B26.2050800@divsol.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



upgrade voltage device_attributes to sensor-device-attributes, following 
Yani's form
   a. change declarations: DEVICE_ATTR -> SENSOR_DEVICE_ATTR
   b. compute sensor_dev_attr from dev_attr, with 
to_sensor_dev_attr(devattr)
   c. change calls to device_create_file() to match.

[jimc@harpo pset]$ diffstat 02-sda-vin
 pc87360.c |  122 
++++++++++++++++++++++++++++++++------------------------------
1 files changed, 64 insertions(+), 58 deletions(-)


Signed-off-by:  Jim Cromie <jcromie@divsol.com>

-------------- next part --------------
diff -ruNp -X exclude-diffs lxC-1/drivers/hwmon/pc87360.c lxC-2/drivers/hwmon/pc87360.c
--- lxC-1/drivers/hwmon/pc87360.c	2005-07-31 12:07:32.000000000 -0600
+++ lxC-2/drivers/hwmon/pc87360.c	2005-07-31 12:08:18.000000000 -0600
@@ -348,32 +348,37 @@ show_and_set_pwm(2)
 show_and_set_pwm(3)
 
 #define show_and_set_in(offset) \
-static ssize_t show_in##offset##_input(struct device *dev, struct device_attribute *attr, char *buf) \
+static ssize_t show_in##offset##_input(struct device *dev, struct device_attribute *devattr, char *buf) \
 { \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%u\n", IN_FROM_REG(data->in[offset], \
 		       data->in_vref)); \
 } \
-static ssize_t show_in##offset##_min(struct device *dev, struct device_attribute *attr, char *buf) \
+static ssize_t show_in##offset##_min(struct device *dev, struct device_attribute *devattr, char *buf) \
 { \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_min[offset], \
 		       data->in_vref)); \
 } \
-static ssize_t show_in##offset##_max(struct device *dev, struct device_attribute *attr, char *buf) \
+static ssize_t show_in##offset##_max(struct device *dev, struct device_attribute *devattr, char *buf) \
 { \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_max[offset], \
 		       data->in_vref)); \
 } \
-static ssize_t show_in##offset##_status(struct device *dev, struct device_attribute *attr, char *buf) \
+static ssize_t show_in##offset##_status(struct device *dev, struct device_attribute *devattr, char *buf) \
 { \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%u\n", data->in_status[offset]); \
 } \
-static ssize_t set_in##offset##_min(struct device *dev, struct device_attribute *attr, const char *buf, \
+static ssize_t set_in##offset##_min(struct device *dev, struct device_attribute *devattr, const char *buf, \
 	size_t count) \
 { \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct pc87360_data *data = i2c_get_clientdata(client); \
 	long val = simple_strtol(buf, NULL, 10); \
@@ -385,9 +390,10 @@ static ssize_t set_in##offset##_min(stru
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
@@ -400,14 +406,14 @@ static ssize_t set_in##offset##_max(stru
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
@@ -830,50 +836,50 @@ static int pc87360_detect(struct i2c_ada
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
