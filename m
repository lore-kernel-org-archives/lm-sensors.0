From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 02 Mar 2009 09:40:39 +0000
Subject: [lm-sensors] [PATCH] Move the pcf8591 driver to hwmon
Message-Id: <20090302104039.437e706e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Directory drivers/i2c/chips is going away, so drivers there must find
new homes. For the pcf8591 driver, the best choice seems to be the
hwmon subsystem. While the Philips PCF8591 device isn't a typical
hardware monitoring chip, its ADC interface is compatible with the
hwmon one, so it fits somewhat.

If a better subsystem is ever created for ADC/DAC chips, the driver
could be moved there.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Aurelien Jarno <aurelien@aurel32.net>
---
 drivers/hwmon/Kconfig       |   14 +
 drivers/hwmon/Makefile      |    1 
 drivers/hwmon/pcf8591.c     |  325 +++++++++++++++++++++++++++++++++++++++++++
 drivers/i2c/chips/Kconfig   |   13 -
 drivers/i2c/chips/Makefile  |    1 
 drivers/i2c/chips/pcf8591.c |  325 -------------------------------------------
 6 files changed, 340 insertions(+), 339 deletions(-)

--- linux-2.6.29-rc6.orig/drivers/hwmon/Kconfig	2009-03-02 10:19:40.000000000 +0100
+++ linux-2.6.29-rc6/drivers/hwmon/Kconfig	2009-03-02 10:33:24.000000000 +0100
@@ -635,6 +635,20 @@ config SENSORS_PC87427
 	  This driver can also be built as a module.  If so, the module
 	  will be called pc87427.
 
+config SENSORS_PCF8591
+	tristate "Philips PCF8591 ADC/DAC"
+	depends on I2C
+	default n
+	help
+	  If you say yes here you get support for Philips PCF8591 4-channel
+	  ADC, 1-channel DAC chips.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called pcf8591.
+
+	  These devices are hard to detect and rarely found on mainstream
+	  hardware.  If unsure, say N.
+
 config SENSORS_SIS5595
 	tristate "Silicon Integrated Systems Corp. SiS5595"
 	depends on PCI
--- linux-2.6.29-rc6.orig/drivers/hwmon/Makefile	2009-01-17 09:06:19.000000000 +0100
+++ linux-2.6.29-rc6/drivers/hwmon/Makefile	2009-03-02 10:22:21.000000000 +0100
@@ -70,6 +70,7 @@ obj-$(CONFIG_SENSORS_MAX1619)	+= max1619
 obj-$(CONFIG_SENSORS_MAX6650)	+= max6650.o
 obj-$(CONFIG_SENSORS_PC87360)	+= pc87360.o
 obj-$(CONFIG_SENSORS_PC87427)	+= pc87427.o
+obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
 obj-$(CONFIG_SENSORS_SIS5595)	+= sis5595.o
 obj-$(CONFIG_SENSORS_SMSC47B397)+= smsc47b397.o
 obj-$(CONFIG_SENSORS_SMSC47M1)	+= smsc47m1.o
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.29-rc6/drivers/hwmon/pcf8591.c	2009-03-02 10:22:31.000000000 +0100
@@ -0,0 +1,325 @@
+/*
+    Copyright (C) 2001-2004 Aurelien Jarno <aurelien@aurel32.net>
+    Ported to Linux 2.6 by Aurelien Jarno <aurelien@aurel32.net> with
+    the help of Jean Delvare <khali@linux-fr.org>
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
+#include <linux/i2c.h>
+#include <linux/mutex.h>
+
+/* Addresses to scan */
+static const unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b, 0x4c,
+					0x4d, 0x4e, 0x4f, I2C_CLIENT_END };
+
+/* Insmod parameters */
+I2C_CLIENT_INSMOD_1(pcf8591);
+
+static int input_mode;
+module_param(input_mode, int, 0);
+MODULE_PARM_DESC(input_mode,
+	"Analog input mode:\n"
+	" 0 = four single ended inputs\n"
+	" 1 = three differential inputs\n"
+	" 2 = single ended and differential mixed\n"
+	" 3 = two differential inputs\n");
+
+/* The PCF8591 control byte
+      7    6    5    4    3    2    1    0
+   |  0 |AOEF|   AIP   |  0 |AINC|  AICH   | */
+
+/* Analog Output Enable Flag (analog output active if 1) */
+#define PCF8591_CONTROL_AOEF		0x40
+
+/* Analog Input Programming
+   0x00 = four single ended inputs
+   0x10 = three differential inputs
+   0x20 = single ended and differential mixed
+   0x30 = two differential inputs */
+#define PCF8591_CONTROL_AIP_MASK	0x30
+
+/* Autoincrement Flag (switch on if 1) */
+#define PCF8591_CONTROL_AINC		0x04
+
+/* Channel selection
+   0x00 = channel 0
+   0x01 = channel 1
+   0x02 = channel 2
+   0x03 = channel 3 */
+#define PCF8591_CONTROL_AICH_MASK	0x03
+
+/* Initial values */
+#define PCF8591_INIT_CONTROL	((input_mode << 4) | PCF8591_CONTROL_AOEF)
+#define PCF8591_INIT_AOUT	0	/* DAC out = 0 */
+
+/* Conversions */
+#define REG_TO_SIGNED(reg)	(((reg) & 0x80)?((reg) - 256):(reg))
+
+struct pcf8591_data {
+	struct mutex update_lock;
+
+	u8 control;
+	u8 aout;
+};
+
+static void pcf8591_init_client(struct i2c_client *client);
+static int pcf8591_read_channel(struct device *dev, int channel);
+
+/* following are the sysfs callback functions */
+#define show_in_channel(channel)					\
+static ssize_t show_in##channel##_input(struct device *dev, struct device_attribute *attr, char *buf)	\
+{									\
+	return sprintf(buf, "%d\n", pcf8591_read_channel(dev, channel));\
+}									\
+static DEVICE_ATTR(in##channel##_input, S_IRUGO,			\
+		   show_in##channel##_input, NULL);
+
+show_in_channel(0);
+show_in_channel(1);
+show_in_channel(2);
+show_in_channel(3);
+
+static ssize_t show_out0_ouput(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct pcf8591_data *data = i2c_get_clientdata(to_i2c_client(dev));
+	return sprintf(buf, "%d\n", data->aout * 10);
+}
+
+static ssize_t set_out0_output(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+{
+	unsigned int value;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct pcf8591_data *data = i2c_get_clientdata(client);
+	if ((value = (simple_strtoul(buf, NULL, 10) + 5) / 10) <= 255) {
+		data->aout = value;
+		i2c_smbus_write_byte_data(client, data->control, data->aout);
+		return count;
+	}
+	return -EINVAL;
+}
+
+static DEVICE_ATTR(out0_output, S_IWUSR | S_IRUGO,
+		   show_out0_ouput, set_out0_output);
+
+static ssize_t show_out0_enable(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct pcf8591_data *data = i2c_get_clientdata(to_i2c_client(dev));
+	return sprintf(buf, "%u\n", !(!(data->control & PCF8591_CONTROL_AOEF)));
+}
+
+static ssize_t set_out0_enable(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct pcf8591_data *data = i2c_get_clientdata(client);
+	unsigned long val = simple_strtoul(buf, NULL, 10);
+
+	mutex_lock(&data->update_lock);
+	if (val)
+		data->control |= PCF8591_CONTROL_AOEF;
+	else
+		data->control &= ~PCF8591_CONTROL_AOEF;
+	i2c_smbus_write_byte(client, data->control);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static DEVICE_ATTR(out0_enable, S_IWUSR | S_IRUGO,
+		   show_out0_enable, set_out0_enable);
+
+static struct attribute *pcf8591_attributes[] = {
+	&dev_attr_out0_enable.attr,
+	&dev_attr_out0_output.attr,
+	&dev_attr_in0_input.attr,
+	&dev_attr_in1_input.attr,
+	NULL
+};
+
+static const struct attribute_group pcf8591_attr_group = {
+	.attrs = pcf8591_attributes,
+};
+
+static struct attribute *pcf8591_attributes_opt[] = {
+	&dev_attr_in2_input.attr,
+	&dev_attr_in3_input.attr,
+	NULL
+};
+
+static const struct attribute_group pcf8591_attr_group_opt = {
+	.attrs = pcf8591_attributes_opt,
+};
+
+/*
+ * Real code
+ */
+
+/* Return 0 if detection is successful, -ENODEV otherwise */
+static int pcf8591_detect(struct i2c_client *client, int kind,
+			  struct i2c_board_info *info)
+{
+	struct i2c_adapter *adapter = client->adapter;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE
+				     | I2C_FUNC_SMBUS_WRITE_BYTE_DATA))
+		return -ENODEV;
+
+	/* Now, we would do the remaining detection. But the PCF8591 is plainly
+	   impossible to detect! Stupid chip. */
+
+	strlcpy(info->type, "pcf8591", I2C_NAME_SIZE);
+
+	return 0;
+}
+
+static int pcf8591_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	struct pcf8591_data *data;
+	int err;
+
+	if (!(data = kzalloc(sizeof(struct pcf8591_data), GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	i2c_set_clientdata(client, data);
+	mutex_init(&data->update_lock);
+
+	/* Initialize the PCF8591 chip */
+	pcf8591_init_client(client);
+
+	/* Register sysfs hooks */
+	err = sysfs_create_group(&client->dev.kobj, &pcf8591_attr_group);
+	if (err)
+		goto exit_kfree;
+
+	/* Register input2 if not in "two differential inputs" mode */
+	if (input_mode != 3) {
+		if ((err = device_create_file(&client->dev,
+					      &dev_attr_in2_input)))
+			goto exit_sysfs_remove;
+	}
+
+	/* Register input3 only in "four single ended inputs" mode */
+	if (input_mode = 0) {
+		if ((err = device_create_file(&client->dev,
+					      &dev_attr_in3_input)))
+			goto exit_sysfs_remove;
+	}
+
+	return 0;
+
+exit_sysfs_remove:
+	sysfs_remove_group(&client->dev.kobj, &pcf8591_attr_group_opt);
+	sysfs_remove_group(&client->dev.kobj, &pcf8591_attr_group);
+exit_kfree:
+	kfree(data);
+exit:
+	return err;
+}
+
+static int pcf8591_remove(struct i2c_client *client)
+{
+	sysfs_remove_group(&client->dev.kobj, &pcf8591_attr_group_opt);
+	sysfs_remove_group(&client->dev.kobj, &pcf8591_attr_group);
+	kfree(i2c_get_clientdata(client));
+	return 0;
+}
+
+/* Called when we have found a new PCF8591. */
+static void pcf8591_init_client(struct i2c_client *client)
+{
+	struct pcf8591_data *data = i2c_get_clientdata(client);
+	data->control = PCF8591_INIT_CONTROL;
+	data->aout = PCF8591_INIT_AOUT;
+
+	i2c_smbus_write_byte_data(client, data->control, data->aout);
+
+	/* The first byte transmitted contains the conversion code of the
+	   previous read cycle. FLUSH IT! */
+	i2c_smbus_read_byte(client);
+}
+
+static int pcf8591_read_channel(struct device *dev, int channel)
+{
+	u8 value;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct pcf8591_data *data = i2c_get_clientdata(client);
+
+	mutex_lock(&data->update_lock);
+
+	if ((data->control & PCF8591_CONTROL_AICH_MASK) != channel) {
+		data->control = (data->control & ~PCF8591_CONTROL_AICH_MASK)
+			      | channel;
+		i2c_smbus_write_byte(client, data->control);
+
+		/* The first byte transmitted contains the conversion code of
+		   the previous read cycle. FLUSH IT! */
+		i2c_smbus_read_byte(client);
+	}
+	value = i2c_smbus_read_byte(client);
+
+	mutex_unlock(&data->update_lock);
+
+	if ((channel = 2 && input_mode = 2) ||
+	    (channel != 3 && (input_mode = 1 || input_mode = 3)))
+		return (10 * REG_TO_SIGNED(value));
+	else
+		return (10 * value);
+}
+
+static const struct i2c_device_id pcf8591_id[] = {
+	{ "pcf8591", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, pcf8591_id);
+
+static struct i2c_driver pcf8591_driver = {
+	.driver = {
+		.name	= "pcf8591",
+	},
+	.probe		= pcf8591_probe,
+	.remove		= pcf8591_remove,
+	.id_table	= pcf8591_id,
+
+	.class		= I2C_CLASS_HWMON,	/* Nearest choice */
+	.detect		= pcf8591_detect,
+	.address_data	= &addr_data,
+};
+
+static int __init pcf8591_init(void)
+{
+	if (input_mode < 0 || input_mode > 3) {
+		printk(KERN_WARNING "pcf8591: invalid input_mode (%d)\n",
+		       input_mode);
+		input_mode = 0;
+	}
+	return i2c_add_driver(&pcf8591_driver);
+}
+
+static void __exit pcf8591_exit(void)
+{
+	i2c_del_driver(&pcf8591_driver);
+}
+
+MODULE_AUTHOR("Aurelien Jarno <aurelien@aurel32.net>");
+MODULE_DESCRIPTION("PCF8591 driver");
+MODULE_LICENSE("GPL");
+
+module_init(pcf8591_init);
+module_exit(pcf8591_exit);
--- linux-2.6.29-rc6.orig/drivers/i2c/chips/Kconfig	2009-01-29 08:27:19.000000000 +0100
+++ linux-2.6.29-rc6/drivers/i2c/chips/Kconfig	2009-03-02 10:21:09.000000000 +0100
@@ -64,19 +64,6 @@ config SENSORS_PCA9539
 	  This driver is deprecated and will be dropped soon. Use
 	  drivers/gpio/pca953x.c instead.
 
-config SENSORS_PCF8591
-	tristate "Philips PCF8591"
-	depends on EXPERIMENTAL
-	default n
-	help
-	  If you say yes here you get support for Philips PCF8591 chips.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called pcf8591.
-
-	  These devices are hard to detect and rarely found on mainstream
-	  hardware.  If unsure, say N.
-
 config SENSORS_MAX6875
 	tristate "Maxim MAX6875 Power supply supervisor"
 	depends on EXPERIMENTAL
--- linux-2.6.29-rc6.orig/drivers/i2c/chips/Makefile	2009-01-29 08:27:19.000000000 +0100
+++ linux-2.6.29-rc6/drivers/i2c/chips/Makefile	2009-03-02 10:21:59.000000000 +0100
@@ -15,7 +15,6 @@ obj-$(CONFIG_SENSORS_MAX6875)	+= max6875
 obj-$(CONFIG_SENSORS_PCA9539)	+= pca9539.o
 obj-$(CONFIG_SENSORS_PCF8574)	+= pcf8574.o
 obj-$(CONFIG_PCF8575)		+= pcf8575.o
-obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
 obj-$(CONFIG_SENSORS_TSL2550)	+= tsl2550.o
 
 ifeq ($(CONFIG_I2C_DEBUG_CHIP),y)
--- linux-2.6.29-rc6.orig/drivers/i2c/chips/pcf8591.c	2009-01-06 20:21:24.000000000 +0100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,325 +0,0 @@
-/*
-    Copyright (C) 2001-2004 Aurelien Jarno <aurelien@aurel32.net>
-    Ported to Linux 2.6 by Aurelien Jarno <aurelien@aurel32.net> with 
-    the help of Jean Delvare <khali@linux-fr.org>
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-*/
-
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/slab.h>
-#include <linux/i2c.h>
-#include <linux/mutex.h>
-
-/* Addresses to scan */
-static const unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b, 0x4c,
-					0x4d, 0x4e, 0x4f, I2C_CLIENT_END };
-
-/* Insmod parameters */
-I2C_CLIENT_INSMOD_1(pcf8591);
-
-static int input_mode;
-module_param(input_mode, int, 0);
-MODULE_PARM_DESC(input_mode,
-	"Analog input mode:\n"
-	" 0 = four single ended inputs\n"
-	" 1 = three differential inputs\n"
-	" 2 = single ended and differential mixed\n"
-	" 3 = two differential inputs\n");
-
-/* The PCF8591 control byte
-      7    6    5    4    3    2    1    0  
-   |  0 |AOEF|   AIP   |  0 |AINC|  AICH   | */
-
-/* Analog Output Enable Flag (analog output active if 1) */
-#define PCF8591_CONTROL_AOEF		0x40
-					
-/* Analog Input Programming 
-   0x00 = four single ended inputs
-   0x10 = three differential inputs
-   0x20 = single ended and differential mixed
-   0x30 = two differential inputs */
-#define PCF8591_CONTROL_AIP_MASK	0x30
-
-/* Autoincrement Flag (switch on if 1) */
-#define PCF8591_CONTROL_AINC		0x04
-
-/* Channel selection
-   0x00 = channel 0 
-   0x01 = channel 1
-   0x02 = channel 2
-   0x03 = channel 3 */
-#define PCF8591_CONTROL_AICH_MASK	0x03
-
-/* Initial values */
-#define PCF8591_INIT_CONTROL	((input_mode << 4) | PCF8591_CONTROL_AOEF)
-#define PCF8591_INIT_AOUT	0	/* DAC out = 0 */
-
-/* Conversions */
-#define REG_TO_SIGNED(reg)	(((reg) & 0x80)?((reg) - 256):(reg))
-
-struct pcf8591_data {
-	struct mutex update_lock;
-
-	u8 control;
-	u8 aout;
-};
-
-static void pcf8591_init_client(struct i2c_client *client);
-static int pcf8591_read_channel(struct device *dev, int channel);
-
-/* following are the sysfs callback functions */
-#define show_in_channel(channel)					\
-static ssize_t show_in##channel##_input(struct device *dev, struct device_attribute *attr, char *buf)	\
-{									\
-	return sprintf(buf, "%d\n", pcf8591_read_channel(dev, channel));\
-}									\
-static DEVICE_ATTR(in##channel##_input, S_IRUGO,			\
-		   show_in##channel##_input, NULL);
-
-show_in_channel(0);
-show_in_channel(1);
-show_in_channel(2);
-show_in_channel(3);
-
-static ssize_t show_out0_ouput(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct pcf8591_data *data = i2c_get_clientdata(to_i2c_client(dev));
-	return sprintf(buf, "%d\n", data->aout * 10);
-}
-
-static ssize_t set_out0_output(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
-{
-	unsigned int value;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct pcf8591_data *data = i2c_get_clientdata(client);
-	if ((value = (simple_strtoul(buf, NULL, 10) + 5) / 10) <= 255) {
-		data->aout = value;
-		i2c_smbus_write_byte_data(client, data->control, data->aout);
-		return count;
-	}
-	return -EINVAL;
-}
-
-static DEVICE_ATTR(out0_output, S_IWUSR | S_IRUGO, 
-		   show_out0_ouput, set_out0_output);
-
-static ssize_t show_out0_enable(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct pcf8591_data *data = i2c_get_clientdata(to_i2c_client(dev));
-	return sprintf(buf, "%u\n", !(!(data->control & PCF8591_CONTROL_AOEF)));
-}
-
-static ssize_t set_out0_enable(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct pcf8591_data *data = i2c_get_clientdata(client);
-	unsigned long val = simple_strtoul(buf, NULL, 10);
-
-	mutex_lock(&data->update_lock);
-	if (val)
-		data->control |= PCF8591_CONTROL_AOEF;
-	else
-		data->control &= ~PCF8591_CONTROL_AOEF;
-	i2c_smbus_write_byte(client, data->control);
-	mutex_unlock(&data->update_lock);
-	return count;
-}
-
-static DEVICE_ATTR(out0_enable, S_IWUSR | S_IRUGO, 
-		   show_out0_enable, set_out0_enable);
-
-static struct attribute *pcf8591_attributes[] = {
-	&dev_attr_out0_enable.attr,
-	&dev_attr_out0_output.attr,
-	&dev_attr_in0_input.attr,
-	&dev_attr_in1_input.attr,
-	NULL
-};
-
-static const struct attribute_group pcf8591_attr_group = {
-	.attrs = pcf8591_attributes,
-};
-
-static struct attribute *pcf8591_attributes_opt[] = {
-	&dev_attr_in2_input.attr,
-	&dev_attr_in3_input.attr,
-	NULL
-};
-
-static const struct attribute_group pcf8591_attr_group_opt = {
-	.attrs = pcf8591_attributes_opt,
-};
-
-/*
- * Real code
- */
-
-/* Return 0 if detection is successful, -ENODEV otherwise */
-static int pcf8591_detect(struct i2c_client *client, int kind,
-			  struct i2c_board_info *info)
-{
-	struct i2c_adapter *adapter = client->adapter;
-
-	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE
-				     | I2C_FUNC_SMBUS_WRITE_BYTE_DATA))
-		return -ENODEV;
-
-	/* Now, we would do the remaining detection. But the PCF8591 is plainly
-	   impossible to detect! Stupid chip. */
-
-	strlcpy(info->type, "pcf8591", I2C_NAME_SIZE);
-
-	return 0;
-}
-
-static int pcf8591_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id)
-{
-	struct pcf8591_data *data;
-	int err;
-
-	if (!(data = kzalloc(sizeof(struct pcf8591_data), GFP_KERNEL))) {
-		err = -ENOMEM;
-		goto exit;
-	}
-	
-	i2c_set_clientdata(client, data);
-	mutex_init(&data->update_lock);
-
-	/* Initialize the PCF8591 chip */
-	pcf8591_init_client(client);
-
-	/* Register sysfs hooks */
-	err = sysfs_create_group(&client->dev.kobj, &pcf8591_attr_group);
-	if (err)
-		goto exit_kfree;
-
-	/* Register input2 if not in "two differential inputs" mode */
-	if (input_mode != 3) {
-		if ((err = device_create_file(&client->dev,
-					      &dev_attr_in2_input)))
-			goto exit_sysfs_remove;
-	}
-
-	/* Register input3 only in "four single ended inputs" mode */
-	if (input_mode = 0) {
-		if ((err = device_create_file(&client->dev,
-					      &dev_attr_in3_input)))
-			goto exit_sysfs_remove;
-	}
-
-	return 0;
-
-exit_sysfs_remove:
-	sysfs_remove_group(&client->dev.kobj, &pcf8591_attr_group_opt);
-	sysfs_remove_group(&client->dev.kobj, &pcf8591_attr_group);
-exit_kfree:
-	kfree(data);
-exit:
-	return err;
-}
-
-static int pcf8591_remove(struct i2c_client *client)
-{
-	sysfs_remove_group(&client->dev.kobj, &pcf8591_attr_group_opt);
-	sysfs_remove_group(&client->dev.kobj, &pcf8591_attr_group);
-	kfree(i2c_get_clientdata(client));
-	return 0;
-}
-
-/* Called when we have found a new PCF8591. */
-static void pcf8591_init_client(struct i2c_client *client)
-{
-	struct pcf8591_data *data = i2c_get_clientdata(client);
-	data->control = PCF8591_INIT_CONTROL;
-	data->aout = PCF8591_INIT_AOUT;
-
-	i2c_smbus_write_byte_data(client, data->control, data->aout);
-	
-	/* The first byte transmitted contains the conversion code of the 
-	   previous read cycle. FLUSH IT! */
-	i2c_smbus_read_byte(client);
-}
-
-static int pcf8591_read_channel(struct device *dev, int channel)
-{
-	u8 value;
-	struct i2c_client *client = to_i2c_client(dev);
-	struct pcf8591_data *data = i2c_get_clientdata(client);
-
-	mutex_lock(&data->update_lock);
-
-	if ((data->control & PCF8591_CONTROL_AICH_MASK) != channel) {
-		data->control = (data->control & ~PCF8591_CONTROL_AICH_MASK)
-			      | channel;
-		i2c_smbus_write_byte(client, data->control);
-	
-		/* The first byte transmitted contains the conversion code of 
-		   the previous read cycle. FLUSH IT! */
-		i2c_smbus_read_byte(client);
-	}
-	value = i2c_smbus_read_byte(client);
-
-	mutex_unlock(&data->update_lock);
-
-	if ((channel = 2 && input_mode = 2) ||
-	    (channel != 3 && (input_mode = 1 || input_mode = 3)))
-		return (10 * REG_TO_SIGNED(value));
-	else
-		return (10 * value);
-}
-
-static const struct i2c_device_id pcf8591_id[] = {
-	{ "pcf8591", 0 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, pcf8591_id);
-
-static struct i2c_driver pcf8591_driver = {
-	.driver = {
-		.name	= "pcf8591",
-	},
-	.probe		= pcf8591_probe,
-	.remove		= pcf8591_remove,
-	.id_table	= pcf8591_id,
-
-	.class		= I2C_CLASS_HWMON,	/* Nearest choice */
-	.detect		= pcf8591_detect,
-	.address_data	= &addr_data,
-};
-
-static int __init pcf8591_init(void)
-{
-	if (input_mode < 0 || input_mode > 3) {
-		printk(KERN_WARNING "pcf8591: invalid input_mode (%d)\n",
-		       input_mode);
-		input_mode = 0;
-	}
-	return i2c_add_driver(&pcf8591_driver);
-}
-
-static void __exit pcf8591_exit(void)
-{
-	i2c_del_driver(&pcf8591_driver);
-}
-
-MODULE_AUTHOR("Aurelien Jarno <aurelien@aurel32.net>");
-MODULE_DESCRIPTION("PCF8591 driver");
-MODULE_LICENSE("GPL");
-
-module_init(pcf8591_init);
-module_exit(pcf8591_exit);

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
