From: vojtech@suse.cz (Vojtech Pavlik)
Date: Thu, 19 May 2005 06:23:41 +0000
Subject: Support of AMD-8111 for lm_sensors
Message-Id: <20021107182005.A830@ucw.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi!

The AMD-8111 IO-Hub (which you likely haven't seen yet, but definitely
will at some point in time), has two SMBus interfaces, one SMBus 1.0
interface, same as in other AMD chipsets (AMD-756, etc), and one SMBus
2.0 interface modelled after the ACPI 2.0 SMBus interface specification.

The attached patches add support for both the interfaces, one by
modifying the i2c-amd756 driver, and the second by creating a new
i2c-amd8111 driver.

I tried to write the new driver as cleanly as possible, so I hope you'll
be able to include the patches into the next lm_sensors release without
any major problems.

Thanks,
-- 
Vojtech Pavlik
SuSE Labs
-------------- next part --------------
diff -urN i2c-2.6.5/kernel/i2c-id.h i2c-2.6.5-8111/kernel/i2c-id.h
--- i2c-2.6.5/kernel/i2c-id.h	2002-08-24 22:19:39.000000000 +0200
+++ i2c-2.6.5-8111/kernel/i2c-id.h	2002-11-07 16:13:59.000000000 +0100
@@ -232,6 +232,7 @@
 #define I2C_HW_SMBUS_ALI1535	0x07
 #define I2C_HW_SMBUS_SIS630	0x08
 #define I2C_HW_SMBUS_SIS645	0x09
+#define I2C_HW_SMBUS_AMD8111	0x0a
 
 /* --- ISA pseudo-adapter						*/
 #define I2C_HW_ISA 0x00
-------------- next part --------------
diff -urN lm_sensors-2.6.5/CONTRIBUTORS lm_sensors-2.6.5-8111/CONTRIBUTORS
--- lm_sensors-2.6.5/CONTRIBUTORS	2002-09-15 22:35:44.000000000 +0200
+++ lm_sensors-2.6.5-8111/CONTRIBUTORS	2002-11-07 15:53:45.000000000 +0100
@@ -76,4 +76,7 @@
   Added Asus ASB100 Bach support to the w83781d driver.
 * Alexander Malysh <amalysh@web.de>
   Author of the i2c-sis630 bus driver.
+* Vojtech Pavlik <vojtech@suse.cz>	
+  Author of the i2c-amd8111 bus driver.
+  Added support for amd8111 SMBus 1.0 controller to i2c-amd756.
 
diff -urN lm_sensors-2.6.5/README lm_sensors-2.6.5-8111/README
--- lm_sensors-2.6.5/README	2002-09-13 03:20:32.000000000 +0200
+++ lm_sensors-2.6.5-8111/README	2002-11-07 15:58:37.000000000 +0100
@@ -40,7 +40,8 @@
 
 At least the following I2C/SMBus adapters are supported:
   Acer Labs M1533, M1535, and M1543C
-  AMD 756, 766, and 768
+  AMD 756, 766, 768 and 8111
+  AMD 8111 SMBus 2.0
   Apple Hydra (used on some PPC machines)
   DEC 21272/21274 (Tsunami/Typhoon - on Alpha boards)
   Intel I801 ICH/ICH0/ICH2/ICH3 (used in Intel 810, 810E, 815E, 820, 840 chipsets)
diff -urN lm_sensors-2.6.5/doc/busses/i2c-amd756 lm_sensors-2.6.5-8111/doc/busses/i2c-amd756
--- lm_sensors-2.6.5/doc/busses/i2c-amd756	2002-05-02 01:33:53.000000000 +0200
+++ lm_sensors-2.6.5-8111/doc/busses/i2c-amd756	2002-11-07 17:44:33.000000000 +0100
@@ -6,6 +6,7 @@
   * AMD 756
   * AMD 766
   * AMD 768
+  * AMD 8111
     Datasheets: Publicly available on AMD website
 
   * nVidia nForce
@@ -21,4 +22,4 @@
 Description
 -----------
 
-This driver supports the AMD 756, 766, and 768 Peripheral Bus Controllers.
+This driver supports the AMD 756, 766, 768 and 8111 Peripheral Bus Controllers.
diff -urN lm_sensors-2.6.5/doc/busses/i2c-amd8111 lm_sensors-2.6.5-8111/doc/busses/i2c-amd8111
--- lm_sensors-2.6.5/doc/busses/i2c-amd8111	1970-01-01 01:00:00.000000000 +0100
+++ lm_sensors-2.6.5-8111/doc/busses/i2c-amd8111	2002-11-07 15:52:28.000000000 +0100
@@ -0,0 +1,39 @@
+Kernel driver `i2c-adm8111.o'
+
+Status: Untested.
+
+Supported adapters:
+    * AMD-8111 SMBus 2.0 PCI interface
+    * Possibly any other interface that implements the ACPI 2.0 EC interface
+    Datasheets: Publicly available at AMD and ACPI websites
+
+Author: Vojtech Pavlik <vojtech@suse.cz>
+
+
+Module Parameters
+-----------------
+
+None.
+
+Description
+-----------
+
+If you see something like this:
+
+00:07.2 SMBus: Advanced Micro Devices [AMD] AMD-8111 SMBus 2.0 (rev 02)
+        Subsystem: Advanced Micro Devices [AMD] AMD-8111 SMBus 2.0
+        Flags: medium devsel, IRQ 19
+        I/O ports at d400 [size2]
+
+in your 'lspci -v', then this driver is for your chipset.
+
+Process Call Support
+--------------------
+
+The chip supports it, but it's not implemented in the driver at the moment.
+
+SMBus 2.0 Support
+-----------------
+
+The chip supports SMBus 2.0, however the only extension the driver
+supports is PEC. Slave mode or host notification are not implemented.
diff -urN lm_sensors-2.6.5/kernel/busses/Module.mk lm_sensors-2.6.5-8111/kernel/busses/Module.mk
--- lm_sensors-2.6.5/kernel/busses/Module.mk	2002-09-01 22:19:27.000000000 +0200
+++ lm_sensors-2.6.5-8111/kernel/busses/Module.mk	2002-11-07 15:46:05.000000000 +0100
@@ -38,6 +38,9 @@
 ifneq ($(shell if grep -q '^CONFIG_I2C_AMD756=y' $(LINUX)/.config; then echo 1; fi),1)
 KERNELBUSSESTARGETS += $(MODULE_DIR)/i2c-amd756.o
 endif
+ifneq ($(shell if grep -q '^CONFIG_I2C_AMD8111=y' $(LINUX)/.config; then echo 1; fi),1)
+KERNELBUSSESTARGETS += $(MODULE_DIR)/i2c-amd8111.o
+endif
 ifneq ($(shell if grep -q '^CONFIG_I2C_HYDRA=y' $(LINUX)/.config; then echo 1; fi),1)
 KERNELBUSSESTARGETS += $(MODULE_DIR)/i2c-hydra.o
 endif
diff -urN lm_sensors-2.6.5/kernel/busses/i2c-amd756.c lm_sensors-2.6.5-8111/kernel/busses/i2c-amd756.c
--- lm_sensors-2.6.5/kernel/busses/i2c-amd756.c	2002-06-08 21:49:06.000000000 +0200
+++ lm_sensors-2.6.5-8111/kernel/busses/i2c-amd756.c	2002-11-07 15:59:29.000000000 +0100
@@ -51,6 +51,12 @@
 #ifndef PCI_DEVICE_ID_AMD_766
 #define PCI_DEVICE_ID_AMD_766 0x7413
 #endif
+#ifndef PCI_DEVICE_ID_AMD_768_SMBUS
+#define PCI_DEVICE_ID_AMD_768_SMBUS 0x7443
+#endif
+#ifndef PCI_DEVICE_ID_AMD_8111_SMBUS
+#define PCI_DEVICE_ID_AMD_8111_SMBUS 0x746B
+#endif
 #ifndef PCI_DEVICE_ID_NVIDIA_NFORCE_SMBUS
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_SMBUS 0x01B4
 #endif
@@ -66,8 +72,9 @@
 static struct sd supported[] = {
     {PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_756, 3, "AMD756", 1},
     {PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_766, 3, "AMD766", 1},
-    {PCI_VENDOR_ID_AMD, 0x7443, 3, "AMD768", 1},
-    {PCI_VENDOR_ID_NVIDIA, 0x01B4, 1, "nVidia nForce", 0},
+    {PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_768_SMBUS, 3, "AMD768", 1},
+    {PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8111_SMBUS, 3, "AMD8111", 1},
+    {PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_SMBUS, 1, "nVidia nForce", 0},
     {0, 0, 0}
 };
 
diff -urN lm_sensors-2.6.5/kernel/busses/i2c-amd8111.c lm_sensors-2.6.5-8111/kernel/busses/i2c-amd8111.c
--- lm_sensors-2.6.5/kernel/busses/i2c-amd8111.c	1970-01-01 01:00:00.000000000 +0100
+++ lm_sensors-2.6.5-8111/kernel/busses/i2c-amd8111.c	2002-11-07 17:49:23.000000000 +0100
@@ -0,0 +1,383 @@
+/*
+ * SMBus 2.0 driver for AMD-8111 IO-Hub.
+ *
+ * Copyright (c) 2002 Vojtech Pavlik
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation version 2.
+ */
+
+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <asm/io.h>
+#include <linux/kernel.h>
+#include <linux/stddef.h>
+#include <linux/sched.h>
+#include <linux/ioport.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/delay.h>
+#include "version.h"
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR ("Vojtech Pavlik <vojtech@suse.cz>");
+MODULE_DESCRIPTION("AMD8111 SMBus 2.0 driver");
+
+struct amd_smbus {
+	struct pci_dev *dev;
+	struct i2c_adapter adapter;
+	int base;
+	int size;
+};
+
+/*
+ * AMD PCI control registers definitions.
+ */
+
+#define AMD_PCI_MISC	0x48
+
+#define AMD_PCI_MISC_SCI	0x04	/* deliver SCI */
+#define AMD_PCI_MISC_INT	0x02	/* deliver PCI IRQ */
+#define AMD_PCI_MISC_SPEEDUP	0x01	/* 16x clock speedup */
+
+/*
+ * ACPI 2.0 chapter 13 PCI interface definitions.
+ */
+
+#define AMD_EC_DATA	0x00	/* data register */
+#define AMD_EC_SC	0x04	/* status of controller */
+#define AMD_EC_CMD	0x04	/* command register */
+#define AMD_EC_ICR	0x08	/* interrupt control register */
+
+#define AMD_EC_SC_SMI	0x04	/* smi event pending */
+#define AMD_EC_SC_SCI	0x02	/* sci event pending */
+#define AMD_EC_SC_BURST	0x01	/* burst mode enabled */
+#define AMD_EC_SC_CMD	0x08	/* byte in data reg is command */
+#define AMD_EC_SC_IBF	0x02	/* data ready for embedded controller */
+#define AMD_EC_SC_OBF	0x01	/* data ready for host */
+
+#define AMD_EC_CMD_RD	0x80	/* read EC */
+#define AMD_EC_CMD_WR	0x81	/* write EC */
+#define AMD_EC_CMD_BE	0x82	/* enable burst mode */
+#define AMD_EC_CMD_BD	0x83	/* disable burst mode */
+#define AMD_EC_CMD_QR	0x84	/* query EC */
+
+/*
+ * ACPI 2.0 chapter 13 access of registers of the EC
+ */
+
+unsigned int amd_ec_wait_write(struct amd_smbus *smbus)
+{
+	int timeout = 500;
+
+	while (timeout-- && (inb(smbus->base + AMD_EC_SC) & AMD_EC_SC_IBF))
+		udelay(1);
+
+	if (!timeout) {
+		printk(KERN_WARNING "i2c-amd811.c: Timeout while waiting for IBF to clear\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+unsigned int amd_ec_wait_read(struct amd_smbus *smbus)
+{
+	int timeout = 500;
+
+	while (timeout-- && (~inb(smbus->base + AMD_EC_SC) & AMD_EC_SC_OBF))
+		udelay(1);
+
+	if (!timeout) {
+		printk(KERN_WARNING "i2c-amd8111.c: Timeout while waiting for OBF to set\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+unsigned int amd_ec_read(struct amd_smbus *smbus, unsigned char address, unsigned char *data)
+{
+	if (amd_ec_wait_write(smbus))
+		return -1;
+	outb(AMD_EC_CMD_RD, smbus->base + AMD_EC_CMD);
+
+	if (amd_ec_wait_write(smbus))
+		return -1;
+	outb(address, smbus->base + AMD_EC_DATA);
+
+	if (amd_ec_wait_read(smbus))
+		return -1;
+	*data = inb(smbus->base + AMD_EC_DATA);
+
+	return 0;
+}
+
+unsigned int amd_ec_write(struct amd_smbus *smbus, unsigned char address, unsigned char data)
+{
+	if (amd_ec_wait_write(smbus))
+		return -1;
+	outb(AMD_EC_CMD_WR, smbus->base + AMD_EC_CMD);
+
+	if (amd_ec_wait_write(smbus))
+		return -1;
+	outb(address, smbus->base + AMD_EC_DATA);
+
+	if (amd_ec_wait_write(smbus))
+		return -1;
+	outb(data, smbus->base + AMD_EC_DATA);
+
+	return 0;
+}
+
+/*
+ * ACPI 2.0 chapter 13 SMBus 2.0 EC register model
+ */
+
+#define AMD_SMB_PRTCL	0x00	/* protocol, PEC */
+#define AMD_SMB_STS	0x01	/* status */
+#define AMD_SMB_ADDR	0x02	/* address */
+#define AMD_SMB_CMD	0x03	/* command */
+#define AMD_SMB_DATA	0x04	/* 32 data registers */
+#define AMD_SMB_BCNT	0x24	/* number of data bytes */
+#define AMD_SMB_ALRM_A	0x25	/* alarm address */
+#define AMD_SMB_ALRM_D	0x26	/* 2 bytes alarm data */
+
+#define AMD_SMB_STS_DONE	0x80
+#define AMD_SMB_STS_ALRM	0x40
+#define AMD_SMB_STS_RES		0x20
+#define AMD_SMB_STS_STATUS	0x1f
+
+#define AMD_SMB_STATUS_OK	0x00
+#define AMD_SMB_STATUS_FAIL	0x07
+#define AMD_SMB_STATUS_DNAK	0x10
+#define AMD_SMB_STATUS_DERR	0x11
+#define AMD_SMB_STATUS_CMD_DENY	0x12
+#define AMD_SMB_STATUS_UNKNOWN	0x13
+#define AMD_SMB_STATUS_ACC_DENY	0x17
+#define AMD_SMB_STATUS_TIMEOUT	0x18
+#define AMD_SMB_STATUS_NOTSUP	0x19
+#define AMD_SMB_STATUS_BUSY	0x1A
+#define AMD_SMB_STATUS_PEC	0x1F
+
+#define AMD_SMB_PRTCL_QUICK		0x02
+#define AMD_SMB_PRTCL_BYTE		0x04
+#define AMD_SMB_PRTCL_BYTE_DATA		0x06
+#define AMD_SMB_PRTCL_WORD_DATA		0x08
+#define AMD_SMB_PRTCL_BLOCK_DATA	0x0a
+#define AMD_SMB_PRTCL_PROC_CALL		0x0c
+#define AMD_SMB_PRTCL_BLOCK_PROC_CALL	0x0d
+#define AMD_SMB_PRTCL_I2C_BLOCK_DATA	0x4a
+#define AMD_SMB_PRTCL_PEC		0x80
+
+
+s32 amd8111_access(struct i2c_adapter * adap, u16 addr, unsigned short flags,
+		char read_write, u8 command, int size, union i2c_smbus_data * data)
+{
+	struct amd_smbus *smbus = adap->algo_data;
+	unsigned char protocol = read_write;	/* 1 = read, 0 = write */
+	unsigned char temp[2];
+	int i, timeout = 5000;
+
+	switch (size) {
+
+		case I2C_SMBUS_QUICK:
+			protocol |= AMD_SMB_PRTCL_QUICK;
+			break;
+
+		case I2C_SMBUS_BYTE:
+			if (!read_write)
+				amd_ec_write(smbus, AMD_SMB_DATA, data->byte);
+			protocol |= AMD_SMB_PRTCL_BYTE;
+			break;
+
+		case I2C_SMBUS_BYTE_DATA:
+			amd_ec_write(smbus, AMD_SMB_CMD, command);
+			if (!read_write)
+				amd_ec_write(smbus, AMD_SMB_DATA, data->byte);
+			protocol |= AMD_SMB_PRTCL_BYTE_DATA;
+			break;
+
+		case I2C_SMBUS_WORD_DATA:
+			amd_ec_write(smbus, AMD_SMB_CMD, command);
+			if (!read_write) {
+				amd_ec_write(smbus, AMD_SMB_DATA, data->byte);
+				amd_ec_write(smbus, AMD_SMB_DATA + 1, data->byte >> 8);
+			}
+			protocol |= AMD_SMB_PRTCL_WORD_DATA;
+			break;
+
+		case I2C_SMBUS_BLOCK_DATA:
+		case I2C_SMBUS_BLOCK_DATA_PEC:
+		case I2C_SMBUS_I2C_BLOCK_DATA:
+			amd_ec_write(smbus, AMD_SMB_CMD, command);
+			if (!read_write)
+				for (i = 0; i < data->block[0]; i++)
+					amd_ec_write(smbus, AMD_SMB_DATA + i, data->block[i + 1]);
+			switch (size) {
+				case I2C_SMBUS_BLOCK_DATA:
+					protocol |= AMD_SMB_PRTCL_BLOCK_DATA;
+					break;
+				case I2C_SMBUS_BLOCK_DATA_PEC:
+					protocol |= AMD_SMB_PRTCL_BLOCK_DATA | AMD_SMB_PRTCL_PEC;
+					break;
+				case I2C_SMBUS_I2C_BLOCK_DATA:
+					protocol |= AMD_SMB_PRTCL_I2C_BLOCK_DATA;
+					break;
+			}
+			break;
+
+		case I2C_SMBUS_PROC_CALL: /* We don't support proc_call yet */
+		default:
+			printk(KERN_WARNING "i2c-amd8111.c: Unsupported transaction %d\n", size);
+			return -1;
+	}
+
+	amd_ec_write(smbus, AMD_SMB_ADDR, addr << 1);
+	amd_ec_write(smbus, AMD_SMB_PRTCL, protocol);
+
+	amd_ec_read(smbus, AMD_SMB_STS, temp + 0);
+
+	while (timeout && ~temp[0] & AMD_SMB_STS_DONE) {
+		amd_ec_read(smbus, AMD_SMB_STS, temp + 0);
+		udelay(10);
+		timeout--;
+	}
+
+	if (!timeout)
+		return -1;
+
+	if (~temp[0] & AMD_SMB_STS_DONE) {
+		printk(KERN_WARNING "i2c-amd8111.c: Transaction completed with error %#x\n", temp[0]);
+		return -1;
+	}
+
+	if (!read_write) /* We're done, no values to return; */
+		return 0;
+
+	switch (size) {
+
+		case I2C_SMBUS_BYTE:
+		case I2C_SMBUS_BYTE_DATA:
+			amd_ec_read(smbus, AMD_SMB_DATA, &data->byte);
+			break;
+
+		case I2C_SMBUS_WORD_DATA:
+			amd_ec_read(smbus, AMD_SMB_DATA, temp + 0);
+			amd_ec_read(smbus, AMD_SMB_DATA + 1, temp + 1);
+			data->word = (temp[1] << 8) | temp[0];
+			break;
+
+		case I2C_SMBUS_BLOCK_DATA:
+		case I2C_SMBUS_BLOCK_DATA_PEC:
+		case I2C_SMBUS_I2C_BLOCK_DATA:
+			for (i = 0; i < data->block[0]; i++)
+				amd_ec_read(smbus, AMD_SMB_DATA + i, data->block + i + 1);
+			break;
+	}
+
+	return 0;
+}
+
+void amd8111_inc(struct i2c_adapter *adapter)
+{
+	MOD_INC_USE_COUNT;
+}
+
+void amd8111_dec(struct i2c_adapter *adapter)
+{
+	MOD_DEC_USE_COUNT;
+}
+
+u32 amd8111_func(struct i2c_adapter *adapter)
+{
+	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
+	    I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
+	    I2C_FUNC_SMBUS_BLOCK_DATA | I2C_FUNC_SMBUS_WRITE_I2C_BLOCK |
+	    I2C_FUNC_SMBUS_BLOCK_DATA_PEC | I2C_FUNC_SMBUS_HWPEC_CALC;
+}
+
+static struct i2c_algorithm smbus_algorithm = {
+	.name = "Non-I2C SMBus 2.0 adapter",
+	.id = I2C_ALGO_SMBUS,
+	.smbus_xfer = amd8111_access,
+	.functionality = amd8111_func,
+};
+
+static int __devinit amd8111_probe(struct pci_dev *dev, const struct pci_device_id *id)
+{
+	struct amd_smbus *smbus;
+
+	if (~pci_resource_flags(dev, 0) & IORESOURCE_IO)
+		return -1;
+
+	if (!(smbus = kmalloc(sizeof(struct amd_smbus), GFP_KERNEL)))
+		return -1;
+	memset(smbus, 0, sizeof(struct amd_smbus));
+
+	pci_set_drvdata(dev, smbus);
+	smbus->dev = dev;
+	smbus->base = pci_resource_start(dev, 0);
+	smbus->size = pci_resource_len(dev, 0);
+
+	if (!request_region(smbus->base, smbus->size, "amd81111 SMBus 2.0")) {
+		kfree(smbus);
+		return -1;
+	}
+
+	sprintf(smbus->adapter.name, "SMBus2 AMD8111 adapter at %04x", smbus->base);
+	smbus->adapter.id = I2C_ALGO_SMBUS | I2C_HW_SMBUS_AMD8111;
+	smbus->adapter.algo = &smbus_algorithm;
+	smbus->adapter.algo_data = smbus;
+	smbus->adapter.inc_use = amd8111_inc;
+	smbus->adapter.dec_use = amd8111_dec;
+
+	pci_write_config_dword(dev, AMD_PCI_MISC, 0);
+
+	if (i2c_add_adapter(&smbus->adapter)) {
+		printk(KERN_WARNING "i2c-amd8111.c: Failed to register adapter.\n");
+		release_region(smbus->base, smbus->size);
+		kfree(smbus);
+		return -1;
+	}
+
+	printk(KERN_INFO "i2c-amd8111.c: AMD8111 SMBus 2.0 adapter at pci%s\n", dev->slot_name);
+	return 0;
+}
+
+static void __devexit amd8111_remove(struct pci_dev *dev)
+{
+	struct amd_smbus *smbus = pci_get_drvdata(dev);
+	if (i2c_del_adapter(&smbus->adapter)) {
+		printk(KERN_WARNING "i2c-amd81111.c: Failed to unregister adapter.\n");
+		return;
+	}
+	release_region(smbus->base, smbus->size);
+	kfree(smbus);
+}
+
+static struct pci_device_id amd8111_id_table[] __devinitdata +{{ 0x1022, 0x746a, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+ { 0 }};
+
+static struct pci_driver amd8111_driver = {
+	.name = "amd8111 smbus 2.0",
+	.id_table = amd8111_id_table,
+	.probe = amd8111_probe,
+	.remove = amd8111_remove,
+};
+
+int __init amd8111_init(void)
+{
+	return pci_module_init(&amd8111_driver);
+}
+
+void __exit amd8111_exit(void)
+{
+	pci_unregister_driver(&amd8111_driver);
+}
+
+module_init(amd8111_init);
+module_exit(amd8111_exit);
diff -urN lm_sensors-2.6.5/mkpatch/FILES lm_sensors-2.6.5-8111/mkpatch/FILES
--- lm_sensors-2.6.5/mkpatch/FILES	2002-09-10 02:22:40.000000000 +0200
+++ lm_sensors-2.6.5-8111/mkpatch/FILES	2002-11-07 15:46:46.000000000 +0100
@@ -3,6 +3,7 @@
 kernel/busses/i2c-ali1535.c	drivers/i2c/i2c-ali1535.c
 kernel/busses/i2c-ali15x3.c	drivers/i2c/i2c-ali15x3.c
 kernel/busses/i2c-amd756.c	drivers/i2c/i2c-amd756.c
+kernel/busses/i2c-amd8111.c	drivers/i2c/i2c-amd8111.c
 kernel/busses/i2c-hydra.c	drivers/i2c/i2c-hydra.c
 kernel/busses/i2c-i801.c	drivers/i2c/i2c-i801.c
 kernel/busses/i2c-i810.c	drivers/i2c/i2c-i810.c
diff -urN lm_sensors-2.6.5/prog/detect/sensors-detect lm_sensors-2.6.5-8111/prog/detect/sensors-detect
--- lm_sensors-2.6.5/prog/detect/sensors-detect	2002-09-01 22:22:51.000000000 +0200
+++ lm_sensors-2.6.5-8111/prog/detect/sensors-detect	2002-11-07 17:32:05.000000000 +0100
@@ -269,6 +269,22 @@
        driver => "i2c-amd756",
        match => sub { $_[0] =~ /^SMBus AMD768 adapter at [0-9,a-f]{4}/ },
      },
+     { 
+       vendid => 0x1022,
+       devid  => 0x746b,
+       func => 3,
+       procid => "AMD-8111 ACPI",
+       driver => "i2c-amd756",
+       match => sub { $_[0] =~ /^SMBus AMD8111 adapter at [0-9,a-f]{4}/ },
+     },
+     { 
+       vendid => 0x1022,
+       devid  => 0x746a,
+       func => 2,
+       procid => "AMD-8111 SMBus 2.0",
+       driver => "i2c-amd8111",
+       match => sub { $_[0] =~ /^SMBus2 AMD8111 adapter at [0-9,a-f]{4}/ },
+     },
      {
        vendid => 0x102b,
        devid  => 0x0519,
