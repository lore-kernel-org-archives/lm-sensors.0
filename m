From: Pawel Moll <pawel.moll@arm.com>
Date: Thu, 20 Sep 2012 16:54:18 +0000
Subject: [lm-sensors] [PATCH v3] hwmon: Versatile Express hwmon driver
Message-Id: <1348160058-13425-1-git-send-email-pawel.moll@arm.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

hwmon framework driver for Versatile Express sensors, providing
information about board level voltage (only when regulator driver
is not configured), currents, temperature and power/energy usage.
Labels for the values can be defined as DT properties.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 .../devicetree/bindings/hwmon/vexpress.txt         |   23 ++
 Documentation/hwmon/vexpress                       |   34 +++
 drivers/hwmon/Kconfig                              |    8 +
 drivers/hwmon/Makefile                             |    1 +
 drivers/hwmon/vexpress.c                           |  255 ++++++++++++++++++++
 5 files changed, 321 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/vexpress.txt
 create mode 100644 Documentation/hwmon/vexpress
 create mode 100644 drivers/hwmon/vexpress.c

diff --git a/Documentation/devicetree/bindings/hwmon/vexpress.txt b/Documentation/devicetree/bindings/hwmon/vexpress.txt
new file mode 100644
index 0000000..9c27ed6
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/vexpress.txt
@@ -0,0 +1,23 @@
+Versatile Express hwmon sensors
+-------------------------------
+
+Requires node properties:
+- "compatible" value : one of
+	"arm,vexpress-volt"
+	"arm,vexpress-amp"
+	"arm,vexpress-temp"
+	"arm,vexpress-power"
+	"arm,vexpress-energy"
+- "arm,vexpress-sysreg,func" when controlled via vexpress-sysreg
+  (see Documentation/devicetree/bindings/arm/vexpress-sysreg.txt
+  for more details)
+
+Optional node properties:
+- label : string describing the monitored value
+
+Example:
+	energy@0 {
+		compatible = "arm,vexpress-energy";
+		arm,vexpress-sysreg,func = <13 0>;
+		label = "A15 Jcore";
+	};
diff --git a/Documentation/hwmon/vexpress b/Documentation/hwmon/vexpress
new file mode 100644
index 0000000..557d6d5
--- /dev/null
+++ b/Documentation/hwmon/vexpress
@@ -0,0 +1,34 @@
+Kernel driver vexpress
+===========
+
+Supported systems:
+  * ARM Ltd. Versatile Express platform
+    Prefix: 'vexpress'
+    Datasheets:
+      * "Hardware Description" sections of the Technical Reference Manuals
+        for the Versatile Express boards:
+        http://infocenter.arm.com/help/topic/com.arm.doc.subset.boards.express/index.html
+      * Section "4.4.14. System Configuration registers" of the V2M-P1 TRM:
+        http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0447-/index.html
+
+Author: Pawel Moll
+
+Description
+-----------
+
+Versatile Express platform (http://www.arm.com/versatileexpress/) is a
+reference & prototyping system for ARM Ltd. processors. It can be set up
+from a wide range of boards, each of them containing (apart of the main
+chip/FPGA) a number of microcontrollers responsible for platform
+configuration and control. Theses microcontrollers can also monitor the
+board and its environment by a number of internal and external sensors,
+providing information about power lines voltages and currents, board
+temperature and power usage. Some of them also calculate consumed energy
+and provide a cumulative use counter.
+
+The configuration devices are _not_ memory mapped and must be accessed
+via a custom interface, abstracted by the "vexpress_config" API.
+
+As these devices are non-discoverable, they must be described in a Device
+Tree passed to the kernel. Details of the DT binding for them can be found
+in Documentation/devicetree/bindings/hwmon/vexpress.txt.
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index b0a2e4c..7359a07 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1187,6 +1187,14 @@ config SENSORS_TWL4030_MADC
 	This driver can also be built as a module. If so it will be called
 	twl4030-madc-hwmon.
 
+config SENSORS_VEXPRESS
+	tristate "Versatile Express"
+	depends on VEXPRESS_CONFIG
+	help
+	  This driver provides support for hardware sensors available on
+	  the ARM Ltd's Versatile Express platform. It can provide wide
+	  range of information like temperature, power, energy.
+
 config SENSORS_VIA_CPUTEMP
 	tristate "VIA CPU temperature sensor"
 	depends on X86
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 7aa9811..e719a7d 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -120,6 +120,7 @@ obj-$(CONFIG_SENSORS_TMP102)	+= tmp102.o
 obj-$(CONFIG_SENSORS_TMP401)	+= tmp401.o
 obj-$(CONFIG_SENSORS_TMP421)	+= tmp421.o
 obj-$(CONFIG_SENSORS_TWL4030_MADC)+= twl4030-madc-hwmon.o
+obj-$(CONFIG_SENSORS_VEXPRESS)	+= vexpress.o
 obj-$(CONFIG_SENSORS_VIA_CPUTEMP)+= via-cputemp.o
 obj-$(CONFIG_SENSORS_VIA686A)	+= via686a.o
 obj-$(CONFIG_SENSORS_VT1211)	+= vt1211.o
diff --git a/drivers/hwmon/vexpress.c b/drivers/hwmon/vexpress.c
new file mode 100644
index 0000000..d9f091e
--- /dev/null
+++ b/drivers/hwmon/vexpress.c
@@ -0,0 +1,255 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * Copyright (C) 2012 ARM Limited
+ */
+
+#define DRVNAME "vexpress-hwmon"
+#define pr_fmt(fmt) DRVNAME ": " fmt
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/hwmon.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/vexpress.h>
+
+struct vexpress_hwmon_data {
+	struct device *hwmon_dev;
+	struct vexpress_config_func *func;
+};
+
+struct vexpress_hwmon_attr {
+	struct device_attribute dev_attr;
+	u32 divisor;
+};
+
+static ssize_t vexpress_hwmon_name_show(struct device *dev,
+		struct device_attribute *dev_attr, char *buffer)
+{
+	const char *compatible = of_get_property(dev->of_node, "compatible",
+			NULL);
+
+	return sprintf(buffer, "%s\n", compatible);
+}
+
+static ssize_t vexpress_hwmon_label_show(struct device *dev,
+		struct device_attribute *dev_attr, char *buffer)
+{
+	const char *label = of_get_property(dev->of_node, "label", NULL);
+
+	return snprintf(buffer, PAGE_SIZE, "%s\n", label);
+}
+
+static ssize_t vexpress_hwmon_u32_show(struct device *dev,
+		struct device_attribute *dev_attr, char *buffer)
+{
+	struct vexpress_hwmon_attr *attr = container_of(dev_attr,
+			struct vexpress_hwmon_attr, dev_attr);
+	struct vexpress_hwmon_data *data = dev_get_drvdata(dev);
+	int err;
+	u32 value;
+
+	err = vexpress_config_read(data->func, 0, &value);
+	if (err)
+		return err;
+
+	return snprintf(buffer, PAGE_SIZE, "%u\n", value / attr->divisor);
+}
+
+static ssize_t vexpress_hwmon_u64_show(struct device *dev,
+		struct device_attribute *dev_attr, char *buffer)
+{
+	struct vexpress_hwmon_attr *attr = container_of(dev_attr,
+			struct vexpress_hwmon_attr, dev_attr);
+	struct vexpress_hwmon_data *data = dev_get_drvdata(dev);
+	int err;
+	u32 value_hi, value_lo;
+
+	err = vexpress_config_read(data->func, 0, &value_lo);
+	if (err)
+		return err;
+
+	err = vexpress_config_read(data->func, 1, &value_hi);
+	if (err)
+		return err;
+
+	return snprintf(buffer, PAGE_SIZE, "%llu\n",
+			div_u64(((u64)value_hi << 32) | value_lo,
+			attr->divisor));
+}
+
+static DEVICE_ATTR(name, S_IRUGO, vexpress_hwmon_name_show, NULL);
+
+#define VEXPRESS_HWMON_ATTR(_name, _show, _divisor)		\
+struct vexpress_hwmon_attr vexpress_hwmon_attr_##_name = {	\
+	.dev_attr = __ATTR(_name, S_IRUGO, _show, NULL),	\
+	.divisor = _divisor,					\
+}
+
+#define VEXPRESS_HWMON_ATTRS(_name, _label_attr, _input_attr)	\
+struct attribute *vexpress_hwmon_attrs_##_name[] = {		\
+	&dev_attr_name.attr,					\
+	&dev_attr_##_label_attr.attr,				\
+	&vexpress_hwmon_attr_##_input_attr.dev_attr.attr,	\
+	NULL							\
+}
+
+#if !defined(CONFIG_REGULATOR_VEXPRESS)
+static DEVICE_ATTR(in1_label, S_IRUGO, vexpress_hwmon_label_show, NULL);
+static VEXPRESS_HWMON_ATTR(in1_input, vexpress_hwmon_u32_show, 1000);
+static VEXPRESS_HWMON_ATTRS(volt, in1_label, in1_input);
+static struct attribute_group vexpress_hwmon_group_volt = {
+	.attrs = vexpress_hwmon_attrs_volt,
+};
+#endif
+
+static DEVICE_ATTR(curr1_label, S_IRUGO, vexpress_hwmon_label_show, NULL);
+static VEXPRESS_HWMON_ATTR(curr1_input, vexpress_hwmon_u32_show, 1000);
+static VEXPRESS_HWMON_ATTRS(amp, curr1_label, curr1_input);
+static struct attribute_group vexpress_hwmon_group_amp = {
+	.attrs = vexpress_hwmon_attrs_amp,
+};
+
+static DEVICE_ATTR(temp1_label, S_IRUGO, vexpress_hwmon_label_show, NULL);
+static VEXPRESS_HWMON_ATTR(temp1_input, vexpress_hwmon_u32_show, 1000);
+static VEXPRESS_HWMON_ATTRS(temp, temp1_label, temp1_input);
+static struct attribute_group vexpress_hwmon_group_temp = {
+	.attrs = vexpress_hwmon_attrs_temp,
+};
+
+static DEVICE_ATTR(power1_label, S_IRUGO, vexpress_hwmon_label_show, NULL);
+static VEXPRESS_HWMON_ATTR(power1_input, vexpress_hwmon_u32_show, 1);
+static VEXPRESS_HWMON_ATTRS(power, power1_label, power1_input);
+static struct attribute_group vexpress_hwmon_group_power = {
+	.attrs = vexpress_hwmon_attrs_power,
+};
+
+static DEVICE_ATTR(energy1_label, S_IRUGO, vexpress_hwmon_label_show, NULL);
+static VEXPRESS_HWMON_ATTR(energy1_input, vexpress_hwmon_u64_show, 1);
+static VEXPRESS_HWMON_ATTRS(energy, energy1_label, energy1_input);
+static struct attribute_group vexpress_hwmon_group_energy = {
+	.attrs = vexpress_hwmon_attrs_energy,
+};
+
+static struct of_device_id vexpress_hwmon_of_match[] = {
+#if !defined(CONFIG_REGULATOR_VEXPRESS)
+	{
+		.compatible = "arm,vexpress-volt",
+		.data = &vexpress_hwmon_group_volt,
+	},
+#endif
+	{
+		.compatible = "arm,vexpress-amp",
+		.data = &vexpress_hwmon_group_amp,
+	}, {
+		.compatible = "arm,vexpress-temp",
+		.data = &vexpress_hwmon_group_temp,
+	}, {
+		.compatible = "arm,vexpress-power",
+		.data = &vexpress_hwmon_group_power,
+	}, {
+		.compatible = "arm,vexpress-energy",
+		.data = &vexpress_hwmon_group_energy,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, vexpress_hwmon_of_match);
+
+static int vexpress_hwmon_probe(struct platform_device *pdev)
+{
+	int err;
+	const struct of_device_id *match;
+	struct vexpress_hwmon_data *data;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data) {
+		err = -ENOMEM;
+		goto error_kzalloc;
+	}
+
+	match = of_match_device(vexpress_hwmon_of_match, &pdev->dev);
+	if (!match) {
+		err = -EINVAL;
+		goto error_match_device;
+	}
+
+	data->func = vexpress_config_func_get_by_dev(&pdev->dev);
+	if (!data->func) {
+		err = -ENXIO;
+		goto error_get_func;
+	}
+
+	err = sysfs_create_group(&pdev->dev.kobj, match->data);
+	if (err)
+		goto error_create_group;
+
+	data->hwmon_dev = hwmon_device_register(&pdev->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
+		goto error_hwmon_device_register;
+	}
+
+	platform_set_drvdata(pdev, data);
+
+	return 0;
+
+error_hwmon_device_register:
+	sysfs_remove_group(&pdev->dev.kobj, match->data);
+error_create_group:
+	vexpress_config_func_put(data->func);
+error_get_func:
+error_match_device:
+error_kzalloc:
+	return err;
+}
+
+static int __devexit vexpress_hwmon_remove(struct platform_device *pdev)
+{
+	struct vexpress_hwmon_data *data = platform_get_drvdata(pdev);
+	const struct of_device_id *match;
+
+	hwmon_device_unregister(data->hwmon_dev);
+
+	match = of_match_device(vexpress_hwmon_of_match, &pdev->dev);
+	sysfs_remove_group(&pdev->dev.kobj, match->data);
+
+	vexpress_config_func_put(data->func);
+
+	return 0;
+}
+
+static struct platform_driver vexpress_hwmon_driver = {
+	.probe = vexpress_hwmon_probe,
+	.remove = __devexit_p(vexpress_hwmon_remove),
+	.driver	= {
+		.name = DRVNAME,
+		.owner = THIS_MODULE,
+		.of_match_table = vexpress_hwmon_of_match,
+	},
+};
+
+static int __init vexpress_hwmon_init(void)
+{
+	return platform_driver_register(&vexpress_hwmon_driver);
+}
+
+static void __exit vexpress_hwmon_exit(void)
+{
+	platform_driver_unregister(&vexpress_hwmon_driver);
+}
+
+MODULE_AUTHOR("Pawel Moll <pawel.moll@arm.com>");
+MODULE_DESCRIPTION("Versatile Express hwmon sensors driver");
+MODULE_LICENSE("GPL");
+
+module_init(vexpress_hwmon_init);
+module_exit(vexpress_hwmon_exit);
-- 
1.7.9.5



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
