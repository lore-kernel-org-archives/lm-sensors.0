From: jcromie@divsol.com (Jim Cromie)
Date: Tue, 02 Aug 2005 00:16:07 +0000
Subject: [lm-sensors] [patchset 16/23] pc87360 convert thermistor dev-attr
Message-Id: <42EE9D5B.7010403@divsol.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



convert thermistor dev-attr get-set macros to functions.

[jimc@harpo pset]$ diffstat 11-therm-demacro
 pc87360.c |  169 
+++++++++++++++++++++++++++++++-------------------------------
 1 files changed, 85 insertions(+), 84 deletions(-)


Signed-off-by:  Jim Cromie <jcromie@divsol.com>


-------------- next part --------------
diff -ruNp -X exclude-diffs lxE-3/drivers/hwmon/pc87360.c lxE-4/drivers/hwmon/pc87360.c
--- lxE-3/drivers/hwmon/pc87360.c	2005-07-31 21:15:31.000000000 -0600
+++ lxE-4/drivers/hwmon/pc87360.c	2005-07-31 21:16:07.000000000 -0600
@@ -436,96 +436,97 @@ show_and_set_in(8)
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
