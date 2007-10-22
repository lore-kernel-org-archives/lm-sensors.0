From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 22 Oct 2007 15:47:16 +0000
Subject: [lm-sensors] [PATCH 4/5] hwmon: (gl518sm) Add individual alarm and
Message-Id: <20071022174716.2e41f277@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The new libsensors needs these.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/gl518sm.c |   69 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

--- linux-2.6.24-rc0.orig/drivers/hwmon/gl518sm.c	2007-10-22 15:17:44.000000000 +0200
+++ linux-2.6.24-rc0/drivers/hwmon/gl518sm.c	2007-10-22 15:21:24.000000000 +0200
@@ -345,6 +345,61 @@ static DEVICE_ATTR(beep_enable, S_IWUSR|
 static DEVICE_ATTR(beep_mask, S_IWUSR|S_IRUGO,
 	show_beep_mask, set_beep_mask);
 
+static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	int bitnr = to_sensor_dev_attr(attr)->index;
+	struct gl518_data *data = gl518_update_device(dev);
+	return sprintf(buf, "%u\n", (data->alarms >> bitnr) & 1);
+}
+
+static SENSOR_DEVICE_ATTR(in0_alarm, S_IRUGO, show_alarm, NULL, 0);
+static SENSOR_DEVICE_ATTR(in1_alarm, S_IRUGO, show_alarm, NULL, 1);
+static SENSOR_DEVICE_ATTR(in2_alarm, S_IRUGO, show_alarm, NULL, 2);
+static SENSOR_DEVICE_ATTR(in3_alarm, S_IRUGO, show_alarm, NULL, 3);
+static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO, show_alarm, NULL, 4);
+static SENSOR_DEVICE_ATTR(fan1_alarm, S_IRUGO, show_alarm, NULL, 5);
+static SENSOR_DEVICE_ATTR(fan2_alarm, S_IRUGO, show_alarm, NULL, 6);
+
+static ssize_t show_beep(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	int bitnr = to_sensor_dev_attr(attr)->index;
+	struct gl518_data *data = gl518_update_device(dev);
+	return sprintf(buf, "%u\n", (data->beep_mask >> bitnr) & 1);
+}
+
+static ssize_t set_beep(struct device *dev, struct device_attribute *attr,
+			const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct gl518_data *data = i2c_get_clientdata(client);
+	int bitnr = to_sensor_dev_attr(attr)->index;
+	unsigned long bit;
+
+	bit = simple_strtoul(buf, NULL, 10);
+	if (bit & ~1)
+		return -EINVAL;
+
+	mutex_lock(&data->update_lock);
+	data->beep_mask = gl518_read_value(client, GL518_REG_ALARM);
+	if (bit)
+		data->beep_mask |= (1 << bitnr);
+	else
+		data->beep_mask &= ~(1 << bitnr);
+	gl518_write_value(client, GL518_REG_ALARM, data->beep_mask);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static SENSOR_DEVICE_ATTR(in0_beep, S_IRUGO|S_IWUSR, show_beep, set_beep, 0);
+static SENSOR_DEVICE_ATTR(in1_beep, S_IRUGO|S_IWUSR, show_beep, set_beep, 1);
+static SENSOR_DEVICE_ATTR(in2_beep, S_IRUGO|S_IWUSR, show_beep, set_beep, 2);
+static SENSOR_DEVICE_ATTR(in3_beep, S_IRUGO|S_IWUSR, show_beep, set_beep, 3);
+static SENSOR_DEVICE_ATTR(temp1_beep, S_IRUGO|S_IWUSR, show_beep, set_beep, 4);
+static SENSOR_DEVICE_ATTR(fan1_beep, S_IRUGO|S_IWUSR, show_beep, set_beep, 5);
+static SENSOR_DEVICE_ATTR(fan2_beep, S_IRUGO|S_IWUSR, show_beep, set_beep, 6);
+
 static struct attribute *gl518_attributes[] = {
 	&dev_attr_in3_input.attr,
 	&dev_attr_in0_min.attr,
@@ -355,6 +410,14 @@ static struct attribute *gl518_attribute
 	&dev_attr_in1_max.attr,
 	&dev_attr_in2_max.attr,
 	&dev_attr_in3_max.attr,
+	&sensor_dev_attr_in0_alarm.dev_attr.attr,
+	&sensor_dev_attr_in1_alarm.dev_attr.attr,
+	&sensor_dev_attr_in2_alarm.dev_attr.attr,
+	&sensor_dev_attr_in3_alarm.dev_attr.attr,
+	&sensor_dev_attr_in0_beep.dev_attr.attr,
+	&sensor_dev_attr_in1_beep.dev_attr.attr,
+	&sensor_dev_attr_in2_beep.dev_attr.attr,
+	&sensor_dev_attr_in3_beep.dev_attr.attr,
 
 	&dev_attr_fan1_auto.attr,
 	&sensor_dev_attr_fan1_input.dev_attr.attr,
@@ -363,10 +426,16 @@ static struct attribute *gl518_attribute
 	&sensor_dev_attr_fan2_min.dev_attr.attr,
 	&sensor_dev_attr_fan1_div.dev_attr.attr,
 	&sensor_dev_attr_fan2_div.dev_attr.attr,
+	&sensor_dev_attr_fan1_alarm.dev_attr.attr,
+	&sensor_dev_attr_fan2_alarm.dev_attr.attr,
+	&sensor_dev_attr_fan1_beep.dev_attr.attr,
+	&sensor_dev_attr_fan2_beep.dev_attr.attr,
 
 	&dev_attr_temp1_input.attr,
 	&dev_attr_temp1_max.attr,
 	&dev_attr_temp1_max_hyst.attr,
+	&sensor_dev_attr_temp1_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp1_beep.dev_attr.attr,
 
 	&dev_attr_alarms.attr,
 	&dev_attr_beep_enable.attr,


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
