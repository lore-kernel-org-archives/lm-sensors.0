From: Krystian Garbaciak <krystian.garbaciak@diasemi.com>
Date: Fri, 24 Aug 2012 14:10:00 +0000
Subject: [lm-sensors] [RFC PATCH 5/8] input: Add support for DA906x PMIC OnKey detection.
Message-Id: <201208241510@sw-eng-lt-dc-vm2>
List-Id: <lm-sensors.vger.kernel.org>
References: <201208241505@sw-eng-lt-dc-vm2>
In-Reply-To: <201208241505@sw-eng-lt-dc-vm2>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com, lm-sensors@lm-sensors.org, linux-input@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-leds@vger.kernel.org
Cc: Alessandro Zummo <a.zummo@towertech.it>, Andrew Jones <drjones@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Ashish Jangam <ashish.jangam@kpitcummins.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Donggeun Kim <dg77.kim@samsung.com>, Wim Van Sebroeck <wim@iguana.be>, "Richard Purdie <rpurdie@rpsys.net>
	Anthony Olech" <anthony.olech@diasemi.com>, Bryan Wu <bryan.wu@canonical.com>, Liam Girdwood <lrg@ti.com>

This driver creates input device that reports a key event on an OnKey button
release. The reported key code depends on the time, the button was holded for.
If holding time < 2 seconds - KEY_SLEEP is reported on button release,
otherwise KEY_POWER is reported after 2 seconds.

Signed-off-by: Krystian Garbaciak <krystian.garbaciak@diasemi.com>
---
 drivers/input/misc/Kconfig        |    6 ++
 drivers/input/misc/Makefile       |    1 +
 drivers/input/misc/da906x-onkey.c |  139 +++++++++++++++++++++++++++++++++++++
 3 files changed, 146 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/misc/da906x-onkey.c

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 7c0f1ec..fd8d951 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -486,6 +486,12 @@ config INPUT_DA9052_ONKEY
 	  To compile this driver as a module, choose M here: the
 	  module will be called da9052_onkey.
 
+config INPUT_DA906X_ONKEY
+	tristate "Dialog DA906x OnKey"
+	depends on MFD_DA906X
+	help
+	  Support for Dialog Semiconductor input onkey device.
+
 config INPUT_DM355EVM
 	tristate "TI DaVinci DM355 EVM Keypad and IR Remote"
 	depends on MFD_DM355EVM_MSP
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 83fe6f5..73406ac 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_INPUT_CMA3000)		+= cma3000_d0x.o
 obj-$(CONFIG_INPUT_CMA3000_I2C)		+= cma3000_d0x_i2c.o
 obj-$(CONFIG_INPUT_COBALT_BTNS)		+= cobalt_btns.o
 obj-$(CONFIG_INPUT_DA9052_ONKEY)	+= da9052_onkey.o
+obj-$(CONFIG_INPUT_DA906X_ONKEY)	+= da906x-onkey.o
 obj-$(CONFIG_INPUT_DM355EVM)		+= dm355evm_keys.o
 obj-$(CONFIG_INPUT_GP2A)		+= gp2ap002a00f.o
 obj-$(CONFIG_INPUT_GPIO_TILT_POLLED)	+= gpio_tilt_polled.o
diff --git a/drivers/input/misc/da906x-onkey.c b/drivers/input/misc/da906x-onkey.c
new file mode 100644
index 0000000..477c554
--- /dev/null
+++ b/drivers/input/misc/da906x-onkey.c
@@ -0,0 +1,139 @@
+/*
+ * OnKey device driver for Dialog DA906x PMIC
+ *
+ * Copyright 2012 Dialog Semiconductors Ltd.
+ *
+ * Author:  <michal.hajduk@diasemi.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/workqueue.h>
+
+#include <linux/mfd/da906x/core.h>
+#include <linux/mfd/da906x/registers.h>
+
+
+struct da906x_onkey {
+	struct	da906x *da906x;
+	struct	input_dev *input;
+	int irq;
+};
+
+static irqreturn_t da906x_onkey_irq_handler(int irq, void *data)
+{
+	struct da906x_onkey *onkey = data;
+	unsigned int code;
+	int ret;
+
+	ret = da906x_reg_read(onkey->da906x, DA906X_REG_STATUS_A);
+	if ((ret >= 0) && (ret & DA906X_NONKEY)) {
+		dev_notice(&onkey->input->dev, "KEY_POWER pressed.\n");
+		code = KEY_POWER;
+	} else {
+		dev_notice(&onkey->input->dev, "KEY_SLEEP pressed.\n");
+		code = KEY_SLEEP;
+	}
+
+	/* Interrupt raised for key release only,
+	   so report consecutive button press and release. */
+	input_report_key(onkey->input, code, 1);
+	input_report_key(onkey->input, code, 0);
+	input_sync(onkey->input);
+
+	return IRQ_HANDLED;
+}
+
+static int __devinit da906x_onkey_probe(struct platform_device *pdev)
+{
+	struct da906x *da906x = dev_get_drvdata(pdev->dev.parent);
+	struct da906x_onkey *onkey;
+	int ret = 0;
+
+	onkey = devm_kzalloc(&pdev->dev, sizeof(struct da906x_onkey),
+			     GFP_KERNEL);
+	if (!onkey) {
+		dev_err(&pdev->dev, "Failed to allocate memory.\n");
+		return -ENOMEM;
+	}
+
+	onkey->input = input_allocate_device();
+	if (!onkey->input) {
+		dev_err(&pdev->dev, "Failed to allocated inpute device.\n");
+		return -ENOMEM;
+	}
+
+	onkey->irq = platform_get_irq_byname(pdev, DA906X_DRVNAME_ONKEY);
+	onkey->da906x = da906x;
+
+	onkey->input->evbit[0] = BIT_MASK(EV_KEY);
+	onkey->input->name = DA906X_DRVNAME_ONKEY;
+	onkey->input->phys = DA906X_DRVNAME_ONKEY "/input0";
+	onkey->input->dev.parent = &pdev->dev;
+	input_set_capability(onkey->input, EV_KEY, KEY_POWER);
+	input_set_capability(onkey->input, EV_KEY, KEY_SLEEP);
+
+	ret = request_threaded_irq(onkey->irq, NULL, da906x_onkey_irq_handler,
+			IRQF_TRIGGER_LOW | IRQF_ONESHOT, "ONKEY", onkey);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to request IRQ.\n");
+		goto err_input;
+	}
+
+	ret = input_register_device(onkey->input);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to request IRQ.\n");
+		goto err_irq;
+	}
+
+	platform_set_drvdata(pdev, onkey);
+
+	/* Interrupt reacts on button release */
+	da906x_reg_update(da906x, DA906X_REG_CONFIG_I,
+			  DA906X_NONKEY_PIN_MASK, DA906X_NONKEY_PIN_SWDOWN);
+
+	return 0;
+
+err_irq:
+	free_irq(onkey->da906x->irq_base + onkey->irq , onkey);
+err_input:
+	input_free_device(onkey->input);
+	return ret;
+}
+
+static int __devexit da906x_onkey_remove(struct platform_device *pdev)
+{
+	struct	da906x_onkey *onkey = platform_get_drvdata(pdev);
+
+	free_irq(onkey->irq, onkey);
+	input_unregister_device(onkey->input);
+	return 0;
+}
+
+static struct platform_driver da906x_onkey_driver = {
+	.probe	= da906x_onkey_probe,
+	.remove	= __devexit_p(da906x_onkey_remove),
+	.driver	= {
+		.name	= DA906X_DRVNAME_ONKEY,
+		.owner	= THIS_MODULE,
+	},
+};
+
+module_platform_driver(da906x_onkey_driver);
+
+MODULE_AUTHOR("Dialog Semiconductor <michal.hajduk@diasemi.com>");
+MODULE_DESCRIPTION("Onkey driver for DA906X");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("paltform:" DA906X_DRVNAME_ONKEY);
-- 
1.7.0.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
