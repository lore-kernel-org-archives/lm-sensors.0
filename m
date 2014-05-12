From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 12 May 2014 19:01:45 +0000
Subject: [lm-sensors] [PATCH 3/9] hwmon: (emc1403) Report external diode fault status
Message-Id: <1399921311-9524-4-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/emc1403.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hwmon/emc1403.c b/drivers/hwmon/emc1403.c
index 613bc49..8e82884 100644
--- a/drivers/hwmon/emc1403.c
+++ b/drivers/hwmon/emc1403.c
@@ -188,6 +188,7 @@ static SENSOR_DEVICE_ATTR(temp2_max, S_IRUGO | S_IWUSR,
 static SENSOR_DEVICE_ATTR(temp2_crit, S_IRUGO | S_IWUSR,
 	show_temp, store_temp, 0x19);
 static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 0x01);
+static SENSOR_DEVICE_ATTR_2(temp2_fault, S_IRUGO, show_bit, NULL, 0x1b, 0x02);
 static SENSOR_DEVICE_ATTR_2(temp2_min_alarm, S_IRUGO,
 	show_bit, NULL, 0x36, 0x02);
 static SENSOR_DEVICE_ATTR_2(temp2_max_alarm, S_IRUGO,
@@ -204,6 +205,7 @@ static SENSOR_DEVICE_ATTR(temp3_max, S_IRUGO | S_IWUSR,
 static SENSOR_DEVICE_ATTR(temp3_crit, S_IRUGO | S_IWUSR,
 	show_temp, store_temp, 0x1A);
 static SENSOR_DEVICE_ATTR(temp3_input, S_IRUGO, show_temp, NULL, 0x23);
+static SENSOR_DEVICE_ATTR_2(temp3_fault, S_IRUGO, show_bit, NULL, 0x1b, 0x04);
 static SENSOR_DEVICE_ATTR_2(temp3_min_alarm, S_IRUGO,
 	show_bit, NULL, 0x36, 0x04);
 static SENSOR_DEVICE_ATTR_2(temp3_max_alarm, S_IRUGO,
@@ -220,6 +222,7 @@ static SENSOR_DEVICE_ATTR(temp4_max, S_IRUGO | S_IWUSR,
 static SENSOR_DEVICE_ATTR(temp4_crit, S_IRUGO | S_IWUSR,
 	show_temp, store_temp, 0x30);
 static SENSOR_DEVICE_ATTR(temp4_input, S_IRUGO, show_temp, NULL, 0x2A);
+static SENSOR_DEVICE_ATTR_2(temp4_fault, S_IRUGO, show_bit, NULL, 0x1b, 0x08);
 static SENSOR_DEVICE_ATTR_2(temp4_min_alarm, S_IRUGO,
 	show_bit, NULL, 0x36, 0x08);
 static SENSOR_DEVICE_ATTR_2(temp4_max_alarm, S_IRUGO,
@@ -258,6 +261,7 @@ static struct attribute *emc1403_attrs[] = {
 	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp1_crit_alarm.dev_attr.attr,
 
+	&sensor_dev_attr_temp2_fault.dev_attr.attr,
 	&sensor_dev_attr_temp2_min_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp2_max_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp2_crit_alarm.dev_attr.attr,
@@ -266,6 +270,7 @@ static struct attribute *emc1403_attrs[] = {
 	&sensor_dev_attr_temp3_max.dev_attr.attr,
 	&sensor_dev_attr_temp3_crit.dev_attr.attr,
 	&sensor_dev_attr_temp3_input.dev_attr.attr,
+	&sensor_dev_attr_temp3_fault.dev_attr.attr,
 	&sensor_dev_attr_temp3_min_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp3_max_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp3_crit_alarm.dev_attr.attr,
@@ -282,6 +287,7 @@ static struct attribute *emc1404_attrs[] = {
 	&sensor_dev_attr_temp4_max.dev_attr.attr,
 	&sensor_dev_attr_temp4_crit.dev_attr.attr,
 	&sensor_dev_attr_temp4_input.dev_attr.attr,
+	&sensor_dev_attr_temp4_fault.dev_attr.attr,
 	&sensor_dev_attr_temp4_min_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp4_max_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp4_crit_alarm.dev_attr.attr,
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
