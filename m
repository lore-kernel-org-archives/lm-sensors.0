From: Xie Xiaobo <X.Xie@freescale.com>
Date: Sun, 05 Feb 2012 12:33:38 +0000
Subject: [lm-sensors] [PATCH V2] hwmon: Add MCP3021 hardware monitoring driver
Message-Id: <1328445218-17226-1-git-send-email-X.Xie@freescale.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add I2C driver for MCP3021 that is an ADC chip from Microchip.
The MCP3021 is a successive approximation A/D converter (ADC)
with 10-bit resolution.
The driver export the value of Vin to sysfs, the voltage unit is
mV. Through the sysfs interface, lm-sensors tool can also display
Vin voltage.

Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
Signed-off-by: Xie Xiaobo <X.Xie@freescale.com>
---
---
 Documentation/hwmon/mcp3021 |   22 +++++
 drivers/hwmon/Kconfig       |   11 +++
 drivers/hwmon/Makefile      |    1 +
 drivers/hwmon/mcp3021.c     |  201 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 235 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/hwmon/mcp3021
 create mode 100644 drivers/hwmon/mcp3021.c

diff --git a/Documentation/hwmon/mcp3021 b/Documentation/hwmon/mcp3021
new file mode 100644
index 0000000..4a182fb
--- /dev/null
+++ b/Documentation/hwmon/mcp3021
@@ -0,0 +1,22 @@
+Kernel driver MCP3021
+===========
+
+Supported chips:
+  * Microchip Technology MCP3021
+    Prefix: 'mcp3021'
+    Datasheet: http://ww1.microchip.com/downloads/en/DeviceDoc/21805a.pdf
+
+Author: Mingkai Hu
+
+Description
+-----------
+
+This driver implements support for the Microchip Technology MCP3021 chip.
+
+The Microchip Technology Inc. MCP3021 is a successive approximation A/D
+converter (ADC) with 10-bit resolution.
+This device provides one single-ended input with very low power consumption.
+Communication to the MCP3021 is performed using a 2-wire I2C compatible
+interface. Standard (100 kHz) and Fast (400 kHz) I2C modes are available.
+The default I2C device address is 0x4d(contact the Microchip factory for
+additional address bit options).
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 91be41f..60b9d14 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -811,6 +811,17 @@ config SENSORS_MAX6650
 	  This driver can also be built as a module.  If so, the module
 	  will be called max6650.
 
+config SENSORS_MCP3021
+	tristate "Microchip MCP3021"
+	depends on I2C && EXPERIMENTAL
+	default n
+	help
+	  If you say yes here you get support for the hardware
+	  monitoring functionality of the MCP3021 chip.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called mcp3021.
+
 config SENSORS_NTC_THERMISTOR
 	tristate "NTC thermistor support"
 	depends on EXPERIMENTAL
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 8251ce8..6d3f11f 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -95,6 +95,7 @@ obj-$(CONFIG_SENSORS_MAX6639)	+= max6639.o
 obj-$(CONFIG_SENSORS_MAX6642)	+= max6642.o
 obj-$(CONFIG_SENSORS_MAX6650)	+= max6650.o
 obj-$(CONFIG_SENSORS_MC13783_ADC)+= mc13783-adc.o
+obj-$(CONFIG_SENSORS_MCP3021)	+= mcp3021.o
 obj-$(CONFIG_SENSORS_NTC_THERMISTOR)	+= ntc_thermistor.o
 obj-$(CONFIG_SENSORS_PC87360)	+= pc87360.o
 obj-$(CONFIG_SENSORS_PC87427)	+= pc87427.o
diff --git a/drivers/hwmon/mcp3021.c b/drivers/hwmon/mcp3021.c
new file mode 100644
index 0000000..9aac929
--- /dev/null
+++ b/drivers/hwmon/mcp3021.c
@@ -0,0 +1,201 @@
+/*
+ * mcp3021.c - driver for the Microchip MCP3021 chip
+ *
+ * Copyright (C) 2008-2009, 2012 Freescale Semiconductor, Inc.
+ * Author: Mingkai Hu <Mingkai.hu@freescale.com>
+ *
+ * This driver export the value of analog input voltage to sysfs, the
+ * voltage unit is mV. Through the sysfs interface, lm-sensors tool
+ * can also display the input voltage.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/jiffies.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/err.h>
+#include <linux/mutex.h>
+#include <linux/device.h>
+
+/*
+ * MCP3021 macros
+ */
+/* Vdd info */
+#define MCP3021_VDD_MAX		5500
+#define MCP3021_VDD_MIN		2700
+#define MCP3021_VDD_REF		3300
+
+/* output format */
+#define MCP3021_SAR_SHIFT	2
+#define MCP3021_SAR_MASK	0x3ff
+
+#define MCP3021_OUTPUT_RES	10	/* 10-bit resolution */
+#define MCP3021_OUTPUT_SCALE	4
+#define MCP3021_OUTPUT_MAX_VAL	((1 << MCP3021_OUTPUT_RES) - 1)
+
+/*
+ * Client data (each client gets its own)
+ */
+struct mcp3021_data {
+	struct device *hwmon_dev;
+	u32 vdd;	/* device power supply */
+};
+
+/*
+ * Driver data (common to all clients)
+ */
+static u16 mcp3021_read16(struct i2c_client *client)
+{
+	int ret;
+	u16 reg;
+	uint8_t buf[2];
+
+	ret = i2c_master_recv(client, buf, 2);
+	if (ret < 0)
+		return ret;
+	if (ret != 2)
+		return -ENXIO;
+
+	/* The output code of the MCP3021 is transmitted with MSB first. */
+	reg = (buf[0] << 8) | buf[1];
+
+	/* The ten-bit output code is composed of the lower 4-bit of the
+	 * first byte and the upper 6-bit of the second byte.
+	 */
+	reg = (reg >> MCP3021_SAR_SHIFT) & MCP3021_SAR_MASK;
+
+	return reg;
+}
+
+static inline u16 volts_from_reg(u16 vdd, u16 val)
+{
+	val = val * MCP3021_OUTPUT_SCALE;
+
+	if (val = 0)
+		return 0;
+	else
+		val -=  MCP3021_OUTPUT_SCALE / 2;
+
+	return  val * vdd / ((1 << MCP3021_OUTPUT_RES)
+			* MCP3021_OUTPUT_SCALE);
+}
+
+static ssize_t show_in_input(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct mcp3021_data *data = i2c_get_clientdata(client);
+	u16 reg, in_input;
+
+	reg = mcp3021_read16(client);
+	if (reg >= 0)
+		in_input = volts_from_reg(data->vdd, reg);
+	else
+		in_input = 0;
+	return sprintf(buf, "%d\n", in_input);
+}
+
+static DEVICE_ATTR(in0_input, S_IRUGO, show_in_input, NULL);
+
+static struct attribute *mcp3021_attributes[] = {
+	&dev_attr_in0_input.attr,
+	NULL
+};
+
+static const struct attribute_group mcp3021_group = {
+	.attrs = mcp3021_attributes,
+};
+
+static int mcp3021_probe(struct i2c_client *client,
+				const struct i2c_device_id *id)
+{
+	int err;
+	struct mcp3021_data *data = NULL;
+
+	if (!i2c_check_functionality(client->adapter,
+			I2C_FUNC_SMBUS_WORD_DATA))
+		return -ENODEV;
+
+	data = kzalloc(sizeof(struct mcp3021_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, data);
+
+	if (client->dev.platform_data) {
+		data->vdd = *(u32 *)client->dev.platform_data;
+		if ((data->vdd > MCP3021_VDD_MAX) ||
+				(data->vdd < MCP3021_VDD_MIN))
+			return -EINVAL;
+	} else
+		data->vdd = MCP3021_VDD_REF;
+
+	err = sysfs_create_group(&client->dev.kobj, &mcp3021_group);
+	if (err)
+		goto exit_free;
+
+	data->hwmon_dev = hwmon_device_register(&client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
+		goto exit_remove;
+	}
+
+	return 0;
+
+exit_remove:
+	sysfs_remove_group(&client->dev.kobj, &mcp3021_group);
+exit_free:
+	kfree(data);
+	return err;
+}
+
+static int mcp3021_remove(struct i2c_client *client)
+{
+	struct mcp3021_data *data = i2c_get_clientdata(client);
+
+	hwmon_device_unregister(data->hwmon_dev);
+	sysfs_remove_group(&client->dev.kobj, &mcp3021_group);
+	kfree(data);
+
+	return 0;
+}
+
+static const struct i2c_device_id mcp3021_id[] = {
+	{ "mcp3021", 0 },
+	{ }
+};
+
+static struct i2c_driver mcp3021_driver = {
+	.driver = {
+		.name = "mcp3021",
+	},
+	.probe = mcp3021_probe,
+	.remove = mcp3021_remove,
+	.id_table = mcp3021_id,
+};
+
+static int __init mcp3021_init(void)
+{
+	return i2c_add_driver(&mcp3021_driver);
+}
+
+static void __exit mcp3021_exit(void)
+{
+	i2c_del_driver(&mcp3021_driver);
+}
+
+MODULE_AUTHOR("Mingkai Hu <Mingkai.hu@freescale.com>");
+MODULE_DESCRIPTION("Microchip MCP3021 driver");
+MODULE_LICENSE("GPL");
+
+module_init(mcp3021_init);
+module_exit(mcp3021_exit);
-- 
1.6.4



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
