From: aurelien@aurel32.net (Aurelien Jarno)
Date: Thu, 19 May 2005 06:24:46 +0000
Subject: PCF8574 support for 2.6 kernel series
Message-Id: <20040306214331.GB14805@pc.aurel32.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Please find attached a patch to support the PCF8574 chip to the 2.6
kernel series. 

This driver doesn't follow the sysfs-interface document as it creates
only two files: "read" and "write". However, as the aim of this driver
is to be used directly from the /sys interface and not through the
libsensors interface, I think it is not really a problem.

Aurelien


-- 
  .''`.  Aurelien Jarno	              GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineering Student 
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
-------------- next part --------------
diff -urN linux-2.6.3.orig/drivers/i2c/chips/Kconfig linux-2.6.3/drivers/i2c/chips/Kconfig
--- linux-2.6.3.orig/drivers/i2c/chips/Kconfig	2004-02-18 04:58:10.000000000 +0100
+++ linux-2.6.3/drivers/i2c/chips/Kconfig	2004-03-06 14:20:09.000000000 +0100
@@ -135,6 +135,17 @@
 	  This driver can also be built as a module.  If so, the module
 	  will be called lm90.
 
+config SENSORS_PCF8574
+	tristate "Philips PCF8574 and PCF8574A"
+	depends on I2C && EXPERIMENTAL
+	select I2C_SENSOR
+	help
+	  If you say yes here you get support for Philips PCF8574 and 
+	  PCF8574A chips.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called pcf8574.
+
 config SENSORS_VIA686A
 	tristate "VIA686A"
 	depends on I2C && EXPERIMENTAL
diff -urN linux-2.6.3.orig/drivers/i2c/chips/Makefile linux-2.6.3/drivers/i2c/chips/Makefile
--- linux-2.6.3.orig/drivers/i2c/chips/Makefile	2004-02-18 05:00:01.000000000 +0100
+++ linux-2.6.3/drivers/i2c/chips/Makefile	2004-03-06 14:20:09.000000000 +0100
@@ -16,5 +16,6 @@
 obj-$(CONFIG_SENSORS_LM83)	+= lm83.o
 obj-$(CONFIG_SENSORS_LM85)	+= lm85.o
 obj-$(CONFIG_SENSORS_LM90)	+= lm90.o
+obj-$(CONFIG_SENSORS_PCF8574)	+= pcf8574.o
 obj-$(CONFIG_SENSORS_VIA686A)	+= via686a.o
 obj-$(CONFIG_SENSORS_W83L785TS)	+= w83l785ts.o
diff -urN linux-2.6.3.orig/drivers/i2c/chips/pcf8574.c linux-2.6.3/drivers/i2c/chips/pcf8574.c
--- linux-2.6.3.orig/drivers/i2c/chips/pcf8574.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.3/drivers/i2c/chips/pcf8574.c	2004-03-06 14:20:09.000000000 +0100
@@ -0,0 +1,283 @@
+/*
+    pcf8574.c - Part of lm_sensors, Linux kernel modules for hardware
+             monitoring
+    Copyright (c) 2000  Frodo Looijaard <frodol@dds.nl>, 
+                        Philip Edelbrock <phil@netroedge.com>,
+                        Dan Eaton <dan.eaton@rocketlogix.com>
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
+* Because of the general purpose nature of this device, it will most
+  likely be necessary to customize the /proc interface to suit the
+  specific application.
+
+  --Dan
+
+*/
+
+
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/i2c-sensor.h>
+#include <linux/init.h>
+
+MODULE_LICENSE("GPL");
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
+/* The PCF8574 registers */
+
+/* (No registers.  [Wow! This thing is SIMPLE!] ) */
+
+/* Initial values */
+#define PCF8574_INIT 255	/* All outputs on (input mode) */
+
+/* Each client has this additional data */
+struct pcf8574_data {
+	struct semaphore update_lock;
+	char valid;		/* !=0 if following fields are valid */
+	unsigned long last_updated;	/* In jiffies */
+
+	u8 read, write;	        /* Register values */
+};
+
+static int pcf8574_attach_adapter(struct i2c_adapter *adapter);
+static int pcf8574_detect(struct i2c_adapter *adapter, int address,
+			  int kind);
+static int pcf8574_detach_client(struct i2c_client *client);
+static void pcf8574_init_client(struct i2c_client *client);
+static void pcf8574_update_client(struct i2c_client *client);
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
+/* I choose here for semi-static PCF8574 allocation. Complete dynamic
+   allocation could also be used; the code needed for this would probably
+   take more memory than the datastructure takes now. */
+static int pcf8574_id = 0;
+
+
+static ssize_t show_read(struct device *dev, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct pcf8574_data *data = i2c_get_clientdata(client);
+	pcf8574_update_client(client);
+	return sprintf(buf, "%d\n", data->read);
+}
+
+static DEVICE_ATTR(read, S_IRUGO, show_read, NULL);
+
+static ssize_t show_write(struct device *dev, char *buf)
+{
+        struct i2c_client *client = to_i2c_client(dev);
+        struct pcf8574_data *data = i2c_get_clientdata(client);
+        return sprintf(buf, "%d\n", data->write);
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
+static int pcf8574_attach_adapter(struct i2c_adapter *adapter)
+{
+	return i2c_detect(adapter, &addr_data, pcf8574_detect);
+}
+
+/* This function is called by i2c_detect */
+int pcf8574_detect(struct i2c_adapter *adapter, int address,
+		   int kind)
+{
+	struct i2c_client *new_client;
+	struct pcf8574_data *data;
+	int err = 0;
+	const char *client_name = "";
+
+	/* Make sure we aren't probing the ISA bus!! This is just a safety check
+	   at this moment; i2c_detect really won't call us. */
+	if (i2c_is_isa_adapter(adapter)) {
+		dev_dbg(&adapter->dev,
+			"pcf8574.o: pcf8574_detect called for an ISA bus adapter?!?\n");
+		return 0;
+	}
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
+		goto ERROR0;
+
+	/* OK. For now, we presume we have a valid client. We now create the
+	   client structure, even though we cannot fill it completely yet.
+	   But it allows us to access pcf8574_{read,write}_value. */
+	if (!(new_client = kmalloc(sizeof(struct i2c_client) +
+				   sizeof(struct pcf8574_data),
+				   GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto ERROR1;
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
+		if (address >= 0x20 && address <= 0x27)
+			kind = pcf8574;
+		else if (address >= 0x38 && address <= 0x3f)
+			kind = pcf8574a;
+		else goto ERROR2;
+	}
+
+	if (kind = pcf8574) {
+		client_name = "pcf8574";
+	} else
+	if (kind = pcf8574a) {
+		client_name = "pcf8574a";
+	} else {
+		dev_dbg(&adapter->dev,
+			"pcf8574.o: Internal error: unknown kind (%d)?!?",
+		       kind);
+		goto ERROR2;
+	}
+
+	/* Fill in the remaining client fields and put it into the global list */
+	strlcpy(new_client->name, client_name, I2C_NAME_SIZE);
+
+	new_client->id = pcf8574_id++;
+	data->valid = 0;
+	init_MUTEX(&data->update_lock);
+
+	/* Tell the I2C layer a new client has arrived */
+	if ((err = i2c_attach_client(new_client)))
+		goto ERROR2;
+
+        /* Initialize the PCF8574 chip */
+        pcf8574_init_client(new_client);
+
+	/* Register sysfs hooks */
+	device_create_file(&new_client->dev, &dev_attr_read);
+	device_create_file(&new_client->dev, &dev_attr_write);
+	return 0;
+
+/* OK, this is not exactly good programming practice, usually. But it is
+   very code-efficient in this case. */
+
+      ERROR2:
+	kfree(new_client);
+      ERROR1:
+      ERROR0:
+	return err;
+}
+
+
+static int pcf8574_detach_client(struct i2c_client *client)
+{
+	int err;
+
+	if ((err = i2c_detach_client(client))) {
+		dev_err(&client->dev,
+		        "pcf8574.o: Client deregistration failed, client not detached.\n");
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
+        struct pcf8574_data *data = i2c_get_clientdata(client);
+        data->write = PCF8574_INIT;
+	i2c_smbus_write_byte(client, data->write);
+}
+
+static void pcf8574_update_client(struct i2c_client *client)
+{
+	struct pcf8574_data *data = i2c_get_clientdata(client);
+
+	down(&data->update_lock);
+
+	if ((jiffies - data->last_updated > 5*HZ) ||
+	    (jiffies < data->last_updated) || !data->valid) {
+
+		dev_dbg(&client->dev, "Starting pcf8574 update\n");
+		data->read = i2c_smbus_read_byte(client); 
+		data->last_updated = jiffies;
+		data->valid = 1;
+	}
+
+	up(&data->update_lock);
+}
+
+
+static int __init sm_pcf8574_init(void)
+{
+	return i2c_add_driver(&pcf8574_driver);
+}
+
+static void __exit sm_pcf8574_exit(void)
+{
+	i2c_del_driver(&pcf8574_driver);
+}
+
+
+
+MODULE_AUTHOR
+    ("Frodo Looijaard <frodol@dds.nl>, Philip Edelbrock <phil@netroedge.com>, Dan Eaton <dan.eaton@rocketlogix.com> and Aurelien Jarno <aurelien@aurel32.net>");
+MODULE_DESCRIPTION("PCF8574 driver");
+
+module_init(sm_pcf8574_init);
+module_exit(sm_pcf8574_exit);
