From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 20 Jan 2012 19:39:20 +0000
Subject: [lm-sensors] [PATCH 08/13] hwmon: (vt1211) Fix: do not use assignment in if condition
Message-Id: <1327088365-11149-9-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fix checkpatch issue:
ERROR: do not use assignment in if condition

Replace repeated calls to device_create_file() with calls to sysfs_create_group.

Cc: Juerg Haefliger <juergh@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/vt1211.c |  227 ++++++++++++++++++++----------------------------
 1 files changed, 94 insertions(+), 133 deletions(-)

diff --git a/drivers/hwmon/vt1211.c b/drivers/hwmon/vt1211.c
index 694bf66..e681a7a 100644
--- a/drivers/hwmon/vt1211.c
+++ b/drivers/hwmon/vt1211.c
@@ -931,112 +931,99 @@ static ssize_t show_alarms(struct device *dev,
  * ---------------------------------------------------------------------
  */
 
-#define SENSOR_ATTR_IN_INPUT(ix) \
-	SENSOR_ATTR_2(in##ix##_input, S_IRUGO, \
-		show_in, NULL, SHOW_IN_INPUT, ix)
-
-static struct sensor_device_attribute_2 vt1211_sysfs_in_input[] = {
-	SENSOR_ATTR_IN_INPUT(0),
-	SENSOR_ATTR_IN_INPUT(1),
-	SENSOR_ATTR_IN_INPUT(2),
-	SENSOR_ATTR_IN_INPUT(3),
-	SENSOR_ATTR_IN_INPUT(4),
-	SENSOR_ATTR_IN_INPUT(5),
-};
-
-#define SENSOR_ATTR_IN_MIN(ix) \
+#define SENSOR_ATTR_IN(ix) \
+{	SENSOR_ATTR_2(in##ix##_input, S_IRUGO, \
+		show_in, NULL, SHOW_IN_INPUT, ix), \
 	SENSOR_ATTR_2(in##ix##_min, S_IRUGO | S_IWUSR, \
-		show_in, set_in, SHOW_SET_IN_MIN, ix)
-
-static struct sensor_device_attribute_2 vt1211_sysfs_in_min[] = {
-	SENSOR_ATTR_IN_MIN(0),
-	SENSOR_ATTR_IN_MIN(1),
-	SENSOR_ATTR_IN_MIN(2),
-	SENSOR_ATTR_IN_MIN(3),
-	SENSOR_ATTR_IN_MIN(4),
-	SENSOR_ATTR_IN_MIN(5),
-};
-
-#define SENSOR_ATTR_IN_MAX(ix) \
+		show_in, set_in, SHOW_SET_IN_MIN, ix), \
 	SENSOR_ATTR_2(in##ix##_max, S_IRUGO | S_IWUSR, \
-		show_in, set_in, SHOW_SET_IN_MAX, ix)
-
-static struct sensor_device_attribute_2 vt1211_sysfs_in_max[] = {
-	SENSOR_ATTR_IN_MAX(0),
-	SENSOR_ATTR_IN_MAX(1),
-	SENSOR_ATTR_IN_MAX(2),
-	SENSOR_ATTR_IN_MAX(3),
-	SENSOR_ATTR_IN_MAX(4),
-	SENSOR_ATTR_IN_MAX(5),
+		show_in, set_in, SHOW_SET_IN_MAX, ix), \
+	SENSOR_ATTR_2(in##ix##_alarm, S_IRUGO, \
+		show_in, NULL, SHOW_IN_ALARM, ix) \
+}
+
+static struct sensor_device_attribute_2 vt1211_sysfs_in[][4] = {
+	SENSOR_ATTR_IN(0),
+	SENSOR_ATTR_IN(1),
+	SENSOR_ATTR_IN(2),
+	SENSOR_ATTR_IN(3),
+	SENSOR_ATTR_IN(4),
+	SENSOR_ATTR_IN(5)
 };
 
-#define SENSOR_ATTR_IN_ALARM(ix) \
-	SENSOR_ATTR_2(in##ix##_alarm, S_IRUGO, \
-		show_in, NULL, SHOW_IN_ALARM, ix)
-
-static struct sensor_device_attribute_2 vt1211_sysfs_in_alarm[] = {
-	SENSOR_ATTR_IN_ALARM(0),
-	SENSOR_ATTR_IN_ALARM(1),
-	SENSOR_ATTR_IN_ALARM(2),
-	SENSOR_ATTR_IN_ALARM(3),
-	SENSOR_ATTR_IN_ALARM(4),
-	SENSOR_ATTR_IN_ALARM(5),
+#define IN_UNIT_ATTRS(X)			\
+{	&vt1211_sysfs_in[X][0].dev_attr.attr,	\
+	&vt1211_sysfs_in[X][1].dev_attr.attr,	\
+	&vt1211_sysfs_in[X][2].dev_attr.attr,	\
+	&vt1211_sysfs_in[X][3].dev_attr.attr,	\
+	NULL					\
+}
+
+static struct attribute *vt1211_in_attr[][5] = {
+	IN_UNIT_ATTRS(0),
+	IN_UNIT_ATTRS(1),
+	IN_UNIT_ATTRS(2),
+	IN_UNIT_ATTRS(3),
+	IN_UNIT_ATTRS(4),
+	IN_UNIT_ATTRS(5)
 };
 
-#define SENSOR_ATTR_TEMP_INPUT(ix) \
-	SENSOR_ATTR_2(temp##ix##_input, S_IRUGO, \
-		show_temp, NULL, SHOW_TEMP_INPUT, ix-1)
-
-static struct sensor_device_attribute_2 vt1211_sysfs_temp_input[] = {
-	SENSOR_ATTR_TEMP_INPUT(1),
-	SENSOR_ATTR_TEMP_INPUT(2),
-	SENSOR_ATTR_TEMP_INPUT(3),
-	SENSOR_ATTR_TEMP_INPUT(4),
-	SENSOR_ATTR_TEMP_INPUT(5),
-	SENSOR_ATTR_TEMP_INPUT(6),
-	SENSOR_ATTR_TEMP_INPUT(7),
+static const struct attribute_group vt1211_in_attr_group[] = {
+	{ .attrs = vt1211_in_attr[0] },
+	{ .attrs = vt1211_in_attr[1] },
+	{ .attrs = vt1211_in_attr[2] },
+	{ .attrs = vt1211_in_attr[3] },
+	{ .attrs = vt1211_in_attr[4] },
+	{ .attrs = vt1211_in_attr[5] }
 };
 
-#define SENSOR_ATTR_TEMP_MAX(ix) \
+#define SENSOR_ATTR_TEMP(ix) \
+{	SENSOR_ATTR_2(temp##ix##_input, S_IRUGO, \
+		show_temp, NULL, SHOW_TEMP_INPUT, ix-1), \
 	SENSOR_ATTR_2(temp##ix##_max, S_IRUGO | S_IWUSR, \
-		show_temp, set_temp, SHOW_SET_TEMP_MAX, ix-1)
-
-static struct sensor_device_attribute_2 vt1211_sysfs_temp_max[] = {
-	SENSOR_ATTR_TEMP_MAX(1),
-	SENSOR_ATTR_TEMP_MAX(2),
-	SENSOR_ATTR_TEMP_MAX(3),
-	SENSOR_ATTR_TEMP_MAX(4),
-	SENSOR_ATTR_TEMP_MAX(5),
-	SENSOR_ATTR_TEMP_MAX(6),
-	SENSOR_ATTR_TEMP_MAX(7),
+		show_temp, set_temp, SHOW_SET_TEMP_MAX, ix-1), \
+	SENSOR_ATTR_2(temp##ix##_max_hyst, S_IRUGO | S_IWUSR, \
+		show_temp, set_temp, SHOW_SET_TEMP_MAX_HYST, ix-1), \
+	SENSOR_ATTR_2(temp##ix##_alarm, S_IRUGO, \
+		show_temp, NULL, SHOW_TEMP_ALARM, ix-1) \
+}
+
+static struct sensor_device_attribute_2 vt1211_sysfs_temp[][4] = {
+	SENSOR_ATTR_TEMP(1),
+	SENSOR_ATTR_TEMP(2),
+	SENSOR_ATTR_TEMP(3),
+	SENSOR_ATTR_TEMP(4),
+	SENSOR_ATTR_TEMP(5),
+	SENSOR_ATTR_TEMP(6),
+	SENSOR_ATTR_TEMP(7),
 };
 
-#define SENSOR_ATTR_TEMP_MAX_HYST(ix) \
-	SENSOR_ATTR_2(temp##ix##_max_hyst, S_IRUGO | S_IWUSR, \
-		show_temp, set_temp, SHOW_SET_TEMP_MAX_HYST, ix-1)
-
-static struct sensor_device_attribute_2 vt1211_sysfs_temp_max_hyst[] = {
-	SENSOR_ATTR_TEMP_MAX_HYST(1),
-	SENSOR_ATTR_TEMP_MAX_HYST(2),
-	SENSOR_ATTR_TEMP_MAX_HYST(3),
-	SENSOR_ATTR_TEMP_MAX_HYST(4),
-	SENSOR_ATTR_TEMP_MAX_HYST(5),
-	SENSOR_ATTR_TEMP_MAX_HYST(6),
-	SENSOR_ATTR_TEMP_MAX_HYST(7),
+#define TEMP_UNIT_ATTRS(X)			\
+{	&vt1211_sysfs_temp[X][0].dev_attr.attr,	\
+	&vt1211_sysfs_temp[X][1].dev_attr.attr,	\
+	&vt1211_sysfs_temp[X][2].dev_attr.attr,	\
+	&vt1211_sysfs_temp[X][3].dev_attr.attr,	\
+	NULL					\
+}
+
+static struct attribute *vt1211_temp_attr[][5] = {
+	TEMP_UNIT_ATTRS(0),
+	TEMP_UNIT_ATTRS(1),
+	TEMP_UNIT_ATTRS(2),
+	TEMP_UNIT_ATTRS(3),
+	TEMP_UNIT_ATTRS(4),
+	TEMP_UNIT_ATTRS(5),
+	TEMP_UNIT_ATTRS(6)
 };
 
-#define SENSOR_ATTR_TEMP_ALARM(ix) \
-	SENSOR_ATTR_2(temp##ix##_alarm, S_IRUGO, \
-		show_temp, NULL, SHOW_TEMP_ALARM, ix-1)
-
-static struct sensor_device_attribute_2 vt1211_sysfs_temp_alarm[] = {
-	SENSOR_ATTR_TEMP_ALARM(1),
-	SENSOR_ATTR_TEMP_ALARM(2),
-	SENSOR_ATTR_TEMP_ALARM(3),
-	SENSOR_ATTR_TEMP_ALARM(4),
-	SENSOR_ATTR_TEMP_ALARM(5),
-	SENSOR_ATTR_TEMP_ALARM(6),
-	SENSOR_ATTR_TEMP_ALARM(7),
+static const struct attribute_group vt1211_temp_attr_group[] = {
+	{ .attrs = vt1211_temp_attr[0] },
+	{ .attrs = vt1211_temp_attr[1] },
+	{ .attrs = vt1211_temp_attr[2] },
+	{ .attrs = vt1211_temp_attr[3] },
+	{ .attrs = vt1211_temp_attr[4] },
+	{ .attrs = vt1211_temp_attr[5] },
+	{ .attrs = vt1211_temp_attr[6] }
 };
 
 #define SENSOR_ATTR_FAN(ix) \
@@ -1164,26 +1151,12 @@ static void vt1211_remove_sysfs(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(vt1211_sysfs_in_input); i++) {
-		device_remove_file(dev,
-			&vt1211_sysfs_in_input[i].dev_attr);
-		device_remove_file(dev,
-			&vt1211_sysfs_in_min[i].dev_attr);
-		device_remove_file(dev,
-			&vt1211_sysfs_in_max[i].dev_attr);
-		device_remove_file(dev,
-			&vt1211_sysfs_in_alarm[i].dev_attr);
-	}
-	for (i = 0; i < ARRAY_SIZE(vt1211_sysfs_temp_input); i++) {
-		device_remove_file(dev,
-			&vt1211_sysfs_temp_input[i].dev_attr);
-		device_remove_file(dev,
-			&vt1211_sysfs_temp_max[i].dev_attr);
-		device_remove_file(dev,
-			&vt1211_sysfs_temp_max_hyst[i].dev_attr);
-		device_remove_file(dev,
-			&vt1211_sysfs_temp_alarm[i].dev_attr);
-	}
+	for (i = 0; i < ARRAY_SIZE(vt1211_in_attr_group); i++)
+		sysfs_remove_group(&dev->kobj, &vt1211_in_attr_group[i]);
+
+	for (i = 0; i < ARRAY_SIZE(vt1211_temp_attr_group); i++)
+		sysfs_remove_group(&dev->kobj, &vt1211_temp_attr_group[i]);
+
 	for (i = 0; i < ARRAY_SIZE(vt1211_sysfs_fan_pwm); i++) {
 		device_remove_file(dev,
 			&vt1211_sysfs_fan_pwm[i].dev_attr);
@@ -1223,32 +1196,20 @@ static int __devinit vt1211_probe(struct platform_device *pdev)
 	vt1211_init_device(data);
 
 	/* Create sysfs interface files */
-	for (i = 0; i < ARRAY_SIZE(vt1211_sysfs_in_input); i++) {
+	for (i = 0; i < ARRAY_SIZE(vt1211_in_attr_group); i++) {
 		if (ISVOLT(i, data->uch_config)) {
-			if ((err = device_create_file(dev,
-				&vt1211_sysfs_in_input[i].dev_attr)) ||
-			    (err = device_create_file(dev,
-				&vt1211_sysfs_in_min[i].dev_attr)) ||
-			    (err = device_create_file(dev,
-				&vt1211_sysfs_in_max[i].dev_attr)) ||
-			    (err = device_create_file(dev,
-				&vt1211_sysfs_in_alarm[i].dev_attr))) {
+			err = sysfs_create_group(&dev->kobj,
+						 &vt1211_in_attr_group[i]);
+			if (err)
 				goto EXIT_DEV_REMOVE;
-			}
 		}
 	}
-	for (i = 0; i < ARRAY_SIZE(vt1211_sysfs_temp_input); i++) {
+	for (i = 0; i < ARRAY_SIZE(vt1211_temp_attr_group); i++) {
 		if (ISTEMP(i, data->uch_config)) {
-			if ((err = device_create_file(dev,
-				&vt1211_sysfs_temp_input[i].dev_attr)) ||
-			    (err = device_create_file(dev,
-				&vt1211_sysfs_temp_max[i].dev_attr)) ||
-			    (err = device_create_file(dev,
-				&vt1211_sysfs_temp_max_hyst[i].dev_attr)) ||
-			    (err = device_create_file(dev,
-				&vt1211_sysfs_temp_alarm[i].dev_attr))) {
+			err = sysfs_create_group(&dev->kobj,
+						 &vt1211_temp_attr_group[i]);
+			if (err)
 				goto EXIT_DEV_REMOVE;
-			}
 		}
 	}
 	for (i = 0; i < ARRAY_SIZE(vt1211_sysfs_fan_pwm); i++) {
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
