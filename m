From: Rini van Zetten <rini@arvoo.nl>
Date: Fri, 20 Feb 2009 10:22:36 +0000
Subject: [lm-sensors] [RFC][PATCH 1/1] add adt7411 hwmon driver
Message-Id: <499E846C.8050105@arvoo.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Signed-off-by: Rini van Zetten <rini@arvoo.nl>
---
  drivers/hwmon/Kconfig   |   10 +
  drivers/hwmon/Makefile  |    1 +
  drivers/hwmon/adt7411.c |  424 
+++++++++++++++++++++++++++++++++++++++++++++++
  3 files changed, 435 insertions(+), 0 deletions(-)
  create mode 100644 drivers/hwmon/adt7411.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index b84bf06..1356ff9 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -159,6 +159,16 @@ config SENSORS_ADM9240
  	  This driver can also be built as a module.  If so, the module
  	  will be called adm9240.

+config SENSORS_ADT7411
+	tristate "Analog Devices ADT7411"
+	depends on I2C && EXPERIMENTAL
+	help
+	  If you say yes here you get support for the Analog Devices
+	  ADT7411 temperature monitoring chip.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called adt7411.
+
  config SENSORS_ADT7462
  	tristate "Analog Devices ADT7462"
  	depends on I2C && EXPERIMENTAL
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 2e80f37..ac9fb0a 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_SENSORS_ADM1029)	+= adm1029.o
  obj-$(CONFIG_SENSORS_ADM1031)	+= adm1031.o
  obj-$(CONFIG_SENSORS_ADM9240)	+= adm9240.o
  obj-$(CONFIG_SENSORS_ADS7828)	+= ads7828.o
+obj-$(CONFIG_SENSORS_AD7414)	+= adt7411.o
  obj-$(CONFIG_SENSORS_ADT7462)	+= adt7462.o
  obj-$(CONFIG_SENSORS_ADT7470)	+= adt7470.o
  obj-$(CONFIG_SENSORS_ADT7473)	+= adt7473.o
diff --git a/drivers/hwmon/adt7411.c b/drivers/hwmon/adt7411.c
new file mode 100644
index 0000000..e073c72
--- /dev/null
+++ b/drivers/hwmon/adt7411.c
@@ -0,0 +1,424 @@
+/*
+ * An hwmon driver for the Analog Devices ADT7411
+ *
+ * Copyright (C) 2009 Rini van Zetten <rini@arvoo.nl> ARVOO Engineering 
B.V.
+ *
+ * Based on ad7414.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/jiffies.h>
+#include <linux/i2c.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/err.h>
+#include <linux/mutex.h>
+#include <linux/sysfs.h>
+
+/*
+ * The ADT7411 registers
+ * Manufacturer ID is 0x41 for Analog Devices.
+ */
+
+#define ADT7411_REG_ISR1                0x00
+#define ADT7411_REG_ISR2                0x01
+#define ADT7411_REG_INT_TEMP_VDD_LSB    0x03
+#define ADT7411_REG_EXT_TEMP_AIN1_LSB   0x04
+#define ADT7411_REG_AIN5_LSB            0x05
+#define ADT7411_REG_VDD_MSB             0x06
+#define ADT7411_REG_INT_TEMP_MSB        0x07
+#define ADT7411_REG_EXT_TEMP_AIN1_MSB   0x08
+#define ADT7411_REG_AIN2_MSB            0x09
+#define ADT7411_REG_AIN3_MSB            0x0A
+#define ADT7411_REG_AIN4_MSB            0x0B
+#define ADT7411_REG_AIN5_MSB            0x0C
+#define ADT7411_REG_AIN6_MSB            0x0D
+#define ADT7411_REG_AIN7_MSB            0x0E
+#define ADT7411_REG_AIN8_MSB            0x0F
+#define ADT7411_REG_CONFIG1             0x18
+#define ADT7411_REG_CONFIG2             0x19
+#define ADT7411_REG_CONFIG3             0x1A
+#define ADT7411_REG_INT_MASK1           0x1D
+#define ADT7411_REG_INT_MASK2           0x1E
+#define ADT7411_REG_INT_TEMP_OFFSET     0x1F
+#define ADT7411_REG_EXT_TEMP_OFFSET     0x20
+#define ADT7411_REG_VDD_HIGH_LIMIT      0x23
+#define ADT7411_REG_VDD_LOW_LIMIT       0x24
+#define ADT7411_REG_INT_THIGH_LIMIT     0x25
+#define ADT7411_REG_INT_TLOW_LIMIT      0x26
+#define ADT7411_REG_EXT_THIGH_AIN1_VHIGH_LIMITS 0x27
+#define ADT7411_REG_EXT_TLOW_AIN1_VLOW_LIMITS   0x28
+#define ADT7411_REG_AIN2_VHIGH_LIMIT            0x2B
+#define ADT7411_REG_AIN2_VLOW_LIMIT             0x2C
+#define ADT7411_REG_AIN3_VHIGH_LIMIT            0x2D
+#define ADT7411_REG_AIN3_VLOW_LIMIT             0x2E
+#define ADT7411_REG_AIN4_VHIGH_LIMIT            0x2F
+#define ADT7411_REG_AIN4_VLOW_LIMIT             0x30
+#define ADT7411_REG_AIN5_VHIGH_LIMIT            0x31
+#define ADT7411_REG_AIN5_VLOW_LIMIT             0x32
+#define ADT7411_REG_AIN6_VHIGH_LIMIT            0x33
+#define ADT7411_REG_AIN6_VLOW_LIMIT             0x34
+#define ADT7411_REG_AIN7_VHIGH_LIMIT            0x35
+#define ADT7411_REG_AIN7_VLOW_LIMIT             0x36
+#define ADT7411_REG_AIN8_VHIGH_LIMIT            0x37
+#define ADT7411_REG_AIN8_VLOW_LIMIT             0x38
+#define ADT7411_REG_DEVID                       0x4D
+#define ADT7411_REG_MANID                       0x4E
+#define ADT7411_REG_REVISION                    0x4F
+#define ADT7411_REG_SPI_LOCK_STATUS             0x7F
+
+/*
+ * Client data (each client gets its own)
+ */
+
+struct adt7411_data {
+	struct device *hwmon_dev;
+	struct mutex lock; /* atomic read data updates */
+	char valid; /* !=0 if following fields are valid */
+	unsigned long next_update; /* In jiffies */
+
+	/* registers values */
+	s16 temp_int;
+	s16 vdd;
+	s16 ain[8]; /* AIN1..AIN8 */
+};
+
+/*
+ * Conversions
+ *
+ */
+#define ADV7411_1LSB_mV 2197 /* (mV) Vref/1024 = 2.25/1024 */
+
+s32 reg_to_volt(s16 reg)
+{
+	return (s32)(reg * ADV7411_1LSB_mV / 1000);
+}
+
+s16 reg_to_temp(s16 t)
+{
+	s16 res;
+
+	res = 0;
+	if (t & 0x200) {
+		/* negative */
+		res = -512 + (t & 0x1ff);
+	}
+	res += (t & 0x1ff);
+	res /= 4;
+
+	return res;
+}
+
+static struct adt7411_data *adt7411_update_device(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct adt7411_data *data = i2c_get_clientdata(client);
+	u8 reg;
+
+	mutex_lock(&data->lock);
+
+	if (time_after(jiffies, data->next_update) || !data->valid) {
+
+		dev_dbg(&client->dev, "starting adt7411 update.\n");
+
+		/* read all measurements
+		 first LSB, next MSB!
+		 */
+
+		reg = i2c_smbus_read_byte_data(client,
+				ADT7411_REG_INT_TEMP_VDD_LSB);/* lsb's */
+		data->vdd = i2c_smbus_read_byte_data(client,
+				ADT7411_REG_VDD_MSB);/* Vdd msb */
+		data->vdd <<= 2;
+		data->vdd |= (reg >> 2);
+
+		data->temp_int = i2c_smbus_read_byte_data(client,
+				ADT7411_REG_INT_TEMP_MSB);/* Tint msb */
+		data->temp_int <<= 2;
+		data->temp_int |= (reg & 0x3);
+
+		/* lsb's AIN4..1 */
+		reg = i2c_smbus_read_byte_data(client,
+				ADT7411_REG_EXT_TEMP_AIN1_LSB);
+
+		data->ain[0] = i2c_smbus_read_byte_data(client,
+				ADT7411_REG_EXT_TEMP_AIN1_MSB);
+		data->ain[0] <<= 2;
+		data->ain[0] |= (reg & 0x3);
+
+		data->ain[1] = i2c_smbus_read_byte_data(client,
+				ADT7411_REG_AIN2_MSB);
+		data->ain[1] <<= 2;
+		data->ain[1] |= ((reg & 0xc) >> 2);
+
+		data->ain[2] = i2c_smbus_read_byte_data(client,
+				ADT7411_REG_AIN3_MSB);
+		data->ain[2] <<= 2;
+		data->ain[2] |= ((reg & 0x30) >> 4);/* lsb AIN3 */
+
+		data->ain[3] = i2c_smbus_read_byte_data(client,
+				ADT7411_REG_AIN4_MSB);
+		data->ain[3] <<= 2;
+		data->ain[3] |= ((reg & 0xc0) >> 6);/* lsb AIN4 */
+
+		reg = i2c_smbus_read_byte_data(client,
+				ADT7411_REG_AIN5_LSB);/* lsb's AIN8..5 */
+
+		data->ain[4] = i2c_smbus_read_byte_data(client,
+				ADT7411_REG_AIN5_MSB);
+		data->ain[4] <<= 2;
+		data->ain[4] |= (reg & 0x3);/* lsb AIN5 */
+
+		data->ain[5] = i2c_smbus_read_byte_data(client,
+				ADT7411_REG_AIN6_MSB);
+		data->ain[5] <<= 2;
+		data->ain[5] |= ((reg & 0xc) >> 2);/* lsb AIN6 */
+
+		data->ain[6] = i2c_smbus_read_byte_data(client,
+				ADT7411_REG_AIN7_MSB);
+		data->ain[6] <<= 2;
+		data->ain[6] |= ((reg & 0x30) >> 4);/* lsb AIN7 */
+
+		data->ain[7] = i2c_smbus_read_byte_data(client,
+				ADT7411_REG_AIN8_MSB);
+		data->ain[7] <<= 2;
+		data->ain[7] |= ((reg & 0xc0) >> 6);/* lsb AIN8 */
+
+		data->next_update = jiffies + HZ + HZ / 2;
+
+		data->valid = 1;
+
+	}
+
+	mutex_unlock(&data->lock);
+
+	return data;
+}
+
+static int adt7411_initialize(struct i2c_client *client)
+{
+	struct adt7411_data *data = i2c_get_clientdata(client);
+
+	mutex_lock(&data->lock);
+
+	/* Control Config 2: reset */
+	i2c_smbus_write_byte_data(client, ADT7411_REG_CONFIG2, 0x80);
+
+	/* Control Config 2  rrobin, en aver */
+	i2c_smbus_write_byte_data(client, ADT7411_REG_CONFIG2, 0x00);
+	/* Control Config 3 clk:22.5khz, int_Vref */
+	i2c_smbus_write_byte_data(client, ADT7411_REG_CONFIG3, 0x09);
+	/* Interr Mask 1 */
+	i2c_smbus_write_byte_data(client, ADT7411_REG_INT_MASK1, 0x00);
+	/* Interr Mask 2 */
+	i2c_smbus_write_byte_data(client, ADT7411_REG_INT_MASK2, 0x00);
+	/* Int T Offset */
+	i2c_smbus_write_byte_data(client, ADT7411_REG_INT_TEMP_OFFSET, 0x00);
+	/* Ext T Offset */
+	i2c_smbus_write_byte_data(client, ADT7411_REG_EXT_TEMP_OFFSET, 0x00);
+	/* Vdd Vhigh Limit */
+	i2c_smbus_write_byte_data(client, ADT7411_REG_VDD_HIGH_LIMIT, 0xc0);
+	/* Vdd Vlow Limit: 2.7V*/
+	i2c_smbus_write_byte_data(client, ADT7411_REG_VDD_LOW_LIMIT, 0x62);
+	/* Int Thigh: +100 */
+	i2c_smbus_write_byte_data(client, ADT7411_REG_INT_THIGH_LIMIT, 0x64);
+	/* Int Tlow: -55 */
+	i2c_smbus_write_byte_data(client, ADT7411_REG_INT_TLOW_LIMIT, 0xc9);
+	/* ExtT/AIN1 Vhigh */
+	i2c_smbus_write_byte_data(client,
+			ADT7411_REG_EXT_THIGH_AIN1_VHIGH_LIMITS, 0xff);
+	/* ExtTlow/AIN Vlow */
+	i2c_smbus_write_byte_data(client,
+			ADT7411_REG_EXT_TLOW_AIN1_VLOW_LIMITS, 0x00);
+	/* AIN2 Vhigh */
+	i2c_smbus_write_byte_data(client, ADT7411_REG_AIN2_VHIGH_LIMIT, 0xff);
+	/* AIN2 Vlow */
+	i2c_smbus_write_byte_data(client, ADT7411_REG_AIN2_VLOW_LIMIT, 0x00);
+	/* AIN3 Vhigh */
+	i2c_smbus_write_byte_data(client, ADT7411_REG_AIN3_VHIGH_LIMIT, 0xff);
+	/* AIN3 Vlow */
+	i2c_smbus_write_byte_data(client, ADT7411_REG_AIN3_VLOW_LIMIT, 0x00);
+	/* AIN4 Vhigh */
+	i2c_smbus_write_byte_data(client, ADT7411_REG_AIN4_VHIGH_LIMIT, 0xff);
+	/* AIN4 Vlow */
+	i2c_smbus_write_byte_data(client, ADT7411_REG_AIN4_VLOW_LIMIT, 0x00);
+	/* AIN5 Vhigh */
+	i2c_smbus_write_byte_data(client, ADT7411_REG_AIN5_VHIGH_LIMIT, 0xff);
+	/* AIN5 Vlow */
+	i2c_smbus_write_byte_data(client, ADT7411_REG_AIN5_VLOW_LIMIT, 0x00);
+	/* AIN6 Vhigh */
+	i2c_smbus_write_byte_data(client, ADT7411_REG_AIN6_VHIGH_LIMIT, 0xff);
+	/* AIN6 Vlow */
+	i2c_smbus_write_byte_data(client, ADT7411_REG_AIN6_VLOW_LIMIT, 0x00);
+	/* AIN7 Vhigh */
+	i2c_smbus_write_byte_data(client, ADT7411_REG_AIN7_VHIGH_LIMIT, 0xff);
+	/* AIN7 Vlow */
+	i2c_smbus_write_byte_data(client, ADT7411_REG_AIN7_VLOW_LIMIT, 0x00);
+	/* AIN8 Vhigh */
+	i2c_smbus_write_byte_data(client, ADT7411_REG_AIN8_VHIGH_LIMIT, 0xff);
+	/* AIN8 Vlow */
+	i2c_smbus_write_byte_data(client, ADT7411_REG_AIN8_VLOW_LIMIT, 0x00);
+
+	/* Control Config 1
+	 start, AIN1-AIN2, dis INT */
+	i2c_smbus_write_byte_data(client, ADT7411_REG_CONFIG1, 0x29);
+
+	mutex_unlock(&data->lock);
+
+	return 1;
+}
+
+/*
+ * Sysfs stuff
+ */
+static ssize_t show_inttemp(struct device *dev,
+		struct device_attribute *devattr, char *buf)
+{
+	struct adt7411_data *data = adt7411_update_device(dev);
+	return sprintf(buf, "%d\n", reg_to_temp(data->temp_int));
+}
+
+static ssize_t show_ain(struct device *dev, struct device_attribute 
*devattr,
+		char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct adt7411_data *data = adt7411_update_device(dev);
+
+	return sprintf(buf, "%d\n", reg_to_volt(data->ain[attr->index]));
+}
+
+static ssize_t show_vdd(struct device *dev, struct device_attribute 
*devattr,
+		char *buf)
+{
+	struct adt7411_data *data = adt7411_update_device(dev);
+
+	return sprintf(buf, "%d\n", reg_to_volt(data->vdd) * 311 / 100);
+}
+
+static SENSOR_DEVICE_ATTR(int_temp_input, S_IRUGO, show_inttemp, NULL, 0);
+static SENSOR_DEVICE_ATTR(ain1_input, S_IRUGO, show_ain, NULL, 0);
+static SENSOR_DEVICE_ATTR(ain2_input, S_IRUGO, show_ain, NULL, 1);
+static SENSOR_DEVICE_ATTR(ain3_input, S_IRUGO, show_ain, NULL, 2);
+static SENSOR_DEVICE_ATTR(ain4_input, S_IRUGO, show_ain, NULL, 3);
+static SENSOR_DEVICE_ATTR(ain5_input, S_IRUGO, show_ain, NULL, 4);
+static SENSOR_DEVICE_ATTR(ain6_input, S_IRUGO, show_ain, NULL, 5);
+static SENSOR_DEVICE_ATTR(ain7_input, S_IRUGO, show_ain, NULL, 6);
+static SENSOR_DEVICE_ATTR(ain8_input, S_IRUGO, show_ain, NULL, 7);
+static SENSOR_DEVICE_ATTR(vdd_input, S_IRUGO, show_vdd, NULL, 0);
+
+static struct attribute *adt7411_attributes[] = {
+		&sensor_dev_attr_int_temp_input.dev_attr.attr,
+		&sensor_dev_attr_ain1_input.dev_attr.attr,
+		&sensor_dev_attr_ain2_input.dev_attr.attr,
+		&sensor_dev_attr_ain3_input.dev_attr.attr,
+		&sensor_dev_attr_ain4_input.dev_attr.attr,
+		&sensor_dev_attr_ain5_input.dev_attr.attr,
+		&sensor_dev_attr_ain6_input.dev_attr.attr,
+		&sensor_dev_attr_ain7_input.dev_attr.attr,
+		&sensor_dev_attr_ain8_input.dev_attr.attr,
+		&sensor_dev_attr_vdd_input.dev_attr.attr, NULL };
+
+static const struct attribute_group adt7411_group = {
+		.attrs = adt7411_attributes, };
+
+static int adt7411_probe(struct i2c_client *client,
+		const struct i2c_device_id *dev_id)
+{
+	struct adt7411_data *data;
+	int err = 0;
+	u8 man_id, chip_id;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		goto exit;
+
+	data = kzalloc(sizeof(struct adt7411_data), GFP_KERNEL);
+	if (!data) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	i2c_set_clientdata(client, data);
+
+	mutex_init(&data->lock);
+
+	/* check whether it is the right chip */
+	man_id = i2c_smbus_read_byte_data(client, ADT7411_REG_MANID);
+	chip_id = i2c_smbus_read_byte_data(client, ADT7411_REG_DEVID);
+
+	if ((man_id != 0x41) || (chip_id != 0x02)) {
+		dev_warn(&client->dev, "adt7411_probe unknown chip.\n");
+		goto exit_free;
+	}
+
+	dev_info(&client->dev, "chip found\n");
+
+	/* initialize chip */
+	adt7411_initialize(client);
+
+	/* Register sysfs hooks */
+	err = sysfs_create_group(&client->dev.kobj, &adt7411_group);
+	if (err)
+		goto exit_free;
+
+	data->hwmon_dev = hwmon_device_register(&client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
+		goto exit_remove;
+	}
+	return 0;
+
+exit_remove:
+	sysfs_remove_group(&client->dev.kobj, &adt7411_group);
+exit_free:
+	kfree(data);
+exit:
+	return err;
+}
+
+static int __devexit adt7411_remove(struct i2c_client *client)
+{
+	struct adt7411_data *data = i2c_get_clientdata(client);
+
+	hwmon_device_unregister(data->hwmon_dev);
+	sysfs_remove_group(&client->dev.kobj, &adt7411_group);
+	kfree(data);
+	return 0;
+}
+
+static const struct i2c_device_id adt7411_id[] = {
+		{ "adt7411", 0 },
+		{ }
+};
+
+static struct i2c_driver adt7411_driver = {
+		.driver = {
+			.owner = THIS_MODULE,
+			.name = "adt7411",
+		},
+		.probe = adt7411_probe,
+		.remove = __devexit_p(adt7411_remove),
+		.id_table = adt7411_id,
+};
+
+static int __init adt7411_init(void)
+{
+	return i2c_add_driver(&adt7411_driver);
+}
+
+module_init(adt7411_init);
+
+static void __exit adt7411_exit(void)
+{
+	i2c_del_driver(&adt7411_driver);
+}
+module_exit(adt7411_exit);
+
+MODULE_AUTHOR("Rini van Zetten : <rini at arvoo.com> ");
+
+MODULE_DESCRIPTION("adt7411 driver");
+MODULE_LICENSE("GPL");
-- 
1.5.6.3

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
