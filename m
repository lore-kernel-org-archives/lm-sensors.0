From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:23:13 +0000
Subject: [lm-sensors] [PATCH 32/95] hwmon: (f71805f) Convert to use devm_ functions
Message-Id: <1339773856-3443-33-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Cc: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/f71805f.c |   26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/drivers/hwmon/f71805f.c b/drivers/hwmon/f71805f.c
index 3e4da62..4dd7723 100644
--- a/drivers/hwmon/f71805f.c
+++ b/drivers/hwmon/f71805f.c
@@ -1386,20 +1386,20 @@ static int __devinit f71805f_probe(struct platform_device *pdev)
 		"f71872f",
 	};
 
-	data = kzalloc(sizeof(struct f71805f_data), GFP_KERNEL);
+	data = devm_kzalloc(&pdev->dev, sizeof(struct f71805f_data),
+			    GFP_KERNEL);
 	if (!data) {
-		err = -ENOMEM;
 		pr_err("Out of memory\n");
-		goto exit;
+		return -ENOMEM;
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
-	if (!request_region(res->start + ADDR_REG_OFFSET, 2, DRVNAME)) {
-		err = -EBUSY;
+	if (!devm_request_region(&pdev->dev, res->start + ADDR_REG_OFFSET, 2,
+				 DRVNAME)) {
 		dev_err(&pdev->dev, "Failed to request region 0x%lx-0x%lx\n",
 			(unsigned long)(res->start + ADDR_REG_OFFSET),
 			(unsigned long)(res->start + ADDR_REG_OFFSET + 1));
-		goto exit_free;
+		return -EBUSY;
 	}
 	data->addr = res->start;
 	data->name = names[sio_data->kind];
@@ -1427,7 +1427,7 @@ static int __devinit f71805f_probe(struct platform_device *pdev)
 	/* Register sysfs interface files */
 	err = sysfs_create_group(&pdev->dev.kobj, &f71805f_group);
 	if (err)
-		goto exit_release_region;
+		return err;
 	if (data->has_in & (1 << 4)) { /* in4 */
 		err = sysfs_create_group(&pdev->dev.kobj,
 					 &f71805f_group_optin[0]);
@@ -1487,19 +1487,12 @@ exit_remove_files:
 	for (i = 0; i < 4; i++)
 		sysfs_remove_group(&pdev->dev.kobj, &f71805f_group_optin[i]);
 	sysfs_remove_group(&pdev->dev.kobj, &f71805f_group_pwm_freq);
-exit_release_region:
-	release_region(res->start + ADDR_REG_OFFSET, 2);
-exit_free:
-	platform_set_drvdata(pdev, NULL);
-	kfree(data);
-exit:
 	return err;
 }
 
 static int __devexit f71805f_remove(struct platform_device *pdev)
 {
 	struct f71805f_data *data = platform_get_drvdata(pdev);
-	struct resource *res;
 	int i;
 
 	hwmon_device_unregister(data->hwmon_dev);
@@ -1507,11 +1500,6 @@ static int __devexit f71805f_remove(struct platform_device *pdev)
 	for (i = 0; i < 4; i++)
 		sysfs_remove_group(&pdev->dev.kobj, &f71805f_group_optin[i]);
 	sysfs_remove_group(&pdev->dev.kobj, &f71805f_group_pwm_freq);
-	platform_set_drvdata(pdev, NULL);
-	kfree(data);
-
-	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
-	release_region(res->start + ADDR_REG_OFFSET, 2);
 
 	return 0;
 }
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
