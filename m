From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 05 Jan 2008 14:40:38 +0000
Subject: [lm-sensors] [PATCH 3/3] hwmon: (lm80) Add individual alarm files
Message-Id: <20080105154038.0efa7781@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The new libsensors needs these individual alarm files.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/lm80.c |   31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

--- linux-2.6.24-rc6.orig/drivers/hwmon/lm80.c	2008-01-05 15:22:49.000000000 +0100
+++ linux-2.6.24-rc6/drivers/hwmon/lm80.c	2008-01-05 15:32:39.000000000 +0100
@@ -304,6 +304,14 @@ static ssize_t show_alarms(struct device
 	return sprintf(buf, "%u\n", data->alarms);
 }
 
+static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	int bitnr = to_sensor_dev_attr(attr)->index;
+	struct lm80_data *data = lm80_update_device(dev);
+	return sprintf(buf, "%u\n", (data->alarms >> bitnr) & 1);
+}
+
 static SENSOR_DEVICE_ATTR(in0_min, S_IWUSR | S_IRUGO,
 		show_in_min, set_in_min, 0);
 static SENSOR_DEVICE_ATTR(in1_min, S_IWUSR | S_IRUGO,
@@ -359,6 +367,17 @@ static DEVICE_ATTR(temp1_crit, S_IWUSR |
 static DEVICE_ATTR(temp1_crit_hyst, S_IWUSR | S_IRUGO, show_temp_os_hyst,
     set_temp_os_hyst);
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
+static SENSOR_DEVICE_ATTR(in0_alarm, S_IRUGO, show_alarm, NULL, 0);
+static SENSOR_DEVICE_ATTR(in1_alarm, S_IRUGO, show_alarm, NULL, 1);
+static SENSOR_DEVICE_ATTR(in2_alarm, S_IRUGO, show_alarm, NULL, 2);
+static SENSOR_DEVICE_ATTR(in3_alarm, S_IRUGO, show_alarm, NULL, 3);
+static SENSOR_DEVICE_ATTR(in4_alarm, S_IRUGO, show_alarm, NULL, 4);
+static SENSOR_DEVICE_ATTR(in5_alarm, S_IRUGO, show_alarm, NULL, 5);
+static SENSOR_DEVICE_ATTR(in6_alarm, S_IRUGO, show_alarm, NULL, 6);
+static SENSOR_DEVICE_ATTR(fan1_alarm, S_IRUGO, show_alarm, NULL, 10);
+static SENSOR_DEVICE_ATTR(fan2_alarm, S_IRUGO, show_alarm, NULL, 11);
+static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_alarm, NULL, 8);
+static SENSOR_DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_alarm, NULL, 13);
 
 /*
  * Real code
@@ -405,7 +424,17 @@ static struct attribute *lm80_attributes
 	&dev_attr_temp1_crit.attr,
 	&dev_attr_temp1_crit_hyst.attr,
 	&dev_attr_alarms.attr,
-
+	&sensor_dev_attr_in0_alarm.dev_attr.attr,
+	&sensor_dev_attr_in1_alarm.dev_attr.attr,
+	&sensor_dev_attr_in2_alarm.dev_attr.attr,
+	&sensor_dev_attr_in3_alarm.dev_attr.attr,
+	&sensor_dev_attr_in4_alarm.dev_attr.attr,
+	&sensor_dev_attr_in5_alarm.dev_attr.attr,
+	&sensor_dev_attr_in6_alarm.dev_attr.attr,
+	&sensor_dev_attr_fan1_alarm.dev_attr.attr,
+	&sensor_dev_attr_fan2_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp1_crit_alarm.dev_attr.attr,
 	NULL
 };
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
