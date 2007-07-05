From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 05 Jul 2007 18:37:58 +0000
Subject: [lm-sensors] [PATCH 3/5] hwmon/lm85: Add individual alarm files
Message-Id: <20070705203758.6cc09521@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The future libsensors needs these individual alarm and fault files.

Also delete old and unused alarm defines.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/lm85.c |   60 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 43 insertions(+), 17 deletions(-)

--- linux-2.6.22-rc6.orig/drivers/hwmon/lm85.c	2007-07-01 13:40:58.000000000 +0200
+++ linux-2.6.22-rc6/drivers/hwmon/lm85.c	2007-07-01 13:50:32.000000000 +0200
@@ -123,23 +123,6 @@ I2C_CLIENT_INSMOD_6(lm85b, lm85c, adm102
 #define	EMC6D102_REG_EXTEND_ADC3	0x87
 #define	EMC6D102_REG_EXTEND_ADC4	0x88
 
-#define	LM85_ALARM_IN0			0x0001
-#define	LM85_ALARM_IN1			0x0002
-#define	LM85_ALARM_IN2			0x0004
-#define	LM85_ALARM_IN3			0x0008
-#define	LM85_ALARM_TEMP1		0x0010
-#define	LM85_ALARM_TEMP2		0x0020
-#define	LM85_ALARM_TEMP3		0x0040
-#define	LM85_ALARM_ALARM2		0x0080
-#define	LM85_ALARM_IN4			0x0100
-#define	LM85_ALARM_RESERVED		0x0200
-#define	LM85_ALARM_FAN1			0x0400
-#define	LM85_ALARM_FAN2			0x0800
-#define	LM85_ALARM_FAN3			0x1000
-#define	LM85_ALARM_FAN4			0x2000
-#define	LM85_ALARM_TEMP1_FAULT		0x4000
-#define	LM85_ALARM_TEMP3_FAULT		0x8000
-
 
 /* Conversions. Rounding and limit checking is only done on the TO_REG 
    variants. Note that you should be a bit careful with which arguments
@@ -477,6 +460,32 @@ static ssize_t show_alarms_reg(struct de
 
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms_reg, NULL);
 
+static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	int nr = to_sensor_dev_attr(attr)->index;
+	struct lm85_data *data = lm85_update_device(dev);
+	return sprintf(buf, "%u\n", (data->alarms >> nr) & 1);
+}
+
+static SENSOR_DEVICE_ATTR(in0_alarm, S_IRUGO, show_alarm, NULL, 0);
+static SENSOR_DEVICE_ATTR(in1_alarm, S_IRUGO, show_alarm, NULL, 1);
+static SENSOR_DEVICE_ATTR(in2_alarm, S_IRUGO, show_alarm, NULL, 2);
+static SENSOR_DEVICE_ATTR(in3_alarm, S_IRUGO, show_alarm, NULL, 3);
+static SENSOR_DEVICE_ATTR(in4_alarm, S_IRUGO, show_alarm, NULL, 8);
+static SENSOR_DEVICE_ATTR(in5_alarm, S_IRUGO, show_alarm, NULL, 18);
+static SENSOR_DEVICE_ATTR(in6_alarm, S_IRUGO, show_alarm, NULL, 16);
+static SENSOR_DEVICE_ATTR(in7_alarm, S_IRUGO, show_alarm, NULL, 17);
+static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO, show_alarm, NULL, 4);
+static SENSOR_DEVICE_ATTR(temp1_fault, S_IRUGO, show_alarm, NULL, 14);
+static SENSOR_DEVICE_ATTR(temp2_alarm, S_IRUGO, show_alarm, NULL, 5);
+static SENSOR_DEVICE_ATTR(temp3_alarm, S_IRUGO, show_alarm, NULL, 6);
+static SENSOR_DEVICE_ATTR(temp3_fault, S_IRUGO, show_alarm, NULL, 15);
+static SENSOR_DEVICE_ATTR(fan1_alarm, S_IRUGO, show_alarm, NULL, 10);
+static SENSOR_DEVICE_ATTR(fan2_alarm, S_IRUGO, show_alarm, NULL, 11);
+static SENSOR_DEVICE_ATTR(fan3_alarm, S_IRUGO, show_alarm, NULL, 12);
+static SENSOR_DEVICE_ATTR(fan4_alarm, S_IRUGO, show_alarm, NULL, 13);
+
 /* pwm */
 
 static ssize_t show_pwm(struct device *dev, struct device_attribute *attr,
@@ -966,6 +975,10 @@ static struct attribute *lm85_attributes
 	&sensor_dev_attr_fan2_min.dev_attr.attr,
 	&sensor_dev_attr_fan3_min.dev_attr.attr,
 	&sensor_dev_attr_fan4_min.dev_attr.attr,
+	&sensor_dev_attr_fan1_alarm.dev_attr.attr,
+	&sensor_dev_attr_fan2_alarm.dev_attr.attr,
+	&sensor_dev_attr_fan3_alarm.dev_attr.attr,
+	&sensor_dev_attr_fan4_alarm.dev_attr.attr,
 
 	&sensor_dev_attr_pwm1.dev_attr.attr,
 	&sensor_dev_attr_pwm2.dev_attr.attr,
@@ -986,6 +999,10 @@ static struct attribute *lm85_attributes
 	&sensor_dev_attr_in1_max.dev_attr.attr,
 	&sensor_dev_attr_in2_max.dev_attr.attr,
 	&sensor_dev_attr_in3_max.dev_attr.attr,
+	&sensor_dev_attr_in0_alarm.dev_attr.attr,
+	&sensor_dev_attr_in1_alarm.dev_attr.attr,
+	&sensor_dev_attr_in2_alarm.dev_attr.attr,
+	&sensor_dev_attr_in3_alarm.dev_attr.attr,
 
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
 	&sensor_dev_attr_temp2_input.dev_attr.attr,
@@ -996,6 +1013,11 @@ static struct attribute *lm85_attributes
 	&sensor_dev_attr_temp1_max.dev_attr.attr,
 	&sensor_dev_attr_temp2_max.dev_attr.attr,
 	&sensor_dev_attr_temp3_max.dev_attr.attr,
+	&sensor_dev_attr_temp1_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp2_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp3_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp1_fault.dev_attr.attr,
+	&sensor_dev_attr_temp3_fault.dev_attr.attr,
 
 	&sensor_dev_attr_pwm1_auto_channels.dev_attr.attr,
 	&sensor_dev_attr_pwm2_auto_channels.dev_attr.attr,
@@ -1037,6 +1059,7 @@ static struct attribute *lm85_attributes
 	&sensor_dev_attr_in4_input.dev_attr.attr,
 	&sensor_dev_attr_in4_min.dev_attr.attr,
 	&sensor_dev_attr_in4_max.dev_attr.attr,
+	&sensor_dev_attr_in4_alarm.dev_attr.attr,
 	NULL
 };
 
@@ -1054,6 +1077,9 @@ static struct attribute *lm85_attributes
 	&sensor_dev_attr_in5_max.dev_attr.attr,
 	&sensor_dev_attr_in6_max.dev_attr.attr,
 	&sensor_dev_attr_in7_max.dev_attr.attr,
+	&sensor_dev_attr_in5_alarm.dev_attr.attr,
+	&sensor_dev_attr_in6_alarm.dev_attr.attr,
+	&sensor_dev_attr_in7_alarm.dev_attr.attr,
 	NULL
 };
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
