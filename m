From: Jim Cromie <jim.cromie@gmail.com>
Date: Thu, 11 Sep 2008 04:36:39 +0000
Subject: [lm-sensors] [ patch 2.6.27-rc6 3/6 v2] separate alarm sysfs files
Message-Id: <48C8A057.3020203@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------060509090708010606060104"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------060509090708010606060104
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

[jimc@harpo ts-t4d]$
[jimc@harpo ts-t4d]$
[jimc@harpo ts-t4d]$
[jimc@harpo ts-t4d]$ more 
0003-hwmon-pc87360-separate-alarm-files-add-temp-min-ma.patch
 From 838b7d240dd75bdec280b8f8a3b14643a29f1ee0 Mon Sep 17 00:00:00 2001
From: Jim Cromie <jim.cromie@gmail.com>
Date: Sat, 28 Jun 2008 13:19:07 -0600
Subject: [PATCH] hwmon/pc87360 separate alarm files - add 
temp-min/max/crit/fault-alarms

Adds temp-min/max/crit/fault-alarm callbacks, sensor-device-attribute
declarations, and refs to those new decls in the macro used to
initialize the temp_group (of sysfs files)

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/hwmon/pc87360.c |   83 
+++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 81 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/pc87360.c b/drivers/hwmon/pc87360.c
index 538f784..17688b7 100644
--- a/drivers/hwmon/pc87360.c
+++ b/drivers/hwmon/pc87360.c
@@ -847,12 +847,79 @@ static ssize_t show_temp_alarms(struct device 
*dev, struct device_
attribute *att
 }
 static DEVICE_ATTR(alarms_temp, S_IRUGO, show_temp_alarms, NULL);
 
+/* show_temp_min/max_alarm() reads data from the per-channel status
+   register (sec 12.3.7), not the temp event status registers (sec
+   12.3.2) that show_temp_alarm() reads (via data->temp_alarms) */
+
+static ssize_t
+show_temp_min_alarm(struct device *dev, struct device_attribute *devattr,
+            char *buf)
+{
+    struct pc87360_data *data = pc87360_update_device(dev);
+    unsigned nr = to_sensor_dev_attr(devattr)->index;
+
+    return sprintf(buf, "%u\n", !!(data->temp_status[nr] & CHAN_ALM_MIN));
+}
+static ssize_t
+show_temp_max_alarm(struct device *dev, struct device_attribute *devattr,
+            char *buf)
+{
+    struct pc87360_data *data = pc87360_update_device(dev);
+    unsigned nr = to_sensor_dev_attr(devattr)->index;
+
+    return sprintf(buf, "%u\n", !!(data->temp_status[nr] & CHAN_ALM_MAX));
+}
+static ssize_t
+show_temp_crit_alarm(struct device *dev, struct device_attribute *devattr,
+             char *buf)
+{
+    struct pc87360_data *data = pc87360_update_device(dev);
+    unsigned nr = to_sensor_dev_attr(devattr)->index;
+
+    return sprintf(buf, "%u\n", !!(data->temp_status[nr] & TEMP_ALM_CRIT));
+}
+
+static struct sensor_device_attribute temp_min_alarm[] = {
+    SENSOR_ATTR(temp1_min_alarm, S_IRUGO, show_temp_min_alarm, NULL, 0),
+    SENSOR_ATTR(temp2_min_alarm, S_IRUGO, show_temp_min_alarm, NULL, 1),
+    SENSOR_ATTR(temp3_min_alarm, S_IRUGO, show_temp_min_alarm, NULL, 2),
+};
+static struct sensor_device_attribute temp_max_alarm[] = {
+    SENSOR_ATTR(temp1_max_alarm, S_IRUGO, show_temp_max_alarm, NULL, 0),
+    SENSOR_ATTR(temp2_max_alarm, S_IRUGO, show_temp_max_alarm, NULL, 1),
+    SENSOR_ATTR(temp3_max_alarm, S_IRUGO, show_temp_max_alarm, NULL, 2),
+};
+static struct sensor_device_attribute temp_crit_alarm[] = {
+    SENSOR_ATTR(temp1_crit_alarm, S_IRUGO, show_temp_crit_alarm, NULL, 0),
+    SENSOR_ATTR(temp2_crit_alarm, S_IRUGO, show_temp_crit_alarm, NULL, 1),
+    SENSOR_ATTR(temp3_crit_alarm, S_IRUGO, show_temp_crit_alarm, NULL, 2),
+};
+
+#define TEMP_FAULT    0x40    /* open diode */
+static ssize_t show_temp_fault(struct device *dev, struct device_attribute
+                   *devattr, char *buf)
+{
+    struct pc87360_data *data = pc87360_update_device(dev);
+    unsigned nr = to_sensor_dev_attr(devattr)->index;
+
+    return sprintf(buf, "%u\n", !!(data->temp_status[nr] & TEMP_FAULT));
+}
+static struct sensor_device_attribute temp_fault[] = {
+    SENSOR_ATTR(temp1_fault, S_IRUGO, show_temp_fault, NULL, 0),
+    SENSOR_ATTR(temp2_fault, S_IRUGO, show_temp_fault, NULL, 1),
+    SENSOR_ATTR(temp3_fault, S_IRUGO, show_temp_fault, NULL, 2),
+};
+
 #define TEMP_UNIT_ATTRS(X) \
     &temp_input[X].dev_attr.attr,    \
     &temp_status[X].dev_attr.attr,    \
     &temp_min[X].dev_attr.attr,    \
     &temp_max[X].dev_attr.attr,    \
-    &temp_crit[X].dev_attr.attr
+    &temp_crit[X].dev_attr.attr,    \
+    &temp_min_alarm[X].dev_attr.attr, \
+    &temp_max_alarm[X].dev_attr.attr, \
+    &temp_crit_alarm[X].dev_attr.attr, \
+    &temp_fault[X].dev_attr.attr
 
 static struct attribute * pc8736x_temp_attr_array[] = {
     TEMP_UNIT_ATTRS(0),
@@ -1088,7 +1155,15 @@ static int __devinit pc87360_probe(struct 
platform_device *pdev)
                 || (err = device_create_file(dev,
                     &temp_crit[i].dev_attr))
                 || (err = device_create_file(dev,
-                    &temp_status[i].dev_attr)))
+                    &temp_status[i].dev_attr))
+                || (err = device_create_file(dev,
+                    &temp_min_alarm[i].dev_attr))
+                || (err = device_create_file(dev,
+                    &temp_max_alarm[i].dev_attr))
+                || (err = device_create_file(dev,
+                    &temp_crit_alarm[i].dev_attr))
+                || (err = device_create_file(dev,
+                    &temp_fault[i].dev_attr)))
                 goto ERROR3;
         }
         if ((err = device_create_file(dev, &dev_attr_alarms_temp)))
@@ -1194,6 +1269,10 @@ static void pc87360_write_value(struct 
pc87360_data *data, u8 ldi
, u8 bank,
 #define CHAN_ALM_ENA    0x10    /* propagate to alarms-reg ?? (chk val!) */
 #define CHAN_READY    (CHAN_ENA|CHAN_CNVRTD) /* sample ready mask */
 
+#define TEMP_OTS_OE    0x20    /* OTS Output Enable */
+#define VIN_RW1C_MASK    (CHAN_READY|CHAN_ALM_MAX|CHAN_ALM_MIN)   /* 
0x87 */
+#define TEMP_RW1C_MASK    (VIN_RW1C_MASK|TEMP_ALM_CRIT|TEMP_FAULT) /* 
0xCF */
+
 static void pc87360_init_device(struct platform_device *pdev,
                 int use_thermistors)
 {
-- 
1.5.5.1



--------------060509090708010606060104
Content-Type: text/x-patch;
	name="0003-hwmon-pc87360-separate-alarm-files-add-temp-min-ma.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename*0="0003-hwmon-pc87360-separate-alarm-files-add-temp-min-ma.patc";
	filename*1="h"

From 838b7d240dd75bdec280b8f8a3b14643a29f1ee0 Mon Sep 17 00:00:00 2001
From: Jim Cromie <jim.cromie@gmail.com>
Date: Sat, 28 Jun 2008 13:19:07 -0600
Subject: [PATCH] hwmon/pc87360 separate alarm files - add temp-min/max/crit/fault-alarms

Adds temp-min/max/crit/fault-alarm callbacks, sensor-device-attribute
declarations, and refs to those new decls in the macro used to
initialize the temp_group (of sysfs files)

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/hwmon/pc87360.c |   83 +++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 81 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/pc87360.c b/drivers/hwmon/pc87360.c
index 538f784..17688b7 100644
--- a/drivers/hwmon/pc87360.c
+++ b/drivers/hwmon/pc87360.c
@@ -847,12 +847,79 @@ static ssize_t show_temp_alarms(struct device *dev, struct device_attribute *att
 }
 static DEVICE_ATTR(alarms_temp, S_IRUGO, show_temp_alarms, NULL);
 
+/* show_temp_min/max_alarm() reads data from the per-channel status
+   register (sec 12.3.7), not the temp event status registers (sec
+   12.3.2) that show_temp_alarm() reads (via data->temp_alarms) */
+
+static ssize_t
+show_temp_min_alarm(struct device *dev, struct device_attribute *devattr,
+		    char *buf)
+{
+	struct pc87360_data *data = pc87360_update_device(dev);
+	unsigned nr = to_sensor_dev_attr(devattr)->index;
+
+	return sprintf(buf, "%u\n", !!(data->temp_status[nr] & CHAN_ALM_MIN));
+}
+static ssize_t
+show_temp_max_alarm(struct device *dev, struct device_attribute *devattr,
+		    char *buf)
+{
+	struct pc87360_data *data = pc87360_update_device(dev);
+	unsigned nr = to_sensor_dev_attr(devattr)->index;
+
+	return sprintf(buf, "%u\n", !!(data->temp_status[nr] & CHAN_ALM_MAX));
+}
+static ssize_t
+show_temp_crit_alarm(struct device *dev, struct device_attribute *devattr,
+		     char *buf)
+{
+	struct pc87360_data *data = pc87360_update_device(dev);
+	unsigned nr = to_sensor_dev_attr(devattr)->index;
+
+	return sprintf(buf, "%u\n", !!(data->temp_status[nr] & TEMP_ALM_CRIT));
+}
+
+static struct sensor_device_attribute temp_min_alarm[] = {
+	SENSOR_ATTR(temp1_min_alarm, S_IRUGO, show_temp_min_alarm, NULL, 0),
+	SENSOR_ATTR(temp2_min_alarm, S_IRUGO, show_temp_min_alarm, NULL, 1),
+	SENSOR_ATTR(temp3_min_alarm, S_IRUGO, show_temp_min_alarm, NULL, 2),
+};
+static struct sensor_device_attribute temp_max_alarm[] = {
+	SENSOR_ATTR(temp1_max_alarm, S_IRUGO, show_temp_max_alarm, NULL, 0),
+	SENSOR_ATTR(temp2_max_alarm, S_IRUGO, show_temp_max_alarm, NULL, 1),
+	SENSOR_ATTR(temp3_max_alarm, S_IRUGO, show_temp_max_alarm, NULL, 2),
+};
+static struct sensor_device_attribute temp_crit_alarm[] = {
+	SENSOR_ATTR(temp1_crit_alarm, S_IRUGO, show_temp_crit_alarm, NULL, 0),
+	SENSOR_ATTR(temp2_crit_alarm, S_IRUGO, show_temp_crit_alarm, NULL, 1),
+	SENSOR_ATTR(temp3_crit_alarm, S_IRUGO, show_temp_crit_alarm, NULL, 2),
+};
+
+#define TEMP_FAULT	0x40	/* open diode */
+static ssize_t show_temp_fault(struct device *dev, struct device_attribute
+			       *devattr, char *buf)
+{
+	struct pc87360_data *data = pc87360_update_device(dev);
+	unsigned nr = to_sensor_dev_attr(devattr)->index;
+
+	return sprintf(buf, "%u\n", !!(data->temp_status[nr] & TEMP_FAULT));
+}
+static struct sensor_device_attribute temp_fault[] = {
+	SENSOR_ATTR(temp1_fault, S_IRUGO, show_temp_fault, NULL, 0),
+	SENSOR_ATTR(temp2_fault, S_IRUGO, show_temp_fault, NULL, 1),
+	SENSOR_ATTR(temp3_fault, S_IRUGO, show_temp_fault, NULL, 2),
+};
+
 #define TEMP_UNIT_ATTRS(X) \
 	&temp_input[X].dev_attr.attr,	\
 	&temp_status[X].dev_attr.attr,	\
 	&temp_min[X].dev_attr.attr,	\
 	&temp_max[X].dev_attr.attr,	\
-	&temp_crit[X].dev_attr.attr
+	&temp_crit[X].dev_attr.attr,	\
+	&temp_min_alarm[X].dev_attr.attr, \
+	&temp_max_alarm[X].dev_attr.attr, \
+	&temp_crit_alarm[X].dev_attr.attr, \
+	&temp_fault[X].dev_attr.attr
 
 static struct attribute * pc8736x_temp_attr_array[] = {
 	TEMP_UNIT_ATTRS(0),
@@ -1088,7 +1155,15 @@ static int __devinit pc87360_probe(struct platform_device *pdev)
 			    || (err = device_create_file(dev,
 					&temp_crit[i].dev_attr))
 			    || (err = device_create_file(dev,
-					&temp_status[i].dev_attr)))
+					&temp_status[i].dev_attr))
+			    || (err = device_create_file(dev,
+					&temp_min_alarm[i].dev_attr))
+			    || (err = device_create_file(dev,
+					&temp_max_alarm[i].dev_attr))
+			    || (err = device_create_file(dev,
+					&temp_crit_alarm[i].dev_attr))
+			    || (err = device_create_file(dev,
+					&temp_fault[i].dev_attr)))
 				goto ERROR3;
 		}
 		if ((err = device_create_file(dev, &dev_attr_alarms_temp)))
@@ -1194,6 +1269,10 @@ static void pc87360_write_value(struct pc87360_data *data, u8 ldi, u8 bank,
 #define CHAN_ALM_ENA	0x10	/* propagate to alarms-reg ?? (chk val!) */
 #define CHAN_READY	(CHAN_ENA|CHAN_CNVRTD) /* sample ready mask */
 
+#define TEMP_OTS_OE	0x20	/* OTS Output Enable */
+#define VIN_RW1C_MASK	(CHAN_READY|CHAN_ALM_MAX|CHAN_ALM_MIN)   /* 0x87 */
+#define TEMP_RW1C_MASK	(VIN_RW1C_MASK|TEMP_ALM_CRIT|TEMP_FAULT) /* 0xCF */
+
 static void pc87360_init_device(struct platform_device *pdev,
 				int use_thermistors)
 {
-- 
1.5.5.1


--------------060509090708010606060104
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------060509090708010606060104--
