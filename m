From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 26 Jun 2010 02:40:09 +0000
Subject: [lm-sensors] [PATCH/RFC 1/3] hwmon: LTC4261 Hardware monitoring
Message-Id: <1277520011-29782-2-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This driver adds support for Linear Technology LTC4261 I2C Negative
Voltage Hot Swap Controller.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/Kconfig   |   11 ++
 drivers/hwmon/Makefile  |    1 +
 drivers/hwmon/ltc4261.c |  301 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 313 insertions(+), 0 deletions(-)
 create mode 100644 drivers/hwmon/ltc4261.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index e19cf8e..dfb300b 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -625,6 +625,17 @@ config SENSORS_LTC4245
 	  This driver can also be built as a module. If so, the module will
 	  be called ltc4245.
 
+config SENSORS_LTC4261
+	tristate "Linear Technology LTC4261"
+	depends on I2C && EXPERIMENTAL
+	default n
+	help
+	  If you say yes here you get support for Linear Technology LTC4261
+	  Negative Voltage Hot Swap Controller I2C interface.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called ltc4261.
+
 config SENSORS_LM95241
 	tristate "National Semiconductor LM95241 sensor chip"
 	depends on I2C
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 2138ceb..795c805 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -76,6 +76,7 @@ obj-$(CONFIG_SENSORS_LM93)	+= lm93.o
 obj-$(CONFIG_SENSORS_LM95241)	+= lm95241.o
 obj-$(CONFIG_SENSORS_LTC4215)	+= ltc4215.o
 obj-$(CONFIG_SENSORS_LTC4245)	+= ltc4245.o
+obj-$(CONFIG_SENSORS_LTC4261)	+= ltc4261.o
 obj-$(CONFIG_SENSORS_MAX1111)	+= max1111.o
 obj-$(CONFIG_SENSORS_MAX1619)	+= max1619.o
 obj-$(CONFIG_SENSORS_MAX6650)	+= max6650.o
diff --git a/drivers/hwmon/ltc4261.c b/drivers/hwmon/ltc4261.c
new file mode 100644
index 0000000..859019a
--- /dev/null
+++ b/drivers/hwmon/ltc4261.c
@@ -0,0 +1,301 @@
+/*
+ * Driver for Linear Technology LTC4261 I2C Negative Voltage Hot Swap Controller
+ *
+ * Copyright (C) 2010 Ericsson AB.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This driver is based on the ltc4245 driver.
+ *
+ * Datasheet:
+ * http://cds.linear.com/docs/Datasheet/42612fb.pdf
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
+
+/* chip registers */
+#define	LTC4261_STATUS	0x00	/* readonly */
+#define	LTC4261_FAULT	0x01
+#define	LTC4261_ALERT	0x02
+#define	LTC4261_CONTROL	0x03
+#define	LTC4261_SENSE_H	0x04
+#define	LTC4261_SENSE_L	0x05
+#define	LTC4261_ADIN2_H	0x06
+#define	LTC4261_ADIN2_L	0x07
+#define	LTC4261_ADIN_H	0x08
+#define	LTC4261_ADIN_L	0x09
+
+/*
+ * Fault register bits
+ */
+#define FAULT_OV	(1<<0)
+#define FAULT_UV	(1<<1)
+#define FAULT_OC	(1<<2)
+
+struct ltc4261_data {
+	struct device *hwmon_dev;
+
+	struct mutex update_lock;
+	bool valid;
+	unsigned long last_updated; /* in jiffies */
+
+	/* Registers */
+	u8 regs[10];
+};
+
+static struct ltc4261_data *ltc4261_update_device(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct ltc4261_data *data = i2c_get_clientdata(client);
+	struct ltc4261_data *ret = data;
+
+	mutex_lock(&data->update_lock);
+
+	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
+		int i;
+
+		/* Read registers -- 0x00 to 0x09 */
+		for (i = 0; i < ARRAY_SIZE(data->regs); i++) {
+			int val;
+
+			val = i2c_smbus_read_byte_data(client, i);
+			if (unlikely(val < 0)) {
+				dev_dbg(dev,
+					"Failed to read ADC value: error %d",
+					val);
+				ret = ERR_PTR(val);
+				goto abort;
+			}
+			data->regs[i] = val;
+		}
+		data->last_updated = jiffies;
+		data->valid = 1;
+	}
+abort:
+	mutex_unlock(&data->update_lock);
+	return ret;
+}
+
+/* Return the voltage from the given register in mV or mA */
+static int ltc4261_get_value(struct ltc4261_data *data, u8 reg)
+{
+	u32 val;
+
+	val = (data->regs[reg] << 2) + ((data->regs[reg+1] >> 6) & 0x03);
+
+	switch (reg) {
+	case LTC4261_ADIN_H:
+	case LTC4261_ADIN2_H:
+		/* 2.5mV resolution. Convert to mV. */
+		val = val * 25 / 10;
+		break;
+	case LTC4261_SENSE_H:
+		/*
+		 * 62.5uV resolution. Convert to current as measured with
+		 * an 1 mOhm sense resistor, in mA. If a different sense
+		 * resistor is installed, calculate the actual current by
+		 * dividing the reported current by the sense resistor value
+		 * in mOhm.
+		 */
+		val = val * 625 / 10;
+		break;
+	default:
+		/* If we get here, the developer messed up */
+		WARN_ON_ONCE(1);
+		val = 0;
+		break;
+	}
+
+	return val;
+}
+
+static ssize_t ltc4261_show_value(struct device *dev,
+				  struct device_attribute *da,
+				  char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct ltc4261_data *data = ltc4261_update_device(dev);
+	int value;
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	value = ltc4261_get_value(data, attr->index);
+	return snprintf(buf, PAGE_SIZE, "%d\n", value);
+}
+
+static ssize_t ltc4261_show_bool(struct device *dev,
+				 struct device_attribute *da,
+				 char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct ltc4261_data *data = ltc4261_update_device(dev);
+	u8 fault;
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	fault = data->regs[LTC4261_FAULT];
+	if (fault & attr->index)    /* Clear reported faults in chip register */
+		i2c_smbus_write_byte_data(client, LTC4261_FAULT,
+					  fault & ~attr->index);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", (fault & attr->index) ? 1 : 0);
+}
+
+/*
+ * These macros are used below in constructing device attribute objects
+ * for use with sysfs_create_group() to make a sysfs device file
+ * for each register.
+ */
+
+#define LTC4261_VALUE(name, ltc4261_cmd_idx) \
+	static SENSOR_DEVICE_ATTR(name, S_IRUGO, \
+	ltc4261_show_value, NULL, ltc4261_cmd_idx)
+
+#define LTC4261_BOOL(name, mask) \
+	static SENSOR_DEVICE_ATTR(name, S_IRUGO, \
+	ltc4261_show_bool, NULL, (mask))
+
+/* Construct a sensor_device_attribute structure for each register */
+
+/* Input voltages */
+LTC4261_VALUE(in1_input, LTC4261_ADIN_H);
+LTC4261_VALUE(in2_input, LTC4261_ADIN2_H);
+
+/*
+ * Voltage alarms. The chip has only one set of voltage alarm input pins.
+ * This set of pins is normally used to detect problems with the first (primary)
+ * voltage, so associate alarms with the first sensor.
+ */
+LTC4261_BOOL(in1_min_alarm, FAULT_UV);
+LTC4261_BOOL(in1_max_alarm, FAULT_OV);
+
+/* Currents (via sense resistor) */
+LTC4261_VALUE(curr1_input, LTC4261_SENSE_H);
+
+/* Overcurrent alarm */
+LTC4261_BOOL(curr1_alarm, FAULT_OC);
+
+/* Finally, construct an array of pointers to members of the above objects,
+ * as required for sysfs_create_group()
+ */
+static struct attribute *ltc4261_attributes[] = {
+	&sensor_dev_attr_in1_input.dev_attr.attr,
+	&sensor_dev_attr_in1_min_alarm.dev_attr.attr,
+	&sensor_dev_attr_in1_max_alarm.dev_attr.attr,
+	&sensor_dev_attr_in2_input.dev_attr.attr,
+
+	&sensor_dev_attr_curr1_input.dev_attr.attr,
+	&sensor_dev_attr_curr1_alarm.dev_attr.attr,
+
+	NULL,
+};
+
+static const struct attribute_group ltc4261_group = {
+	.attrs = ltc4261_attributes,
+};
+
+static int ltc4261_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	struct i2c_adapter *adapter = client->adapter;
+	struct ltc4261_data *data;
+	int ret;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		return -ENODEV;
+
+	if (i2c_smbus_read_byte_data(client, LTC4261_STATUS) < 0) {
+		dev_err(&client->dev, "Failed to read register %d:%02x:%02x\n",
+			adapter->id, client->addr, LTC4261_STATUS);
+		return -ENODEV;
+	}
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
+	/* Clear faults */
+	i2c_smbus_write_byte_data(client, LTC4261_FAULT, 0x00);
+
+	/* Register sysfs hooks */
+	ret = sysfs_create_group(&client->dev.kobj, &ltc4261_group);
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
+	sysfs_remove_group(&client->dev.kobj, &ltc4261_group);
+out_sysfs_create_group:
+	kfree(data);
+out_kzalloc:
+	return ret;
+}
+
+static int ltc4261_remove(struct i2c_client *client)
+{
+	struct ltc4261_data *data = i2c_get_clientdata(client);
+
+	hwmon_device_unregister(data->hwmon_dev);
+	sysfs_remove_group(&client->dev.kobj, &ltc4261_group);
+
+	kfree(data);
+
+	return 0;
+}
+
+static const struct i2c_device_id ltc4261_id[] = {
+	{ "ltc4261", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ltc4261_id);
+
+/* This is the driver that will be inserted */
+static struct i2c_driver ltc4261_driver = {
+	.driver = {
+		.name	= "ltc4261",
+	},
+	.probe		= ltc4261_probe,
+	.remove		= ltc4261_remove,
+	.id_table	= ltc4261_id,
+};
+
+static int __init ltc4261_init(void)
+{
+	return i2c_add_driver(&ltc4261_driver);
+}
+
+static void __exit ltc4261_exit(void)
+{
+	i2c_del_driver(&ltc4261_driver);
+}
+
+MODULE_AUTHOR("Guenter Roeck>");
+MODULE_DESCRIPTION("LTC4261 driver");
+MODULE_LICENSE("GPL");
+
+module_init(ltc4261_init);
+module_exit(ltc4261_exit);
-- 
1.7.0.87.g0901d


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
