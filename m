From: Axel Lin <axel.lin@ingics.com>
Date: Sat, 14 Jun 2014 06:50:50 +0000
Subject: [lm-sensors] [PATCH RFT] hwmon: (gpio-fan) Convert to devm_hwmon_device_register_with_groups
Message-Id: <1402728650.25269.1.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This simplifies the code a bit and also ensures the attribute groups are
properly removed from sysfs when unload the module.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/gpio-fan.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
index ba35e4d..2abfc3f 100644
--- a/drivers/hwmon/gpio-fan.c
+++ b/drivers/hwmon/gpio-fan.c
@@ -537,9 +537,10 @@ static int gpio_fan_probe(struct platform_device *pdev)
 	}
 
 	/* Make this driver part of hwmon class. */
-	fan_data->hwmon_dev = hwmon_device_register_with_groups(&pdev->dev,
-						"gpio-fan", fan_data,
-						gpio_fan_groups);
+	fan_data->hwmon_dev +		devm_hwmon_device_register_with_groups(&pdev->dev,
+						       "gpio-fan", fan_data,
+						       gpio_fan_groups);
 	if (IS_ERR(fan_data->hwmon_dev))
 		return PTR_ERR(fan_data->hwmon_dev);
 
@@ -548,15 +549,6 @@ static int gpio_fan_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int gpio_fan_remove(struct platform_device *pdev)
-{
-	struct gpio_fan_data *fan_data = platform_get_drvdata(pdev);
-
-	hwmon_device_unregister(fan_data->hwmon_dev);
-
-	return 0;
-}
-
 #ifdef CONFIG_PM_SLEEP
 static int gpio_fan_suspend(struct device *dev)
 {
@@ -588,7 +580,6 @@ static SIMPLE_DEV_PM_OPS(gpio_fan_pm, gpio_fan_suspend, gpio_fan_resume);
 
 static struct platform_driver gpio_fan_driver = {
 	.probe		= gpio_fan_probe,
-	.remove		= gpio_fan_remove,
 	.driver	= {
 		.name	= "gpio-fan",
 		.pm	= GPIO_FAN_PM,
-- 
1.8.3.2




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
