From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 10 Oct 2007 19:11:01 +0000
Subject: [lm-sensors] [PATCH 1/3] hwmon: (adm1025) Use dynamic sysfs
Message-Id: <20071010211101.0c33978a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This lets us get rid of macro-generated functions and shrinks the
driver size by about 30%.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/adm1025.c |  291 ++++++++++++++++++++++++-----------------------
 1 file changed, 154 insertions(+), 137 deletions(-)

--- linux-2.6.23.orig/drivers/hwmon/adm1025.c	2007-10-10 18:01:48.000000000 +0200
+++ linux-2.6.23/drivers/hwmon/adm1025.c	2007-10-10 18:04:59.000000000 +0200
@@ -51,6 +51,7 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
 #include <linux/hwmon-vid.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
@@ -153,86 +154,96 @@ struct adm1025_data {
  * Sysfs stuff
  */
 
-#define show_in(offset) \
-static ssize_t show_in##offset(struct device *dev, struct device_attribute *attr, char *buf) \
-{ \
-	struct adm1025_data *data = adm1025_update_device(dev); \
-	return sprintf(buf, "%u\n", IN_FROM_REG(data->in[offset], \
-		       in_scale[offset])); \
-} \
-static ssize_t show_in##offset##_min(struct device *dev, struct device_attribute *attr, char *buf) \
-{ \
-	struct adm1025_data *data = adm1025_update_device(dev); \
-	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_min[offset], \
-		       in_scale[offset])); \
-} \
-static ssize_t show_in##offset##_max(struct device *dev, struct device_attribute *attr, char *buf) \
-{ \
-	struct adm1025_data *data = adm1025_update_device(dev); \
-	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_max[offset], \
-		       in_scale[offset])); \
-} \
-static DEVICE_ATTR(in##offset##_input, S_IRUGO, show_in##offset, NULL);
-show_in(0);
-show_in(1);
-show_in(2);
-show_in(3);
-show_in(4);
-show_in(5);
-
-#define show_temp(offset) \
-static ssize_t show_temp##offset(struct device *dev, struct device_attribute *attr, char *buf) \
-{ \
-	struct adm1025_data *data = adm1025_update_device(dev); \
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[offset-1])); \
-} \
-static ssize_t show_temp##offset##_min(struct device *dev, struct device_attribute *attr, char *buf) \
-{ \
-	struct adm1025_data *data = adm1025_update_device(dev); \
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_min[offset-1])); \
-} \
-static ssize_t show_temp##offset##_max(struct device *dev, struct device_attribute *attr, char *buf) \
-{ \
-	struct adm1025_data *data = adm1025_update_device(dev); \
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_max[offset-1])); \
-}\
-static DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_temp##offset, NULL);
-show_temp(1);
-show_temp(2);
+static ssize_t
+show_in(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	int index = to_sensor_dev_attr(attr)->index;
+	struct adm1025_data *data = adm1025_update_device(dev);
+	return sprintf(buf, "%u\n", IN_FROM_REG(data->in[index],
+		       in_scale[index]));
+}
+
+static ssize_t
+show_in_min(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	int index = to_sensor_dev_attr(attr)->index;
+	struct adm1025_data *data = adm1025_update_device(dev);
+	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_min[index],
+		       in_scale[index]));
+}
+
+static ssize_t
+show_in_max(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	int index = to_sensor_dev_attr(attr)->index;
+	struct adm1025_data *data = adm1025_update_device(dev);
+	return sprintf(buf, "%u\n", IN_FROM_REG(data->in_max[index],
+		       in_scale[index]));
+}
+
+static ssize_t
+show_temp(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	int index = to_sensor_dev_attr(attr)->index;
+	struct adm1025_data *data = adm1025_update_device(dev);
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[index]));
+}
+
+static ssize_t
+show_temp_min(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	int index = to_sensor_dev_attr(attr)->index;
+	struct adm1025_data *data = adm1025_update_device(dev);
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_min[index]));
+}
+
+static ssize_t
+show_temp_max(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	int index = to_sensor_dev_attr(attr)->index;
+	struct adm1025_data *data = adm1025_update_device(dev);
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_max[index]));
+}
+
+static ssize_t set_in_min(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t count)
+{
+	int index = to_sensor_dev_attr(attr)->index;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct adm1025_data *data = i2c_get_clientdata(client);
+	long val = simple_strtol(buf, NULL, 10);
+
+	mutex_lock(&data->update_lock);
+	data->in_min[index] = IN_TO_REG(val, in_scale[index]);
+	i2c_smbus_write_byte_data(client, ADM1025_REG_IN_MIN(index),
+				  data->in_min[index]);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static ssize_t set_in_max(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t count)
+{
+	int index = to_sensor_dev_attr(attr)->index;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct adm1025_data *data = i2c_get_clientdata(client);
+	long val = simple_strtol(buf, NULL, 10);
+
+	mutex_lock(&data->update_lock);
+	data->in_max[index] = IN_TO_REG(val, in_scale[index]);
+	i2c_smbus_write_byte_data(client, ADM1025_REG_IN_MAX(index),
+				  data->in_max[index]);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
 
 #define set_in(offset) \
-static ssize_t set_in##offset##_min(struct device *dev, struct device_attribute *attr, const char *buf, \
-	size_t count) \
-{ \
-	struct i2c_client *client = to_i2c_client(dev); \
-	struct adm1025_data *data = i2c_get_clientdata(client); \
-	long val = simple_strtol(buf, NULL, 10); \
- \
-	mutex_lock(&data->update_lock); \
-	data->in_min[offset] = IN_TO_REG(val, in_scale[offset]); \
-	i2c_smbus_write_byte_data(client, ADM1025_REG_IN_MIN(offset), \
-				  data->in_min[offset]); \
-	mutex_unlock(&data->update_lock); \
-	return count; \
-} \
-static ssize_t set_in##offset##_max(struct device *dev, struct device_attribute *attr, const char *buf, \
-	size_t count) \
-{ \
-	struct i2c_client *client = to_i2c_client(dev); \
-	struct adm1025_data *data = i2c_get_clientdata(client); \
-	long val = simple_strtol(buf, NULL, 10); \
- \
-	mutex_lock(&data->update_lock); \
-	data->in_max[offset] = IN_TO_REG(val, in_scale[offset]); \
-	i2c_smbus_write_byte_data(client, ADM1025_REG_IN_MAX(offset), \
-				  data->in_max[offset]); \
-	mutex_unlock(&data->update_lock); \
-	return count; \
-} \
-static DEVICE_ATTR(in##offset##_min, S_IWUSR | S_IRUGO, \
-	show_in##offset##_min, set_in##offset##_min); \
-static DEVICE_ATTR(in##offset##_max, S_IWUSR | S_IRUGO, \
-	show_in##offset##_max, set_in##offset##_max);
+static SENSOR_DEVICE_ATTR(in##offset##_input, S_IRUGO, \
+	show_in, NULL, offset); \
+static SENSOR_DEVICE_ATTR(in##offset##_min, S_IWUSR | S_IRUGO, \
+	show_in_min, set_in_min, offset); \
+static SENSOR_DEVICE_ATTR(in##offset##_max, S_IWUSR | S_IRUGO, \
+	show_in_max, set_in_max, offset)
 set_in(0);
 set_in(1);
 set_in(2);
@@ -240,39 +251,45 @@ set_in(3);
 set_in(4);
 set_in(5);
 
+static ssize_t set_temp_min(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	int index = to_sensor_dev_attr(attr)->index;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct adm1025_data *data = i2c_get_clientdata(client);
+	long val = simple_strtol(buf, NULL, 10);
+
+	mutex_lock(&data->update_lock);
+	data->temp_min[index] = TEMP_TO_REG(val);
+	i2c_smbus_write_byte_data(client, ADM1025_REG_TEMP_LOW(index),
+				  data->temp_min[index]);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static ssize_t set_temp_max(struct device *dev, struct device_attribute *attr,
+	const char *buf, size_t count)
+{
+	int index = to_sensor_dev_attr(attr)->index;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct adm1025_data *data = i2c_get_clientdata(client);
+	long val = simple_strtol(buf, NULL, 10);
+
+	mutex_lock(&data->update_lock);
+	data->temp_max[index] = TEMP_TO_REG(val);
+	i2c_smbus_write_byte_data(client, ADM1025_REG_TEMP_HIGH(index),
+				  data->temp_max[index]);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
 #define set_temp(offset) \
-static ssize_t set_temp##offset##_min(struct device *dev, struct device_attribute *attr, const char *buf, \
-	size_t count) \
-{ \
-	struct i2c_client *client = to_i2c_client(dev); \
-	struct adm1025_data *data = i2c_get_clientdata(client); \
-	long val = simple_strtol(buf, NULL, 10); \
- \
-	mutex_lock(&data->update_lock); \
-	data->temp_min[offset-1] = TEMP_TO_REG(val); \
-	i2c_smbus_write_byte_data(client, ADM1025_REG_TEMP_LOW(offset-1), \
-				  data->temp_min[offset-1]); \
-	mutex_unlock(&data->update_lock); \
-	return count; \
-} \
-static ssize_t set_temp##offset##_max(struct device *dev, struct device_attribute *attr, const char *buf, \
-	size_t count) \
-{ \
-	struct i2c_client *client = to_i2c_client(dev); \
-	struct adm1025_data *data = i2c_get_clientdata(client); \
-	long val = simple_strtol(buf, NULL, 10); \
- \
-	mutex_lock(&data->update_lock); \
-	data->temp_max[offset-1] = TEMP_TO_REG(val); \
-	i2c_smbus_write_byte_data(client, ADM1025_REG_TEMP_HIGH(offset-1), \
-				  data->temp_max[offset-1]); \
-	mutex_unlock(&data->update_lock); \
-	return count; \
-} \
-static DEVICE_ATTR(temp##offset##_min, S_IWUSR | S_IRUGO, \
-	show_temp##offset##_min, set_temp##offset##_min); \
-static DEVICE_ATTR(temp##offset##_max, S_IWUSR | S_IRUGO, \
-	show_temp##offset##_max, set_temp##offset##_max);
+static SENSOR_DEVICE_ATTR(temp##offset##_input, S_IRUGO, \
+	show_temp, NULL, offset - 1); \
+static SENSOR_DEVICE_ATTR(temp##offset##_min, S_IWUSR | S_IRUGO, \
+	show_temp_min, set_temp_min, offset - 1); \
+static SENSOR_DEVICE_ATTR(temp##offset##_max, S_IWUSR | S_IRUGO, \
+	show_temp_max, set_temp_max, offset - 1)
 set_temp(1);
 set_temp(2);
 
@@ -316,27 +333,27 @@ static int adm1025_attach_adapter(struct
 }
 
 static struct attribute *adm1025_attributes[] = {
-	&dev_attr_in0_input.attr,
-	&dev_attr_in1_input.attr,
-	&dev_attr_in2_input.attr,
-	&dev_attr_in3_input.attr,
-	&dev_attr_in5_input.attr,
-	&dev_attr_in0_min.attr,
-	&dev_attr_in1_min.attr,
-	&dev_attr_in2_min.attr,
-	&dev_attr_in3_min.attr,
-	&dev_attr_in5_min.attr,
-	&dev_attr_in0_max.attr,
-	&dev_attr_in1_max.attr,
-	&dev_attr_in2_max.attr,
-	&dev_attr_in3_max.attr,
-	&dev_attr_in5_max.attr,
-	&dev_attr_temp1_input.attr,
-	&dev_attr_temp2_input.attr,
-	&dev_attr_temp1_min.attr,
-	&dev_attr_temp2_min.attr,
-	&dev_attr_temp1_max.attr,
-	&dev_attr_temp2_max.attr,
+	&sensor_dev_attr_in0_input.dev_attr.attr,
+	&sensor_dev_attr_in1_input.dev_attr.attr,
+	&sensor_dev_attr_in2_input.dev_attr.attr,
+	&sensor_dev_attr_in3_input.dev_attr.attr,
+	&sensor_dev_attr_in5_input.dev_attr.attr,
+	&sensor_dev_attr_in0_min.dev_attr.attr,
+	&sensor_dev_attr_in1_min.dev_attr.attr,
+	&sensor_dev_attr_in2_min.dev_attr.attr,
+	&sensor_dev_attr_in3_min.dev_attr.attr,
+	&sensor_dev_attr_in5_min.dev_attr.attr,
+	&sensor_dev_attr_in0_max.dev_attr.attr,
+	&sensor_dev_attr_in1_max.dev_attr.attr,
+	&sensor_dev_attr_in2_max.dev_attr.attr,
+	&sensor_dev_attr_in3_max.dev_attr.attr,
+	&sensor_dev_attr_in5_max.dev_attr.attr,
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_temp2_input.dev_attr.attr,
+	&sensor_dev_attr_temp1_min.dev_attr.attr,
+	&sensor_dev_attr_temp2_min.dev_attr.attr,
+	&sensor_dev_attr_temp1_max.dev_attr.attr,
+	&sensor_dev_attr_temp2_max.dev_attr.attr,
 	&dev_attr_alarms.attr,
 	&dev_attr_cpu0_vid.attr,
 	&dev_attr_vrm.attr,
@@ -348,9 +365,9 @@ static const struct attribute_group adm1
 };
 
 static struct attribute *adm1025_attributes_opt[] = {
-	&dev_attr_in4_input.attr,
-	&dev_attr_in4_min.attr,
-	&dev_attr_in4_max.attr,
+	&sensor_dev_attr_in4_input.dev_attr.attr,
+	&sensor_dev_attr_in4_min.dev_attr.attr,
+	&sensor_dev_attr_in4_max.dev_attr.attr,
 	NULL
 };
 
@@ -464,11 +481,11 @@ static int adm1025_detect(struct i2c_ada
 	/* Pin 11 is either in4 (+12V) or VID4 */
 	if (!(config & 0x20)) {
 		if ((err = device_create_file(&new_client->dev,
-					&dev_attr_in4_input))
+					&sensor_dev_attr_in4_input.dev_attr))
 		 || (err = device_create_file(&new_client->dev,
-					&dev_attr_in4_min))
+					&sensor_dev_attr_in4_min.dev_attr))
 		 || (err = device_create_file(&new_client->dev,
-					&dev_attr_in4_max)))
+					&sensor_dev_attr_in4_max.dev_attr)))
 			goto exit_remove;
 	}
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
