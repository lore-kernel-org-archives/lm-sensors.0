From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 20 Jan 2012 19:39:17 +0000
Subject: [lm-sensors] [PATCH 05/13] hwmon: (pc87360) Fix: do not use assignment in if condition
Message-Id: <1327088365-11149-6-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fix checkpatch issue:
ERROR: do not use assignment in if condition

Replace repeated calls to device_create_file() with calls to sysfs_create_group.

Cc: Jim Cromie <jim.cromie@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pc87360.c |  129 +++++++++++++++++++++--------------------------
 1 files changed, 58 insertions(+), 71 deletions(-)

diff --git a/drivers/hwmon/pc87360.c b/drivers/hwmon/pc87360.c
index 7f95761..47d9949 100644
--- a/drivers/hwmon/pc87360.c
+++ b/drivers/hwmon/pc87360.c
@@ -346,11 +346,13 @@ static struct sensor_device_attribute fan_min[] = {
 	SENSOR_ATTR(fan3_min, S_IWUSR | S_IRUGO, show_fan_min, set_fan_min, 2),
 };
 
-#define FAN_UNIT_ATTRS(X)	\
-	&fan_input[X].dev_attr.attr,	\
+#define FAN_UNIT_ATTRS(X)		\
+{	&fan_input[X].dev_attr.attr,	\
 	&fan_status[X].dev_attr.attr,	\
 	&fan_div[X].dev_attr.attr,	\
-	&fan_min[X].dev_attr.attr
+	&fan_min[X].dev_attr.attr,	\
+	NULL				\
+}
 
 static ssize_t show_pwm(struct device *dev, struct device_attribute *devattr,
 			char *buf)
@@ -389,17 +391,16 @@ static struct sensor_device_attribute pwm[] = {
 	SENSOR_ATTR(pwm3, S_IWUSR | S_IRUGO, show_pwm, set_pwm, 2),
 };
 
-static struct attribute *pc8736x_fan_attr_array[] = {
+static struct attribute *pc8736x_fan_attr[][5] = {
 	FAN_UNIT_ATTRS(0),
 	FAN_UNIT_ATTRS(1),
-	FAN_UNIT_ATTRS(2),
-	&pwm[0].dev_attr.attr,
-	&pwm[1].dev_attr.attr,
-	&pwm[2].dev_attr.attr,
-	NULL
+	FAN_UNIT_ATTRS(2)
 };
-static const struct attribute_group pc8736x_fan_group = {
-	.attrs = pc8736x_fan_attr_array,
+
+static const struct attribute_group pc8736x_fan_attr_group[] = {
+	{ .attrs = pc8736x_fan_attr[0], },
+	{ .attrs = pc8736x_fan_attr[1], },
+	{ .attrs = pc8736x_fan_attr[2], },
 };
 
 static ssize_t show_in_input(struct device *dev,
@@ -1078,28 +1079,29 @@ static struct sensor_device_attribute temp_fault[] = {
 	SENSOR_ATTR(temp3_fault, S_IRUGO, show_temp_fault, NULL, 2),
 };
 
-#define TEMP_UNIT_ATTRS(X) \
-	&temp_input[X].dev_attr.attr,	\
-	&temp_status[X].dev_attr.attr,	\
-	&temp_min[X].dev_attr.attr,	\
-	&temp_max[X].dev_attr.attr,	\
-	&temp_crit[X].dev_attr.attr,	\
-	&temp_min_alarm[X].dev_attr.attr, \
-	&temp_max_alarm[X].dev_attr.attr, \
-	&temp_crit_alarm[X].dev_attr.attr, \
-	&temp_fault[X].dev_attr.attr
-
-static struct attribute *pc8736x_temp_attr_array[] = {
+#define TEMP_UNIT_ATTRS(X)			\
+{	&temp_input[X].dev_attr.attr,		\
+	&temp_status[X].dev_attr.attr,		\
+	&temp_min[X].dev_attr.attr,		\
+	&temp_max[X].dev_attr.attr,		\
+	&temp_crit[X].dev_attr.attr,		\
+	&temp_min_alarm[X].dev_attr.attr,	\
+	&temp_max_alarm[X].dev_attr.attr,	\
+	&temp_crit_alarm[X].dev_attr.attr,	\
+	&temp_fault[X].dev_attr.attr,		\
+	NULL					\
+}
+
+static struct attribute *pc8736x_temp_attr[][10] = {
 	TEMP_UNIT_ATTRS(0),
 	TEMP_UNIT_ATTRS(1),
-	TEMP_UNIT_ATTRS(2),
-	/* include the few miscellaneous atts here */
-	&dev_attr_alarms_temp.attr,
-	NULL
+	TEMP_UNIT_ATTRS(2)
 };
 
-static const struct attribute_group pc8736x_temp_group = {
-	.attrs = pc8736x_temp_attr_array,
+static const struct attribute_group pc8736x_temp_attr_group[] = {
+	{ .attrs = pc8736x_temp_attr[0] },
+	{ .attrs = pc8736x_temp_attr[1] },
+	{ .attrs = pc8736x_temp_attr[2] }
 };
 
 static ssize_t show_name(struct device *dev,
@@ -1203,6 +1205,22 @@ static int __init pc87360_find(int sioaddr, u8 *devid,
 	return 0;
 }
 
+static void pc87360_remove_files(struct device *dev)
+{
+	int i;
+
+	device_remove_file(dev, &dev_attr_name);
+	device_remove_file(dev, &dev_attr_alarms_temp);
+	for (i = 0; i < ARRAY_SIZE(pc8736x_temp_attr_group); i++)
+		sysfs_remove_group(&dev->kobj, &pc8736x_temp_attr_group[i]);
+	for (i = 0; i < ARRAY_SIZE(pc8736x_fan_attr_group); i++) {
+		sysfs_remove_group(&pdev->dev.kobj, &pc8736x_fan_attr_group[i]);
+		device_remove_file(dev, &pwm[i].dev_attr);
+	}
+	sysfs_remove_group(&dev->kobj, &pc8736x_therm_group);
+	sysfs_remove_group(&dev->kobj, &pc8736x_vin_group);
+}
+
 static int __devinit pc87360_probe(struct platform_device *pdev)
 {
 	int i;
@@ -1320,24 +1338,9 @@ static int __devinit pc87360_probe(struct platform_device *pdev)
 
 	if (data->tempnr) {
 		for (i = 0; i < data->tempnr; i++) {
-			if ((err = device_create_file(dev,
-					&temp_input[i].dev_attr))
-			    || (err = device_create_file(dev,
-					&temp_min[i].dev_attr))
-			    || (err = device_create_file(dev,
-					&temp_max[i].dev_attr))
-			    || (err = device_create_file(dev,
-					&temp_crit[i].dev_attr))
-			    || (err = device_create_file(dev,
-					&temp_status[i].dev_attr))
-			    || (err = device_create_file(dev,
-					&temp_min_alarm[i].dev_attr))
-			    || (err = device_create_file(dev,
-					&temp_max_alarm[i].dev_attr))
-			    || (err = device_create_file(dev,
-					&temp_crit_alarm[i].dev_attr))
-			    || (err = device_create_file(dev,
-					&temp_fault[i].dev_attr)))
+			err = sysfs_create_group(&dev->kobj,
+						 &pc8736x_temp_attr_group[i]);
+			if (err)
 				goto ERROR3;
 		}
 		err = device_create_file(dev, &dev_attr_alarms_temp);
@@ -1346,17 +1349,12 @@ static int __devinit pc87360_probe(struct platform_device *pdev)
 	}
 
 	for (i = 0; i < data->fannr; i++) {
-		if (FAN_CONFIG_MONITOR(data->fan_conf, i)
-		    && ((err = device_create_file(dev,
-					&fan_input[i].dev_attr))
-			|| (err = device_create_file(dev,
-					&fan_min[i].dev_attr))
-			|| (err = device_create_file(dev,
-					&fan_div[i].dev_attr))
-			|| (err = device_create_file(dev,
-					&fan_status[i].dev_attr))))
-			goto ERROR3;
-
+		if (FAN_CONFIG_MONITOR(data->fan_conf, i)) {
+			err = sysfs_create_group(&dev->kobj,
+						 &pc8736x_fan_attr_group[i]);
+			if (err)
+				goto ERROR3;
+		}
 		if (FAN_CONFIG_CONTROL(data->fan_conf, i)) {
 			err = device_create_file(dev, &pwm[i].dev_attr);
 			if (err)
@@ -1376,12 +1374,7 @@ static int __devinit pc87360_probe(struct platform_device *pdev)
 	return 0;
 
 ERROR3:
-	device_remove_file(dev, &dev_attr_name);
-	/* can still remove groups whose members were added individually */
-	sysfs_remove_group(&dev->kobj, &pc8736x_temp_group);
-	sysfs_remove_group(&dev->kobj, &pc8736x_fan_group);
-	sysfs_remove_group(&dev->kobj, &pc8736x_therm_group);
-	sysfs_remove_group(&dev->kobj, &pc8736x_vin_group);
+	pc87360_remove_files(dev);
 	for (i = 0; i < 3; i++) {
 		if (data->address[i])
 			release_region(data->address[i], PC87360_EXTENT);
@@ -1397,13 +1390,7 @@ static int __devexit pc87360_remove(struct platform_device *pdev)
 	int i;
 
 	hwmon_device_unregister(data->hwmon_dev);
-
-	device_remove_file(&pdev->dev, &dev_attr_name);
-	sysfs_remove_group(&pdev->dev.kobj, &pc8736x_temp_group);
-	sysfs_remove_group(&pdev->dev.kobj, &pc8736x_fan_group);
-	sysfs_remove_group(&pdev->dev.kobj, &pc8736x_therm_group);
-	sysfs_remove_group(&pdev->dev.kobj, &pc8736x_vin_group);
-
+	pc87360_remove_files(&pdev->dev);
 	for (i = 0; i < 3; i++) {
 		if (data->address[i])
 			release_region(data->address[i], PC87360_EXTENT);
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
