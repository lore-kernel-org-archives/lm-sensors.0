From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 07 Oct 2007 18:57:40 +0000
Subject: [lm-sensors] [PATCH] hwmon/w83781d: Add individual alarm and beep
Message-Id: <20071007205740.0c52f8cf@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The upcoming libsensors 3 needs these individual alarm and beep files.
For the W83781D, this is quirky because this chip has a single alarm
bit for both temp2 and temp3.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83781d.c |  165 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 159 insertions(+), 6 deletions(-)

--- linux-2.6.23-rc9.orig/drivers/hwmon/w83781d.c	2007-10-07 19:21:58.000000000 +0200
+++ linux-2.6.23-rc9/drivers/hwmon/w83781d.c	2007-10-07 20:32:13.000000000 +0200
@@ -480,6 +480,39 @@ show_alarms_reg(struct device *dev, stru
 
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms_reg, NULL);
 
+static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct w83781d_data *data = w83781d_update_device(dev);
+	int bitnr = to_sensor_dev_attr(attr)->index;
+	return sprintf(buf, "%u\n", (data->alarms >> bitnr) & 1);
+}
+
+/* The W83781D has a single alarm bit for temp2 and temp3 */
+static ssize_t show_temp3_alarm(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct w83781d_data *data = w83781d_update_device(dev);
+	int bitnr = (data->type = w83781d) ? 5 : 13;
+	return sprintf(buf, "%u\n", (data->alarms >> bitnr) & 1);
+}
+
+static SENSOR_DEVICE_ATTR(in0_alarm, S_IRUGO, show_alarm, NULL, 0);
+static SENSOR_DEVICE_ATTR(in1_alarm, S_IRUGO, show_alarm, NULL, 1);
+static SENSOR_DEVICE_ATTR(in2_alarm, S_IRUGO, show_alarm, NULL, 2);
+static SENSOR_DEVICE_ATTR(in3_alarm, S_IRUGO, show_alarm, NULL, 3);
+static SENSOR_DEVICE_ATTR(in4_alarm, S_IRUGO, show_alarm, NULL, 8);
+static SENSOR_DEVICE_ATTR(in5_alarm, S_IRUGO, show_alarm, NULL, 9);
+static SENSOR_DEVICE_ATTR(in6_alarm, S_IRUGO, show_alarm, NULL, 10);
+static SENSOR_DEVICE_ATTR(in7_alarm, S_IRUGO, show_alarm, NULL, 16);
+static SENSOR_DEVICE_ATTR(in8_alarm, S_IRUGO, show_alarm, NULL, 17);
+static SENSOR_DEVICE_ATTR(fan1_alarm, S_IRUGO, show_alarm, NULL, 6);
+static SENSOR_DEVICE_ATTR(fan2_alarm, S_IRUGO, show_alarm, NULL, 7);
+static SENSOR_DEVICE_ATTR(fan3_alarm, S_IRUGO, show_alarm, NULL, 11);
+static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO, show_alarm, NULL, 4);
+static SENSOR_DEVICE_ATTR(temp2_alarm, S_IRUGO, show_alarm, NULL, 5);
+static SENSOR_DEVICE_ATTR(temp3_alarm, S_IRUGO, show_temp3_alarm, NULL, 0);
+
 static ssize_t show_beep_mask (struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w83781d_data *data = w83781d_update_device(dev);
@@ -543,6 +576,97 @@ static DEVICE_ATTR(beep_mask, S_IRUGO | 
 static DEVICE_ATTR(beep_enable, S_IRUGO | S_IWUSR,
 		show_beep_enable, store_beep_enable);
 
+static ssize_t show_beep(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct w83781d_data *data = w83781d_update_device(dev);
+	int bitnr = to_sensor_dev_attr(attr)->index;
+	return sprintf(buf, "%u\n", (data->beep_mask >> bitnr) & 1);
+}
+
+static ssize_t
+store_beep(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct w83781d_data *data = w83781d_update_device(dev);
+	int bitnr = to_sensor_dev_attr(attr)->index;
+	unsigned long bit;
+	u8 reg;
+
+	bit = simple_strtoul(buf, NULL, 10);
+	if (bit & ~1)
+		return -EINVAL;
+	bit <<= bitnr;
+
+	mutex_lock(&data->update_lock);
+	data->beep_mask &= ~(1 << bitnr);
+	data->beep_mask |= bit;
+
+	if (bitnr < 8) {
+		reg = w83781d_read_value(data, W83781D_REG_BEEP_INTS1);
+		reg &= ~(1 << bitnr);
+		reg |= bit;
+		w83781d_write_value(data, W83781D_REG_BEEP_INTS1, reg);
+	} else if (bitnr < 16) {
+		bit >>= 8;
+		bitnr -= 8;
+		reg = w83781d_read_value(data, W83781D_REG_BEEP_INTS2);
+		reg &= ~(1 << bitnr);
+		reg |= bit;
+		w83781d_write_value(data, W83781D_REG_BEEP_INTS2, reg);
+	} else {
+		bit >>= 16;
+		bitnr -= 16;
+		reg = w83781d_read_value(data, W83781D_REG_BEEP_INTS3);
+		reg &= ~(1 << bitnr);
+		reg |= bit;
+		w83781d_write_value(data, W83781D_REG_BEEP_INTS3, reg);
+	}
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+/* The W83781D has a single beep bit for temp2 and temp3 */
+static ssize_t show_temp3_beep(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct w83781d_data *data = w83781d_update_device(dev);
+	int bitnr = (data->type = w83781d) ? 5 : 13;
+	return sprintf(buf, "%u\n", (data->beep_mask >> bitnr) & 1);
+}
+
+static SENSOR_DEVICE_ATTR(in0_beep, S_IRUGO | S_IWUSR,
+			show_beep, store_beep, 0);
+static SENSOR_DEVICE_ATTR(in1_beep, S_IRUGO | S_IWUSR,
+			show_beep, store_beep, 1);
+static SENSOR_DEVICE_ATTR(in2_beep, S_IRUGO | S_IWUSR,
+			show_beep, store_beep, 2);
+static SENSOR_DEVICE_ATTR(in3_beep, S_IRUGO | S_IWUSR,
+			show_beep, store_beep, 3);
+static SENSOR_DEVICE_ATTR(in4_beep, S_IRUGO | S_IWUSR,
+			show_beep, store_beep, 8);
+static SENSOR_DEVICE_ATTR(in5_beep, S_IRUGO | S_IWUSR,
+			show_beep, store_beep, 9);
+static SENSOR_DEVICE_ATTR(in6_beep, S_IRUGO | S_IWUSR,
+			show_beep, store_beep, 10);
+static SENSOR_DEVICE_ATTR(in7_beep, S_IRUGO | S_IWUSR,
+			show_beep, store_beep, 16);
+static SENSOR_DEVICE_ATTR(in8_beep, S_IRUGO | S_IWUSR,
+			show_beep, store_beep, 17);
+static SENSOR_DEVICE_ATTR(fan1_beep, S_IRUGO | S_IWUSR,
+			show_beep, store_beep, 6);
+static SENSOR_DEVICE_ATTR(fan2_beep, S_IRUGO | S_IWUSR,
+			show_beep, store_beep, 7);
+static SENSOR_DEVICE_ATTR(fan3_beep, S_IRUGO | S_IWUSR,
+			show_beep, store_beep, 11);
+static SENSOR_DEVICE_ATTR(temp1_beep, S_IRUGO | S_IWUSR,
+			show_beep, store_beep, 4);
+static SENSOR_DEVICE_ATTR(temp2_beep, S_IRUGO | S_IWUSR,
+			show_beep, store_beep, 5);
+static SENSOR_DEVICE_ATTR(temp3_beep, S_IRUGO,
+			show_temp3_beep, store_beep, 13);
+
 static ssize_t
 show_fan_div(struct device *dev, struct device_attribute *da, char *buf)
 {
@@ -876,17 +1000,23 @@ ERROR_SC_0:
 #define IN_UNIT_ATTRS(X)					\
 	&sensor_dev_attr_in##X##_input.dev_attr.attr,		\
 	&sensor_dev_attr_in##X##_min.dev_attr.attr,		\
-	&sensor_dev_attr_in##X##_max.dev_attr.attr
+	&sensor_dev_attr_in##X##_max.dev_attr.attr, 		\
+	&sensor_dev_attr_in##X##_alarm.dev_attr.attr,		\
+	&sensor_dev_attr_in##X##_beep.dev_attr.attr
 
 #define FAN_UNIT_ATTRS(X)					\
 	&sensor_dev_attr_fan##X##_input.dev_attr.attr,		\
 	&sensor_dev_attr_fan##X##_min.dev_attr.attr,		\
-	&sensor_dev_attr_fan##X##_div.dev_attr.attr
+	&sensor_dev_attr_fan##X##_div.dev_attr.attr,		\
+	&sensor_dev_attr_fan##X##_alarm.dev_attr.attr,		\
+	&sensor_dev_attr_fan##X##_beep.dev_attr.attr
 
 #define TEMP_UNIT_ATTRS(X)					\
 	&sensor_dev_attr_temp##X##_input.dev_attr.attr,		\
 	&sensor_dev_attr_temp##X##_max.dev_attr.attr,		\
-	&sensor_dev_attr_temp##X##_max_hyst.dev_attr.attr
+	&sensor_dev_attr_temp##X##_max_hyst.dev_attr.attr,	\
+	&sensor_dev_attr_temp##X##_alarm.dev_attr.attr,		\
+	&sensor_dev_attr_temp##X##_beep.dev_attr.attr
 
 static struct attribute* w83781d_attributes[] = {
 	IN_UNIT_ATTRS(0),
@@ -945,7 +1075,11 @@ w83781d_create_files(struct device *dev,
 		    || (err = device_create_file(dev,
 				&sensor_dev_attr_in1_min.dev_attr))
 		    || (err = device_create_file(dev,
-				&sensor_dev_attr_in1_max.dev_attr)))
+				&sensor_dev_attr_in1_max.dev_attr))
+		    || (err = device_create_file(dev,
+				&sensor_dev_attr_in1_alarm.dev_attr))
+		    || (err = device_create_file(dev,
+				&sensor_dev_attr_in1_beep.dev_attr)))
 			return err;
 	}
 	if (kind != as99127f && kind != w83781d && kind != w83783s) {
@@ -956,11 +1090,19 @@ w83781d_create_files(struct device *dev,
 		    || (err = device_create_file(dev,
 				&sensor_dev_attr_in7_max.dev_attr))
 		    || (err = device_create_file(dev,
+				&sensor_dev_attr_in7_alarm.dev_attr))
+		    || (err = device_create_file(dev,
+				&sensor_dev_attr_in7_beep.dev_attr))
+		    || (err = device_create_file(dev,
 				&sensor_dev_attr_in8_input.dev_attr))
 		    || (err = device_create_file(dev,
 				&sensor_dev_attr_in8_min.dev_attr))
 		    || (err = device_create_file(dev,
-				&sensor_dev_attr_in8_max.dev_attr)))
+				&sensor_dev_attr_in8_max.dev_attr))
+		    || (err = device_create_file(dev,
+				&sensor_dev_attr_in8_alarm.dev_attr))
+		    || (err = device_create_file(dev,
+				&sensor_dev_attr_in8_beep.dev_attr)))
 			return err;
 	}
 	if (kind != w83783s) {
@@ -969,8 +1111,19 @@ w83781d_create_files(struct device *dev,
 		    || (err = device_create_file(dev,
 				&sensor_dev_attr_temp3_max.dev_attr))
 		    || (err = device_create_file(dev,
-				&sensor_dev_attr_temp3_max_hyst.dev_attr)))
+				&sensor_dev_attr_temp3_max_hyst.dev_attr))
+		    || (err = device_create_file(dev,
+				&sensor_dev_attr_temp3_alarm.dev_attr))
+		    || (err = device_create_file(dev,
+				&sensor_dev_attr_temp3_beep.dev_attr)))
 			return err;
+
+		if (kind != w83781d)
+			err = sysfs_chmod_file(&dev->kobj,
+				&sensor_dev_attr_temp3_alarm.dev_attr.attr,
+				S_IRUGO | S_IWUSR);
+			if (err)
+				return err;
 	}
 
 	if (kind != w83781d && kind != as99127f) {


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
