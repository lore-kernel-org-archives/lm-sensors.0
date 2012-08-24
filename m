From: Krystian Garbaciak <krystian.garbaciak@diasemi.com>
Date: Fri, 24 Aug 2012 14:20:00 +0000
Subject: [lm-sensors] [RFC PATCH 7/8] watchdog: Add DA906x PMIC watchdog driver.
Message-Id: <201208241520@sw-eng-lt-dc-vm2>
List-Id: <lm-sensors.vger.kernel.org>
References: <201208241515@sw-eng-lt-dc-vm2>
In-Reply-To: <201208241515@sw-eng-lt-dc-vm2>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com, lm-sensors@lm-sensors.org, linux-input@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-leds@vger.kernel.org
Cc: Alessandro Zummo <a.zummo@towertech.it>, Andrew Jones <drjones@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Ashish Jangam <ashish.jangam@kpitcummins.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Donggeun Kim <dg77.kim@samsung.com>, Wim Van Sebroeck <wim@iguana.be>, "Richard Purdie <rpurdie@rpsys.net>
	Anthony Olech" <anthony.olech@diasemi.com>, Bryan Wu <bryan.wu@canonical.com>, Liam Girdwood <lrg@ti.com>

This driver supports watchdog device inside DA906x PMIC.

Signed-off-by: Krystian Garbaciak <krystian.garbaciak@diasemi.com>
---
 drivers/watchdog/Kconfig      |   27 ++++
 drivers/watchdog/Makefile     |    1 +
 drivers/watchdog/da906x_wdt.c |  276 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 304 insertions(+), 0 deletions(-)
 create mode 100644 drivers/watchdog/da906x_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 53d7571..ef07575 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -76,6 +76,33 @@ config DA9052_WATCHDOG
           Alternatively say M to compile the driver as a module,
           which will be called da9052_wdt.
 
+config DA906X_WATCHDOG
+	tristate "Dialog DA906X Watchdog"
+	depends on MFD_DA906X
+	select WATCHDOG_CORE
+	help
+	  Support for the watchdog in the DA906X PMIC.
+
+config DA906X_WDT_DEFAULT_TIMEOUT
+	int "Watchdog timeout in seconds <2, 4, 8, 16, 32, 65, 131>"
+	depends on DA906X_WATCHDOG
+	default 8
+	range 2 131
+	help
+	  Select the default watchdog timer period to be used by the
+	  Dialog DA906x watchdog driver. Supported values are:
+	  2, 4, 8, 16, 32, 65, 131 seconds.
+
+config DA906X_WDT_FLEXIBLE_TIMEOUT
+	bool "Flexible watchdog timeout (when requested value is unsupported)"
+	depends on DA906X_WATCHDOG
+	default y
+	help
+	  Say Y here to allow to select longer watchdog timer period to be
+	  used when requested value is not supported. The lowest available
+	  value higher than requested will be used (watchdog will never
+	  expire before requested timeout).
+
 config WM831X_WATCHDOG
 	tristate "WM831x watchdog"
 	depends on MFD_WM831X
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 572b39b..0746a87 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -164,6 +164,7 @@ obj-$(CONFIG_XEN_WDT) += xen_wdt.o
 
 # Architecture Independent
 obj-$(CONFIG_DA9052_WATCHDOG) += da9052_wdt.o
+obj-$(CONFIG_DA906X_WATCHDOG) += da906x_wdt.o
 obj-$(CONFIG_WM831X_WATCHDOG) += wm831x_wdt.o
 obj-$(CONFIG_WM8350_WATCHDOG) += wm8350_wdt.o
 obj-$(CONFIG_MAX63XX_WATCHDOG) += max63xx_wdt.o
diff --git a/drivers/watchdog/da906x_wdt.c b/drivers/watchdog/da906x_wdt.c
new file mode 100644
index 0000000..a67e4fa
--- /dev/null
+++ b/drivers/watchdog/da906x_wdt.c
@@ -0,0 +1,276 @@
+/*
+ * Watchdog driver for DA906X PMICs.
+ *
+ * Copyright(c) 2012 Dialog Semiconductor Ltd.
+ *
+ * Author: Mariusz Wojtasik <mariusz.wojtasik@diasemi.com>
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
+#include <linux/watchdog.h>
+#include <linux/platform_device.h>
+#include <linux/uaccess.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+
+#include <linux/mfd/da906x/registers.h>
+#include <linux/mfd/da906x/core.h>
+
+#define	SUPPORTED_TIMEOUTS_STR		"2, 4, 8, 16, 32, 65, 131"
+
+/* Watchdog selector to timeout in seconds.
+   0: WDT disabled;
+   others: timeout = 2048 ms * 2^(TWDSCALE-1). */
+const int wdt_timeout[] = { 0, 2, 4, 8, 16, 32, 65, 131 };
+#define DA906X_TWDSCALE_DISABLE		0
+#define DA906X_TWDSCALE_MIN		1
+#define DA906X_TWDSCALE_MAX		(ARRAY_SIZE(wdt_timeout) - 1)
+#define DA906X_WDT_MIN_TIMEOUT		wdt_timeout[DA906X_TWDSCALE_MIN]
+#define DA906X_WDT_MAX_TIMEOUT		wdt_timeout[DA906X_TWDSCALE_MAX]
+#define WATCHDOG_DEFAULT_TIMEOUT	wdt_timeout[3];
+
+/* module parameters */
+static int default_timeout = CONFIG_DA906X_WDT_DEFAULT_TIMEOUT;
+module_param(default_timeout, int, 0);
+MODULE_PARM_DESC(default_timeout,
+	"Watchdog timeout in seconds (select from: " SUPPORTED_TIMEOUTS_STR
+	" default=" __stringify(CONFIG_DA906X_WDT_DEFAULT_TIMEOUT) ")");
+
+static bool flex_timeout = CONFIG_DA906X_WDT_FLEXIBLE_TIMEOUT;
+module_param(flex_timeout, bool, false);
+MODULE_PARM_DESC(flex_timeout,
+	"Watchdog flexible timeout, allows longer timeout than requested"
+	" (default=" __stringify(CONFIG_DA906X_WDT_FLEXIBLE_TIMEOUT) ")");
+
+static int nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, int, 0);
+MODULE_PARM_DESC(nowayout,
+		 "Watchdog cannot be stopped once started (default="
+		 __stringify(WATCHDOG_NOWAYOUT) ")");
+
+
+struct da906x_watchdog {
+	struct da906x *da906x;
+	struct watchdog_device *wdtdev;
+	struct mutex lock;
+};
+static struct da906x_watchdog da906x_watchdog;
+
+static int _da906x_wdt_timeout_to_sel(int secs)
+{
+	int i;
+
+	for (i = DA906X_TWDSCALE_MIN; i <= DA906X_TWDSCALE_MAX; i++) {
+		if (wdt_timeout[i] = secs ||
+		    (flex_timeout && wdt_timeout[i] > secs))
+			return i;
+	}
+
+	return 0;
+}
+
+static int _da906x_wdt_disable(struct da906x *da906x)
+{
+	return da906x_reg_update(da906x, DA906X_REG_CONTROL_D,
+			DA906X_TWDSCALE_MASK,
+			DA906X_TWDSCALE_DISABLE << DA906X_TWDSCALE_SHIFT);
+}
+
+static int _da906x_wdt_set_timeout(struct da906x *da906x, unsigned int regval)
+{
+	if (regval > DA906X_TWDSCALE_MAX)
+		return -EINVAL;
+
+	return da906x_reg_update(da906x, DA906X_REG_CONTROL_D,
+			DA906X_TWDSCALE_MASK, regval << DA906X_TWDSCALE_SHIFT);
+}
+
+static int _da906x_wdt_kick(struct da906x *da906x)
+{
+	return da906x_reg_write(da906x, DA906X_REG_CONTROL_F, DA906X_WATCHDOG);
+}
+
+static int da906x_wdt_start(struct watchdog_device *wdd)
+{
+	struct da906x_watchdog *wdt = watchdog_get_drvdata(wdd);
+	unsigned int selector;
+	int ret = 0;
+
+	mutex_lock(&wdt->lock);
+	selector = _da906x_wdt_timeout_to_sel(wdt->wdtdev->timeout);
+	ret = _da906x_wdt_set_timeout(wdt->da906x, selector);
+	if (ret != 0) {
+		dev_err(wdt->da906x->dev,
+			"Watchdog failed to start (err = %d)\n", ret);
+	}
+	mutex_unlock(&wdt->lock);
+
+	return ret;
+}
+
+static int da906x_wdt_stop(struct watchdog_device *wdd)
+{
+	struct da906x_watchdog *wdt = watchdog_get_drvdata(wdd);
+	int ret = 0;
+
+	mutex_lock(&wdt->lock);
+	ret = _da906x_wdt_disable(wdt->da906x);
+	if (ret < 0)
+		dev_alert(wdt->da906x->dev,
+			  "Watchdog failed to stop (err = %d)\n", ret);
+	mutex_unlock(&wdt->lock);
+
+	return ret;
+}
+
+static int da906x_wdt_ping(struct watchdog_device *wdd)
+{
+	struct da906x_watchdog *wdt = watchdog_get_drvdata(wdd);
+	int ret = 0;
+
+	mutex_lock(&wdt->lock);
+	ret = _da906x_wdt_kick(wdt->da906x);
+	if (ret < 0)
+		dev_alert(wdt->da906x->dev,
+			  "Failed to ping the watchdog (err = %d)\n", ret);
+	mutex_unlock(&wdt->lock);
+
+	return ret;
+}
+
+static int da906x_wdt_set_timeout(struct watchdog_device *wdd,
+							unsigned int timeout)
+{
+	struct da906x_watchdog *wdt = watchdog_get_drvdata(wdd);
+	unsigned int selector;
+	int ret = 0;
+
+	mutex_lock(&wdt->lock);
+	selector = _da906x_wdt_timeout_to_sel(timeout);
+	if (selector = 0) {
+		dev_err(wdt->da906x->dev,
+			"Unsupported watchdog timeout (selecto from: "
+			SUPPORTED_TIMEOUTS_STR ")\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = _da906x_wdt_set_timeout(wdt->da906x, selector);
+	if (ret < 0) {
+		dev_err(wdt->da906x->dev,
+			"Failed to set watchdog timeout (err = %d)\n", ret);
+		goto out;
+	}
+
+	wdd->timeout = wdt_timeout[selector];
+
+out:
+	mutex_unlock(&wdt->lock);
+
+	return ret;
+}
+
+static struct watchdog_info da906x_watchdog_info = {
+	.options	= WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
+	.identity	= "DA906x Watchdog",
+};
+
+static struct watchdog_ops da906x_watchdog_ops = {
+	.owner	= THIS_MODULE,
+	.start		= da906x_wdt_start,
+	.stop		= da906x_wdt_stop,
+	.ping		= da906x_wdt_ping,
+	.set_timeout	= da906x_wdt_set_timeout,
+};
+
+static struct watchdog_device da906x_watchdog_device = {
+	.info	= &da906x_watchdog_info,
+	.ops	= &da906x_watchdog_ops,
+	.driver_data = &da906x_watchdog,
+};
+
+static int __devinit da906x_wdt_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct da906x *da906x = dev_get_drvdata(pdev->dev.parent);
+	struct da906x_watchdog *wdt = &da906x_watchdog;
+	unsigned int selector;
+
+	if (wdt->da906x != NULL) {
+		dev_err(da906x->dev, DA906X_DRVNAME_WATCHDOG
+			" already registered.\n");
+		return -EBUSY;
+	}
+
+	wdt->da906x = da906x;
+	wdt->wdtdev = &da906x_watchdog_device;
+	mutex_init(&wdt->lock);
+
+	if (nowayout)
+		set_bit(WDOG_NO_WAY_OUT, &wdt->wdtdev->status);
+
+	if (flex_timeout)
+		wdt->wdtdev->min_timeout = 1;
+	else
+		wdt->wdtdev->min_timeout = DA906X_WDT_MIN_TIMEOUT;
+
+	wdt->wdtdev->max_timeout = DA906X_WDT_MAX_TIMEOUT;
+
+	selector = _da906x_wdt_timeout_to_sel(default_timeout);
+	if (selector = 0) {
+		wdt->wdtdev->timeout = WATCHDOG_DEFAULT_TIMEOUT;
+		dev_warn(da906x->dev,
+			 "Invalid default timeout: %d "
+			 "(select from: " SUPPORTED_TIMEOUTS_STR ").\n",
+			 default_timeout);
+		dev_warn(da906x->dev, "Default timeout is %d secs.\n",
+			 wdt->wdtdev->timeout);
+	} else {
+		wdt->wdtdev->timeout = wdt_timeout[selector];
+		if (wdt->wdtdev->timeout != default_timeout) {
+			dev_info(da906x->dev, "Using %d secs timeout.\n",
+				 wdt->wdtdev->timeout);
+		}
+	}
+
+	ret = watchdog_register_device(wdt->wdtdev);
+	if (ret)
+		dev_err(da906x->dev, DA906X_DRVNAME_WATCHDOG
+			" registration failed (err = %d)", ret);
+
+	return ret;
+}
+
+static int __devexit da906x_wdt_remove(struct platform_device *dev)
+{
+	struct da906x_watchdog *wdt = &da906x_watchdog;
+
+	watchdog_unregister_device(&da906x_watchdog_device);
+	wdt->da906x = NULL;
+	wdt->wdtdev = NULL;
+
+	return 0;
+}
+
+static struct platform_driver da906x_wdt_driver = {
+	.probe = da906x_wdt_probe,
+	.remove = __devexit_p(da906x_wdt_remove),
+	.driver = {
+		.name	= DA906X_DRVNAME_WATCHDOG,
+		.owner	= THIS_MODULE,
+	},
+};
+
+module_platform_driver(da906x_wdt_driver);
+
+MODULE_AUTHOR("Mariusz Wojtasik <mariusz.wojtasik@diasemi.com>");
+MODULE_DESCRIPTION("Watchdog driver for Dialog DA906x");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" DA906X_DRVNAME_WATCHDOG);
-- 
1.7.0.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
