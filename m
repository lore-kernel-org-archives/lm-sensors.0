From: jcromie@divsol.com (Jim Cromie)
Date: Tue, 02 Aug 2005 00:50:48 +0000
Subject: [lm-sensors] [patchset 17/23] pc87360 convert temperature dev-attr
Message-Id: <42EEA6EE.8090800@divsol.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


convert temperature dev-attr get-set macros to functions.

[jimc@harpo pset]$ diffstat 12-temp-demacro
 pc87360.c |  172 
+++++++++++++++++++++++++++++++-------------------------------
 1 files changed, 88 insertions(+), 84 deletions(-)

Signed-off-by:  Jim Cromie <jcromie@divsol.com>


-------------- next part --------------
diff -ruNp -X exclude-diffs lxE-4/drivers/hwmon/pc87360.c lxE-5/drivers/hwmon/pc87360.c
--- lxE-4/drivers/hwmon/pc87360.c	2005-07-31 21:16:07.000000000 -0600
+++ lxE-5/drivers/hwmon/pc87360.c	2005-07-31 21:16:46.000000000 -0600
@@ -559,95 +559,99 @@ static ssize_t show_in_alarms(struct dev
 }
 static DEVICE_ATTR(alarms_in, S_IRUGO, show_in_alarms, NULL);
 
-#define show_and_set_temp(offset) \
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
+#define declare_temp_sdas(offset) \
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
-show_and_set_temp(1)
-show_and_set_temp(2)
-show_and_set_temp(3)
+	show_temp_status, NULL, offset)
+
+declare_temp_sdas(1);
+declare_temp_sdas(2);
+declare_temp_sdas(3);
+
 
 static ssize_t show_temp_alarms(struct device *dev, struct device_attribute *attr, char *buf)
 {
