From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Date: Thu, 20 Aug 2009 21:49:25 +0000
Subject: [lm-sensors] [PATCH v2] hwmon: add INA209 driver
Message-Id: <20090820214925.GC16733@ovro.caltech.edu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add Linux support for the TI / Burr-Brown INA209 voltage / current / power
monitor I2C interface.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---

This is my second posting of this driver. It has been significantly changed
since it was first posted. Details below.

v1 -> v2:
* do not use calibration register, use libsensors instead
* add enables for output pins
* increase precision of readings

Since the previous posting of this driver, I have decided to use userspace
(via libsensors) to convert the shunt voltage to get the current and power
readings. This allows us to bypass the on-chip logic which requires special
programming to work properly. The on-chip logic is impossible to program in
a way acceptable by the hwmon community.

I have done two things in this driver which do not follow the accepted
practice set forth in the Documentation/hwmon/sysfs-interface document.

1) shunt voltage readings are provided in microvolt instead of millivolt

This chip has very high precision, which is needed when using very small
sense resistors. I have a number of these chips in use. The smallest sense
resistor I am using is 5.7 milliOhm.

If millivolts are used (per the sysfs-interface document), then much of the
precision provided by the chip is lost. By using microvolts, we keep the
entire precision of the chip, which enables much more accurate current and
power readings. The libsensors package is then used to convert the values
to the units it finds appropriate.

2) output pin enables

This chip has software-programmable limits. When the limits are crossed,
the chip can drive an output pin to notify an external controller to shut
off the power supply.

These output pins cannot be enabled when the driver is inserted. If the
chip is monitoring a power supply which takes a large amount of inrush
current to charge up when first enabled, the limits may cause the power
supply to be disabled at startup. Having the enables allows userspace to
implement a power-on sequence.

I followed the example set forth by the adm1026 driver, which has similar
output pin enables.

 Documentation/hwmon/ina209 |  123 +++++++++
 drivers/hwmon/Kconfig      |   11 +
 drivers/hwmon/Makefile     |    1 +
 drivers/hwmon/ina209.c     |  588 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 723 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/hwmon/ina209
 create mode 100644 drivers/hwmon/ina209.c

diff --git a/Documentation/hwmon/ina209 b/Documentation/hwmon/ina209
new file mode 100644
index 0000000..7ec5a37
--- /dev/null
+++ b/Documentation/hwmon/ina209
@@ -0,0 +1,123 @@
+Kernel driver ina209
+==========+
+Supported chips:
+  * Burr-Brown / Texas Instruments INA209
+    Prefix: 'ina209'
+    Addresses scanned: 0x40-0x4f
+    Datasheet:
+        http://www.ti.com/lit/gpn/ina209
+
+Author: Paul Hays <haysp@magma.net>
+Author: Ira W. Snyder <iws@ovro.caltech.edu>
+
+
+Description
+-----------
+
+The Burr-Brown INA209 monitors voltage and current on the high side
+of a D.C. power supply. It can perform measurements and calculations
+in the background to supply readings at any time. It includes a
+programmable calibration multiplier to scale the displayed current
+and power values.
+
+
+Sysfs entries
+-------------
+
+The INA209 chip is highly configurable both via hardwiring and via
+the I2C bus. See the datasheet for details.
+
+This tries to expose most monitoring features of the hardware via
+sysfs. It does not support every feature of this chip.
+
+
+in0_input		shunt voltage (uV)
+in0_input_highest	shunt voltage historical maximum reading (uV)
+in0_input_lowest	shunt voltage historical minimum reading (uV)
+in0_max			shunt voltage max alarm limit (uV)
+in0_min			shunt voltage min alarm limit (uV)
+in0_crit_max		shunt voltage crit max alarm limit (uV)
+in0_crit_min		shunt voltage crit min alarm limit (uV)
+in0_max_alarm		shunt voltage max alarm limit exceeded
+in0_min_alarm		shunt voltage min alarm limit exceeded
+in0_crit_max_alarm	shunt voltage crit max alarm limit exceeded
+in0_crit_min_alarm	shunt voltage crit min alarm limit exceeded
+in0_crit_enable		shunt voltage crit output pin enable (critical pin)
+
+in1_input		bus voltage (mV)
+in1_input_highest	bus voltage historical maximum reading (mV)
+in1_input_lowest	bus voltage historical minimum reading (mV)
+in1_max			bus voltage max alarm limit (mV)
+in1_min			bus voltage min alarm limit (mV)
+in1_crit_max		bus voltage crit max alarm limit (mV)
+in1_crit_min		bus voltage crit min alarm limit (mV)
+in1_max_alarm		bus voltage max alarm limit exceeded
+in1_min_alarm		bus voltage min alarm limit exceeded
+in1_crit_max_alarm	bus voltage crit max alarm limit exceeded
+in1_crit_min_alarm	bus voltage crit min alarm limit exceeded
+in1_crit_enable		bus voltage crit output pin enable (overlimit pin)
+
+power1_input		power measurement (uW), see notes below
+curr1_input		current measurement (mA), see notes below
+
+
+General Remarks
+---------------
+
+Please note that the values reported for shunt voltage do not conform to the
+Documentation/hwmon/sysfs-interface document. This was done in order to preserve
+the full precision of the INA209 chip. If the values were instead reported in
+millivolts, more than half of the chip's precision would be lost. This error
+carries through to the current and power readings, which rely on the sense
+resistor value.
+
+This requires a "compute" statement in the sensors.conf file, so that libsensors
+can convert the value to the units it expects. The following compute statement
+should be added to your sensors.conf file:
+
+compute in0 (@ / 1000), (@ * 1000)
+
+The power and current registers in this chip require that the calibration
+register is programmed correctly before they are used. The hwmon community has
+not created any way to set the calibration register, and therefore the internal
+logic on the chip is not used for the current and power readings.
+
+This means that certain features of the chip are not exposed to userspace,
+because they do not work. These features are:
+
+power1_input_highest	power historical maximum reading (uW)
+power1_max		power max alarm limit (uW)
+power1_crit		power crit alarm limit (uW)
+power1_alarm		power max alarm limit exceeded
+power1_crit_alarm	power crit alarm limit exceeded
+
+Instead of using the internal logic on the chip to report tho current and power
+usage, the shunt voltage is reported instead. This allows the user to use their
+knowledge of the circuit (specifically, the shunt resistor value) to create an
+appropriate "compute" statement in their sensors.conf file. With the appropriate
+compute statement, libsensors will convert the value to the appropriate units
+automatically.
+
+Please remember that the shunt resistor value is reported in microvolts when
+making these calculations. Example compute statements are provided for an INA209
+with a 10 milliOhm sense resistor:
+
+compute power1 in1_input * curr1_input, in1_input * curr1_input
+compute curr1 (@ / 10), (@ * 10)
+
+
+Output Pins
+-----------
+
+Following the convention used for the adm1026 chip, output pins can be enabled
+using sysfs files. The only two pins supported are the critical and overlimit
+pins. The warning pin is not supported.
+
+The pins cannot be enabled at chip start time, because it is possible that
+userspace will need to control a power-on sequence before the pins are enabled.
+This is especially useful if the user would like to set current limits after
+the supplies are powered on. It is likely that the inrush current will be higher
+than the current limits, however runtime current spikes should not overrun the
+limit.
+
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 2d50166..4f658d3 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1017,6 +1017,17 @@ config SENSORS_APPLESMC
 	  Say Y here if you have an applicable laptop and want to experience
 	  the awesome power of applesmc.
 
+config SENSORS_INA209
+	tristate "TI / Burr Brown INA209"
+	depends on I2C && EXPERIMENTAL
+	default n
+	help
+	  If you say yes here you get support for the TI / Burr Brown INA209
+	  voltage / current / power monitor I2C interface.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called ina209.
+
 config HWMON_DEBUG_CHIP
 	bool "Hardware Monitoring Chip debugging messages"
 	default n
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index b793dce..d55082f 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -51,6 +51,7 @@ obj-$(CONFIG_SENSORS_HDAPS)	+= hdaps.o
 obj-$(CONFIG_SENSORS_I5K_AMB)	+= i5k_amb.o
 obj-$(CONFIG_SENSORS_IBMAEM)	+= ibmaem.o
 obj-$(CONFIG_SENSORS_IBMPEX)	+= ibmpex.o
+obj-$(CONFIG_SENSORS_INA209)	+= ina209.o
 obj-$(CONFIG_SENSORS_IT87)	+= it87.o
 obj-$(CONFIG_SENSORS_K8TEMP)	+= k8temp.o
 obj-$(CONFIG_SENSORS_LIS3LV02D) += lis3lv02d.o hp_accel.o
diff --git a/drivers/hwmon/ina209.c b/drivers/hwmon/ina209.c
new file mode 100644
index 0000000..1c40da2
--- /dev/null
+++ b/drivers/hwmon/ina209.c
@@ -0,0 +1,588 @@
+/*
+ * Driver for the Texas Instruments / Burr Brown INA209
+ * Bidirectional Current/Power Monitor
+ *
+ * Copyright (C) 2008 Paul Hays <haysp@magma.ca>
+ * Copyright (C) 2008-2009 Ira W. Snyder <iws@ovro.caltech.edu>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * Datasheet:
+ * http://www.ti.com/lit/gpn/ina209
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/bug.h>
+#include <linux/i2c.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+
+/*
+ * Addresses to probe. The chip can be hardwired to use any of these
+ * addresses using pins A0 and A1. (E.g. connecting both to the SDA pin
+ * selects address 0x4a).
+ */
+static const unsigned short normal_i2c[] = {
+	0x40, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47,
+	0x48, 0x49, 0x4a, 0x4b, 0x4c, 0x4d, 0x4e, 0x4f,
+	I2C_CLIENT_END};
+
+/* Insmod parameters */
+I2C_CLIENT_INSMOD_1(ina209);
+
+/* Here are names of the chip's registers (a.k.a. commands) */
+enum ina209_reg {
+	INA209_CONFIGURATION		= 0x00,
+	INA209_STATUS			= 0x01,
+	INA209_STATUS_MASK		= 0x02,
+	INA209_SHUNT_V			= 0x03,
+	INA209_BUS_V			= 0x04,
+	INA209_POWER			= 0x05,
+	INA209_BUS_CURRENT		= 0x06,
+	INA209_SHUNT_V_POS_PEAK		= 0x07,
+	INA209_SHUNT_V_NEG_PEAK		= 0x08,
+	INA209_BUS_V_MAX_PEAK		= 0x09,
+	INA209_BUS_V_MIN_PEAK		= 0x0a,
+	INA209_POWER_PEAK		= 0x0b,
+	INA209_SHUNT_V_POS_WARN		= 0x0c,
+	INA209_SHUNT_V_NEG_WARN		= 0x0d,
+	INA209_POWER_WARN		= 0x0e,
+	INA209_BUS_OVER_V_WARN		= 0x0f,
+	INA209_BUS_UNDER_V_WARN		= 0x10,
+	INA209_POWER_OVER_LIMIT		= 0x11,
+	INA209_BUS_OVER_V_OVER_LIMIT	= 0x12,
+	INA209_BUS_UNDER_V_OVER_LIMIT	= 0x13,
+	INA209_CRITICAL_DAC_POS		= 0x14,
+	INA209_CRITICAL_DAC_NEG		= 0x15,
+	INA209_CALIBRATION		= 0x16,
+};
+
+enum ina209_output_pins {
+	INA209_OUTPUT_WARNING		= 0x1,
+	INA209_OUTPUT_OVERLIMIT		= 0x2,
+	INA209_OUTPUT_CRITICAL		= 0x4,
+};
+
+struct ina209_data {
+	struct device *hwmon_dev;
+
+	struct mutex update_lock;
+	bool valid;
+	unsigned long last_updated; /* in jiffies */
+
+	/* All chip registers */
+	u16 regs[0x17];
+};
+
+/*
+ * All registers are word-sized (16 bit)
+ *
+ * INA209 uses a high-byte first convention, which is exactly opposite
+ * to the SMBus standard
+ */
+static s32 ina209_read_reg(struct i2c_client *client, u8 reg)
+{
+	s32 val = i2c_smbus_read_word_data(client, reg);
+
+	if (val < 0)
+		return val;
+
+	return swab16(val);
+}
+
+static s32 ina209_write_reg(struct i2c_client *client, u8 reg, u16 val)
+{
+	return i2c_smbus_write_word_data(client, reg, swab16(val));
+}
+
+static struct ina209_data *ina209_update_device(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct ina209_data *data = i2c_get_clientdata(client);
+	s32 val;
+	int i;
+
+	mutex_lock(&data->update_lock);
+
+	/* This chip updates every 532 usec, but this should be fast enough */
+	if (time_after(jiffies, data->last_updated + HZ / 8) || !data->valid) {
+
+		dev_dbg(&client->dev, "Starting ina209 update\n");
+
+		for (i = 0; i < ARRAY_SIZE(data->regs); i++) {
+			val = ina209_read_reg(client, i);
+			if (val < 0)
+				data->regs[i] = 0;
+			else
+				data->regs[i] = val;
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
+/*
+ * Read a value from a device register and convert it to the
+ * appropriate sysfs units
+ *
+ * NOTE: the shunt values are reported in microvolts so that we do not
+ * NOTE: loose precision. libsensors will need to convert the value
+ */
+static int ina209_from_reg(struct device *dev, u8 reg)
+{
+	struct ina209_data *data = ina209_update_device(dev);
+	const u16 val = data->regs[reg];
+
+	switch (reg) {
+	case INA209_SHUNT_V:
+	case INA209_SHUNT_V_POS_PEAK:
+	case INA209_SHUNT_V_NEG_PEAK:
+	case INA209_SHUNT_V_POS_WARN:
+	case INA209_SHUNT_V_NEG_WARN:
+		/* 10 uV per division */
+		return (s16)val * 10;
+
+	case INA209_BUS_V:
+	case INA209_BUS_V_MAX_PEAK:
+	case INA209_BUS_V_MIN_PEAK:
+	case INA209_BUS_OVER_V_WARN:
+	case INA209_BUS_UNDER_V_WARN:
+	case INA209_BUS_OVER_V_OVER_LIMIT:
+	case INA209_BUS_UNDER_V_OVER_LIMIT:
+		/* 4 mV per division, last 3 bits unused */
+		return (val >> 3) * 4;
+
+	case INA209_CRITICAL_DAC_POS:
+		/* 1 mV per division, in the higest 8 bits */
+		return val >> 8;
+
+	case INA209_CRITICAL_DAC_NEG:
+		/* 1 mV per division, in the higest 8 bits */
+		return -1 * (val >> 8);
+	}
+
+	/* You tried to read a register that isn't supported */
+	WARN_ON_ONCE(1);
+	return 0;
+}
+
+/*
+ * Take a value and convert it to register format, clamping the value
+ * to the appropriate range. Write it to the register
+ */
+static void ina209_to_reg(struct device *dev, u8 reg, int val)
+{
+	struct ina209_data *data = ina209_update_device(dev);
+	struct i2c_client *client = to_i2c_client(dev);
+	u16 regval = 0;
+
+	/*
+	 * We lock around this switch because we're essentially doing
+	 * a read-modify-write of values in data->regs[]
+	 */
+	mutex_lock(&data->update_lock);
+
+	switch (reg) {
+	case INA209_SHUNT_V_POS_WARN:
+	case INA209_SHUNT_V_NEG_WARN:
+		/* Limit to +- 320 mV, 10 uV per division */
+		regval = SENSORS_LIMIT(val, -320000, 320000) / 10;
+		break;
+
+	case INA209_BUS_OVER_V_WARN:
+	case INA209_BUS_UNDER_V_WARN:
+	case INA209_BUS_OVER_V_OVER_LIMIT:
+	case INA209_BUS_UNDER_V_OVER_LIMIT:
+		/* Limit to 0-32000 mV, 4 mV per division */
+		regval = SENSORS_LIMIT(val, 0, 32000) / 4;
+
+		/*
+		 * The last three bits aren't part of the value, but we'll
+		 * preserve them in their original state
+		 */
+		regval = (regval << 3) | (data->regs[reg] & 0x7);
+		break;
+
+	case INA209_CRITICAL_DAC_NEG:
+		/*
+		 * Limit to -255-0 mV, 1 mV per division
+		 * Convert the value to a positive value for the register
+		 */
+		regval = abs(SENSORS_LIMIT(val, -255, 0));
+
+		/*
+		 * The value lives in the top 8 bits only, be careful
+		 * and keep the original value of the other bits
+		 */
+		regval = (regval << 8) | (data->regs[reg] & 0xff);
+		break;
+
+	case INA209_CRITICAL_DAC_POS:
+		/* Limit to 0-255 mV, 1 mV per division */
+		regval = SENSORS_LIMIT(val, 0, 255);
+
+		/*
+		 * The value lives in the top 8 bits only, be careful
+		 * and keep the original value of the other bits
+		 */
+		regval = (regval << 8) | (data->regs[reg] & 0xff);
+		break;
+
+	case INA209_SHUNT_V:
+	case INA209_BUS_V:
+	case INA209_POWER:
+	case INA209_BUS_CURRENT:
+	case INA209_SHUNT_V_POS_PEAK:
+	case INA209_SHUNT_V_NEG_PEAK:
+	case INA209_BUS_V_MAX_PEAK:
+	case INA209_BUS_V_MIN_PEAK:
+	case INA209_POWER_PEAK:
+	default:
+		/* These registers are read only! */
+		WARN_ON_ONCE(1);
+		break;
+	}
+
+	/* Write the value to the register */
+	data->regs[reg] = regval;
+	ina209_write_reg(client, reg, regval);
+	mutex_unlock(&data->update_lock);
+}
+
+static ssize_t ina209_set_value(struct device *dev,
+				struct device_attribute *da,
+				const char *buf,
+				size_t count)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	long val = simple_strtol(buf, NULL, 10);
+
+	ina209_to_reg(dev, attr->index, val);
+	return count;
+}
+
+static ssize_t ina209_show_value(struct device *dev,
+				 struct device_attribute *da,
+				 char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	int val = ina209_from_reg(dev, attr->index);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", val);
+}
+
+static ssize_t ina209_show_alarm(struct device *dev,
+				 struct device_attribute *da,
+				 char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct ina209_data *data = ina209_update_device(dev);
+	const u16 status = data->regs[INA209_STATUS];
+	const unsigned int mask = attr->index;
+
+	/*
+	 * All alarms are in the INA209_STATUS register. To avoid a long
+	 * switch statement, the mask is passed in attr->index
+	 */
+	return snprintf(buf, PAGE_SIZE, "%u\n", status & mask ? 1 : 0);
+}
+
+static ssize_t ina209_show_enable(struct device *dev,
+				  struct device_attribute *da,
+				  char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct ina209_data *data = ina209_update_device(dev);
+	const u16 status = data->regs[INA209_STATUS_MASK];
+	const unsigned int mask = attr->index;
+
+	/*
+	 * All output enables are in the INA209_STATUS_MASK register. To avoid
+	 * a long switch statement, the mask is passed in attr->index
+	 */
+	return snprintf(buf, PAGE_SIZE, "%u\n", status & mask ? 1 : 0);
+}
+
+static ssize_t ina209_set_enable(struct device *dev,
+				 struct device_attribute *da,
+				 const char *buf,
+				 size_t count)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct ina209_data *data = ina209_update_device(dev);
+	struct i2c_client *client = to_i2c_client(dev);
+	const unsigned int mask = attr->index;
+	long val = simple_strtol(buf, NULL, 10);
+	u16 regval;
+
+	mutex_lock(&data->update_lock);
+
+	regval = data->regs[INA209_STATUS_MASK];
+	regval = (val) ? regval | mask : regval & ~mask;
+
+	ina209_write_reg(client, INA209_STATUS_MASK, regval);
+
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+/*
+ * These macros are used below in constructing device attribute objects
+ * for use with sysfs_create_group() to make a sysfs device file
+ * for each register.
+ */
+
+#define INA209_RO(name, ina209_cmd_idx) \
+	static SENSOR_DEVICE_ATTR(name, S_IRUGO, \
+	ina209_show_value, NULL, ina209_cmd_idx)
+
+#define INA209_RW(name, ina209_cmd_idx) \
+	static SENSOR_DEVICE_ATTR(name, S_IRUGO | S_IWUSR, \
+	ina209_show_value, ina209_set_value, ina209_cmd_idx)
+
+#define INA209_ALARM(name, ina209_cmd_idx) \
+	static SENSOR_DEVICE_ATTR(name, S_IRUGO, \
+	ina209_show_alarm, NULL, ina209_cmd_idx)
+
+#define INA209_OUTPUT(name, ina209_cmd_idx) \
+	static SENSOR_DEVICE_ATTR(name, S_IRUGO | S_IWUSR, \
+	ina209_show_enable, ina209_set_enable, ina209_cmd_idx)
+
+/* Shunt voltage reading, history, limits, alarms */
+INA209_RO(in0_input,			INA209_SHUNT_V);
+INA209_RO(in0_input_highest,		INA209_SHUNT_V_POS_PEAK);
+INA209_RO(in0_input_lowest,		INA209_SHUNT_V_NEG_PEAK);
+INA209_RW(in0_max,			INA209_SHUNT_V_POS_WARN);
+INA209_RW(in0_min,			INA209_SHUNT_V_NEG_WARN);
+INA209_RW(in0_crit_max,			INA209_CRITICAL_DAC_POS);
+INA209_RW(in0_crit_min,			INA209_CRITICAL_DAC_NEG);
+INA209_ALARM(in0_min_alarm,		(1 << 11));
+INA209_ALARM(in0_max_alarm,		(1 << 12));
+INA209_ALARM(in0_crit_min_alarm,	(1 << 6));
+INA209_ALARM(in0_crit_max_alarm,	(1 << 7));
+INA209_OUTPUT(in0_crit_enable,		INA209_OUTPUT_CRITICAL);
+
+/* Bus voltage reading, history, limits, alarms */
+INA209_RO(in1_input,			INA209_BUS_V);
+INA209_RO(in1_input_highest,		INA209_BUS_V_MAX_PEAK);
+INA209_RO(in1_input_lowest,		INA209_BUS_V_MIN_PEAK);
+INA209_RW(in1_max,			INA209_BUS_OVER_V_WARN);
+INA209_RW(in1_min,			INA209_BUS_UNDER_V_WARN);
+INA209_RW(in1_crit_max,			INA209_BUS_OVER_V_OVER_LIMIT);
+INA209_RW(in1_crit_min,			INA209_BUS_UNDER_V_OVER_LIMIT);
+INA209_ALARM(in1_min_alarm,		(1 << 14));
+INA209_ALARM(in1_max_alarm,		(1 << 15));
+INA209_ALARM(in1_crit_min_alarm,	(1 << 9));
+INA209_ALARM(in1_crit_max_alarm,	(1 << 10));
+INA209_OUTPUT(in1_crit_enable,		INA209_OUTPUT_OVERLIMIT);
+
+/*
+ * These report the shunt voltage rather than the register readings. Please
+ * see the Documentation/hwmon/ina209 document for an explanation.
+ */
+INA209_RO(power1_input,			INA209_SHUNT_V);
+INA209_RO(curr1_input,			INA209_SHUNT_V);
+
+/*
+ * Finally, construct an array of pointers to members of the above objects,
+ * as required for sysfs_create_group()
+ */
+static struct attribute *ina209_attributes[] = {
+	&sensor_dev_attr_in0_input.dev_attr.attr,
+	&sensor_dev_attr_in0_input_highest.dev_attr.attr,
+	&sensor_dev_attr_in0_input_lowest.dev_attr.attr,
+	&sensor_dev_attr_in0_max.dev_attr.attr,
+	&sensor_dev_attr_in0_min.dev_attr.attr,
+	&sensor_dev_attr_in0_crit_max.dev_attr.attr,
+	&sensor_dev_attr_in0_crit_min.dev_attr.attr,
+	&sensor_dev_attr_in0_max_alarm.dev_attr.attr,
+	&sensor_dev_attr_in0_min_alarm.dev_attr.attr,
+	&sensor_dev_attr_in0_crit_max_alarm.dev_attr.attr,
+	&sensor_dev_attr_in0_crit_min_alarm.dev_attr.attr,
+	&sensor_dev_attr_in0_crit_enable.dev_attr.attr,
+
+	&sensor_dev_attr_in1_input.dev_attr.attr,
+	&sensor_dev_attr_in1_input_highest.dev_attr.attr,
+	&sensor_dev_attr_in1_input_lowest.dev_attr.attr,
+	&sensor_dev_attr_in1_max.dev_attr.attr,
+	&sensor_dev_attr_in1_min.dev_attr.attr,
+	&sensor_dev_attr_in1_crit_max.dev_attr.attr,
+	&sensor_dev_attr_in1_crit_min.dev_attr.attr,
+	&sensor_dev_attr_in1_max_alarm.dev_attr.attr,
+	&sensor_dev_attr_in1_min_alarm.dev_attr.attr,
+	&sensor_dev_attr_in1_crit_max_alarm.dev_attr.attr,
+	&sensor_dev_attr_in1_crit_min_alarm.dev_attr.attr,
+	&sensor_dev_attr_in1_crit_enable.dev_attr.attr,
+
+	&sensor_dev_attr_power1_input.dev_attr.attr,
+	&sensor_dev_attr_curr1_input.dev_attr.attr,
+
+	NULL,
+};
+
+static const struct attribute_group ina209_group = {
+	.attrs = ina209_attributes,
+};
+
+static int ina209_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	struct ina209_data *data;
+	int ret;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data) {
+		ret = -ENOMEM;
+		goto out_kzalloc;
+	}
+
+	i2c_set_clientdata(client, data);
+	mutex_init(&data->update_lock);
+
+	/* Initialize the INA209 chip */
+
+	/*
+	 * This writes the reset value to the chip. This chip's gain is
+	 * completely fake, it just chops the significant bits off of values.
+	 * Therefore, we don't lose any resolution by doing this
+	 */
+	ina209_write_reg(client, INA209_CONFIGURATION, 0x399F);
+
+	/* Enable the overlimit output pin latch */
+	ina209_write_reg(client, INA209_BUS_OVER_V_OVER_LIMIT, 0x0001);
+
+	/* Enable the critical output pin latch and filter */
+	ina209_write_reg(client, INA209_CRITICAL_DAC_POS, 0x0001);
+	ina209_write_reg(client, INA209_CRITICAL_DAC_NEG, 0x0010);
+
+	/* Clear the status register */
+	ina209_read_reg(client, INA209_STATUS);
+
+	/* Register sysfs hooks */
+	ret = sysfs_create_group(&client->dev.kobj, &ina209_group);
+	if (ret)
+		goto out_sysfs_create_group;
+
+	data->hwmon_dev = hwmon_device_register(&client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		ret = PTR_ERR(data->hwmon_dev);
+		goto out_hwmon_device_register;
+	}
+
+	return 0;
+
+out_hwmon_device_register:
+	sysfs_remove_group(&client->dev.kobj, &ina209_group);
+out_sysfs_create_group:
+	kfree(data);
+out_kzalloc:
+	return ret;
+}
+
+static int ina209_remove(struct i2c_client *client)
+{
+	struct ina209_data *data = i2c_get_clientdata(client);
+
+	hwmon_device_unregister(data->hwmon_dev);
+	sysfs_remove_group(&client->dev.kobj, &ina209_group);
+
+	kfree(data);
+
+	return 0;
+}
+
+static int ina209_detect(struct i2c_client *client,
+			 int kind,
+			 struct i2c_board_info *info)
+{
+	struct i2c_adapter *adapter = client->adapter;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_WORD_DATA))
+		return -ENODEV;
+
+	if (kind < 0) {		/* probed detection - check the chip type */
+		s32 v;		/* 16 bits from the chip, or -1 for error */
+
+		/*
+		 * Chip registers 0x00-0x16 are documented. The vendor's
+		 * program INA209EVM.exe hints that register 0x17 is "unused"
+		 * and that 0x18-0x1b provide internal status data.
+		 * i2cdump shows that 0x17 returns 0 and that the chip
+		 * ignores register address bits 0x20 and higher (e.g.
+		 * registers 0x00, 0x20, 0x40 etc through 0xe0 give
+		 * identical values).
+		 */
+
+		/* read "unused" register, expect 0 */
+		if (ina209_read_reg(client, 0x17) != 0)
+			return -ENODEV;
+
+		/* expect 0 bits in configuration */
+		v = ina209_read_reg(client, INA209_CONFIGURATION);
+		if (v < 0 || (v & 0xc000) != 0)
+			return -ENODEV;
+
+		/* chip must ignore address bit 0x20 */
+		if (ina209_read_reg(client, 0x20 | INA209_CONFIGURATION) != v)
+			return -ENODEV;
+
+		/* unused bits in status register, expect 0 */
+		v = ina209_read_reg(client, INA209_STATUS);
+		if (v < 0 || (v & 0x0007) != 0)
+			return -ENODEV;
+	}
+
+	strlcpy(info->type, "ina209", I2C_NAME_SIZE);
+	dev_info(&adapter->dev, "ina209 %s at address 0x%02x\n",
+			kind < 0 ? "probed" : "forced",
+			client->addr);
+
+	return 0;
+}
+
+static const struct i2c_device_id ina209_id[] = {
+	{ "ina209", ina209 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ina209_id);
+
+/* This is the driver that will be inserted */
+static struct i2c_driver ina209_driver = {
+	.class		= I2C_CLASS_HWMON,
+	.driver = {
+		.name	= "ina209",
+	},
+	.probe		= ina209_probe,
+	.remove		= ina209_remove,
+	.id_table	= ina209_id,
+	.detect		= ina209_detect,
+	.address_data	= &addr_data,
+};
+
+static int __init ina209_init(void)
+{
+	return i2c_add_driver(&ina209_driver);
+}
+
+static void __exit ina209_exit(void)
+{
+	i2c_del_driver(&ina209_driver);
+}
+
+MODULE_AUTHOR("Ira W. Snyder <iws@ovro.caltech.edu>");
+MODULE_DESCRIPTION("INA209 driver");
+MODULE_LICENSE("GPL");
+
+module_init(ina209_init);
+module_exit(ina209_exit);
-- 
1.5.4.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
