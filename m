From: <b29983@freescale.com>
Date: Wed, 22 Jun 2011 01:49:21 +0000
Subject: [lm-sensors] [PATCH] hwmon: (zl6100) Add new chip support
Message-Id: <1308707361-15558-1-git-send-email-b29983@freescale.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Tang Yuantian <B29983@freescale.com>

	The ZL6100 is a digital power controller with Power Monitoring support.
	It provides an I2C/SMBus digital interface that enables the user to
	configure all aspects of the device operation as well as monitor the
	input and output parameters. It accepts most standard PMBus commands.
	Four parameters are output here which are Output Current, Output Voltage,
	Local Temperature and Remote Temperature.

	This chip is currently used on some PowerPC platform.

Signed-off-by: Tang Yuantian <b29983@freescale.com>
---
 based on: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
 branch: master

 drivers/hwmon/Kconfig  |    9 +
 drivers/hwmon/Makefile |    1 +
 drivers/hwmon/zl6100.c |  405 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 415 insertions(+), 0 deletions(-)
 create mode 100644 drivers/hwmon/zl6100.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 16db83c..c803185 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -649,6 +649,15 @@ config SENSORS_LM93
 	  This driver can also be built as a module.  If so, the module
 	  will be called lm93.
 
+config SENSORS_ZL6100
+	tristate "Intersil zl6100 and compatibles"
+	depends on I2C
+	help
+	  If you say yes here you get support for Intersil ZL6100 chips.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called zl6100.
+
 config SENSORS_LTC4151
 	tristate "Linear Technology LTC4151"
 	depends on I2C
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 28061cf..b26c192 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -79,6 +79,7 @@ obj-$(CONFIG_SENSORS_LM87)	+= lm87.o
 obj-$(CONFIG_SENSORS_LM90)	+= lm90.o
 obj-$(CONFIG_SENSORS_LM92)	+= lm92.o
 obj-$(CONFIG_SENSORS_LM93)	+= lm93.o
+obj-$(CONFIG_SENSORS_ZL6100)    += zl6100.o
 obj-$(CONFIG_SENSORS_LM95241)	+= lm95241.o
 obj-$(CONFIG_SENSORS_LTC4151)	+= ltc4151.o
 obj-$(CONFIG_SENSORS_LTC4215)	+= ltc4215.o
diff --git a/drivers/hwmon/zl6100.c b/drivers/hwmon/zl6100.c
new file mode 100644
index 0000000..dd83f52
--- /dev/null
+++ b/drivers/hwmon/zl6100.c
@@ -0,0 +1,405 @@
+/*
+ * zl6100.c - Part of lm_sensors, Linux kernel modules for hardware
+ * monitoring. The lm_snesors version should be 3.1.2 or above.
+ *
+ * Copyright (C) 2010-2011 Freescale Semiconductor, Inc.
+ * Author: Yuantian Tang <b29983@freescale.com>
+ *
+ * The ZL6100 is a digital DC-DC controller with Voltage/Current/Temperature
+ * Monitoring functions made by Intersil Americas Inc.
+ * The ZL6100 also can be used as Voltage/Current/Temperature sensor.
+ * It uses the PMBus protocol for communication with a host
+ * controller. Complete datasheet can be obtained from Intersil's website
+ * at:
+ *		http://www.intersil.com/products/deviceinfo.asp?pn=ZL6100
+ *
+ * This driver also supports the ZL2006, ZL2008, ZL8100, ZL2004, ZL2106,
+ * ZL2103 chips made by Intersil. They all use same command which is
+ * defined in Power System Management Protocol Specification
+ * Part II - Command Language.
+ *
+ * Since the zl6100 was the first chipset supported by this driver, most
+ * comments will refer to this chipset, but are actually general and
+ * concern all supported chipsets, unless mentioned otherwise.
+ *
+ * NOTE: If the lm-sensors tool get the value of 0, it is possible that
+ * the zl6100 chip is not ready. It is recommended to retrieve the data again.
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
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/jiffies.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/i2c.h>
+#include <linux/err.h>
+#include <linux/mutex.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+
+/*
+ * zl6100 COMMAND
+ */
+#define VOUT_MODE	0x20	/* get data format */
+#define READ_VOUT	0x8B	/* get the voltage */
+#define READ_IOUT	0x8C	/* get the current */
+#define READ_TEMP1	0x8D	/* get the internal temperature */
+#define READ_TEMP2	0x8E	/* get the external temperature */
+#define VOUT_MAX	0x24	/* get the max voltage */
+
+/*
+ * scale factor to help calculation
+ */
+#define DIVIDE_FACTOR   1000
+
+/*
+ * Client data (each client gets its own)
+ */
+struct zl6100_data {
+	struct device *hwmon_dev;
+	struct mutex update_lock;
+	int valid; /* zero until following fields are valid */
+	unsigned long last_updated; /* in jiffies */
+	u16 volt;		/* output voltage */
+	u16 volt_max;	/* max output voltage */
+	u16 cur;		/* output current */
+	u16 temp1;		/* internal temperature */
+	u16 temp2;		/* external temperature */
+};
+
+/* table for positive exponent = 2^x */
+static unsigned int power_pos[] = {
+	1,					/* 0_0000 => 0 */
+	2,					/* 0_0001 => 1 */
+	4,					/* 0_0010 => 2 */
+	8,					/* 0_0011 => 3 */
+	16,					/* 0_0100 => 4 */
+	32,					/* 0_0101 => 5 */
+	64,					/* 0_0110 => 6 */
+	128,				/* 0_0111 => 7 */
+	256,				/* 0_1000 => 8 */
+	512,				/* 0_1001 => 9 */
+	1024,				/* 0_1010 => 10 */
+	2048,				/* 0_1011 => 11 */
+	4096,				/* 0_1100 => 12 */
+	8192,				/* 0_1101 => 13 */
+	16384,				/* 0_1110 => 14 */
+	32678				/* 0_1111 => 15 */
+};
+
+/*
+ * table for negative exponent.
+ * amplified by 1,000,000 times in order to not lost accuracy.
+ * = 2^(x)*1,000,000.
+ */
+static unsigned int power_neg[] = {
+	15,					/* 1_0000 => 16 (-0) */
+	30,					/* 1_0001 => 17 (-15) */
+	61,					/* 1_0010 => 18 (-14) */
+	122,				/* 1_0011 => 19 (-13) */
+	244,				/* 1_0100 => 20 (-12) */
+	488,				/* 1_0101 => 21 (-11) */
+	976,				/* 1_0110 => 22 (-10) */
+	1953,				/* 1_0111 => 23 (-9) */
+	3906,				/* 1_1000 => 24 (-8) */
+	7812,				/* 1_1001 => 25 (-7) */
+	15625,				/* 1_1010 => 26 (-6) */
+	31250,				/* 1_1011 => 27 (-5) */
+	62500,				/* 1_1100 => 28 (-4) */
+	125000,				/* 1_1101 => 29 (-3) */
+	250000,				/* 1_1110 => 30 (-2) */
+	500000				/* 1_1111 => 31 (-1) */
+};
+
+/*
+ * VOUT LINEAR data format with exponent value -13.
+ * return unit: millivolt
+ */
+static unsigned long voltage_from_u16(u16 vout)
+{
+	unsigned long v;
+
+	v = vout * power_neg[3];
+	v /= DIVIDE_FACTOR;
+
+	return v;
+}
+
+/*
+ * Literal data format.
+ * return unit: milliampere
+ */
+static long current_from_u16(u16 iout)
+{
+	int y, i;
+	long c;
+
+	i = (iout >> 11) & 0xF;
+	if (iout & 0x400)
+		y = -((~(iout - 1)) & 0x3ff);
+	else
+		y = iout & 0x3ff;
+
+	if (iout & 0x8000) {
+		c = y * power_neg[i];
+		c /= DIVIDE_FACTOR;
+	} else {
+		c = y * power_pos[i];
+		c *= DIVIDE_FACTOR;
+	}
+
+	return c;
+}
+
+/*
+ * Literal data format.
+ * return unit: millidegree Celsius
+ */
+static long temp_from_u16(u16 temp)
+{
+	return current_from_u16(temp);
+}
+
+/*
+ * execute the PMbus read command
+ * @client: handle to slave device
+ * @cmd	:	command
+ * @val :	return value.
+ *
+ * return negative errno else zero on success.
+ */
+static int zl6100_read(struct i2c_client *client, u8 cmd, u16 *val)
+{
+	int err = 0;
+
+	/*
+	 * For zl6100, the shortest interval between two read is 2ms.
+	 * So, we sleep 2ms to make sure zl6100 is ready for next read.
+	 */
+	msleep(2);
+	err = i2c_smbus_read_word_data(client, cmd);
+	if (err < 0) {
+		dev_err(&client->dev, "Cmd: %#02x failed (%d)\n",
+				cmd, err);
+		*val = 0;
+		return err;
+	}
+	*val = err;
+
+	return 0;
+}
+
+static struct zl6100_data *zl6100_update_device(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct zl6100_data *data = i2c_get_clientdata(client);
+
+	mutex_lock(&data->update_lock);
+	if (time_after(jiffies, data->last_updated + HZ)
+		|| !data->valid) {
+		int err = 0;
+
+		dev_dbg(&client->dev, "Update zl6100(I2C addr:0x%02hx) data.\n",
+				client->addr);
+		err = zl6100_read(client, READ_VOUT, &data->volt);
+		err |= zl6100_read(client, VOUT_MAX, &data->volt_max);
+		err |= zl6100_read(client, READ_IOUT, &data->cur);
+		err |= zl6100_read(client, READ_TEMP1, &data->temp1);
+		err |= zl6100_read(client, READ_TEMP2, &data->temp2);
+		if (unlikely(err))
+			dev_err(&client->dev, "Update zl6100(I2C addr:0x%#02hx)"
+				"error. Please update again\n", client->addr);
+
+		data->last_updated = jiffies;
+		data->valid = 1;
+	}
+	mutex_unlock(&data->update_lock);
+
+	return data;
+}
+
+/*
+ * call back function to output the voltage value
+ */
+static int show_volt(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct zl6100_data *data = zl6100_update_device(dev);
+	unsigned long volt = voltage_from_u16(data->volt);
+
+	return sprintf(buf, "%lu\n", volt);
+}
+
+/*
+ * call back function to output the max voltage value
+ */
+static int show_volt_max(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct zl6100_data *data = zl6100_update_device(dev);
+	unsigned long volt = voltage_from_u16(data->volt_max);
+
+	return sprintf(buf, "%lu\n", volt);
+}
+
+/*
+ * the call back function to output current value
+ */
+static int show_curr(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct zl6100_data *data = zl6100_update_device(dev);
+	long cur = current_from_u16(data->cur);
+
+	return sprintf(buf, "%ld\n", cur);
+}
+
+/*
+ * the call back function to output internal temperature value
+ */
+static int show_temp_internal(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct zl6100_data *data = zl6100_update_device(dev);
+	long temp = temp_from_u16(data->temp1);
+
+	return sprintf(buf, "%ld\n", temp);
+}
+
+/*
+ * the call back function to output external temperature value
+ */
+static int show_temp_external(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct zl6100_data *data = zl6100_update_device(dev);
+	long temp = temp_from_u16(data->temp2);
+
+	return sprintf(buf, "%ld\n", temp);
+}
+
+static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, show_volt, NULL, 0);
+static SENSOR_DEVICE_ATTR(in0_max, S_IRUGO, show_volt_max, NULL, 0);
+static SENSOR_DEVICE_ATTR(curr1_input, S_IRUGO, show_curr, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_internal, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp_external, NULL, 0);
+
+static struct attribute *zl6100_attributes[] = {
+	&sensor_dev_attr_in0_input.dev_attr.attr,
+	&sensor_dev_attr_in0_max.dev_attr.attr,
+	&sensor_dev_attr_curr1_input.dev_attr.attr,
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_temp2_input.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group zl6100_group = {
+	.attrs = zl6100_attributes,
+};
+
+static int zl6100_probe(struct i2c_client *client,
+				const struct i2c_device_id *id)
+{
+	int err;
+	struct zl6100_data *data = NULL;
+
+	data = kzalloc(sizeof(struct zl6100_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, data);
+	mutex_init(&data->update_lock);
+
+	if (!i2c_check_functionality(client->adapter,
+			I2C_FUNC_SMBUS_WORD_DATA |
+			I2C_FUNC_SMBUS_I2C_BLOCK)) {
+		err = -EIO;
+		goto exit_free;
+	}
+
+	err = sysfs_create_group(&client->dev.kobj, &zl6100_group);
+	if (err)
+		goto exit_free;
+
+	data->hwmon_dev = hwmon_device_register(&client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
+		goto exit_remove;
+	}
+
+	pr_info("Zl6100 compatible chip(I2C address:0x%02hx) initialized.\n",
+			client->addr);
+
+	return 0;
+
+exit_remove:
+	sysfs_remove_group(&client->dev.kobj, &zl6100_group);
+exit_free:
+	kfree(data);
+	i2c_set_clientdata(client, NULL);
+	return err;
+}
+
+static int zl6100_remove(struct i2c_client *client)
+{
+	struct zl6100_data *data = i2c_get_clientdata(client);
+
+	hwmon_device_unregister(data->hwmon_dev);
+	sysfs_remove_group(&client->dev.kobj, &zl6100_group);
+	kfree(data);
+	i2c_set_clientdata(client, NULL);
+
+	return 0;
+}
+
+static const struct i2c_device_id zl6100_id[] = {
+	{ "zl6100", 0},
+	{ "zl2006", 0},
+	{ "zl2008", 0},
+	{ "zl8100", 0},
+	{ "zl2004", 0},
+	{ "zl2106", 0},
+	{ "zl2103", 0},
+	{ }
+};
+
+static struct i2c_driver zl6100_driver = {
+	.class	= I2C_CLASS_HWMON,
+	.driver = {
+		.name = "zl6100",
+	},
+	.probe = zl6100_probe,
+	.remove = zl6100_remove,
+	.id_table = zl6100_id,
+};
+
+static int __init zl6100_init(void)
+{
+	return i2c_add_driver(&zl6100_driver);
+}
+
+static void __exit zl6100_exit(void)
+{
+	i2c_del_driver(&zl6100_driver);
+}
+
+MODULE_AUTHOR("Yuantian Tang <b29983@freescale.com>");
+MODULE_DESCRIPTION("Intersil zl6100 driver");
+MODULE_LICENSE("GPL");
+
+module_init(zl6100_init);
+module_exit(zl6100_exit);
-- 
1.6.4



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
