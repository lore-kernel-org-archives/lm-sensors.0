From: Pawel Moll <pawel.moll@arm.com>
Date: Tue, 18 Sep 2012 14:17:45 +0000
Subject: [lm-sensors] [PATCH v2 03/13] hwmon: Versatile Express hwmon driver
Message-Id: <1347977875-16855-4-git-send-email-pawel.moll@arm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1347977875-16855-1-git-send-email-pawel.moll@arm.com>
In-Reply-To: <1347977875-16855-1-git-send-email-pawel.moll@arm.com>
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
 drivers/hwmon/Kconfig    |    8 ++
 drivers/hwmon/Makefile   |    1 +
 drivers/hwmon/vexpress.c |  330 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 339 insertions(+)
 create mode 100644 drivers/hwmon/vexpress.c

Hi Jean, Guenter,

Would you be able to merge this in time for 3.7? (if it looks fine, that is)

Regards

Pawel

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
index 0000000..fe80c63
--- /dev/null
+++ b/drivers/hwmon/vexpress.c
@@ -0,0 +1,330 @@
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
+static struct device *vexpress_hwmon_dev;
+static int vexpress_hwmon_dev_refcount;
+static DEFINE_SPINLOCK(vexpress_hwmon_dev_lock);
+
+static ssize_t vexpress_hwmon_name_show(struct device *dev,
+		struct device_attribute *dev_attr, char *buffer)
+{
+	return sprintf(buffer, "%s\n", DRVNAME);
+}
+
+static struct device_attribute vexpress_hwmon_name_attr +		__ATTR(name, 0444, vexpress_hwmon_name_show, NULL);
+
+struct vexpress_hwmon_attrs {
+	struct vexpress_config_func *func;
+	const char *label;
+	struct device_attribute label_attr;
+	char label_name[16];
+	struct device_attribute input_attr;
+	char input_name[16];
+	u32 divisor;
+};
+
+static ssize_t vexpress_hwmon_label_show(struct device *dev,
+		struct device_attribute *dev_attr, char *buffer)
+{
+	struct vexpress_hwmon_attrs *attrs = container_of(dev_attr,
+			struct vexpress_hwmon_attrs, label_attr);
+
+	return snprintf(buffer, PAGE_SIZE, "%s\n", attrs->label);
+}
+
+static ssize_t vexpress_hwmon_u32_show(struct device *dev,
+		struct device_attribute *dev_attr, char *buffer)
+{
+	struct vexpress_hwmon_attrs *attrs = container_of(dev_attr,
+			struct vexpress_hwmon_attrs, input_attr);
+	int err;
+	u32 value;
+
+	err = vexpress_config_read(attrs->func, 0, &value);
+	if (err)
+		return err;
+
+	return snprintf(buffer, PAGE_SIZE, "%u\n", value / attrs->divisor);
+}
+
+static ssize_t vexpress_hwmon_u64_show(struct device *dev,
+		struct device_attribute *dev_attr, char *buffer)
+{
+	struct vexpress_hwmon_attrs *attrs = container_of(dev_attr,
+			struct vexpress_hwmon_attrs, input_attr);
+	int err;
+	u32 value_hi, value_lo;
+
+	err = vexpress_config_read(attrs->func, 0, &value_lo);
+	if (err)
+		return err;
+
+	err = vexpress_config_read(attrs->func, 1, &value_hi);
+	if (err)
+		return err;
+
+	return snprintf(buffer, PAGE_SIZE, "%llu\n",
+			div_u64(((u64)value_hi << 32) | value_lo,
+			attrs->divisor));
+}
+
+static struct device *vexpress_hwmon_dev_get(void)
+{
+	struct device *result;
+
+	spin_lock(&vexpress_hwmon_dev_lock);
+
+	if (vexpress_hwmon_dev) {
+		result = vexpress_hwmon_dev;
+	} else {
+		int err;
+
+		result = hwmon_device_register(NULL);
+		if (IS_ERR(result))
+			goto out;
+
+		err = device_create_file(result, &vexpress_hwmon_name_attr);
+		if (err) {
+			result = ERR_PTR(err);
+			hwmon_device_unregister(result);
+			goto out;
+		}
+
+		vexpress_hwmon_dev = result;
+	}
+
+	vexpress_hwmon_dev_refcount++;
+
+out:
+	spin_unlock(&vexpress_hwmon_dev_lock);
+
+	return result;
+}
+
+static void vexpress_hwmon_dev_put(void)
+{
+	spin_lock(&vexpress_hwmon_dev_lock);
+
+	if (--vexpress_hwmon_dev_refcount = 0) {
+		hwmon_device_unregister(vexpress_hwmon_dev);
+		vexpress_hwmon_dev = NULL;
+	}
+
+	WARN_ON(vexpress_hwmon_dev_refcount < 0);
+
+	spin_unlock(&vexpress_hwmon_dev_lock);
+}
+
+struct vexpress_hwmon_func {
+	const char *name;
+	bool wide;
+	u32 divisor;
+	atomic_t index;
+};
+
+#if !defined(CONFIG_REGULATOR_VEXPRESS)
+static struct vexpress_hwmon_func vexpress_hwmon_volt = {
+	.name = "in",
+	.divisor = 1000,
+};
+#endif
+
+static struct vexpress_hwmon_func vexpress_hwmon_amp = {
+	.name = "curr",
+	.divisor = 1000,
+};
+
+static struct vexpress_hwmon_func vexpress_hwmon_temp = {
+	.name = "temp",
+	.divisor = 1000,
+};
+
+static struct vexpress_hwmon_func vexpress_hwmon_power = {
+	.name = "power",
+	.divisor = 1,
+};
+
+static struct vexpress_hwmon_func vexpress_hwmon_energy = {
+	.name = "energy",
+	.wide = true,
+	.divisor = 1,
+};
+
+static struct of_device_id vexpress_hwmon_of_match[] = {
+#if !defined(CONFIG_REGULATOR_VEXPRESS)
+	{
+		.compatible = "arm,vexpress-volt",
+		.data = &vexpress_hwmon_volt,
+	},
+#endif
+	{
+		.compatible = "arm,vexpress-amp",
+		.data = &vexpress_hwmon_amp,
+	}, {
+		.compatible = "arm,vexpress-temp",
+		.data = &vexpress_hwmon_temp,
+	}, {
+		.compatible = "arm,vexpress-power",
+		.data = &vexpress_hwmon_power,
+	}, {
+		.compatible = "arm,vexpress-energy",
+		.data = &vexpress_hwmon_energy,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, vexpress_hwmon_of_match);
+
+static int vexpress_hwmon_probe(struct platform_device *pdev)
+{
+	int err;
+	const struct of_device_id *match;
+	struct vexpress_hwmon_func *hwmon_func;
+	struct device *hwmon_dev;
+	struct vexpress_hwmon_attrs *attrs;
+	const char *attr_name;
+	int attr_index;
+
+	match = of_match_device(vexpress_hwmon_of_match, &pdev->dev);
+	if (!match) {
+		err = -EINVAL;
+		goto error_match_device;
+	}
+	hwmon_func = match->data;
+
+	hwmon_dev = vexpress_hwmon_dev_get();
+	if (IS_ERR(hwmon_dev)) {
+		err = PTR_ERR(hwmon_dev);
+		goto error_hwmon_dev_get;
+	}
+
+	attrs = devm_kzalloc(&pdev->dev, sizeof(*attrs), GFP_KERNEL);
+	if (!attrs) {
+		err = -ENOMEM;
+		goto error_kzalloc;
+	}
+
+	attrs->func = vexpress_config_func_get_by_dev(&pdev->dev);
+	if (!attrs->func) {
+		err = -ENXIO;
+		goto error_get_func;
+	}
+
+	err = sysfs_create_link(&pdev->dev.kobj, &hwmon_dev->kobj, "hwmon");
+	if (err)
+		goto error_create_link;
+
+	attr_index = atomic_inc_return(&hwmon_func->index);
+	attr_name = hwmon_func->name;
+
+	snprintf(attrs->input_name, sizeof(attrs->input_name),
+			"%s%d_input", attr_name, attr_index);
+	attrs->input_attr.attr.name = attrs->input_name;
+	attrs->input_attr.attr.mode = 0444;
+	if (hwmon_func->wide)
+		attrs->input_attr.show = vexpress_hwmon_u64_show;
+	else
+		attrs->input_attr.show = vexpress_hwmon_u32_show;
+	sysfs_attr_init(&attrs->input_attr.attr);
+	err = device_create_file(hwmon_dev, &attrs->input_attr);
+	if (err)
+		goto error_create_input;
+
+	attrs->label = of_get_property(pdev->dev.of_node, "label", NULL);
+	if (attrs->label) {
+		snprintf(attrs->label_name, sizeof(attrs->label_name),
+				"%s%d_label", attr_name, attr_index);
+		attrs->label_attr.attr.name = attrs->label_name;
+		attrs->label_attr.attr.mode = 0444;
+		attrs->label_attr.show = vexpress_hwmon_label_show;
+		sysfs_attr_init(&attrs->label_attr.attr);
+		err = device_create_file(hwmon_dev, &attrs->label_attr);
+		if (err)
+			goto error_create_label;
+	}
+
+	attrs->divisor = hwmon_func->divisor;
+
+	platform_set_drvdata(pdev, attrs);
+
+	return 0;
+
+error_create_label:
+	device_remove_file(hwmon_dev, &attrs->input_attr);
+error_create_input:
+	sysfs_remove_link(&pdev->dev.kobj, "hwmon");
+error_create_link:
+	vexpress_config_func_put(attrs->func);
+error_get_func:
+error_kzalloc:
+	vexpress_hwmon_dev_put();
+error_hwmon_dev_get:
+error_match_device:
+	return err;
+}
+
+static int __devexit vexpress_hwmon_remove(struct platform_device *pdev)
+{
+	struct vexpress_hwmon_attrs *attrs = platform_get_drvdata(pdev);
+	const struct of_device_id *match +		of_match_device(vexpress_hwmon_of_match, &pdev->dev);
+	struct vexpress_hwmon_func *hwmon_func = match->data;
+
+	if (attrs->label)
+		device_remove_file(vexpress_hwmon_dev, &attrs->label_attr);
+	device_remove_file(vexpress_hwmon_dev, &attrs->input_attr);
+	atomic_dec(&hwmon_func->index);
+	sysfs_remove_link(&pdev->dev.kobj, "hwmon");
+	vexpress_config_func_put(attrs->func);
+	vexpress_hwmon_dev_put();
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
+MODULE_DESCRIPTION("Versatile Express hwmon");
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
