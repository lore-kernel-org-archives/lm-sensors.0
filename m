From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 13 Jul 2007 16:45:54 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/w83792d: Add individual alarm files
Message-Id: <20070713184554.22090f2f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Gong Jun,

On Fri, 13 Jul 2007 17:27:47 +0800, JGong@winbond.com wrote:
> w83792d: add individual alarm files for the new libsensors.
> 
> I have tested it on my w83792d motherboard, please apply.
> 
> Signed-off-by: Gong Jun <jgong@winbond.com>

Looks good. I simply fixed the patch header and the indentation (spaces
were used instead of tabs in various places).

From: Gong Jun <jgong@winbond.com>

w83792d: add individual alarm files for the new libsensors.

Signed-off-by: Gong Jun <jgong@winbond.com>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83792d.c |   49 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

--- linux-2.6.23-pre.orig/drivers/hwmon/w83792d.c	2007-02-04 19:44:54.000000000 +0100
+++ linux-2.6.23-pre/drivers/hwmon/w83792d.c	2007-07-13 18:37:04.000000000 +0200
@@ -540,6 +540,15 @@ show_alarms_reg(struct device *dev, stru
 	return sprintf(buf, "%d\n", data->alarms);
 }
 
+static ssize_t show_alarm(struct device *dev,
+			  struct device_attribute *attr, char *buf)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+	struct w83792d_data *data = w83792d_update_device(dev);
+	return sprintf(buf, "%d\n", (data->alarms >> nr) & 1);
+}
+
 static ssize_t
 show_pwm(struct device *dev, struct device_attribute *attr,
 		char *buf)
@@ -1015,6 +1024,25 @@ static SENSOR_DEVICE_ATTR_2(temp2_max_hy
 static SENSOR_DEVICE_ATTR_2(temp3_max_hyst, S_IRUGO | S_IWUSR,
 			show_temp23, store_temp23, 1, 4);
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms_reg, NULL);
+static SENSOR_DEVICE_ATTR(in0_alarm, S_IRUGO, show_alarm, NULL, 0);
+static SENSOR_DEVICE_ATTR(in1_alarm, S_IRUGO, show_alarm, NULL, 1);
+static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO, show_alarm, NULL, 2);
+static SENSOR_DEVICE_ATTR(temp2_alarm, S_IRUGO, show_alarm, NULL, 3);
+static SENSOR_DEVICE_ATTR(temp3_alarm, S_IRUGO, show_alarm, NULL, 4);
+static SENSOR_DEVICE_ATTR(fan1_alarm, S_IRUGO, show_alarm, NULL, 5);
+static SENSOR_DEVICE_ATTR(fan2_alarm, S_IRUGO, show_alarm, NULL, 6);
+static SENSOR_DEVICE_ATTR(fan3_alarm, S_IRUGO, show_alarm, NULL, 7);
+static SENSOR_DEVICE_ATTR(in2_alarm, S_IRUGO, show_alarm, NULL, 8);
+static SENSOR_DEVICE_ATTR(in3_alarm, S_IRUGO, show_alarm, NULL, 9);
+static SENSOR_DEVICE_ATTR(in4_alarm, S_IRUGO, show_alarm, NULL, 10);
+static SENSOR_DEVICE_ATTR(in5_alarm, S_IRUGO, show_alarm, NULL, 11);
+static SENSOR_DEVICE_ATTR(in6_alarm, S_IRUGO, show_alarm, NULL, 12);
+static SENSOR_DEVICE_ATTR(fan7_alarm, S_IRUGO, show_alarm, NULL, 15);
+static SENSOR_DEVICE_ATTR(in7_alarm, S_IRUGO, show_alarm, NULL, 19);
+static SENSOR_DEVICE_ATTR(in8_alarm, S_IRUGO, show_alarm, NULL, 20);
+static SENSOR_DEVICE_ATTR(fan4_alarm, S_IRUGO, show_alarm, NULL, 21);
+static SENSOR_DEVICE_ATTR(fan5_alarm, S_IRUGO, show_alarm, NULL, 22);
+static SENSOR_DEVICE_ATTR(fan6_alarm, S_IRUGO, show_alarm, NULL, 23);
 static DEVICE_ATTR(chassis, S_IRUGO, show_regs_chassis, NULL);
 static DEVICE_ATTR(chassis_clear, S_IRUGO | S_IWUSR,
 			show_chassis_clear, store_chassis_clear);
@@ -1123,26 +1151,30 @@ static SENSOR_DEVICE_ATTR(fan6_div, S_IW
 static SENSOR_DEVICE_ATTR(fan7_div, S_IWUSR | S_IRUGO,
 			show_fan_div, store_fan_div, 7);
 
-static struct attribute *w83792d_attributes_fan[4][4] = {
+static struct attribute *w83792d_attributes_fan[4][5] = {
 	{
 		&sensor_dev_attr_fan4_input.dev_attr.attr,
 		&sensor_dev_attr_fan4_min.dev_attr.attr,
 		&sensor_dev_attr_fan4_div.dev_attr.attr,
+		&sensor_dev_attr_fan4_alarm.dev_attr.attr,
 		NULL
 	}, {
 		&sensor_dev_attr_fan5_input.dev_attr.attr,
 		&sensor_dev_attr_fan5_min.dev_attr.attr,
 		&sensor_dev_attr_fan5_div.dev_attr.attr,
+		&sensor_dev_attr_fan5_alarm.dev_attr.attr,
 		NULL
 	}, {
 		&sensor_dev_attr_fan6_input.dev_attr.attr,
 		&sensor_dev_attr_fan6_min.dev_attr.attr,
 		&sensor_dev_attr_fan6_div.dev_attr.attr,
+		&sensor_dev_attr_fan6_alarm.dev_attr.attr,
 		NULL
 	}, {
 		&sensor_dev_attr_fan7_input.dev_attr.attr,
 		&sensor_dev_attr_fan7_min.dev_attr.attr,
 		&sensor_dev_attr_fan7_div.dev_attr.attr,
+		&sensor_dev_attr_fan7_alarm.dev_attr.attr,
 		NULL
 	}
 };
@@ -1182,6 +1214,15 @@ static struct attribute *w83792d_attribu
 	&sensor_dev_attr_in8_input.dev_attr.attr,
 	&sensor_dev_attr_in8_max.dev_attr.attr,
 	&sensor_dev_attr_in8_min.dev_attr.attr,
+	&sensor_dev_attr_in0_alarm.dev_attr.attr,
+	&sensor_dev_attr_in1_alarm.dev_attr.attr,
+	&sensor_dev_attr_in2_alarm.dev_attr.attr,
+	&sensor_dev_attr_in3_alarm.dev_attr.attr,
+	&sensor_dev_attr_in4_alarm.dev_attr.attr,
+	&sensor_dev_attr_in5_alarm.dev_attr.attr,
+	&sensor_dev_attr_in6_alarm.dev_attr.attr,
+	&sensor_dev_attr_in7_alarm.dev_attr.attr,
+	&sensor_dev_attr_in8_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
 	&sensor_dev_attr_temp1_max.dev_attr.attr,
 	&sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
@@ -1191,6 +1232,9 @@ static struct attribute *w83792d_attribu
 	&sensor_dev_attr_temp3_input.dev_attr.attr,
 	&sensor_dev_attr_temp3_max.dev_attr.attr,
 	&sensor_dev_attr_temp3_max_hyst.dev_attr.attr,
+	&sensor_dev_attr_temp1_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp2_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp3_alarm.dev_attr.attr,
 	&sensor_dev_attr_pwm1.dev_attr.attr,
 	&sensor_dev_attr_pwm1_mode.dev_attr.attr,
 	&sensor_dev_attr_pwm1_enable.dev_attr.attr,
@@ -1233,12 +1277,15 @@ static struct attribute *w83792d_attribu
 	&sensor_dev_attr_fan1_input.dev_attr.attr,
 	&sensor_dev_attr_fan1_min.dev_attr.attr,
 	&sensor_dev_attr_fan1_div.dev_attr.attr,
+	&sensor_dev_attr_fan1_alarm.dev_attr.attr,
 	&sensor_dev_attr_fan2_input.dev_attr.attr,
 	&sensor_dev_attr_fan2_min.dev_attr.attr,
 	&sensor_dev_attr_fan2_div.dev_attr.attr,
+	&sensor_dev_attr_fan2_alarm.dev_attr.attr,
 	&sensor_dev_attr_fan3_input.dev_attr.attr,
 	&sensor_dev_attr_fan3_min.dev_attr.attr,
 	&sensor_dev_attr_fan3_div.dev_attr.attr,
+	&sensor_dev_attr_fan3_alarm.dev_attr.attr,
 	NULL
 };
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
