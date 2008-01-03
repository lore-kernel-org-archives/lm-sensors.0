From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 03 Jan 2008 22:35:33 +0000
Subject: [lm-sensors] [PATCH] hwmon: (lm77) Add individual alarm files
Message-Id: <20080103233533.08ff4c07@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The new libsensors needs this. As the old library never had support for
the lm77 driver, I even dropped the legacy "alarms" file.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
Michael, could you please test and/or review this patch? Either test
the sysfs files directly or use lm-sensors 3.0.0 and the alarms should
be displayed as needed. Thanks.

 drivers/hwmon/lm77.c |   20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

--- linux-2.6.24-rc6.orig/drivers/hwmon/lm77.c	2007-12-31 15:09:18.000000000 +0100
+++ linux-2.6.24-rc6/drivers/hwmon/lm77.c	2007-12-31 15:13:43.000000000 +0100
@@ -31,6 +31,7 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
 
@@ -113,7 +114,6 @@ show(temp_input);
 show(temp_crit);
 show(temp_min);
 show(temp_max);
-show(alarms);
 
 /* read routines for hysteresis values */
 static ssize_t show_temp_crit_hyst(struct device *dev, struct device_attribute *attr, char *buf)
@@ -186,6 +186,14 @@ static ssize_t set_temp_crit(struct devi
 	return count;
 }
 
+static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	int bitnr = to_sensor_dev_attr(attr)->index;
+	struct lm77_data *data = lm77_update_device(dev);
+	return sprintf(buf, "%u\n", (data->alarms >> bitnr) & 1);
+}
+
 static DEVICE_ATTR(temp1_input, S_IRUGO,
 		   show_temp_input, NULL);
 static DEVICE_ATTR(temp1_crit, S_IWUSR | S_IRUGO,
@@ -202,8 +210,9 @@ static DEVICE_ATTR(temp1_min_hyst, S_IRU
 static DEVICE_ATTR(temp1_max_hyst, S_IRUGO,
 		   show_temp_max_hyst, NULL);
 
-static DEVICE_ATTR(alarms, S_IRUGO,
-		   show_alarms, NULL);
+static SENSOR_DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_alarm, NULL, 2);
+static SENSOR_DEVICE_ATTR(temp1_min_alarm, S_IRUGO, show_alarm, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_alarm, NULL, 1);
 
 static int lm77_attach_adapter(struct i2c_adapter *adapter)
 {
@@ -220,8 +229,9 @@ static struct attribute *lm77_attributes
 	&dev_attr_temp1_crit_hyst.attr,
 	&dev_attr_temp1_min_hyst.attr,
 	&dev_attr_temp1_max_hyst.attr,
-	&dev_attr_alarms.attr,
-
+	&sensor_dev_attr_temp1_crit_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp1_min_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
 	NULL
 };
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
