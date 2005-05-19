From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:19 +0000
Subject: Adding S4882 support to the i2c-amd756 driver
Message-Id: <20041018225457.265ed103.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041017222721.1f12466d.khali@linux-fr.org>
In-Reply-To: <20041017222721.1f12466d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting myself:

> * Composite module
> I don't know how this can be done in the lm_sensors tree. Hint anyone?

I finally came to a sort of composite module. Thanks go to my beloved
one for the idea of simply including i2c-amd756-s4882.c from
i2c-amd756.c. Simple and unusual but it does what we need. We don't even
need to alter the Makefile stuff.

Mark, does this second approach please you more than my original one?
The changes to the original file are reduced to their minimal form.

We could probably go with a real composite module (separate compilation)
but this means changes to kernel/busses/Module.mk, and at least one
additional header file. I don't think it's worth the effort, but
counterarguments are welcome.

Patch to i2c-amd756.c:

=================================RCS file: /home/cvs/lm_sensors2/kernel/busses/i2c-amd756.c,v
retrieving revision 1.35
diff -u -r1.35 i2c-amd756.c
--- kernel/busses/i2c-amd756.c	16 Oct 2004 17:11:39 -0000	1.35
+++ kernel/busses/i2c-amd756.c	18 Oct 2004 20:35:54 -0000
@@ -89,6 +89,13 @@
 #define AMD756_PROCESS_CALL 0x04
 #define AMD756_BLOCK_DATA   0x05
 
+/* Include S4882 support by default if compiled outside of the kernel tree.
+   When patching the kernel instead, inclusion can be decided as a kernel
+   configuration option. */
+#ifndef CONFIG_I2C_AMD756
+#define CONFIG_I2C_AMD756_S4882
+#endif
+
 
 static unsigned short amd756_ioport = 0;
 
@@ -315,25 +322,35 @@
 	.algo		= &smbus_algorithm,
 };
 
-enum chiptype { AMD756, AMD766, AMD768, NFORCE, AMD8111 };
+enum chiptype { AMD756, AMD766, AMD768, NFORCE, AMD8111, S4882 };
 static const char* chipname[] = {
 	"AMD756", "AMD766", "AMD768",
-	"nVidia nForce", "AMD8111",
+	"nVidia nForce", "AMD8111", "AMD8111",
 };
 
 static struct pci_device_id amd756_ids[] __devinitdata = {
 	{PCI_VENDOR_ID_AMD, 0x740B, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AMD756 },
 	{PCI_VENDOR_ID_AMD, 0x7413, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AMD766 },
 	{PCI_VENDOR_ID_AMD, 0x7443, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AMD768 },
+#ifdef CONFIG_I2C_AMD756_S4882
+	{PCI_VENDOR_ID_AMD, 0x746B, PCI_VENDOR_ID_AMD, 0x36C0, 0, 0, S4882 },
+#endif
 	{PCI_VENDOR_ID_AMD, 0x746B, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AMD8111 },
 	{PCI_VENDOR_ID_NVIDIA, 0x01B4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, NFORCE },
 	{ 0, }
 };
 
+#ifdef CONFIG_I2C_AMD756_S4882
+#include "i2c-amd756-s4882.c"
+#endif
+
 static int __devinit amd756_probe(struct pci_dev *pdev,
 				  const struct pci_device_id *id)
 {
 	int nforce = (id->driver_data = NFORCE);
+#ifdef CONFIG_I2C_AMD756_S4882
+	int s4882 = (id->driver_data = S4882);
+#endif
 	int error;
 	u8 temp;
 	
@@ -379,6 +396,11 @@
 	printk(KERN_DEBUG DRV_NAME ": AMD756_smba = 0x%X\n", amd756_ioport);
 #endif
 
+#ifdef CONFIG_I2C_AMD756_S4882
+	if (s4882)
+		amd756_s4882_init_main();
+#endif
+
 	sprintf(amd756_adapter.name, "SMBus %s adapter at %04x",
 		chipname[id->driver_data], amd756_ioport);
 
@@ -389,6 +411,14 @@
 		goto out_err;
 	}
 
+#ifdef CONFIG_I2C_AMD756_S4882
+	if (s4882) {
+		error = amd756_s4882_init_virtual();
+		if (error)
+			goto out_err;
+	}
+#endif
+
 	return 0;
 
  out_err:
@@ -416,6 +446,9 @@
 
 static void __exit i2c_amd756_exit(void)
 {
+#ifdef CONFIG_I2C_AMD756_S4882
+	amd756_s4882_exit();
+#endif
 	i2c_del_adapter(&amd756_adapter);
 	release_region(amd756_ioport, SMB_IOSIZE);
 }
=================================

New code goes in kernel/busses/i2c-amd756-s4882.c:

=================================/*
 * i2c-amd756-s4882.c - i2c-amd756 extras for the Tyan S4882 motherboard
 *
 * Copyright (C) 2004 Jean Delvare <khali@linux-fr.org>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 */
 
/*
 * We select the channels by sending commands to the Philips
 * PCA9556 chip at I2C address 0x18. The main adapter is used for
 * the non-multiplexed part of the bus, and 4 virtual adapters
 * are defined for the multiplexed addresses: 0x50-0x53 (memory
 * module EEPROM) located on channels 1-4, and 0x4c (LM63)
 * located on multiplexed channels 0 and 5-7. We define one
 * virtual adapter per CPU, which corresponds to two multiplexed
 * channels:
 *   CPU0: virtual adapter 1, channels 1 and 0
 *   CPU1: virtual adapter 2, channels 2 and 5
 *   CPU2: virtual adapter 3, channels 3 and 6
 *   CPU3: virtual adapter 4, channels 4 and 7
 * Support is only included if CONFIG_I2C_AMD756_S4882 is
 * defined.
 */

static struct i2c_adapter *s4882_adapter;
static struct i2c_algorithm *s4882_algo;

static struct i2c_client pca9556_client = {
	.name		= "pca9556",
	.adapter	= &amd756_adapter,
	.addr		= 0x18,
	.driver		= NULL,
};

/* Wrapper access functions for multiplexed SMBus (S4882) */
static struct semaphore amd756_lock;

static s32 amd756_access_virt0(struct i2c_adapter * adap, u16 addr,
		  unsigned short flags, char read_write,
		  u8 command, int size, union i2c_smbus_data * data)
{
	int error;

	/* We exclude the multiplexed addresses */
	if (addr = 0x4c || (addr & 0xfc) = 0x50 || (addr & 0xfc) = 0x30)
		return -1;

	down(&amd756_lock);

	error = amd756_access(adap, addr, flags, read_write, command, size,
			      data);

	up(&amd756_lock);

	return error;
}

/* We remember the last used channels combination so as to only switch
   channels when it is really needed. This greatly reduces the SMBus
   overhead, but also assumes that nobody will be writing to the PCA9556
   in our back. */
static u8 last_channels;

static inline s32 amd756_access_channel(struct i2c_adapter * adap, u16 addr,
		  unsigned short flags, char read_write,
		  u8 command, int size, union i2c_smbus_data * data,
		  u8 channels)
{
	int error;

	/* We exclude the non-multiplexed addresses */
	if (addr != 0x4c && (addr & 0xfc) != 0x50 && (addr & 0xfc) != 0x30)
		return -1;

	down(&amd756_lock);

	if (last_channels != channels) {
		union i2c_smbus_data mplxdata;
		mplxdata.byte = channels;

		error = amd756_access(adap, 0x18, 0, I2C_SMBUS_WRITE, 0x01,
				      I2C_SMBUS_BYTE_DATA, &mplxdata);
		if (error)
			goto UNLOCK;
		last_channels = channels;
	}
	error = amd756_access(adap, addr, flags, read_write, command, size,
			      data);

UNLOCK:
	up(&amd756_lock);
	return error;
}

static s32 amd756_access_virt1(struct i2c_adapter * adap, u16 addr,
		  unsigned short flags, char read_write,
		  u8 command, int size, union i2c_smbus_data * data)
{
	/* CPU0: channels 1 and 0 enabled */
	return amd756_access_channel(adap, addr, flags, read_write, command,
				     size, data, 0x03);
}

static s32 amd756_access_virt2(struct i2c_adapter * adap, u16 addr,
		  unsigned short flags, char read_write,
		  u8 command, int size, union i2c_smbus_data * data)
{
	/* CPU1: channels 2 and 5 enabled */
	return amd756_access_channel(adap, addr, flags, read_write, command,
				     size, data, 0x24);
}

static s32 amd756_access_virt3(struct i2c_adapter * adap, u16 addr,
		  unsigned short flags, char read_write,
		  u8 command, int size, union i2c_smbus_data * data)
{
	/* CPU2: channels 3 and 6 enabled */
	return amd756_access_channel(adap, addr, flags, read_write, command,
				     size, data, 0x48);
}

static s32 amd756_access_virt4(struct i2c_adapter * adap, u16 addr,
		  unsigned short flags, char read_write,
		  u8 command, int size, union i2c_smbus_data * data)
{
	/* CPU3: channels 4 and 7 enabled */
	return amd756_access_channel(adap, addr, flags, read_write, command,
				     size, data, 0x90);
}

static void __devinit amd756_s4882_init_main(void)
{
	printk(KERN_INFO DRV_NAME ": Enabling bus multiplexing for "
	       "Tyan S4882\n");

	init_MUTEX(&amd756_lock);

	/* Intercept calls to the main adapter  */
	smbus_algorithm.smbus_xfer = amd756_access_virt0;
}

/* return 0 on success, negative value on error */
static int __devinit amd756_s4882_init_virtual(void)
{
	int i, error;
	union i2c_smbus_data ioconfig;

	/* Define the 4 virtual adapters and algorithms structures */
	if (!(s4882_adapter = kmalloc(4 * sizeof(struct i2c_adapter),
				      GFP_KERNEL))) {
		error = -ENOMEM;
		goto ERROR0;
	}
	if (!(s4882_algo = kmalloc(4 * sizeof(struct i2c_algorithm),
				   GFP_KERNEL))) {
		error = -ENOMEM;
		goto ERROR1;
	}

	for (i = 0; i < 4; i++) {
		s4882_algo[i] = smbus_algorithm;
		s4882_adapter[i] = amd756_adapter;
		sprintf(s4882_adapter[i].name,
			"SMBus 8111 adapter (CPU%d)", i);
		s4882_adapter[i].algo = s4882_algo+i;
	}

	/* Point to the wrapper callback functions */
	s4882_algo[0].smbus_xfer = amd756_access_virt1;
	s4882_algo[1].smbus_xfer = amd756_access_virt2;
	s4882_algo[2].smbus_xfer = amd756_access_virt3;
	s4882_algo[3].smbus_xfer = amd756_access_virt4;

	/* Register the PCA9556 multiplexer */
	error = i2c_attach_client(&pca9556_client);
	if (error) {
		printk(KERN_ERR DRV_NAME ": PCA9556 registration "
		       "failed\n");
		goto ERROR2;
	}

	/* Configure the PCA9556 multiplexer */
	ioconfig.byte = 0x00; /* All I/O to output mode */
	error = amd756_access(&amd756_adapter, 0x18, 0,
			      I2C_SMBUS_WRITE, 0x03,
			      I2C_SMBUS_BYTE_DATA, &ioconfig);
	if (error) {
		printk(KERN_ERR DRV_NAME ": PCA9556 configuration "
		       "failed\n");
		error = -EIO;
		goto ERROR3;
	}

	/* Register virtual adapters */
	for (i = 0; i < 4; i++) {
		error = i2c_add_adapter(s4882_adapter+i);
		if (error) {
			printk(KERN_ERR DRV_NAME
			       ": Virtual adapter %d registration "
			       "failed, module not inserted\n", i);
			for (i--; i >= 0; i--)
				i2c_del_adapter(s4882_adapter+i);
			goto ERROR3;
		}
	}

	return 0;

ERROR3:
	i2c_detach_client(&pca9556_client);
ERROR2:
	kfree(s4882_algo);
	s4882_algo = NULL;
ERROR1:
	kfree(s4882_adapter);
	s4882_adapter = NULL;
ERROR0:
	return error;
}

static void __exit amd756_s4882_exit(void)
{
	if (s4882_adapter) {
		int i;

		for (i = 0; i < 4; i++)
			i2c_del_adapter(s4882_adapter+i);
		kfree(s4882_adapter);
		s4882_adapter = NULL;
	}
	if (s4882_algo) {
		kfree(s4882_algo);
		s4882_algo = NULL;
	}

	i2c_detach_client(&pca9556_client);
}

=================================
Comments welcome,
thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
