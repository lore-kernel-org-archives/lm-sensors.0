From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:22:42 +0000
Subject: [lm-sensors] [PATCH 01/95] hwmon: (mc13783-adc.c) Convert to use devm_ functions
Message-Id: <1339773856-3443-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Cc: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/mc13783-adc.c |   12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/mc13783-adc.c b/drivers/hwmon/mc13783-adc.c
index ce86c5e..cf47a59 100644
--- a/drivers/hwmon/mc13783-adc.c
+++ b/drivers/hwmon/mc13783-adc.c
@@ -179,7 +179,7 @@ static int __init mc13783_adc_probe(struct platform_device *pdev)
 	const struct platform_device_id *id = platform_get_device_id(pdev);
 	char *dash;
 
-	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
@@ -194,7 +194,7 @@ static int __init mc13783_adc_probe(struct platform_device *pdev)
 	/* Register sysfs hooks */
 	ret = sysfs_create_group(&pdev->dev.kobj, &mc13783_group_base);
 	if (ret)
-		goto out_err_create_base;
+		return ret;
 
 	if (id->driver_data & MC13783_ADC_16CHANS) {
 		ret = sysfs_create_group(&pdev->dev.kobj,
@@ -230,11 +230,6 @@ out_err_create_ts:
 out_err_create_16chans:
 
 	sysfs_remove_group(&pdev->dev.kobj, &mc13783_group_base);
-out_err_create_base:
-
-	platform_set_drvdata(pdev, NULL);
-	kfree(priv);
-
 	return ret;
 }
 
@@ -253,9 +248,6 @@ static int __devexit mc13783_adc_remove(struct platform_device *pdev)
 
 	sysfs_remove_group(&pdev->dev.kobj, &mc13783_group_base);
 
-	platform_set_drvdata(pdev, NULL);
-	kfree(priv);
-
 	return 0;
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
