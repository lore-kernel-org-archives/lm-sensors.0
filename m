From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:23:12 +0000
Subject: [lm-sensors] [PATCH 31/95] hwmon: (exynos4_tmu) Convert to use devm_ functions
Message-Id: <1339773856-3443-32-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/exynos4_tmu.c |   45 ++++++++++++-------------------------------
 1 file changed, 12 insertions(+), 33 deletions(-)

diff --git a/drivers/hwmon/exynos4_tmu.c b/drivers/hwmon/exynos4_tmu.c
index f2359a0..17dd076 100644
--- a/drivers/hwmon/exynos4_tmu.c
+++ b/drivers/hwmon/exynos4_tmu.c
@@ -356,7 +356,8 @@ static int __devinit exynos4_tmu_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	data = kzalloc(sizeof(struct exynos4_tmu_data), GFP_KERNEL);
+	data = devm_kzalloc(&pdev->dev, sizeof(struct exynos4_tmu_data),
+			    GFP_KERNEL);
 	if (!data) {
 		dev_err(&pdev->dev, "Failed to allocate driver structure\n");
 		return -ENOMEM;
@@ -364,48 +365,45 @@ static int __devinit exynos4_tmu_probe(struct platform_device *pdev)
 
 	data->irq = platform_get_irq(pdev, 0);
 	if (data->irq < 0) {
-		ret = data->irq;
 		dev_err(&pdev->dev, "Failed to get platform irq\n");
-		goto err_free;
+		return data->irq;
 	}
 
 	INIT_WORK(&data->irq_work, exynos4_tmu_work);
 
 	data->mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!data->mem) {
-		ret = -ENOENT;
 		dev_err(&pdev->dev, "Failed to get platform resource\n");
-		goto err_free;
+		return -ENOENT;
 	}
 
-	data->mem = request_mem_region(data->mem->start,
+	data->mem = devm_request_mem_region(&pdev->dev, data->mem->start,
 			resource_size(data->mem), pdev->name);
 	if (!data->mem) {
-		ret = -ENODEV;
 		dev_err(&pdev->dev, "Failed to request memory region\n");
-		goto err_free;
+		return -ENODEV;
 	}
 
-	data->base = ioremap(data->mem->start, resource_size(data->mem));
+	data->base = devm_ioremap(&pdev->dev, data->mem->start,
+				  resource_size(data->mem));
 	if (!data->base) {
-		ret = -ENODEV;
 		dev_err(&pdev->dev, "Failed to ioremap memory\n");
-		goto err_mem_region;
+		return -ENODEV;
 	}
 
-	ret = request_irq(data->irq, exynos4_tmu_irq,
+	ret = devm_request_irq(&pdev->dev, data->irq, exynos4_tmu_irq,
 		IRQF_TRIGGER_RISING,
 		"exynos4-tmu", data);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to request irq: %d\n", data->irq);
-		goto err_io_remap;
+		return ret;
 	}
 
 	data->clk = clk_get(NULL, "tmu_apbif");
 	if (IS_ERR(data->clk)) {
 		ret = PTR_ERR(data->clk);
 		dev_err(&pdev->dev, "Failed to get clock\n");
-		goto err_irq;
+		return ret;
 	}
 
 	data->pdata = pdata;
@@ -438,17 +436,7 @@ static int __devinit exynos4_tmu_probe(struct platform_device *pdev)
 err_create_group:
 	sysfs_remove_group(&pdev->dev.kobj, &exynos4_tmu_attr_group);
 err_clk:
-	platform_set_drvdata(pdev, NULL);
 	clk_put(data->clk);
-err_irq:
-	free_irq(data->irq, data);
-err_io_remap:
-	iounmap(data->base);
-err_mem_region:
-	release_mem_region(data->mem->start, resource_size(data->mem));
-err_free:
-	kfree(data);
-
 	return ret;
 }
 
@@ -463,15 +451,6 @@ static int __devexit exynos4_tmu_remove(struct platform_device *pdev)
 
 	clk_put(data->clk);
 
-	free_irq(data->irq, data);
-
-	iounmap(data->base);
-	release_mem_region(data->mem->start, resource_size(data->mem));
-
-	platform_set_drvdata(pdev, NULL);
-
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
