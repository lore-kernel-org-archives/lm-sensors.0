From: Punit Agrawal <punit.agrawal@arm.com>
Date: Wed, 22 Jul 2015 14:02:40 +0000
Subject: [lm-sensors] [PATCH 6/9] hwmon: Support sensors exported via ARM SCP interface
Message-Id: <1437573763-6525-7-git-send-email-punit.agrawal@arm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1437573763-6525-1-git-send-email-punit.agrawal@arm.com>
In-Reply-To: <1437573763-6525-1-git-send-email-punit.agrawal@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-pm@vger.kernel.org
Cc: Punit Agrawal <punit.agrawal@arm.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, Sudeep Holla <sudeep.holla@arm.com>

Create a driver to add support for SoC sensors exported by the System
Control Processor (SCP) via the System Control and Power Interface
(SCPI). The supported sensor types is one of voltage, temperature,
current, and power.

The sensor labels and values provided by the SCP are exported via the
hwmon sysfs interface.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Cc: Jean Delvare <jdelvare@suse.de>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/hwmon/Kconfig      |   8 ++
 drivers/hwmon/Makefile     |   1 +
 drivers/hwmon/scpi-hwmon.c | 212 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 221 insertions(+)
 create mode 100644 drivers/hwmon/scpi-hwmon.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 4943c3c..f5e0862 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1551,6 +1551,14 @@ config SENSORS_VEXPRESS
 	  the ARM Ltd's Versatile Express platform. It can provide wide
 	  range of information like temperature, power, energy.
 
+config SENSORS_ARM_SCPI
+	tristate "ARM SCPI Sensors"
+	depends on ARM_SCPI_PROTOCOL
+	help
+	  This driver provides support for hardware sensors available on
+	  the ARM Ltd's SCP based platforms. It can provide temperature
+	  and voltage for range of devices on the SoC.
+
 config SENSORS_VIA_CPUTEMP
 	tristate "VIA CPU temperature sensor"
 	depends on X86
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 8aba87f..4961710 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -150,6 +150,7 @@ obj-$(CONFIG_SENSORS_TMP421)	+= tmp421.o
 obj-$(CONFIG_SENSORS_TWL4030_MADC)+= twl4030-madc-hwmon.o
 obj-$(CONFIG_SENSORS_V2M_JUNO)	+= v2m-juno.o
 obj-$(CONFIG_SENSORS_VEXPRESS)	+= vexpress.o
+obj-$(CONFIG_SENSORS_ARM_SCPI)	+= scpi-hwmon.o
 obj-$(CONFIG_SENSORS_VIA_CPUTEMP)+= via-cputemp.o
 obj-$(CONFIG_SENSORS_VIA686A)	+= via686a.o
 obj-$(CONFIG_SENSORS_VT1211)	+= vt1211.o
diff --git a/drivers/hwmon/scpi-hwmon.c b/drivers/hwmon/scpi-hwmon.c
new file mode 100644
index 0000000..dd0a6f1
--- /dev/null
+++ b/drivers/hwmon/scpi-hwmon.c
@@ -0,0 +1,212 @@
+/*
+ * System Control and Power Interface(SCPI) based hwmon sensor driver
+ *
+ * Copyright (C) 2015 ARM Ltd.
+ * Punit Agrawal <punit.agrawal@arm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/hwmon.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/scpi_protocol.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+
+static struct scpi_ops *scpi_ops;
+
+struct sensor_dev {
+	struct scpi_sensor_info info;
+	struct device_attribute dev_attr_input;
+	struct device_attribute dev_attr_label;
+	char input[20];
+	char label[20];
+};
+
+struct scpi_sensors {
+	int num_volt;
+	int num_temp;
+	int num_current;
+	int num_power;
+	struct sensor_dev *device;
+	struct device *hwdev;
+};
+struct scpi_sensors scpi_sensors;
+
+static int scpi_read_sensor(struct sensor_dev *sensor, u32 *value)
+{
+	int ret;
+
+	ret = scpi_ops->sensor_get_value(sensor->info.sensor_id, value);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+/* hwmon callback functions */
+static ssize_t
+scpi_hwmon_show_sensor(struct device *dev,
+		       struct device_attribute *attr, char *buf)
+{
+	struct sensor_dev *sensor;
+	u32 value;
+	int ret;
+
+	sensor = container_of(attr, struct sensor_dev, dev_attr_input);
+
+	ret = scpi_read_sensor(sensor, &value);
+	if (ret) {
+		dev_warn(dev, "error (ret=%d) reading sensor (id=%u) value\n",
+			 ret, sensor->info.sensor_id);
+		return 0;
+	}
+
+	return sprintf(buf, "%u\n", value);
+}
+
+static ssize_t
+scpi_hwmon_show_label(struct device *dev,
+		      struct device_attribute *attr, char *buf)
+{
+	struct sensor_dev *sensor;
+
+	sensor = container_of(attr, struct sensor_dev, dev_attr_label);
+
+	return sprintf(buf, "%s\n", sensor->info.name);
+}
+
+struct attribute *scpi_attrs[24] = { 0 };
+struct attribute_group scpi_group;
+const struct attribute_group *scpi_groups[2] = { 0 };
+
+static int scpi_hwmon_probe(struct platform_device *pdev)
+{
+	u16 sensors, i;
+	int ret;
+
+	scpi_ops = get_scpi_ops();
+	if (!scpi_ops)
+		return -EPROBE_DEFER;
+
+	ret = scpi_ops->sensor_get_capability(&sensors);
+	if (ret)
+		return ret;
+
+	scpi_sensors.device = devm_kcalloc(&pdev->dev, sensors,
+				   sizeof(*scpi_sensors.device), GFP_KERNEL);
+	if (!scpi_sensors.device)
+		return -ENOMEM;
+
+	dev_info(&pdev->dev, "Found %d sensors\n", sensors);
+	for (i = 0; i < sensors; i++) {
+		struct sensor_dev *dev = &scpi_sensors.device[i];
+
+		ret = scpi_ops->sensor_get_info(i, &dev->info);
+		if (ret) {
+			dev_info(&pdev->dev,
+				 "Error ret=%d when querying for sensor %d\n",
+				 ret, i);
+			return ret;
+		}
+
+		dev_info(&pdev->dev, "Probed \'%s\' sensor.\n",
+			 dev->info.name);
+
+		switch (dev->info.class) {
+		case TEMPERATURE:
+			snprintf(dev->input, 20,
+				 "temp%d_input", scpi_sensors.num_temp);
+			snprintf(dev->label, 20,
+				 "temp%d_label", scpi_sensors.num_temp);
+			scpi_sensors.num_temp++;
+			break;
+		case VOLTAGE:
+			snprintf(dev->input, 20,
+				 "in%d_input", scpi_sensors.num_volt);
+			snprintf(dev->label, 20,
+				 "in%d_label", scpi_sensors.num_volt);
+			scpi_sensors.num_volt++;
+			break;
+		case CURRENT:
+			snprintf(dev->input, 20,
+				 "curr%d_input", scpi_sensors.num_current);
+			snprintf(dev->label, 20,
+				 "curr%d_label", scpi_sensors.num_current);
+			scpi_sensors.num_current++;
+			break;
+		case POWER:
+			snprintf(dev->input, 20,
+				 "power%d_input", scpi_sensors.num_power);
+			snprintf(dev->label, 20,
+				 "power%d_label", scpi_sensors.num_power);
+			scpi_sensors.num_power++;
+			break;
+		default:
+			break;
+		}
+
+		dev->dev_attr_input.attr.mode = S_IRUGO;
+		dev->dev_attr_input.store = NULL;
+		dev->dev_attr_input.show = scpi_hwmon_show_sensor;
+		dev->dev_attr_input.attr.name = dev->input;
+
+		dev->dev_attr_label.attr.mode = S_IRUGO;
+		dev->dev_attr_label.store = NULL;
+		dev->dev_attr_label.show = scpi_hwmon_show_label;
+		dev->dev_attr_label.attr.name = dev->label;
+
+		scpi_attrs[i << 1] = &dev->dev_attr_input.attr;
+		scpi_attrs[(i << 1) + 1] = &dev->dev_attr_label.attr;
+	}
+
+	scpi_group.attrs = scpi_attrs;
+	scpi_groups[0] = &scpi_group;
+
+	scpi_sensors.hwdev = devm_hwmon_device_register_with_groups(&pdev->dev,
+				    "scpi_sensors", &scpi_sensors, scpi_groups);
+
+	if (IS_ERR(scpi_sensors.hwdev)) {
+		dev_err(&pdev->dev, "Error registering scpi_sensors hwmon device\n");
+		return PTR_ERR(scpi_sensors.hwdev);
+	}
+
+	dev_info(&pdev->dev, "SCPI hwmon driver initialised.\n");
+	return 0;
+}
+
+static int scpi_hwmon_remove(struct platform_device *pdev)
+{
+	scpi_ops = NULL;
+	return 0;
+}
+
+static const struct of_device_id scpi_of_match[] = {
+	{.compatible = "arm,scpi-sensors"},
+	{},
+};
+
+static struct platform_driver scpi_hwmon_platdrv = {
+	.driver = {
+		.name	= "scpi-hwmon",
+		.owner	= THIS_MODULE,
+		.of_match_table = scpi_of_match,
+	},
+	.probe		= scpi_hwmon_probe,
+	.remove	= scpi_hwmon_remove,
+};
+module_platform_driver(scpi_hwmon_platdrv);
+
+MODULE_AUTHOR("Punit Agrawal <punit.agrawal@arm.com>");
+MODULE_DESCRIPTION("ARM SCPI HWMON interface driver");
+MODULE_LICENSE("GPL v2");
-- 
2.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
