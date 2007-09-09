From: Krzysztof Helt <krzysztof.h1@gmail.com>
Date: Sun, 09 Sep 2007 09:45:12 +0000
Subject: [lm-sensors] [PATCH] adm1021: individual alarm files
Message-Id: <20070909114512.4194600c.krzysztof.h1@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch converts the driver to individual alarm files
as required by the new lmsensors library.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

This patch requires the adm1021 patch which converts
driver to use dynamic sysfs callbacks which I reposted
last week.

--- linux-2.6.22/drivers/hwmon/adm1021.c	2007-09-09 11:39:33.321569276 +0200
+++ linux-2.6.23/drivers/hwmon/adm1021.c	2007-09-09 11:41:58.401836930 +0200
@@ -150,12 +150,12 @@ static ssize_t show_temp_min(struct devi
 	return sprintf(buf, "%d\n", 1000 * data->temp_min[index]);
 }
 
-static ssize_t show_alarms(struct device *dev,
-			   struct device_attribute *attr,
-			   char *buf)
+static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
+			  char *buf)
 {
+	int index = to_sensor_dev_attr(attr)->index;
 	struct adm1021_data *data = adm1021_update_device(dev);
-	return sprintf(buf, "%u\n", data->alarms);
+	return sprintf(buf, "%u\n", (data->alarms >> index) & 1);
 }
 
 static ssize_t set_temp_max(struct device *dev,
@@ -203,7 +203,11 @@ static SENSOR_DEVICE_ATTR(temp2_max, S_I
 			  set_temp_max, 1);
 static SENSOR_DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_temp_min,
 			  set_temp_min, 1);
-static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
+static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_alarm, NULL, 6);
+static SENSOR_DEVICE_ATTR(temp1_min_alarm, S_IRUGO, show_alarm, NULL, 5);
+static SENSOR_DEVICE_ATTR(temp2_max_alarm, S_IRUGO, show_alarm, NULL, 4);
+static SENSOR_DEVICE_ATTR(temp2_min_alarm, S_IRUGO, show_alarm, NULL, 3);
+static SENSOR_DEVICE_ATTR(temp2_input_fault, S_IRUGO, show_alarm, NULL, 2);
 
 static int adm1021_attach_adapter(struct i2c_adapter *adapter)
 {
@@ -219,7 +223,11 @@ static struct attribute *adm1021_attribu
 	&sensor_dev_attr_temp2_max.dev_attr.attr,
 	&sensor_dev_attr_temp2_min.dev_attr.attr,
 	&sensor_dev_attr_temp2_input.dev_attr.attr,
-	&dev_attr_alarms.attr,
+	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp1_min_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp2_max_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp2_min_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp2_input_fault.dev_attr.attr,
 	NULL
 };
 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
