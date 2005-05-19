From: aurelien@aurel32.net (Aurelien Jarno)
Date: Thu, 19 May 2005 06:24:48 +0000
Subject: Fw: [PATCH 2.6] New chip driver: pcf8574
Message-Id: <20040318224531.GA23105@pc.aurel32.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Oops, I send a patch to Greg KH and I forgot to copy the lm-sensors 
list. Please find below the mail I sent to him.

Sorry for all.

----- Original Message -----
From: Aurelien Jarno <aurelien@aurel32.net>
To: Greg KH <greg@kroah.com>
Sent: Thu, 18 Mar 2004 23:37:37 +0100
Subject: [PATCH 2.6] New chip driver: pcf8574

Hi Greg,

Please find below a patch against kernel 2.6.5-rc1 to add the pcf8574
driver (an I/O expander for the I2C bus). I have ported it from the 2.4
version, and it includes some fixes and simplifications.

It has been reviewed by Jean Delvare on IRC.

Thanks,
Aurelien

diff -urN linux-2.6.5-rc1.orig/drivers/i2c/chips/Kconfig linux-2.6.5-rc1/drivers/i2c/chips/Kconfig
--- linux-2.6.5-rc1.orig/drivers/i2c/chips/Kconfig	2004-03-18 20:24:27.000000000 +0100
+++ linux-2.6.5-rc1/drivers/i2c/chips/Kconfig	2004-03-18 20:25:26.000000000 +0100
@@ -209,4 +209,15 @@
 	  This driver can also be built as a module.  If so, the module
 	  will be called eeprom.
 
+config SENSORS_PCF8574
+	tristate "Philips PCF8574 and PCF8574A"
+	depends on I2C && EXPERIMENTAL
+	select I2C_SENSOR
+	help
+	  If you say yes here you get support for Philips PCF8574 and 
+	  PCF8574A chips.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called pcf8574.
+
 endmenu
diff -urN linux-2.6.5-rc1.orig/drivers/i2c/chips/Makefile linux-2.6.5-rc1/drivers/i2c/chips/Makefile
--- linux-2.6.5-rc1.orig/drivers/i2c/chips/Makefile	2004-03-18 20:24:27.000000000 +0100
+++ linux-2.6.5-rc1/drivers/i2c/chips/Makefile	2004-03-18 20:25:26.000000000 +0100
@@ -19,6 +19,7 @@
 obj-$(CONFIG_SENSORS_LM83)	+= lm83.o
 obj-$(CONFIG_SENSORS_LM85)	+= lm85.o
 obj-$(CONFIG_SENSORS_LM90)	+= lm90.o
+obj-$(CONFIG_SENSORS_PCF8574)	+= pcf8574.o
 obj-$(CONFIG_SENSORS_VIA686A)	+= via686a.o
 obj-$(CONFIG_SENSORS_W83L785TS)	+= w83l785ts.o
 
diff -urN linux-2.6.5-rc1.orig/drivers/i2c/chips/pcf8574.c linux-2.6.5-rc1/drivers/i2c/chips/pcf8574.c
--- linux-2.6.5-rc1.orig/drivers/i2c/chips/pcf8574.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.5-rc1/drivers/i2c/chips/pcf8574.c	2004-03-18 22:23:10.000000000 +0100
@@ -0,0 +1,245 @@
+/*
+    pcf8574.c - Part of lm_sensors, Linux kernel modules for hardware
+             monitoring
+    Copyright (c) 2000  Frodo Looijaard <frodol@dds.nl>, 
+                        Philip Edelbrock <phil@netroedge.com>,
+                        Dan Eaton <dan.eaton@rocketlogix.com>
+    Ported to Linux 2.6 by Aurelien Jarno <aurel32@debian.org> with 
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
+/* A few notes about the PCF8574:
+
+* The PCF8574 is an 8-bit I/O expander for the I2C bus produced by
+  Philips Semiconductors.  It is designed to provide a byte I2C
+  interface to up to 8 separate devices.
+  
+* The PCF8574 appears as a very simple SMBus device which can be
+  read from or written to with SMBUS byte read/write accesses.
+
+  --Dan
+
+*/
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/i2c-sensor.h>
+
+/* Addresses to scan */
+static unsigned short normal_i2c[] = { I2C_CLIENT_END };
+static unsigned short normal_i2c_range[] = { 0x20, 0x27, 0x38, 0x3f, I2C_CLIENT_END };
+static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
+static unsigned int normal_isa_range[] = { I2C_CLIENT_ISA_END };
+
+/* Insmod parameters */
+SENSORS_INSMOD_2(pcf8574, pcf8574a);
+
+/* Initial values */
+#define PCF8574_INIT 255	/* All outputs on (input mode) */
+
+/* Each client has this additional data */
+struct pcf8574_data {
+	struct semaphore update_lock;
+
+	u8 read, write;			/* Register values */
+};
+
+static int pcf8574_attach_adapter(struct i2c_adapter *adapter);
+static int pcf8574_detect(struct i2c_adapter *adapter, int address, int kind);
+static int pcf8574_detach_client(struct i2c_client *client);
+static void pcf8574_init_client(struct i2c_client *client);
+static struct pcf8574_data *pcf8574_update_client(struct device *dev);
+
+/* This is the driver that will be inserted */
+static struct i2c_driver pcf8574_driver = {
+	.owner		= THIS_MODULE,
+	.name		= "pcf8574",
+	.id		= I2C_DRIVERID_PCF8574,
+	.flags		= I2C_DF_NOTIFY,
+	.attach_adapter	= pcf8574_attach_adapter,
+	.detach_client	= pcf8574_detach_client,
+};
+
+static int pcf8574_id = 0;
+
+/* following are the sysfs callback functions */
+static ssize_t show_read(struct device *dev, char *buf)
+{
+	struct pcf8574_data *data = pcf8574_update_client(dev);
+	return sprintf(buf, "%u\n", data->read);
+}
+
+static DEVICE_ATTR(read, S_IRUGO, show_read, NULL);
+
+static ssize_t show_write(struct device *dev, char *buf)
+{
+	struct pcf8574_data *data = i2c_get_clientdata(to_i2c_client(dev));
+	return sprintf(buf, "%u\n", data->write);
+}
+
+static ssize_t set_write(struct device *dev, const char *buf,
+			 size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct pcf8574_data *data = i2c_get_clientdata(client);
+	data->write = simple_strtoul(buf, NULL, 10);
+	i2c_smbus_write_byte(client, data->write);
+	return count;
+}
+
+static DEVICE_ATTR(write, S_IWUSR | S_IRUGO, show_write, set_write);
+
+/*
+ * Real code
+ */
+
+static int pcf8574_attach_adapter(struct i2c_adapter *adapter)
+{
+	return i2c_detect(adapter, &addr_data, pcf8574_detect);
+}
+
+/* This function is called by i2c_detect */
+int pcf8574_detect(struct i2c_adapter *adapter, int address, int kind)
+{
+	struct i2c_client *new_client;
+	struct pcf8574_data *data;
+	int err = 0;
+	const char *client_name = "";
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
+		goto exit;
+
+	/* OK. For now, we presume we have a valid client. We now create the
+	   client structure, even though we cannot fill it completely yet. */
+	if (!(new_client = kmalloc(sizeof(struct i2c_client) +
+				   sizeof(struct pcf8574_data),
+				   GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	memset(new_client, 0, sizeof(struct i2c_client) +
+	       sizeof(struct pcf8574_data));
+
+	data = (struct pcf8574_data *) (new_client + 1);
+	i2c_set_clientdata(new_client, data);
+	new_client->addr = address;
+	new_client->adapter = adapter;
+	new_client->driver = &pcf8574_driver;
+	new_client->flags = 0;
+
+	/* Now, we would do the remaining detection. But the PCF8574 is plainly
+	   impossible to detect! Stupid chip. */
+
+	/* Determine the chip type */
+	if (kind <= 0) {
+		if (address >= 0x38 && address <= 0x3f)
+			kind = pcf8574a;
+		else
+			kind = pcf8574;
+	}
+
+	if (kind = pcf8574a)
+		client_name = "pcf8574a";
+	else
+		client_name = "pcf8574";
+
+	/* Fill in the remaining client fields and put it into the global list */
+	strlcpy(new_client->name, client_name, I2C_NAME_SIZE);
+
+	new_client->id = pcf8574_id++;
+	init_MUTEX(&data->update_lock);
+
+	/* Tell the I2C layer a new client has arrived */
+	if ((err = i2c_attach_client(new_client)))
+		goto exit_free;
+	
+	/* Initialize the PCF8574 chip */
+	pcf8574_init_client(new_client);
+
+	/* Register sysfs hooks */
+	device_create_file(&new_client->dev, &dev_attr_read);
+	device_create_file(&new_client->dev, &dev_attr_write);
+	return 0;
+
+/* OK, this is not exactly good programming practice, usually. But it is
+   very code-efficient in this case. */
+
+      exit_free:
+	kfree(new_client);
+      exit:
+	return err;
+}
+
+static int pcf8574_detach_client(struct i2c_client *client)
+{
+	int err;
+
+	if ((err = i2c_detach_client(client))) {
+		dev_err(&client->dev,
+			"Client deregistration failed, client not detached.\n");
+		return err;
+	}
+
+	kfree(client);
+	return 0;
+}
+
+/* Called when we have found a new PCF8574. */
+static void pcf8574_init_client(struct i2c_client *client)
+{
+	struct pcf8574_data *data = i2c_get_clientdata(client);
+	data->write = PCF8574_INIT;
+	i2c_smbus_write_byte(client, data->write);
+}
+
+static struct pcf8574_data *pcf8574_update_client(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct pcf8574_data *data = i2c_get_clientdata(client);
+
+	down(&data->update_lock);
+	dev_dbg(&client->dev, "Starting pcf8574 update\n");
+	data->read = i2c_smbus_read_byte(client); 
+	up(&data->update_lock);
+	
+	return data;
+}
+
+static int __init pcf8574_init(void)
+{
+	return i2c_add_driver(&pcf8574_driver);
+}
+
+static void __exit pcf8574_exit(void)
+{
+	i2c_del_driver(&pcf8574_driver);
+}
+
+
+MODULE_AUTHOR
+    ("Frodo Looijaard <frodol@dds.nl>, "
+     "Philip Edelbrock <phil@netroedge.com>, "
+     "Dan Eaton <dan.eaton@rocketlogix.com> "
+     "and Aurelien Jarno <aurelien@aurel32.net>");
+MODULE_DESCRIPTION("PCF8574 driver");
+MODULE_LICENSE("GPL");
+
+module_init(pcf8574_init);
+module_exit(pcf8574_exit);
