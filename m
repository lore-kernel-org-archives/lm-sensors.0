From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:24:00 +0000
Subject: [lm-sensors] [PATCH 79/95] hwmon: (via686a) Convert to use devm_ functions
Message-Id: <1339773856-3443-80-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/via686a.c |   23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/hwmon/via686a.c b/drivers/hwmon/via686a.c
index 288135d..299399a 100644
--- a/drivers/hwmon/via686a.c
+++ b/drivers/hwmon/via686a.c
@@ -690,18 +690,17 @@ static int __devinit via686a_probe(struct platform_device *pdev)
 
 	/* Reserve the ISA region */
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
-	if (!request_region(res->start, VIA686A_EXTENT,
-			    via686a_driver.driver.name)) {
+	if (!devm_request_region(&pdev->dev, res->start, VIA686A_EXTENT,
+				 via686a_driver.driver.name)) {
 		dev_err(&pdev->dev, "Region 0x%lx-0x%lx already in use!\n",
 			(unsigned long)res->start, (unsigned long)res->end);
 		return -ENODEV;
 	}
 
-	data = kzalloc(sizeof(struct via686a_data), GFP_KERNEL);
-	if (!data) {
-		err = -ENOMEM;
-		goto exit_release;
-	}
+	data = devm_kzalloc(&pdev->dev, sizeof(struct via686a_data),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
 	platform_set_drvdata(pdev, data);
 	data->addr = res->start;
@@ -714,7 +713,7 @@ static int __devinit via686a_probe(struct platform_device *pdev)
 	/* Register sysfs hooks */
 	err = sysfs_create_group(&pdev->dev.kobj, &via686a_group);
 	if (err)
-		goto exit_free;
+		return err;
 
 	data->hwmon_dev = hwmon_device_register(&pdev->dev);
 	if (IS_ERR(data->hwmon_dev)) {
@@ -726,10 +725,6 @@ static int __devinit via686a_probe(struct platform_device *pdev)
 
 exit_remove_files:
 	sysfs_remove_group(&pdev->dev.kobj, &via686a_group);
-exit_free:
-	kfree(data);
-exit_release:
-	release_region(res->start, VIA686A_EXTENT);
 	return err;
 }
 
@@ -740,10 +735,6 @@ static int __devexit via686a_remove(struct platform_device *pdev)
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&pdev->dev.kobj, &via686a_group);
 
-	release_region(data->addr, VIA686A_EXTENT);
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
