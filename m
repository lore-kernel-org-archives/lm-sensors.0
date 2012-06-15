From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:24:02 +0000
Subject: [lm-sensors] [PATCH 81/95] hwmon: (vt8231) Convert to use devm_ functions
Message-Id: <1339773856-3443-82-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Cc: Roger Lucas <vt8231@hiddenengine.co.uk>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/vt8231.c |   24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/hwmon/vt8231.c b/drivers/hwmon/vt8231.c
index 386a845..84e3dc5 100644
--- a/drivers/hwmon/vt8231.c
+++ b/drivers/hwmon/vt8231.c
@@ -789,18 +789,16 @@ static int vt8231_probe(struct platform_device *pdev)
 
 	/* Reserve the ISA region */
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
-	if (!request_region(res->start, VT8231_EXTENT,
-			    vt8231_driver.driver.name)) {
+	if (!devm_request_region(&pdev->dev, res->start, VT8231_EXTENT,
+				 vt8231_driver.driver.name)) {
 		dev_err(&pdev->dev, "Region 0x%lx-0x%lx already in use!\n",
 			(unsigned long)res->start, (unsigned long)res->end);
 		return -ENODEV;
 	}
 
-	data = kzalloc(sizeof(struct vt8231_data), GFP_KERNEL);
-	if (!data) {
-		err = -ENOMEM;
-		goto exit_release;
-	}
+	data = devm_kzalloc(&pdev->dev, sizeof(struct vt8231_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
 	platform_set_drvdata(pdev, data);
 	data->addr = res->start;
@@ -812,7 +810,7 @@ static int vt8231_probe(struct platform_device *pdev)
 	/* Register sysfs hooks */
 	err = sysfs_create_group(&pdev->dev.kobj, &vt8231_group);
 	if (err)
-		goto exit_free;
+		return err;
 
 	/* Must update device information to find out the config field */
 	data->uch_config = vt8231_read_value(data, VT8231_REG_UCH_CONFIG);
@@ -850,13 +848,6 @@ exit_remove_files:
 		sysfs_remove_group(&pdev->dev.kobj, &vt8231_group_temps[i]);
 
 	sysfs_remove_group(&pdev->dev.kobj, &vt8231_group);
-
-exit_free:
-	platform_set_drvdata(pdev, NULL);
-	kfree(data);
-
-exit_release:
-	release_region(res->start, VT8231_EXTENT);
 	return err;
 }
 
@@ -875,9 +866,6 @@ static int __devexit vt8231_remove(struct platform_device *pdev)
 
 	sysfs_remove_group(&pdev->dev.kobj, &vt8231_group);
 
-	release_region(data->addr, VT8231_EXTENT);
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
