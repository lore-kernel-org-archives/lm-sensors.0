From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 07 Aug 2012 15:20:26 +0000
Subject: [lm-sensors] [PATCH 37/39] hwmon: (jz4740-hwmon) Convert to use devm_ functions
Message-Id: <1344352828-25143-38-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Cc: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/jz4740-hwmon.c |   49 +++++++++++-------------------------------
 1 file changed, 13 insertions(+), 36 deletions(-)

diff --git a/drivers/hwmon/jz4740-hwmon.c b/drivers/hwmon/jz4740-hwmon.c
index 5253d23..84bf215 100644
--- a/drivers/hwmon/jz4740-hwmon.c
+++ b/drivers/hwmon/jz4740-hwmon.c
@@ -106,42 +106,36 @@ static int __devinit jz4740_hwmon_probe(struct platform_device *pdev)
 	int ret;
 	struct jz4740_hwmon *hwmon;
 
-	hwmon = kmalloc(sizeof(*hwmon), GFP_KERNEL);
-	if (!hwmon) {
-		dev_err(&pdev->dev, "Failed to allocate driver structure\n");
+	hwmon = devm_kzalloc(&pdev->dev, sizeof(*hwmon), GFP_KERNEL);
+	if (!hwmon)
 		return -ENOMEM;
-	}
 
 	hwmon->cell = mfd_get_cell(pdev);
 
 	hwmon->irq = platform_get_irq(pdev, 0);
 	if (hwmon->irq < 0) {
-		ret = hwmon->irq;
 		dev_err(&pdev->dev, "Failed to get platform irq: %d\n", ret);
-		goto err_free;
+		return hwmon->irq;
 	}
 
 	hwmon->mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!hwmon->mem) {
-		ret = -ENOENT;
 		dev_err(&pdev->dev, "Failed to get platform mmio resource\n");
-		goto err_free;
+		return -ENOENT;
 	}
 
-	hwmon->mem = request_mem_region(hwmon->mem->start,
+	hwmon->mem = devm_request_mem_region(&pdev->dev, hwmon->mem->start,
 			resource_size(hwmon->mem), pdev->name);
 	if (!hwmon->mem) {
-		ret = -EBUSY;
 		dev_err(&pdev->dev, "Failed to request mmio memory region\n");
-		goto err_free;
+		return -EBUSY;
 	}
 
-	hwmon->base = ioremap_nocache(hwmon->mem->start,
-			resource_size(hwmon->mem));
+	hwmon->base = devm_ioremap_nocache(&pdev->dev, hwmon->mem->start,
+					   resource_size(hwmon->mem));
 	if (!hwmon->base) {
-		ret = -EBUSY;
 		dev_err(&pdev->dev, "Failed to ioremap mmio memory\n");
-		goto err_release_mem_region;
+		return -EBUSY;
 	}
 
 	init_completion(&hwmon->read_completion);
@@ -149,17 +143,18 @@ static int __devinit jz4740_hwmon_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, hwmon);
 
-	ret = request_irq(hwmon->irq, jz4740_hwmon_irq, 0, pdev->name, hwmon);
+	ret = devm_request_irq(&pdev->dev, hwmon->irq, jz4740_hwmon_irq, 0,
+			       pdev->name, hwmon);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to request irq: %d\n", ret);
-		goto err_iounmap;
+		return ret;
 	}
 	disable_irq(hwmon->irq);
 
 	ret = sysfs_create_group(&pdev->dev.kobj, &jz4740_hwmon_attr_group);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to create sysfs group: %d\n", ret);
-		goto err_free_irq;
+		return ret;
 	}
 
 	hwmon->hwmon = hwmon_device_register(&pdev->dev);
@@ -172,16 +167,6 @@ static int __devinit jz4740_hwmon_probe(struct platform_device *pdev)
 
 err_remove_file:
 	sysfs_remove_group(&pdev->dev.kobj, &jz4740_hwmon_attr_group);
-err_free_irq:
-	free_irq(hwmon->irq, hwmon);
-err_iounmap:
-	platform_set_drvdata(pdev, NULL);
-	iounmap(hwmon->base);
-err_release_mem_region:
-	release_mem_region(hwmon->mem->start, resource_size(hwmon->mem));
-err_free:
-	kfree(hwmon);
-
 	return ret;
 }
 
@@ -192,14 +177,6 @@ static int __devexit jz4740_hwmon_remove(struct platform_device *pdev)
 	hwmon_device_unregister(hwmon->hwmon);
 	sysfs_remove_group(&pdev->dev.kobj, &jz4740_hwmon_attr_group);
 
-	free_irq(hwmon->irq, hwmon);
-
-	iounmap(hwmon->base);
-	release_mem_region(hwmon->mem->start, resource_size(hwmon->mem));
-
-	platform_set_drvdata(pdev, NULL);
-	kfree(hwmon);
-
 	return 0;
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
