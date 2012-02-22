From: Xie Xiaobo <X.Xie@freescale.com>
Date: Wed, 22 Feb 2012 07:55:32 +0000
Subject: [lm-sensors] [PATCH V5] hwmon: Add MCP3021 ADC driver
Message-Id: <1329897332-18383-1-git-send-email-X.Xie@freescale.com>
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
The patch V5 fixed two issues based on Jean's comments.
 Documentation/hwmon/mcp3021 |   22 ++++++
 drivers/hwmon/Kconfig       |   10 +++
 drivers/hwmon/Makefile      |    1 +
 drivers/hwmon/mcp3021.c     |  176 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 209 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/hwmon/mcp3021
 create mode 100644 drivers/hwmon/mcp3021.c

diff --git a/Documentation/hwmon/mcp3021 b/Documentation/hwmon/mcp3021
new file mode 100644
index 0000000..325fd87
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
+The default I2C device address is 0x4d (contact the Microchip factory for
+additional address options).
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 24d584a..b58a947 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -812,6 +812,16 @@ config SENSORS_MAX6650
 	  This driver can also be built as a module.  If so, the module
 	  will be called max6650.
 
+config SENSORS_MCP3021
+	tristate "Microchip MCP3021"
+	depends on I2C && EXPERIMENTAL
+	help
+	  If you say yes here you get support for the MCP3021 chip
+	  that is a A/D converter (ADC) with 10-bit resolution.
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
index 0000000..c874491
--- /dev/null
+++ b/drivers/hwmon/mcp3021.c
@@ -0,0 +1,176 @@
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
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/hwmon.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/err.h>
+#include <linux/device.h>
+
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
+
+/*
+ * Client data (each client gets its own)
+ */
+struct mcp3021_data {
+	struct device *hwmon_dev;
+	u32 vdd;	/* device power supply */
+};
+
+static int mcp3021_read16(struct i2c_client *client)
+{
+	int ret;
+	u16 reg;
+	__be16 buf;
+
+	ret = i2c_master_recv(client, (char *)&buf, 2);
+	if (ret < 0)
+		return ret;
+	if (ret != 2)
+		return -EIO;
+
+	/* The output code of the MCP3021 is transmitted with MSB first. */
+	reg = be16_to_cpu(buf);
+
+	/*
+	 * The ten-bit output code is composed of the lower 4-bit of the
+	 * first byte and the upper 6-bit of the second byte.
+	 */
+	reg = (reg >> MCP3021_SAR_SHIFT) & MCP3021_SAR_MASK;
+
+	return reg;
+}
+
+static inline u16 volts_from_reg(u16 vdd, u16 val)
+{
+	if (val = 0)
+		return 0;
+
+	val = val * MCP3021_OUTPUT_SCALE - MCP3021_OUTPUT_SCALE / 2;
+
+	return val * DIV_ROUND_CLOSEST(vdd,
+			(1 << MCP3021_OUTPUT_RES) * MCP3021_OUTPUT_SCALE);
+}
+
+static ssize_t show_in_input(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct mcp3021_data *data = i2c_get_clientdata(client);
+	int reg, in_input;
+
+	reg = mcp3021_read16(client);
+
+	if (reg < 0) {
+		printk(KERN_ERR "%s encountered error %d\n", __func__, reg);
+		return reg;
+	}
+
+	in_input = volts_from_reg(data->vdd, reg);
+	return sprintf(buf, "%d\n", in_input);
+}
+
+static DEVICE_ATTR(in0_input, S_IRUGO, show_in_input, NULL);
+
+static struct attribute *mcp3021_attribute = &dev_attr_in0_input.attr;
+
+static int mcp3021_probe(struct i2c_client *client,
+				const struct i2c_device_id *id)
+{
+	int err;
+	struct mcp3021_data *data = NULL;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
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
+		if (data->vdd > MCP3021_VDD_MAX ||
+				data->vdd < MCP3021_VDD_MIN) {
+			err = -EINVAL;
+			goto exit_free;
+		}
+	} else
+		data->vdd = MCP3021_VDD_REF;
+
+	err = sysfs_create_file(&client->dev.kobj, mcp3021_attribute);
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
+	sysfs_remove_file(&client->dev.kobj, mcp3021_attribute);
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
+	sysfs_remove_file(&client->dev.kobj, mcp3021_attribute);
+	kfree(data);
+
+	return 0;
+}
+
+static const struct i2c_device_id mcp3021_id[] = {
+	{ "mcp3021", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, mcp3021_id);
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
+module_i2c_driver(mcp3021_driver);
+
+MODULE_AUTHOR("Mingkai Hu <Mingkai.hu@freescale.com>");
+MODULE_DESCRIPTION("Microchip MCP3021 driver");
+MODULE_LICENSE("GPL");
-- 
1.7.5.1



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
