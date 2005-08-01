From: jcromie@divsol.com (Jim Cromie)
Date: Mon, 01 Aug 2005 23:59:00 +0000
Subject: [lm-sensors] [patchset 13/23] pc87360 convert voltage dev-attr
Message-Id: <42EE9ACD.1010808@divsol.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



convert voltage dev-attr get-set macros to functions.

[jimc@harpo pset]$ diffstat 08-vin-demacro
 pc87360.c |  124 
+++++++++++++++++++++++++++++++-------------------------------
 1 files changed, 62 insertions(+), 62 deletions(-)


Signed-off-by:  Jim Cromie <jcromie@divsol.com>


-------------- next part --------------
diff -ruNp -X exclude-diffs lxD-12/drivers/hwmon/pc87360.c lxE-1/drivers/hwmon/pc87360.c
--- lxD-12/drivers/hwmon/pc87360.c	2005-07-31 19:41:02.000000000 -0600
+++ lxE-1/drivers/hwmon/pc87360.c	2005-07-31 21:14:00.000000000 -0600
@@ -354,73 +354,73 @@ show_and_set_pwm(1)
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
