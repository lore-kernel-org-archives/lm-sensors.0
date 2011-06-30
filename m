From: Lucas Stach <dev@lynxeye.de>
Date: Thu, 30 Jun 2011 23:44:33 +0000
Subject: [lm-sensors] [RFC 2/2] add new hwmon core interface
Message-Id: <1309477474.18912.28.camel@tellur>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From d40386ba43913c0cf9e036a4d67be20080fa3767 Mon Sep 17 00:00:00 2001
From: Lucas Stach <dev@lynxeye.de>
Date: Fri, 1 Jul 2011 01:09:16 +0200
Subject: [PATCH 2/2] hwmon: add hwmon-dummy driver to showcase new core
 interface

Just a stupid driver to showcase the new core interface.
*NOT FOR INCLUSION INTO ANYTHING*
---
 drivers/hwmon/Kconfig       |    5 +
 drivers/hwmon/Makefile      |    2 +
 drivers/hwmon/hwmon-dummy.c |  176 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 183 insertions(+), 0 deletions(-)
 create mode 100644 drivers/hwmon/hwmon-dummy.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 50e40db..9a30595 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -39,6 +39,11 @@ config HWMON_DEBUG_CHIP
 
 comment "Native drivers"
 
+config SENSORS_DUMMY
+	tristate "Dummy driver for new hwmon core interface"
+	help
+	  Dummy driver to showcase the new hwmon core interface.
+
 config SENSORS_ABITUGURU
 	tristate "Abit uGuru (rev 1 & 2)"
 	depends on X86 && EXPERIMENTAL
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 967d0ea..10f5624 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -3,6 +3,7 @@
 #
 
 obj-$(CONFIG_HWMON)		+= hwmon.o
+obj-$(CONFIG_HWMON)		+= hwmon-core.o
 obj-$(CONFIG_HWMON_VID)		+= hwmon-vid.o
 
 # APCI drivers
@@ -44,6 +45,7 @@ obj-$(CONFIG_SENSORS_PKGTEMP)	+= pkgtemp.o
 obj-$(CONFIG_SENSORS_DME1737)	+= dme1737.o
 obj-$(CONFIG_SENSORS_DS620)	+= ds620.o
 obj-$(CONFIG_SENSORS_DS1621)	+= ds1621.o
+obj-$(CONFIG_SENSORS_DUMMY)	+= hwmon-dummy.o
 obj-$(CONFIG_SENSORS_EMC1403)	+= emc1403.o
 obj-$(CONFIG_SENSORS_EMC2103)	+= emc2103.o
 obj-$(CONFIG_SENSORS_F71805F)	+= f71805f.o
diff --git a/drivers/hwmon/hwmon-dummy.c b/drivers/hwmon/hwmon-dummy.c
new file mode 100644
index 0000000..d1bc0d5
--- /dev/null
+++ b/drivers/hwmon/hwmon-dummy.c
@@ -0,0 +1,176 @@
+/*
+ * hwmon-dummy.c
+ * Copyright (C) 2011 Lucas Stach
+ * Just a stupid little driver to show off the new hwmon-core interface.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/platform_device.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/hwmon-core.h>
+
+static void dummy_device_release(struct device *dev);
+
+static struct device_driver dummy_driver = {
+		.name	= "HwmonDummyDriver",
+		.bus	= &platform_bus_type,
+};
+
+static struct platform_device dummy_device = {
+		.name	= "HwmonDummyDevice",
+		.id		= 0,
+		.dev	= {
+				.release	= dummy_device_release,
+		}
+};
+
+static struct device *hwmon_dev;
+struct hwmon_device_instance *core_dev;
+
+static int get_text(void * inst_data, enum hwmon_text_attr attr,
+		unsigned int index, char *buf)
+{
+	int ret = 0;
+
+	switch(attr) {
+		case hwmon_attr_name:
+			ret = snprintf(buf, PAGE_SIZE, "hwmon_dummy\n");
+			break;
+		case hwmon_attr_volt_label:
+			ret = snprintf(buf, PAGE_SIZE, "volt_label\n");
+			break;
+		case hwmon_attr_fan_label:
+			ret = snprintf(buf, PAGE_SIZE, "fan_label\n");
+			break;
+		default:
+			break;
+	}
+
+	return ret;
+}
+
+static int get_num(void * inst_data, enum hwmon_numeric_attr attr,
+		unsigned int index, int *value)
+{
+	switch(attr) {
+	case hwmon_attr_update_interval:
+		*value = 1000;
+		break;
+	case hwmon_attr_volt_min:
+		*value = 1;
+		break;
+	case hwmon_attr_volt_lcrit:
+		*value = 2;
+		break;
+	case hwmon_attr_volt_max:
+		*value = 3;
+		break;
+	case hwmon_attr_volt_crit:
+		*value = 4;
+		break;
+	case hwmon_attr_volt_vid:
+		*value = 5;
+		break;
+	case hwmon_attr_volt_vrm:
+		*value = 6;
+		break;
+	case hwmon_attr_volt_input:
+		*value = 7;
+		break;
+
+	case hwmon_attr_fan_div:
+		*value = 10;
+		break;
+	case hwmon_attr_fan_input:
+		*value = 11;
+		break;
+	case hwmon_attr_fan_max:
+		*value = 12;
+		break;
+	case hwmon_attr_fan_min:
+		*value = 13;
+		break;
+	case hwmon_attr_fan_pulses:
+		*value = 14;
+		break;
+	case hwmon_attr_fan_target:
+		*value = 15;
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
+static int set_num(void * inst_data, enum hwmon_numeric_attr attr,
+		unsigned int index, int value)
+{
+	return 0;
+}
+static int dummy_init(void)
+{
+	driver_register(&dummy_driver);
+	platform_device_register(&dummy_device);
+	hwmon_dev = hwmon_device_register(&dummy_device.dev);
+
+	/* now really fire up the new core api */
+	core_dev = kzalloc(sizeof(struct hwmon_device_instance), GFP_KERNEL);
+	core_dev->get_text_attr = &get_text;
+	core_dev->get_numeric_attr = &get_num;
+	core_dev->set_numeric_attr = &set_num;
+
+	core_dev->caps.num_voltage = 2;
+	core_dev->caps.volt_min = 1;
+	core_dev->caps.volt_lcrit = 1;
+	core_dev->caps.volt_max = 1;
+	core_dev->caps.volt_crit = 1;
+	core_dev->caps.volt_vid = 1;
+	core_dev->caps.volt_vrm = 1;
+	core_dev->caps.volt_label = 1;
+
+	core_dev->caps.num_fan = 2;
+	core_dev->caps.fan_min = 1;
+	core_dev->caps.fan_div = 1;
+	core_dev->caps.fan_label = 1;
+	core_dev->caps.fan_max = 1;
+	core_dev->caps.fan_pulses = 1;
+	core_dev->caps.fan_target = 1;
+
+	/* link hwmon_device_instance to hwmon_dev */
+	dev_set_drvdata(hwmon_dev, core_dev);
+
+	hwmon_create_sysfs(hwmon_dev);
+
+	return 0;
+}
+
+static void dummy_exit(void)
+{
+	driver_unregister(&dummy_driver);
+	platform_device_unregister(&dummy_device);
+	hwmon_device_unregister(hwmon_dev);
+
+	hwmon_destroy_sysfs(hwmon_dev);
+
+	kfree(core_dev);
+}
+
+static DECLARE_COMPLETION(dev_obj_is_free);
+static void dummy_device_release(struct device *dev)
+{
+	complete(&dev_obj_is_free);
+}
+
+module_init(dummy_init);
+module_exit(dummy_exit);
+
+MODULE_AUTHOR("Lucas Stach");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Hwmon dummy driver to show new hwmon core interface");
-- 
1.7.5.4



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
