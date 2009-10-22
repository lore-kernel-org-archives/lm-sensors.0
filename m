From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 22 Oct 2009 10:08:58 +0000
Subject: [lm-sensors] [PATCH 2/4] hwmon-f71882fg: Cleanup sysfs attr
Message-Id: <4AE02F3A.3000608@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------010100080203080605070304"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------010100080203080605070304
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

hwmon-f71882fg: Cleanup sysfs attr creation 2/2

This patch merges the f71882fg_auto_pwm_attr array into the
fxxxx_fan_attr resp. fxxxx_auto_pwm_attr array, as the f71882fg_auto_pwm_attr
array was merely extending these 2 with entries for a 4th fan, it also makes
these 2 arrays 2 dimensional so that the rest of the code can choose to
add attr for 3 or 4 fans without needing to know the nr of attr per fan.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>


--------------010100080203080605070304
Content-Type: text/plain;
 name="hwmon-f71882fg-sysfs-create-cleanup2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="hwmon-f71882fg-sysfs-create-cleanup2.patch"

hwmon-f71882fg: Cleanup sysfs attr creation 2/2

This patch merges the f71882fg_auto_pwm_attr array into the
fxxxx_fan_attr resp. fxxxx_auto_pwm_attr array, as the f71882fg_auto_pwm_attr
array was merely extending these 2 with entries for a 4th fan, it also makes
these 2 arrays 2 dimensional so that the rest of the code can choose to
add attr for 3 or 4 fans without needing to know the nr of attr per fan.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
--- linux/drivers/hwmon/f71882fg.c	2009-10-21 11:59:06.000000000 +0200
+++ linux/drivers/hwmon/f71882fg.c	2009-10-21 13:25:13.000000000 +0200
@@ -416,41 +416,51 @@
 };
 
 /* Fan / PWM attr common to all models */
-static struct sensor_device_attribute_2 fxxxx_fan_attr[] = {
+static struct sensor_device_attribute_2 fxxxx_fan_attr[4][6] = { {
 	SENSOR_ATTR_2(fan1_input, S_IRUGO, show_fan, NULL, 0, 0),
 	SENSOR_ATTR_2(fan1_full_speed, S_IRUGO|S_IWUSR,
 		      show_fan_full_speed,
 		      store_fan_full_speed, 0, 0),
 	SENSOR_ATTR_2(fan1_alarm, S_IRUGO, show_fan_alarm, NULL, 0, 0),
-	SENSOR_ATTR_2(fan2_input, S_IRUGO, show_fan, NULL, 0, 1),
-	SENSOR_ATTR_2(fan2_full_speed, S_IRUGO|S_IWUSR,
-		      show_fan_full_speed,
-		      store_fan_full_speed, 0, 1),
-	SENSOR_ATTR_2(fan2_alarm, S_IRUGO, show_fan_alarm, NULL, 0, 1),
-	SENSOR_ATTR_2(fan3_input, S_IRUGO, show_fan, NULL, 0, 2),
-	SENSOR_ATTR_2(fan3_full_speed, S_IRUGO|S_IWUSR,
-		      show_fan_full_speed,
-		      store_fan_full_speed, 0, 2),
-	SENSOR_ATTR_2(fan3_alarm, S_IRUGO, show_fan_alarm, NULL, 0, 2),
-
 	SENSOR_ATTR_2(pwm1, S_IRUGO|S_IWUSR, show_pwm, store_pwm, 0, 0),
 	SENSOR_ATTR_2(pwm1_enable, S_IRUGO|S_IWUSR, show_pwm_enable,
 		      store_pwm_enable, 0, 0),
 	SENSOR_ATTR_2(pwm1_interpolate, S_IRUGO|S_IWUSR,
 		      show_pwm_interpolate, store_pwm_interpolate, 0, 0),
-
+}, {
+	SENSOR_ATTR_2(fan2_input, S_IRUGO, show_fan, NULL, 0, 1),
+	SENSOR_ATTR_2(fan2_full_speed, S_IRUGO|S_IWUSR,
+		      show_fan_full_speed,
+		      store_fan_full_speed, 0, 1),
+	SENSOR_ATTR_2(fan2_alarm, S_IRUGO, show_fan_alarm, NULL, 0, 1),
 	SENSOR_ATTR_2(pwm2, S_IRUGO|S_IWUSR, show_pwm, store_pwm, 0, 1),
 	SENSOR_ATTR_2(pwm2_enable, S_IRUGO|S_IWUSR, show_pwm_enable,
 		      store_pwm_enable, 0, 1),
 	SENSOR_ATTR_2(pwm2_interpolate, S_IRUGO|S_IWUSR,
 		      show_pwm_interpolate, store_pwm_interpolate, 0, 1),
-
+}, {
+	SENSOR_ATTR_2(fan3_input, S_IRUGO, show_fan, NULL, 0, 2),
+	SENSOR_ATTR_2(fan3_full_speed, S_IRUGO|S_IWUSR,
+		      show_fan_full_speed,
+		      store_fan_full_speed, 0, 2),
+	SENSOR_ATTR_2(fan3_alarm, S_IRUGO, show_fan_alarm, NULL, 0, 2),
 	SENSOR_ATTR_2(pwm3, S_IRUGO|S_IWUSR, show_pwm, store_pwm, 0, 2),
 	SENSOR_ATTR_2(pwm3_enable, S_IRUGO|S_IWUSR, show_pwm_enable,
 		      store_pwm_enable, 0, 2),
 	SENSOR_ATTR_2(pwm3_interpolate, S_IRUGO|S_IWUSR,
 		      show_pwm_interpolate, store_pwm_interpolate, 0, 2),
-};
+}, {
+	SENSOR_ATTR_2(fan4_input, S_IRUGO, show_fan, NULL, 0, 3),
+	SENSOR_ATTR_2(fan4_full_speed, S_IRUGO|S_IWUSR,
+		      show_fan_full_speed,
+		      store_fan_full_speed, 0, 3),
+	SENSOR_ATTR_2(fan4_alarm, S_IRUGO, show_fan_alarm, NULL, 0, 3),
+	SENSOR_ATTR_2(pwm4, S_IRUGO|S_IWUSR, show_pwm, store_pwm, 0, 3),
+	SENSOR_ATTR_2(pwm4_enable, S_IRUGO|S_IWUSR, show_pwm_enable,
+		      store_pwm_enable, 0, 3),
+	SENSOR_ATTR_2(pwm4_interpolate, S_IRUGO|S_IWUSR,
+		      show_pwm_interpolate, store_pwm_interpolate, 0, 3),
+} };
 
 /* Attr for models which can beep on Fan alarm */
 static struct sensor_device_attribute_2 fxxxx_fan_beep_attr[] = {
@@ -460,10 +470,12 @@
 		store_fan_beep, 0, 1),
 	SENSOR_ATTR_2(fan3_beep, S_IRUGO|S_IWUSR, show_fan_beep,
 		store_fan_beep, 0, 2),
+	SENSOR_ATTR_2(fan4_beep, S_IRUGO|S_IWUSR, show_fan_beep,
+		store_fan_beep, 0, 3),
 };
 
 /* PWM attr for the f71862fg, less pwms and less zones per pwm than the
-   f71882fg / f71889fg */
+   f71858fg / f71882fg / f71889fg */
 static struct sensor_device_attribute_2 f71862fg_auto_pwm_attr[] = {
 	SENSOR_ATTR_2(pwm1_auto_channels_temp, S_IRUGO|S_IWUSR,
 		      show_pwm_auto_point_channel,
@@ -533,7 +545,7 @@
 };
 
 /* PWM attr common to both the f71858fg, f71882fg and f71889fg */
-static struct sensor_device_attribute_2 fxxxx_auto_pwm_attr[] = {
+static struct sensor_device_attribute_2 fxxxx_auto_pwm_attr[4][14] = { {
 	SENSOR_ATTR_2(pwm1_auto_channels_temp, S_IRUGO|S_IWUSR,
 		      show_pwm_auto_point_channel,
 		      store_pwm_auto_point_channel, 0, 0),
@@ -574,7 +586,7 @@
 		      show_pwm_auto_point_temp_hyst, NULL, 2, 0),
 	SENSOR_ATTR_2(pwm1_auto_point4_temp_hyst, S_IRUGO,
 		      show_pwm_auto_point_temp_hyst, NULL, 3, 0),
-
+}, {
 	SENSOR_ATTR_2(pwm2_auto_channels_temp, S_IRUGO|S_IWUSR,
 		      show_pwm_auto_point_channel,
 		      store_pwm_auto_point_channel, 0, 1),
@@ -615,7 +627,7 @@
 		      show_pwm_auto_point_temp_hyst, NULL, 2, 1),
 	SENSOR_ATTR_2(pwm2_auto_point4_temp_hyst, S_IRUGO,
 		      show_pwm_auto_point_temp_hyst, NULL, 3, 1),
-
+}, {
 	SENSOR_ATTR_2(pwm3_auto_channels_temp, S_IRUGO|S_IWUSR,
 		      show_pwm_auto_point_channel,
 		      store_pwm_auto_point_channel, 0, 2),
@@ -656,23 +668,7 @@
 		      show_pwm_auto_point_temp_hyst, NULL, 2, 2),
 	SENSOR_ATTR_2(pwm3_auto_point4_temp_hyst, S_IRUGO,
 		      show_pwm_auto_point_temp_hyst, NULL, 3, 2),
-};
-
-/* Fan / PWM attr found on the f71882fg but not on the f71858fg */
-static struct sensor_device_attribute_2 f71882fg_auto_pwm_attr[] = {
-	SENSOR_ATTR_2(fan4_input, S_IRUGO, show_fan, NULL, 0, 3),
-	SENSOR_ATTR_2(fan4_full_speed, S_IRUGO|S_IWUSR,
-		      show_fan_full_speed,
-		      store_fan_full_speed, 0, 3),
-	SENSOR_ATTR_2(fan4_beep, S_IRUGO|S_IWUSR, show_fan_beep,
-		store_fan_beep, 0, 3),
-	SENSOR_ATTR_2(fan4_alarm, S_IRUGO, show_fan_alarm, NULL, 0, 3),
-
-	SENSOR_ATTR_2(pwm4, S_IRUGO|S_IWUSR, show_pwm, store_pwm, 0, 3),
-	SENSOR_ATTR_2(pwm4_enable, S_IRUGO|S_IWUSR, show_pwm_enable,
-		      store_pwm_enable, 0, 3),
-	SENSOR_ATTR_2(pwm4_interpolate, S_IRUGO|S_IWUSR,
-		      show_pwm_interpolate, store_pwm_interpolate, 0, 3),
+}, {
 	SENSOR_ATTR_2(pwm4_auto_channels_temp, S_IRUGO|S_IWUSR,
 		      show_pwm_auto_point_channel,
 		      store_pwm_auto_point_channel, 0, 3),
@@ -713,7 +709,7 @@
 		      show_pwm_auto_point_temp_hyst, NULL, 2, 3),
 	SENSOR_ATTR_2(pwm4_auto_point4_temp_hyst, S_IRUGO,
 		      show_pwm_auto_point_temp_hyst, NULL, 3, 3),
-};
+} };
 
 /* Fan attr specific to the f8000 (4th fan input can only measure speed) */
 static struct sensor_device_attribute_2 f8000_fan_attr[] = {
@@ -1917,39 +1913,24 @@
 			goto exit_unregister_sysfs;
 		}
 
-		err = f71882fg_create_sysfs_files(pdev, fxxxx_fan_attr,
-					ARRAY_SIZE(fxxxx_fan_attr));
+		err = f71882fg_create_sysfs_files(pdev, &fxxxx_fan_attr[0][0],
+				ARRAY_SIZE(fxxxx_fan_attr[0]) * nr_fans);
 		if (err)
 			goto exit_unregister_sysfs;
 
-		switch (data->type) {
-		case f71862fg:
+		if (data->type == f71862fg || data->type == f71882fg) {
 			err = f71882fg_create_sysfs_files(pdev,
-					fxxxx_fan_beep_attr,
-					ARRAY_SIZE(fxxxx_fan_beep_attr));
+					fxxxx_fan_beep_attr, nr_fans);
 			if (err)
 				goto exit_unregister_sysfs;
+		}
+
+		switch (data->type) {
+		case f71862fg:
 			err = f71882fg_create_sysfs_files(pdev,
 					f71862fg_auto_pwm_attr,
 					ARRAY_SIZE(f71862fg_auto_pwm_attr));
 			break;
-		case f71882fg:
-			err = f71882fg_create_sysfs_files(pdev,
-					fxxxx_fan_beep_attr,
-					ARRAY_SIZE(fxxxx_fan_beep_attr));
-			if (err)
-				goto exit_unregister_sysfs;
-			err = f71882fg_create_sysfs_files(pdev,
-					f71882fg_auto_pwm_attr,
-					ARRAY_SIZE(f71882fg_auto_pwm_attr));
-			if (err)
-				goto exit_unregister_sysfs;
-			/* fall through! */
-		case f71858fg:
-			err = f71882fg_create_sysfs_files(pdev,
-					fxxxx_auto_pwm_attr,
-					ARRAY_SIZE(fxxxx_auto_pwm_attr));
-			break;
 		case f8000:
 			err = f71882fg_create_sysfs_files(pdev,
 					f8000_fan_attr,
@@ -1960,6 +1941,10 @@
 					f8000_auto_pwm_attr,
 					ARRAY_SIZE(f8000_auto_pwm_attr));
 			break;
+		default: /* f71858fg / f71882fg / f71889fg */
+			err = f71882fg_create_sysfs_files(pdev,
+				&fxxxx_auto_pwm_attr[0][0],
+				ARRAY_SIZE(fxxxx_auto_pwm_attr[0]) * nr_fans);
 		}
 		if (err)
 			goto exit_unregister_sysfs;
@@ -1989,7 +1974,7 @@
 
 static int f71882fg_remove(struct platform_device *pdev)
 {
-	int i;
+	int i, j;
 	struct f71882fg_data *data = platform_get_drvdata(pdev);
 
 	platform_set_drvdata(pdev, NULL);
@@ -2009,15 +1994,18 @@
 					&fxxxx_in1_alarm_attr[i].dev_attr);
 
 	for (i = 0; i < ARRAY_SIZE(fxxxx_fan_attr); i++)
-		device_remove_file(&pdev->dev, &fxxxx_fan_attr[i].dev_attr);
+		for (j = 0; j < ARRAY_SIZE(fxxxx_fan_attr[0]); j++)
+			device_remove_file(&pdev->dev,
+					   &fxxxx_fan_attr[i][j].dev_attr);
 
 	for (i = 0; i < ARRAY_SIZE(fxxxx_fan_beep_attr); i++)
 		device_remove_file(&pdev->dev,
 				   &fxxxx_fan_beep_attr[i].dev_attr);
 
-	for (i = 0; i < ARRAY_SIZE(f71882fg_auto_pwm_attr); i++)
-		device_remove_file(&pdev->dev,
-				   &f71882fg_auto_pwm_attr[i].dev_attr);
+	for (i = 0; i < ARRAY_SIZE(fxxxx_auto_pwm_attr); i++)
+		for (j = 0; j < ARRAY_SIZE(fxxxx_auto_pwm_attr[0]); j++)
+			device_remove_file(&pdev->dev,
+					  &fxxxx_auto_pwm_attr[i][j].dev_attr);
 
 	for (i = 0; i < ARRAY_SIZE(f8000_auto_pwm_attr); i++)
 		device_remove_file(&pdev->dev,

--------------010100080203080605070304
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------010100080203080605070304--
