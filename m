From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:23:20 +0000
Subject: [lm-sensors] [PATCH 39/95] hwmon: (gpio-fan) Convert to use devm_ functions
Message-Id: <1339773856-3443-40-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Cc: Simon Guinot <sguinot@lacie.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/gpio-fan.c |   56 +++++++++++++---------------------------------
 1 file changed, 15 insertions(+), 41 deletions(-)

diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
index 2ce8c44..b90b3e9 100644
--- a/drivers/hwmon/gpio-fan.c
+++ b/drivers/hwmon/gpio-fan.c
@@ -95,17 +95,17 @@ static int fan_alarm_init(struct gpio_fan_data *fan_data,
 
 	fan_data->alarm = alarm;
 
-	err = gpio_request(alarm->gpio, "GPIO fan alarm");
+	err = devm_gpio_request(&pdev->dev, alarm->gpio, "GPIO fan alarm");
 	if (err)
 		return err;
 
 	err = gpio_direction_input(alarm->gpio);
 	if (err)
-		goto err_free_gpio;
+		return err;
 
 	err = device_create_file(&pdev->dev, &dev_attr_fan1_alarm);
 	if (err)
-		goto err_free_gpio;
+		return err;
 
 	/*
 	 * If the alarm GPIO don't support interrupts, just leave
@@ -117,8 +117,8 @@ static int fan_alarm_init(struct gpio_fan_data *fan_data,
 
 	INIT_WORK(&fan_data->alarm_work, fan_alarm_notify);
 	irq_set_irq_type(alarm_irq, IRQ_TYPE_EDGE_BOTH);
-	err = request_irq(alarm_irq, fan_alarm_irq_handler, IRQF_SHARED,
-			  "GPIO fan alarm", fan_data);
+	err = devm_request_irq(&pdev->dev, alarm_irq, fan_alarm_irq_handler,
+			       IRQF_SHARED, "GPIO fan alarm", fan_data);
 	if (err)
 		goto err_free_sysfs;
 
@@ -126,21 +126,14 @@ static int fan_alarm_init(struct gpio_fan_data *fan_data,
 
 err_free_sysfs:
 	device_remove_file(&pdev->dev, &dev_attr_fan1_alarm);
-err_free_gpio:
-	gpio_free(alarm->gpio);
-
 	return err;
 }
 
 static void fan_alarm_free(struct gpio_fan_data *fan_data)
 {
 	struct platform_device *pdev = fan_data->pdev;
-	int alarm_irq = gpio_to_irq(fan_data->alarm->gpio);
 
-	if (alarm_irq >= 0)
-		free_irq(alarm_irq, fan_data);
 	device_remove_file(&pdev->dev, &dev_attr_fan1_alarm);
-	gpio_free(fan_data->alarm->gpio);
 }
 
 /*
@@ -365,15 +358,14 @@ static int fan_ctrl_init(struct gpio_fan_data *fan_data,
 	int i, err;
 
 	for (i = 0; i < num_ctrl; i++) {
-		err = gpio_request(ctrl[i], "GPIO fan control");
+		err = devm_gpio_request(&pdev->dev, ctrl[i],
+					"GPIO fan control");
 		if (err)
-			goto err_free_gpio;
+			return err;
 
 		err = gpio_direction_output(ctrl[i], gpio_get_value(ctrl[i]));
-		if (err) {
-			gpio_free(ctrl[i]);
-			goto err_free_gpio;
-		}
+		if (err)
+			return err;
 	}
 
 	fan_data->num_ctrl = num_ctrl;
@@ -382,32 +374,18 @@ static int fan_ctrl_init(struct gpio_fan_data *fan_data,
 	fan_data->speed = pdata->speed;
 	fan_data->pwm_enable = true; /* Enable manual fan speed control. */
 	fan_data->speed_index = get_fan_speed_index(fan_data);
-	if (fan_data->speed_index < 0) {
-		err = -ENODEV;
-		goto err_free_gpio;
-	}
+	if (fan_data->speed_index < 0)
+		return -ENODEV;
 
 	err = sysfs_create_group(&pdev->dev.kobj, &gpio_fan_ctrl_group);
-	if (err)
-		goto err_free_gpio;
-
-	return 0;
-
-err_free_gpio:
-	for (i = i - 1; i >= 0; i--)
-		gpio_free(ctrl[i]);
-
 	return err;
 }
 
 static void fan_ctrl_free(struct gpio_fan_data *fan_data)
 {
 	struct platform_device *pdev = fan_data->pdev;
-	int i;
 
 	sysfs_remove_group(&pdev->dev.kobj, &gpio_fan_ctrl_group);
-	for (i = 0; i < fan_data->num_ctrl; i++)
-		gpio_free(fan_data->ctrl[i]);
 }
 
 /*
@@ -431,7 +409,8 @@ static int __devinit gpio_fan_probe(struct platform_device *pdev)
 	if (!pdata)
 		return -EINVAL;
 
-	fan_data = kzalloc(sizeof(struct gpio_fan_data), GFP_KERNEL);
+	fan_data = devm_kzalloc(&pdev->dev, sizeof(struct gpio_fan_data),
+				GFP_KERNEL);
 	if (!fan_data)
 		return -ENOMEM;
 
@@ -443,7 +422,7 @@ static int __devinit gpio_fan_probe(struct platform_device *pdev)
 	if (pdata->alarm) {
 		err = fan_alarm_init(fan_data, pdata->alarm);
 		if (err)
-			goto err_free_data;
+			return err;
 	}
 
 	/* Configure control GPIOs if available. */
@@ -480,10 +459,6 @@ err_free_ctrl:
 err_free_alarm:
 	if (fan_data->alarm)
 		fan_alarm_free(fan_data);
-err_free_data:
-	platform_set_drvdata(pdev, NULL);
-	kfree(fan_data);
-
 	return err;
 }
 
@@ -497,7 +472,6 @@ static int __devexit gpio_fan_remove(struct platform_device *pdev)
 		fan_alarm_free(fan_data);
 	if (fan_data->ctrl)
 		fan_ctrl_free(fan_data);
-	kfree(fan_data);
 
 	return 0;
 }
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
