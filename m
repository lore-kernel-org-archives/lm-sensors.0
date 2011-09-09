From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 09 Sep 2011 10:12:34 +0000
Subject: [lm-sensors] [PATCH 2/3] hwmon/f71882fg: Add a
Message-Id: <1315563155-15774-2-git-send-email-hdegoede@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This is a preparation patch for not registering fan/pwm attributes for
some fans (rather then register them for all or for none).

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/hwmon/f71882fg.c |  108 +++++++++++++++++++++++++++-------------------
 1 files changed, 64 insertions(+), 44 deletions(-)

diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
index c0805aa..47c9b8d 100644
--- a/drivers/hwmon/f71882fg.c
+++ b/drivers/hwmon/f71882fg.c
@@ -2154,6 +2154,54 @@ static void f71882fg_remove_sysfs_files(struct platform_device *pdev,
 		device_remove_file(&pdev->dev, &attr[i].dev_attr);
 }
 
+static int __devinit f71882fg_create_fan_sysfs_files(
+	struct platform_device *pdev, int idx, bool pwm_auto_point)
+{
+	struct f71882fg_data *data = platform_get_drvdata(pdev);
+	int err;
+
+	err = f71882fg_create_sysfs_files(pdev, &fxxxx_fan_attr[idx][0],
+					  ARRAY_SIZE(fxxxx_fan_attr[0]));
+	if (err)
+		return err;
+
+	if (f71882fg_fan_has_beep[data->type]) {
+		err = f71882fg_create_sysfs_files(pdev,
+						  &fxxxx_fan_beep_attr[idx],
+						  1);
+		if (err)
+			return err;
+	}
+
+	if (!pwm_auto_point)
+		return 0; /* All done */
+
+	switch (data->type) {
+	case f71862fg:
+		err = f71882fg_create_sysfs_files(pdev,
+					&f71862fg_auto_pwm_attr[idx][0],
+					ARRAY_SIZE(f71862fg_auto_pwm_attr[0]));
+		break;
+	case f71808e:
+	case f71869:
+		err = f71882fg_create_sysfs_files(pdev,
+					&f71869_auto_pwm_attr[idx][0],
+					ARRAY_SIZE(f71869_auto_pwm_attr[0]));
+		break;
+	case f8000:
+		err = f71882fg_create_sysfs_files(pdev,
+					&f8000_auto_pwm_attr[idx][0],
+					ARRAY_SIZE(f8000_auto_pwm_attr[0]));
+		break;
+	default:
+		err = f71882fg_create_sysfs_files(pdev,
+					&fxxxx_auto_pwm_attr[idx][0],
+					ARRAY_SIZE(fxxxx_auto_pwm_attr[0]));
+	}
+
+	return err;
+}
+
 static int __devinit f71882fg_probe(struct platform_device *pdev)
 {
 	struct f71882fg_data *data;
@@ -2247,6 +2295,8 @@ static int __devinit f71882fg_probe(struct platform_device *pdev)
 	}
 
 	if (start_reg & 0x02) {
+		bool pwm_auto_point = true;
+
 		switch (data->type) {
 		case f71808e:
 		case f71808a:
@@ -2298,18 +2348,6 @@ static int __devinit f71882fg_probe(struct platform_device *pdev)
 			goto exit_unregister_sysfs;
 		}
 
-		err = f71882fg_create_sysfs_files(pdev, &fxxxx_fan_attr[0][0],
-				ARRAY_SIZE(fxxxx_fan_attr[0]) * nr_fans);
-		if (err)
-			goto exit_unregister_sysfs;
-
-		if (f71882fg_fan_has_beep[data->type]) {
-			err = f71882fg_create_sysfs_files(pdev,
-					fxxxx_fan_beep_attr, nr_fans);
-			if (err)
-				goto exit_unregister_sysfs;
-		}
-
 		switch (data->type) {
 		case f71808e:
 		case f71808a:
@@ -2331,59 +2369,41 @@ static int __devinit f71882fg_probe(struct platform_device *pdev)
 					 "Auto pwm controlled by raw digital "
 					 "data, disabling pwm auto_point "
 					 "sysfs attributes\n");
-				goto no_pwm_auto_point;
+				pwm_auto_point = false;
 			}
 			break;
 		default:
 			break;
 		}
 
-		switch (data->type) {
-		case f71808a:
-			err = f71882fg_create_sysfs_files(pdev,
-				&fxxxx_auto_pwm_attr[0][0],
-				ARRAY_SIZE(fxxxx_auto_pwm_attr[0]) * nr_fans);
+		for (i = 0; i < nr_fans; i++) {
+			err = f71882fg_create_fan_sysfs_files(pdev, i,
+							      pwm_auto_point);
 			if (err)
 				goto exit_unregister_sysfs;
+
+			dev_info(&pdev->dev, "Fan: %d is in %s mode\n", i + 1,
+				 (data->pwm_enable & (1 << 2 * i)) ?
+				 "duty-cycle" : "RPM");
+		}
+
+		/* Some types have 1 extra fan with limited functionality */
+		switch (data->type) {
+		case f71808a:
 			err = f71882fg_create_sysfs_files(pdev,
 					f71808a_fan3_attr,
 					ARRAY_SIZE(f71808a_fan3_attr));
 			break;
-		case f71862fg:
-			err = f71882fg_create_sysfs_files(pdev,
-				&f71862fg_auto_pwm_attr[0][0],
-				ARRAY_SIZE(f71862fg_auto_pwm_attr[0]) *
-					nr_fans);
-			break;
-		case f71808e:
-		case f71869:
-			err = f71882fg_create_sysfs_files(pdev,
-				&f71869_auto_pwm_attr[0][0],
-				ARRAY_SIZE(f71869_auto_pwm_attr[0]) * nr_fans);
-			break;
 		case f8000:
 			err = f71882fg_create_sysfs_files(pdev,
 					f8000_fan_attr,
 					ARRAY_SIZE(f8000_fan_attr));
-			if (err)
-				goto exit_unregister_sysfs;
-			err = f71882fg_create_sysfs_files(pdev,
-				&f8000_auto_pwm_attr[0][0],
-				ARRAY_SIZE(f8000_auto_pwm_attr[0]) * nr_fans);
 			break;
 		default:
-			err = f71882fg_create_sysfs_files(pdev,
-				&fxxxx_auto_pwm_attr[0][0],
-				ARRAY_SIZE(fxxxx_auto_pwm_attr[0]) * nr_fans);
+			break;
 		}
 		if (err)
 			goto exit_unregister_sysfs;
-
-no_pwm_auto_point:
-		for (i = 0; i < nr_fans; i++)
-			dev_info(&pdev->dev, "Fan: %d is in %s mode\n", i + 1,
-				 (data->pwm_enable & (1 << 2 * i)) ?
-				 "duty-cycle" : "RPM");
 	}
 
 	data->hwmon_dev = hwmon_device_register(&pdev->dev);
-- 
1.7.6.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
