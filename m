From: Hadrien Copponnex <hadrien.copponnex@appeartv.com>
Date: Thu, 21 May 2015 15:26:55 +0000
Subject: [lm-sensors] [PATCH] hwmon: New driver for Texas Instruments TPS2480/TPS2481
Message-Id: <555DF93F.3090909@appeartv.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Attached is a patch which adds hwmon support for Texas Instruments 
TPS2480/TPS2481 current sensor. The code follows the same architecture 
found in other hwmon drivers and should be pretty easy to understand.

The chip reports measured current as the voltage drop across a shunt 
resistor. This value is reported in the curr1_input attribute as 10 uV 
steps. It is then the responsibility of the user to convert back this 
value in amperes to have the correct value (for instance using 
sensors.conf file).

Many parameters affecting the chip operation are exported through sysfs 
interface and thus are available for configuration from userland. Even 
if it is not necessary to configure the chip before usage, there might 
be cases where a user needs to do so.

To apply the patch on the latest kernel, simply type (assuming filename 
<patch>):
git apply --check <patch>

To use the driver, enable the option "SENSORS_TPS2480", in your kernel 
configuration file. I2C/SMBus support is required in your kernel. The 
code has been written in an architecture-independent way, but have only 
been tested on PowerPC architecture (big-endian).

As this is my first patch submitted for the Linux kernel, it is possible 
that the approach I used is not correct, notably the way the driver 
reports current/voltage information and the exported chip parameters. I 
don't know if it is necessary to export that much 
information/configuration for a simple chip like this one, or if I 
should keep it simple, and use the chip in the default configuration.

Please let me know any feedback you have on this patch.

Best regards,
Hadrien Copponnex
R&D Engineer

AppearTV AS
www.appeartv.com

Signed-off-by: Hadrien Copponnex <hadrien.copponnex@appeartv.com>

---
  drivers/hwmon/Kconfig   |   10 ++
  drivers/hwmon/Makefile  |    1 +
  drivers/hwmon/tps2480.c |  386 
+++++++++++++++++++++++++++++++++++++++++++++++
  3 files changed, 397 insertions(+)
  create mode 100644 drivers/hwmon/tps2480.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 25d9e72..7919e7d 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1504,6 +1504,16 @@ config SENSORS_TMP421
  	  This driver can also be built as a module.  If so, the module
  	  will be called tmp421.

+config SENSORS_TPS2480
+	tristate "Texas Instruments TPS2480/2481 (EXPERIMENTAL)"
+	depends on I2C
+	help
+	  If you say yes here you get support for Texas Instruments TPS2480
+	  and TPS2481 sensor chips.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called tps2480.
+
  config SENSORS_TWL4030_MADC
  	tristate "Texas Instruments TWL4030 MADC Hwmon"
  	depends on TWL4030_MADC
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index b4a40f1..b640247 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -145,6 +145,7 @@ obj-$(CONFIG_SENSORS_TMP102)	+= tmp102.o
  obj-$(CONFIG_SENSORS_TMP103)	+= tmp103.o
  obj-$(CONFIG_SENSORS_TMP401)	+= tmp401.o
  obj-$(CONFIG_SENSORS_TMP421)	+= tmp421.o
+obj-$(CONFIG_SENSORS_TPS2480)   += tps2480.o
  obj-$(CONFIG_SENSORS_TWL4030_MADC)+= twl4030-madc-hwmon.o
  obj-$(CONFIG_SENSORS_VEXPRESS)	+= vexpress.o
  obj-$(CONFIG_SENSORS_VIA_CPUTEMP)+= via-cputemp.o
diff --git a/drivers/hwmon/tps2480.c b/drivers/hwmon/tps2480.c
new file mode 100644
index 0000000..caaf847
--- /dev/null
+++ b/drivers/hwmon/tps2480.c
@@ -0,0 +1,386 @@
+/*
+ * Hardware monitoring driver for TI TPS2480 / TPS2481
+ *
+ * Copyright (c) 2014 AppearTV AS
+ *
+ * Relevant documentation:
+ *    http://www.ti.com/lit/ds/symlink/tps2480.pdf
+ *
+ * Parts of this file are based from:
+ *    ltc4151.c (tps2480_update_device function)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/slab.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/jiffies.h>
+
+#define TPS2480_REG_CONFIG        0x00 /* R/W */
+#define TPS2480_REG_SHUNT_VOLTAGE 0x01 /* R   */
+#define TPS2480_REG_BUS_VOLTAGE   0x02 /* R   */
+#define TPS2480_REG_POWER         0x03 /* R   */
+#define TPS2480_REG_CURRENT       0x04 /* R   */
+#define TPS2480_REG_CALIBRATION   0x05 /* R/W */
+#define TPS2480_MAX_REGISTERS     6
+
+struct tps2480_data {
+	struct device  *hwmon_dev;
+	struct mutex    lock;
+	u16             registers[TPS2480_MAX_REGISTERS];
+	unsigned long   last_updated;
+	u8              valid;
+} tps2480_data;
+
+/*
+ * Chip operating functions
+ */
+
+static s32 write_register(struct i2c_client *client, u8 reg, u16 value)
+{
+	s32 err = i2c_smbus_write_word_data(client, reg, cpu_to_le16(value));
+
+	if (err)
+		dev_err(&client->dev, "cannot write i2c command");
+	return err;
+}
+
+static s32 reset_chip(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct tps2480_data *data = i2c_get_clientdata(client);
+
+	mutex_lock(&data->lock);
+	data->valid = 0;
+	mutex_unlock(&data->lock);
+
+	return write_register(client, TPS2480_REG_CONFIG, 1 << 15);
+}
+
+/* returns the driver data associated to the device
+ * in addition, reads the latest status from registers
+ * don't forget to release the lock when you have finished using the data
+ * structure
+ */
+static struct tps2480_data *tps2480_update_device(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct tps2480_data *data = i2c_get_clientdata(client);
+	u8 i;
+
+	mutex_lock(&data->lock);
+
+	if (time_after(jiffies, data->last_updated + HZ + HZ / 2) ||
+		!data->valid) {
+		/* read data and update device structure */
+		for (i = 0; i < TPS2480_MAX_REGISTERS; ++i) {
+			s32 val = i2c_smbus_read_word_data(client, i);
+
+			if (val < 0) {
+				data->valid = 0;
+				goto finish;
+			}
+			data->registers[i] = le16_to_cpu((u16)val);
+		}
+		data->valid = 1;
+		data->last_updated = jiffies;
+	}
+
+finish:
+	return data;
+}
+
+/*
+ * Sysfs callbacks
+ */
+
+static ssize_t perform_show(struct device  *dev, char *buf, u8 reg, 
const u16
+*p, const char *fmt)
+{
+	struct tps2480_data *data = tps2480_update_device(dev);
+	u16 value = data->registers[reg];
+	u8 valid = data->valid;
+
+	mutex_unlock(&data->lock);
+	if (!valid)
+		return -EIO;
+	value = (value >> p[1]) & p[0];
+	return snprintf(buf, PAGE_SIZE, fmt, value);
+}
+
+static ssize_t perform_store(struct device *dev, const char *buf, 
size_t count,
+u8 reg, const u16 *p)
+{
+	struct tps2480_data *data = tps2480_update_device(dev);
+	struct i2c_client *client = to_i2c_client(dev);
+	unsigned long val = 0;
+	ssize_t result = count;
+	s32 err;
+
+	if (kstrtoul(buf, 10, &val) || val > p[0]) {
+		result = -EINVAL;
+		goto finish;
+	}
+
+	data->registers[reg] = (val & p[0]) << p[1];
+
+	err = write_register(client, reg, data->registers[reg]);
+	if (err)
+		result = err;
+
+finish:
+	mutex_unlock(&data->lock);
+
+	return result;
+}
+
+/* Variable parameters
+   [0]: mask
+   [1]: shift */
+static const u16 in0[2] = {0xfff8, 0x01};
+static const u16 cu1[2] = {0xffff, 0x00};
+static const u16 cu2[2] = {0xffff, 0x00};
+static const u16 pow[2] = {0xffff, 0x00};
+static const u16 bvr[2] = {0x0001, 0x0d};
+static const u16 pga[2] = {0x0003, 0x0b};
+static const u16 bad[2] = {0x000f, 0x07};
+static const u16 sad[2] = {0x000f, 0x03};
+static const u16 mod[2] = {0x0007, 0x00};
+static const u16 cal[2] = {0xffff, 0x00};
+
+static ssize_t show_in0(struct device *dev, struct device_attribute 
*attr, char
+*buf)
+{
+	return perform_show(dev, buf, TPS2480_REG_BUS_VOLTAGE, in0, "%hu\n");
+}
+
+static ssize_t show_curr1(struct device *dev, struct device_attribute 
*attr,
+char *buf)
+{
+	return perform_show(dev, buf, TPS2480_REG_SHUNT_VOLTAGE, cu1, "%hd\n");
+}
+
+static ssize_t show_curr2(struct device *dev, struct device_attribute 
*attr,
+char *buf)
+{
+	return perform_show(dev, buf, TPS2480_REG_CURRENT, cu2, "%hd\n");
+}
+
+static ssize_t show_power(struct device *dev, struct device_attribute 
*attr,
+char *buf)
+{
+	return perform_show(dev, buf, TPS2480_REG_POWER, pow, "%hu\n");
+}
+
+static ssize_t store_reset(struct device *dev, struct device_attribute 
*attr,
+const char *buf, size_t count)
+{
+	s32 err = reset_chip(dev);
+
+	return err ? err : count;
+}
+
+static ssize_t show_bus_voltage_range(struct device *dev, struct
+device_attribute *attr, char *buf)
+{
+	return perform_show(dev, buf, TPS2480_REG_CONFIG, bvr, "%hu\n");
+}
+
+static ssize_t store_bus_voltage_range(struct device *dev, struct
+device_attribute *attr, const char *buf, size_t count)
+{
+	return perform_store(dev, buf, count, TPS2480_REG_CONFIG, bvr);
+}
+
+static ssize_t show_pga(struct device *dev, struct device_attribute 
*attr, char
+*buf)
+{
+	return perform_show(dev, buf, TPS2480_REG_CONFIG, pga, "%hu\n");
+}
+
+static ssize_t store_pga(struct device *dev, struct device_attribute *attr,
+const char *buf, size_t count)
+{
+	return perform_store(dev, buf, count, TPS2480_REG_CONFIG, pga);
+}
+
+static ssize_t show_badc(struct device *dev, struct device_attribute *attr,
+char *buf)
+{
+	return perform_show(dev, buf, TPS2480_REG_CONFIG, bad, "%hu\n");
+}
+
+static ssize_t store_badc(struct device *dev, struct device_attribute 
*attr,
+const char *buf, size_t count)
+{
+	return perform_store(dev, buf, count, TPS2480_REG_CONFIG, bad);
+}
+
+static ssize_t show_sadc(struct device *dev, struct device_attribute *attr,
+char *buf)
+{
+	return perform_show(dev, buf, TPS2480_REG_CONFIG, sad, "%hu\n");
+}
+
+static ssize_t store_sadc(struct device *dev, struct device_attribute 
*attr,
+const char *buf, size_t count)
+{
+	return perform_store(dev, buf, count, TPS2480_REG_CONFIG, sad);
+}
+
+static ssize_t show_mode(struct device *dev, struct device_attribute *attr,
+char *buf)
+{
+	return perform_show(dev, buf, TPS2480_REG_CONFIG, mod, "%hu\n");
+}
+
+static ssize_t store_mode(struct device *dev, struct device_attribute 
*attr,
+const char *buf, size_t count)
+{
+	return perform_store(dev, buf, count, TPS2480_REG_CONFIG, mod);
+}
+
+static ssize_t show_calibration(struct device *dev, struct device_attribute
+*attr, char *buf)
+{
+	return perform_show(dev, buf, TPS2480_REG_CALIBRATION, cal, "%hu\n");
+}
+
+static ssize_t store_calibration(struct device *dev, struct 
device_attribute
+*attr, const char  *buf, size_t count)
+{
+	return perform_store(dev, buf, count, TPS2480_REG_CALIBRATION, cal);
+}
+
+static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, show_in0, NULL, 0); /* Bus
+voltage */
+static SENSOR_DEVICE_ATTR(curr1_input, S_IRUGO, show_curr1, NULL, 1); 
/* Shunt
+voltage */
+static SENSOR_DEVICE_ATTR(curr2_input, S_IRUGO, show_curr2, NULL, 1); /*
+Current */
+static SENSOR_DEVICE_ATTR(power_input, S_IRUGO, show_power, NULL, 1); /*
+Power */
+static SENSOR_DEVICE_ATTR(reset, S_IWUSR, NULL, store_reset, 0); /* 
Reset */
+static SENSOR_DEVICE_ATTR(bus_voltage_range, S_IRUGO | S_IWUSR,
+show_bus_voltage_range, store_bus_voltage_range, 0); /* Bus voltage 
range */
+static SENSOR_DEVICE_ATTR(pga, S_IRUGO | S_IWUSR, show_pga, store_pga, 
0); /*
+PGA */
+static SENSOR_DEVICE_ATTR(badc, S_IRUGO | S_IWUSR, show_badc, 
store_badc, 0);
+/* BADC */
+static SENSOR_DEVICE_ATTR(sadc, S_IRUGO | S_IWUSR, show_sadc, 
store_sadc, 0);
+/* SADC */
+static SENSOR_DEVICE_ATTR(mode, S_IRUGO | S_IWUSR, show_mode, 
store_mode, 0);
+/* Mode */
+static SENSOR_DEVICE_ATTR(calibration, S_IRUGO | S_IWUSR, show_calibration,
+store_calibration, 0); /* Calibration */
+
+static struct attribute *tps2480_attrs[] = {
+	&sensor_dev_attr_in0_input.dev_attr.attr,
+	&sensor_dev_attr_curr1_input.dev_attr.attr,
+	&sensor_dev_attr_curr2_input.dev_attr.attr,
+	&sensor_dev_attr_power_input.dev_attr.attr,
+	&sensor_dev_attr_reset.dev_attr.attr,
+	&sensor_dev_attr_bus_voltage_range.dev_attr.attr,
+	&sensor_dev_attr_pga.dev_attr.attr,
+	&sensor_dev_attr_badc.dev_attr.attr,
+	&sensor_dev_attr_sadc.dev_attr.attr,
+	&sensor_dev_attr_mode.dev_attr.attr,
+	&sensor_dev_attr_calibration.dev_attr.attr,
+	NULL
+};
+
+static struct attribute_group tps2480_attr_grp = {
+	.attrs = tps2480_attrs,
+};
+
+/*
+ * Driver interface functions
+ */
+
+static int tps2480_probe(struct i2c_client *client, const struct 
i2c_device_id
+*id)
+{
+	struct tps2480_data *data;
+	int err;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA |
+I2C_FUNC_SMBUS_WORD_DATA)) {
+		dev_err(&client->dev, "i2c adapter doesn't support smbus");
+		return -EOPNOTSUPP;
+	}
+
+	data = devm_kzalloc(&client->dev,
+						sizeof(struct tps2480_data),
+						GFP_KERNEL);
+	if (data = NULL) {
+		dev_err(&client->dev, "cannot allocate memory");
+		return -ENOMEM;
+	}
+	i2c_set_clientdata(client, data);
+
+	mutex_init(&data->lock);
+
+	err = sysfs_create_group(&client->dev.kobj, &tps2480_attr_grp);
+	if (err) {
+		dev_err(&client->dev, "error creating sysfs attribute group");
+		return err;
+	}
+
+	data->hwmon_dev = hwmon_device_register(&client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
+		dev_err(&client->dev, "error registering hwmon device");
+		sysfs_remove_group(&client->dev.kobj, &tps2480_attr_grp);
+		return err;
+	}
+
+	return 0;
+}
+
+static int tps2480_remove(struct i2c_client *client)
+{
+	struct tps2480_data *data = i2c_get_clientdata(client);
+
+	hwmon_device_unregister(data->hwmon_dev);
+	sysfs_remove_group(&client->dev.kobj, &tps2480_attr_grp);
+
+	return 0;
+}
+
+static const struct i2c_device_id tps2480_id[] = {
+	{"tps2480", 0},
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, tps2480_id);
+
+static struct i2c_driver tps2480_driver = {
+	.class = I2C_CLASS_HWMON,
+	.driver = {
+		   .name = "tps2480",
+		   },
+	.probe = tps2480_probe,
+	.remove = tps2480_remove,
+	.id_table = tps2480_id,
+};
+
+module_i2c_driver(tps2480_driver);
+
+MODULE_AUTHOR("Hadrien Copponnex <hadrien.copponnex@appeartv.com>");
+MODULE_DESCRIPTION("I2C/SMBus Driver for TI TPS2480/TPS2481");
+MODULE_LICENSE("GPL");
-- 
1.7.9.5



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
