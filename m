From: jim.cromie@gmail.com (Jim Cromie)
Date: Mon, 21 Aug 2006 04:39:15 +0000
Subject: [lm-sensors] [patch 3/3 resend] hwmon/pc87360: combine sysfs-attr
Message-Id: <44E938F3.8040604@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

resend to fix whitespace junk

3. hwmon-pc87360-sysfs-combo-callbacks.patch

This combines individual  (show|set)_Sensor_Attr callbacks into
(show|set)_Sensor callbacks that handle all that Sensor's Attrs.
The callback routines use the .nr field to determine what attribute
they were called for.

$> size ac-*/drivers/hwmon/pc87360.o
   text    data     bss     dec     hex filename
  12427    3432      29   15888    3e10 ac-1/drivers/hwmon/pc87360.o
  10960    3432      29   14421    3855 ac-2/drivers/hwmon/pc87360.o


Signed-off-by: Jim Cromie <jim.cromie at gmail.com>

[jimc at harpo hwmon-stuff]$ diffstat hwmon-pc87360-sysfs-combo-callbacks.patch
 pc87360.c |  547 
++++++++++++++++++++++++++++----------------------------------
 1 files changed, 250 insertions(+), 297 deletions(-)

--

diff -ruNp -X dontdiff -X exclude-diffs ac-1/drivers/hwmon/pc87360.c ac-2/drivers/hwmon/pc87360.c
--- ac-1/drivers/hwmon/pc87360.c	2006-08-20 21:51:49.000000000 -0600
+++ ac-2/drivers/hwmon/pc87360.c	2006-08-20 22:22:30.000000000 -0600
@@ -257,34 +257,35 @@ static struct i2c_driver pc87360_driver 
 #define FN_FAN_STATUS	2
 #define FN_FAN_DIV	3
 
-static ssize_t show_fan_input(struct device *dev, struct device_attribute *devattr, char *buf)
-{
-	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
-	struct pc87360_data *data = pc87360_update_device(dev);
-	return sprintf(buf, "%u\n", FAN_FROM_REG(data->fan[attr->index],
-		       FAN_DIV_FROM_REG(data->fan_status[attr->index])));
-}
-static ssize_t show_fan_min(struct device *dev, struct device_attribute *devattr, char *buf)
-{
-	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
-	struct pc87360_data *data = pc87360_update_device(dev);
-	return sprintf(buf, "%u\n", FAN_FROM_REG(data->fan_min[attr->index],
-		       FAN_DIV_FROM_REG(data->fan_status[attr->index])));
-}
-static ssize_t show_fan_div(struct device *dev, struct device_attribute *devattr, char *buf)
-{
-	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
-	struct pc87360_data *data = pc87360_update_device(dev);
-	return sprintf(buf, "%u\n",
-		       FAN_DIV_FROM_REG(data->fan_status[attr->index]));
-}
-static ssize_t show_fan_status(struct device *dev, struct device_attribute *devattr, char *buf)
+static ssize_t show_fan(struct device *dev, struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
+	int idx = attr->index;
+	int func = attr->nr;
 	struct pc87360_data *data = pc87360_update_device(dev);
-	return sprintf(buf, "%u\n",
-		       FAN_STATUS_FROM_REG(data->fan_status[attr->index]));
+	unsigned res = -1;
+	
+	switch(func) {
+	case FN_FAN_INPUT:
+		res = FAN_FROM_REG(data->fan[idx],
+				   FAN_DIV_FROM_REG(data->fan_status[idx]));
+		break;
+	case FN_FAN_MIN:
+		res = FAN_FROM_REG(data->fan_min[idx],
+				   FAN_DIV_FROM_REG(data->fan_status[idx]));
+		break;
+	case FN_FAN_STATUS:
+		res = FAN_STATUS_FROM_REG(data->fan_status[idx]);
+		break;
+	case FN_FAN_DIV:
+		res = FAN_DIV_FROM_REG(data->fan_status[idx]);
+		break;
+	default:
+		printk(KERN_ERR "unknown attr fetch\n");
+	}
+	return sprintf(buf, "%u\n", res);
 }
+
 static ssize_t set_fan_min(struct device *dev, struct device_attribute *devattr, const char *buf,
 	size_t count)
 {
@@ -316,31 +317,27 @@ static ssize_t set_fan_min(struct device
 }
 
 static struct sensor_device_attribute_2 fan_input[] = {
-	SENSOR_ATTR_2(fan1_input, S_IRUGO, show_fan_input, NULL, FN_FAN_INPUT, 0),
-	SENSOR_ATTR_2(fan2_input, S_IRUGO, show_fan_input, NULL, FN_FAN_INPUT, 1),
-	SENSOR_ATTR_2(fan3_input, S_IRUGO, show_fan_input, NULL, FN_FAN_INPUT, 2),
+	SENSOR_ATTR_2(fan1_input, S_IRUGO, show_fan, NULL, FN_FAN_INPUT, 0),
+	SENSOR_ATTR_2(fan2_input, S_IRUGO, show_fan, NULL, FN_FAN_INPUT, 1),
+	SENSOR_ATTR_2(fan3_input, S_IRUGO, show_fan, NULL, FN_FAN_INPUT, 2),
 };
 static struct sensor_device_attribute_2 fan_status[] = {
-	SENSOR_ATTR_2(fan1_status, S_IRUGO, show_fan_status, NULL, FN_FAN_STATUS, 0),
-	SENSOR_ATTR_2(fan2_status, S_IRUGO, show_fan_status, NULL, FN_FAN_STATUS, 1),
-	SENSOR_ATTR_2(fan3_status, S_IRUGO, show_fan_status, NULL, FN_FAN_STATUS, 2),
-		      
+	SENSOR_ATTR_2(fan1_status, S_IRUGO, show_fan, NULL, FN_FAN_STATUS, 0),
+	SENSOR_ATTR_2(fan2_status, S_IRUGO, show_fan, NULL, FN_FAN_STATUS, 1),
+	SENSOR_ATTR_2(fan3_status, S_IRUGO, show_fan, NULL, FN_FAN_STATUS, 2),
 };
 static struct sensor_device_attribute_2 fan_div[] = {
-	SENSOR_ATTR_2(fan1_div, S_IRUGO,
-		      show_fan_div, NULL, FN_FAN_DIV, 0),
-	SENSOR_ATTR_2(fan2_div, S_IRUGO,
-		      show_fan_div, NULL, FN_FAN_DIV, 1),
-	SENSOR_ATTR_2(fan3_div, S_IRUGO,
-		      show_fan_div, NULL, FN_FAN_DIV, 2),
+	SENSOR_ATTR_2(fan1_div, S_IRUGO, show_fan, NULL, FN_FAN_DIV, 0),
+	SENSOR_ATTR_2(fan2_div, S_IRUGO, show_fan, NULL, FN_FAN_DIV, 1),
+	SENSOR_ATTR_2(fan3_div, S_IRUGO, show_fan, NULL, FN_FAN_DIV, 2),
 };
 static struct sensor_device_attribute_2 fan_min[] = {
 	SENSOR_ATTR_2(fan1_min, S_IWUSR | S_IRUGO,
-		      show_fan_min, set_fan_min, FN_FAN_MIN, 0),
+		      show_fan, set_fan_min, FN_FAN_MIN, 0),
 	SENSOR_ATTR_2(fan2_min, S_IWUSR | S_IRUGO,
-		      show_fan_min, set_fan_min, FN_FAN_MIN, 1),
+		      show_fan, set_fan_min, FN_FAN_MIN, 1),
 	SENSOR_ATTR_2(fan3_min, S_IWUSR | S_IRUGO,
-		      show_fan_min, set_fan_min, FN_FAN_MIN, 2),
+		      show_fan, set_fan_min, FN_FAN_MIN, 2),
 };
 
 #define FAN_UNIT_ATTRS(X)	\
@@ -401,116 +398,113 @@ static const struct attribute_group pc87
 #define FN_IN_MAX	7
 #define FN_IN_STATUS	8
 
-static ssize_t show_in_input(struct device *dev, struct device_attribute *devattr, char *buf)
-{
-	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
-	struct pc87360_data *data = pc87360_update_device(dev);
-	return sprintf(buf, "%u\n", IN_FROM_REG(data->in[attr->index],
-		       data->in_vref));
-}
-static ssize_t show_in_min(struct device *dev, struct device_attribute *devattr, char *buf)
-{
-	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
-	struct pc87360_data *data = pc87360_update_device(dev);
-	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_min[attr->index],
-		       data->in_vref));
-}
-static ssize_t show_in_max(struct device *dev, struct device_attribute *devattr, char *buf)
-{
-	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
-	struct pc87360_data *data = pc87360_update_device(dev);
-	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_max[attr->index],
-		       data->in_vref));
-}
-static ssize_t show_in_status(struct device *dev, struct device_attribute *devattr, char *buf)
+static ssize_t show_vin(struct device *dev, struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
+	int idx = attr->index;
+	int func = attr->nr;
 	struct pc87360_data *data = pc87360_update_device(dev);
-	return sprintf(buf, "%u\n", data->in_status[attr->index]);
+	unsigned res = -1;
+	
+	switch (func) {
+	case FN_IN_INPUT:
+		res = IN_FROM_REG(data->in[idx], data->in_vref);
+		break;
+	case FN_IN_MIN:
+		res = IN_FROM_REG(data->in_min[idx], data->in_vref);
+		break;
+	case FN_IN_MAX:
+		res = IN_FROM_REG(data->in_max[idx], data->in_vref);
+		break;
+	case FN_IN_STATUS:
+		res = data->in_status[idx];
+		break;
+	default:
+		printk(KERN_ERR "unknown attr fetch\n");
+	}
+	return sprintf(buf, "%u\n", res);
 }
-static ssize_t set_in_min(struct device *dev, struct device_attribute *devattr, const char *buf,
-	size_t count)
-{
-	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct pc87360_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
 
-	mutex_lock(&data->update_lock);
-	data->in_min[attr->index] = IN_TO_REG(val, data->in_vref);
-	pc87360_write_value(data, LD_IN, attr->index, PC87365_REG_IN_MIN,
-			    data->in_min[attr->index]);
-	mutex_unlock(&data->update_lock);
-	return count;
-}
-static ssize_t set_in_max(struct device *dev, struct device_attribute *devattr, const char *buf,
-	size_t count)
+static ssize_t set_in(struct device *dev, struct device_attribute *devattr, const char *buf,
+		      size_t count)
 {
 	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
+	int idx = attr->index;
+	int func = attr->nr;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct pc87360_data *data = i2c_get_clientdata(client);
 	long val = simple_strtol(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
-	data->in_max[attr->index] = IN_TO_REG(val,
-			       data->in_vref);
-	pc87360_write_value(data, LD_IN, attr->index, PC87365_REG_IN_MAX,
-			    data->in_max[attr->index]);
+	switch (func) {
+	case FN_IN_MIN:
+		data->in_min[idx] = IN_TO_REG(val, data->in_vref);
+		pc87360_write_value(data, LD_IN, idx, PC87365_REG_IN_MIN,
+				    data->in_min[idx]);
+		break;
+	case FN_IN_MAX:
+		data->in_max[idx] = IN_TO_REG(val, data->in_vref);
+		pc87360_write_value(data, LD_IN, idx, PC87365_REG_IN_MAX,
+				    data->in_max[idx]);
+		break;
+	default:
+		printk(KERN_ERR "unknown attr fetch\n");
+	}
 	mutex_unlock(&data->update_lock);
 	return count;
 }
 
 static struct sensor_device_attribute_2 in_input[] = {
-	SENSOR_ATTR_2(in0_input, S_IRUGO, show_in_input, NULL, FN_IN_INPUT, 0),
-	SENSOR_ATTR_2(in1_input, S_IRUGO, show_in_input, NULL, FN_IN_INPUT, 1),
-	SENSOR_ATTR_2(in2_input, S_IRUGO, show_in_input, NULL, FN_IN_INPUT, 2),
-	SENSOR_ATTR_2(in3_input, S_IRUGO, show_in_input, NULL, FN_IN_INPUT, 3),
-	SENSOR_ATTR_2(in4_input, S_IRUGO, show_in_input, NULL, FN_IN_INPUT, 4),
-	SENSOR_ATTR_2(in5_input, S_IRUGO, show_in_input, NULL, FN_IN_INPUT, 5),
-	SENSOR_ATTR_2(in6_input, S_IRUGO, show_in_input, NULL, FN_IN_INPUT, 6),
-	SENSOR_ATTR_2(in7_input, S_IRUGO, show_in_input, NULL, FN_IN_INPUT, 7),
-	SENSOR_ATTR_2(in8_input, S_IRUGO, show_in_input, NULL, FN_IN_INPUT, 8),
-	SENSOR_ATTR_2(in9_input, S_IRUGO, show_in_input, NULL, FN_IN_INPUT, 9),
-	SENSOR_ATTR_2(in10_input, S_IRUGO, show_in_input, NULL, FN_IN_INPUT, 10),
+	SENSOR_ATTR_2(in0_input, S_IRUGO, show_vin, NULL, FN_IN_INPUT, 0),
+	SENSOR_ATTR_2(in1_input, S_IRUGO, show_vin, NULL, FN_IN_INPUT, 1),
+	SENSOR_ATTR_2(in2_input, S_IRUGO, show_vin, NULL, FN_IN_INPUT, 2),
+	SENSOR_ATTR_2(in3_input, S_IRUGO, show_vin, NULL, FN_IN_INPUT, 3),
+	SENSOR_ATTR_2(in4_input, S_IRUGO, show_vin, NULL, FN_IN_INPUT, 4),
+	SENSOR_ATTR_2(in5_input, S_IRUGO, show_vin, NULL, FN_IN_INPUT, 5),
+	SENSOR_ATTR_2(in6_input, S_IRUGO, show_vin, NULL, FN_IN_INPUT, 6),
+	SENSOR_ATTR_2(in7_input, S_IRUGO, show_vin, NULL, FN_IN_INPUT, 7),
+	SENSOR_ATTR_2(in8_input, S_IRUGO, show_vin, NULL, FN_IN_INPUT, 8),
+	SENSOR_ATTR_2(in9_input, S_IRUGO, show_vin, NULL, FN_IN_INPUT, 9),
+	SENSOR_ATTR_2(in10_input, S_IRUGO, show_vin, NULL, FN_IN_INPUT, 10),
 };
 static struct sensor_device_attribute_2 in_status[] = {
-	SENSOR_ATTR_2(in0_status, S_IRUGO, show_in_status, NULL, FN_IN_STATUS, 0),
-	SENSOR_ATTR_2(in1_status, S_IRUGO, show_in_status, NULL, FN_IN_STATUS, 1),
-	SENSOR_ATTR_2(in2_status, S_IRUGO, show_in_status, NULL, FN_IN_STATUS, 2),
-	SENSOR_ATTR_2(in3_status, S_IRUGO, show_in_status, NULL, FN_IN_STATUS, 3),
-	SENSOR_ATTR_2(in4_status, S_IRUGO, show_in_status, NULL, FN_IN_STATUS, 4),
-	SENSOR_ATTR_2(in5_status, S_IRUGO, show_in_status, NULL, FN_IN_STATUS, 5),
-	SENSOR_ATTR_2(in6_status, S_IRUGO, show_in_status, NULL, FN_IN_STATUS, 6),
-	SENSOR_ATTR_2(in7_status, S_IRUGO, show_in_status, NULL, FN_IN_STATUS, 7),
-	SENSOR_ATTR_2(in8_status, S_IRUGO, show_in_status, NULL, FN_IN_STATUS, 8),
-	SENSOR_ATTR_2(in9_status, S_IRUGO, show_in_status, NULL, FN_IN_STATUS, 9),
-	SENSOR_ATTR_2(in10_status, S_IRUGO, show_in_status, NULL, FN_IN_STATUS, 10),
+	SENSOR_ATTR_2(in0_status, S_IRUGO, show_vin, NULL, FN_IN_STATUS, 0),
+	SENSOR_ATTR_2(in1_status, S_IRUGO, show_vin, NULL, FN_IN_STATUS, 1),
+	SENSOR_ATTR_2(in2_status, S_IRUGO, show_vin, NULL, FN_IN_STATUS, 2),
+	SENSOR_ATTR_2(in3_status, S_IRUGO, show_vin, NULL, FN_IN_STATUS, 3),
+	SENSOR_ATTR_2(in4_status, S_IRUGO, show_vin, NULL, FN_IN_STATUS, 4),
+	SENSOR_ATTR_2(in5_status, S_IRUGO, show_vin, NULL, FN_IN_STATUS, 5),
+	SENSOR_ATTR_2(in6_status, S_IRUGO, show_vin, NULL, FN_IN_STATUS, 6),
+	SENSOR_ATTR_2(in7_status, S_IRUGO, show_vin, NULL, FN_IN_STATUS, 7),
+	SENSOR_ATTR_2(in8_status, S_IRUGO, show_vin, NULL, FN_IN_STATUS, 8),
+	SENSOR_ATTR_2(in9_status, S_IRUGO, show_vin, NULL, FN_IN_STATUS, 9),
+	SENSOR_ATTR_2(in10_status, S_IRUGO, show_vin, NULL, FN_IN_STATUS, 10),
 };
 static struct sensor_device_attribute_2 in_min[] = {
-	SENSOR_ATTR_2(in0_min, S_IWUSR | S_IRUGO, show_in_min, set_in_min, FN_IN_MIN, 0),
-	SENSOR_ATTR_2(in1_min, S_IWUSR | S_IRUGO, show_in_min, set_in_min, FN_IN_MIN, 1),
-	SENSOR_ATTR_2(in2_min, S_IWUSR | S_IRUGO, show_in_min, set_in_min, FN_IN_MIN, 2),
-	SENSOR_ATTR_2(in3_min, S_IWUSR | S_IRUGO, show_in_min, set_in_min, FN_IN_MIN, 3),
-	SENSOR_ATTR_2(in4_min, S_IWUSR | S_IRUGO, show_in_min, set_in_min, FN_IN_MIN, 4),
-	SENSOR_ATTR_2(in5_min, S_IWUSR | S_IRUGO, show_in_min, set_in_min, FN_IN_MIN, 5),
-	SENSOR_ATTR_2(in6_min, S_IWUSR | S_IRUGO, show_in_min, set_in_min, FN_IN_MIN, 6),
-	SENSOR_ATTR_2(in7_min, S_IWUSR | S_IRUGO, show_in_min, set_in_min, FN_IN_MIN, 7),
-	SENSOR_ATTR_2(in8_min, S_IWUSR | S_IRUGO, show_in_min, set_in_min, FN_IN_MIN, 8),
-	SENSOR_ATTR_2(in9_min, S_IWUSR | S_IRUGO, show_in_min, set_in_min, FN_IN_MIN, 9),
-	SENSOR_ATTR_2(in10_min, S_IWUSR | S_IRUGO, show_in_min, set_in_min, FN_IN_MIN, 10),
+	SENSOR_ATTR_2(in0_min, S_IWUSR | S_IRUGO, show_vin, set_in, FN_IN_MIN, 0),
+	SENSOR_ATTR_2(in1_min, S_IWUSR | S_IRUGO, show_vin, set_in, FN_IN_MIN, 1),
+	SENSOR_ATTR_2(in2_min, S_IWUSR | S_IRUGO, show_vin, set_in, FN_IN_MIN, 2),
+	SENSOR_ATTR_2(in3_min, S_IWUSR | S_IRUGO, show_vin, set_in, FN_IN_MIN, 3),
+	SENSOR_ATTR_2(in4_min, S_IWUSR | S_IRUGO, show_vin, set_in, FN_IN_MIN, 4),
+	SENSOR_ATTR_2(in5_min, S_IWUSR | S_IRUGO, show_vin, set_in, FN_IN_MIN, 5),
+	SENSOR_ATTR_2(in6_min, S_IWUSR | S_IRUGO, show_vin, set_in, FN_IN_MIN, 6),
+	SENSOR_ATTR_2(in7_min, S_IWUSR | S_IRUGO, show_vin, set_in, FN_IN_MIN, 7),
+	SENSOR_ATTR_2(in8_min, S_IWUSR | S_IRUGO, show_vin, set_in, FN_IN_MIN, 8),
+	SENSOR_ATTR_2(in9_min, S_IWUSR | S_IRUGO, show_vin, set_in, FN_IN_MIN, 9),
+	SENSOR_ATTR_2(in10_min, S_IWUSR | S_IRUGO, show_vin, set_in, FN_IN_MIN, 10),
 };
 static struct sensor_device_attribute_2 in_max[] = {
-	SENSOR_ATTR_2(in0_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, FN_IN_MAX, 0),
-	SENSOR_ATTR_2(in1_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, FN_IN_MAX, 1),
-	SENSOR_ATTR_2(in2_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, FN_IN_MAX, 2),
-	SENSOR_ATTR_2(in3_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, FN_IN_MAX, 3),
-	SENSOR_ATTR_2(in4_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, FN_IN_MAX, 4),
-	SENSOR_ATTR_2(in5_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, FN_IN_MAX, 5),
-	SENSOR_ATTR_2(in6_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, FN_IN_MAX, 6),
-	SENSOR_ATTR_2(in7_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, FN_IN_MAX, 7),
-	SENSOR_ATTR_2(in8_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, FN_IN_MAX, 8),
-	SENSOR_ATTR_2(in9_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, FN_IN_MAX, 9),
-	SENSOR_ATTR_2(in10_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, FN_IN_MAX, 10),
+	SENSOR_ATTR_2(in0_max, S_IWUSR | S_IRUGO, show_vin, set_in, FN_IN_MAX, 0),
+	SENSOR_ATTR_2(in1_max, S_IWUSR | S_IRUGO, show_vin, set_in, FN_IN_MAX, 1),
+	SENSOR_ATTR_2(in2_max, S_IWUSR | S_IRUGO, show_vin, set_in, FN_IN_MAX, 2),
+	SENSOR_ATTR_2(in3_max, S_IWUSR | S_IRUGO, show_vin, set_in, FN_IN_MAX, 3),
+	SENSOR_ATTR_2(in4_max, S_IWUSR | S_IRUGO, show_vin, set_in, FN_IN_MAX, 4),
+	SENSOR_ATTR_2(in5_max, S_IWUSR | S_IRUGO, show_vin, set_in, FN_IN_MAX, 5),
+	SENSOR_ATTR_2(in6_max, S_IWUSR | S_IRUGO, show_vin, set_in, FN_IN_MAX, 6),
+	SENSOR_ATTR_2(in7_max, S_IWUSR | S_IRUGO, show_vin, set_in, FN_IN_MAX, 7),
+	SENSOR_ATTR_2(in8_max, S_IWUSR | S_IRUGO, show_vin, set_in, FN_IN_MAX, 8),
+	SENSOR_ATTR_2(in9_max, S_IWUSR | S_IRUGO, show_vin, set_in, FN_IN_MAX, 9),
+	SENSOR_ATTR_2(in10_max, S_IWUSR | S_IRUGO, show_vin, set_in, FN_IN_MAX, 10),
 };
 
 #define VIN_UNIT_ATTRS(X) \
@@ -540,12 +534,12 @@ static ssize_t set_vrm(struct device *de
 }
 static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm, set_vrm);
 
-static ssize_t show_in_alarms(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t show_vin_alarms(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct pc87360_data *data = pc87360_update_device(dev);
 	return sprintf(buf, "%u\n", data->in_alarms);
 }
-static DEVICE_ATTR(alarms_in, S_IRUGO, show_in_alarms, NULL);
+static DEVICE_ATTR(alarms_in, S_IRUGO, show_vin_alarms, NULL);
 
 static struct attribute *pc8736x_vin_attr_array[] = {
 	VIN_UNIT_ATTRS(0),
@@ -574,82 +568,66 @@ static const struct attribute_group pc87
 #define FN_THERM_STATUS	12
 #define FN_THERM_CRIT	13
 
-static ssize_t show_therm_input(struct device *dev, struct device_attribute *devattr, char *buf)
-{
-	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
-	struct pc87360_data *data = pc87360_update_device(dev);
-	return sprintf(buf, "%u\n", IN_FROM_REG(data->in[attr->index],
-		       data->in_vref));
-}
-static ssize_t show_therm_min(struct device *dev, struct device_attribute *devattr, char *buf)
-{
-	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
-	struct pc87360_data *data = pc87360_update_device(dev);
-	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_min[attr->index],
-		       data->in_vref));
-}
-static ssize_t show_therm_max(struct device *dev, struct device_attribute *devattr, char *buf)
-{
-	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
-	struct pc87360_data *data = pc87360_update_device(dev);
-	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_max[attr->index],
-		       data->in_vref));
-}
-static ssize_t show_therm_crit(struct device *dev, struct device_attribute *devattr, char *buf)
-{
-	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
-	struct pc87360_data *data = pc87360_update_device(dev);
-	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_crit[attr->index-11],
-		       data->in_vref));
-}
-static ssize_t show_therm_status(struct device *dev, struct device_attribute *devattr, char *buf)
+static ssize_t show_therm(struct device *dev, struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
+	int idx = attr->index;
+	int func = attr->nr;
 	struct pc87360_data *data = pc87360_update_device(dev);
-	return sprintf(buf, "%u\n", data->in_status[attr->index]);
-}
-static ssize_t set_therm_min(struct device *dev, struct device_attribute *devattr, const char *buf,
-	size_t count)
-{
-	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct pc87360_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
-
-	mutex_lock(&data->update_lock);
-	data->in_min[attr->index] = IN_TO_REG(val, data->in_vref);
-	pc87360_write_value(data, LD_IN, attr->index, PC87365_REG_TEMP_MIN,
-			    data->in_min[attr->index]);
-	mutex_unlock(&data->update_lock);
-	return count;
+	unsigned res = -1;
+	
+	switch (func) {
+	case FN_THERM_INPUT:
+		res = IN_FROM_REG(data->in[idx], data->in_vref);
+		break;
+	case FN_THERM_MIN:
+		res = IN_FROM_REG(data->in_min[idx], data->in_vref);
+		break;
+	case FN_THERM_MAX:
+		res = IN_FROM_REG(data->in_max[idx], data->in_vref);
+		break;
+	case FN_THERM_STATUS:
+		res = data->in_status[idx];
+		break;
+	case FN_THERM_CRIT:
+		res = IN_FROM_REG(data->in_crit[idx-11], data->in_vref);
+		break;
+	default:
+		printk(KERN_ERR "unknown attr fetch\n");
+	}
+	return sprintf(buf, "%u\n", res);
 }
-static ssize_t set_therm_max(struct device *dev, struct device_attribute *devattr, const char *buf,
-	size_t count)
-{
-	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct pc87360_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
 
-	mutex_lock(&data->update_lock);
-	data->in_max[attr->index] = IN_TO_REG(val, data->in_vref);
-	pc87360_write_value(data, LD_IN, attr->index, PC87365_REG_TEMP_MAX,
-			    data->in_max[attr->index]);
-	mutex_unlock(&data->update_lock);
-	return count;
-}
-static ssize_t set_therm_crit(struct device *dev, struct device_attribute *devattr, const char *buf,
-	size_t count)
+static ssize_t set_therm(struct device *dev, struct device_attribute *devattr, const char *buf,
+			 size_t count)
 {
 	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
+	int idx = attr->index;
+	int func = attr->nr;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct pc87360_data *data = i2c_get_clientdata(client);
 	long val = simple_strtol(buf, NULL, 10);
-
+	
 	mutex_lock(&data->update_lock);
-	data->in_crit[attr->index-11] = IN_TO_REG(val, data->in_vref);
-	pc87360_write_value(data, LD_IN, attr->index, PC87365_REG_TEMP_CRIT,
-			    data->in_crit[attr->index-11]);
+	switch (func) {
+	case FN_THERM_MIN:
+		data->in_min[idx] = IN_TO_REG(val, data->in_vref);
+		pc87360_write_value(data, LD_IN, idx, PC87365_REG_TEMP_MIN,
+				    data->in_min[idx]);
+		break;
+	case FN_THERM_MAX:
+		data->in_max[idx] = IN_TO_REG(val, data->in_vref);
+		pc87360_write_value(data, LD_IN, idx, PC87365_REG_TEMP_MAX,
+				    data->in_max[idx]);
+		break;
+	case FN_THERM_CRIT:
+		data->in_crit[idx-11] = IN_TO_REG(val, data->in_vref);
+		pc87360_write_value(data, LD_IN, idx, PC87365_REG_TEMP_CRIT,
+				    data->in_crit[idx-11]);
+		break;
+	default:
+		printk(KERN_ERR "unknown attr fetch\n");
+	}
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -659,39 +637,39 @@ static ssize_t set_therm_crit(struct dev
 */
 
 static struct sensor_device_attribute_2 therm_input[] = {
-	SENSOR_ATTR_2(temp4_input, S_IRUGO, show_therm_input, NULL, FN_THERM_INPUT, 0+11),
-	SENSOR_ATTR_2(temp5_input, S_IRUGO, show_therm_input, NULL, FN_THERM_INPUT, 1+11),
-	SENSOR_ATTR_2(temp6_input, S_IRUGO, show_therm_input, NULL, FN_THERM_INPUT, 2+11),
+	SENSOR_ATTR_2(temp4_input, S_IRUGO, show_therm, NULL, FN_THERM_INPUT, 0+11),
+	SENSOR_ATTR_2(temp5_input, S_IRUGO, show_therm, NULL, FN_THERM_INPUT, 1+11),
+	SENSOR_ATTR_2(temp6_input, S_IRUGO, show_therm, NULL, FN_THERM_INPUT, 2+11),
 };
 
 static struct sensor_device_attribute_2 therm_status[] = {
-	SENSOR_ATTR_2(temp4_status, S_IRUGO, show_therm_status, NULL, FN_THERM_STATUS, 0+11),
-	SENSOR_ATTR_2(temp5_status, S_IRUGO, show_therm_status, NULL, FN_THERM_STATUS, 1+11),
-	SENSOR_ATTR_2(temp6_status, S_IRUGO, show_therm_status, NULL, FN_THERM_STATUS, 2+11),
+	SENSOR_ATTR_2(temp4_status, S_IRUGO, show_therm, NULL, FN_THERM_STATUS, 0+11),
+	SENSOR_ATTR_2(temp5_status, S_IRUGO, show_therm, NULL, FN_THERM_STATUS, 1+11),
+	SENSOR_ATTR_2(temp6_status, S_IRUGO, show_therm, NULL, FN_THERM_STATUS, 2+11),
 };
 static struct sensor_device_attribute_2 therm_min[] = {
 	SENSOR_ATTR_2(temp4_min, S_IRUGO | S_IWUSR,
-		      show_therm_min, set_therm_min, FN_THERM_MIN, 0+11),
+		      show_therm, set_therm, FN_THERM_MIN, 0+11),
 	SENSOR_ATTR_2(temp5_min, S_IRUGO | S_IWUSR,
-		      show_therm_min, set_therm_min, FN_THERM_MIN, 1+11),
+		      show_therm, set_therm, FN_THERM_MIN, 1+11),
 	SENSOR_ATTR_2(temp6_min, S_IRUGO | S_IWUSR,
-		      show_therm_min, set_therm_min, FN_THERM_MIN, 2+11),
+		      show_therm, set_therm, FN_THERM_MIN, 2+11),
 };
 static struct sensor_device_attribute_2 therm_max[] = {
 	SENSOR_ATTR_2(temp4_max, S_IRUGO | S_IWUSR,
-		      show_therm_max, set_therm_max, FN_THERM_MAX, 0+11),
+		      show_therm, set_therm, FN_THERM_MAX, 0+11),
 	SENSOR_ATTR_2(temp5_max, S_IRUGO | S_IWUSR,
-		      show_therm_max, set_therm_max, FN_THERM_MAX, 1+11),
+		      show_therm, set_therm, FN_THERM_MAX, 1+11),
 	SENSOR_ATTR_2(temp6_max, S_IRUGO | S_IWUSR,
-		      show_therm_max, set_therm_max, FN_THERM_MAX, 2+11),
+		      show_therm, set_therm, FN_THERM_MAX, 2+11),
 };
 static struct sensor_device_attribute_2 therm_crit[] = {
 	SENSOR_ATTR_2(temp4_crit, S_IRUGO | S_IWUSR,
-		      show_therm_crit, set_therm_crit, FN_THERM_CRIT, 0+11),
+		      show_therm, set_therm, FN_THERM_CRIT, 0+11),
 	SENSOR_ATTR_2(temp5_crit, S_IRUGO | S_IWUSR,
-		      show_therm_crit, set_therm_crit, FN_THERM_CRIT, 1+11),
+		      show_therm, set_therm, FN_THERM_CRIT, 1+11),
 	SENSOR_ATTR_2(temp6_crit, S_IRUGO | S_IWUSR,
-		      show_therm_crit, set_therm_crit, FN_THERM_CRIT, 2+11),
+		      show_therm, set_therm, FN_THERM_CRIT, 2+11),
 };
 
 #define THERM_UNIT_ATTRS(X) \
@@ -717,129 +695,104 @@ static const struct attribute_group pc87
 #define FN_TEMP_STATUS	17
 #define FN_TEMP_CRIT	18
 
-static ssize_t show_temp_input(struct device *dev, struct device_attribute *devattr, char *buf)
-{
-	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
-	int idx = attr->index;
-	struct pc87360_data *data = pc87360_update_device(dev);
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[idx]));
-}
-static ssize_t show_temp_min(struct device *dev, struct device_attribute *devattr, char *buf)
-{
-	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
-	int idx = attr->index;
-	struct pc87360_data *data = pc87360_update_device(dev);
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_min[idx]));
-}
-static ssize_t show_temp_max(struct device *dev, struct device_attribute *devattr, char *buf)
-{
-	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
-	int idx = attr->index;
-	struct pc87360_data *data = pc87360_update_device(dev);
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_max[idx]));
-}
-static ssize_t show_temp_crit(struct device *dev, struct device_attribute *devattr, char *buf)
-{
-	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
-	int idx = attr->index;
-	struct pc87360_data *data = pc87360_update_device(dev);
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_crit[idx]));
-}
-static ssize_t show_temp_status(struct device *dev, struct device_attribute *devattr, char *buf)
+static ssize_t show_temp(struct device *dev, struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
 	int idx = attr->index;
+	int func = attr->nr;
 	struct pc87360_data *data = pc87360_update_device(dev);
-	return sprintf(buf, "%d\n", data->temp_status[idx]);
-}
-static ssize_t set_temp_min(struct device *dev, struct device_attribute *devattr, const char *buf,
-	size_t count)
-{
-	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
-	int idx = attr->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct pc87360_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
-
-	mutex_lock(&data->update_lock);
-	data->temp_min[idx] = TEMP_TO_REG(val);
-	pc87360_write_value(data, LD_TEMP, idx, PC87365_REG_TEMP_MIN,
-			    data->temp_min[idx]);
-	mutex_unlock(&data->update_lock);
-	return count;
+	unsigned res = -1;
+	
+	switch (func) {
+	case FN_TEMP_INPUT:
+		res = TEMP_FROM_REG(data->temp[idx]);
+		break;
+	case FN_TEMP_MIN:
+		res = TEMP_FROM_REG(data->temp_min[idx]);
+		break;
+	case FN_TEMP_MAX:
+		res = TEMP_FROM_REG(data->temp_max[idx]);
+		break;
+	case FN_TEMP_STATUS:
+		res = data->temp_status[idx];
+		break;
+	case FN_TEMP_CRIT:
+		res = TEMP_FROM_REG(data->temp_crit[idx]);
+		break;
+	default:
+		printk(KERN_ERR "unknown attr fetch\n");
+	}
+	return sprintf(buf, "%u\n", res);
 }
-static ssize_t set_temp_max(struct device *dev, struct device_attribute *devattr, const char *buf,
-	size_t count)
-{
-	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
-	int idx = attr->index;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct pc87360_data *data = i2c_get_clientdata(client);
-	long val = simple_strtol(buf, NULL, 10);
 
-	mutex_lock(&data->update_lock);
-	data->temp_max[idx] = TEMP_TO_REG(val);
-	pc87360_write_value(data, LD_TEMP, idx, PC87365_REG_TEMP_MAX,
-			    data->temp_max[idx]);
-	mutex_unlock(&data->update_lock);
-	return count;
-}
-static ssize_t set_temp_crit(struct device *dev, struct device_attribute *devattr, const char *buf,
-	size_t count)
+static ssize_t set_temp(struct device *dev, struct device_attribute *devattr, const char *buf,
+			size_t count)
 {
 	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
 	int idx = attr->index;
+	int func = attr->nr;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct pc87360_data *data = i2c_get_clientdata(client);
 	long val = simple_strtol(buf, NULL, 10);
-
+	
 	mutex_lock(&data->update_lock);
-	data->temp_crit[idx] = TEMP_TO_REG(val);
-	pc87360_write_value(data, LD_TEMP, idx, PC87365_REG_TEMP_CRIT,
-			    data->temp_crit[idx]);
+	switch (func) {
+	case FN_TEMP_MIN:
+		data->temp_min[idx] = TEMP_TO_REG(val);
+		pc87360_write_value(data, LD_TEMP, idx, PC87365_REG_TEMP_MIN,
+				    data->temp_min[idx]);
+		break;
+	case FN_TEMP_MAX:
+		data->temp_max[idx] = TEMP_TO_REG(val);
+		pc87360_write_value(data, LD_TEMP, idx, PC87365_REG_TEMP_MAX,
+				    data->temp_max[idx]);
+		break;
+	case FN_TEMP_CRIT:
+		data->temp_crit[idx] = TEMP_TO_REG(val);
+		pc87360_write_value(data, LD_TEMP, idx, PC87365_REG_TEMP_CRIT,
+				    data->temp_crit[idx]);
+		break;
+	default:
+		printk(KERN_ERR "unknown attr fetch\n");
+	}
 	mutex_unlock(&data->update_lock);
 	return count;
 }
 
 static struct sensor_device_attribute_2 temp_input[] = {
-	SENSOR_ATTR_2(temp1_input, S_IRUGO,
-		      show_temp_input, NULL, FN_TEMP_INPUT, 0),
-	SENSOR_ATTR_2(temp2_input, S_IRUGO,
-		      show_temp_input, NULL, FN_TEMP_INPUT, 1),
-	SENSOR_ATTR_2(temp3_input, S_IRUGO,
-		      show_temp_input, NULL, FN_TEMP_INPUT, 2),
+	SENSOR_ATTR_2(temp1_input, S_IRUGO, show_temp, NULL, FN_TEMP_INPUT, 0),
+	SENSOR_ATTR_2(temp2_input, S_IRUGO, show_temp, NULL, FN_TEMP_INPUT, 1),
+	SENSOR_ATTR_2(temp3_input, S_IRUGO, show_temp, NULL, FN_TEMP_INPUT, 2),
 };
 static struct sensor_device_attribute_2 temp_status[] = {
-	SENSOR_ATTR_2(temp1_status, S_IRUGO,
-		      show_temp_status, NULL, FN_TEMP_STATUS, 0),
-	SENSOR_ATTR_2(temp2_status, S_IRUGO,
-		      show_temp_status, NULL, FN_TEMP_STATUS, 1),
-	SENSOR_ATTR_2(temp3_status, S_IRUGO,
-		      show_temp_status, NULL, FN_TEMP_STATUS, 2),
+	SENSOR_ATTR_2(temp1_status, S_IRUGO, show_temp, NULL, FN_TEMP_STATUS, 0),
+	SENSOR_ATTR_2(temp2_status, S_IRUGO, show_temp, NULL, FN_TEMP_STATUS, 1),
+	SENSOR_ATTR_2(temp3_status, S_IRUGO, show_temp, NULL, FN_TEMP_STATUS, 2),
+		      
 };
 static struct sensor_device_attribute_2 temp_min[] = {
 	SENSOR_ATTR_2(temp1_min, S_IRUGO | S_IWUSR,
-		    show_temp_min, set_temp_min, FN_TEMP_MIN, 0),
+		      show_temp, set_temp, FN_TEMP_MIN, 0),
 	SENSOR_ATTR_2(temp2_min, S_IRUGO | S_IWUSR,
-		    show_temp_min, set_temp_min, FN_TEMP_MIN, 1),
+		      show_temp, set_temp, FN_TEMP_MIN, 1),
 	SENSOR_ATTR_2(temp3_min, S_IRUGO | S_IWUSR,
-		    show_temp_min, set_temp_min, FN_TEMP_MIN, 2),
+		      show_temp, set_temp, FN_TEMP_MIN, 2),
 };
 static struct sensor_device_attribute_2 temp_max[] = {
 	SENSOR_ATTR_2(temp1_max, S_IRUGO | S_IWUSR,
-		    show_temp_max, set_temp_max, FN_TEMP_MAX, 0),
+		      show_temp, set_temp, FN_TEMP_MAX, 0),
 	SENSOR_ATTR_2(temp2_max, S_IRUGO | S_IWUSR,
-		    show_temp_max, set_temp_max, FN_TEMP_MAX, 1),
+		      show_temp, set_temp, FN_TEMP_MAX, 1),
 	SENSOR_ATTR_2(temp3_max, S_IRUGO | S_IWUSR,
-		    show_temp_max, set_temp_max, FN_TEMP_MAX, 2),
+		      show_temp, set_temp, FN_TEMP_MAX, 2),
 };
 static struct sensor_device_attribute_2 temp_crit[] = {
 	SENSOR_ATTR_2(temp1_crit, S_IRUGO | S_IWUSR,
-		    show_temp_crit, set_temp_crit, FN_TEMP_CRIT, 0),
+		      show_temp, set_temp, FN_TEMP_CRIT, 0),
 	SENSOR_ATTR_2(temp2_crit, S_IRUGO | S_IWUSR,
-		    show_temp_crit, set_temp_crit, FN_TEMP_CRIT, 1),
+		      show_temp, set_temp, FN_TEMP_CRIT, 1),
 	SENSOR_ATTR_2(temp3_crit, S_IRUGO | S_IWUSR,
-		    show_temp_crit, set_temp_crit, FN_TEMP_CRIT, 2),
+		      show_temp, set_temp, FN_TEMP_CRIT, 2),
 };
 
 static ssize_t show_temp_alarms(struct device *dev, struct device_attribute *attr, char *buf)



