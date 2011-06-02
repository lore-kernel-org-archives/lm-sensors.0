From: David George <david.george@ska.ac.za>
Date: Thu, 02 Jun 2011 13:26:20 +0000
Subject: [lm-sensors] [PATCH] hwmon: new max1668 driver
Message-Id: <20110602132620.GC4230@lapster.kat.ac.za>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter.

Hopefully this is more to your liking. I have made the changes you recommended,
except adding max1668_sysfs_cleanup(). I didn't 100% follow how it would help.

Thanks again for your time and vigilant eye.

Regards,
David

This patch adds support for MAX1668 and compatible temperature sensors.
Signed-off-by: David George <david.george@ska.ac.za>
--- a/drivers/hwmon/Makefile	2011-06-01 14:40:48.000000000 +0200
+++ b/drivers/hwmon/Makefile	2011-06-01 14:46:20.000000000 +0200
@@ -85,6 +85,7 @@ obj-$(CONFIG_SENSORS_LTC4245)	+= ltc4245
 obj-$(CONFIG_SENSORS_LTC4261)	+= ltc4261.o
 obj-$(CONFIG_SENSORS_MAX1111)	+= max1111.o
 obj-$(CONFIG_SENSORS_MAX1619)	+= max1619.o
+obj-$(CONFIG_SENSORS_MAX1668)	+= max1668.o
 obj-$(CONFIG_SENSORS_MAX6639)	+= max6639.o
 obj-$(CONFIG_SENSORS_MAX6650)	+= max6650.o
 obj-$(CONFIG_SENSORS_MC13783_ADC)+= mc13783-adc.o
--- a/drivers/hwmon/Kconfig	2011-06-01 14:40:48.000000000 +0200
+++ b/drivers/hwmon/Kconfig	2011-06-02 11:55:13.000000000 +0200
@@ -729,6 +729,16 @@ config SENSORS_MAX1619
 	  This driver can also be built as a module.  If so, the module
 	  will be called max1619.
 
+config SENSORS_MAX1668
+	tristate "Maxim MAX1668 and compatibles"
+	depends on I2C && EXPERIMENTAL
+	help
+	  If you say yes here you get support for MAX1668, MAX1989 and
+	  MAX1805 chips.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called max1668.
+
 config SENSORS_MAX6639
 	tristate "Maxim MAX6639 sensor chip"
 	depends on I2C && EXPERIMENTAL
--- a/MAINTAINERS	2011-06-02 13:03:51.000000000 +0200
+++ b/MAINTAINERS	2011-06-02 13:03:59.000000000 +0200
@@ -4090,6 +4090,13 @@ S:	Orphan
 F:	drivers/video/matrox/matroxfb_*
 F:	include/linux/matroxfb.h
 
+MAX1668 TEMPERATURE SENSOR DRIVER
+M:	"David George" <david.george@ska.ac.za>
+L:	lm-sensors@lm-sensors.org
+S:	Maintained
+F:	Documentation/hwmon/max1668
+F:	drivers/hwmon/max1668.c
+
 MAX6650 HARDWARE MONITOR AND FAN CONTROLLER DRIVER
 M:	"Hans J. Koch" <hjk@hansjkoch.de>
 L:	lm-sensors@lm-sensors.org
--- a/drivers/hwmon/max1668.c	1970-01-01 02:00:00.000000000 +0200
+++ b/drivers/hwmon/max1668.c	2011-06-02 14:00:05.000000000 +0200
@@ -0,0 +1,482 @@
+/*
+    Copyright (c) 2011 David George <david.george@ska.ac.za>
+
+    based on adm1021.c
+    some credit to Christoph Scheurer, but largely a rewrite
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+*/
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
+
+/* Addresses to scan */
+static unsigned short max1668_addr_list[] = {
+	0x18, 0x19, 0x1a, 0x29, 0x2a, 0x2b, 0x4c, 0x4d, 0x4e, I2C_CLIENT_END };
+
+/* max1668 registers */
+
+#define MAX1668_REG_TEMP(nr)	(nr)
+#define MAX1668_REG_STAT1	0x05
+#define MAX1668_REG_STAT2	0x06
+#define MAX1668_REG_MAN_ID	0xfe
+#define MAX1668_REG_DEV_ID	0xff
+
+/* limits */
+
+/* write high limits */
+#define MAX1668_REG_LIMH_WR(nr)	(0x13 + 2 * (nr))
+/* write low limits */
+#define MAX1668_REG_LIML_WR(nr)	(0x14 + 2 * (nr))
+/* read high limits */
+#define MAX1668_REG_LIMH_RD(nr)	(0x08 + 2 * (nr))
+/* read low limits */
+#define MAX1668_REG_LIML_RD(nr)	(0x09 + 2 * (nr))
+
+/* manufacturer and device ID Constants */
+#define MAN_ID_MAXIM		0x4d
+#define DEV_ID_MAX1668		0x3
+#define DEV_ID_MAX1805		0x5
+#define DEV_ID_MAX1989		0xb
+
+/* read only mode module parameter */
+static int read_only;
+module_param(read_only, bool, 0);
+
+enum chips { max1668, max1805, max1989 };
+
+struct max1668_data {
+	struct device *hwmon_dev;
+	enum chips type;
+
+	struct mutex update_lock;
+	char valid;		/* !=0 if following fields are valid */
+	unsigned long last_updated;	/* In jiffies */
+
+	/* 1x local and 4x remote */
+	s8 temp_max[5];
+	s8 temp_min[5];
+	s8 temp[5];
+	u16 alarms;
+};
+
+static struct max1668_data *max1668_update_device(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct max1668_data *data = i2c_get_clientdata(client);
+	struct max1668_data *ret = data;
+	s32 val;
+	int i;
+
+	mutex_lock(&data->update_lock);
+
+	if (data->valid && !time_after(jiffies,
+			data->last_updated + HZ + HZ / 2))
+		goto abort;
+
+	for (i = 0; i < 5; i++) {
+		val = i2c_smbus_read_byte_data(client, MAX1668_REG_TEMP(i));
+		if (unlikely(val < 0)) {
+			ret = ERR_PTR(val);
+			goto abort;
+		}
+		data->temp[i] = (s8) val;
+
+		val = i2c_smbus_read_byte_data(client, MAX1668_REG_LIMH_RD(i));
+		if (unlikely(val < 0)) {
+			ret = ERR_PTR(val);
+			goto abort;
+		}
+		data->temp_max[i] = (s8) val;
+
+		val = i2c_smbus_read_byte_data(client, MAX1668_REG_LIML_RD(i));
+		if (unlikely(val < 0)) {
+			ret = ERR_PTR(val);
+			goto abort;
+		}
+		data->temp_min[i] = (s8) val;
+	}
+
+	val = i2c_smbus_read_byte_data(client, MAX1668_REG_STAT1);
+	if (unlikely(val < 0)) {
+		ret = ERR_PTR(val);
+		goto abort;
+	}
+	data->alarms &= 0x00ff;
+	data->alarms |= ((u8) (val & 0x60)) << 8;
+
+	val = i2c_smbus_read_byte_data(client, MAX1668_REG_STAT2);
+	if (unlikely(val < 0)) {
+		ret = ERR_PTR(val);
+		goto abort;
+	}
+	data->alarms &= 0xff00;
+	data->alarms |= ((u8) val);
+
+	data->last_updated = jiffies;
+	data->valid = 1;
+abort:
+	mutex_unlock(&data->update_lock);
+
+	return ret;
+}
+
+static ssize_t show_temp(struct device *dev,
+			 struct device_attribute *devattr, char *buf)
+{
+	int index = to_sensor_dev_attr(devattr)->index;
+	struct max1668_data *data = max1668_update_device(dev);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	return sprintf(buf, "%d\n", data->temp[index] * 1000);
+}
+
+static ssize_t show_temp_max(struct device *dev,
+			     struct device_attribute *devattr, char *buf)
+{
+	int index = to_sensor_dev_attr(devattr)->index;
+	struct max1668_data *data = max1668_update_device(dev);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	return sprintf(buf, "%d\n", data->temp_max[index] * 1000);
+}
+
+static ssize_t show_temp_min(struct device *dev,
+			     struct device_attribute *devattr, char *buf)
+{
+	int index = to_sensor_dev_attr(devattr)->index;
+	struct max1668_data *data = max1668_update_device(dev);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	return sprintf(buf, "%d\n", data->temp_min[index] * 1000);
+}
+
+static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	int index = to_sensor_dev_attr(attr)->index;
+	struct max1668_data *data = max1668_update_device(dev);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	return sprintf(buf, "%u\n", (data->alarms >> index) & 0x1);
+}
+
+static ssize_t set_temp_max(struct device *dev,
+			    struct device_attribute *devattr,
+			    const char *buf, size_t count)
+{
+	int index = to_sensor_dev_attr(devattr)->index;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct max1668_data *data = i2c_get_clientdata(client);
+	long temp;
+	int ret;
+
+	ret = kstrtol(buf, 10, &temp);
+	if (ret < 0)
+		return ret;
+
+	mutex_lock(&data->update_lock);
+	data->temp_max[index] = SENSORS_LIMIT(temp/1000, -128, 127);
+	if (i2c_smbus_write_byte_data(client,
+					MAX1668_REG_LIMH_WR(index),
+					data->temp_max[index]))
+		count = -EIO;
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+static ssize_t set_temp_min(struct device *dev,
+			    struct device_attribute *devattr,
+			    const char *buf, size_t count)
+{
+	int index = to_sensor_dev_attr(devattr)->index;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct max1668_data *data = i2c_get_clientdata(client);
+	long temp;
+	int ret;
+
+	ret = kstrtol(buf, 10, &temp);
+	if (ret < 0)
+		return ret;
+
+	mutex_lock(&data->update_lock);
+	data->temp_min[index] = SENSORS_LIMIT(temp/1000, -128, 127);
+	if (i2c_smbus_write_byte_data(client,
+					MAX1668_REG_LIML_WR(index),
+					data->temp_max[index]))
+		count = -EIO;
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp1_max, S_IRUGO, show_temp_max,
+				set_temp_max, 0);
+static SENSOR_DEVICE_ATTR(temp1_min, S_IRUGO, show_temp_min,
+				set_temp_min, 0);
+static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 1);
+static SENSOR_DEVICE_ATTR(temp2_max, S_IRUGO, show_temp_max,
+				set_temp_max, 1);
+static SENSOR_DEVICE_ATTR(temp2_min, S_IRUGO, show_temp_min,
+				set_temp_min, 1);
+static SENSOR_DEVICE_ATTR(temp3_input, S_IRUGO, show_temp, NULL, 2);
+static SENSOR_DEVICE_ATTR(temp3_max, S_IRUGO, show_temp_max,
+				set_temp_max, 2);
+static SENSOR_DEVICE_ATTR(temp3_min, S_IRUGO, show_temp_min,
+				set_temp_min, 2);
+static SENSOR_DEVICE_ATTR(temp4_input, S_IRUGO, show_temp, NULL, 3);
+static SENSOR_DEVICE_ATTR(temp4_max, S_IRUGO, show_temp_max,
+				set_temp_max, 3);
+static SENSOR_DEVICE_ATTR(temp4_min, S_IRUGO, show_temp_min,
+				set_temp_min, 3);
+static SENSOR_DEVICE_ATTR(temp5_input, S_IRUGO, show_temp, NULL, 4);
+static SENSOR_DEVICE_ATTR(temp5_max, S_IRUGO, show_temp_max,
+				set_temp_max, 4);
+static SENSOR_DEVICE_ATTR(temp5_min, S_IRUGO, show_temp_min,
+				set_temp_min, 4);
+
+static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_alarm, NULL, 14);
+static SENSOR_DEVICE_ATTR(temp1_min_alarm, S_IRUGO, show_alarm, NULL, 13);
+static SENSOR_DEVICE_ATTR(temp2_min_alarm, S_IRUGO, show_alarm, NULL, 7);
+static SENSOR_DEVICE_ATTR(temp2_max_alarm, S_IRUGO, show_alarm, NULL, 6);
+static SENSOR_DEVICE_ATTR(temp3_min_alarm, S_IRUGO, show_alarm, NULL, 5);
+static SENSOR_DEVICE_ATTR(temp3_max_alarm, S_IRUGO, show_alarm, NULL, 4);
+static SENSOR_DEVICE_ATTR(temp4_min_alarm, S_IRUGO, show_alarm, NULL, 3);
+static SENSOR_DEVICE_ATTR(temp4_max_alarm, S_IRUGO, show_alarm, NULL, 2);
+static SENSOR_DEVICE_ATTR(temp5_min_alarm, S_IRUGO, show_alarm, NULL, 1);
+static SENSOR_DEVICE_ATTR(temp5_max_alarm, S_IRUGO, show_alarm, NULL, 0);
+
+/* Attributes common to MAX1668, MAX1989 and MAX1805 */
+static struct attribute *max1668_attribute_common[] = {
+	&sensor_dev_attr_temp1_max.dev_attr.attr,
+	&sensor_dev_attr_temp1_min.dev_attr.attr,
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_temp2_max.dev_attr.attr,
+	&sensor_dev_attr_temp2_min.dev_attr.attr,
+	&sensor_dev_attr_temp2_input.dev_attr.attr,
+	&sensor_dev_attr_temp3_max.dev_attr.attr,
+	&sensor_dev_attr_temp3_min.dev_attr.attr,
+	&sensor_dev_attr_temp3_input.dev_attr.attr,
+
+	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp1_min_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp2_max_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp2_min_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp3_max_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp3_min_alarm.dev_attr.attr,
+	NULL
+};
+
+/* Attributes not present on MAX1805 */
+static struct attribute *max1668_attribute_unique[] = {
+	&sensor_dev_attr_temp4_max.dev_attr.attr,
+	&sensor_dev_attr_temp4_min.dev_attr.attr,
+	&sensor_dev_attr_temp4_input.dev_attr.attr,
+	&sensor_dev_attr_temp5_max.dev_attr.attr,
+	&sensor_dev_attr_temp5_min.dev_attr.attr,
+	&sensor_dev_attr_temp5_input.dev_attr.attr,
+
+	&sensor_dev_attr_temp4_max_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp4_min_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp5_max_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp5_min_alarm.dev_attr.attr,
+	NULL
+};
+
+static mode_t max1668_attribute_mode(struct kobject *kobj,
+				     struct attribute *attr, int index)
+{
+	int ret = S_IRUGO;
+	if (read_only)
+		return ret;
+	if (attr = &sensor_dev_attr_temp1_max.dev_attr.attr ||
+	    attr = &sensor_dev_attr_temp2_max.dev_attr.attr ||
+	    attr = &sensor_dev_attr_temp3_max.dev_attr.attr ||
+	    attr = &sensor_dev_attr_temp4_max.dev_attr.attr ||
+	    attr = &sensor_dev_attr_temp5_max.dev_attr.attr ||
+	    attr = &sensor_dev_attr_temp1_min.dev_attr.attr ||
+	    attr = &sensor_dev_attr_temp2_min.dev_attr.attr ||
+	    attr = &sensor_dev_attr_temp3_min.dev_attr.attr ||
+	    attr = &sensor_dev_attr_temp4_min.dev_attr.attr ||
+	    attr = &sensor_dev_attr_temp5_min.dev_attr.attr)
+		ret |= S_IWUSR;
+	return ret;
+}
+
+static const struct attribute_group max1668_group_common = {
+	.attrs = max1668_attribute_common,
+	.is_visible = max1668_attribute_mode
+};
+
+static const struct attribute_group max1668_group_unique = {
+	.attrs = max1668_attribute_unique,
+	.is_visible = max1668_attribute_mode
+};
+
+/* Return 0 if detection is successful, -ENODEV otherwise */
+static int max1668_detect(struct i2c_client *client,
+			  struct i2c_board_info *info)
+{
+	struct i2c_adapter *adapter = client->adapter;
+	const char *type_name;
+	int man_id, dev_id;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		return -ENODEV;
+
+	/* Check for unsupported part */
+	man_id = i2c_smbus_read_byte_data(client, MAX1668_REG_MAN_ID);
+	if (man_id != MAN_ID_MAXIM)
+		return -ENODEV;
+
+	dev_id = i2c_smbus_read_byte_data(client, MAX1668_REG_DEV_ID);
+	if (dev_id < 0)
+		return -ENODEV;
+
+	type_name = NULL;
+	if (dev_id = DEV_ID_MAX1668)
+		type_name = "max1668";
+	else if (dev_id = DEV_ID_MAX1805)
+		type_name = "max1805";
+	else if (dev_id = DEV_ID_MAX1989)
+		type_name = "max1989";
+
+	if (!type_name)
+		return -ENODEV;
+
+	strlcpy(info->type, type_name, I2C_NAME_SIZE);
+
+	return 0;
+}
+
+static int max1668_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	struct i2c_adapter *adapter = client->adapter;
+	struct max1668_data *data;
+	int err;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		return -ENODEV;
+
+	data = kzalloc(sizeof(struct max1668_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, data);
+	data->type = id->driver_data;
+	mutex_init(&data->update_lock);
+
+	/* Register sysfs hooks */
+	err = sysfs_create_group(&client->dev.kobj, &max1668_group_common);
+	if (err)
+		goto error_free;
+
+	if (data->type = max1668 || data->type = max1989) {
+		err = sysfs_create_group(&client->dev.kobj,
+					 &max1668_group_unique);
+		if (err)
+			goto error_sysrem0;
+	}
+
+	data->hwmon_dev = hwmon_device_register(&client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
+		if (data->type = max1668 || data->type = max1989)
+			goto error_sysrem1;
+		else
+			goto error_sysrem0;
+	}
+
+	return 0;
+
+error_sysrem1:
+	sysfs_remove_group(&client->dev.kobj, &max1668_group_unique);
+error_sysrem0:
+	sysfs_remove_group(&client->dev.kobj, &max1668_group_common);
+error_free:
+	kfree(data);
+	return err;
+}
+
+static int max1668_remove(struct i2c_client *client)
+{
+	struct max1668_data *data = i2c_get_clientdata(client);
+
+	hwmon_device_unregister(data->hwmon_dev);
+	if (data->type = max1668 || data->type = max1989)
+		sysfs_remove_group(&client->dev.kobj, &max1668_group_unique);
+
+	sysfs_remove_group(&client->dev.kobj, &max1668_group_common);
+
+	kfree(data);
+	return 0;
+}
+
+static const struct i2c_device_id max1668_id[] = {
+	{ "max1668", max1668 },
+	{ "max1805", max1805 },
+	{ "max1989", max1989 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, max1668_id);
+
+/* This is the driver that will be inserted */
+static struct i2c_driver max1668_driver = {
+	.class = I2C_CLASS_HWMON,
+	.driver = {
+		  .name	= "max1668",
+		  },
+	.probe = max1668_probe,
+	.remove	= max1668_remove,
+	.id_table = max1668_id,
+	.detect	= max1668_detect,
+	.address_list = max1668_addr_list,
+};
+
+static int __init sensors_max1668_init(void)
+{
+	return i2c_add_driver(&max1668_driver);
+}
+
+static void __exit sensors_max1668_exit(void)
+{
+	i2c_del_driver(&max1668_driver);
+}
+
+MODULE_AUTHOR("David George <david.george@ska.ac.za>");
+MODULE_DESCRIPTION("MAX1668 remote temperature sensor driver");
+MODULE_LICENSE("GPL");
+MODULE_PARM_DESC(read_only, "Don't set any values, read only mode");
+
+module_init(sensors_max1668_init)
+module_exit(sensors_max1668_exit)
--- a/Documentation/hwmon/max1668	1970-01-01 02:00:00.000000000 +0200
+++ b/Documentation/hwmon/max1668	2011-06-02 13:51:14.000000000 +0200
@@ -0,0 +1,61 @@
+Kernel driver max1668
+==========+
+Supported chips:
+  * Maxim MAX1668, MAX1805 and MAX1989
+    Prefix: 'max1668'
+    Addresses scanned: I2C 0x18, 0x19, 0x1a, 0x29, 0x2a, 0x2b, 0x4c, 0x4d, 0x4e
+    Datasheet: http://datasheets.maxim-ic.com/en/ds/MAX1668-MAX1989.pdf
+
+Author:
+    David George <david.george@ska.ac.za>
+
+Description
+-----------
+
+This driver implements support for the Maxim MAX1668, MAX1805 and MAX1989
+chips.
+
+The three devices are very similar, but the MAX1805 has a reduced feature
+set; only two remote temperature inputs vs the four avaible on the other
+two ICs.
+
+The driver is able to distinguish between the devices and creates sysfs
+entries as follows:
+
+MAX1805, MAX1668 and MAX1989:
+
+temp1_input     ro local (ambient) temperature
+temp1_max       rw local temperature maximum threshold for alarm
+temp1_max_alarm ro local temperature maximum threshold alarm
+temp1_min       rw local temperature minimum threshold for alarm
+temp1_min_alarm ro local temperature minimum threshold alarm
+temp2_input     ro remote temperature 1
+temp2_max       rw remote temperature 1 maximum threshold for alarm
+temp2_max_alarm ro remote temperature 1 maximum threshold alarm
+temp2_min       rw remote temperature 1 minimum threshold for alarm
+temp2_min_alarm ro remote temperature 1 minimum threshold alarm
+temp3_input     ro remote temperature 2
+temp3_max       rw remote temperature 2 maximum threshold for alarm
+temp3_max_alarm ro remote temperature 2 maximum threshold alarm
+temp3_min       rw remote temperature 2 minimum threshold for alarm
+temp3_min_alarm ro remote temperature 2 minimum threshold alarm
+
+MAX1668 and MAX1989 only:
+temp4_input     ro remote temperature 3
+temp4_max       rw remote temperature 3 maximum threshold for alarm
+temp4_max_alarm ro remote temperature 3 maximum threshold alarm
+temp4_min       rw remote temperature 3 minimum threshold for alarm
+temp4_min_alarm ro remote temperature 3 minimum threshold alarm
+temp5_input     ro remote temperature 4
+temp5_max       rw remote temperature 4 maximum threshold for alarm
+temp5_max_alarm ro remote temperature 4 maximum threshold alarm
+temp5_min       rw remote temperature 4 minimum threshold for alarm
+temp5_min_alarm ro remote temperature 4 minimum threshold alarm
+
+Module Parameters
+-----------------
+
+* read_only: int
+  Set to non-zero if you wish to prevent write access to alarm thresholds.
+


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
