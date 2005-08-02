From: jcromie@divsol.com (Jim Cromie)
Date: Tue, 02 Aug 2005 00:14:59 +0000
Subject: [lm-sensors] Re: [patchset 14/23] pc87360 convert fan-sensor
Message-Id: <42EE9CD8.2000100@divsol.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jim Cromie wrote:

>
> convert fan-sensor dev-attr get-set macros to functions.
>
> [jimc@harpo pset]$ diffstat 09-fan-demacro
> pc87360.c |   77 
> +++++++++++++++++++++++++++++++-------------------------------
> 1 files changed, 39 insertions(+), 38 deletions(-)
>
> Signed-off-by:  Jim Cromie <jcromie@divsol.com>
>
>
oops: attached
-------------- next part --------------
diff -ruNp -X exclude-diffs lxE-1/drivers/hwmon/pc87360.c lxE-2/drivers/hwmon/pc87360.c
--- lxE-1/drivers/hwmon/pc87360.c	2005-07-31 21:14:00.000000000 -0600
+++ lxE-2/drivers/hwmon/pc87360.c	2005-07-31 21:14:56.000000000 -0600
@@ -275,49 +275,50 @@ static ssize_t _set_fan_min(struct devic
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
