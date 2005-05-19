From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:50 +0000
Subject: [RFC PATCH 2.6.12-rc2-mm2 1/2] i2c: new sysfs class "hwmon"
Message-Id: <20050411044617.GB4963@jupiter.solarsys.private>
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

Index: linux-2.6.12-rc2-mm2/drivers/Kconfig
=================================--- linux-2.6.12-rc2-mm2.orig/drivers/Kconfig	2005-04-10 23:28:14.000000000 -0400
+++ linux-2.6.12-rc2-mm2/drivers/Kconfig	2005-04-10 23:28:19.000000000 -0400
@@ -42,6 +42,8 @@ source "drivers/input/Kconfig"
 
 source "drivers/char/Kconfig"
 
+source "drivers/hwmon/Kconfig"
+
 source "drivers/i2c/Kconfig"
 
 source "drivers/w1/Kconfig"
Index: linux-2.6.12-rc2-mm2/drivers/Makefile
=================================--- linux-2.6.12-rc2-mm2.orig/drivers/Makefile	2005-04-10 23:28:14.000000000 -0400
+++ linux-2.6.12-rc2-mm2/drivers/Makefile	2005-04-10 23:28:19.000000000 -0400
@@ -51,6 +51,7 @@ obj-$(CONFIG_GAMEPORT)		+= input/gamepor
 obj-$(CONFIG_INPUT)		+= input/
 obj-$(CONFIG_I2O)		+= message/
 obj-$(CONFIG_I2C)		+= i2c/
+obj-$(CONFIG_HWMON)		+= hwmon/
 obj-$(CONFIG_W1)		+= w1/
 obj-$(CONFIG_PHONE)		+= telephony/
 obj-$(CONFIG_MD)		+= md/
Index: linux-2.6.12-rc2-mm2/drivers/hwmon/Kconfig
=================================--- linux-2.6.12-rc2-mm2.orig/drivers/hwmon/Kconfig	2005-04-10 18:53:34.084511920 -0400
+++ linux-2.6.12-rc2-mm2/drivers/hwmon/Kconfig	2005-04-10 23:28:19.000000000 -0400
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
Index: linux-2.6.12-rc2-mm2/drivers/hwmon/Makefile
=================================--- linux-2.6.12-rc2-mm2.orig/drivers/hwmon/Makefile	2005-04-10 18:53:34.084511920 -0400
+++ linux-2.6.12-rc2-mm2/drivers/hwmon/Makefile	2005-04-10 23:28:19.000000000 -0400
@@ -0,0 +1,5 @@
+#
+# Makefile for hardware monitoring (sensors)
+#
+obj-$(CONFIG_HWMON)	+= hwmon.o
+
Index: linux-2.6.12-rc2-mm2/drivers/hwmon/hwmon.c
=================================--- linux-2.6.12-rc2-mm2.orig/drivers/hwmon/hwmon.c	2005-04-10 18:53:34.084511920 -0400
+++ linux-2.6.12-rc2-mm2/drivers/hwmon/hwmon.c	2005-04-10 23:36:48.000000000 -0400
@@ -0,0 +1,69 @@
+/*
+    hwmon.c - part of lm_sensors, Linux kernel modules for hardware monitoring
+
+    This file defines the sysfs class "hwmon", for use by sensors drivers.
+
+    Copyright (C) 2005 Mark M. Hoffman <mhoffman@lightlink.com>
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+*/
+
+#include <linux/module.h>
+#include <linux/device.h>
+
+static void hwmon_class_dev_release(struct class_device *cdev)
+{
+	/* nothing to do here ? */
+}
+
+static struct class hwmon_class = {
+	.name = "hwmon",
+	.release = &hwmon_class_dev_release,
+};
+
+int hwmon_device_register(struct class_device *cdev, struct device *dev)
+{
+	memset(cdev, 0, sizeof(struct class_device));
+	cdev->dev = dev;
+	cdev->class = &hwmon_class;
+	strlcpy(cdev->class_id, dev->bus_id, BUS_ID_SIZE);
+	return class_device_register(cdev);
+}
+
+void hwmon_device_unregister(struct class_device *cdev)
+{
+	class_device_unregister(cdev);
+}
+
+static int __init hwmon_init(void)
+{
+	return class_register(&hwmon_class);
+}
+
+static void __exit hwmon_exit(void)
+{
+	class_unregister(&hwmon_class);
+}
+
+module_init(hwmon_init);
+module_exit(hwmon_exit);
+
+EXPORT_SYMBOL(hwmon_device_register);
+EXPORT_SYMBOL(hwmon_device_unregister);
+
+MODULE_AUTHOR("Mark M. Hoffman <mhoffman@lightlink.com>");
+MODULE_DESCRIPTION("hardware monitoring sysfs/class support");
+MODULE_LICENSE("GPL");
+
Index: linux-2.6.12-rc2-mm2/include/linux/hwmon.h
=================================--- linux-2.6.12-rc2-mm2.orig/include/linux/hwmon.h	2005-04-10 18:53:34.084511920 -0400
+++ linux-2.6.12-rc2-mm2/include/linux/hwmon.h	2005-04-10 23:28:19.000000000 -0400
@@ -0,0 +1,33 @@
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
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+*/
+
+#ifndef _HWMON_H_
+#define _HWMON_H_
+
+#include <linux/device.h>
+
+int hwmon_device_register(struct class_device *cdev, struct device *dev);
+void hwmon_device_unregister(struct class_device *cdev);
+
+#endif
+
Index: linux-2.6.12-rc2-mm2/include/linux/i2c.h
=================================--- linux-2.6.12-rc2-mm2.orig/include/linux/i2c.h	2005-04-10 23:28:14.000000000 -0400
+++ linux-2.6.12-rc2-mm2/include/linux/i2c.h	2005-04-10 23:28:19.000000000 -0400
@@ -154,6 +154,7 @@ struct i2c_client {
 	int usage_count;		/* How many accesses currently  */
 					/* to the client		*/
 	struct device dev;		/* the device structure		*/
+	struct class_device class_dev;
 	struct list_head list;
 	char name[I2C_NAME_SIZE];
 	struct completion released;

-- 
Mark M. Hoffman
mhoffman@lightlink.com
