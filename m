From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:23:53 +0000
Subject: [lm-sensors] [PATCH 72/95] hwmon: (sht15) Convert to use devm_ functions
Message-Id: <1339773856-3443-73-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Cc: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/sht15.c |   51 ++++++++++++++++++-------------------------------
 1 file changed, 19 insertions(+), 32 deletions(-)

diff --git a/drivers/hwmon/sht15.c b/drivers/hwmon/sht15.c
index 8b011d0..80f235a 100644
--- a/drivers/hwmon/sht15.c
+++ b/drivers/hwmon/sht15.c
@@ -884,13 +884,13 @@ static int sht15_invalidate_voltage(struct notifier_block *nb,
 static int __devinit sht15_probe(struct platform_device *pdev)
 {
 	int ret;
-	struct sht15_data *data = kzalloc(sizeof(*data), GFP_KERNEL);
+	struct sht15_data *data;
 	u8 status = 0;
 
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
 	if (!data) {
-		ret = -ENOMEM;
-		dev_err(&pdev->dev, "kzalloc failed\n");
-		goto error_ret;
+		dev_err(&pdev->dev, "devm_kzalloc failed\n");
+		return -ENOMEM;
 	}
 
 	INIT_WORK(&data->read_work, sht15_bh_read_data);
@@ -901,9 +901,8 @@ static int __devinit sht15_probe(struct platform_device *pdev)
 	init_waitqueue_head(&data->wait_queue);
 
 	if (pdev->dev.platform_data = NULL) {
-		ret = -EINVAL;
 		dev_err(&pdev->dev, "no platform data supplied\n");
-		goto err_free_data;
+		return -EINVAL;
 	}
 	data->pdata = pdev->dev.platform_data;
 	data->supply_uV = data->pdata->supply_mv * 1000;
@@ -938,50 +937,51 @@ static int __devinit sht15_probe(struct platform_device *pdev)
 				"regulator notifier request failed\n");
 			regulator_disable(data->reg);
 			regulator_put(data->reg);
-			goto err_free_data;
+			return ret;
 		}
 	}
 
 	/* Try requesting the GPIOs */
-	ret = gpio_request(data->pdata->gpio_sck, "SHT15 sck");
+	ret = devm_gpio_request(&pdev->dev, data->pdata->gpio_sck, "SHT15 sck");
 	if (ret) {
 		dev_err(&pdev->dev, "gpio request failed\n");
 		goto err_release_reg;
 	}
 	gpio_direction_output(data->pdata->gpio_sck, 0);
 
-	ret = gpio_request(data->pdata->gpio_data, "SHT15 data");
+	ret = devm_gpio_request(&pdev->dev, data->pdata->gpio_data,
+				"SHT15 data");
 	if (ret) {
 		dev_err(&pdev->dev, "gpio request failed\n");
-		goto err_release_gpio_sck;
+		goto err_release_reg;
 	}
 
-	ret = request_irq(gpio_to_irq(data->pdata->gpio_data),
-			  sht15_interrupt_fired,
-			  IRQF_TRIGGER_FALLING,
-			  "sht15 data",
-			  data);
+	ret = devm_request_irq(&pdev->dev, gpio_to_irq(data->pdata->gpio_data),
+			       sht15_interrupt_fired,
+			       IRQF_TRIGGER_FALLING,
+			       "sht15 data",
+			       data);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to get irq for data line\n");
-		goto err_release_gpio_data;
+		goto err_release_reg;
 	}
 	disable_irq_nosync(gpio_to_irq(data->pdata->gpio_data));
 	sht15_connection_reset(data);
 	ret = sht15_soft_reset(data);
 	if (ret)
-		goto err_release_irq;
+		goto err_release_reg;
 
 	/* write status with platform data options */
 	if (status) {
 		ret = sht15_send_status(data, status);
 		if (ret)
-			goto err_release_irq;
+			goto err_release_reg;
 	}
 
 	ret = sysfs_create_group(&pdev->dev.kobj, &sht15_attr_group);
 	if (ret) {
 		dev_err(&pdev->dev, "sysfs create failed\n");
-		goto err_release_irq;
+		goto err_release_reg;
 	}
 
 	data->hwmon_dev = hwmon_device_register(data->dev);
@@ -994,21 +994,12 @@ static int __devinit sht15_probe(struct platform_device *pdev)
 
 err_release_sysfs_group:
 	sysfs_remove_group(&pdev->dev.kobj, &sht15_attr_group);
-err_release_irq:
-	free_irq(gpio_to_irq(data->pdata->gpio_data), data);
-err_release_gpio_data:
-	gpio_free(data->pdata->gpio_data);
-err_release_gpio_sck:
-	gpio_free(data->pdata->gpio_sck);
 err_release_reg:
 	if (!IS_ERR(data->reg)) {
 		regulator_unregister_notifier(data->reg, &data->nb);
 		regulator_disable(data->reg);
 		regulator_put(data->reg);
 	}
-err_free_data:
-	kfree(data);
-error_ret:
 	return ret;
 }
 
@@ -1033,11 +1024,7 @@ static int __devexit sht15_remove(struct platform_device *pdev)
 		regulator_put(data->reg);
 	}
 
-	free_irq(gpio_to_irq(data->pdata->gpio_data), data);
-	gpio_free(data->pdata->gpio_data);
-	gpio_free(data->pdata->gpio_sck);
 	mutex_unlock(&data->read_lock);
-	kfree(data);
 
 	return 0;
 }
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
