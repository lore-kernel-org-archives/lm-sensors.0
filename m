From: Lucas Stach <dev@lynxeye.de>
Date: Thu, 15 Sep 2011 20:45:55 +0000
Subject: [lm-sensors] [RFC 2/2] add new hwmon-core interface v2
Message-Id: <1316119556.25490.15.camel@tellur>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This is a dummy driver to showcase the new hwmon-core interface.
*NOT INTENDED FOR INCLUSION INTO ANYTHING*

Signed-off-by: Lucas Stach <dev@lynxeye.de>
---
 drivers/hwmon/Kconfig       |    5 +
 drivers/hwmon/Makefile      |    1 +
 drivers/hwmon/hwmon-dummy.c |  179 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 185 insertions(+), 0 deletions(-)
 create mode 100644 drivers/hwmon/hwmon-dummy.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 0b62c3c..bf7df99 100644
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
 	depends on X86 && DMI && EXPERIMENTAL
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 3d5b395..31205bc 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_SENSORS_CORETEMP)	+= coretemp.o
 obj-$(CONFIG_SENSORS_DME1737)	+= dme1737.o
 obj-$(CONFIG_SENSORS_DS620)	+= ds620.o
 obj-$(CONFIG_SENSORS_DS1621)	+= ds1621.o
+obj-$(CONFIG_SENSORS_DUMMY)	+= hwmon-dummy.o
 obj-$(CONFIG_SENSORS_EMC1403)	+= emc1403.o
 obj-$(CONFIG_SENSORS_EMC2103)	+= emc2103.o
 obj-$(CONFIG_SENSORS_EMC6W201)	+= emc6w201.o
diff --git a/drivers/hwmon/hwmon-dummy.c b/drivers/hwmon/hwmon-dummy.c
new file mode 100644
index 0000000..2452adf
--- /dev/null
+++ b/drivers/hwmon/hwmon-dummy.c
@@ -0,0 +1,179 @@
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
+static int get_text(void * inst_data, enum hwmon_attr attr,
+		unsigned int index, char *buf)
+{
+	int ret = 0;
+
+	switch(attr) {
+		case hwmon_attr_generic_name:
+			ret = snprintf(buf, PAGE_SIZE, "hwmon_dummy\n");
+			break;
+		case hwmon_attr_in_label:
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
+static int get_num(void * inst_data, enum hwmon_attr attr,
+		unsigned int index, int *value)
+{
+	switch(attr) {
+	case hwmon_attr_generic_update_interval:
+		*value = 1000;
+		break;
+	case hwmon_attr_in_min:
+		*value = 1;
+		break;
+	case hwmon_attr_in_lcrit:
+		*value = 2;
+		break;
+	case hwmon_attr_in_max:
+		*value = 3;
+		break;
+	case hwmon_attr_in_crit:
+		*value = 4;
+		break;
+	case hwmon_attr_in_vid:
+		*value = 5;
+		break;
+	case hwmon_attr_in_vrm:
+		*value = 6;
+		break;
+	case hwmon_attr_in_input:
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
+static int set_num(void * inst_data, enum hwmon_attr attr,
+		unsigned int index, int value)
+{
+	return 0;
+}
+static int dummy_init(void)
+{
+	if(driver_register(&dummy_driver))
+		return 1;
+
+	platform_device_register(&dummy_device);
+	hwmon_dev = hwmon_device_register(&dummy_device.dev);
+
+	/* now really fire up the new core api
+	 * (some static structs will do also for drivers with only one valid
+	 * configuration, like this)
+	 * */
+	core_dev = kzalloc(sizeof(struct hwmon_device_instance), GFP_KERNEL);
+	core_dev->get_text_attr = &get_text;
+	core_dev->get_numeric_attr = &get_num;
+	core_dev->set_numeric_attr = &set_num;
+
+	core_dev->caps = kzalloc(sizeof(struct hwmon_device_caps), GFP_KERNEL);
+
+	core_dev->caps->num_channels[hwmon_feature_in] = 2;
+	core_dev->caps->subfeature_caps[hwmon_feature_in] +			HWMON_CAP(in_min)  | HWMON_CAP(in_lcrit) | HWMON_CAP(in_max) |
+			HWMON_CAP(in_crit) | HWMON_CAP(in_vid) | HWMON_CAP(in_vrm) |
+			HWMON_CAP(in_label);
+
+
+	core_dev->caps->num_channels[hwmon_feature_fan] = 2;
+	core_dev->caps->subfeature_caps[hwmon_feature_fan] +			HWMON_CAP(fan_min) | HWMON_CAP(fan_div) | HWMON_CAP(fan_label) |
+			HWMON_CAP(fan_max) | HWMON_CAP(fan_pulses) | HWMON_CAP(fan_target);
+
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
1.7.6



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
