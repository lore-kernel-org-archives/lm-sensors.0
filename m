From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 02 Dec 2007 22:42:24 +0000
Subject: [lm-sensors] [PATCH 4/4] hwmon: (adm1031) Add individual alarm and
Message-Id: <20071202234224.07706e95@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The new libsensors needs these.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/adm1031.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

--- linux-2.6.24-rc3.orig/drivers/hwmon/adm1031.c	2007-12-01 15:59:16.000000000 +0100
+++ linux-2.6.24-rc3/drivers/hwmon/adm1031.c	2007-12-01 15:59:19.000000000 +0100
@@ -669,6 +669,29 @@ static ssize_t show_alarms(struct device
 
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
 
+static ssize_t show_alarm(struct device *dev,
+			  struct device_attribute *attr, char *buf)
+{
+	int bitnr = to_sensor_dev_attr(attr)->index;
+	struct adm1031_data *data = adm1031_update_device(dev);
+	return sprintf(buf, "%d\n", (data->alarm >> bitnr) & 1);
+}
+
+static SENSOR_DEVICE_ATTR(fan1_alarm, S_IRUGO, show_alarm, NULL, 0);
+static SENSOR_DEVICE_ATTR(fan1_fault, S_IRUGO, show_alarm, NULL, 1);
+static SENSOR_DEVICE_ATTR(temp2_max_alarm, S_IRUGO, show_alarm, NULL, 2);
+static SENSOR_DEVICE_ATTR(temp2_min_alarm, S_IRUGO, show_alarm, NULL, 3);
+static SENSOR_DEVICE_ATTR(temp2_crit_alarm, S_IRUGO, show_alarm, NULL, 4);
+static SENSOR_DEVICE_ATTR(temp2_fault, S_IRUGO, show_alarm, NULL, 5);
+static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_alarm, NULL, 6);
+static SENSOR_DEVICE_ATTR(temp1_min_alarm, S_IRUGO, show_alarm, NULL, 7);
+static SENSOR_DEVICE_ATTR(fan2_alarm, S_IRUGO, show_alarm, NULL, 8);
+static SENSOR_DEVICE_ATTR(fan2_fault, S_IRUGO, show_alarm, NULL, 9);
+static SENSOR_DEVICE_ATTR(temp3_max_alarm, S_IRUGO, show_alarm, NULL, 10);
+static SENSOR_DEVICE_ATTR(temp3_min_alarm, S_IRUGO, show_alarm, NULL, 11);
+static SENSOR_DEVICE_ATTR(temp3_crit_alarm, S_IRUGO, show_alarm, NULL, 12);
+static SENSOR_DEVICE_ATTR(temp3_fault, S_IRUGO, show_alarm, NULL, 13);
+static SENSOR_DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_alarm, NULL, 14);
 
 static int adm1031_attach_adapter(struct i2c_adapter *adapter)
 {
@@ -681,16 +704,25 @@ static struct attribute *adm1031_attribu
 	&sensor_dev_attr_fan1_input.dev_attr.attr,
 	&sensor_dev_attr_fan1_div.dev_attr.attr,
 	&sensor_dev_attr_fan1_min.dev_attr.attr,
+	&sensor_dev_attr_fan1_alarm.dev_attr.attr,
+	&sensor_dev_attr_fan1_fault.dev_attr.attr,
 	&sensor_dev_attr_pwm1.dev_attr.attr,
 	&sensor_dev_attr_auto_fan1_channel.dev_attr.attr,
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
 	&sensor_dev_attr_temp1_min.dev_attr.attr,
+	&sensor_dev_attr_temp1_min_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp1_max.dev_attr.attr,
+	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp1_crit.dev_attr.attr,
+	&sensor_dev_attr_temp1_crit_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp2_input.dev_attr.attr,
 	&sensor_dev_attr_temp2_min.dev_attr.attr,
+	&sensor_dev_attr_temp2_min_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp2_max.dev_attr.attr,
+	&sensor_dev_attr_temp2_max_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp2_crit.dev_attr.attr,
+	&sensor_dev_attr_temp2_crit_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp2_fault.dev_attr.attr,
 
 	&sensor_dev_attr_auto_temp1_off.dev_attr.attr,
 	&sensor_dev_attr_auto_temp1_min.dev_attr.attr,
@@ -715,12 +747,18 @@ static struct attribute *adm1031_attribu
 	&sensor_dev_attr_fan2_input.dev_attr.attr,
 	&sensor_dev_attr_fan2_div.dev_attr.attr,
 	&sensor_dev_attr_fan2_min.dev_attr.attr,
+	&sensor_dev_attr_fan2_alarm.dev_attr.attr,
+	&sensor_dev_attr_fan2_fault.dev_attr.attr,
 	&sensor_dev_attr_pwm2.dev_attr.attr,
 	&sensor_dev_attr_auto_fan2_channel.dev_attr.attr,
 	&sensor_dev_attr_temp3_input.dev_attr.attr,
 	&sensor_dev_attr_temp3_min.dev_attr.attr,
+	&sensor_dev_attr_temp3_min_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp3_max.dev_attr.attr,
+	&sensor_dev_attr_temp3_max_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp3_crit.dev_attr.attr,
+	&sensor_dev_attr_temp3_crit_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp3_fault.dev_attr.attr,
 	&sensor_dev_attr_auto_temp3_off.dev_attr.attr,
 	&sensor_dev_attr_auto_temp3_min.dev_attr.attr,
 	&sensor_dev_attr_auto_temp3_max.dev_attr.attr,

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
