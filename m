From: aurelien@aurel32.net (Aurelien Jarno)
Date: Thu, 19 May 2005 06:24:46 +0000
Subject: PCF8591 support for 2.6 kernel series
Message-Id: <20040306215325.GC14805@pc.aurel32.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Please find attached a preliminary patch to support the PCF8591 chip
to the 2.6 kernel series. 

This driver currently doesn't follow the sysfs-interface document, and I
may need some help to choose the filenames. For your information, the 
PCF8591 is an 8-bit A/D and D/A converter (4 analog input and one analog
ouput). I mapped the four analog inputs to in_input[0-3]. So there is
still three files that don't follow the sysfs-interface document:
- ain_conf
- aout
- aout_enable

Help would be greatly appreciated.

Aurelien


-- 
  .''`.  Aurelien Jarno	              GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineering Student 
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
-------------- next part --------------
diff -urN linux-2.6.3.orig/drivers/i2c/chips/Kconfig linux-2.6.3/drivers/i2c/chips/Kconfig
--- linux-2.6.3.orig/drivers/i2c/chips/Kconfig	2004-02-18 04:58:10.000000000 +0100
+++ linux-2.6.3/drivers/i2c/chips/Kconfig	2004-03-06 14:34:34.000000000 +0100
@@ -135,6 +135,16 @@
 	  This driver can also be built as a module.  If so, the module
 	  will be called lm90.
 
+config SENSORS_PCF8591
+	tristate "Philips PCF8591"
+	depends on I2C && EXPERIMENTAL
+	select I2C_SENSOR
+	help
+	  If you say yes here you get support for Philips PCF8591 chip.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called pcf8591.
+
 config SENSORS_VIA686A
 	tristate "VIA686A"
 	depends on I2C && EXPERIMENTAL
diff -urN linux-2.6.3.orig/drivers/i2c/chips/Makefile linux-2.6.3/drivers/i2c/chips/Makefile
--- linux-2.6.3.orig/drivers/i2c/chips/Makefile	2004-02-18 05:00:01.000000000 +0100
+++ linux-2.6.3/drivers/i2c/chips/Makefile	2004-03-06 14:34:34.000000000 +0100
@@ -16,5 +16,6 @@
 obj-$(CONFIG_SENSORS_LM83)	+= lm83.o
 obj-$(CONFIG_SENSORS_LM85)	+= lm85.o
 obj-$(CONFIG_SENSORS_LM90)	+= lm90.o
+obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
 obj-$(CONFIG_SENSORS_VIA686A)	+= via686a.o
 obj-$(CONFIG_SENSORS_W83L785TS)	+= w83l785ts.o
diff -urN linux-2.6.3.orig/drivers/i2c/chips/pcf8591.c linux-2.6.3/drivers/i2c/chips/pcf8591.c
--- linux-2.6.3.orig/drivers/i2c/chips/pcf8591.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.3/drivers/i2c/chips/pcf8591.c	2004-03-06 14:34:34.000000000 +0100
@@ -0,0 +1,411 @@
+/*
+    pcf8591.c - Part of lm_sensors, Linux kernel modules for hardware
+             monitoring
+    Copyright (c) 2001  Aurelien Jarno <aurelien@aurel32.net>
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
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/i2c-sensor.h>
+#include <linux/init.h>
+
+/* Addresses to scan */
+static unsigned short normal_i2c[] = { I2C_CLIENT_END };
+static unsigned short normal_i2c_range[] = { 0x48, 0x4f, I2C_CLIENT_END };
+static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
+static unsigned int normal_isa_range[] = { I2C_CLIENT_ISA_END };
+
+/* Insmod parameters */
+SENSORS_INSMOD_1(pcf8591);
+
+/* The PCF8591 control byte */
+/*    7    6    5    4    3    2    1    0   */
+/* |  0 |AOEF|   AIP   |  0 |AINC|  AICH   | */
+#define PCF8591_CONTROL_BYTE_MASK 	0x88
+#define PCF8591_CONTROL_BYTE_VAL 	0x00
+
+#define PCF8591_CONTROL_BYTE_AOEF 	0x40  	/* Analog Output Enable Flag */
+                                        	/* (analog output active if 1) */
+
+#define PCF8591_CONTROL_BYTE_AIP 	0x30   	/* Analog Input Programming */
+                                        	/* 0x00 = four single ended inputs */
+                                        	/* 0x10 = three differential inputs */
+                                        	/* 0x20 = single ended and differential mixed */
+                                        	/* 0x30 = two differential inputs */
+
+#define PCF8591_CONTROL_BYTE_AINC 	0x04  	/* Autoincrement Flag */
+                                        	/* (switch on if 1) */
+
+#define PCF8591_CONTROL_BYTE_AICH 	0x03  	/* Analog Output Enable Flag */
+                                        	/* 0x00 = channel 0 */
+                                        	/* 0x01 = channel 1 */
+                                        	/* 0x02 = channel 2 */
+                                        	/* 0x03 = channel 3 */
+
+
+/* Initial values */
+#define PCF8591_INIT_CONTROL_BYTE (PCF8591_CONTROL_BYTE_AINC)
+						/* Four single ended inputs, autoincrement */
+
+#define PCF8591_INIT_AOUT 		0	/* DAC out = 0 */
+
+
+/* Conversions. */
+#define REG_TO_SIGNED(reg) (reg & 0x80)?(reg - 256):(reg)
+						/* Convert signed 8 bit value to signed value */
+
+
+struct pcf8591_data {
+        struct semaphore lock;
+        enum chips type;
+
+        struct semaphore update_lock;
+        char valid;             /* !=0 if following fields are valid */
+        unsigned long last_updated;     /* In jiffies */
+
+        u8 control_byte;
+        u8 in0;
+        u8 in1;
+        u8 in2;
+        u8 in3;
+        u8 aout;
+};
+
+static int pcf8591_attach_adapter(struct i2c_adapter *adapter);
+static int pcf8591_detect(struct i2c_adapter *adapter, int address,
+                          int kind);
+static int pcf8591_detach_client(struct i2c_client *client);
+
+static void pcf8591_update_client(struct i2c_client *client);
+static void pcf8591_init_client(struct i2c_client *client);
+
+/* This is the driver that will be inserted */
+static struct i2c_driver pcf8591_driver = {
+	.owner		= THIS_MODULE,
+	.name		= "pcf8591",
+	.id		= I2C_DRIVERID_PCF8591,
+	.flags		= I2C_DF_NOTIFY,
+	.attach_adapter	= pcf8591_attach_adapter,
+	.detach_client	= pcf8591_detach_client,
+};
+
+static int pcf8591_id = 0;
+
+
+static ssize_t show_ain_conf(struct device *dev, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct pcf8591_data *data = i2c_get_clientdata(client);
+	return sprintf(buf, "%d\n", (data->control_byte & PCF8591_CONTROL_BYTE_AIP) >> 4);
+}
+
+static ssize_t set_ain_conf(struct device *dev, const char *buf,
+			    size_t count)
+{
+	u8 conf;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct pcf8591_data *data = i2c_get_clientdata(client);
+	conf = simple_strtoul(buf, NULL, 10);
+	if (conf <= 3) {
+		data->control_byte &= ~PCF8591_CONTROL_BYTE_AIP;
+		data->control_byte |= (conf << 4);
+		i2c_smbus_write_byte(client, data->control_byte);
+		data->valid = 0;
+	}
+	return count;
+}
+
+static ssize_t show_in_input0(struct device *dev, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct pcf8591_data *data = i2c_get_clientdata(client);
+	pcf8591_update_client(client);
+	if (((data->control_byte & PCF8591_CONTROL_BYTE_AIP) = 0x00)
+	   | ((data->control_byte & PCF8591_CONTROL_BYTE_AIP) = 0x20))
+		return sprintf(buf, "%d\n", data->in0); 
+	else
+		return sprintf(buf, "%d\n", REG_TO_SIGNED(data->in0)); 
+}
+
+static ssize_t show_in_input1(struct device *dev, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct pcf8591_data *data = i2c_get_clientdata(client);
+	pcf8591_update_client(client);
+	if (((data->control_byte & PCF8591_CONTROL_BYTE_AIP) = 0x00)
+	   | ((data->control_byte & PCF8591_CONTROL_BYTE_AIP) = 0x20))
+		return sprintf(buf, "%d\n", data->in1); 
+	else
+		return sprintf(buf, "%d\n", REG_TO_SIGNED(data->in1)); 
+}
+
+static ssize_t show_in_input2(struct device *dev, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct pcf8591_data *data = i2c_get_clientdata(client);
+	pcf8591_update_client(client);
+	if ((data->control_byte & PCF8591_CONTROL_BYTE_AIP) = 0x00)
+		return sprintf(buf, "%d\n", data->in2); 
+	else if ((data->control_byte & PCF8591_CONTROL_BYTE_AIP) != 0x30)
+		return sprintf(buf, "%d\n", REG_TO_SIGNED(data->in2)); 
+	else
+		return sprintf(buf, "0\n"); 
+}
+
+static ssize_t show_in_input3(struct device *dev, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct pcf8591_data *data = i2c_get_clientdata(client);
+	pcf8591_update_client(client);
+	if ((data->control_byte & PCF8591_CONTROL_BYTE_AIP) = 0x00)
+		return sprintf(buf, "%d\n", data->in3); 
+	else
+		return sprintf(buf, "0\n"); 
+}
+
+static ssize_t show_aout_enable(struct device *dev, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct pcf8591_data *data = i2c_get_clientdata(client);
+	return sprintf(buf, "%d\n", !(!(data->control_byte & PCF8591_CONTROL_BYTE_AOEF)));
+}
+
+static ssize_t set_aout_enable(struct device *dev, const char *buf,
+			       size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct pcf8591_data *data = i2c_get_clientdata(client);
+	if (simple_strtoul(buf, NULL, 10))
+		data->control_byte |= PCF8591_CONTROL_BYTE_AOEF;
+	else
+		data->control_byte &= ~PCF8591_CONTROL_BYTE_AOEF;
+	i2c_smbus_write_byte(client, data->control_byte);
+	return count;
+}
+
+static ssize_t show_aout(struct device *dev, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct pcf8591_data *data = i2c_get_clientdata(client);
+	return sprintf(buf, "%d\n", data->aout);
+}
+
+static ssize_t set_aout(struct device *dev, const char *buf,
+			 size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct pcf8591_data *data = i2c_get_clientdata(client);
+	data->aout = simple_strtoul(buf, NULL, 10);
+	i2c_smbus_write_byte_data(client, data->control_byte, data->aout);
+	return count;
+}
+
+static DEVICE_ATTR(ain_conf, S_IWUSR | S_IRUGO, show_ain_conf, set_ain_conf);
+static DEVICE_ATTR(aout_enable, S_IWUSR | S_IRUGO, show_aout_enable, set_aout_enable);
+static DEVICE_ATTR(aout, S_IWUSR | S_IRUGO, show_aout, set_aout);
+static DEVICE_ATTR(in_input0, S_IRUGO, show_in_input0, NULL);
+static DEVICE_ATTR(in_input1, S_IRUGO, show_in_input1, NULL);
+static DEVICE_ATTR(in_input2, S_IRUGO, show_in_input2, NULL);
+static DEVICE_ATTR(in_input3, S_IRUGO, show_in_input3, NULL);
+
+		
+/* This function is called when:
+     * pcf8591_driver is inserted (when this module is loaded), for each
+       available adapter
+     * when a new adapter is inserted (and pcf8591_driver is still present) */
+static int pcf8591_attach_adapter(struct i2c_adapter *adapter)
+{
+        return i2c_detect(adapter, &addr_data, pcf8591_detect);
+}
+
+/* This function is called by i2c_detect */
+int pcf8591_detect(struct i2c_adapter *adapter, int address,
+                   int kind)
+{
+        struct i2c_client *new_client;
+        struct pcf8591_data *data;
+        int err = 0;
+        const char *client_name = "";
+
+        /* Make sure we aren't probing the ISA bus!! This is just a safety check 
+	   at this moment; i2c_detect really won't call us. */
+        if (i2c_is_isa_adapter(adapter)) {
+                dev_dbg(&adapter->dev,
+                        "pcf8591.o: pcf8591_detect called for an ISA bus adapter?!?\n");
+                return 0;
+        }
+
+        if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
+                goto ERROR0;
+
+        /* OK. For now, we presume we have a valid client. We now create the
+           client structure, even though we cannot fill it completely yet. */
+        if (!(new_client = kmalloc(sizeof(struct i2c_client) +
+                                   sizeof(struct pcf8591_data),
+                                   GFP_KERNEL))) {
+                err = -ENOMEM;
+                goto ERROR1;
+        }
+
+        memset(new_client, 0, sizeof(struct i2c_client) +
+	       sizeof(struct pcf8591_data));
+	
+        data = (struct pcf8591_data *) (new_client + 1);
+	i2c_set_clientdata(new_client, data);
+        new_client->addr = address;
+        new_client->adapter = adapter;
+        new_client->driver = &pcf8591_driver;
+        new_client->flags = 0;
+
+	/* Now, we do the remaining detection. It is lousy. */
+	if (kind < 0) {
+		i2c_smbus_write_byte(new_client, PCF8591_CONTROL_BYTE_MASK);
+		if ((i2c_smbus_read_byte(new_client) & PCF8591_CONTROL_BYTE_MASK)
+		    != PCF8591_CONTROL_BYTE_VAL)
+			goto ERROR2;
+	}
+
+        /* Determine the chip type - only one kind supported! */
+        if (kind <= 0)
+                kind = pcf8591;
+
+        if (kind = pcf8591) {
+                client_name = "pcf8591";
+        } else {
+                dev_dbg(&adapter->dev, 
+			"pcf8591.o: Internal error: unknown kind (%d)?!?",
+                        kind);
+                goto ERROR2;
+        }
+
+        /* Fill in the remaining client fields and put it into the global list */
+        strlcpy(new_client->name, client_name, I2C_NAME_SIZE);
+
+        new_client->id = pcf8591_id++;
+        data->valid = 0;
+        init_MUTEX(&data->update_lock);
+
+        /* Tell the I2C layer a new client has arrived */
+        if ((err = i2c_attach_client(new_client)))
+                goto ERROR2;
+
+        /* Initialize the PCF8591 chip */
+        pcf8591_init_client(new_client);
+
+	/* Register sysfs hooks */
+	device_create_file(&new_client->dev, &dev_attr_ain_conf);
+	device_create_file(&new_client->dev, &dev_attr_aout);
+	device_create_file(&new_client->dev, &dev_attr_aout_enable);
+	device_create_file(&new_client->dev, &dev_attr_in_input0);
+	device_create_file(&new_client->dev, &dev_attr_in_input1);
+	device_create_file(&new_client->dev, &dev_attr_in_input2);
+	device_create_file(&new_client->dev, &dev_attr_in_input3);
+	
+//evice_create_file(&new_client->dev, &dev_attr_read);
+        return 0;
+	
+/* OK, this is not exactly good programming practice, usually. But it is
+   very code-efficient in this case. */
+
+      ERROR2:
+        kfree(new_client);
+      ERROR1:
+      ERROR0:
+        return err;
+}
+
+static int pcf8591_detach_client(struct i2c_client *client)
+{
+        int err;
+
+        if ((err = i2c_detach_client(client))) {
+                dev_err(&client->dev,
+                        "pcf8591.o: Client deregistration failed, client not detached.\n");
+                return err;
+        }
+
+        kfree(client);
+        return 0;
+}
+
+/* Called when we have found a new PCF8591. */
+static void pcf8591_init_client(struct i2c_client *client)
+{
+        struct pcf8591_data *data = i2c_get_clientdata(client);
+        data->control_byte = PCF8591_INIT_CONTROL_BYTE;
+        data->aout = PCF8591_INIT_AOUT;
+
+        i2c_smbus_write_byte_data(client, data->control_byte, data->aout);
+}
+
+static void pcf8591_update_client(struct i2c_client *client)
+{
+        struct pcf8591_data *data = i2c_get_clientdata(client);
+
+        down(&data->update_lock);
+
+        if ((jiffies - data->last_updated > HZ + HZ / 2) ||
+            (jiffies < data->last_updated) || !data->valid) {
+
+                dev_dbg(&client->dev, "Starting pcf8591 update\n");
+
+                i2c_smbus_write_byte(client, data->control_byte);
+                i2c_smbus_read_byte(client);    /* The first byte transmitted contains the */
+                                                /* conversion code of the previous read cycled */
+                                                /* FLUSH IT ! */
+
+
+                /* Number of byte to read to signed depend on the analog input mode */
+		
+                /* In all case, read at least two values */
+                data->in0 = i2c_smbus_read_byte(client);
+                data->in1 = i2c_smbus_read_byte(client);
+
+		/* Read the third value if not in "two differential inputs" mode */
+                if ((data->control_byte & PCF8591_CONTROL_BYTE_AIP) != 0x30)
+                        data->in2 = i2c_smbus_read_byte(client);
+		
+		/* Read the fourth value only in "four single ended inputs" mode */
+		if ((data->control_byte & PCF8591_CONTROL_BYTE_AIP) = 0x00)
+                        data->in3 = i2c_smbus_read_byte(client);
+
+                data->last_updated = jiffies;
+                data->valid = 1;
+        }
+
+        up(&data->update_lock);
+}
+
+
+
+static int __init sm_pcf8591_init(void)
+{
+	return i2c_add_driver(&pcf8591_driver);
+}
+
+static void __exit sm_pcf8591_exit(void)
+{
+        i2c_del_driver(&pcf8591_driver);
+}
+
+MODULE_AUTHOR("Aurelien Jarno <aurelien@aurel32.net>");
+MODULE_DESCRIPTION("PCF8591 driver");
+MODULE_LICENSE("GPL");
+
+module_init(sm_pcf8591_init);
+module_exit(sm_pcf8591_exit);
