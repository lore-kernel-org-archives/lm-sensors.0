From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 13 Jul 2011 19:25:07 +0000
Subject: [lm-sensors] [PATCH] hwmon: (it87) Add chassis intrusion detection
Message-Id: <20110713212507.42269295@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add chassis intrusion detection support for all supported devices,
using the standard interface.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
This needs testing! The only report I have so far, says that reporting
works OK but clearing the intrusion alarm does not. That case is still
under investigation, as my code follows the datasheet as far as I can
see, so I have no idea why it wouldn't work.

 it87.c |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

--- it87.orig/drivers/hwmon/it87.c	2011-07-11 16:09:21.000000000 +0200
+++ it87/drivers/hwmon/it87.c	2011-07-13 21:10:53.000000000 +0200
@@ -1172,6 +1172,32 @@ static ssize_t show_alarm(struct device
 	struct it87_data *data = it87_update_device(dev);
 	return sprintf(buf, "%u\n", (data->alarms >> bitnr) & 1);
 }
+
+static ssize_t clear_intrusion(struct device *dev, struct device_attribute
+		*attr, const char *buf, size_t count)
+{
+	struct it87_data *data = dev_get_drvdata(dev);
+	long val;
+	int config;
+
+	if (strict_strtol(buf, 10, &val) < 0 || val != 0)
+		return -EINVAL;
+
+	mutex_lock(&data->update_lock);
+	config = it87_read_value(data, IT87_REG_CONFIG);
+	if (config < 0)
+		count = config;
+	else {
+		config |= 1 << 5;
+		it87_write_value(data, IT87_REG_CONFIG, config);
+		/* Invalidate cache to force re-read */
+		data->valid = 0;
+	}
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
 static SENSOR_DEVICE_ATTR(in0_alarm, S_IRUGO, show_alarm, NULL, 8);
 static SENSOR_DEVICE_ATTR(in1_alarm, S_IRUGO, show_alarm, NULL, 9);
 static SENSOR_DEVICE_ATTR(in2_alarm, S_IRUGO, show_alarm, NULL, 10);
@@ -1188,6 +1214,8 @@ static SENSOR_DEVICE_ATTR(fan5_alarm, S_
 static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO, show_alarm, NULL, 16);
 static SENSOR_DEVICE_ATTR(temp2_alarm, S_IRUGO, show_alarm, NULL, 17);
 static SENSOR_DEVICE_ATTR(temp3_alarm, S_IRUGO, show_alarm, NULL, 18);
+static SENSOR_DEVICE_ATTR(intrusion0_alarm, S_IRUGO | S_IWUSR,
+			  show_alarm, clear_intrusion, 4);
 
 static ssize_t show_beep(struct device *dev, struct device_attribute *attr,
 		char *buf)
@@ -1350,6 +1378,7 @@ static struct attribute *it87_attributes
 	&sensor_dev_attr_temp3_alarm.dev_attr.attr,
 
 	&dev_attr_alarms.attr,
+	&sensor_dev_attr_intrusion0_alarm.dev_attr.attr,
 	&dev_attr_name.attr,
 	NULL
 };


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
