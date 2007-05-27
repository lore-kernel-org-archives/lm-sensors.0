From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 27 May 2007 15:14:19 +0000
Subject: [lm-sensors] [PATCH] Fault files naming convention
Message-Id: <20070527171419.34c725f8@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

We have the following naming convention documented in
Documentation/hwmon/sysfs-interface for fault files:

in[0-*]_input_fault
fan[1-*]_input_fault
temp[1-*]_input_fault

Some drivers follow this convention (lm63, lm83, lm90, smsc47m192).
However some drivers omit the "input" part and create files named
fan1_fault (pc87427) or temp1_fault (dme1737). And the new "generic"
libsensors follows this second (non-standard) convention, so it fails
to report fault conditions for drivers which follow the standard.

We want a single naming scheme, and everyone seems to prefer the
shorter variant, so let's go for it.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 Documentation/hwmon/sysfs-interface |    6 +++---
 drivers/hwmon/lm63.c                |    4 ++--
 drivers/hwmon/lm83.c                |   12 ++++++------
 drivers/hwmon/lm90.c                |    4 ++--
 drivers/hwmon/smsc47m192.c          |    8 ++++----
 5 files changed, 17 insertions(+), 17 deletions(-)

--- linux-2.6.22-rc3.orig/Documentation/hwmon/sysfs-interface	2007-05-13 10:01:12.000000000 +0200
+++ linux-2.6.22-rc3/Documentation/hwmon/sysfs-interface	2007-05-27 16:56:46.000000000 +0200
@@ -343,9 +343,9 @@ to notify open diodes, unconnected fans 
 supports it. When this boolean has value 1, the measurement for that
 channel should not be trusted.
 
-in[0-*]_input_fault
-fan[1-*]_input_fault
-temp[1-*]_input_fault
+in[0-*]_fault
+fan[1-*]_fault
+temp[1-*]_fault
 		Input fault condition
 		0: no fault occured
 		1: fault condition
--- linux-2.6.22-rc3.orig/drivers/hwmon/lm63.c	2007-02-04 19:44:54.000000000 +0100
+++ linux-2.6.22-rc3/drivers/hwmon/lm63.c	2007-05-27 16:57:31.000000000 +0200
@@ -364,7 +364,7 @@ static DEVICE_ATTR(temp2_crit_hyst, S_IW
 /* Individual alarm files */
 static SENSOR_DEVICE_ATTR(fan1_min_alarm, S_IRUGO, show_alarm, NULL, 0);
 static SENSOR_DEVICE_ATTR(temp2_crit_alarm, S_IRUGO, show_alarm, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp2_input_fault, S_IRUGO, show_alarm, NULL, 2);
+static SENSOR_DEVICE_ATTR(temp2_fault, S_IRUGO, show_alarm, NULL, 2);
 static SENSOR_DEVICE_ATTR(temp2_min_alarm, S_IRUGO, show_alarm, NULL, 3);
 static SENSOR_DEVICE_ATTR(temp2_max_alarm, S_IRUGO, show_alarm, NULL, 4);
 static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_alarm, NULL, 6);
@@ -383,7 +383,7 @@ static struct attribute *lm63_attributes
 	&dev_attr_temp2_crit_hyst.attr,
 
 	&sensor_dev_attr_temp2_crit_alarm.dev_attr.attr,
-	&sensor_dev_attr_temp2_input_fault.dev_attr.attr,
+	&sensor_dev_attr_temp2_fault.dev_attr.attr,
 	&sensor_dev_attr_temp2_min_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp2_max_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
--- linux-2.6.22-rc3.orig/drivers/hwmon/lm83.c	2007-02-04 19:44:54.000000000 +0100
+++ linux-2.6.22-rc3/drivers/hwmon/lm83.c	2007-05-27 16:57:52.000000000 +0200
@@ -223,14 +223,14 @@ static SENSOR_DEVICE_ATTR(temp4_crit, S_
 /* Individual alarm files */
 static SENSOR_DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_alarm, NULL, 0);
 static SENSOR_DEVICE_ATTR(temp3_crit_alarm, S_IRUGO, show_alarm, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp3_input_fault, S_IRUGO, show_alarm, NULL, 2);
+static SENSOR_DEVICE_ATTR(temp3_fault, S_IRUGO, show_alarm, NULL, 2);
 static SENSOR_DEVICE_ATTR(temp3_max_alarm, S_IRUGO, show_alarm, NULL, 4);
 static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_alarm, NULL, 6);
 static SENSOR_DEVICE_ATTR(temp2_crit_alarm, S_IRUGO, show_alarm, NULL, 8);
 static SENSOR_DEVICE_ATTR(temp4_crit_alarm, S_IRUGO, show_alarm, NULL, 9);
-static SENSOR_DEVICE_ATTR(temp4_input_fault, S_IRUGO, show_alarm, NULL, 10);
+static SENSOR_DEVICE_ATTR(temp4_fault, S_IRUGO, show_alarm, NULL, 10);
 static SENSOR_DEVICE_ATTR(temp4_max_alarm, S_IRUGO, show_alarm, NULL, 12);
-static SENSOR_DEVICE_ATTR(temp2_input_fault, S_IRUGO, show_alarm, NULL, 13);
+static SENSOR_DEVICE_ATTR(temp2_fault, S_IRUGO, show_alarm, NULL, 13);
 static SENSOR_DEVICE_ATTR(temp2_max_alarm, S_IRUGO, show_alarm, NULL, 15);
 /* Raw alarm file for compatibility */
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
@@ -245,7 +245,7 @@ static struct attribute *lm83_attributes
 
 	&sensor_dev_attr_temp1_crit_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp3_crit_alarm.dev_attr.attr,
-	&sensor_dev_attr_temp3_input_fault.dev_attr.attr,
+	&sensor_dev_attr_temp3_fault.dev_attr.attr,
 	&sensor_dev_attr_temp3_max_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
 	&dev_attr_alarms.attr,
@@ -266,9 +266,9 @@ static struct attribute *lm83_attributes
 
 	&sensor_dev_attr_temp2_crit_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp4_crit_alarm.dev_attr.attr,
-	&sensor_dev_attr_temp4_input_fault.dev_attr.attr,
+	&sensor_dev_attr_temp4_fault.dev_attr.attr,
 	&sensor_dev_attr_temp4_max_alarm.dev_attr.attr,
-	&sensor_dev_attr_temp2_input_fault.dev_attr.attr,
+	&sensor_dev_attr_temp2_fault.dev_attr.attr,
 	&sensor_dev_attr_temp2_max_alarm.dev_attr.attr,
 	NULL
 };
--- linux-2.6.22-rc3.orig/drivers/hwmon/lm90.c	2007-05-27 16:23:50.000000000 +0200
+++ linux-2.6.22-rc3/drivers/hwmon/lm90.c	2007-05-27 16:58:01.000000000 +0200
@@ -371,7 +371,7 @@ static SENSOR_DEVICE_ATTR(temp2_crit_hys
 /* Individual alarm files */
 static SENSOR_DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_alarm, NULL, 0);
 static SENSOR_DEVICE_ATTR(temp2_crit_alarm, S_IRUGO, show_alarm, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp2_input_fault, S_IRUGO, show_alarm, NULL, 2);
+static SENSOR_DEVICE_ATTR(temp2_fault, S_IRUGO, show_alarm, NULL, 2);
 static SENSOR_DEVICE_ATTR(temp2_min_alarm, S_IRUGO, show_alarm, NULL, 3);
 static SENSOR_DEVICE_ATTR(temp2_max_alarm, S_IRUGO, show_alarm, NULL, 4);
 static SENSOR_DEVICE_ATTR(temp1_min_alarm, S_IRUGO, show_alarm, NULL, 5);
@@ -393,7 +393,7 @@ static struct attribute *lm90_attributes
 
 	&sensor_dev_attr_temp1_crit_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp2_crit_alarm.dev_attr.attr,
-	&sensor_dev_attr_temp2_input_fault.dev_attr.attr,
+	&sensor_dev_attr_temp2_fault.dev_attr.attr,
 	&sensor_dev_attr_temp2_min_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp2_max_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp1_min_alarm.dev_attr.attr,
--- linux-2.6.22-rc3.orig/drivers/hwmon/smsc47m192.c	2007-05-27 16:23:44.000000000 +0200
+++ linux-2.6.22-rc3/drivers/hwmon/smsc47m192.c	2007-05-27 16:58:15.000000000 +0200
@@ -361,8 +361,8 @@ static ssize_t show_alarm(struct device 
 static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO, show_alarm, NULL, 0x0010);
 static SENSOR_DEVICE_ATTR(temp2_alarm, S_IRUGO, show_alarm, NULL, 0x0020);
 static SENSOR_DEVICE_ATTR(temp3_alarm, S_IRUGO, show_alarm, NULL, 0x0040);
-static SENSOR_DEVICE_ATTR(temp2_input_fault, S_IRUGO, show_alarm, NULL, 0x4000);
-static SENSOR_DEVICE_ATTR(temp3_input_fault, S_IRUGO, show_alarm, NULL, 0x8000);
+static SENSOR_DEVICE_ATTR(temp2_fault, S_IRUGO, show_alarm, NULL, 0x4000);
+static SENSOR_DEVICE_ATTR(temp3_fault, S_IRUGO, show_alarm, NULL, 0x8000);
 static SENSOR_DEVICE_ATTR(in0_alarm, S_IRUGO, show_alarm, NULL, 0x0001);
 static SENSOR_DEVICE_ATTR(in1_alarm, S_IRUGO, show_alarm, NULL, 0x0002);
 static SENSOR_DEVICE_ATTR(in2_alarm, S_IRUGO, show_alarm, NULL, 0x0004);
@@ -412,13 +412,13 @@ static struct attribute *smsc47m192_attr
 	&sensor_dev_attr_temp2_min.dev_attr.attr,
 	&sensor_dev_attr_temp2_offset.dev_attr.attr,
 	&sensor_dev_attr_temp2_alarm.dev_attr.attr,
-	&sensor_dev_attr_temp2_input_fault.dev_attr.attr,
+	&sensor_dev_attr_temp2_fault.dev_attr.attr,
 	&sensor_dev_attr_temp3_input.dev_attr.attr,
 	&sensor_dev_attr_temp3_max.dev_attr.attr,
 	&sensor_dev_attr_temp3_min.dev_attr.attr,
 	&sensor_dev_attr_temp3_offset.dev_attr.attr,
 	&sensor_dev_attr_temp3_alarm.dev_attr.attr,
-	&sensor_dev_attr_temp3_input_fault.dev_attr.attr,
+	&sensor_dev_attr_temp3_fault.dev_attr.attr,
 
 	&dev_attr_cpu0_vid.attr,
 	&dev_attr_vrm.attr,

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
