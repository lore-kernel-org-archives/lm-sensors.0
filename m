From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 22 Oct 2007 15:46:42 +0000
Subject: [lm-sensors] [PATCH 3/5] hwmon: (gl518sm) Refactor fan functions
Message-Id: <20071022174642.3c3ce8f0@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This makes the code more readable and the binary smaller (by 5% or so).

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/gl518sm.c |  110 +++++++++++++++++++++++++----------------------
 1 file changed, 60 insertions(+), 50 deletions(-)

--- linux-2.6.24-rc0.orig/drivers/hwmon/gl518sm.c	2007-10-21 22:43:02.000000000 +0200
+++ linux-2.6.24-rc0/drivers/hwmon/gl518sm.c	2007-10-22 15:17:44.000000000 +0200
@@ -38,6 +38,7 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
 #include <linux/sysfs.h>
@@ -166,24 +167,10 @@ static ssize_t show_##suffix(struct devi
 	return sprintf(buf, "%d\n", type##_FROM_REG(data->value));	\
 }
 
-#define show_fan(suffix, value, index)					\
-static ssize_t show_##suffix(struct device *dev, struct device_attribute *attr, char *buf)		\
-{									\
-	struct gl518_data *data = gl518_update_device(dev);		\
-	return sprintf(buf, "%d\n", FAN_FROM_REG(data->value[index],	\
-		DIV_FROM_REG(data->fan_div[index])));			\
-}
-
 show(TEMP, temp_input1, temp_in);
 show(TEMP, temp_max1, temp_max);
 show(TEMP, temp_hyst1, temp_hyst);
 show(BOOL, fan_auto1, fan_auto1);
-show_fan(fan_input1, fan_in, 0);
-show_fan(fan_input2, fan_in, 1);
-show_fan(fan_min1, fan_min, 0);
-show_fan(fan_min2, fan_min, 1);
-show(DIV, fan_div1, fan_div[0]);
-show(DIV, fan_div2, fan_div[1]);
 show(VDD, in_input0, voltage_in[0]);
 show(IN, in_input1, voltage_in[1]);
 show(IN, in_input2, voltage_in[2]);
@@ -200,6 +187,32 @@ show(RAW, alarms, alarms);
 show(BOOL, beep_enable, beep_enable);
 show(BEEP_MASK, beep_mask, beep_mask);
 
+static ssize_t show_fan_input(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	int nr = to_sensor_dev_attr(attr)->index;
+	struct gl518_data *data = gl518_update_device(dev);
+	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan_in[nr],
+					DIV_FROM_REG(data->fan_div[nr])));
+}
+
+static ssize_t show_fan_min(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	int nr = to_sensor_dev_attr(attr)->index;
+	struct gl518_data *data = gl518_update_device(dev);
+	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan_min[nr],
+					DIV_FROM_REG(data->fan_div[nr])));
+}
+
+static ssize_t show_fan_div(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	int nr = to_sensor_dev_attr(attr)->index;
+	struct gl518_data *data = gl518_update_device(dev);
+	return sprintf(buf, "%d\n", DIV_FROM_REG(data->fan_div[nr]));
+}
+
 #define set(type, suffix, value, reg)					\
 static ssize_t set_##suffix(struct device *dev, struct device_attribute *attr, const char *buf,	\
 	size_t count)							\
@@ -241,8 +254,6 @@ static ssize_t set_##suffix(struct devic
 set(TEMP, temp_max1, temp_max, GL518_REG_TEMP_MAX);
 set(TEMP, temp_hyst1, temp_hyst, GL518_REG_TEMP_HYST);
 set_bits(BOOL, fan_auto1, fan_auto1, GL518_REG_MISC, 0x08, 3);
-set_bits(DIV, fan_div1, fan_div[0], GL518_REG_MISC, 0xc0, 6);
-set_bits(DIV, fan_div2, fan_div[1], GL518_REG_MISC, 0x30, 4);
 set_low(VDD, in_min0, voltage_min[0], GL518_REG_VDD_LIMIT);
 set_low(IN, in_min1, voltage_min[1], GL518_REG_VIN1_LIMIT);
 set_low(IN, in_min2, voltage_min[2], GL518_REG_VIN2_LIMIT);
@@ -254,25 +265,27 @@ set_high(IN, in_max3, voltage_max[3], GL
 set_bits(BOOL, beep_enable, beep_enable, GL518_REG_CONF, 0x04, 2);
 set(BEEP_MASK, beep_mask, beep_mask, GL518_REG_ALARM);
 
-static ssize_t set_fan_min1(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+static ssize_t set_fan_min(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct gl518_data *data = i2c_get_clientdata(client);
+	int nr = to_sensor_dev_attr(attr)->index;
 	int regvalue;
 	unsigned long val = simple_strtoul(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
 	regvalue = gl518_read_value(client, GL518_REG_FAN_LIMIT);
-	data->fan_min[0] = FAN_TO_REG(val,
-		DIV_FROM_REG(data->fan_div[0]));
-	regvalue = (regvalue & 0x00ff) | (data->fan_min[0] << 8);
+	data->fan_min[nr] = FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
+	regvalue = (regvalue & (0xff << (8 * nr)))
+		 | (data->fan_min[nr] << (8 * (1 - nr)));
 	gl518_write_value(client, GL518_REG_FAN_LIMIT, regvalue);
 
 	data->beep_mask = gl518_read_value(client, GL518_REG_ALARM);
-	if (data->fan_min[0] = 0)
-		data->alarm_mask &= ~0x20;
+	if (data->fan_min[nr] = 0)
+		data->alarm_mask &= ~(0x20 << nr);
 	else
-		data->alarm_mask |= 0x20;
+		data->alarm_mask |= (0x20 << nr);
 	data->beep_mask &= data->alarm_mask;
 	gl518_write_value(client, GL518_REG_ALARM, data->beep_mask);
 
@@ -280,28 +293,21 @@ static ssize_t set_fan_min1(struct devic
 	return count;
 }
 
-static ssize_t set_fan_min2(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+static ssize_t set_fan_div(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct gl518_data *data = i2c_get_clientdata(client);
+	int nr = to_sensor_dev_attr(attr)->index;
 	int regvalue;
 	unsigned long val = simple_strtoul(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
-	regvalue = gl518_read_value(client, GL518_REG_FAN_LIMIT);
-	data->fan_min[1] = FAN_TO_REG(val,
-		DIV_FROM_REG(data->fan_div[1]));
-	regvalue = (regvalue & 0xff00) | data->fan_min[1];
-	gl518_write_value(client, GL518_REG_FAN_LIMIT, regvalue);
-
-	data->beep_mask = gl518_read_value(client, GL518_REG_ALARM);
-	if (data->fan_min[1] = 0)
-		data->alarm_mask &= ~0x40;
-	else
-		data->alarm_mask |= 0x40;
-	data->beep_mask &= data->alarm_mask;
-	gl518_write_value(client, GL518_REG_ALARM, data->beep_mask);
-
+	regvalue = gl518_read_value(client, GL518_REG_MISC);
+	data->fan_div[nr] = DIV_TO_REG(val);
+	regvalue = (regvalue & ~(0xc0 >> (2 * nr)))
+		 | (data->fan_div[nr] << (6 - 2 * nr));
+	gl518_write_value(client, GL518_REG_MISC, regvalue);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -311,12 +317,16 @@ static DEVICE_ATTR(temp1_max, S_IWUSR|S_
 static DEVICE_ATTR(temp1_max_hyst, S_IWUSR|S_IRUGO,
 	show_temp_hyst1, set_temp_hyst1);
 static DEVICE_ATTR(fan1_auto, S_IWUSR|S_IRUGO, show_fan_auto1, set_fan_auto1);
-static DEVICE_ATTR(fan1_input, S_IRUGO, show_fan_input1, NULL);
-static DEVICE_ATTR(fan2_input, S_IRUGO, show_fan_input2, NULL);
-static DEVICE_ATTR(fan1_min, S_IWUSR|S_IRUGO, show_fan_min1, set_fan_min1);
-static DEVICE_ATTR(fan2_min, S_IWUSR|S_IRUGO, show_fan_min2, set_fan_min2);
-static DEVICE_ATTR(fan1_div, S_IWUSR|S_IRUGO, show_fan_div1, set_fan_div1);
-static DEVICE_ATTR(fan2_div, S_IWUSR|S_IRUGO, show_fan_div2, set_fan_div2);
+static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, show_fan_input, NULL, 0);
+static SENSOR_DEVICE_ATTR(fan2_input, S_IRUGO, show_fan_input, NULL, 1);
+static SENSOR_DEVICE_ATTR(fan1_min, S_IWUSR|S_IRUGO,
+	show_fan_min, set_fan_min, 0);
+static SENSOR_DEVICE_ATTR(fan2_min, S_IWUSR|S_IRUGO,
+	show_fan_min, set_fan_min, 1);
+static SENSOR_DEVICE_ATTR(fan1_div, S_IWUSR|S_IRUGO,
+	show_fan_div, set_fan_div, 0);
+static SENSOR_DEVICE_ATTR(fan2_div, S_IWUSR|S_IRUGO,
+	show_fan_div, set_fan_div, 1);
 static DEVICE_ATTR(in0_input, S_IRUGO, show_in_input0, NULL);
 static DEVICE_ATTR(in1_input, S_IRUGO, show_in_input1, NULL);
 static DEVICE_ATTR(in2_input, S_IRUGO, show_in_input2, NULL);
@@ -347,12 +357,12 @@ static struct attribute *gl518_attribute
 	&dev_attr_in3_max.attr,
 
 	&dev_attr_fan1_auto.attr,
-	&dev_attr_fan1_input.attr,
-	&dev_attr_fan2_input.attr,
-	&dev_attr_fan1_min.attr,
-	&dev_attr_fan2_min.attr,
-	&dev_attr_fan1_div.attr,
-	&dev_attr_fan2_div.attr,
+	&sensor_dev_attr_fan1_input.dev_attr.attr,
+	&sensor_dev_attr_fan2_input.dev_attr.attr,
+	&sensor_dev_attr_fan1_min.dev_attr.attr,
+	&sensor_dev_attr_fan2_min.dev_attr.attr,
+	&sensor_dev_attr_fan1_div.dev_attr.attr,
+	&sensor_dev_attr_fan2_div.dev_attr.attr,
 
 	&dev_attr_temp1_input.attr,
 	&dev_attr_temp1_max.attr,


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
