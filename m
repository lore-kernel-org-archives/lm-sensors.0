From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 17 May 2010 00:27:37 +0000
Subject: [lm-sensors] [PATCH] hwmon: DNS323 rev C1 fan support
Message-Id: <1274056057.21352.696.camel@pasglop>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The hardware only supports 3 settings: off, slow and fast.

In order to have a chance to work with existing fan control systems,
we emulate a PWM device with the following mapping:

   0.. 15  off
  16..127  slow
 128..255  fast

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Note: These numbers have been picked up pretty randomly and I haven't
had a chance yet to check how fancontrol copes with them. However,
at least we get reasonable "manual" control, and it should at least
be able to pump the fans to full speed if the temperature is too high
so we can always adjust the thresholds later on.

---
 drivers/hwmon/Kconfig       |   12 ++
 drivers/hwmon/Makefile      |    1 +
 drivers/hwmon/dns323c-fan.c |  237 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 250 insertions(+), 0 deletions(-)
 create mode 100644 drivers/hwmon/dns323c-fan.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 9be8e17..5f55735 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1087,6 +1087,18 @@ config SENSORS_MC13783_ADC
         help
           Support for the A/D converter on MC13783 PMIC.
 
+config SENSORS_DNS323C_FAN
+       tristate "D-Link DNS323 rev C1 Fan"
+       depends on MACH_DNS323
+       help
+         Support for the GPIO based fan control on the D-Link DNS323
+	 HW revision C1. This exposes a pseudo pwm device with the
+	 following values supported:
+
+	 	    0..15	: Fan off
+		   16..127	: Fan on low speed
+		  128..255	: Fan on high speed
+	 
 if ACPI
 
 comment "ACPI drivers"
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 4aa1a3d..15bcdef 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -100,6 +100,7 @@ obj-$(CONFIG_SENSORS_W83L785TS)	+= w83l785ts.o
 obj-$(CONFIG_SENSORS_W83L786NG)	+= w83l786ng.o
 obj-$(CONFIG_SENSORS_WM831X)	+= wm831x-hwmon.o
 obj-$(CONFIG_SENSORS_WM8350)	+= wm8350-hwmon.o
+obj-$(CONFIG_SENSORS_DNS323C_FAN)+= dns323c-fan.o
 
 ifeq ($(CONFIG_HWMON_DEBUG_CHIP),y)
 EXTRA_CFLAGS += -DDEBUG
diff --git a/drivers/hwmon/dns323c-fan.c b/drivers/hwmon/dns323c-fan.c
new file mode 100644
index 0000000..c10c58e
--- /dev/null
+++ b/drivers/hwmon/dns323c-fan.c
@@ -0,0 +1,237 @@
+/*
+ *  dns323c_fan - Driver for the D-LINK DNS-323 rev C1 fan control
+ *
+ *  Copyright 2010 Benjamin Herrenschmidt
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/gpio.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/gfp.h>
+#include <linux/slab.h>
+#include <linux/err.h>
+#include <linux/sysfs.h>
+#include <linux/platform_device.h>
+
+enum fan_speed {
+	FAN_OFF,
+	FAN_LOW	,
+	FAN_FAST,
+	FAN_FAST_LOCK,
+};
+
+#define DNS323C_GPIO_FAN_BIT1		18
+#define DNS323C_GPIO_FAN_BIT0		19
+
+struct dns323c_fan {
+	struct device	*hwmon;
+	struct mutex	lock;
+	enum fan_speed	speed;
+};
+
+static void __set_fan_speed(struct dns323c_fan *fan, enum fan_speed speed)
+{
+	if (speed = fan->speed)
+		return;
+
+	switch(speed) {
+	case FAN_OFF:
+		gpio_set_value(DNS323C_GPIO_FAN_BIT1, 0);
+		gpio_set_value(DNS323C_GPIO_FAN_BIT0, 0);
+		break;
+	case FAN_LOW:
+		gpio_set_value(DNS323C_GPIO_FAN_BIT1, 0);
+		gpio_set_value(DNS323C_GPIO_FAN_BIT0, 1);
+		break;
+	default:
+		gpio_set_value(DNS323C_GPIO_FAN_BIT0, 0);
+		gpio_set_value(DNS323C_GPIO_FAN_BIT1, 1);
+	};
+	fan->speed = speed;
+}
+
+static ssize_t show_pwm(struct device *dev, struct device_attribute *da,
+			char *buf)
+{
+	struct dns323c_fan *fan = dev_get_drvdata(dev);
+	int pseudo_pwm;
+
+	switch(fan->speed) {
+	case FAN_OFF:
+		pseudo_pwm = 0;
+		break;
+	case FAN_LOW:
+		pseudo_pwm = 63;
+		break;
+	default:
+		pseudo_pwm = 255;
+	}
+	return sprintf(buf, "%d\n", pseudo_pwm);
+}
+
+static ssize_t set_pwm(struct device *dev, struct device_attribute *da,
+		       const char *buf, size_t count)
+{
+	struct dns323c_fan *fan = dev_get_drvdata(dev);
+	enum fan_speed speed;
+	unsigned long val;
+
+	if (strict_strtoul(buf, 10, &val))
+		return -EINVAL;
+	if (fan->speed = FAN_FAST_LOCK)
+		return count;
+
+	mutex_lock(&fan->lock);
+	if (val < 16)
+		speed = FAN_OFF;
+	else if (val < 128)
+		speed = FAN_LOW;
+	else
+		speed = FAN_FAST;
+	__set_fan_speed(fan, speed);
+	mutex_unlock(&fan->lock);
+
+	return count;
+}
+
+static ssize_t show_pwm_en(struct device *dev, struct device_attribute *da,
+			   char *buf)
+{
+	struct dns323c_fan *fan = dev_get_drvdata(dev);
+
+	if (fan->speed = FAN_FAST_LOCK)
+		return sprintf(buf, "0\n");
+	else
+		return sprintf(buf, "1\n");
+}
+
+static ssize_t set_pwm_en(struct device *dev, struct device_attribute *da,
+			  const char *buf, size_t count)
+{
+	struct dns323c_fan *fan = dev_get_drvdata(dev);
+	enum fan_speed speed;
+	unsigned long val;
+
+	if (strict_strtoul(buf, 10, &val))
+		return -EINVAL;
+	if (val != 0 && val != 1)
+		return -EINVAL;
+
+	mutex_lock(&fan->lock);
+	if (val = 0 && fan->speed != FAN_FAST_LOCK)
+		speed = FAN_FAST_LOCK;
+	else if (val != 0 && fan->speed = FAN_FAST_LOCK)
+		speed = FAN_FAST;
+	else
+		speed = fan->speed;
+	__set_fan_speed(fan, speed);
+	mutex_unlock(&fan->lock);
+
+	return count;
+}
+
+static DEVICE_ATTR(pwm1, S_IRUGO | S_IWUSR, show_pwm, set_pwm);
+static DEVICE_ATTR(pwm1_enable, S_IRUGO | S_IWUSR, show_pwm_en, set_pwm_en);
+
+static int dns323c_fan_probe(struct platform_device *pdev)
+{
+	struct dns323c_fan *fan = NULL;
+	int ret = -ENXIO;
+
+	/* Get the GPIOs */
+	if (gpio_request(DNS323C_GPIO_FAN_BIT0, "FAN0") != 0) {
+		pr_err("dns323c_fan: Failed to request fan GPIO 0 !\n");
+		return -ENXIO;
+	}
+	if (gpio_request(DNS323C_GPIO_FAN_BIT1, "FAN1") != 0) {
+		pr_err("dns323c_fan: Failed to request fan GPIO 1 !\n");
+		goto err_gpio;
+	}
+
+	/* Set directions to output and medium speed. We write bit 1 first
+	 * since it contains 0 to avoid having a transitory 11 state which
+	 * isn't supported
+	 */
+	gpio_direction_output(DNS323C_GPIO_FAN_BIT1, 0);
+	gpio_direction_output(DNS323C_GPIO_FAN_BIT0, 1);
+
+	/* Grab some memory for our state */
+	fan = kzalloc(sizeof(struct dns323c_fan), GFP_KERNEL);
+	if (!fan) {
+		ret = -ENOMEM;
+		goto err_alloc;
+	}
+	fan->speed = FAN_LOW;
+	mutex_init(&fan->lock);
+	platform_set_drvdata(pdev, fan);
+
+	ret = device_create_file(&pdev->dev, &dev_attr_pwm1);
+	ret |= device_create_file(&pdev->dev, &dev_attr_pwm1_enable);
+	if (ret)
+		goto err_file;
+
+	fan->hwmon = hwmon_device_register(&pdev->dev);
+	if (IS_ERR(fan->hwmon)) {
+		ret = PTR_ERR(fan->hwmon);
+		goto err_dev;
+	}
+	return 0;
+
+ err_dev:
+	device_remove_file(&pdev->dev, &dev_attr_pwm1);
+	device_remove_file(&pdev->dev, &dev_attr_pwm1_enable);
+ err_file:
+	kfree(fan);
+ err_alloc:
+	gpio_free(DNS323C_GPIO_FAN_BIT1);
+ err_gpio:
+	gpio_free(DNS323C_GPIO_FAN_BIT0);
+	return ret;
+}
+
+static int __devexit dns323c_fan_remove(struct platform_device *pdev)
+{
+	struct dns323c_fan *fan = platform_get_drvdata(pdev);
+
+	hwmon_device_unregister(fan->hwmon);
+	device_remove_file(&pdev->dev, &dev_attr_pwm1);
+	device_remove_file(&pdev->dev, &dev_attr_pwm1_enable);
+	kfree(fan);
+	gpio_free(DNS323C_GPIO_FAN_BIT1);
+	gpio_free(DNS323C_GPIO_FAN_BIT0);
+	return 0;
+}
+
+static struct platform_driver dns323c_fan_driver = {
+	.probe = dns323c_fan_probe,
+	.remove = __devexit_p(dns323c_fan_remove),
+	.driver = {
+		.name = "dns323c-fan",
+		.owner = THIS_MODULE,
+	},
+};
+
+static int __init dns323c_fan_init(void)
+{
+	return platform_driver_register(&dns323c_fan_driver);
+}
+
+static void __exit dns323c_fan_exit(void)
+{
+	platform_driver_unregister(&dns323c_fan_driver);
+}
+
+MODULE_AUTHOR("Benjamin Herrenschmidt <benh@kernel.crashing.org>");
+MODULE_DESCRIPTION("DNS323 RevC1 Fan control");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:dns323c-fan");
+
+module_init(dns323c_fan_init);
+module_exit(dns323c_fan_exit);



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
