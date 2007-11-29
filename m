From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 29 Nov 2007 22:45:22 +0000
Subject: [lm-sensors] [PATCH 1/4] hwmon: (adm1026) Add individual alarm files
Message-Id: <20071129234522.754a76d1@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The new libsensors needs these.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/adm1026.c |   65 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

--- linux-2.6.24-rc3.orig/drivers/hwmon/adm1026.c	2007-10-24 09:59:28.000000000 +0200
+++ linux-2.6.24-rc3/drivers/hwmon/adm1026.c	2007-11-29 21:29:01.000000000 +0100
@@ -1244,6 +1244,43 @@ static ssize_t show_alarms_reg(struct de
 
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms_reg, NULL);
 
+static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	struct adm1026_data *data = adm1026_update_device(dev);
+	int bitnr = to_sensor_dev_attr(attr)->index;
+	return sprintf(buf, "%ld\n", (data->alarms >> bitnr) & 1);
+}
+
+static SENSOR_DEVICE_ATTR(temp2_alarm, S_IRUGO, show_alarm, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp3_alarm, S_IRUGO, show_alarm, NULL, 1);
+static SENSOR_DEVICE_ATTR(in9_alarm, S_IRUGO, show_alarm, NULL, 1);
+static SENSOR_DEVICE_ATTR(in11_alarm, S_IRUGO, show_alarm, NULL, 2);
+static SENSOR_DEVICE_ATTR(in12_alarm, S_IRUGO, show_alarm, NULL, 3);
+static SENSOR_DEVICE_ATTR(in13_alarm, S_IRUGO, show_alarm, NULL, 4);
+static SENSOR_DEVICE_ATTR(in14_alarm, S_IRUGO, show_alarm, NULL, 5);
+static SENSOR_DEVICE_ATTR(in15_alarm, S_IRUGO, show_alarm, NULL, 6);
+static SENSOR_DEVICE_ATTR(in16_alarm, S_IRUGO, show_alarm, NULL, 7);
+static SENSOR_DEVICE_ATTR(in0_alarm, S_IRUGO, show_alarm, NULL, 8);
+static SENSOR_DEVICE_ATTR(in1_alarm, S_IRUGO, show_alarm, NULL, 9);
+static SENSOR_DEVICE_ATTR(in2_alarm, S_IRUGO, show_alarm, NULL, 10);
+static SENSOR_DEVICE_ATTR(in3_alarm, S_IRUGO, show_alarm, NULL, 11);
+static SENSOR_DEVICE_ATTR(in4_alarm, S_IRUGO, show_alarm, NULL, 12);
+static SENSOR_DEVICE_ATTR(in5_alarm, S_IRUGO, show_alarm, NULL, 13);
+static SENSOR_DEVICE_ATTR(in6_alarm, S_IRUGO, show_alarm, NULL, 14);
+static SENSOR_DEVICE_ATTR(in7_alarm, S_IRUGO, show_alarm, NULL, 15);
+static SENSOR_DEVICE_ATTR(fan1_alarm, S_IRUGO, show_alarm, NULL, 16);
+static SENSOR_DEVICE_ATTR(fan2_alarm, S_IRUGO, show_alarm, NULL, 17);
+static SENSOR_DEVICE_ATTR(fan3_alarm, S_IRUGO, show_alarm, NULL, 18);
+static SENSOR_DEVICE_ATTR(fan4_alarm, S_IRUGO, show_alarm, NULL, 19);
+static SENSOR_DEVICE_ATTR(fan5_alarm, S_IRUGO, show_alarm, NULL, 20);
+static SENSOR_DEVICE_ATTR(fan6_alarm, S_IRUGO, show_alarm, NULL, 21);
+static SENSOR_DEVICE_ATTR(fan7_alarm, S_IRUGO, show_alarm, NULL, 22);
+static SENSOR_DEVICE_ATTR(fan8_alarm, S_IRUGO, show_alarm, NULL, 23);
+static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO, show_alarm, NULL, 24);
+static SENSOR_DEVICE_ATTR(in10_alarm, S_IRUGO, show_alarm, NULL, 25);
+static SENSOR_DEVICE_ATTR(in8_alarm, S_IRUGO, show_alarm, NULL, 26);
+
 static ssize_t show_alarm_mask(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct adm1026_data *data = adm1026_update_device(dev);
@@ -1444,87 +1481,115 @@ static struct attribute *adm1026_attribu
 	&sensor_dev_attr_in0_input.dev_attr.attr,
 	&sensor_dev_attr_in0_max.dev_attr.attr,
 	&sensor_dev_attr_in0_min.dev_attr.attr,
+	&sensor_dev_attr_in0_alarm.dev_attr.attr,
 	&sensor_dev_attr_in1_input.dev_attr.attr,
 	&sensor_dev_attr_in1_max.dev_attr.attr,
 	&sensor_dev_attr_in1_min.dev_attr.attr,
+	&sensor_dev_attr_in1_alarm.dev_attr.attr,
 	&sensor_dev_attr_in2_input.dev_attr.attr,
 	&sensor_dev_attr_in2_max.dev_attr.attr,
 	&sensor_dev_attr_in2_min.dev_attr.attr,
+	&sensor_dev_attr_in2_alarm.dev_attr.attr,
 	&sensor_dev_attr_in3_input.dev_attr.attr,
 	&sensor_dev_attr_in3_max.dev_attr.attr,
 	&sensor_dev_attr_in3_min.dev_attr.attr,
+	&sensor_dev_attr_in3_alarm.dev_attr.attr,
 	&sensor_dev_attr_in4_input.dev_attr.attr,
 	&sensor_dev_attr_in4_max.dev_attr.attr,
 	&sensor_dev_attr_in4_min.dev_attr.attr,
+	&sensor_dev_attr_in4_alarm.dev_attr.attr,
 	&sensor_dev_attr_in5_input.dev_attr.attr,
 	&sensor_dev_attr_in5_max.dev_attr.attr,
 	&sensor_dev_attr_in5_min.dev_attr.attr,
+	&sensor_dev_attr_in5_alarm.dev_attr.attr,
 	&sensor_dev_attr_in6_input.dev_attr.attr,
 	&sensor_dev_attr_in6_max.dev_attr.attr,
 	&sensor_dev_attr_in6_min.dev_attr.attr,
+	&sensor_dev_attr_in6_alarm.dev_attr.attr,
 	&sensor_dev_attr_in7_input.dev_attr.attr,
 	&sensor_dev_attr_in7_max.dev_attr.attr,
 	&sensor_dev_attr_in7_min.dev_attr.attr,
+	&sensor_dev_attr_in7_alarm.dev_attr.attr,
 	&sensor_dev_attr_in8_input.dev_attr.attr,
 	&sensor_dev_attr_in8_max.dev_attr.attr,
 	&sensor_dev_attr_in8_min.dev_attr.attr,
+	&sensor_dev_attr_in8_alarm.dev_attr.attr,
 	&sensor_dev_attr_in9_input.dev_attr.attr,
 	&sensor_dev_attr_in9_max.dev_attr.attr,
 	&sensor_dev_attr_in9_min.dev_attr.attr,
+	&sensor_dev_attr_in9_alarm.dev_attr.attr,
 	&sensor_dev_attr_in10_input.dev_attr.attr,
 	&sensor_dev_attr_in10_max.dev_attr.attr,
 	&sensor_dev_attr_in10_min.dev_attr.attr,
+	&sensor_dev_attr_in10_alarm.dev_attr.attr,
 	&sensor_dev_attr_in11_input.dev_attr.attr,
 	&sensor_dev_attr_in11_max.dev_attr.attr,
 	&sensor_dev_attr_in11_min.dev_attr.attr,
+	&sensor_dev_attr_in11_alarm.dev_attr.attr,
 	&sensor_dev_attr_in12_input.dev_attr.attr,
 	&sensor_dev_attr_in12_max.dev_attr.attr,
 	&sensor_dev_attr_in12_min.dev_attr.attr,
+	&sensor_dev_attr_in12_alarm.dev_attr.attr,
 	&sensor_dev_attr_in13_input.dev_attr.attr,
 	&sensor_dev_attr_in13_max.dev_attr.attr,
 	&sensor_dev_attr_in13_min.dev_attr.attr,
+	&sensor_dev_attr_in13_alarm.dev_attr.attr,
 	&sensor_dev_attr_in14_input.dev_attr.attr,
 	&sensor_dev_attr_in14_max.dev_attr.attr,
 	&sensor_dev_attr_in14_min.dev_attr.attr,
+	&sensor_dev_attr_in14_alarm.dev_attr.attr,
 	&sensor_dev_attr_in15_input.dev_attr.attr,
 	&sensor_dev_attr_in15_max.dev_attr.attr,
 	&sensor_dev_attr_in15_min.dev_attr.attr,
+	&sensor_dev_attr_in15_alarm.dev_attr.attr,
 	&sensor_dev_attr_in16_input.dev_attr.attr,
 	&sensor_dev_attr_in16_max.dev_attr.attr,
 	&sensor_dev_attr_in16_min.dev_attr.attr,
+	&sensor_dev_attr_in16_alarm.dev_attr.attr,
 	&sensor_dev_attr_fan1_input.dev_attr.attr,
 	&sensor_dev_attr_fan1_div.dev_attr.attr,
 	&sensor_dev_attr_fan1_min.dev_attr.attr,
+	&sensor_dev_attr_fan1_alarm.dev_attr.attr,
 	&sensor_dev_attr_fan2_input.dev_attr.attr,
 	&sensor_dev_attr_fan2_div.dev_attr.attr,
 	&sensor_dev_attr_fan2_min.dev_attr.attr,
+	&sensor_dev_attr_fan2_alarm.dev_attr.attr,
 	&sensor_dev_attr_fan3_input.dev_attr.attr,
 	&sensor_dev_attr_fan3_div.dev_attr.attr,
 	&sensor_dev_attr_fan3_min.dev_attr.attr,
+	&sensor_dev_attr_fan3_alarm.dev_attr.attr,
 	&sensor_dev_attr_fan4_input.dev_attr.attr,
 	&sensor_dev_attr_fan4_div.dev_attr.attr,
 	&sensor_dev_attr_fan4_min.dev_attr.attr,
+	&sensor_dev_attr_fan4_alarm.dev_attr.attr,
 	&sensor_dev_attr_fan5_input.dev_attr.attr,
 	&sensor_dev_attr_fan5_div.dev_attr.attr,
 	&sensor_dev_attr_fan5_min.dev_attr.attr,
+	&sensor_dev_attr_fan5_alarm.dev_attr.attr,
 	&sensor_dev_attr_fan6_input.dev_attr.attr,
 	&sensor_dev_attr_fan6_div.dev_attr.attr,
 	&sensor_dev_attr_fan6_min.dev_attr.attr,
+	&sensor_dev_attr_fan6_alarm.dev_attr.attr,
 	&sensor_dev_attr_fan7_input.dev_attr.attr,
 	&sensor_dev_attr_fan7_div.dev_attr.attr,
 	&sensor_dev_attr_fan7_min.dev_attr.attr,
+	&sensor_dev_attr_fan7_alarm.dev_attr.attr,
 	&sensor_dev_attr_fan8_input.dev_attr.attr,
 	&sensor_dev_attr_fan8_div.dev_attr.attr,
 	&sensor_dev_attr_fan8_min.dev_attr.attr,
+	&sensor_dev_attr_fan8_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
 	&sensor_dev_attr_temp1_max.dev_attr.attr,
 	&sensor_dev_attr_temp1_min.dev_attr.attr,
+	&sensor_dev_attr_temp1_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp2_input.dev_attr.attr,
 	&sensor_dev_attr_temp2_max.dev_attr.attr,
 	&sensor_dev_attr_temp2_min.dev_attr.attr,
+	&sensor_dev_attr_temp2_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp3_input.dev_attr.attr,
 	&sensor_dev_attr_temp3_max.dev_attr.attr,
 	&sensor_dev_attr_temp3_min.dev_attr.attr,
+	&sensor_dev_attr_temp3_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp1_offset.dev_attr.attr,
 	&sensor_dev_attr_temp2_offset.dev_attr.attr,
 	&sensor_dev_attr_temp3_offset.dev_attr.attr,


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
