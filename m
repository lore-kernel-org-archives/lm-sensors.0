From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 14 Mar 2013 00:44:24 +0000
Subject: [lm-sensors] [PATCH 9/9] hwmon: (ltc4261) Fix 'Macros with complex values' checkpatch error
Message-Id: <1363221864-15284-10-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fix:
ERROR: Macros with complex values should be enclosed in parenthesis

by unwinding the problematic macros.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/ltc4261.c |   38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/drivers/hwmon/ltc4261.c b/drivers/hwmon/ltc4261.c
index 84a2d28..487da58 100644
--- a/drivers/hwmon/ltc4261.c
+++ b/drivers/hwmon/ltc4261.c
@@ -165,24 +165,12 @@ static ssize_t ltc4261_show_bool(struct device *dev,
 }
 
 /*
- * These macros are used below in constructing device attribute objects
- * for use with sysfs_create_group() to make a sysfs device file
- * for each register.
- */
-
-#define LTC4261_VALUE(name, ltc4261_cmd_idx) \
-	static SENSOR_DEVICE_ATTR(name, S_IRUGO, \
-	ltc4261_show_value, NULL, ltc4261_cmd_idx)
-
-#define LTC4261_BOOL(name, mask) \
-	static SENSOR_DEVICE_ATTR(name, S_IRUGO, \
-	ltc4261_show_bool, NULL, (mask))
-
-/*
  * Input voltages.
  */
-LTC4261_VALUE(in1_input, LTC4261_ADIN_H);
-LTC4261_VALUE(in2_input, LTC4261_ADIN2_H);
+static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, ltc4261_show_value, NULL,
+			  LTC4261_ADIN_H);
+static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, ltc4261_show_value, NULL,
+			  LTC4261_ADIN2_H);
 
 /*
  * Voltage alarms. The chip has only one set of voltage alarm status bits,
@@ -192,16 +180,22 @@ LTC4261_VALUE(in2_input, LTC4261_ADIN2_H);
  * To ensure that the alarm condition is reported to the user, report it
  * with both voltage sensors.
  */
-LTC4261_BOOL(in1_min_alarm, FAULT_UV);
-LTC4261_BOOL(in1_max_alarm, FAULT_OV);
-LTC4261_BOOL(in2_min_alarm, FAULT_UV);
-LTC4261_BOOL(in2_max_alarm, FAULT_OV);
+static SENSOR_DEVICE_ATTR(in1_min_alarm, S_IRUGO, ltc4261_show_bool, NULL,
+			  FAULT_UV);
+static SENSOR_DEVICE_ATTR(in1_max_alarm, S_IRUGO, ltc4261_show_bool, NULL,
+			  FAULT_OV);
+static SENSOR_DEVICE_ATTR(in2_min_alarm, S_IRUGO, ltc4261_show_bool, NULL,
+			  FAULT_UV);
+static SENSOR_DEVICE_ATTR(in2_max_alarm, S_IRUGO, ltc4261_show_bool, NULL,
+			  FAULT_OV);
 
 /* Currents (via sense resistor) */
-LTC4261_VALUE(curr1_input, LTC4261_SENSE_H);
+static SENSOR_DEVICE_ATTR(curr1_input, S_IRUGO, ltc4261_show_value, NULL,
+			  LTC4261_SENSE_H);
 
 /* Overcurrent alarm */
-LTC4261_BOOL(curr1_max_alarm, FAULT_OC);
+static SENSOR_DEVICE_ATTR(curr1_max_alarm, S_IRUGO, ltc4261_show_bool, NULL,
+			  FAULT_OC);
 
 static struct attribute *ltc4261_attributes[] = {
 	&sensor_dev_attr_in1_input.dev_attr.attr,
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
