From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:24:16 +0000
Subject: [lm-sensors] [PATCH 95/95] hwmon: (via-cputemp) Convert to use devm_ functions
Message-Id: <1339773856-3443-96-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/via-cputemp.c |   19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/hwmon/via-cputemp.c b/drivers/hwmon/via-cputemp.c
index 8689664..0be7e81 100644
--- a/drivers/hwmon/via-cputemp.c
+++ b/drivers/hwmon/via-cputemp.c
@@ -128,11 +128,11 @@ static int __devinit via_cputemp_probe(struct platform_device *pdev)
 	int err;
 	u32 eax, edx;
 
-	data = kzalloc(sizeof(struct via_cputemp_data), GFP_KERNEL);
+	data = devm_kzalloc(&pdev->dev, sizeof(struct via_cputemp_data),
+			    GFP_KERNEL);
 	if (!data) {
-		err = -ENOMEM;
 		dev_err(&pdev->dev, "Out of memory\n");
-		goto exit;
+		return -ENOMEM;
 	}
 
 	data->id = pdev->id;
@@ -151,8 +151,7 @@ static int __devinit via_cputemp_probe(struct platform_device *pdev)
 		data->msr_temp = 0x1423;
 		break;
 	default:
-		err = -ENODEV;
-		goto exit_free;
+		return -ENODEV;
 	}
 
 	/* test if we can access the TEMPERATURE MSR */
@@ -160,14 +159,14 @@ static int __devinit via_cputemp_probe(struct platform_device *pdev)
 	if (err) {
 		dev_err(&pdev->dev,
 			"Unable to access TEMPERATURE MSR, giving up\n");
-		goto exit_free;
+		return err;
 	}
 
 	platform_set_drvdata(pdev, data);
 
 	err = sysfs_create_group(&pdev->dev.kobj, &via_cputemp_group);
 	if (err)
-		goto exit_free;
+		return err;
 
 	if (data->msr_vid)
 		data->vrm = vid_which_vrm();
@@ -192,10 +191,6 @@ exit_remove:
 	if (data->vrm)
 		device_remove_file(&pdev->dev, &dev_attr_cpu0_vid);
 	sysfs_remove_group(&pdev->dev.kobj, &via_cputemp_group);
-exit_free:
-	platform_set_drvdata(pdev, NULL);
-	kfree(data);
-exit:
 	return err;
 }
 
@@ -207,8 +202,6 @@ static int __devexit via_cputemp_remove(struct platform_device *pdev)
 	if (data->vrm)
 		device_remove_file(&pdev->dev, &dev_attr_cpu0_vid);
 	sysfs_remove_group(&pdev->dev.kobj, &via_cputemp_group);
-	platform_set_drvdata(pdev, NULL);
-	kfree(data);
 	return 0;
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
