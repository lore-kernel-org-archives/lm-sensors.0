From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 31 Mar 2013 18:09:37 +0000
Subject: [lm-sensors] [PATCH 3/5] hwmon: (it87) Use is_visible for fan attributes
Message-Id: <1364753379-20222-4-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Simplify code and reduce object size by almost 500 bytes on x86_64.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/it87.c |  125 +++++++++++++++++++-------------------------------
 1 file changed, 47 insertions(+), 78 deletions(-)

diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index 5066439..a096f16 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -1567,45 +1567,67 @@ static const struct attribute_group it87_group = {
 	.attrs = it87_attributes,
 };
 
-static struct attribute *it87_attributes_fan[5][3+1] = { {
+static umode_t it87_fan_is_visible(struct kobject *kobj,
+				   struct attribute *attr, int index)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct it87_data *data = dev_get_drvdata(dev);
+	struct it87_sio_data *sio_data = dev->platform_data;
+	int i = index / 5;	/* fan index */
+	int a = index % 5;	/* attribute index */
+
+	if (!(data->has_fan & (1 << i)))
+		return 0;
+
+	if (a = 3) {			/* beep */
+		if (!sio_data->beep_pin)
+			return 0;
+		/* first fan beep attribute is writable */
+		if (i = __ffs(data->has_fan))
+			return attr->mode | S_IWUSR;
+	}
+
+	if (a = 4 && (i > 2 || has_16bit_fans(data)))
+		return 0;
+
+	return attr->mode;
+}
+
+static struct attribute *it87_attributes_fan[] = {
 	&sensor_dev_attr_fan1_input.dev_attr.attr,
 	&sensor_dev_attr_fan1_min.dev_attr.attr,
 	&sensor_dev_attr_fan1_alarm.dev_attr.attr,
-	NULL
-}, {
+	&sensor_dev_attr_fan1_beep.dev_attr.attr,	/* 3 */
+	&sensor_dev_attr_fan1_div.dev_attr.attr,	/* 4 */
+
 	&sensor_dev_attr_fan2_input.dev_attr.attr,
 	&sensor_dev_attr_fan2_min.dev_attr.attr,
 	&sensor_dev_attr_fan2_alarm.dev_attr.attr,
-	NULL
-}, {
+	&sensor_dev_attr_fan2_beep.dev_attr.attr,
+	&sensor_dev_attr_fan2_div.dev_attr.attr,
+
 	&sensor_dev_attr_fan3_input.dev_attr.attr,
 	&sensor_dev_attr_fan3_min.dev_attr.attr,
 	&sensor_dev_attr_fan3_alarm.dev_attr.attr,
-	NULL
-}, {
+	&sensor_dev_attr_fan3_beep.dev_attr.attr,
+	&sensor_dev_attr_fan3_div.dev_attr.attr,
+
 	&sensor_dev_attr_fan4_input.dev_attr.attr,
 	&sensor_dev_attr_fan4_min.dev_attr.attr,
 	&sensor_dev_attr_fan4_alarm.dev_attr.attr,
-	NULL
-}, {
+	&sensor_dev_attr_fan4_beep.dev_attr.attr,
+	&sensor_dev_attr_fan4_beep.dev_attr.attr,	/* dummy */
+
 	&sensor_dev_attr_fan5_input.dev_attr.attr,
 	&sensor_dev_attr_fan5_min.dev_attr.attr,
 	&sensor_dev_attr_fan5_alarm.dev_attr.attr,
+	&sensor_dev_attr_fan5_beep.dev_attr.attr,
 	NULL
-} };
-
-static const struct attribute_group it87_group_fan[5] = {
-	{ .attrs = it87_attributes_fan[0] },
-	{ .attrs = it87_attributes_fan[1] },
-	{ .attrs = it87_attributes_fan[2] },
-	{ .attrs = it87_attributes_fan[3] },
-	{ .attrs = it87_attributes_fan[4] },
 };
 
-static const struct attribute *it87_attributes_fan_div[] = {
-	&sensor_dev_attr_fan1_div.dev_attr.attr,
-	&sensor_dev_attr_fan2_div.dev_attr.attr,
-	&sensor_dev_attr_fan3_div.dev_attr.attr,
+static const struct attribute_group it87_group_fan = {
+	.attrs = it87_attributes_fan,
+	.is_visible = it87_fan_is_visible,
 };
 
 static struct attribute *it87_attributes_pwm[3][4+1] = { {
@@ -1675,14 +1697,6 @@ static const struct attribute_group it87_group_autopwm[3] = {
 	{ .attrs = it87_attributes_autopwm[2] },
 };
 
-static struct attribute *it87_attributes_fan_beep[] = {
-	&sensor_dev_attr_fan1_beep.dev_attr.attr,
-	&sensor_dev_attr_fan2_beep.dev_attr.attr,
-	&sensor_dev_attr_fan3_beep.dev_attr.attr,
-	&sensor_dev_attr_fan4_beep.dev_attr.attr,
-	&sensor_dev_attr_fan5_beep.dev_attr.attr,
-};
-
 static struct attribute *it87_attributes_vid[] = {
 	&dev_attr_vrm.attr,
 	&dev_attr_cpu0_vid.attr,
@@ -1980,18 +1994,8 @@ static void it87_remove_files(struct device *dev)
 	sysfs_remove_group(&dev->kobj, &it87_group);
 	sysfs_remove_group(&dev->kobj, &it87_group_in);
 	sysfs_remove_group(&dev->kobj, &it87_group_temp);
+	sysfs_remove_group(&dev->kobj, &it87_group_fan);
 
-	for (i = 0; i < 5; i++) {
-		if (!(data->has_fan & (1 << i)))
-			continue;
-		sysfs_remove_group(&dev->kobj, &it87_group_fan[i]);
-		if (sio_data->beep_pin)
-			sysfs_remove_file(&dev->kobj,
-					  it87_attributes_fan_beep[i]);
-		if (i < 3 && !has_16bit_fans(data))
-			sysfs_remove_file(&dev->kobj,
-					  it87_attributes_fan_div[i]);
-	}
 	for (i = 0; i < 3; i++) {
 		if (sio_data->skip_pwm & (1 << 0))
 			continue;
@@ -2013,7 +2017,6 @@ static int it87_probe(struct platform_device *pdev)
 	struct it87_sio_data *sio_data = dev->platform_data;
 	int err = 0, i;
 	int enable_pwm_interface;
-	int fan_beep_need_rw;
 
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
 	if (!devm_request_region(&pdev->dev, res->start, IT87_EC_EXTENT,
@@ -2106,43 +2109,9 @@ static int it87_probe(struct platform_device *pdev)
 	if (err)
 		goto error;
 
-	/* Do not create fan files for disabled fans */
-	fan_beep_need_rw = 1;
-	for (i = 0; i < 5; i++) {
-		if (!(data->has_fan & (1 << i)))
-			continue;
-		err = sysfs_create_group(&dev->kobj, &it87_group_fan[i]);
-		if (err)
-			goto error;
-
-		if (i < 3 && !has_16bit_fans(data)) {
-			err = sysfs_create_file(&dev->kobj,
-						it87_attributes_fan_div[i]);
-			if (err)
-				goto error;
-		}
-
-		if (sio_data->beep_pin) {
-			err = sysfs_create_file(&dev->kobj,
-						it87_attributes_fan_beep[i]);
-			if (err)
-				goto error;
-			if (!fan_beep_need_rw)
-				continue;
-
-			/*
-			 * As we have a single beep enable bit for all fans,
-			 * only the first enabled fan has a writable attribute
-			 * for it.
-			 */
-			if (sysfs_chmod_file(&dev->kobj,
-					     it87_attributes_fan_beep[i],
-					     S_IRUGO | S_IWUSR))
-				dev_dbg(dev, "chmod +w fan%d_beep failed\n",
-					i + 1);
-			fan_beep_need_rw = 0;
-		}
-	}
+	err = sysfs_create_group(&dev->kobj, &it87_group_fan);
+	if (err)
+		goto error;
 
 	if (enable_pwm_interface) {
 		for (i = 0; i < 3; i++) {
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
