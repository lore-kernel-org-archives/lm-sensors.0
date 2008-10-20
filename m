From: Ira Snyder <iws@ovro.caltech.edu>
Date: Mon, 20 Oct 2008 16:03:08 +0000
Subject: [lm-sensors] [PATCH] hwmon: Add LTC4245 driver
Message-Id: <20081020160308.GA22915@ovro.caltech.edu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add Linux support for the Linear Technology LTC4245 Multiple Supply Hot
Swap controller I2C monitoring interface.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---

I'm pretty sure this should be the final revision of the driver. Please
go ahead and forward it upstream. :)

I apologize for the late response. I was having some troubles with my
email. They should all be sorted out now.

Thanks for all the help and review!
Ira


Changes v3 -> v4:
  * simplify ltc4245_get_voltage(), removing special casing for -12v
  * power should always be a positive value

Changes v2 -> v3:
  * fix units (power?_input in uW, curr?_input in mA)
  * combine all alarm functions
  * rename power[1-4]_alarm to in[5-8]_min_alarm, per suggestions

Changes v1 -> v2:
  * fixed checkpatch warnings
  * removed raw register access, per suggestions
  * changed sysfs interface, per suggestions (current, power, alarms)


 Documentation/hwmon/ltc4245 |   69 +++++
 drivers/hwmon/Kconfig       |   11 +
 drivers/hwmon/Makefile      |    1 +
 drivers/hwmon/ltc4245.c     |  574 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 655 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/hwmon/ltc4245
 create mode 100644 drivers/hwmon/ltc4245.c

diff --git a/Documentation/hwmon/ltc4245 b/Documentation/hwmon/ltc4245
new file mode 100644
index 0000000..d2f411a
--- /dev/null
+++ b/Documentation/hwmon/ltc4245
@@ -0,0 +1,69 @@
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
+into the values specified in the sysfs-interface document. The current readings
+rely on the sense resistors listed in Table 2: "Sense Resistor Values".
+
+in1_input		12v input voltage (mV)
+in2_input		5v  input voltage (mV)
+in3_input		3v  input voltage (mV)
+in4_input		Vee (-12v) input voltage (mV)
+
+in1_min_alarm		12v input undervoltage alarm
+in2_min_alarm		5v  input undervoltage alarm
+in3_min_alarm		3v  input undervoltage alarm
+in4_min_alarm		Vee (-12v) input undervoltage alarm
+
+curr1_input		12v current (mA)
+curr2_input		5v  current (mA)
+curr3_input		3v  current (mA)
+curr4_input		Vee (-12v) current (mA)
+
+curr1_max_alarm		12v overcurrent alarm
+curr2_max_alarm		5v  overcurrent alarm
+curr3_max_alarm		3v  overcurrent alarm
+curr4_max_alarm		Vee (-12v) overcurrent alarm
+
+in5_input		12v output voltage (mV)
+in6_input		5v  output voltage (mV)
+in7_input		3v  output voltage (mV)
+in8_input		Vee (-12v) output voltage (mV)
+
+in5_min_alarm		12v output undervoltage alarm
+in6_min_alarm		5v  output undervoltage alarm
+in7_min_alarm		3v  output undervoltage alarm
+in8_min_alarm		Vee (-12v) output undervoltage alarm
+
+in9_input		GPIO #1 voltage data
+in10_input		GPIO #2 voltage data
+in11_input		GPIO #3 voltage data
+
+power1_input		12v power usage (mW)
+power2_input		5v  power usage (mW)
+power3_input		3v  power usage (mW)
+power4_input		Vee (-12v) power usage (mW)
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
index 0000000..5d0528b
--- /dev/null
+++ b/drivers/hwmon/ltc4245.c
@@ -0,0 +1,574 @@
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
+enum ltc4245_cmd {
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
+	LTC4245_GPIOADC1		= 0x1c,
+	LTC4245_GPIOADC2		= 0x1d,
+	LTC4245_GPIOADC3		= 0x1e,
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
+	u8 vregs[0x0f];
+};
+
+/* All registers are byte-sized (8 bit) */
+static s32 ltc4245_read_reg(struct i2c_client *client, u8 reg)
+{
+	return i2c_smbus_read_byte_data(client, reg);
+}
+
+#if 0
+static s32 ltc4245_write_reg(struct i2c_client *client, u8 reg, u8 val)
+{
+	return i2c_smbus_write_byte_data(client, reg, val);
+}
+#endif
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
+		for (i = 0; i < ARRAY_SIZE(data->cregs); i++)
+			data->cregs[i] = ltc4245_read_reg(client, i);
+
+		/* Read voltage registers -- 0x10 to 0x1f */
+		for (i = 0; i < ARRAY_SIZE(data->vregs); i++)
+			data->vregs[i] = ltc4245_read_reg(client, i+0x10);
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
+/* Return the voltage from the given register in millivolts */
+static int ltc4245_get_voltage(struct device *dev, u8 reg)
+{
+	struct ltc4245_data *data = ltc4245_update_device(dev);
+	const s32 val = data->vregs[reg - 0x10];
+	const u8 regval = val;
+	u32 voltage = 0;
+
+	if (unlikely(val < 0))
+		return 0;
+
+	switch (reg) {
+	case LTC4245_12VIN:
+	case LTC4245_12VOUT:
+		voltage = regval * 55;
+		break;
+	case LTC4245_5VIN:
+	case LTC4245_5VOUT:
+		voltage = regval * 22;
+		break;
+	case LTC4245_3VIN:
+	case LTC4245_3VOUT:
+		voltage = regval * 15;
+		break;
+	case LTC4245_VEEIN:
+	case LTC4245_VEEOUT:
+		voltage = regval * -55;
+		break;
+	case LTC4245_GPIOADC1:
+	case LTC4245_GPIOADC2:
+	case LTC4245_GPIOADC3:
+		voltage = regval * 10;
+		break;
+	default:
+		/* If we get here, the developer messed up */
+		WARN_ON_ONCE(1);
+		break;
+	}
+
+	return voltage;
+}
+
+/* Return the current in the given sense register in milliAmperes */
+static u32 ltc4245_get_current(struct device *dev, u8 reg)
+{
+	struct ltc4245_data *data = ltc4245_update_device(dev);
+	const s32 val = data->vregs[reg - 0x10];
+	const u8 regval = val;
+	u32 voltage;
+	u32 current;
+
+	if (unlikely(val) < 0)
+		return 0;
+
+	/* The strange looking conversions that follow are fixed-point
+	 * math, since we cannot do floating point in the kernel.
+	 *
+	 * Step 1: convert sense register to microVolts
+	 * Step 2: convert voltage to milliAmperes
+	 *
+	 * If you play around with the V=IR equation, you come up with
+	 * the following: X uV / Y mOhm = Z mA
+	 *
+	 * With the resistors that are fractions of a milliOhm, we multiply
+	 * the voltage and resistance by 10, to shift the decimal point.
+	 * Now we can use the normal division operator again.
+	 */
+
+	switch (reg) {
+	case LTC4245_12VSENSE:
+		voltage = regval * 250; /* voltage in uV */
+		current = voltage / 50; /* sense resistor 50 mOhm */
+		break;
+	case LTC4245_5VSENSE:
+		voltage = regval * 125; /* voltage in uV */
+		current = (voltage * 10) / 35; /* sense resistor 3.5 mOhm */
+		break;
+	case LTC4245_3VSENSE:
+		voltage = regval * 125; /* voltage in uV */
+		current = (voltage * 10) / 25; /* sense resistor 2.5 mOhm */
+		break;
+	case LTC4245_VEESENSE:
+		voltage = regval * 250; /* voltage in uV */
+		current = voltage / 100; /* sense resistor 100 mOhm */
+		break;
+	default:
+		/* If we get here, the developer messed up */
+		WARN_ON_ONCE(1);
+		current = 0;
+		break;
+	}
+
+	return current;
+}
+
+static ssize_t ltc4245_show_voltage(struct device *dev,
+				    struct device_attribute *da,
+				    char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	const u32 voltage = ltc4245_get_voltage(dev, attr->index);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", voltage);
+}
+
+static ssize_t ltc4245_show_current(struct device *dev,
+				    struct device_attribute *da,
+				    char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	const u32 current = ltc4245_get_current(dev, attr->index);
+
+	return snprintf(buf, PAGE_SIZE, "%u\n", current);
+}
+
+static ssize_t ltc4245_show_power(struct device *dev,
+				  struct device_attribute *da,
+				  char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	const u32 current = ltc4245_get_current(dev, attr->index);
+	const u32 output_voltage = ltc4245_get_voltage(dev, attr->index+1);
+
+	/* current in mA * voltage in mV = power in uW */
+	const unsigned int power = abs(output_voltage * current);
+
+	return snprintf(buf, PAGE_SIZE, "%u\n", power);
+}
+
+static ssize_t ltc4245_show_alarm(struct device *dev,
+					  struct device_attribute *da,
+					  char *buf)
+{
+	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(da);
+	struct ltc4245_data *data = ltc4245_update_device(dev);
+	const s32 reg = data->cregs[attr->index];
+	const u32 mask = attr->nr;
+
+	if (unlikely(reg < 0)) {
+		memset(buf, 0, PAGE_SIZE); /* user should not see old data */
+		return 0;
+	}
+
+	return snprintf(buf, PAGE_SIZE, "%u\n", (reg & mask) ? 1 : 0);
+}
+
+/* These macros are used below in constructing device attribute objects
+ * for use with sysfs_create_group() to make a sysfs device file
+ * for each register.
+ */
+
+#define LTC4245_VOLTAGE(name, ltc4245_cmd_idx) \
+	static SENSOR_DEVICE_ATTR(name, S_IRUGO, \
+	ltc4245_show_voltage, NULL, ltc4245_cmd_idx)
+
+#define LTC4245_CURRENT(name, ltc4245_cmd_idx) \
+	static SENSOR_DEVICE_ATTR(name, S_IRUGO, \
+	ltc4245_show_current, NULL, ltc4245_cmd_idx)
+
+#define LTC4245_POWER(name, ltc4245_cmd_idx) \
+	static SENSOR_DEVICE_ATTR(name, S_IRUGO, \
+	ltc4245_show_power, NULL, ltc4245_cmd_idx)
+
+#define LTC4245_ALARM(name, mask, reg) \
+	static SENSOR_DEVICE_ATTR_2(name, S_IRUGO, \
+	ltc4245_show_alarm, NULL, (mask), reg)
+
+/* Construct a sensor_device_attribute structure for each register */
+
+/* Input voltages */
+LTC4245_VOLTAGE(in1_input,			LTC4245_12VIN);
+LTC4245_VOLTAGE(in2_input,			LTC4245_5VIN);
+LTC4245_VOLTAGE(in3_input,			LTC4245_3VIN);
+LTC4245_VOLTAGE(in4_input,			LTC4245_VEEIN);
+
+/* Input undervoltage alarms */
+LTC4245_ALARM(in1_min_alarm,	(1 << 0),	LTC4245_FAULT1);
+LTC4245_ALARM(in2_min_alarm,	(1 << 1),	LTC4245_FAULT1);
+LTC4245_ALARM(in3_min_alarm,	(1 << 2),	LTC4245_FAULT1);
+LTC4245_ALARM(in4_min_alarm,	(1 << 3),	LTC4245_FAULT1);
+
+/* Currents (via sense resistor) */
+LTC4245_CURRENT(curr1_input,			LTC4245_12VSENSE);
+LTC4245_CURRENT(curr2_input,			LTC4245_5VSENSE);
+LTC4245_CURRENT(curr3_input,			LTC4245_3VSENSE);
+LTC4245_CURRENT(curr4_input,			LTC4245_VEESENSE);
+
+/* Overcurrent alarms */
+LTC4245_ALARM(curr1_max_alarm,	(1 << 4),	LTC4245_FAULT1);
+LTC4245_ALARM(curr2_max_alarm,	(1 << 5),	LTC4245_FAULT1);
+LTC4245_ALARM(curr3_max_alarm,	(1 << 6),	LTC4245_FAULT1);
+LTC4245_ALARM(curr4_max_alarm,	(1 << 7),	LTC4245_FAULT1);
+
+/* Output voltages */
+LTC4245_VOLTAGE(in5_input,			LTC4245_12VOUT);
+LTC4245_VOLTAGE(in6_input,			LTC4245_5VOUT);
+LTC4245_VOLTAGE(in7_input,			LTC4245_3VOUT);
+LTC4245_VOLTAGE(in8_input,			LTC4245_VEEOUT);
+
+/* Power Bad alarms */
+LTC4245_ALARM(in5_min_alarm,	(1 << 0),	LTC4245_FAULT2);
+LTC4245_ALARM(in6_min_alarm,	(1 << 1),	LTC4245_FAULT2);
+LTC4245_ALARM(in7_min_alarm,	(1 << 2),	LTC4245_FAULT2);
+LTC4245_ALARM(in8_min_alarm,	(1 << 3),	LTC4245_FAULT2);
+
+/* GPIO voltages */
+LTC4245_VOLTAGE(in9_input,			LTC4245_GPIOADC1);
+LTC4245_VOLTAGE(in10_input,			LTC4245_GPIOADC2);
+LTC4245_VOLTAGE(in11_input,			LTC4245_GPIOADC3);
+
+/* Power Consumption (virtual) */
+LTC4245_POWER(power1_input,			LTC4245_12VSENSE);
+LTC4245_POWER(power2_input,			LTC4245_5VSENSE);
+LTC4245_POWER(power3_input,			LTC4245_3VSENSE);
+LTC4245_POWER(power4_input,			LTC4245_VEESENSE);
+
+/* Finally, construct an array of pointers to members of the above objects,
+ * as required for sysfs_create_group()
+ */
+static struct attribute *ltc4245_attributes[] = {
+	&sensor_dev_attr_in1_input.dev_attr.attr,
+	&sensor_dev_attr_in2_input.dev_attr.attr,
+	&sensor_dev_attr_in3_input.dev_attr.attr,
+	&sensor_dev_attr_in4_input.dev_attr.attr,
+
+	&sensor_dev_attr_in1_min_alarm.dev_attr.attr,
+	&sensor_dev_attr_in2_min_alarm.dev_attr.attr,
+	&sensor_dev_attr_in3_min_alarm.dev_attr.attr,
+	&sensor_dev_attr_in4_min_alarm.dev_attr.attr,
+
+	&sensor_dev_attr_curr1_input.dev_attr.attr,
+	&sensor_dev_attr_curr2_input.dev_attr.attr,
+	&sensor_dev_attr_curr3_input.dev_attr.attr,
+	&sensor_dev_attr_curr4_input.dev_attr.attr,
+
+	&sensor_dev_attr_curr1_max_alarm.dev_attr.attr,
+	&sensor_dev_attr_curr2_max_alarm.dev_attr.attr,
+	&sensor_dev_attr_curr3_max_alarm.dev_attr.attr,
+	&sensor_dev_attr_curr4_max_alarm.dev_attr.attr,
+
+	&sensor_dev_attr_in5_input.dev_attr.attr,
+	&sensor_dev_attr_in6_input.dev_attr.attr,
+	&sensor_dev_attr_in7_input.dev_attr.attr,
+	&sensor_dev_attr_in8_input.dev_attr.attr,
+
+	&sensor_dev_attr_in5_min_alarm.dev_attr.attr,
+	&sensor_dev_attr_in6_min_alarm.dev_attr.attr,
+	&sensor_dev_attr_in7_min_alarm.dev_attr.attr,
+	&sensor_dev_attr_in8_min_alarm.dev_attr.attr,
+
+	&sensor_dev_attr_in9_input.dev_attr.attr,
+	&sensor_dev_attr_in10_input.dev_attr.attr,
+	&sensor_dev_attr_in11_input.dev_attr.attr,
+
+	&sensor_dev_attr_power1_input.dev_attr.attr,
+	&sensor_dev_attr_power2_input.dev_attr.attr,
+	&sensor_dev_attr_power3_input.dev_attr.attr,
+	&sensor_dev_attr_power4_input.dev_attr.attr,
+
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
+	ret = sysfs_create_group(&client->dev.kobj, &ltc4245_group);
+
+	if (ret)
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
+	for (i = 0x00; i < 0xff; i += 0x20) {
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
+			kind < 0 ? "probed" : "forced",
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
