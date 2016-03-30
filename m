From: Tiberiu Breana <tiberiu.a.breana@intel.com>
Date: Wed, 30 Mar 2016 16:16:24 +0000
Subject: [lm-sensors] [PATCH v4] hwmon: (max31722) Add support for MAX31722/MAX31723 temperature sensors
Message-Id: <1459354584-14510-1-git-send-email-tiberiu.a.breana@intel.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add basic support for the Maxim Integrated MAX31722/MAX31723 SPI
temperature sensors / thermostats.

Includes:
    - ACPI support;
    - raw temperature readings;
    - power management

Datasheet:
https://datasheets.maximintegrated.com/en/ds/MAX31722-MAX31723.pdf

Signed-off-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
---
Changes since v3:
- fixed a problem regarding the measurement scale
---
 Documentation/hwmon/max31722 |  34 +++++++++
 drivers/hwmon/Kconfig        |  10 +++
 drivers/hwmon/Makefile       |   1 +
 drivers/hwmon/max31722.c     | 165 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 210 insertions(+)
 create mode 100644 Documentation/hwmon/max31722
 create mode 100644 drivers/hwmon/max31722.c

diff --git a/Documentation/hwmon/max31722 b/Documentation/hwmon/max31722
new file mode 100644
index 0000000..090da845
--- /dev/null
+++ b/Documentation/hwmon/max31722
@@ -0,0 +1,34 @@
+Kernel driver max31722
+===========
+
+Supported chips:
+  * Maxim Integrated MAX31722
+    Prefix: 'max31722'
+    ACPI ID: MAX31722
+    Addresses scanned: -
+    Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX31722-MAX31723.pdf
+  * Maxim Integrated MAX31723
+    Prefix: 'max31723'
+    ACPI ID: MAX31723
+    Addresses scanned: -
+    Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX31722-MAX31723.pdf
+
+Author: Tiberiu Breana <tiberiu.a.breana@intel.com>
+
+Description
+-----------
+
+This driver adds support for the Maxim Integrated MAX31722/MAX31723 thermometers
+and thermostats running over an SPI interface.
+
+Usage Notes
+-----------
+
+This driver uses ACPI to auto-detect devices. See ACPI IDs in the above section.
+
+Sysfs entries
+-------------
+
+The following attribute is supported:
+
+temp1_input		Measured temperature. Read-only.
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 60fb80b..00dbe08 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -807,6 +807,16 @@ config SENSORS_MAX197
 	  This driver can also be built as a module. If so, the module
 	  will be called max197.
 
+config SENSORS_MAX31722
+tristate "MAX31722 temperature sensor"
+	depends on SPI
+	help
+	  Support for the Maxim Integrated MAX31722/MAX31723 digital
+	  thermometers/thermostats operating over an SPI interface.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called max31722.
+
 config SENSORS_MAX6639
 	tristate "Maxim MAX6639 sensor chip"
 	depends on I2C
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 30c94df..689afe9 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -111,6 +111,7 @@ obj-$(CONFIG_SENSORS_MAX16065)	+= max16065.o
 obj-$(CONFIG_SENSORS_MAX1619)	+= max1619.o
 obj-$(CONFIG_SENSORS_MAX1668)	+= max1668.o
 obj-$(CONFIG_SENSORS_MAX197)	+= max197.o
+obj-$(CONFIG_SENSORS_MAX31722)	+= max31722.o
 obj-$(CONFIG_SENSORS_MAX6639)	+= max6639.o
 obj-$(CONFIG_SENSORS_MAX6642)	+= max6642.o
 obj-$(CONFIG_SENSORS_MAX6650)	+= max6650.o
diff --git a/drivers/hwmon/max31722.c b/drivers/hwmon/max31722.c
new file mode 100644
index 0000000..30a100e
--- /dev/null
+++ b/drivers/hwmon/max31722.c
@@ -0,0 +1,165 @@
+/*
+ * max31722 - hwmon driver for Maxim Integrated MAX31722/MAX31723 SPI
+ * digital thermometer and thermostats.
+ *
+ * Copyright (c) 2016, Intel Corporation.
+ *
+ * This file is subject to the terms and conditions of version 2 of
+ * the GNU General Public License. See the file COPYING in the main
+ * directory of this archive for more details.
+ */
+
+#include <linux/acpi.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+
+#define MAX31722_REG_CFG				0x00
+#define MAX31722_REG_TEMP_LSB				0x01
+
+#define MAX31722_MODE_CONTINUOUS			0x00
+#define MAX31722_MODE_STANDBY				0x01
+#define MAX31722_MODE_MASK				0xFE
+#define MAX31722_RESOLUTION_12BIT			0x06
+#define MAX31722_WRITE_MASK				0x80
+
+struct max31722_data {
+	struct device *hwmon_dev;
+	struct spi_device *spi_device;
+	u8 mode;
+};
+
+static int max31722_set_mode(struct max31722_data *data, u8 mode)
+{
+	int ret;
+	struct spi_device *spi = data->spi_device;
+	u8 buf[2] = {
+		MAX31722_REG_CFG | MAX31722_WRITE_MASK,
+		(data->mode & MAX31722_MODE_MASK) | mode
+	};
+
+	ret = spi_write(spi, &buf, sizeof(buf));
+	if (ret < 0) {
+		dev_err(&spi->dev, "failed to set sensor mode.\n");
+		return ret;
+	}
+	data->mode = (data->mode & MAX31722_MODE_MASK) | mode;
+
+	return 0;
+}
+
+static ssize_t max31722_show_temp(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buf)
+{
+	ssize_t ret;
+	struct max31722_data *data = dev_get_drvdata(dev);
+
+	ret = spi_w8r16(data->spi_device, MAX31722_REG_TEMP_LSB);
+	if (ret < 0)
+		return ret;
+	/* Keep 12 bits and multiply by the scale of 62.5 millidegrees/bit. */
+	return sprintf(buf, "%d\n", (s16)le16_to_cpu(ret) * 125 / 32);
+}
+
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO,
+			  max31722_show_temp, NULL, 0);
+
+static struct attribute *max31722_attrs[] = {
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	NULL,
+};
+
+ATTRIBUTE_GROUPS(max31722);
+
+static int max31722_probe(struct spi_device *spi)
+{
+	int ret;
+	struct max31722_data *data;
+
+	data = devm_kzalloc(&spi->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	spi_set_drvdata(spi, data);
+	data->spi_device = spi;
+	/*
+	 * Set SD bit to 0 so we can have continuous measurements.
+	 * Set resolution to 12 bits for maximum precision.
+	 */
+	data->mode = MAX31722_MODE_CONTINUOUS | MAX31722_RESOLUTION_12BIT;
+	ret = max31722_set_mode(data, MAX31722_MODE_CONTINUOUS);
+	if (ret < 0)
+		return ret;
+
+	data->hwmon_dev = hwmon_device_register_with_groups(&spi->dev,
+							    spi->modalias,
+							    data,
+							    max31722_groups);
+	if (IS_ERR(data->hwmon_dev)) {
+		max31722_set_mode(data, MAX31722_MODE_STANDBY);
+		return PTR_ERR(data->hwmon_dev);
+	}
+
+	return 0;
+}
+
+static int max31722_remove(struct spi_device *spi)
+{
+	struct max31722_data *data = spi_get_drvdata(spi);
+
+	hwmon_device_unregister(data->hwmon_dev);
+
+	return max31722_set_mode(data, MAX31722_MODE_STANDBY);
+}
+
+static int __maybe_unused max31722_suspend(struct device *dev)
+{
+	struct spi_device *spi_device = to_spi_device(dev);
+	struct max31722_data *data = spi_get_drvdata(spi_device);
+
+	return max31722_set_mode(data, MAX31722_MODE_STANDBY);
+}
+
+static int __maybe_unused max31722_resume(struct device *dev)
+{
+	struct spi_device *spi_device = to_spi_device(dev);
+	struct max31722_data *data = spi_get_drvdata(spi_device);
+
+	return max31722_set_mode(data, MAX31722_MODE_CONTINUOUS);
+}
+
+static SIMPLE_DEV_PM_OPS(max31722_pm_ops, max31722_suspend, max31722_resume);
+
+static const struct spi_device_id max31722_spi_id[] = {
+	{"max31722", 0},
+	{"max31723", 0},
+	{}
+};
+
+static const struct acpi_device_id __maybe_unused max31722_acpi_id[] = {
+	{"MAX31722", 0},
+	{"MAX31723", 0},
+	{}
+};
+
+MODULE_DEVICE_TABLE(spi, max31722_spi_id);
+
+static struct spi_driver max31722_driver = {
+	.driver = {
+		.name = "max31722",
+		.pm = &max31722_pm_ops,
+		.acpi_match_table = ACPI_PTR(max31722_acpi_id),
+	},
+	.probe =            max31722_probe,
+	.remove =           max31722_remove,
+	.id_table =         max31722_spi_id,
+};
+
+module_spi_driver(max31722_driver);
+
+MODULE_AUTHOR("Tiberiu Breana <tiberiu.a.breana@intel.com>");
+MODULE_DESCRIPTION("max31722 sensor driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
