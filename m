From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 10 Oct 2007 19:11:52 +0000
Subject: [lm-sensors] [PATCH 2/3] hwmon: (adm1025) Add individual alarm files
Message-Id: <20071010211152.584048eb@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The future libsensors needs these individual alarm and fault files.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/adm1025.c |   30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

--- linux-2.6.23.orig/drivers/hwmon/adm1025.c	2007-10-10 20:33:24.000000000 +0200
+++ linux-2.6.23/drivers/hwmon/adm1025.c	2007-10-10 20:55:30.000000000 +0200
@@ -300,6 +300,23 @@ static ssize_t show_alarms(struct device
 }
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
 
+static ssize_t
+show_alarm(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	int bitnr = to_sensor_dev_attr(attr)->index;
+	struct adm1025_data *data = adm1025_update_device(dev);
+	return sprintf(buf, "%u\n", (data->alarms >> bitnr) & 1);
+}
+static SENSOR_DEVICE_ATTR(in0_alarm, S_IRUGO, show_alarm, NULL, 0);
+static SENSOR_DEVICE_ATTR(in1_alarm, S_IRUGO, show_alarm, NULL, 1);
+static SENSOR_DEVICE_ATTR(in2_alarm, S_IRUGO, show_alarm, NULL, 2);
+static SENSOR_DEVICE_ATTR(in3_alarm, S_IRUGO, show_alarm, NULL, 3);
+static SENSOR_DEVICE_ATTR(in4_alarm, S_IRUGO, show_alarm, NULL, 8);
+static SENSOR_DEVICE_ATTR(in5_alarm, S_IRUGO, show_alarm, NULL, 9);
+static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO, show_alarm, NULL, 5);
+static SENSOR_DEVICE_ATTR(temp2_alarm, S_IRUGO, show_alarm, NULL, 4);
+static SENSOR_DEVICE_ATTR(temp1_fault, S_IRUGO, show_alarm, NULL, 14);
+
 static ssize_t show_vid(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct adm1025_data *data = adm1025_update_device(dev);
@@ -348,12 +365,20 @@ static struct attribute *adm1025_attribu
 	&sensor_dev_attr_in2_max.dev_attr.attr,
 	&sensor_dev_attr_in3_max.dev_attr.attr,
 	&sensor_dev_attr_in5_max.dev_attr.attr,
+	&sensor_dev_attr_in0_alarm.dev_attr.attr,
+	&sensor_dev_attr_in1_alarm.dev_attr.attr,
+	&sensor_dev_attr_in2_alarm.dev_attr.attr,
+	&sensor_dev_attr_in3_alarm.dev_attr.attr,
+	&sensor_dev_attr_in5_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
 	&sensor_dev_attr_temp2_input.dev_attr.attr,
 	&sensor_dev_attr_temp1_min.dev_attr.attr,
 	&sensor_dev_attr_temp2_min.dev_attr.attr,
 	&sensor_dev_attr_temp1_max.dev_attr.attr,
 	&sensor_dev_attr_temp2_max.dev_attr.attr,
+	&sensor_dev_attr_temp1_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp2_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp1_fault.dev_attr.attr,
 	&dev_attr_alarms.attr,
 	&dev_attr_cpu0_vid.attr,
 	&dev_attr_vrm.attr,
@@ -368,6 +393,7 @@ static struct attribute *adm1025_attribu
 	&sensor_dev_attr_in4_input.dev_attr.attr,
 	&sensor_dev_attr_in4_min.dev_attr.attr,
 	&sensor_dev_attr_in4_max.dev_attr.attr,
+	&sensor_dev_attr_in4_alarm.dev_attr.attr,
 	NULL
 };
 
@@ -485,7 +511,9 @@ static int adm1025_detect(struct i2c_ada
 		 || (err = device_create_file(&new_client->dev,
 					&sensor_dev_attr_in4_min.dev_attr))
 		 || (err = device_create_file(&new_client->dev,
-					&sensor_dev_attr_in4_max.dev_attr)))
+					&sensor_dev_attr_in4_max.dev_attr))
+		 || (err = device_create_file(&new_client->dev,
+					&sensor_dev_attr_in4_alarm.dev_attr)))
 			goto exit_remove;
 	}
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
