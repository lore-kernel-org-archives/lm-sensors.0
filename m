From: jcromie@divsol.com (Jim Cromie)
Date: Mon, 01 Aug 2005 23:38:28 +0000
Subject: [lm-sensors] [patchset 10/23] pc87360 thermistor dev-attr -->
Message-Id: <42EE95AB.1030001@divsol.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


upgrade thermistor device_attributes to sensor-device-attributes, 
following Yani's form
 a. change declarations: DEVICE_ATTR -> SENSOR_DEVICE_ATTR
 b. compute sensor_dev_attr from dev_attr, with to_sensor_dev_attr(devattr)
 c. change calls to device_create_file() to match.

[jimc@harpo pset]$ diffstat 06-sda-therm
 pc87360.c |   74 
++++++++++++++++++++++++++++++++++----------------------------
 1 files changed, 41 insertions(+), 33 deletions(-)

Signed-off-by:  Jim Cromie <jcromie@divsol.com>


-------------- next part --------------
diff -ruNp -X exclude-diffs lxC-9/drivers/hwmon/pc87360.c lxC-10/drivers/hwmon/pc87360.c
--- lxC-9/drivers/hwmon/pc87360.c	2005-07-31 12:13:26.000000000 -0600
+++ lxC-10/drivers/hwmon/pc87360.c	2005-07-31 12:14:05.000000000 -0600
@@ -434,38 +434,44 @@ show_and_set_in(9)
 show_and_set_in(10)
 
 #define show_and_set_therm(offset) \
-static ssize_t show_temp##offset##_input(struct device *dev, struct device_attribute *attr, char *buf) \
+static ssize_t show_temp##offset##_input(struct device *dev, struct device_attribute *devattr, char *buf) \
 { \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%u\n", IN_FROM_REG(data->in[offset+7], \
 		       data->in_vref)); \
 } \
-static ssize_t show_temp##offset##_min(struct device *dev, struct device_attribute *attr, char *buf) \
+static ssize_t show_temp##offset##_min(struct device *dev, struct device_attribute *devattr, char *buf) \
 { \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_min[offset+7], \
 		       data->in_vref)); \
 } \
-static ssize_t show_temp##offset##_max(struct device *dev, struct device_attribute *attr, char *buf) \
+static ssize_t show_temp##offset##_max(struct device *dev, struct device_attribute *devattr, char *buf) \
 { \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_max[offset+7], \
 		       data->in_vref)); \
 } \
-static ssize_t show_temp##offset##_crit(struct device *dev, struct device_attribute *attr, char *buf) \
+static ssize_t show_temp##offset##_crit(struct device *dev, struct device_attribute *devattr, char *buf) \
 { \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_crit[offset-4], \
 		       data->in_vref)); \
 } \
-static ssize_t show_temp##offset##_status(struct device *dev, struct device_attribute *attr, char *buf) \
+static ssize_t show_temp##offset##_status(struct device *dev, struct device_attribute *devattr, char *buf) \
 { \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%u\n", data->in_status[offset+7]); \
 } \
-static ssize_t set_temp##offset##_min(struct device *dev, struct device_attribute *attr, const char *buf, \
+static ssize_t set_temp##offset##_min(struct device *dev, struct device_attribute *devattr, const char *buf, \
 	size_t count) \
 { \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct pc87360_data *data = i2c_get_clientdata(client); \
 	long val = simple_strtol(buf, NULL, 10); \
@@ -477,9 +483,10 @@ static ssize_t set_temp##offset##_min(st
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
@@ -491,9 +498,10 @@ static ssize_t set_temp##offset##_max(st
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
@@ -505,16 +513,16 @@ static ssize_t set_temp##offset##_crit(s
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
@@ -923,21 +931,21 @@ static int pc87360_detect(struct i2c_ada
 		device_create_file(&new_client->dev, &sensor_dev_attr_temp3_status.dev_attr);
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
