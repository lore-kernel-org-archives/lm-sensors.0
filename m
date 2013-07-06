From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 06 Jul 2013 17:24:54 +0000
Subject: [lm-sensors] [RFC PATCH 4/5] hwmon: (gpio-fan) Convert to use hwmon_device_register_groups
Message-Id: <1373131495-13465-5-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1373131495-13465-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1373131495-13465-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/gpio-fan.c |   23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
index 3104149..7953d99 100644
--- a/drivers/hwmon/gpio-fan.c
+++ b/drivers/hwmon/gpio-fan.c
@@ -358,6 +358,11 @@ static const struct attribute_group gpio_fan_group = {
 	.is_visible = gpio_fan_is_visible,
 };
 
+static const struct attribute_group *gpio_fan_groups[] = {
+	&gpio_fan_group,
+	NULL
+};
+
 static int fan_ctrl_init(struct gpio_fan_data *fan_data,
 			 struct gpio_fan_platform_data *pdata)
 {
@@ -539,24 +544,15 @@ static int gpio_fan_probe(struct platform_device *pdev)
 			return err;
 	}
 
-	err = sysfs_create_group(&pdev->dev.kobj, &gpio_fan_group);
-	if (err)
-		return err;
-
 	/* Make this driver part of hwmon class. */
-	fan_data->hwmon_dev = hwmon_device_register(&pdev->dev);
-	if (IS_ERR(fan_data->hwmon_dev)) {
-		err = PTR_ERR(fan_data->hwmon_dev);
-		goto err_remove;
-	}
+	fan_data->hwmon_dev = hwmon_device_register_groups(&pdev->dev, fan_data,
+							   gpio_fan_groups);
+	if (IS_ERR(fan_data->hwmon_dev))
+		return PTR_ERR(fan_data->hwmon_dev);
 
 	dev_info(&pdev->dev, "GPIO fan initialized\n");
 
 	return 0;
-
-err_remove:
-	sysfs_remove_group(&pdev->dev.kobj, &gpio_fan_group);
-	return err;
 }
 
 static int gpio_fan_remove(struct platform_device *pdev)
@@ -564,7 +560,6 @@ static int gpio_fan_remove(struct platform_device *pdev)
 	struct gpio_fan_data *fan_data = platform_get_drvdata(pdev);
 
 	hwmon_device_unregister(fan_data->hwmon_dev);
-	sysfs_remove_group(&pdev->dev.kobj, &gpio_fan_group);
 
 	return 0;
 }
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
