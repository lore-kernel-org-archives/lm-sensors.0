From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Sat, 07 Jul 2012 21:05:28 +0000
Subject: [lm-sensors] [PATCH 3/4] hwmon / gpio-fan: Use struct dev_pm_ops for power management
Message-Id: <201207072305.28595.rjw@sisk.pl>
List-Id: <lm-sensors.vger.kernel.org>
References: <201207072302.16491.rjw@sisk.pl>
In-Reply-To: <201207072302.16491.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Alistair John Strachan <alistair@devzero.co.uk>, lm-sensors@lm-sensors.org, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <linux@roeck-us.net>, Kukjin Kim <kgene.kim@samsung.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

Make the gpio-fan driver define its PM callbacks through
a struct dev_pm_ops object rather than by using legacy PM hooks
in struct platform_driver.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/hwmon/gpio-fan.c |   19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

Index: linux/drivers/hwmon/gpio-fan.c
=================================--- linux.orig/drivers/hwmon/gpio-fan.c
+++ linux/drivers/hwmon/gpio-fan.c
@@ -503,10 +503,11 @@ static int __devexit gpio_fan_remove(str
 }
 
 #ifdef CONFIG_PM
-static int gpio_fan_suspend(struct platform_device *pdev, pm_message_t state)
+static int gpio_fan_suspend(struct device *dev)
 {
-	struct gpio_fan_data *fan_data = platform_get_drvdata(pdev);
+	struct gpio_fan_data *fan_data;
 
+	fan_data = platform_get_drvdata(to_platform_device(dev));
 	if (fan_data->ctrl) {
 		fan_data->resume_speed = fan_data->speed_index;
 		set_fan_speed(fan_data, 0);
@@ -515,27 +516,29 @@ static int gpio_fan_suspend(struct platf
 	return 0;
 }
 
-static int gpio_fan_resume(struct platform_device *pdev)
+static int gpio_fan_resume(struct device *dev)
 {
-	struct gpio_fan_data *fan_data = platform_get_drvdata(pdev);
+	struct gpio_fan_data *fan_data;
 
+	fan_data = platform_get_drvdata(to_platform_device(dev));
 	if (fan_data->ctrl)
 		set_fan_speed(fan_data, fan_data->resume_speed);
 
 	return 0;
 }
+
+static SIMPLE_DEV_PM_OPS(gpio_fan_pm, gpio_fan_suspend, gpio_fan_resume);
+#define GPIO_FAN_PM	(&gpio_fan_pm)
 #else
-#define gpio_fan_suspend NULL
-#define gpio_fan_resume NULL
+#define GPIO_FAN_PM	NULL
 #endif
 
 static struct platform_driver gpio_fan_driver = {
 	.probe		= gpio_fan_probe,
 	.remove		= __devexit_p(gpio_fan_remove),
-	.suspend	= gpio_fan_suspend,
-	.resume		= gpio_fan_resume,
 	.driver	= {
 		.name	= "gpio-fan",
+		.pm	= GPIO_FAN_PM,
 	},
 };
 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
