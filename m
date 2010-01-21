From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 21 Jan 2010 13:49:47 +0000
Subject: [lm-sensors] [PATCH 3/8] hwmon: (it87) Refactor attributes creation
Message-Id: <20100121144947.63908165@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali@linux-fr.org>

There is a lot of code redundancy in the creation of the fan and
pwm attributes. Move these attributes to arrays so that the code can
be simplified.

This in turns makes the attributes removal code larger, so move it to
a separate function that can be called in both the standard removal
case and the error path during probing.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/it87.c |  233 ++++++++++++++++++++++----------------------------
 1 file changed, 103 insertions(+), 130 deletions(-)

--- linux-2.6.33-rc4.orig/drivers/hwmon/it87.c	2010-01-19 13:18:39.000000000 +0100
+++ linux-2.6.33-rc4/drivers/hwmon/it87.c	2010-01-19 13:30:10.000000000 +0100
@@ -1014,47 +1014,100 @@ static const struct attribute_group it87
 	.attrs = it87_attributes,
 };
 
-static struct attribute *it87_attributes_opt[] = {
+static struct attribute *it87_attributes_fan16[5][3+1] = { {
 	&sensor_dev_attr_fan1_input16.dev_attr.attr,
 	&sensor_dev_attr_fan1_min16.dev_attr.attr,
+	&sensor_dev_attr_fan1_alarm.dev_attr.attr,
+	NULL
+}, {
 	&sensor_dev_attr_fan2_input16.dev_attr.attr,
 	&sensor_dev_attr_fan2_min16.dev_attr.attr,
+	&sensor_dev_attr_fan2_alarm.dev_attr.attr,
+	NULL
+}, {
 	&sensor_dev_attr_fan3_input16.dev_attr.attr,
 	&sensor_dev_attr_fan3_min16.dev_attr.attr,
+	&sensor_dev_attr_fan3_alarm.dev_attr.attr,
+	NULL
+}, {
 	&sensor_dev_attr_fan4_input16.dev_attr.attr,
 	&sensor_dev_attr_fan4_min16.dev_attr.attr,
+	&sensor_dev_attr_fan4_alarm.dev_attr.attr,
+	NULL
+}, {
 	&sensor_dev_attr_fan5_input16.dev_attr.attr,
 	&sensor_dev_attr_fan5_min16.dev_attr.attr,
+	&sensor_dev_attr_fan5_alarm.dev_attr.attr,
+	NULL
+} };
+
+static const struct attribute_group it87_group_fan16[5] = {
+	{ .attrs = it87_attributes_fan16[0] },
+	{ .attrs = it87_attributes_fan16[1] },
+	{ .attrs = it87_attributes_fan16[2] },
+	{ .attrs = it87_attributes_fan16[3] },
+	{ .attrs = it87_attributes_fan16[4] },
+};
 
+static struct attribute *it87_attributes_fan[3][4+1] = { {
 	&sensor_dev_attr_fan1_input.dev_attr.attr,
 	&sensor_dev_attr_fan1_min.dev_attr.attr,
 	&sensor_dev_attr_fan1_div.dev_attr.attr,
+	&sensor_dev_attr_fan1_alarm.dev_attr.attr,
+	NULL
+}, {
 	&sensor_dev_attr_fan2_input.dev_attr.attr,
 	&sensor_dev_attr_fan2_min.dev_attr.attr,
 	&sensor_dev_attr_fan2_div.dev_attr.attr,
+	&sensor_dev_attr_fan2_alarm.dev_attr.attr,
+	NULL
+}, {
 	&sensor_dev_attr_fan3_input.dev_attr.attr,
 	&sensor_dev_attr_fan3_min.dev_attr.attr,
 	&sensor_dev_attr_fan3_div.dev_attr.attr,
-
-	&sensor_dev_attr_fan1_alarm.dev_attr.attr,
-	&sensor_dev_attr_fan2_alarm.dev_attr.attr,
 	&sensor_dev_attr_fan3_alarm.dev_attr.attr,
-	&sensor_dev_attr_fan4_alarm.dev_attr.attr,
-	&sensor_dev_attr_fan5_alarm.dev_attr.attr,
+	NULL
+} };
+
+static const struct attribute_group it87_group_fan[3] = {
+	{ .attrs = it87_attributes_fan[0] },
+	{ .attrs = it87_attributes_fan[1] },
+	{ .attrs = it87_attributes_fan[2] },
+};
 
+static const struct attribute_group *
+it87_get_fan_group(const struct it87_data *data)
+{
+	return has_16bit_fans(data) ? it87_group_fan16 : it87_group_fan;
+}
+
+static struct attribute *it87_attributes_pwm[3][4+1] = { {
 	&sensor_dev_attr_pwm1_enable.dev_attr.attr,
-	&sensor_dev_attr_pwm2_enable.dev_attr.attr,
-	&sensor_dev_attr_pwm3_enable.dev_attr.attr,
 	&sensor_dev_attr_pwm1.dev_attr.attr,
-	&sensor_dev_attr_pwm2.dev_attr.attr,
-	&sensor_dev_attr_pwm3.dev_attr.attr,
 	&dev_attr_pwm1_freq.attr,
-	&dev_attr_pwm2_freq.attr,
-	&dev_attr_pwm3_freq.attr,
 	&sensor_dev_attr_pwm1_auto_channels_temp.dev_attr.attr,
+	NULL
+}, {
+	&sensor_dev_attr_pwm2_enable.dev_attr.attr,
+	&sensor_dev_attr_pwm2.dev_attr.attr,
+	&dev_attr_pwm2_freq.attr,
 	&sensor_dev_attr_pwm2_auto_channels_temp.dev_attr.attr,
+	NULL
+}, {
+	&sensor_dev_attr_pwm3_enable.dev_attr.attr,
+	&sensor_dev_attr_pwm3.dev_attr.attr,
+	&dev_attr_pwm3_freq.attr,
 	&sensor_dev_attr_pwm3_auto_channels_temp.dev_attr.attr,
+	NULL
+} };
+
+static const struct attribute_group it87_group_pwm[3] = {
+	{ .attrs = it87_attributes_pwm[0] },
+	{ .attrs = it87_attributes_pwm[1] },
+	{ .attrs = it87_attributes_pwm[2] },
+};
 
+static struct attribute *it87_attributes_opt[] = {
 	&dev_attr_vrm.attr,
 	&dev_attr_cpu0_vid.attr,
 	NULL
@@ -1179,13 +1232,35 @@ exit:
 	return err;
 }
 
+static void it87_remove_files(struct device *dev)
+{
+	struct it87_data *data = platform_get_drvdata(pdev);
+	struct it87_sio_data *sio_data = dev->platform_data;
+	const struct attribute_group *fan_group = it87_get_fan_group(data);
+	int i;
+
+	sysfs_remove_group(&dev->kobj, &it87_group);
+	for (i = 0; i < 5; i++) {
+		if (!(data->has_fan & (1 << i)))
+			continue;
+		sysfs_remove_group(&dev->kobj, &fan_group[i]);
+	}
+	for (i = 0; i < 3; i++) {
+		if (sio_data->skip_pwm & (1 << 0))
+			continue;
+		sysfs_remove_group(&dev->kobj, &it87_group_pwm[i]);
+	}
+	sysfs_remove_group(&dev->kobj, &it87_group_opt);
+}
+
 static int __devinit it87_probe(struct platform_device *pdev)
 {
 	struct it87_data *data;
 	struct resource *res;
 	struct device *dev = &pdev->dev;
 	struct it87_sio_data *sio_data = dev->platform_data;
-	int err = 0;
+	const struct attribute_group *fan_group;
+	int err = 0, i;
 	int enable_pwm_interface;
 	static const char *names[] = {
 		"it87",
@@ -1236,122 +1311,22 @@ static int __devinit it87_probe(struct p
 		goto ERROR2;
 
 	/* Do not create fan files for disabled fans */
-	if (has_16bit_fans(data)) {
-		/* 16-bit tachometers */
-		if (data->has_fan & (1 << 0)) {
-			if ((err = device_create_file(dev,
-			     &sensor_dev_attr_fan1_input16.dev_attr))
-			 || (err = device_create_file(dev,
-			     &sensor_dev_attr_fan1_min16.dev_attr))
-			 || (err = device_create_file(dev,
-			     &sensor_dev_attr_fan1_alarm.dev_attr)))
-				goto ERROR4;
-		}
-		if (data->has_fan & (1 << 1)) {
-			if ((err = device_create_file(dev,
-			     &sensor_dev_attr_fan2_input16.dev_attr))
-			 || (err = device_create_file(dev,
-			     &sensor_dev_attr_fan2_min16.dev_attr))
-			 || (err = device_create_file(dev,
-			     &sensor_dev_attr_fan2_alarm.dev_attr)))
-				goto ERROR4;
-		}
-		if (data->has_fan & (1 << 2)) {
-			if ((err = device_create_file(dev,
-			     &sensor_dev_attr_fan3_input16.dev_attr))
-			 || (err = device_create_file(dev,
-			     &sensor_dev_attr_fan3_min16.dev_attr))
-			 || (err = device_create_file(dev,
-			     &sensor_dev_attr_fan3_alarm.dev_attr)))
-				goto ERROR4;
-		}
-		if (data->has_fan & (1 << 3)) {
-			if ((err = device_create_file(dev,
-			     &sensor_dev_attr_fan4_input16.dev_attr))
-			 || (err = device_create_file(dev,
-			     &sensor_dev_attr_fan4_min16.dev_attr))
-			 || (err = device_create_file(dev,
-			     &sensor_dev_attr_fan4_alarm.dev_attr)))
-				goto ERROR4;
-		}
-		if (data->has_fan & (1 << 4)) {
-			if ((err = device_create_file(dev,
-			     &sensor_dev_attr_fan5_input16.dev_attr))
-			 || (err = device_create_file(dev,
-			     &sensor_dev_attr_fan5_min16.dev_attr))
-			 || (err = device_create_file(dev,
-			     &sensor_dev_attr_fan5_alarm.dev_attr)))
-				goto ERROR4;
-		}
-	} else {
-		/* 8-bit tachometers with clock divider */
-		if (data->has_fan & (1 << 0)) {
-			if ((err = device_create_file(dev,
-			     &sensor_dev_attr_fan1_input.dev_attr))
-			 || (err = device_create_file(dev,
-			     &sensor_dev_attr_fan1_min.dev_attr))
-			 || (err = device_create_file(dev,
-			     &sensor_dev_attr_fan1_div.dev_attr))
-			 || (err = device_create_file(dev,
-			     &sensor_dev_attr_fan1_alarm.dev_attr)))
-				goto ERROR4;
-		}
-		if (data->has_fan & (1 << 1)) {
-			if ((err = device_create_file(dev,
-			     &sensor_dev_attr_fan2_input.dev_attr))
-			 || (err = device_create_file(dev,
-			     &sensor_dev_attr_fan2_min.dev_attr))
-			 || (err = device_create_file(dev,
-			     &sensor_dev_attr_fan2_div.dev_attr))
-			 || (err = device_create_file(dev,
-			     &sensor_dev_attr_fan2_alarm.dev_attr)))
-				goto ERROR4;
-		}
-		if (data->has_fan & (1 << 2)) {
-			if ((err = device_create_file(dev,
-			     &sensor_dev_attr_fan3_input.dev_attr))
-			 || (err = device_create_file(dev,
-			     &sensor_dev_attr_fan3_min.dev_attr))
-			 || (err = device_create_file(dev,
-			     &sensor_dev_attr_fan3_div.dev_attr))
-			 || (err = device_create_file(dev,
-			     &sensor_dev_attr_fan3_alarm.dev_attr)))
-				goto ERROR4;
-		}
+	fan_group = it87_get_fan_group(data);
+	for (i = 0; i < 5; i++) {
+		if (!(data->has_fan & (1 << i)))
+			continue;
+		err = sysfs_create_group(&dev->kobj, &fan_group[i]);
+		if (err)
+			goto ERROR4;
 	}
 
 	if (enable_pwm_interface) {
-		if (!(sio_data->skip_pwm & (1 << 0))) {
-			if ((err = device_create_file(dev,
-			     &sensor_dev_attr_pwm1_enable.dev_attr))
-			 || (err = device_create_file(dev,
-			     &sensor_dev_attr_pwm1.dev_attr))
-			 || (err = device_create_file(dev,
-			     &dev_attr_pwm1_freq))
-			 || (err = device_create_file(dev,
-			     &sensor_dev_attr_pwm1_auto_channels_temp.dev_attr)))
-				goto ERROR4;
-		}
-		if (!(sio_data->skip_pwm & (1 << 1))) {
-			if ((err = device_create_file(dev,
-			     &sensor_dev_attr_pwm2_enable.dev_attr))
-			 || (err = device_create_file(dev,
-			     &sensor_dev_attr_pwm2.dev_attr))
-			 || (err = device_create_file(dev,
-			     &dev_attr_pwm2_freq))
-			 || (err = device_create_file(dev,
-			     &sensor_dev_attr_pwm2_auto_channels_temp.dev_attr)))
-				goto ERROR4;
-		}
-		if (!(sio_data->skip_pwm & (1 << 2))) {
-			if ((err = device_create_file(dev,
-			     &sensor_dev_attr_pwm3_enable.dev_attr))
-			 || (err = device_create_file(dev,
-			     &sensor_dev_attr_pwm3.dev_attr))
-			 || (err = device_create_file(dev,
-			     &dev_attr_pwm3_freq))
-			 || (err = device_create_file(dev,
-			     &sensor_dev_attr_pwm3_auto_channels_temp.dev_attr)))
+		for (i = 0; i < 3; i++) {
+			if (sio_data->skip_pwm & (1 << i))
+				continue;
+			err = sysfs_create_group(&dev->kobj,
+						 &it87_group_pwm[i]);
+			if (err)
 				goto ERROR4;
 		}
 	}
@@ -1376,8 +1351,7 @@ static int __devinit it87_probe(struct p
 	return 0;
 
 ERROR4:
-	sysfs_remove_group(&dev->kobj, &it87_group);
-	sysfs_remove_group(&dev->kobj, &it87_group_opt);
+	it87_remove_files(dev);
 ERROR2:
 	platform_set_drvdata(pdev, NULL);
 	kfree(data);
@@ -1392,8 +1366,7 @@ static int __devexit it87_remove(struct
 	struct it87_data *data = platform_get_drvdata(pdev);
 
 	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&pdev->dev.kobj, &it87_group);
-	sysfs_remove_group(&pdev->dev.kobj, &it87_group_opt);
+	it87_remove_files(&pdev->dev);
 
 	release_region(data->addr, IT87_EC_EXTENT);
 	platform_set_drvdata(pdev, NULL);

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
