From: Jim Cromie <jim.cromie@gmail.com>
Date: Thu, 11 Sep 2008 04:47:07 +0000
Subject: [lm-sensors] [ patch 2.6.27-rc6 6/6 v2] separate alarm sysfs files
Message-Id: <48C8A2CB.6000000@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------060702030505070800020108"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------060702030505070800020108
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

 From 7b4b599eef53f06825dbd2337714f028a0516069 Mon Sep 17 00:00:00 2001
From: Jim Cromie <jim.cromie@gmail.com>
Date: Sat, 28 Jun 2008 13:19:07 -0600
Subject: [PATCH] hwmon/pc87360 separate alarm files - add 
therm-min/max/crit-alarms

Adds therm-min/max/crit-alarm callbacks, sensor-device-attribute
declarations, and refs to those new decls in the macro used to
initialize the therm_group (of sysfs files).  This spin includes
style fixes per feedback.

The thermistors use voltage channels to measure; so they don't
have a fault-alarm, but unlike the other voltages, they do have an
overtemp, which we call crit (by convention).

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/hwmon/pc87360.c |   61 
++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 60 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/pc87360.c b/drivers/hwmon/pc87360.c
index acff04f..e49692b 100644
--- a/drivers/hwmon/pc87360.c
+++ b/drivers/hwmon/pc87360.c
@@ -715,12 +715,71 @@ static struct sensor_device_attribute therm_crit[] = {
             show_therm_crit, set_therm_crit, 2+11),
 };
 
+/* show_therm_min/max_alarm() reads data from the per-channel voltage
+   status register (sec 11.5.12) */
+
+static ssize_t
+show_therm_min_alarm(struct device *dev, struct device_attribute *devattr,
+             char *buf)
+{
+    struct pc87360_data *data = pc87360_update_device(dev);
+    unsigned nr = to_sensor_dev_attr(devattr)->index;
+
+    return sprintf(buf, "%u\n", !!(data->in_status[nr] & CHAN_ALM_MIN));
+}
+static ssize_t
+show_therm_max_alarm(struct device *dev, struct device_attribute *devattr,
+             char *buf)
+{
+    struct pc87360_data *data = pc87360_update_device(dev);
+    unsigned nr = to_sensor_dev_attr(devattr)->index;
+
+    return sprintf(buf, "%u\n", !!(data->in_status[nr] & CHAN_ALM_MAX));
+}
+static ssize_t
+show_therm_crit_alarm(struct device *dev, struct device_attribute *devattr,
+              char *buf)
+{
+    struct pc87360_data *data = pc87360_update_device(dev);
+    unsigned nr = to_sensor_dev_attr(devattr)->index;
+
+    return sprintf(buf, "%u\n", !!(data->in_status[nr] & TEMP_ALM_CRIT));
+}
+
+static struct sensor_device_attribute therm_min_alarm[] = {
+    SENSOR_ATTR(temp4_min_alarm, S_IRUGO,
+            show_therm_min_alarm, NULL, 0+11),
+    SENSOR_ATTR(temp5_min_alarm, S_IRUGO,
+            show_therm_min_alarm, NULL, 1+11),
+    SENSOR_ATTR(temp6_min_alarm, S_IRUGO,
+            show_therm_min_alarm, NULL, 2+11),
+};
+static struct sensor_device_attribute therm_max_alarm[] = {
+    SENSOR_ATTR(temp4_max_alarm, S_IRUGO,
+            show_therm_max_alarm, NULL, 0+11),
+    SENSOR_ATTR(temp5_max_alarm, S_IRUGO,
+            show_therm_max_alarm, NULL, 1+11),
+    SENSOR_ATTR(temp6_max_alarm, S_IRUGO,
+            show_therm_max_alarm, NULL, 2+11),
+};
+static struct sensor_device_attribute therm_crit_alarm[] = {
+    SENSOR_ATTR(temp4_crit_alarm, S_IRUGO,
+            show_therm_crit_alarm, NULL, 0+11),
+    SENSOR_ATTR(temp5_crit_alarm, S_IRUGO,
+            show_therm_crit_alarm, NULL, 1+11),
+    SENSOR_ATTR(temp6_crit_alarm, S_IRUGO,
+            show_therm_crit_alarm, NULL, 2+11),
+};
+
 #define THERM_UNIT_ATTRS(X) \
     &therm_input[X].dev_attr.attr,    \
     &therm_status[X].dev_attr.attr,    \
     &therm_min[X].dev_attr.attr,    \
     &therm_max[X].dev_attr.attr,    \
-    &therm_crit[X].dev_attr.attr
+    &therm_crit[X].dev_attr.attr,    \
+    &therm_min_alarm[X].dev_attr.attr, \
+    &therm_max_alarm[X].dev_attr.attr, \
+    &therm_crit_alarm[X].dev_attr.attr
 
 static struct attribute * pc8736x_therm_attr_array[] = {
     THERM_UNIT_ATTRS(0),
-- 
1.5.5.1



--------------060702030505070800020108
Content-Type: text/x-patch;
	name="0006-hwmon-pc87360-separate-alarm-files-add-therm-min-m.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename*0="0006-hwmon-pc87360-separate-alarm-files-add-therm-min-m.patc";
	filename*1="h"

From 7b4b599eef53f06825dbd2337714f028a0516069 Mon Sep 17 00:00:00 2001
From: Jim Cromie <jim.cromie@gmail.com>
Date: Sat, 28 Jun 2008 13:19:07 -0600
Subject: [PATCH] hwmon/pc87360 separate alarm files - add therm-min/max/crit-alarms

Adds therm-min/max/crit-alarm callbacks, sensor-device-attribute
declarations, and refs to those new decls in the macro used to
initialize the therm_group (of sysfs files).  This spin includes
style fixes per feedback.

The thermistors use voltage channels to measure; so they don't
have a fault-alarm, but unlike the other voltages, they do have an
overtemp, which we call crit (by convention).

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/hwmon/pc87360.c |   61 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 60 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/pc87360.c b/drivers/hwmon/pc87360.c
index acff04f..e49692b 100644
--- a/drivers/hwmon/pc87360.c
+++ b/drivers/hwmon/pc87360.c
@@ -715,12 +715,71 @@ static struct sensor_device_attribute therm_crit[] = {
 		    show_therm_crit, set_therm_crit, 2+11),
 };
 
+/* show_therm_min/max_alarm() reads data from the per-channel voltage
+   status register (sec 11.5.12) */
+
+static ssize_t
+show_therm_min_alarm(struct device *dev, struct device_attribute *devattr,
+		     char *buf)
+{
+	struct pc87360_data *data = pc87360_update_device(dev);
+	unsigned nr = to_sensor_dev_attr(devattr)->index;
+
+	return sprintf(buf, "%u\n", !!(data->in_status[nr] & CHAN_ALM_MIN));
+}
+static ssize_t
+show_therm_max_alarm(struct device *dev, struct device_attribute *devattr,
+		     char *buf)
+{
+	struct pc87360_data *data = pc87360_update_device(dev);
+	unsigned nr = to_sensor_dev_attr(devattr)->index;
+
+	return sprintf(buf, "%u\n", !!(data->in_status[nr] & CHAN_ALM_MAX));
+}
+static ssize_t
+show_therm_crit_alarm(struct device *dev, struct device_attribute *devattr,
+		      char *buf)
+{
+	struct pc87360_data *data = pc87360_update_device(dev);
+	unsigned nr = to_sensor_dev_attr(devattr)->index;
+
+	return sprintf(buf, "%u\n", !!(data->in_status[nr] & TEMP_ALM_CRIT));
+}
+
+static struct sensor_device_attribute therm_min_alarm[] = {
+	SENSOR_ATTR(temp4_min_alarm, S_IRUGO,
+		    show_therm_min_alarm, NULL, 0+11),
+	SENSOR_ATTR(temp5_min_alarm, S_IRUGO,
+		    show_therm_min_alarm, NULL, 1+11),
+	SENSOR_ATTR(temp6_min_alarm, S_IRUGO,
+		    show_therm_min_alarm, NULL, 2+11),
+};
+static struct sensor_device_attribute therm_max_alarm[] = {
+	SENSOR_ATTR(temp4_max_alarm, S_IRUGO,
+		    show_therm_max_alarm, NULL, 0+11),
+	SENSOR_ATTR(temp5_max_alarm, S_IRUGO,
+		    show_therm_max_alarm, NULL, 1+11),
+	SENSOR_ATTR(temp6_max_alarm, S_IRUGO,
+		    show_therm_max_alarm, NULL, 2+11),
+};
+static struct sensor_device_attribute therm_crit_alarm[] = {
+	SENSOR_ATTR(temp4_crit_alarm, S_IRUGO,
+		    show_therm_crit_alarm, NULL, 0+11),
+	SENSOR_ATTR(temp5_crit_alarm, S_IRUGO,
+		    show_therm_crit_alarm, NULL, 1+11),
+	SENSOR_ATTR(temp6_crit_alarm, S_IRUGO,
+		    show_therm_crit_alarm, NULL, 2+11),
+};
+
 #define THERM_UNIT_ATTRS(X) \
 	&therm_input[X].dev_attr.attr,	\
 	&therm_status[X].dev_attr.attr,	\
 	&therm_min[X].dev_attr.attr,	\
 	&therm_max[X].dev_attr.attr,	\
-	&therm_crit[X].dev_attr.attr
+	&therm_crit[X].dev_attr.attr,	\
+	&therm_min_alarm[X].dev_attr.attr, \
+	&therm_max_alarm[X].dev_attr.attr, \
+	&therm_crit_alarm[X].dev_attr.attr
 
 static struct attribute * pc8736x_therm_attr_array[] = {
 	THERM_UNIT_ATTRS(0),
-- 
1.5.5.1


--------------060702030505070800020108
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------060702030505070800020108--
