From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 16 May 2007 18:01:40 +0000
Subject: [lm-sensors] [PATCH 4/4] hwmon/ds1621: Create individual alarm files
Message-Id: <20070516200140.268f6064@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Future versions of libsensors will need this.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Aurelien Jarno <aurelien@aurel32.net>
---
 drivers/hwmon/ds1621.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- linux-2.6.22-rc1.orig/drivers/hwmon/ds1621.c	2007-05-16 19:50:53.000000000 +0200
+++ linux-2.6.22-rc1/drivers/hwmon/ds1621.c	2007-05-16 20:00:38.000000000 +0200
@@ -168,15 +168,29 @@ static ssize_t show_alarms(struct device
 	return sprintf(buf, "%d\n", ALARMS_FROM_REG(data->conf));
 }
 
+static ssize_t show_alarm(struct device *dev, struct device_attribute *da,
+			  char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct ds1621_data *data = ds1621_update_client(dev);
+	return sprintf(buf, "%d\n", !!(data->conf & attr->index));
+}
+
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
 static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);
 static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO, show_temp, set_temp, 1);
 static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp, set_temp, 2);
+static SENSOR_DEVICE_ATTR(temp1_min_alarm, S_IRUGO, show_alarm, NULL,
+		DS1621_ALARM_TEMP_LOW);
+static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_alarm, NULL,
+		DS1621_ALARM_TEMP_HIGH);
 
 static struct attribute *ds1621_attributes[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
 	&sensor_dev_attr_temp1_min.dev_attr.attr,
 	&sensor_dev_attr_temp1_max.dev_attr.attr,
+	&sensor_dev_attr_temp1_min_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
 	&dev_attr_alarms.attr,
 	NULL
 };


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
