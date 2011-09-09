From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 09 Sep 2011 10:12:35 +0000
Subject: [lm-sensors] [PATCH 3/3] hwmon/f71882fg: Make the decision wether
Message-Id: <1315563155-15774-3-git-send-email-hdegoede@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Before this patch the f71882fg driver completely fails to initialize
on systems which have reserved settings in the pwm enable register, and
it disables all auto pwm sysfs attributes if any fan is controlled by
a digital sensor reading.

This patch changes the fail to initialize into don't register any attributes
for the fan for which there are reserved settings in the pwm enable register
and also makes the not registering of auto pwm sysfs attributes a per fan
thing.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/hwmon/f71882fg.c |  119 +++++++++++++++++++++-------------------------
 1 files changed, 54 insertions(+), 65 deletions(-)

diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
index 47c9b8d..59dd881 100644
--- a/drivers/hwmon/f71882fg.c
+++ b/drivers/hwmon/f71882fg.c
@@ -2155,11 +2155,37 @@ static void f71882fg_remove_sysfs_files(struct platform_device *pdev,
 }
 
 static int __devinit f71882fg_create_fan_sysfs_files(
-	struct platform_device *pdev, int idx, bool pwm_auto_point)
+	struct platform_device *pdev, int idx)
 {
 	struct f71882fg_data *data = platform_get_drvdata(pdev);
 	int err;
 
+	/* Sanity check the pwm setting */
+	err = 0;
+	switch (data->type) {
+	case f71858fg:
+		if (((data->pwm_enable >> (idx * 2)) & 3) = 3)
+			err = 1;
+		break;
+	case f71862fg:
+		if (((data->pwm_enable >> (idx * 2)) & 1) != 1)
+			err = 1;
+		break;
+	case f8000:
+		if (idx = 2)
+			err = data->pwm_enable & 0x20;
+		break;
+	default:
+		break;
+	}
+	if (err) {
+		dev_err(&pdev->dev,
+			"Invalid (reserved) pwm settings: 0x%02x, "
+			"skipping fan %d\n",
+			(data->pwm_enable >> (idx * 2)) & 3, idx + 1);
+		return 0; /* This is a non fatal condition */
+	}
+
 	err = f71882fg_create_sysfs_files(pdev, &fxxxx_fan_attr[idx][0],
 					  ARRAY_SIZE(fxxxx_fan_attr[0]));
 	if (err)
@@ -2173,8 +2199,32 @@ static int __devinit f71882fg_create_fan_sysfs_files(
 			return err;
 	}
 
-	if (!pwm_auto_point)
-		return 0; /* All done */
+	dev_info(&pdev->dev, "Fan: %d is in %s mode\n", idx + 1,
+		 (data->pwm_enable & (1 << (2 * idx))) ? "duty-cycle" : "RPM");
+
+	/* Check for unsupported auto pwm settings */
+	switch (data->type) {
+	case f71808e:
+	case f71808a:
+	case f71869:
+	case f71869a:
+	case f71889fg:
+	case f71889ed:
+	case f71889a:
+		data->pwm_auto_point_mapping[idx] +			f71882fg_read8(data, F71882FG_REG_POINT_MAPPING(idx));
+		if ((data->pwm_auto_point_mapping[idx] & 0x80) ||
+		    (data->pwm_auto_point_mapping[idx] & 3) = 0) {
+			dev_warn(&pdev->dev,
+				 "Auto pwm controlled by raw digital "
+				 "data, disabling pwm auto_point "
+				 "sysfs attributes for fan %d\n", idx + 1);
+			return 0; /* This is a non fatal condition */
+		}
+		break;
+	default:
+		break;
+	}
 
 	switch (data->type) {
 	case f71862fg:
@@ -2295,8 +2345,6 @@ static int __devinit f71882fg_probe(struct platform_device *pdev)
 	}
 
 	if (start_reg & 0x02) {
-		bool pwm_auto_point = true;
-
 		switch (data->type) {
 		case f71808e:
 		case f71808a:
@@ -2322,69 +2370,10 @@ static int __devinit f71882fg_probe(struct platform_device *pdev)
 		data->pwm_enable  			f71882fg_read8(data, F71882FG_REG_PWM_ENABLE);
 
-		/* Sanity check the pwm settings */
-		switch (data->type) {
-		case f71858fg:
-			err = 0;
-			for (i = 0; i < nr_fans; i++)
-				if (((data->pwm_enable >> (i * 2)) & 3) = 3)
-					err = 1;
-			break;
-		case f71862fg:
-			err = (data->pwm_enable & 0x15) != 0x15;
-			break;
-		case f8000:
-			err = data->pwm_enable & 0x20;
-			break;
-		default:
-			err = 0;
-			break;
-		}
-		if (err) {
-			dev_err(&pdev->dev,
-				"Invalid (reserved) pwm settings: 0x%02x\n",
-				(unsigned int)data->pwm_enable);
-			err = -ENODEV;
-			goto exit_unregister_sysfs;
-		}
-
-		switch (data->type) {
-		case f71808e:
-		case f71808a:
-		case f71869:
-		case f71869a:
-		case f71889fg:
-		case f71889ed:
-		case f71889a:
-			for (i = 0; i < nr_fans; i++) {
-				data->pwm_auto_point_mapping[i] -					f71882fg_read8(data,
-						F71882FG_REG_POINT_MAPPING(i));
-				if ((data->pwm_auto_point_mapping[i] & 0x80) ||
-				    (data->pwm_auto_point_mapping[i] & 3) = 0)
-					break;
-			}
-			if (i != nr_fans) {
-				dev_warn(&pdev->dev,
-					 "Auto pwm controlled by raw digital "
-					 "data, disabling pwm auto_point "
-					 "sysfs attributes\n");
-				pwm_auto_point = false;
-			}
-			break;
-		default:
-			break;
-		}
-
 		for (i = 0; i < nr_fans; i++) {
-			err = f71882fg_create_fan_sysfs_files(pdev, i,
-							      pwm_auto_point);
+			err = f71882fg_create_fan_sysfs_files(pdev, i);
 			if (err)
 				goto exit_unregister_sysfs;
-
-			dev_info(&pdev->dev, "Fan: %d is in %s mode\n", i + 1,
-				 (data->pwm_enable & (1 << 2 * i)) ?
-				 "duty-cycle" : "RPM");
 		}
 
 		/* Some types have 1 extra fan with limited functionality */
-- 
1.7.6.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
