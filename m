From: theuns@bluewatersys.com (Theuns Verwoerd)
Date: Tue, 08 Aug 2006 04:33:32 +0000
Subject: [lm-sensors] [PATCH 001/001] I2C: AD7414 I2C chip driver for
Message-Id: <44D8141C.10409@bluewatersys.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

AD7414 Temperature Sensor I2C driver.  I2C chip driver for the Analog
Devices AD7414 device.
Signed-off-by: Theuns Verwoerd <theuns.verwoerd at bluewatersys.com>
---
Tested on a custom EP9315-based board developed in-house at Bluewater
Systems.  Fairly trivial driver; really just exposes the raw registers
to userspace, along with the current temperature.
Patch is relative to Linux-2.6.18-rc4 .
[Take 2, incorporating changes suggested by LKML]
---
diff -uprN -X linux-2.6.18-rc4.orig/Documentation/dontdiff linux-2.6.18-rc4.orig/drivers/hwmon/ad7414.c linux-2.6.18-rc4/drivers/hwmon/ad7414.c
--- linux-2.6.18-rc4.orig/drivers/hwmon/ad7414.c	1970-01-01 12:00:00.000000000 +1200
+++ linux-2.6.18-rc4/drivers/hwmon/ad7414.c	2006-08-08 15:08:36.000000000 +1200
@@ -0,0 +1,308 @@
+/*
+ * AD7414 I2C Chip Driver
+ *
+ * Copyright (C) 2006 Theuns Verwoerd, Bluewater Systems (theuns.verwoerd at bluewatersys.com)
+ *
+ *	This program is free software; you can redistribute it and/or modify
+ *	it under the terms of the GNU General Public License as published by
+ *	the Free Software Foundation, version 2 of the License.
+ *
+ * Simple I2C driver for Analog Devices AD7414 temperature sensor.
+ *		Based on: lm75.c
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+
+/* Addresses to scan */
+static unsigned short normal_i2c[] = { 0x4a, I2C_CLIENT_END };
+
+/* Insmod parameters */
+I2C_CLIENT_INSMOD_1(ad7414);
+
+/* AD7414 Registers */
+#define AD7414_REG_TEMP			0
+#define AD7414_REG_CONF			1
+#define AD7414_REG_TEMP_HIGH	2
+#define AD7414_REG_TEMP_LOW		3
+
+/* Each client has this additional data */
+struct ad7414_data {
+	struct i2c_client client;
+	struct class_device *class_dev;
+	struct mutex update_lock;
+	char valid;		/* !=0 if following fields are valid */
+	unsigned long last_updated;		/* In jiffies */
+	u16 temp_value;		/* Register values */
+	u16 temp_config;
+	u16 temp_high;
+	u16 temp_low;
+};
+
+static int ad7414_attach_adapter(struct i2c_adapter *adapter);
+static int ad7414_detect(struct i2c_adapter *adapter, int address,
+			 int kind);
+static int ad7414_detach_client(struct i2c_client *client);
+static struct ad7414_data *ad7414_update_device(struct device *dev);
+static int ad7414_ADC_to_temp(int ADC);
+
+/* This is the driver that will be inserted */
+static struct i2c_driver ad7414_driver = {
+	.driver = {
+		   .name = "ad7414",
+		   },
+	.id = I2C_DRIVERID_AD7414,
+	.attach_adapter = ad7414_attach_adapter,
+	.detach_client = ad7414_detach_client,
+};
+
+#ifdef CONFIG_HWMON_DEBUG_SYSFS_FILES
+/* Custom access: raw and decoded registers */
+#define show_raw(value)	\
+	static ssize_t show_raw_##value(struct device *dev, struct device_attribute *attr, char *buf)	\
+	{																								\
+		struct ad7414_data *data = ad7414_update_device(dev);										\
+																									\
+		return sprintf(buf, "0x%x\n", data->value);													\
+	}
+show_raw(temp_value);
+show_raw(temp_config);
+show_raw(temp_high);
+show_raw(temp_low);
+
+#define show_text(value)	\
+	static ssize_t show_text_##value(struct device *dev, struct device_attribute *attr, char *buf)	\
+	{																							\
+		struct ad7414_data *data = ad7414_update_device(dev);									\
+																								\
+		return sprintf(buf, "%dC\n", data->value);												\
+	}
+show_text(temp_high);
+show_text(temp_low);
+
+static ssize_t show_text_temp_value(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct ad7414_data *data = ad7414_update_device(dev);
+	return sprintf(buf, "%d.%02uC %s%s%s\n",
+		       ad7414_ADC_to_temp(data->temp_value) / 1000,
+		       abs(ad7414_ADC_to_temp(data->temp_value)) % 1000,
+		       data->temp_value & 0x20 ? "ALERT " : "",
+		       data->temp_value & 0x10 ? "THIGH " : "",
+		       data->temp_value & 0x20 ? "TLOW " : "");
+}
+
+static ssize_t show_text_temp_config(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct ad7414_data *data = ad7414_update_device(dev);
+	return sprintf(buf, "0x%x %s%s%s%s%s%s%s\n", data->temp_config,
+		       data->temp_config & 0x80 ? "POWEROFF " : "",
+		       data->temp_config & 0x40 ? "NOFILTER " : "",
+		       data->temp_config & 0x20 ? "NOALERT " : "",
+		       data->temp_config & 0x10 ? "ALRTHIGH " : "ALRTLOW ",
+		       data->temp_config & 0x08 ? "ALERTRST " : "",
+		       data->temp_config & 0x04 ? "ONESHOT " : "",
+		       data->temp_config & 0x03 ? "TESTMODE " : "");
+}
+#endif // CONFIG_HWMON_DEBUG_SYSFS_FILES
+
+/* Standard sysfs hwmon files */
+static ssize_t show_temp1_input(struct device *dev,
+									struct device_attribute *attr, char *buf)
+{
+	struct ad7414_data *data = ad7414_update_device(dev);
+	return sprintf(buf, "%d\n",
+				   ad7414_ADC_to_temp(data->temp_value));
+}
+
+#ifdef CONFIG_HWMON_DEBUG_SYSFS_FILES
+#define set_raw(value, reg)	\
+	static ssize_t set_raw_##value(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)	\
+	{																													\
+		struct i2c_client *client = to_i2c_client(dev);																	\
+		struct ad7414_data *data = i2c_get_clientdata(client);															\
+		int value = simple_strtoul(buf, NULL, 0);																		\
+																														\
+		mutex_lock(&data->update_lock);																					\
+		data->value = value;																							\
+		i2c_smbus_write_byte_data(client, reg, value);																	\
+		mutex_unlock(&data->update_lock);																				\
+		return count;																									\
+	}
+set_raw(temp_config, AD7414_REG_CONF);
+set_raw(temp_high, AD7414_REG_TEMP_HIGH);
+set_raw(temp_low, AD7414_REG_TEMP_LOW);
+#endif // CONFIG_HWMON_DEBUG_SYSFS_FILES
+
+#ifdef CONFIG_HWMON_DEBUG_SYSFS_FILES
+/* Custom raw/text register access */
+static DEVICE_ATTR(raw_config, S_IWUSR | S_IRUGO, show_raw_temp_config,
+		   set_raw_temp_config);
+static DEVICE_ATTR(raw_high, S_IWUSR | S_IRUGO, show_raw_temp_high,
+		   set_raw_temp_high);
+static DEVICE_ATTR(raw_low, S_IWUSR | S_IRUGO, show_raw_temp_low,
+		   set_raw_temp_low);
+static DEVICE_ATTR(raw_value, S_IRUGO, show_raw_temp_value, NULL);
+
+static DEVICE_ATTR(text_config, S_IRUGO, show_text_temp_config, NULL);
+static DEVICE_ATTR(text_high, S_IRUGO, show_text_temp_high, NULL);
+static DEVICE_ATTR(text_low, S_IRUGO, show_text_temp_low, NULL);
+static DEVICE_ATTR(text_value, S_IRUGO, show_text_temp_value, NULL);
+#endif // CONFIG_HWMON_DEBUG_SYSFS_FILES
+
+/* Standard sysfs hwmon files */
+static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp1_input, NULL);
+
+static int ad7414_ADC_to_temp(int ADC)
+{
+	/* ADC temp is D15..D6, two's complement, but it's only 10 bits */
+	/* translates temperature reading to milliCentigrade */
+	ADC = ADC >> 6;
+	if (ADC > 0x200) {
+		return (((ADC & 0x1ff) - 512) * 1000 / 4);
+	} else {
+		return (ADC * 1000 / 4);
+	}
+}
+
+static int ad7414_read_value(struct i2c_client *client, u8 reg)
+{
+	int value = ~0;
+	switch (reg) {
+	case AD7414_REG_TEMP:	/* 10-bit register, MSB first */
+		value = swab16(i2c_smbus_read_word_data(client, reg));
+		break;
+	default:		/* 8-bit register */
+		value = i2c_smbus_read_byte_data(client, reg);
+		break;
+	}
+	return value;
+}
+
+static int ad7414_attach_adapter(struct i2c_adapter *adapter)
+{
+	return i2c_probe(adapter, &addr_data, ad7414_detect);
+}
+
+/* This function is called by i2c_probe */
+static int ad7414_detect(struct i2c_adapter *adapter, int address,
+			 int kind)
+{
+	struct i2c_client *new_client = NULL;
+	struct ad7414_data *data = NULL;
+	int err = 0;
+
+	if (!i2c_check_functionality
+	    (adapter, I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA))
+		goto error;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data) {
+		err = -ENOMEM;
+		goto error;
+	}
+
+	new_client = &data->client;
+	i2c_set_clientdata(new_client, data);
+	new_client->addr = address;
+	new_client->adapter = adapter;
+	new_client->driver = &ad7414_driver;
+	new_client->flags = 0;
+
+	/* Fill in the remaining client fields */
+	strncpy(new_client->name, "ad7414", I2C_NAME_SIZE);
+	data->valid = 0;
+	mutex_init(&data->update_lock);
+
+	/* Tell the I2C layer a new client has arrived */
+	err = i2c_attach_client(new_client);
+	if (err)
+		goto error;
+
+	/* Register sysfs files: best-effort */
+#ifdef CONFIG_HWMON_DEBUG_SYSFS_FILES
+	device_create_file(&new_client->dev, &dev_attr_raw_config);
+	device_create_file(&new_client->dev, &dev_attr_raw_high);
+	device_create_file(&new_client->dev, &dev_attr_raw_low);
+	device_create_file(&new_client->dev, &dev_attr_raw_value);
+
+	device_create_file(&new_client->dev, &dev_attr_text_config);
+	device_create_file(&new_client->dev, &dev_attr_text_high);
+	device_create_file(&new_client->dev, &dev_attr_text_low);
+	device_create_file(&new_client->dev, &dev_attr_text_value);
+#endif // CONFIG_HWMON_DEBUG_SYSFS_FILES
+
+	device_create_file(&new_client->dev, &dev_attr_temp1_input);
+	return 0;
+
+error:
+	kfree(data);
+	return err;
+}
+
+static int ad7414_detach_client(struct i2c_client *client)
+{
+	struct ad7414_data *data = i2c_get_clientdata(client);
+	int err;
+
+	err = i2c_detach_client(client);
+	if (err) {
+		dev_err(&client->dev,
+			"Client deregistration failed, client not detached.\n");
+		return err;
+	}
+	kfree(data);
+	return 0;
+}
+
+static struct ad7414_data *ad7414_update_device(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct ad7414_data *data = i2c_get_clientdata(client);
+
+	mutex_lock(&data->update_lock);
+
+	/* Temperature reading updates every 800ms */
+	if (time_after(jiffies, data->last_updated + HZ * 8 / 10)
+	    || !data->valid) {
+		dev_dbg(&client->dev, "Starting ad7414 update\n");
+
+		data->temp_value +		    ad7414_read_value(client, AD7414_REG_TEMP);
+		data->temp_config +		    ad7414_read_value(client, AD7414_REG_CONF);
+		data->temp_high +		    ad7414_read_value(client, AD7414_REG_TEMP_HIGH);
+		data->temp_low +		    ad7414_read_value(client, AD7414_REG_TEMP_LOW);
+		data->last_updated = jiffies;
+		data->valid = 1;
+	}
+
+	mutex_unlock(&data->update_lock);
+
+	return data;
+}
+
+static int __init ad7414_init(void)
+{
+	return i2c_add_driver(&ad7414_driver);
+}
+
+static void __exit ad7414_exit(void)
+{
+	i2c_del_driver(&ad7414_driver);
+}
+
+
+MODULE_AUTHOR("Theuns Verwoerd <theuns.verwoerd at bluewatersys.com>");
+MODULE_DESCRIPTION("AD7414 I2C driver");
+MODULE_LICENSE("GPL");
+
+module_init(ad7414_init);
+module_exit(ad7414_exit);
diff -uprN -X linux-2.6.18-rc4.orig/Documentation/dontdiff linux-2.6.18-rc4.orig/drivers/hwmon/Kconfig linux-2.6.18-rc4/drivers/hwmon/Kconfig
--- linux-2.6.18-rc4.orig/drivers/hwmon/Kconfig	2006-08-08 14:59:44.000000000 +1200
+++ linux-2.6.18-rc4/drivers/hwmon/Kconfig	2006-08-08 15:52:33.000000000 +1200
@@ -39,6 +39,16 @@ config SENSORS_ABITUGURU
 	  This driver can also be built as a module.  If so, the module
 	  will be called abituguru.
 
+config SENSORS_AD7414
+	tristate "Analog Devices AD7414 Temperature Sensor"
+	depends on HWMON && I2C && EXPERIMENTAL
+	help
+	  If you say yes here you get support for Analog Devices
+	  AD7414 temperature sensor.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called ad7414.
+
 config SENSORS_ADM1021
 	tristate "Analog Devices ADM1021 and compatibles"
 	depends on HWMON && I2C
@@ -507,6 +517,17 @@ config SENSORS_HDAPS
 	  Say Y here if you have an applicable laptop and want to experience
 	  the awesome power of hdaps.
 
+config HWMON_DEBUG_SYSFS_FILES
+	bool "Hardware Monitoring sysfs debugging files"
+	depends on HWMON && EXPERIMENTAL
+	default n
+	help
+	  Say Y here if you want the I2C chip drivers to produce a bunch of
+	  sysfs files exposing raw device registers.  Select this if you are 
+	  doing development on I2C chip drivers.
+
+	  Currenly supported by: AD7414
+
 config HWMON_DEBUG_CHIP
 	bool "Hardware Monitoring Chip debugging messages"
 	depends on HWMON
diff -uprN -X linux-2.6.18-rc4.orig/Documentation/dontdiff linux-2.6.18-rc4.orig/drivers/hwmon/Makefile linux-2.6.18-rc4/drivers/hwmon/Makefile
--- linux-2.6.18-rc4.orig/drivers/hwmon/Makefile	2006-08-08 14:59:44.000000000 +1200
+++ linux-2.6.18-rc4/drivers/hwmon/Makefile	2006-08-08 15:47:05.000000000 +1200
@@ -13,6 +13,7 @@ obj-$(CONFIG_SENSORS_W83781D)	+= w83781d
 obj-$(CONFIG_SENSORS_W83791D)	+= w83791d.o
 
 obj-$(CONFIG_SENSORS_ABITUGURU)	+= abituguru.o
+obj-$(CONFIG_SENSORS_AD7414)	+= ad7414.o
 obj-$(CONFIG_SENSORS_ADM1021)	+= adm1021.o
 obj-$(CONFIG_SENSORS_ADM1025)	+= adm1025.o
 obj-$(CONFIG_SENSORS_ADM1026)	+= adm1026.o
diff -uprN -X linux-2.6.18-rc4.orig/Documentation/dontdiff linux-2.6.18-rc4.orig/include/linux/i2c-id.h linux-2.6.18-rc4/include/linux/i2c-id.h
--- linux-2.6.18-rc4.orig/include/linux/i2c-id.h	2006-08-08 15:02:37.000000000 +1200
+++ linux-2.6.18-rc4/include/linux/i2c-id.h	2006-08-08 16:00:16.000000000 +1200
@@ -116,6 +116,7 @@
 #define I2C_DRIVERID_KS0127	86	/* Samsung ks0127 video decoder */
 #define I2C_DRIVERID_TLV320AIC23B 87	/* TI TLV320AIC23B audio codec  */
 #define I2C_DRIVERID_ISL1208	88	/* Intersil ISL1208 RTC		*/
+#define I2C_DRIVERID_AD7414	89	/* AD7414 I2C Chip Driver */
 
 #define I2C_DRIVERID_I2CDEV	900
 #define I2C_DRIVERID_ARP        902    /* SMBus ARP Client              */
diff -uprN -X linux-2.6.18-rc4.orig/Documentation/dontdiff linux-2.6.18-rc4.orig/include/linux/utsrelease.h linux-2.6.18-rc4/include/linux/utsrelease.h
--- linux-2.6.18-rc4.orig/include/linux/utsrelease.h	1970-01-01 12:00:00.000000000 +1200
+++ linux-2.6.18-rc4/include/linux/utsrelease.h	2006-08-08 15:53:06.000000000 +1200
@@ -0,0 +1 @@
+#define UTS_RELEASE "2.6.18-rc4"


-------------- next part --------------
A non-text attachment was scrubbed...
Name: ad7414_support_2.6.18-rc4.patch.bz2
Type: application/x-bzip
Size: 3876 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060808/034c6b4a/attachment.bin 
