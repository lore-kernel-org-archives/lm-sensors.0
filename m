From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 20 Jan 2014 18:58:26 +0000
Subject: [lm-sensors] [PATCH] hwmon: Driver for Linear Technologies LTC4260
Message-Id: <1390244306-20509-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1390244236-20425-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1390244236-20425-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

LTC4260 is a Positive Voltage Hot Swap Controller.
The driver currently only supports voltage monitoring, not voltage control.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/ltc4260 |   56 ++++++++++++
 drivers/hwmon/Kconfig       |   11 +++
 drivers/hwmon/Makefile      |    1 +
 drivers/hwmon/ltc4260.c     |  201 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 269 insertions(+)
 create mode 100644 Documentation/hwmon/ltc4260
 create mode 100644 drivers/hwmon/ltc4260.c

diff --git a/Documentation/hwmon/ltc4260 b/Documentation/hwmon/ltc4260
new file mode 100644
index 0000000..c4ff4ad
--- /dev/null
+++ b/Documentation/hwmon/ltc4260
@@ -0,0 +1,56 @@
+Kernel driver ltc4260
+==========+
+Supported chips:
+  * Linear Technology LTC4260
+    Prefix: 'ltc4260'
+    Addresses scanned: -
+    Datasheet:
+        http://cds.linear.com/docs/en/datasheet/4260fc.pdf
+
+Author: Guenter Roeck <linux@roeck-us.net>
+
+
+Description
+-----------
+
+The LTC4260 Hot Swap controller allows a board to be safely inserted
+and removed from a live backplane.
+
+
+Usage Notes
+-----------
+
+This driver does not probe for LTC4260 devices, since there is no register
+which can be safely used to identify the chip. You will have to instantiate
+the devices explicitly.
+
+Example: the following will load the driver for an LTC4260 at address 0x10
+on I2C bus #1:
+$ modprobe ltc4260
+$ echo ltc4260 0x10 > /sys/bus/i2c/devices/i2c-1/new_device
+
+
+Sysfs entries
+-------------
+
+Voltage readings provided by this driver are reported as obtained from the ADC
+registers. If a set of voltage divider resistors is installed, calculate the
+real voltage by multiplying the reported value with (R1+R2)/R2, where R1 is the
+value of the divider resistor against the measured voltage and R2 is the value
+of the divider resistor against Ground.
+
+Current reading provided by this driver is reported as obtained from the ADC
+Current Sense register. The reported value assumes that a 1 mOhm sense resistor
+is installed. If a different sense resistor is installed, calculate the real
+current by dividing the reported value by the sense resistor value in mOhm.
+
+in1_input		SOURCE voltage (mV)
+in1_min_alarm		Undervoltage alarm
+in1_max_alarm		Overvoltage alarm
+
+in2_input		ADIN voltage (mV)
+in2_alarm		Power bad alarm
+
+curr1_input		SENSE current (mA)
+curr1_alarm		SENSE overcurrent alarm
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 52d548f..6cbbd43 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -808,6 +808,17 @@ config SENSORS_LTC4245
 	  This driver can also be built as a module. If so, the module will
 	  be called ltc4245.
 
+config SENSORS_LTC4260
+	tristate "Linear Technology LTC4260"
+	depends on I2C
+	default n
+	help
+	  If you say yes here you get support for Linear Technology LTC4261
+	  Positive Voltage Hot Swap Controller I2C interface.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called ltc4260.
+
 config SENSORS_LTC4261
 	tristate "Linear Technology LTC4261"
 	depends on I2C
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index ec7cde0..7afbc928 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -98,6 +98,7 @@ obj-$(CONFIG_SENSORS_LM95245)	+= lm95245.o
 obj-$(CONFIG_SENSORS_LTC4151)	+= ltc4151.o
 obj-$(CONFIG_SENSORS_LTC4215)	+= ltc4215.o
 obj-$(CONFIG_SENSORS_LTC4245)	+= ltc4245.o
+obj-$(CONFIG_SENSORS_LTC4260)	+= ltc4260.o
 obj-$(CONFIG_SENSORS_LTC4261)	+= ltc4261.o
 obj-$(CONFIG_SENSORS_MAX1111)	+= max1111.o
 obj-$(CONFIG_SENSORS_MAX16065)	+= max16065.o
diff --git a/drivers/hwmon/ltc4260.c b/drivers/hwmon/ltc4260.c
new file mode 100644
index 0000000..b83181e
--- /dev/null
+++ b/drivers/hwmon/ltc4260.c
@@ -0,0 +1,201 @@
+/*
+ * Driver for Linear Technology LTC4260 I2C Positive Voltage Hot Swap Controller
+ *
+ * Copyright (c) 2014 Guenter Roeck
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/jiffies.h>
+#include <linux/regmap.h>
+
+/* chip registers */
+#define LTC4260_CONTROL	0x00
+#define LTC4260_ALERT	0x01
+#define LTC4260_STATUS	0x02
+#define LTC4260_FAULT	0x03
+#define LTC4260_SENSE	0x04
+#define LTC4260_SOURCE	0x05
+#define LTC4260_ADIN	0x06
+
+/*
+ * Fault register bits
+ */
+#define FAULT_OV	(1 << 0)
+#define FAULT_UV	(1 << 1)
+#define FAULT_OC	(1 << 2)
+#define FAULT_POWER_BAD	(1 << 3)
+#define FAULT_FET_SHORT	(1 << 5)
+
+/* Return the voltage from the given register in mV or mA */
+static int ltc4260_get_value(struct device *dev, u8 reg)
+{
+	struct regmap *regmap = dev_get_drvdata(dev);
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(regmap, reg, &val);
+	if (ret < 0)
+		return ret;
+
+	switch (reg) {
+	case LTC4260_ADIN:
+		/* 10 mV resolution. Convert to mV. */
+		val = val * 10;
+		break;
+	case LTC4260_SOURCE:
+		/* 400 mV resolution. Convert to mV. */
+		val = val * 400;
+		break;
+	case LTC4260_SENSE:
+		/*
+		 * 300 uV resolution. Convert to current as measured with
+		 * an 1 mOhm sense resistor, in mA. If a different sense
+		 * resistor is installed, calculate the actual current by
+		 * dividing the reported current by the sense resistor value
+		 * in mOhm.
+		 */
+		val = val * 300;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return val;
+}
+
+static ssize_t ltc4260_show_value(struct device *dev,
+				  struct device_attribute *da, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	int value;
+
+	value = ltc4260_get_value(dev, attr->index);
+	if (value < 0)
+		return value;
+	return snprintf(buf, PAGE_SIZE, "%d\n", value);
+}
+
+static ssize_t ltc4260_show_bool(struct device *dev,
+				 struct device_attribute *da, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct regmap *regmap = dev_get_drvdata(dev);
+	unsigned int fault;
+	int ret;
+
+	ret = regmap_read(regmap, LTC4260_FAULT, &fault);
+	if (ret < 0)
+		return ret;
+
+	fault &= attr->index;
+	if (fault)		/* Clear reported faults in chip register */
+		regmap_update_bits(regmap, LTC4260_FAULT, attr->index, 0);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", !!fault);
+}
+
+/* Voltages */
+static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, ltc4260_show_value, NULL,
+			  LTC4260_SOURCE);
+static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, ltc4260_show_value, NULL,
+			  LTC4260_ADIN);
+
+/*
+ * Voltage alarms
+ * UV/OV faults are associated with the input voltage, and the POWER BAD and
+ * FET SHORT faults are associated with the output voltage.
+ */
+static SENSOR_DEVICE_ATTR(in1_min_alarm, S_IRUGO, ltc4260_show_bool, NULL,
+			  FAULT_UV);
+static SENSOR_DEVICE_ATTR(in1_max_alarm, S_IRUGO, ltc4260_show_bool, NULL,
+			  FAULT_OV);
+static SENSOR_DEVICE_ATTR(in2_alarm, S_IRUGO, ltc4260_show_bool, NULL,
+			  FAULT_POWER_BAD | FAULT_FET_SHORT);
+
+/* Current (via sense resistor) */
+static SENSOR_DEVICE_ATTR(curr1_input, S_IRUGO, ltc4260_show_value, NULL,
+			  LTC4260_SENSE);
+
+/* Overcurrent alarm */
+static SENSOR_DEVICE_ATTR(curr1_max_alarm, S_IRUGO, ltc4260_show_bool, NULL,
+			  FAULT_OC);
+
+static struct attribute *ltc4260_attrs[] = {
+	&sensor_dev_attr_in1_input.dev_attr.attr,
+	&sensor_dev_attr_in1_min_alarm.dev_attr.attr,
+	&sensor_dev_attr_in1_max_alarm.dev_attr.attr,
+	&sensor_dev_attr_in2_input.dev_attr.attr,
+	&sensor_dev_attr_in2_alarm.dev_attr.attr,
+
+	&sensor_dev_attr_curr1_input.dev_attr.attr,
+	&sensor_dev_attr_curr1_max_alarm.dev_attr.attr,
+
+	NULL,
+};
+ATTRIBUTE_GROUPS(ltc4260);
+
+static struct regmap_config ltc4260_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = LTC4260_ADIN,
+};
+
+static int ltc4260_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	struct device *dev = &client->dev;
+	struct device *hwmon_dev;
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init_i2c(client, &ltc4260_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(dev, "failed to allocate register map\n");
+		return PTR_ERR(regmap);
+	}
+
+	/* Clear faults */
+	regmap_write(regmap, LTC4260_FAULT, 0x00);
+
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
+							   regmap,
+							   ltc4260_groups);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
+}
+
+static const struct i2c_device_id ltc4260_id[] = {
+	{"ltc4260", 0},
+	{ }
+};
+
+MODULE_DEVICE_TABLE(i2c, ltc4260_id);
+
+static struct i2c_driver ltc4260_driver = {
+	.driver = {
+		   .name = "ltc4260",
+		   },
+	.probe = ltc4260_probe,
+	.id_table = ltc4260_id,
+};
+
+module_i2c_driver(ltc4260_driver);
+
+MODULE_AUTHOR("Guenter Roeck <linux@roeck-us.net>");
+MODULE_DESCRIPTION("LTC4260 driver");
+MODULE_LICENSE("GPL");
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
