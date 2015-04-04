From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 04 Apr 2015 21:55:05 +0000
Subject: [lm-sensors] [PATCH 14/22] hwmon: (it87) Use is_visible for pwm attributes
Message-Id: <1428184513-22380-15-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Simplify code and reduce object size by about 250 bytes on x86_64.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/it87.c | 137 ++++++++++++++++++++++++---------------------------
 1 file changed, 65 insertions(+), 72 deletions(-)

diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index 82d2950d7898..defb0f8ac161 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -485,6 +485,7 @@ struct it87_data {
 	 * is no longer needed, but it is still done to keep the driver
 	 * simple.
 	 */
+	u8 has_pwm;		/* Bitfield, pwm control enabled */
 	u8 pwm_ctrl[6];		/* Register value */
 	u8 pwm_duty[6];		/* Manual PWM value set by user */
 	u8 pwm_temp_map[6];	/* PWM to temp. chan. mapping (bits 1-0) */
@@ -1320,15 +1321,6 @@ static ssize_t set_pwm_temp_map(struct device *dev,
 	long val;
 	u8 reg;
 
-	/*
-	 * This check can go away if we ever support automatic fan speed
-	 * control on newer chips.
-	 */
-	if (!has_old_autopwm(data)) {
-		dev_notice(dev, "Mapping change disabled for safety reasons\n");
-		return -EINVAL;
-	}
-
 	if (kstrtol(buf, 10, &val) < 0)
 		return -EINVAL;
 
@@ -1462,7 +1454,7 @@ static SENSOR_DEVICE_ATTR(pwm1_enable, S_IRUGO | S_IWUSR,
 static SENSOR_DEVICE_ATTR(pwm1, S_IRUGO | S_IWUSR, show_pwm, set_pwm, 0);
 static SENSOR_DEVICE_ATTR(pwm1_freq, S_IRUGO | S_IWUSR, show_pwm_freq,
 			  set_pwm_freq, 0);
-static SENSOR_DEVICE_ATTR(pwm1_auto_channels_temp, S_IRUGO | S_IWUSR,
+static SENSOR_DEVICE_ATTR(pwm1_auto_channels_temp, S_IRUGO,
 			  show_pwm_temp_map, set_pwm_temp_map, 0);
 static SENSOR_DEVICE_ATTR_2(pwm1_auto_point1_pwm, S_IRUGO | S_IWUSR,
 			    show_auto_pwm, set_auto_pwm, 0, 0);
@@ -1487,7 +1479,7 @@ static SENSOR_DEVICE_ATTR(pwm2_enable, S_IRUGO | S_IWUSR,
 			  show_pwm_enable, set_pwm_enable, 1);
 static SENSOR_DEVICE_ATTR(pwm2, S_IRUGO | S_IWUSR, show_pwm, set_pwm, 1);
 static SENSOR_DEVICE_ATTR(pwm2_freq, S_IRUGO, show_pwm_freq, set_pwm_freq, 1);
-static SENSOR_DEVICE_ATTR(pwm2_auto_channels_temp, S_IRUGO | S_IWUSR,
+static SENSOR_DEVICE_ATTR(pwm2_auto_channels_temp, S_IRUGO,
 			  show_pwm_temp_map, set_pwm_temp_map, 1);
 static SENSOR_DEVICE_ATTR_2(pwm2_auto_point1_pwm, S_IRUGO | S_IWUSR,
 			    show_auto_pwm, set_auto_pwm, 1, 0);
@@ -1512,7 +1504,7 @@ static SENSOR_DEVICE_ATTR(pwm3_enable, S_IRUGO | S_IWUSR,
 			  show_pwm_enable, set_pwm_enable, 2);
 static SENSOR_DEVICE_ATTR(pwm3, S_IRUGO | S_IWUSR, show_pwm, set_pwm, 2);
 static SENSOR_DEVICE_ATTR(pwm3_freq, S_IRUGO, show_pwm_freq, NULL, 2);
-static SENSOR_DEVICE_ATTR(pwm3_auto_channels_temp, S_IRUGO | S_IWUSR,
+static SENSOR_DEVICE_ATTR(pwm3_auto_channels_temp, S_IRUGO,
 			  show_pwm_temp_map, set_pwm_temp_map, 2);
 static SENSOR_DEVICE_ATTR_2(pwm3_auto_point1_pwm, S_IRUGO | S_IWUSR,
 			    show_auto_pwm, set_auto_pwm, 2, 0);
@@ -1537,21 +1529,21 @@ static SENSOR_DEVICE_ATTR(pwm4_enable, S_IRUGO | S_IWUSR,
 			  show_pwm_enable, set_pwm_enable, 3);
 static SENSOR_DEVICE_ATTR(pwm4, S_IRUGO | S_IWUSR, show_pwm, set_pwm, 3);
 static SENSOR_DEVICE_ATTR(pwm4_freq, S_IRUGO, show_pwm_freq, NULL, 3);
-static SENSOR_DEVICE_ATTR(pwm4_auto_channels_temp, S_IRUGO | S_IWUSR,
+static SENSOR_DEVICE_ATTR(pwm4_auto_channels_temp, S_IRUGO,
 			  show_pwm_temp_map, set_pwm_temp_map, 3);
 
 static SENSOR_DEVICE_ATTR(pwm5_enable, S_IRUGO | S_IWUSR,
 			  show_pwm_enable, set_pwm_enable, 4);
 static SENSOR_DEVICE_ATTR(pwm5, S_IRUGO | S_IWUSR, show_pwm, set_pwm, 4);
 static SENSOR_DEVICE_ATTR(pwm5_freq, S_IRUGO, show_pwm_freq, NULL, 4);
-static SENSOR_DEVICE_ATTR(pwm5_auto_channels_temp, S_IRUGO | S_IWUSR,
+static SENSOR_DEVICE_ATTR(pwm5_auto_channels_temp, S_IRUGO,
 			  show_pwm_temp_map, set_pwm_temp_map, 4);
 
 static SENSOR_DEVICE_ATTR(pwm6_enable, S_IRUGO | S_IWUSR,
 			  show_pwm_enable, set_pwm_enable, 5);
 static SENSOR_DEVICE_ATTR(pwm6, S_IRUGO | S_IWUSR, show_pwm, set_pwm, 5);
 static SENSOR_DEVICE_ATTR(pwm6_freq, S_IRUGO, show_pwm_freq, NULL, 5);
-static SENSOR_DEVICE_ATTR(pwm6_auto_channels_temp, S_IRUGO | S_IWUSR,
+static SENSOR_DEVICE_ATTR(pwm6_auto_channels_temp, S_IRUGO,
 			  show_pwm_temp_map, set_pwm_temp_map, 5);
 
 /* Alarms */
@@ -1944,67 +1936,81 @@ static const struct attribute_group it87_group_fan = {
 	.is_visible = it87_fan_is_visible,
 };
 
-static struct attribute *it87_attributes_pwm[6][4+1] = { {
+static umode_t it87_pwm_is_visible(struct kobject *kobj,
+				   struct attribute *attr, int index)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct it87_data *data = dev_get_drvdata(dev);
+	int i = index / 4;	/* pwm index */
+	int a = index % 4;	/* attribute index */
+
+	if (!(data->has_pwm & (1 << i)))
+		return 0;
+
+	/* pwmX_auto_channels_temp is only writable for old auto pwm */
+	if (a = 3 && has_old_autopwm(data))
+		return attr->mode | S_IWUSR;
+
+	/* pwm2_freq is writable if there are two pwm frequency selects */
+	if (has_pwm_freq2(data) && i = 1 && a = 2)
+		return attr->mode | S_IWUSR;
+
+	return attr->mode;
+}
+
+static struct attribute *it87_attributes_pwm[] = {
 	&sensor_dev_attr_pwm1_enable.dev_attr.attr,
 	&sensor_dev_attr_pwm1.dev_attr.attr,
 	&sensor_dev_attr_pwm1_freq.dev_attr.attr,
 	&sensor_dev_attr_pwm1_auto_channels_temp.dev_attr.attr,
-	NULL
-}, {
+
 	&sensor_dev_attr_pwm2_enable.dev_attr.attr,
 	&sensor_dev_attr_pwm2.dev_attr.attr,
 	&sensor_dev_attr_pwm2_freq.dev_attr.attr,
 	&sensor_dev_attr_pwm2_auto_channels_temp.dev_attr.attr,
-	NULL
-}, {
+
 	&sensor_dev_attr_pwm3_enable.dev_attr.attr,
 	&sensor_dev_attr_pwm3.dev_attr.attr,
 	&sensor_dev_attr_pwm3_freq.dev_attr.attr,
 	&sensor_dev_attr_pwm3_auto_channels_temp.dev_attr.attr,
-	NULL
-}, {
+
 	&sensor_dev_attr_pwm4_enable.dev_attr.attr,
 	&sensor_dev_attr_pwm4.dev_attr.attr,
 	&sensor_dev_attr_pwm4_freq.dev_attr.attr,
 	&sensor_dev_attr_pwm4_auto_channels_temp.dev_attr.attr,
-	NULL
-}, {
+
 	&sensor_dev_attr_pwm5_enable.dev_attr.attr,
 	&sensor_dev_attr_pwm5.dev_attr.attr,
 	&sensor_dev_attr_pwm5_freq.dev_attr.attr,
 	&sensor_dev_attr_pwm5_auto_channels_temp.dev_attr.attr,
-	NULL
-}, {
+
 	&sensor_dev_attr_pwm6_enable.dev_attr.attr,
 	&sensor_dev_attr_pwm6.dev_attr.attr,
 	&sensor_dev_attr_pwm6_freq.dev_attr.attr,
 	&sensor_dev_attr_pwm6_auto_channels_temp.dev_attr.attr,
+
 	NULL
-} };
+};
 
-static umode_t pwm_attribute_mode(struct kobject *kobj, struct attribute *attr,
-				  int index)
+static const struct attribute_group it87_group_pwm = {
+	.attrs = it87_attributes_pwm,
+	.is_visible = it87_pwm_is_visible,
+};
+
+static umode_t it87_auto_pwm_is_visible(struct kobject *kobj,
+					struct attribute *attr, int index)
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
 	struct it87_data *data = dev_get_drvdata(dev);
+	int i = index / 9;	/* pwm index */
 
-	if (has_pwm_freq2(data) && index = 2)
-		return attr->mode | S_IWUSR;
+	if (!(data->has_pwm & (1 << i)))
+		return 0;
 
 	return attr->mode;
 }
 
-static const struct attribute_group it87_group_pwm[6] = {
-	{ .attrs = it87_attributes_pwm[0] },
-	{ .attrs = it87_attributes_pwm[1],
-	  .is_visible = pwm_attribute_mode, },
-	{ .attrs = it87_attributes_pwm[2] },
-	{ .attrs = it87_attributes_pwm[3] },
-	{ .attrs = it87_attributes_pwm[4] },
-	{ .attrs = it87_attributes_pwm[5] },
-};
-
-static struct attribute *it87_attributes_autopwm[3][9+1] = { {
+static struct attribute *it87_attributes_auto_pwm[] = {
 	&sensor_dev_attr_pwm1_auto_point1_pwm.dev_attr.attr,
 	&sensor_dev_attr_pwm1_auto_point2_pwm.dev_attr.attr,
 	&sensor_dev_attr_pwm1_auto_point3_pwm.dev_attr.attr,
@@ -2014,8 +2020,7 @@ static struct attribute *it87_attributes_autopwm[3][9+1] = { {
 	&sensor_dev_attr_pwm1_auto_point2_temp.dev_attr.attr,
 	&sensor_dev_attr_pwm1_auto_point3_temp.dev_attr.attr,
 	&sensor_dev_attr_pwm1_auto_point4_temp.dev_attr.attr,
-	NULL
-}, {
+
 	&sensor_dev_attr_pwm2_auto_point1_pwm.dev_attr.attr,
 	&sensor_dev_attr_pwm2_auto_point2_pwm.dev_attr.attr,
 	&sensor_dev_attr_pwm2_auto_point3_pwm.dev_attr.attr,
@@ -2025,8 +2030,7 @@ static struct attribute *it87_attributes_autopwm[3][9+1] = { {
 	&sensor_dev_attr_pwm2_auto_point2_temp.dev_attr.attr,
 	&sensor_dev_attr_pwm2_auto_point3_temp.dev_attr.attr,
 	&sensor_dev_attr_pwm2_auto_point4_temp.dev_attr.attr,
-	NULL
-}, {
+
 	&sensor_dev_attr_pwm3_auto_point1_pwm.dev_attr.attr,
 	&sensor_dev_attr_pwm3_auto_point2_pwm.dev_attr.attr,
 	&sensor_dev_attr_pwm3_auto_point3_pwm.dev_attr.attr,
@@ -2036,13 +2040,13 @@ static struct attribute *it87_attributes_autopwm[3][9+1] = { {
 	&sensor_dev_attr_pwm3_auto_point2_temp.dev_attr.attr,
 	&sensor_dev_attr_pwm3_auto_point3_temp.dev_attr.attr,
 	&sensor_dev_attr_pwm3_auto_point4_temp.dev_attr.attr,
-	NULL
-} };
 
-static const struct attribute_group it87_group_autopwm[3] = {
-	{ .attrs = it87_attributes_autopwm[0] },
-	{ .attrs = it87_attributes_autopwm[1] },
-	{ .attrs = it87_attributes_autopwm[2] },
+	NULL,
+};
+
+static const struct attribute_group it87_group_auto_pwm = {
+	.attrs = it87_attributes_auto_pwm,
+	.is_visible = it87_auto_pwm_is_visible,
 };
 
 static struct attribute *it87_attributes_vid[] = {
@@ -2428,23 +2432,15 @@ exit:
 
 static void it87_remove_files(struct device *dev)
 {
-	struct it87_data *data = dev_get_drvdata(dev);
 	struct it87_sio_data *sio_data = dev_get_platdata(dev);
-	int i;
 
 	sysfs_remove_group(&dev->kobj, &it87_group);
 	sysfs_remove_group(&dev->kobj, &it87_group_in);
 	sysfs_remove_group(&dev->kobj, &it87_group_temp);
 	sysfs_remove_group(&dev->kobj, &it87_group_fan);
+	sysfs_remove_group(&dev->kobj, &it87_group_pwm);
+	sysfs_remove_group(&dev->kobj, &it87_group_auto_pwm);
 
-	for (i = 0; i < 6; i++) {
-		if (sio_data->skip_pwm & (1 << i))
-			continue;
-		sysfs_remove_group(&dev->kobj, &it87_group_pwm[i]);
-		if (has_old_autopwm(data))
-			sysfs_remove_group(&dev->kobj,
-					   &it87_group_autopwm[i]);
-	}
 	if (!sio_data->skip_vid)
 		sysfs_remove_group(&dev->kobj, &it87_group_vid);
 	sysfs_remove_group(&dev->kobj, &it87_group_label);
@@ -2731,18 +2727,15 @@ static int it87_probe(struct platform_device *pdev)
 		goto error;
 
 	if (enable_pwm_interface) {
-		for (i = 0; i < 6; i++) {
-			if (sio_data->skip_pwm & (1 << i))
-				continue;
-			err = sysfs_create_group(&dev->kobj,
-						 &it87_group_pwm[i]);
-			if (err)
-				goto error;
+		data->has_pwm = (1 << ARRAY_SIZE(IT87_REG_PWM)) - 1;
+		data->has_pwm &= ~sio_data->skip_pwm;
 
-			if (!has_old_autopwm(data))
-				continue;
+		err = sysfs_create_group(&dev->kobj, &it87_group_pwm);
+		if (err)
+			goto error;
+		if (has_old_autopwm(data)) {
 			err = sysfs_create_group(&dev->kobj,
-						 &it87_group_autopwm[i]);
+						 &it87_group_auto_pwm);
 			if (err)
 				goto error;
 		}
-- 
2.1.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
