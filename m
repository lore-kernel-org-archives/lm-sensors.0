From: mort@bork.org (Martin Hicks)
Date: Wed, 12 Jul 2006 14:43:40 +0000
Subject: [lm-sensors] [PATCH] hwmon:  Add support for DS1682
Message-Id: <20060712144340.GI16658@bork.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi,

This adds a driver for the Dallas Semiconductor DS1682
Total Elapsed Time counter.

Signed-off-by: Martin Hicks <mort at bork.org>

---

 drivers/hwmon/Kconfig  |   25 ++++
 drivers/hwmon/Makefile |    1 
 drivers/hwmon/ds1682.c |  321 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/i2c-id.h |    1 
 4 files changed, 348 insertions(+), 0 deletions(-)
 create mode 100644 drivers/hwmon/ds1682.c

929a2c6bbd7ba9abdc68219552f2944290d8f45f
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 0e31a0c..2a45d83 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -129,6 +129,31 @@ config SENSORS_DS1621
 	  This driver can also be built as a module.  If so, the module
 	  will be called ds1621.
 
+config SENSORS_DS1682
+        tristate "Dallas Semiconductor DS1682"
+        depends on HWMON && I2C && EXPERIMENTAL
+        help
+          If you say yes here you get support for Dallas Semiconductor
+          DS1682 total elapsed time recorder.
+
+          This driver can also be built as a module.  If so, the module
+          will be called ds1682.
+
+config SENSORS_DS1682_RESET
+        bool "Enable DS1682 Config and Reset capabilities"
+        depends on SENSORS_DS1682
+        help
+          This enables the configuration phase of the ds1682.  Once you
+          setup the config register to your liking you can issue a reset
+          command by doing, for example:
+                
+                  echo 55 > /sys/bus/i2c/devices/0-006b/reset
+
+          twice. This permanently locks the device into its current
+          configuration.
+
+          YOU CAN ONLY DO THIS ONCE.  Subsequent resets are ignored.
+
 config SENSORS_F71805F
 	tristate "Fintek F71805F/FG"
 	depends on HWMON && EXPERIMENTAL
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 3141584..d435011 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_SENSORS_ADM1031)	+= adm1031
 obj-$(CONFIG_SENSORS_ADM9240)	+= adm9240.o
 obj-$(CONFIG_SENSORS_ATXP1)	+= atxp1.o
 obj-$(CONFIG_SENSORS_DS1621)	+= ds1621.o
+obj-$(CONFIG_SENSORS_DS1682)	+= ds1682.o
 obj-$(CONFIG_SENSORS_F71805F)	+= f71805f.o
 obj-$(CONFIG_SENSORS_FSCHER)	+= fscher.o
 obj-$(CONFIG_SENSORS_FSCPOS)	+= fscpos.o
diff --git a/drivers/hwmon/ds1682.c b/drivers/hwmon/ds1682.c
new file mode 100644
index 0000000..109f689
--- /dev/null
+++ b/drivers/hwmon/ds1682.c
@@ -0,0 +1,321 @@
+/*
+ * ds1682.c	for the Dallas Semiconductor DS1682 Total-Elapsed-Time
+ *		recorder with Alarm.
+ *
+ * Copyright (C) 2006  Martin Hicks <mort at bork.org>
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
+#include <linux/mutex.h>
+#include <linux/delay.h>
+
+/* Addresses to scan */
+static unsigned short normal_i2c[] = { 0x6b, I2C_CLIENT_END };
+
+/* Insmod parameters */
+I2C_CLIENT_INSMOD_1(ds1682);
+
+/* Registers */
+enum ds1682_reg {
+	CONFIG_REG		= 0x00,
+	ALARM_REG		= 0x01,
+	ETC_REG			= 0x05,
+	EVENT_CTR_REG		= 0x09,
+	USER1_REG		= 0x0b,
+	USER2_REG		= 0x0c,
+	USER3_REG		= 0x0d,
+	USER4_REG		= 0x0e,
+	USER5_REG		= 0x0f,
+	USER6_REG		= 0x10,
+	USER7_REG		= 0x11,
+	USER8_REG		= 0x12,
+	USER9_REG		= 0x13,
+	USER10_REG		= 0x14,
+	/* Unused 0x15-0x1c */
+	RESET_REG		= 0x1d,
+	WRITE_DISABLE_REG 	= 0x1e,
+	WRITE_MEM_DISABLE_REG	= 0x1f,
+};
+
+enum config_bits {
+	ECMSB	= 1<<0,	/* Event Counter MSB */
+	AP	= 1<<1,	/* Alarm Polarity */
+	RE	= 1<<2,	/* Reset Enable */
+	AOS	= 1<<3,	/* Alarm Output Select */
+	WMDF	= 1<<4,	/* Write-Memory-Disable Flag */
+	WDF	= 1<<5,	/* Write Disable Flag */
+	AF	= 1<<6,	/* Alarm Flag */
+	UNUSED	= 1<<7,
+};
+	
+
+static int ds1682_attach_adapter(struct i2c_adapter *adapter);
+static int ds1682_detect(struct i2c_adapter *adapter, int address, int kind);
+static int ds1682_detach_client(struct i2c_client *client);
+static struct ds1682_data *ds1682_update_device(struct device *dev);
+
+static struct i2c_driver ds1682_driver = {
+	.driver = {
+		.name	= "ds1682",
+	},
+	.id		= I2C_DRIVERID_DS1682,
+	.attach_adapter	= ds1682_attach_adapter,
+	.detach_client	= ds1682_detach_client,
+};
+
+struct ds1682_data {
+	enum chips type;
+	struct i2c_client client;
+	struct class_device *class_dev;
+	struct mutex update_lock;
+	char valid;
+	unsigned long last_updated_measure;
+
+	union {
+		u8 etc_byte[4];
+		u32 etc_int;
+	} etc;
+	u32 event_ctr;
+	u8 config;
+};
+
+/*** sysfs accessors ***/
+static ssize_t show_etc(struct device *dev, struct device_attribute *dummy,
+			char *buf)
+{
+	struct ds1682_data *data = ds1682_update_device(dev);
+	return sprintf(buf, "%d\n", data->etc.etc_int >> 2);
+}
+static DEVICE_ATTR(time_elapsed, S_IRUGO, show_etc, NULL);
+
+static ssize_t show_event_ctr(struct device *dev,
+			      struct device_attribute *dummy, char *buf)
+{
+	struct ds1682_data *data = ds1682_update_device(dev);
+	return sprintf(buf, "%d\n", data->event_ctr);
+}
+static DEVICE_ATTR(event_counter, S_IRUGO, show_event_ctr, NULL);
+
+#ifdef CONFIG_SENSORS_DS1682_RESET
+static ssize_t do_reset(struct device *dev, struct device_attribute *devattr,
+			const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct ds1682_data *data = i2c_get_clientdata(client);
+	static int reset = 0;
+	long val = simple_strtol(buf, NULL, 10);
+
+	if (val = 55) {
+		u8 config;
+
+		if (++reset != 2)
+			return count;
+
+		mutex_lock(&data->update_lock);
+		i2c_smbus_write_byte_data(client, RESET_REG, 0x55);
+		i2c_smbus_write_byte_data(client, RESET_REG, 0x55);
+		data->valid = 0;
+		printk("ds1682: reset issued\n");
+		mutex_unlock(&data->update_lock);
+	} else
+		printk("ds1682: invalid reset code\n");
+
+	return count;
+}
+static DEVICE_ATTR(reset, S_IWUSR, NULL, do_reset);
+#endif /* CONFIG_SENSORS_DS1682_RESET */
+
+static ssize_t read_user_eeprom(struct device *dev,
+				struct device_attribute *dummy,
+				char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	int count = 0, i;
+
+	for (i = 0; i < 10; i++) {
+		u8 val = i2c_smbus_read_byte_data(client, USER1_REG + i);
+		count += sprintf(buf + i, "%c", val);
+	}
+	return count;
+}
+
+static ssize_t write_user_eeprom(struct device *dev,
+				 struct device_attribute *devattr,
+				 const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct ds1682_data *data = ds1682_update_device(dev);
+	int i;
+
+	/* User EEPROM writing is disabled */
+	if (data->config & WMDF)
+		return 0;
+
+	for (i = 0; i < count; i++)
+		i2c_smbus_write_byte_data(client, USER1_REG+i, buf[i]);
+
+	return count;
+}
+static DEVICE_ATTR(user_eeprom, S_IWUSR | S_IRUGO,
+		   read_user_eeprom, write_user_eeprom);
+
+static ssize_t get_config(struct device *dev,
+			  struct device_attribute *dummy,
+			  char *buf)
+{
+	struct ds1682_data *data = ds1682_update_device(dev);
+	return sprintf(buf, "%02x\n", data->config);
+}
+
+#ifdef CONFIG_SENSORS_DS1682_RESET
+static ssize_t set_config(struct device *dev,
+			  struct device_attribute *devattr,
+			  const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	unsigned int config;
+
+	sscanf(buf, "%x", &config);
+	/* This is an 8-bit register */
+	if (config > 0xff) {
+		printk("ds1682: set_config failed.  (value > 0xff)\n");
+		return -ERANGE;
+	}
+
+	i2c_smbus_write_byte_data(client, CONFIG_REG, config);
+
+	return count;
+}
+static DEVICE_ATTR(config, S_IWUSR | S_IRUGO,
+		   get_config, set_config);
+#else
+static DEVICE_ATTR(config, S_IRUGO, get_config, NULL);
+#endif /* CONFIG_SENSORS_DS1682_RESET */
+
+static int ds1682_detect(struct i2c_adapter *adapter, int address, int kind)
+{
+	struct i2c_client *new_client;
+	struct ds1682_data *data;
+	int err = 0;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		goto exit;
+
+	if (!(data = kzalloc(sizeof(*data), GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	new_client = &data->client;
+	i2c_set_clientdata(new_client, data);
+	new_client->addr = address;
+	new_client->adapter = adapter;
+	new_client->driver = &ds1682_driver;
+	new_client->flags = 0;
+
+	/* Just assume that anything at 0x6b is a ds1682 */
+	strlcpy(new_client->name, "ds1682", I2C_NAME_SIZE);
+	data->type = ds1682;
+	mutex_init(&data->update_lock);
+
+	if ((err = i2c_attach_client(new_client)))
+		goto exit_free;
+
+	/* populate sysfs filesystem */
+	data->class_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->class_dev)) {
+		err = PTR_ERR(data->class_dev);
+		goto exit_detach;
+	}
+
+	device_create_file(&new_client->dev, &dev_attr_time_elapsed);
+	device_create_file(&new_client->dev, &dev_attr_event_counter);
+#ifdef CONFIG_SENSORS_DS1682_RESET
+	device_create_file(&new_client->dev, &dev_attr_reset);
+#endif
+	device_create_file(&new_client->dev, &dev_attr_user_eeprom);
+	device_create_file(&new_client->dev, &dev_attr_config);
+
+	return 0;
+
+exit_detach:
+	i2c_detach_client(new_client);
+exit_free:
+	kfree(data);
+exit:
+	return err;
+}
+
+static struct ds1682_data *ds1682_update_device(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct ds1682_data *data = i2c_get_clientdata(client);
+	int i;
+
+	mutex_lock(&data->update_lock);
+
+	/* Don't let stuff poll faster than the clock tick */
+	if (time_after(jiffies, data->last_updated_measure + 3*HZ/4) || !data->valid) {
+		/* Read the Elapsed Time Counter */
+		for (i = 0; i < 4; i++)
+			data->etc.etc_byte[i] +				i2c_smbus_read_byte_data(client, ETC_REG+i);
+		data->etc.etc_int = swab32(data->etc.etc_int);
+
+		data->config = i2c_smbus_read_byte_data(client, CONFIG_REG);
+
+		/*
+		 * The MSB of the Event Counter is stored in the
+		 * config register
+		 */
+		if (data->config & 1)
+			data->event_ctr = 1<<16;
+		data->event_ctr |= i2c_smbus_read_word_data(client, EVENT_CTR_REG);
+	}
+	mutex_unlock(&data->update_lock);
+	return data;
+}
+
+static int ds1682_attach_adapter(struct i2c_adapter *adapter)
+{
+	if (!(adapter->class & I2C_CLASS_HWMON))
+		return 0;
+	return i2c_probe(adapter, &addr_data, ds1682_detect);
+}
+
+static int ds1682_detach_client(struct i2c_client *client)
+{
+	struct ds1682_data *data = i2c_get_clientdata(client);
+	int err;
+
+	hwmon_device_unregister(data->class_dev);
+
+	if ((err = i2c_detach_client(client)))
+		return err;
+
+	kfree(data);
+	return 0;
+}
+
+static int __init sensors_ds1682_init(void)
+{
+	return i2c_add_driver(&ds1682_driver);
+}
+
+static void __exit sensors_ds1682_exit(void)
+{
+	i2c_del_driver(&ds1682_driver);
+}
+
+MODULE_AUTHOR("Martin Hicks <mort at bork.org>");
+MODULE_DESCRIPTION("DS1682 driver");
+MODULE_LICENSE("GPL");
+
+module_init(sensors_ds1682_init);
+module_exit(sensors_ds1682_exit);
diff --git a/include/linux/i2c-id.h b/include/linux/i2c-id.h
index 21338bb..c4cf3c6 100644
--- a/include/linux/i2c-id.h
+++ b/include/linux/i2c-id.h
@@ -158,6 +158,7 @@ #define I2C_DRIVERID_LM90 1042
 #define I2C_DRIVERID_ASB100 1043
 #define I2C_DRIVERID_FSCHER 1046
 #define I2C_DRIVERID_W83L785TS 1047
+#define I2C_DRIVERID_DS1682 1049
 
 /*
  * ---- Adapter types ----------------------------------------------------
-- 
1.3.2


-- 
Martin Hicks || mort at bork.org || PGP/GnuPG: 0x4C7F2BEE

