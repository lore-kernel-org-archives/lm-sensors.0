From: Per =?iso-8859-1?Q?Dal=E9n?= <per.dalen@appeartv.com>
Date: Fri, 01 Apr 2011 08:21:05 +0000
Subject: [lm-sensors] [PATCH v2] hwmon: Add support for MAX6642
Message-Id: <54668.79.160.13.2.1301646065.squirrel@webmail.s7.itpays.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

MAX6642 is a SMBus-Compatible Remote/Local Temperature Sensor with
Overtemperature Alarm from Maxim.

Signed-off-by: Per Dalen <per.dalen@appeartv.com>

---
diff --git a/Documentation/hwmon/max6642 b/Documentation/hwmon/max6642
new file mode 100644
index 0000000..afbd3e4
--- /dev/null
+++ b/Documentation/hwmon/max6642
@@ -0,0 +1,21 @@
+Kernel driver max6642
+==========+
+Supported chips:
+  * Maxim MAX6642
+    Prefix: 'max6642'
+    Addresses scanned: I2C 0x48-0x4f
+    Datasheet: Publicly available at the Maxim website
+               http://datasheets.maxim-ic.com/en/ds/MAX6642.pdf
+
+Authors:
+        Per Dalen <per.dalen@appeartv.com>
+
+Description
+-----------
+
+The MAX6642 is a digital temperature sensor. It senses its own
temperature as
+well as the temperature on one external diode.
+
+All temperature values are given in degrees Celsius. Resolution
+is 0.25 degree for the local temperature and for the remote temperature.
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 060ef63..660d031 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -728,6 +728,15 @@ config SENSORS_MAX6639
 	  This driver can also be built as a module.  If so, the module
 	  will be called max6639.

+config SENSORS_MAX6642
+	tristate "Maxim MAX6642 sensor chip"
+	depends on I2C
+	help
+	  If you say yes here you get support for MAX6642 sensor chip.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called max6642.
+
 config SENSORS_MAX6650
 	tristate "Maxim MAX6650 sensor chip"
 	depends on I2C && EXPERIMENTAL
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 967d0ea..2211752 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -85,6 +85,7 @@ obj-$(CONFIG_SENSORS_LTC4261)	+= ltc4261.o
 obj-$(CONFIG_SENSORS_MAX1111)	+= max1111.o
 obj-$(CONFIG_SENSORS_MAX1619)	+= max1619.o
 obj-$(CONFIG_SENSORS_MAX6639)	+= max6639.o
+obj-$(CONFIG_SENSORS_MAX6642)	+= max6642.o
 obj-$(CONFIG_SENSORS_MAX6650)	+= max6650.o
 obj-$(CONFIG_SENSORS_MC13783_ADC)+= mc13783-adc.o
 obj-$(CONFIG_SENSORS_PC87360)	+= pc87360.o
diff --git a/drivers/hwmon/max6642.c b/drivers/hwmon/max6642.c
new file mode 100644
index 0000000..c7739b8
--- /dev/null
+++ b/drivers/hwmon/max6642.c
@@ -0,0 +1,372 @@
+/*
+ * Driver for +/-1 degree C, SMBus-Compatible Remote/Local Temperature
Sensor
+ * with Overtemperature Alarm
+ *
+ * Copyright (C) 2011 AppearTV AS
+ *
+ * Derived from:
+ *
+ *  Based on the max1619 driver.
+ *  Copyright (C) 2003-2004 Alexey Fisher <fishor@mail.ru>
+ *                          Jean Delvare <khali@linux-fr.org>
+ *
+ * The MAX6642 is a sensor chip made by Maxim.
+ * It reports up to two temperatures (its own plus up to
+ * one external one). Complete datasheet can be
+ * obtained from Maxim's website at:
+ *   http://datasheets.maxim-ic.com/en/ds/MAX6642.pdf
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
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/jiffies.h>
+#include <linux/i2c.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/err.h>
+#include <linux/mutex.h>
+#include <linux/sysfs.h>
+
+static const unsigned short normal_i2c[] = {
+	0x48, 0x49, 0x4a, 0x4b, 0x4c, 0x4d, 0x4e, 0x4f, I2C_CLIENT_END };
+
+/*
+ * The MAX6642 registers
+ */
+
+#define MAX6642_REG_R_MAN_ID		0xFE
+#define MAX6642_REG_R_CONFIG		0x03
+#define MAX6642_REG_W_CONFIG		0x09
+#define MAX6642_REG_R_STATUS		0x02
+#define MAX6642_REG_R_LOCAL_TEMP	0x00
+#define MAX6642_REG_R_LOCAL_TEMPL	0x11
+#define MAX6642_REG_R_LOCAL_HIGH	0x05
+#define MAX6642_REG_W_LOCAL_HIGH	0x0B
+#define MAX6642_REG_R_REMOTE_TEMP	0x01
+#define MAX6642_REG_R_REMOTE_TEMPL	0x10
+#define MAX6642_REG_R_REMOTE_HIGH	0x07
+#define MAX6642_REG_W_REMOTE_HIGH	0x0D
+
+/*
+ * Conversions
+ */
+
+static int temp_from_reg10(int val)
+{
+	return val * 250;
+}
+
+static int temp_from_reg(int val)
+{
+	return val * 1000;
+}
+
+static int temp_to_reg(int val)
+{
+	return val / 1000;
+}
+
+/*
+ * Client data (each client gets its own)
+ */
+
+struct max6642_data {
+	struct device *hwmon_dev;
+	struct mutex update_lock;
+	bool valid; /* zero until following fields are valid */
+	unsigned long last_updated; /* in jiffies */
+
+	/* registers values */
+	u16 temp_input1; /* local */
+	u16 temp_high1; /* local */
+	u16 temp_input2; /* remote */
+	u16 temp_high2; /* remote */
+	u8 alarms;
+};
+
+/*
+ * Real code
+ */
+
+static void max6642_init_client(struct i2c_client *client)
+{
+	u8 config;
+
+	/*
+	 * Start the conversions.
+	 */
+	config = i2c_smbus_read_byte_data(client, MAX6642_REG_R_CONFIG);
+	if (config & 0x40)
+		i2c_smbus_write_byte_data(client, MAX6642_REG_W_CONFIG,
+					  config & 0xBF); /* run */
+}
+
+/* Return 0 if detection is successful, -ENODEV otherwise */
+static int max6642_detect(struct i2c_client *client,
+			  struct i2c_board_info *info)
+{
+	struct i2c_adapter *adapter = client->adapter;
+	u8 reg_config, reg_status, man_id;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		return -ENODEV;
+
+	/* identification */
+	man_id = i2c_smbus_read_byte_data(client, MAX6642_REG_R_MAN_ID);
+	if (man_id != 0x4D) {
+		dev_info(&adapter->dev,
+			 "Unsupported chip (man_id=0x%02X).\n",
+			 man_id);
+		return -ENODEV;
+	}
+
+	/* detection */
+	reg_config = i2c_smbus_read_byte_data(client, MAX6642_REG_R_CONFIG);
+	reg_status = i2c_smbus_read_byte_data(client, MAX6642_REG_R_STATUS);
+	if (((reg_config & 0x0f) != 0x00) &&
+	    ((reg_status & 0x2b) != 0x00)) {
+		dev_dbg(&adapter->dev, "MAX6642 detection failed at 0x%02x\n",
+			client->addr);
+		return -ENODEV;
+	}
+
+	strlcpy(info->type, "max6642", I2C_NAME_SIZE);
+
+	return 0;
+}
+
+static struct max6642_data *max6642_update_device(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct max6642_data *data = i2c_get_clientdata(client);
+	u16 val, tmp;
+
+	mutex_lock(&data->update_lock);
+
+	if (time_after(jiffies, data->last_updated + HZ * 8) || !data->valid) {
+		dev_dbg(&client->dev, "Updating max6642 data.\n");
+		val = i2c_smbus_read_byte_data(client,
+					MAX6642_REG_R_LOCAL_TEMPL);
+		tmp = (val >> 6) & 3;
+		val = i2c_smbus_read_byte_data(client,
+					MAX6642_REG_R_LOCAL_TEMP);
+		val = (val << 2) | tmp;
+		data->temp_input1 = val;
+		val = i2c_smbus_read_byte_data(client,
+					MAX6642_REG_R_REMOTE_TEMPL);
+		tmp = (val >> 6) & 3;
+		val = i2c_smbus_read_byte_data(client,
+					MAX6642_REG_R_REMOTE_TEMP);
+		val = (val << 2) | tmp;
+		data->temp_input2 = val;
+		data->temp_high1 = i2c_smbus_read_byte_data(client,
+					MAX6642_REG_R_LOCAL_HIGH);
+		data->temp_high2 = i2c_smbus_read_byte_data(client,
+					MAX6642_REG_R_REMOTE_HIGH);
+		data->alarms = i2c_smbus_read_byte_data(client,
+					MAX6642_REG_R_STATUS);
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
+ * Sysfs stuff
+ */
+
+#define show_temp10(value) \
+static ssize_t show10_##value(struct device *dev, \
+			      struct device_attribute *attr, char *buf) \
+{ \
+	struct max6642_data *data = max6642_update_device(dev); \
+	return sprintf(buf, "%d\n", temp_from_reg10(data->value)); \
+}
+
+show_temp10(temp_input1);
+show_temp10(temp_input2);
+
+#define show_temp(value) \
+static ssize_t show_##value(struct device *dev, struct device_attribute
*attr, \
+			    char *buf) \
+{ \
+	struct max6642_data *data = max6642_update_device(dev); \
+	return sprintf(buf, "%d\n", temp_from_reg(data->value)); \
+}
+
+show_temp(temp_high1);
+show_temp(temp_high2);
+
+#define set_temp(value, reg) \
+static ssize_t set_##value(struct device *dev, struct device_attribute
*attr, \
+			   const char *buf, size_t count) \
+{ \
+	long val, err;					\
+	struct i2c_client *client = to_i2c_client(dev); \
+	struct max6642_data *data = i2c_get_clientdata(client); \
+	err = strict_strtol(buf, 10, &val);				\
+	if (err < 0)				\
+		return err;				\
+\
+	mutex_lock(&data->update_lock); \
+	data->value = temp_to_reg(val); \
+	i2c_smbus_write_byte_data(client, reg, data->value); \
+	mutex_unlock(&data->update_lock); \
+	return count; \
+}
+
+set_temp(temp_high1, MAX6642_REG_W_LOCAL_HIGH);
+set_temp(temp_high2, MAX6642_REG_W_REMOTE_HIGH);
+
+static ssize_t show_alarms(struct device *dev, struct device_attribute
*attr,
+			   char *buf)
+{
+	struct max6642_data *data = max6642_update_device(dev);
+	return sprintf(buf, "%d\n", data->alarms);
+}
+
+static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	int bitnr = to_sensor_dev_attr(attr)->index;
+	struct max6642_data *data = max6642_update_device(dev);
+	return sprintf(buf, "%d\n", (data->alarms >> bitnr) & 1);
+}
+
+static DEVICE_ATTR(temp1_input, S_IRUGO, show10_temp_input1, NULL);
+static DEVICE_ATTR(temp2_input, S_IRUGO, show10_temp_input2, NULL);
+static DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_high1,
+	set_temp_high1);
+static DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_temp_high2,
+	set_temp_high2);
+static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
+static SENSOR_DEVICE_ATTR(temp_fault, S_IRUGO, show_alarm, NULL, 2);
+static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_alarm, NULL, 6);
+static SENSOR_DEVICE_ATTR(temp2_max_alarm, S_IRUGO, show_alarm, NULL, 4);
+
+static struct attribute *max6642_attributes[] = {
+	&dev_attr_temp1_input.attr,
+	&dev_attr_temp2_input.attr,
+	&dev_attr_temp1_max.attr,
+	&dev_attr_temp2_max.attr,
+
+	&dev_attr_alarms.attr,
+	&sensor_dev_attr_temp_fault.dev_attr.attr,
+	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp2_max_alarm.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group max6642_group = {
+	.attrs = max6642_attributes,
+};
+
+static int max6642_probe(struct i2c_client *new_client,
+			 const struct i2c_device_id *id)
+{
+	struct max6642_data *data;
+	int err;
+
+	data = kzalloc(sizeof(struct max6642_data), GFP_KERNEL);
+	if (!data) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	i2c_set_clientdata(new_client, data);
+	data->valid = 0;
+	mutex_init(&data->update_lock);
+
+	/* Initialize the MAX6642 chip */
+	max6642_init_client(new_client);
+
+	/* Register sysfs hooks */
+	err = sysfs_create_group(&new_client->dev.kobj, &max6642_group);
+	if (err)
+		goto exit_free;
+
+	data->hwmon_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
+		goto exit_remove_files;
+	}
+
+	return 0;
+
+exit_remove_files:
+	sysfs_remove_group(&new_client->dev.kobj, &max6642_group);
+exit_free:
+	kfree(data);
+exit:
+	return err;
+}
+
+static int max6642_remove(struct i2c_client *client)
+{
+	struct max6642_data *data = i2c_get_clientdata(client);
+
+	hwmon_device_unregister(data->hwmon_dev);
+	sysfs_remove_group(&client->dev.kobj, &max6642_group);
+
+	kfree(data);
+	return 0;
+}
+
+/*
+ * Driver data (common to all clients)
+ */
+
+static const struct i2c_device_id max6642_id[] = {
+	{ "max6642", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, max6642_id);
+
+static struct i2c_driver max6642_driver = {
+	.class		= I2C_CLASS_HWMON,
+	.driver = {
+		.name	= "max6642",
+	},
+	.probe		= max6642_probe,
+	.remove		= max6642_remove,
+	.id_table	= max6642_id,
+	.detect		= max6642_detect,
+	.address_list	= normal_i2c,
+};
+
+static int __init sensors_max6642_init(void)
+{
+	return i2c_add_driver(&max6642_driver);
+}
+
+static void __exit sensors_max6642_exit(void)
+{
+	i2c_del_driver(&max6642_driver);
+}
+
+MODULE_AUTHOR("Per Dalen <per.dalen@appeartv.com>");
+MODULE_DESCRIPTION("MAX6642 sensor driver");
+MODULE_LICENSE("GPL");
+
+module_init(sensors_max6642_init);
+module_exit(sensors_max6642_exit);



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
