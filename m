From: Krystian Garbaciak <krystian.garbaciak@diasemi.com>
Date: Fri, 24 Aug 2012 14:15:00 +0000
Subject: [lm-sensors] [RFC PATCH 6/8] input: Add support for DA906x vibration motor driver.
Message-Id: <201208241515@sw-eng-lt-dc-vm2>
List-Id: <lm-sensors.vger.kernel.org>
References: <201208241510@sw-eng-lt-dc-vm2>
In-Reply-To: <201208241510@sw-eng-lt-dc-vm2>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com, lm-sensors@lm-sensors.org, linux-input@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-leds@vger.kernel.org
Cc: Alessandro Zummo <a.zummo@towertech.it>, Andrew Jones <drjones@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Ashish Jangam <ashish.jangam@kpitcummins.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Donggeun Kim <dg77.kim@samsung.com>, Wim Van Sebroeck <wim@iguana.be>, "Richard Purdie <rpurdie@rpsys.net>
	Anthony Olech" <anthony.olech@diasemi.com>, Bryan Wu <bryan.wu@canonical.com>, Liam Girdwood <lrg@ti.com>

This driver is registers (memless) force-feedback input device with capability
of FF_RUMBLE effect.

Signed-off-by: Krystian Garbaciak <krystian.garbaciak@diasemi.com>
---
 drivers/input/misc/Kconfig            |    7 ++
 drivers/input/misc/Makefile           |    1 +
 drivers/input/misc/da906x-vibration.c |  153 +++++++++++++++++++++++++++++++++
 3 files changed, 161 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/misc/da906x-vibration.c

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index fd8d951..b8a5fac 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -492,6 +492,13 @@ config INPUT_DA906X_ONKEY
 	help
 	  Support for Dialog Semiconductor input onkey device.
 
+config INPUT_DA906X_VIBRATION
+	tristate "Dialog DA906x Vibration"
+	depends on MFD_DA906X
+	select INPUT_FF_MEMLESS
+	help
+	  Support for Dialog Semiconductor vibration motor driver.
+
 config INPUT_DM355EVM
 	tristate "TI DaVinci DM355 EVM Keypad and IR Remote"
 	depends on MFD_DM355EVM_MSP
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 73406ac..7b284ef 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_INPUT_CMA3000_I2C)		+= cma3000_d0x_i2c.o
 obj-$(CONFIG_INPUT_COBALT_BTNS)		+= cobalt_btns.o
 obj-$(CONFIG_INPUT_DA9052_ONKEY)	+= da9052_onkey.o
 obj-$(CONFIG_INPUT_DA906X_ONKEY)	+= da906x-onkey.o
+obj-$(CONFIG_INPUT_DA906X_VIBRATION)	+= da906x-vibration.o
 obj-$(CONFIG_INPUT_DM355EVM)		+= dm355evm_keys.o
 obj-$(CONFIG_INPUT_GP2A)		+= gp2ap002a00f.o
 obj-$(CONFIG_INPUT_GPIO_TILT_POLLED)	+= gpio_tilt_polled.o
diff --git a/drivers/input/misc/da906x-vibration.c b/drivers/input/misc/da906x-vibration.c
new file mode 100644
index 0000000..0fae20a
--- /dev/null
+++ b/drivers/input/misc/da906x-vibration.c
@@ -0,0 +1,153 @@
+/*
+ * Force Feedback device driver for DA906x PMIC series
+ *
+ * Copyright 2012 Dialog Semiconductors Ltd.
+ *
+ * Author: Krystian Garbaciak <krystian.garbaciak@diasemi.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/input.h>
+#include <linux/mfd/da906x/core.h>
+#include <linux/mfd/da906x/registers.h>
+
+struct vibration {
+	struct da906x		*hw;
+	struct input_dev	*input_dev;
+	struct workqueue_struct	*workqueue;
+	struct work_struct	work;
+	unsigned short		strength;
+};
+
+static void vibra_work(struct work_struct *work)
+{
+	struct vibration *vibr = container_of(work, struct vibration, work);
+	unsigned val;
+
+	val = (vibr->strength * (DA906X_VIB_SET_MAX + 1)) /
+	      ((unsigned long)USHRT_MAX + 1);
+
+	da906x_reg_write(vibr->hw, DA906X_REG_VIB, val);
+
+	if (val)
+		da906x_reg_set_bits(vibr->hw, DA906X_REG_LDO8_CONT,
+				    DA906X_LDO_EN);
+	else
+		da906x_reg_clear_bits(vibr->hw, DA906X_REG_LDO8_CONT,
+				      DA906X_LDO_EN);
+}
+
+static int vibra_play(struct input_dev *input, void *data,
+		      struct ff_effect *effect)
+{
+	struct vibration *vibration = input_get_drvdata(input);
+
+	vibration->strength = effect->u.rumble.strong_magnitude;
+
+	queue_work(vibration->workqueue, &vibration->work);
+
+	return 0;
+}
+
+static int __devinit da906x_vibration_probe(struct platform_device *pdev)
+{
+	struct da906x *da906x = dev_get_drvdata(pdev->dev.parent);
+	struct vibration *vibration;
+	int ret;
+
+	/* Check PMIC vibration configuration */
+	ret = da906x_reg_read(da906x, DA906X_REG_CONFIG_H);
+	if (ret < 0)
+		return ret;
+
+	if (!(ret & DA906X_LDO8_MODE_MASK)) {
+		dev_err(&pdev->dev, "Vibration is disabled\n");
+		return -ENODEV;
+	}
+
+	vibration = devm_kzalloc(&pdev->dev, sizeof(*vibration), GFP_KERNEL);
+	if (!vibration) {
+		dev_err(&pdev->dev, "Could not allocate memory\n");
+		return -ENOMEM;
+	}
+
+	platform_set_drvdata(pdev, vibration);
+	vibration->hw = da906x;
+	INIT_WORK(&vibration->work, vibra_work);
+	vibration->workqueue = alloc_workqueue("da906x-vibration", 0, 0);
+	if (!vibration->workqueue) {
+		dev_err(&pdev->dev, "Could not allocate workqueue\n");
+		return -ENOMEM;
+	}
+
+	vibration->input_dev = input_allocate_device();
+	if (!vibration->input_dev) {
+		dev_err(&pdev->dev, "Could not allocate device\n");
+		ret = -ENOMEM;
+		goto err_ialloc;
+	}
+
+	input_set_drvdata(vibration->input_dev, vibration);
+	vibration->input_dev->name = DA906X_DRVNAME_VIBRATION;
+	vibration->input_dev->id.version = 1;
+	vibration->input_dev->dev.parent = pdev->dev.parent;
+	vibration->input_dev->evbit[0] = BIT_MASK(EV_FF);
+	input_set_capability(vibration->input_dev, EV_FF, FF_RUMBLE);
+
+	ret = input_ff_create_memless(vibration->input_dev, NULL, vibra_play);
+	if (ret < 0) {
+		dev_err(&pdev->dev,
+			"Could not create force-feedback device\n");
+		goto err_ffcreat;
+	}
+
+	ret = input_register_device(vibration->input_dev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Could not register input device\n");
+		goto err_ireg;
+	}
+	return 0;
+
+err_ireg:
+	input_ff_destroy(vibration->input_dev);
+err_ffcreat:
+	input_free_device(vibration->input_dev);
+err_ialloc:
+	destroy_workqueue(vibration->workqueue);
+
+	return ret;
+}
+
+static int __devexit da906x_vibration_remove(struct platform_device *pdev)
+{
+	struct vibration *vibration = platform_get_drvdata(pdev);
+
+	input_unregister_device(vibration->input_dev);
+	return 0;
+}
+
+static struct platform_driver da906x_vibration_driver = {
+	.probe		= da906x_vibration_probe,
+	.remove		= __devexit_p(da906x_vibration_remove),
+	.driver		= {
+		.name	= DA906X_DRVNAME_VIBRATION,
+		.owner	= THIS_MODULE,
+	},
+};
+
+module_platform_driver(da906x_vibration_driver);
+
+/* Module information */
+MODULE_AUTHOR("Krystian Garbaciak <krystian.garbaciak@diasemi.com>");
+MODULE_DESCRIPTION("DA906x vibration driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" DA906X_DRVNAME_VIBRATION);
-- 
1.7.0.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
