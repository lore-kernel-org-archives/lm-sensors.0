From: Krystian Garbaciak <krystian.garbaciak@diasemi.com>
Date: Fri, 24 Aug 2012 14:25:00 +0000
Subject: [lm-sensors] [RFC PATCH 8/8] leds: Add DA906x PMIC LED driver.
Message-Id: <201208241525@sw-eng-lt-dc-vm2>
List-Id: <lm-sensors.vger.kernel.org>
References: <201208241520@sw-eng-lt-dc-vm2>
In-Reply-To: <201208241520@sw-eng-lt-dc-vm2>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com, lm-sensors@lm-sensors.org, linux-input@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-leds@vger.kernel.org
Cc: Alessandro Zummo <a.zummo@towertech.it>, Andrew Jones <drjones@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Ashish Jangam <ashish.jangam@kpitcummins.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Donggeun Kim <dg77.kim@samsung.com>, Wim Van Sebroeck <wim@iguana.be>, "Richard Purdie <rpurdie@rpsys.net>
	Anthony Olech" <anthony.olech@diasemi.com>, Bryan Wu <bryan.wu@canonical.com>, Liam Girdwood <lrg@ti.com>

PMIC can control three LEDs, devoted to work as RGB LED.

Beside standard brightness setting, the driver provides some hardware blinking
functionality. Driver brings access to blinking register fields inside PMIC
with LED attributes: hw_blink_dur_regval and hw_blink_frq_regval. When the
latter is not 0, hardware blinking is enabled. As long as hardware blinking
is enabled, brightness is set to its maximum.

Signed-off-by: Krystian Garbaciak <krystian.garbaciak@diasemi.com>
---
 drivers/leds/Kconfig       |    8 +
 drivers/leds/Makefile      |    1 +
 drivers/leds/leds-da906x.c |  438 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 447 insertions(+), 0 deletions(-)
 create mode 100644 drivers/leds/leds-da906x.c

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index c96bbaa..46dc3dd 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -287,6 +287,14 @@ config LEDS_DA9052
 	  This option enables support for on-chip LED drivers found
 	  on Dialog Semiconductor DA9052-BC and DA9053-AA/Bx PMICs.
 
+config LEDS_DA906X
+        tristate "Dialog DA906x LEDS"
+        depends on LEDS_CLASS
+        depends on MFD_DA906X
+        help
+          This option enables support for on-chip LED drivers found
+          on Dialog Semiconductor DA906x PMICs
+
 config LEDS_DAC124S085
 	tristate "LED Support for DAC124S085 SPI DAC"
 	depends on LEDS_CLASS
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index a4429a9..1601366 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_LEDS_PCA955X)		+= leds-pca955x.o
 obj-$(CONFIG_LEDS_PCA9633)		+= leds-pca9633.o
 obj-$(CONFIG_LEDS_DA903X)		+= leds-da903x.o
 obj-$(CONFIG_LEDS_DA9052)		+= leds-da9052.o
+obj-$(CONFIG_LEDS_DA906X)		+= leds-da906x.o
 obj-$(CONFIG_LEDS_WM831X_STATUS)	+= leds-wm831x-status.o
 obj-$(CONFIG_LEDS_WM8350)		+= leds-wm8350.o
 obj-$(CONFIG_LEDS_PWM)			+= leds-pwm.o
diff --git a/drivers/leds/leds-da906x.c b/drivers/leds/leds-da906x.c
new file mode 100644
index 0000000..3203fc6
--- /dev/null
+++ b/drivers/leds/leds-da906x.c
@@ -0,0 +1,438 @@
+/*
+ * LEDs driver for Dialog DA906x PMIC series
+ *
+ * Copyright 2012 Dialog Semiconductors Ltd.
+ *
+ * Author: Mariusz Wojtasik <mariusz.wojtasik@diasemi.com>,
+ *         Krystian Garbaciak <krystian.garbaciak@diasemi.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/leds.h>
+#include <linux/err.h>
+#include <linux/mfd/da906x/core.h>
+#include <linux/mfd/da906x/pdata.h>
+
+#define DRIVER_NAME		DA906X_DRVNAME_LEDS
+
+#define	DA906X_GPIO_LED_NUM	3
+
+#define DA906X_PWM_MAX		(DA906X_GPIO_PWM_MASK >> DA906X_GPIO_PWM_SHIFT)
+#define DA906X_MAX_BRIGHTNESS	0x5F
+#define DA906X_BLINK_DUR_MAX	(DA906X_BLINK_DUR_MASK >> \
+							DA906X_BLINK_DUR_SHIFT)
+#define DA906X_BLINK_FRQ_MAX	(DA906X_BLINK_FRQ_MASK >> \
+							DA906X_BLINK_FRQ_SHIFT)
+
+struct da906x_led {
+	int id;
+	struct led_classdev cdev;
+	struct work_struct work;
+	struct da906x *da906x;
+	struct da906x_leds *leds_container;
+
+	int pwm_regval;
+};
+
+struct da906x_leds {
+	int n_leds;
+	/* Array size to be defined during init. Keep at end. */
+	struct da906x_led led[0];
+};
+
+int da906x_led_pwm_reg[DA906X_LED_NUM] = {
+	DA906X_REG_GPO11_LED,
+	DA906X_REG_GPO14_LED,
+	DA906X_REG_GPO15_LED,
+};
+
+static int da906x_led_get_hw_blinking(struct da906x *da906x,
+				      unsigned *frq, unsigned *dur)
+{
+	int ret = da906x_reg_read(da906x, DA906X_REG_CONTROL_D);
+	if (ret < 0)
+		return ret;
+
+	if (frq)
+		*frq = (ret & DA906X_BLINK_FRQ_MASK) >> DA906X_BLINK_FRQ_SHIFT;
+
+	if (dur)
+		*dur = (ret & DA906X_BLINK_DUR_MASK) >> DA906X_BLINK_DUR_SHIFT;
+
+	return 0;
+}
+
+static int
+da906x_led_set_hw_bright(struct da906x *da906x, int id, int pwm_val)
+{
+	unsigned int blink_frq;
+	int ret;
+
+	ret = da906x_led_get_hw_blinking(da906x, &blink_frq, NULL);
+	if (ret)
+		return ret;
+
+	/* For enabled blinking, brightness setting is unavailable */
+	if (!blink_frq)
+		ret = da906x_reg_write(da906x, da906x_led_pwm_reg[id],
+				       pwm_val);
+
+	return ret;
+}
+
+static inline int
+da906x_led_get_hw_bright(struct da906x *da906x, int id)
+{
+	return da906x_reg_read(da906x, da906x_led_pwm_reg[id]);
+}
+
+static void da906x_led_brightness_set(struct led_classdev *cdev,
+	enum led_brightness brightness)
+{
+	struct da906x_led *led = container_of(cdev, struct da906x_led, cdev);
+
+	if (led->pwm_regval != brightness) {
+		led->pwm_regval = brightness;
+		schedule_work(&led->work);
+	}
+}
+
+static void da906x_led_brightness_work(struct work_struct *work)
+{
+	struct da906x_led *led = container_of(work, struct da906x_led, work);
+	int ret;
+
+	ret = da906x_led_set_hw_bright(led->da906x, led->id, led->pwm_regval);
+	if (ret)
+		dev_err(led->da906x->dev,
+			"Failed to set led brightness (err = %d)\n", ret);
+}
+
+static int da906x_configure_led_pin(struct da906x_led *led,
+				    int low_level_driven)
+{
+	int ret;
+	u16 gpio_cfg_reg;
+	u8 gpio_cfg_mask, gpio_cfg_val;
+	u8 mode_cfg_bit;
+
+	switch (led->id) {
+	case DA906X_GPIO11_LED:
+		gpio_cfg_reg = DA906X_REG_GPIO_10_11;
+		gpio_cfg_mask = DA906X_GPIO11_PIN_MASK;
+		gpio_cfg_val = DA906X_GPIO11_PIN_GPO_OD;
+		mode_cfg_bit = DA906X_GPIO11_MODE_LED_ACT_LOW;
+		break;
+
+	case DA906X_GPIO14_LED:
+		gpio_cfg_reg = DA906X_REG_GPIO_14_15;
+		gpio_cfg_mask = DA906X_GPIO14_PIN_MASK;
+		gpio_cfg_val = DA906X_GPIO14_PIN_GPO_OD;
+		mode_cfg_bit = DA906X_GPIO14_MODE_LED_ACT_LOW;
+		break;
+
+	case DA906X_GPIO15_LED:
+		gpio_cfg_reg = DA906X_REG_GPIO_14_15;
+		gpio_cfg_mask = DA906X_GPIO15_PIN_MASK;
+		gpio_cfg_val = DA906X_GPIO15_PIN_GPO_OD;
+		mode_cfg_bit = DA906X_GPIO15_MODE_LED_ACT_LOW;
+		break;
+
+	default:
+		BUG();
+	}
+
+	/* Configure GPOs for open drain */
+	ret = da906x_reg_update(led->da906x, gpio_cfg_reg, gpio_cfg_mask,
+				gpio_cfg_val);
+	if (ret)
+		return ret;
+
+	/* Configure active level */
+	if (low_level_driven)
+		ret = da906x_reg_set_bits(led->da906x,
+					  DA906X_REG_GPIO_MODE_8_15,
+					  mode_cfg_bit);
+	else
+		ret = da906x_reg_clear_bits(led->da906x,
+					    DA906X_REG_GPIO_MODE_8_15,
+					    mode_cfg_bit);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static ssize_t da906x_hw_blink_dur_store(struct device *dev,
+						struct device_attribute *attr,
+						const char *buf, size_t count)
+{
+	struct led_classdev *cdev = dev_get_drvdata(dev);
+	struct da906x_led *led = container_of(cdev, struct da906x_led, cdev);
+	unsigned long dur;
+	int ret;
+
+	ret = kstrtoul(buf, 0, &dur);
+	if (ret || dur > DA906X_BLINK_DUR_MAX) {
+		dev_err(led->da906x->dev,
+			"Invalid parameter (valid are %d..%d)\n",
+			0, DA906X_BLINK_DUR_MAX);
+		return -EINVAL;
+	}
+
+	ret = da906x_reg_update(led->da906x, DA906X_REG_CONTROL_D,
+				DA906X_BLINK_DUR_MASK,
+				dur << DA906X_BLINK_DUR_SHIFT);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static ssize_t da906x_hw_blink_dur_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct led_classdev *cdev = dev_get_drvdata(dev);
+	struct da906x_led *led = container_of(cdev, struct da906x_led, cdev);
+	int ret;
+	unsigned int dur;
+
+	ret = da906x_led_get_hw_blinking(led->da906x, NULL, &dur);
+	if (ret < 0)
+		return ret;
+
+	return sprintf(buf, "%u\n", dur);
+}
+
+static ssize_t da906x_hw_blink_frq_store(struct device *dev,
+						struct device_attribute *attr,
+						const char *buf, size_t count)
+{
+	struct led_classdev *cdev = dev_get_drvdata(dev);
+	struct da906x_led *led = container_of(cdev, struct da906x_led, cdev);
+	struct da906x_leds *leds = led->leds_container;
+	unsigned long frq;
+	int i;
+	int ret;
+
+	ret = kstrtoul(buf, 0, &frq);
+	if (ret || frq > DA906X_BLINK_FRQ_MAX) {
+		dev_err(led->da906x->dev,
+			"Invalid parameter (valid are %d..%d)\n",
+			0, DA906X_BLINK_FRQ_MAX);
+		return -EINVAL;
+	}
+
+	if (frq) {
+		/* Reset all LEDs brightness before blinking */
+		for (i = leds->n_leds - 1; i >= 0; i--) {
+			ret = da906x_led_set_hw_bright(led->da906x, i, 0);
+			if (ret < 0)
+				return ret;
+		}
+	}
+
+	ret = da906x_reg_update(led->da906x, DA906X_REG_CONTROL_D,
+				DA906X_BLINK_FRQ_MASK,
+				frq << DA906X_BLINK_FRQ_SHIFT);
+	if (ret < 0)
+		return ret;
+
+	if (!frq) {
+		/* Restore all LEDs brightness, when blinking is off */
+		for (i = leds->n_leds - 1; i >= 0; i--) {
+			ret = da906x_led_set_hw_bright(led->da906x, i,
+						      leds->led[i].pwm_regval);
+			if (ret < 0)
+				return ret;
+		}
+	}
+
+	return count;
+}
+
+static ssize_t da906x_hw_blink_frq_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct led_classdev *cdev = dev_get_drvdata(dev);
+	struct da906x_led *led = container_of(cdev, struct da906x_led, cdev);
+	int ret;
+	unsigned int frq;
+
+	ret = da906x_led_get_hw_blinking(led->da906x, &frq, NULL);
+	if (ret < 0)
+		return ret;
+
+	return sprintf(buf, "%u\n", frq);
+}
+
+static DEVICE_ATTR(hw_blink_dur_regval, 0644,
+		   da906x_hw_blink_dur_show, da906x_hw_blink_dur_store);
+static DEVICE_ATTR(hw_blink_frq_regval, 0644,
+		   da906x_hw_blink_frq_show, da906x_hw_blink_frq_store);
+
+static int da906x_led_probe(struct platform_device *pdev)
+{
+	struct da906x *da906x;
+	struct da906x_pdata *pdata;
+	struct led_platform_data *leds_pdata;
+	struct led_info *led_info;
+	struct da906x_leds *leds;
+	struct da906x_led *led;
+	size_t size;
+	int ret;
+	int i, j;
+
+	da906x = dev_get_drvdata(pdev->dev.parent);
+	pdata = da906x->dev->platform_data;
+	if (pdata = NULL) {
+		dev_err(&pdev->dev, "No platform data\n");
+		return -ENODEV;
+	}
+
+	leds_pdata = pdata->leds_pdata;
+	if (leds_pdata = NULL) {
+		dev_err(&pdev->dev, "No platform data for LEDs\n");
+		return -ENODEV;
+	}
+
+	size = sizeof(struct da906x_leds) +
+	       sizeof(struct da906x_led) * leds_pdata->num_leds;
+	leds = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
+	if (leds = NULL) {
+		dev_err(&pdev->dev, "Failed to alloc memory\n");
+		return -ENOMEM;
+	}
+
+	leds->n_leds = leds_pdata->num_leds;
+	platform_set_drvdata(pdev, leds);
+
+	for (i = 0; i < leds_pdata->num_leds; i++) {
+		led_info = &leds_pdata->leds[i];
+
+		if ((led_info->flags & DA906X_LED_ID_MASK) >= DA906X_LED_NUM) {
+			dev_err(&pdev->dev, "Invalid platform data\n");
+			ret = -EINVAL;
+			goto err_register;
+		}
+
+		/* Check, if LED ID is not duplicated */
+		for (led = &leds->led[0], j = 0; j < i; led++, j++) {
+			if (led->id =
+			    (led_info->flags & DA906X_LED_ID_MASK)) {
+				dev_err(&pdev->dev, "Duplicated LED ID\n");
+				ret = -EINVAL;
+				goto err_register;
+			}
+		}
+
+		led->id = led_info->flags & DA906X_LED_ID_MASK;
+		led->pwm_regval = da906x_led_get_hw_bright(da906x, i);
+		led->cdev.brightness = led->pwm_regval;
+		led->cdev.max_brightness = DA906X_MAX_BRIGHTNESS;
+		led->cdev.brightness_set = da906x_led_brightness_set;
+		led->cdev.default_trigger = led_info->default_trigger;
+		led->cdev.name = led_info->name;
+		led->da906x = da906x;
+		led->leds_container = leds;
+
+		INIT_WORK(&led->work, da906x_led_brightness_work);
+
+		ret = led_classdev_register(pdev->dev.parent, &led->cdev);
+		if (ret) {
+			dev_err(&pdev->dev, "Cannot register LEDs\n");
+			goto err_register;
+		}
+
+		ret = device_create_file(led->cdev.dev,
+					 &dev_attr_hw_blink_dur_regval);
+		if (ret < 0) {
+			dev_err(&pdev->dev,
+				"Failed to create device file (err = %d)\n",
+				ret);
+			goto err_create_dur_attr;
+		}
+
+		ret = device_create_file(led->cdev.dev,
+					 &dev_attr_hw_blink_frq_regval);
+		if (ret < 0) {
+			dev_err(&pdev->dev,
+				"Failed to create device file (err = %d)\n",
+				ret);
+			goto err_create_frq_attr;
+		}
+
+		ret = da906x_configure_led_pin(led,
+				led_info->flags & DA906X_LED_LOW_LEVEL_ACTIVE);
+		if (ret) {
+			dev_err(&pdev->dev, "Failed to configure LED pins\n");
+			goto err_configure_pin;
+		}
+	}
+
+	return 0;
+
+err_register:
+	while (--i >= 0) {
+err_configure_pin:
+		device_remove_file(leds->led[i].cdev.dev,
+				   &dev_attr_hw_blink_frq_regval);
+err_create_frq_attr:
+		device_remove_file(leds->led[i].cdev.dev,
+				   &dev_attr_hw_blink_dur_regval);
+err_create_dur_attr:
+		cancel_work_sync(&leds->led[i].work);
+		led_classdev_unregister(&leds->led[i].cdev);
+	}
+
+	kfree(leds);
+
+	return ret;
+}
+
+static int da906x_led_remove(struct platform_device *pdev)
+{
+	struct da906x_leds *leds = platform_get_drvdata(pdev);
+	int i;
+
+	for (i = leds->n_leds - 1; i >= 0; i--) {
+		device_remove_file(leds->led[i].cdev.dev,
+				   &dev_attr_hw_blink_frq_regval);
+		device_remove_file(leds->led[i].cdev.dev,
+				   &dev_attr_hw_blink_dur_regval);
+		cancel_work_sync(&leds->led[i].work);
+		led_classdev_unregister(&leds->led[i].cdev);
+	}
+
+	kfree(leds);
+
+	return 0;
+}
+
+static struct platform_driver da906x_led_driver = {
+	.driver = {
+		.name = DRIVER_NAME,
+		.owner = THIS_MODULE,
+	},
+	.probe = da906x_led_probe,
+	.remove = __devexit_p(da906x_led_remove),
+};
+
+module_platform_driver(da906x_led_driver);
+
+MODULE_DESCRIPTION("LED driver for Dialog DA906X");
+MODULE_AUTHOR("Mariusz Wojtasik <mariusz.wojtasik@diasemi.com>, Krystian Garbaciak <krystian.garbaciak@diasemi.com>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" DRIVER_NAME);
-- 
1.7.0.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
