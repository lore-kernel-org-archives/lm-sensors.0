From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 30 Mar 2013 16:19:19 +0000
Subject: [lm-sensors] [PATCH] hwmon: (gpio-fan) Use is_visible to determine if attributes should be created
Message-Id: <1364660359-27990-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Simplify code and reduce object size by more than 300 bytes (x86_64).

Cc: Jamie Lentin <jm@lentin.co.uk>
Cc: Simon Guinot <sguinot@lacie.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/gpio-fan.c |  104 +++++++++++++++++-----------------------------
 1 file changed, 39 insertions(+), 65 deletions(-)

diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
index 4e02480..3104149 100644
--- a/drivers/hwmon/gpio-fan.c
+++ b/drivers/hwmon/gpio-fan.c
@@ -105,10 +105,6 @@ static int fan_alarm_init(struct gpio_fan_data *fan_data,
 	if (err)
 		return err;
 
-	err = device_create_file(&pdev->dev, &dev_attr_fan1_alarm);
-	if (err)
-		return err;
-
 	/*
 	 * If the alarm GPIO don't support interrupts, just leave
 	 * without initializing the fail notification support.
@@ -121,23 +117,9 @@ static int fan_alarm_init(struct gpio_fan_data *fan_data,
 	irq_set_irq_type(alarm_irq, IRQ_TYPE_EDGE_BOTH);
 	err = devm_request_irq(&pdev->dev, alarm_irq, fan_alarm_irq_handler,
 			       IRQF_SHARED, "GPIO fan alarm", fan_data);
-	if (err)
-		goto err_free_sysfs;
-
-	return 0;
-
-err_free_sysfs:
-	device_remove_file(&pdev->dev, &dev_attr_fan1_alarm);
 	return err;
 }
 
-static void fan_alarm_free(struct gpio_fan_data *fan_data)
-{
-	struct platform_device *pdev = fan_data->pdev;
-
-	device_remove_file(&pdev->dev, &dev_attr_fan1_alarm);
-}
-
 /*
  * Control GPIOs.
  */
@@ -327,6 +309,12 @@ exit_unlock:
 	return ret;
 }
 
+static ssize_t show_name(struct device *dev,
+			 struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "gpio-fan\n");
+}
+
 static DEVICE_ATTR(pwm1, S_IRUGO | S_IWUSR, show_pwm, set_pwm);
 static DEVICE_ATTR(pwm1_enable, S_IRUGO | S_IWUSR,
 		   show_pwm_enable, set_pwm_enable);
@@ -336,8 +324,26 @@ static DEVICE_ATTR(fan1_max, S_IRUGO, show_rpm_max, NULL);
 static DEVICE_ATTR(fan1_input, S_IRUGO, show_rpm, NULL);
 static DEVICE_ATTR(fan1_target, S_IRUGO | S_IWUSR, show_rpm, set_rpm);
 
-static struct attribute *gpio_fan_ctrl_attributes[] = {
-	&dev_attr_pwm1.attr,
+static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
+
+static umode_t gpio_fan_is_visible(struct kobject *kobj,
+				   struct attribute *attr, int index)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct gpio_fan_data *data = dev_get_drvdata(dev);
+
+	if (index = 1 && !data->alarm)
+		return 0;
+	if (index > 1 && !data->ctrl)
+		return 0;
+
+	return attr->mode;
+}
+
+static struct attribute *gpio_fan_attributes[] = {
+	&dev_attr_name.attr,
+	&dev_attr_fan1_alarm.attr,		/* 1 */
+	&dev_attr_pwm1.attr,			/* 2 */
 	&dev_attr_pwm1_enable.attr,
 	&dev_attr_pwm1_mode.attr,
 	&dev_attr_fan1_input.attr,
@@ -347,8 +353,9 @@ static struct attribute *gpio_fan_ctrl_attributes[] = {
 	NULL
 };
 
-static const struct attribute_group gpio_fan_ctrl_group = {
-	.attrs = gpio_fan_ctrl_attributes,
+static const struct attribute_group gpio_fan_group = {
+	.attrs = gpio_fan_attributes,
+	.is_visible = gpio_fan_is_visible,
 };
 
 static int fan_ctrl_init(struct gpio_fan_data *fan_data,
@@ -379,30 +386,9 @@ static int fan_ctrl_init(struct gpio_fan_data *fan_data,
 	if (fan_data->speed_index < 0)
 		return -ENODEV;
 
-	err = sysfs_create_group(&pdev->dev.kobj, &gpio_fan_ctrl_group);
-	return err;
-}
-
-static void fan_ctrl_free(struct gpio_fan_data *fan_data)
-{
-	struct platform_device *pdev = fan_data->pdev;
-
-	sysfs_remove_group(&pdev->dev.kobj, &gpio_fan_ctrl_group);
-}
-
-/*
- * Platform driver.
- */
-
-static ssize_t show_name(struct device *dev,
-			 struct device_attribute *attr, char *buf)
-{
-	return sprintf(buf, "gpio-fan\n");
+	return 0;
 }
 
-static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
-
-
 #ifdef CONFIG_OF_GPIO
 /*
  * Translate OpenFirmware node properties into platform_data
@@ -546,38 +532,30 @@ static int gpio_fan_probe(struct platform_device *pdev)
 
 	/* Configure control GPIOs if available. */
 	if (pdata->ctrl && pdata->num_ctrl > 0) {
-		if (!pdata->speed || pdata->num_speed <= 1) {
-			err = -EINVAL;
-			goto err_free_alarm;
-		}
+		if (!pdata->speed || pdata->num_speed <= 1)
+			return -EINVAL;
 		err = fan_ctrl_init(fan_data, pdata);
 		if (err)
-			goto err_free_alarm;
+			return err;
 	}
 
-	err = device_create_file(&pdev->dev, &dev_attr_name);
+	err = sysfs_create_group(&pdev->dev.kobj, &gpio_fan_group);
 	if (err)
-		goto err_free_ctrl;
+		return err;
 
 	/* Make this driver part of hwmon class. */
 	fan_data->hwmon_dev = hwmon_device_register(&pdev->dev);
 	if (IS_ERR(fan_data->hwmon_dev)) {
 		err = PTR_ERR(fan_data->hwmon_dev);
-		goto err_remove_name;
+		goto err_remove;
 	}
 
 	dev_info(&pdev->dev, "GPIO fan initialized\n");
 
 	return 0;
 
-err_remove_name:
-	device_remove_file(&pdev->dev, &dev_attr_name);
-err_free_ctrl:
-	if (fan_data->ctrl)
-		fan_ctrl_free(fan_data);
-err_free_alarm:
-	if (fan_data->alarm)
-		fan_alarm_free(fan_data);
+err_remove:
+	sysfs_remove_group(&pdev->dev.kobj, &gpio_fan_group);
 	return err;
 }
 
@@ -586,11 +564,7 @@ static int gpio_fan_remove(struct platform_device *pdev)
 	struct gpio_fan_data *fan_data = platform_get_drvdata(pdev);
 
 	hwmon_device_unregister(fan_data->hwmon_dev);
-	device_remove_file(&pdev->dev, &dev_attr_name);
-	if (fan_data->alarm)
-		fan_alarm_free(fan_data);
-	if (fan_data->ctrl)
-		fan_ctrl_free(fan_data);
+	sysfs_remove_group(&pdev->dev.kobj, &gpio_fan_group);
 
 	return 0;
 }
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
