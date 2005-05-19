From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:55 +0000
Subject: [CVS PATCH] Sync cvs tree with latest 2.5 bk tree
Message-Id: <20030425183641.GB2257@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Here's a patch to sync up the lmsensors cvs tree with the current 2.5 bk
tree.  Anyone with commit permissions want to submit it?

The header files should be renamed too, as they have been in the kernel
tree, but a cvs diff can't show that :)

I'll submit a i2c sync patch, after this is applied, as that is out of
date quite a bit too.

Ah, now you all see why it's tough to do work in two trees...

thanks,

greg k-h


Index: kernel/busses/i2c-ali15x3.c
=================================RCS file: /home/cvs/lm_sensors2/kernel/busses/i2c-ali15x3.c,v
retrieving revision 1.28
diff -a -u -r1.28 i2c-ali15x3.c
--- kernel/busses/i2c-ali15x3.c	21 Jan 2003 20:01:27 -0000	1.28
+++ kernel/busses/i2c-ali15x3.c	25 Apr 2003 18:29:29 -0000
@@ -60,6 +60,8 @@
 
 /* Note: we assume there can only be one ALI15X3, with one SMBus interface */
 
+/* #define DEBUG 1 */
+
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/kernel.h>
@@ -69,49 +71,48 @@
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <asm/io.h>
-#include "version.h"
 
 /* ALI15X3 SMBus address offsets */
-#define SMBHSTSTS (0 + ali15x3_smba)
-#define SMBHSTCNT (1 + ali15x3_smba)
-#define SMBHSTSTART (2 + ali15x3_smba)
-#define SMBHSTCMD (7 + ali15x3_smba)
-#define SMBHSTADD (3 + ali15x3_smba)
-#define SMBHSTDAT0 (4 + ali15x3_smba)
-#define SMBHSTDAT1 (5 + ali15x3_smba)
-#define SMBBLKDAT (6 + ali15x3_smba)
+#define SMBHSTSTS	(0 + ali15x3_smba)
+#define SMBHSTCNT	(1 + ali15x3_smba)
+#define SMBHSTSTART	(2 + ali15x3_smba)
+#define SMBHSTCMD	(7 + ali15x3_smba)
+#define SMBHSTADD	(3 + ali15x3_smba)
+#define SMBHSTDAT0	(4 + ali15x3_smba)
+#define SMBHSTDAT1	(5 + ali15x3_smba)
+#define SMBBLKDAT	(6 + ali15x3_smba)
 
 /* PCI Address Constants */
-#define SMBCOM    0x004
-#define SMBBA     0x014
-#define SMBATPC   0x05B		/* used to unlock xxxBA registers */
-#define SMBHSTCFG 0x0E0
-#define SMBSLVC   0x0E1
-#define SMBCLK    0x0E2
-#define SMBREV    0x008
+#define SMBCOM		0x004
+#define SMBBA		0x014
+#define SMBATPC		0x05B	/* used to unlock xxxBA registers */
+#define SMBHSTCFG	0x0E0
+#define SMBSLVC		0x0E1
+#define SMBCLK		0x0E2
+#define SMBREV		0x008
 
 /* Other settings */
-#define MAX_TIMEOUT 200		/* times 1/100 sec */
-#define ALI15X3_SMB_IOSIZE 32
+#define MAX_TIMEOUT		200	/* times 1/100 sec */
+#define ALI15X3_SMB_IOSIZE	32
 
 /* this is what the Award 1004 BIOS sets them to on a ASUS P5A MB.
    We don't use these here. If the bases aren't set to some value we
    tell user to upgrade BIOS and we fail.
 */
-#define ALI15X3_SMB_DEFAULTBASE 0xE800
+#define ALI15X3_SMB_DEFAULTBASE	0xE800
 
 /* ALI15X3 address lock bits */
-#define ALI15X3_LOCK	0x06
+#define ALI15X3_LOCK		0x06
 
 /* ALI15X3 command constants */
-#define ALI15X3_ABORT      0x02
-#define ALI15X3_T_OUT      0x04
-#define ALI15X3_QUICK      0x00
-#define ALI15X3_BYTE       0x10
-#define ALI15X3_BYTE_DATA  0x20
-#define ALI15X3_WORD_DATA  0x30
-#define ALI15X3_BLOCK_DATA 0x40
-#define ALI15X3_BLOCK_CLR  0x80
+#define ALI15X3_ABORT		0x02
+#define ALI15X3_T_OUT		0x04
+#define ALI15X3_QUICK		0x00
+#define ALI15X3_BYTE		0x10
+#define ALI15X3_BYTE_DATA	0x20
+#define ALI15X3_WORD_DATA	0x30
+#define ALI15X3_BLOCK_DATA	0x40
+#define ALI15X3_BLOCK_CLR	0x80
 
 /* ALI15X3 status register bits */
 #define ALI15X3_STS_IDLE	0x04
@@ -130,77 +131,52 @@
 MODULE_PARM_DESC(force_addr,
 		 "Initialize the base address of the i2c controller");
 
-
-static void ali15x3_do_pause(unsigned int amount);
-static int ali15x3_transaction(void);
-
 static unsigned short ali15x3_smba = 0;
-static int locked=0;
 
-/* Detect whether a ALI15X3 can be found, and initialize it, where necessary.
-   Note the differences between kernels with the old PCI BIOS interface and
-   newer kernels with the real PCI interface. In compat.h some things are
-   defined to make the transition easier. */
-int ali15x3_setup(void)
+static int ali15x3_setup(struct pci_dev *ALI15X3_dev)
 {
 	u16 a;
 	unsigned char temp;
 
-	struct pci_dev *ALI15X3_dev;
-
-	/* First check whether we can access PCI at all */
-	if (pci_present() = 0) {
-		printk("i2c-ali15x3.o: Error: No PCI-bus found!\n");
-		return -ENODEV;
-	}
-
-	/* Look for the ALI15X3, M7101 device */
-	ALI15X3_dev = NULL;
-	ALI15X3_dev = pci_find_device(PCI_VENDOR_ID_AL,
-				      PCI_DEVICE_ID_AL_M7101, ALI15X3_dev);
-	if (ALI15X3_dev = NULL) {
-		printk("i2c-ali15x3.o: Error: Can't detect ali15x3!\n");
-		return -ENODEV;
-	}
-
-/* Check the following things:
-	- SMB I/O address is initialized
-	- Device is enabled
-	- We can use the addresses
-*/
-
-/* Unlock the register.
-   The data sheet says that the address registers are read-only
-   if the lock bits are 1, but in fact the address registers
-   are zero unless you clear the lock bits.
-*/
+	/* Check the following things:
+		- SMB I/O address is initialized
+		- Device is enabled
+		- We can use the addresses
+	*/
+
+	/* Unlock the register.
+	   The data sheet says that the address registers are read-only
+	   if the lock bits are 1, but in fact the address registers
+	   are zero unless you clear the lock bits.
+	*/
 	pci_read_config_byte(ALI15X3_dev, SMBATPC, &temp);
 	if (temp & ALI15X3_LOCK) {
 		temp &= ~ALI15X3_LOCK;
 		pci_write_config_byte(ALI15X3_dev, SMBATPC, temp);
 	}
 
-/* Determine the address of the SMBus area */
+	/* Determine the address of the SMBus area */
 	pci_read_config_word(ALI15X3_dev, SMBBA, &ali15x3_smba);
 	ali15x3_smba &= (0xffff & ~(ALI15X3_SMB_IOSIZE - 1));
 	if (ali15x3_smba = 0 && force_addr = 0) {
-		printk
-		    ("i2c-ali15x3.o: ALI15X3_smb region uninitialized - upgrade BIOS or use force_addr=0xaddr\n");
+		dev_err(&ALI15X3_dev->dev, "ALI15X3_smb region uninitialized "
+			"- upgrade BIOS or use force_addr=0xaddr\n");
 		return -ENODEV;
 	}
 
 	if(force_addr)
 		ali15x3_smba = force_addr & ~(ALI15X3_SMB_IOSIZE - 1);
 
-	if (check_region(ali15x3_smba, ALI15X3_SMB_IOSIZE)) {
-		printk
-		    ("i2c-ali15x3.o: ALI15X3_smb region 0x%x already in use!\n",
-		     ali15x3_smba);
+	if (!request_region(ali15x3_smba, ALI15X3_SMB_IOSIZE, "ali15x3-smb")) {
+		dev_err(&ALI15X3_dev->dev,
+			"ALI15X3_smb region 0x%x already in use!\n",
+			ali15x3_smba);
 		return -ENODEV;
 	}
 
 	if(force_addr) {
-		printk("i2c-ali15x3.o: forcing ISA address 0x%04X\n", ali15x3_smba);
+		dev_info(&ALI15X3_dev->dev, "forcing ISA address 0x%04X\n",
+			ali15x3_smba);
 		if (PCIBIOS_SUCCESSFUL ! 		    pci_write_config_word(ALI15X3_dev, SMBBA, ali15x3_smba))
 			return -ENODEV;
@@ -209,68 +185,60 @@
 			return -ENODEV;
 		if ((a & ~(ALI15X3_SMB_IOSIZE - 1)) != ali15x3_smba) {
 			/* make sure it works */
-			printk("i2c-ali15x3.o: force address failed - not supported?\n");
+			dev_err(&ALI15X3_dev->dev,
+				"force address failed - not supported?\n");
 			return -ENODEV;
 		}
 	}
-/* check if whole device is enabled */
+	/* check if whole device is enabled */
 	pci_read_config_byte(ALI15X3_dev, SMBCOM, &temp);
 	if ((temp & 1) = 0) {
-		printk("i2c-ali15x3: enabling SMBus device\n");
+		dev_info(&ALI15X3_dev->dev, "enabling SMBus device\n");
 		pci_write_config_byte(ALI15X3_dev, SMBCOM, temp | 0x01);
 	}
 
-/* Is SMB Host controller enabled? */
+	/* Is SMB Host controller enabled? */
 	pci_read_config_byte(ALI15X3_dev, SMBHSTCFG, &temp);
 	if ((temp & 1) = 0) {
-		printk("i2c-ali15x3: enabling SMBus controller\n");
+		dev_info(&ALI15X3_dev->dev, "enabling SMBus controller\n");
 		pci_write_config_byte(ALI15X3_dev, SMBHSTCFG, temp | 0x01);
 	}
 
-/* set SMB clock to 74KHz as recommended in data sheet */
+	/* set SMB clock to 74KHz as recommended in data sheet */
 	pci_write_config_byte(ALI15X3_dev, SMBCLK, 0x20);
 
-	/* Everything is happy, let's grab the memory and set things up. */
-	request_region(ali15x3_smba, ALI15X3_SMB_IOSIZE, "ali15x3-smb");
-
-#ifdef DEBUG
-/*
-  The interrupt routing for SMB is set up in register 0x77 in the
-  1533 ISA Bridge device, NOT in the 7101 device.
-  Don't bother with finding the 1533 device and reading the register.
-  if ((....... & 0x0F) = 1)
-     printk("i2c-ali15x3.o: ALI15X3 using Interrupt 9 for SMBus.\n");
-*/
+	/*
+	  The interrupt routing for SMB is set up in register 0x77 in the
+	  1533 ISA Bridge device, NOT in the 7101 device.
+	  Don't bother with finding the 1533 device and reading the register.
+	if ((....... & 0x0F) = 1)
+		dev_dbg(&ALI15X3_dev->dev, "ALI15X3 using Interrupt 9 for SMBus.\n");
+	*/
 	pci_read_config_byte(ALI15X3_dev, SMBREV, &temp);
-	printk("i2c-ali15x3.o: SMBREV = 0x%X\n", temp);
-	printk("i2c-ali15x3.o: ALI15X3_smba = 0x%X\n", ali15x3_smba);
-#endif				/* DEBUG */
+	dev_dbg(&ALI15X3_dev->dev, "SMBREV = 0x%X\n", temp);
+	dev_dbg(&ALI15X3_dev->dev, "iALI15X3_smba = 0x%X\n", ali15x3_smba);
 
 	return 0;
 }
 
-
 /* Internally used pause function */
-void ali15x3_do_pause(unsigned int amount)
+static void ali15x3_do_pause(unsigned int amount)
 {
 	current->state = TASK_INTERRUPTIBLE;
 	schedule_timeout(amount);
 }
 
 /* Another internally used function */
-int ali15x3_transaction(void)
+static int ali15x3_transaction(struct i2c_adapter *adap)
 {
 	int temp;
 	int result = 0;
 	int timeout = 0;
 
-#ifdef DEBUG
-	printk
-	    ("i2c-ali15x3.o: Transaction (pre): STS=%02x, CNT=%02x, CMD=%02x, ADD=%02x, DAT0=%02x, "
-	     "DAT1=%02x\n", inb_p(SMBHSTSTS), inb_p(SMBHSTCNT),
-	     inb_p(SMBHSTCMD), inb_p(SMBHSTADD), inb_p(SMBHSTDAT0),
-	     inb_p(SMBHSTDAT1));
-#endif
+	dev_dbg(&adap->dev, "Transaction (pre): STS=%02x, CNT=%02x, CMD=%02x, "
+		"ADD=%02x, DAT0=%02x, DAT1=%02x\n", inb_p(SMBHSTSTS),
+		inb_p(SMBHSTCNT), inb_p(SMBHSTCMD), inb_p(SMBHSTADD),
+		inb_p(SMBHSTDAT0), inb_p(SMBHSTDAT1));
 
 	/* get status */
 	temp = inb_p(SMBHSTSTS);
@@ -278,43 +246,32 @@
 	/* Make sure the SMBus host is ready to start transmitting */
 	/* Check the busy bit first */
 	if (temp & ALI15X3_STS_BUSY) {
-/*
-   If the host controller is still busy, it may have timed out in the previous transaction,
-   resulting in a "SMBus Timeout" printk.
-   I've tried the following to reset a stuck busy bit.
-	1. Reset the controller with an ABORT command.
-	   (this doesn't seem to clear the controller if an external device is hung)
-	2. Reset the controller and the other SMBus devices with a T_OUT command.
-	   (this clears the host busy bit if an external device is hung,
-	   but it comes back upon a new access to a device)
-	3. Disable and reenable the controller in SMBHSTCFG
-   Worst case, nothing seems to work except power reset.
-*/
-/* Abort - reset the host controller */
-/*
-#ifdef DEBUG
-    printk("i2c-ali15x3.o: Resetting host controller to clear busy condition\n",temp);
-#endif
-    outb_p(ALI15X3_ABORT, SMBHSTCNT);
-    temp = inb_p(SMBHSTSTS);
-    if (temp & ALI15X3_STS_BUSY) {
-*/
-
-/*
-   Try resetting entire SMB bus, including other devices -
-   This may not work either - it clears the BUSY bit but
-   then the BUSY bit may come back on when you try and use the chip again.
-   If that's the case you are stuck.
-*/
-		printk
-		    ("i2c-ali15x3.o: Resetting entire SMB Bus to clear busy condition (%02x)\n",
-		     temp);
+	/*
+	   If the host controller is still busy, it may have timed out in the
+	   previous transaction, resulting in a "SMBus Timeout" Dev.
+	   I've tried the following to reset a stuck busy bit.
+		1. Reset the controller with an ABORT command.
+		   (this doesn't seem to clear the controller if an external
+		   device is hung)
+		2. Reset the controller and the other SMBus devices with a
+		   T_OUT command.  (this clears the host busy bit if an
+		   external device is hung, but it comes back upon a new access
+		   to a device)
+		3. Disable and reenable the controller in SMBHSTCFG
+	   Worst case, nothing seems to work except power reset.
+	*/
+	/* Abort - reset the host controller */
+	/*
+	   Try resetting entire SMB bus, including other devices -
+	   This may not work either - it clears the BUSY bit but
+	   then the BUSY bit may come back on when you try and use the chip again.
+	   If that's the case you are stuck.
+	*/
+		dev_info(&adap->dev, "Resetting entire SMB Bus to "
+			"clear busy condition (%02x)\n", temp);
 		outb_p(ALI15X3_T_OUT, SMBHSTCNT);
 		temp = inb_p(SMBHSTSTS);
 	}
-/*
-  }
-*/
 
 	/* now check the error bits and the busy bit */
 	if (temp & (ALI15X3_STS_ERR | ALI15X3_STS_BUSY)) {
@@ -325,9 +282,9 @@
 			/* this is probably going to be correctable only by a power reset
 			   as one of the bits now appears to be stuck */
 			/* This may be a bus or device with electrical problems. */
-			printk
-			    ("i2c-ali15x3.o: SMBus reset failed! (0x%02x) - controller or device on bus is probably hung\n",
-			     temp);
+			dev_err(&adap->dev, "SMBus reset failed! (0x%02x) - "
+				"controller or device on bus is probably hung\n",
+				temp);
 			return -1;
 		}
 	} else {
@@ -351,48 +308,41 @@
 	/* If the SMBus is still busy, we give up */
 	if (timeout >= MAX_TIMEOUT) {
 		result = -1;
-		printk("i2c-ali15x3.o: SMBus Timeout!\n");
+		dev_err(&adap->dev, "SMBus Timeout!\n");
 	}
 
 	if (temp & ALI15X3_STS_TERM) {
 		result = -1;
-#ifdef DEBUG
-		printk("i2c-ali15x3.o: Error: Failed bus transaction\n");
-#endif
+		dev_dbg(&adap->dev, "Error: Failed bus transaction\n");
 	}
 
-/*
-  Unfortunately the ALI SMB controller maps "no response" and "bus collision"
-  into a single bit. No reponse is the usual case so don't
-  do a printk.
-  This means that bus collisions go unreported.
-*/
+	/*
+	  Unfortunately the ALI SMB controller maps "no response" and "bus
+	  collision" into a single bit. No reponse is the usual case so don't
+	  do a printk.
+	  This means that bus collisions go unreported.
+	*/
 	if (temp & ALI15X3_STS_COLL) {
 		result = -1;
-#ifdef DEBUG
-		printk
-		    ("i2c-ali15x3.o: Error: no response or bus collision ADD=%02x\n",
-		     inb_p(SMBHSTADD));
-#endif
+		dev_dbg(&adap->dev,
+			"Error: no response or bus collision ADD=%02x\n",
+			inb_p(SMBHSTADD));
 	}
 
-/* haven't ever seen this */
+	/* haven't ever seen this */
 	if (temp & ALI15X3_STS_DEV) {
 		result = -1;
-		printk("i2c-ali15x3.o: Error: device error\n");
+		dev_err(&adap->dev, "Error: device error\n");
 	}
-#ifdef DEBUG
-	printk
-	    ("i2c-ali15x3.o: Transaction (post): STS=%02x, CNT=%02x, CMD=%02x, ADD=%02x, "
-	     "DAT0=%02x, DAT1=%02x\n", inb_p(SMBHSTSTS), inb_p(SMBHSTCNT),
-	     inb_p(SMBHSTCMD), inb_p(SMBHSTADD), inb_p(SMBHSTDAT0),
-	     inb_p(SMBHSTDAT1));
-#endif
+	dev_dbg(&adap->dev, "Transaction (post): STS=%02x, CNT=%02x, CMD=%02x, "
+		"ADD=%02x, DAT0=%02x, DAT1=%02x\n", inb_p(SMBHSTSTS),
+		inb_p(SMBHSTCNT), inb_p(SMBHSTCMD), inb_p(SMBHSTADD),
+		inb_p(SMBHSTDAT0), inb_p(SMBHSTDAT1));
 	return result;
 }
 
 /* Return -1 on error. */
-s32 ali15x3_access(struct i2c_adapter * adap, u16 addr,
+static s32 ali15x3_access(struct i2c_adapter * adap, u16 addr,
 		   unsigned short flags, char read_write, u8 command,
 		   int size, union i2c_smbus_data * data)
 {
@@ -400,9 +350,9 @@
 	int temp;
 	int timeout;
 
-/* clear all the bits (clear-on-write) */
+	/* clear all the bits (clear-on-write) */
 	outb_p(0xFF, SMBHSTSTS);
-/* make sure SMBus is idle */
+	/* make sure SMBus is idle */
 	temp = inb_p(SMBHSTSTS);
 	for (timeout = 0;
 	     (timeout < MAX_TIMEOUT) && !(temp & ALI15X3_STS_IDLE);
@@ -411,14 +361,12 @@
 		temp = inb_p(SMBHSTSTS);
 	}
 	if (timeout >= MAX_TIMEOUT) {
-		printk("i2c-ali15x3.o: Idle wait Timeout! STS=0x%02x\n",
-		       temp);
+		dev_err(&adap->dev, "Idle wait Timeout! STS=0x%02x\n", temp);
 	}
 
 	switch (size) {
 	case I2C_SMBUS_PROC_CALL:
-		printk
-		    ("i2c-ali15x3.o: I2C_SMBUS_PROC_CALL not supported!\n");
+		dev_err(&adap->dev, "I2C_SMBUS_PROC_CALL not supported!\n");
 		return -1;
 	case I2C_SMBUS_QUICK:
 		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
@@ -465,7 +413,8 @@
 				data->block[0] = len;
 			}
 			outb_p(len, SMBHSTDAT0);
-			outb_p(inb_p(SMBHSTCNT) | ALI15X3_BLOCK_CLR, SMBHSTCNT);	/* Reset SMBBLKDAT */
+			/* Reset SMBBLKDAT */
+			outb_p(inb_p(SMBHSTCNT) | ALI15X3_BLOCK_CLR, SMBHSTCNT);
 			for (i = 1; i <= len; i++)
 				outb_p(data->block[i], SMBBLKDAT);
 		}
@@ -475,7 +424,7 @@
 
 	outb_p(size, SMBHSTCNT);	/* output command */
 
-	if (ali15x3_transaction())	/* Error in transaction */
+	if (ali15x3_transaction(adap))	/* Error in transaction */
 		return -1;
 
 	if ((read_write = I2C_SMBUS_WRITE) || (size = ALI15X3_QUICK))
@@ -497,22 +446,19 @@
 		if (len > 32)
 			len = 32;
 		data->block[0] = len;
-		outb_p(inb_p(SMBHSTCNT) | ALI15X3_BLOCK_CLR, SMBHSTCNT);	/* Reset SMBBLKDAT */
+		/* Reset SMBBLKDAT */
+		outb_p(inb_p(SMBHSTCNT) | ALI15X3_BLOCK_CLR, SMBHSTCNT);
 		for (i = 1; i <= data->block[0]; i++) {
 			data->block[i] = inb_p(SMBBLKDAT);
-#ifdef DEBUG
-			printk
-			    ("i2c-ali15x3.o: Blk: len=%d, i=%d, data=%02x\n",
-			     len, i, data->block[i]);
-#endif	/* DEBUG */
+			dev_dbg(&adap->dev, "Blk: len=%d, i=%d, data=%02x\n",
+				len, i, data->block[i]);
 		}
 		break;
 	}
 	return 0;
 }
 
-
-u32 ali15x3_func(struct i2c_adapter *adapter)
+static u32 ali15x3_func(struct i2c_adapter *adapter)
 {
 	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
 	    I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
@@ -528,29 +474,37 @@
 
 static struct i2c_adapter ali15x3_adapter = {
 	.owner		= THIS_MODULE,
-	.name		= "unset",
 	.id		= I2C_ALGO_SMBUS | I2C_HW_SMBUS_ALI15X3,
 	.algo		= &smbus_algorithm,
+	.dev		= {
+		.name	= "unset",
+	},
 };
 
-
-
 static struct pci_device_id ali15x3_ids[] __devinitdata = {
+	{
+	.vendor =	PCI_VENDOR_ID_AL,
+	.device =	PCI_DEVICE_ID_AL_M7101,
+	.subvendor =	PCI_ANY_ID,
+	.subdevice =	PCI_ANY_ID,
+	},
 	{ 0, }
 };
 
 static int __devinit ali15x3_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	if (ali15x3_setup()) {
-		printk
-		    ("i2c-ali15x3.o: ALI15X3 not detected, module not inserted.\n");
-
+	if (ali15x3_setup(dev)) {
+		dev_err(&dev->dev,
+			"ALI15X3 not detected, module not inserted.\n");
 		return -ENODEV;
 	}
 
-	sprintf(ali15x3_adapter.name, "SMBus ALI15X3 adapter at %04x",
-		ali15x3_smba);
-	i2c_add_adapter(&ali15x3_adapter);
+	/* set up the driverfs linkage to our parent device */
+	ali15x3_adapter.dev.parent = &dev->dev;
+
+	snprintf(ali15x3_adapter.dev.name, DEVICE_NAME_SIZE,
+		"SMBus ALI15X3 adapter at %04x", ali15x3_smba);
+	return i2c_add_adapter(&ali15x3_adapter);
 }
 
 static void __devexit ali15x3_remove(struct pci_dev *dev)
@@ -567,21 +521,19 @@
 
 static int __init i2c_ali15x3_init(void)
 {
-	printk("i2c-ali15x3.o version %s (%s)\n", LM_VERSION, LM_DATE);
+	printk("i2c-ali15x3.o version %s (%s)\n", I2C_VERSION, I2C_DATE);
 	return pci_module_init(&ali15x3_driver);
 }
 
-
 static void __exit i2c_ali15x3_exit(void)
 {
 	pci_unregister_driver(&ali15x3_driver);
 	release_region(ali15x3_smba, ALI15X3_SMB_IOSIZE);
 }
 
-
-
-MODULE_AUTHOR
-    ("Frodo Looijaard <frodol@dds.nl>, Philip Edelbrock <phil@netroedge.com>, and Mark D. Studebaker <mdsxyz123@yahoo.com>");
+MODULE_AUTHOR ("Frodo Looijaard <frodol@dds.nl>, "
+		"Philip Edelbrock <phil@netroedge.com>, "
+		"and Mark D. Studebaker <mdsxyz123@yahoo.com>");
 MODULE_DESCRIPTION("ALI15X3 SMBus driver");
 MODULE_LICENSE("GPL");
 
Index: kernel/busses/i2c-amd756.c
=================================RCS file: /home/cvs/lm_sensors2/kernel/busses/i2c-amd756.c,v
retrieving revision 1.25
diff -a -u -r1.25 i2c-amd756.c
--- kernel/busses/i2c-amd756.c	21 Jan 2003 20:01:27 -0000	1.25
+++ kernel/busses/i2c-amd756.c	25 Apr 2003 18:29:30 -0000
@@ -35,6 +35,9 @@
    Note: we assume there can only be one device, with one SMBus interface.
 */
 
+/* #define DEBUG 1 */
+
+#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/kernel.h>
@@ -44,46 +47,43 @@
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <asm/io.h>
-#include "version.h"
-
-#define DRV_NAME	"i2c-amd756"
 
 /* AMD756 SMBus address offsets */
-#define SMB_ADDR_OFFSET        0xE0
-#define SMB_IOSIZE             16
-#define SMB_GLOBAL_STATUS      (0x0 + amd756_ioport)
-#define SMB_GLOBAL_ENABLE      (0x2 + amd756_ioport)
-#define SMB_HOST_ADDRESS       (0x4 + amd756_ioport)
-#define SMB_HOST_DATA          (0x6 + amd756_ioport)
-#define SMB_HOST_COMMAND       (0x8 + amd756_ioport)
-#define SMB_HOST_BLOCK_DATA    (0x9 + amd756_ioport)
-#define SMB_HAS_DATA           (0xA + amd756_ioport)
-#define SMB_HAS_DEVICE_ADDRESS (0xC + amd756_ioport)
-#define SMB_HAS_HOST_ADDRESS   (0xE + amd756_ioport)
-#define SMB_SNOOP_ADDRESS      (0xF + amd756_ioport)
+#define SMB_ADDR_OFFSET		0xE0
+#define SMB_IOSIZE		16
+#define SMB_GLOBAL_STATUS	(0x0 + amd756_ioport)
+#define SMB_GLOBAL_ENABLE	(0x2 + amd756_ioport)
+#define SMB_HOST_ADDRESS	(0x4 + amd756_ioport)
+#define SMB_HOST_DATA		(0x6 + amd756_ioport)
+#define SMB_HOST_COMMAND	(0x8 + amd756_ioport)
+#define SMB_HOST_BLOCK_DATA	(0x9 + amd756_ioport)
+#define SMB_HAS_DATA		(0xA + amd756_ioport)
+#define SMB_HAS_DEVICE_ADDRESS	(0xC + amd756_ioport)
+#define SMB_HAS_HOST_ADDRESS	(0xE + amd756_ioport)
+#define SMB_SNOOP_ADDRESS	(0xF + amd756_ioport)
 
 /* PCI Address Constants */
 
 /* address of I/O space */
-#define SMBBA     0x058		/* mh */
-#define SMBBANFORCE     0x014
+#define SMBBA		0x058		/* mh */
+#define SMBBANFORCE	0x014
 
 /* general configuration */
-#define SMBGCFG   0x041		/* mh */
+#define SMBGCFG		0x041		/* mh */
 
 /* silicon revision code */
-#define SMBREV    0x008
+#define SMBREV		0x008
 
 /* Other settings */
-#define MAX_TIMEOUT 500
+#define MAX_TIMEOUT	500
 
 /* AMD756 constants */
-#define AMD756_QUICK        0x00
-#define AMD756_BYTE         0x01
-#define AMD756_BYTE_DATA    0x02
-#define AMD756_WORD_DATA    0x03
-#define AMD756_PROCESS_CALL 0x04
-#define AMD756_BLOCK_DATA   0x05
+#define AMD756_QUICK		0x00
+#define AMD756_BYTE		0x01
+#define AMD756_BYTE_DATA	0x02
+#define AMD756_WORD_DATA	0x03
+#define AMD756_PROCESS_CALL	0x04
+#define AMD756_BLOCK_DATA	0x05
 
 
 static unsigned short amd756_ioport = 0;
@@ -101,36 +101,36 @@
 	schedule_timeout(amount);
 }
 
-#define GS_ABRT_STS (1 << 0)
-#define GS_COL_STS (1 << 1)
-#define GS_PRERR_STS (1 << 2)
-#define GS_HST_STS (1 << 3)
-#define GS_HCYC_STS (1 << 4)
-#define GS_TO_STS (1 << 5)
-#define GS_SMB_STS (1 << 11)
-
-#define GS_CLEAR_STS (GS_ABRT_STS | GS_COL_STS | GS_PRERR_STS | \
-  GS_HCYC_STS | GS_TO_STS )
-
-#define GE_CYC_TYPE_MASK (7)
-#define GE_HOST_STC (1 << 3)
-#define GE_ABORT (1 << 5)
+#define GS_ABRT_STS	(1 << 0)
+#define GS_COL_STS	(1 << 1)
+#define GS_PRERR_STS	(1 << 2)
+#define GS_HST_STS	(1 << 3)
+#define GS_HCYC_STS	(1 << 4)
+#define GS_TO_STS	(1 << 5)
+#define GS_SMB_STS	(1 << 11)
+
+#define GS_CLEAR_STS	(GS_ABRT_STS | GS_COL_STS | GS_PRERR_STS | \
+			 GS_HCYC_STS | GS_TO_STS )
+
+#define GE_CYC_TYPE_MASK	(7)
+#define GE_HOST_STC		(1 << 3)
+#define GE_ABORT		(1 << 5)
 
 
-static int amd756_transaction(void)
+static int amd756_transaction(struct i2c_adapter *adap)
 {
 	int temp;
 	int result = 0;
 	int timeout = 0;
 
-	pr_debug(DRV_NAME
-	       ": Transaction (pre): GS=%04x, GE=%04x, ADD=%04x, DAT=%04x\n",
-	       inw_p(SMB_GLOBAL_STATUS), inw_p(SMB_GLOBAL_ENABLE),
-	       inw_p(SMB_HOST_ADDRESS), inb_p(SMB_HOST_DATA));
+	dev_dbg(&adap->dev, ": Transaction (pre): GS=%04x, GE=%04x, ADD=%04x, "
+		"DAT=%04x\n", inw_p(SMB_GLOBAL_STATUS),
+		inw_p(SMB_GLOBAL_ENABLE), inw_p(SMB_HOST_ADDRESS),
+		inb_p(SMB_HOST_DATA));
 
 	/* Make sure the SMBus host is ready to start transmitting */
 	if ((temp = inw_p(SMB_GLOBAL_STATUS)) & (GS_HST_STS | GS_SMB_STS)) {
-		pr_debug(DRV_NAME ": SMBus busy (%04x). Waiting... \n", temp);
+		dev_dbg(&adap->dev, ": SMBus busy (%04x). Waiting... \n", temp);
 		do {
 			amd756_do_pause(1);
 			temp = inw_p(SMB_GLOBAL_STATUS);
@@ -138,7 +138,7 @@
 		         (timeout++ < MAX_TIMEOUT));
 		/* If the SMBus is still busy, we give up */
 		if (timeout >= MAX_TIMEOUT) {
-			pr_debug(DRV_NAME ": Busy wait timeout (%04x)\n", temp);
+			dev_dbg(&adap->dev, ": Busy wait timeout (%04x)\n", temp);
 			goto abort;
 		}
 		timeout = 0;
@@ -155,46 +155,46 @@
 
 	/* If the SMBus is still busy, we give up */
 	if (timeout >= MAX_TIMEOUT) {
-		pr_debug(DRV_NAME ": Completion timeout!\n");
+		dev_dbg(&adap->dev, ": Completion timeout!\n");
 		goto abort;
 	}
 
 	if (temp & GS_PRERR_STS) {
 		result = -1;
-		pr_debug(DRV_NAME ": SMBus Protocol error (no response)!\n");
+		dev_dbg(&adap->dev, ": SMBus Protocol error (no response)!\n");
 	}
 
 	if (temp & GS_COL_STS) {
 		result = -1;
-		printk(KERN_WARNING DRV_NAME " SMBus collision!\n");
+		dev_warn(&adap->dev, " SMBus collision!\n");
 	}
 
 	if (temp & GS_TO_STS) {
 		result = -1;
-		pr_debug(DRV_NAME ": SMBus protocol timeout!\n");
+		dev_dbg(&adap->dev, ": SMBus protocol timeout!\n");
 	}
 
 	if (temp & GS_HCYC_STS)
-		pr_debug(DRV_NAME " SMBus protocol success!\n");
+		dev_dbg(&adap->dev, " SMBus protocol success!\n");
 
 	outw_p(GS_CLEAR_STS, SMB_GLOBAL_STATUS);
 
 #ifdef DEBUG
 	if (((temp = inw_p(SMB_GLOBAL_STATUS)) & GS_CLEAR_STS) != 0x00) {
-		pr_debug(DRV_NAME
-		         ": Failed reset at end of transaction (%04x)\n", temp);
+		dev_dbg(&adap->dev,
+			": Failed reset at end of transaction (%04x)\n", temp);
 	}
-
-	pr_debug(DRV_NAME
-		 ": Transaction (post): GS=%04x, GE=%04x, ADD=%04x, DAT=%04x\n",
-		 inw_p(SMB_GLOBAL_STATUS), inw_p(SMB_GLOBAL_ENABLE),
-		 inw_p(SMB_HOST_ADDRESS), inb_p(SMB_HOST_DATA));
 #endif
 
+	dev_dbg(&adap->dev,
+		": Transaction (post): GS=%04x, GE=%04x, ADD=%04x, DAT=%04x\n",
+		inw_p(SMB_GLOBAL_STATUS), inw_p(SMB_GLOBAL_ENABLE),
+		inw_p(SMB_HOST_ADDRESS), inb_p(SMB_HOST_DATA));
+
 	return result;
 
  abort:
-	printk(KERN_WARNING DRV_NAME ": Sending abort.\n");
+	dev_warn(&adap->dev, ": Sending abort.\n");
 	outw_p(inw(SMB_GLOBAL_ENABLE) | GE_ABORT, SMB_GLOBAL_ENABLE);
 	amd756_do_pause(100);
 	outw_p(GS_CLEAR_STS, SMB_GLOBAL_STATUS);
@@ -202,7 +202,6 @@
 }
 
 /* Return -1 on error. */
-
 static s32 amd756_access(struct i2c_adapter * adap, u16 addr,
 		  unsigned short flags, char read_write,
 		  u8 command, int size, union i2c_smbus_data * data)
@@ -212,7 +211,7 @@
 	/** TODO: Should I supporte the 10-bit transfers? */
 	switch (size) {
 	case I2C_SMBUS_PROC_CALL:
-		pr_debug(DRV_NAME ": I2C_SMBUS_PROC_CALL not supported!\n");
+		dev_dbg(&adap->dev, ": I2C_SMBUS_PROC_CALL not supported!\n");
 		/* TODO: Well... It is supported, I'm just not sure what to do here... */
 		return -1;
 	case I2C_SMBUS_QUICK:
@@ -267,7 +266,7 @@
 	/* How about enabling interrupts... */
 	outw_p(size & GE_CYC_TYPE_MASK, SMB_GLOBAL_ENABLE);
 
-	if (amd756_transaction())	/* Error in transaction */
+	if (amd756_transaction(adap))	/* Error in transaction */
 		return -1;
 
 	if ((read_write = I2C_SMBUS_WRITE) || (size = AMD756_QUICK))
@@ -313,9 +312,11 @@
 
 static struct i2c_adapter amd756_adapter = {
 	.owner		= THIS_MODULE,
-	.name		= "unset",
 	.id		= I2C_ALGO_SMBUS | I2C_HW_SMBUS_AMD756,
 	.algo		= &smbus_algorithm,
+	.dev		= {
+		.name	= "unset",
+	},
 };
 
 enum chiptype { AMD756, AMD766, AMD768, NFORCE };
@@ -335,7 +336,7 @@
 	u8 temp;
 	
 	if (amd756_ioport) {
-		printk(KERN_ERR DRV_NAME ": Only one device supported. "
+		dev_err(&pdev->dev, ": Only one device supported. "
 		       "(you have a strange motherboard, btw..)\n");
 		return -ENODEV;
 	}
@@ -352,8 +353,8 @@
 
 		pci_read_config_byte(pdev, SMBGCFG, &temp);
 		if ((temp & 128) = 0) {
-			printk(KERN_ERR DRV_NAME
-			       ": Error: SMBus controller I/O not enabled!\n");
+			dev_err(&pdev->dev,
+				": Error: SMBus controller I/O not enabled!\n");
 			return -ENODEV;
 		}
 
@@ -365,24 +366,25 @@
 	}
 
 	if (!request_region(amd756_ioport, SMB_IOSIZE, "amd756-smbus")) {
-		printk(KERN_ERR DRV_NAME
-		       ": SMB region 0x%x already in use!\n", amd756_ioport);
+		dev_err(&pdev->dev, ": SMB region 0x%x already in use!\n",
+			amd756_ioport);
 		return -ENODEV;
 	}
 
-#ifdef DEBUG
 	pci_read_config_byte(pdev, SMBREV, &temp);
-	printk(KERN_DEBUG DRV_NAME ": SMBREV = 0x%X\n", temp);
-	printk(KERN_DEBUG DRV_NAME ": AMD756_smba = 0x%X\n", amd756_ioport);
-#endif
+	dev_dbg(&pdev->dev, ": SMBREV = 0x%X\n", temp);
+	dev_dbg(&pdev->dev, ": AMD756_smba = 0x%X\n", amd756_ioport);
+
+	/* set up the driverfs linkage to our parent device */
+	amd756_adapter.dev.parent = &pdev->dev;
 
-	sprintf(amd756_adapter.name,
+	snprintf(amd756_adapter.dev.name, DEVICE_NAME_SIZE,
 		"SMBus AMD75x adapter at %04x", amd756_ioport);
 
 	error = i2c_add_adapter(&amd756_adapter);
 	if (error) {
-		printk(KERN_ERR DRV_NAME
-		       ": Adapter registration failed, module not inserted.\n");
+		dev_err(&pdev->dev,
+			": Adapter registration failed, module not inserted.\n");
 		goto out_err;
 	}
 
@@ -393,10 +395,10 @@
 	return error;
 }
 
-
 static void __devexit amd756_remove(struct pci_dev *dev)
 {
 	i2c_del_adapter(&amd756_adapter);
+	release_region(amd756_ioport, SMB_IOSIZE);
 }
 
 static struct pci_driver amd756_driver = {
@@ -406,22 +408,19 @@
 	.remove		= __devexit_p(amd756_remove),
 };
 
-static int __init i2c_amd756_init(void)
+static int __init amd756_init(void)
 {
-	printk(KERN_INFO "i2c-amd756.o version %s (%s)\n", LM_VERSION, LM_DATE);
 	return pci_module_init(&amd756_driver);
 }
 
-
-static void __exit i2c_amd756_exit(void)
+static void __exit amd756_exit(void)
 {
 	pci_unregister_driver(&amd756_driver);
-	release_region(amd756_ioport, SMB_IOSIZE);
 }
 
 MODULE_AUTHOR("Merlin Hughes <merlin@merlin.org>");
 MODULE_DESCRIPTION("AMD756/766/768/nVidia nForce SMBus driver");
 MODULE_LICENSE("GPL");
 
-module_init(i2c_amd756_init)
-module_exit(i2c_amd756_exit)
+module_init(amd756_init)
+module_exit(amd756_exit)
Index: kernel/busses/i2c-amd8111.c
=================================RCS file: /home/cvs/lm_sensors2/kernel/busses/i2c-amd8111.c,v
retrieving revision 1.10
diff -a -u -r1.10 i2c-amd8111.c
--- kernel/busses/i2c-amd8111.c	21 Jan 2003 20:01:27 -0000	1.10
+++ kernel/busses/i2c-amd8111.c	25 Apr 2003 18:29:30 -0000
@@ -18,11 +18,6 @@
 #include <linux/i2c.h>
 #include <linux/delay.h>
 #include <asm/io.h>
-#include "version.h"
-
-#ifndef I2C_HW_SMBUS_AMD8111
-#error Your i2c is too old - i2c-2.7.0 or greater required!
-#endif
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR ("Vojtech Pavlik <vojtech@suse.cz>");
@@ -79,7 +74,7 @@
 		udelay(1);
 
 	if (!timeout) {
-		printk(KERN_WARNING "i2c-amd8111.c: Timeout while waiting for IBF to clear\n");
+		dev_warn(&smbus->dev->dev, "Timeout while waiting for IBF to clear\n");
 		return -1;
 	}
 
@@ -94,7 +89,7 @@
 		udelay(1);
 
 	if (!timeout) {
-		printk(KERN_WARNING "i2c-amd8111.c: Timeout while waiting for OBF to set\n");
+		dev_warn(&smbus->dev->dev, "Timeout while waiting for OBF to set\n");
 		return -1;
 	}
 
@@ -261,11 +256,11 @@
 		case I2C_SMBUS_BLOCK_DATA_PEC:
 		case I2C_SMBUS_PROC_CALL_PEC:
 		case I2C_SMBUS_BLOCK_PROC_CALL_PEC:
-			printk(KERN_WARNING "i2c-amd8111.c: Unexpected software PEC transaction %d\n.", size);
+			dev_warn(&adap->dev, "Unexpected software PEC transaction %d\n.", size);
 			return -1;
 
 		default:
-			printk(KERN_WARNING "i2c-amd8111.c: Unsupported transaction %d\n", size);
+			dev_warn(&adap->dev, "Unsupported transaction %d\n", size);
 			return -1;
 	}
 
@@ -344,56 +339,60 @@
 static int __devinit amd8111_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	struct amd_smbus *smbus;
-	int error;
+	int error = -ENODEV;
 
 	if (~pci_resource_flags(dev, 0) & IORESOURCE_IO)
-		return -1;
+		return -ENODEV;
 
-	if (!(smbus = (void*)kmalloc(sizeof(struct amd_smbus), GFP_KERNEL)))
-		return -1;
+	smbus = kmalloc(sizeof(struct amd_smbus), GFP_KERNEL);
+	if (!smbus)
+		return -ENOMEM;
 	memset(smbus, 0, sizeof(struct amd_smbus));
 
-	pci_set_drvdata(dev, smbus);
 	smbus->dev = dev;
 	smbus->base = pci_resource_start(dev, 0);
 	smbus->size = pci_resource_len(dev, 0);
 
-	if (!request_region(smbus->base, smbus->size, "amd8111 SMBus 2.0")) {
-		kfree(smbus);
-		return -1;
-	}
+	if (!request_region(smbus->base, smbus->size, "amd8111 SMBus 2.0"))
+		goto out_kfree;
 
 	smbus->adapter.owner = THIS_MODULE;
-	sprintf(smbus->adapter.name, "SMBus2 AMD8111 adapter at %04x", smbus->base);
+	snprintf(smbus->adapter.dev.name, DEVICE_NAME_SIZE,
+		"SMBus2 AMD8111 adapter at %04x", smbus->base);
 	smbus->adapter.id = I2C_ALGO_SMBUS | I2C_HW_SMBUS_AMD8111;
 	smbus->adapter.algo = &smbus_algorithm;
 	smbus->adapter.algo_data = smbus;
 
+	/* set up the driverfs linkage to our parent device */
+	smbus->adapter.dev.parent = &dev->dev;
+
 	error = i2c_add_adapter(&smbus->adapter);
-	if (error) {
-		printk(KERN_WARNING "i2c-amd8111.c: Failed to register adapter.\n");
-		release_region(smbus->base, smbus->size);
-		kfree(smbus);
-		return -1;
-	}
+	if (error)
+		goto out_release_region;
 
 	pci_write_config_dword(smbus->dev, AMD_PCI_MISC, 0);
-
-	printk(KERN_INFO "i2c-amd8111.c: AMD8111 SMBus 2.0 adapter at %#x\n", smbus->base);
+	pci_set_drvdata(dev, smbus);
 	return 0;
+
+ out_release_region:
+	release_region(smbus->base, smbus->size);
+ out_kfree:
+	kfree(smbus);
+	return -1;
 }
 
 
 static void __devexit amd8111_remove(struct pci_dev *dev)
 {
-	struct amd_smbus *smbus = (void*) pci_get_drvdata(dev);
+	struct amd_smbus *smbus = pci_get_drvdata(dev);
+
 	i2c_del_adapter(&smbus->adapter);
 	release_region(smbus->base, smbus->size);
 	kfree(smbus);
 }
 
 static struct pci_driver amd8111_driver = {
-	.name		= "amd8111 smbus 2.0",
+	.name		= "amd8111 smbus 2",
 	.id_table	= amd8111_ids,
 	.probe		= amd8111_probe,
 	.remove		= __devexit_p(amd8111_remove),
@@ -401,7 +400,6 @@
 
 static int __init i2c_amd8111_init(void)
 {
-	printk(KERN_INFO "i2c-amd8111.o version %s (%s)\n", LM_VERSION, LM_DATE);
 	return pci_module_init(&amd8111_driver);
 }
 
Index: kernel/busses/i2c-i801.c
=================================RCS file: /home/cvs/lm_sensors2/kernel/busses/i2c-i801.c,v
retrieving revision 1.30
diff -a -u -r1.30 i2c-i801.c
--- kernel/busses/i2c-i801.c	23 Jan 2003 23:24:05 -0000	1.30
+++ kernel/busses/i2c-i801.c	25 Apr 2003 18:29:30 -0000
@@ -48,67 +48,49 @@
 #include <linux/init.h>
 #include <linux/i2c.h>
 #include <asm/io.h>
-#include "version.h"
-
-MODULE_LICENSE("GPL");
 
 #ifdef I2C_FUNC_SMBUS_BLOCK_DATA_PEC
 #define HAVE_PEC
 #endif
 
-#ifndef PCI_DEVICE_ID_INTEL_82801CA_SMBUS
-#define PCI_DEVICE_ID_INTEL_82801CA_SMBUS	0x2483
-#endif
-
-#ifndef PCI_DEVICE_ID_INTEL_82801DB_SMBUS
-#define PCI_DEVICE_ID_INTEL_82801DB_SMBUS	0x24C3
-#endif
-
-static int supported[] = {PCI_DEVICE_ID_INTEL_82801AA_3,
-                          PCI_DEVICE_ID_INTEL_82801AB_3,
-                          PCI_DEVICE_ID_INTEL_82801BA_2,
-			  PCI_DEVICE_ID_INTEL_82801CA_SMBUS,
-			  PCI_DEVICE_ID_INTEL_82801DB_SMBUS,
-                          0 };
-
 /* I801 SMBus address offsets */
-#define SMBHSTSTS (0 + i801_smba)
-#define SMBHSTCNT (2 + i801_smba)
-#define SMBHSTCMD (3 + i801_smba)
-#define SMBHSTADD (4 + i801_smba)
-#define SMBHSTDAT0 (5 + i801_smba)
-#define SMBHSTDAT1 (6 + i801_smba)
-#define SMBBLKDAT (7 + i801_smba)
-#define SMBPEC    (8 + i801_smba)	/* ICH4 only */
-#define SMBAUXSTS (12 + i801_smba)	/* ICH4 only */
-#define SMBAUXCTL (13 + i801_smba)	/* ICH4 only */
+#define SMBHSTSTS	(0 + i801_smba)
+#define SMBHSTCNT	(2 + i801_smba)
+#define SMBHSTCMD	(3 + i801_smba)
+#define SMBHSTADD	(4 + i801_smba)
+#define SMBHSTDAT0	(5 + i801_smba)
+#define SMBHSTDAT1	(6 + i801_smba)
+#define SMBBLKDAT	(7 + i801_smba)
+#define SMBPEC		(8 + i801_smba)	/* ICH4 only */
+#define SMBAUXSTS	(12 + i801_smba)	/* ICH4 only */
+#define SMBAUXCTL	(13 + i801_smba)	/* ICH4 only */
 
 /* PCI Address Constants */
-#define SMBBA     0x020
-#define SMBHSTCFG 0x040
-#define SMBREV    0x008
+#define SMBBA		0x020
+#define SMBHSTCFG	0x040
+#define SMBREV		0x008
 
 /* Host configuration bits for SMBHSTCFG */
-#define SMBHSTCFG_HST_EN      1
-#define SMBHSTCFG_SMB_SMI_EN  2
-#define SMBHSTCFG_I2C_EN      4
+#define SMBHSTCFG_HST_EN	1
+#define SMBHSTCFG_SMB_SMI_EN	2
+#define SMBHSTCFG_I2C_EN	4
 
 /* Other settings */
-#define MAX_TIMEOUT 100
-#define ENABLE_INT9 0	/* set to 0x01 to enable - untested */
+#define MAX_TIMEOUT		100
+#define ENABLE_INT9		0	/* set to 0x01 to enable - untested */
 
 /* I801 command constants */
-#define I801_QUICK          0x00
-#define I801_BYTE           0x04
-#define I801_BYTE_DATA      0x08
-#define I801_WORD_DATA      0x0C
-#define I801_PROC_CALL      0x10	/* later chips only, unimplemented */
-#define I801_BLOCK_DATA     0x14
-#define I801_I2C_BLOCK_DATA 0x18	/* unimplemented */
-#define I801_BLOCK_LAST     0x34
-#define I801_I2C_BLOCK_LAST 0x38	/* unimplemented */
-#define I801_START          0x40
-#define I801_PEC_EN         0x80	/* ICH4 only */
+#define I801_QUICK		0x00
+#define I801_BYTE		0x04
+#define I801_BYTE_DATA		0x08
+#define I801_WORD_DATA		0x0C
+#define I801_PROC_CALL		0x10	/* later chips only, unimplemented */
+#define I801_BLOCK_DATA		0x14
+#define I801_I2C_BLOCK_DATA	0x18	/* unimplemented */
+#define I801_BLOCK_LAST		0x34
+#define I801_I2C_BLOCK_LAST	0x38	/* unimplemented */
+#define I801_START		0x40
+#define I801_PEC_EN		0x80	/* ICH4 only */
 
 /* insmod parameters */
 
@@ -120,153 +102,109 @@
 		 "Forcibly enable the I801 at the given address. "
 		 "EXTREMELY DANGEROUS!");
 
-
-
-
-
 static void i801_do_pause(unsigned int amount);
 static int i801_transaction(void);
 static int i801_block_transaction(union i2c_smbus_data *data,
 				  char read_write, int command);
 
+static unsigned short i801_smba;
+static struct pci_dev *I801_dev;
+static int isich4;
 
-
-
-static unsigned short i801_smba = 0;
-static struct pci_dev *I801_dev = NULL;
-static int isich4 = 0;
-
-/* Detect whether a I801 can be found, and initialize it, where necessary.
-   Note the differences between kernels with the old PCI BIOS interface and
-   newer kernels with the real PCI interface. In compat.h some things are
-   defined to make the transition easier. */
-int i801_setup(void)
+static int i801_setup(struct pci_dev *dev)
 {
 	int error_return = 0;
-	int *num = supported;
 	unsigned char temp;
 
-	/* First check whether we can access PCI at all */
-	if (pci_present() = 0) {
-		printk(KERN_WARNING "i2c-i801.o: Error: No PCI-bus found!\n");
-		error_return = -ENODEV;
-		goto END;
-	}
-
-	/* Look for each chip */
 	/* Note: we keep on searching until we have found 'function 3' */
-	I801_dev = NULL;
-	do {
-		if((I801_dev = pci_find_device(PCI_VENDOR_ID_INTEL,
-					      *num, I801_dev))) {
-			if(PCI_FUNC(I801_dev->devfn) != 3)
-				continue;
-			break;
-		}
-		num++;
-	} while (*num != 0);
-
-	if (I801_dev = NULL) {
-		printk
-		    (KERN_WARNING "i2c-i801.o: Error: Can't detect I801, function 3!\n");
-		error_return = -ENODEV;
-		goto END;
-	}
-	isich4 = *num = PCI_DEVICE_ID_INTEL_82801DB_SMBUS;
+	if(PCI_FUNC(dev->devfn) != 3)
+		return -ENODEV;
+
+	I801_dev = dev;
+	if (dev->device = PCI_DEVICE_ID_INTEL_82801DB_3)
+		isich4 = 1;
+	else
+		isich4 = 0;
 
-/* Determine the address of the SMBus areas */
+	/* Determine the address of the SMBus areas */
 	if (force_addr) {
 		i801_smba = force_addr & 0xfff0;
 	} else {
 		pci_read_config_word(I801_dev, SMBBA, &i801_smba);
 		i801_smba &= 0xfff0;
 		if(i801_smba = 0) {
-			printk(KERN_ERR "i2c-i801.o: SMB base address uninitialized - upgrade BIOS or use force_addr=0xaddr\n");
+			dev_err(&dev->dev, "SMB base address uninitialized"
+				"- upgrade BIOS or use force_addr=0xaddr\n");
 			return -ENODEV;
 		}
 	}
 
-	if (check_region(i801_smba, (isich4 ? 16 : 8))) {
-		printk
-		    (KERN_ERR "i2c-i801.o: I801_smb region 0x%x already in use!\n",
-		     i801_smba);
-		error_return = -ENODEV;
+	if (!request_region(i801_smba, (isich4 ? 16 : 8), "i801-smbus")) {
+		dev_err(&dev->dev, "I801_smb region 0x%x already in use!\n",
+			i801_smba);
+		error_return = -EBUSY;
 		goto END;
 	}
 
 	pci_read_config_byte(I801_dev, SMBHSTCFG, &temp);
 	temp &= ~SMBHSTCFG_I2C_EN;	/* SMBus timing */
 	pci_write_config_byte(I801_dev, SMBHSTCFG, temp);
-/* If force_addr is set, we program the new address here. Just to make
-   sure, we disable the device first. */
+
+	/* If force_addr is set, we program the new address here. Just to make
+	   sure, we disable the device first. */
 	if (force_addr) {
 		pci_write_config_byte(I801_dev, SMBHSTCFG, temp & 0xfe);
 		pci_write_config_word(I801_dev, SMBBA, i801_smba);
 		pci_write_config_byte(I801_dev, SMBHSTCFG, temp | 0x01);
-		printk
-		    (KERN_WARNING "i2c-i801.o: WARNING: I801 SMBus interface set to new "
-		     "address %04x!\n", i801_smba);
+		dev_warn(&dev->dev, "WARNING: I801 SMBus interface set to "
+			"new address %04x!\n", i801_smba);
 	} else if ((temp & 1) = 0) {
 		pci_write_config_byte(I801_dev, SMBHSTCFG, temp | 1);
-		printk(KERN_WARNING "i2c-i801.o: enabling SMBus device\n");
+		dev_warn(&dev->dev, "enabling SMBus device\n");
 	}
 
-	request_region(i801_smba, (isich4 ? 16 : 8), "i801-smbus");
-
-#ifdef DEBUG
 	if (temp & 0x02)
-		printk
-		    (KERN_DEBUG "i2c-i801.o: I801 using Interrupt SMI# for SMBus.\n");
+		dev_dbg(&dev->dev, "I801 using Interrupt SMI# for SMBus.\n");
 	else
-		printk
-		    (KERN_DEBUG "i2c-i801.o: I801 using PCI Interrupt for SMBus.\n");
+		dev_dbg(&dev->dev, "I801 using PCI Interrupt for SMBus.\n");
 
 	pci_read_config_byte(I801_dev, SMBREV, &temp);
-	printk(KERN_DEBUG "i2c-i801.o: SMBREV = 0x%X\n", temp);
-	printk(KERN_DEBUG "i2c-i801.o: I801_smba = 0x%X\n", i801_smba);
-#endif				/* DEBUG */
+	dev_dbg(&dev->dev, "SMBREV = 0x%X\n", temp);
+	dev_dbg(&dev->dev, "I801_smba = 0x%X\n", i801_smba);
 
-      END:
+END:
 	return error_return;
 }
 
 
-void i801_do_pause(unsigned int amount)
+static void i801_do_pause(unsigned int amount)
 {
 	current->state = TASK_INTERRUPTIBLE;
 	schedule_timeout(amount);
 }
 
-int i801_transaction(void)
+static int i801_transaction(void)
 {
 	int temp;
 	int result = 0;
 	int timeout = 0;
 
-#ifdef DEBUG
-	printk
-	    (KERN_DEBUG "i2c-i801.o: Transaction (pre): CNT=%02x, CMD=%02x, ADD=%02x, DAT0=%02x, "
-	     "DAT1=%02x\n", inb_p(SMBHSTCNT), inb_p(SMBHSTCMD),
-	     inb_p(SMBHSTADD), inb_p(SMBHSTDAT0), inb_p(SMBHSTDAT1));
-#endif
+	dev_dbg(&I801_dev->dev, "Transaction (pre): CNT=%02x, CMD=%02x,"
+		"ADD=%02x, DAT0=%02x, DAT1=%02x\n", inb_p(SMBHSTCNT),
+		inb_p(SMBHSTCMD), inb_p(SMBHSTADD), inb_p(SMBHSTDAT0),
+		inb_p(SMBHSTDAT1));
 
 	/* Make sure the SMBus host is ready to start transmitting */
 	/* 0x1f = Failed, Bus_Err, Dev_Err, Intr, Host_Busy */
 	if ((temp = (0x1f & inb_p(SMBHSTSTS))) != 0x00) {
-#ifdef DEBUG
-		printk(KERN_DEBUG "i2c-i801.o: SMBus busy (%02x). Resetting... \n",
-		       temp);
-#endif
+		dev_dbg(&I801_dev->dev, "SMBus busy (%02x). Resetting... \n",
+			temp);
 		outb_p(temp, SMBHSTSTS);
 		if ((temp = (0x1f & inb_p(SMBHSTSTS))) != 0x00) {
-#ifdef DEBUG
-			printk(KERN_DEBUG "i2c-i801.o: Failed! (%02x)\n", temp);
-#endif
+			dev_dbg(&I801_dev->dev, "Failed! (%02x)\n", temp);
 			return -1;
 		} else {
-#ifdef DEBUG
-			printk(KERN_DEBUG "i2c-i801.o: Successfull!\n");
-#endif
+			dev_dbg(&I801_dev->dev, "Successfull!\n");
 		}
 	}
 
@@ -280,76 +218,64 @@
 
 	/* If the SMBus is still busy, we give up */
 	if (timeout >= MAX_TIMEOUT) {
-#ifdef DEBUG
-		printk(KERN_DEBUG "i2c-i801.o: SMBus Timeout!\n");
+		dev_dbg(&I801_dev->dev, "SMBus Timeout!\n");
 		result = -1;
-#endif
 	}
 
 	if (temp & 0x10) {
 		result = -1;
-#ifdef DEBUG
-		printk(KERN_DEBUG "i2c-i801.o: Error: Failed bus transaction\n");
-#endif
+		dev_dbg(&I801_dev->dev, "Error: Failed bus transaction\n");
 	}
 
 	if (temp & 0x08) {
 		result = -1;
-		printk
-		    (KERN_ERR "i2c-i801.o: Bus collision! SMBus may be locked until next hard\n"
-		     "reset. (sorry!)\n");
+		dev_err(&I801_dev->dev, "Bus collision! SMBus may be locked "
+			"until next hard reset. (sorry!)\n");
 		/* Clock stops and slave is stuck in mid-transmission */
 	}
 
 	if (temp & 0x04) {
 		result = -1;
-#ifdef DEBUG
-		printk(KERN_DEBUG "i2c-i801.o: Error: no response!\n");
-#endif
+		dev_dbg(&I801_dev->dev, "Error: no response!\n");
 	}
 
 	if ((inb_p(SMBHSTSTS) & 0x1f) != 0x00)
 		outb_p(inb(SMBHSTSTS), SMBHSTSTS);
 
 	if ((temp = (0x1f & inb_p(SMBHSTSTS))) != 0x00) {
-#ifdef DEBUG
-		printk
-		    (KERN_DEBUG "i2c-i801.o: Failed reset at end of transaction (%02x)\n",
-		     temp);
-#endif
+		dev_dbg(&I801_dev->dev, "Failed reset at end of transaction"
+			"(%02x)\n", temp);
 	}
-#ifdef DEBUG
-	printk
-	    (KERN_DEBUG "i2c-i801.o: Transaction (post): CNT=%02x, CMD=%02x, ADD=%02x, "
-	     "DAT0=%02x, DAT1=%02x\n", inb_p(SMBHSTCNT), inb_p(SMBHSTCMD),
-	     inb_p(SMBHSTADD), inb_p(SMBHSTDAT0), inb_p(SMBHSTDAT1));
-#endif
+	dev_dbg(&I801_dev->dev, "Transaction (post): CNT=%02x, CMD=%02x, "
+		"ADD=%02x, DAT0=%02x, DAT1=%02x\n", inb_p(SMBHSTCNT),
+		inb_p(SMBHSTCMD), inb_p(SMBHSTADD), inb_p(SMBHSTDAT0),
+		inb_p(SMBHSTDAT1));
 	return result;
 }
 
 /* All-inclusive block transaction function */
-int i801_block_transaction(union i2c_smbus_data *data, char read_write, 
-                           int command)
+static int i801_block_transaction(union i2c_smbus_data *data, char read_write,
+				  int command)
 {
 	int i, len;
 	int smbcmd;
 	int temp;
 	int result = 0;
 	int timeout;
-        unsigned char hostc, errmask;
+	unsigned char hostc, errmask;
 
-        if (command = I2C_SMBUS_I2C_BLOCK_DATA) {
-                if (read_write = I2C_SMBUS_WRITE) {
-                        /* set I2C_EN bit in configuration register */
-                        pci_read_config_byte(I801_dev, SMBHSTCFG, &hostc);
-                        pci_write_config_byte(I801_dev, SMBHSTCFG, 
-                                              hostc | SMBHSTCFG_I2C_EN);
-                } else {
-                        printk("i2c-i801.o: "
-                               "I2C_SMBUS_I2C_BLOCK_READ not supported!\n");
-                        return -1;
-                }
-        }
+	if (command = I2C_SMBUS_I2C_BLOCK_DATA) {
+		if (read_write = I2C_SMBUS_WRITE) {
+			/* set I2C_EN bit in configuration register */
+			pci_read_config_byte(I801_dev, SMBHSTCFG, &hostc);
+			pci_write_config_byte(I801_dev, SMBHSTCFG,
+					      hostc | SMBHSTCFG_I2C_EN);
+		} else {
+			dev_err(&I801_dev->dev,
+				"I2C_SMBUS_I2C_BLOCK_READ not DB!\n");
+			return -1;
+		}
+	}
 
 	if (read_write = I2C_SMBUS_WRITE) {
 		len = data->block[0];
@@ -372,60 +298,43 @@
 			smbcmd = I801_BLOCK_LAST;
 		else
 			smbcmd = I801_BLOCK_DATA;
-#if 0 /* now using HW PEC */
-		if(isich4 && command = I2C_SMBUS_BLOCK_DATA_PEC)
-			smbcmd |= I801_PEC_EN;
-#endif
 		outb_p(smbcmd | ENABLE_INT9, SMBHSTCNT);
 
-#ifdef DEBUG
-		printk
-		    (KERN_DEBUG "i2c-i801.o: Block (pre %d): CNT=%02x, CMD=%02x, ADD=%02x, "
-		     "DAT0=%02x, BLKDAT=%02x\n", i, inb_p(SMBHSTCNT),
-		     inb_p(SMBHSTCMD), inb_p(SMBHSTADD), inb_p(SMBHSTDAT0),
-		     inb_p(SMBBLKDAT));
-#endif
+		dev_dbg(&I801_dev->dev, "Block (pre %d): CNT=%02x, CMD=%02x, "
+			"ADD=%02x, DAT0=%02x, BLKDAT=%02x\n", i,
+			inb_p(SMBHSTCNT), inb_p(SMBHSTCMD), inb_p(SMBHSTADD),
+			inb_p(SMBHSTDAT0), inb_p(SMBBLKDAT));
 
 		/* Make sure the SMBus host is ready to start transmitting */
 		temp = inb_p(SMBHSTSTS);
-                if (i = 1) {
-                    /* Erronenous conditions before transaction: 
-                     * Byte_Done, Failed, Bus_Err, Dev_Err, Intr, Host_Busy */
-                    errmask=0x9f; 
-                } else {
-                    /* Erronenous conditions during transaction: 
-                     * Failed, Bus_Err, Dev_Err, Intr */
-                    errmask=0x1e; 
-                }
+		if (i = 1) {
+			/* Erronenous conditions before transaction: 
+			 * Byte_Done, Failed, Bus_Err, Dev_Err, Intr, Host_Busy */
+			errmask=0x9f; 
+		} else {
+			/* Erronenous conditions during transaction: 
+			 * Failed, Bus_Err, Dev_Err, Intr */
+			errmask=0x1e; 
+		}
 		if (temp & errmask) {
-#ifdef DEBUG
-			printk
-			    (KERN_DEBUG "i2c-i801.o: SMBus busy (%02x). Resetting... \n",
-			     temp);
-#endif
+			dev_dbg(&I801_dev->dev, "SMBus busy (%02x). "
+				"Resetting... \n", temp);
 			outb_p(temp, SMBHSTSTS);
 			if (((temp = inb_p(SMBHSTSTS)) & errmask) != 0x00) {
-				printk
-				    (KERN_ERR "i2c-i801.o: Reset failed! (%02x)\n",
-				     temp);
+				dev_err(&I801_dev->dev,
+					"Reset failed! (%02x)\n", temp);
 				result = -1;
                                 goto END;
 			}
 			if (i != 1) {
-                                result = -1;  /* if die in middle of block transaction, fail */
-                                goto END;
-                        }
+				/* if die in middle of block transaction, fail */
+				result = -1;
+				goto END;
+			}
 		}
 
-		if (i = 1) {
-#if 0 /* #ifdef HAVE_PEC (now using HW PEC) */
-			if(isich4 && command = I2C_SMBUS_BLOCK_DATA_PEC) {
-				if(read_write = I2C_SMBUS_WRITE)
-					outb_p(data->block[len + 1], SMBPEC);
-			}
-#endif
+		if (i = 1)
 			outb_p(inb(SMBHSTCNT) | I801_START, SMBHSTCNT);
-		}
 
 		/* We will always wait for a fraction of a second! */
 		timeout = 0;
@@ -439,25 +348,19 @@
 		/* If the SMBus is still busy, we give up */
 		if (timeout >= MAX_TIMEOUT) {
 			result = -1;
-#ifdef DEBUG
-			printk(KERN_DEBUG "i2c-i801.o: SMBus Timeout!\n");
-#endif
+			dev_dbg(&I801_dev->dev, "SMBus Timeout!\n");
 		}
 
 		if (temp & 0x10) {
 			result = -1;
-#ifdef DEBUG
-			printk
-			    (KERN_DEBUG "i2c-i801.o: Error: Failed bus transaction\n");
-#endif
+			dev_dbg(&I801_dev->dev,
+				"Error: Failed bus transaction\n");
 		} else if (temp & 0x08) {
 			result = -1;
-			printk(KERN_ERR "i2c-i801.o: Bus collision!\n");
+			dev_err(&I801_dev->dev, "Bus collision!\n");
 		} else if (temp & 0x04) {
 			result = -1;
-#ifdef DEBUG
-			printk(KERN_DEBUG "i2c-i801.o: Error: no response!\n");
-#endif
+			dev_dbg(&I801_dev->dev, "Error: no response!\n");
 		}
 
 		if (i = 1 && read_write = I2C_SMBUS_READ) {
@@ -469,7 +372,7 @@
 			data->block[0] = len;
 		}
 
-                /* Retrieve/store value in SMBBLKDAT */
+		/* Retrieve/store value in SMBBLKDAT */
 		if (read_write = I2C_SMBUS_READ)
 			data->block[i] = inb_p(SMBBLKDAT);
 		if (read_write = I2C_SMBUS_WRITE && i+1 <= len)
@@ -477,18 +380,15 @@
 		if ((temp & 0x9e) != 0x00)
 			outb_p(temp, SMBHSTSTS);  /* signals SMBBLKDAT ready */
 
-#ifdef DEBUG
 		if ((temp = (0x1e & inb_p(SMBHSTSTS))) != 0x00) {
-			printk
-			    (KERN_DEBUG "i2c-i801.o: Bad status (%02x) at end of transaction\n",
-			     temp);
-		}
-		printk
-		    (KERN_DEBUG "i2c-i801.o: Block (post %d): CNT=%02x, CMD=%02x, ADD=%02x, "
-		     "DAT0=%02x, BLKDAT=%02x\n", i, inb_p(SMBHSTCNT),
-		     inb_p(SMBHSTCMD), inb_p(SMBHSTADD), inb_p(SMBHSTDAT0),
-		     inb_p(SMBBLKDAT));
-#endif
+			dev_dbg(&I801_dev->dev,
+				"Bad status (%02x) at end of transaction\n",
+				temp);
+		}
+		dev_dbg(&I801_dev->dev, "Block (post %d): CNT=%02x, CMD=%02x, "
+			"ADD=%02x, DAT0=%02x, BLKDAT=%02x\n", i,
+			inb_p(SMBHSTCNT), inb_p(SMBHSTCMD), inb_p(SMBHSTADD),
+			inb_p(SMBHSTDAT0), inb_p(SMBBLKDAT));
 
 		if (result < 0)
 			goto END;
@@ -505,29 +405,24 @@
 			   && (timeout++ < MAX_TIMEOUT));
 
 		if (timeout >= MAX_TIMEOUT) {
-			printk(KERN_DEBUG "i2c-i801.o: PEC Timeout!\n");
+			dev_dbg(&I801_dev->dev, "PEC Timeout!\n");
 		}
-#if 0 /* now using HW PEC */
-		if(read_write = I2C_SMBUS_READ) {
-			data->block[len + 1] = inb_p(SMBPEC);
-		}
-#endif
 		outb_p(temp, SMBHSTSTS); 
 	}
 #endif
-        result = 0;
+	result = 0;
 END:
-        if (command = I2C_SMBUS_I2C_BLOCK_DATA) {
-                /* restore saved configuration register value */
+	if (command = I2C_SMBUS_I2C_BLOCK_DATA) {
+		/* restore saved configuration register value */
 		pci_write_config_byte(I801_dev, SMBHSTCFG, hostc);
-        }
+	}
 	return result;
 }
 
 /* Return -1 on error. */
-s32 i801_access(struct i2c_adapter * adap, u16 addr, unsigned short flags,
-		char read_write, u8 command, int size,
-		union i2c_smbus_data * data)
+static s32 i801_access(struct i2c_adapter * adap, u16 addr,
+		       unsigned short flags, char read_write, u8 command,
+		       int size, union i2c_smbus_data * data)
 {
 	int hwpec = 0;
 	int block = 0;
@@ -583,7 +478,7 @@
 		break;
 	case I2C_SMBUS_PROC_CALL:
 	default:
-		printk(KERN_ERR "i2c-i801.o: Unsupported transaction %d\n", size);
+		dev_err(&I801_dev->dev, "Unsupported transaction %d\n", size);
 		return -1;
 	}
 
@@ -629,7 +524,7 @@
 }
 
 
-u32 i801_func(struct i2c_adapter *adapter)
+static u32 i801_func(struct i2c_adapter *adapter)
 {
 	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
 	    I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
@@ -651,29 +546,62 @@
 
 static struct i2c_adapter i801_adapter = {
 	.owner		= THIS_MODULE,
-	.name		= "unset",
 	.id		= I2C_ALGO_SMBUS | I2C_HW_SMBUS_I801,
 	.algo		= &smbus_algorithm,
+	.dev		= {
+		.name	= "unset",
+	},
 };
 
-
-
 static struct pci_device_id i801_ids[] __devinitdata = {
+	{
+		.vendor =	PCI_VENDOR_ID_INTEL,
+		.device =	PCI_DEVICE_ID_INTEL_82801AA_3,
+		.subvendor =	PCI_ANY_ID,
+		.subdevice =	PCI_ANY_ID,
+	},
+	{
+		.vendor =	PCI_VENDOR_ID_INTEL,
+		.device =	PCI_DEVICE_ID_INTEL_82801AB_3,
+		.subvendor =	PCI_ANY_ID,
+		.subdevice =	PCI_ANY_ID,
+	},
+	{
+		.vendor =	PCI_VENDOR_ID_INTEL,
+		.device =	PCI_DEVICE_ID_INTEL_82801BA_2,
+		.subvendor =	PCI_ANY_ID,
+		.subdevice =	PCI_ANY_ID,
+	},
+	{
+		.vendor =	PCI_VENDOR_ID_INTEL,
+		.device =	PCI_DEVICE_ID_INTEL_82801CA_3,
+		.subvendor =	PCI_ANY_ID,
+		.subdevice =	PCI_ANY_ID,
+	},
+	{
+		.vendor =	PCI_VENDOR_ID_INTEL,
+		.device =	PCI_DEVICE_ID_INTEL_82801DB_3,
+		.subvendor =	PCI_ANY_ID,
+		.subdevice =	PCI_ANY_ID,
+	},
 	{ 0, }
 };
 
 static int __devinit i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 
-	if (i801_setup()) {
-		printk
-		    (KERN_WARNING "i2c-i801.o: I801 not detected, module not inserted.\n");
+	if (i801_setup(dev)) {
+		dev_warn(&dev->dev,
+			"I801 not detected, module not inserted.\n");
 		return -ENODEV;
 	}
 
-	sprintf(i801_adapter.name, "SMBus I801 adapter at %04x",
-		i801_smba);
-	i2c_add_adapter(&i801_adapter);
+	/* set up the driverfs linkage to our parent device */
+	i801_adapter.dev.parent = &dev->dev;
+
+	snprintf(i801_adapter.dev.name, DEVICE_NAME_SIZE,
+		"SMBus I801 adapter at %04x", i801_smba);
+	return i2c_add_adapter(&i801_adapter);
 }
 
 static void __devexit i801_remove(struct pci_dev *dev)
@@ -690,22 +618,21 @@
 
 static int __init i2c_i801_init(void)
 {
-	printk(KERN_INFO "i2c-i801.o version %s (%s)\n", LM_VERSION, LM_DATE);
+	printk(KERN_INFO "i2c-i801 version %s (%s)\n", I2C_VERSION, I2C_DATE);
 	return pci_module_init(&i801_driver);
 }
 
-
 static void __exit i2c_i801_exit(void)
 {
 	pci_unregister_driver(&i801_driver);
 	release_region(i801_smba, (isich4 ? 16 : 8));
 }
 
-
-
-MODULE_AUTHOR
-    ("Frodo Looijaard <frodol@dds.nl>, Philip Edelbrock <phil@netroedge.com>, and Mark D. Studebaker <mdsxyz123@yahoo.com>");
+MODULE_AUTHOR ("Frodo Looijaard <frodol@dds.nl>, "
+		"Philip Edelbrock <phil@netroedge.com>, "
+		"and Mark D. Studebaker <mdsxyz123@yahoo.com>");
 MODULE_DESCRIPTION("I801 SMBus driver");
+MODULE_LICENSE("GPL");
 
 module_init(i2c_i801_init);
 module_exit(i2c_i801_exit);
Index: kernel/busses/i2c-isa.c
=================================RCS file: /home/cvs/lm_sensors2/kernel/busses/i2c-isa.c,v
retrieving revision 1.26
diff -a -u -r1.26 i2c-isa.c
--- kernel/busses/i2c-isa.c	21 Jan 2003 20:01:27 -0000	1.26
+++ kernel/busses/i2c-isa.c	25 Apr 2003 18:29:30 -0000
@@ -29,7 +29,6 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/i2c.h>
-#include "version.h"
 
 /* This is the actual algorithm we define */
 static struct i2c_algorithm isa_algorithm = {
@@ -40,14 +39,15 @@
 /* There can only be one... */
 static struct i2c_adapter isa_adapter = {
 	.owner		= THIS_MODULE,
-	.name		= "ISA main adapter",
 	.id		= I2C_ALGO_ISA | I2C_HW_ISA,
 	.algo		= &isa_algorithm,
+	.dev		= {
+		.name	= "ISA main adapter",
+	},
 };
 
 static int __init i2c_isa_init(void)
 {
-	printk("i2c-isa.o version %s (%s)\n", LM_VERSION, LM_DATE);
 	return i2c_add_adapter(&isa_adapter);
 }
 
Index: kernel/busses/i2c-piix4.c
=================================RCS file: /home/cvs/lm_sensors2/kernel/busses/i2c-piix4.c,v
retrieving revision 1.53
diff -a -u -r1.53 i2c-piix4.c
--- kernel/busses/i2c-piix4.c	23 Jan 2003 23:24:05 -0000	1.53
+++ kernel/busses/i2c-piix4.c	25 Apr 2003 18:29:30 -0000
@@ -28,7 +28,8 @@
    Note: we assume there can only be one device, with one SMBus interface.
 */
 
-#include <linux/version.h>
+/* #define DEBUG 1 */
+
 #include <linux/module.h>
 #include <linux/config.h>
 #include <linux/pci.h>
@@ -40,8 +41,6 @@
 #include <linux/init.h>
 #include <linux/apm_bios.h>
 #include <asm/io.h>
-#include "version.h"
-#include "dmi_scan.h"
 
 
 struct sd {
@@ -51,50 +50,38 @@
 	const char *name;
 };
 
-/* Note: We assume all devices are identical
-         to the Intel PIIX4; we only mention it during detection.   */
-
-static struct sd supported[] = {
-	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371AB_3, 3, "PIIX4"},
-	{PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_OSB4, 0, "OSB4"},
-	{PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB5, 0, "CSB5"},
-	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82443MX_3, 3, "440MX"},
-	{PCI_VENDOR_ID_EFAR, PCI_DEVICE_ID_EFAR_SLC90E66_3, 0, "Victory66"},
-	{0, 0, 0, NULL}
-};
-
 /* PIIX4 SMBus address offsets */
-#define SMBHSTSTS (0 + piix4_smba)
-#define SMBHSLVSTS (1 + piix4_smba)
-#define SMBHSTCNT (2 + piix4_smba)
-#define SMBHSTCMD (3 + piix4_smba)
-#define SMBHSTADD (4 + piix4_smba)
-#define SMBHSTDAT0 (5 + piix4_smba)
-#define SMBHSTDAT1 (6 + piix4_smba)
-#define SMBBLKDAT (7 + piix4_smba)
-#define SMBSLVCNT (8 + piix4_smba)
-#define SMBSHDWCMD (9 + piix4_smba)
-#define SMBSLVEVT (0xA + piix4_smba)
-#define SMBSLVDAT (0xC + piix4_smba)
+#define SMBHSTSTS	(0 + piix4_smba)
+#define SMBHSLVSTS	(1 + piix4_smba)
+#define SMBHSTCNT	(2 + piix4_smba)
+#define SMBHSTCMD	(3 + piix4_smba)
+#define SMBHSTADD	(4 + piix4_smba)
+#define SMBHSTDAT0	(5 + piix4_smba)
+#define SMBHSTDAT1	(6 + piix4_smba)
+#define SMBBLKDAT	(7 + piix4_smba)
+#define SMBSLVCNT	(8 + piix4_smba)
+#define SMBSHDWCMD	(9 + piix4_smba)
+#define SMBSLVEVT	(0xA + piix4_smba)
+#define SMBSLVDAT	(0xC + piix4_smba)
 
 /* PCI Address Constants */
-#define SMBBA     0x090
-#define SMBHSTCFG 0x0D2
-#define SMBSLVC   0x0D3
-#define SMBSHDW1  0x0D4
-#define SMBSHDW2  0x0D5
-#define SMBREV    0x0D6
+#define SMBBA		0x090
+#define SMBHSTCFG	0x0D2
+#define SMBSLVC		0x0D3
+#define SMBSHDW1	0x0D4
+#define SMBSHDW2	0x0D5
+#define SMBREV		0x0D6
 
 /* Other settings */
-#define MAX_TIMEOUT 500
-#define  ENABLE_INT9 0
+#define MAX_TIMEOUT	500
+#define  ENABLE_INT9	0
 
 /* PIIX4 constants */
-#define PIIX4_QUICK      0x00
-#define PIIX4_BYTE       0x04
-#define PIIX4_BYTE_DATA  0x08
-#define PIIX4_WORD_DATA  0x0C
-#define PIIX4_BLOCK_DATA 0x14
+#define PIIX4_QUICK		0x00
+#define PIIX4_BYTE		0x04
+#define PIIX4_BYTE_DATA		0x08
+#define PIIX4_WORD_DATA		0x0C
+#define PIIX4_BLOCK_DATA	0x14
 
 /* insmod parameters */
 
@@ -117,81 +104,41 @@
 
 
 static unsigned short piix4_smba = 0;
+static struct i2c_adapter piix4_adapter;
 
-#ifdef CONFIG_X86
 /*
  * Get DMI information.
  */
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,34)
-void dmi_scan_mach(void);
-#endif
-
-static int __init ibm_dmi_probe(void)
+static int ibm_dmi_probe(void)
 {
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,34)
+#ifdef CONFIG_X86
 	extern int is_unsafe_smbus;
 	return is_unsafe_smbus;
 #else
-#define IBM_SIGNATURE		"IBM"
-	dmi_scan_mach();
-	if(dmi_ident[DMI_SYS_VENDOR] = NULL)
-		return 0;
-	if(strncmp(dmi_ident[DMI_SYS_VENDOR], IBM_SIGNATURE,
-	           strlen(IBM_SIGNATURE)) = 0)
-		return 1;
 	return 0;
 #endif
 }
-#endif
 
-/* Detect whether a PIIX4 can be found, and initialize it, where necessary.
-   Note the differences between kernels with the old PCI BIOS interface and
-   newer kernels with the real PCI interface. In compat.h some things are
-   defined to make the transition easier. */
-int piix4_setup(void)
+static int piix4_setup(struct pci_dev *PIIX4_dev, const struct pci_device_id *id)
 {
 	int error_return = 0;
 	unsigned char temp;
-	struct sd *num = supported;
-	struct pci_dev *PIIX4_dev = NULL;
 
-	if (pci_present() = 0) {
-		error_return = -ENODEV;
-		goto END;
-	}
+	/* match up the function */
+	if (PCI_FUNC(PIIX4_dev->devfn) != id->driver_data)
+		return -ENODEV;
 
-	/* Look for a supported device/function */
-	do {
-		if((PIIX4_dev = pci_find_device(num->mfr, num->dev,
-					        PIIX4_dev))) {
-			if(PCI_FUNC(PIIX4_dev->devfn) != num->fn)
-				continue;
-			break;
-		}
-		PIIX4_dev = NULL;
-		num++;
-	} while (num->mfr);
-
-	if (PIIX4_dev = NULL) {
-		printk
-		  (KERN_ERR "i2c-piix4.o: Error: Can't detect PIIX4 or compatible device!\n");
-		 error_return = -ENODEV;
-		 goto END;
-	}
-	printk(KERN_INFO "i2c-piix4.o: Found %s device\n", num->name);
+	dev_info(&PIIX4_dev->dev, "Found %s device\n", PIIX4_dev->dev.name);
 
-#ifdef CONFIG_X86
 	if(ibm_dmi_probe()) {
-		printk
-		  (KERN_ERR "i2c-piix4.o: IBM Laptop detected; this module may corrupt\n");
-		printk
-		  (KERN_ERR "             your serial eeprom! Refusing to load module!\n");
-		 error_return = -EPERM;
-		 goto END;
+		dev_err(&PIIX4_dev->dev, "IBM Laptop detected; this module "
+			"may corrupt your serial eeprom! Refusing to load "
+			"module!\n");
+		error_return = -EPERM;
+		goto END;
 	}
-#endif
 
-/* Determine the address of the SMBus areas */
+	/* Determine the address of the SMBus areas */
 	if (force_addr) {
 		piix4_smba = force_addr & 0xfff0;
 		force = 0;
@@ -199,112 +146,97 @@
 		pci_read_config_word(PIIX4_dev, SMBBA, &piix4_smba);
 		piix4_smba &= 0xfff0;
 		if(piix4_smba = 0) {
-			printk(KERN_ERR "i2c-piix4.o: SMB base address uninitialized - upgrade BIOS or use force_addr=0xaddr\n");
+			dev_err(&PIIX4_dev->dev, "SMB base address "
+				"uninitialized - upgrade BIOS or use "
+				"force_addr=0xaddr\n");
 			return -ENODEV;
 		}
 	}
 
-	if (check_region(piix4_smba, 8)) {
-		printk
-		    (KERN_ERR "i2c-piix4.o: SMB region 0x%x already in use!\n",
-		     piix4_smba);
+	if (!request_region(piix4_smba, 8, "piix4-smbus")) {
+		dev_err(&PIIX4_dev->dev, "SMB region 0x%x already in use!\n",
+			piix4_smba);
 		error_return = -ENODEV;
 		goto END;
 	}
 
 	pci_read_config_byte(PIIX4_dev, SMBHSTCFG, &temp);
-/* If force_addr is set, we program the new address here. Just to make
-   sure, we disable the PIIX4 first. */
+	/* If force_addr is set, we program the new address here. Just to make
+	   sure, we disable the PIIX4 first. */
 	if (force_addr) {
 		pci_write_config_byte(PIIX4_dev, SMBHSTCFG, temp & 0xfe);
 		pci_write_config_word(PIIX4_dev, SMBBA, piix4_smba);
 		pci_write_config_byte(PIIX4_dev, SMBHSTCFG, temp | 0x01);
-		printk
-		    (KERN_INFO "i2c-piix4.o: WARNING: SMBus interface set to new "
-		     "address %04x!\n", piix4_smba);
+		dev_info(&PIIX4_dev->dev, "WARNING: SMBus interface set to "
+			"new address %04x!\n", piix4_smba);
 	} else if ((temp & 1) = 0) {
 		if (force) {
-/* This should never need to be done, but has been noted that
-   many Dell machines have the SMBus interface on the PIIX4
-   disabled!? NOTE: This assumes I/O space and other allocations WERE
-   done by the Bios!  Don't complain if your hardware does weird 
-   things after enabling this. :') Check for Bios updates before
-   resorting to this.  */
+			/* This should never need to be done, but has been
+			 * noted that many Dell machines have the SMBus
+			 * interface on the PIIX4 disabled!? NOTE: This assumes
+			 * I/O space and other allocations WERE done by the
+			 * Bios!  Don't complain if your hardware does weird
+			 * things after enabling this. :') Check for Bios
+			 * updates before resorting to this.
+			 */
 			pci_write_config_byte(PIIX4_dev, SMBHSTCFG,
 					      temp | 1);
-			printk
-			    (KERN_NOTICE "i2c-piix4.o: WARNING: SMBus interface has been FORCEFULLY "
-			     "ENABLED!\n");
+			dev_printk(KERN_NOTICE, &PIIX4_dev->dev,
+				"WARNING: SMBus interface has been "
+				"FORCEFULLY ENABLED!\n");
 		} else {
-			printk
-			    (KERN_ERR "i2c-piix4.o: Host SMBus controller not enabled!\n");
+			dev_err(&PIIX4_dev->dev,
+				"Host SMBus controller not enabled!\n");
 			error_return = -ENODEV;
 			goto END;
 		}
 	}
 
-	/* Everything is happy, let's grab the memory and set things up. */
-	request_region(piix4_smba, 8, "piix4-smbus");
-
-#ifdef DEBUG
 	if ((temp & 0x0E) = 8)
-		printk
-		    (KERN_DEBUG "i2c-piix4.o: Using Interrupt 9 for SMBus.\n");
+		dev_dbg(&PIIX4_dev->dev, "Using Interrupt 9 for SMBus.\n");
 	else if ((temp & 0x0E) = 0)
-		printk
-		    (KERN_DEBUG "i2c-piix4.o: Using Interrupt SMI# for SMBus.\n");
+		dev_dbg(&PIIX4_dev->dev, "Using Interrupt SMI# for SMBus.\n");
 	else
-		printk
-		    (KERN_ERR "i2c-piix4.o: Illegal Interrupt configuration (or code out "
-		     "of date)!\n");
+		dev_err(&PIIX4_dev->dev, "Illegal Interrupt configuration "
+			"(or code out of date)!\n");
 
 	pci_read_config_byte(PIIX4_dev, SMBREV, &temp);
-	printk(KERN_DEBUG "i2c-piix4.o: SMBREV = 0x%X\n", temp);
-	printk(KERN_DEBUG "i2c-piix4.o: SMBA = 0x%X\n", piix4_smba);
-#endif				/* DEBUG */
+	dev_dbg(&PIIX4_dev->dev, "SMBREV = 0x%X\n", temp);
+	dev_dbg(&PIIX4_dev->dev, "SMBA = 0x%X\n", piix4_smba);
 
-      END:
+END:
 	return error_return;
 }
 
-
 /* Internally used pause function */
-void piix4_do_pause(unsigned int amount)
+static void piix4_do_pause(unsigned int amount)
 {
 	current->state = TASK_INTERRUPTIBLE;
 	schedule_timeout(amount);
 }
 
 /* Another internally used function */
-int piix4_transaction(void)
+static int piix4_transaction(void)
 {
 	int temp;
 	int result = 0;
 	int timeout = 0;
 
-#ifdef DEBUG
-	printk
-	    (KERN_DEBUG "i2c-piix4.o: Transaction (pre): CNT=%02x, CMD=%02x, ADD=%02x, DAT0=%02x, "
-	     "DAT1=%02x\n", inb_p(SMBHSTCNT), inb_p(SMBHSTCMD),
-	     inb_p(SMBHSTADD), inb_p(SMBHSTDAT0), inb_p(SMBHSTDAT1));
-#endif
+	dev_dbg(&piix4_adapter.dev, "Transaction (pre): CNT=%02x, CMD=%02x, "
+		"ADD=%02x, DAT0=%02x, DAT1=%02x\n", inb_p(SMBHSTCNT),
+		inb_p(SMBHSTCMD), inb_p(SMBHSTADD), inb_p(SMBHSTDAT0),
+		inb_p(SMBHSTDAT1));
 
 	/* Make sure the SMBus host is ready to start transmitting */
 	if ((temp = inb_p(SMBHSTSTS)) != 0x00) {
-#ifdef DEBUG
-		printk(KERN_DEBUG "i2c-piix4.o: SMBus busy (%02x). Resetting... \n",
-		       temp);
-#endif
+		dev_dbg(&piix4_adapter.dev, "SMBus busy (%02x). "
+			"Resetting... \n", temp);
 		outb_p(temp, SMBHSTSTS);
 		if ((temp = inb_p(SMBHSTSTS)) != 0x00) {
-#ifdef DEBUG
-			printk(KERN_ERR "i2c-piix4.o: Failed! (%02x)\n", temp);
-#endif
+			dev_err(&piix4_adapter.dev, "Failed! (%02x)\n", temp);
 			return -1;
 		} else {
-#ifdef DEBUG
-			printk(KERN_DEBUG "i2c-piix4.o: Successfull!\n");
-#endif
+			dev_dbg(&piix4_adapter.dev, "Successfull!\n");
 		}
 	}
 
@@ -317,55 +249,45 @@
 		temp = inb_p(SMBHSTSTS);
 	} while ((temp & 0x01) && (timeout++ < MAX_TIMEOUT));
 
-#ifdef DEBUG
 	/* If the SMBus is still busy, we give up */
 	if (timeout >= MAX_TIMEOUT) {
-		printk(KERN_ERR "i2c-piix4.o: SMBus Timeout!\n");
+		dev_err(&piix4_adapter.dev, "SMBus Timeout!\n");
 		result = -1;
 	}
-#endif
 
 	if (temp & 0x10) {
 		result = -1;
-#ifdef DEBUG
-		printk(KERN_ERR "i2c-piix4.o: Error: Failed bus transaction\n");
-#endif
+		dev_err(&piix4_adapter.dev, "Error: Failed bus transaction\n");
 	}
 
 	if (temp & 0x08) {
 		result = -1;
-		printk
-		    (KERN_ERR "i2c-piix4.o: Bus collision! SMBus may be locked until next hard\n"
-		     "reset. (sorry!)\n");
+		dev_dbg(&piix4_adapter.dev, "Bus collision! SMBus may be "
+			"locked until next hard reset. (sorry!)\n");
 		/* Clock stops and slave is stuck in mid-transmission */
 	}
 
 	if (temp & 0x04) {
 		result = -1;
-#ifdef DEBUG
-		printk(KERN_ERR "i2c-piix4.o: Error: no response!\n");
-#endif
+		dev_err(&piix4_adapter.dev, "Error: no response!\n");
 	}
 
 	if (inb_p(SMBHSTSTS) != 0x00)
 		outb_p(inb(SMBHSTSTS), SMBHSTSTS);
 
-#ifdef DEBUG
 	if ((temp = inb_p(SMBHSTSTS)) != 0x00) {
-		printk
-		    (KERN_ERR "i2c-piix4.o: Failed reset at end of transaction (%02x)\n",
-		     temp);
-	}
-	printk
-	    (KERN_DEBUG "i2c-piix4.o: Transaction (post): CNT=%02x, CMD=%02x, ADD=%02x, "
-	     "DAT0=%02x, DAT1=%02x\n", inb_p(SMBHSTCNT), inb_p(SMBHSTCMD),
-	     inb_p(SMBHSTADD), inb_p(SMBHSTDAT0), inb_p(SMBHSTDAT1));
-#endif
+		dev_err(&piix4_adapter.dev, "Failed reset at end of "
+			"transaction (%02x)\n", temp);
+	}
+	dev_dbg(&piix4_adapter.dev, "Transaction (post): CNT=%02x, CMD=%02x, "
+		"ADD=%02x, DAT0=%02x, DAT1=%02x\n", inb_p(SMBHSTCNT),
+		inb_p(SMBHSTCMD), inb_p(SMBHSTADD), inb_p(SMBHSTDAT0),
+		inb_p(SMBHSTDAT1));
 	return result;
 }
 
 /* Return -1 on error. */
-s32 piix4_access(struct i2c_adapter * adap, u16 addr,
+static s32 piix4_access(struct i2c_adapter * adap, u16 addr,
 		 unsigned short flags, char read_write,
 		 u8 command, int size, union i2c_smbus_data * data)
 {
@@ -373,8 +295,7 @@
 
 	switch (size) {
 	case I2C_SMBUS_PROC_CALL:
-		printk
-		    (KERN_ERR "i2c-piix4.o: I2C_SMBUS_PROC_CALL not supported!\n");
+		dev_err(&adap->dev, "I2C_SMBUS_PROC_CALL not supported!\n");
 		return -1;
 	case I2C_SMBUS_QUICK:
 		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
@@ -457,8 +378,7 @@
 	return 0;
 }
 
-
-u32 piix4_func(struct i2c_adapter *adapter)
+static u32 piix4_func(struct i2c_adapter *adapter)
 {
 	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
 	    I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
@@ -474,24 +394,69 @@
 
 static struct i2c_adapter piix4_adapter = {
 	.owner		= THIS_MODULE,
-	.name		= "unset",
 	.id		= I2C_ALGO_SMBUS | I2C_HW_SMBUS_PIIX4,
 	.algo		= &smbus_algorithm,
+	.dev		= {
+		.name	= "unset",
+	},
 };
 
-
-
 static struct pci_device_id piix4_ids[] __devinitdata = {
+	{
+		.vendor =	PCI_VENDOR_ID_INTEL,
+		.device =	PCI_DEVICE_ID_INTEL_82371AB_3,
+		.subvendor =	PCI_ANY_ID,
+		.subdevice =	PCI_ANY_ID,
+		.driver_data =	3
+	},
+	{
+		.vendor =	PCI_VENDOR_ID_SERVERWORKS,
+		.device =	PCI_DEVICE_ID_SERVERWORKS_OSB4,
+		.subvendor =	PCI_ANY_ID,
+		.subdevice =	PCI_ANY_ID,
+		.driver_data =	0,
+	},
+	{
+		.vendor =	PCI_VENDOR_ID_SERVERWORKS,
+		.device =	PCI_DEVICE_ID_SERVERWORKS_CSB5,
+		.subvendor =	PCI_ANY_ID,
+		.subdevice =	PCI_ANY_ID,
+		.driver_data =	0,
+	},
+	{
+		.vendor =	PCI_VENDOR_ID_INTEL,
+		.device =	PCI_DEVICE_ID_INTEL_82443MX_3,
+		.subvendor =	PCI_ANY_ID,
+		.subdevice =	PCI_ANY_ID,
+		.driver_data =	3,
+	},
+	{
+		.vendor =	PCI_VENDOR_ID_EFAR,
+		.device =	PCI_DEVICE_ID_EFAR_SLC90E66_3,
+		.subvendor =	PCI_ANY_ID,
+		.subdevice =	PCI_ANY_ID,
+		.driver_data =	0,
+	},
 	{ 0, }
 };
 
 static int __devinit piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
+	int retval;
+
+	retval = piix4_setup(dev, id);
+	if (retval)
+		return retval;
 
-	sprintf(piix4_adapter.name, "SMBus PIIX4 adapter at %04x",
-		piix4_smba);
+	/* set up the driverfs linkage to our parent device */
+	piix4_adapter.dev.parent = &dev->dev;
 
-	i2c_add_adapter(&piix4_adapter);
+	snprintf(piix4_adapter.dev.name, DEVICE_NAME_SIZE,
+		"SMBus PIIX4 adapter at %04x", piix4_smba);
+
+	retval = i2c_add_adapter(&piix4_adapter);
+
+	return retval;
 }
 
 static void __devexit piix4_remove(struct pci_dev *dev)
@@ -509,7 +474,7 @@
 
 static int __init i2c_piix4_init(void)
 {
-	printk("i2c-piix4.o version %s (%s)\n", LM_VERSION, LM_DATE);
+	printk(KERN_INFO "i2c-piix4 version %s (%s)\n", I2C_VERSION, I2C_DATE);
 	return pci_module_init(&piix4_driver);
 }
 
@@ -519,8 +484,6 @@
 	pci_unregister_driver(&piix4_driver);
 	release_region(piix4_smba, 8);
 }
-
-
 
 MODULE_AUTHOR
     ("Frodo Looijaard <frodol@dds.nl> and Philip Edelbrock <phil@netroedge.com>");
Index: kernel/busses/i2c-viapro.c
=================================RCS file: /home/cvs/lm_sensors2/kernel/busses/i2c-viapro.c,v
retrieving revision 1.27
diff -a -u -r1.27 i2c-viapro.c
--- kernel/busses/i2c-viapro.c	23 Jan 2003 23:24:05 -0000	1.27
+++ kernel/busses/i2c-viapro.c	25 Apr 2003 18:29:30 -0000
@@ -41,62 +41,42 @@
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <asm/io.h>
-#include "version.h"
 
-#define SMBBA1	    0x90
-#define SMBBA2      0x80
-#define SMBBA3      0xD0
-
-struct sd {
-	const unsigned short dev;
-	const unsigned char base;
-	const unsigned char hstcfg;
-	const char *name;
-};
-
-static struct sd supported[] = {
-	{PCI_DEVICE_ID_VIA_82C596_3, SMBBA1, 0xD2, "VT82C596A/B"},
-	{PCI_DEVICE_ID_VIA_82C596B_3, SMBBA1, 0xD2, "VT82C596B"},
-	{PCI_DEVICE_ID_VIA_82C686_4, SMBBA1, 0xD2, "VT82C686A/B"},
-	{PCI_DEVICE_ID_VIA_8233_0, SMBBA3, 0xD2, "VT8233"},
-	{0x3147, SMBBA3, 0xD2, "VT8233A"},
-	{0x3177, SMBBA3, 0xD2, "VT8233A/8235"},
-	{0x8235, SMBBA1, 0xD2, "VT8231"},
-	{0, 0, 0, NULL}
-};
-
-static struct sd *num = supported;
+#define SMBBA1	   	 0x90
+#define SMBBA2     	 0x80
+#define SMBBA3     	 0xD0
 
 /* SMBus address offsets */
-#define SMBHSTSTS (0 + vt596_smba)
-#define SMBHSLVSTS (1 + vt596_smba)
-#define SMBHSTCNT (2 + vt596_smba)
-#define SMBHSTCMD (3 + vt596_smba)
-#define SMBHSTADD (4 + vt596_smba)
-#define SMBHSTDAT0 (5 + vt596_smba)
-#define SMBHSTDAT1 (6 + vt596_smba)
-#define SMBBLKDAT (7 + vt596_smba)
-#define SMBSLVCNT (8 + vt596_smba)
-#define SMBSHDWCMD (9 + vt596_smba)
-#define SMBSLVEVT (0xA + vt596_smba)
-#define SMBSLVDAT (0xC + vt596_smba)
+static unsigned short vt596_smba;
+#define SMBHSTSTS	(vt596_smba + 0)
+#define SMBHSLVSTS	(vt596_smba + 1)
+#define SMBHSTCNT	(vt596_smba + 2)
+#define SMBHSTCMD	(vt596_smba + 3)
+#define SMBHSTADD	(vt596_smba + 4)
+#define SMBHSTDAT0	(vt596_smba + 5)
+#define SMBHSTDAT1	(vt596_smba + 6)
+#define SMBBLKDAT	(vt596_smba + 7)
+#define SMBSLVCNT	(vt596_smba + 8)
+#define SMBSHDWCMD	(vt596_smba + 9)
+#define SMBSLVEVT	(vt596_smba + 0xA)
+#define SMBSLVDAT	(vt596_smba + 0xC)
 
 /* PCI Address Constants */
 
 /* SMBus data in configuration space can be found in two places,
    We try to select the better one*/
 
-static unsigned short smb_cf_hstcfg;
+static unsigned short smb_cf_hstcfg = 0xD2;
 
 #define SMBHSTCFG   (smb_cf_hstcfg)
-#define SMBSLVC     (SMBHSTCFG+1)
-#define SMBSHDW1    (SMBHSTCFG+2)
-#define SMBSHDW2    (SMBHSTCFG+3)
-#define SMBREV      (SMBHSTCFG+4)
+#define SMBSLVC     (smb_cf_hstcfg + 1)
+#define SMBSHDW1    (smb_cf_hstcfg + 2)
+#define SMBSHDW2    (smb_cf_hstcfg + 3)
+#define SMBREV      (smb_cf_hstcfg + 4)
 
 /* Other settings */
-#define MAX_TIMEOUT 500
-#define  ENABLE_INT9 0
+#define MAX_TIMEOUT	500
+#define ENABLE_INT9	0
 
 /* VT82C596 constants */
 #define VT596_QUICK      0x00
@@ -105,177 +85,55 @@
 #define VT596_WORD_DATA  0x0C
 #define VT596_BLOCK_DATA 0x14
 
-/* insmod parameters */
 
 /* If force is set to anything different from 0, we forcibly enable the
    VT596. DANGEROUS! */
-static int force = 0;
+static int force;
 MODULE_PARM(force, "i");
 MODULE_PARM_DESC(force, "Forcibly enable the SMBus. DANGEROUS!");
 
 /* If force_addr is set to anything different from 0, we forcibly enable
    the VT596 at the given address. VERY DANGEROUS! */
-static int force_addr = 0;
+static int force_addr;
 MODULE_PARM(force_addr, "i");
 MODULE_PARM_DESC(force_addr,
 		 "Forcibly enable the SMBus at the given address. "
 		 "EXTREMELY DANGEROUS!");
 
 
-
-
-
-static void vt596_do_pause(unsigned int amount);
-static int vt596_transaction(void);
-
-
-
-static unsigned short vt596_smba = 0;
-
-
-/* Detect whether a compatible device can be found, and initialize it. */
-int vt596_setup(void)
-{
-	unsigned char temp;
-
-	struct pci_dev *VT596_dev = NULL;
-
-	/* First check whether we can access PCI at all */
-	if (pci_present() = 0)
-		return(-ENODEV);
-
-	/* Look for a supported device/function */
-	do {
-		if((VT596_dev = pci_find_device(PCI_VENDOR_ID_VIA, num->dev,
-					        VT596_dev)))
-			break;
-	} while ((++num)->dev);
-
-	if (VT596_dev = NULL)
-		return(-ENODEV);
-	printk("i2c-viapro.o: Found Via %s device\n", num->name);
-
-/* Determine the address of the SMBus areas */
-	smb_cf_hstcfg = num->hstcfg;
-	if (force_addr) {
-		vt596_smba = force_addr & 0xfff0;
-		force = 0;
-	} else {
-		if ((pci_read_config_word(VT596_dev, num->base, &vt596_smba))
-		    || !(vt596_smba & 0x1)) {
-			/* try 2nd address and config reg. for 596 */
-			if((num->dev = PCI_DEVICE_ID_VIA_82C596_3) &&
-			   (!pci_read_config_word(VT596_dev, SMBBA2, &vt596_smba)) &&
-			   (vt596_smba & 0x1)) {
-				smb_cf_hstcfg = 0x84;
-			} else {
-			        /* no matches at all */
-			        printk("i2c-viapro.o: Cannot configure SMBus "
-				       "I/O Base address\n");
-			        return(-ENODEV);
-			}
-		}
-		vt596_smba &= 0xfff0;
-		if(vt596_smba = 0) {
-			printk(KERN_ERR "i2c-viapro.o: SMBus base address"
-			   "uninitialized - upgrade BIOS or use force_addr=0xaddr\n");
-			return -ENODEV;
-		}
-	}
-
-	if (check_region(vt596_smba, 8)) {
-		printk("i2c-viapro.o: SMBus region 0x%x already in use!\n",
-		        vt596_smba);
-		return(-ENODEV);
-	}
-
-	pci_read_config_byte(VT596_dev, SMBHSTCFG, &temp);
-/* If force_addr is set, we program the new address here. Just to make
-   sure, we disable the VT596 first. */
-	if (force_addr) {
-		pci_write_config_byte(VT596_dev, SMBHSTCFG, temp & 0xfe);
-		pci_write_config_word(VT596_dev, num->base, vt596_smba);
-		pci_write_config_byte(VT596_dev, SMBHSTCFG, temp | 0x01);
-		printk
-		    ("i2c-viapro.o: WARNING: SMBus interface set to new "
-		     "address 0x%04x!\n", vt596_smba);
-	} else if ((temp & 1) = 0) {
-		if (force) {
-/* NOTE: This assumes I/O space and other allocations WERE
-   done by the Bios!  Don't complain if your hardware does weird 
-   things after enabling this. :') Check for Bios updates before
-   resorting to this.  */
-			pci_write_config_byte(VT596_dev, SMBHSTCFG,
-					      temp | 1);
-			printk
-			    ("i2c-viapro.o: enabling SMBus device\n");
-		} else {
-			printk
-			    ("SMBUS: Error: Host SMBus controller not enabled! - "
-			     "upgrade BIOS or use force=1\n");
-			return(-ENODEV);
-		}
-	}
-
-	/* Everything is happy, let's grab the memory and set things up. */
-	request_region(vt596_smba, 8, "viapro-smbus");
-
-#ifdef DEBUG
-	if ((temp & 0x0E) = 8)
-		printk("i2c-viapro.o: using Interrupt 9 for SMBus.\n");
-	else if ((temp & 0x0E) = 0)
-		printk("i2c-viapro.o: using Interrupt SMI# for SMBus.\n");
-	else
-		printk
-		    ("i2c-viapro.o: Illegal Interrupt configuration (or code out "
-		     "of date)!\n");
-
-	pci_read_config_byte(VT596_dev, SMBREV, &temp);
-	printk("i2c-viapro.o: SMBREV = 0x%X\n", temp);
-	printk("i2c-viapro.o: VT596_smba = 0x%X\n", vt596_smba);
-#endif				/* DEBUG */
-
-	return(0);
-}
-
+static struct i2c_adapter vt596_adapter;
 
 /* Internally used pause function */
-void vt596_do_pause(unsigned int amount)
+static void vt596_do_pause(unsigned int amount)
 {
 	current->state = TASK_INTERRUPTIBLE;
 	schedule_timeout(amount);
 }
 
 /* Another internally used function */
-int vt596_transaction(void)
+static int vt596_transaction(void)
 {
 	int temp;
 	int result = 0;
 	int timeout = 0;
 
-#ifdef DEBUG
-	printk
-	    ("i2c-viapro.o: Transaction (pre): CNT=%02x, CMD=%02x, ADD=%02x, DAT0=%02x, "
-	     "DAT1=%02x\n", inb_p(SMBHSTCNT), inb_p(SMBHSTCMD),
-	     inb_p(SMBHSTADD), inb_p(SMBHSTDAT0), inb_p(SMBHSTDAT1));
-#endif
+	dev_dbg(&vt596_adapter.dev, "Transaction (pre): CNT=%02x, CMD=%02x, "
+		"ADD=%02x, DAT0=%02x, DAT1=%02x\n", inb_p(SMBHSTCNT), 
+		inb_p(SMBHSTCMD), inb_p(SMBHSTADD), inb_p(SMBHSTDAT0), 
+		inb_p(SMBHSTDAT1));
 
 	/* Make sure the SMBus host is ready to start transmitting */
 	if ((temp = inb_p(SMBHSTSTS)) != 0x00) {
-#ifdef DEBUG
-		printk("i2c-viapro.o: SMBus busy (0x%02x). Resetting... \n",
-		       temp);
-#endif
+		dev_dbg(&vt596_adapter.dev, "SMBus busy (0x%02x). "
+				"Resetting...\n", temp);
+		
 		outb_p(temp, SMBHSTSTS);
 		if ((temp = inb_p(SMBHSTSTS)) != 0x00) {
-#ifdef DEBUG
-			printk("i2c-viapro.o: Failed! (0x%02x)\n", temp);
-#endif
+			dev_dbg(&vt596_adapter.dev, "Failed! (0x%02x)\n", temp);
+			
 			return -1;
 		} else {
-#ifdef DEBUG
-			printk("i2c-viapro.o: Successfull!\n");
-#endif
+			dev_dbg(&vt596_adapter.dev, "Successfull!\n");
 		}
 	}
 
@@ -291,64 +149,53 @@
 
 	/* If the SMBus is still busy, we give up */
 	if (timeout >= MAX_TIMEOUT) {
-#ifdef DEBUG
-		printk("i2c-viapro.o: SMBus Timeout!\n");
 		result = -1;
-#endif
+		dev_dbg(&vt596_adapter.dev, "SMBus Timeout!\n");
 	}
 
 	if (temp & 0x10) {
 		result = -1;
-#ifdef DEBUG
-		printk("i2c-viapro.o: Error: Failed bus transaction\n");
-#endif
+		dev_dbg(&vt596_adapter.dev, "Error: Failed bus transaction\n");
 	}
 
 	if (temp & 0x08) {
 		result = -1;
-		printk
-		    ("i2c-viapro.o: Bus collision! SMBus may be locked until next hard\n"
-		     "reset. (sorry!)\n");
+		dev_info(&vt596_adapter.dev, "Bus collision! SMBus may be "
+			"locked until next hard\nreset. (sorry!)\n");
 		/* Clock stops and slave is stuck in mid-transmission */
 	}
 
 	if (temp & 0x04) {
 		result = -1;
-#ifdef DEBUG
-		printk("i2c-viapro.o: Error: no response!\n");
-#endif
+		dev_dbg(&vt596_adapter.dev, "Error: no response!\n");
 	}
 
 	if (inb_p(SMBHSTSTS) != 0x00)
 		outb_p(inb(SMBHSTSTS), SMBHSTSTS);
 
 	if ((temp = inb_p(SMBHSTSTS)) != 0x00) {
-#ifdef DEBUG
-		printk
-		    ("i2c-viapro.o: Failed reset at end of transaction (%02x)\n",
-		     temp);
-#endif
-	}
-#ifdef DEBUG
-	printk
-	    ("i2c-viapro.o: Transaction (post): CNT=%02x, CMD=%02x, ADD=%02x, "
-	     "DAT0=%02x, DAT1=%02x\n", inb_p(SMBHSTCNT), inb_p(SMBHSTCMD),
-	     inb_p(SMBHSTADD), inb_p(SMBHSTDAT0), inb_p(SMBHSTDAT1));
-#endif
+		dev_dbg(&vt596_adapter.dev, "Failed reset at end of "
+			"transaction (%02x)\n", temp);
+	}
+	dev_dbg(&vt596_adapter.dev, "Transaction (post): CNT=%02x, CMD=%02x, "
+		"ADD=%02x, DAT0=%02x, DAT1=%02x\n", inb_p(SMBHSTCNT),
+		inb_p(SMBHSTCMD), inb_p(SMBHSTADD), inb_p(SMBHSTDAT0), 
+		inb_p(SMBHSTDAT1));
+	
 	return result;
 }
 
 /* Return -1 on error. */
-s32 vt596_access(struct i2c_adapter * adap, u16 addr, unsigned short flags,
-		 char read_write,
-		 u8 command, int size, union i2c_smbus_data * data)
+static s32 vt596_access(struct i2c_adapter *adap, u16 addr,
+		unsigned short flags,  char read_write, u8 command,
+		int size,  union i2c_smbus_data *data)
 {
 	int i, len;
 
 	switch (size) {
 	case I2C_SMBUS_PROC_CALL:
-		printk
-		    ("i2c-viapro.o: I2C_SMBUS_PROC_CALL not supported!\n");
+		dev_info(&vt596_adapter.dev,
+			 "I2C_SMBUS_PROC_CALL not supported!\n");
 		return -1;
 	case I2C_SMBUS_QUICK:
 		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
@@ -401,18 +248,18 @@
 
 	outb_p((size & 0x1C) + (ENABLE_INT9 & 1), SMBHSTCNT);
 
-	if (vt596_transaction())	/* Error in transaction */
+	if (vt596_transaction()) /* Error in transaction */
 		return -1;
 
 	if ((read_write = I2C_SMBUS_WRITE) || (size = VT596_QUICK))
 		return 0;
 
-
 	switch (size) {
-	case VT596_BYTE:	/* Where is the result put? I assume here it is in
-				   SMBHSTDAT0 but it might just as well be in the
-				   SMBHSTCMD. No clue in the docs */
-
+	case VT596_BYTE:
+		/* Where is the result put? I assume here it is in
+		 * SMBHSTDAT0 but it might just as well be in the
+		 * SMBHSTCMD. No clue in the docs 
+		 */
 		data->byte = inb_p(SMBHSTDAT0);
 		break;
 	case VT596_BYTE_DATA:
@@ -431,15 +278,13 @@
 	return 0;
 }
 
-
-u32 vt596_func(struct i2c_adapter *adapter)
+static u32 vt596_func(struct i2c_adapter *adapter)
 {
 	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
 	    I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
 	    I2C_FUNC_SMBUS_BLOCK_DATA;
 }
 
-
 static struct i2c_algorithm smbus_algorithm = {
 	.name		= "Non-I2C SMBus adapter",
 	.id		= I2C_ALGO_SMBUS,
@@ -449,36 +294,165 @@
 
 static struct i2c_adapter vt596_adapter = {
 	.owner		= THIS_MODULE,
-	.name		= "unset",
 	.id		= I2C_ALGO_SMBUS | I2C_HW_SMBUS_VIA2,
 	.algo		= &smbus_algorithm,
+	.dev		= {
+		.name	= "unset",
+	},
 };
 
-
-static struct pci_device_id vt596_ids[] __devinitdata = {
-	{ 0, }
-};
-
-static int __devinit vt596_probe(struct pci_dev *dev, const struct pci_device_id *id)
+static int __devinit vt596_probe(struct pci_dev *pdev,
+				 const struct pci_device_id *id)
 {
+	unsigned char temp;
+	int error = -ENODEV;
+	
+	/* Determine the address of the SMBus areas */
+	if (force_addr) {
+		vt596_smba = force_addr & 0xfff0;
+		force = 0;
+		goto found;
+	}
 
-	if (vt596_setup()) {
-		printk
-		    ("i2c-viapro.o: Can't detect vt82c596 or compatible device, module not inserted.\n");
+	if ((pci_read_config_word(pdev, id->driver_data, &vt596_smba)) ||
+	    !(vt596_smba & 0x1)) {
+		/* try 2nd address and config reg. for 596 */
+		if (id->device = PCI_DEVICE_ID_VIA_82C596_3 &&
+		    !pci_read_config_word(pdev, SMBBA2, &vt596_smba) &&
+		    (vt596_smba & 0x1)) {
+			smb_cf_hstcfg = 0x84;
+		} else {
+			/* no matches at all */
+			dev_err(&pdev->dev, "Cannot configure "
+				"SMBus I/O Base address\n");
+			return -ENODEV;
+		}
+	}
 
+	vt596_smba &= 0xfff0;
+	if (vt596_smba = 0) {
+		dev_err(&pdev->dev, "SMBus base address "
+			"uninitialized - upgrade BIOS or use "
+			"force_addr=0xaddr\n");
 		return -ENODEV;
 	}
 
-	sprintf(vt596_adapter.name, "SMBus Via Pro adapter at %04x",
-		vt596_smba);
-	i2c_add_adapter(&vt596_adapter);
+ found:
+	if (!request_region(vt596_smba, 8, "viapro-smbus")) {
+		dev_err(&pdev->dev, "SMBus region 0x%x already in use!\n",
+		        vt596_smba);
+		return -ENODEV;
+	}
+
+	pci_read_config_byte(pdev, SMBHSTCFG, &temp);
+	/* If force_addr is set, we program the new address here. Just to make
+	   sure, we disable the VT596 first. */
+	if (force_addr) {
+		pci_write_config_byte(pdev, SMBHSTCFG, temp & 0xfe);
+		pci_write_config_word(pdev, id->driver_data, vt596_smba);
+		pci_write_config_byte(pdev, SMBHSTCFG, temp | 0x01);
+		dev_warn(&pdev->dev, "WARNING: SMBus interface set to new "
+		     "address 0x%04x!\n", vt596_smba);
+	} else if ((temp & 1) = 0) {
+		if (force) {
+			/* NOTE: This assumes I/O space and other allocations 
+			 * WERE done by the Bios!  Don't complain if your 
+			 * hardware does weird things after enabling this. 
+			 * :') Check for Bios updates before resorting to 
+			 * this.
+			 */
+			pci_write_config_byte(pdev, SMBHSTCFG, temp | 1);
+			dev_info(&pdev->dev, "Enabling SMBus device\n");
+		} else {
+			dev_err(&pdev->dev, "SMBUS: Error: Host SMBus "
+				"controller not enabled! - upgrade BIOS or "
+				"use force=1\n");
+			goto release_region;
+		}
+	}
+
+	if ((temp & 0x0E) = 8)
+		dev_dbg(&pdev->dev, "using Interrupt 9 for SMBus.\n");
+	else if ((temp & 0x0E) = 0)
+		dev_dbg(&pdev->dev, "using Interrupt SMI# for SMBus.\n");
+	else
+		dev_dbg(&pdev->dev, "Illegal Interrupt configuration "
+			"(or code out of date)!\n");
+
+	pci_read_config_byte(pdev, SMBREV, &temp);
+	dev_dbg(&pdev->dev, "SMBREV = 0x%X\n", temp);
+	dev_dbg(&pdev->dev, "VT596_smba = 0x%X\n", vt596_smba);
+
+	vt596_adapter.dev.parent = &pdev->dev;
+	snprintf(vt596_adapter.dev.name, DEVICE_NAME_SIZE,
+			"SMBus Via Pro adapter at %04x", vt596_smba);
+	
+	return i2c_add_adapter(&vt596_adapter);
+
+ release_region:
+	release_region(vt596_smba, 8);
+	return error;
 }
 
-static void __devexit vt596_remove(struct pci_dev *dev)
+static void __devexit vt596_remove(struct pci_dev *pdev)
 {
 	i2c_del_adapter(&vt596_adapter);
+	release_region(vt596_smba, 8);
 }
 
+static struct pci_device_id vt596_ids[] __devinitdata = {
+	{
+		.vendor		= PCI_VENDOR_ID_VIA,
+		.device 	= PCI_DEVICE_ID_VIA_82C596_3,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= SMBBA1,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_VIA,
+		.device		= PCI_DEVICE_ID_VIA_82C596B_3,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= SMBBA1,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_VIA,
+		.device 	= PCI_DEVICE_ID_VIA_82C686_4,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= SMBBA1,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_VIA,
+		.device 	= PCI_DEVICE_ID_VIA_8233_0,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= SMBBA3
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_VIA,
+		.device 	= PCI_DEVICE_ID_VIA_8233A,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= SMBBA3,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_VIA,
+		.device 	= PCI_DEVICE_ID_VIA_8235,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= SMBBA3
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_VIA,
+		.device 	= PCI_DEVICE_ID_VIA_8231_4,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= SMBBA1,
+	},
+	{ 0, }
+};
+
 static struct pci_driver vt596_driver = {
 	.name		= "vt596 smbus",
 	.id_table	= vt596_ids,
@@ -488,7 +462,6 @@
 
 static int __init i2c_vt596_init(void)
 {
-	printk("i2c-viapro.o version %s (%s)\n", LM_VERSION, LM_DATE);
 	return pci_module_init(&vt596_driver);
 }
 
@@ -496,15 +469,12 @@
 static void __exit i2c_vt596_exit(void)
 {
 	pci_unregister_driver(&vt596_driver);
-	release_region(vt596_smba, 8);
 }
 
-
-
-MODULE_AUTHOR
-    ("Frodo Looijaard <frodol@dds.nl> and Philip Edelbrock <phil@netroedge.com>");
+MODULE_AUTHOR(
+    "Frodo Looijaard <frodol@dds.nl> and "
+    "Philip Edelbrock <phil@netroedge.com>");
 MODULE_DESCRIPTION("vt82c596 SMBus driver");
-
 MODULE_LICENSE("GPL");
 
 module_init(i2c_vt596_init);
Index: kernel/chips/adm1021.c
=================================RCS file: /home/cvs/lm_sensors2/kernel/chips/adm1021.c,v
retrieving revision 1.46
diff -a -u -r1.46 adm1021.c
--- kernel/chips/adm1021.c	21 Jan 2003 20:01:26 -0000	1.46
+++ kernel/chips/adm1021.c	25 Apr 2003 18:29:30 -0000
@@ -20,19 +20,31 @@
 */
 
 #include <linux/module.h>
+#include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/i2c.h>
-#include <linux/i2c-proc.h>
-#include <linux/init.h>
-#include "version.h"
+#include <linux/i2c-sensor.h>
+
+
+/* Registers */
+#define ADM1021_SYSCTL_TEMP		1200
+#define ADM1021_SYSCTL_REMOTE_TEMP	1201
+#define ADM1021_SYSCTL_DIE_CODE		1202
+#define ADM1021_SYSCTL_ALARMS		1203
+
+#define ADM1021_ALARM_TEMP_HIGH		0x40
+#define ADM1021_ALARM_TEMP_LOW		0x20
+#define ADM1021_ALARM_RTEMP_HIGH	0x10
+#define ADM1021_ALARM_RTEMP_LOW		0x08
+#define ADM1021_ALARM_RTEMP_NA		0x04
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { SENSORS_I2C_END };
+static unsigned short normal_i2c[] = { I2C_CLIENT_END };
 static unsigned short normal_i2c_range[] = { 0x18, 0x1a, 0x29, 0x2b,
-	0x4c, 0x4e, SENSORS_I2C_END
+	0x4c, 0x4e, I2C_CLIENT_END
 };
-static unsigned int normal_isa[] = { SENSORS_ISA_END };
-static unsigned int normal_isa_range[] = { SENSORS_ISA_END };
+static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
+static unsigned int normal_isa_range[] = { I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
 SENSORS_INSMOD_8(adm1021, adm1023, max1617, max1617a, thmc10, lm84, gl523sm, mc1066);
@@ -41,94 +53,87 @@
 
 /* The adm1021 registers */
 /* Read-only */
-#define ADM1021_REG_TEMP 0x00
-#define ADM1021_REG_REMOTE_TEMP 0x01
-#define ADM1021_REG_STATUS 0x02
-#define ADM1021_REG_MAN_ID 0x0FE	/* 0x41 = AMD, 0x49 = TI, 0x4D = Maxim, 0x23 = Genesys , 0x54 = Onsemi*/
-#define ADM1021_REG_DEV_ID 0x0FF	/* ADM1021 = 0x0X, ADM1023 = 0x3X */
-#define ADM1021_REG_DIE_CODE 0x0FF	/* MAX1617A */
+#define ADM1021_REG_TEMP		0x00
+#define ADM1021_REG_REMOTE_TEMP		0x01
+#define ADM1021_REG_STATUS		0x02
+#define ADM1021_REG_MAN_ID		0x0FE	/* 0x41 = AMD, 0x49 = TI, 0x4D = Maxim, 0x23 = Genesys , 0x54 = Onsemi*/
+#define ADM1021_REG_DEV_ID		0x0FF	/* ADM1021 = 0x0X, ADM1023 = 0x3X */
+#define ADM1021_REG_DIE_CODE		0x0FF	/* MAX1617A */
 /* These use different addresses for reading/writing */
-#define ADM1021_REG_CONFIG_R 0x03
-#define ADM1021_REG_CONFIG_W 0x09
-#define ADM1021_REG_CONV_RATE_R 0x04
-#define ADM1021_REG_CONV_RATE_W 0x0A
+#define ADM1021_REG_CONFIG_R		0x03
+#define ADM1021_REG_CONFIG_W		0x09
+#define ADM1021_REG_CONV_RATE_R		0x04
+#define ADM1021_REG_CONV_RATE_W		0x0A
 /* These are for the ADM1023's additional precision on the remote temp sensor */
-#define ADM1021_REG_REM_TEMP_PREC 0x010
-#define ADM1021_REG_REM_OFFSET 0x011
-#define ADM1021_REG_REM_OFFSET_PREC 0x012
-#define ADM1021_REG_REM_TOS_PREC 0x013
-#define ADM1021_REG_REM_THYST_PREC 0x014
+#define ADM1021_REG_REM_TEMP_PREC	0x010
+#define ADM1021_REG_REM_OFFSET		0x011
+#define ADM1021_REG_REM_OFFSET_PREC	0x012
+#define ADM1021_REG_REM_TOS_PREC	0x013
+#define ADM1021_REG_REM_THYST_PREC	0x014
 /* limits */
-#define ADM1021_REG_TOS_R 0x05
-#define ADM1021_REG_TOS_W 0x0B
-#define ADM1021_REG_REMOTE_TOS_R 0x07
-#define ADM1021_REG_REMOTE_TOS_W 0x0D
-#define ADM1021_REG_THYST_R 0x06
-#define ADM1021_REG_THYST_W 0x0C
-#define ADM1021_REG_REMOTE_THYST_R 0x08
-#define ADM1021_REG_REMOTE_THYST_W 0x0E
+#define ADM1021_REG_TOS_R		0x05
+#define ADM1021_REG_TOS_W		0x0B
+#define ADM1021_REG_REMOTE_TOS_R	0x07
+#define ADM1021_REG_REMOTE_TOS_W	0x0D
+#define ADM1021_REG_THYST_R		0x06
+#define ADM1021_REG_THYST_W		0x0C
+#define ADM1021_REG_REMOTE_THYST_R	0x08
+#define ADM1021_REG_REMOTE_THYST_W	0x0E
 /* write-only */
-#define ADM1021_REG_ONESHOT 0x0F
+#define ADM1021_REG_ONESHOT		0x0F
 
-#define ADM1021_ALARM_TEMP (ADM1021_ALARM_TEMP_HIGH | ADM1021_ALARM_TEMP_LOW)
-#define ADM1021_ALARM_RTEMP (ADM1021_ALARM_RTEMP_HIGH | ADM1021_ALARM_RTEMP_LOW\
-                             | ADM1021_ALARM_RTEMP_NA)
-#define ADM1021_ALARM_ALL  (ADM1021_ALARM_TEMP | ADM1021_ALARM_RTEMP)
 
 /* Conversions. Rounding and limit checking is only done on the TO_REG
    variants. Note that you should be a bit careful with which arguments
    these macros are called: arguments may be evaluated more than once.
    Fixing this is just not worth it. */
 /* Conversions  note: 1021 uses normal integer signed-byte format*/
-#define TEMP_FROM_REG(val) (val > 127 ? val-256 : val)
-#define TEMP_TO_REG(val)   (SENSORS_LIMIT((val < 0 ? val+256 : val),0,255))
+#define TEMP_FROM_REG(val)	(val > 127 ? val-256 : val)
+#define TEMP_TO_REG(val)	(SENSORS_LIMIT((val < 0 ? val+256 : val),0,255))
 
 /* Initial values */
 
-/* Note: Eventhough I left the low and high limits named os and hyst, 
+/* Note: Even though I left the low and high limits named os and hyst, 
 they don't quite work like a thermostat the way the LM75 does.  I.e., 
-a lower temp than THYST actuall triggers an alarm instead of 
+a lower temp than THYST actually triggers an alarm instead of 
 clearing it.  Weird, ey?   --Phil  */
-#define adm1021_INIT_TOS 60
-#define adm1021_INIT_THYST 20
-#define adm1021_INIT_REMOTE_TOS 60
-#define adm1021_INIT_REMOTE_THYST 20
+#define adm1021_INIT_TOS		60
+#define adm1021_INIT_THYST		20
+#define adm1021_INIT_REMOTE_TOS		60
+#define adm1021_INIT_REMOTE_THYST	20
 
 /* Each client has this additional data */
 struct adm1021_data {
-	int sysctl_id;
 	enum chips type;
 
 	struct semaphore update_lock;
 	char valid;		/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
 
-	u8 temp, temp_os, temp_hyst;	/* Register values */
-	u8 remote_temp, remote_temp_os, remote_temp_hyst, alarms, die_code;
-	u8 fail;
+	u8	temp_max;	/* Register values */
+	u8	temp_hyst;
+	u8	temp_input;
+	u8	remote_temp_max;
+	u8	remote_temp_hyst;
+	u8	remote_temp_input;
+	u8	alarms;
+	/* special values for ADM1021 only */
+	u8	die_code;
         /* Special values for ADM1023 only */
-	u8 remote_temp_prec, remote_temp_os_prec, remote_temp_hyst_prec, 
-	   remote_temp_offset, remote_temp_offset_prec;
+	u8	remote_temp_prec;
+	u8	remote_temp_os_prec;
+	u8	remote_temp_hyst_prec;
+	u8	remote_temp_offset;
+	u8	remote_temp_offset_prec;
 };
 
 static int adm1021_attach_adapter(struct i2c_adapter *adapter);
-static int adm1021_detect(struct i2c_adapter *adapter, int address,
-			  unsigned short flags, int kind);
+static int adm1021_detect(struct i2c_adapter *adapter, int address, int kind);
 static void adm1021_init_client(struct i2c_client *client);
 static int adm1021_detach_client(struct i2c_client *client);
 static int adm1021_read_value(struct i2c_client *client, u8 reg);
-static int adm1021_rd_good(u8 *val, struct i2c_client *client, u8 reg, u8 mask);
 static int adm1021_write_value(struct i2c_client *client, u8 reg,
 			       u16 value);
-static void adm1021_temp(struct i2c_client *client, int operation,
-			 int ctl_name, int *nrels_mag, long *results);
-static void adm1021_remote_temp(struct i2c_client *client, int operation,
-				int ctl_name, int *nrels_mag,
-				long *results);
-static void adm1021_alarms(struct i2c_client *client, int operation,
-			   int ctl_name, int *nrels_mag, long *results);
-static void adm1021_die_code(struct i2c_client *client, int operation,
-			     int ctl_name, int *nrels_mag, long *results);
 static void adm1021_update_client(struct i2c_client *client);
 
 /* (amalysh) read only mode, otherwise any limit's writing confuse BIOS */
@@ -138,67 +143,70 @@
 /* This is the driver that will be inserted */
 static struct i2c_driver adm1021_driver = {
 	.owner		= THIS_MODULE,
-	.name		= "ADM1021, MAX1617 sensor driver",
+	.name		= "ADM1021-MAX1617",
 	.id		= I2C_DRIVERID_ADM1021,
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= adm1021_attach_adapter,
 	.detach_client	= adm1021_detach_client,
 };
 
-/* -- SENSORS SYSCTL START -- */
-
-#define ADM1021_SYSCTL_TEMP 1200
-#define ADM1021_SYSCTL_REMOTE_TEMP 1201
-#define ADM1021_SYSCTL_DIE_CODE 1202
-#define ADM1021_SYSCTL_ALARMS 1203
-
-#define ADM1021_ALARM_TEMP_HIGH 0x40
-#define ADM1021_ALARM_TEMP_LOW 0x20
-#define ADM1021_ALARM_RTEMP_HIGH 0x10
-#define ADM1021_ALARM_RTEMP_LOW 0x08
-#define ADM1021_ALARM_RTEMP_NA 0x04
-
-/* -- SENSORS SYSCTL END -- */
-
-/* These files are created for each detected adm1021. This is just a template;
-   though at first sight, you might think we could use a statically
-   allocated list, we need some way to get back to the parent - which
-   is done through one of the 'extra' fields which are initialized
-   when a new copy is allocated. */
-static ctl_table adm1021_dir_table_template[] = {
-	{ADM1021_SYSCTL_TEMP, "temp1", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &adm1021_temp},
-	{ADM1021_SYSCTL_REMOTE_TEMP, "temp2", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &adm1021_remote_temp},
-	{ADM1021_SYSCTL_DIE_CODE, "die_code", NULL, 0, 0444, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &adm1021_die_code},
-	{ADM1021_SYSCTL_ALARMS, "alarms", NULL, 0, 0444, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &adm1021_alarms},
-	{0}
-};
-
-static ctl_table adm1021_max_dir_table_template[] = {
-	{ADM1021_SYSCTL_TEMP, "temp1", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &adm1021_temp},
-	{ADM1021_SYSCTL_REMOTE_TEMP, "temp2", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &adm1021_remote_temp},
-	{ADM1021_SYSCTL_ALARMS, "alarms", NULL, 0, 0444, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &adm1021_alarms},
-	{0}
-};
-
 /* I choose here for semi-static allocation. Complete dynamic
    allocation could also be used; the code needed for this would probably
    take more memory than the datastructure takes now. */
 static int adm1021_id = 0;
 
+#define show(value)	\
+static ssize_t show_##value(struct device *dev, char *buf)	\
+{								\
+	struct i2c_client *client = to_i2c_client(dev);		\
+	struct adm1021_data *data = i2c_get_clientdata(client);	\
+	int temp;						\
+								\
+	adm1021_update_client(client);				\
+	temp = TEMP_FROM_REG(data->value);			\
+	return sprintf(buf, "%d\n", temp);			\
+}
+show(temp_max);
+show(temp_hyst);
+show(temp_input);
+show(remote_temp_max);
+show(remote_temp_hyst);
+show(remote_temp_input);
+show(alarms);
+show(die_code);
+
+#define set(value, reg)	\
+static ssize_t set_##value(struct device *dev, const char *buf, size_t count)	\
+{								\
+	struct i2c_client *client = to_i2c_client(dev);		\
+	struct adm1021_data *data = i2c_get_clientdata(client);	\
+	int temp = simple_strtoul(buf, NULL, 10);		\
+								\
+	data->value = TEMP_TO_REG(temp);			\
+	adm1021_write_value(client, reg, data->value);		\
+	return count;						\
+}
+set(temp_max, ADM1021_REG_TOS_W);
+set(temp_hyst, ADM1021_REG_THYST_W);
+set(remote_temp_max, ADM1021_REG_REMOTE_TOS_W);
+set(remote_temp_hyst, ADM1021_REG_REMOTE_THYST_W);
+
+static DEVICE_ATTR(temp_max1, S_IWUSR | S_IRUGO, show_temp_max, set_temp_max);
+static DEVICE_ATTR(temp_min1, S_IWUSR | S_IRUGO, show_temp_hyst, set_temp_hyst);
+static DEVICE_ATTR(temp_input1, S_IRUGO, show_temp_input, NULL);
+static DEVICE_ATTR(temp_max2, S_IWUSR | S_IRUGO, show_remote_temp_max, set_remote_temp_max);
+static DEVICE_ATTR(temp_min2, S_IWUSR | S_IRUGO, show_remote_temp_hyst, set_remote_temp_hyst);
+static DEVICE_ATTR(temp_input2, S_IRUGO, show_remote_temp_input, NULL);
+static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
+static DEVICE_ATTR(die_code, S_IRUGO, show_die_code, NULL);
+
+
 static int adm1021_attach_adapter(struct i2c_adapter *adapter)
 {
 	return i2c_detect(adapter, &addr_data, adm1021_detect);
 }
 
-static int adm1021_detect(struct i2c_adapter *adapter, int address,
-			  unsigned short flags, int kind)
+static int adm1021_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	int i;
 	struct i2c_client *new_client;
@@ -211,8 +219,7 @@
 	   at this moment; i2c_detect really won't call us. */
 #ifdef DEBUG
 	if (i2c_is_isa_adapter(adapter)) {
-		printk
-		    ("adm1021.o: adm1021_detect called for an ISA bus adapter?!?\n");
+		dev_dbg(&adapter->dev, "adm1021_detect called for an ISA bus adapter?!?\n");
 		return 0;
 	}
 #endif
@@ -230,44 +237,39 @@
 		err = -ENOMEM;
 		goto error0;
 	}
+	memset(new_client, 0x00, sizeof(struct i2c_client) +
+				 sizeof(struct adm1021_data));
 
 	data = (struct adm1021_data *) (new_client + 1);
+	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
-	new_client->data = data;
 	new_client->adapter = adapter;
 	new_client->driver = &adm1021_driver;
 	new_client->flags = 0;
 
 	/* Now, we do the remaining detection. */
-
 	if (kind < 0) {
-		if (
-		    (adm1021_read_value(new_client, ADM1021_REG_STATUS) &
-		     0x03) != 0x00)
+		if ((adm1021_read_value(new_client, ADM1021_REG_STATUS) & 0x03) != 0x00)
 			goto error1;
 	}
 
 	/* Determine the chip type. */
-
 	if (kind <= 0) {
 		i = adm1021_read_value(new_client, ADM1021_REG_MAN_ID);
 		if (i = 0x41)
-		  if ((adm1021_read_value (new_client, ADM1021_REG_DEV_ID) & 0x0F0) = 0x030)
-			kind = adm1023;
-		  else
-			kind = adm1021;
+			if ((adm1021_read_value(new_client, ADM1021_REG_DEV_ID) & 0x0F0) = 0x030)
+				kind = adm1023;
+			else
+				kind = adm1021;
 		else if (i = 0x49)
 			kind = thmc10;
 		else if (i = 0x23)
 			kind = gl523sm;
 		else if ((i = 0x4d) &&
-			 (adm1021_read_value
-			  (new_client, ADM1021_REG_DEV_ID) = 0x01))
+			 (adm1021_read_value(new_client, ADM1021_REG_DEV_ID) = 0x01))
 			kind = max1617a;
 		/* LM84 Mfr ID in a different place */
-		else
-		    if (adm1021_read_value
-			(new_client, ADM1021_REG_CONV_RATE_R) = 0x00)
+		else if (adm1021_read_value(new_client, ADM1021_REG_CONV_RATE_R) = 0x00)
 			kind = lm84;
 		else if (i = 0x54)
 			kind = mc1066;
@@ -300,15 +302,13 @@
 		type_name = "mc1066";
 		client_name = "MC1066 chip";
 	} else {
-#ifdef DEBUG
-		printk("adm1021.o: Internal error: unknown kind (%d)?!?",
-		       kind);
-#endif
+		dev_err(&adapter->dev, "Internal error: unknown kind (%d)?!?",
+			kind);
 		goto error1;
 	}
 
 	/* Fill in the remaining client fields and put it into the global list */
-	strcpy(new_client->name, client_name);
+	strncpy(new_client->dev.name, client_name, DEVICE_NAME_SIZE);
 	data->type = kind;
 
 	new_client->id = adm1021_id++;
@@ -319,25 +319,24 @@
 	if ((err = i2c_attach_client(new_client)))
 		goto error3;
 
-	/* Register a new directory entry with module sensors */
-	if ((i = i2c_register_entry(new_client,	type_name,
-					data->type = adm1021 ? adm1021_dir_table_template :
-					adm1021_max_dir_table_template)) < 0) {
-		err = i;
-		goto error4;
-	}
-	data->sysctl_id = i;
+	device_create_file(&new_client->dev, &dev_attr_temp_max1);
+	device_create_file(&new_client->dev, &dev_attr_temp_min1);
+	device_create_file(&new_client->dev, &dev_attr_temp_input1);
+	device_create_file(&new_client->dev, &dev_attr_temp_max2);
+	device_create_file(&new_client->dev, &dev_attr_temp_min2);
+	device_create_file(&new_client->dev, &dev_attr_temp_input2);
+	device_create_file(&new_client->dev, &dev_attr_alarms);
+	if (data->type = adm1021)
+		device_create_file(&new_client->dev, &dev_attr_die_code);
 
 	/* Initialize the ADM1021 chip */
 	adm1021_init_client(new_client);
 	return 0;
 
-      error4:
-	i2c_detach_client(new_client);
-      error3:
-      error1:
+error3:
+error1:
 	kfree(new_client);
-      error0:
+error0:
 	return err;
 }
 
@@ -360,104 +359,55 @@
 
 static int adm1021_detach_client(struct i2c_client *client)
 {
-
 	int err;
 
-	i2c_deregister_entry(((struct adm1021_data *) (client->data))->
-				 sysctl_id);
-
 	if ((err = i2c_detach_client(client))) {
-		printk
-		    ("adm1021.o: Client deregistration failed, client not detached.\n");
+		dev_err(&client->dev, "Client deregistration failed, client not detached.\n");
 		return err;
 	}
 
 	kfree(client);
-
 	return 0;
-
 }
 
-
 /* All registers are byte-sized */
 static int adm1021_read_value(struct i2c_client *client, u8 reg)
 {
 	return i2c_smbus_read_byte_data(client, reg);
 }
 
-/* only update value if read succeeded; set fail bit if failed */
-static int adm1021_rd_good(u8 *val, struct i2c_client *client, u8 reg, u8 mask)
-{
-	int i;
-	struct adm1021_data *data = client->data;
-
-	i = i2c_smbus_read_byte_data(client, reg);
-	if (i < 0) {
-		data->fail |= mask;
-		return i;
-	}
-	*val = i;
-	return 0;
-}
-
 static int adm1021_write_value(struct i2c_client *client, u8 reg, u16 value)
 {
-	if (read_only > 0)
-		return 0;
-
-	return i2c_smbus_write_byte_data(client, reg, value);
+	if (!read_only)
+		return i2c_smbus_write_byte_data(client, reg, value);
+	return 0;
 }
 
 static void adm1021_update_client(struct i2c_client *client)
 {
-	struct adm1021_data *data = client->data;
+	struct adm1021_data *data = i2c_get_clientdata(client);
 
 	down(&data->update_lock);
 
 	if ((jiffies - data->last_updated > HZ + HZ / 2) ||
 	    (jiffies < data->last_updated) || !data->valid) {
+		dev_dbg(&client->dev, "Starting adm1021 update\n");
 
-#ifdef DEBUG
-		printk("Starting adm1021 update\n");
-#endif
-
-		data->fail = 0;
-		adm1021_rd_good(&(data->temp), client, ADM1021_REG_TEMP,
-		                ADM1021_ALARM_TEMP);
-		adm1021_rd_good(&(data->temp_os), client, ADM1021_REG_TOS_R,
-		                ADM1021_ALARM_TEMP);
-		adm1021_rd_good(&(data->temp_hyst), client,
-		                ADM1021_REG_THYST_R, ADM1021_ALARM_TEMP);
-		adm1021_rd_good(&(data->remote_temp), client,
-		                ADM1021_REG_REMOTE_TEMP, ADM1021_ALARM_RTEMP);
-		adm1021_rd_good(&(data->remote_temp_os), client,
-		                ADM1021_REG_REMOTE_TOS_R, ADM1021_ALARM_RTEMP);
-		adm1021_rd_good(&(data->remote_temp_hyst), client,
-		                ADM1021_REG_REMOTE_THYST_R,
-		                ADM1021_ALARM_RTEMP);
-		data->alarms = ADM1021_ALARM_ALL;
-		if (!adm1021_rd_good(&(data->alarms), client,
-		                     ADM1021_REG_STATUS, 0))
-			data->alarms &= ADM1021_ALARM_ALL;
+		data->temp_input = adm1021_read_value(client, ADM1021_REG_TEMP);
+		data->temp_max = adm1021_read_value(client, ADM1021_REG_TOS_R);
+		data->temp_hyst = adm1021_read_value(client, ADM1021_REG_THYST_R);
+		data->remote_temp_input = adm1021_read_value(client, ADM1021_REG_REMOTE_TEMP);
+		data->remote_temp_max = adm1021_read_value(client, ADM1021_REG_REMOTE_TOS_R);
+		data->remote_temp_hyst = adm1021_read_value(client, ADM1021_REG_REMOTE_THYST_R);
+		data->alarms = adm1021_read_value(client, ADM1021_REG_STATUS) & 0xec;
 		if (data->type = adm1021)
-			adm1021_rd_good(&(data->die_code), client,
-			                ADM1021_REG_DIE_CODE, 0);
+			data->die_code = adm1021_read_value(client, ADM1021_REG_DIE_CODE);
 		if (data->type = adm1023) {
-			adm1021_rd_good(&(data->remote_temp_prec), client,
-			                ADM1021_REG_REM_TEMP_PREC,
-			                ADM1021_ALARM_TEMP);
-			adm1021_rd_good(&(data->remote_temp_os_prec), client,
-			                ADM1021_REG_REM_TOS_PREC,
-			                ADM1021_ALARM_RTEMP);
-			adm1021_rd_good(&(data->remote_temp_hyst_prec), client,
-			                ADM1021_REG_REM_THYST_PREC,
-			                ADM1021_ALARM_RTEMP);
-			adm1021_rd_good(&(data->remote_temp_offset), client,
-			                ADM1021_REG_REM_OFFSET,
-			                ADM1021_ALARM_RTEMP);
-			adm1021_rd_good(&(data->remote_temp_offset_prec),
-			                client, ADM1021_REG_REM_OFFSET_PREC,
-			                ADM1021_ALARM_RTEMP);
+			data->remote_temp_prec = adm1021_read_value(client, ADM1021_REG_REM_TEMP_PREC);
+			data->remote_temp_os_prec = adm1021_read_value(client, ADM1021_REG_REM_TOS_PREC);
+			data->remote_temp_hyst_prec = adm1021_read_value(client, ADM1021_REG_REM_THYST_PREC);
+			data->remote_temp_offset = adm1021_read_value(client, ADM1021_REG_REM_OFFSET);
+			data->remote_temp_offset_prec = adm1021_read_value(client, ADM1021_REG_REM_OFFSET_PREC);
 		}
 		data->last_updated = jiffies;
 		data->valid = 1;
@@ -466,154 +416,23 @@
 	up(&data->update_lock);
 }
 
-
-void adm1021_temp(struct i2c_client *client, int operation, int ctl_name,
-		  int *nrels_mag, long *results)
-{
-	struct adm1021_data *data = client->data;
-	if (operation = SENSORS_PROC_REAL_INFO)
-		*nrels_mag = 0;
-	else if (operation = SENSORS_PROC_REAL_READ) {
-		adm1021_update_client(client);
-		results[0] = TEMP_FROM_REG(data->temp_os);
-		results[1] = TEMP_FROM_REG(data->temp_hyst);
-		results[2] = TEMP_FROM_REG(data->temp);
-		*nrels_mag = 3;
-	} else if (operation = SENSORS_PROC_REAL_WRITE) {
-		if (*nrels_mag >= 1) {
-			data->temp_os = TEMP_TO_REG(results[0]);
-			adm1021_write_value(client, ADM1021_REG_TOS_W,
-					    data->temp_os);
-		}
-		if (*nrels_mag >= 2) {
-			data->temp_hyst = TEMP_TO_REG(results[1]);
-			adm1021_write_value(client, ADM1021_REG_THYST_W,
-					    data->temp_hyst);
-		}
-	}
-}
-
-void adm1021_remote_temp(struct i2c_client *client, int operation,
-			 int ctl_name, int *nrels_mag, long *results)
-{
-	struct adm1021_data *data = client->data;
-	int prec = 0;
-
-	if (operation = SENSORS_PROC_REAL_INFO)
-		if (data->type = adm1023) { *nrels_mag = 3; }
-                 else { *nrels_mag = 0; }
-	else if (operation = SENSORS_PROC_REAL_READ) {
-		adm1021_update_client(client);
-		results[0] = TEMP_FROM_REG(data->remote_temp_os);
-		results[1] = TEMP_FROM_REG(data->remote_temp_hyst);
-		results[2] = TEMP_FROM_REG(data->remote_temp);
-		if (data->type = adm1023) {
-		  results[0]=results[0]*1000 + 
-		   ((data->remote_temp_os_prec >> 5) * 125);
-		  results[1]=results[1]*1000 + 
-		   ((data->remote_temp_hyst_prec >> 5) * 125);
-		  results[2]=(TEMP_FROM_REG(data->remote_temp_offset)*1000) + 
-                   ((data->remote_temp_offset_prec >> 5) * 125);
-		  results[3]=TEMP_FROM_REG(data->remote_temp)*1000 + 
-		   ((data->remote_temp_prec >> 5) * 125);
- 		  *nrels_mag = 4;
-		} else {
- 		  *nrels_mag = 3;
-		}
-	} else if (operation = SENSORS_PROC_REAL_WRITE) {
-		if (*nrels_mag >= 1) {
-			if (data->type = adm1023) {
-			  prec=((results[0]-((results[0]/1000)*1000))/125)<<5;
-			  adm1021_write_value(client,
-                                            ADM1021_REG_REM_TOS_PREC,
-                                            prec);
-			  results[0]=results[0]/1000;
-			  data->remote_temp_os_prec=prec;
-			}
-			data->remote_temp_os = TEMP_TO_REG(results[0]);
-			adm1021_write_value(client,
-					    ADM1021_REG_REMOTE_TOS_W,
-					    data->remote_temp_os);
-		}
-		if (*nrels_mag >= 2) {
-			if (data->type = adm1023) {
-			  prec=((results[1]-((results[1]/1000)*1000))/125)<<5;
-			  adm1021_write_value(client,
-                                            ADM1021_REG_REM_THYST_PREC,
-                                            prec);
-			  results[1]=results[1]/1000;
-			  data->remote_temp_hyst_prec=prec;
-			}
-			data->remote_temp_hyst = TEMP_TO_REG(results[1]);
-			adm1021_write_value(client,
-					    ADM1021_REG_REMOTE_THYST_W,
-					    data->remote_temp_hyst);
-		}
-		if (*nrels_mag >= 3) {
-			if (data->type = adm1023) {
-			  prec=((results[2]-((results[2]/1000)*1000))/125)<<5;
-			  adm1021_write_value(client,
-                                            ADM1021_REG_REM_OFFSET_PREC,
-                                            prec);
-			  results[2]=results[2]/1000;
-			  data->remote_temp_offset_prec=prec;
-			  data->remote_temp_offset=results[2];
-			  adm1021_write_value(client,
-                                            ADM1021_REG_REM_OFFSET,
-                                            data->remote_temp_offset);
-			}
-		}
-	}
-}
-
-void adm1021_die_code(struct i2c_client *client, int operation,
-		      int ctl_name, int *nrels_mag, long *results)
-{
-	struct adm1021_data *data = client->data;
-	if (operation = SENSORS_PROC_REAL_INFO)
-		*nrels_mag = 0;
-	else if (operation = SENSORS_PROC_REAL_READ) {
-		adm1021_update_client(client);
-		results[0] = data->die_code;
-		*nrels_mag = 1;
-	} else if (operation = SENSORS_PROC_REAL_WRITE) {
-		/* Can't write to it */
-	}
-}
-
-void adm1021_alarms(struct i2c_client *client, int operation, int ctl_name,
-		    int *nrels_mag, long *results)
-{
-	struct adm1021_data *data = client->data;
-	if (operation = SENSORS_PROC_REAL_INFO)
-		*nrels_mag = 0;
-	else if (operation = SENSORS_PROC_REAL_READ) {
-		adm1021_update_client(client);
-		results[0] = data->alarms | data->fail;
-		*nrels_mag = 1;
-	} else if (operation = SENSORS_PROC_REAL_WRITE) {
-		/* Can't write to it */
-	}
-}
-
-static int __init sm_adm1021_init(void)
+static int __init sensors_adm1021_init(void)
 {
-	printk(KERN_INFO "adm1021.o version %s (%s)\n", LM_VERSION, LM_DATE);
 	return i2c_add_driver(&adm1021_driver);
 }
 
-static void __exit sm_adm1021_exit(void)
+static void __exit sensors_adm1021_exit(void)
 {
 	i2c_del_driver(&adm1021_driver);
 }
 
-MODULE_AUTHOR
-    ("Frodo Looijaard <frodol@dds.nl> and Philip Edelbrock <phil@netroedge.com>");
+MODULE_AUTHOR ("Frodo Looijaard <frodol@dds.nl> and "
+		"Philip Edelbrock <phil@netroedge.com>");
 MODULE_DESCRIPTION("adm1021 driver");
 MODULE_LICENSE("GPL");
 
 MODULE_PARM(read_only, "i");
 MODULE_PARM_DESC(read_only, "Don't set any values, read only mode");
 
-module_init(sm_adm1021_init)
-module_exit(sm_adm1021_exit)
+module_init(sensors_adm1021_init)
+module_exit(sensors_adm1021_exit)
Index: kernel/chips/it87.c
=================================RCS file: /home/cvs/lm_sensors2/kernel/chips/it87.c,v
retrieving revision 1.9
diff -a -u -r1.9 it87.c
--- kernel/chips/it87.c	21 Jan 2003 20:01:26 -0000	1.9
+++ kernel/chips/it87.c	25 Apr 2003 18:29:30 -0000
@@ -32,25 +32,18 @@
 */
 
 #include <linux/module.h>
+#include <linux/init.h>
 #include <linux/slab.h>
-#include <linux/proc_fs.h>
-#include <linux/ioport.h>
-#include <linux/sysctl.h>
-#include <linux/types.h>
 #include <linux/i2c.h>
-#include <linux/i2c-proc.h>
-#include <linux/init.h>
-#include <asm/errno.h>
+#include <linux/i2c-sensor.h>
 #include <asm/io.h>
-#include "version.h"
 
-MODULE_LICENSE("GPL");
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { SENSORS_I2C_END };
-static unsigned short normal_i2c_range[] = { 0x20, 0x2f, SENSORS_I2C_END };
-static unsigned int normal_isa[] = { 0x0290, SENSORS_ISA_END };
-static unsigned int normal_isa_range[] = { SENSORS_ISA_END };
+static unsigned short normal_i2c[] = { I2C_CLIENT_END };
+static unsigned short normal_i2c_range[] = { 0x20, 0x2f, I2C_CLIENT_END };
+static unsigned int normal_isa[] = { 0x0290, I2C_CLIENT_ISA_END };
+static unsigned int normal_isa_range[] = { I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
 SENSORS_INSMOD_4(it87, it8705, it8712, sis950);
@@ -106,13 +99,46 @@
 
 #define IT87_REG_CHIPID        0x58
 
-
-/* Conversions. Rounding and limit checking is only done on the TO_REG 
-   variants. Note that you should be a bit careful with which arguments
-   these macros are called: arguments may be evaluated more than once.
-   Fixing this is just not worth it. */
-#define IN_TO_REG(val)  (SENSORS_LIMIT((((val) * 10 + 8)/16),0,255))
-#define IN_FROM_REG(val) (((val) *  16) / 10)
+static inline u8 IN_TO_REG(long val, int inNum)
+{
+	/* to avoid floating point, we multiply everything by 100.
+	 val is guaranteed to be positive, so we can achieve the effect of 
+	 rounding by (...*10+5)/10.  Note that the *10 is hidden in the 
+	 /250 (which should really be /2500).
+	 At the end, we need to /100 because we *100 everything and we need
+	 to /10 because of the rounding thing, so we /1000.   */
+	if (inNum <= 1)
+		return (u8)
+		    SENSORS_LIMIT(((val * 210240 - 13300) / 250 + 5) / 1000, 
+				  0, 255);
+	else if (inNum = 2)
+		return (u8)
+		    SENSORS_LIMIT(((val * 157370 - 13300) / 250 + 5) / 1000, 
+				  0, 255);
+	else if (inNum = 3)
+		return (u8)
+		    SENSORS_LIMIT(((val * 101080 - 13300) / 250 + 5) / 1000, 
+				  0, 255);
+	else
+		return (u8) SENSORS_LIMIT(((val * 41714 - 13300) / 250 + 5)
+					  / 1000, 0, 255);
+}
+
+static inline long IN_FROM_REG(u8 val, int inNum)
+{
+	/* to avoid floating point, we multiply everything by 100.
+	 val is guaranteed to be positive, so we can achieve the effect of
+	 rounding by adding 0.5.  Or, to avoid fp math, we do (...*10+5)/10.
+	 We need to scale with *100 anyway, so no need to /100 at the end. */
+	if (inNum <= 1)
+		return (long) (((250000 * val + 13300) / 210240 * 10 + 5) /10);
+	else if (inNum = 2)
+		return (long) (((250000 * val + 13300) / 157370 * 10 + 5) /10);
+	else if (inNum = 3)
+		return (long) (((250000 * val + 13300) / 101080 * 10 + 5) /10);
+	else
+		return (long) (((250000 * val + 13300) / 41714 * 10 + 5) /10);
+}
 
 static inline u8 FAN_TO_REG(long rpm, int div)
 {
@@ -126,11 +152,11 @@
 #define FAN_FROM_REG(val,div) ((val)=0?-1:(val)=255?0:1350000/((val)*(div)))
 
 #define TEMP_TO_REG(val) (SENSORS_LIMIT(((val)<0?(((val)-5)/10):\
-                                                 ((val)+5)/10),0,255))
+					((val)+5)/10),0,255))
 #define TEMP_FROM_REG(val) (((val)>0x80?(val)-0x100:(val))*10)
 
 #define VID_FROM_REG(val) ((val)=0x1f?0:(val)>=0x10?510-(val)*10:\
-                           205-(val)*5)
+				205-(val)*5)
 #define ALARMS_FROM_REG(val) (val)
 
 #define DIV_TO_REG(val) ((val)=8?3:(val)=4?2:(val)=1?0:1)
@@ -149,37 +175,37 @@
 #define IT87_INIT_IN_PERCENTAGE 10
 
 #define IT87_INIT_IN_MIN_0 \
-        (IT87_INIT_IN_0 - IT87_INIT_IN_0 * IT87_INIT_IN_PERCENTAGE / 100)
+	(IT87_INIT_IN_0 - IT87_INIT_IN_0 * IT87_INIT_IN_PERCENTAGE / 100)
 #define IT87_INIT_IN_MAX_0 \
-        (IT87_INIT_IN_0 + IT87_INIT_IN_0 * IT87_INIT_IN_PERCENTAGE / 100)
+	(IT87_INIT_IN_0 + IT87_INIT_IN_0 * IT87_INIT_IN_PERCENTAGE / 100)
 #define IT87_INIT_IN_MIN_1 \
-        (IT87_INIT_IN_1 - IT87_INIT_IN_1 * IT87_INIT_IN_PERCENTAGE / 100)
+	(IT87_INIT_IN_1 - IT87_INIT_IN_1 * IT87_INIT_IN_PERCENTAGE / 100)
 #define IT87_INIT_IN_MAX_1 \
-        (IT87_INIT_IN_1 + IT87_INIT_IN_1 * IT87_INIT_IN_PERCENTAGE / 100)
+	(IT87_INIT_IN_1 + IT87_INIT_IN_1 * IT87_INIT_IN_PERCENTAGE / 100)
 #define IT87_INIT_IN_MIN_2 \
-        (IT87_INIT_IN_2 - IT87_INIT_IN_2 * IT87_INIT_IN_PERCENTAGE / 100)
+	(IT87_INIT_IN_2 - IT87_INIT_IN_2 * IT87_INIT_IN_PERCENTAGE / 100)
 #define IT87_INIT_IN_MAX_2 \
-        (IT87_INIT_IN_2 + IT87_INIT_IN_2 * IT87_INIT_IN_PERCENTAGE / 100)
+	(IT87_INIT_IN_2 + IT87_INIT_IN_2 * IT87_INIT_IN_PERCENTAGE / 100)
 #define IT87_INIT_IN_MIN_3 \
-        (IT87_INIT_IN_3 - IT87_INIT_IN_3 * IT87_INIT_IN_PERCENTAGE / 100)
+	(IT87_INIT_IN_3 - IT87_INIT_IN_3 * IT87_INIT_IN_PERCENTAGE / 100)
 #define IT87_INIT_IN_MAX_3 \
-        (IT87_INIT_IN_3 + IT87_INIT_IN_3 * IT87_INIT_IN_PERCENTAGE / 100)
+	(IT87_INIT_IN_3 + IT87_INIT_IN_3 * IT87_INIT_IN_PERCENTAGE / 100)
 #define IT87_INIT_IN_MIN_4 \
-        (IT87_INIT_IN_4 - IT87_INIT_IN_4 * IT87_INIT_IN_PERCENTAGE / 100)
+	(IT87_INIT_IN_4 - IT87_INIT_IN_4 * IT87_INIT_IN_PERCENTAGE / 100)
 #define IT87_INIT_IN_MAX_4 \
-        (IT87_INIT_IN_4 + IT87_INIT_IN_4 * IT87_INIT_IN_PERCENTAGE / 100)
+	(IT87_INIT_IN_4 + IT87_INIT_IN_4 * IT87_INIT_IN_PERCENTAGE / 100)
 #define IT87_INIT_IN_MIN_5 \
-        (IT87_INIT_IN_5 - IT87_INIT_IN_5 * IT87_INIT_IN_PERCENTAGE / 100)
+	(IT87_INIT_IN_5 - IT87_INIT_IN_5 * IT87_INIT_IN_PERCENTAGE / 100)
 #define IT87_INIT_IN_MAX_5 \
-        (IT87_INIT_IN_5 + IT87_INIT_IN_5 * IT87_INIT_IN_PERCENTAGE / 100)
+	(IT87_INIT_IN_5 + IT87_INIT_IN_5 * IT87_INIT_IN_PERCENTAGE / 100)
 #define IT87_INIT_IN_MIN_6 \
-        (IT87_INIT_IN_6 - IT87_INIT_IN_6 * IT87_INIT_IN_PERCENTAGE / 100)
+	(IT87_INIT_IN_6 - IT87_INIT_IN_6 * IT87_INIT_IN_PERCENTAGE / 100)
 #define IT87_INIT_IN_MAX_6 \
-        (IT87_INIT_IN_6 + IT87_INIT_IN_6 * IT87_INIT_IN_PERCENTAGE / 100)
+	(IT87_INIT_IN_6 + IT87_INIT_IN_6 * IT87_INIT_IN_PERCENTAGE / 100)
 #define IT87_INIT_IN_MIN_7 \
-        (IT87_INIT_IN_7 - IT87_INIT_IN_7 * IT87_INIT_IN_PERCENTAGE / 100)
+	(IT87_INIT_IN_7 - IT87_INIT_IN_7 * IT87_INIT_IN_PERCENTAGE / 100)
 #define IT87_INIT_IN_MAX_7 \
-        (IT87_INIT_IN_7 + IT87_INIT_IN_7 * IT87_INIT_IN_PERCENTAGE / 100)
+	(IT87_INIT_IN_7 + IT87_INIT_IN_7 * IT87_INIT_IN_PERCENTAGE / 100)
 
 #define IT87_INIT_FAN_MIN_1 3000
 #define IT87_INIT_FAN_MIN_2 3000
@@ -198,7 +224,6 @@
    allocated. */
 struct it87_data {
 	struct semaphore lock;
-	int sysctl_id;
 	enum chips type;
 
 	struct semaphore update_lock;
@@ -220,33 +245,19 @@
 
 
 static int it87_attach_adapter(struct i2c_adapter *adapter);
-static int it87_detect(struct i2c_adapter *adapter, int address,
-		       unsigned short flags, int kind);
+static int it87_detect(struct i2c_adapter *adapter, int address, int kind);
 static int it87_detach_client(struct i2c_client *client);
 
 static int it87_read_value(struct i2c_client *client, u8 register);
 static int it87_write_value(struct i2c_client *client, u8 register,
-			    u8 value);
+			u8 value);
 static void it87_update_client(struct i2c_client *client);
 static void it87_init_client(struct i2c_client *client);
 
 
-static void it87_in(struct i2c_client *client, int operation, int ctl_name,
-		    int *nrels_mag, long *results);
-static void it87_fan(struct i2c_client *client, int operation,
-		     int ctl_name, int *nrels_mag, long *results);
-static void it87_temp(struct i2c_client *client, int operation,
-		      int ctl_name, int *nrels_mag, long *results);
-static void it87_vid(struct i2c_client *client, int operation,
-		     int ctl_name, int *nrels_mag, long *results);
-static void it87_alarms(struct i2c_client *client, int operation,
-			    int ctl_name, int *nrels_mag, long *results);
-static void it87_fan_div(struct i2c_client *client, int operation,
-			 int ctl_name, int *nrels_mag, long *results);
-
 static struct i2c_driver it87_driver = {
 	.owner		= THIS_MODULE,
-	.name		= "IT87xx sensor driver",
+	.name		= "IT87xx",
 	.id		= I2C_DRIVERID_IT87,
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= it87_attach_adapter,
@@ -255,90 +266,258 @@
 
 static int it87_id = 0;
 
-/* The /proc/sys entries */
-
-/* -- SENSORS SYSCTL START -- */
-#define IT87_SYSCTL_IN0 1000    /* Volts * 100 */
-#define IT87_SYSCTL_IN1 1001
-#define IT87_SYSCTL_IN2 1002
-#define IT87_SYSCTL_IN3 1003
-#define IT87_SYSCTL_IN4 1004
-#define IT87_SYSCTL_IN5 1005
-#define IT87_SYSCTL_IN6 1006
-#define IT87_SYSCTL_IN7 1007
-#define IT87_SYSCTL_IN8 1008
-#define IT87_SYSCTL_FAN1 1101   /* Rotations/min */
-#define IT87_SYSCTL_FAN2 1102
-#define IT87_SYSCTL_FAN3 1103
-#define IT87_SYSCTL_TEMP1 1200  /* Degrees Celcius * 10 */
-#define IT87_SYSCTL_TEMP2 1201  /* Degrees Celcius * 10 */
-#define IT87_SYSCTL_TEMP3 1202  /* Degrees Celcius * 10 */
-#define IT87_SYSCTL_VID 1300    /* Volts * 100 */
-#define IT87_SYSCTL_FAN_DIV 2000        /* 1, 2, 4 or 8 */
-#define IT87_SYSCTL_ALARMS 2004    /* bitvector */
-
-#define IT87_ALARM_IN0 0x000100
-#define IT87_ALARM_IN1 0x000200
-#define IT87_ALARM_IN2 0x000400
-#define IT87_ALARM_IN3 0x000800
-#define IT87_ALARM_IN4 0x001000
-#define IT87_ALARM_IN5 0x002000
-#define IT87_ALARM_IN6 0x004000
-#define IT87_ALARM_IN7 0x008000
-#define IT87_ALARM_FAN1 0x0001
-#define IT87_ALARM_FAN2 0x0002
-#define IT87_ALARM_FAN3 0x0004
-#define IT87_ALARM_TEMP1 0x00010000
-#define IT87_ALARM_TEMP2 0x00020000
-#define IT87_ALARM_TEMP3 0x00040000
-
-/* -- SENSORS SYSCTL END -- */
-
-/* These files are created for each detected IT87. This is just a template;
-   though at first sight, you might think we could use a statically
-   allocated list, we need some way to get back to the parent - which
-   is done through one of the 'extra' fields which are initialized 
-   when a new copy is allocated. */
-static ctl_table it87_dir_table_template[] = {
-	{IT87_SYSCTL_IN0, "in0", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &it87_in},
-	{IT87_SYSCTL_IN1, "in1", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &it87_in},
-	{IT87_SYSCTL_IN2, "in2", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &it87_in},
-	{IT87_SYSCTL_IN3, "in3", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &it87_in},
-	{IT87_SYSCTL_IN4, "in4", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &it87_in},
-	{IT87_SYSCTL_IN5, "in5", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &it87_in},
-	{IT87_SYSCTL_IN6, "in6", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &it87_in},
-	{IT87_SYSCTL_IN7, "in7", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &it87_in},
-	{IT87_SYSCTL_IN8, "in8", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &it87_in},
-	{IT87_SYSCTL_FAN1, "fan1", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &it87_fan},
-	{IT87_SYSCTL_FAN2, "fan2", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &it87_fan},
-	{IT87_SYSCTL_FAN3, "fan3", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &it87_fan},
-	{IT87_SYSCTL_TEMP1, "temp1", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &it87_temp},
-	{IT87_SYSCTL_TEMP2, "temp2", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &it87_temp},
-	{IT87_SYSCTL_TEMP3, "temp3", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &it87_temp},
-	{IT87_SYSCTL_VID, "vid", NULL, 0, 0444, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &it87_vid},
-	{IT87_SYSCTL_FAN_DIV, "fan_div", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &it87_fan_div},
-	{IT87_SYSCTL_ALARMS, "alarms", NULL, 0, 0444, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &it87_alarms},
-	{0}
-};
-
+static ssize_t show_in(struct device *dev, char *buf, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct it87_data *data = i2c_get_clientdata(client);
+	it87_update_client(client);
+	return sprintf(buf, "%ld\n", IN_FROM_REG(data->in[nr], nr)*10 );
+}
+
+static ssize_t show_in_min(struct device *dev, char *buf, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct it87_data *data = i2c_get_clientdata(client);
+	it87_update_client(client);
+	return sprintf(buf, "%ld\n", IN_FROM_REG(data->in_min[nr], nr)*10 );
+}
+
+static ssize_t show_in_max(struct device *dev, char *buf, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct it87_data *data = i2c_get_clientdata(client);
+	it87_update_client(client);
+	return sprintf(buf, "%ld\n", IN_FROM_REG(data->in_max[nr], nr)*10 );
+}
+
+static ssize_t set_in_min(struct device *dev, const char *buf, 
+		size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct it87_data *data = i2c_get_clientdata(client);
+	unsigned long val = simple_strtoul(buf, NULL, 10)/10;
+	data->in_min[nr] = IN_TO_REG(val,nr);
+	it87_write_value(client, IT87_REG_VIN_MIN(nr), 
+			data->in_min[nr]);
+	return count;
+}
+static ssize_t set_in_max(struct device *dev, const char *buf, 
+		size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct it87_data *data = i2c_get_clientdata(client);
+	unsigned long val = simple_strtoul(buf, NULL, 10)/10;
+	data->in_max[nr] = IN_TO_REG(val,nr);
+	it87_write_value(client, IT87_REG_VIN_MAX(nr), 
+			data->in_max[nr]);
+	return count;
+}
+
+#define show_in_offset(offset)					\
+static ssize_t							\
+	show_in##offset (struct device *dev, char *buf)		\
+{								\
+	return show_in(dev, buf, 0x##offset);			\
+}								\
+static ssize_t							\
+	show_in##offset##_min (struct device *dev, char *buf)	\
+{								\
+	return show_in_min(dev, buf, 0x##offset);		\
+}								\
+static ssize_t							\
+	show_in##offset##_max (struct device *dev, char *buf)	\
+{								\
+	return show_in_max(dev, buf, 0x##offset);		\
+}								\
+static ssize_t set_in##offset##_min (struct device *dev, 	\
+		const char *buf, size_t count) 			\
+{								\
+	return set_in_min(dev, buf, count, 0x##offset);		\
+}								\
+static ssize_t set_in##offset##_max (struct device *dev,	\
+			const char *buf, size_t count)		\
+{								\
+	return set_in_max(dev, buf, count, 0x##offset);		\
+}								\
+static DEVICE_ATTR(in_input##offset, S_IRUGO, show_in##offset, NULL) 	\
+static DEVICE_ATTR(in_min##offset, S_IRUGO | S_IWUSR, 		\
+		show_in##offset##_min, set_in##offset##_min)	\
+static DEVICE_ATTR(in_max##offset, S_IRUGO | S_IWUSR, 		\
+		show_in##offset##_max, set_in##offset##_max)
+
+show_in_offset(0);
+show_in_offset(1);
+show_in_offset(2);
+show_in_offset(3);
+show_in_offset(4);
+
+/* 3 temperatures */
+static ssize_t show_temp(struct device *dev, char *buf, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct it87_data *data = i2c_get_clientdata(client);
+	it87_update_client(client);
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[nr])*10 );
+}
+/* more like overshoot temperature */
+static ssize_t show_temp_max(struct device *dev, char *buf, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct it87_data *data = i2c_get_clientdata(client);
+	it87_update_client(client);
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_high[nr])*10);
+}
+/* more like hysteresis temperature */
+static ssize_t show_temp_min(struct device *dev, char *buf, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct it87_data *data = i2c_get_clientdata(client);
+	it87_update_client(client);
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_low[nr])*10);
+}
+static ssize_t set_temp_max(struct device *dev, const char *buf, 
+		size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct it87_data *data = i2c_get_clientdata(client);
+	int val = simple_strtol(buf, NULL, 10)/10;
+	data->temp_high[nr] = TEMP_TO_REG(val);
+	it87_write_value(client, IT87_REG_TEMP_HIGH(nr), data->temp_high[nr]);
+	return count;
+}
+static ssize_t set_temp_min(struct device *dev, const char *buf, 
+		size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct it87_data *data = i2c_get_clientdata(client);
+	int val = simple_strtol(buf, NULL, 10)/10;
+	data->temp_low[nr] = TEMP_TO_REG(val);
+	it87_write_value(client, IT87_REG_TEMP_LOW(nr), data->temp_low[nr]);
+	return count;
+}
+#define show_temp_offset(offset)					\
+static ssize_t show_temp_##offset (struct device *dev, char *buf)	\
+{									\
+	return show_temp(dev, buf, 0x##offset - 1);			\
+}									\
+static ssize_t								\
+show_temp_##offset##_max (struct device *dev, char *buf)		\
+{									\
+	return show_temp_max(dev, buf, 0x##offset - 1);			\
+}									\
+static ssize_t								\
+show_temp_##offset##_min (struct device *dev, char *buf)		\
+{									\
+	return show_temp_min(dev, buf, 0x##offset - 1);			\
+}									\
+static ssize_t set_temp_##offset##_max (struct device *dev, 		\
+		const char *buf, size_t count) 				\
+{									\
+	return set_temp_max(dev, buf, count, 0x##offset - 1);		\
+}									\
+static ssize_t set_temp_##offset##_min (struct device *dev, 		\
+		const char *buf, size_t count) 				\
+{									\
+	return set_temp_min(dev, buf, count, 0x##offset - 1);		\
+}									\
+static DEVICE_ATTR(temp_input##offset, S_IRUGO, show_temp_##offset, NULL) \
+static DEVICE_ATTR(temp_max##offset, S_IRUGO | S_IWUSR, 		\
+		show_temp_##offset##_max, set_temp_##offset##_max) 	\
+static DEVICE_ATTR(temp_min##offset, S_IRUGO | S_IWUSR, 		\
+		show_temp_##offset##_min, set_temp_##offset##_min)	
+
+show_temp_offset(1);
+show_temp_offset(2);
+show_temp_offset(3);
+
+/* 2 Fans */
+static ssize_t show_fan(struct device *dev, char *buf, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct it87_data *data = i2c_get_clientdata(client);
+	it87_update_client(client);
+	return sprintf(buf,"%d\n", FAN_FROM_REG(data->fan[nr], 
+				DIV_FROM_REG(data->fan_div[nr])) );
+}
+static ssize_t show_fan_min(struct device *dev, char *buf, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct it87_data *data = i2c_get_clientdata(client);
+	it87_update_client(client);
+	return sprintf(buf,"%d\n",
+		FAN_FROM_REG(data->fan_min[nr], DIV_FROM_REG(data->fan_div[nr])) );
+}
+static ssize_t show_fan_div(struct device *dev, char *buf, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct it87_data *data = i2c_get_clientdata(client);
+	it87_update_client(client);
+	return sprintf(buf,"%d\n", DIV_FROM_REG(data->fan_div[nr]) );
+}
+static ssize_t set_fan_min(struct device *dev, const char *buf, 
+		size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct it87_data *data = i2c_get_clientdata(client);
+	int val = simple_strtol(buf, NULL, 10);
+	data->fan_min[nr] = FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
+	it87_write_value(client, IT87_REG_FAN_MIN(nr+1), data->fan_min[nr]);
+	return count;
+}
+static ssize_t set_fan_div(struct device *dev, const char *buf, 
+		size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct it87_data *data = i2c_get_clientdata(client);
+	int val = simple_strtol(buf, NULL, 10);
+	int old = it87_read_value(client, IT87_REG_FAN_DIV);
+	data->fan_div[nr] = DIV_TO_REG(val);
+	old = (old & 0x0f) | (data->fan_div[1] << 6) | (data->fan_div[0] << 4);
+	it87_write_value(client, IT87_REG_FAN_DIV, old);
+	return count;
+}
+
+#define show_fan_offset(offset)						\
+static ssize_t show_fan_##offset (struct device *dev, char *buf)	\
+{									\
+	return show_fan(dev, buf, 0x##offset - 1);			\
+}									\
+static ssize_t show_fan_##offset##_min (struct device *dev, char *buf)	\
+{									\
+	return show_fan_min(dev, buf, 0x##offset - 1);			\
+}									\
+static ssize_t show_fan_##offset##_div (struct device *dev, char *buf)	\
+{									\
+	return show_fan_div(dev, buf, 0x##offset - 1);			\
+}									\
+static ssize_t set_fan_##offset##_min (struct device *dev, 		\
+	const char *buf, size_t count) 					\
+{									\
+	return set_fan_min(dev, buf, count, 0x##offset - 1);		\
+}									\
+static ssize_t set_fan_##offset##_div (struct device *dev, 		\
+		const char *buf, size_t count) 				\
+{									\
+	return set_fan_div(dev, buf, count, 0x##offset - 1);		\
+}									\
+static DEVICE_ATTR(fan_input##offset, S_IRUGO, show_fan_##offset, NULL) \
+static DEVICE_ATTR(fan_min##offset, S_IRUGO | S_IWUSR, 			\
+		show_fan_##offset##_min, set_fan_##offset##_min) 	\
+static DEVICE_ATTR(fan_div##offset, S_IRUGO | S_IWUSR, 			\
+		show_fan_##offset##_div, set_fan_##offset##_div)
+
+show_fan_offset(1);
+show_fan_offset(2);
+
+/* Alarm */
+static ssize_t show_alarm(struct device *dev, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct it87_data *data = i2c_get_clientdata(client);
+	it87_update_client(client);
+	return sprintf(buf,"%d\n", ALARMS_FROM_REG(data->alarms));
+}
+static DEVICE_ATTR(alarm, S_IRUGO | S_IWUSR, show_alarm, NULL);
 
 /* This function is called when:
      * it87_driver is inserted (when this module is loaded), for each
@@ -350,26 +529,24 @@
 }
 
 /* This function is called by i2c_detect */
-int it87_detect(struct i2c_adapter *adapter, int address,
-		unsigned short flags, int kind)
+int it87_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	int i;
-	struct i2c_client *new_client;
+	struct i2c_client *new_client = NULL;
 	struct it87_data *data;
 	int err = 0;
-	const char *type_name = "";
+	const char *name = "";
 	const char *client_name = "";
 	int is_isa = i2c_is_isa_adapter(adapter);
 
-	if (!is_isa
-	    && !i2c_check_functionality(adapter,
-					I2C_FUNC_SMBUS_BYTE_DATA)) goto
-		    ERROR0;
+	if (!is_isa && 
+	    !i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		goto ERROR0;
 
-	if (is_isa) {
-		if (check_region(address, IT87_EXTENT))
+	/* Reserve the ISA region */
+	if (is_isa)
+		if (!request_region(address, IT87_EXTENT, name))
 			goto ERROR0;
-	}
 
 	/* Probe whether there is anything available on this address. Already
 	   done for SMBus clients */
@@ -381,11 +558,11 @@
 			   if we read 'undefined' registers. */
 			i = inb_p(address + 1);
 			if (inb_p(address + 2) != i)
-				goto ERROR0;
+				goto ERROR1;
 			if (inb_p(address + 3) != i)
-				goto ERROR0;
+				goto ERROR1;
 			if (inb_p(address + 7) != i)
-				goto ERROR0;
+				goto ERROR1;
 #undef REALLY_SLOW_IO
 
 			/* Let's just hope nothing breaks here */
@@ -403,17 +580,17 @@
 	   But it allows us to access it87_{read,write}_value. */
 
 	if (!(new_client = kmalloc((sizeof(struct i2c_client)) +
-				   sizeof(struct it87_data),
-				   GFP_KERNEL))) {
+					sizeof(struct it87_data),
+					GFP_KERNEL))) {
 		err = -ENOMEM;
-		goto ERROR0;
+		goto ERROR1;
 	}
 
 	data = (struct it87_data *) (new_client + 1);
 	if (is_isa)
 		init_MUTEX(&data->lock);
+	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
-	new_client->data = data;
 	new_client->adapter = adapter;
 	new_client->driver = &it87_driver;
 	new_client->flags = 0;
@@ -424,7 +601,7 @@
 		if (it87_read_value(new_client, IT87_REG_CONFIG) & 0x80)
 			goto ERROR1;
 		if (!is_isa
-		    && (it87_read_value(new_client, IT87_REG_I2C_ADDR) !+			&& (it87_read_value(new_client, IT87_REG_I2C_ADDR) ! 			address)) goto ERROR1;
 	}
 
@@ -445,25 +622,20 @@
 	}
 
 	if (kind = it87) {
-		type_name = "it87";
+		name = "it87";
 		client_name = "IT87 chip";
 	} /* else if (kind = it8712) {
-		type_name = "it8712";
+		name = "it8712";
 		client_name = "IT87-J chip";
 	} */ else {
-#ifdef DEBUG
-		printk("it87.o: Internal error: unknown kind (%d)?!?",
-		       kind);
-#endif
+		dev_dbg(&adapter->dev, "Internal error: unknown kind (%d)?!?",
+			kind);
 		goto ERROR1;
 	}
 
-	/* Reserve the ISA region */
-	if (is_isa)
-		request_region(address, IT87_EXTENT, type_name);
-
 	/* Fill in the remaining client fields and put it into the global list */
-	strcpy(new_client->name, client_name);
+	strncpy(new_client->dev.name, name, DEVICE_NAME_SIZE);
+
 	data->type = kind;
 
 	new_client->id = it87_id++;
@@ -472,32 +644,51 @@
 
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(new_client)))
-		goto ERROR3;
+		goto ERROR1;
 
-	/* Register a new directory entry with module sensors */
-	if ((i = i2c_register_entry(new_client,
-				    type_name,
-				    it87_dir_table_template)) < 0) {
-		err = i;
-		goto ERROR4;
-	}
-	data->sysctl_id = i;
+	/* register sysfs hooks */
+	device_create_file(&new_client->dev, &dev_attr_in_input0);
+	device_create_file(&new_client->dev, &dev_attr_in_input1);
+	device_create_file(&new_client->dev, &dev_attr_in_input2);
+	device_create_file(&new_client->dev, &dev_attr_in_input3);
+	device_create_file(&new_client->dev, &dev_attr_in_input4);
+	device_create_file(&new_client->dev, &dev_attr_in_min0);
+	device_create_file(&new_client->dev, &dev_attr_in_min1);
+	device_create_file(&new_client->dev, &dev_attr_in_min2);
+	device_create_file(&new_client->dev, &dev_attr_in_min3);
+	device_create_file(&new_client->dev, &dev_attr_in_min4);
+	device_create_file(&new_client->dev, &dev_attr_in_max0);
+	device_create_file(&new_client->dev, &dev_attr_in_max1);
+	device_create_file(&new_client->dev, &dev_attr_in_max2);
+	device_create_file(&new_client->dev, &dev_attr_in_max3);
+	device_create_file(&new_client->dev, &dev_attr_in_max4);
+	device_create_file(&new_client->dev, &dev_attr_temp_input1);
+	device_create_file(&new_client->dev, &dev_attr_temp_input2);
+	device_create_file(&new_client->dev, &dev_attr_temp_input3);
+	device_create_file(&new_client->dev, &dev_attr_temp_max1);
+	device_create_file(&new_client->dev, &dev_attr_temp_max2);
+	device_create_file(&new_client->dev, &dev_attr_temp_max3);
+	device_create_file(&new_client->dev, &dev_attr_temp_min1);
+	device_create_file(&new_client->dev, &dev_attr_temp_min2);
+	device_create_file(&new_client->dev, &dev_attr_temp_min3);
+	device_create_file(&new_client->dev, &dev_attr_fan_input1);
+	device_create_file(&new_client->dev, &dev_attr_fan_input2);
+	device_create_file(&new_client->dev, &dev_attr_fan_min1);
+	device_create_file(&new_client->dev, &dev_attr_fan_min2);
+	device_create_file(&new_client->dev, &dev_attr_fan_div1);
+	device_create_file(&new_client->dev, &dev_attr_fan_div2);
+	device_create_file(&new_client->dev, &dev_attr_alarm);
 
 	/* Initialize the IT87 chip */
 	it87_init_client(new_client);
 	return 0;
 
-/* OK, this is not exactly good programming practice, usually. But it is
-   very code-efficient in this case. */
+ERROR1:
+	kfree(new_client);
 
-      ERROR4:
-	i2c_detach_client(new_client);
-      ERROR3:
 	if (is_isa)
 		release_region(address, IT87_EXTENT);
-      ERROR1:
-	kfree(new_client);
-      ERROR0:
+ERROR0:
 	return err;
 }
 
@@ -505,12 +696,9 @@
 {
 	int err;
 
-	i2c_deregister_entry(((struct it87_data *) (client->data))->
-				sysctl_id);
-
 	if ((err = i2c_detach_client(client))) {
-		printk
-		    ("it87.o: Client deregistration failed, client not detached.\n");
+		dev_err(&client->dev,
+			"Client deregistration failed, client not detached.\n");
 		return err;
 	}
 
@@ -530,12 +718,14 @@
    nowhere else be necessary! */
 static int it87_read_value(struct i2c_client *client, u8 reg)
 {
+	struct it87_data *data = i2c_get_clientdata(client);
+
 	int res;
 	if (i2c_is_isa_client(client)) {
-		down(&(((struct it87_data *) (client->data))->lock));
+		down(&data->lock);
 		outb_p(reg, client->addr + IT87_ADDR_REG_OFFSET);
 		res = inb_p(client->addr + IT87_DATA_REG_OFFSET);
-		up(&(((struct it87_data *) (client->data))->lock));
+		up(&data->lock);
 		return res;
 	} else
 		return i2c_smbus_read_byte_data(client, reg);
@@ -550,11 +740,13 @@
    nowhere else be necessary! */
 static int it87_write_value(struct i2c_client *client, u8 reg, u8 value)
 {
+	struct it87_data *data = i2c_get_clientdata(client);
+
 	if (i2c_is_isa_client(client)) {
-		down(&(((struct it87_data *) (client->data))->lock));
+		down(&data->lock);
 		outb_p(reg, client->addr + IT87_ADDR_REG_OFFSET);
 		outb_p(value, client->addr + IT87_DATA_REG_OFFSET);
-		up(&(((struct it87_data *) (client->data))->lock));
+		up(&data->lock);
 		return 0;
 	} else
 		return i2c_smbus_write_byte_data(client, reg, value);
@@ -567,38 +759,38 @@
 	   This sets fan-divs to 2, among others */
 	it87_write_value(client, IT87_REG_CONFIG, 0x80);
 	it87_write_value(client, IT87_REG_VIN_MIN(0),
-			 IN_TO_REG(IT87_INIT_IN_MIN_0));
+			 IN_TO_REG(IT87_INIT_IN_MIN_0, 0));
 	it87_write_value(client, IT87_REG_VIN_MAX(0),
-			 IN_TO_REG(IT87_INIT_IN_MAX_0));
+			 IN_TO_REG(IT87_INIT_IN_MAX_0, 0));
 	it87_write_value(client, IT87_REG_VIN_MIN(1),
-			 IN_TO_REG(IT87_INIT_IN_MIN_1));
+			 IN_TO_REG(IT87_INIT_IN_MIN_1, 1));
 	it87_write_value(client, IT87_REG_VIN_MAX(1),
-			 IN_TO_REG(IT87_INIT_IN_MAX_1));
+			 IN_TO_REG(IT87_INIT_IN_MAX_1, 1));
 	it87_write_value(client, IT87_REG_VIN_MIN(2),
-			 IN_TO_REG(IT87_INIT_IN_MIN_2));
+			 IN_TO_REG(IT87_INIT_IN_MIN_2, 2));
 	it87_write_value(client, IT87_REG_VIN_MAX(2),
-			 IN_TO_REG(IT87_INIT_IN_MAX_2));
+			 IN_TO_REG(IT87_INIT_IN_MAX_2, 2));
 	it87_write_value(client, IT87_REG_VIN_MIN(3),
-			 IN_TO_REG(IT87_INIT_IN_MIN_3));
+			 IN_TO_REG(IT87_INIT_IN_MIN_3, 3));
 	it87_write_value(client, IT87_REG_VIN_MAX(3),
-			 IN_TO_REG(IT87_INIT_IN_MAX_3));
+			 IN_TO_REG(IT87_INIT_IN_MAX_3, 3));
 	it87_write_value(client, IT87_REG_VIN_MIN(4),
-			 IN_TO_REG(IT87_INIT_IN_MIN_4));
+			 IN_TO_REG(IT87_INIT_IN_MIN_4, 4));
 	it87_write_value(client, IT87_REG_VIN_MAX(4),
-			 IN_TO_REG(IT87_INIT_IN_MAX_4));
+			 IN_TO_REG(IT87_INIT_IN_MAX_4, 4));
 	it87_write_value(client, IT87_REG_VIN_MIN(5),
-			 IN_TO_REG(IT87_INIT_IN_MIN_5));
+			 IN_TO_REG(IT87_INIT_IN_MIN_5, 5));
 	it87_write_value(client, IT87_REG_VIN_MAX(5),
-			 IN_TO_REG(IT87_INIT_IN_MAX_5));
+			 IN_TO_REG(IT87_INIT_IN_MAX_5, 5));
 	it87_write_value(client, IT87_REG_VIN_MIN(6),
-			 IN_TO_REG(IT87_INIT_IN_MIN_6));
+			 IN_TO_REG(IT87_INIT_IN_MIN_6, 6));
 	it87_write_value(client, IT87_REG_VIN_MAX(6),
-			 IN_TO_REG(IT87_INIT_IN_MAX_6));
+			 IN_TO_REG(IT87_INIT_IN_MAX_6, 6));
 	it87_write_value(client, IT87_REG_VIN_MIN(7),
-			 IN_TO_REG(IT87_INIT_IN_MIN_7));
+			 IN_TO_REG(IT87_INIT_IN_MIN_7, 7));
 	it87_write_value(client, IT87_REG_VIN_MAX(7),
-			 IN_TO_REG(IT87_INIT_IN_MAX_7));
-        /* Note: Battery voltage does not have limit registers */
+			 IN_TO_REG(IT87_INIT_IN_MAX_7, 7));
+	/* Note: Battery voltage does not have limit registers */
 	it87_write_value(client, IT87_REG_FAN_MIN(1),
 			 FAN_TO_REG(IT87_INIT_FAN_MIN_1, 2));
 	it87_write_value(client, IT87_REG_FAN_MIN(2),
@@ -639,7 +831,7 @@
 
 static void it87_update_client(struct i2c_client *client)
 {
-	struct it87_data *data = client->data;
+	struct it87_data *data = i2c_get_clientdata(client);
 	int i;
 
 	down(&data->update_lock);
@@ -648,8 +840,8 @@
 	    (jiffies < data->last_updated) || !data->valid) {
 
 		if (update_vbat) {
-                	/* Cleared after each update, so reenable.  Value
-		   	  returned by this read will be previous value */	
+			/* Cleared after each update, so reenable.  Value
+		 	  returned by this read will be previous value */	
 			it87_write_value(client, IT87_REG_CONFIG,
 			   it87_read_value(client, IT87_REG_CONFIG) | 0x40);
 		}
@@ -667,7 +859,7 @@
 		   to min and max value */
 		data->in_min[8] = 0;
 		data->in_max[8] = 255;
-                
+
 		for (i = 1; i <= 3; i++) {
 			data->fan[i - 1]  			    it87_read_value(client, IT87_REG_FAN(i));
@@ -709,164 +901,8 @@
 	up(&data->update_lock);
 }
 
-
-/* The next few functions are the call-back functions of the /proc/sys and
-   sysctl files. Which function is used is defined in the ctl_table in
-   the extra1 field.
-    - Each function must return the magnitude (power of 10 to divide the
-      data with) if it is called with operation=SENSORS_PROC_REAL_INFO.
-    - It must put a maximum of *nrels elements in results reflecting the
-      data of this file, and set *nrels to the number it actually put 
-      in it, if operation=SENSORS_PROC_REAL_READ.
-    - Finally, it must get upto *nrels elements from results and write them
-      to the chip, if operations=SENSORS_PROC_REAL_WRITE.
-   Note that on SENSORS_PROC_REAL_READ, I do not check whether results is
-   large enough (by checking the incoming value of *nrels). This is not very
-   good practice, but as long as you put less than about 5 values in results,
-   you can assume it is large enough. */
-void it87_in(struct i2c_client *client, int operation, int ctl_name,
-	     int *nrels_mag, long *results)
-{
-	struct it87_data *data = client->data;
-	int nr = ctl_name - IT87_SYSCTL_IN0;
-
-	if (operation = SENSORS_PROC_REAL_INFO)
-		*nrels_mag = 2;
-	else if (operation = SENSORS_PROC_REAL_READ) {
-		it87_update_client(client);
-		results[0] = IN_FROM_REG(data->in_min[nr]);
-		results[1] = IN_FROM_REG(data->in_max[nr]);
-		results[2] = IN_FROM_REG(data->in[nr]);
-		*nrels_mag = 3;
-	} else if (operation = SENSORS_PROC_REAL_WRITE) {
-		if (*nrels_mag >= 1) {
-			data->in_min[nr] = IN_TO_REG(results[0]);
-			it87_write_value(client, IT87_REG_VIN_MIN(nr),
-					 data->in_min[nr]);
-		}
-		if (*nrels_mag >= 2) {
-			data->in_max[nr] = IN_TO_REG(results[1]);
-			it87_write_value(client, IT87_REG_VIN_MAX(nr),
-					 data->in_max[nr]);
-		}
-	}
-}
-
-void it87_fan(struct i2c_client *client, int operation, int ctl_name,
-	      int *nrels_mag, long *results)
-{
-	struct it87_data *data = client->data;
-	int nr = ctl_name - IT87_SYSCTL_FAN1 + 1;
-
-	if (operation = SENSORS_PROC_REAL_INFO)
-		*nrels_mag = 0;
-	else if (operation = SENSORS_PROC_REAL_READ) {
-		it87_update_client(client);
-		results[0] = FAN_FROM_REG(data->fan_min[nr - 1],
-					  DIV_FROM_REG(data->
-						       fan_div[nr - 1]));
-		results[1] -		    FAN_FROM_REG(data->fan[nr - 1],
-				 DIV_FROM_REG(data->fan_div[nr - 1]));
-		*nrels_mag = 2;
-	} else if (operation = SENSORS_PROC_REAL_WRITE) {
-		if (*nrels_mag >= 1) {
-			data->fan_min[nr - 1] = FAN_TO_REG(results[0],
-							   DIV_FROM_REG
-							   (data->
-							    fan_div[nr -
-								    1]));
-			it87_write_value(client, IT87_REG_FAN_MIN(nr),
-					 data->fan_min[nr - 1]);
-		}
-	}
-}
-
-
-void it87_temp(struct i2c_client *client, int operation, int ctl_name,
-	       int *nrels_mag, long *results)
-{
-	struct it87_data *data = client->data;
-	int nr = ctl_name - IT87_SYSCTL_TEMP1 + 1;
-	if (operation = SENSORS_PROC_REAL_INFO)
-		*nrels_mag = 1;
-	else if (operation = SENSORS_PROC_REAL_READ) {
-		it87_update_client(client);
-		results[0] = TEMP_FROM_REG(data->temp_high[nr - 1]);
-		results[1] = TEMP_FROM_REG(data->temp_low[nr - 1]);
-		results[2] = TEMP_FROM_REG(data->temp[nr - 1]);
-		*nrels_mag = 3;
-	} else if (operation = SENSORS_PROC_REAL_WRITE) {
-		if (*nrels_mag >= 1) {
-			data->temp_high[nr - 1] = TEMP_TO_REG(results[0]);
-			it87_write_value(client, IT87_REG_TEMP_HIGH(nr),
-					 data->temp_high[nr - 1]);
-		}
-		if (*nrels_mag >= 2) {
-			data->temp_low[nr - 1] = TEMP_TO_REG(results[1]);
-			it87_write_value(client, IT87_REG_TEMP_LOW(nr),
-					 data->temp_low[nr - 1]);
-		}
-	}
-}
-
-void it87_vid(struct i2c_client *client, int operation, int ctl_name,
-	      int *nrels_mag, long *results)
-{
-	struct it87_data *data = client->data;
-	if (operation = SENSORS_PROC_REAL_INFO)
-		*nrels_mag = 2;
-	else if (operation = SENSORS_PROC_REAL_READ) {
-		it87_update_client(client);
-		results[0] = VID_FROM_REG(data->vid);
-		*nrels_mag = 1;
-	}
-}
-
-void it87_alarms(struct i2c_client *client, int operation,
-                     int ctl_name, int *nrels_mag, long *results)
-{
-	struct it87_data *data = client->data;
-	if (operation = SENSORS_PROC_REAL_INFO)
-		*nrels_mag = 0;
-	else if (operation = SENSORS_PROC_REAL_READ) {
-		it87_update_client(client);
-		results[0] = ALARMS_FROM_REG(data->alarms);
-		*nrels_mag = 1;
-	}
-}
-
-void it87_fan_div(struct i2c_client *client, int operation, int ctl_name,
-		  int *nrels_mag, long *results)
-{
-	struct it87_data *data = client->data;
-	int old;
-
-	if (operation = SENSORS_PROC_REAL_INFO)
-		*nrels_mag = 0;
-	else if (operation = SENSORS_PROC_REAL_READ) {
-		it87_update_client(client);
-		results[0] = DIV_FROM_REG(data->fan_div[0]);
-		results[1] = DIV_FROM_REG(data->fan_div[1]);
-		results[2] = 2;
-		*nrels_mag = 3;
-	} else if (operation = SENSORS_PROC_REAL_WRITE) {
-		old = it87_read_value(client, IT87_REG_FAN_DIV);
-		if (*nrels_mag >= 2) {
-			data->fan_div[1] = DIV_TO_REG(results[1]);
-			old = (old & 0xc3) | (data->fan_div[1] << 3);
-		}
-		if (*nrels_mag >= 1) {
-			data->fan_div[0] = DIV_TO_REG(results[0]);
-			old = (old & 0xf8) | data->fan_div[0];
-			it87_write_value(client, IT87_REG_FAN_DIV, old);
-		}
-	}
-}
-
 static int __init sm_it87_init(void)
 {
-	printk("it87.o version %s (%s)\n", LM_VERSION, LM_DATE);
 	return i2c_add_driver(&it87_driver);
 }
 
@@ -876,13 +912,13 @@
 }
 
 
-
 MODULE_AUTHOR("Chris Gauthron <chrisg@0-in.com>");
 MODULE_DESCRIPTION("IT8705F, IT8712F, Sis950 driver");
 MODULE_PARM(update_vbat, "i");
 MODULE_PARM_DESC(update_vbat, "Update vbat if set else return powerup value");
 MODULE_PARM(temp_type, "i");
 MODULE_PARM_DESC(temp_type, "Temperature sensor type, normally leave unset");
+MODULE_LICENSE("GPL");
 
 module_init(sm_it87_init);
 module_exit(sm_it87_exit);
Index: kernel/chips/lm75.c
=================================RCS file: /home/cvs/lm_sensors2/kernel/chips/lm75.c,v
retrieving revision 1.43
diff -a -u -r1.43 lm75.c
--- kernel/chips/lm75.c	21 Jan 2003 20:01:26 -0000	1.43
+++ kernel/chips/lm75.c	25 Apr 2003 18:29:30 -0000
@@ -18,18 +18,20 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
 
+/* #define DEBUG 1 */
+
 #include <linux/module.h>
+#include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/i2c.h>
-#include <linux/i2c-proc.h>
-#include <linux/init.h>
-#include "version.h"
+#include <linux/i2c-sensor.h>
+
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { SENSORS_I2C_END };
-static unsigned short normal_i2c_range[] = { 0x48, 0x4f, SENSORS_I2C_END };
-static unsigned int normal_isa[] = { SENSORS_ISA_END };
-static unsigned int normal_isa_range[] = { SENSORS_ISA_END };
+static unsigned short normal_i2c[] = { I2C_CLIENT_END };
+static unsigned short normal_i2c_range[] = { 0x48, 0x4f, I2C_CLIENT_END };
+static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
+static unsigned int normal_isa_range[] = { I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
 SENSORS_INSMOD_1(lm75);
@@ -37,104 +39,113 @@
 /* Many LM75 constants specified below */
 
 /* The LM75 registers */
-#define LM75_REG_TEMP 0x00
-#define LM75_REG_CONF 0x01
-#define LM75_REG_TEMP_HYST 0x02
-#define LM75_REG_TEMP_OS 0x03
+#define LM75_REG_TEMP		0x00
+#define LM75_REG_CONF		0x01
+#define LM75_REG_TEMP_HYST	0x02
+#define LM75_REG_TEMP_OS	0x03
 
 /* Conversions. Rounding and limit checking is only done on the TO_REG
    variants. Note that you should be a bit careful with which arguments
    these macros are called: arguments may be evaluated more than once.
    Fixing this is just not worth it. */
-#define TEMP_FROM_REG(val) ((((val & 0x7fff) >> 7) * 5) | ((val & 0x8000)?-256:0))
-#define TEMP_TO_REG(val)   (SENSORS_LIMIT((val<0?(0x200+((val)/5))<<7:(((val) + 2) / 5) << 7),0,0xffff))
+#define TEMP_FROM_REG(val)	((((val & 0x7fff) >> 7) * 5) | ((val & 0x8000)?-256:0))
+#define TEMP_TO_REG(val)	(SENSORS_LIMIT((val<0?(0x200+((val)/5))<<7:(((val) + 2) / 5) << 7),0,0xffff))
 
 /* Initial values */
-#define LM75_INIT_TEMP_OS 600
-#define LM75_INIT_TEMP_HYST 500
+#define LM75_INIT_TEMP_OS	600
+#define LM75_INIT_TEMP_HYST	500
 
 /* Each client has this additional data */
 struct lm75_data {
-	int sysctl_id;
-
-	struct semaphore update_lock;
-	char valid;		/* !=0 if following fields are valid */
-	unsigned long last_updated;	/* In jiffies */
-
-	u16 temp, temp_os, temp_hyst;	/* Register values */
+	struct semaphore	update_lock;
+	char			valid;		/* !=0 if following fields are valid */
+	unsigned long		last_updated;	/* In jiffies */
+	u16			temp_input;	/* Register values */
+	u16			temp_max;
+	u16			temp_hyst;
 };
 
 static int lm75_attach_adapter(struct i2c_adapter *adapter);
-static int lm75_detect(struct i2c_adapter *adapter, int address,
-		       unsigned short flags, int kind);
+static int lm75_detect(struct i2c_adapter *adapter, int address, int kind);
 static void lm75_init_client(struct i2c_client *client);
 static int lm75_detach_client(struct i2c_client *client);
-
-static u16 swap_bytes(u16 val);
 static int lm75_read_value(struct i2c_client *client, u8 reg);
 static int lm75_write_value(struct i2c_client *client, u8 reg, u16 value);
-static void lm75_temp(struct i2c_client *client, int operation,
-		      int ctl_name, int *nrels_mag, long *results);
 static void lm75_update_client(struct i2c_client *client);
 
 
 /* This is the driver that will be inserted */
 static struct i2c_driver lm75_driver = {
 	.owner		= THIS_MODULE,
-	.name		= "LM75 sensor chip driver",
+	.name		= "lm75",
 	.id		= I2C_DRIVERID_LM75,
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= lm75_attach_adapter,
 	.detach_client	= lm75_detach_client,
 };
 
-/* -- SENSORS SYSCTL START -- */
-
-#define LM75_SYSCTL_TEMP 1200	/* Degrees Celcius * 10 */
-
-/* -- SENSORS SYSCTL END -- */
-
-/* These files are created for each detected LM75. This is just a template;
-   though at first sight, you might think we could use a statically
-   allocated list, we need some way to get back to the parent - which
-   is done through one of the 'extra' fields which are initialized
-   when a new copy is allocated. */
-static ctl_table lm75_dir_table_template[] = {
-	{LM75_SYSCTL_TEMP, "temp", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &lm75_temp},
-	{0}
-};
-
 static int lm75_id = 0;
 
+#define show(value)	\
+static ssize_t show_##value(struct device *dev, char *buf)	\
+{								\
+	struct i2c_client *client = to_i2c_client(dev);		\
+	struct lm75_data *data = i2c_get_clientdata(client);	\
+	int temp;						\
+								\
+	lm75_update_client(client);				\
+	temp = TEMP_FROM_REG(data->value);			\
+	return sprintf(buf, "%d\n", temp * 100);		\
+}
+show(temp_max);
+show(temp_hyst);
+show(temp_input);
+
+#define set(value, reg)	\
+static ssize_t set_##value(struct device *dev, const char *buf, size_t count)	\
+{								\
+	struct i2c_client *client = to_i2c_client(dev);		\
+	struct lm75_data *data = i2c_get_clientdata(client);	\
+	int temp = simple_strtoul(buf, NULL, 10) / 100;		\
+								\
+	data->value = TEMP_TO_REG(temp);			\
+	lm75_write_value(client, reg, data->value);		\
+	return count;						\
+}
+set(temp_max, LM75_REG_TEMP_OS);
+set(temp_hyst, LM75_REG_TEMP_HYST);
+
+static DEVICE_ATTR(temp_max, S_IWUSR | S_IRUGO, show_temp_max, set_temp_max);
+static DEVICE_ATTR(temp_min, S_IWUSR | S_IRUGO, show_temp_hyst, set_temp_hyst);
+static DEVICE_ATTR(temp_input, S_IRUGO, show_temp_input, NULL);
+
 static int lm75_attach_adapter(struct i2c_adapter *adapter)
 {
 	return i2c_detect(adapter, &addr_data, lm75_detect);
 }
 
 /* This function is called by i2c_detect */
-int lm75_detect(struct i2c_adapter *adapter, int address,
-		unsigned short flags, int kind)
+static int lm75_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	int i, cur, conf, hyst, os;
 	struct i2c_client *new_client;
 	struct lm75_data *data;
 	int err = 0;
-	const char *type_name, *client_name;
+	const char *name;
 
 	/* Make sure we aren't probing the ISA bus!! This is just a safety check
 	   at this moment; i2c_detect really won't call us. */
 #ifdef DEBUG
 	if (i2c_is_isa_adapter(adapter)) {
-		printk
-		    ("lm75.o: lm75_detect called for an ISA bus adapter?!?\n");
-		return 0;
+		dev_dbg(&adapter->dev,
+			"lm75_detect called for an ISA bus adapter?!?\n");
+		goto exit;
 	}
 #endif
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
 				     I2C_FUNC_SMBUS_WORD_DATA))
-		    goto error0;
+		goto exit;
 
 	/* OK. For now, we presume we have a valid client. We now create the
 	   client structure, even though we cannot fill it completely yet.
@@ -143,12 +154,14 @@
 				   sizeof(struct lm75_data),
 				   GFP_KERNEL))) {
 		err = -ENOMEM;
-		goto error0;
+		goto exit;
 	}
+	memset(new_client, 0x00, sizeof(struct i2c_client) +
+				 sizeof(struct lm75_data));
 
 	data = (struct lm75_data *) (new_client + 1);
+	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
-	new_client->data = data;
 	new_client->adapter = adapter;
 	new_client->driver = &lm75_driver;
 	new_client->flags = 0;
@@ -160,16 +173,10 @@
 		hyst = i2c_smbus_read_word_data(new_client, 2);
 		os = i2c_smbus_read_word_data(new_client, 3);
 		for (i = 0; i <= 0x1f; i++)
-			if (
-			    (i2c_smbus_read_byte_data
-			     (new_client, i * 8 + 1) != conf)
-			    ||
-			    (i2c_smbus_read_word_data
-			     (new_client, i * 8 + 2) != hyst)
-			    ||
-			    (i2c_smbus_read_word_data
-			     (new_client, i * 8 + 3) != os))
-				goto error1;
+			if ((i2c_smbus_read_byte_data(new_client, i * 8 + 1) != conf) ||
+			    (i2c_smbus_read_word_data(new_client, i * 8 + 2) != hyst) ||
+			    (i2c_smbus_read_word_data(new_client, i * 8 + 3) != os))
+				goto exit_free;
 	}
 
 	/* Determine the chip type - only one kind supported! */
@@ -177,15 +184,15 @@
 		kind = lm75;
 
 	if (kind = lm75) {
-		type_name = "lm75";
-		client_name = "LM75 chip";
+		name = "lm75";
 	} else {
-		pr_debug("lm75.o: Internal error: unknown kind (%d)?!?", kind);
-		goto error1;
+		dev_dbg(&adapter->dev, "Internal error: unknown kind (%d)?!?",
+			kind);
+		goto exit_free;
 	}
 
 	/* Fill in the remaining client fields and put it into the global list */
-	strcpy(new_client->name, client_name);
+	strncpy(new_client->dev.name, name, DEVICE_NAME_SIZE);
 
 	new_client->id = lm75_id++;
 	data->valid = 0;
@@ -193,36 +200,23 @@
 
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(new_client)))
-		goto error3;
+		goto exit_free;
 
-	/* Register a new directory entry with module sensors */
-	if ((i = i2c_register_entry(new_client, type_name,
-					lm75_dir_table_template)) < 0) {
-		err = i;
-		goto error4;
-	}
-	data->sysctl_id = i;
+	device_create_file(&new_client->dev, &dev_attr_temp_max);
+	device_create_file(&new_client->dev, &dev_attr_temp_min);
+	device_create_file(&new_client->dev, &dev_attr_temp_input);
 
 	lm75_init_client(new_client);
 	return 0;
 
-/* OK, this is not exactly good programming practice, usually. But it is
-   very code-efficient in this case. */
-
-      error4:
-	i2c_detach_client(new_client);
-      error3:
-      error1:
+exit_free:
 	kfree(new_client);
-      error0:
+exit:
 	return err;
 }
 
 static int lm75_detach_client(struct i2c_client *client)
 {
-	struct lm75_data *data = client->data;
-
-	i2c_deregister_entry(data->sysctl_id);
 	i2c_detach_client(client);
 	kfree(client);
 	return 0;
@@ -268,18 +262,17 @@
 
 static void lm75_update_client(struct i2c_client *client)
 {
-	struct lm75_data *data = client->data;
+	struct lm75_data *data = i2c_get_clientdata(client);
 
 	down(&data->update_lock);
 
 	if ((jiffies - data->last_updated > HZ + HZ / 2) ||
 	    (jiffies < data->last_updated) || !data->valid) {
-		pr_debug("Starting lm75 update\n");
+		dev_dbg(&client->dev, "Starting lm75 update\n");
 
-		data->temp = lm75_read_value(client, LM75_REG_TEMP);
-		data->temp_os = lm75_read_value(client, LM75_REG_TEMP_OS);
-		data->temp_hyst -		    lm75_read_value(client, LM75_REG_TEMP_HYST);
+		data->temp_input = lm75_read_value(client, LM75_REG_TEMP);
+		data->temp_max = lm75_read_value(client, LM75_REG_TEMP_OS);
+		data->temp_hyst = lm75_read_value(client, LM75_REG_TEMP_HYST);
 		data->last_updated = jiffies;
 		data->valid = 1;
 	}
@@ -287,40 +280,12 @@
 	up(&data->update_lock);
 }
 
-
-void lm75_temp(struct i2c_client *client, int operation, int ctl_name,
-	       int *nrels_mag, long *results)
-{
-	struct lm75_data *data = client->data;
-	if (operation = SENSORS_PROC_REAL_INFO)
-		*nrels_mag = 1;
-	else if (operation = SENSORS_PROC_REAL_READ) {
-		lm75_update_client(client);
-		results[0] = TEMP_FROM_REG(data->temp_os);
-		results[1] = TEMP_FROM_REG(data->temp_hyst);
-		results[2] = TEMP_FROM_REG(data->temp);
-		*nrels_mag = 3;
-	} else if (operation = SENSORS_PROC_REAL_WRITE) {
-		if (*nrels_mag >= 1) {
-			data->temp_os = TEMP_TO_REG(results[0]);
-			lm75_write_value(client, LM75_REG_TEMP_OS,
-					 data->temp_os);
-		}
-		if (*nrels_mag >= 2) {
-			data->temp_hyst = TEMP_TO_REG(results[1]);
-			lm75_write_value(client, LM75_REG_TEMP_HYST,
-					 data->temp_hyst);
-		}
-	}
-}
-
-static int __init sm_lm75_init(void)
+static int __init sensors_lm75_init(void)
 {
-	printk(KERN_INFO "lm75.o version %s (%s)\n", LM_VERSION, LM_DATE);
 	return i2c_add_driver(&lm75_driver);
 }
 
-static void __exit sm_lm75_exit(void)
+static void __exit sensors_lm75_exit(void)
 {
 	i2c_del_driver(&lm75_driver);
 }
@@ -329,5 +294,5 @@
 MODULE_DESCRIPTION("LM75 driver");
 MODULE_LICENSE("GPL");
 
-module_init(sm_lm75_init);
-module_exit(sm_lm75_exit);
+module_init(sensors_lm75_init);
+module_exit(sensors_lm75_exit);
Index: kernel/chips/via686a.c
=================================RCS file: /home/cvs/lm_sensors2/kernel/chips/via686a.c,v
retrieving revision 1.28
diff -a -u -r1.28 via686a.c
--- kernel/chips/via686a.c	23 Jan 2003 23:24:05 -0000	1.28
+++ kernel/chips/via686a.c	25 Apr 2003 18:29:31 -0000
@@ -36,10 +36,9 @@
 #include <linux/pci.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
-#include <linux/i2c-proc.h>
+#include <linux/i2c-sensor.h>
 #include <linux/init.h>
 #include <asm/io.h>
-#include "version.h"
 
 
 /* If force_addr is set to anything different from 0, we forcibly enable
@@ -52,10 +51,10 @@
 /* Addresses to scan.
    Note that we can't determine the ISA address until we have initialized
    our module */
-static unsigned short normal_i2c[] = { SENSORS_I2C_END };
-static unsigned short normal_i2c_range[] = { SENSORS_I2C_END };
-static unsigned int normal_isa[] = { 0x0000, SENSORS_ISA_END };
-static unsigned int normal_isa_range[] = { SENSORS_ISA_END };
+static unsigned short normal_i2c[] = { I2C_CLIENT_END };
+static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
+static unsigned int normal_isa[] = { 0x0000, I2C_CLIENT_ISA_END };
+static unsigned int normal_isa_range[] = { I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
 SENSORS_INSMOD_1(via686a);
@@ -82,15 +81,15 @@
 #define VIA686A_REG_FAN_MIN(nr) (0x3a + (nr))
 #define VIA686A_REG_FAN(nr)     (0x28 + (nr))
 
-// the following values are as speced by VIA:
+/* the following values are as speced by VIA: */
 static const u8 regtemp[] = { 0x20, 0x21, 0x1f };
 static const u8 regover[] = { 0x39, 0x3d, 0x1d };
 static const u8 reghyst[] = { 0x3a, 0x3e, 0x1e };
 
 /* temps numbered 1-3 */
-#define VIA686A_REG_TEMP(nr)		(regtemp[(nr) - 1])
-#define VIA686A_REG_TEMP_OVER(nr)	(regover[(nr) - 1])
-#define VIA686A_REG_TEMP_HYST(nr)	(reghyst[(nr) - 1])
+#define VIA686A_REG_TEMP(nr)		(regtemp[nr])
+#define VIA686A_REG_TEMP_OVER(nr)	(regover[nr])
+#define VIA686A_REG_TEMP_HYST(nr)	(reghyst[nr])
 #define VIA686A_REG_TEMP_LOW1	0x4b	// bits 7-6
 #define VIA686A_REG_TEMP_LOW23	0x49	// 2 = bits 5-4, 3 = bits 7-6
 
@@ -98,44 +97,44 @@
 #define VIA686A_REG_ALARM2 0x42
 #define VIA686A_REG_FANDIV 0x47
 #define VIA686A_REG_CONFIG 0x40
-// The following register sets temp interrupt mode (bits 1-0 for temp1, 
-// 3-2 for temp2, 5-4 for temp3).  Modes are:
-//    00 interrupt stays as long as value is out-of-range
-//    01 interrupt is cleared once register is read (default)
-//    10 comparator mode- like 00, but ignores hysteresis
-//    11 same as 00
+/* The following register sets temp interrupt mode (bits 1-0 for temp1, 
+ 3-2 for temp2, 5-4 for temp3).  Modes are:
+    00 interrupt stays as long as value is out-of-range
+    01 interrupt is cleared once register is read (default)
+    10 comparator mode- like 00, but ignores hysteresis
+    11 same as 00 */
 #define VIA686A_REG_TEMP_MODE 0x4b
-// We'll just assume that you want to set all 3 simultaneously:
+/* We'll just assume that you want to set all 3 simultaneously: */
 #define VIA686A_TEMP_MODE_MASK 0x3F
 #define VIA686A_TEMP_MODE_CONTINUOUS (0x00)
 
 /* Conversions. Rounding and limit checking is only done on the TO_REG
-   variants. */
+   variants. 
 
-/********* VOLTAGE CONVERSIONS (Bob Dougherty) ********/
-// From HWMon.cpp (Copyright 1998-2000 Jonathan Teh Soon Yew):
-// voltagefactor[0]=1.25/2628; (2628/1.25!02.4)   // Vccp
-// voltagefactor[1]=1.25/2628; (2628/1.25!02.4)   // +2.5V
-// voltagefactor[2]=1.67/2628; (2628/1.6773.7)   // +3.3V
-// voltagefactor[3]=2.6/2628;  (2628/2.6010.8)   // +5V
-// voltagefactor[4]=6.3/2628;  (2628/6.30A7.14)   // +12V
-// in[i]=(data[i+2]*25.0+133)*voltagefactor[i];
-// That is:
-// volts = (25*regVal+133)*factor
-// regVal = (volts/factor-133)/25
-// (These conversions were contributed by Jonathan Teh Soon Yew 
-// <j.teh@iname.com>)
-// 
-// These get us close, but they don't completely agree with what my BIOS 
-// says- they are all a bit low.  But, it all we have to go on...
+********* VOLTAGE CONVERSIONS (Bob Dougherty) ********
+ From HWMon.cpp (Copyright 1998-2000 Jonathan Teh Soon Yew):
+ voltagefactor[0]=1.25/2628; (2628/1.25!02.4)   // Vccp
+ voltagefactor[1]=1.25/2628; (2628/1.25!02.4)   // +2.5V
+ voltagefactor[2]=1.67/2628; (2628/1.6773.7)   // +3.3V
+ voltagefactor[3]=2.6/2628;  (2628/2.6010.8)   // +5V
+ voltagefactor[4]=6.3/2628;  (2628/6.30A7.14)   // +12V
+ in[i]=(data[i+2]*25.0+133)*voltagefactor[i];
+ That is:
+ volts = (25*regVal+133)*factor
+ regVal = (volts/factor-133)/25
+ (These conversions were contributed by Jonathan Teh Soon Yew 
+ <j.teh@iname.com>)
+ 
+ These get us close, but they don't completely agree with what my BIOS 
+ says- they are all a bit low.  But, it all we have to go on... */
 static inline u8 IN_TO_REG(long val, int inNum)
 {
-	// to avoid floating point, we multiply everything by 100.
-	// val is guaranteed to be positive, so we can achieve the effect of 
-	// rounding by (...*10+5)/10.  Note that the *10 is hidden in the 
-	// /250 (which should really be /2500).
-	// At the end, we need to /100 because we *100 everything and we need
-	// to /10 because of the rounding thing, so we /1000.  
+	/* to avoid floating point, we multiply everything by 100.
+	 val is guaranteed to be positive, so we can achieve the effect of 
+	 rounding by (...*10+5)/10.  Note that the *10 is hidden in the 
+	 /250 (which should really be /2500).
+	 At the end, we need to /100 because we *100 everything and we need
+	 to /10 because of the rounding thing, so we /1000.   */
 	if (inNum <= 1)
 		return (u8)
 		    SENSORS_LIMIT(((val * 210240 - 13300) / 250 + 5) / 1000, 
@@ -155,10 +154,10 @@
 
 static inline long IN_FROM_REG(u8 val, int inNum)
 {
-	// to avoid floating point, we multiply everything by 100.
-	// val is guaranteed to be positive, so we can achieve the effect of
-	// rounding by adding 0.5.  Or, to avoid fp math, we do (...*10+5)/10.
-	// We need to scale with *100 anyway, so no need to /100 at the end.
+	/* to avoid floating point, we multiply everything by 100.
+	 val is guaranteed to be positive, so we can achieve the effect of
+	 rounding by adding 0.5.  Or, to avoid fp math, we do (...*10+5)/10.
+	 We need to scale with *100 anyway, so no need to /100 at the end. */
 	if (inNum <= 1)
 		return (long) (((250000 * val + 13300) / 210240 * 10 + 5) /10);
 	else if (inNum = 2)
@@ -170,9 +169,9 @@
 }
 
 /********* FAN RPM CONVERSIONS ********/
-// Higher register values = slower fans (the fan's strobe gates a counter).
-// But this chip saturates back at 0, not at 255 like all the other chips.
-// So, 0 means 0 RPM
+/* Higher register values = slower fans (the fan's strobe gates a counter).
+ But this chip saturates back at 0, not at 255 like all the other chips.
+ So, 0 means 0 RPM */
 static inline u8 FAN_TO_REG(long rpm, int div)
 {
 	if (rpm = 0)
@@ -184,37 +183,37 @@
 #define FAN_FROM_REG(val,div) ((val)=0?0:(val)=255?0:1350000/((val)*(div)))
 
 /******** TEMP CONVERSIONS (Bob Dougherty) *********/
-// linear fits from HWMon.cpp (Copyright 1998-2000 Jonathan Teh Soon Yew)
-//      if(temp<169)
-//              return double(temp)*0.427-32.08;
-//      else if(temp>9 && temp< 2)
-//              return double(temp)*0.582-58.16;
-//      else
-//              return double(temp)*0.924-127.33;
-//
-// A fifth-order polynomial fits the unofficial data (provided by Alex van 
-// Kaam <darkside@chello.nl>) a bit better.  It also give more reasonable 
-// numbers on my machine (ie. they agree with what my BIOS tells me).  
-// Here's the fifth-order fit to the 8-bit data:
-// temp = 1.625093e-10*val^5 - 1.001632e-07*val^4 + 2.457653e-05*val^3 - 
-//        2.967619e-03*val^2 + 2.175144e-01*val - 7.090067e+0.
-//
-// (2000-10-25- RFD: thanks to Uwe Andersen <uandersen@mayah.com> for 
-// finding my typos in this formula!)
-//
-// Alas, none of the elegant function-fit solutions will work because we 
-// aren't allowed to use floating point in the kernel and doing it with 
-// integers doesn't rpovide enough precision.  So we'll do boring old 
-// look-up table stuff.  The unofficial data (see below) have effectively 
-// 7-bit resolution (they are rounded to the nearest degree).  I'm assuming 
-// that the transfer function of the device is monotonic and smooth, so a 
-// smooth function fit to the data will allow us to get better precision.  
-// I used the 5th-order poly fit described above and solved for
-// VIA register values 0-255.  I *10 before rounding, so we get tenth-degree 
-// precision.  (I could have done all 1024 values for our 10-bit readings, 
-// but the function is very linear in the useful range (0-80 deg C), so 
-// we'll just use linear interpolation for 10-bit readings.)  So, tempLUT 
-// is the temp at via register values 0-255:
+/* linear fits from HWMon.cpp (Copyright 1998-2000 Jonathan Teh Soon Yew)
+      if(temp<169)
+              return double(temp)*0.427-32.08;
+      else if(temp>9 && temp< 2)
+              return double(temp)*0.582-58.16;
+      else
+              return double(temp)*0.924-127.33;
+
+ A fifth-order polynomial fits the unofficial data (provided by Alex van 
+ Kaam <darkside@chello.nl>) a bit better.  It also give more reasonable 
+ numbers on my machine (ie. they agree with what my BIOS tells me).  
+ Here's the fifth-order fit to the 8-bit data:
+ temp = 1.625093e-10*val^5 - 1.001632e-07*val^4 + 2.457653e-05*val^3 - 
+        2.967619e-03*val^2 + 2.175144e-01*val - 7.090067e+0.
+
+ (2000-10-25- RFD: thanks to Uwe Andersen <uandersen@mayah.com> for 
+ finding my typos in this formula!)
+
+ Alas, none of the elegant function-fit solutions will work because we 
+ aren't allowed to use floating point in the kernel and doing it with 
+ integers doesn't rpovide enough precision.  So we'll do boring old 
+ look-up table stuff.  The unofficial data (see below) have effectively 
+ 7-bit resolution (they are rounded to the nearest degree).  I'm assuming 
+ that the transfer function of the device is monotonic and smooth, so a 
+ smooth function fit to the data will allow us to get better precision.  
+ I used the 5th-order poly fit described above and solved for
+ VIA register values 0-255.  I *10 before rounding, so we get tenth-degree 
+ precision.  (I could have done all 1024 values for our 10-bit readings, 
+ but the function is very linear in the useful range (0-80 deg C), so 
+ we'll just use linear interpolation for 10-bit readings.)  So, tempLUT 
+ is the temp at via register values 0-255: */
 static const long tempLUT[]      { -709, -688, -667, -646, -627, -607, -589, -570, -553, -536, -519,
 	    -503, -487, -471, -456, -442, -428, -414, -400, -387, -375,
@@ -252,15 +251,15 @@
 45,46,46,47,48,48,49,49,50,51,51,52,52,53,53,54,55,55,56,57,57,58,59,59,60,
 61,62,62,63,64,65,66,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,83,84,
 85,86,88,89,91,92,94,96,97,99,101,103,105,107,109,110};
-*/
 
-// Here's the reverse LUT.  I got it by doing a 6-th order poly fit (needed
-// an extra term for a good fit to these inverse data!) and then 
-// solving for each temp value from -50 to 110 (the useable range for 
-// this chip).  Here's the fit: 
-// viaRegVal = -1.160370e-10*val^6 +3.193693e-08*val^5 - 1.464447e-06*val^4 
-// - 2.525453e-04*val^3 + 1.424593e-02*val^2 + 2.148941e+00*val +7.275808e+01)
-// Note that n1:
+
+ Here's the reverse LUT.  I got it by doing a 6-th order poly fit (needed
+ an extra term for a good fit to these inverse data!) and then 
+ solving for each temp value from -50 to 110 (the useable range for 
+ this chip).  Here's the fit: 
+ viaRegVal = -1.160370e-10*val^6 +3.193693e-08*val^5 - 1.464447e-06*val^4 
+ - 2.525453e-04*val^3 + 1.424593e-02*val^2 + 2.148941e+00*val +7.275808e+01)
+ Note that n1: */
 static const u8 viaLUT[]      { 12, 12, 13, 14, 14, 15, 16, 16, 17, 18, 18, 19, 20, 20, 21, 22, 23,
 	    23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 35, 36, 37, 39, 40,
@@ -277,10 +276,10 @@
 	    239, 240
 };
 
-/* Converting temps to (8-bit) hyst and over registers */
-// No interpolation here.  Just check the limits and go.
-// The +5 effectively rounds off properly and the +50 is because 
-// the temps start at -50
+/* Converting temps to (8-bit) hyst and over registers 
+ No interpolation here.  Just check the limits and go.
+ The +5 effectively rounds off properly and the +50 is because 
+ the temps start at -50 */
 static inline u8 TEMP_TO_REG(long val)
 {
 	return (u8)
@@ -288,22 +287,22 @@
 				  ((val + 5) / 10 + 50))], 0, 255);
 }
 
-/* for 8-bit temperature hyst and over registers */
-// The temp values are already *10, so we don't need to do that.
-// But we _will_ round these off to the nearest degree with (...*10+5)/10
+/* for 8-bit temperature hyst and over registers 
+ The temp values are already *10, so we don't need to do that.
+ But we _will_ round these off to the nearest degree with (...*10+5)/10 */
 #define TEMP_FROM_REG(val) ((tempLUT[(val)]*10+5)/10)
 
-/* for 10-bit temperature readings */
-// You might _think_ this is too long to inline, but's it's really only
-// called once...
+/* for 10-bit temperature readings 
+ You might _think_ this is too long to inline, but's it's really only
+ called once... */
 static inline long TEMP_FROM_REG10(u16 val)
 {
-	// the temp values are already *10, so we don't need to do that.
+	/* the temp values are already *10, so we don't need to do that. */
 	long temp;
 	u16 eightBits = val >> 2;
 	u16 twoBits = val & 3;
 
-	// handle the extremes first (they won't interpolate well! ;-)
+	/* handle the extremes first (they won't interpolate well! ;-) */
 	if (val = 0)
 		return (long) tempLUT[0];
 	if (val = 1023)
@@ -312,11 +311,11 @@
 	if (twoBits = 0)
 		return (long) tempLUT[eightBits];
 	else {
-		// do some interpolation by multipying the lower and upper
-		// bounds by 25, 50 or 75, then /100.
+		/* do some interpolation by multipying the lower and upper
+		 bounds by 25, 50 or 75, then /100. */
 		temp = ((25 * (4 - twoBits)) * tempLUT[eightBits]
 			+ (25 * twoBits) * tempLUT[eightBits + 1]);
-		// increase the magnitude by 50 to achieve rounding.
+		/* increase the magnitude by 50 to achieve rounding. */
 		if (temp > 0)
 			temp += 50;
 		else
@@ -370,7 +369,6 @@
    dynamically allocated, at the same time when a new via686a client is
    allocated. */
 struct via686a_data {
-	struct semaphore lock;
 	int sysctl_id;
 
 	struct semaphore update_lock;
@@ -392,35 +390,267 @@
 static struct pci_dev *s_bridge;	/* pointer to the (only) via686a */
 
 static int via686a_attach_adapter(struct i2c_adapter *adapter);
-static int via686a_detect(struct i2c_adapter *adapter, int address,
-			  unsigned short flags, int kind);
+static int via686a_detect(struct i2c_adapter *adapter, int address, int kind);
 static int via686a_detach_client(struct i2c_client *client);
 
-static int via686a_read_value(struct i2c_client *client, u8 register);
-static void via686a_write_value(struct i2c_client *client, u8 register,
-				u8 value);
+static inline int via686a_read_value(struct i2c_client *client, u8 reg)
+{
+	return (inb_p(client->addr + reg));
+}
+
+static inline void via686a_write_value(struct i2c_client *client, u8 reg,
+				       u8 value)
+{
+	outb_p(value, client->addr + reg);
+}
+
 static void via686a_update_client(struct i2c_client *client);
 static void via686a_init_client(struct i2c_client *client);
 
+/* following are the sysfs callback functions */
 
-static void via686a_in(struct i2c_client *client, int operation,
-		       int ctl_name, int *nrels_mag, long *results);
-static void via686a_fan(struct i2c_client *client, int operation,
-			int ctl_name, int *nrels_mag, long *results);
-static void via686a_temp(struct i2c_client *client, int operation,
-			 int ctl_name, int *nrels_mag, long *results);
-static void via686a_alarms(struct i2c_client *client, int operation,
-			   int ctl_name, int *nrels_mag, long *results);
-static void via686a_fan_div(struct i2c_client *client, int operation,
-			    int ctl_name, int *nrels_mag, long *results);
-
-static int via686a_id = 0;
+/* 7 voltage sensors */
+static ssize_t show_in(struct device *dev, char *buf, int nr) {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct via686a_data *data = i2c_get_clientdata(client);
+	via686a_update_client(client);
+	return sprintf(buf, "%ld\n", IN_FROM_REG(data->in[nr], nr)*10 );
+}
+
+static ssize_t show_in_min(struct device *dev, char *buf, int nr) {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct via686a_data *data = i2c_get_clientdata(client);
+	via686a_update_client(client);
+	return sprintf(buf, "%ld\n", IN_FROM_REG(data->in_min[nr], nr)*10 );
+}
+
+static ssize_t show_in_max(struct device *dev, char *buf, int nr) {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct via686a_data *data = i2c_get_clientdata(client);
+	via686a_update_client(client);
+	return sprintf(buf, "%ld\n", IN_FROM_REG(data->in_max[nr], nr)*10 );
+}
+
+static ssize_t set_in_min(struct device *dev, const char *buf, 
+		size_t count, int nr) {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct via686a_data *data = i2c_get_clientdata(client);
+	unsigned long val = simple_strtoul(buf, NULL, 10)/10;
+	data->in_min[nr] = IN_TO_REG(val,nr);
+	via686a_write_value(client, VIA686A_REG_IN_MIN(nr), 
+			data->in_min[nr]);
+	return count;
+}
+static ssize_t set_in_max(struct device *dev, const char *buf, 
+		size_t count, int nr) {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct via686a_data *data = i2c_get_clientdata(client);
+	unsigned long val = simple_strtoul(buf, NULL, 10)/10;
+	data->in_max[nr] = IN_TO_REG(val,nr);
+	via686a_write_value(client, VIA686A_REG_IN_MAX(nr), 
+			data->in_max[nr]);
+	return count;
+}
+#define show_in_offset(offset)					\
+static ssize_t 							\
+	show_in##offset (struct device *dev, char *buf)		\
+{								\
+	return show_in(dev, buf, 0x##offset);			\
+}								\
+static ssize_t 							\
+	show_in##offset##_min (struct device *dev, char *buf)	\
+{								\
+	return show_in_min(dev, buf, 0x##offset);		\
+}								\
+static ssize_t 							\
+	show_in##offset##_max (struct device *dev, char *buf)	\
+{								\
+	return show_in_max(dev, buf, 0x##offset);		\
+}								\
+static ssize_t set_in##offset##_min (struct device *dev, 	\
+		const char *buf, size_t count) 			\
+{								\
+	return set_in_min(dev, buf, count, 0x##offset);		\
+}								\
+static ssize_t set_in##offset##_max (struct device *dev,	\
+			const char *buf, size_t count)		\
+{								\
+	return set_in_max(dev, buf, count, 0x##offset);		\
+}								\
+static DEVICE_ATTR(in_input##offset, S_IRUGO, show_in##offset, NULL) 	\
+static DEVICE_ATTR(in_min##offset, S_IRUGO | S_IWUSR, 		\
+		show_in##offset##_min, set_in##offset##_min)	\
+static DEVICE_ATTR(in_max##offset, S_IRUGO | S_IWUSR, 		\
+		show_in##offset##_max, set_in##offset##_max)
+
+show_in_offset(0);
+show_in_offset(1);
+show_in_offset(2);
+show_in_offset(3);
+show_in_offset(4);
+
+/* 3 temperatures */
+static ssize_t show_temp(struct device *dev, char *buf, int nr) {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct via686a_data *data = i2c_get_clientdata(client);
+	via686a_update_client(client);
+	return sprintf(buf, "%ld\n", TEMP_FROM_REG10(data->temp[nr])*10 );
+}
+/* more like overshoot temperature */
+static ssize_t show_temp_max(struct device *dev, char *buf, int nr) {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct via686a_data *data = i2c_get_clientdata(client);
+	via686a_update_client(client);
+	return sprintf(buf, "%ld\n", TEMP_FROM_REG(data->temp_over[nr])*10);
+}
+/* more like hysteresis temperature */
+static ssize_t show_temp_min(struct device *dev, char *buf, int nr) {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct via686a_data *data = i2c_get_clientdata(client);
+	via686a_update_client(client);
+	return sprintf(buf, "%ld\n", TEMP_FROM_REG(data->temp_hyst[nr])*10);
+}
+static ssize_t set_temp_max(struct device *dev, const char *buf, 
+		size_t count, int nr) {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct via686a_data *data = i2c_get_clientdata(client);
+	int val = simple_strtol(buf, NULL, 10)/10;
+	data->temp_over[nr] = TEMP_TO_REG(val);
+	via686a_write_value(client, VIA686A_REG_TEMP_OVER(nr), data->temp_over[nr]);
+	return count;
+}
+static ssize_t set_temp_min(struct device *dev, const char *buf, 
+		size_t count, int nr) {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct via686a_data *data = i2c_get_clientdata(client);
+	int val = simple_strtol(buf, NULL, 10)/10;
+	data->temp_hyst[nr] = TEMP_TO_REG(val);
+	via686a_write_value(client, VIA686A_REG_TEMP_HYST(nr), data->temp_hyst[nr]);
+	return count;
+}
+#define show_temp_offset(offset)					\
+static ssize_t show_temp_##offset (struct device *dev, char *buf)	\
+{									\
+	return show_temp(dev, buf, 0x##offset - 1);			\
+}									\
+static ssize_t								\
+show_temp_##offset##_max (struct device *dev, char *buf)		\
+{									\
+	return show_temp_max(dev, buf, 0x##offset - 1);			\
+}									\
+static ssize_t								\
+show_temp_##offset##_min (struct device *dev, char *buf)		\
+{									\
+	return show_temp_min(dev, buf, 0x##offset - 1);			\
+}									\
+static ssize_t set_temp_##offset##_max (struct device *dev, 		\
+		const char *buf, size_t count) 				\
+{									\
+	return set_temp_max(dev, buf, count, 0x##offset - 1);		\
+}									\
+static ssize_t set_temp_##offset##_min (struct device *dev, 		\
+		const char *buf, size_t count) 				\
+{									\
+	return set_temp_min(dev, buf, count, 0x##offset - 1);		\
+}									\
+static DEVICE_ATTR(temp_input##offset, S_IRUGO, show_temp_##offset, NULL) \
+static DEVICE_ATTR(temp_max##offset, S_IRUGO | S_IWUSR, 		\
+		show_temp_##offset##_max, set_temp_##offset##_max) 	\
+static DEVICE_ATTR(temp_min##offset, S_IRUGO | S_IWUSR, 		\
+		show_temp_##offset##_min, set_temp_##offset##_min)	
+
+show_temp_offset(1);
+show_temp_offset(2);
+show_temp_offset(3);
+
+/* 2 Fans */
+static ssize_t show_fan(struct device *dev, char *buf, int nr) {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct via686a_data *data = i2c_get_clientdata(client);
+	via686a_update_client(client);
+	return sprintf(buf,"%d\n", FAN_FROM_REG(data->fan[nr], 
+				DIV_FROM_REG(data->fan_div[nr])) );
+}
+static ssize_t show_fan_min(struct device *dev, char *buf, int nr) {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct via686a_data *data = i2c_get_clientdata(client);
+	via686a_update_client(client);
+	return sprintf(buf,"%d\n",
+		FAN_FROM_REG(data->fan_min[nr], DIV_FROM_REG(data->fan_div[nr])) );
+}
+static ssize_t show_fan_div(struct device *dev, char *buf, int nr) {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct via686a_data *data = i2c_get_clientdata(client);
+	via686a_update_client(client);
+	return sprintf(buf,"%d\n", DIV_FROM_REG(data->fan_div[nr]) );
+}
+static ssize_t set_fan_min(struct device *dev, const char *buf, 
+		size_t count, int nr) {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct via686a_data *data = i2c_get_clientdata(client);
+	int val = simple_strtol(buf, NULL, 10);
+	data->fan_min[nr] = FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
+	via686a_write_value(client, VIA686A_REG_FAN_MIN(nr+1), data->fan_min[nr]);
+	return count;
+}
+static ssize_t set_fan_div(struct device *dev, const char *buf, 
+		size_t count, int nr) {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct via686a_data *data = i2c_get_clientdata(client);
+	int val = simple_strtol(buf, NULL, 10);
+	int old = via686a_read_value(client, VIA686A_REG_FANDIV);
+	data->fan_div[nr] = DIV_TO_REG(val);
+	old = (old & 0x0f) | (data->fan_div[1] << 6) | (data->fan_div[0] << 4);
+	via686a_write_value(client, VIA686A_REG_FANDIV, old);
+	return count;
+}
+
+#define show_fan_offset(offset)						\
+static ssize_t show_fan_##offset (struct device *dev, char *buf)	\
+{									\
+	return show_fan(dev, buf, 0x##offset - 1);			\
+}									\
+static ssize_t show_fan_##offset##_min (struct device *dev, char *buf)	\
+{									\
+	return show_fan_min(dev, buf, 0x##offset - 1);			\
+}									\
+static ssize_t show_fan_##offset##_div (struct device *dev, char *buf)	\
+{									\
+	return show_fan_div(dev, buf, 0x##offset - 1);			\
+}									\
+static ssize_t set_fan_##offset##_min (struct device *dev, 		\
+	const char *buf, size_t count) 					\
+{									\
+	return set_fan_min(dev, buf, count, 0x##offset - 1);		\
+}									\
+static ssize_t set_fan_##offset##_div (struct device *dev, 		\
+		const char *buf, size_t count) 				\
+{									\
+	return set_fan_div(dev, buf, count, 0x##offset - 1);		\
+}									\
+static DEVICE_ATTR(fan_input##offset, S_IRUGO, show_fan_##offset, NULL) \
+static DEVICE_ATTR(fan_min##offset, S_IRUGO | S_IWUSR, 			\
+		show_fan_##offset##_min, set_fan_##offset##_min) 	\
+static DEVICE_ATTR(fan_div##offset, S_IRUGO | S_IWUSR, 			\
+		show_fan_##offset##_div, set_fan_##offset##_div)
+
+show_fan_offset(1);
+show_fan_offset(2);
+
+/* Alarm */
+static ssize_t show_alarm(struct device *dev, char *buf) {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct via686a_data *data = i2c_get_clientdata(client);
+	via686a_update_client(client);
+	return sprintf(buf,"%d\n", ALARMS_FROM_REG(data->alarms));
+}
+static DEVICE_ATTR(alarm, S_IRUGO | S_IWUSR, show_alarm, NULL);
 
 /* The driver. I choose to use type i2c_driver, as at is identical to both
    smbus_driver and isa_driver, and clients could be of either kind */
 static struct i2c_driver via686a_driver = {
 	.owner		= THIS_MODULE,
-	.name		= "VIA 686A",
+	.name		= "VIA686A",
 	.id		= I2C_DRIVERID_VIA686A,
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= via686a_attach_adapter,
@@ -428,142 +658,33 @@
 };
 
 
-
-/* The /proc/sys entries */
-
-/* -- SENSORS SYSCTL START -- */
-#define VIA686A_SYSCTL_IN0 1000
-#define VIA686A_SYSCTL_IN1 1001
-#define VIA686A_SYSCTL_IN2 1002
-#define VIA686A_SYSCTL_IN3 1003
-#define VIA686A_SYSCTL_IN4 1004
-#define VIA686A_SYSCTL_FAN1 1101
-#define VIA686A_SYSCTL_FAN2 1102
-#define VIA686A_SYSCTL_TEMP 1200
-#define VIA686A_SYSCTL_TEMP2 1201
-#define VIA686A_SYSCTL_TEMP3 1202
-#define VIA686A_SYSCTL_FAN_DIV 2000
-#define VIA686A_SYSCTL_ALARMS 2001
-
-#define VIA686A_ALARM_IN0 0x01
-#define VIA686A_ALARM_IN1 0x02
-#define VIA686A_ALARM_IN2 0x04
-#define VIA686A_ALARM_IN3 0x08
-#define VIA686A_ALARM_TEMP 0x10
-#define VIA686A_ALARM_FAN1 0x40
-#define VIA686A_ALARM_FAN2 0x80
-#define VIA686A_ALARM_IN4 0x100
-#define VIA686A_ALARM_TEMP2 0x800
-#define VIA686A_ALARM_CHAS 0x1000
-#define VIA686A_ALARM_TEMP3 0x8000
-
-/* -- SENSORS SYSCTL END -- */
-
-/* These files are created for each detected VIA686A. This is just a template;
-   though at first sight, you might think we could use a statically
-   allocated list, we need some way to get back to the parent - which
-   is done through one of the 'extra' fields which are initialized 
-   when a new copy is allocated. */
-static ctl_table via686a_dir_table_template[] = {
-	{VIA686A_SYSCTL_IN0, "in0", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &via686a_in},
-	{VIA686A_SYSCTL_IN1, "in1", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &via686a_in},
-	{VIA686A_SYSCTL_IN2, "in2", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &via686a_in},
-	{VIA686A_SYSCTL_IN3, "in3", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &via686a_in},
-	{VIA686A_SYSCTL_IN4, "in4", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &via686a_in},
-	{VIA686A_SYSCTL_FAN1, "fan1", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &via686a_fan},
-	{VIA686A_SYSCTL_FAN2, "fan2", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &via686a_fan},
-	{VIA686A_SYSCTL_TEMP, "temp1", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &via686a_temp},
-	{VIA686A_SYSCTL_TEMP2, "temp2", NULL, 0, 0644, NULL,
-	 &i2c_proc_real, &i2c_sysctl_real, NULL, &via686a_temp},
-	{VIA686A_SYSCTL_TEMP3, "temp3", NULL, 0, 0644, NULL,
-	 &i2c_proc_real, &i2c_sysctl_real, NULL, &via686a_temp},
-	{VIA686A_SYSCTL_FAN_DIV, "fan_div", NULL, 0, 0644, NULL,
-	 &i2c_proc_real, &i2c_sysctl_real, NULL, &via686a_fan_div},
-	{VIA686A_SYSCTL_ALARMS, "alarms", NULL, 0, 0444, NULL,
-	 &i2c_proc_real, &i2c_sysctl_real, NULL, &via686a_alarms},
-	{0}
-};
-
-static inline int via686a_read_value(struct i2c_client *client, u8 reg)
-{
-	return (inb_p(client->addr + reg));
-}
-
-static inline void via686a_write_value(struct i2c_client *client, u8 reg,
-				       u8 value)
-{
-	outb_p(value, client->addr + reg);
-}
-
 /* This is called when the module is loaded */
 static int via686a_attach_adapter(struct i2c_adapter *adapter)
 {
 	return i2c_detect(adapter, &addr_data, via686a_detect);
 }
 
-/* Locate chip and get correct base address */
-static int via686a_find(int *address)
+static int via686a_detect(struct i2c_adapter *adapter, int address, int kind)
 {
-	u16 val;
-
-	if (!pci_present())
-		return -ENODEV;
-
-	if (!(s_bridge = pci_find_device(PCI_VENDOR_ID_VIA,
-					 PCI_DEVICE_ID_VIA_82C686_4,
-					 NULL)))
-		return -ENODEV;
-
-	if (PCIBIOS_SUCCESSFUL !-	    pci_read_config_word(s_bridge, VIA686A_BASE_REG, &val))
-		return -ENODEV;
-	*address = val & ~(VIA686A_EXTENT - 1);
-	if (*address = 0 && force_addr = 0) {
-		printk("via686a.o: base address not set - upgrade BIOS or use force_addr=0xaddr\n");
-		return -ENODEV;
-	}
-	if (force_addr)
-		*address = force_addr;	/* so detect will get called */
-
-	return 0;
-}
-
-int via686a_detect(struct i2c_adapter *adapter, int address,
-		   unsigned short flags, int kind)
-{
-	int i;
 	struct i2c_client *new_client;
 	struct via686a_data *data;
 	int err = 0;
-	const char *type_name = "via686a";
+	const char client_name[] = "via686a chip";
 	u16 val;
 
 	/* Make sure we are probing the ISA bus!!  */
 	if (!i2c_is_isa_adapter(adapter)) {
-		printk
-		("via686a.o: via686a_detect called for an I2C bus adapter?!?\n");
+		dev_err(&adapter->dev,
+		"via686a_detect called for an I2C bus adapter?!?\n");
 		return 0;
 	}
 
 	/* 8231 requires multiple of 256, we enforce that on 686 as well */
 	if(force_addr)
 		address = force_addr & 0xFF00;
-	if (check_region(address, VIA686A_EXTENT)) {
-		printk("via686a.o: region 0x%x already in use!\n",
-		       address);
-		return -ENODEV;
-	}
 
 	if(force_addr) {
-		printk("via686a.o: forcing ISA address 0x%04X\n", address);
+		dev_warn(&adapter->dev,"forcing ISA address 0x%04X\n", address);
 		if (PCIBIOS_SUCCESSFUL ! 		    pci_write_config_word(s_bridge, VIA686A_BASE_REG, address))
 			return -ENODEV;
@@ -572,13 +693,20 @@
 	    pci_read_config_word(s_bridge, VIA686A_ENABLE_REG, &val))
 		return -ENODEV;
 	if (!(val & 0x0001)) {
-		printk("via686a.o: enabling sensors\n");
+		dev_warn(&adapter->dev,"enabling sensors\n");
 		if (PCIBIOS_SUCCESSFUL ! 		    pci_write_config_word(s_bridge, VIA686A_ENABLE_REG,
 		                      val | 0x0001))
 			return -ENODEV;
 	}
 
+	/* Reserve the ISA region */
+	if (!request_region(address, VIA686A_EXTENT, "via686a-sensor")) {
+		dev_err(&adapter->dev,"region 0x%x already in use!\n",
+		       address);
+		return -ENODEV;
+	}
+
 	if (!(new_client = kmalloc(sizeof(struct i2c_client) +
 				   sizeof(struct via686a_data),
 				   GFP_KERNEL))) {
@@ -586,43 +714,62 @@
 		goto ERROR0;
 	}
 
+	memset(new_client,0x00, sizeof(struct i2c_client) +
+				sizeof(struct via686a_data));
 	data = (struct via686a_data *) (new_client + 1);
+	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
-	init_MUTEX(&data->lock);
-	new_client->data = data;
 	new_client->adapter = adapter;
 	new_client->driver = &via686a_driver;
 	new_client->flags = 0;
-
-	/* Reserve the ISA region */
-	request_region(address, VIA686A_EXTENT, "via686a-sensors");
+	new_client->dev.parent = &adapter->dev;
 
 	/* Fill in the remaining client fields and put into the global list */
-	strcpy(new_client->name, "Via 686A Integrated Sensors");
+	snprintf(new_client->dev.name, DEVICE_NAME_SIZE, client_name);
 
-	new_client->id = via686a_id++;
 	data->valid = 0;
 	init_MUTEX(&data->update_lock);
-
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(new_client)))
 		goto ERROR3;
-
-	/* Register a new directory entry with module sensors */
-	if ((i = i2c_register_entry((struct i2c_client *) new_client,
-					type_name,
-					via686a_dir_table_template)) < 0) {
-		err = i;
-		goto ERROR4;
-	}
-	data->sysctl_id = i;
+	
+	/* register sysfs hooks */
+	device_create_file(&new_client->dev, &dev_attr_in_input0);
+	device_create_file(&new_client->dev, &dev_attr_in_input1);
+	device_create_file(&new_client->dev, &dev_attr_in_input2);
+	device_create_file(&new_client->dev, &dev_attr_in_input3);
+	device_create_file(&new_client->dev, &dev_attr_in_input4);
+	device_create_file(&new_client->dev, &dev_attr_in_min0);
+	device_create_file(&new_client->dev, &dev_attr_in_min1);
+	device_create_file(&new_client->dev, &dev_attr_in_min2);
+	device_create_file(&new_client->dev, &dev_attr_in_min3);
+	device_create_file(&new_client->dev, &dev_attr_in_min4);
+	device_create_file(&new_client->dev, &dev_attr_in_max0);
+	device_create_file(&new_client->dev, &dev_attr_in_max1);
+	device_create_file(&new_client->dev, &dev_attr_in_max2);
+	device_create_file(&new_client->dev, &dev_attr_in_max3);
+	device_create_file(&new_client->dev, &dev_attr_in_max4);
+	device_create_file(&new_client->dev, &dev_attr_temp_input1);
+	device_create_file(&new_client->dev, &dev_attr_temp_input2);
+	device_create_file(&new_client->dev, &dev_attr_temp_input3);
+	device_create_file(&new_client->dev, &dev_attr_temp_max1);
+	device_create_file(&new_client->dev, &dev_attr_temp_max2);
+	device_create_file(&new_client->dev, &dev_attr_temp_max3);
+	device_create_file(&new_client->dev, &dev_attr_temp_min1);
+	device_create_file(&new_client->dev, &dev_attr_temp_min2);
+	device_create_file(&new_client->dev, &dev_attr_temp_min3);
+	device_create_file(&new_client->dev, &dev_attr_fan_input1);
+	device_create_file(&new_client->dev, &dev_attr_fan_input2);
+	device_create_file(&new_client->dev, &dev_attr_fan_min1);
+	device_create_file(&new_client->dev, &dev_attr_fan_min2);
+	device_create_file(&new_client->dev, &dev_attr_fan_div1);
+	device_create_file(&new_client->dev, &dev_attr_fan_div2);
+	device_create_file(&new_client->dev, &dev_attr_alarm);
 
 	/* Initialize the VIA686A chip */
 	via686a_init_client(new_client);
 	return 0;
 
-      ERROR4:
-	i2c_detach_client(new_client);
       ERROR3:
 	release_region(address, VIA686A_EXTENT);
 	kfree(new_client);
@@ -634,12 +781,9 @@
 {
 	int err;
 
-	i2c_deregister_entry(((struct via686a_data *) 
-				  (client->data))->sysctl_id);
-
 	if ((err = i2c_detach_client(client))) {
-		printk
-		("via686a.o: Client deregistration failed, client not detached.\n");
+		dev_err(&client->dev,
+		"Client deregistration failed, client not detached.\n");
 		return err;
 	}
 
@@ -688,7 +832,7 @@
 			    FAN_TO_REG(VIA686A_INIT_FAN_MIN, 2));
 	via686a_write_value(client, VIA686A_REG_FAN_MIN(2),
 			    FAN_TO_REG(VIA686A_INIT_FAN_MIN, 2));
-	for (i = 1; i <= 3; i++) {
+	for (i = 0; i <= 2; i++) {
 		via686a_write_value(client, VIA686A_REG_TEMP_OVER(i),
 				    TEMP_TO_REG(VIA686A_INIT_TEMP_OVER));
 		via686a_write_value(client, VIA686A_REG_TEMP_HYST(i),
@@ -706,13 +850,13 @@
 
 static void via686a_update_client(struct i2c_client *client)
 {
-	struct via686a_data *data = client->data;
+	struct via686a_data *data = i2c_get_clientdata(client);
 	int i;
 
 	down(&data->update_lock);
 
-       if (time_after(jiffies - data->last_updated, HZ + HZ / 2) ||
-           time_before(jiffies, data->last_updated) || !data->valid) {
+       if ((jiffies - data->last_updated > HZ + HZ / 2) ||
+           (jiffies < data->last_updated) || !data->valid) {
 
 		for (i = 0; i <= 4; i++) {
 			data->in[i] @@ -729,13 +873,13 @@
 			data->fan_min[i - 1] = via686a_read_value(client,
 						     VIA686A_REG_FAN_MIN(i));
 		}
-		for (i = 1; i <= 3; i++) {
-			data->temp[i - 1] = via686a_read_value(client,
+		for (i = 0; i <= 2; i++) {
+			data->temp[i] = via686a_read_value(client,
 						 VIA686A_REG_TEMP(i)) << 2;
-			data->temp_over[i - 1] +			data->temp_over[i]  			    via686a_read_value(client,
 					       VIA686A_REG_TEMP_OVER(i));
-			data->temp_hyst[i - 1] +			data->temp_hyst[i]  			    via686a_read_value(client,
 					       VIA686A_REG_TEMP_HYST(i));
 		}
@@ -768,150 +912,13 @@
 	up(&data->update_lock);
 }
 
-
-/* The next few functions are the call-back functions of the /proc/sys and
-   sysctl files. Which function is used is defined in the ctl_table in
-   the extra1 field.
-   Each function must return the magnitude (power of 10 to divide the date
-   with) if it is called with operation=SENSORS_PROC_REAL_INFO. It must
-   put a maximum of *nrels elements in results reflecting the data of this
-   file, and set *nrels to the number it actually put in it, if operation=
-   SENSORS_PROC_REAL_READ. Finally, it must get upto *nrels elements from
-   results and write them to the chip, if operations=SENSORS_PROC_REAL_WRITE.
-   Note that on SENSORS_PROC_REAL_READ, I do not check whether results is
-   large enough (by checking the incoming value of *nrels). This is not very
-   good practice, but as long as you put less than about 5 values in results,
-   you can assume it is large enough. */
-static void via686a_in(struct i2c_client *client, int operation, int ctl_name,
-               int *nrels_mag, long *results)
-{
-	struct via686a_data *data = client->data;
-	int nr = ctl_name - VIA686A_SYSCTL_IN0;
-
-	if (operation = SENSORS_PROC_REAL_INFO)
-		*nrels_mag = 2;
-	else if (operation = SENSORS_PROC_REAL_READ) {
-		via686a_update_client(client);
-		results[0] = IN_FROM_REG(data->in_min[nr], nr);
-		results[1] = IN_FROM_REG(data->in_max[nr], nr);
-		results[2] = IN_FROM_REG(data->in[nr], nr);
-		*nrels_mag = 3;
-	} else if (operation = SENSORS_PROC_REAL_WRITE) {
-		if (*nrels_mag >= 1) {
-			data->in_min[nr] = IN_TO_REG(results[0], nr);
-			via686a_write_value(client, VIA686A_REG_IN_MIN(nr),
-					    data->in_min[nr]);
-		}
-		if (*nrels_mag >= 2) {
-			data->in_max[nr] = IN_TO_REG(results[1], nr);
-			via686a_write_value(client, VIA686A_REG_IN_MAX(nr),
-					    data->in_max[nr]);
-		}
-	}
-}
-
-void via686a_fan(struct i2c_client *client, int operation, int ctl_name,
-		 int *nrels_mag, long *results)
-{
-	struct via686a_data *data = client->data;
-	int nr = ctl_name - VIA686A_SYSCTL_FAN1 + 1;
-
-	if (operation = SENSORS_PROC_REAL_INFO)
-		*nrels_mag = 0;
-	else if (operation = SENSORS_PROC_REAL_READ) {
-		via686a_update_client(client);
-		results[0] = FAN_FROM_REG(data->fan_min[nr - 1],
-					  DIV_FROM_REG(data->fan_div
-						       [nr - 1]));
-		results[1] = FAN_FROM_REG(data->fan[nr - 1],
-				 DIV_FROM_REG(data->fan_div[nr - 1]));
-		*nrels_mag = 2;
-	} else if (operation = SENSORS_PROC_REAL_WRITE) {
-		if (*nrels_mag >= 1) {
-			data->fan_min[nr - 1] = FAN_TO_REG(results[0], 
-							   DIV_FROM_REG(data->
-							      fan_div[nr -1]));
-			via686a_write_value(client,
-					    VIA686A_REG_FAN_MIN(nr),
-					    data->fan_min[nr - 1]);
-		}
-	}
-}
-
-void via686a_temp(struct i2c_client *client, int operation, int ctl_name,
-		  int *nrels_mag, long *results)
-{
-	struct via686a_data *data = client->data;
-	int nr = ctl_name - VIA686A_SYSCTL_TEMP;
-
-	if (operation = SENSORS_PROC_REAL_INFO)
-		*nrels_mag = 1;
-	else if (operation = SENSORS_PROC_REAL_READ) {
-		via686a_update_client(client);
-		results[0] = TEMP_FROM_REG(data->temp_over[nr]);
-		results[1] = TEMP_FROM_REG(data->temp_hyst[nr]);
-		results[2] = TEMP_FROM_REG10(data->temp[nr]);
-		*nrels_mag = 3;
-	} else if (operation = SENSORS_PROC_REAL_WRITE) {
-		if (*nrels_mag >= 1) {
-			data->temp_over[nr] = TEMP_TO_REG(results[0]);
-			via686a_write_value(client,
-					    VIA686A_REG_TEMP_OVER(nr + 1),
-					    data->temp_over[nr]);
-		}
-		if (*nrels_mag >= 2) {
-			data->temp_hyst[nr] = TEMP_TO_REG(results[1]);
-			via686a_write_value(client,
-					    VIA686A_REG_TEMP_HYST(nr + 1),
-					    data->temp_hyst[nr]);
-		}
-	}
-}
-
-void via686a_alarms(struct i2c_client *client, int operation, int ctl_name,
-		    int *nrels_mag, long *results)
-{
-	struct via686a_data *data = client->data;
-	if (operation = SENSORS_PROC_REAL_INFO)
-		*nrels_mag = 0;
-	else if (operation = SENSORS_PROC_REAL_READ) {
-		via686a_update_client(client);
-		results[0] = ALARMS_FROM_REG(data->alarms);
-		*nrels_mag = 1;
-	}
-}
-
-void via686a_fan_div(struct i2c_client *client, int operation,
-		     int ctl_name, int *nrels_mag, long *results)
-{
-	struct via686a_data *data = client->data;
-	int old;
-
-	if (operation = SENSORS_PROC_REAL_INFO)
-		*nrels_mag = 0;
-	else if (operation = SENSORS_PROC_REAL_READ) {
-		via686a_update_client(client);
-		results[0] = DIV_FROM_REG(data->fan_div[0]);
-		results[1] = DIV_FROM_REG(data->fan_div[1]);
-		*nrels_mag = 2;
-	} else if (operation = SENSORS_PROC_REAL_WRITE) {
-		old = via686a_read_value(client, VIA686A_REG_FANDIV);
-		if (*nrels_mag >= 2) {
-			data->fan_div[1] = DIV_TO_REG(results[1]);
-			old = (old & 0x3f) | (data->fan_div[1] << 6);
-		}
-		if (*nrels_mag >= 1) {
-			data->fan_div[0] = DIV_TO_REG(results[0]);
-			old = (old & 0xcf) | (data->fan_div[0] << 4);
-			via686a_write_value(client, VIA686A_REG_FANDIV,
-					    old);
-		}
-	}
-}
-
-
 static struct pci_device_id via686a_pci_ids[] __devinitdata = {
-       {PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+       {
+	       .vendor 		= PCI_VENDOR_ID_VIA, 
+	       .device 		= PCI_DEVICE_ID_VIA_82C686_4, 
+	       .subvendor	= PCI_ANY_ID, 
+	       .subdevice	= PCI_ANY_ID, 
+       },
        { 0, }
 };
 
@@ -927,14 +934,14 @@
 
        addr = val & ~(VIA686A_EXTENT - 1);
        if (addr = 0 && force_addr = 0) {
-               printk("via686a.o: base address not set - upgrade BIOS or use force_addr=0xaddr\n");
+               dev_err(&dev->dev,"base address not set - upgrade BIOS or use force_addr=0xaddr\n");
                return -ENODEV;
        }
        if (force_addr)
                addr = force_addr;      /* so detect will get called */
 
        if (!addr) {
-               printk("via686a.o: No Via 686A sensors found.\n");
+               dev_err(&dev->dev,"No Via 686A sensors found.\n");
                return -ENODEV;
        }
        normal_isa[0] = addr;
Index: kernel/chips/w83781d.c
=================================RCS file: /home/cvs/lm_sensors2/kernel/chips/w83781d.c,v
retrieving revision 1.99
diff -a -u -r1.99 w83781d.c
--- kernel/chips/w83781d.c	31 Jan 2003 04:00:33 -0000	1.99
+++ kernel/chips/w83781d.c	25 Apr 2003 18:29:31 -0000
@@ -35,30 +35,26 @@
 */
 
 #include <linux/module.h>
+#include <linux/init.h>
 #include <linux/slab.h>
-#include <linux/ioport.h>
-#include <linux/types.h>
 #include <linux/i2c.h>
-#include <linux/i2c-proc.h>
-#include <linux/init.h>
-#include <asm/errno.h>
+#include <linux/i2c-sensor.h>
+#include <linux/i2c-vid.h>
 #include <asm/io.h>
-#include "version.h"
-#include "sensors_vid.h"
 
 /* RT Table support #defined so we can take it out if it gets bothersome */
-#define W83781D_RT 1
+#define W83781D_RT			1
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { SENSORS_I2C_END };
-static unsigned short normal_i2c_range[] = { 0x20, 0x2f, SENSORS_I2C_END };
-static unsigned int normal_isa[] = { 0x0290, SENSORS_ISA_END };
-static unsigned int normal_isa_range[] = { SENSORS_ISA_END };
+static unsigned short normal_i2c[] = { I2C_CLIENT_END };
+static unsigned short normal_i2c_range[] = { 0x20, 0x2f, I2C_CLIENT_END };
+static unsigned int normal_isa[] = { 0x0290, I2C_CLIENT_ISA_END };
+static unsigned int normal_isa_range[] = { I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
 SENSORS_INSMOD_6(w83781d, w83782d, w83783s, w83627hf, as99127f, w83697hf);
-SENSORS_MODULE_PARM(force_subclients, "List of subclient addresses: " \
-                      "{bus, clientaddr, subclientaddr1, subclientaddr2}");
+I2C_CLIENT_MODULE_PARM(force_subclients, "List of subclient addresses: "
+		    "{bus, clientaddr, subclientaddr1, subclientaddr2}");
 
 static int init = 1;
 MODULE_PARM(init, "i");
@@ -67,135 +63,141 @@
 /* Constants specified below */
 
 /* Length of ISA address segment */
-#define W83781D_EXTENT 8
+#define W83781D_EXTENT			8
 
 /* Where are the ISA address/data registers relative to the base address */
-#define W83781D_ADDR_REG_OFFSET 5
-#define W83781D_DATA_REG_OFFSET 6
+#define W83781D_ADDR_REG_OFFSET		5
+#define W83781D_DATA_REG_OFFSET		6
 
 /* The W83781D registers */
 /* The W83782D registers for nr=7,8 are in bank 5 */
-#define W83781D_REG_IN_MAX(nr) ((nr < 7) ? (0x2b + (nr) * 2) : \
-					   (0x554 + (((nr) - 7) * 2)))
-#define W83781D_REG_IN_MIN(nr) ((nr < 7) ? (0x2c + (nr) * 2) : \
-					   (0x555 + (((nr) - 7) * 2)))
-#define W83781D_REG_IN(nr)     ((nr < 7) ? (0x20 + (nr)) : \
-					   (0x550 + (nr) - 7))
-
-#define W83781D_REG_FAN_MIN(nr) (0x3a + (nr))
-#define W83781D_REG_FAN(nr) (0x27 + (nr))
-
-#define W83781D_REG_TEMP2 0x0150
-#define W83781D_REG_TEMP3 0x0250
-#define W83781D_REG_TEMP2_HYST 0x153
-#define W83781D_REG_TEMP3_HYST 0x253
-#define W83781D_REG_TEMP2_CONFIG 0x152
-#define W83781D_REG_TEMP3_CONFIG 0x252
-#define W83781D_REG_TEMP2_OVER 0x155
-#define W83781D_REG_TEMP3_OVER 0x255
-
-#define W83781D_REG_TEMP 0x27
-#define W83781D_REG_TEMP_OVER 0x39
-#define W83781D_REG_TEMP_HYST 0x3A
-#define W83781D_REG_BANK 0x4E
-
-#define W83781D_REG_CONFIG 0x40
-#define W83781D_REG_ALARM1 0x41
-#define W83781D_REG_ALARM2 0x42
-#define W83781D_REG_ALARM3 0x450	/* not on W83781D */
-
-#define W83781D_REG_IRQ 0x4C
-#define W83781D_REG_BEEP_CONFIG 0x4D
-#define W83781D_REG_BEEP_INTS1 0x56
-#define W83781D_REG_BEEP_INTS2 0x57
-#define W83781D_REG_BEEP_INTS3 0x453	/* not on W83781D */
-
-#define W83781D_REG_VID_FANDIV 0x47
-
-#define W83781D_REG_CHIPID 0x49
-#define W83781D_REG_WCHIPID 0x58
-#define W83781D_REG_CHIPMAN 0x4F
-#define W83781D_REG_PIN 0x4B
+#define W83781D_REG_IN_MAX(nr)		((nr < 7) ? (0x2b + (nr) * 2) : \
+						    (0x554 + (((nr) - 7) * 2)))
+#define W83781D_REG_IN_MIN(nr)		((nr < 7) ? (0x2c + (nr) * 2) : \
+						    (0x555 + (((nr) - 7) * 2)))
+#define W83781D_REG_IN(nr)		((nr < 7) ? (0x20 + (nr)) : \
+						    (0x550 + (nr) - 7))
+
+#define W83781D_REG_FAN_MIN(nr)		(0x3a + (nr))
+#define W83781D_REG_FAN(nr)		(0x27 + (nr))
+
+#define W83781D_REG_BANK		0x4E
+#define W83781D_REG_TEMP2_CONFIG	0x152
+#define W83781D_REG_TEMP3_CONFIG	0x252
+#define W83781D_REG_TEMP(nr)		((nr = 3) ? (0x0250) : \
+					((nr = 2) ? (0x0150) : \
+						     (0x27)))
+#define W83781D_REG_TEMP_HYST(nr)	((nr = 3) ? (0x253) : \
+					((nr = 2) ? (0x153) : \
+						     (0x3A)))
+#define W83781D_REG_TEMP_OVER(nr)	((nr = 3) ? (0x255) : \
+					((nr = 2) ? (0x155) : \
+						     (0x39)))
+
+#define W83781D_REG_CONFIG		0x40
+#define W83781D_REG_ALARM1		0x41
+#define W83781D_REG_ALARM2		0x42
+#define W83781D_REG_ALARM3		0x450	/* not on W83781D */
+
+#define W83781D_REG_IRQ			0x4C
+#define W83781D_REG_BEEP_CONFIG		0x4D
+#define W83781D_REG_BEEP_INTS1		0x56
+#define W83781D_REG_BEEP_INTS2		0x57
+#define W83781D_REG_BEEP_INTS3		0x453	/* not on W83781D */
+
+#define W83781D_REG_VID_FANDIV		0x47
+
+#define W83781D_REG_CHIPID		0x49
+#define W83781D_REG_WCHIPID		0x58
+#define W83781D_REG_CHIPMAN		0x4F
+#define W83781D_REG_PIN			0x4B
 
 /* 782D/783S only */
-#define W83781D_REG_VBAT 0x5D
+#define W83781D_REG_VBAT		0x5D
 
 /* PWM 782D (1-4) and 783S (1-2) only */
-#define W83781D_REG_PWM1 0x5B	/* 782d and 783s/627hf datasheets disagree */
-				/* on which is which; */
-#define W83781D_REG_PWM2 0x5A	/* We follow the 782d convention here, */
-				/* However 782d is probably wrong. */
-#define W83781D_REG_PWM3 0x5E
-#define W83781D_REG_PWM4 0x5F
-#define W83781D_REG_PWMCLK12 0x5C
-#define W83781D_REG_PWMCLK34 0x45C
+#define W83781D_REG_PWM1		0x5B	/* 782d and 783s/627hf datasheets disagree */
+						/* on which is which; */
+#define W83781D_REG_PWM2		0x5A	/* We follow the 782d convention here, */
+						/* However 782d is probably wrong. */
+#define W83781D_REG_PWM3		0x5E
+#define W83781D_REG_PWM4		0x5F
+#define W83781D_REG_PWMCLK12		0x5C
+#define W83781D_REG_PWMCLK34		0x45C
 static const u8 regpwm[] = { W83781D_REG_PWM1, W83781D_REG_PWM2,
 	W83781D_REG_PWM3, W83781D_REG_PWM4
 };
-#define W83781D_REG_PWM(nr) (regpwm[(nr) - 1])
 
-#define W83781D_REG_I2C_ADDR 0x48
-#define W83781D_REG_I2C_SUBADDR 0x4A
+#define W83781D_REG_PWM(nr)		(regpwm[(nr) - 1])
+
+#define W83781D_REG_I2C_ADDR		0x48
+#define W83781D_REG_I2C_SUBADDR		0x4A
 
 /* The following are undocumented in the data sheets however we
    received the information in an email from Winbond tech support */
 /* Sensor selection - not on 781d */
-#define W83781D_REG_SCFG1 0x5D
+#define W83781D_REG_SCFG1		0x5D
 static const u8 BIT_SCFG1[] = { 0x02, 0x04, 0x08 };
-#define W83781D_REG_SCFG2 0x59
+
+#define W83781D_REG_SCFG2		0x59
 static const u8 BIT_SCFG2[] = { 0x10, 0x20, 0x40 };
-#define W83781D_DEFAULT_BETA 3435
+
+#define W83781D_DEFAULT_BETA		3435
 
 /* RT Table registers */
-#define W83781D_REG_RT_IDX 0x50
-#define W83781D_REG_RT_VAL 0x51
+#define W83781D_REG_RT_IDX		0x50
+#define W83781D_REG_RT_VAL		0x51
 
 /* Conversions. Rounding and limit checking is only done on the TO_REG
    variants. Note that you should be a bit careful with which arguments
    these macros are called: arguments may be evaluated more than once.
    Fixing this is just not worth it. */
-#define IN_TO_REG(val)  (SENSORS_LIMIT((((val) * 10 + 8)/16),0,255))
-#define IN_FROM_REG(val) (((val) * 16) / 10)
+#define IN_TO_REG(val)			(SENSORS_LIMIT((((val) * 10 + 8)/16),0,255))
+#define IN_FROM_REG(val)		(((val) * 16) / 10)
 
-static inline u8 FAN_TO_REG(long rpm, int div)
+static inline u8
+FAN_TO_REG(long rpm, int div)
 {
 	if (rpm = 0)
 		return 255;
 	rpm = SENSORS_LIMIT(rpm, 1, 1000000);
-	return SENSORS_LIMIT((1350000 + rpm * div / 2) / (rpm * div), 1,
-			     254);
+	return SENSORS_LIMIT((1350000 + rpm * div / 2) / (rpm * div), 1, 254);
 }
 
-#define FAN_FROM_REG(val,div) ((val)=0?-1:(val)=255?0:1350000/((val)*(div)))
+#define FAN_FROM_REG(val,div)		((val) = 0   ? -1 : \
+					((val) = 255 ? 0 : \
+							1350000 / ((val) * (div))))
 
-#define TEMP_TO_REG(val) (SENSORS_LIMIT(((val)<0?(((val)-5)/10):\
-                                                 ((val)+5)/10),0,255))
-#define TEMP_FROM_REG(val) (((val)>0x80?(val)-0x100:(val))*10)
+#define TEMP_TO_REG(val)		(SENSORS_LIMIT(((val / 10) < 0 ? (((val / 10) - 5) / 10) : \
+									 ((val / 10) + 5) / 10), 0, 255))
+#define TEMP_FROM_REG(val)		((((val ) > 0x80 ? (val) - 0x100 : (val)) * 10) * 10)
 
-#define TEMP_ADD_TO_REG(val)   (SENSORS_LIMIT(((((val) + 2) / 5) << 7),\
-                                              0,0xffff))
-#define TEMP_ADD_FROM_REG(val) (((val) >> 7) * 5)
+#define TEMP_ADD_TO_REG(val)		(SENSORS_LIMIT(((((val / 10) + 2) / 5) << 7),\
+                                              0, 0xffff))
+#define TEMP_ADD_FROM_REG(val)		((((val) >> 7) * 5) * 10)
 
-#define AS99127_TEMP_ADD_TO_REG(val) (SENSORS_LIMIT((((((val) + 2)*4)/10) \
-                                               << 7),0,0xffff))
-#define AS99127_TEMP_ADD_FROM_REG(val) ((((val) >> 7) * 10) / 4)
+#define AS99127_TEMP_ADD_TO_REG(val)	(SENSORS_LIMIT((((((val / 10) + 2)*4)/10) \
+                                               << 7), 0, 0xffff))
+#define AS99127_TEMP_ADD_FROM_REG(val)	(((((val) >> 7) * 10) / 4) * 10)
 
-#define ALARMS_FROM_REG(val) (val)
-#define PWM_FROM_REG(val) (val)
-#define PWM_TO_REG(val) (SENSORS_LIMIT((val),0,255))
-#define BEEPS_FROM_REG(val) (val)
-#define BEEPS_TO_REG(val) ((val) & 0xffffff)
+#define ALARMS_FROM_REG(val)		(val)
+#define PWM_FROM_REG(val)		(val)
+#define PWM_TO_REG(val)			(SENSORS_LIMIT((val),0,255))
+#define BEEP_MASK_FROM_REG(val)		(val)
+#define BEEP_MASK_TO_REG(val)		((val) & 0xffffff)
 
-#define BEEP_ENABLE_TO_REG(val)   ((val)?1:0)
-#define BEEP_ENABLE_FROM_REG(val) ((val)?1:0)
+#define BEEP_ENABLE_TO_REG(val)		((val) ? 1 : 0)
+#define BEEP_ENABLE_FROM_REG(val)	((val) ? 1 : 0)
 
-#define DIV_FROM_REG(val) (1 << (val))
+#define DIV_FROM_REG(val)		(1 << (val))
 
-static inline u8 DIV_TO_REG(long val, enum chips type)
+static inline u8
+DIV_TO_REG(long val, enum chips type)
 {
 	int i;
 	val = SENSORS_LIMIT(val, 1,
-		((type = w83781d || type = as99127f) ? 8 : 128)) >> 1;
+			    ((type = w83781d
+			      || type = as99127f) ? 8 : 128)) >> 1;
 	for (i = 0; i < 6; i++) {
 		if (val = 0)
 			break;
@@ -205,102 +207,70 @@
 }
 
 /* Initial limits */
-#define W83781D_INIT_IN_0 (vid=3500?280:vid/10)
-#define W83781D_INIT_IN_1 (vid=3500?280:vid/10)
-#define W83781D_INIT_IN_2 330
-#define W83781D_INIT_IN_3 (((500)   * 100)/168)
-#define W83781D_INIT_IN_4 (((1200)  * 10)/38)
-#define W83781D_INIT_IN_5 (((-1200) * -604)/2100)
-#define W83781D_INIT_IN_6 (((-500)  * -604)/909)
-#define W83781D_INIT_IN_7 (((500)   * 100)/168)
-#define W83781D_INIT_IN_8 300
+#define W83781D_INIT_IN_0		(vid = 3500 ? 280 : vid / 10)
+#define W83781D_INIT_IN_1		(vid = 3500 ? 280 : vid / 10)
+#define W83781D_INIT_IN_2		330
+#define W83781D_INIT_IN_3		(((500)   * 100) / 168)
+#define W83781D_INIT_IN_4		(((1200)  * 10) / 38)
+#define W83781D_INIT_IN_5		(((-1200) * -604) / 2100)
+#define W83781D_INIT_IN_6		(((-500)  * -604) / 909)
+#define W83781D_INIT_IN_7		(((500)   * 100) / 168)
+#define W83781D_INIT_IN_8		300
 /* Initial limits for 782d/783s negative voltages */
 /* Note level shift. Change min/max below if you change these. */
-#define W83782D_INIT_IN_5 ((((-1200) + 1491) * 100)/514)
-#define W83782D_INIT_IN_6 ((( (-500)  + 771) * 100)/314)
+#define W83782D_INIT_IN_5		((((-1200) + 1491) * 100)/514)
+#define W83782D_INIT_IN_6		((( (-500)  + 771) * 100)/314)
 
-#define W83781D_INIT_IN_PERCENTAGE 10
+#define W83781D_INIT_IN_PERCENTAGE	10
+#define W83781D_INIT_IN_MIN(val)	(val - val * W83781D_INIT_IN_PERCENTAGE / 100)
+#define W83781D_INIT_IN_MAX(val)	(val + val * W83781D_INIT_IN_PERCENTAGE / 100)
+
+#define W83781D_INIT_IN_MIN_0		W83781D_INIT_IN_MIN(W83781D_INIT_IN_0)
+#define W83781D_INIT_IN_MAX_0		W83781D_INIT_IN_MAX(W83781D_INIT_IN_0)
+#define W83781D_INIT_IN_MIN_1		W83781D_INIT_IN_MIN(W83781D_INIT_IN_1)
+#define W83781D_INIT_IN_MAX_1		W83781D_INIT_IN_MAX(W83781D_INIT_IN_1)
+#define W83781D_INIT_IN_MIN_2		W83781D_INIT_IN_MIN(W83781D_INIT_IN_2)
+#define W83781D_INIT_IN_MAX_2		W83781D_INIT_IN_MAX(W83781D_INIT_IN_2)
+#define W83781D_INIT_IN_MIN_3		W83781D_INIT_IN_MIN(W83781D_INIT_IN_3)
+#define W83781D_INIT_IN_MAX_3		W83781D_INIT_IN_MAX(W83781D_INIT_IN_3)
+#define W83781D_INIT_IN_MIN_4		W83781D_INIT_IN_MIN(W83781D_INIT_IN_4)
+#define W83781D_INIT_IN_MAX_4		W83781D_INIT_IN_MAX(W83781D_INIT_IN_4)
+#define W83781D_INIT_IN_MIN_5		W83781D_INIT_IN_MIN(W83781D_INIT_IN_5)
+#define W83781D_INIT_IN_MAX_5		W83781D_INIT_IN_MAX(W83781D_INIT_IN_5)
+#define W83781D_INIT_IN_MIN_6		W83781D_INIT_IN_MIN(W83781D_INIT_IN_6)
+#define W83781D_INIT_IN_MAX_6		W83781D_INIT_IN_MAX(W83781D_INIT_IN_6)
+#define W83781D_INIT_IN_MIN_7		W83781D_INIT_IN_MIN(W83781D_INIT_IN_7)
+#define W83781D_INIT_IN_MAX_7		W83781D_INIT_IN_MAX(W83781D_INIT_IN_7)
+#define W83781D_INIT_IN_MIN_8		W83781D_INIT_IN_MIN(W83781D_INIT_IN_8)
+#define W83781D_INIT_IN_MAX_8		W83781D_INIT_IN_MAX(W83781D_INIT_IN_8)
 
-#define W83781D_INIT_IN_MIN_0 \
-        (W83781D_INIT_IN_0 - W83781D_INIT_IN_0 * W83781D_INIT_IN_PERCENTAGE \
-         / 100)
-#define W83781D_INIT_IN_MAX_0 \
-        (W83781D_INIT_IN_0 + W83781D_INIT_IN_0 * W83781D_INIT_IN_PERCENTAGE \
-         / 100)
-#define W83781D_INIT_IN_MIN_1 \
-        (W83781D_INIT_IN_1 - W83781D_INIT_IN_1 * W83781D_INIT_IN_PERCENTAGE \
-         / 100)
-#define W83781D_INIT_IN_MAX_1 \
-        (W83781D_INIT_IN_1 + W83781D_INIT_IN_1 * W83781D_INIT_IN_PERCENTAGE \
-         / 100)
-#define W83781D_INIT_IN_MIN_2 \
-        (W83781D_INIT_IN_2 - W83781D_INIT_IN_2 * W83781D_INIT_IN_PERCENTAGE \
-         / 100)
-#define W83781D_INIT_IN_MAX_2 \
-        (W83781D_INIT_IN_2 + W83781D_INIT_IN_2 * W83781D_INIT_IN_PERCENTAGE \
-         / 100)
-#define W83781D_INIT_IN_MIN_3 \
-        (W83781D_INIT_IN_3 - W83781D_INIT_IN_3 * W83781D_INIT_IN_PERCENTAGE \
-         / 100)
-#define W83781D_INIT_IN_MAX_3 \
-        (W83781D_INIT_IN_3 + W83781D_INIT_IN_3 * W83781D_INIT_IN_PERCENTAGE \
-         / 100)
-#define W83781D_INIT_IN_MIN_4 \
-        (W83781D_INIT_IN_4 - W83781D_INIT_IN_4 * W83781D_INIT_IN_PERCENTAGE \
-         / 100)
-#define W83781D_INIT_IN_MAX_4 \
-        (W83781D_INIT_IN_4 + W83781D_INIT_IN_4 * W83781D_INIT_IN_PERCENTAGE \
-         / 100)
-#define W83781D_INIT_IN_MIN_5 \
-        (W83781D_INIT_IN_5 - W83781D_INIT_IN_5 * W83781D_INIT_IN_PERCENTAGE \
-         / 100)
-#define W83781D_INIT_IN_MAX_5 \
-        (W83781D_INIT_IN_5 + W83781D_INIT_IN_5 * W83781D_INIT_IN_PERCENTAGE \
-         / 100)
-#define W83781D_INIT_IN_MIN_6 \
-        (W83781D_INIT_IN_6 - W83781D_INIT_IN_6 * W83781D_INIT_IN_PERCENTAGE \
-         / 100)
-#define W83781D_INIT_IN_MAX_6 \
-        (W83781D_INIT_IN_6 + W83781D_INIT_IN_6 * W83781D_INIT_IN_PERCENTAGE \
-         / 100)
-#define W83781D_INIT_IN_MIN_7 \
-        (W83781D_INIT_IN_7 - W83781D_INIT_IN_7 * W83781D_INIT_IN_PERCENTAGE \
-         / 100)
-#define W83781D_INIT_IN_MAX_7 \
-        (W83781D_INIT_IN_7 + W83781D_INIT_IN_7 * W83781D_INIT_IN_PERCENTAGE \
-         / 100)
-#define W83781D_INIT_IN_MIN_8 \
-        (W83781D_INIT_IN_8 - W83781D_INIT_IN_8 * W83781D_INIT_IN_PERCENTAGE \
-         / 100)
-#define W83781D_INIT_IN_MAX_8 \
-        (W83781D_INIT_IN_8 + W83781D_INIT_IN_8 * W83781D_INIT_IN_PERCENTAGE \
-         / 100)
 /* Initial limits for 782d/783s negative voltages */
 /* These aren't direct multiples because of level shift */
 /* Beware going negative - check */
 #define W83782D_INIT_IN_MIN_5_TMP \
-        (((-1200 * (100 + W83781D_INIT_IN_PERCENTAGE)) + (1491 * 100))/514)
+	(((-1200 * (100 + W83781D_INIT_IN_PERCENTAGE)) + (1491 * 100))/514)
 #define W83782D_INIT_IN_MIN_5 \
-        ((W83782D_INIT_IN_MIN_5_TMP > 0) ? W83782D_INIT_IN_MIN_5_TMP : 0)
+	((W83782D_INIT_IN_MIN_5_TMP > 0) ? W83782D_INIT_IN_MIN_5_TMP : 0)
 #define W83782D_INIT_IN_MAX_5 \
-        (((-1200 * (100 - W83781D_INIT_IN_PERCENTAGE)) + (1491 * 100))/514)
+	(((-1200 * (100 - W83781D_INIT_IN_PERCENTAGE)) + (1491 * 100))/514)
 #define W83782D_INIT_IN_MIN_6_TMP \
-        ((( -500 * (100 + W83781D_INIT_IN_PERCENTAGE)) +  (771 * 100))/314)
+	((( -500 * (100 + W83781D_INIT_IN_PERCENTAGE)) +  (771 * 100))/314)
 #define W83782D_INIT_IN_MIN_6 \
-        ((W83782D_INIT_IN_MIN_6_TMP > 0) ? W83782D_INIT_IN_MIN_6_TMP : 0)
+	((W83782D_INIT_IN_MIN_6_TMP > 0) ? W83782D_INIT_IN_MIN_6_TMP : 0)
 #define W83782D_INIT_IN_MAX_6 \
-        ((( -500 * (100 - W83781D_INIT_IN_PERCENTAGE)) +  (771 * 100))/314)
+	((( -500 * (100 - W83781D_INIT_IN_PERCENTAGE)) +  (771 * 100))/314)
 
-#define W83781D_INIT_FAN_MIN_1 3000
-#define W83781D_INIT_FAN_MIN_2 3000
-#define W83781D_INIT_FAN_MIN_3 3000
-
-#define W83781D_INIT_TEMP_OVER 600
-#define W83781D_INIT_TEMP_HYST 1270	/* must be 127 for ALARM to work */
-#define W83781D_INIT_TEMP2_OVER 600
-#define W83781D_INIT_TEMP2_HYST 500
-#define W83781D_INIT_TEMP3_OVER 600
-#define W83781D_INIT_TEMP3_HYST 500
+#define W83781D_INIT_FAN_MIN_1		3000
+#define W83781D_INIT_FAN_MIN_2		3000
+#define W83781D_INIT_FAN_MIN_3		3000
+
+/* temp = value / 100 */
+#define W83781D_INIT_TEMP_OVER		6000
+#define W83781D_INIT_TEMP_HYST		12700	/* must be 127 for ALARM to work */
+#define W83781D_INIT_TEMP2_OVER		6000
+#define W83781D_INIT_TEMP2_HYST		5000
+#define W83781D_INIT_TEMP3_OVER		6000
+#define W83781D_INIT_TEMP3_HYST		5000
 
 /* There are some complications in a module like this. First off, W83781D chips
    may be both present on the SMBus and the ISA bus, and we have to handle
@@ -323,7 +293,6 @@
    allocated. */
 struct w83781d_data {
 	struct semaphore lock;
-	int sysctl_id;
 	enum chips type;
 
 	struct semaphore update_lock;
@@ -339,18 +308,18 @@
 	u8 fan[3];		/* Register value */
 	u8 fan_min[3];		/* Register value */
 	u8 temp;
-	u8 temp_over;		/* Register value */
-	u8 temp_hyst;		/* Register value */
+	u8 temp_min;		/* Register value */
+	u8 temp_max;		/* Register value */
 	u16 temp_add[2];	/* Register value */
-	u16 temp_add_over[2];	/* Register value */
-	u16 temp_add_hyst[2];	/* Register value */
+	u16 temp_max_add[2];	/* Register value */
+	u16 temp_min_add[2];	/* Register value */
 	u8 fan_div[3];		/* Register encoding, shifted right */
 	u8 vid;			/* Register encoding, combined */
 	u32 alarms;		/* Register encoding, combined */
-	u32 beeps;		/* Register encoding, combined */
+	u32 beep_mask;		/* Register encoding, combined */
 	u8 beep_enable;		/* Boolean */
 	u8 pwm[4];		/* Register value */
-	u8 pwmenable[4];	/* bool */
+	u8 pwmenable[4];	/* Boolean */
 	u16 sens[3];		/* 782D/783S only.
 				   1 = pentium diode; 2 = 3904 diode;
 				   3000-5000 = thermistor beta.
@@ -362,10 +331,8 @@
 	u8 vrm;
 };
 
-
 static int w83781d_attach_adapter(struct i2c_adapter *adapter);
-static int w83781d_detect(struct i2c_adapter *adapter, int address,
-			  unsigned short flags, int kind);
+static int w83781d_detect(struct i2c_adapter *adapter, int address, int kind);
 static int w83781d_detach_client(struct i2c_client *client);
 
 static int w83781d_read_value(struct i2c_client *client, u16 register);
@@ -374,416 +341,698 @@
 static void w83781d_update_client(struct i2c_client *client);
 static void w83781d_init_client(struct i2c_client *client);
 
-
-static void w83781d_in(struct i2c_client *client, int operation,
-		       int ctl_name, int *nrels_mag, long *results);
-static void w83781d_fan(struct i2c_client *client, int operation,
-			int ctl_name, int *nrels_mag, long *results);
-static void w83781d_temp(struct i2c_client *client, int operation,
-			 int ctl_name, int *nrels_mag, long *results);
-static void w83781d_temp_add(struct i2c_client *client, int operation,
-			     int ctl_name, int *nrels_mag, long *results);
-static void w83781d_vid(struct i2c_client *client, int operation,
-			int ctl_name, int *nrels_mag, long *results);
-static void w83781d_vrm(struct i2c_client *client, int operation,
-			int ctl_name, int *nrels_mag, long *results);
-static void w83781d_alarms(struct i2c_client *client, int operation,
-			   int ctl_name, int *nrels_mag, long *results);
-static void w83781d_beep(struct i2c_client *client, int operation,
-			 int ctl_name, int *nrels_mag, long *results);
-static void w83781d_fan_div(struct i2c_client *client, int operation,
-			    int ctl_name, int *nrels_mag, long *results);
-static void w83781d_pwm(struct i2c_client *client, int operation,
-			int ctl_name, int *nrels_mag, long *results);
-static void w83781d_sens(struct i2c_client *client, int operation,
-			 int ctl_name, int *nrels_mag, long *results);
-#ifdef W83781D_RT
-static void w83781d_rt(struct i2c_client *client, int operation,
-		       int ctl_name, int *nrels_mag, long *results);
-#endif
-static u16 swap_bytes(u16 val);
-
-static int w83781d_id = 0;
+static inline u16 swap_bytes(u16 val)
+{
+	return (val >> 8) | (val << 8);
+}
 
 static struct i2c_driver w83781d_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "W83781D sensor driver",
-	.id		= I2C_DRIVERID_W83781D,
-	.flags		= I2C_DF_NOTIFY,
-	.attach_adapter	= w83781d_attach_adapter,
-	.detach_client	= w83781d_detach_client,
+	.owner = THIS_MODULE,
+	.name = "w83781d",
+	.id = I2C_DRIVERID_W83781D,
+	.flags = I2C_DF_NOTIFY,
+	.attach_adapter = w83781d_attach_adapter,
+	.detach_client = w83781d_detach_client,
 };
 
-/* The /proc/sys entries */
-/* -- SENSORS SYSCTL START -- */
+/* following are the sysfs callback functions */
+#define show_in_reg(reg) \
+static ssize_t show_##reg (struct device *dev, char *buf, int nr) \
+{ \
+	struct i2c_client *client = to_i2c_client(dev); \
+	struct w83781d_data *data = i2c_get_clientdata(client); \
+	 \
+	w83781d_update_client(client); \
+	 \
+	return sprintf(buf,"%ld\n", (long)IN_FROM_REG(data->reg[nr] * 10)); \
+}
+show_in_reg(in);
+show_in_reg(in_min);
+show_in_reg(in_max);
+
+#define store_in_reg(REG, reg) \
+static ssize_t store_in_##reg (struct device *dev, const char *buf, size_t count, int nr) \
+{ \
+	struct i2c_client *client = to_i2c_client(dev); \
+	struct w83781d_data *data = i2c_get_clientdata(client); \
+	u32 val; \
+	 \
+	val = simple_strtoul(buf, NULL, 10); \
+	data->in_##reg[nr] = (IN_TO_REG(val) / 10); \
+	w83781d_write_value(client, W83781D_REG_IN_##REG(nr), data->in_##reg[nr]); \
+	 \
+	return count; \
+}
+store_in_reg(MIN, min);
+store_in_reg(MAX, max);
+
+#define sysfs_in_offset(offset) \
+static ssize_t \
+show_regs_in_##offset (struct device *dev, char *buf) \
+{ \
+        return show_in(dev, buf, 0x##offset); \
+} \
+static DEVICE_ATTR(in_input##offset, S_IRUGO, show_regs_in_##offset, NULL)
+
+#define sysfs_in_reg_offset(reg, offset) \
+static ssize_t show_regs_in_##reg##offset (struct device *dev, char *buf) \
+{ \
+	return show_in_##reg (dev, buf, 0x##offset); \
+} \
+static ssize_t store_regs_in_##reg##offset (struct device *dev, const char *buf, size_t count) \
+{ \
+	return store_in_##reg (dev, buf, count, 0x##offset); \
+} \
+static DEVICE_ATTR(in_##reg##offset, S_IRUGO| S_IWUSR, show_regs_in_##reg##offset, store_regs_in_##reg##offset)
+
+#define sysfs_in_offsets(offset) \
+sysfs_in_offset(offset); \
+sysfs_in_reg_offset(min, offset); \
+sysfs_in_reg_offset(max, offset);
+
+sysfs_in_offsets(0);
+sysfs_in_offsets(1);
+sysfs_in_offsets(2);
+sysfs_in_offsets(3);
+sysfs_in_offsets(4);
+sysfs_in_offsets(5);
+sysfs_in_offsets(6);
+sysfs_in_offsets(7);
+sysfs_in_offsets(8);
+
+#define device_create_file_in(client, offset) \
+device_create_file(&client->dev, &dev_attr_in_input##offset); \
+device_create_file(&client->dev, &dev_attr_in_min##offset); \
+device_create_file(&client->dev, &dev_attr_in_max##offset);
+
+#define show_fan_reg(reg) \
+static ssize_t show_##reg (struct device *dev, char *buf, int nr) \
+{ \
+	struct i2c_client *client = to_i2c_client(dev); \
+	struct w83781d_data *data = i2c_get_clientdata(client); \
+	 \
+	w83781d_update_client(client); \
+	 \
+	return sprintf(buf,"%ld\n", \
+		FAN_FROM_REG(data->reg[nr-1], (long)DIV_FROM_REG(data->fan_div[nr-1]))); \
+}
+show_fan_reg(fan);
+show_fan_reg(fan_min);
+
+static ssize_t
+store_fan_min(struct device *dev, const char *buf, size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct w83781d_data *data = i2c_get_clientdata(client);
+	u32 val;
+
+	val = simple_strtoul(buf, NULL, 10);
+	data->fan_min[nr - 1] +	    FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr - 1]));
+	w83781d_write_value(client, W83781D_REG_FAN_MIN(nr),
+			    data->fan_min[nr - 1]);
+
+	return count;
+}
+
+#define sysfs_fan_offset(offset) \
+static ssize_t show_regs_fan_##offset (struct device *dev, char *buf) \
+{ \
+	return show_fan(dev, buf, 0x##offset); \
+} \
+static DEVICE_ATTR(fan_input##offset, S_IRUGO, show_regs_fan_##offset, NULL)
+
+#define sysfs_fan_min_offset(offset) \
+static ssize_t show_regs_fan_min##offset (struct device *dev, char *buf) \
+{ \
+	return show_fan_min(dev, buf, 0x##offset); \
+} \
+static ssize_t store_regs_fan_min##offset (struct device *dev, const char *buf, size_t count) \
+{ \
+	return store_fan_min(dev, buf, count, 0x##offset); \
+} \
+static DEVICE_ATTR(fan_min##offset, S_IRUGO | S_IWUSR, show_regs_fan_min##offset, store_regs_fan_min##offset)
+
+sysfs_fan_offset(1);
+sysfs_fan_min_offset(1);
+sysfs_fan_offset(2);
+sysfs_fan_min_offset(2);
+sysfs_fan_offset(3);
+sysfs_fan_min_offset(3);
+
+#define device_create_file_fan(client, offset) \
+device_create_file(&client->dev, &dev_attr_fan_input##offset); \
+device_create_file(&client->dev, &dev_attr_fan_min##offset); \
+
+#define show_temp_reg(reg) \
+static ssize_t show_##reg (struct device *dev, char *buf, int nr) \
+{ \
+	struct i2c_client *client = to_i2c_client(dev); \
+	struct w83781d_data *data = i2c_get_clientdata(client); \
+	 \
+	w83781d_update_client(client); \
+	 \
+	if (nr >= 2) {	/* TEMP2 and TEMP3 */ \
+		if (data->type = as99127f) { \
+			return sprintf(buf,"%ld\n", \
+				(long)AS99127_TEMP_ADD_FROM_REG(data->reg##_add[nr-2])); \
+		} else { \
+			return sprintf(buf,"%ld\n", \
+				(long)TEMP_ADD_FROM_REG(data->reg##_add[nr-2])); \
+		} \
+	} else {	/* TEMP1 */ \
+		return sprintf(buf,"%ld\n", (long)TEMP_FROM_REG(data->reg)); \
+	} \
+}
+show_temp_reg(temp);
+show_temp_reg(temp_min);
+show_temp_reg(temp_max);
+
+#define store_temp_reg(REG, reg) \
+static ssize_t store_temp_##reg (struct device *dev, const char *buf, size_t count, int nr) \
+{ \
+	struct i2c_client *client = to_i2c_client(dev); \
+	struct w83781d_data *data = i2c_get_clientdata(client); \
+	u32 val; \
+	 \
+	val = simple_strtoul(buf, NULL, 10); \
+	 \
+	if (nr >= 2) {	/* TEMP2 and TEMP3 */ \
+		if (data->type = as99127f) \
+			data->temp_##reg##_add[nr-2] = AS99127_TEMP_ADD_TO_REG(val); \
+		else \
+			data->temp_##reg##_add[nr-2] = TEMP_ADD_TO_REG(val); \
+		 \
+		w83781d_write_value(client, W83781D_REG_TEMP_##REG(nr), \
+				data->temp_##reg##_add[nr-2]); \
+	} else {	/* TEMP1 */ \
+		data->temp_##reg = TEMP_TO_REG(val); \
+		w83781d_write_value(client, W83781D_REG_TEMP_##REG(nr), \
+			data->temp_##reg); \
+	} \
+	 \
+	return count; \
+}
+store_temp_reg(OVER, min);
+store_temp_reg(HYST, max);
+
+#define sysfs_temp_offset(offset) \
+static ssize_t \
+show_regs_temp_##offset (struct device *dev, char *buf) \
+{ \
+	return show_temp(dev, buf, 0x##offset); \
+} \
+static DEVICE_ATTR(temp_input##offset, S_IRUGO, show_regs_temp_##offset, NULL)
+
+#define sysfs_temp_reg_offset(reg, offset) \
+static ssize_t show_regs_temp_##reg##offset (struct device *dev, char *buf) \
+{ \
+	return show_temp_##reg (dev, buf, 0x##offset); \
+} \
+static ssize_t store_regs_temp_##reg##offset (struct device *dev, const char *buf, size_t count) \
+{ \
+	return store_temp_##reg (dev, buf, count, 0x##offset); \
+} \
+static DEVICE_ATTR(temp_##reg##offset, S_IRUGO| S_IWUSR, show_regs_temp_##reg##offset, store_regs_temp_##reg##offset)
+
+#define sysfs_temp_offsets(offset) \
+sysfs_temp_offset(offset); \
+sysfs_temp_reg_offset(min, offset); \
+sysfs_temp_reg_offset(max, offset);
+
+sysfs_temp_offsets(1);
+sysfs_temp_offsets(2);
+sysfs_temp_offsets(3);
+
+#define device_create_file_temp(client, offset) \
+device_create_file(&client->dev, &dev_attr_temp_input##offset); \
+device_create_file(&client->dev, &dev_attr_temp_max##offset); \
+device_create_file(&client->dev, &dev_attr_temp_min##offset);
+
+static ssize_t
+show_vid_reg(struct device *dev, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct w83781d_data *data = i2c_get_clientdata(client);
+
+	w83781d_update_client(client);
+
+	return sprintf(buf, "%ld\n", (long) vid_from_reg(data->vid, data->vrm));
+}
+
+static
+DEVICE_ATTR(vid, S_IRUGO, show_vid_reg, NULL)
+#define device_create_file_vid(client) \
+device_create_file(&client->dev, &dev_attr_vid);
+static ssize_t
+show_vrm_reg(struct device *dev, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct w83781d_data *data = i2c_get_clientdata(client);
+
+	w83781d_update_client(client);
+
+	return sprintf(buf, "%ld\n", (long) data->vrm);
+}
+
+static ssize_t
+store_vrm_reg(struct device *dev, const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct w83781d_data *data = i2c_get_clientdata(client);
+	u32 val;
+
+	val = simple_strtoul(buf, NULL, 10);
+	data->vrm = val;
+
+	return count;
+}
+
+static
+DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm_reg, store_vrm_reg)
+#define device_create_file_vrm(client) \
+device_create_file(&client->dev, &dev_attr_vrm);
+static ssize_t
+show_alarms_reg(struct device *dev, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct w83781d_data *data = i2c_get_clientdata(client);
+
+	w83781d_update_client(client);
+
+	return sprintf(buf, "%ld\n", (long) ALARMS_FROM_REG(data->alarms));
+}
+
+static
+DEVICE_ATTR(alarms, S_IRUGO, show_alarms_reg, NULL)
+#define device_create_file_alarms(client) \
+device_create_file(&client->dev, &dev_attr_alarms);
+#define show_beep_reg(REG, reg) \
+static ssize_t show_beep_##reg (struct device *dev, char *buf) \
+{ \
+	struct i2c_client *client = to_i2c_client(dev); \
+	struct w83781d_data *data = i2c_get_clientdata(client); \
+	 \
+	w83781d_update_client(client); \
+	 \
+	return sprintf(buf,"%ld\n", (long)BEEP_##REG##_FROM_REG(data->beep_##reg)); \
+}
+show_beep_reg(ENABLE, enable);
+show_beep_reg(MASK, mask);
+
+#define BEEP_ENABLE			0	/* Store beep_enable */
+#define BEEP_MASK			1	/* Store beep_mask */
+
+static ssize_t
+store_beep_reg(struct device *dev, const char *buf, size_t count,
+	       int update_mask)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct w83781d_data *data = i2c_get_clientdata(client);
+	u32 val, val2;
+
+	val = simple_strtoul(buf, NULL, 10);
+
+	if (update_mask = BEEP_MASK) {	/* We are storing beep_mask */
+		data->beep_mask = BEEP_MASK_TO_REG(val);
+		w83781d_write_value(client, W83781D_REG_BEEP_INTS1,
+				    data->beep_mask & 0xff);
+
+		if ((data->type != w83781d) && (data->type != as99127f)) {
+			w83781d_write_value(client, W83781D_REG_BEEP_INTS3,
+					    ((data->beep_mask) >> 16) & 0xff);
+		}
+
+		val2 = (data->beep_mask >> 8) & 0x7f;
+	} else {		/* We are storing beep_enable */
+		val2 = w83781d_read_value(client, W83781D_REG_BEEP_INTS2) & 0x7f;
+		data->beep_enable = BEEP_ENABLE_TO_REG(val);
+	}
+
+	w83781d_write_value(client, W83781D_REG_BEEP_INTS2,
+			    val2 | data->beep_enable << 7);
+
+	return count;
+}
+
+#define sysfs_beep(REG, reg) \
+static ssize_t show_regs_beep_##reg (struct device *dev, char *buf) \
+{ \
+	return show_beep_##reg(dev, buf); \
+} \
+static ssize_t store_regs_beep_##reg (struct device *dev, const char *buf, size_t count) \
+{ \
+	return store_beep_reg(dev, buf, count, BEEP_##REG); \
+} \
+static DEVICE_ATTR(beep_##reg, S_IRUGO | S_IWUSR, show_regs_beep_##reg, store_regs_beep_##reg)
+
+sysfs_beep(ENABLE, enable);
+sysfs_beep(MASK, mask);
+
+#define device_create_file_beep(client) \
+device_create_file(&client->dev, &dev_attr_beep_enable); \
+device_create_file(&client->dev, &dev_attr_beep_mask);
 
-#define W83781D_SYSCTL_IN0 1000	/* Volts * 100 */
-#define W83781D_SYSCTL_IN1 1001
-#define W83781D_SYSCTL_IN2 1002
-#define W83781D_SYSCTL_IN3 1003
-#define W83781D_SYSCTL_IN4 1004
-#define W83781D_SYSCTL_IN5 1005
-#define W83781D_SYSCTL_IN6 1006
-#define W83781D_SYSCTL_IN7 1007
-#define W83781D_SYSCTL_IN8 1008
-#define W83781D_SYSCTL_FAN1 1101	/* Rotations/min */
-#define W83781D_SYSCTL_FAN2 1102
-#define W83781D_SYSCTL_FAN3 1103
-#define W83781D_SYSCTL_TEMP1 1200	/* Degrees Celcius * 10 */
-#define W83781D_SYSCTL_TEMP2 1201	/* Degrees Celcius * 10 */
-#define W83781D_SYSCTL_TEMP3 1202	/* Degrees Celcius * 10 */
-#define W83781D_SYSCTL_VID 1300		/* Volts * 1000 */
-#define W83781D_SYSCTL_VRM 1301
-#define W83781D_SYSCTL_PWM1 1401
-#define W83781D_SYSCTL_PWM2 1402
-#define W83781D_SYSCTL_PWM3 1403
-#define W83781D_SYSCTL_PWM4 1404
-#define W83781D_SYSCTL_SENS1 1501	/* 1, 2, or Beta (3000-5000) */
-#define W83781D_SYSCTL_SENS2 1502
-#define W83781D_SYSCTL_SENS3 1503
-#define W83781D_SYSCTL_RT1   1601	/* 32-entry table */
-#define W83781D_SYSCTL_RT2   1602	/* 32-entry table */
-#define W83781D_SYSCTL_RT3   1603	/* 32-entry table */
-#define W83781D_SYSCTL_FAN_DIV 2000	/* 1, 2, 4 or 8 */
-#define W83781D_SYSCTL_ALARMS 2001	/* bitvector */
-#define W83781D_SYSCTL_BEEP 2002	/* bitvector */
-
-#define W83781D_ALARM_IN0 0x0001
-#define W83781D_ALARM_IN1 0x0002
-#define W83781D_ALARM_IN2 0x0004
-#define W83781D_ALARM_IN3 0x0008
-#define W83781D_ALARM_IN4 0x0100
-#define W83781D_ALARM_IN5 0x0200
-#define W83781D_ALARM_IN6 0x0400
-#define W83782D_ALARM_IN7 0x10000
-#define W83782D_ALARM_IN8 0x20000
-#define W83781D_ALARM_FAN1 0x0040
-#define W83781D_ALARM_FAN2 0x0080
-#define W83781D_ALARM_FAN3 0x0800
-#define W83781D_ALARM_TEMP1 0x0010
-#define W83781D_ALARM_TEMP23 0x0020	/* 781D only */
-#define W83781D_ALARM_TEMP2 0x0020	/* 782D/783S */
-#define W83781D_ALARM_TEMP3 0x2000	/* 782D only */
-#define W83781D_ALARM_CHAS 0x1000
-
-/* -- SENSORS SYSCTL END -- */
-
-/* These files are created for each detected chip. This is just a template;
-   though at first sight, you might think we could use a statically
-   allocated list, we need some way to get back to the parent - which
-   is done through one of the 'extra' fields which are initialized 
-   when a new copy is allocated. */
-
-/* just a guess - no datasheet */
-static ctl_table as99127f_dir_table_template[] = {
-	{W83781D_SYSCTL_IN0, "in0", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_in},
-	{W83781D_SYSCTL_IN1, "in1", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_in},
-	{W83781D_SYSCTL_IN2, "in2", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_in},
-	{W83781D_SYSCTL_IN3, "in3", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_in},
-	{W83781D_SYSCTL_IN4, "in4", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_in},
-	{W83781D_SYSCTL_IN5, "in5", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_in},
-	{W83781D_SYSCTL_IN6, "in6", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_in},
-	{W83781D_SYSCTL_FAN1, "fan1", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_fan},
-	{W83781D_SYSCTL_FAN2, "fan2", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_fan},
-	{W83781D_SYSCTL_FAN3, "fan3", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_fan},
-	{W83781D_SYSCTL_TEMP1, "temp1", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_temp},
-	{W83781D_SYSCTL_TEMP2, "temp2", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_temp_add},
-	{W83781D_SYSCTL_TEMP3, "temp3", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_temp_add},
-	{W83781D_SYSCTL_VID, "vid", NULL, 0, 0444, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_vid},
-	{W83781D_SYSCTL_VRM, "vrm", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_vrm},
-	{W83781D_SYSCTL_FAN_DIV, "fan_div", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_fan_div},
-	{W83781D_SYSCTL_ALARMS, "alarms", NULL, 0, 0444, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_alarms},
-	{W83781D_SYSCTL_BEEP, "beep", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_beep},
-	{W83781D_SYSCTL_PWM1, "pwm1", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_pwm},
-	{W83781D_SYSCTL_PWM2, "pwm2", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_pwm},
-	{0}
-};
+/* w83697hf only has two fans */
+static ssize_t
+show_fan_div_reg(struct device *dev, char *buf, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct w83781d_data *data = i2c_get_clientdata(client);
+
+	w83781d_update_client(client);
+
+	return sprintf(buf, "%ld\n",
+		       (long) DIV_FROM_REG(data->fan_div[nr - 1]));
+}
+
+/* w83697hf only has two fans */
+static ssize_t
+store_fan_div_reg(struct device *dev, const char *buf, size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct w83781d_data *data = i2c_get_clientdata(client);
+	u32 val, old, old2, old3 = 0;
+
+	val = simple_strtoul(buf, NULL, 10);
+	old = w83781d_read_value(client, W83781D_REG_VID_FANDIV);
+
+	data->fan_div[nr - 1] = DIV_TO_REG(val, data->type);
+
+	/* w83781d and as99127f don't have extended divisor bits */
+	if ((data->type != w83781d) && data->type != as99127f) {
+		old3 = w83781d_read_value(client, W83781D_REG_VBAT);
+	}
+	if (nr >= 3 && data->type != w83697hf) {
+		old2 = w83781d_read_value(client, W83781D_REG_PIN);
+		old2 = (old2 & 0x3f) | ((data->fan_div[2] & 0x03) << 6);
+		w83781d_write_value(client, W83781D_REG_PIN, old2);
+
+		if ((data->type != w83781d) && (data->type != as99127f)) {
+			old3 = (old3 & 0x7f) | ((data->fan_div[2] & 0x04) << 5);
+		}
+	}
+	if (nr >= 2) {
+		old = (old & 0x3f) | ((data->fan_div[1] & 0x03) << 6);
+
+		if ((data->type != w83781d) && (data->type != as99127f)) {
+			old3 = (old3 & 0xbf) | ((data->fan_div[1] & 0x04) << 4);
+		}
+	}
+	if (nr >= 1) {
+		old = (old & 0xcf) | ((data->fan_div[0] & 0x03) << 4);
+		w83781d_write_value(client, W83781D_REG_VID_FANDIV, old);
+
+		if ((data->type != w83781d) && (data->type != as99127f)) {
+			old3 = (old3 & 0xdf) | ((data->fan_div[0] & 0x04) << 3);
+			w83781d_write_value(client, W83781D_REG_VBAT, old3);
+		}
+	}
+
+	return count;
+}
+
+#define sysfs_fan_div(offset) \
+static ssize_t show_regs_fan_div_##offset (struct device *dev, char *buf) \
+{ \
+	return show_fan_div_reg(dev, buf, offset); \
+} \
+static ssize_t store_regs_fan_div_##offset (struct device *dev, const char *buf, size_t count) \
+{ \
+	return store_fan_div_reg(dev, buf, count, offset); \
+} \
+static DEVICE_ATTR(fan_div##offset, S_IRUGO | S_IWUSR, show_regs_fan_div_##offset, store_regs_fan_div_##offset)
+
+sysfs_fan_div(1);
+sysfs_fan_div(2);
+sysfs_fan_div(3);
+
+#define device_create_file_fan_div(client, offset) \
+device_create_file(&client->dev, &dev_attr_fan_div##offset); \
+
+/* w83697hf only has two fans */
+static ssize_t
+show_pwm_reg(struct device *dev, char *buf, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct w83781d_data *data = i2c_get_clientdata(client);
+
+	w83781d_update_client(client);
+
+	return sprintf(buf, "%ld\n", (long) PWM_FROM_REG(data->pwm[nr - 1]));
+}
+
+/* w83697hf only has two fans */
+static ssize_t
+show_pwmenable_reg(struct device *dev, char *buf, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct w83781d_data *data = i2c_get_clientdata(client);
+
+	w83781d_update_client(client);
+
+	return sprintf(buf, "%ld\n", (long) data->pwmenable[nr - 1]);
+}
+
+static ssize_t
+store_pwm_reg(struct device *dev, const char *buf, size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct w83781d_data *data = i2c_get_clientdata(client);
+	u32 val;
+
+	val = simple_strtoul(buf, NULL, 10);
+
+	data->pwm[nr - 1] = PWM_TO_REG(val);
+	w83781d_write_value(client, W83781D_REG_PWM(nr), data->pwm[nr - 1]);
+
+	return count;
+}
+
+static ssize_t
+store_pwmenable_reg(struct device *dev, const char *buf, size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct w83781d_data *data = i2c_get_clientdata(client);
+	u32 val, j, k;
+
+	val = simple_strtoul(buf, NULL, 10);
+
+	/* only PWM2 can be enabled/disabled */
+	if (nr = 2) {
+		j = w83781d_read_value(client, W83781D_REG_PWMCLK12);
+		k = w83781d_read_value(client, W83781D_REG_BEEP_CONFIG);
+
+		if (val > 0) {
+			if (!(j & 0x08))
+				w83781d_write_value(client,
+						    W83781D_REG_PWMCLK12,
+						    j | 0x08);
+			if (k & 0x10)
+				w83781d_write_value(client,
+						    W83781D_REG_BEEP_CONFIG,
+						    k & 0xef);
+
+			data->pwmenable[1] = 1;
+		} else {
+			if (j & 0x08)
+				w83781d_write_value(client,
+						    W83781D_REG_PWMCLK12,
+						    j & 0xf7);
+			if (!(k & 0x10))
+				w83781d_write_value(client,
+						    W83781D_REG_BEEP_CONFIG,
+						    j | 0x10);
+
+			data->pwmenable[1] = 0;
+		}
+	}
+
+	return count;
+}
+
+#define sysfs_pwm(offset) \
+static ssize_t show_regs_pwm_##offset (struct device *dev, char *buf) \
+{ \
+	return show_pwm_reg(dev, buf, offset); \
+} \
+static ssize_t store_regs_pwm_##offset (struct device *dev, const char *buf, size_t count) \
+{ \
+	return store_pwm_reg(dev, buf, count, offset); \
+} \
+static DEVICE_ATTR(pwm##offset, S_IRUGO | S_IWUSR, show_regs_pwm_##offset, store_regs_pwm_##offset)
+
+#define sysfs_pwmenable(offset) \
+static ssize_t show_regs_pwmenable_##offset (struct device *dev, char *buf) \
+{ \
+	return show_pwmenable_reg(dev, buf, offset); \
+} \
+static ssize_t store_regs_pwmenable_##offset (struct device *dev, const char *buf, size_t count) \
+{ \
+	return store_pwmenable_reg(dev, buf, count, offset); \
+} \
+static DEVICE_ATTR(pwm_enable##offset, S_IRUGO | S_IWUSR, show_regs_pwmenable_##offset, store_regs_pwmenable_##offset)
+
+sysfs_pwm(1);
+sysfs_pwm(2);
+sysfs_pwmenable(2);		/* only PWM2 can be enabled/disabled */
+sysfs_pwm(3);
+sysfs_pwm(4);
+
+#define device_create_file_pwm(client, offset) \
+device_create_file(&client->dev, &dev_attr_pwm##offset); \
+
+#define device_create_file_pwmenable(client, offset) \
+device_create_file(&client->dev, &dev_attr_pwm_enable##offset); \
+
+static ssize_t
+show_sensor_reg(struct device *dev, char *buf, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct w83781d_data *data = i2c_get_clientdata(client);
+
+	w83781d_update_client(client);
+
+	return sprintf(buf, "%ld\n", (long) data->sens[nr - 1]);
+}
+
+static ssize_t
+store_sensor_reg(struct device *dev, const char *buf, size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct w83781d_data *data = i2c_get_clientdata(client);
+	u32 val, tmp;
+
+	val = simple_strtoul(buf, NULL, 10);
+
+	switch (val) {
+	case 1:		/* PII/Celeron diode */
+		tmp = w83781d_read_value(client, W83781D_REG_SCFG1);
+		w83781d_write_value(client, W83781D_REG_SCFG1,
+				    tmp | BIT_SCFG1[nr - 1]);
+		tmp = w83781d_read_value(client, W83781D_REG_SCFG2);
+		w83781d_write_value(client, W83781D_REG_SCFG2,
+				    tmp | BIT_SCFG2[nr - 1]);
+		data->sens[nr - 1] = val;
+		break;
+	case 2:		/* 3904 */
+		tmp = w83781d_read_value(client, W83781D_REG_SCFG1);
+		w83781d_write_value(client, W83781D_REG_SCFG1,
+				    tmp | BIT_SCFG1[nr - 1]);
+		tmp = w83781d_read_value(client, W83781D_REG_SCFG2);
+		w83781d_write_value(client, W83781D_REG_SCFG2,
+				    tmp & ~BIT_SCFG2[nr - 1]);
+		data->sens[nr - 1] = val;
+		break;
+	case W83781D_DEFAULT_BETA:	/* thermistor */
+		tmp = w83781d_read_value(client, W83781D_REG_SCFG1);
+		w83781d_write_value(client, W83781D_REG_SCFG1,
+				    tmp & ~BIT_SCFG1[nr - 1]);
+		data->sens[nr - 1] = val;
+		break;
+	default:
+		dev_err(&client->dev,
+		       "Invalid sensor type %ld; must be 1, 2, or %d\n",
+		       (long) val, W83781D_DEFAULT_BETA);
+		break;
+	}
+
+	return count;
+}
+
+#define sysfs_sensor(offset) \
+static ssize_t show_regs_sensor_##offset (struct device *dev, char *buf) \
+{ \
+    return show_sensor_reg(dev, buf, offset); \
+} \
+static ssize_t store_regs_sensor_##offset (struct device *dev, const char *buf, size_t count) \
+{ \
+    return store_sensor_reg(dev, buf, count, offset); \
+} \
+static DEVICE_ATTR(sensor##offset, S_IRUGO | S_IWUSR, show_regs_sensor_##offset, store_regs_sensor_##offset)
+
+sysfs_sensor(1);
+sysfs_sensor(2);
+sysfs_sensor(3);
+
+#define device_create_file_sensor(client, offset) \
+device_create_file(&client->dev, &dev_attr_sensor##offset); \
 
-static ctl_table w83781d_dir_table_template[] = {
-	{W83781D_SYSCTL_IN0, "in0", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_in},
-	{W83781D_SYSCTL_IN1, "in1", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_in},
-	{W83781D_SYSCTL_IN2, "in2", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_in},
-	{W83781D_SYSCTL_IN3, "in3", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_in},
-	{W83781D_SYSCTL_IN4, "in4", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_in},
-	{W83781D_SYSCTL_IN5, "in5", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_in},
-	{W83781D_SYSCTL_IN6, "in6", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_in},
-	{W83781D_SYSCTL_FAN1, "fan1", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_fan},
-	{W83781D_SYSCTL_FAN2, "fan2", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_fan},
-	{W83781D_SYSCTL_FAN3, "fan3", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_fan},
-	{W83781D_SYSCTL_TEMP1, "temp1", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_temp},
-	{W83781D_SYSCTL_TEMP2, "temp2", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_temp_add},
-	{W83781D_SYSCTL_TEMP3, "temp3", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_temp_add},
-	{W83781D_SYSCTL_VID, "vid", NULL, 0, 0444, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_vid},
-	{W83781D_SYSCTL_VRM, "vrm", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_vrm},
-	{W83781D_SYSCTL_FAN_DIV, "fan_div", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_fan_div},
-	{W83781D_SYSCTL_ALARMS, "alarms", NULL, 0, 0444, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_alarms},
-	{W83781D_SYSCTL_BEEP, "beep", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_beep},
 #ifdef W83781D_RT
-	{W83781D_SYSCTL_RT1, "rt1", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_rt},
-	{W83781D_SYSCTL_RT2, "rt2", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_rt},
-	{W83781D_SYSCTL_RT3, "rt3", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_rt},
-#endif
-	{0}
-};
+static ssize_t
+show_rt_reg(struct device *dev, char *buf, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct w83781d_data *data = i2c_get_clientdata(client);
+	int i, j = 0;
+
+	w83781d_update_client(client);
+
+	for (i = 0; i < 32; i++) {
+		if (i > 0)
+			j += sprintf(buf, " %ld", (long) data->rt[nr - 1][i]);
+		else
+			j += sprintf(buf, "%ld", (long) data->rt[nr - 1][i]);
+	}
+	j += sprintf(buf, "\n");
 
-/* without pwm3-4 */
-static ctl_table w83782d_isa_dir_table_template[] = {
-	{W83781D_SYSCTL_IN0, "in0", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_in},
-	{W83781D_SYSCTL_IN1, "in1", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_in},
-	{W83781D_SYSCTL_IN2, "in2", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_in},
-	{W83781D_SYSCTL_IN3, "in3", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_in},
-	{W83781D_SYSCTL_IN4, "in4", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_in},
-	{W83781D_SYSCTL_IN5, "in5", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_in},
-	{W83781D_SYSCTL_IN6, "in6", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_in},
-	{W83781D_SYSCTL_IN7, "in7", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_in},
-	{W83781D_SYSCTL_IN8, "in8", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_in},
-	{W83781D_SYSCTL_FAN1, "fan1", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_fan},
-	{W83781D_SYSCTL_FAN2, "fan2", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_fan},
-	{W83781D_SYSCTL_FAN3, "fan3", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_fan},
-	{W83781D_SYSCTL_TEMP1, "temp1", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_temp},
-	{W83781D_SYSCTL_TEMP2, "temp2", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_temp_add},
-	{W83781D_SYSCTL_TEMP3, "temp3", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_temp_add},
-	{W83781D_SYSCTL_VID, "vid", NULL, 0, 0444, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_vid},
-	{W83781D_SYSCTL_VRM, "vrm", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_vrm},
-	{W83781D_SYSCTL_FAN_DIV, "fan_div", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_fan_div},
-	{W83781D_SYSCTL_ALARMS, "alarms", NULL, 0, 0444, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_alarms},
-	{W83781D_SYSCTL_BEEP, "beep", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_beep},
-	{W83781D_SYSCTL_PWM1, "pwm1", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_pwm},
-	{W83781D_SYSCTL_PWM2, "pwm2", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_pwm},
-	{W83781D_SYSCTL_SENS1, "sensor1", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_sens},
-	{W83781D_SYSCTL_SENS2, "sensor2", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_sens},
-	{W83781D_SYSCTL_SENS3, "sensor3", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_sens},
-	{0}
-};
+	return j;
+}
 
-/* with pwm3-4 */
-static ctl_table w83782d_i2c_dir_table_template[] = {
-	{W83781D_SYSCTL_IN0, "in0", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_in},
-	{W83781D_SYSCTL_IN1, "in1", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_in},
-	{W83781D_SYSCTL_IN2, "in2", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_in},
-	{W83781D_SYSCTL_IN3, "in3", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_in},
-	{W83781D_SYSCTL_IN4, "in4", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_in},
-	{W83781D_SYSCTL_IN5, "in5", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_in},
-	{W83781D_SYSCTL_IN6, "in6", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_in},
-	{W83781D_SYSCTL_IN7, "in7", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_in},
-	{W83781D_SYSCTL_IN8, "in8", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_in},
-	{W83781D_SYSCTL_FAN1, "fan1", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_fan},
-	{W83781D_SYSCTL_FAN2, "fan2", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_fan},
-	{W83781D_SYSCTL_FAN3, "fan3", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_fan},
-	{W83781D_SYSCTL_TEMP1, "temp1", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_temp},
-	{W83781D_SYSCTL_TEMP2, "temp2", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_temp_add},
-	{W83781D_SYSCTL_TEMP3, "temp3", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_temp_add},
-	{W83781D_SYSCTL_VID, "vid", NULL, 0, 0444, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_vid},
-	{W83781D_SYSCTL_VRM, "vrm", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_vrm},
-	{W83781D_SYSCTL_FAN_DIV, "fan_div", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_fan_div},
-	{W83781D_SYSCTL_ALARMS, "alarms", NULL, 0, 0444, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_alarms},
-	{W83781D_SYSCTL_BEEP, "beep", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_beep},
-	{W83781D_SYSCTL_PWM1, "pwm1", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_pwm},
-	{W83781D_SYSCTL_PWM2, "pwm2", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_pwm},
-	{W83781D_SYSCTL_PWM3, "pwm3", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_pwm},
-	{W83781D_SYSCTL_PWM4, "pwm4", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_pwm},
-	{W83781D_SYSCTL_SENS1, "sensor1", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_sens},
-	{W83781D_SYSCTL_SENS2, "sensor2", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_sens},
-	{W83781D_SYSCTL_SENS3, "sensor3", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_sens},
-	{0}
-};
+static ssize_t
+store_rt_reg(struct device *dev, const char *buf, size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct w83781d_data *data = i2c_get_clientdata(client);
+	u32 val, i;
 
-static ctl_table w83783s_dir_table_template[] = {
-	{W83781D_SYSCTL_IN0, "in0", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_in},
-	/* no in1 to maintain compatibility with 781d and 782d. */
-	{W83781D_SYSCTL_IN2, "in2", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_in},
-	{W83781D_SYSCTL_IN3, "in3", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_in},
-	{W83781D_SYSCTL_IN4, "in4", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_in},
-	{W83781D_SYSCTL_IN5, "in5", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_in},
-	{W83781D_SYSCTL_IN6, "in6", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_in},
-	{W83781D_SYSCTL_FAN1, "fan1", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_fan},
-	{W83781D_SYSCTL_FAN2, "fan2", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_fan},
-	{W83781D_SYSCTL_FAN3, "fan3", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_fan},
-	{W83781D_SYSCTL_TEMP1, "temp1", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_temp},
-	{W83781D_SYSCTL_TEMP2, "temp2", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_temp_add},
-	{W83781D_SYSCTL_VID, "vid", NULL, 0, 0444, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_vid},
-	{W83781D_SYSCTL_VRM, "vrm", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_vrm},
-	{W83781D_SYSCTL_FAN_DIV, "fan_div", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_fan_div},
-	{W83781D_SYSCTL_ALARMS, "alarms", NULL, 0, 0444, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_alarms},
-	{W83781D_SYSCTL_BEEP, "beep", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_beep},
-	{W83781D_SYSCTL_PWM1, "pwm1", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_pwm},
-	{W83781D_SYSCTL_PWM2, "pwm2", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_pwm},
-	{W83781D_SYSCTL_SENS1, "sensor1", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_sens},
-	{W83781D_SYSCTL_SENS2, "sensor2", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_sens},
-	{0}
-};
+	for (i = 0; i < count; i++) {
+		val = simple_strtoul(buf + count, NULL, 10);
 
-/* similar to w83782d but no fan3, no vid */
-static ctl_table w83697hf_dir_table_template[] = {
-	{W83781D_SYSCTL_IN0, "in0", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_in},
-	/* no in1 to maintain compatibility with 781d and 782d. */
-	{W83781D_SYSCTL_IN2, "in2", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_in},
-	{W83781D_SYSCTL_IN3, "in3", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_in},
-	{W83781D_SYSCTL_IN4, "in4", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_in},
-	{W83781D_SYSCTL_IN5, "in5", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_in},
-	{W83781D_SYSCTL_IN6, "in6", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_in},
-	{W83781D_SYSCTL_IN7, "in7", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_in},
-	{W83781D_SYSCTL_IN8, "in8", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_in},
-	{W83781D_SYSCTL_FAN1, "fan1", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_fan},
-	{W83781D_SYSCTL_FAN2, "fan2", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_fan},
-	{W83781D_SYSCTL_TEMP1, "temp1", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_temp},
-	{W83781D_SYSCTL_TEMP2, "temp2", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_temp_add},
-	{W83781D_SYSCTL_FAN_DIV, "fan_div", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_fan_div},
-	{W83781D_SYSCTL_ALARMS, "alarms", NULL, 0, 0444, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_alarms},
-	{W83781D_SYSCTL_BEEP, "beep", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_beep},
-	{W83781D_SYSCTL_PWM1, "pwm1", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_pwm},
-	{W83781D_SYSCTL_PWM2, "pwm2", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_pwm},
-	{W83781D_SYSCTL_SENS1, "sensor1", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_sens},
-	{W83781D_SYSCTL_SENS2, "sensor2", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_sens},
-	{0}
-};
+		/* fixme: no bounds checking 0-255 */
+		data->rt[nr - 1][i] = val & 0xff;
+		w83781d_write_value(client, W83781D_REG_RT_IDX, i);
+		w83781d_write_value(client, W83781D_REG_RT_VAL,
+				    data->rt[nr - 1][i]);
+	}
+
+	return count;
+}
+
+#define sysfs_rt(offset) \
+static ssize_t show_regs_rt_##offset (struct device *dev, char *buf) \
+{ \
+	return show_rt_reg(dev, buf, offset); \
+} \
+static ssize_t store_regs_rt_##offset (struct device *dev, const char *buf, size_t count) \
+{ \
+    return store_rt_reg(dev, buf, count, offset); \
+} \
+static DEVICE_ATTR(rt##offset, S_IRUGO | S_IWUSR, show_regs_rt_##offset, store_regs_rt_##offset)
+
+sysfs_rt(1);
+sysfs_rt(2);
+sysfs_rt(3);
 
+#define device_create_file_rt(client, offset) \
+device_create_file(&client->dev, &dev_attr_rt##offset); \
+
+#endif				/* ifdef W83781D_RT */
 
 /* This function is called when:
      * w83781d_driver is inserted (when this module is loaded), for each
        available adapter
      * when a new adapter is inserted (and w83781d_driver is still present) */
-static int w83781d_attach_adapter(struct i2c_adapter *adapter)
+static int
+w83781d_attach_adapter(struct i2c_adapter *adapter)
 {
 	return i2c_detect(adapter, &addr_data, w83781d_detect);
 }
 
-static int w83781d_detect(struct i2c_adapter *adapter, int address,
-                  unsigned short flags, int kind)
+static int
+w83781d_detect(struct i2c_adapter *adapter, int address, int kind)
 {
-	int i, val1 = 0, val2, id;
+	int i = 0, val1 = 0, val2, id;
 	struct i2c_client *new_client;
 	struct w83781d_data *data;
 	int err = 0;
@@ -793,15 +1042,14 @@
 	enum vendor { winbond, asus } vendid;
 
 	if (!is_isa
-	    && !i2c_check_functionality(adapter,
-					I2C_FUNC_SMBUS_BYTE_DATA)) goto
-		    ERROR0;
-
-       if (is_isa) {
-               if (!request_region(address, W83781D_EXTENT, "w83781d"))
-                       goto ERROR0;
-               release_region(address, W83781D_EXTENT);
-       }
+	    && !i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		goto ERROR0;
+
+	if (is_isa) {
+		if (!request_region(address, W83781D_EXTENT, "w83781d"))
+			goto ERROR0;
+		release_region(address, W83781D_EXTENT);
+	}
 
 	/* Probe whether there is anything available on this address. Already
 	   done for SMBus clients */
@@ -834,17 +1082,19 @@
 	   client structure, even though we cannot fill it completely yet.
 	   But it allows us to access w83781d_{read,write}_value. */
 
-	if (!(new_client = kmalloc(sizeof(struct i2c_client) +
-				   sizeof(struct w83781d_data),
-				   GFP_KERNEL))) {
+	if (!(new_client = kmalloc(sizeof (struct i2c_client) +
+				   sizeof (struct w83781d_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto ERROR0;
 	}
 
+	memset(new_client, 0x00, sizeof (struct i2c_client) +
+	       sizeof (struct w83781d_data));
+
 	data = (struct w83781d_data *) (new_client + 1);
+	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
 	init_MUTEX(&data->lock);
-	new_client->data = data;
 	new_client->adapter = adapter;
 	new_client->driver = &w83781d_driver;
 	new_client->flags = 0;
@@ -856,16 +1106,17 @@
 	   force_*=... parameter, and the Winbond will be reset to the right
 	   bank. */
 	if (kind < 0) {
-		if (w83781d_read_value(new_client, W83781D_REG_CONFIG) &
-		    0x80) goto ERROR1;
+		if (w83781d_read_value(new_client, W83781D_REG_CONFIG) & 0x80)
+			goto ERROR1;
 		val1 = w83781d_read_value(new_client, W83781D_REG_BANK);
 		val2 = w83781d_read_value(new_client, W83781D_REG_CHIPMAN);
 		/* Check for Winbond or Asus ID if in bank 0 */
 		if ((!(val1 & 0x07)) &&
-		    (((!(val1 & 0x80)) && (val2 != 0xa3) && (val2 != 0xc3) 
-			 && (val2 != 0x94))
+		    (((!(val1 & 0x80)) && (val2 != 0xa3) && (val2 != 0xc3)
+		      && (val2 != 0x94))
 		     || ((val1 & 0x80) && (val2 != 0x5c) && (val2 != 0x12)
-			 && (val2 != 0x06)))) goto ERROR1;
+			 && (val2 != 0x06))))
+			goto ERROR1;
 		/* If Winbond SMBus, check address at 0x48. Asus doesn't support */
 		if ((!is_isa) && (((!(val1 & 0x80)) && (val2 = 0xa3)) ||
 				  ((val1 & 0x80) && (val2 = 0x5c)))) {
@@ -894,8 +1145,7 @@
 			goto ERROR1;
 		/* mask off lower bit, not reliable */
 		val1 -		    w83781d_read_value(new_client,
-				       W83781D_REG_WCHIPID) & 0xfe;
+		    w83781d_read_value(new_client, W83781D_REG_WCHIPID) & 0xfe;
 		if (val1 = 0x10 && vendid = winbond)
 			kind = w83781d;
 		else if (val1 = 0x30 && vendid = winbond)
@@ -910,10 +1160,10 @@
 			kind = w83697hf;
 		else {
 			if (kind = 0)
-				printk
-				    (KERN_WARNING "w83781d.o: Ignoring 'force' parameter for unknown chip at"
-				     "adapter %d, address 0x%02x\n",
-				     i2c_adapter_id(adapter), address);
+				dev_warn(&new_client->dev,
+				       "Ignoring 'force' parameter for unknown chip at"
+				       "adapter %d, address 0x%02x\n",
+				       i2c_adapter_id(adapter), address);
 			goto ERROR1;
 		}
 	}
@@ -937,10 +1187,7 @@
 		type_name = "w83697hf";
 		client_name = "W83697HF chip";
 	} else {
-#ifdef DEBUG
-		printk(KERN_ERR "w83781d.o: Internal error: unknown kind (%d)?!?",
-		       kind);
-#endif
+		dev_err(&new_client->dev, "Internal error: unknown kind (%d)?!?", kind);
 		goto ERROR1;
 	}
 
@@ -949,10 +1196,9 @@
 		request_region(address, W83781D_EXTENT, type_name);
 
 	/* Fill in the remaining client fields and put it into the global list */
-	strcpy(new_client->name, client_name);
+	strncpy(new_client->dev.name, client_name, DEVICE_NAME_SIZE);
 	data->type = kind;
 
-	new_client->id = w83781d_id++;
 	data->valid = 0;
 	init_MUTEX(&data->update_lock);
 
@@ -962,41 +1208,48 @@
 
 	/* attach secondary i2c lm75-like clients */
 	if (!is_isa) {
-		if (!(data->lm75 = kmalloc(2 * sizeof(struct i2c_client),
+		if (!(data->lm75 = kmalloc(2 * sizeof (struct i2c_client),
 					   GFP_KERNEL))) {
 			err = -ENOMEM;
 			goto ERROR4;
 		}
+
+		memset(data->lm75, 0x00, 2 * sizeof (struct i2c_client));
+
 		id = i2c_adapter_id(adapter);
-		if(force_subclients[0] = id && force_subclients[1] = address) {
-			for(i = 2; i <= 3; i++) {
-				if(force_subclients[i] < 0x48 ||
-				   force_subclients[i] > 0x4f) {
-					printk(KERN_ERR "w83781d.o: Invalid subclient address %d; must be 0x48-0x4f\n",
-					        force_subclients[i]);
+		if (force_subclients[0] = id && force_subclients[1] = address) {
+			for (i = 2; i <= 3; i++) {
+				if (force_subclients[i] < 0x48 ||
+				    force_subclients[i] > 0x4f) {
+					dev_err(&new_client->dev,
+					       "Invalid subclient address %d; must be 0x48-0x4f\n",
+					       force_subclients[i]);
 					goto ERROR5;
 				}
 			}
 			w83781d_write_value(new_client,
-			                    W83781D_REG_I2C_SUBADDR,
-			                    (force_subclients[2] & 0x07) |
-			                    ((force_subclients[3] & 0x07) <<4));
+					    W83781D_REG_I2C_SUBADDR,
+					    (force_subclients[2] & 0x07) |
+					    ((force_subclients[3] & 0x07) <<
+					     4));
 			data->lm75[0].addr = force_subclients[2];
 		} else {
 			val1 = w83781d_read_value(new_client,
-					          W83781D_REG_I2C_SUBADDR);
+						  W83781D_REG_I2C_SUBADDR);
 			data->lm75[0].addr = 0x48 + (val1 & 0x07);
 		}
 		if (kind != w83783s) {
-			if(force_subclients[0] = id &&
-			   force_subclients[1] = address) {
+			if (force_subclients[0] = id &&
+			    force_subclients[1] = address) {
 				data->lm75[1].addr = force_subclients[3];
 			} else {
-				data->lm75[1].addr = 0x48 + ((val1 >> 4) & 0x07);
+				data->lm75[1].addr +				    0x48 + ((val1 >> 4) & 0x07);
 			}
-			if(data->lm75[0].addr = data->lm75[1].addr) {
-				printk(KERN_ERR "w83781d.o: Duplicate addresses 0x%x for subclients.\n",
-					data->lm75[0].addr);
+			if (data->lm75[0].addr = data->lm75[1].addr) {
+				dev_err(&new_client->dev,
+				       "Duplicate addresses 0x%x for subclients.\n",
+				       data->lm75[0].addr);
 				goto ERROR5;
 			}
 		}
@@ -1012,19 +1265,12 @@
 			client_name = "AS99127F subclient";
 
 		for (i = 0; i <= 1; i++) {
-			data->lm75[i].data = NULL;	/* store all data in w83781d */
+			i2c_set_clientdata(&data->lm75[i], NULL);	/* store all data in w83781d */
 			data->lm75[i].adapter = adapter;
 			data->lm75[i].driver = &w83781d_driver;
 			data->lm75[i].flags = 0;
-			strcpy(data->lm75[i].name, client_name);
-			data->lm75[i].id = w83781d_id++;
-			if ((err = i2c_attach_client(&(data->lm75[i])))) {
-				printk(KERN_ERR "w83781d.o: Subclient %d registration at address 0x%x failed.\n",
-				       i, data->lm75[i].addr);
-				if (i = 1)
-					goto ERROR6;
-				goto ERROR5;
-			}
+			strncpy(data->lm75[i].dev.name, client_name,
+				DEVICE_NAME_SIZE);
 			if (kind = w83783s)
 				break;
 		}
@@ -1032,24 +1278,67 @@
 		data->lm75 = NULL;
 	}
 
-	/* Register a new directory entry with module sensors */
-	if ((i = i2c_register_entry(new_client,
-					type_name,
-					(kind = as99127f) ?
-					   as99127f_dir_table_template :
-					(kind = w83781d) ?
-					   w83781d_dir_table_template :
-					(kind = w83783s) ?
-					   w83783s_dir_table_template :
-					(kind = w83697hf) ?
-					   w83697hf_dir_table_template :
-					(is_isa || kind = w83627hf) ?
-					   w83782d_isa_dir_table_template :
-					   w83782d_i2c_dir_table_template)) < 0) {
-		err = i;
-		goto ERROR7;
+	device_create_file_in(new_client, 0);
+	if (kind != w83783s && kind != w83697hf)
+		device_create_file_in(new_client, 1);
+	device_create_file_in(new_client, 2);
+	device_create_file_in(new_client, 3);
+	device_create_file_in(new_client, 4);
+	device_create_file_in(new_client, 5);
+	device_create_file_in(new_client, 6);
+	if (kind != as99127f && kind != w83781d && kind != w83783s) {
+		device_create_file_in(new_client, 7);
+		device_create_file_in(new_client, 8);
+	}
+
+	device_create_file_fan(new_client, 1);
+	device_create_file_fan(new_client, 2);
+	if (kind != w83697hf)
+		device_create_file_fan(new_client, 3);
+
+	device_create_file_temp(new_client, 1);
+	device_create_file_temp(new_client, 2);
+	if (kind != w83783s && kind != w83697hf)
+		device_create_file_temp(new_client, 3);
+
+	if (kind != w83697hf)
+		device_create_file_vid(new_client);
+
+	if (kind != w83697hf)
+		device_create_file_vrm(new_client);
+
+	device_create_file_fan_div(new_client, 1);
+	device_create_file_fan_div(new_client, 2);
+	if (kind != w83697hf)
+		device_create_file_fan_div(new_client, 3);
+
+	device_create_file_alarms(new_client);
+
+	device_create_file_beep(new_client);
+
+	if (kind != w83781d) {
+		device_create_file_pwm(new_client, 1);
+		device_create_file_pwm(new_client, 2);
+		device_create_file_pwmenable(new_client, 2);
+	}
+	if (kind = w83782d && !is_isa) {
+		device_create_file_pwm(new_client, 3);
+		device_create_file_pwm(new_client, 4);
+	}
+
+	if (kind != as99127f && kind != w83781d) {
+		device_create_file_sensor(new_client, 1);
+		device_create_file_sensor(new_client, 2);
+		if (kind != w83783s && kind != w83697hf)
+			device_create_file_sensor(new_client, 3);
 	}
-	data->sysctl_id = i;
+#ifdef W83781D_RT
+	if (kind = w83781d) {
+		device_create_file_rt(new_client, 1);
+		device_create_file_rt(new_client, 2);
+		device_create_file_rt(new_client, 3);
+	}
+#endif
 
 	/* Initialize the chip */
 	w83781d_init_client(new_client);
@@ -1058,21 +1347,13 @@
 /* OK, this is not exactly good programming practice, usually. But it is
    very code-efficient in this case. */
 
-      ERROR7:
-	if (!is_isa)
-		i2c_detach_client(&
-				  (((struct
-				     w83781d_data *) (new_client->data))->
-				   lm75[1]));
-      ERROR6:
-	if (!is_isa)
-		i2c_detach_client(&
-				  (((struct
-				     w83781d_data *) (new_client->data))->
-				   lm75[0]));
       ERROR5:
-	if (!is_isa)
-		kfree(((struct w83781d_data *) (new_client->data))->lm75);
+	if (!is_isa) {
+		i2c_detach_client(&data->lm75[0]);
+		if (data->type != w83783s)
+			i2c_detach_client(&data->lm75[1]);
+		kfree(data->lm75);
+	}
       ERROR4:
 	i2c_detach_client(new_client);
       ERROR3:
@@ -1084,55 +1365,45 @@
 	return err;
 }
 
-static int w83781d_detach_client(struct i2c_client *client)
+static int
+w83781d_detach_client(struct i2c_client *client)
 {
+	struct w83781d_data *data = i2c_get_clientdata(client);
 	int err;
 
-	i2c_deregister_entry(((struct w83781d_data *) (client->data))->
-				 sysctl_id);
-
 	if ((err = i2c_detach_client(client))) {
-		printk
-		    (KERN_ERR "w83781d.o: Client deregistration failed, client not detached.\n");
+		dev_err(&client->dev,
+		       "Client deregistration failed, client not detached.\n");
 		return err;
 	}
 
-	if(i2c_is_isa_client(client)) {
+	if (i2c_is_isa_client(client)) {
 		release_region(client->addr, W83781D_EXTENT);
 	} else {
-		i2c_detach_client(&
-				  (((struct
-				     w83781d_data *) (client->data))->
-				   lm75[0]));
-		if((((struct w83781d_data *) (client->data))->type) != w83783s)
-			i2c_detach_client(&
-				  (((struct
-				     w83781d_data *) (client->data))->
-				   lm75[1]));
-		kfree(((struct w83781d_data *) (client->data))->lm75);
+		i2c_detach_client(&data->lm75[0]);
+		if (data->type != w83783s)
+			i2c_detach_client(&data->lm75[1]);
+		kfree(data->lm75);
 	}
 	kfree(client);
 
 	return 0;
 }
 
-static inline u16 swap_bytes(u16 val)
-{
-	return (val >> 8) | (val << 8);
-}
-
 /* The SMBus locks itself, usually, but nothing may access the Winbond between
    bank switches. ISA access must always be locked explicitly! 
    We ignore the W83781D BUSY flag at this moment - it could lead to deadlocks,
    would slow down the W83781D access and should not be necessary. 
    There are some ugly typecasts here, but the good news is - they should
    nowhere else be necessary! */
-static int w83781d_read_value(struct i2c_client *client, u16 reg)
+static int
+w83781d_read_value(struct i2c_client *client, u16 reg)
 {
+	struct w83781d_data *data = i2c_get_clientdata(client);
 	int res, word_sized, bank;
 	struct i2c_client *cl;
 
-	down(&(((struct w83781d_data *) (client->data))->lock));
+	down(&data->lock);
 	if (i2c_is_isa_client(client)) {
 		word_sized = (((reg & 0xff00) = 0x100)
 			      || ((reg & 0xff00) = 0x200))
@@ -1169,46 +1440,42 @@
 			res = i2c_smbus_read_byte_data(client, reg & 0xff);
 		} else {
 			/* switch to subclient */
-			cl -			    &(((struct w83781d_data *) (client->data))->
-			      lm75[bank - 1]);
+			cl = &data->lm75[bank - 1];
 			/* convert from ISA to LM75 I2C addresses */
 			switch (reg & 0xff) {
-			case 0x50: /* TEMP */
+			case 0x50:	/* TEMP */
 				res -				    swap_bytes(i2c_smbus_read_word_data
-					       (cl, 0));
+				    swap_bytes(i2c_smbus_read_word_data(cl, 0));
 				break;
-			case 0x52: /* CONFIG */
+			case 0x52:	/* CONFIG */
 				res = i2c_smbus_read_byte_data(cl, 1);
 				break;
-			case 0x53: /* HYST */
+			case 0x53:	/* HYST */
 				res -				    swap_bytes(i2c_smbus_read_word_data
-					       (cl, 2));
+				    swap_bytes(i2c_smbus_read_word_data(cl, 2));
 				break;
-			case 0x55: /* OVER */
+			case 0x55:	/* OVER */
 			default:
 				res -				    swap_bytes(i2c_smbus_read_word_data
-					       (cl, 3));
+				    swap_bytes(i2c_smbus_read_word_data(cl, 3));
 				break;
 			}
 		}
 		if (bank > 2)
-			i2c_smbus_write_byte_data(client, W83781D_REG_BANK,
-						  0);
+			i2c_smbus_write_byte_data(client, W83781D_REG_BANK, 0);
 	}
-	up(&(((struct w83781d_data *) (client->data))->lock));
+	up(&data->lock);
 	return res;
 }
 
-static int w83781d_write_value(struct i2c_client *client, u16 reg, u16 value)
+static int
+w83781d_write_value(struct i2c_client *client, u16 reg, u16 value)
 {
+	struct w83781d_data *data = i2c_get_clientdata(client);
 	int word_sized, bank;
 	struct i2c_client *cl;
 
-	down(&(((struct w83781d_data *) (client->data))->lock));
+	down(&data->lock);
 	if (i2c_is_isa_client(client)) {
 		word_sized = (((reg & 0xff00) = 0x100)
 			      || ((reg & 0xff00) = 0x200))
@@ -1227,8 +1494,7 @@
 			outb_p((reg & 0xff) + 1,
 			       client->addr + W83781D_ADDR_REG_OFFSET);
 		}
-		outb_p(value & 0xff,
-		       client->addr + W83781D_DATA_REG_OFFSET);
+		outb_p(value & 0xff, client->addr + W83781D_DATA_REG_OFFSET);
 		if (reg & 0xff00) {
 			outb_p(W83781D_REG_BANK,
 			       client->addr + W83781D_ADDR_REG_OFFSET);
@@ -1245,42 +1511,40 @@
 						  value & 0xff);
 		} else {
 			/* switch to subclient */
-			cl = &(((struct w83781d_data *) (client->data))->
-			      lm75[bank - 1]);
+			cl = &data->lm75[bank - 1];
 			/* convert from ISA to LM75 I2C addresses */
 			switch (reg & 0xff) {
-			case 0x52: /* CONFIG */
-				i2c_smbus_write_byte_data(cl, 1,
-							  value & 0xff);
+			case 0x52:	/* CONFIG */
+				i2c_smbus_write_byte_data(cl, 1, value & 0xff);
 				break;
-			case 0x53: /* HYST */
+			case 0x53:	/* HYST */
 				i2c_smbus_write_word_data(cl, 2,
 							  swap_bytes(value));
 				break;
-			case 0x55: /* OVER */
+			case 0x55:	/* OVER */
 				i2c_smbus_write_word_data(cl, 3,
 							  swap_bytes(value));
 				break;
 			}
 		}
 		if (bank > 2)
-			i2c_smbus_write_byte_data(client, W83781D_REG_BANK,
-						  0);
+			i2c_smbus_write_byte_data(client, W83781D_REG_BANK, 0);
 	}
-	up(&(((struct w83781d_data *) (client->data))->lock));
+	up(&data->lock);
 	return 0;
 }
 
 /* Called when we have found a new W83781D. It should set limits, etc. */
-static void w83781d_init_client(struct i2c_client *client)
+static void
+w83781d_init_client(struct i2c_client *client)
 {
-	struct w83781d_data *data = client->data;
+	struct w83781d_data *data = i2c_get_clientdata(client);
 	int vid = 0, i, p;
 	int type = data->type;
 	u8 tmp;
 
-	if(init && type != as99127f) { /* this resets registers we don't have
-			                  documentation for on the as99127f */
+	if (init && type != as99127f) {	/* this resets registers we don't have
+					   documentation for on the as99127f */
 		/* save these registers */
 		i = w83781d_read_value(client, W83781D_REG_BEEP_CONFIG);
 		p = w83781d_read_value(client, W83781D_REG_PWMCLK12);
@@ -1292,7 +1556,7 @@
 		w83781d_write_value(client, W83781D_REG_BEEP_CONFIG, i | 0x80);
 		w83781d_write_value(client, W83781D_REG_PWMCLK12, p);
 		/* Disable master beep-enable (reset turns it on).
-		   Individual beeps should be reset to off but for some reason
+		   Individual beep_mask should be reset to off but for some reason
 		   disabling this bit helps some people not get beeped */
 		w83781d_write_value(client, W83781D_REG_BEEP_INTS2, 0);
 	}
@@ -1300,7 +1564,8 @@
 	if (type != w83697hf) {
 		vid = w83781d_read_value(client, W83781D_REG_VID_FANDIV) & 0x0f;
 		vid |-		    (w83781d_read_value(client, W83781D_REG_CHIPID) & 0x01) << 4;
+		    (w83781d_read_value(client, W83781D_REG_CHIPID) & 0x01) <<
+		    4;
 		data->vrm = DEFAULT_VRM;
 		vid = vid_from_reg(vid, data->vrm);
 	}
@@ -1341,8 +1606,7 @@
 			int j;
 			for (j = 0; j < 32; j++) {
 				w83781d_write_value(client,
-						    W83781D_REG_RT_IDX,
-						    k++);
+						    W83781D_REG_RT_IDX, k++);
 				data->rt[i][j]  				    w83781d_read_value(client,
 						       W83781D_REG_RT_VAL);
@@ -1351,7 +1615,7 @@
 	}
 #endif				/* W83781D_RT */
 
-	if(init) {
+	if (init) {
 		w83781d_write_value(client, W83781D_REG_IN_MIN(0),
 				    IN_TO_REG(W83781D_INIT_IN_MIN_0));
 		w83781d_write_value(client, W83781D_REG_IN_MAX(0),
@@ -1408,7 +1672,9 @@
 			w83781d_write_value(client, W83781D_REG_IN_MAX(8),
 					    IN_TO_REG(W83781D_INIT_IN_MAX_8));
 			w83781d_write_value(client, W83781D_REG_VBAT,
-			    (w83781d_read_value(client, W83781D_REG_VBAT) | 0x01));
+					    (w83781d_read_value
+					     (client,
+					      W83781D_REG_VBAT) | 0x01));
 		}
 		w83781d_write_value(client, W83781D_REG_FAN_MIN(1),
 				    FAN_TO_REG(W83781D_INIT_FAN_MIN_1, 2));
@@ -1416,43 +1682,44 @@
 				    FAN_TO_REG(W83781D_INIT_FAN_MIN_2, 2));
 		if (type != w83697hf) {
 			w83781d_write_value(client, W83781D_REG_FAN_MIN(3),
-				    FAN_TO_REG(W83781D_INIT_FAN_MIN_3, 2));
+					    FAN_TO_REG(W83781D_INIT_FAN_MIN_3,
+						       2));
 		}
 
-		w83781d_write_value(client, W83781D_REG_TEMP_OVER,
+		w83781d_write_value(client, W83781D_REG_TEMP_OVER(1),
 				    TEMP_TO_REG(W83781D_INIT_TEMP_OVER));
-		w83781d_write_value(client, W83781D_REG_TEMP_HYST,
+		w83781d_write_value(client, W83781D_REG_TEMP_HYST(1),
 				    TEMP_TO_REG(W83781D_INIT_TEMP_HYST));
 
 		if (type = as99127f) {
-			w83781d_write_value(client, W83781D_REG_TEMP2_OVER,
+			w83781d_write_value(client, W83781D_REG_TEMP_OVER(2),
 					    AS99127_TEMP_ADD_TO_REG
 					    (W83781D_INIT_TEMP2_OVER));
-			w83781d_write_value(client, W83781D_REG_TEMP2_HYST,
+			w83781d_write_value(client, W83781D_REG_TEMP_HYST(2),
 					    AS99127_TEMP_ADD_TO_REG
 					    (W83781D_INIT_TEMP2_HYST));
 		} else {
-			w83781d_write_value(client, W83781D_REG_TEMP2_OVER,
+			w83781d_write_value(client, W83781D_REG_TEMP_OVER(2),
 					    TEMP_ADD_TO_REG
 					    (W83781D_INIT_TEMP2_OVER));
-			w83781d_write_value(client, W83781D_REG_TEMP2_HYST,
+			w83781d_write_value(client, W83781D_REG_TEMP_HYST(2),
 					    TEMP_ADD_TO_REG
 					    (W83781D_INIT_TEMP2_HYST));
 		}
 		w83781d_write_value(client, W83781D_REG_TEMP2_CONFIG, 0x00);
 
 		if (type = as99127f) {
-			w83781d_write_value(client, W83781D_REG_TEMP3_OVER,
+			w83781d_write_value(client, W83781D_REG_TEMP_OVER(3),
 					    AS99127_TEMP_ADD_TO_REG
 					    (W83781D_INIT_TEMP3_OVER));
-			w83781d_write_value(client, W83781D_REG_TEMP3_HYST,
+			w83781d_write_value(client, W83781D_REG_TEMP_HYST(3),
 					    AS99127_TEMP_ADD_TO_REG
 					    (W83781D_INIT_TEMP3_HYST));
 		} else if (type != w83783s && type != w83697hf) {
-			w83781d_write_value(client, W83781D_REG_TEMP3_OVER,
+			w83781d_write_value(client, W83781D_REG_TEMP_OVER(3),
 					    TEMP_ADD_TO_REG
 					    (W83781D_INIT_TEMP3_OVER));
-			w83781d_write_value(client, W83781D_REG_TEMP3_HYST,
+			w83781d_write_value(client, W83781D_REG_TEMP_HYST(3),
 					    TEMP_ADD_TO_REG
 					    (W83781D_INIT_TEMP3_HYST));
 		}
@@ -1462,9 +1729,9 @@
 		}
 		if (type != w83781d) {
 			/* enable comparator mode for temp2 and temp3 so
-		           alarm indication will work correctly */
+			   alarm indication will work correctly */
 			w83781d_write_value(client, W83781D_REG_IRQ, 0x41);
-			for(i = 0; i < 3; i++)
+			for (i = 0; i < 3; i++)
 				data->pwmenable[i] = 1;
 		}
 	}
@@ -1476,579 +1743,140 @@
 			    | 0x01);
 }
 
-static void w83781d_update_client(struct i2c_client *client)
+static void
+w83781d_update_client(struct i2c_client *client)
 {
-       struct w83781d_data *data = client->data;
-       int i;
-
-       down(&data->update_lock);
-
-       if (time_after(jiffies - data->last_updated, HZ + HZ / 2) ||
-           time_before(jiffies, data->last_updated) || !data->valid) {
-               pr_debug(KERN_DEBUG "Starting device update\n");
-
-               for (i = 0; i <= 8; i++) {
-                       if ((data->type = w83783s || data->type = w83697hf)
-                           && (i = 1))
-                               continue;       /* 783S has no in1 */
-                       data->in[i] -                           w83781d_read_value(client, W83781D_REG_IN(i));
-                       data->in_min[i] -                           w83781d_read_value(client,
-                                              W83781D_REG_IN_MIN(i));
-                       data->in_max[i] -                           w83781d_read_value(client,
-                                              W83781D_REG_IN_MAX(i));
-                       if ((data->type != w83782d) && (data->type != w83697hf)
-                           && (data->type != w83627hf) && (i = 6))
-                               break;
-               }
-               for (i = 1; i <= 3; i++) {
-                       data->fan[i - 1] -                           w83781d_read_value(client, W83781D_REG_FAN(i));
-                       data->fan_min[i - 1] -                           w83781d_read_value(client,
-                                              W83781D_REG_FAN_MIN(i));
-               }
-               if (data->type != w83781d) {
-                       for (i = 1; i <= 4; i++) {
-                               data->pwm[i - 1] -                                   w83781d_read_value(client,
-                                                      W83781D_REG_PWM(i));
-                               if (((data->type = w83783s)
-                                    || (data->type = w83627hf)
-                                    || (data->type = as99127f)
-                                    || (data->type = w83697hf)
-                                    || ((data->type = w83782d)
-                                       && i2c_is_isa_client(client)))
-                                   && i = 2)
-                                       break;
-                       }
-               }
-
-               data->temp = w83781d_read_value(client, W83781D_REG_TEMP);
-               data->temp_over -                   w83781d_read_value(client, W83781D_REG_TEMP_OVER);
-               data->temp_hyst -                   w83781d_read_value(client, W83781D_REG_TEMP_HYST);
-               data->temp_add[0] -                   w83781d_read_value(client, W83781D_REG_TEMP2);
-               data->temp_add_over[0] -                   w83781d_read_value(client, W83781D_REG_TEMP2_OVER);
-               data->temp_add_hyst[0] -                   w83781d_read_value(client, W83781D_REG_TEMP2_HYST);
-               if (data->type != w83783s && data->type != w83697hf) {
-                       data->temp_add[1] -                           w83781d_read_value(client, W83781D_REG_TEMP3);
-                       data->temp_add_over[1] -                           w83781d_read_value(client, W83781D_REG_TEMP3_OVER);
-                       data->temp_add_hyst[1] -                           w83781d_read_value(client, W83781D_REG_TEMP3_HYST);
-               }
-               i = w83781d_read_value(client, W83781D_REG_VID_FANDIV);
-               if (data->type != w83697hf) {
-                       data->vid = i & 0x0f;
-                       data->vid |-                           (w83781d_read_value(client, W83781D_REG_CHIPID) & 0x01)
-                           << 4;
-               }
-               data->fan_div[0] = (i >> 4) & 0x03;
-               data->fan_div[1] = (i >> 6) & 0x03;
-               if (data->type != w83697hf) {
-                       data->fan_div[2] = (w83781d_read_value(client,
-                                              W83781D_REG_PIN) >> 6) & 0x03;
-               }
-               if ((data->type != w83781d) && (data->type != as99127f)) {
-                       i = w83781d_read_value(client, W83781D_REG_VBAT);
-                       data->fan_div[0] |= (i >> 3) & 0x04;
-                       data->fan_div[1] |= (i >> 4) & 0x04;
-                       if (data->type != w83697hf)
-                               data->fan_div[2] |= (i >> 5) & 0x04;
-               }
-               data->alarms -                   w83781d_read_value(client,
-                                      W83781D_REG_ALARM1) +
-                   (w83781d_read_value(client, W83781D_REG_ALARM2) << 8);
-               if ((data->type = w83782d) || (data->type = w83627hf)) {
-                       data->alarms |-                           w83781d_read_value(client,
-                                              W83781D_REG_ALARM3) << 16;
-               }
-               i = w83781d_read_value(client, W83781D_REG_BEEP_INTS2);
-               data->beep_enable = i >> 7;
-               data->beeps = ((i & 0x7f) << 8) +
-                   w83781d_read_value(client, W83781D_REG_BEEP_INTS1);
-               if ((data->type != w83781d) && (data->type != as99127f)) {
-                       data->beeps |-                           w83781d_read_value(client,
-                                              W83781D_REG_BEEP_INTS3) << 16;
-               }
-               data->last_updated = jiffies;
-               data->valid = 1;
-       }
-
-	up(&data->update_lock);
-}
+	struct w83781d_data *data = i2c_get_clientdata(client);
+	int i;
 
+	down(&data->update_lock);
 
-/* The next few functions are the call-back functions of the /proc/sys and
-   sysctl files. Which function is used is defined in the ctl_table in
-   the extra1 field.
-   Each function must return the magnitude (power of 10 to divide the date
-   with) if it is called with operation=SENSORS_PROC_REAL_INFO. It must
-   put a maximum of *nrels elements in results reflecting the data of this
-   file, and set *nrels to the number it actually put in it, if operation=
-   SENSORS_PROC_REAL_READ. Finally, it must get upto *nrels elements from
-   results and write them to the chip, if operations=SENSORS_PROC_REAL_WRITE.
-   Note that on SENSORS_PROC_REAL_READ, I do not check whether results is
-   large enough (by checking the incoming value of *nrels). This is not very
-   good practice, but as long as you put less than about 5 values in results,
-   you can assume it is large enough. */
-static void w83781d_in(struct i2c_client *client, int operation, int ctl_name,
-               int *nrels_mag, long *results)
-{
-	struct w83781d_data *data = client->data;
-	int nr = ctl_name - W83781D_SYSCTL_IN0;
-
-	if (operation = SENSORS_PROC_REAL_INFO)
-		*nrels_mag = 2;
-	else if (operation = SENSORS_PROC_REAL_READ) {
-		w83781d_update_client(client);
-		results[0] = IN_FROM_REG(data->in_min[nr]);
-		results[1] = IN_FROM_REG(data->in_max[nr]);
-		results[2] = IN_FROM_REG(data->in[nr]);
-		*nrels_mag = 3;
-	} else if (operation = SENSORS_PROC_REAL_WRITE) {
-		if (*nrels_mag >= 1) {
-			data->in_min[nr] = IN_TO_REG(results[0]);
-			w83781d_write_value(client, W83781D_REG_IN_MIN(nr),
-					    data->in_min[nr]);
-		}
-		if (*nrels_mag >= 2) {
-			data->in_max[nr] = IN_TO_REG(results[1]);
-			w83781d_write_value(client, W83781D_REG_IN_MAX(nr),
-					    data->in_max[nr]);
-		}
-	}
-}
-
-void w83781d_fan(struct i2c_client *client, int operation, int ctl_name,
-		 int *nrels_mag, long *results)
-{
-	struct w83781d_data *data = client->data;
-	int nr = ctl_name - W83781D_SYSCTL_FAN1 + 1;
-
-	if (operation = SENSORS_PROC_REAL_INFO)
-		*nrels_mag = 0;
-	else if (operation = SENSORS_PROC_REAL_READ) {
-		w83781d_update_client(client);
-		results[0] = FAN_FROM_REG(data->fan_min[nr - 1],
-				  DIV_FROM_REG(data->fan_div[nr - 1]));
-		results[1] = FAN_FROM_REG(data->fan[nr - 1],
-			          DIV_FROM_REG(data->fan_div[nr - 1]));
-		*nrels_mag = 2;
-	} else if (operation = SENSORS_PROC_REAL_WRITE) {
-		if (*nrels_mag >= 1) {
-			data->fan_min[nr - 1] -			     FAN_TO_REG(results[0],
-			            DIV_FROM_REG(data->fan_div[nr-1]));
-			w83781d_write_value(client,
-					    W83781D_REG_FAN_MIN(nr),
-					    data->fan_min[nr - 1]);
-		}
-	}
-}
-
-void w83781d_temp(struct i2c_client *client, int operation, int ctl_name,
-		  int *nrels_mag, long *results)
-{
-	struct w83781d_data *data = client->data;
-	if (operation = SENSORS_PROC_REAL_INFO)
-		*nrels_mag = 1;
-	else if (operation = SENSORS_PROC_REAL_READ) {
-		w83781d_update_client(client);
-		results[0] = TEMP_FROM_REG(data->temp_over);
-		results[1] = TEMP_FROM_REG(data->temp_hyst);
-		results[2] = TEMP_FROM_REG(data->temp);
-		*nrels_mag = 3;
-	} else if (operation = SENSORS_PROC_REAL_WRITE) {
-		if (*nrels_mag >= 1) {
-			data->temp_over = TEMP_TO_REG(results[0]);
-			w83781d_write_value(client, W83781D_REG_TEMP_OVER,
-					    data->temp_over);
-		}
-		if (*nrels_mag >= 2) {
-			data->temp_hyst = TEMP_TO_REG(results[1]);
-			w83781d_write_value(client, W83781D_REG_TEMP_HYST,
-					    data->temp_hyst);
-		}
-	}
-}
-
-void w83781d_temp_add(struct i2c_client *client, int operation,
-		      int ctl_name, int *nrels_mag, long *results)
-{
-	struct w83781d_data *data = client->data;
-	int nr = ctl_name - W83781D_SYSCTL_TEMP2;
-
-	if (operation = SENSORS_PROC_REAL_INFO)
-		*nrels_mag = 1;
-	else if (operation = SENSORS_PROC_REAL_READ) {
-		w83781d_update_client(client);
-		if (data->type = as99127f) {
-			results[0] -			    AS99127_TEMP_ADD_FROM_REG(data->
-						      temp_add_over[nr]);
-			results[1] -			    AS99127_TEMP_ADD_FROM_REG(data->
-						      temp_add_hyst[nr]);
-			results[2] -			    AS99127_TEMP_ADD_FROM_REG(data->temp_add[nr]);
-		} else {
-			results[0] -			    TEMP_ADD_FROM_REG(data->temp_add_over[nr]);
-			results[1] -			    TEMP_ADD_FROM_REG(data->temp_add_hyst[nr]);
-			results[2] = TEMP_ADD_FROM_REG(data->temp_add[nr]);
-		}
-		*nrels_mag = 3;
-	} else if (operation = SENSORS_PROC_REAL_WRITE) {
-		if (*nrels_mag >= 1) {
-			if (data->type = as99127f)
-				data->temp_add_over[nr] -				    AS99127_TEMP_ADD_TO_REG(results[0]);
-			else
-				data->temp_add_over[nr] -				    TEMP_ADD_TO_REG(results[0]);
-			w83781d_write_value(client,
-					    nr ? W83781D_REG_TEMP3_OVER :
-					    W83781D_REG_TEMP2_OVER,
-					    data->temp_add_over[nr]);
-		}
-		if (*nrels_mag >= 2) {
-			if (data->type = as99127f)
-				data->temp_add_hyst[nr] -				    AS99127_TEMP_ADD_TO_REG(results[1]);
-			else
-				data->temp_add_hyst[nr] -				    TEMP_ADD_TO_REG(results[1]);
-			w83781d_write_value(client,
-					    nr ? W83781D_REG_TEMP3_HYST :
-					    W83781D_REG_TEMP2_HYST,
-					    data->temp_add_hyst[nr]);
+	if (time_after
+	    (jiffies - data->last_updated, (unsigned long) (HZ + HZ / 2))
+	    || time_before(jiffies, data->last_updated) || !data->valid) {
+		pr_debug(KERN_DEBUG "Starting device update\n");
+
+		for (i = 0; i <= 8; i++) {
+			if ((data->type = w83783s || data->type = w83697hf)
+			    && (i = 1))
+				continue;	/* 783S has no in1 */
+			data->in[i] +			    w83781d_read_value(client, W83781D_REG_IN(i));
+			data->in_min[i] +			    w83781d_read_value(client, W83781D_REG_IN_MIN(i));
+			data->in_max[i] +			    w83781d_read_value(client, W83781D_REG_IN_MAX(i));
+			if ((data->type != w83782d) && (data->type != w83697hf)
+			    && (data->type != w83627hf) && (i = 6))
+				break;
 		}
-	}
-}
-
-
-void w83781d_vid(struct i2c_client *client, int operation, int ctl_name,
-		 int *nrels_mag, long *results)
-{
-	struct w83781d_data *data = client->data;
-	if (operation = SENSORS_PROC_REAL_INFO)
-		*nrels_mag = 3;
-	else if (operation = SENSORS_PROC_REAL_READ) {
-		w83781d_update_client(client);
-		results[0] = vid_from_reg(data->vid, data->vrm);
-		*nrels_mag = 1;
-	}
-}
-
-void w83781d_vrm(struct i2c_client *client, int operation, int ctl_name,
-		 int *nrels_mag, long *results)
-{
-	struct w83781d_data *data = client->data;
-	if (operation = SENSORS_PROC_REAL_INFO)
-		*nrels_mag = 1;
-	else if (operation = SENSORS_PROC_REAL_READ) {
-		results[0] = data->vrm;
-		*nrels_mag = 1;
-	} else if (operation = SENSORS_PROC_REAL_WRITE) {
-		if (*nrels_mag >= 1)
-			data->vrm = results[0];
-	}
-}
-
-void w83781d_alarms(struct i2c_client *client, int operation, int ctl_name,
-		    int *nrels_mag, long *results)
-{
-	struct w83781d_data *data = client->data;
-	if (operation = SENSORS_PROC_REAL_INFO)
-		*nrels_mag = 0;
-	else if (operation = SENSORS_PROC_REAL_READ) {
-		w83781d_update_client(client);
-		results[0] = ALARMS_FROM_REG(data->alarms);
-		*nrels_mag = 1;
-	}
-}
-
-void w83781d_beep(struct i2c_client *client, int operation, int ctl_name,
-		  int *nrels_mag, long *results)
-{
-	struct w83781d_data *data = client->data;
-	int val;
-
-	if (operation = SENSORS_PROC_REAL_INFO)
-		*nrels_mag = 0;
-	else if (operation = SENSORS_PROC_REAL_READ) {
-		w83781d_update_client(client);
-		results[0] = BEEP_ENABLE_FROM_REG(data->beep_enable);
-		results[1] = BEEPS_FROM_REG(data->beeps);
-		*nrels_mag = 2;
-	} else if (operation = SENSORS_PROC_REAL_WRITE) {
-		if (*nrels_mag >= 2) {
-			data->beeps = BEEPS_TO_REG(results[1]);
-			w83781d_write_value(client, W83781D_REG_BEEP_INTS1,
-					    data->beeps & 0xff);
-			if ((data->type != w83781d) &&
-			    (data->type != as99127f)) {
-				w83781d_write_value(client,
-						    W83781D_REG_BEEP_INTS3,
-						    ((data-> beeps) >> 16) &
-						      0xff);
+		for (i = 1; i <= 3; i++) {
+			data->fan[i - 1] +			    w83781d_read_value(client, W83781D_REG_FAN(i));
+			data->fan_min[i - 1] +			    w83781d_read_value(client, W83781D_REG_FAN_MIN(i));
+		}
+		if (data->type != w83781d) {
+			for (i = 1; i <= 4; i++) {
+				data->pwm[i - 1] +				    w83781d_read_value(client,
+						       W83781D_REG_PWM(i));
+				if (((data->type = w83783s)
+				     || (data->type = w83627hf)
+				     || (data->type = as99127f)
+				     || (data->type = w83697hf)
+				     || ((data->type = w83782d)
+					 && i2c_is_isa_client(client)))
+				    && i = 2)
+					break;
 			}
-			val = (data->beeps >> 8) & 0x7f;
-		} else if (*nrels_mag >= 1)
-			val -			    w83781d_read_value(client,
-					       W83781D_REG_BEEP_INTS2) &
-			    0x7f;
-		if (*nrels_mag >= 1) {
-			data->beep_enable = BEEP_ENABLE_TO_REG(results[0]);
-			w83781d_write_value(client, W83781D_REG_BEEP_INTS2,
-					    val | data->beep_enable << 7);
 		}
-	}
-}
 
-/* w83697hf only has two fans */
-void w83781d_fan_div(struct i2c_client *client, int operation,
-		     int ctl_name, int *nrels_mag, long *results)
-{
-	struct w83781d_data *data = client->data;
-	int old, old2, old3 = 0;
-
-	if (operation = SENSORS_PROC_REAL_INFO)
-		*nrels_mag = 0;
-	else if (operation = SENSORS_PROC_REAL_READ) {
-		w83781d_update_client(client);
-		results[0] = DIV_FROM_REG(data->fan_div[0]);
-		results[1] = DIV_FROM_REG(data->fan_div[1]);
-		if (data->type = w83697hf) {
-			*nrels_mag = 2;
-		} else {
-			results[2] = DIV_FROM_REG(data->fan_div[2]);
-			*nrels_mag = 3;
-		}
-	} else if (operation = SENSORS_PROC_REAL_WRITE) {
-		old = w83781d_read_value(client, W83781D_REG_VID_FANDIV);
-		/* w83781d and as99127f don't have extended divisor bits */
-		if ((data->type != w83781d) && data->type != as99127f) {
-			old3 -			    w83781d_read_value(client, W83781D_REG_VBAT);
-		}
-		if (*nrels_mag >= 3 && data->type != w83697hf) {
-			data->fan_div[2] -			    DIV_TO_REG(results[2], data->type);
-			old2 = w83781d_read_value(client, W83781D_REG_PIN);
-			old2 -			    (old2 & 0x3f) | ((data->fan_div[2] & 0x03) << 6);
-			w83781d_write_value(client, W83781D_REG_PIN, old2);
-			if ((data->type != w83781d) &&
-			    (data->type != as99127f)) {
-				old3 -				    (old3 & 0x7f) |
-				    ((data->fan_div[2] & 0x04) << 5);
-			}
-		}
-		if (*nrels_mag >= 2) {
-			data->fan_div[1] -			    DIV_TO_REG(results[1], data->type);
-			old -			    (old & 0x3f) | ((data->fan_div[1] & 0x03) << 6);
-			if ((data->type != w83781d) &&
-			    (data->type != as99127f)) {
-				old3 -				    (old3 & 0xbf) |
-				    ((data->fan_div[1] & 0x04) << 4);
-			}
-		}
-		if (*nrels_mag >= 1) {
-			data->fan_div[0] -			    DIV_TO_REG(results[0], data->type);
-			old -			    (old & 0xcf) | ((data->fan_div[0] & 0x03) << 4);
-			w83781d_write_value(client, W83781D_REG_VID_FANDIV,
-					    old);
-			if ((data->type != w83781d) &&
-			    (data->type != as99127f)) {
-				old3 -				    (old3 & 0xdf) |
-				    ((data->fan_div[0] & 0x04) << 3);
-				w83781d_write_value(client,
-						    W83781D_REG_VBAT,
-						    old3);
-			}
+		data->temp = w83781d_read_value(client, W83781D_REG_TEMP(1));
+		data->temp_min +		    w83781d_read_value(client, W83781D_REG_TEMP_OVER(1));
+		data->temp_max +		    w83781d_read_value(client, W83781D_REG_TEMP_HYST(1));
+		data->temp_add[0] +		    w83781d_read_value(client, W83781D_REG_TEMP(2));
+		data->temp_max_add[0] +		    w83781d_read_value(client, W83781D_REG_TEMP_OVER(2));
+		data->temp_min_add[0] +		    w83781d_read_value(client, W83781D_REG_TEMP_HYST(2));
+		if (data->type != w83783s && data->type != w83697hf) {
+			data->temp_add[1] +			    w83781d_read_value(client, W83781D_REG_TEMP(3));
+			data->temp_max_add[1] +			    w83781d_read_value(client,
+					       W83781D_REG_TEMP_OVER(3));
+			data->temp_min_add[1] +			    w83781d_read_value(client,
+					       W83781D_REG_TEMP_HYST(3));
 		}
-	}
-}
-
-void w83781d_pwm(struct i2c_client *client, int operation, int ctl_name,
-		 int *nrels_mag, long *results)
-{
-	struct w83781d_data *data = client->data;
-	int nr = 1 + ctl_name - W83781D_SYSCTL_PWM1;
-	int j, k;
-
-	if (operation = SENSORS_PROC_REAL_INFO)
-		*nrels_mag = 0;
-	else if (operation = SENSORS_PROC_REAL_READ) {
-		w83781d_update_client(client);
-		results[0] = PWM_FROM_REG(data->pwm[nr - 1]);
-		results[1] = data->pwmenable[nr - 1];
-		*nrels_mag = 2;
-	} else if (operation = SENSORS_PROC_REAL_WRITE) {
-		if (*nrels_mag >= 1) {
-			data->pwm[nr - 1] = PWM_TO_REG(results[0]);
-			w83781d_write_value(client, W83781D_REG_PWM(nr),
-					    data->pwm[nr - 1]);
-		}
-		/* only PWM2 can be enabled/disabled */
-		if (*nrels_mag >= 2 && nr = 2) {
-			j = w83781d_read_value(client, W83781D_REG_PWMCLK12);
-			k = w83781d_read_value(client, W83781D_REG_BEEP_CONFIG);
-			if(results[1]) {
-				if(!(j & 0x08))
-					w83781d_write_value(client,
-					     W83781D_REG_PWMCLK12, j | 0x08);
-				if(k & 0x10)
-					w83781d_write_value(client,
-					     W83781D_REG_BEEP_CONFIG, k & 0xef);
-				data->pwmenable[1] = 1;
-			} else {
-				if(j & 0x08)
-					w83781d_write_value(client,
-					     W83781D_REG_PWMCLK12, j & 0xf7);
-				if(!(k & 0x10))
-					w83781d_write_value(client,
-					     W83781D_REG_BEEP_CONFIG, j | 0x10);
-				data->pwmenable[1] = 0;
-			}
+		i = w83781d_read_value(client, W83781D_REG_VID_FANDIV);
+		if (data->type != w83697hf) {
+			data->vid = i & 0x0f;
+			data->vid |+			    (w83781d_read_value(client, W83781D_REG_CHIPID) &
+			     0x01)
+			    << 4;
+		}
+		data->fan_div[0] = (i >> 4) & 0x03;
+		data->fan_div[1] = (i >> 6) & 0x03;
+		if (data->type != w83697hf) {
+			data->fan_div[2] = (w83781d_read_value(client,
+							       W83781D_REG_PIN)
+					    >> 6) & 0x03;
+		}
+		if ((data->type != w83781d) && (data->type != as99127f)) {
+			i = w83781d_read_value(client, W83781D_REG_VBAT);
+			data->fan_div[0] |= (i >> 3) & 0x04;
+			data->fan_div[1] |= (i >> 4) & 0x04;
+			if (data->type != w83697hf)
+				data->fan_div[2] |= (i >> 5) & 0x04;
+		}
+		data->alarms +		    w83781d_read_value(client,
+				       W83781D_REG_ALARM1) +
+		    (w83781d_read_value(client, W83781D_REG_ALARM2) << 8);
+		if ((data->type = w83782d) || (data->type = w83627hf)) {
+			data->alarms |+			    w83781d_read_value(client,
+					       W83781D_REG_ALARM3) << 16;
 		}
-	}
-}
-
-void w83781d_sens(struct i2c_client *client, int operation, int ctl_name,
-		  int *nrels_mag, long *results)
-{
-	struct w83781d_data *data = client->data;
-	int nr = 1 + ctl_name - W83781D_SYSCTL_SENS1;
-	u8 tmp;
-
-	if (operation = SENSORS_PROC_REAL_INFO)
-		*nrels_mag = 0;
-	else if (operation = SENSORS_PROC_REAL_READ) {
-		results[0] = data->sens[nr - 1];
-		*nrels_mag = 1;
-	} else if (operation = SENSORS_PROC_REAL_WRITE) {
-		if (*nrels_mag >= 1) {
-			switch (results[0]) {
-			case 1:	/* PII/Celeron diode */
-				tmp = w83781d_read_value(client,
-						       W83781D_REG_SCFG1);
-				w83781d_write_value(client,
-						    W83781D_REG_SCFG1,
-						    tmp | BIT_SCFG1[nr -
-								    1]);
-				tmp = w83781d_read_value(client,
-						       W83781D_REG_SCFG2);
-				w83781d_write_value(client,
-						    W83781D_REG_SCFG2,
-						    tmp | BIT_SCFG2[nr -
-								    1]);
-				data->sens[nr - 1] = results[0];
-				break;
-			case 2:	/* 3904 */
-				tmp = w83781d_read_value(client,
-						       W83781D_REG_SCFG1);
-				w83781d_write_value(client,
-						    W83781D_REG_SCFG1,
-						    tmp | BIT_SCFG1[nr -
-								    1]);
-				tmp = w83781d_read_value(client,
-						       W83781D_REG_SCFG2);
-				w83781d_write_value(client,
-						    W83781D_REG_SCFG2,
-						    tmp & ~BIT_SCFG2[nr -
-								     1]);
-				data->sens[nr - 1] = results[0];
-				break;
-			case W83781D_DEFAULT_BETA:	/* thermistor */
-				tmp = w83781d_read_value(client,
-						       W83781D_REG_SCFG1);
-				w83781d_write_value(client,
-						    W83781D_REG_SCFG1,
-						    tmp & ~BIT_SCFG1[nr -
-								     1]);
-				data->sens[nr - 1] = results[0];
-				break;
-			default:
-				printk
-				    (KERN_ERR "w83781d.o: Invalid sensor type %ld; must be 1, 2, or %d\n",
-				     results[0], W83781D_DEFAULT_BETA);
-				break;
-			}
+		i = w83781d_read_value(client, W83781D_REG_BEEP_INTS2);
+		data->beep_enable = i >> 7;
+		data->beep_mask = ((i & 0x7f) << 8) +
+		    w83781d_read_value(client, W83781D_REG_BEEP_INTS1);
+		if ((data->type != w83781d) && (data->type != as99127f)) {
+			data->beep_mask |+			    w83781d_read_value(client,
+					       W83781D_REG_BEEP_INTS3) << 16;
 		}
+		data->last_updated = jiffies;
+		data->valid = 1;
 	}
-}
-
-#ifdef W83781D_RT
-static void w83781d_rt(struct i2c_client *client, int operation, int ctl_name,
-               int *nrels_mag, long *results)
-{
-	struct w83781d_data *data = client->data;
-	int nr = 1 + ctl_name - W83781D_SYSCTL_RT1;
-	int i;
 
-	if (operation = SENSORS_PROC_REAL_INFO)
-		*nrels_mag = 0;
-	else if (operation = SENSORS_PROC_REAL_READ) {
-		for (i = 0; i < 32; i++) {
-			results[i] = data->rt[nr - 1][i];
-		}
-		*nrels_mag = 32;
-	} else if (operation = SENSORS_PROC_REAL_WRITE) {
-		if (*nrels_mag > 32)
-			*nrels_mag = 32;
-		for (i = 0; i < *nrels_mag; i++) {
-			/* fixme: no bounds checking 0-255 */
-			data->rt[nr - 1][i] = results[i];
-			w83781d_write_value(client, W83781D_REG_RT_IDX, i);
-			w83781d_write_value(client, W83781D_REG_RT_VAL,
-					    data->rt[nr - 1][i]);
-		}
-	}
+	up(&data->update_lock);
 }
-#endif
 
-static int __init sm_w83781d_init(void)
+static int __init
+sensors_w83781d_init(void)
 {
-	printk(KERN_INFO "w83781d.o version %s (%s)\n", LM_VERSION, LM_DATE);
 	return i2c_add_driver(&w83781d_driver);
 }
 
-static void __exit sm_w83781d_exit(void)
+static void __exit
+sensors_w83781d_exit(void)
 {
 	i2c_del_driver(&w83781d_driver);
 }
 
-
-
 MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>, "
 	      "Philip Edelbrock <phil@netroedge.com>, "
 	      "and Mark Studebaker <mdsxyz123@yahoo.com>");
 MODULE_DESCRIPTION("W83781D driver");
 MODULE_LICENSE("GPL");
 
-module_init(sm_w83781d_init);
-module_exit(sm_w83781d_exit);
+module_init(sensors_w83781d_init);
+module_exit(sensors_w83781d_exit);
Index: kernel/include/i2c-dev.h
=================================RCS file: /home/cvs/lm_sensors2/kernel/include/i2c-dev.h,v
retrieving revision 1.7
diff -a -u -r1.7 i2c-dev.h
--- kernel/include/i2c-dev.h	21 Jan 2003 20:01:26 -0000	1.7
+++ kernel/include/i2c-dev.h	25 Apr 2003 18:29:31 -0000
@@ -19,343 +19,28 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
 
-/* $Id: i2c-dev.h,v 1.7 2003/01/21 20:01:26 kmalkki Exp $ */
+/* $Id: i2c-dev.h,v 1.13 2003/01/21 08:08:16 kmalkki Exp $ */
 
-#ifndef LIB_I2CDEV_H
-#define LIB_I2CDEV_H
+#ifndef _LINUX_I2C_DEV_H
+#define _LINUX_I2C_DEV_H
 
 #include <linux/types.h>
-#include <sys/ioctl.h>
-
-
-/* -- i2c.h -- */
-
-
-/*
- * I2C Message - used for pure i2c transaction, also from /dev interface
- */
-struct i2c_msg {
-	__u16 addr;	/* slave address			*/
-	unsigned short flags;		
-#define I2C_M_TEN	0x10	/* we have a ten bit chip address	*/
-#define I2C_M_RD	0x01
-#define I2C_M_NOSTART	0x4000
-#define I2C_M_REV_DIR_ADDR	0x2000
-#define I2C_M_IGNORE_NAK	0x1000
-#define I2C_M_NO_RD_ACK		0x0800
-	short len;		/* msg length				*/
-	char *buf;		/* pointer to msg data			*/
-	int err;
-	short done;
-};
-
-/* To determine what functionality is present */
-
-#define I2C_FUNC_I2C			0x00000001
-#define I2C_FUNC_10BIT_ADDR		0x00000002
-#define I2C_FUNC_PROTOCOL_MANGLING	0x00000004 /* I2C_M_{REV_DIR_ADDR,NOSTART,..} */
-#define I2C_FUNC_SMBUS_HWPEC_CALC	0x00000008 /* SMBus 2.0 */
-#define I2C_FUNC_SMBUS_READ_WORD_DATA_PEC  0x00000800 /* SMBus 2.0 */ 
-#define I2C_FUNC_SMBUS_WRITE_WORD_DATA_PEC 0x00001000 /* SMBus 2.0 */ 
-#define I2C_FUNC_SMBUS_PROC_CALL_PEC	0x00002000 /* SMBus 2.0 */
-#define I2C_FUNC_SMBUS_BLOCK_PROC_CALL_PEC 0x00004000 /* SMBus 2.0 */
-#define I2C_FUNC_SMBUS_BLOCK_PROC_CALL	0x00008000 /* SMBus 2.0 */
-#define I2C_FUNC_SMBUS_QUICK		0x00010000 
-#define I2C_FUNC_SMBUS_READ_BYTE	0x00020000 
-#define I2C_FUNC_SMBUS_WRITE_BYTE	0x00040000 
-#define I2C_FUNC_SMBUS_READ_BYTE_DATA	0x00080000 
-#define I2C_FUNC_SMBUS_WRITE_BYTE_DATA	0x00100000 
-#define I2C_FUNC_SMBUS_READ_WORD_DATA	0x00200000 
-#define I2C_FUNC_SMBUS_WRITE_WORD_DATA	0x00400000 
-#define I2C_FUNC_SMBUS_PROC_CALL	0x00800000 
-#define I2C_FUNC_SMBUS_READ_BLOCK_DATA	0x01000000 
-#define I2C_FUNC_SMBUS_WRITE_BLOCK_DATA 0x02000000 
-#define I2C_FUNC_SMBUS_READ_I2C_BLOCK	0x04000000 /* I2C-like block xfer  */
-#define I2C_FUNC_SMBUS_WRITE_I2C_BLOCK	0x08000000 /* w/ 1-byte reg. addr. */
-#define I2C_FUNC_SMBUS_READ_I2C_BLOCK_2	 0x10000000 /* I2C-like block xfer  */
-#define I2C_FUNC_SMBUS_WRITE_I2C_BLOCK_2 0x20000000 /* w/ 2-byte reg. addr. */
-#define I2C_FUNC_SMBUS_READ_BLOCK_DATA_PEC  0x40000000 /* SMBus 2.0 */
-#define I2C_FUNC_SMBUS_WRITE_BLOCK_DATA_PEC 0x80000000 /* SMBus 2.0 */
-
-#define I2C_FUNC_SMBUS_BYTE I2C_FUNC_SMBUS_READ_BYTE | \
-                            I2C_FUNC_SMBUS_WRITE_BYTE
-#define I2C_FUNC_SMBUS_BYTE_DATA I2C_FUNC_SMBUS_READ_BYTE_DATA | \
-                                 I2C_FUNC_SMBUS_WRITE_BYTE_DATA
-#define I2C_FUNC_SMBUS_WORD_DATA I2C_FUNC_SMBUS_READ_WORD_DATA | \
-                                 I2C_FUNC_SMBUS_WRITE_WORD_DATA
-#define I2C_FUNC_SMBUS_BLOCK_DATA I2C_FUNC_SMBUS_READ_BLOCK_DATA | \
-                                  I2C_FUNC_SMBUS_WRITE_BLOCK_DATA
-#define I2C_FUNC_SMBUS_I2C_BLOCK I2C_FUNC_SMBUS_READ_I2C_BLOCK | \
-                                  I2C_FUNC_SMBUS_WRITE_I2C_BLOCK
-#define I2C_FUNC_SMBUS_I2C_BLOCK_2 I2C_FUNC_SMBUS_READ_I2C_BLOCK_2 | \
-                                   I2C_FUNC_SMBUS_WRITE_I2C_BLOCK_2
-#define I2C_FUNC_SMBUS_BLOCK_DATA_PEC I2C_FUNC_SMBUS_READ_BLOCK_DATA_PEC | \
-                                      I2C_FUNC_SMBUS_WRITE_BLOCK_DATA_PEC
-#define I2C_FUNC_SMBUS_WORD_DATA_PEC  I2C_FUNC_SMBUS_READ_WORD_DATA_PEC | \
-                                      I2C_FUNC_SMBUS_WRITE_WORD_DATA_PEC
-
-#define I2C_FUNC_SMBUS_READ_BYTE_PEC		I2C_FUNC_SMBUS_READ_BYTE_DATA
-#define I2C_FUNC_SMBUS_WRITE_BYTE_PEC		I2C_FUNC_SMBUS_WRITE_BYTE_DATA
-#define I2C_FUNC_SMBUS_READ_BYTE_DATA_PEC	I2C_FUNC_SMBUS_READ_WORD_DATA
-#define I2C_FUNC_SMBUS_WRITE_BYTE_DATA_PEC	I2C_FUNC_SMBUS_WRITE_WORD_DATA
-#define I2C_FUNC_SMBUS_BYTE_PEC			I2C_FUNC_SMBUS_BYTE_DATA
-#define I2C_FUNC_SMBUS_BYTE_DATA_PEC		I2C_FUNC_SMBUS_WORD_DATA
-
-#define I2C_FUNC_SMBUS_EMUL I2C_FUNC_SMBUS_QUICK | \
-                            I2C_FUNC_SMBUS_BYTE | \
-                            I2C_FUNC_SMBUS_BYTE_DATA | \
-                            I2C_FUNC_SMBUS_WORD_DATA | \
-                            I2C_FUNC_SMBUS_PROC_CALL | \
-                            I2C_FUNC_SMBUS_WRITE_BLOCK_DATA | \
-                            I2C_FUNC_SMBUS_WRITE_BLOCK_DATA_PEC | \
-                            I2C_FUNC_SMBUS_I2C_BLOCK
-
-/* 
- * Data for SMBus Messages 
- */
-#define I2C_SMBUS_BLOCK_MAX	32	/* As specified in SMBus standard */	
-#define I2C_SMBUS_I2C_BLOCK_MAX	32	/* Not specified but we use same structure */
-union i2c_smbus_data {
-	__u8 byte;
-	__u16 word;
-	__u8 block[I2C_SMBUS_BLOCK_MAX + 3]; /* block[0] is used for length */
-                          /* one more for read length in block process call */
-	                                            /* and one more for PEC */
-};
-
-/* smbus_access read or write markers */
-#define I2C_SMBUS_READ	1
-#define I2C_SMBUS_WRITE	0
-
-/* SMBus transaction types (size parameter in the above functions) 
-   Note: these no longer correspond to the (arbitrary) PIIX4 internal codes! */
-#define I2C_SMBUS_QUICK		    0
-#define I2C_SMBUS_BYTE		    1
-#define I2C_SMBUS_BYTE_DATA	    2 
-#define I2C_SMBUS_WORD_DATA	    3
-#define I2C_SMBUS_PROC_CALL	    4
-#define I2C_SMBUS_BLOCK_DATA	    5
-#define I2C_SMBUS_I2C_BLOCK_DATA    6
-#define I2C_SMBUS_BLOCK_PROC_CALL   7		/* SMBus 2.0 */
-#define I2C_SMBUS_BLOCK_DATA_PEC    8		/* SMBus 2.0 */
-#define I2C_SMBUS_PROC_CALL_PEC     9		/* SMBus 2.0 */
-#define I2C_SMBUS_BLOCK_PROC_CALL_PEC  10	/* SMBus 2.0 */
-#define I2C_SMBUS_WORD_DATA_PEC	   11		/* SMBus 2.0 */
-
-
-/* ----- commands for the ioctl like i2c_command call:
- * note that additional calls are defined in the algorithm and hw 
- *	dependent layers - these can be listed here, or see the 
- *	corresponding header files.
- */
-				/* -> bit-adapter specific ioctls	*/
-#define I2C_RETRIES	0x0701	/* number of times a device address      */
-				/* should be polled when not            */
-                                /* acknowledging 			*/
-#define I2C_TIMEOUT	0x0702	/* set timeout - call with int 		*/
-
-
-/* this is for i2c-dev.c	*/
-#define I2C_SLAVE	0x0703	/* Change slave address			*/
-				/* Attn.: Slave address is 7 or 10 bits */
-#define I2C_SLAVE_FORCE	0x0706	/* Change slave address			*/
-				/* Attn.: Slave address is 7 or 10 bits */
-				/* This changes the address, even if it */
-				/* is already taken!			*/
-#define I2C_TENBIT	0x0704	/* 0 for 7 bit addrs, != 0 for 10 bit	*/
-
-#define I2C_FUNCS	0x0705	/* Get the adapter functionality */
-#define I2C_RDWR	0x0707	/* Combined R/W transfer (one stop only)*/
-#define I2C_PEC		0x0708	/* != 0 for SMBus PEC                   */
-#if 0
-#define I2C_ACK_TEST	0x0710	/* See if a slave is at a specific address */
-#endif
-
-#define I2C_SMBUS	0x0720	/* SMBus-level access */
-
-/* -- i2c.h -- */
-
 
+/* Some IOCTL commands are defined in <linux/i2c.h> */
 /* Note: 10-bit addresses are NOT supported! */
 
 /* This is the structure as used in the I2C_SMBUS ioctl call */
 struct i2c_smbus_ioctl_data {
-	char read_write;
+	__u8 read_write;
 	__u8 command;
-	int size;
+	__u32 size;
 	union i2c_smbus_data *data;
 };
 
 /* This is the structure as used in the I2C_RDWR ioctl call */
 struct i2c_rdwr_ioctl_data {
 	struct i2c_msg *msgs;	/* pointers to i2c_msgs */
-	int nmsgs;		/* number of i2c_msgs */
+	__u32 nmsgs;		/* number of i2c_msgs */
 };
 
-
-static inline __s32 i2c_smbus_access(int file, char read_write, __u8 command, 
-                                     int size, union i2c_smbus_data *data)
-{
-	struct i2c_smbus_ioctl_data args;
-
-	args.read_write = read_write;
-	args.command = command;
-	args.size = size;
-	args.data = data;
-	return ioctl(file,I2C_SMBUS,&args);
-}
-
-
-static inline __s32 i2c_smbus_write_quick(int file, __u8 value)
-{
-	return i2c_smbus_access(file,value,0,I2C_SMBUS_QUICK,NULL);
-}
-	
-static inline __s32 i2c_smbus_read_byte(int file)
-{
-	union i2c_smbus_data data;
-	if (i2c_smbus_access(file,I2C_SMBUS_READ,0,I2C_SMBUS_BYTE,&data))
-		return -1;
-	else
-		return 0x0FF & data.byte;
-}
-
-static inline __s32 i2c_smbus_write_byte(int file, __u8 value)
-{
-	return i2c_smbus_access(file,I2C_SMBUS_WRITE,value,
-	                        I2C_SMBUS_BYTE,NULL);
-}
-
-static inline __s32 i2c_smbus_read_byte_data(int file, __u8 command)
-{
-	union i2c_smbus_data data;
-	if (i2c_smbus_access(file,I2C_SMBUS_READ,command,
-	                     I2C_SMBUS_BYTE_DATA,&data))
-		return -1;
-	else
-		return 0x0FF & data.byte;
-}
-
-static inline __s32 i2c_smbus_write_byte_data(int file, __u8 command, 
-                                              __u8 value)
-{
-	union i2c_smbus_data data;
-	data.byte = value;
-	return i2c_smbus_access(file,I2C_SMBUS_WRITE,command,
-	                        I2C_SMBUS_BYTE_DATA, &data);
-}
-
-static inline __s32 i2c_smbus_read_word_data(int file, __u8 command)
-{
-	union i2c_smbus_data data;
-	if (i2c_smbus_access(file,I2C_SMBUS_READ,command,
-	                     I2C_SMBUS_WORD_DATA,&data))
-		return -1;
-	else
-		return 0x0FFFF & data.word;
-}
-
-static inline __s32 i2c_smbus_write_word_data(int file, __u8 command, 
-                                              __u16 value)
-{
-	union i2c_smbus_data data;
-	data.word = value;
-	return i2c_smbus_access(file,I2C_SMBUS_WRITE,command,
-	                        I2C_SMBUS_WORD_DATA, &data);
-}
-
-static inline __s32 i2c_smbus_process_call(int file, __u8 command, __u16 value)
-{
-	union i2c_smbus_data data;
-	data.word = value;
-	if (i2c_smbus_access(file,I2C_SMBUS_WRITE,command,
-	                     I2C_SMBUS_PROC_CALL,&data))
-		return -1;
-	else
-		return 0x0FFFF & data.word;
-}
-
-
-/* Returns the number of read bytes */
-static inline __s32 i2c_smbus_read_block_data(int file, __u8 command, 
-                                              __u8 *values)
-{
-	union i2c_smbus_data data;
-	int i;
-	if (i2c_smbus_access(file,I2C_SMBUS_READ,command,
-	                     I2C_SMBUS_BLOCK_DATA,&data))
-		return -1;
-	else {
-		for (i = 1; i <= data.block[0]; i++)
-			values[i-1] = data.block[i];
-		return data.block[0];
-	}
-}
-
-static inline __s32 i2c_smbus_write_block_data(int file, __u8 command, 
-                                               __u8 length, __u8 *values)
-{
-	union i2c_smbus_data data;
-	int i;
-	if (length > 32)
-		length = 32;
-	for (i = 1; i <= length; i++)
-		data.block[i] = values[i-1];
-	data.block[0] = length;
-	return i2c_smbus_access(file,I2C_SMBUS_WRITE,command,
-	                        I2C_SMBUS_BLOCK_DATA, &data);
-}
-
-/* Returns the number of read bytes */
-static inline __s32 i2c_smbus_read_i2c_block_data(int file, __u8 command,
-                                                  __u8 *values)
-{
-	union i2c_smbus_data data;
-	int i;
-	if (i2c_smbus_access(file,I2C_SMBUS_READ,command,
-	                      I2C_SMBUS_I2C_BLOCK_DATA,&data))
-		return -1;
-	else {
-		for (i = 1; i <= data.block[0]; i++)
-			values[i-1] = data.block[i];
-		return data.block[0];
-	}
-}
-
-static inline __s32 i2c_smbus_write_i2c_block_data(int file, __u8 command,
-                                               __u8 length, __u8 *values)
-{
-	union i2c_smbus_data data;
-	int i;
-	if (length > 32)
-		length = 32;
-	for (i = 1; i <= length; i++)
-		data.block[i] = values[i-1];
-	data.block[0] = length;
-	return i2c_smbus_access(file,I2C_SMBUS_WRITE,command,
-	                        I2C_SMBUS_I2C_BLOCK_DATA, &data);
-}
-
-/* Returns the number of read bytes */
-static inline __s32 i2c_smbus_block_process_call(int file, __u8 command,
-                                                 __u8 length, __u8 *values)
-{
-	union i2c_smbus_data data;
-	int i;
-	if (length > 32)
-		length = 32;
-	for (i = 1; i <= length; i++)
-		data.block[i] = values[i-1];
-	data.block[0] = length;
-	if (i2c_smbus_access(file,I2C_SMBUS_WRITE,command,
-	                     I2C_SMBUS_BLOCK_PROC_CALL,&data))
-		return -1;
-	else {
-		for (i = 1; i <= data.block[0]; i++)
-			values[i-1] = data.block[i];
-		return data.block[0];
-	}
-}
-
-
-#endif /* LIB_I2CDEV_H */
+#endif /* _LINUX_I2C_DEV_H */
