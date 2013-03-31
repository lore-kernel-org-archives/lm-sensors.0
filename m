From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 31 Mar 2013 18:09:38 +0000
Subject: [lm-sensors] [PATCH 4/5] hwmon: (it87) Use is_visible for pwm attributes
Message-Id: <1364753379-20222-5-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Simplify code and reduce object size by about 250 bytes on x86_64.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/it87.c |   97 ++++++++++++++++++++------------------------------
 1 file changed, 39 insertions(+), 58 deletions(-)

diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index a096f16..a6cc41d 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -1630,34 +1630,30 @@ static const struct attribute_group it87_group_fan = {
 	.is_visible = it87_fan_is_visible,
 };
 
-static struct attribute *it87_attributes_pwm[3][4+1] = { {
+static umode_t it87_pwm_is_visible(struct kobject *kobj,
+				   struct attribute *attr, int index)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct it87_data *data = dev_get_drvdata(dev);
+	struct it87_sio_data *sio_data = dev->platform_data;
+	int i = index / 13;	/* pwm index */
+	int a = index % 13;	/* attribute index */
+
+	if (sio_data->skip_pwm & (1 << i))
+		return 0;
+
+	if (a >= 4 && !has_old_autopwm(data))
+		return 0;
+
+	return attr->mode;
+}
+
+static struct attribute *it87_attributes_pwm[] = {
 	&sensor_dev_attr_pwm1_enable.dev_attr.attr,
 	&sensor_dev_attr_pwm1.dev_attr.attr,
 	&dev_attr_pwm1_freq.attr,
 	&sensor_dev_attr_pwm1_auto_channels_temp.dev_attr.attr,
-	NULL
-}, {
-	&sensor_dev_attr_pwm2_enable.dev_attr.attr,
-	&sensor_dev_attr_pwm2.dev_attr.attr,
-	&dev_attr_pwm2_freq.attr,
-	&sensor_dev_attr_pwm2_auto_channels_temp.dev_attr.attr,
-	NULL
-}, {
-	&sensor_dev_attr_pwm3_enable.dev_attr.attr,
-	&sensor_dev_attr_pwm3.dev_attr.attr,
-	&dev_attr_pwm3_freq.attr,
-	&sensor_dev_attr_pwm3_auto_channels_temp.dev_attr.attr,
-	NULL
-} };
-
-static const struct attribute_group it87_group_pwm[3] = {
-	{ .attrs = it87_attributes_pwm[0] },
-	{ .attrs = it87_attributes_pwm[1] },
-	{ .attrs = it87_attributes_pwm[2] },
-};
-
-static struct attribute *it87_attributes_autopwm[3][9+1] = { {
-	&sensor_dev_attr_pwm1_auto_point1_pwm.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_point1_pwm.dev_attr.attr,	/* 4 .. 12 */
 	&sensor_dev_attr_pwm1_auto_point2_pwm.dev_attr.attr,
 	&sensor_dev_attr_pwm1_auto_point3_pwm.dev_attr.attr,
 	&sensor_dev_attr_pwm1_auto_point4_pwm.dev_attr.attr,
@@ -1666,8 +1662,11 @@ static struct attribute *it87_attributes_autopwm[3][9+1] = { {
 	&sensor_dev_attr_pwm1_auto_point2_temp.dev_attr.attr,
 	&sensor_dev_attr_pwm1_auto_point3_temp.dev_attr.attr,
 	&sensor_dev_attr_pwm1_auto_point4_temp.dev_attr.attr,
-	NULL
-}, {
+
+	&sensor_dev_attr_pwm2_enable.dev_attr.attr,
+	&sensor_dev_attr_pwm2.dev_attr.attr,
+	&dev_attr_pwm2_freq.attr,
+	&sensor_dev_attr_pwm2_auto_channels_temp.dev_attr.attr,
 	&sensor_dev_attr_pwm2_auto_point1_pwm.dev_attr.attr,
 	&sensor_dev_attr_pwm2_auto_point2_pwm.dev_attr.attr,
 	&sensor_dev_attr_pwm2_auto_point3_pwm.dev_attr.attr,
@@ -1677,8 +1676,11 @@ static struct attribute *it87_attributes_autopwm[3][9+1] = { {
 	&sensor_dev_attr_pwm2_auto_point2_temp.dev_attr.attr,
 	&sensor_dev_attr_pwm2_auto_point3_temp.dev_attr.attr,
 	&sensor_dev_attr_pwm2_auto_point4_temp.dev_attr.attr,
-	NULL
-}, {
+
+	&sensor_dev_attr_pwm3_enable.dev_attr.attr,
+	&sensor_dev_attr_pwm3.dev_attr.attr,
+	&dev_attr_pwm3_freq.attr,
+	&sensor_dev_attr_pwm3_auto_channels_temp.dev_attr.attr,
 	&sensor_dev_attr_pwm3_auto_point1_pwm.dev_attr.attr,
 	&sensor_dev_attr_pwm3_auto_point2_pwm.dev_attr.attr,
 	&sensor_dev_attr_pwm3_auto_point3_pwm.dev_attr.attr,
@@ -1688,13 +1690,13 @@ static struct attribute *it87_attributes_autopwm[3][9+1] = { {
 	&sensor_dev_attr_pwm3_auto_point2_temp.dev_attr.attr,
 	&sensor_dev_attr_pwm3_auto_point3_temp.dev_attr.attr,
 	&sensor_dev_attr_pwm3_auto_point4_temp.dev_attr.attr,
+
 	NULL
-} };
+};
 
-static const struct attribute_group it87_group_autopwm[3] = {
-	{ .attrs = it87_attributes_autopwm[0] },
-	{ .attrs = it87_attributes_autopwm[1] },
-	{ .attrs = it87_attributes_autopwm[2] },
+static const struct attribute_group it87_group_pwm = {
+	.attrs = it87_attributes_pwm,
+	.is_visible = it87_pwm_is_visible,
 };
 
 static struct attribute *it87_attributes_vid[] = {
@@ -1987,23 +1989,14 @@ exit:
 
 static void it87_remove_files(struct device *dev)
 {
-	struct it87_data *data = platform_get_drvdata(pdev);
 	struct it87_sio_data *sio_data = dev->platform_data;
-	int i;
 
 	sysfs_remove_group(&dev->kobj, &it87_group);
 	sysfs_remove_group(&dev->kobj, &it87_group_in);
 	sysfs_remove_group(&dev->kobj, &it87_group_temp);
 	sysfs_remove_group(&dev->kobj, &it87_group_fan);
+	sysfs_remove_group(&dev->kobj, &it87_group_pwm);
 
-	for (i = 0; i < 3; i++) {
-		if (sio_data->skip_pwm & (1 << 0))
-			continue;
-		sysfs_remove_group(&dev->kobj, &it87_group_pwm[i]);
-		if (has_old_autopwm(data))
-			sysfs_remove_group(&dev->kobj,
-					   &it87_group_autopwm[i]);
-	}
 	if (!sio_data->skip_vid)
 		sysfs_remove_group(&dev->kobj, &it87_group_vid);
 	sysfs_remove_group(&dev->kobj, &it87_group_label);
@@ -2114,21 +2107,9 @@ static int it87_probe(struct platform_device *pdev)
 		goto error;
 
 	if (enable_pwm_interface) {
-		for (i = 0; i < 3; i++) {
-			if (sio_data->skip_pwm & (1 << i))
-				continue;
-			err = sysfs_create_group(&dev->kobj,
-						 &it87_group_pwm[i]);
-			if (err)
-				goto error;
-
-			if (!has_old_autopwm(data))
-				continue;
-			err = sysfs_create_group(&dev->kobj,
-						 &it87_group_autopwm[i]);
-			if (err)
-				goto error;
-		}
+		err = sysfs_create_group(&dev->kobj, &it87_group_pwm);
+		if (err)
+			goto error;
 	}
 
 	if (!sio_data->skip_vid) {
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
