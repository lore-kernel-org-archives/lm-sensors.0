From: jcromie@divsol.com (Jim Cromie)
Date: Mon, 01 Aug 2005 23:10:23 +0000
Subject: [lm-sensors] [patchset 8/23] pc87360 temp dev-attrs -->
Message-Id: <42EE8ED6.3000309@divsol.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


upgrade temperature  device_attributes to sensor-device-attributes, 
following Yani's form
a. change declarations: DEVICE_ATTR -> SENSOR_DEVICE_ATTR
b. compute sensor_dev_attr from dev_attr, with to_sensor_dev_attr(devattr)
c. change calls to device_create_file() to match.

[jimc@harpo pset]$ diffstat 05-sda-temp
 pc87360.c |   74 
++++++++++++++++++++++++++++++++++----------------------------
 1 files changed, 41 insertions(+), 33 deletions(-)


Signed-off-by:  Jim Cromie <jcromie@divsol.com>


-------------- next part --------------
diff -ruNp -X exclude-diffs lxC-7/drivers/hwmon/pc87360.c lxC-8/drivers/hwmon/pc87360.c
--- lxC-7/drivers/hwmon/pc87360.c	2005-07-31 12:11:59.000000000 -0600
+++ lxC-8/drivers/hwmon/pc87360.c	2005-07-31 12:12:43.000000000 -0600
@@ -548,34 +548,40 @@ static ssize_t show_in_alarms(struct dev
 static DEVICE_ATTR(alarms_in, S_IRUGO, show_in_alarms, NULL);
 
 #define show_and_set_temp(offset) \
-static ssize_t show_temp##offset##_input(struct device *dev, struct device_attribute *attr, char *buf) \
+static ssize_t show_temp##offset##_input(struct device *dev, struct device_attribute *devattr, char *buf) \
 { \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[offset-1])); \
 } \
-static ssize_t show_temp##offset##_min(struct device *dev, struct device_attribute *attr, char *buf) \
+static ssize_t show_temp##offset##_min(struct device *dev, struct device_attribute *devattr, char *buf) \
 { \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_min[offset-1])); \
 } \
-static ssize_t show_temp##offset##_max(struct device *dev, struct device_attribute *attr, char *buf) \
+static ssize_t show_temp##offset##_max(struct device *dev, struct device_attribute *devattr, char *buf) \
 { \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_max[offset-1])); \
 }\
-static ssize_t show_temp##offset##_crit(struct device *dev, struct device_attribute *attr, char *buf) \
+static ssize_t show_temp##offset##_crit(struct device *dev, struct device_attribute *devattr, char *buf) \
 { \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_crit[offset-1])); \
 }\
-static ssize_t show_temp##offset##_status(struct device *dev, struct device_attribute *attr, char *buf) \
+static ssize_t show_temp##offset##_status(struct device *dev, struct device_attribute *devattr, char *buf) \
 { \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct pc87360_data *data = pc87360_update_device(dev); \
 	return sprintf(buf, "%d\n", data->temp_status[offset-1]); \
 }\
-static ssize_t set_temp##offset##_min(struct device *dev, struct device_attribute *attr, const char *buf, \
+static ssize_t set_temp##offset##_min(struct device *dev, struct device_attribute *devattr, const char *buf, \
 	size_t count) \
 { \
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr); \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct pc87360_data *data = i2c_get_clientdata(client); \
 	long val = simple_strtol(buf, NULL, 10); \
@@ -587,9 +593,10 @@ static ssize_t set_temp##offset##_min(st
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
@@ -601,9 +608,10 @@ static ssize_t set_temp##offset##_max(st
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
@@ -615,16 +623,16 @@ static ssize_t set_temp##offset##_crit(s
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
@@ -894,25 +902,25 @@ static int pc87360_detect(struct i2c_ada
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
 		device_create_file(&new_client->dev, &dev_attr_temp4_input);
