From: Roel Kluin <roel.kluin@gmail.com>
Date: Sat, 22 Aug 2009 14:00:47 +0000
Subject: [lm-sensors] [PATCH] hwmon: Fix freeing of gpio_data and irq
Message-Id: <4A8FFA0F.1070101@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

If already requested, gpio_data and irq should be freed in
the case of an error.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
please review, especially the added free_irq(): are its
arguments ok like this?

diff --git a/drivers/hwmon/sht15.c b/drivers/hwmon/sht15.c
index 6290a25..303c026 100644
--- a/drivers/hwmon/sht15.c
+++ b/drivers/hwmon/sht15.c
@@ -562,7 +562,7 @@ static int __devinit sht15_probe(struct platform_device *pdev)
 	ret = sysfs_create_group(&pdev->dev.kobj, &sht15_attr_group);
 	if (ret) {
 		dev_err(&pdev->dev, "sysfs create failed");
-		goto err_free_data;
+		goto err_release_gpio_data;
 	}
 
 	ret = request_irq(gpio_to_irq(data->pdata->gpio_data),
@@ -581,10 +581,12 @@ static int __devinit sht15_probe(struct platform_device *pdev)
 	data->hwmon_dev = hwmon_device_register(data->dev);
 	if (IS_ERR(data->hwmon_dev)) {
 		ret = PTR_ERR(data->hwmon_dev);
-		goto err_release_gpio_data;
+		goto err_release_irq;
 	}
 	return 0;
 
+err_release_irq:
+	free_irq(gpio_to_irq(data->pdata->gpio_data), data);
 err_release_gpio_data:
 	gpio_free(data->pdata->gpio_data);
 err_release_gpio_sck:

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
