From: Hartmut Knaack <knaack.h@gmx.de>
Date: Fri, 03 Aug 2012 10:31:24 +0000
Subject: [lm-sensors] [PATCH v2] hwmon: Driver for ADT7410
Message-Id: <501BA87C.2020907@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,
this patch brings basic support for the Analog Devices ADT7410 temperature =
sensor, based on the lm75 hwmon driver and the adt7410 iio driver. Changes =
as suggested by Guenter have been applied. The following functionality has =
been implemented:

  * get current temperature
  * get/set minimum, maximum and critical temperature
  * get/set hysteresis
  * get alarm events for minimum, maximum and critical temperature

All implemented sysfs-symbols have been sucessfully tested at temperatures =
of 15=B0C to 40=B0C.

Signed-off-by: Hartmut Knaack <knaack.h <at> gmx.de>
---
diff --git a/Documentation/hwmon/adt7410 b/Documentation/hwmon/adt7410
new file mode 100644
index 0000000..5ccae11
--- /dev/null
+++ b/Documentation/hwmon/adt7410
@@ -0,0 +1,47 @@
+Kernel driver adt7410
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Supported chips:
+  * Analog Devices ADT7410
+    Prefix: 'adt7410'
+    Addresses scanned: I2C 0x48 - 0x4B
+    Datasheet: Publicly available at the Analog Devices website
+               http://www.analog.com/static/imported-files/data_sheets/ADT=
7410.pdf
+
+Author: Hartmut Knaack <knaack.h <at> gmx.de>
+
+Description
+-----------
+
+The ADT7410 is a temperature sensor with rated temperature range of -55=B0=
C to
++150=B0C. It has a high accuracy of +/-0.5=B0C and can be operated at a re=
solution
+of 13 bits (0.0625=B0C) or 16 bits (0.0078=B0C). The sensor provides an IN=
T pin to
+indicate an excession of a set minimum or maximum temperature, as well as a
+critical temperature (CT) pin to indicate an excession of a set critical
+temperature. Both pins can be set up with a common hysteresis of 0=B0C - 1=
5=B0C
+and a fault queue ranging from 1 to 4 events. Both pins can individually s=
et
+to be active-low or active-high, while the whole device can either run in
+comparator mode or interrupt mode. The ADT7410 supports continous temperat=
ure
+sampling, as well as sampling one temperature value per second or even just
+get one sample on demand for power saving. Besides, it can completely power
+down its ADC, if power management is required.
+
+Configuration Notes
+-------------------
+
+Since the device uses one hysteresis value, which is a delta to minimum,
+maximum and critical temperature, the driver will represent it as
+temp#_max_hyst.
+The device is set to 16 bit resolution and comparator mode by default.
+
+sysfs-Interface
+---------------
+
+temp#_input		- temperature input
+temp#_min		- temperature minimum setpoint
+temp#_max		- temperature maximum setpoint
+temp#_crit		- critical temperature setpoint
+temp#_max_hyst		- hysteresis for temperature maximum
+temp#_min_alarm		- temperature minimum alarm flag
+temp#_max_alarm		- temperature maximum alarm flag
+temp#_crit_alarm	- critical temperature alarm flag
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 6f1d167..7ed1989 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -179,6 +179,16 @@ config SENSORS_ADM9240
 	  This driver can also be built as a module.  If so, the module
 	  will be called adm9240.
=20
+config SENSORS_ADT7410
+	tristate "Analog Devices ADT7410"
+	depends on I2C && EXPERIMENTAL
+	help
+	  If you say yes here you get support for the Analog Devices
+	  ADT7410 temperature monitoring chip.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called adt7410.
+
 config SENSORS_ADT7411
 	tristate "Analog Devices ADT7411"
 	depends on I2C && EXPERIMENTAL
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index e1eeac1..112ce3a 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_SENSORS_ADM9240)	+=3D adm9240.o
 obj-$(CONFIG_SENSORS_ADS1015)	+=3D ads1015.o
 obj-$(CONFIG_SENSORS_ADS7828)	+=3D ads7828.o
 obj-$(CONFIG_SENSORS_ADS7871)	+=3D ads7871.o
+obj-$(CONFIG_SENSORS_ADT7410)	+=3D adt7410.o
 obj-$(CONFIG_SENSORS_ADT7411)	+=3D adt7411.o
 obj-$(CONFIG_SENSORS_ADT7462)	+=3D adt7462.o
 obj-$(CONFIG_SENSORS_ADT7470)	+=3D adt7470.o
diff --git a/drivers/hwmon/adt7410.c b/drivers/hwmon/adt7410.c
new file mode 100644
index 0000000..19dbbf9
--- /dev/null
+++ b/drivers/hwmon/adt7410.c
@@ -0,0 +1,495 @@
+/*
+ * adt7410.c - Part of lm_sensors, Linux kernel modules for hardware
+ *	 monitoring
+ * Hartmut Knaack <knaack.h <at> gmx.de> 2012-07-22
+ * based on lm75.c by Frodo Looijaard <frodol <at> dds.nl>
+ * and adt7410.c from iio-staging by Sonic Zhang <sonic.zhang <at> analog.=
com>
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
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/jiffies.h>
+#include <linux/i2c.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/err.h>
+#include <linux/mutex.h>
+#include <linux/delay.h>
+
+/*
+ * ADT7410 registers definition
+ */
+
+#define ADT7410_TEMPERATURE		0
+#define ADT7410_STATUS			2
+#define ADT7410_CONFIG			3
+#define ADT7410_T_ALARM_HIGH		4
+#define ADT7410_T_ALARM_LOW		6
+#define ADT7410_T_CRIT			8
+#define ADT7410_T_HYST			0xA
+#define ADT7410_ID			0xB
+#define ADT7410_RESET			0x2F
+
+/*
+ * ADT7410 status
+ */
+#define ADT7410_STAT_T_LOW		0x10
+#define ADT7410_STAT_T_HIGH		0x20
+#define ADT7410_STAT_T_CRIT		0x40
+#define ADT7410_STAT_NOT_RDY		0x80
+
+/*
+ * ADT7410 config
+ */
+#define ADT7410_FAULT_QUEUE_MASK	0x3
+#define ADT7410_CT_POLARITY		0x4
+#define ADT7410_INT_POLARITY		0x8
+#define ADT7410_EVENT_MODE		0x10
+#define ADT7410_MODE_MASK		0x60
+#define ADT7410_FULL			0x0
+#define ADT7410_ONESHOT			0x20
+#define ADT7410_SPS			0x40
+#define ADT7410_PD			0x60
+#define ADT7410_RESOLUTION		0x80
+
+/*
+ * ADT7410 masks
+ */
+#define ADT7410_T16_VALUE_SIGN			0x8000
+#define ADT7410_T16_VALUE_FLOAT_OFFSET		7
+#define ADT7410_T16_VALUE_FLOAT_MASK		0x7F
+#define ADT7410_T13_VALUE_MASK			0xFFF8
+#define ADT7410_T_HYST_MASK			0xF
+#define ADT7410_DEVICE_ID_MASK			0x7
+#define ADT7410_DEVICE_ID			0x3
+#define ADT7410_MANUFACTURE_ID_OFFSET		3
+#define ADT7410_MANUFACTURE_ID			0x19
+#define ADT7410_IRQS				2
+
+
+/* straight from the datasheet */
+#define ADT7410_TEMP_MIN (-55000)
+#define ADT7410_TEMP_MAX 150000
+
+/*
+ * This driver handles the ADT7410 and compatible digital temperature sens=
ors.
+ */
+
+enum adt7410_type {		/* keep sorted in alphabetical order */
+	adt7410,
+};
+
+/* Addresses scanned */
+static const unsigned short normal_i2c[] =3D { 0x48, 0x49, 0x4a, 0x4b,
+					I2C_CLIENT_END };
+
+static const u8 ADT7410_REG_TEMP[4] =3D {
+	ADT7410_TEMPERATURE,		/* input */
+	ADT7410_T_ALARM_HIGH,		/* high */
+	ADT7410_T_ALARM_LOW,		/* low */
+	ADT7410_T_CRIT,			/* critical */
+};
+
+/* Each client has this additional data */
+struct adt7410_data {
+	struct device		*hwmon_dev;
+	struct mutex		update_lock;
+	u8			config;
+	bool			valid;		/* !=3D0 if registers valid */
+	unsigned long		last_updated;	/* In jiffies */
+	u16			temp[4];	/* Register values,
+						   0 =3D input
+						   1 =3D high
+						   2 =3D low
+						   3 =3D critical */
+};
+
+/*
+ * adt7410 register access by I2C
+ */
+static int adt7410_temp_ready(struct i2c_client *client)
+{
+	int i, status;
+
+	for (i =3D 0; i < 4; i++) {
+		status =3D i2c_smbus_read_byte_data(client, ADT7410_STATUS);
+		if (status < 0)
+			return status;
+		if (!(status & ADT7410_STAT_NOT_RDY))
+			return 0;
+		msleep(100);
+	}
+	return -EIO;
+}
+
+static struct adt7410_data *adt7410_update_device(struct device *dev)
+{
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct adt7410_data *data =3D i2c_get_clientdata(client);
+	struct adt7410_data *ret =3D data;
+	mutex_lock(&data->update_lock);
+
+	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
+	    || !data->valid) {
+		int i;
+
+		dev_dbg(&client->dev, "Starting adt7410 update\n");
+
+		for (i =3D 0; i < ARRAY_SIZE(data->temp); i++) {
+			int status;
+
+			if (i =3D=3D 0) {/* wait for register be set */
+				status =3D adt7410_temp_ready(client);
+				if (status)
+					return ERR_PTR(status);
+			}
+			status =3D i2c_smbus_read_word_swapped(client,
+							 ADT7410_REG_TEMP[i]);
+			if (unlikely(status < 0)) {
+				dev_dbg(dev,
+					"ADT7410: Failed to read value: reg %d, error %d\n",
+					ADT7410_REG_TEMP[i], status);
+				ret =3D ERR_PTR(status);
+				data->valid =3D 0;
+				goto abort;
+			}
+			data->temp[i] =3D status;
+		}
+		data->last_updated =3D jiffies;
+		data->valid =3D 1;
+	}
+
+abort:
+	mutex_unlock(&data->update_lock);
+	return ret;
+}
+
+static u16 ADT7410_TEMP_TO_REG(long temp)
+{
+	return (u16)((SENSORS_LIMIT(temp, ADT7410_TEMP_MIN,
+				    ADT7410_TEMP_MAX) * 128) / 1000);
+}
+
+static int ADT7410_REG_TO_TEMP(struct adt7410_data *data,
+			       u16 reg)
+{
+	/* in 13 bit mode, bits 0-2 are status flags - mask them out */
+	if (!(data->config & ADT7410_RESOLUTION))
+		reg &=3D ADT7410_T13_VALUE_MASK;
+	/* temperature is stored in twos complement format, in steps of
+	 * 1/128=B0C */
+	return ((int)reg * 1000) / 128;
+}
+
+
+
+/*-----------------------------------------------------------------------*/
+
+/* sysfs attributes for hwmon */
+
+static ssize_t adt7410_show_temp(struct device *dev,
+				 struct device_attribute *da,
+				 char *buf)
+{
+	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(da);
+	struct adt7410_data *data =3D adt7410_update_device(dev);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	return sprintf(buf, "%d\n", ADT7410_REG_TO_TEMP(data,
+		       data->temp[attr->index]));
+}
+
+static ssize_t adt7410_set_temp(struct device *dev,
+				struct device_attribute *da,
+				const char *buf, size_t count)
+{
+	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(da);
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct adt7410_data *data =3D i2c_get_clientdata(client);
+	int nr =3D attr->index;
+	long temp;
+	int ret;
+
+	ret =3D kstrtol(buf, 10, &temp);
+	if (ret)
+		return -EINVAL;
+
+	mutex_lock(&data->update_lock);
+	data->temp[nr] =3D ADT7410_TEMP_TO_REG(temp);
+	i2c_smbus_write_word_swapped(client, ADT7410_REG_TEMP[nr],
+				     data->temp[nr]);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static ssize_t adt7410_show_t_hyst(struct device *dev,
+				   struct device_attribute *da,
+				   char *buf)
+{
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct adt7410_data *data =3D i2c_get_clientdata(client);
+	int ret;
+
+	ret =3D i2c_smbus_read_byte_data(client, ADT7410_T_HYST);
+	if (ret < 0)
+		return ret;
+	/* hysteresis is stored as a 4 bit delta in the device, convert it
+	 * to an absolute value in relation to t_max */
+	return sprintf(buf, "%d\n", ADT7410_REG_TO_TEMP(data, data->temp[1]
+		       - (u16)((ret & ADT7410_T_HYST_MASK) << 7)));
+}
+
+static ssize_t adt7410_set_t_hyst(struct device *dev,
+				  struct device_attribute *da,
+				  const char *buf, size_t count)
+{
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct adt7410_data *data =3D i2c_get_clientdata(client);
+	int ret;
+	long hyst;
+	u8 t_hyst;
+
+	ret =3D kstrtol(buf, 10, &hyst);
+	if ((hyst < ADT7410_TEMP_MIN) || (hyst > ADT7410_TEMP_MAX))
+		return -EINVAL;
+	/* convert absolute hysteresis value to a 4 bit delta value */
+	t_hyst =3D (u8)(((s32)(data->temp[1] * 1000) / 128 - hyst) / 1000);
+	if (ret || (t_hyst > ADT7410_T_HYST_MASK))
+		return -EINVAL;
+
+	ret =3D i2c_smbus_write_byte_data(client, ADT7410_T_HYST, t_hyst);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t adt7410_show_alarm(struct device *dev,
+				  struct device_attribute *da,
+				  char *buf)
+{
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct sensor_device_attribute_2 *attr2 =3D to_sensor_dev_attr_2(da);
+	int ret;
+
+	ret =3D i2c_smbus_read_byte_data(client, ADT7410_STATUS);
+	if (ret < 0)
+		return ret;
+
+	return sprintf(buf, "%d\n", (ret & attr2->nr) ? 1 : 0);
+}
+
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, adt7410_show_temp, NULL, 0=
);
+static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO,
+			  adt7410_show_temp, adt7410_set_temp, 1);
+static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO,
+			  adt7410_show_temp, adt7410_set_temp, 2);
+static SENSOR_DEVICE_ATTR(temp1_crit, S_IWUSR | S_IRUGO,
+			  adt7410_show_temp, adt7410_set_temp, 3);
+static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IWUSR | S_IRUGO,
+			  adt7410_show_t_hyst, adt7410_set_t_hyst, 4);
+static SENSOR_DEVICE_ATTR_2(temp1_min_alarm, S_IRUGO, adt7410_show_alarm,
+			    NULL, ADT7410_STAT_T_LOW, 2);
+static SENSOR_DEVICE_ATTR_2(temp1_max_alarm, S_IRUGO, adt7410_show_alarm,
+			    NULL, ADT7410_STAT_T_HIGH, 1);
+static SENSOR_DEVICE_ATTR_2(temp1_crit_alarm, S_IRUGO, adt7410_show_alarm,
+			    NULL, ADT7410_STAT_T_CRIT, 3);
+
+static struct attribute *adt7410_attributes[] =3D {
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_temp1_max.dev_attr.attr,
+	&sensor_dev_attr_temp1_min.dev_attr.attr,
+	&sensor_dev_attr_temp1_crit.dev_attr.attr,
+	&sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
+	&sensor_dev_attr_temp1_min_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp1_crit_alarm.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group adt7410_group =3D {
+	.attrs =3D adt7410_attributes,
+};
+
+/*-----------------------------------------------------------------------*/
+
+/* device probe and removal */
+
+static int adt7410_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	struct adt7410_data *data;
+	int ret, new;
+
+	if (!i2c_check_functionality(client->adapter,
+			I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA))
+		return -EIO;
+
+	data =3D devm_kzalloc(&client->dev, sizeof(struct adt7410_data),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, data);
+	mutex_init(&data->update_lock);
+
+	/* configure as specified */
+	ret =3D i2c_smbus_read_byte_data(client, ADT7410_CONFIG);
+	if (ret < 0) {
+		dev_dbg(&client->dev, "Can't read config? %d\n", ret);
+		return ret;
+	}
+	data->config =3D ret;
+	/* Set to 16 bit resolution, continous conversion and comparator mode.
+	 * Then tweak to be more precise when appropriate.
+	 */
+	new =3D data->config | ADT7410_FULL | ADT7410_RESOLUTION |
+			ADT7410_EVENT_MODE;
+	if (data->config !=3D new) {
+		i2c_smbus_write_byte_data(client, ADT7410_CONFIG, new);
+		data->config =3D new;
+	}
+	dev_dbg(&client->dev, "Config %02x\n", new);
+
+	/* Register sysfs hooks */
+	ret =3D sysfs_create_group(&client->dev.kobj, &adt7410_group);
+	if (ret)
+		return ret;
+
+	data->hwmon_dev =3D hwmon_device_register(&client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		ret =3D PTR_ERR(data->hwmon_dev);
+		goto exit_remove;
+	}
+
+	dev_info(&client->dev, "%s: sensor '%s'\n",
+		 dev_name(data->hwmon_dev), client->name);
+
+	return 0;
+
+exit_remove:
+	sysfs_remove_group(&client->dev.kobj, &adt7410_group);
+	return ret;
+}
+
+static int adt7410_remove(struct i2c_client *client)
+{
+	struct adt7410_data *data =3D i2c_get_clientdata(client);
+
+	hwmon_device_unregister(data->hwmon_dev);
+	sysfs_remove_group(&client->dev.kobj, &adt7410_group);
+	i2c_smbus_write_byte_data(client, ADT7410_CONFIG, data->config);
+	return 0;
+}
+
+static const struct i2c_device_id adt7410_ids[] =3D {
+	{ "adt7410", adt7410, },
+	{ /* LIST END */ }
+};
+MODULE_DEVICE_TABLE(i2c, adt7410_ids);
+
+/* Return 0 if detection is successful, -ENODEV otherwise
+ * very basic detection */
+static int adt7410_detect(struct i2c_client *new_client,
+			  struct i2c_board_info *info)
+{
+	struct i2c_adapter *adapter =3D new_client->adapter;
+	int ret;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
+				     I2C_FUNC_SMBUS_WORD_DATA))
+		return -ENODEV;
+
+	ret =3D i2c_smbus_read_byte_data(new_client, ADT7410_ID);
+	if (ret < 0)
+		return ret;
+
+	if ((ret >> ADT7410_MANUFACTURE_ID_OFFSET) !=3D ADT7410_MANUFACTURE_ID)
+		return -ENODEV;
+
+	if ((ret & ADT7410_DEVICE_ID_MASK) !=3D ADT7410_DEVICE_ID)
+		return -ENODEV;
+
+	/* Bits 0-3 of status register read back 0000 */
+	ret =3D i2c_smbus_read_byte_data(new_client, ADT7410_STATUS);
+	if (ret < 0)
+		return ret;
+
+	if (ret & 0xF)
+		return -ENODEV;
+
+	strlcpy(info->type, "adt7410", I2C_NAME_SIZE);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int adt7410_suspend(struct device *dev)
+{
+	int ret;
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct adt7410_data *data =3D i2c_get_clientdata(client);
+
+	ret =3D i2c_smbus_write_byte_data(client, ADT7410_CONFIG,
+					data->config | ADT7410_PD);
+	if (ret)
+		return ret;
+	return 0;
+}
+
+static int adt7410_resume(struct device *dev)
+{
+	int ret;
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct adt7410_data *data =3D i2c_get_clientdata(client);
+
+	ret =3D i2c_smbus_write_byte_data(client, ADT7410_CONFIG, data->config);
+	if (ret)
+		return ret;
+	return 0;
+}
+
+static const struct dev_pm_ops adt7410_dev_pm_ops =3D {
+	.suspend	=3D adt7410_suspend,
+	.resume		=3D adt7410_resume,
+};
+#define ADT7410_DEV_PM_OPS (&adt7410_dev_pm_ops)
+#else
+#define ADT7410_DEV_PM_OPS NULL
+#endif /* CONFIG_PM */
+
+static struct i2c_driver adt7410_driver =3D {
+	.class		=3D I2C_CLASS_HWMON,
+	.driver =3D {
+		.name	=3D "adt7410",
+		.pm	=3D ADT7410_DEV_PM_OPS,
+	},
+	.probe		=3D adt7410_probe,
+	.remove		=3D adt7410_remove,
+	.id_table	=3D adt7410_ids,
+	.detect		=3D adt7410_detect,
+	.address_list	=3D normal_i2c,
+};
+
+module_i2c_driver(adt7410_driver);
+
+MODULE_AUTHOR("Hartmut Knaack <knaack.h <at> gmx.de>");
+MODULE_DESCRIPTION("ADT7410 driver");
+MODULE_LICENSE("GPL");

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
