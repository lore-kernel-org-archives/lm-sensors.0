From: Ben Hutchings <bhutchings@solarflare.com>
Date: Wed, 04 Jun 2008 18:47:00 +0000
Subject: [lm-sensors] [PATCH 2/2] max664x: New driver for Maxim
Message-Id: <20080604184659.GH11300@solarflare.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The MAX6647 hardware monitor is used on the Solarflare 10GBASE-T reference
design.  The 6646 and 6649 are nearly identical to it.

This new-style driver is configurable using platform_data and provides
functions to poll sensor values, similarly to the modified lm87 driver.

Signed-off-by: Ben Hutchings <bhutchings@solarflare.com>
---
 drivers/hwmon/Kconfig   |   10 ++
 drivers/hwmon/Makefile  |    1 +
 drivers/hwmon/max664x.c |  353 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/max664x.h |   97 +++++++++++++
 4 files changed, 461 insertions(+), 0 deletions(-)
 create mode 100644 drivers/hwmon/max664x.c
 create mode 100644 include/linux/max664x.h

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 00ff533..fad29c0 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -512,6 +512,16 @@ config SENSORS_MAX1619
 	  This driver can also be built as a module.  If so, the module
 	  will be called max1619.
 
+config SENSORS_MAX664X
+	tristate "Maxim MAX6646/6647/6649 sensor chips"
+	depends on I2C
+	help
+	  If you say yes here you get support for MAX6646/6647/6649
+	  sensor chips.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called max664x.
+
 config SENSORS_MAX6650
 	tristate "Maxim MAX6650 sensor chip"
 	depends on I2C && EXPERIMENTAL
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index d098677..24b907e 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -58,6 +58,7 @@ obj-$(CONFIG_SENSORS_LM90)	+= lm90.o
 obj-$(CONFIG_SENSORS_LM92)	+= lm92.o
 obj-$(CONFIG_SENSORS_LM93)	+= lm93.o
 obj-$(CONFIG_SENSORS_MAX1619)	+= max1619.o
+obj-$(CONFIG_SENSORS_MAX664X)	+= max664x.o
 obj-$(CONFIG_SENSORS_MAX6650)	+= max6650.o
 obj-$(CONFIG_SENSORS_PC87360)	+= pc87360.o
 obj-$(CONFIG_SENSORS_PC87427)	+= pc87427.o
diff --git a/drivers/hwmon/max664x.c b/drivers/hwmon/max664x.c
new file mode 100644
index 0000000..1ea3855
--- /dev/null
+++ b/drivers/hwmon/max664x.c
@@ -0,0 +1,353 @@
+/****************************************************************************
+ * Driver for Maxim MAX6646/6647/6649 sensor chips
+ * Copyright 2008 Solarflare Communications Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation, incorporated herein by reference.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/jiffies.h>
+#include <linux/i2c.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/max664x.h>
+
+/* Data sheet: <http://datasheets.maxim-ic.com/en/ds/MAX6646-MAX6649.pdf> */
+
+#define MAX664X_REG_RLTS	0x00
+#define MAX664X_REG_RRTE	0x01
+#define MAX664X_REG_RSL		0x02
+#define MAX664X_REG_RCL		0x03
+#define MAX664X_REG_RCRA	0x04
+#define MAX664X_REG_RLHN	0x05
+#define MAX664X_REG_RLLI	0x06
+#define MAX664X_REG_RRHI	0x07
+#define MAX664X_REG_RRLS	0x08
+#define MAX664X_REG_WCA		0x09
+#define MAX664X_REG_WCRW	0x0a
+#define MAX664X_REG_WLHO	0x0b
+#define MAX664X_REG_WLLM	0x0c
+#define MAX664X_REG_WRHA	0x0d
+#define MAX664X_REG_WRLN	0x0e
+#define MAX664X_REG_OSHT	0x0f
+#define	MAX664X_REG_REET	0x10
+#define	MAX664X_REG_RIET	0x11
+#define	MAX664X_REG_RWOE	0x19
+#define	MAX664X_REG_RWOI	0x20
+#define	MAX664X_REG_HYS		0x21
+#define	MAX664X_REG_QUEUE	0x22
+#define	MAX664X_REG_MFID	0xfe
+#define	MAX664X_REG_REVID	0xff
+
+struct max664x_data {
+	struct device *hwmon_dev;
+	struct mutex update_lock;
+	int valid;
+	unsigned long last_updated; /* in jiffies */
+	struct max664x_settings set;
+	struct max664x_values val;
+};
+
+#define TEMP_FROM_REG(val) ((val) * 1000)
+#define TEMP_TO_REG(val) ((val) / 1000)
+#define PERIOD_FROM_RATE_REG(val) (16000 >> min_t(int, val, 6))
+#define PERIOD_TO_RATE_REG(val) SENSORS_LIMIT(7 - ffs(val / 250), 0, 6)
+
+static struct max664x_data *max664x_update_device(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct max664x_data *data = i2c_get_clientdata(client);
+
+	mutex_lock(&data->update_lock);
+
+	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
+		data->set.rate +			i2c_smbus_read_byte_data(client, MAX664X_REG_RCRA);
+		data->val.temp_int +			i2c_smbus_read_byte_data(client, MAX664X_REG_RLTS);
+		data->set.temp_int_overt +			i2c_smbus_read_byte_data(client, MAX664X_REG_RWOI);
+		data->set.temp_int_high_alert +			i2c_smbus_read_byte_data(client, MAX664X_REG_RLHN);
+		data->set.temp_int_low_alert +			i2c_smbus_read_byte_data(client, MAX664X_REG_RLLI);
+		data->val.temp_ext +			i2c_smbus_read_byte_data(client, MAX664X_REG_RRTE);
+		data->set.temp_ext_overt +			i2c_smbus_read_byte_data(client, MAX664X_REG_RWOE);
+		data->set.temp_ext_high_alert +			i2c_smbus_read_byte_data(client, MAX664X_REG_RRHI);
+		data->set.temp_ext_low_alert +			i2c_smbus_read_byte_data(client, MAX664X_REG_RRLS);
+		data->set.temp_overt_hyst +			i2c_smbus_read_byte_data(client, MAX664X_REG_HYS);
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
+struct max664x_values *max664x_update_values(struct i2c_client *client)
+{
+	struct max664x_data *data = max664x_update_device(&client->dev);
+	return &data->val;
+}
+EXPORT_SYMBOL(max664x_update_values);
+
+static void
+set_temp_limit(struct device *dev, const char *buf, int offset, int reg)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct max664x_data *data = i2c_get_clientdata(client);
+	long val = simple_strtol(buf, NULL, 10);
+	u8 reg_val = TEMP_TO_REG(val);
+
+	mutex_lock(&data->update_lock);
+	((u8 *)&data->set)[offset] = reg_val;
+	i2c_smbus_write_byte_data(client, reg, reg_val);
+	mutex_unlock(&data->update_lock);
+}
+			   
+#define TEMP_LIMIT_ATTR(where, limit, reg_name)				\
+	static ssize_t							\
+	show_temp_##where##_##limit(struct device *dev,			\
+				    struct device_attribute *attr, char *buf) \
+	{								\
+		struct max664x_data *data = max664x_update_device(dev); \
+		return sprintf(buf, "%u\n",				\
+			       TEMP_FROM_REG(data->set.temp_##where##_##limit)); \
+	}								\
+	static ssize_t							\
+	set_temp_##where##_##limit(struct device *dev,			\
+				   struct device_attribute *attr,	\
+				   const char *buf, size_t count)	\
+	{								\
+		set_temp_limit(dev, buf,				\
+			       offsetof(struct max664x_settings,	\
+					temp_##where##_##limit),	\
+			       MAX664X_REG_##reg_name);			\
+		return count;						\
+	}								\
+	static DEVICE_ATTR(temp_##where##_##limit, S_IRUGO | S_IWUSR,	\
+			   show_temp_##where##_##limit,			\
+			   set_temp_##where##_##limit);
+
+#define TEMP_ATTRS(where, overt_reg, high_alert_reg, low_alert_reg)	\
+	static ssize_t							\
+	show_temp_##where##_input(struct device *dev,			\
+				  struct device_attribute *attr, char *buf) \
+	{								\
+		struct max664x_data *data = max664x_update_device(dev);	\
+		return sprintf(buf, "%u\n",				\
+			       TEMP_FROM_REG(data->val.temp_##where));	\
+	}								\
+	static DEVICE_ATTR(temp_##where##_input, S_IRUGO,		\
+			   show_temp_##where##_input, NULL);		\
+	TEMP_LIMIT_ATTR(where, overt, overt_reg)			\
+	TEMP_LIMIT_ATTR(where, high_alert, high_alert_reg)		\
+	TEMP_LIMIT_ATTR(where, low_alert, low_alert_reg)
+
+TEMP_ATTRS(int, RWOI, WLHO, WLLM)
+TEMP_ATTRS(ext, RWOE, WRHA, WRLN)
+
+static ssize_t
+show_period(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct max664x_data *data = max664x_update_device(dev);
+	return sprintf(buf, "%u\n", PERIOD_FROM_RATE_REG(data->set.rate));
+}
+static ssize_t set_period(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct max664x_data *data = i2c_get_clientdata(client);
+	long val = simple_strtol(buf, NULL, 10);
+	u8 reg_val = PERIOD_TO_RATE_REG(val);
+
+	mutex_lock(&data->update_lock);
+	data->set.rate = reg_val;
+	i2c_smbus_write_byte_data(client, MAX664X_REG_WCRW, reg_val);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+static DEVICE_ATTR(period, S_IRUGO | S_IWUSR, show_period, set_period);
+
+static ssize_t show_temp_overt_hyst(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct max664x_data *data = max664x_update_device(dev);
+	return sprintf(buf, "%u\n", TEMP_FROM_REG(data->set.temp_overt_hyst));
+}
+static ssize_t
+set_temp_overt_hyst(struct device *dev, struct device_attribute *attr,
+		    const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct max664x_data *data = i2c_get_clientdata(client);
+	long val = simple_strtol(buf, NULL, 10);
+	u8 reg_val = TEMP_TO_REG(val);
+
+	mutex_lock(&data->update_lock);
+	data->set.temp_overt_hyst = reg_val;
+	i2c_smbus_write_byte_data(client, MAX664X_REG_HYS, reg_val);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+static DEVICE_ATTR(temp_overt_hyst, S_IRUGO | S_IWUSR,
+		   show_temp_overt_hyst, set_temp_overt_hyst);
+
+/*
+ * Status is read-to-clear, so it is not world-readable and is not
+ * updated with the other fields.
+ */
+static ssize_t show_status(struct device *dev,
+			   struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	int val = i2c_smbus_read_byte_data(client, MAX664X_REG_RSL);
+	return val >= 0 ? sprintf(buf, "0x%x\n", val) : val;
+}
+static DEVICE_ATTR(status, S_IRUSR, show_status, NULL);
+
+int max664x_read_status(struct i2c_client *client)
+{
+	return i2c_smbus_read_byte_data(client, MAX664X_REG_RSL);
+}
+EXPORT_SYMBOL(max664x_read_status);
+
+static struct attribute *max664x_attributes[] = {
+	&dev_attr_temp_int_input.attr,
+	&dev_attr_temp_int_overt.attr,
+	&dev_attr_temp_int_high_alert.attr,
+	&dev_attr_temp_int_low_alert.attr,
+	&dev_attr_temp_ext_input.attr,
+	&dev_attr_temp_ext_overt.attr,
+	&dev_attr_temp_ext_high_alert.attr,
+	&dev_attr_temp_ext_low_alert.attr,
+
+	&dev_attr_period.attr,
+	&dev_attr_temp_overt_hyst.attr,
+	&dev_attr_status.attr,
+
+	NULL
+};
+
+static const struct attribute_group max664x_group = {
+	.attrs = max664x_attributes,
+};
+
+static int
+max664x_probe(struct i2c_client *client, const struct i2c_device_id *id)
+{
+	const struct max664x_platform_data *plat_data +		client->dev.platform_data;
+	struct max664x_data *data;
+	int err;
+
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_BYTE_DATA))
+		return -EIO;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->valid = 0;
+	mutex_init(&data->update_lock);
+	if (plat_data)
+		data->set = plat_data->set;
+	i2c_set_clientdata(client, data);
+
+	if (plat_data && plat_data->set_rate)
+		i2c_smbus_write_byte_data(client, MAX664X_REG_WCRW,
+					  data->set.rate);
+	if (plat_data && plat_data->set_limits) {
+		i2c_smbus_write_byte_data(client, MAX664X_REG_RWOI,
+					  data->set.temp_int_overt);
+		i2c_smbus_write_byte_data(client, MAX664X_REG_WLHO,
+					  data->set.temp_int_high_alert);
+		i2c_smbus_write_byte_data(client, MAX664X_REG_WLLM,
+					  data->set.temp_int_low_alert);
+		i2c_smbus_write_byte_data(client, MAX664X_REG_RWOE,
+					  data->set.temp_ext_overt);
+		i2c_smbus_write_byte_data(client, MAX664X_REG_WRHA,
+					  data->set.temp_ext_high_alert);
+		i2c_smbus_write_byte_data(client, MAX664X_REG_WRLN,
+					  data->set.temp_ext_low_alert);
+		i2c_smbus_write_byte_data(client, MAX664X_REG_HYS,
+					  data->set.temp_overt_hyst);
+	}
+
+	err = sysfs_create_group(&client->dev.kobj, &max664x_group);
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
+	sysfs_remove_group(&client->dev.kobj, &max664x_group);
+exit_free:
+	kfree(data);
+	i2c_set_clientdata(client, NULL);
+	return err;
+}
+
+static int max664x_remove(struct i2c_client *client)
+{
+	struct max664x_data *data = i2c_get_clientdata(client);
+
+	hwmon_device_unregister(data->hwmon_dev);
+	sysfs_remove_group(&client->dev.kobj, &max664x_group);
+
+	kfree(data);
+	i2c_set_clientdata(client, NULL);
+	return 0;
+}
+
+static const struct i2c_device_id max664x_id[] = {
+	{ "max6646" },
+	{ "max6647" },
+	{ "max6649" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, max664x_id);
+
+struct i2c_driver max664x_driver = {
+	.driver = {
+		.name	= "max664x",
+	},
+	.probe		= max664x_probe,
+	.remove		= max664x_remove,
+	.id_table	= max664x_id,
+};
+
+static int __init max664x_init(void)
+{
+	return i2c_add_driver(&max664x_driver);
+}
+
+static void __exit max664x_exit(void)
+{
+	i2c_del_driver(&max664x_driver);
+}
+
+MODULE_AUTHOR("Solarflare Communications");
+MODULE_DESCRIPTION("MAX6646/6647/6649 driver");
+MODULE_LICENSE("GPL v2");
+
+module_init(max664x_init);
+module_exit(max664x_exit);
diff --git a/include/linux/max664x.h b/include/linux/max664x.h
new file mode 100644
index 0000000..09e1680
--- /dev/null
+++ b/include/linux/max664x.h
@@ -0,0 +1,97 @@
+/****************************************************************************
+ * Interface to max664x driver
+ * Copyright 2008 Solarflare Communications Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation, incorporated herein by reference.
+ */
+
+#ifndef _MAX664X_H_
+#define _MAX664X_H_
+
+#ifdef __KERNEL__
+
+#include <linux/types.h>
+#include <linux/i2c.h>
+
+/* Status register */
+#define MAX664X_STATUS_IOT	(1 << 0)
+#define MAX664X_STATUS_EOT	(1 << 1)
+#define MAX664X_STATUS_FAULT	(1 << 2)
+#define MAX664X_STATUS_RLOW	(1 << 3)
+#define MAX664X_STATUS_RHIGH	(1 << 4)
+#define MAX664X_STATUS_LLOW	(1 << 5)
+#define MAX664X_STATUS_LHIGH	(1 << 6)
+#define MAX664X_STATUS_BUSY	(1 << 7)
+
+/**
+ * struct max664x_settings - settings for MAX6646/6647/6649 hardware monitor
+ * @rate: Conversion rate setting
+ * @temp_int_overt: Internal/local high temperature to set OVERT
+ * @temp_int_high_alert: Internal/local high temperature to set ALERT
+ * @temp_int_low_alert: Internal/local low temperature to set ALERT
+ * @temp_ext_overt: External/remote high temperature to set OVERT
+ * @temp_ext_high_alert: External/remote high temperature to set ALERT
+ * @temp_ext_low_alert: External/remote low temperature to set ALERT
+ * @temp_overt_hyst: Hysteresis for resetting OVERT
+ *
+ * All values are raw register values.
+ */
+struct max664x_settings {
+	u8 rate;
+	u8 temp_int_overt;
+	u8 temp_int_high_alert;
+	u8 temp_int_low_alert;
+	u8 temp_ext_overt;
+	u8 temp_ext_high_alert;
+	u8 temp_ext_low_alert;
+	u8 temp_overt_hyst;
+};
+
+/**
+ * struct max664x_values - values from MAX6646/6647/6649 hardware monitor
+ * @temp_int: Internal/local temperature
+ * @temp_ext: External/remote temperature
+ *
+ * All values are raw register values.
+ */
+struct max664x_values {
+	u8 temp_int;
+	u8 temp_ext;
+};
+
+/**
+ * struct max664x_platform_data - platform data for MAX6646/6647/6649 hardware monitor
+ * @set_rate: Flag for whether to set rate register
+ * @set_limits: Flag for whether to set limit registers
+ * @set: Settings to be applied depending on the above flags
+ *
+ * This platform data is optional.  If not provided, the driver will
+ * assume that the MAX6646/6647/6649 was properly configured by firmware
+ * or the power-on-reset defaults.
+ */
+struct max664x_platform_data {
+	unsigned set_rate : 1;
+	unsigned set_limits : 1;
+	struct max664x_settings set;
+};
+
+/**
+ * max664x_update_values() - update and return current values
+ * @client: I2C client to which the max664x driver is bound
+ */
+struct max664x_values *max664x_update_values(struct i2c_client *client);
+
+/**
+ * max664x_read_status() - read status register
+ * @client: I2C client to which the max664x driver is bound
+ *
+ * Read the status register, which automatically clears any stuck alarm
+ * bits.
+ */
+int max664x_read_status(struct i2c_client *client);
+
+#endif
+
+#endif

-- 
Ben Hutchings, Senior Software Engineer, Solarflare Communications
Not speaking for my employer; that's the marketing department's job.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
