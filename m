From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:21 +0000
Subject: More on SMBus multiplexing
Message-Id: <20041108225005.627ecdc0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041023200215.38e375a1.khali@linux-fr.org>
In-Reply-To: <20041023200215.38e375a1.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting myself:

> On second thought, don't. As I said on LKML this morning, my autoload
> code doesn't work and we will have to stick to manual loading for now.
> I'll provide a simplified patch that does this tomorrow.

We are not exactly tomorrow but here is the modified patch. Please note
that this is only safe tp apply *after* my other patch that adds extra
checks to i2c_del_adapter.

Please apply,
Thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

diff -ruN drivers/i2c/busses.orig/Kconfig drivers/i2c/busses/Kconfig
--- drivers/i2c/busses.orig/Kconfig	2004-10-26 20:51:51.000000000 +0200
+++ drivers/i2c/busses/Kconfig	2004-11-04 20:47:38.000000000 +0100
@@ -51,6 +51,19 @@
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-amd756.
 
+config I2C_AMD756_S4882
+	tristate "SMBus multiplexing on the Tyan S4882"
+	depends on I2C_AMD756 && EXPERIMENTAL
+	help
+	  Enabling this option will add specific SMBus support for the Tyan
+	  S4882 motherboard.  On this 4-CPU board, the SMBus is multiplexed
+	  over 8 different channels, where the various memory module EEPROMs
+	  and temperature sensors live.  Saying yes here will give you access
+	  to these in addition to the trunk.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-amd756-s4882.
+
 config I2C_AMD8111
 	tristate "AMD 8111"
 	depends on I2C && PCI && EXPERIMENTAL
diff -ruN drivers/i2c/busses.orig/Makefile drivers/i2c/busses/Makefile
--- drivers/i2c/busses.orig/Makefile	2004-10-26 20:48:19.000000000 +0200
+++ drivers/i2c/busses/Makefile	2004-11-04 19:57:31.000000000 +0100
@@ -6,6 +6,7 @@
 obj-$(CONFIG_I2C_ALI1563)	+= i2c-ali1563.o
 obj-$(CONFIG_I2C_ALI15X3)	+= i2c-ali15x3.o
 obj-$(CONFIG_I2C_AMD756)	+= i2c-amd756.o
+obj-$(CONFIG_I2C_AMD756_S4882)	+= i2c-amd756-s4882.o
 obj-$(CONFIG_I2C_AMD8111)	+= i2c-amd8111.o
 obj-$(CONFIG_I2C_ELEKTOR)	+= i2c-elektor.o
 obj-$(CONFIG_I2C_HYDRA)		+= i2c-hydra.o
diff -ruN drivers/i2c/busses.orig/i2c-amd756-s4882.c drivers/i2c/busses/i2c-amd756-s4882.c
--- drivers/i2c/busses.orig/i2c-amd756-s4882.c	1970-01-01 01:00:00.000000000 +0100
+++ drivers/i2c/busses/i2c-amd756-s4882.c	2004-11-06 20:42:55.000000000 +0100
@@ -0,0 +1,261 @@
+/*
+ * i2c-amd756-s4882.c - i2c-amd756 extras for the Tyan S4882 motherboard
+ *
+ * Copyright (C) 2004 Jean Delvare <khali@linux-fr.org>
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
+/*
+ * We select the channels by sending commands to the Philips
+ * PCA9556 chip at I2C address 0x18. The main adapter is used for
+ * the non-multiplexed part of the bus, and 4 virtual adapters
+ * are defined for the multiplexed addresses: 0x50-0x53 (memory
+ * module EEPROM) located on channels 1-4, and 0x4c (LM63)
+ * located on multiplexed channels 0 and 5-7. We define one
+ * virtual adapter per CPU, which corresponds to two multiplexed
+ * channels:
+ *   CPU0: virtual adapter 1, channels 1 and 0
+ *   CPU1: virtual adapter 2, channels 2 and 5
+ *   CPU2: virtual adapter 3, channels 3 and 6
+ *   CPU3: virtual adapter 4, channels 4 and 7
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+
+extern struct i2c_adapter amd756_smbus;
+
+static struct i2c_adapter *s4882_adapter;
+static struct i2c_algorithm *s4882_algo;
+
+/* Wrapper access functions for multiplexed SMBus */
+static struct semaphore amd756_lock;
+
+static s32 amd756_access_virt0(struct i2c_adapter * adap, u16 addr,
+			       unsigned short flags, char read_write,
+			       u8 command, int size,
+			       union i2c_smbus_data * data)
+{
+	int error;
+
+	/* We exclude the multiplexed addresses */
+	if (addr = 0x4c || (addr & 0xfc) = 0x50 || (addr & 0xfc) = 0x30
+	 || addr = 0x18)
+		return -1;
+
+	down(&amd756_lock);
+
+	error = amd756_smbus.algo->smbus_xfer(adap, addr, flags, read_write,
+					      command, size, data);
+
+	up(&amd756_lock);
+
+	return error;
+}
+
+/* We remember the last used channels combination so as to only switch
+   channels when it is really needed. This greatly reduces the SMBus
+   overhead, but also assumes that nobody will be writing to the PCA9556
+   in our back. */
+static u8 last_channels;
+
+static inline s32 amd756_access_channel(struct i2c_adapter * adap, u16 addr,
+					unsigned short flags, char read_write,
+					u8 command, int size,
+					union i2c_smbus_data * data,
+					u8 channels)
+{
+	int error;
+
+	/* We exclude the non-multiplexed addresses */
+	if (addr != 0x4c && (addr & 0xfc) != 0x50 && (addr & 0xfc) != 0x30)
+		return -1;
+
+	down(&amd756_lock);
+
+	if (last_channels != channels) {
+		union i2c_smbus_data mplxdata;
+		mplxdata.byte = channels;
+
+		error = amd756_smbus.algo->smbus_xfer(adap, 0x18, 0,
+						      I2C_SMBUS_WRITE, 0x01,
+						      I2C_SMBUS_BYTE_DATA,
+						      &mplxdata);
+		if (error)
+			goto UNLOCK;
+		last_channels = channels;
+	}
+	error = amd756_smbus.algo->smbus_xfer(adap, addr, flags, read_write,
+					      command, size, data);
+
+UNLOCK:
+	up(&amd756_lock);
+	return error;
+}
+
+static s32 amd756_access_virt1(struct i2c_adapter * adap, u16 addr,
+			       unsigned short flags, char read_write,
+			       u8 command, int size,
+			       union i2c_smbus_data * data)
+{
+	/* CPU0: channels 1 and 0 enabled */
+	return amd756_access_channel(adap, addr, flags, read_write, command,
+				     size, data, 0x03);
+}
+
+static s32 amd756_access_virt2(struct i2c_adapter * adap, u16 addr,
+			       unsigned short flags, char read_write,
+			       u8 command, int size,
+			       union i2c_smbus_data * data)
+{
+	/* CPU1: channels 2 and 5 enabled */
+	return amd756_access_channel(adap, addr, flags, read_write, command,
+				     size, data, 0x24);
+}
+
+static s32 amd756_access_virt3(struct i2c_adapter * adap, u16 addr,
+			       unsigned short flags, char read_write,
+			       u8 command, int size,
+			       union i2c_smbus_data * data)
+{
+	/* CPU2: channels 3 and 6 enabled */
+	return amd756_access_channel(adap, addr, flags, read_write, command,
+				     size, data, 0x48);
+}
+
+static s32 amd756_access_virt4(struct i2c_adapter * adap, u16 addr,
+			       unsigned short flags, char read_write,
+			       u8 command, int size,
+			       union i2c_smbus_data * data)
+{
+	/* CPU3: channels 4 and 7 enabled */
+	return amd756_access_channel(adap, addr, flags, read_write, command,
+				     size, data, 0x90);
+}
+
+static int __init amd756_s4882_init(void)
+{
+	int i, error;
+	union i2c_smbus_data ioconfig;
+
+	/* Unregister physical bus */
+	error = i2c_del_adapter(&amd756_smbus);
+	if (error) {
+		if (error != -EINVAL)
+			dev_err(&amd756_smbus.dev, "Physical bus removal "
+				"failed\n");
+		goto ERROR0;
+	}
+
+	printk(KERN_INFO "Enabling SMBus multiplexing for Tyan S4882\n");
+	init_MUTEX(&amd756_lock);
+
+	/* Define the 5 virtual adapters and algorithms structures */
+	if (!(s4882_adapter = kmalloc(5 * sizeof(struct i2c_adapter),
+				      GFP_KERNEL))) {
+		error = -ENOMEM;
+		goto ERROR1;
+	}
+	if (!(s4882_algo = kmalloc(5 * sizeof(struct i2c_algorithm),
+				   GFP_KERNEL))) {
+		error = -ENOMEM;
+		goto ERROR2;
+	}
+
+	/* Fill in the new structures */
+	s4882_algo[0] = *(amd756_smbus.algo);
+	s4882_algo[0].smbus_xfer = amd756_access_virt0;
+	s4882_adapter[0] = amd756_smbus;
+	s4882_adapter[0].algo = s4882_algo;
+	for (i = 1; i < 5; i++) {
+		s4882_algo[i] = *(amd756_smbus.algo);
+		s4882_adapter[i] = amd756_smbus;
+		sprintf(s4882_adapter[i].name,
+			"SMBus 8111 adapter (CPU%d)", i-1);
+		s4882_adapter[i].algo = s4882_algo+i;
+	}
+	s4882_algo[1].smbus_xfer = amd756_access_virt1;
+	s4882_algo[2].smbus_xfer = amd756_access_virt2;
+	s4882_algo[3].smbus_xfer = amd756_access_virt3;
+	s4882_algo[4].smbus_xfer = amd756_access_virt4;
+
+	/* Configure the PCA9556 multiplexer */
+	ioconfig.byte = 0x00; /* All I/O to output mode */
+	error = amd756_smbus.algo->smbus_xfer(&amd756_smbus, 0x18, 0,
+					      I2C_SMBUS_WRITE, 0x03,
+					      I2C_SMBUS_BYTE_DATA, &ioconfig);
+	if (error) {
+		dev_dbg(&amd756_smbus.dev, "PCA9556 configuration failed\n");
+		error = -EIO;
+		goto ERROR3;
+	}
+
+	/* Register virtual adapters */
+	for (i = 0; i < 5; i++) {
+		error = i2c_add_adapter(s4882_adapter+i);
+		if (error) {
+			dev_err(&amd756_smbus.dev,
+			       "Virtual adapter %d registration "
+			       "failed, module not inserted\n", i);
+			for (i--; i >= 0; i--)
+				i2c_del_adapter(s4882_adapter+i);
+			goto ERROR3;
+		}
+	}
+
+	return 0;
+
+ERROR3:
+	kfree(s4882_algo);
+	s4882_algo = NULL;
+ERROR2:
+	kfree(s4882_adapter);
+	s4882_adapter = NULL;
+ERROR1:
+	i2c_del_adapter(&amd756_smbus);
+ERROR0:
+	return error;
+}
+
+static void __exit amd756_s4882_exit(void)
+{
+	if (s4882_adapter) {
+		int i;
+
+		for (i = 0; i < 5; i++)
+			i2c_del_adapter(s4882_adapter+i);
+		kfree(s4882_adapter);
+		s4882_adapter = NULL;
+	}
+	if (s4882_algo) {
+		kfree(s4882_algo);
+		s4882_algo = NULL;
+	}
+
+	/* Restore physical bus */
+	if (i2c_add_adapter(&amd756_smbus))
+		dev_err(&amd756_smbus.dev, "Physical bus restoration "
+			"failed\n");
+}
+
+MODULE_AUTHOR("Jean Delvare <khali@linux-fr.org>");
+MODULE_DESCRIPTION("S4882 SMBus multiplexing");
+MODULE_LICENSE("GPL");
+
+module_init(amd756_s4882_init);
+module_exit(amd756_s4882_exit);
diff -ruN drivers/i2c/busses.orig/i2c-amd756.c drivers/i2c/busses/i2c-amd756.c
--- drivers/i2c/busses.orig/i2c-amd756.c	2004-10-26 20:48:19.000000000 +0200
+++ drivers/i2c/busses/i2c-amd756.c	2004-11-04 19:58:25.000000000 +0100
@@ -302,7 +302,7 @@
 	.functionality	= amd756_func,
 };
 
-static struct i2c_adapter amd756_adapter = {
+struct i2c_adapter amd756_smbus = {
 	.owner		= THIS_MODULE,
 	.class          = I2C_CLASS_HWMON,
 	.algo		= &smbus_algorithm,
@@ -374,12 +374,12 @@
 	dev_dbg(&pdev->dev, "AMD756_smba = 0x%X\n", amd756_ioport);
 
 	/* set up the driverfs linkage to our parent device */
-	amd756_adapter.dev.parent = &pdev->dev;
+	amd756_smbus.dev.parent = &pdev->dev;
 
-	sprintf(amd756_adapter.name, "SMBus %s adapter at %04x",
+	sprintf(amd756_smbus.name, "SMBus %s adapter at %04x",
 		chipname[id->driver_data], amd756_ioport);
 
-	error = i2c_add_adapter(&amd756_adapter);
+	error = i2c_add_adapter(&amd756_smbus);
 	if (error) {
 		dev_err(&pdev->dev,
 			"Adapter registration failed, module not inserted\n");
@@ -395,7 +395,7 @@
 
 static void __devexit amd756_remove(struct pci_dev *dev)
 {
-	i2c_del_adapter(&amd756_adapter);
+	i2c_del_adapter(&amd756_smbus);
 	release_region(amd756_ioport, SMB_IOSIZE);
 }
 
@@ -420,5 +420,7 @@
 MODULE_DESCRIPTION("AMD756/766/768/8111 and nVidia nForce SMBus driver");
 MODULE_LICENSE("GPL");
 
+EXPORT_SYMBOL(amd756_smbus);
+
 module_init(amd756_init)
 module_exit(amd756_exit)


-- 
Jean Delvare
http://khali.linux-fr.org/
