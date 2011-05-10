From: Martin Hicks <mort@bork.org>
Date: Tue, 10 May 2011 14:46:07 +0000
Subject: [lm-sensors] [PATCH] hwmon: Driver for INA219 current and power
Message-Id: <1305038767-13241-1-git-send-email-mort@bork.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This is a new driver for the INA219 current and power monitor.  This
device does require manual configuration via sysfs files in order to
provide the current and power information.  By default it does provide
voltage information for the monitored bus.

Signed-off-by: Martin Hicks <mort@bork.org>
---
 drivers/hwmon/Kconfig  |   16 ++
 drivers/hwmon/Makefile |    1 +
 drivers/hwmon/ina219.c |  462 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 479 insertions(+), 0 deletions(-)
 create mode 100644 drivers/hwmon/ina219.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 50e40db..5196fd4 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -443,6 +443,22 @@ config SENSORS_IBMPEX
 	  This driver can also be built as a module.  If so, the module
 	  will be called ibmpex.
 
+config SENSORS_INA219
+	tristate "INA219 Current and Power monitor"
+	depends on I2C
+	help
+	  If you say yes here you get support for the INA219 Current and
+	  power monitor chip.  The TI TPS2490 may also be compatible with
+	  this driver.
+
+	  This driver requires some configuration via sysfs in order to
+	  use the current and power measurement features.  Please read
+	  the documentation for the chip and place the correct values
+	  into the 'config', 'calibrate' and 'current_lsb' sysfs files.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called ina219.
+
 config SENSORS_IT87
 	tristate "ITE IT87xx and compatibles"
 	select HWMON_VID
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 967d0ea..6e8d450 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -58,6 +58,7 @@ obj-$(CONFIG_SENSORS_ULTRA45)	+= ultra45_env.o
 obj-$(CONFIG_SENSORS_I5K_AMB)	+= i5k_amb.o
 obj-$(CONFIG_SENSORS_IBMAEM)	+= ibmaem.o
 obj-$(CONFIG_SENSORS_IBMPEX)	+= ibmpex.o
+obj-$(CONFIG_SENSORS_INA219)	+= ina219.o
 obj-$(CONFIG_SENSORS_IT87)	+= it87.o
 obj-$(CONFIG_SENSORS_JC42)	+= jc42.o
 obj-$(CONFIG_SENSORS_JZ4740)	+= jz4740-hwmon.o
diff --git a/drivers/hwmon/ina219.c b/drivers/hwmon/ina219.c
new file mode 100644
index 0000000..1b95834
--- /dev/null
+++ b/drivers/hwmon/ina219.c
@@ -0,0 +1,462 @@
+/*
+    ina219.c - Hardware monitoring for the INA219 Current and Power Monitor
+
+    Copyright (c) 2011 Martin Hicks <mort@bork.org>
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
+
+/*
+ * To use this device to its full potential three configuration values must
+ * be provided:
+ *
+ *  - The config register may need to be modified.
+ *  - The calibration register must be filled.
+ *  - The Current LSB value must be provided.
+ *
+ * All of these values are explained in detail in the INA219 Manual.
+ * By default this device reports Shunt and Bus voltages while using a
+ * +/-320mV range on the Shunt Voltage.  Max bus voltage is set to 32V.
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
+
+/* Addresses scanned */
+static const unsigned short normal_i2c[] = { 0x40, 0x41, 0x44, 0x45,
+						I2C_CLIENT_END };
+
+/* Registers */
+enum {
+	INA219_REG_CONF  = 0,
+	INA219_REG_SHUNT,
+	INA219_REG_BUS,
+	INA219_REG_POWER,
+	INA219_REG_CURRENT,
+	INA219_REG_CAL,
+};
+
+#define CONFIG_DEFAULT 0x399f
+
+/* Configuration register fields */
+enum {
+	MODE_SHIFT = 0,
+	MODE_MASK = 0x7,
+	SADC_SHIFT = 3,
+	SADC_MASK = 0x15,
+	BADC_SHIFT = 7,
+	BADC_MASK = 0x15,
+	PGA_SHIFT = 11,
+	PGA_MASK = 0x3,
+	BRNG_SHIFT = 14,
+	BRNG_MASK = 0x1,
+	RST_SHIFT = 15,
+	RST_MASK = 0x1,
+};
+
+struct ina219_data {
+	struct device		*hwmon_dev;
+	struct mutex		update_lock;
+	unsigned short		config;
+	unsigned short		calibrate;
+	unsigned short		current_lsb;	/* uA/bit */
+	u8			calibrated;
+
+	char			valid;		/* !=0 if registers are valid */
+	unsigned long		last_updated;	/* In jiffies */
+	s16			shunt_voltage;
+	s16			bus_voltage;
+	s16			bus_power;
+	s16			bus_current;
+};
+
+static int ina219_read_value(struct i2c_client *client, u8 reg, short *dest)
+{
+	int status;
+
+	status = swab16(i2c_smbus_read_word_data(client, reg));
+	if (status < 0) {
+		dev_dbg(&client->dev, "reg %d, err %d\n", reg, status);
+		return status;
+	}
+
+	*dest =  status;
+	return 0;
+}
+
+/* Lock must be held */
+static int __do_reset(struct i2c_client *client, struct ina219_data *data)
+{
+	int err;
+	short val;
+
+	err = i2c_smbus_write_word_data(client, INA219_REG_CONF, swab16(1<<RST_SHIFT));
+	if (err < 0) {
+		dev_dbg(&client->dev, "Error resetting: %d\n", err);
+		return err;
+	}
+	/* Wait for reset after register write */
+	udelay(4);
+	/* Make sure config register is defaults */
+	if (ina219_read_value(client, INA219_REG_CONF, &val)) {
+		dev_dbg(&client->dev, "Error resetting: %d\n", err);
+		return err;
+	}
+	if (val != 0x399f) {
+		dev_dbg(&client->dev, "Error after reset: Did not reset to 0x%x\n",
+			CONFIG_DEFAULT);
+		return -EIO;
+	}
+
+	data->valid = 0;
+	data->last_updated = 0;
+	data->shunt_voltage = data->bus_voltage = 0;
+	data->bus_power = data->bus_current = 0;
+	data->config = data->calibrate = data->current_lsb = 0;
+	data->calibrated = 0;
+	return 0;
+}
+
+static struct ina219_data *__ina219_update_device(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct ina219_data *data = i2c_get_clientdata(client);
+
+	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
+		|| !data->valid) {
+
+		ina219_read_value(client, INA219_REG_CONF, &data->config);
+		ina219_read_value(client, INA219_REG_CAL, &data->calibrate);
+		ina219_read_value(client, INA219_REG_SHUNT, &data->shunt_voltage);
+		ina219_read_value(client, INA219_REG_BUS, &data->bus_voltage);
+		data->calibrated = data->calibrate && data->current_lsb;
+
+		if (data->calibrated) {
+			ina219_read_value(client, INA219_REG_CURRENT, &data->bus_current);
+			ina219_read_value(client, INA219_REG_POWER, &data->bus_power);
+		}
+
+		data->last_updated = jiffies;
+		data->valid = 1;
+	}
+
+	return data;
+}
+
+static struct ina219_data *ina219_update_device(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct ina219_data *data = i2c_get_clientdata(client);
+
+	mutex_lock(&data->update_lock);
+	data = __ina219_update_device(dev);
+	mutex_unlock(&data->update_lock);
+
+	return data;
+}
+
+/* sysfs attributes for the ina219 */
+static ssize_t show_value(struct device *dev,
+			struct device_attribute *da, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct ina219_data *data = ina219_update_device(dev);
+
+	switch (attr->index) {
+	case 0:
+		/* LSB is 10uV, so divide to get to mV */
+		return sprintf(buf, "%d mV\n", data->shunt_voltage / 100);
+	case 1:
+		/* Bus voltage is not right-aligned and is then 4mV LSB */
+		return sprintf(buf, "%d mV\n", (data->bus_voltage>>3)*4);
+	case 2:
+		if (!data->calibrated)
+			return 0;
+		/* Power LSB is 20 x the current LSB - convert from uA to mA */
+		return sprintf(buf, "%d mW\n", data->bus_power*20*data->current_lsb/1000);
+	case 3:
+		if (!data->calibrated)
+			return 0;
+		/* current_lsb tells us how many uA/bit, convert to mA */
+		return sprintf(buf, "%d mA\n",
+			data->bus_current*data->current_lsb/1000);
+	case 5:
+		return sprintf(buf, "0x%04x\n", data->config);
+	case 6:
+		return sprintf(buf, "0x%04x\n", data->calibrate);
+	case 7:
+		return sprintf(buf, "%d\n", data->calibrated);
+	case 8:
+		return sprintf(buf, "%d uA/bit\n", data->current_lsb);
+	}
+	return 0;
+}
+
+static ssize_t set_reset(struct device *dev, struct device_attribute *da,
+				const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct ina219_data *data = i2c_get_clientdata(client);
+
+	mutex_lock(&data->update_lock);
+	__do_reset(client, data);
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+static ssize_t set_config(struct device *dev, struct device_attribute *da,
+				const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct ina219_data *data = i2c_get_clientdata(client);
+
+	long new_config;
+	int error;
+
+	error = strict_strtol(buf, 0, &new_config);
+	if (error)
+		return error;
+	new_config &= 0xffff;
+
+	mutex_lock(&data->update_lock);
+	/*
+	 * If the reset bit is set, do a reset first, then clear the reset bit and set
+	 * the config
+	 */
+	if (new_config & 1<<RST_SHIFT)
+		__do_reset(client, data);
+	new_config &= ~(1<<RST_SHIFT);
+
+	dev_dbg(&client->dev, "Setting chip config to 0x%hx\n", swab16((u16)new_config));
+	i2c_smbus_write_word_data(client, INA219_REG_CONF, swab16(new_config));
+	data->valid = 0;
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+static ssize_t set_calibrate(struct device *dev, struct device_attribute *da,
+				const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct ina219_data *data = i2c_get_clientdata(client);
+
+	long cal;
+	int error;
+
+	error = strict_strtol(buf, 0, &cal);
+	if (error)
+		return error;
+
+	/* Lowest bit is void */
+	cal &= ~1;
+	cal &= 0xffff;
+
+	mutex_lock(&data->update_lock);
+	i2c_smbus_write_word_data(client, INA219_REG_CAL, swab16(cal));
+	/* minimum of 4uS sleep before you can read back INA219_REG_CAL */
+	udelay(5);
+
+	__ina219_update_device(dev);
+	data->valid = 0;
+	__ina219_update_device(dev);
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+static ssize_t set_current_lsb(struct device *dev, struct device_attribute *da,
+				const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct ina219_data *data = i2c_get_clientdata(client);
+	long lsb;
+	int error;
+
+	error = strict_strtol(buf, 0, &lsb);
+	if (error)
+		return error;
+
+	mutex_lock(&data->update_lock);
+	data->current_lsb = lsb;
+	data->valid = 0;
+	__ina219_update_device(dev);
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+static SENSOR_DEVICE_ATTR(shunt_voltage, S_IRUGO,  show_value, NULL, 0);
+static SENSOR_DEVICE_ATTR(bus_voltage, S_IRUGO, show_value, NULL, 1);
+static SENSOR_DEVICE_ATTR(bus_power, S_IRUGO, show_value, NULL, 2);
+static SENSOR_DEVICE_ATTR(bus_current, S_IRUGO, show_value, NULL, 3);
+static SENSOR_DEVICE_ATTR(reset, S_IWUSR, NULL, set_reset, 4);
+static SENSOR_DEVICE_ATTR(config, S_IRUGO | S_IWUSR, show_value, set_config, 5);
+static SENSOR_DEVICE_ATTR(calibrate, S_IRUGO | S_IWUSR, show_value,
+							set_calibrate, 6);
+static SENSOR_DEVICE_ATTR(calibrated, S_IRUGO, show_value, NULL, 7);
+static SENSOR_DEVICE_ATTR(current_lsb, S_IRUGO | S_IWUSR, show_value,
+							set_current_lsb, 8);
+
+
+static struct attribute *ina219_attributes[] = {
+	&sensor_dev_attr_shunt_voltage.dev_attr.attr,
+	&sensor_dev_attr_bus_voltage.dev_attr.attr,
+	&sensor_dev_attr_bus_power.dev_attr.attr,
+	&sensor_dev_attr_bus_current.dev_attr.attr,
+	&sensor_dev_attr_reset.dev_attr.attr,
+	&sensor_dev_attr_config.dev_attr.attr,
+	&sensor_dev_attr_calibrate.dev_attr.attr,
+	&sensor_dev_attr_calibrated.dev_attr.attr,
+	&sensor_dev_attr_current_lsb.dev_attr.attr,
+	NULL
+};
+
+
+static const struct attribute_group ina219_group = {
+	.attrs = ina219_attributes,
+};
+
+static const struct i2c_device_id ina219_ids[] = {
+	{ "ina219", 0, },
+	{ /* LIST END */ }
+};
+MODULE_DEVICE_TABLE(i2c, ina219_ids);
+
+static int
+ina219_probe(struct i2c_client *client, const struct i2c_device_id *id)
+{
+	struct ina219_data *data;
+	int status;
+
+	data = kzalloc(sizeof(struct ina219_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, data);
+	mutex_init(&data->update_lock);
+
+	/* Leave the chip configured as default */
+
+	status = sysfs_create_group(&client->dev.kobj, &ina219_group);
+	if (status)
+		goto exit_free;
+
+	data->hwmon_dev = hwmon_device_register(&client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		status = PTR_ERR(data->hwmon_dev);
+		goto exit_remove;
+	}
+
+	dev_info(&client->dev, "%s: sensor '%s'\n",
+		dev_name(data->hwmon_dev), client->name);
+
+	return 0;
+
+exit_remove:
+	sysfs_remove_group(&client->dev.kobj, &ina219_group);
+exit_free:
+	kfree(data);
+	return status;
+}
+
+static int ina219_remove(struct i2c_client *client)
+{
+	struct ina219_data *data = i2c_get_clientdata(client);
+
+	hwmon_device_unregister(data->hwmon_dev);
+	sysfs_remove_group(&client->dev.kobj, &ina219_group);
+	i2c_smbus_write_word_data(client, INA219_REG_CONF, swab16(1<<RST_SHIFT));
+	kfree(data);
+	return 0;
+}
+
+static int ina219_detect(struct i2c_client *new_client,
+			struct i2c_board_info *info)
+{
+	struct i2c_adapter *adapter = new_client->adapter;
+	u16 val;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
+						I2C_FUNC_SMBUS_WORD_DATA))
+		return -ENODEV;
+
+	/*
+	 * Just rely on the power-on-reset value of the config register
+	 * and hitting the reset causes the POR value to return
+	 */
+	ina219_read_value(new_client, INA219_REG_CONF, &val);
+	if (val != 0x399f) {
+		return -ENODEV;
+	}
+
+	i2c_smbus_write_word_data(new_client, INA219_REG_CONF, 0);
+	udelay(4);
+	ina219_read_value(new_client, INA219_REG_CONF, &val);
+	if (val != 0) {
+		return -ENODEV;
+	}
+
+	i2c_smbus_write_word_data(new_client, INA219_REG_CONF, swab16(1<<RST_SHIFT));
+	udelay(4);
+	ina219_read_value(new_client, INA219_REG_CONF, &val);
+	if (val != 0x399f) {
+		return -ENODEV;
+	}
+	strlcpy(info->type, "ina219", I2C_NAME_SIZE);
+
+	return 0;
+}
+
+static struct i2c_driver ina219_driver = {
+	.class		= I2C_CLASS_HWMON,
+	.driver = {
+		.name	= "ina219",
+	},
+	.probe		= ina219_probe,
+	.remove		= ina219_remove,
+	.id_table	= ina219_ids,
+	.detect		= ina219_detect,
+	.address_list	= normal_i2c,
+};
+
+static int __init sensors_ina219_init(void)
+{
+	return i2c_add_driver(&ina219_driver);
+}
+
+static void __exit sensors_ina219_exit(void)
+{
+	return i2c_del_driver(&ina219_driver);
+}
+
+MODULE_AUTHOR("Martin Hicks <mort@bork.org>");
+MODULE_DESCRIPTION("INA219 Power and Current monitor");
+MODULE_LICENSE("GPL");
+
+module_init(sensors_ina219_init);
+module_exit(sensors_ina219_exit);
+
-- 
1.5.6.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
