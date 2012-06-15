From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:23:55 +0000
Subject: [lm-sensors] [PATCH 74/95] hwmon: (sis5595) Convert to use devm_ functions
Message-Id: <1339773856-3443-75-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/sis5595.c |   28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/drivers/hwmon/sis5595.c b/drivers/hwmon/sis5595.c
index 6c4d8eb..8275f0e 100644
--- a/drivers/hwmon/sis5595.c
+++ b/drivers/hwmon/sis5595.c
@@ -593,17 +593,14 @@ static int __devinit sis5595_probe(struct platform_device *pdev)
 
 	/* Reserve the ISA region */
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
-	if (!request_region(res->start, SIS5595_EXTENT,
-			    sis5595_driver.driver.name)) {
-		err = -EBUSY;
-		goto exit;
-	}
+	if (!devm_request_region(&pdev->dev, res->start, SIS5595_EXTENT,
+				 sis5595_driver.driver.name))
+		return -EBUSY;
 
-	data = kzalloc(sizeof(struct sis5595_data), GFP_KERNEL);
-	if (!data) {
-		err = -ENOMEM;
-		goto exit_release;
-	}
+	data = devm_kzalloc(&pdev->dev, sizeof(struct sis5595_data),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
 	mutex_init(&data->lock);
 	mutex_init(&data->update_lock);
@@ -636,7 +633,7 @@ static int __devinit sis5595_probe(struct platform_device *pdev)
 	/* Register sysfs hooks */
 	err = sysfs_create_group(&pdev->dev.kobj, &sis5595_group);
 	if (err)
-		goto exit_free;
+		return err;
 	if (data->maxins = 4) {
 		err = sysfs_create_group(&pdev->dev.kobj, &sis5595_group_in4);
 		if (err)
@@ -659,11 +656,6 @@ exit_remove_files:
 	sysfs_remove_group(&pdev->dev.kobj, &sis5595_group);
 	sysfs_remove_group(&pdev->dev.kobj, &sis5595_group_in4);
 	sysfs_remove_group(&pdev->dev.kobj, &sis5595_group_temp1);
-exit_free:
-	kfree(data);
-exit_release:
-	release_region(res->start, SIS5595_EXTENT);
-exit:
 	return err;
 }
 
@@ -676,10 +668,6 @@ static int __devexit sis5595_remove(struct platform_device *pdev)
 	sysfs_remove_group(&pdev->dev.kobj, &sis5595_group_in4);
 	sysfs_remove_group(&pdev->dev.kobj, &sis5595_group_temp1);
 
-	release_region(data->addr, SIS5595_EXTENT);
-	platform_set_drvdata(pdev, NULL);
-	kfree(data);
-
 	return 0;
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
