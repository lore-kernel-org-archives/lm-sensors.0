From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 02 Jun 2005 05:37:36 +0000
Subject: [lm-sensors] Re: [PATCH 2.6.12-rc5-mm1 2/3] i2c: new sysfs class
Message-Id: <20050602033654.GC4906@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This patch adds the sysfs class "hwmon" for use by hardware monitoring
(sensors) chip drivers.  It (the Kconfig text) presumes that sensors
chip drivers will be moved to drivers/hwmon (although that is not done
by this patch).

Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>

Index: linux-2.6.12-rc5-mm1/drivers/Kconfig
=================================--- linux-2.6.12-rc5-mm1.orig/drivers/Kconfig
+++ linux-2.6.12-rc5-mm1/drivers/Kconfig
@@ -42,6 +42,8 @@ source "drivers/input/Kconfig"
 
 source "drivers/char/Kconfig"
 
+source "drivers/hwmon/Kconfig"
+
 source "drivers/i2c/Kconfig"
 
 source "drivers/w1/Kconfig"
Index: linux-2.6.12-rc5-mm1/drivers/Makefile
=================================--- linux-2.6.12-rc5-mm1.orig/drivers/Makefile
+++ linux-2.6.12-rc5-mm1/drivers/Makefile
@@ -53,6 +53,7 @@ obj-$(CONFIG_GAMEPORT)		+= input/gamepor
 obj-$(CONFIG_INPUT)		+= input/
 obj-$(CONFIG_I2O)		+= message/
 obj-$(CONFIG_I2C)		+= i2c/
+obj-$(CONFIG_HWMON)		+= hwmon/
 obj-$(CONFIG_W1)		+= w1/
 obj-$(CONFIG_PHONE)		+= telephony/
 obj-$(CONFIG_MD)		+= md/
Index: linux-2.6.12-rc5-mm1/drivers/hwmon/Kconfig
=================================--- linux-2.6.12-rc5-mm1.orig/drivers/hwmon/Kconfig
+++ linux-2.6.12-rc5-mm1/drivers/hwmon/Kconfig
@@ -0,0 +1,15 @@
+
+menu "Hardware Monitoring (Sensors) support"
+
+config HWMON
+	tristate "Hardware Monitoring Core support"
+	help
+	  If you want hardware monitoring (sensors) support, you should
+	  say Y here and also to the specific driver(s) for your sensors
+	  chip(s) below.
+
+	  This support can also be built as a module.  If so, the module
+	  will be called hwmon.
+
+endmenu
+
Index: linux-2.6.12-rc5-mm1/drivers/hwmon/Makefile
=================================--- linux-2.6.12-rc5-mm1.orig/drivers/hwmon/Makefile
+++ linux-2.6.12-rc5-mm1/drivers/hwmon/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for hardware monitoring (sensors)
+#
+obj-$(CONFIG_HWMON)	+= hwmon.o
+
Index: linux-2.6.12-rc5-mm1/drivers/hwmon/hwmon.c
=================================--- linux-2.6.12-rc5-mm1.orig/drivers/hwmon/hwmon.c
+++ linux-2.6.12-rc5-mm1/drivers/hwmon/hwmon.c
@@ -0,0 +1,77 @@
+/*
+    hwmon.c - part of lm_sensors, Linux kernel modules for hardware monitoring
+
+    This file defines the sysfs class "hwmon", for use by sensors drivers.
+
+    Copyright (C) 2005 Mark M. Hoffman <mhoffman@lightlink.com>
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; version 2 of the License.
+*/
+
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/kdev_t.h>
+#include <linux/hwmon.h>
+
+static struct class *hwmon_class;
+
+/**
+ * hwmon_device_register - register w/ hwmon sysfs class
+ * @dev: the device to register
+ * @fmt: string for the class device's name
+ *
+ * hwmon_device_unregister() must be called when the class device is no
+ * longer needed.
+ *
+ * Returns the pointer to the new struct class device.
+ */
+struct class_device *hwmon_device_register(struct device *dev, char *fmt, ...)
+{
+	va_list args;
+	struct class_device *cdev;
+
+	va_start(args, fmt);
+	cdev = class_device_create_v(hwmon_class, MKDEV(0,0), dev, fmt, args);
+	va_end(args);
+
+	return cdev;
+}
+
+/**
+ * hwmon_device_unregister - removes the previously registered class device
+ *
+ * @cdev: the class device to destroy
+ */
+void hwmon_device_unregister(struct class_device *cdev)
+{
+	class_device_unregister(cdev);
+}
+
+static int __init hwmon_init(void)
+{
+	hwmon_class = class_create(THIS_MODULE, "hwmon");
+	if (IS_ERR(hwmon_class)) {
+		printk(KERN_ERR "hwmon.c: couldn't create sysfs class\n");
+		return PTR_ERR(hwmon_class);
+	}
+	return 0;
+}
+
+static void __exit hwmon_exit(void)
+{
+	class_destroy(hwmon_class);
+}
+
+module_init(hwmon_init);
+module_exit(hwmon_exit);
+
+EXPORT_SYMBOL_GPL(hwmon_device_register);
+EXPORT_SYMBOL_GPL(hwmon_device_unregister);
+
+MODULE_AUTHOR("Mark M. Hoffman <mhoffman@lightlink.com>");
+MODULE_DESCRIPTION("hardware monitoring sysfs/class support");
+MODULE_LICENSE("GPL");
+
Index: linux-2.6.12-rc5-mm1/include/linux/hwmon.h
=================================--- linux-2.6.12-rc5-mm1.orig/include/linux/hwmon.h
+++ linux-2.6.12-rc5-mm1/include/linux/hwmon.h
@@ -0,0 +1,24 @@
+/*
+    hwmon.h - part of lm_sensors, Linux kernel modules for hardware monitoring
+
+    This file declares helper functions for the sysfs class "hwmon",
+    for use by sensors drivers.
+
+    Copyright (C) 2005 Mark M. Hoffman <mhoffman@lightlink.com>
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; version 2 of the License.
+*/
+
+#ifndef _HWMON_H_
+#define _HWMON_H_
+
+#include <linux/device.h>
+
+struct class_device *hwmon_device_register(struct device *dev, char *fmt, ...);
+
+void hwmon_device_unregister(struct class_device *cdev);
+
+#endif
+

-- 
Mark M. Hoffman
mhoffman@lightlink.com

