From: gregkh@suse.de (gregkh@suse.de)
Date: Wed, 27 Jul 2005 00:01:00 +0000
Subject: [lm-sensors] patch i2c-hwmon-class-02.patch added to gregkh-2.6 tree
Message-Id: <1DxXTN-3wg-00@press.kroah.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: I2C hwmon: hwmon sysfs class

to my gregkh-2.6 tree.  Its filename is

     i2c-hwmon-class-02.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/

Patches currently in gregkh-2.6 which might be from mhoffman@lightlink.com are

i2c/i2c-hwmon-class-01.patch
i2c/i2c-hwmon-class-02.patch
i2c/i2c-hwmon-class-03.patch


From mhoffman@lightlink.com Fri Jul 15 18:42:15 2005
Date: Fri, 15 Jul 2005 21:38:08 -0400
From: "Mark M. Hoffman" <mhoffman@lightlink.com>
To: Greg KH <greg@kroah.com>
Cc: Jean Delvare <khali@linux-fr.org>,
	Yani Ioannou <yani.ioannou@gmail.com>,
	lm-sensors <lm-sensors@lm-sensors.org>
Subject: I2C hwmon: hwmon sysfs class
Message-ID: <20050716013808.GC4265@jupiter.solarsys.private>

This patch adds the sysfs class "hwmon" for use by hardware monitoring
(sensors) chip drivers.  It also fixes up the related Kconfig/Makefile
bits.

Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 drivers/hwmon/Kconfig  |    7 +++
 drivers/hwmon/Makefile |    2 +
 drivers/hwmon/hwmon.c  |   98 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/hwmon.h  |   24 ++++++++++++
 4 files changed, 130 insertions(+), 1 deletion(-)

--- gregkh-2.6.orig/drivers/hwmon/Kconfig	2005-07-13 09:45:05.000000000 -0700
+++ gregkh-2.6/drivers/hwmon/Kconfig	2005-07-26 14:56:41.000000000 -0700
@@ -12,7 +12,12 @@
 	  of a system. Most modern motherboards include such a device. It
 	  can include temperature sensors, voltage sensors, fan speed
 	  sensors and various additional features such as the ability to
-	  control the speed of the fans.
+	  control the speed of the fans.  If you want this support you
+	  should say Y here and also to the specific driver(s) for your
+	  sensors chip(s) below.
+
+	  This support can also be built as a module.  If so, the module
+	  will be called hwmon.
 
 config SENSORS_ADM1021
 	tristate "Analog Devices ADM1021 and compatibles"
--- gregkh-2.6.orig/drivers/hwmon/Makefile	2005-07-13 09:45:05.000000000 -0700
+++ gregkh-2.6/drivers/hwmon/Makefile	2005-07-26 14:56:41.000000000 -0700
@@ -2,6 +2,8 @@
 # Makefile for sensor chip drivers.
 #
 
+obj-$(CONFIG_HWMON)		+= hwmon.o
+
 # asb100, then w83781d go first, as they can override other drivers' addresses.
 obj-$(CONFIG_SENSORS_ASB100)	+= asb100.o
 obj-$(CONFIG_SENSORS_W83627HF)	+= w83627hf.o
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ gregkh-2.6/drivers/hwmon/hwmon.c	2005-07-26 14:56:41.000000000 -0700
@@ -0,0 +1,98 @@
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
+#include <linux/idr.h>
+#include <linux/hwmon.h>
+
+#define HWMON_ID_PREFIX "hwmon"
+#define HWMON_ID_FORMAT HWMON_ID_PREFIX "%d"
+
+static struct class *hwmon_class;
+
+static DEFINE_IDR(hwmon_idr);
+
+/**
+ * hwmon_device_register - register w/ hwmon sysfs class
+ * @dev: the device to register
+ *
+ * hwmon_device_unregister() must be called when the class device is no
+ * longer needed.
+ *
+ * Returns the pointer to the new struct class device.
+ */
+struct class_device *hwmon_device_register(struct device *dev)
+{
+	struct class_device *cdev;
+	int id;
+
+	if (idr_pre_get(&hwmon_idr, GFP_KERNEL) = 0)
+		return ERR_PTR(-ENOMEM);
+
+	if (idr_get_new(&hwmon_idr, NULL, &id) < 0)
+		return ERR_PTR(-ENOMEM);
+
+	id = id & MAX_ID_MASK;
+	cdev = class_device_create(hwmon_class, MKDEV(0,0), dev,
+					HWMON_ID_FORMAT, id);
+
+	if (IS_ERR(cdev))
+		idr_remove(&hwmon_idr, id);
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
+	int id;
+
+	if (sscanf(cdev->class_id, HWMON_ID_FORMAT, &id) = 1) {
+		class_device_unregister(cdev);
+		idr_remove(&hwmon_idr, id);
+	} else
+		dev_dbg(cdev->dev,
+			"hwmon_device_unregister() failed: bad class ID!\n");
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
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ gregkh-2.6/include/linux/hwmon.h	2005-07-26 14:56:41.000000000 -0700
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
+struct class_device *hwmon_device_register(struct device *dev);
+
+void hwmon_device_unregister(struct class_device *cdev);
+
+#endif
+
