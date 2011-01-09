From: Roland Stigge <stigge@antcom.de>
Date: Sun, 09 Jan 2011 11:34:08 +0000
Subject: Re: [lm-sensors] [PATCH] Support for DS620
Message-Id: <4D299D30.1060105@antcom.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------020103010007020005040104"
List-Id: <lm-sensors.vger.kernel.org>
References: <4D0FB795.3010006@antcom.de>
In-Reply-To: <4D0FB795.3010006@antcom.de>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------020103010007020005040104
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 09/01/11 04:59, Guenter Roeck wrote:
>> HWMON driver for Dallas Semiconductor DS620 temperature sensor and thermostat
>>
>> Signed-off-by: Roland Stigge <stigge@antcom.de>
>>
> Almost ... see below.

Update attached. :-)

bye,
  Roland

--------------020103010007020005040104
Content-Type: text/x-patch;
 name="ds620.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ds620.patch"

diff --git a/Documentation/hwmon/ds620 b/Documentation/hwmon/ds620
new file mode 100644
index 0000000..1fbe3cd
--- /dev/null
+++ b/Documentation/hwmon/ds620
@@ -0,0 +1,34 @@
+Kernel driver ds620
+===================
+
+Supported chips:
+  * Dallas Semiconductor DS620
+    Prefix: 'ds620'
+    Datasheet: Publicly available at the Dallas Semiconductor website
+               http://www.dalsemi.com/
+
+Authors:
+        Roland Stigge <stigge@antcom.de>
+        based on ds1621.c by
+        Christian W. Zuckschwerdt <zany@triq.net>
+
+Description
+-----------
+
+The DS620 is a (one instance) digital thermometer and thermostat. It has both
+high and low temperature limits which can be user defined (i.e.  programmed
+into non-volatile on-chip registers). Temperature range is -55 degree Celsius
+to +125. Between 0 and 70 degree Celsius, accuracy is 0.5 Kelvin. The value
+returned via sysfs displays post decimal positions.
+
+The thermostat function works as follows: When configured via platform_data
+(struct ds620_platform_data) .pomode == 0 (default), the thermostat output pin
+PO is always low. If .pomode == 1, the thermostat is in PO_LOW mode. I.e., the
+output pin PO becomes active when the temperature falls below temp1_min and
+stays active until the temperature goes above temp1_max.
+
+Likewise, with .pomode == 2, the thermostat is in PO_HIGH mode. I.e., the PO
+output pin becomes active when the temperature goes above temp1_max and stays
+active until the temperature falls below temp1_min.
+
+The PO output pin of the DS620 operates active-low.
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index a56f6ad..700389a 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -274,6 +274,16 @@ config SENSORS_ATXP1
 	  This driver can also be built as a module.  If so, the module
 	  will be called atxp1.
 
+config SENSORS_DS620
+	tristate "Dallas Semiconductor DS620"
+	depends on I2C
+	help
+	  If you say yes here you get support for Dallas Semiconductor
+	  DS620 sensor chip.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called ds620.
+
 config SENSORS_DS1621
 	tristate "Dallas Semiconductor DS1621 and DS1625"
 	depends on I2C
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 2479b3d..42542d7 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -41,6 +41,7 @@ obj-$(CONFIG_SENSORS_ATXP1)	+= atxp1.o
 obj-$(CONFIG_SENSORS_CORETEMP)	+= coretemp.o
 obj-$(CONFIG_SENSORS_PKGTEMP)	+= pkgtemp.o
 obj-$(CONFIG_SENSORS_DME1737)	+= dme1737.o
+obj-$(CONFIG_SENSORS_DS620)	+= ds620.o
 obj-$(CONFIG_SENSORS_DS1621)	+= ds1621.o
 obj-$(CONFIG_SENSORS_EMC1403)	+= emc1403.o
 obj-$(CONFIG_SENSORS_EMC2103)	+= emc2103.o
diff --git a/drivers/hwmon/ds620.c b/drivers/hwmon/ds620.c
new file mode 100644
index 0000000..257957c
--- /dev/null
+++ b/drivers/hwmon/ds620.c
@@ -0,0 +1,337 @@
+/*
+ *  ds620.c - Support for temperature sensor and thermostat DS620
+ *
+ *  Copyright (C) 2010, 2011 Roland Stigge <stigge@antcom.de>
+ *
+ *  based on ds1621.c by Christian W. Zuckschwerdt  <zany@triq.net>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
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
+#include <linux/i2c/ds620.h>
+
+/*
+ * Many DS620 constants specified below
+ *  15   14   13   12   11   10   09    08
+ * |Done|NVB |THF |TLF |R1  |R0  |AUTOC|1SHOT|
+ *
+ *  07   06   05   04   03   02   01    00
+ * |PO2 |PO1 |A2  |A1  |A0  |    |     |     |
+ */
+#define DS620_REG_CONFIG_DONE		0x8000
+#define DS620_REG_CONFIG_NVB		0x4000
+#define DS620_REG_CONFIG_THF		0x2000
+#define DS620_REG_CONFIG_TLF		0x1000
+#define DS620_REG_CONFIG_R1		0x0800
+#define DS620_REG_CONFIG_R0		0x0400
+#define DS620_REG_CONFIG_AUTOC		0x0200
+#define DS620_REG_CONFIG_1SHOT		0x0100
+#define DS620_REG_CONFIG_PO2		0x0080
+#define DS620_REG_CONFIG_PO1		0x0040
+#define DS620_REG_CONFIG_A2		0x0020
+#define DS620_REG_CONFIG_A1		0x0010
+#define DS620_REG_CONFIG_A0		0x0008
+
+/* The DS620 registers */
+static const u8 DS620_REG_TEMP[3] = {
+	0xAA,			/* input, word, RO */
+	0xA2,			/* min, word, RW */
+	0xA0,			/* max, word, RW */
+};
+
+#define DS620_REG_CONF		0xAC	/* word, RW */
+#define DS620_COM_START		0x51	/* no data */
+#define DS620_COM_STOP		0x22	/* no data */
+
+/* Each client has this additional data */
+struct ds620_data {
+	struct device *hwmon_dev;
+	struct mutex update_lock;
+	char valid;		/* !=0 if following fields are valid */
+	unsigned long last_updated;	/* In jiffies */
+
+	u16 temp[3];		/* Register values, word */
+};
+
+/*
+ *  Temperature registers are word-sized.
+ *  DS620 uses a high-byte first convention, which is exactly opposite to
+ *  the SMBus standard.
+ */
+static int ds620_read_temp(struct i2c_client *client, u8 reg)
+{
+	int ret;
+
+	ret = i2c_smbus_read_word_data(client, reg);
+	if (ret < 0)
+		return ret;
+	return swab16(ret);
+}
+
+static int ds620_write_temp(struct i2c_client *client, u8 reg, u16 value)
+{
+	return i2c_smbus_write_word_data(client, reg, swab16(value));
+}
+
+static void ds620_init_client(struct i2c_client *client)
+{
+	struct ds620_platform_data *ds620_info = client->dev.platform_data;
+	u16 conf, new_conf;
+
+	new_conf = conf =
+	    swab16(i2c_smbus_read_word_data(client, DS620_REG_CONF));
+
+	/* switch to continuous conversion mode */
+	new_conf &= ~DS620_REG_CONFIG_1SHOT;
+	/* already high at power-on, but don't trust the BIOS! */
+	new_conf |= DS620_REG_CONFIG_PO2;
+	/* thermostat mode according to platform data */
+	if (ds620_info && ds620_info->pomode == 1)
+		new_conf &= ~DS620_REG_CONFIG_PO1; /* PO_LOW */
+	else if (ds620_info && ds620_info->pomode == 2)
+		new_conf |= DS620_REG_CONFIG_PO1; /* PO_HIGH */
+	else
+		new_conf &= ~DS620_REG_CONFIG_PO2; /* always low */
+	/* with highest precision */
+	new_conf |= DS620_REG_CONFIG_R1 | DS620_REG_CONFIG_R0;
+
+	if (conf != new_conf)
+		i2c_smbus_write_word_data(client, DS620_REG_CONF,
+					  swab16(new_conf));
+
+	/* start conversion */
+	i2c_smbus_write_byte(client, DS620_COM_START);
+}
+
+static struct ds620_data *ds620_update_client(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct ds620_data *data = i2c_get_clientdata(client);
+	struct ds620_data *ret = data;
+
+	mutex_lock(&data->update_lock);
+
+	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
+	    || !data->valid) {
+		int i;
+		int res;
+
+		dev_dbg(&client->dev, "Starting ds620 update\n");
+
+		for (i = 0; i < ARRAY_SIZE(data->temp); i++) {
+			res = ds620_read_temp(client,
+					      DS620_REG_TEMP[i]);
+			if (res < 0) {
+				ret = ERR_PTR(res);
+				goto abort;
+			}
+
+			data->temp[i] = res;
+		}
+
+		data->last_updated = jiffies;
+		data->valid = 1;
+	}
+abort:
+	mutex_unlock(&data->update_lock);
+
+	return ret;
+}
+
+static ssize_t show_temp(struct device *dev, struct device_attribute *da,
+			 char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct ds620_data *data = ds620_update_client(dev);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	return sprintf(buf, "%d\n", ((data->temp[attr->index] / 8) * 625) / 10);
+}
+
+static ssize_t set_temp(struct device *dev, struct device_attribute *da,
+			const char *buf, size_t count)
+{
+	int res;
+	long val;
+
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct ds620_data *data = i2c_get_clientdata(client);
+
+	res = strict_strtol(buf, 10, &val);
+
+	if (res)
+		return res;
+
+	val = (val * 10 / 625) * 8;
+
+	mutex_lock(&data->update_lock);
+	data->temp[attr->index] = val;
+	ds620_write_temp(client, DS620_REG_TEMP[attr->index],
+			 data->temp[attr->index]);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static ssize_t show_alarm(struct device *dev, struct device_attribute *da,
+			  char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct ds620_data *data = ds620_update_client(dev);
+	struct i2c_client *client = to_i2c_client(dev);
+	u16 conf, new_conf;
+	int res;
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	/* reset alarms if necessary */
+	res = i2c_smbus_read_word_data(client, DS620_REG_CONF);
+	if (res < 0)
+		return res;
+
+	conf = swab16(res);
+	new_conf = conf;
+	new_conf &= ~attr->index;
+	if (conf != new_conf) {
+		res = i2c_smbus_write_word_data(client, DS620_REG_CONF,
+						swab16(new_conf));
+		if (res < 0)
+			return res;
+	}
+
+	return sprintf(buf, "%d\n", !!(conf & attr->index));
+}
+
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO, show_temp, set_temp, 1);
+static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp, set_temp, 2);
+static SENSOR_DEVICE_ATTR(temp1_min_alarm, S_IRUGO, show_alarm, NULL,
+			  DS620_REG_CONFIG_TLF);
+static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_alarm, NULL,
+			  DS620_REG_CONFIG_THF);
+
+static struct attribute *ds620_attributes[] = {
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_temp1_min.dev_attr.attr,
+	&sensor_dev_attr_temp1_max.dev_attr.attr,
+	&sensor_dev_attr_temp1_min_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group ds620_group = {
+	.attrs = ds620_attributes,
+};
+
+static int ds620_probe(struct i2c_client *client,
+		       const struct i2c_device_id *id)
+{
+	struct ds620_data *data;
+	int err;
+
+	data = kzalloc(sizeof(struct ds620_data), GFP_KERNEL);
+	if (!data) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	i2c_set_clientdata(client, data);
+	mutex_init(&data->update_lock);
+
+	/* Initialize the DS620 chip */
+	ds620_init_client(client);
+
+	/* Register sysfs hooks */
+	err = sysfs_create_group(&client->dev.kobj, &ds620_group);
+	if (err)
+		goto exit_free;
+
+	data->hwmon_dev = hwmon_device_register(&client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
+		goto exit_remove_files;
+	}
+
+	dev_info(&client->dev, "temperature sensor found\n");
+
+	return 0;
+
+exit_remove_files:
+	sysfs_remove_group(&client->dev.kobj, &ds620_group);
+exit_free:
+	kfree(data);
+exit:
+	return err;
+}
+
+static int ds620_remove(struct i2c_client *client)
+{
+	struct ds620_data *data = i2c_get_clientdata(client);
+
+	hwmon_device_unregister(data->hwmon_dev);
+	sysfs_remove_group(&client->dev.kobj, &ds620_group);
+
+	kfree(data);
+
+	return 0;
+}
+
+static const struct i2c_device_id ds620_id[] = {
+	{"ds620", 0},
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, ds620_id);
+
+/* This is the driver that will be inserted */
+static struct i2c_driver ds620_driver = {
+	.class = I2C_CLASS_HWMON,
+	.driver = {
+		   .name = "ds620",
+	},
+	.probe = ds620_probe,
+	.remove = ds620_remove,
+	.id_table = ds620_id,
+};
+
+static int __init ds620_init(void)
+{
+	return i2c_add_driver(&ds620_driver);
+}
+
+static void __exit ds620_exit(void)
+{
+	i2c_del_driver(&ds620_driver);
+}
+
+MODULE_AUTHOR("Roland Stigge <stigge@antcom.de>");
+MODULE_DESCRIPTION("DS620 driver");
+MODULE_LICENSE("GPL");
+
+module_init(ds620_init);
+module_exit(ds620_exit);
diff --git a/include/linux/i2c/ds620.h b/include/linux/i2c/ds620.h
new file mode 100644
index 0000000..736bb87
--- /dev/null
+++ b/include/linux/i2c/ds620.h
@@ -0,0 +1,21 @@
+#ifndef _LINUX_DS620_H
+#define _LINUX_DS620_H
+
+#include <linux/types.h>
+#include <linux/i2c.h>
+
+/* platform data for the DS620 temperature sensor and thermostat */
+
+struct ds620_platform_data {
+	/*
+	 *  Thermostat output pin PO mode:
+	 *  0 = always low (default)
+	 *  1 = PO_LOW
+	 *  2 = PO_HIGH
+	 *
+	 * (see Documentation/hwmon/ds620)
+	 */
+	int pomode;
+};
+
+#endif /* _LINUX_DS620_H */

--------------020103010007020005040104
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------020103010007020005040104--
