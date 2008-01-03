From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 03 Jan 2008 22:00:30 +0000
Subject: [lm-sensors] [PATCH 2/3] hwmon: (w83627hf) Add individual alarm and
Message-Id: <20080103230030.549f58b5@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The new libsensors needs these individual alarm and beep files. The
code was copied from the w83781d driver. I've tested the alarm files
on a W83627THF. I couldn't test the beep files as the system in
question doesn't have a speaker.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
Carlos, Jim, could any of you please test and/or review this patch?

 drivers/hwmon/w83627hf.c |  142 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 139 insertions(+), 3 deletions(-)

--- linux-2.6.24-rc6.orig/drivers/hwmon/w83627hf.c	2008-01-02 11:16:28.000000000 +0100
+++ linux-2.6.24-rc6/drivers/hwmon/w83627hf.c	2008-01-02 11:26:23.000000000 +0100
@@ -717,6 +717,29 @@ show_alarms_reg(struct device *dev, stru
 }
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms_reg, NULL);
 
+static ssize_t
+show_alarm(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct w83627hf_data *data = w83627hf_update_device(dev);
+	int bitnr = to_sensor_dev_attr(attr)->index;
+	return sprintf(buf, "%u\n", (data->alarms >> bitnr) & 1);
+}
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
+static SENSOR_DEVICE_ATTR(temp3_alarm, S_IRUGO, show_alarm, NULL, 13);
+
 #define show_beep_reg(REG, reg) \
 static ssize_t show_beep_##reg (struct device *dev, struct device_attribute *attr, char *buf) \
 { \
@@ -778,6 +801,91 @@ sysfs_beep(ENABLE, enable);
 sysfs_beep(MASK, mask);
 
 static ssize_t
+show_beep(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct w83627hf_data *data = w83627hf_update_device(dev);
+	int bitnr = to_sensor_dev_attr(attr)->index;
+	return sprintf(buf, "%u\n", (data->beep_mask >> bitnr) & 1);
+}
+
+static ssize_t
+store_beep(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct w83627hf_data *data = dev_get_drvdata(dev);
+	int bitnr = to_sensor_dev_attr(attr)->index;
+	unsigned long bit;
+	u8 reg;
+
+	bit = simple_strtoul(buf, NULL, 10);
+	if (bit & ~1)
+		return -EINVAL;
+
+	mutex_lock(&data->update_lock);
+	if (bit)
+		data->beep_mask |= (1 << bitnr);
+	else
+		data->beep_mask &= ~(1 << bitnr);
+
+	if (bitnr < 8) {
+		reg = w83627hf_read_value(data, W83781D_REG_BEEP_INTS1);
+		if (bit)
+			reg |= (1 << bitnr);
+		else
+			reg &= ~(1 << bitnr);
+		w83627hf_write_value(data, W83781D_REG_BEEP_INTS1, reg);
+	} else if (bitnr < 16) {
+		reg = w83627hf_read_value(data, W83781D_REG_BEEP_INTS2);
+		if (bit)
+			reg |= (1 << (bitnr - 8));
+		else
+			reg &= ~(1 << (bitnr - 8));
+		w83627hf_write_value(data, W83781D_REG_BEEP_INTS2, reg);
+	} else {
+		reg = w83627hf_read_value(data, W83781D_REG_BEEP_INTS3);
+		if (bit)
+			reg |= (1 << (bitnr - 16));
+		else
+			reg &= ~(1 << (bitnr - 16));
+		w83627hf_write_value(data, W83781D_REG_BEEP_INTS3, reg);
+	}
+	mutex_unlock(&data->update_lock);
+
+	return count;
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
+static SENSOR_DEVICE_ATTR(temp3_beep, S_IRUGO | S_IWUSR,
+			show_beep, store_beep, 13);
+
+static ssize_t
 show_fan_div(struct device *dev, struct device_attribute *devattr, char *buf)
 {
 	int nr = to_sensor_dev_attr(devattr)->index;
@@ -1077,23 +1185,31 @@ static int __init w83627hf_find(int sioa
 #define VIN_UNIT_ATTRS(_X_)	\
 	&sensor_dev_attr_in##_X_##_input.dev_attr.attr,		\
 	&sensor_dev_attr_in##_X_##_min.dev_attr.attr,		\
-	&sensor_dev_attr_in##_X_##_max.dev_attr.attr
+	&sensor_dev_attr_in##_X_##_max.dev_attr.attr,		\
+	&sensor_dev_attr_in##_X_##_alarm.dev_attr.attr,		\
+	&sensor_dev_attr_in##_X_##_beep.dev_attr.attr
 
 #define FAN_UNIT_ATTRS(_X_)	\
 	&sensor_dev_attr_fan##_X_##_input.dev_attr.attr,	\
 	&sensor_dev_attr_fan##_X_##_min.dev_attr.attr,		\
-	&sensor_dev_attr_fan##_X_##_div.dev_attr.attr
+	&sensor_dev_attr_fan##_X_##_div.dev_attr.attr,		\
+	&sensor_dev_attr_fan##_X_##_alarm.dev_attr.attr,	\
+	&sensor_dev_attr_fan##_X_##_beep.dev_attr.attr
 
 #define TEMP_UNIT_ATTRS(_X_)	\
 	&sensor_dev_attr_temp##_X_##_input.dev_attr.attr,	\
 	&sensor_dev_attr_temp##_X_##_max.dev_attr.attr,		\
 	&sensor_dev_attr_temp##_X_##_max_hyst.dev_attr.attr,	\
-	&sensor_dev_attr_temp##_X_##_type.dev_attr.attr
+	&sensor_dev_attr_temp##_X_##_type.dev_attr.attr,	\
+	&sensor_dev_attr_temp##_X_##_alarm.dev_attr.attr,	\
+	&sensor_dev_attr_temp##_X_##_beep.dev_attr.attr
 
 static struct attribute *w83627hf_attributes[] = {
 	&dev_attr_in0_input.attr,
 	&dev_attr_in0_min.attr,
 	&dev_attr_in0_max.attr,
+	&sensor_dev_attr_in0_alarm.dev_attr.attr,
+	&sensor_dev_attr_in0_beep.dev_attr.attr,
 	VIN_UNIT_ATTRS(2),
 	VIN_UNIT_ATTRS(3),
 	VIN_UNIT_ATTRS(4),
@@ -1197,12 +1313,20 @@ static int __devinit w83627hf_probe(stru
 		 || (err = device_create_file(dev,
 				&sensor_dev_attr_in5_max.dev_attr))
 		 || (err = device_create_file(dev,
+				&sensor_dev_attr_in5_alarm.dev_attr))
+		 || (err = device_create_file(dev,
+				&sensor_dev_attr_in5_beep.dev_attr))
+		 || (err = device_create_file(dev,
 				&sensor_dev_attr_in6_input.dev_attr))
 		 || (err = device_create_file(dev,
 				&sensor_dev_attr_in6_min.dev_attr))
 		 || (err = device_create_file(dev,
 				&sensor_dev_attr_in6_max.dev_attr))
 		 || (err = device_create_file(dev,
+				&sensor_dev_attr_in6_alarm.dev_attr))
+		 || (err = device_create_file(dev,
+				&sensor_dev_attr_in6_beep.dev_attr))
+		 || (err = device_create_file(dev,
 				&sensor_dev_attr_pwm1_freq.dev_attr))
 		 || (err = device_create_file(dev,
 				&sensor_dev_attr_pwm2_freq.dev_attr)))
@@ -1216,18 +1340,30 @@ static int __devinit w83627hf_probe(stru
 		 || (err = device_create_file(dev,
 				&sensor_dev_attr_in1_max.dev_attr))
 		 || (err = device_create_file(dev,
+				&sensor_dev_attr_in1_alarm.dev_attr))
+		 || (err = device_create_file(dev,
+				&sensor_dev_attr_in1_beep.dev_attr))
+		 || (err = device_create_file(dev,
 				&sensor_dev_attr_fan3_input.dev_attr))
 		 || (err = device_create_file(dev,
 				&sensor_dev_attr_fan3_min.dev_attr))
 		 || (err = device_create_file(dev,
 				&sensor_dev_attr_fan3_div.dev_attr))
 		 || (err = device_create_file(dev,
+				&sensor_dev_attr_fan3_alarm.dev_attr))
+		 || (err = device_create_file(dev,
+				&sensor_dev_attr_fan3_beep.dev_attr))
+		 || (err = device_create_file(dev,
 				&sensor_dev_attr_temp3_input.dev_attr))
 		 || (err = device_create_file(dev,
 				&sensor_dev_attr_temp3_max.dev_attr))
 		 || (err = device_create_file(dev,
 				&sensor_dev_attr_temp3_max_hyst.dev_attr))
 		 || (err = device_create_file(dev,
+				&sensor_dev_attr_temp3_alarm.dev_attr))
+		 || (err = device_create_file(dev,
+				&sensor_dev_attr_temp3_beep.dev_attr))
+		 || (err = device_create_file(dev,
 				&sensor_dev_attr_temp3_type.dev_attr)))
 			goto ERROR4;
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
