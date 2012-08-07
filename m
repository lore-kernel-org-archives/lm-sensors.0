From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 07 Aug 2012 15:20:27 +0000
Subject: [lm-sensors] [PATCH 38/39] hwmon: (via-cputemp) Convert to use devm_ functions
Message-Id: <1344352828-25143-39-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/via-cputemp.c |   23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/hwmon/via-cputemp.c b/drivers/hwmon/via-cputemp.c
index ee4ebc1..ea6aca3 100644
--- a/drivers/hwmon/via-cputemp.c
+++ b/drivers/hwmon/via-cputemp.c
@@ -128,12 +128,10 @@ static int __devinit via_cputemp_probe(struct platform_device *pdev)
 	int err;
 	u32 eax, edx;
 
-	data = kzalloc(sizeof(struct via_cputemp_data), GFP_KERNEL);
-	if (!data) {
-		err = -ENOMEM;
-		dev_err(&pdev->dev, "Out of memory\n");
-		goto exit;
-	}
+	data = devm_kzalloc(&pdev->dev, sizeof(struct via_cputemp_data),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
 	data->id = pdev->id;
 	data->name = "via_cputemp";
@@ -151,8 +149,7 @@ static int __devinit via_cputemp_probe(struct platform_device *pdev)
 		data->msr_temp = 0x1423;
 		break;
 	default:
-		err = -ENODEV;
-		goto exit_free;
+		return -ENODEV;
 	}
 
 	/* test if we can access the TEMPERATURE MSR */
@@ -160,14 +157,14 @@ static int __devinit via_cputemp_probe(struct platform_device *pdev)
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
@@ -192,10 +189,6 @@ exit_remove:
 	if (data->vrm)
 		device_remove_file(&pdev->dev, &dev_attr_cpu0_vid);
 	sysfs_remove_group(&pdev->dev.kobj, &via_cputemp_group);
-exit_free:
-	platform_set_drvdata(pdev, NULL);
-	kfree(data);
-exit:
 	return err;
 }
 
@@ -207,8 +200,6 @@ static int __devexit via_cputemp_remove(struct platform_device *pdev)
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
