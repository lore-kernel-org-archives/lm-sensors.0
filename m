From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 12 May 2014 19:01:49 +0000
Subject: [lm-sensors] [PATCH 7/9] hwmon: (emc1403) Add support for max_hyst attributes
Message-Id: <1399921311-9524-8-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The hysteresis value applies to all limits, so add support for
tempX_max_hyst.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/emc1403.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hwmon/emc1403.c b/drivers/hwmon/emc1403.c
index 13cac04..a9ebd68 100644
--- a/drivers/hwmon/emc1403.c
+++ b/drivers/hwmon/emc1403.c
@@ -173,6 +173,7 @@ static SENSOR_DEVICE_ATTR_2(temp1_max_alarm, S_IRUGO,
 	show_bit, NULL, 0x35, 0x01);
 static SENSOR_DEVICE_ATTR_2(temp1_crit_alarm, S_IRUGO,
 	show_bit, NULL, 0x37, 0x01);
+static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IRUGO, show_hyst, NULL, 0x05);
 static SENSOR_DEVICE_ATTR(temp1_crit_hyst, S_IRUGO | S_IWUSR,
 	show_hyst, store_hyst, 0x20);
 
@@ -190,6 +191,7 @@ static SENSOR_DEVICE_ATTR_2(temp2_max_alarm, S_IRUGO,
 	show_bit, NULL, 0x35, 0x02);
 static SENSOR_DEVICE_ATTR_2(temp2_crit_alarm, S_IRUGO,
 	show_bit, NULL, 0x37, 0x02);
+static SENSOR_DEVICE_ATTR(temp2_max_hyst, S_IRUGO, show_hyst, NULL, 0x07);
 static SENSOR_DEVICE_ATTR(temp2_crit_hyst, S_IRUGO, show_hyst, NULL, 0x19);
 
 static SENSOR_DEVICE_ATTR(temp3_min, S_IRUGO | S_IWUSR,
@@ -206,6 +208,7 @@ static SENSOR_DEVICE_ATTR_2(temp3_max_alarm, S_IRUGO,
 	show_bit, NULL, 0x35, 0x04);
 static SENSOR_DEVICE_ATTR_2(temp3_crit_alarm, S_IRUGO,
 	show_bit, NULL, 0x37, 0x04);
+static SENSOR_DEVICE_ATTR(temp3_max_hyst, S_IRUGO, show_hyst, NULL, 0x15);
 static SENSOR_DEVICE_ATTR(temp3_crit_hyst, S_IRUGO, show_hyst, NULL, 0x1A);
 
 static SENSOR_DEVICE_ATTR(temp4_min, S_IRUGO | S_IWUSR,
@@ -222,6 +225,7 @@ static SENSOR_DEVICE_ATTR_2(temp4_max_alarm, S_IRUGO,
 	show_bit, NULL, 0x35, 0x08);
 static SENSOR_DEVICE_ATTR_2(temp4_crit_alarm, S_IRUGO,
 	show_bit, NULL, 0x37, 0x08);
+static SENSOR_DEVICE_ATTR(temp4_max_hyst, S_IRUGO, show_hyst, NULL, 0x2C);
 static SENSOR_DEVICE_ATTR(temp4_crit_hyst, S_IRUGO, show_hyst, NULL, 0x30);
 
 static SENSOR_DEVICE_ATTR_2(power_state, S_IRUGO | S_IWUSR,
@@ -232,12 +236,14 @@ static struct attribute *emc1402_attrs[] = {
 	&sensor_dev_attr_temp1_max.dev_attr.attr,
 	&sensor_dev_attr_temp1_crit.dev_attr.attr,
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
 	&sensor_dev_attr_temp1_crit_hyst.dev_attr.attr,
 
 	&sensor_dev_attr_temp2_min.dev_attr.attr,
 	&sensor_dev_attr_temp2_max.dev_attr.attr,
 	&sensor_dev_attr_temp2_crit.dev_attr.attr,
 	&sensor_dev_attr_temp2_input.dev_attr.attr,
+	&sensor_dev_attr_temp2_max_hyst.dev_attr.attr,
 	&sensor_dev_attr_temp2_crit_hyst.dev_attr.attr,
 
 	&sensor_dev_attr_power_state.dev_attr.attr,
@@ -266,6 +272,7 @@ static struct attribute *emc1403_attrs[] = {
 	&sensor_dev_attr_temp3_min_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp3_max_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp3_crit_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp3_max_hyst.dev_attr.attr,
 	&sensor_dev_attr_temp3_crit_hyst.dev_attr.attr,
 	NULL
 };
@@ -283,6 +290,7 @@ static struct attribute *emc1404_attrs[] = {
 	&sensor_dev_attr_temp4_min_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp4_max_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp4_crit_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp4_max_hyst.dev_attr.attr,
 	&sensor_dev_attr_temp4_crit_hyst.dev_attr.attr,
 	NULL
 };
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
