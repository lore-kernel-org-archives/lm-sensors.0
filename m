From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 22 Oct 2009 10:09:46 +0000
Subject: [lm-sensors] [PATCH 3/4] hwmon-f71882fg: Fix sysfs file removal
Message-Id: <4AE02F6A.1080200@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------050107000206040702080905"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------050107000206040702080905
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

There is a bug in the old sysfs file removal, as it uses fxxxx_in_temp_attr
to remove the in and temp sysfs attributes, but fxxxx_in_temp_attr has
temp#_alarm, where as f71858fg_in_temp_attr has temp#_max_alarm, so
the temp#_max_alarm attributes for the f71858fg never get removed.

This patch fixes this by doing the sysfs removal exactly the same way as
the creation instead of being (too) clever, this will also avoid similar
bugs in the future.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>


--------------050107000206040702080905
Content-Type: text/plain;
 name="hwmon-f71882fg-fix-sysfs-file-removal.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="hwmon-f71882fg-fix-sysfs-file-removal.patch"

hwmon-f71882fg: Fix sysfs file removal

There is a bug in the old sysfs file removal, as it uses fxxxx_in_temp_attr
to remove the in and temp sysfs attributes, but fxxxx_in_temp_attr has
temp#_alarm, where as f71858fg_in_temp_attr has temp#_max_alarm, so
the temp#_max_alarm attributes for the f71858fg never get removed.

This patch fixes this by doing the sysfs removal exactly the same way as
the creation instead of being (too) clever, this will also avoid similar
bugs in the future.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
--- linux/drivers/hwmon/f71882fg.c	2009-10-21 13:42:42.000000000 +0200
+++ linux/drivers/hwmon/f71882fg.c	2009-10-21 14:11:22.000000000 +0200
@@ -1810,6 +1810,15 @@
 	return 0;
 }
 
+static void f71882fg_remove_sysfs_files(struct platform_device *pdev,
+	struct sensor_device_attribute_2 *attr, int count)
+{
+	int i;
+
+	for (i = 0; i < count; i++)
+		device_remove_file(&pdev->dev, &attr[i].dev_attr);
+}
+
 static int __devinit f71882fg_probe(struct platform_device *pdev)
 {
 	struct f71882fg_data *data;
@@ -1974,42 +1983,74 @@
 
 static int f71882fg_remove(struct platform_device *pdev)
 {
-	int i, j;
 	struct f71882fg_data *data = platform_get_drvdata(pdev);
+	int nr_fans = (data->type == f71882fg) ? 4 : 3;
+	u8 start_reg = f71882fg_read8(data, F71882FG_REG_START);
 
 	platform_set_drvdata(pdev, NULL);
 	if (data->hwmon_dev)
 		hwmon_device_unregister(data->hwmon_dev);
 
-	/* Note we are not looping over all attr arrays we have as the ones
-	   below are supersets of the ones skipped. */
 	device_remove_file(&pdev->dev, &dev_attr_name);
 
-	for (i = 0; i < ARRAY_SIZE(fxxxx_in_temp_attr); i++)
-		device_remove_file(&pdev->dev,
-					&fxxxx_in_temp_attr[i].dev_attr);
-
-	for (i = 0; i < ARRAY_SIZE(fxxxx_in1_alarm_attr); i++)
-		device_remove_file(&pdev->dev,
-					&fxxxx_in1_alarm_attr[i].dev_attr);
-
-	for (i = 0; i < ARRAY_SIZE(fxxxx_fan_attr); i++)
-		for (j = 0; j < ARRAY_SIZE(fxxxx_fan_attr[0]); j++)
-			device_remove_file(&pdev->dev,
-					   &fxxxx_fan_attr[i][j].dev_attr);
-
-	for (i = 0; i < ARRAY_SIZE(fxxxx_fan_beep_attr); i++)
-		device_remove_file(&pdev->dev,
-				   &fxxxx_fan_beep_attr[i].dev_attr);
-
-	for (i = 0; i < ARRAY_SIZE(fxxxx_auto_pwm_attr); i++)
-		for (j = 0; j < ARRAY_SIZE(fxxxx_auto_pwm_attr[0]); j++)
-			device_remove_file(&pdev->dev,
-					  &fxxxx_auto_pwm_attr[i][j].dev_attr);
-
-	for (i = 0; i < ARRAY_SIZE(f8000_auto_pwm_attr); i++)
-		device_remove_file(&pdev->dev,
-				   &f8000_auto_pwm_attr[i].dev_attr);
+	if (start_reg & 0x01) {
+		switch (data->type) {
+		case f71858fg:
+			if (data->temp_config & 0x10)
+				f71882fg_remove_sysfs_files(pdev,
+					f8000_in_temp_attr,
+					ARRAY_SIZE(f8000_in_temp_attr));
+			else
+				f71882fg_remove_sysfs_files(pdev,
+					f71858fg_in_temp_attr,
+					ARRAY_SIZE(f71858fg_in_temp_attr));
+			break;
+		case f71882fg:
+			f71882fg_remove_sysfs_files(pdev,
+					fxxxx_in1_alarm_attr,
+					ARRAY_SIZE(fxxxx_in1_alarm_attr));
+			/* fall through! */
+		case f71862fg:
+			f71882fg_remove_sysfs_files(pdev,
+					fxxxx_in_temp_attr,
+					ARRAY_SIZE(fxxxx_in_temp_attr));
+			break;
+		case f8000:
+			f71882fg_remove_sysfs_files(pdev,
+					f8000_in_temp_attr,
+					ARRAY_SIZE(f8000_in_temp_attr));
+			break;
+		}
+	}
+
+	if (start_reg & 0x02) {
+		f71882fg_remove_sysfs_files(pdev, &fxxxx_fan_attr[0][0],
+				ARRAY_SIZE(fxxxx_fan_attr[0]) * nr_fans);
+
+		if (data->type == f71862fg || data->type == f71882fg)
+			f71882fg_remove_sysfs_files(pdev,
+					fxxxx_fan_beep_attr, nr_fans);
+
+		switch (data->type) {
+		case f71862fg:
+			f71882fg_remove_sysfs_files(pdev,
+					f71862fg_auto_pwm_attr,
+					ARRAY_SIZE(f71862fg_auto_pwm_attr));
+			break;
+		case f8000:
+			f71882fg_remove_sysfs_files(pdev,
+					f8000_fan_attr,
+					ARRAY_SIZE(f8000_fan_attr));
+			f71882fg_remove_sysfs_files(pdev,
+					f8000_auto_pwm_attr,
+					ARRAY_SIZE(f8000_auto_pwm_attr));
+			break;
+		default: /* f71858fg / f71882fg / f71889fg */
+			f71882fg_remove_sysfs_files(pdev,
+				&fxxxx_auto_pwm_attr[0][0],
+				ARRAY_SIZE(fxxxx_auto_pwm_attr[0]) * nr_fans);
+		}
+	}
 
 	kfree(data);
 

--------------050107000206040702080905
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------050107000206040702080905--
