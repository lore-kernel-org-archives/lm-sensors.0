From: Ira Snyder <iws@ovro.caltech.edu>
Date: Fri, 10 Oct 2008 22:28:31 +0000
Subject: [lm-sensors] [RFC] [PATCH] hwmon: Add LTC4245 driver
Message-Id: <20081010222831.GC8570@ovro.caltech.edu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add Linux support for the Linear Technology LTC4245 Multiple Supply Hot
Swap controller I2C monitoring interface.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---
 Documentation/hwmon/ltc4245 |   63 ++++++
 drivers/hwmon/Kconfig       |   11 +
 drivers/hwmon/Makefile      |    1 +
 drivers/hwmon/ltc4245.c     |  471 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 546 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/hwmon/ltc4245
 create mode 100644 drivers/hwmon/ltc4245.c

As the subject says, this is RFC. I was not sure how to make the alarms
on this chip fit into the alarms framework specified in sysfs-interface,
so I left them out. I'm completely open to suggestions on what to do. I
also exposed a number of registers straight from the chip to userspace
(via sysfs). I don't know what the policy is for this.

Take it easy on me, this is my first hwmon driver :) I'd love
suggestions for improvements, however.

diff --git a/Documentation/hwmon/ltc4245 b/Documentation/hwmon/ltc4245
new file mode 100644
index 0000000..5694ef0
--- /dev/null
+++ b/Documentation/hwmon/ltc4245
@@ -0,0 +1,63 @@
+Kernel driver ltc4245
+==========+
+Supported chips:
+  * Linear Technology LTC4245
+    Prefix: 'ltc4245'
+    Addresses scanned: 0x20-0x3f
+    Datasheet:
+        http://www.linear.com/pc/downloadDocument.do?navId=H0,C1,C1003,C1006,C1140,P19392,D13517
+
+Author: Ira W. Snyder <iws@ovro.caltech.edu>
+
+
+Description
+-----------
+
+The LTC4245 controller allows a board to be safely inserted and removed
+from a live backplane in multiple supply systems such as CompactPCI and
+PCI Express.
+
+
+Sysfs entries
+-------------
+
+The LTC4245 has built-in limits for over and under current warnings. This
+makes it very likely that the reference circuit will be used.
+
+This driver uses the values in the datasheet to change the register values
+into the values specified in the sysfs-interface document.
+
+The fault registers were not exposed because I am not sure how to make them
+fit into the alarm interface defined in the sysfs-interface document.
+
+in0_input	12v input  voltage (mV)
+in1_input	12v sense  voltage (mV)
+in2_input	12v output voltage (mV)
+in3_input	5v  input  voltage (mV)
+in4_input	5v  sense  voltage (mV)
+in5_input	5v  output voltage (mV)
+in6_input	3v  input  voltage (mV)
+in7_input	3v  sense  voltage (mV)
+in8_input	3v  output voltage (mV)
+in9_input	VEEout input  voltage (mV)
+in10_input	VEEout sense  voltage (mV)
+in11_input	VEEout output voltage (mV)
+in12_input	GPIO #0 voltage (mV)
+in13_input	GPIO #1 voltage (mV)
+in14_input	GPIO #2 voltage (mV)
+in15_input	GPIO #3 voltage (mV)
+
+
+The following registers just return the value that is in the corresponding
+register in the chip. Read the datasheet to interpret them.
+
+status		Status register
+alert		Alert register
+control		Control register
+on		On register (enable/disable supplies)
+fault1		Overcurrent and Undervoltage faults
+fault2		Power Bad and other misc faults
+gpio		GPIO control/status register
+adcadr		ADC address register (for non free-running mode)
+
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index d402e8d..91bec8a 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -836,6 +836,17 @@ config SENSORS_APPLESMC
 	  Say Y here if you have an applicable laptop and want to experience
 	  the awesome power of applesmc.
 
+config SENSORS_LTC4245
+	tristate "Linear Technology LTC4245"
+	depends on I2C && EXPERIMENTAL
+	default n
+	help
+	  If you say yes here you get support for Linear Technology LTC4245
+	  Multiple Supply Hot Swap Controller I2C interface.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called ltc4245.
+
 config HWMON_DEBUG_CHIP
 	bool "Hardware Monitoring Chip debugging messages"
 	default n
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 950134a..0ed56ac 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -59,6 +59,7 @@ obj-$(CONFIG_SENSORS_LM87)	+= lm87.o
 obj-$(CONFIG_SENSORS_LM90)	+= lm90.o
 obj-$(CONFIG_SENSORS_LM92)	+= lm92.o
 obj-$(CONFIG_SENSORS_LM93)	+= lm93.o
+obj-$(CONFIG_SENSORS_LTC4245)	+= ltc4245.o
 obj-$(CONFIG_SENSORS_MAX1619)	+= max1619.o
 obj-$(CONFIG_SENSORS_MAX6650)	+= max6650.o
 obj-$(CONFIG_SENSORS_PC87360)	+= pc87360.o
diff --git a/drivers/hwmon/ltc4245.c b/drivers/hwmon/ltc4245.c
new file mode 100644
index 0000000..0669e17
--- /dev/null
+++ b/drivers/hwmon/ltc4245.c
@@ -0,0 +1,471 @@
+/*
+ * Driver for Linear Technology LTC4245 I2C Multiple Supply Hot Swap Controller
+ *
+ * Copyright (C) 2008 Ira W. Snyder <iws@ovro.caltech.edu>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This driver is based on the ds1621 and ina209 drivers.
+ *
+ * Datasheet:
+ * http://www.linear.com/pc/downloadDocument.do?navId=H0,C1,C1003,C1006,C1140,P19392,D13517
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+
+/* Addresses to probe */
+static unsigned short normal_i2c[] = {
+	0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27,
+	0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d, 0x2e, 0x2f,
+	0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37,
+	0x38, 0x39, 0x3a, 0x3b, 0x3c, 0x3d, 0x3e, 0x3f,
+	I2C_CLIENT_END};
+
+/* Insmod parameters */
+I2C_CLIENT_INSMOD_1(ltc4245);
+
+/* Here are names of the chip's registers (a.k.a. commands) */
+enum ltc4245_cmd
+{
+	LTC4245_STATUS			= 0x00, /* readonly */
+	LTC4245_ALERT			= 0x01,
+	LTC4245_CONTROL			= 0x02,
+	LTC4245_ON			= 0x03,
+	LTC4245_FAULT1			= 0x04,
+	LTC4245_FAULT2			= 0x05,
+	LTC4245_GPIO			= 0x06,
+	LTC4245_ADCADR			= 0x07,
+
+	LTC4245_12VIN			= 0x10,
+	LTC4245_12VSENSE		= 0x11,
+	LTC4245_12VOUT			= 0x12,
+	LTC4245_5VIN			= 0x13,
+	LTC4245_5VSENSE			= 0x14,
+	LTC4245_5VOUT			= 0x15,
+	LTC4245_3VIN			= 0x16,
+	LTC4245_3VSENSE			= 0x17,
+	LTC4245_3VOUT			= 0x18,
+	LTC4245_VEEIN			= 0x19,
+	LTC4245_VEESENSE		= 0x1a,
+	LTC4245_VEEOUT			= 0x1b,
+	LTC4245_GPIOADC0		= 0x1c,
+	LTC4245_GPIOADC1		= 0x1d,
+	LTC4245_GPIOADC2		= 0x1e,
+	LTC4245_GPIOADC3		= 0x1f,
+};
+
+struct ltc4245_data {
+	struct device *hwmon_dev;
+
+	struct mutex update_lock;
+	bool valid;
+	unsigned long last_updated; /* in jiffies */
+
+	/* Control registers */
+	u8 cregs[0x08];
+
+	/* Voltage registers */
+	u8 vregs[0x10];
+};
+
+/* All registers are byte-sized (8 bit) */
+static s32 ltc4245_read_reg(struct i2c_client *client, u8 reg)
+{
+	return i2c_smbus_read_byte_data(client, reg);
+}
+
+static s32 ltc4245_write_reg(struct i2c_client *client, u8 reg, u8 val)
+{
+	return i2c_smbus_write_byte_data(client, reg, val);
+}
+
+static struct ltc4245_data *ltc4245_update_device(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct ltc4245_data *data = i2c_get_clientdata(client);
+	int i;
+
+	mutex_lock(&data->update_lock);
+
+	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
+
+		dev_dbg(&client->dev, "Starting ltc4245 update\n");
+
+		/* Read control registers -- 0x00 to 0x07 */
+		for (i=0; i<ARRAY_SIZE(data->cregs); i++) {
+			data->cregs[i] = ltc4245_read_reg(client, i);
+		}
+
+		/* Read voltage registers -- 0x10 to 0x1f */
+		for (i=0; i<ARRAY_SIZE(data->vregs); i++) {
+			data->vregs[i] = ltc4245_read_reg(client, i+0x10);
+		}
+
+		data->last_updated = jiffies;
+		data->valid = 1;
+	}
+
+	mutex_unlock(&data->update_lock);
+
+	return data;
+}
+
+static ssize_t ltc4245_show_voltage(struct device *dev,
+				    struct device_attribute *da,
+				    char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct ltc4245_data *data = ltc4245_update_device(dev);
+	const s32 val = data->vregs[attr->index - 0x10];
+	const u8 regval = val;
+
+	if (unlikely(val < 0)) {
+		dev_dbg(dev, "failed to read register 0x%2.2x\n", attr->index);
+		memset(buf, 0, PAGE_SIZE); /* user should not see old data */
+		return 0;
+	}
+
+	switch (attr->index) {
+	case LTC4245_12VIN:
+	case LTC4245_12VOUT:
+		return snprintf(buf, PAGE_SIZE, "%u\n", regval * 55);
+	case LTC4245_12VSENSE:
+		return snprintf(buf, PAGE_SIZE, "%u\n", regval * 250 / 1000);
+	case LTC4245_5VIN:
+	case LTC4245_5VOUT:
+		return snprintf(buf, PAGE_SIZE, "%u\n", regval * 22);
+	case LTC4245_5VSENSE:
+		return snprintf(buf, PAGE_SIZE, "%u\n", regval * 125 / 1000);
+	case LTC4245_3VIN:
+	case LTC4245_3VOUT:
+		return snprintf(buf, PAGE_SIZE, "%u\n", regval * 15);
+	case LTC4245_3VSENSE:
+		return snprintf(buf, PAGE_SIZE, "%u\n", regval * 125 / 1000);
+	case LTC4245_VEEIN:
+	case LTC4245_VEEOUT:
+		return snprintf(buf, PAGE_SIZE, "%s%u\n",
+				(regval * 55) = 0 ? "" : "-", regval * 55);
+	case LTC4245_VEESENSE:
+		return snprintf(buf, PAGE_SIZE, "%u\n", regval * 250 / 1000);
+	case LTC4245_GPIOADC0:
+	case LTC4245_GPIOADC1:
+	case LTC4245_GPIOADC2:
+	case LTC4245_GPIOADC3:
+		return snprintf(buf, PAGE_SIZE, "%u\n", regval * 10);
+	}
+
+	/* If we get here, the developer messed up :) */
+	WARN_ON_ONCE(1);
+	return 0;
+}
+
+static ssize_t ltc4245_show(struct device *dev,
+			   struct device_attribute *da,
+			   char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct ltc4245_data *data = ltc4245_update_device(dev);
+	const s32 val = data->cregs[attr->index];
+
+	if (val < 0) {
+		dev_dbg(dev, "failed to read register 0x%2.2x\n", attr->index);
+		memset(buf, 0, PAGE_SIZE); /* user should not see old data */
+		return 0;
+	}
+
+	return snprintf(buf, PAGE_SIZE, "0x%x\n", val);
+}
+
+static ssize_t ltc4245_store(struct device *dev,
+			    struct device_attribute *da,
+			    const char *buf,
+			    size_t count)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct ltc4245_data *data = ltc4245_update_device(dev);
+	unsigned long val = simple_strtoul(buf, NULL, 0);
+
+	mutex_lock(&data->update_lock);
+	data->cregs[attr->index] = val;
+	ltc4245_write_reg(client, attr->index, val);
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+/* These macros are used below in constructing device attribute objects
+ * for use with sysfs_create_group() to make a sysfs device file
+ * for each register.
+ */
+#define LTC4245_ENTRY_RO(name, ltc4245_cmd_idx) \
+	static SENSOR_DEVICE_ATTR(name, S_IRUGO, \
+	ltc4245_show, NULL, ltc4245_cmd_idx)
+
+#define LTC4245_ENTRY_RW(name, ltc4245_cmd_idx) \
+	static SENSOR_DEVICE_ATTR(name, S_IRUGO | S_IWUSR, \
+	ltc4245_show, ltc4245_store, ltc4245_cmd_idx)
+
+#define LTC4245_VOLTAGE_RO(name, ltc4245_cmd_idx) \
+	static SENSOR_DEVICE_ATTR(name, S_IRUGO, \
+	ltc4245_show_voltage, NULL, ltc4245_cmd_idx)
+
+/* Construct a sensor_device_attribute structure for each register */
+LTC4245_ENTRY_RO(status,		LTC4245_STATUS);
+LTC4245_ENTRY_RW(alert,			LTC4245_ALERT);
+LTC4245_ENTRY_RW(control,		LTC4245_CONTROL);
+LTC4245_ENTRY_RW(on,			LTC4245_ON);
+LTC4245_ENTRY_RW(fault1,		LTC4245_FAULT1);
+LTC4245_ENTRY_RW(fault2,		LTC4245_FAULT2);
+LTC4245_ENTRY_RW(gpio,			LTC4245_GPIO);
+LTC4245_ENTRY_RW(adcadr,		LTC4245_ADCADR);
+
+LTC4245_VOLTAGE_RO(in0_input,		LTC4245_12VIN);
+LTC4245_VOLTAGE_RO(in1_input,		LTC4245_12VSENSE);
+LTC4245_VOLTAGE_RO(in2_input,		LTC4245_12VOUT);
+LTC4245_VOLTAGE_RO(in3_input,		LTC4245_5VIN);
+LTC4245_VOLTAGE_RO(in4_input,		LTC4245_5VSENSE);
+LTC4245_VOLTAGE_RO(in5_input,		LTC4245_5VOUT);
+LTC4245_VOLTAGE_RO(in6_input,		LTC4245_3VIN);
+LTC4245_VOLTAGE_RO(in7_input,		LTC4245_3VSENSE);
+LTC4245_VOLTAGE_RO(in8_input,		LTC4245_3VOUT);
+LTC4245_VOLTAGE_RO(in9_input,		LTC4245_VEEIN);
+LTC4245_VOLTAGE_RO(in10_input,		LTC4245_VEESENSE);
+LTC4245_VOLTAGE_RO(in11_input,		LTC4245_VEEOUT);
+LTC4245_VOLTAGE_RO(in12_input,		LTC4245_GPIOADC0);
+LTC4245_VOLTAGE_RO(in13_input,		LTC4245_GPIOADC1);
+LTC4245_VOLTAGE_RO(in14_input,		LTC4245_GPIOADC2);
+LTC4245_VOLTAGE_RO(in15_input,		LTC4245_GPIOADC3);
+
+/* Finally, construct an array of pointers to members of the above objects,
+ * as required for sysfs_create_group()
+ */
+static struct attribute *ltc4245_attributes[] = {
+	&sensor_dev_attr_status.dev_attr.attr,
+	&sensor_dev_attr_alert.dev_attr.attr,
+	&sensor_dev_attr_control.dev_attr.attr,
+	&sensor_dev_attr_on.dev_attr.attr,
+	&sensor_dev_attr_fault1.dev_attr.attr,
+	&sensor_dev_attr_fault2.dev_attr.attr,
+	&sensor_dev_attr_gpio.dev_attr.attr,
+	&sensor_dev_attr_adcadr.dev_attr.attr,
+
+	&sensor_dev_attr_in0_input.dev_attr.attr,
+	&sensor_dev_attr_in1_input.dev_attr.attr,
+	&sensor_dev_attr_in2_input.dev_attr.attr,
+	&sensor_dev_attr_in3_input.dev_attr.attr,
+	&sensor_dev_attr_in4_input.dev_attr.attr,
+	&sensor_dev_attr_in5_input.dev_attr.attr,
+	&sensor_dev_attr_in6_input.dev_attr.attr,
+	&sensor_dev_attr_in7_input.dev_attr.attr,
+	&sensor_dev_attr_in8_input.dev_attr.attr,
+	&sensor_dev_attr_in9_input.dev_attr.attr,
+	&sensor_dev_attr_in10_input.dev_attr.attr,
+	&sensor_dev_attr_in11_input.dev_attr.attr,
+	&sensor_dev_attr_in12_input.dev_attr.attr,
+	&sensor_dev_attr_in13_input.dev_attr.attr,
+	&sensor_dev_attr_in14_input.dev_attr.attr,
+	&sensor_dev_attr_in15_input.dev_attr.attr,
+	NULL,
+};
+
+static struct attribute_group ltc4245_group = {
+	.attrs = ltc4245_attributes,
+};
+
+static int ltc4245_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	struct ltc4245_data *data;
+	int ret;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+
+	if (!data) {
+		ret = -ENOMEM;
+		goto out_kzalloc;
+	}
+
+	i2c_set_clientdata(client, data);
+	mutex_init(&data->update_lock);
+
+	/* Initialize the LTC4245 chip */
+	/* TODO */
+
+	/* Register sysfs hooks */
+	if ((ret = sysfs_create_group(&client->dev.kobj, &ltc4245_group)))
+		goto out_sysfs_create_group;
+
+	data->hwmon_dev = hwmon_device_register(&client->dev);
+
+	if (IS_ERR(data->hwmon_dev)) {
+		ret = PTR_ERR(data->hwmon_dev);
+		goto out_hwmon_device_register;
+	}
+
+	return 0;
+
+out_hwmon_device_register:
+	sysfs_remove_group(&client->dev.kobj, &ltc4245_group);
+out_sysfs_create_group:
+	kfree(data);
+out_kzalloc:
+	return ret;
+}
+
+static int ltc4245_remove(struct i2c_client *client)
+{
+	struct ltc4245_data *data = i2c_get_clientdata(client);
+
+	hwmon_device_unregister(data->hwmon_dev);
+	sysfs_remove_group(&client->dev.kobj, &ltc4245_group);
+
+	kfree(data);
+
+	return 0;
+}
+
+/* Check that some bits in a control register appear at all possible
+ * locations without changing value
+ *
+ * @client: the i2c client to use
+ * @reg: the register to read
+ * @bits: the bits to check (0xff checks all bits,
+ *                           0x03 checks only the last two bits)
+ *
+ * return -ENODEV if the register value doesn't stay constant at all
+ * possible addresses
+ *
+ * return 0 for success
+ */
+static int ltc4245_check_control_reg(struct i2c_client *client, u8 reg, u8 bits)
+{
+	int i;
+	s32 v, voff1, voff2;
+
+	v = ltc4245_read_reg(client, reg) & bits;
+
+	if (v < 0)
+		return -ENODEV;
+
+	for (i=0x00; i<0xff; i+=0x20) {
+		voff1 = ltc4245_read_reg(client, reg + i) & bits;
+		voff2 = ltc4245_read_reg(client, reg + i + 0x08) & bits;
+
+		if (voff1 < 0 || voff2 < 0 || v != voff1 || v != voff2)
+			return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int ltc4245_detect(struct i2c_client *client,
+			  int kind,
+			  struct i2c_board_info *info)
+{
+	struct i2c_adapter *adapter = client->adapter;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		return -ENODEV;
+
+	if (kind < 0) {		/* probed detection - check the chip type */
+		s32 v;		/* 8 bits from the chip, or -ERRNO */
+
+		/* Chip registers 0x00-0x07 are control registers
+		 * Chip registers 0x10-0x1f are data registers
+		 *
+		 * Address bits b7-b5 are ignored. This makes the chip "repeat"
+		 * in steps of 0x20. Any control registers should appear with
+		 * the same values across all duplicated addresses.
+		 *
+		 * Register 0x02 bit b2 is reserved, expect 0
+		 * Register 0x07 bits b7 to b4 are reserved, expect 0
+		 *
+		 * Registers 0x01, 0x02 are control registers and should not
+		 * change on their own.
+		 *
+		 * Register 0x06 bits b6 and b7 are control bits, and should
+		 * not change on their own.
+		 *
+		 * Register 0x07 bits b3 to b0 are control bits, and should
+		 * not change on their own.
+		 */
+
+		/* read register 0x02 reserved bit, expect 0 */
+		v = ltc4245_read_reg(client, LTC4245_CONTROL);
+		if (v < 0 || (v & 0x04) != 0)
+			return -ENODEV;
+
+		/* read register 0x07 reserved bits, expect 0 */
+		v = ltc4245_read_reg(client, LTC4245_ADCADR);
+		if (v < 0 || (v & 0xf0) != 0)
+			return -ENODEV;
+
+		/* check that the alert register appears at all locations */
+		if (ltc4245_check_control_reg(client, LTC4245_ALERT, 0xff))
+			return -ENODEV;
+
+		/* check that the control register appears at all locations */
+		if (ltc4245_check_control_reg(client, LTC4245_CONTROL, 0xff))
+			return -ENODEV;
+
+		/* check that register 0x06 bits b6 and b7 stay constant */
+		if (ltc4245_check_control_reg(client, LTC4245_GPIO, 0xc0))
+			return -ENODEV;
+
+		/* check that register 0x07 bits b3-b0 stay constant */
+		if (ltc4245_check_control_reg(client, LTC4245_ADCADR, 0x0f))
+			return -ENODEV;
+	}
+
+	strlcpy(info->type, "ltc4245", I2C_NAME_SIZE);
+	pr_info("ltc4245: %s on i2c-%u address 0x%02x\n",
+			kind<0 ? "probed" : "forced",
+			adapter->nr, client->addr);
+
+	return 0;
+}
+
+static const struct i2c_device_id ltc4245_id[] = {
+	{ "ltc4245", ltc4245 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ltc4245_id);
+
+/* This is the driver that will be inserted */
+static struct i2c_driver ltc4245_driver = {
+	.class		= I2C_CLASS_HWMON,
+	.driver = {
+		.name	= "ltc4245",
+	},
+	.probe		= ltc4245_probe,
+	.remove		= ltc4245_remove,
+	.id_table	= ltc4245_id,
+	.detect		= ltc4245_detect,
+	.address_data	= &addr_data,
+};
+
+static int __init ltc4245_init(void)
+{
+	return i2c_add_driver(&ltc4245_driver);
+}
+
+static void __exit ltc4245_exit(void)
+{
+	i2c_del_driver(&ltc4245_driver);
+}
+
+MODULE_AUTHOR("Ira W. Snyder <iws@ovro.caltech.edu>");
+MODULE_DESCRIPTION("LTC4245 driver");
+MODULE_LICENSE("GPL");
+
+module_init(ltc4245_init);
+module_exit(ltc4245_exit);
-- 
1.5.4.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
