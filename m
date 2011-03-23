From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 23 Mar 2011 03:43:03 +0000
Subject: [lm-sensors] [PATCH] hwmon: Driver for MAX16065/MAX16066 System
Message-Id: <1300851783-13583-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch adds hardware monitoring support for Maxim MAX16065/MAX16066
flash-configurable system managers with nonvolatile fault registers.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 Documentation/hwmon/max16065 |   69 ++++
 drivers/hwmon/Kconfig        |   10 +
 drivers/hwmon/Makefile       |    1 +
 drivers/hwmon/max16065.c     |  757 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 837 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/hwmon/max16065
 create mode 100644 drivers/hwmon/max16065.c

diff --git a/Documentation/hwmon/max16065 b/Documentation/hwmon/max16065
new file mode 100644
index 0000000..5495868
--- /dev/null
+++ b/Documentation/hwmon/max16065
@@ -0,0 +1,69 @@
+Kernel driver max16065
+===========
+
+Supported chips:
+  * Maxim 16065/16066
+    Prefixes: 'max16065', 'max16066'
+    Addresses scanned: -
+    Datasheet:
+	http://datasheets.maxim-ic.com/en/ds/MAX16065-MAX16066.pdf
+
+Author: Guenter Roeck <guenter.roeck@ericsson.com>
+
+
+Description
+-----------
+
+[From datasheet] The MAX16065/MAX16066 flash-configurable system managers
+monitor and sequence multiple system voltages. The MAX16065/MAX16066 can also
+accurately monitor (+/-2.5%) one current channel using a dedicated high-side
+current-sense amplifier. The MAX16065 manages up to twelve system voltages
+simultaneously, and the MAX16066 manages up to eight supply voltages.
+
+Each monitored channel has its own low and high critical limits, plus an
+additional limit which is configurable as either low or high secondary limit.
+
+
+Usage Notes
+-----------
+
+This driver does not probe for devices, since there is no register which
+can be safely used to identify the chip. You will have to instantiate
+the devices explicitly. When instantiating the device, you have to specify
+its configuration register address.
+
+Example: the following will load the driver for a MAX16065 at address 0x51
+on I2C bus #1:
+$ echo max16065 0x51 > /sys/bus/i2c/devices/i2c-1/new_device
+
+
+Sysfs entries
+-------------
+
+in[0-7]_input		Input voltage measurements.
+in[8-11]_input		Input voltage measurements; MAX16065 only.
+in12_input		Voltage on CSP (Current Sense Positive) pin.
+			Only if current sensing is enabled.
+
+in[0-7]_min		Low warning limit.
+in[8-11]_min		Low warning limit; MAX16065 only
+
+in[0-7]_max		High warning limit.
+in[8-11]_max		High warning limit; MAX16065 only
+
+			Either low or high warning limits are supported
+			(depending on chip configuration), but not both.
+
+in[0-7]_lcrit		Low critical limit.
+in[8-11]_lcrit		Low critical limit; MAX16065 only
+
+in[0-7]_crit		High critical limit.
+in[8-11]_crit		High critical limit; MAX16065 only
+
+in[0-7]_alarm		Input voltage alarm
+in[8-11]_alarm		Input voltage alarm; MAX16065 only
+
+curr1_input		Current sense input; only if current sensing is enabled
+			Displayed current assumes 0.001 Ohm current sense
+			resistor.
+curr1_alarm		Overcurrent alarm
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 1bfb443..5ec8ee5 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -698,6 +698,16 @@ config SENSORS_MAX1111
 	  This driver can also be built as a module.  If so, the module
 	  will be called max1111.
 
+config SENSORS_MAX16065
+	tristate "Maxim MAX16065/MAX16066 System Manager"
+	depends on I2C
+	help
+	  If you say yes here you get support for hardware monitoring
+	  capabilities of the MAX16065/MAX16066 System Manager chips.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called max16065.
+
 config SENSORS_MAX1619
 	tristate "Maxim MAX1619 sensor chip"
 	depends on I2C
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index bd0410e..7fba079 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -85,6 +85,7 @@ obj-$(CONFIG_SENSORS_LTC4215)	+= ltc4215.o
 obj-$(CONFIG_SENSORS_LTC4245)	+= ltc4245.o
 obj-$(CONFIG_SENSORS_LTC4261)	+= ltc4261.o
 obj-$(CONFIG_SENSORS_MAX1111)	+= max1111.o
+obj-$(CONFIG_SENSORS_MAX16065)	+= max16065.o
 obj-$(CONFIG_SENSORS_MAX1619)	+= max1619.o
 obj-$(CONFIG_SENSORS_MAX6639)	+= max6639.o
 obj-$(CONFIG_SENSORS_MAX6650)	+= max6650.o
diff --git a/drivers/hwmon/max16065.c b/drivers/hwmon/max16065.c
new file mode 100644
index 0000000..9863099
--- /dev/null
+++ b/drivers/hwmon/max16065.c
@@ -0,0 +1,757 @@
+/*
+ * Driver for Maxim MAX16065/16066 12-Channel/8-Channel, Flash-Configurable
+ * System Managers with Nonvolatile Fault Registers
+ *
+ * Copyright (C) 2011 Ericsson AB.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * Datasheet: http://datasheets.maxim-ic.com/en/ds/MAX16065-MAX16066.pdf
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
+#include <linux/delay.h>
+
+enum chips { max16056, max16066 };
+
+/*
+ * Registers
+ */
+#define MAX16065_ADC(x)		((x) * 2)
+
+#define MAX16065_CURR_SENSE	0x18
+#define MAX16065_CSP_ADC	0x19
+
+#define MAX16065_FAULT(x)	(0x1b + (x))
+
+#define MAX16065_SCALE_BASE	0x43
+#define MAX16065_CURR_CONTROL	0x47
+#define MAX16065_SECONDARY(x)	(0x48 + (x) * 3)
+#define MAX16065_CRIT(x)	(0x49 + (x) * 3)
+#define MAX16065_LCRIT(x)	(0x4a + (x) * 3)
+
+#define MAX16065_SW_ENABLE	0x73
+
+#define MAX16065_SW_ENABLED	(1 << 0) /* Set if sequencing is enabled */
+#define MAX16065_WARNING_OV	(1 << 3) /* Set if secondary threshold is OV
+					    warning */
+
+#define MAX16065_CURR_ENABLE	(1 << 0)
+
+#define MAX16065_SECONDARY_THRESH(x)	(((x) * 3) + 0x48)
+#define MAX16065_OV_THRESH(x)		(((x) * 3) + 0x49)
+#define MAX16065_UV_THRESH(x)		(((x) * 3) + 0x4a)
+
+#define MAX16065_NUM_ADC	12
+#define MAX16066_NUM_ADC	8
+
+static const int max16065_adc_range[] = { 5560, 2780, 1390, 0 };
+static const int max16065_csp_adc_range[] = { 7000, 14000 };
+
+/* ADC registers have 10 bit resolution. */
+#define ADC_TO_MV(x, r) (((x) * (r)) / 1024)
+
+/*
+ * Limit registers have 8 bit resolution and match upper 8 bits of ADC
+ * registers.
+ */
+#define LIMIT_TO_MV(x, r) ((x) * (r) / 256)
+#define MV_TO_LIMIT(x, r) ((r) ?  ((x) * 256 / (r)) : 0)
+
+#define ADC_TO_CURR(x, g) ((x) * 1400000 / ((g) * 255))
+
+struct max16065_data {
+	enum chips type;
+	struct device *hwmon_dev;
+	struct mutex update_lock;
+	bool valid;
+	unsigned long last_updated; /* in jiffies */
+	int num_adc;
+	int curr_gain;
+	/* limits are in mV */
+	bool secondary_is_max;		/* secondary limits reflect max */
+	int secondary[MAX16065_NUM_ADC];
+	int lcrit[MAX16065_NUM_ADC];
+	int crit[MAX16065_NUM_ADC];
+	int range[MAX16065_NUM_ADC + 1];/* voltage range */
+	int adc[MAX16065_NUM_ADC + 1];	/* adc values (raw) including csp_adc */
+	int curr_sense;
+	int fault[2];
+};
+
+/*
+ * max16065_read_adc()
+ *
+ * Read 16 bit value from <reg>, <reg+1>.
+ * Upper 8 bits are in <reg>, lower 2 bits are in bits 7:6 of <reg+1>.
+ */
+static int max16065_read_adc(struct i2c_client *client, int reg)
+{
+	int rv, val;
+
+	rv = i2c_smbus_read_byte_data(client, reg);
+	if (rv < 0)
+		return rv;
+	val = rv << 2;
+	rv = i2c_smbus_read_byte_data(client, reg + 1);
+	if (rv < 0)
+		return rv;
+	val |= rv >> 6;
+	return val;
+}
+
+static struct max16065_data *max16065_update_device(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct max16065_data *data = i2c_get_clientdata(client);
+
+	mutex_lock(&data->update_lock);
+	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
+		int i;
+
+		for (i = 0; i < MAX16065_NUM_ADC; i++)
+			data->adc[i]
+			  = max16065_read_adc(client, MAX16065_ADC(i));
+		data->adc[MAX16065_NUM_ADC]
+		  = max16065_read_adc(client, MAX16065_CSP_ADC);
+		data->curr_sense
+		  = i2c_smbus_read_byte_data(client, MAX16065_CURR_SENSE);
+
+		for (i = 0; i < 2; i++)
+			data->fault[i]
+			  = i2c_smbus_read_byte_data(client, MAX16065_FAULT(i));
+
+		data->last_updated = jiffies;
+		data->valid = 1;
+	}
+	mutex_unlock(&data->update_lock);
+	return data;
+}
+
+static ssize_t max16065_show_alarm(struct device *dev,
+				   struct device_attribute *da, char *buf)
+{
+	struct sensor_device_attribute_2 *attr2 = to_sensor_dev_attr_2(da);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct max16065_data *data = max16065_update_device(dev);
+	int val = data->fault[attr2->nr];
+
+	if (val < 0)
+		return val;
+
+	val &= (1 << attr2->index);
+	if (val)
+		i2c_smbus_write_byte_data(client, MAX16065_FAULT(attr2->nr),
+					  val);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", !!val);
+}
+
+static ssize_t max16065_show_input(struct device *dev,
+				   struct device_attribute *da, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct max16065_data *data = max16065_update_device(dev);
+	int adc = data->adc[attr->index];
+
+	if (adc < 0)
+		return adc;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n",
+			ADC_TO_MV(adc, data->range[attr->index]));
+}
+
+static ssize_t max16065_show_current(struct device *dev,
+				     struct device_attribute *da, char *buf)
+{
+	struct max16065_data *data = max16065_update_device(dev);
+
+	if (data->curr_sense < 0)
+		return data->curr_sense;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n",
+			ADC_TO_CURR(data->curr_sense, data->curr_gain));
+}
+
+static ssize_t max16065_set_lcrit(struct device *dev,
+				  struct device_attribute *da,
+				  const char *buf, size_t count)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct max16065_data *data = i2c_get_clientdata(client);
+	unsigned long val;
+	int err;
+
+	err = strict_strtoul(buf, 10, &val);
+	if (err < 0)
+		return err;
+	mutex_lock(&data->update_lock);
+	data->lcrit[attr->index] = val;
+	i2c_smbus_write_byte_data(client, MAX16065_LCRIT(attr->index),
+				  MV_TO_LIMIT(val, data->range[attr->index]));
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+static ssize_t max16065_show_lcrit(struct device *dev,
+				   struct device_attribute *da, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct max16065_data *data = i2c_get_clientdata(client);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n",
+			data->lcrit[attr->index]);
+}
+
+static ssize_t max16065_set_crit(struct device *dev,
+				 struct device_attribute *da,
+				 const char *buf, size_t count)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct max16065_data *data = i2c_get_clientdata(client);
+	unsigned long val;
+	int err;
+
+	err = strict_strtoul(buf, 10, &val);
+	if (err < 0)
+		return err;
+	mutex_lock(&data->update_lock);
+	data->crit[attr->index] = val;
+	i2c_smbus_write_byte_data(client, MAX16065_CRIT(attr->index),
+				  MV_TO_LIMIT(val, data->range[attr->index]));
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+static ssize_t max16065_show_crit(struct device *dev,
+				  struct device_attribute *da, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct max16065_data *data = i2c_get_clientdata(client);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n",
+			data->crit[attr->index]);
+}
+
+static ssize_t max16065_set_secondary(struct device *dev,
+				      struct device_attribute *da,
+				      const char *buf, size_t count)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct max16065_data *data = i2c_get_clientdata(client);
+	unsigned long val;
+	int err;
+
+	err = strict_strtoul(buf, 10, &val);
+	if (err < 0)
+		return err;
+	mutex_lock(&data->update_lock);
+	data->secondary[attr->index] = val;
+	i2c_smbus_write_byte_data(client, MAX16065_SECONDARY(attr->index),
+				  MV_TO_LIMIT(val, data->range[attr->index]));
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+static ssize_t max16065_show_secondary(struct device *dev,
+				       struct device_attribute *da, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct max16065_data *data = i2c_get_clientdata(client);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n",
+			data->secondary[attr->index]);
+}
+
+/* Construct a sensor_device_attribute structure for each register */
+
+/* Input voltages */
+static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, max16065_show_input, NULL, 0);
+static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, max16065_show_input, NULL, 1);
+static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, max16065_show_input, NULL, 2);
+static SENSOR_DEVICE_ATTR(in3_input, S_IRUGO, max16065_show_input, NULL, 3);
+static SENSOR_DEVICE_ATTR(in4_input, S_IRUGO, max16065_show_input, NULL, 4);
+static SENSOR_DEVICE_ATTR(in5_input, S_IRUGO, max16065_show_input, NULL, 5);
+static SENSOR_DEVICE_ATTR(in6_input, S_IRUGO, max16065_show_input, NULL, 6);
+static SENSOR_DEVICE_ATTR(in7_input, S_IRUGO, max16065_show_input, NULL, 7);
+static SENSOR_DEVICE_ATTR(in8_input, S_IRUGO, max16065_show_input, NULL, 8);
+static SENSOR_DEVICE_ATTR(in9_input, S_IRUGO, max16065_show_input, NULL, 9);
+static SENSOR_DEVICE_ATTR(in10_input, S_IRUGO, max16065_show_input, NULL, 10);
+static SENSOR_DEVICE_ATTR(in11_input, S_IRUGO, max16065_show_input, NULL, 11);
+static SENSOR_DEVICE_ATTR(in12_input, S_IRUGO, max16065_show_input, NULL, 12);
+
+/* Input voltages lcrit */
+static SENSOR_DEVICE_ATTR(in0_lcrit, S_IWUSR | S_IRUGO, max16065_show_lcrit,
+			  max16065_set_lcrit, 0);
+static SENSOR_DEVICE_ATTR(in1_lcrit, S_IWUSR | S_IRUGO, max16065_show_lcrit,
+			  max16065_set_lcrit, 1);
+static SENSOR_DEVICE_ATTR(in2_lcrit, S_IWUSR | S_IRUGO, max16065_show_lcrit,
+			  max16065_set_lcrit, 2);
+static SENSOR_DEVICE_ATTR(in3_lcrit, S_IWUSR | S_IRUGO, max16065_show_lcrit,
+			  max16065_set_lcrit, 3);
+static SENSOR_DEVICE_ATTR(in4_lcrit, S_IWUSR | S_IRUGO, max16065_show_lcrit,
+			  max16065_set_lcrit, 4);
+static SENSOR_DEVICE_ATTR(in5_lcrit, S_IWUSR | S_IRUGO, max16065_show_lcrit,
+			  max16065_set_lcrit, 5);
+static SENSOR_DEVICE_ATTR(in6_lcrit, S_IWUSR | S_IRUGO, max16065_show_lcrit,
+			  max16065_set_lcrit, 6);
+static SENSOR_DEVICE_ATTR(in7_lcrit, S_IWUSR | S_IRUGO, max16065_show_lcrit,
+			  max16065_set_lcrit, 7);
+static SENSOR_DEVICE_ATTR(in8_lcrit, S_IWUSR | S_IRUGO, max16065_show_lcrit,
+			  max16065_set_lcrit, 8);
+static SENSOR_DEVICE_ATTR(in9_lcrit, S_IWUSR | S_IRUGO, max16065_show_lcrit,
+			  max16065_set_lcrit, 9);
+static SENSOR_DEVICE_ATTR(in10_lcrit, S_IWUSR | S_IRUGO, max16065_show_lcrit,
+			  max16065_set_lcrit, 10);
+static SENSOR_DEVICE_ATTR(in11_lcrit, S_IWUSR | S_IRUGO, max16065_show_lcrit,
+			  max16065_set_lcrit, 11);
+
+/* Input voltages crit */
+static SENSOR_DEVICE_ATTR(in0_crit, S_IWUSR | S_IRUGO, max16065_show_crit,
+			  max16065_set_crit, 0);
+static SENSOR_DEVICE_ATTR(in1_crit, S_IWUSR | S_IRUGO, max16065_show_crit,
+			  max16065_set_crit, 1);
+static SENSOR_DEVICE_ATTR(in2_crit, S_IWUSR | S_IRUGO, max16065_show_crit,
+			  max16065_set_crit, 2);
+static SENSOR_DEVICE_ATTR(in3_crit, S_IWUSR | S_IRUGO, max16065_show_crit,
+			  max16065_set_crit, 3);
+static SENSOR_DEVICE_ATTR(in4_crit, S_IWUSR | S_IRUGO, max16065_show_crit,
+			  max16065_set_crit, 4);
+static SENSOR_DEVICE_ATTR(in5_crit, S_IWUSR | S_IRUGO, max16065_show_crit,
+			  max16065_set_crit, 5);
+static SENSOR_DEVICE_ATTR(in6_crit, S_IWUSR | S_IRUGO, max16065_show_crit,
+			  max16065_set_crit, 6);
+static SENSOR_DEVICE_ATTR(in7_crit, S_IWUSR | S_IRUGO, max16065_show_crit,
+			  max16065_set_crit, 7);
+static SENSOR_DEVICE_ATTR(in8_crit, S_IWUSR | S_IRUGO, max16065_show_crit,
+			  max16065_set_crit, 8);
+static SENSOR_DEVICE_ATTR(in9_crit, S_IWUSR | S_IRUGO, max16065_show_crit,
+			  max16065_set_crit, 9);
+static SENSOR_DEVICE_ATTR(in10_crit, S_IWUSR | S_IRUGO, max16065_show_crit,
+			  max16065_set_crit, 10);
+static SENSOR_DEVICE_ATTR(in11_crit, S_IWUSR | S_IRUGO, max16065_show_crit,
+			  max16065_set_crit, 11);
+
+/* Input voltages min */
+static SENSOR_DEVICE_ATTR(in0_min, S_IWUSR | S_IRUGO, max16065_show_secondary,
+			  max16065_set_secondary, 0);
+static SENSOR_DEVICE_ATTR(in1_min, S_IWUSR | S_IRUGO, max16065_show_secondary,
+			  max16065_set_secondary, 1);
+static SENSOR_DEVICE_ATTR(in2_min, S_IWUSR | S_IRUGO, max16065_show_secondary,
+			  max16065_set_secondary, 2);
+static SENSOR_DEVICE_ATTR(in3_min, S_IWUSR | S_IRUGO, max16065_show_secondary,
+			  max16065_set_secondary, 3);
+static SENSOR_DEVICE_ATTR(in4_min, S_IWUSR | S_IRUGO, max16065_show_secondary,
+			  max16065_set_secondary, 4);
+static SENSOR_DEVICE_ATTR(in5_min, S_IWUSR | S_IRUGO, max16065_show_secondary,
+			  max16065_set_secondary, 5);
+static SENSOR_DEVICE_ATTR(in6_min, S_IWUSR | S_IRUGO, max16065_show_secondary,
+			  max16065_set_secondary, 6);
+static SENSOR_DEVICE_ATTR(in7_min, S_IWUSR | S_IRUGO, max16065_show_secondary,
+			  max16065_set_secondary, 7);
+static SENSOR_DEVICE_ATTR(in8_min, S_IWUSR | S_IRUGO, max16065_show_secondary,
+			  max16065_set_secondary, 8);
+static SENSOR_DEVICE_ATTR(in9_min, S_IWUSR | S_IRUGO, max16065_show_secondary,
+			  max16065_set_secondary, 9);
+static SENSOR_DEVICE_ATTR(in10_min, S_IWUSR | S_IRUGO, max16065_show_secondary,
+			  max16065_set_secondary, 10);
+static SENSOR_DEVICE_ATTR(in11_min, S_IWUSR | S_IRUGO, max16065_show_secondary,
+			  max16065_set_secondary, 11);
+
+/* Input voltages max */
+static SENSOR_DEVICE_ATTR(in0_max, S_IWUSR | S_IRUGO, max16065_show_secondary,
+			  max16065_set_secondary, 0);
+static SENSOR_DEVICE_ATTR(in1_max, S_IWUSR | S_IRUGO, max16065_show_secondary,
+			  max16065_set_secondary, 1);
+static SENSOR_DEVICE_ATTR(in2_max, S_IWUSR | S_IRUGO, max16065_show_secondary,
+			  max16065_set_secondary, 2);
+static SENSOR_DEVICE_ATTR(in3_max, S_IWUSR | S_IRUGO, max16065_show_secondary,
+			  max16065_set_secondary, 3);
+static SENSOR_DEVICE_ATTR(in4_max, S_IWUSR | S_IRUGO, max16065_show_secondary,
+			  max16065_set_secondary, 4);
+static SENSOR_DEVICE_ATTR(in5_max, S_IWUSR | S_IRUGO, max16065_show_secondary,
+			  max16065_set_secondary, 5);
+static SENSOR_DEVICE_ATTR(in6_max, S_IWUSR | S_IRUGO, max16065_show_secondary,
+			  max16065_set_secondary, 6);
+static SENSOR_DEVICE_ATTR(in7_max, S_IWUSR | S_IRUGO, max16065_show_secondary,
+			  max16065_set_secondary, 7);
+static SENSOR_DEVICE_ATTR(in8_max, S_IWUSR | S_IRUGO, max16065_show_secondary,
+			  max16065_set_secondary, 8);
+static SENSOR_DEVICE_ATTR(in9_max, S_IWUSR | S_IRUGO, max16065_show_secondary,
+			  max16065_set_secondary, 9);
+static SENSOR_DEVICE_ATTR(in10_max, S_IWUSR | S_IRUGO, max16065_show_secondary,
+			  max16065_set_secondary, 10);
+static SENSOR_DEVICE_ATTR(in11_max, S_IWUSR | S_IRUGO, max16065_show_secondary,
+			  max16065_set_secondary, 11);
+
+/* alarms */
+static SENSOR_DEVICE_ATTR_2(in0_alarm, S_IRUGO, max16065_show_alarm, NULL, 0,
+			    0);
+static SENSOR_DEVICE_ATTR_2(in1_alarm, S_IRUGO, max16065_show_alarm, NULL, 0,
+			    1);
+static SENSOR_DEVICE_ATTR_2(in2_alarm, S_IRUGO, max16065_show_alarm, NULL, 0,
+			    2);
+static SENSOR_DEVICE_ATTR_2(in3_alarm, S_IRUGO, max16065_show_alarm, NULL, 0,
+			    3);
+static SENSOR_DEVICE_ATTR_2(in4_alarm, S_IRUGO, max16065_show_alarm, NULL, 0,
+			    4);
+static SENSOR_DEVICE_ATTR_2(in5_alarm, S_IRUGO, max16065_show_alarm, NULL, 0,
+			    5);
+static SENSOR_DEVICE_ATTR_2(in6_alarm, S_IRUGO, max16065_show_alarm, NULL, 0,
+			    6);
+static SENSOR_DEVICE_ATTR_2(in7_alarm, S_IRUGO, max16065_show_alarm, NULL, 0,
+			    7);
+static SENSOR_DEVICE_ATTR_2(in8_alarm, S_IRUGO, max16065_show_alarm, NULL, 1,
+			    0);
+static SENSOR_DEVICE_ATTR_2(in9_alarm, S_IRUGO, max16065_show_alarm, NULL, 1,
+			    1);
+static SENSOR_DEVICE_ATTR_2(in10_alarm, S_IRUGO, max16065_show_alarm, NULL, 1,
+			    2);
+static SENSOR_DEVICE_ATTR_2(in11_alarm, S_IRUGO, max16065_show_alarm, NULL, 1,
+			    3);
+
+/* Current and alarm */
+static SENSOR_DEVICE_ATTR(curr1_input, S_IRUGO, max16065_show_current, NULL, 0);
+static SENSOR_DEVICE_ATTR_2(curr1_alarm, S_IRUGO, max16065_show_alarm, NULL,
+			    1, 4);
+
+/*
+ * Finally, construct an array of pointers to members of the above objects,
+ * as required for sysfs_create_group()
+ */
+static struct attribute *max16065_basic_attributes[] = {
+	&sensor_dev_attr_in0_input.dev_attr.attr,
+	&sensor_dev_attr_in0_lcrit.dev_attr.attr,
+	&sensor_dev_attr_in0_crit.dev_attr.attr,
+	&sensor_dev_attr_in0_alarm.dev_attr.attr,
+
+	&sensor_dev_attr_in1_input.dev_attr.attr,
+	&sensor_dev_attr_in1_lcrit.dev_attr.attr,
+	&sensor_dev_attr_in1_crit.dev_attr.attr,
+	&sensor_dev_attr_in1_alarm.dev_attr.attr,
+
+	&sensor_dev_attr_in2_input.dev_attr.attr,
+	&sensor_dev_attr_in2_lcrit.dev_attr.attr,
+	&sensor_dev_attr_in2_crit.dev_attr.attr,
+	&sensor_dev_attr_in2_alarm.dev_attr.attr,
+
+	&sensor_dev_attr_in3_input.dev_attr.attr,
+	&sensor_dev_attr_in3_lcrit.dev_attr.attr,
+	&sensor_dev_attr_in3_crit.dev_attr.attr,
+	&sensor_dev_attr_in3_alarm.dev_attr.attr,
+
+	&sensor_dev_attr_in4_input.dev_attr.attr,
+	&sensor_dev_attr_in4_lcrit.dev_attr.attr,
+	&sensor_dev_attr_in4_crit.dev_attr.attr,
+	&sensor_dev_attr_in4_alarm.dev_attr.attr,
+
+	&sensor_dev_attr_in5_input.dev_attr.attr,
+	&sensor_dev_attr_in5_lcrit.dev_attr.attr,
+	&sensor_dev_attr_in5_crit.dev_attr.attr,
+	&sensor_dev_attr_in5_alarm.dev_attr.attr,
+
+	&sensor_dev_attr_in6_input.dev_attr.attr,
+	&sensor_dev_attr_in6_lcrit.dev_attr.attr,
+	&sensor_dev_attr_in6_crit.dev_attr.attr,
+	&sensor_dev_attr_in6_alarm.dev_attr.attr,
+
+	&sensor_dev_attr_in7_input.dev_attr.attr,
+	&sensor_dev_attr_in7_lcrit.dev_attr.attr,
+	&sensor_dev_attr_in7_crit.dev_attr.attr,
+	&sensor_dev_attr_in7_alarm.dev_attr.attr,
+
+	NULL,
+};
+
+static struct attribute *max16065_current_attributes[] = {
+	&sensor_dev_attr_in12_input.dev_attr.attr,
+	&sensor_dev_attr_curr1_input.dev_attr.attr,
+	&sensor_dev_attr_curr1_alarm.dev_attr.attr,
+	NULL,
+};
+
+static struct attribute *max16065_extended_attributes[] = {
+	&sensor_dev_attr_in8_input.dev_attr.attr,
+	&sensor_dev_attr_in8_lcrit.dev_attr.attr,
+	&sensor_dev_attr_in8_crit.dev_attr.attr,
+	&sensor_dev_attr_in8_alarm.dev_attr.attr,
+
+	&sensor_dev_attr_in9_input.dev_attr.attr,
+	&sensor_dev_attr_in9_lcrit.dev_attr.attr,
+	&sensor_dev_attr_in9_crit.dev_attr.attr,
+	&sensor_dev_attr_in9_alarm.dev_attr.attr,
+
+	&sensor_dev_attr_in10_input.dev_attr.attr,
+	&sensor_dev_attr_in10_lcrit.dev_attr.attr,
+	&sensor_dev_attr_in10_crit.dev_attr.attr,
+	&sensor_dev_attr_in10_alarm.dev_attr.attr,
+
+	&sensor_dev_attr_in11_input.dev_attr.attr,
+	&sensor_dev_attr_in11_lcrit.dev_attr.attr,
+	&sensor_dev_attr_in11_crit.dev_attr.attr,
+	&sensor_dev_attr_in11_alarm.dev_attr.attr,
+
+	NULL,
+};
+
+static struct attribute *max16065_basic_min_attributes[] = {
+	&sensor_dev_attr_in0_min.dev_attr.attr,
+	&sensor_dev_attr_in1_min.dev_attr.attr,
+	&sensor_dev_attr_in2_min.dev_attr.attr,
+	&sensor_dev_attr_in3_min.dev_attr.attr,
+	&sensor_dev_attr_in4_min.dev_attr.attr,
+	&sensor_dev_attr_in5_min.dev_attr.attr,
+	&sensor_dev_attr_in6_min.dev_attr.attr,
+	&sensor_dev_attr_in7_min.dev_attr.attr,
+	NULL,
+};
+
+static struct attribute *max16065_extended_min_attributes[] = {
+	&sensor_dev_attr_in8_min.dev_attr.attr,
+	&sensor_dev_attr_in9_min.dev_attr.attr,
+	&sensor_dev_attr_in10_min.dev_attr.attr,
+	&sensor_dev_attr_in11_min.dev_attr.attr,
+	NULL,
+};
+
+static struct attribute *max16065_basic_max_attributes[] = {
+	&sensor_dev_attr_in0_max.dev_attr.attr,
+	&sensor_dev_attr_in1_max.dev_attr.attr,
+	&sensor_dev_attr_in2_max.dev_attr.attr,
+	&sensor_dev_attr_in3_max.dev_attr.attr,
+	&sensor_dev_attr_in4_max.dev_attr.attr,
+	&sensor_dev_attr_in5_max.dev_attr.attr,
+	&sensor_dev_attr_in6_max.dev_attr.attr,
+	&sensor_dev_attr_in7_max.dev_attr.attr,
+	NULL,
+};
+
+static struct attribute *max16065_extended_max_attributes[] = {
+	&sensor_dev_attr_in8_max.dev_attr.attr,
+	&sensor_dev_attr_in9_max.dev_attr.attr,
+	&sensor_dev_attr_in10_max.dev_attr.attr,
+	&sensor_dev_attr_in11_max.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group max16065_basic_group = {
+	.attrs = max16065_basic_attributes,
+};
+
+static const struct attribute_group max16065_current_group = {
+	.attrs = max16065_current_attributes,
+};
+
+static const struct attribute_group max16065_extended_group = {
+	.attrs = max16065_extended_attributes,
+};
+
+static const struct attribute_group max16065_basic_min_group = {
+	.attrs = max16065_basic_min_attributes,
+};
+
+static const struct attribute_group max16065_extended_min_group = {
+	.attrs = max16065_extended_min_attributes,
+};
+
+static const struct attribute_group max16065_basic_max_group = {
+	.attrs = max16065_basic_max_attributes,
+};
+
+static const struct attribute_group max16065_extended_max_group = {
+	.attrs = max16065_extended_max_attributes,
+};
+
+static void max16065_cleanup(struct i2c_client *client)
+{
+	sysfs_remove_group(&client->dev.kobj, &max16065_extended_max_group);
+	sysfs_remove_group(&client->dev.kobj, &max16065_extended_min_group);
+	sysfs_remove_group(&client->dev.kobj, &max16065_extended_group);
+	sysfs_remove_group(&client->dev.kobj, &max16065_basic_max_group);
+	sysfs_remove_group(&client->dev.kobj, &max16065_basic_min_group);
+	sysfs_remove_group(&client->dev.kobj, &max16065_current_group);
+	sysfs_remove_group(&client->dev.kobj, &max16065_basic_group);
+}
+
+static int max16065_probe(struct i2c_client *client,
+			  const struct i2c_device_id *id)
+{
+	struct i2c_adapter *adapter = client->adapter;
+	struct max16065_data *data;
+	int i, j, val, ret;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		return -ENODEV;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, data);
+	mutex_init(&data->update_lock);
+
+	data->num_adc = id->driver_data;
+
+	val = i2c_smbus_read_byte_data(client, MAX16065_SW_ENABLE);
+	if (unlikely(val < 0)) {
+		ret = val;
+		goto out;
+	}
+
+	data->secondary_is_max = !!(val & MAX16065_WARNING_OV);
+
+	/* Read scale registers, convert to range */
+	for (i = 0; i < data->num_adc / 4; i++) {
+		val = i2c_smbus_read_byte_data(client, MAX16065_SCALE_BASE + i);
+		if (unlikely(val < 0)) {
+			ret = val;
+			goto out;
+		}
+		for (j = 0; j < 4; j++) {
+			data->range[i * 4 + j] +			  max16065_adc_range[(val >> (j * 2)) & 0x3];
+		}
+	}
+
+	/* Read limits */
+	for (i = 0; i < data->num_adc; i++) {
+		val = i2c_smbus_read_byte_data(client, MAX16065_LCRIT(i));
+		if (unlikely(val < 0)) {
+			ret = val;
+			goto out;
+		}
+		data->lcrit[i] = LIMIT_TO_MV(val, data->range[i]);
+
+		val = i2c_smbus_read_byte_data(client, MAX16065_CRIT(i));
+		if (unlikely(val < 0)) {
+			ret = val;
+			goto out;
+		}
+		data->crit[i] = LIMIT_TO_MV(val, data->range[i]);
+
+		val = i2c_smbus_read_byte_data(client, MAX16065_SECONDARY(i));
+		if (unlikely(val < 0)) {
+			ret = val;
+			goto out;
+		}
+		data->secondary[i] = LIMIT_TO_MV(val, data->range[i]);
+	}
+
+	/* Register sysfs hooks */
+	ret = sysfs_create_group(&client->dev.kobj, &max16065_basic_group);
+	if (ret)
+		goto out;
+
+	ret = sysfs_create_group(&client->dev.kobj,
+				 data->secondary_is_max ?
+				 &max16065_basic_max_group :
+				 &max16065_basic_min_group);
+	if (ret)
+		goto out;
+
+	val = i2c_smbus_read_byte_data(client, MAX16065_CURR_CONTROL);
+	if (unlikely(val < 0)) {
+		ret = val;
+		goto out;
+	}
+	if (val & MAX16065_CURR_ENABLE) {
+		/* Current gain is 6, 12, 24, 48 based on values in bit 2,3 */
+		data->curr_gain = 6 << ((val >> 2) & 0x03);
+		data->range[MAX16065_NUM_ADC]
+		  = max16065_csp_adc_range[(val >> 1) & 1];
+		ret = sysfs_create_group(&client->dev.kobj,
+					 &max16065_current_group);
+		if (ret)
+			goto out;
+	}
+
+	if (data->num_adc = MAX16065_NUM_ADC) {
+		ret = sysfs_create_group(&client->dev.kobj,
+					 &max16065_extended_group);
+		if (ret)
+			goto out;
+		ret = sysfs_create_group(&client->dev.kobj,
+					 data->secondary_is_max ?
+					 &max16065_extended_max_group :
+					 &max16065_extended_min_group);
+		if (ret)
+			goto out;
+
+	}
+
+	data->hwmon_dev = hwmon_device_register(&client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		ret = PTR_ERR(data->hwmon_dev);
+		goto out;
+	}
+	return 0;
+
+out:
+	max16065_cleanup(client);
+	kfree(data);
+	return ret;
+}
+
+static int max16065_remove(struct i2c_client *client)
+{
+	struct max16065_data *data = i2c_get_clientdata(client);
+
+	hwmon_device_unregister(data->hwmon_dev);
+	max16065_cleanup(client);
+	kfree(data);
+
+	return 0;
+}
+
+static const struct i2c_device_id max16065_id[] = {
+	{"max16065", MAX16065_NUM_ADC},
+	{"max16066", MAX16066_NUM_ADC},
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, max16065_id);
+
+/* This is the driver that will be inserted */
+static struct i2c_driver max16065_driver = {
+	.driver = {
+		   .name = "max16065",
+		   },
+	.probe = max16065_probe,
+	.remove = max16065_remove,
+	.id_table = max16065_id,
+};
+
+static int __init max16065_init(void)
+{
+	return i2c_add_driver(&max16065_driver);
+}
+
+static void __exit max16065_exit(void)
+{
+	i2c_del_driver(&max16065_driver);
+}
+
+MODULE_AUTHOR("Guenter Roeck");
+MODULE_DESCRIPTION("MAX16065 driver");
+MODULE_LICENSE("GPL");
+
+module_init(max16065_init);
+module_exit(max16065_exit);
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
