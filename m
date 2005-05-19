From: floyd@unpunk.com (Matt Mercer)
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: [patch] i2c-ali1535 fixup
Message-Id: <20030711223230.GA24311@unpunk.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I have been maintaining a reworked version of the i2c-ali1535 driver since
the lm_sensors 2.7.0 snapshot. I have merged my changes with the current cvs
head.  Would be cool to see this get passed up to the kernel at this point.

Summary of changes:
- improved device initialization
- improved smbus initialization and error handling


Thanks
Matt Mercer
fee@users.sourceforge.net

-------------- next part --------------
Index: kernel/busses/i2c-ali1535.c
=================================RCS file: /home/cvs/lm_sensors2/kernel/busses/i2c-ali1535.c,v
retrieving revision 1.15
diff -u -2 -r1.15 i2c-ali1535.c
--- kernel/busses/i2c-ali1535.c	23 Jun 2003 01:21:04 -0000	1.15
+++ kernel/busses/i2c-ali1535.c	11 Jul 2003 22:35:42 -0000
@@ -2,5 +2,7 @@
     i2c-ali1535.c - Part of lm_sensors, Linux kernel modules for hardware
                     monitoring
-    Copyright (c) 2000  Frodo Looijaard <frodol@dds.nl>, 
+    Copyright (c) 2000, 2003
+                        Matt Mercer <fee@users.sourceforge.net>
+                        Frodo Looijaard <frodol@dds.nl>, 
                         Philip Edelbrock <phil@netroedge.com>, 
                         Mark D. Studebaker <mdsxyz123@yahoo.com>,
@@ -24,33 +26,37 @@
 
 /*
-    This is the driver for the SMB Host controller on
-    Acer Labs Inc. (ALI) M1535 South Bridge.
+   This is the driver for the SMB Host controller on Acer Labs Inc. (ALi) M7101
+   PMU component of the M1535 South Bridge.  The SMB controller is part of the
+   M7101 device, which is an ACPI compliant Power Management Unit (PMU).
+
+   The M1535 is a South bridge for portable systems.  It is very similar to
+   the M15x3 South bridges also produced by ALi. There are 4 primary verions
+   of this chip, they are labeled 1535 (notebook), 1535D (desktop), 1535+ and
+   1535D+. According to the datasheet and the pci config data these chips
+   report a PCI ID of 1533 although they are actually M1535. This is atleast
+   the case for the M1535 B1 and probably many others. 
+
+   Some of the differences between the 1533 and 1535, registers within the 
+   M7101 component have moved and some have been redefined slightly. 
+   Additionally, the sequencing of the SMBus transactions has been modified
+   to be more consistent with the sequencing recommended by the manufacturer
+   and observed through testing. These changes are reflected in this driver
+   and can be identified by comparing this driver to the i2c-ali15x3 driver.
+   For an overview of these chips see http://www.ali.com.tw/
 
-    The M1535 is a South bridge for portable systems.
-    It is very similar to the M15x3 South bridges also produced
-    by Acer Labs Inc.  Some of the registers within the part
-    have moved and some have been redefined slightly. Additionally,
-    the sequencing of the SMBus transactions has been modified
-    to be more consistent with the sequencing recommended by
-    the manufacturer and observed through testing.  These
-    changes are reflected in this driver and can be identified
-    by comparing this driver to the i2c-ali15x3 driver.
-    For an overview of these chips see http://www.acerlabs.com
-
-    The SMB controller is part of the 7101 device, which is an
-    ACPI-compliant Power Management Unit (PMU).
-
-    The whole 7101 device has to be enabled for the SMB to work.
-    You can't just enable the SMB alone.
-    The SMB and the ACPI have separate I/O spaces.
-    We make sure that the SMB is enabled. We leave the ACPI alone.
+   Both the ACPI and SMBus I/O spaces must be enabled.  We make sure that the
+   SMBus is enabled. We leave the ACPI alone.
 
-    This driver controls the SMB Host only.
-
-    This driver does not use interrupts.
+   This driver controls the SMB Host only.
+   This driver does not use interrupts.
 */
 
 
-/* Note: we assume there can only be one ALI1535, with one SMBus interface */
+/*
+ * Note: we assume there can only be one ALI1535/7101, with one SMBus interface
+ */
+
+
+#include <linux/version.h>
 
 #include <linux/module.h>
@@ -66,86 +72,101 @@
 #include "version.h"
 
+#undef ALI_DEBUG 
 
-/* ALI1535 SMBus address offsets */
-#define SMBHSTSTS (0 + ali1535_smba)
-#define SMBHSTTYP (1 + ali1535_smba)
-#define SMBHSTPORT (2 + ali1535_smba)
-#define SMBHSTCMD (7 + ali1535_smba)
-#define SMBHSTADD (3 + ali1535_smba)
-#define SMBHSTDAT0 (4 + ali1535_smba)
-#define SMBHSTDAT1 (5 + ali1535_smba)
-#define SMBBLKDAT (6 + ali1535_smba)
-
-/* PCI Address Constants */
-#define SMBCOM    0x004
-#define SMBREV    0x008
-#define SMBCFG    0x0D1
-#define SMBBA     0x0E2
-#define SMBHSTCFG 0x0F0
-#define SMBCLK    0x0F2
-
-/* Other settings */
-#define MAX_TIMEOUT 500		/* times 1/100 sec */
-#define ALI1535_SMB_IOSIZE 32
-
-/* 
-*/
-#define ALI1535_SMB_DEFAULTBASE 0x8040
-
-/* ALI1535 address lock bits */
-#define ALI1535_LOCK	0x06 < dwe >
 
-/* ALI1535 command constants */
-#define ALI1535_QUICK      0x00
-#define ALI1535_BYTE       0x10
-#define ALI1535_BYTE_DATA  0x20
-#define ALI1535_WORD_DATA  0x30
-#define ALI1535_BLOCK_DATA 0x40
-#define ALI1535_I2C_READ   0x60
 
-#define	ALI1535_DEV10B_EN	0x80	/* Enable 10-bit addressing in */
+/* PCI Address Constants of the M7101 PMU */
+#define M7101_COM     0x04 /* M7101 COM, command register */
+#define M7101_RID     0x08 /* M7101 RID, revision ID register */
+#define M7101_CFG     0xD1 /* M7101 CFG_SET, configuration setting */
+#define M7101_SMBBASE 0xE2 /* M7101 SMB_BASE, SMB I/O base addres setting */
+#define M7101_SMBHST  0xF0 /* M7101 SMB_HOST, SMBus Host Configuration */
+#define M7101_SMBIDLE 0xF2 /* M7101 SMB_IDLE, SMBus Idle Time */
+
+/* Default M7101 base address */
+#define SMB_SMB_DEFAULTBASE 0x8040
+
+/* M7101 SMB IO register address offsets */
+#define SMB_STATUS (0 + ali1535_smba) /* SMB host controller status register */
+#define SMB_TYPE (1 + ali1535_smba)   /* SMB command type register */
+#define SMB_SPORT (2 + ali1535_smba)  /* Start Cycle Port & Alert Addr */
+#define SMB_ADD (3 + ali1535_smba)    /* Dev addr register & count for block */
+#define SMB_DATA0 (4 + ali1535_smba)  /* Dev DATA 0 register */
+#define SMB_DATA1 (5 + ali1535_smba)  /* Dev DATA 1 register */
+#define SMB_BLKDAT (6 + ali1535_smba) /* Dev BLOCK DATA register */
+#define SMB_CMD (7 + ali1535_smba)    /* SMB command register */
+
+/* M7101 SMB_STATUS register */
+#define SMB_STS_ALERT       0x01    /* Alert-Response-Address cmd issued */
+#define SMB_STS_A_10_BITS   0x02    /* set when ALERT */
+#define SMB_STS_IDLE        0x04    /* host idle */
+#define SMB_STS_BUSY        0x08    /* host busy */
+#define SMB_STS_DONE        0x10    /* transaction complete */
+#define SMB_STS_DEV         0x20    /* device error */
+#define SMB_STS_BUSERR      0x40    /* bus error/collision */
+#define SMB_STS_FAIL        0x80    /* failed bus transaction */
+#define SMB_STS_ERR         0xe0    /* all the bad error bits */
+#define SMB_STS_RST         0xff    /* all the bad error bits */
+
+/* M7101 SMB_TYP command constants */
+#define	SMB_TYP_KILL       0x04      /* Kill Command (write)        */
+#define	SMB_TYP_T_OUT_CMD  0x08      /* Time-out Command (write)    */
+#define SMB_TYP_QUICK      0x00      /* Quick command               */
+#define SMB_TYP_BYTE       0x10      /* Send/Rcv byte               */
+#define SMB_TYP_BYTE_DATA  0x20      /* Write/Read byte             */
+#define SMB_TYP_WORD_DATA  0x30      /* Write/Read word             */
+#define SMB_TYP_BLOCK_DATA 0x40      /* Write/Read block            */
+#define SMB_TYP_PROC_CALL  0x50      /* I2C Process call            */
+
+
+/* M7101 SMB_TYPE read data */
+#define	SMB_A_HIGH_BIT8 0x04     /* Bit 8 of 10-bit address in  */
+                                     /*  Alert-Response-Address     */
+                                     /*  (read)                     */
+#define	SMB_A_HIGH_BIT9 0x08     /* Bit 9 of 10-bit address in  */
+                                     /* Alert-Response-Address      */
+                                     /* (read)                      */
+#define	SMB_D_HI_MASK 0x03       /* Mask for isolating bits 9-8 */
+                                     /*  of 10-bit address in I2C   */ 
+                                     /*  Read Command               */
+#define	SMB_DEV10B_EN	0x80	/* Enable 10-bit addressing in */
                                         /*  I2C read                   */
-#define	ALI1535_T_OUT		0x08	/* Time-out Command (write)    */
-#define	ALI1535_A_HIGH_BIT9	0x08	/* Bit 9 of 10-bit address in  */
-                                        /* Alert-Response-Address      */
-                                        /* (read)                      */
-#define	ALI1535_KILL		0x04	/* Kill Command (write)        */
-#define	ALI1535_A_HIGH_BIT8	0x04	/* Bit 8 of 10-bit address in  */
-                                        /*  Alert-Response-Address     */
-                                        /*  (read)                     */
-
-#define	ALI1535_D_HI_MASK	0x03	/* Mask for isolating bits 9-8 */
-                                        /*  of 10-bit address in I2C   */ 
-                                        /*  Read Command               */
-
-/* ALI1535 status register bits */
-#define ALI1535_STS_IDLE	0x04
-#define ALI1535_STS_BUSY	0x08	/* host busy */
-#define ALI1535_STS_DONE	0x10	/* transaction complete */
-#define ALI1535_STS_DEV		0x20	/* device error */
-#define ALI1535_STS_BUSERR	0x40	/* bus error    */
-#define ALI1535_STS_FAIL	0x80    /* failed bus transaction */
-#define ALI1535_STS_ERR		0xE0	/* all the bad error bits */
-
-#define ALI1535_BLOCK_CLR	0x04	/* reset block data index */
+#define SMB_BLOCK_CLR	0x04	/* reset block data index */
 
 /* ALI1535 device address register bits */
-#define	ALI1535_RD_ADDR		0x01	/* Read/Write Bit in Device    */
+#define	SMB_RD_ADDR		0x01	/* Read/Write Bit in Device    */
                                         /*  Address field              */
                                         /*  -> Write = 0               */
                                         /*  -> Read  = 1               */
-#define	ALI1535_SMBIO_EN	0x04	/* SMB I/O Space enable        */
+#define	SMB_SMBIO_EN	0x04	/* SMB I/O Space enable        */
+
+/* Other settings */
+#define MAX_TIMEOUT 100		/* times 1/100 sec */
+#define SMB_IDLE_TIMEOUT 0x50   /* bus transaction idle timer */
+                                /* bits 7-5 base clock
+                                 *           000: 149K
+                                 *           001: 74K (default)
+                                 *           010: 31K *works best*
+                                 *           100: 223K
+                                 *           101: 111K
+                                 *           110: 55K
+                                 * bits 4-3 delay timer
+                                 *           00: base clock x 4 (default)
+                                 *           01: base clock x 2
+                                 *           10: base clock x 8 *works best*
+                                 *           11: reserved
+                                 * bits 2-0 reserved
+                                 */
+
+#define SMB_SMB_IOSIZE 32
 
 static void ali1535_do_pause(unsigned int amount);
 static int ali1535_transaction(void);
+static int ali1535_reset(void);
 
 static unsigned short ali1535_smba = 0;
 DECLARE_MUTEX(i2c_ali1535_sem);
 
-
-/* Detect whether a ALI1535 can be found, and initialize it, where necessary.
-   Note the differences between kernels with the old PCI BIOS interface and
-   newer kernels with the real PCI interface. In compat.h some things are
-   defined to make the transition easier. */
+/* Detect whether a M7101 can be found, and initialize it. */
 int ali1535_setup(struct pci_dev *ALI1535_dev)
 {
@@ -153,72 +174,49 @@
 	unsigned char temp;
 
-/* Check the following things:
-	- SMB I/O address is initialized
-	- Device is enabled
-	- We can use the addresses
-*/
-
-/* Determine the address of the SMBus area */
-	pci_read_config_word(ALI1535_dev, SMBBA, &ali1535_smba);
-	ali1535_smba &= (0xffff & ~(ALI1535_SMB_IOSIZE - 1));
+	/* Determine the address of the SMBus area */
+	pci_read_config_word(ALI1535_dev, M7101_SMBBASE, &ali1535_smba);
+	ali1535_smba &= (0xffff & ~(SMB_SMB_IOSIZE - 1));
 	if (ali1535_smba = 0) {
-		printk
-		    ("i2c-ali1535.o: ALI1535_smb region uninitialized - upgrade BIOS?\n");
+		printk("i2c-ali1535: M7101 SMBus region uninitialized\n");
 		error_return = -ENODEV;
-	}
-
-	if (error_return = -ENODEV)
 		goto END;
-
-	if (check_region(ali1535_smba, ALI1535_SMB_IOSIZE)) {
-		printk
-		    ("i2c-ali1535.o: ALI1535_smb region 0x%x already in use!\n",
-		     ali1535_smba);
-		error_return = -ENODEV;
 	}
+	printk("i2c-ali1535: M7101 SMBus region at 0x%04x\n", ali1535_smba);
 
-	if (error_return = -ENODEV)
-		goto END;
-
-	/* check if whole device is enabled */
-	pci_read_config_byte(ALI1535_dev, SMBCFG, &temp);
-	if ((temp & ALI1535_SMBIO_EN) = 0) {
-		printk
-		    ("i2c-ali1535.o: SMB device not enabled - upgrade BIOS?\n");
+	/* 
+	 * Check the following things:
+	 * - SMB I/O address is initialized
+	 * - Device is enabled
+	 * - We can use the addresses
+	 */
+
+	/* SMB IO space enabled? */
+	pci_read_config_byte(ALI1535_dev, M7101_CFG, &temp);
+	if (!(temp & SMB_SMBIO_EN)) {
+		printk("i2c-ali1535: M7101 SMBus device not enabled\n");
 		error_return = -ENODEV;
 		goto END;
 	}
 
-/* Is SMB Host controller enabled? */
-	pci_read_config_byte(ALI1535_dev, SMBHSTCFG, &temp);
-	if ((temp & 1) = 0) {
-		printk
-		    ("i2c-ali1535.o: SMBus controller not enabled - upgrade BIOS?\n");
+	/* SMB Host controller interface enabled? */
+	pci_read_config_byte(ALI1535_dev, M7101_SMBHST, &temp);
+	if (!(temp & 1)) {
+		printk("i2c-ali1535: M7101 SMBus controller not enabled(0x%02x)\n",
+			temp);
 		error_return = -ENODEV;
 		goto END;
 	}
 
-/* set SMB clock to 74KHz as recommended in data sheet */
-	pci_write_config_byte(ALI1535_dev, SMBCLK, 0x20);
+	/* set SMB idle timer */
+	pci_write_config_byte(ALI1535_dev, M7101_SMBIDLE, SMB_IDLE_TIMEOUT);
 
 	/* Everything is happy, let's grab the memory and set things up. */
-	request_region(ali1535_smba, ALI1535_SMB_IOSIZE, "ali1535-smb");
-
-#ifdef DEBUG
-/*
-  The interrupt routing for SMB is set up in register 0x77 in the
-  1533 ISA Bridge device, NOT in the 7101 device.
-  Don't bother with finding the 1533 device and reading the register.
-  if ((....... & 0x0F) = 1)
-     printk("i2c-ali1535.o: ALI1535 using Interrupt 9 for SMBus.\n");
-*/
-	pci_read_config_byte(ALI1535_dev, SMBREV, &temp);
-	printk("i2c-ali1535.o: SMBREV = 0x%X\n", temp);
-	printk("i2c-ali1535.o: ALI1535_smba = 0x%X\n", ali1535_smba);
-#endif				/* DEBUG */
-
-      END:
+	if(NULL = request_region(ali1535_smba, SMB_SMB_IOSIZE, "ali1535_smb")) {
+		printk("i2c-ali1535: failed to get region 0x%04x\n", ali1535_smba);
+		goto END;
+	}
+END:
 	return error_return;
-}
+} /* end ali1535_setup */
 
 
@@ -231,227 +229,201 @@
 
 /* Another internally used function */
-int ali1535_transaction(void)
+int ali1535_reset(void)
 {
-	int temp;
-	int result = 0;
-	int timeout = 0;
-
-#ifdef DEBUG
-	printk
-	    ("i2c-ali1535.o: Transaction (pre): STS=%02x, TYP=%02x, CMD=%02x, ADD=%02x, DAT0=%02x, "
-	     "DAT1=%02x\n", inb_p(SMBHSTSTS), inb_p(SMBHSTTYP),
-	     inb_p(SMBHSTCMD), inb_p(SMBHSTADD), inb_p(SMBHSTDAT0),
-	     inb_p(SMBHSTDAT1));
-#endif
+/*
+ * If the host controller is still busy, it may have timed out in the previous
+ * transaction, resulting in a "SMBus Timeout" printk.
+ * I've tried the following to reset a stuck busy bit.
+ *       1. Reset the controller and the other SMBus devices with a T_OUT 
+ *          command. (this clears the host busy bit if an external device is
+ *          hung, but it comes back upon a new access to a device)
+ *       2. Reset the controller with an KILL command.
+ *          (this doesn't seem to clear the controller if an external device
+ *          is hung)
+ * Worst case, nothing seems to work except power reset.
+ */
 
 	/* get status */
-	temp = inb_p(SMBHSTSTS);
-
-	/* Make sure the SMBus host is ready to start transmitting */
+	int status = inb(SMB_STATUS);
+  
 	/* Check the busy bit first */
-	if (temp & ALI1535_STS_BUSY) {
-/*
-   If the host controller is still busy, it may have timed out in the previous transaction,
-   resulting in a "SMBus Timeout" printk.
-   I've tried the following to reset a stuck busy bit.
-	1. Reset the controller with an KILL command.
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
-    printk("i2c-ali1535.o: Resetting host controller to clear busy condition\n",temp);
+	if (status & SMB_STS_BUSY) {
+		printk("i2c-ali1535: Issuing T_OUT to clear busy condition 0x%02x\n", status);
+		/* Abort/KILL - reset the host controller */
+		outb(SMB_TYP_T_OUT_CMD, SMB_TYPE);
+		outb(SMB_STS_RST, SMB_STATUS); /* reset status */
+		status = inb(SMB_STATUS);
+#ifdef ALI_DEBUG
+		printk("i2c-ali1535: T_OUT results condition 0x%02x\n", status);
 #endif
-    outb_p(ALI1535_KILL, SMBHSTTYP);
-    temp = inb_p(SMBHSTSTS);
-    if (temp & ALI1535_STS_BUSY) {
-*/
+	}
 
-/*
-   Try resetting entire SMB bus, including other devices -
-   This may not work either - it clears the BUSY bit but
-   then the BUSY bit may come back on when you try and use the chip again.
-   If that's the case you are stuck.
-*/
-		printk
-		    ("i2c-ali1535.o: Resetting entire SMB Bus to clear busy condition (%02x)\n",
-		     temp);
-		outb_p(ALI1535_T_OUT, SMBHSTTYP);
-		temp = inb_p(SMBHSTSTS);
+	/*
+	 * Try resetting entire SMB bus, including other devices, this may not
+	 * work either - it clears the BUSY bit but the BUSY bit may come back
+	 * on when you try and use the chip again.
+	 */
+	if (status & SMB_STS_ERR) {
+		printk("i2c-ali1535: Issuing KILL to clear condition 0x%02x\n", status);
+		outb(SMB_TYP_KILL, SMB_TYPE);
+		outb(SMB_STS_RST, SMB_STATUS); /* reset status */
+		status = inb(SMB_STATUS);
+#ifdef ALI_DEBUG
+		printk("i2c-ali1535: KILL results condition 0x%02x\n", status);
+#endif
 	}
-/*
-  }
-*/
 
-	/* now check the error bits and the busy bit */
-	if (temp & (ALI1535_STS_ERR | ALI1535_STS_BUSY)) {
-		/* do a clear-on-write */
-		outb_p(0xFF, SMBHSTSTS);
-		if ((temp = inb_p(SMBHSTSTS)) &
-		    (ALI1535_STS_ERR | ALI1535_STS_BUSY)) {
-			/* this is probably going to be correctable only by a power reset
-			   as one of the bits now appears to be stuck */
-			/* This may be a bus or device with electrical problems. */
-			printk
-			    ("i2c-ali1535.o: SMBus reset failed! (0x%02x) - controller or device on bus is probably hung\n",
-			     temp);
-			return -1;
-		}
-	} else {
-		/* check and clear done bit */
-		if (temp & ALI1535_STS_DONE) {
-			outb_p(temp, SMBHSTSTS);
-		}
+	/*
+	 * This is probably going to be correctable only by a power reset as
+	 * one of the bits now appears to be stuck. This may be a bus or device
+	 * with electrical problems.
+	 */
+	if (status & SMB_STS_ERR) {
+		printk ("i2c-ali1535: SMBus reset failed, controller or device "
+			"on bus is probably hung 0x%02x\n", status);
+		return -1;
 	}
+	else return 0;
+}
+
+
+int ali1535_transaction(void)
+{
+#ifdef ALI_DEBUG
+  printk("i2c-ali1535: transaction (pre): STS=%02x, TYP=%02x, PORT=%02x, "
+         "ADD=%02x, DAT0=%02x, DAT1=%02x, CMD=%02x\n", 
+         inb(SMB_STATUS), inb(SMB_TYPE), inb(SMB_SPORT), inb(SMB_ADD),
+         inb(SMB_DATA0), inb(SMB_DATA1), inb(SMB_CMD));
+#endif
+
+	int status, result, timeout = 0;
+
+	status = inb(SMB_STATUS);
 
 	/* start the transaction by writing anything to the start register */
-	outb_p(0xFF, SMBHSTPORT);
+	if (status & SMB_STS_IDLE)
+		outb(0x01, SMB_SPORT);
+	else return -1;
 
 	/* We will always wait for a fraction of a second! */
-	timeout = 0;
 	do {
 		ali1535_do_pause(1);
-		temp = inb_p(SMBHSTSTS);
-	} while (((temp & ALI1535_STS_BUSY) && !(temp & ALI1535_STS_IDLE))
-		 && (timeout++ < MAX_TIMEOUT));
+		status = inb(SMB_STATUS);
+#ifdef ALI_DEBUG
+  printk("i2c-ali1535: transaction (DO): STS=%02x, TYP=%02x, PORT=%02x, "
+	 "ADD=%02x, DAT0=%02x, DAT1=%02x, CMD=%02x\n", 
+         inb(SMB_STATUS), inb(SMB_TYPE), inb(SMB_SPORT), inb(SMB_ADD),
+         inb(SMB_DATA0), inb(SMB_DATA1), inb(SMB_CMD));
+#endif
+	} while (((status & SMB_STS_BUSY) || !(status & SMB_STS_IDLE))
+		&& (timeout++ < MAX_TIMEOUT));
 
 	/* If the SMBus is still busy, we give up */
 	if (timeout >= MAX_TIMEOUT) {
-		result = -1;
-		printk("i2c-ali1535.o: SMBus Timeout!\n");
+		printk("i2c-ali1535: SMBus Timeout! 0x%02x\n", status);
+		return -1;
 	}
 
-	if (temp & ALI1535_STS_FAIL) {
+	if (status & SMB_STS_DONE)
+		outb(SMB_STS_RST, SMB_STATUS);
+	else if (status & SMB_STS_FAIL)
+		return -1;
+	/*
+	 * the ALI SMB controller maps "no response" and "bus collision"
+	 * into a single bit. No reponse is the usual case so don't do a printk.
+	 * This means that bus collisions go unreported.
+	 */
+	else if (status & SMB_STS_BUSERR) {
+		outb(SMB_STS_RST, SMB_STATUS);
 		result = -1;
-#ifdef DEBUG
-		printk("i2c-ali1535.o: Error: Failed bus transaction\n");
+#ifdef ALI_DEBUG
+	printk("i2c-ali1535: Error: no response or bus collision STS=%02x"
+	       " ADD=%02x\n", inb(SMB_STATUS),inb(SMB_ADD));
 #endif
 	}
-
-/*
-  Unfortunately the ALI SMB controller maps "no response" and "bus collision"
-  into a single bit. No reponse is the usual case so don't do a printk.
-  This means that bus collisions go unreported.
-*/
-	if (temp & ALI1535_STS_BUSERR) {
+	else if (status & SMB_STS_DEV) {
+		printk("i2c-ali1535: Error: device error STS=%02x\n", status);
 		result = -1;
-#ifdef DEBUG
-		printk
-		    ("i2c-ali1535.o: Error: no response or bus collision ADD=%02x\n",
-		     inb_p(SMBHSTADD));
-#endif
 	}
 
-/* haven't ever seen this */
-	if (temp & ALI1535_STS_DEV) {
+	else {
+		printk("i2c-ali1535: Error: command never completed, STS=%02x\n", status);
 		result = -1;
-		printk("i2c-ali1535.o: Error: device error\n");
 	}
 
-/* 
-   check to see if the "command complete" indication is set
- */
-	if (!(temp & ALI1535_STS_DONE)) {
-		result = -1;
-		printk("i2c-ali1535.o: Error: command never completed\n");
-	}
-#ifdef DEBUG
-	printk
-	    ("i2c-ali1535.o: Transaction (post): STS=%02x, TYP=%02x, CMD=%02x, ADD=%02x, "
-	     "DAT0=%02x, DAT1=%02x\n", inb_p(SMBHSTSTS), inb_p(SMBHSTTYP),
-	     inb_p(SMBHSTCMD), inb_p(SMBHSTADD), inb_p(SMBHSTDAT0),
-	     inb_p(SMBHSTDAT1));
+#ifdef ALI_DEBUG
+	printk("i2c-ali1535: transaction (post): STS=%02x, TYP=%02x, PORT=%02x, "
+		"ADD=%02x, DAT0=%02x, DAT1=%02x, CMD=%02x\n", 
+		inb(SMB_STATUS), inb(SMB_TYPE), inb(SMB_SPORT), inb(SMB_ADD),
+		inb(SMB_DATA0), inb(SMB_DATA1), inb(SMB_CMD));
 #endif
-
-/* 
-    take consequent actions for error conditions
- */
-        if (!(temp & ALI1535_STS_DONE)) {
-	  /* issue "kill" to reset host controller */
-	  outb_p(ALI1535_KILL,SMBHSTTYP);
-	  outb_p(0xFF,SMBHSTSTS);
-	}	  
-	else if (temp & ALI1535_STS_ERR) {
-	  /* issue "timeout" to reset all devices on bus */
-	  outb_p(ALI1535_T_OUT,SMBHSTTYP);
-	  outb_p(0xFF,SMBHSTSTS);
-	}
-        
 	return result;
-}
+} /* end ali1535_transaction() */
 
-/* Return -1 on error. */
-s32 ali1535_access(struct i2c_adapter * adap, u16 addr,
+s32 ali1535_access(struct i2c_adapter* adap, u16 addr,
 		   unsigned short flags, char read_write, u8 command,
-		   int size, union i2c_smbus_data * data)
+		   int size, union i2c_smbus_data* data)
 {
-	int i, len;
-	int temp;
-	int timeout;
+	int i, len, temp, timeout = 0;
+	u8 status = 0;
 	s32 result = 0;
 
 	down(&i2c_ali1535_sem);
-/* make sure SMBus is idle */
-	temp = inb_p(SMBHSTSTS);
-	for (timeout = 0;
-	     (timeout < MAX_TIMEOUT) && !(temp & ALI1535_STS_IDLE);
-	     timeout++) {
-		ali1535_do_pause(1);
-		temp = inb_p(SMBHSTSTS);
-	}
-	if (timeout >= MAX_TIMEOUT) {
-		printk("i2c-ali1535.o: Idle wait Timeout! STS=0x%02x\n",
-		       temp);
-	}
 
-/* clear status register (clear-on-write) */
-	outb_p(0xFF, SMBHSTSTS);
+#ifdef ALI_DEBUG
+	printk("i2c-ali1535: Access (pre): STS=%02x, TYP=%02x, PORT=%02x, "
+		"ADD=%02x, DAT0=%02x, DAT1=%02x, CMD=%02x\n", 
+		inb(SMB_STATUS), inb(SMB_TYPE), inb(SMB_SPORT), inb(SMB_ADD),
+		inb(SMB_DATA0), inb(SMB_DATA1), inb(SMB_CMD));
+#endif
+
+	/* clear status register */
+	outb(SMB_STS_RST, SMB_STATUS);
 
 	switch (size) {
+	case I2C_SMBUS_PROC_CALL:
+		printk("i2c-ali1535: I2C_SMBUS_PROC_CALL not supported!\n");
+		result = -1;
+		goto EXIT;
 	case I2C_SMBUS_QUICK:
-		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
-		       SMBHSTADD);
-		size = ALI1535_QUICK;
-                outb_p(size, SMBHSTTYP);	/* output command */
-                break;
+		//printk("i2c-ali1535: access: I2C_SMBUS_QUCK\n");
+		outb(((addr & 0x7f) << 1) | (read_write & 0x01), SMB_ADD);
+		size = SMB_TYP_QUICK;
+		outb(size, SMB_TYPE);  /* output command */
+		break;
 	case I2C_SMBUS_BYTE:
-		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
-		       SMBHSTADD);
-		size = ALI1535_BYTE;
-                outb_p(size, SMBHSTTYP);	/* output command */
+		//printk("i2c-ali1535: access: I2C_SMBUS_BYTE\n");
+		outb(((addr & 0x7f) << 1) | (read_write & 0x01), SMB_ADD);
+		size = SMB_TYP_BYTE;
+		outb(size, SMB_TYPE);  /* output command */
 		if (read_write = I2C_SMBUS_WRITE)
-			outb_p(command, SMBHSTCMD);
+			outb(command, SMB_CMD);
 		break;
 	case I2C_SMBUS_BYTE_DATA:
-		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
-		       SMBHSTADD);
-		size = ALI1535_BYTE_DATA;
-                outb_p(size, SMBHSTTYP);	/* output command */
-		outb_p(command, SMBHSTCMD);
+		//printk("i2c-ali1535: access: I2C_SMBUS_BYTE_DATA\n");
+		outb(((addr & 0x7f) << 1) | (read_write & 0x01), SMB_ADD);
+		size = SMB_TYP_BYTE_DATA;
+		outb(size, SMB_TYPE);  /* output command */
+		outb(command, SMB_CMD);
 		if (read_write = I2C_SMBUS_WRITE)
-			outb_p(data->byte, SMBHSTDAT0);
+			outb(data->byte, SMB_DATA0);
 		break;
 	case I2C_SMBUS_WORD_DATA:
-		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
-		       SMBHSTADD);
-		size = ALI1535_WORD_DATA;
-                outb_p(size, SMBHSTTYP);	/* output command */
-		outb_p(command, SMBHSTCMD);
+		//printk("i2c-ali1535: access: I2C_SMBUS_WORD_DATA\n");
+		outb(((addr & 0x7f) << 1) | (read_write & 0x01), SMB_ADD);
+		size = SMB_TYP_WORD_DATA;
+		outb(size, SMB_TYPE);  /* output command */
+		outb(command, SMB_CMD);
 		if (read_write = I2C_SMBUS_WRITE) {
-			outb_p(data->word & 0xff, SMBHSTDAT0);
-			outb_p((data->word & 0xff00) >> 8, SMBHSTDAT1);
+			outb(data->word & 0xff, SMB_DATA0);
+			outb((data->word & 0xff00) >> 8, SMB_DATA1);
 		}
 		break;
 	case I2C_SMBUS_BLOCK_DATA:
-		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
-		       SMBHSTADD);
-		size = ALI1535_BLOCK_DATA;
-                outb_p(size, SMBHSTTYP);	/* output command */
-		outb_p(command, SMBHSTCMD);
+		//printk("i2c-ali1535: access: I2C_SMBUS_BLOCK_DATA\n");
+		outb(((addr & 0x7f) << 1) | (read_write & 0x01), SMB_ADD);
+		size = SMB_TYP_BLOCK_DATA;
+		outb(size, SMB_TYPE);  /* output command */
+		outb(command, SMB_CMD);
 		if (read_write = I2C_SMBUS_WRITE) {
 			len = data->block[0];
@@ -464,104 +436,111 @@
 				data->block[0] = len;
 			}
-			outb_p(len, SMBHSTDAT0);
-			outb_p(inb_p(SMBHSTTYP) | ALI1535_BLOCK_CLR, SMBHSTTYP);	/* Reset SMBBLKDAT */
+			outb(len, SMB_DATA0);
+			//outb(inb(SMB_TYPE) | SMB_BLOCK_CLR, SMB_TYPE);  /* Reset SMB_BLKDAT */
+			outb(0x04, SMB_STATUS);  /* Reset SMB_BLKDAT */
 			for (i = 1; i <= len; i++)
-				outb_p(data->block[i], SMBBLKDAT);
+				outb(data->block[i], SMB_BLKDAT);
 		}
 		break;
-	default:
-		printk
-		    (KERN_WARNING "i2c-ali1535.o: Unsupported transaction %d\n", size);
-		result = -1;
-		goto EXIT;
-	}
+	} /* end switch */
 
-	if (ali1535_transaction())	/* Error in transaction */
-	  {
+#ifdef ALI_DEBUG
+	printk("i2c-ali1535: Access (pre-trans): STS=%02x, TYP=%02x, PORT=%02x,"
+		" ADD=%02x, DAT0=%02x, DAT1=%02x, CMD=%02x\n", 
+		inb(SMB_STATUS), inb(SMB_TYPE), inb(SMB_SPORT), inb(SMB_ADD),
+		inb(SMB_DATA0), inb(SMB_DATA1), inb(SMB_CMD));
+#endif
+
+	if (ali1535_transaction() < 0) {  /* Error in transaction */
+		ali1535_reset();
 		result = -1;
 		goto EXIT;
-          }
+	}
 
-	if ((read_write = I2C_SMBUS_WRITE) || (size = ALI1535_QUICK))
-	  {
+	if ((read_write = I2C_SMBUS_WRITE) || (size = SMB_TYP_QUICK)) {
 		result = 0;
 		goto EXIT;
-          }
+	}
+
+#ifdef ALI_DEBUG
+	printk("i2c-ali1535: Access (pre read): STS=%02x, TYP=%02x, PORT=%02x,"
+		" ADD=%02x, DAT0=%02x, DAT1=%02x, CMD=%02x\n", 
+		inb(SMB_STATUS), inb(SMB_TYPE), inb(SMB_SPORT), inb(SMB_ADD),
+		inb(SMB_DATA0), inb(SMB_DATA1), inb(SMB_CMD));
+#endif
 
 	switch (size) {
-	case ALI1535_BYTE:	/* Result put in SMBHSTDAT0 */
-		data->byte = inb_p(SMBHSTDAT0);
+	case SMB_TYP_BYTE:  /* Result put in SMB_DATA0 */
+		data->byte = inb(SMB_DATA0);
 		break;
-	case ALI1535_BYTE_DATA:
-		data->byte = inb_p(SMBHSTDAT0);
+	case SMB_TYP_BYTE_DATA:
+		data->byte = inb(SMB_DATA0);
 		break;
-	case ALI1535_WORD_DATA:
-		data->word = inb_p(SMBHSTDAT0) + (inb_p(SMBHSTDAT1) << 8);
+	case SMB_TYP_WORD_DATA:
+		data->word = inb(SMB_DATA0) | (inb(SMB_DATA1) << 8);
 		break;
-	case ALI1535_BLOCK_DATA:
-		len = inb_p(SMBHSTDAT0);
+	case SMB_TYP_BLOCK_DATA:
+		len = inb(SMB_DATA0);
 		if (len > 32)
 			len = 32;
 		data->block[0] = len;
-		outb_p(inb_p(SMBHSTTYP) | ALI1535_BLOCK_CLR, SMBHSTTYP);	/* Reset SMBBLKDAT */
-		for (i = 1; i <= data->block[0]; i++) {
-			data->block[i] = inb_p(SMBBLKDAT);
-#ifdef DEBUG
-			printk
-			    ("i2c-ali1535.o: Blk: len=%d, i=%d, data=%02x\n",
-			     len, i, data->block[i]);
-#endif	/* DEBUG */
-		}
+		outb(0x04, SMB_STATUS);  /* Reset SMB_BLKDAT */
+		for (i = 1; i <= data->block[0]; i++) 
+			data->block[i] = inb(SMB_BLKDAT);
 		break;
-	}
+	} /* end switch */
+#ifdef ALI_DEBUG
+	printk("i2c-ali1535: Access (post read): STS=%02x, TYP=%02x, PORT=%02x,"
+		" ADD=%02x, DAT0=%02x, DAT1=%02x, CMD=%02x\n", 
+		inb(SMB_STATUS), inb(SMB_TYPE), inb(SMB_SPORT), inb(SMB_ADD),
+		inb(SMB_DATA0), inb(SMB_DATA1), inb(SMB_CMD));
+#endif
+
 EXIT:
+	if(SMB_TYP_BLOCK_DATA = size ||
+           I2C_SMBUS_BLOCK_DATA = size)
+		outb(0x04, SMB_STATUS);  /* Reset SMB_BLKDAT */
 	up(&i2c_ali1535_sem);
 	return result;
 }
 
-
 u32 ali1535_func(struct i2c_adapter *adapter)
 {
 	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
-	    I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
-	    I2C_FUNC_SMBUS_BLOCK_DATA;
+		I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
+		I2C_FUNC_SMBUS_BLOCK_DATA;
 }
 
+/*
+ * I2C Structures
+ */
 static struct i2c_algorithm smbus_algorithm = {
-	.name		= "Non-i2c SMBus adapter",
-	.id		= I2C_ALGO_SMBUS,
-	.smbus_xfer	= ali1535_access,
-	.functionality	= ali1535_func,
+        .name           = "Non-i2c SMBus adapter",
+        .id             = I2C_ALGO_SMBUS,
+        .smbus_xfer     = ali1535_access,
+        .functionality  = ali1535_func,
 };
 
 static struct i2c_adapter ali1535_adapter = {
-	.owner		= THIS_MODULE,
-	.name		= "unset",
-	.id		= I2C_ALGO_SMBUS | I2C_HW_SMBUS_ALI1535,
-	.algo		= &smbus_algorithm,
-};
-
-
-static struct pci_device_id ali1535_ids[] __devinitdata = {
-	{
-	.vendor =	PCI_VENDOR_ID_AL,
-	.device =	PCI_DEVICE_ID_AL_M7101,
-	.subvendor =	PCI_ANY_ID,
-	.subdevice =	PCI_ANY_ID,
-	},
-	{ 0, }
+        .owner          = THIS_MODULE,
+        .name           = "unset",
+        .id             = I2C_ALGO_SMBUS | I2C_HW_SMBUS_ALI1535,
+        .algo           = &smbus_algorithm,
 };
 
+/*
+ * PCI Structures
+ */
 static int __devinit ali1535_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	if (ali1535_setup(dev)) {
-		printk
-		    ("i2c-ali1535.o: ALI1535 not detected, module not inserted.\n");
-		return -ENODEV;
-	}
-
-	sprintf(ali1535_adapter.name, "SMBus ALI1535 adapter at %04x",
-		ali1535_smba);
-	return i2c_add_adapter(&ali1535_adapter);
+        if (ali1535_setup(dev)) {
+                printk
+		    ("i2c-ali1535: ALi7101 not detected, module not inserted.\n");
+                return -ENODEV;
+        }
+
+        sprintf(ali1535_adapter.name, "ALi7101 SMBus adapter at 0x%04x",
+                ali1535_smba);
+        return i2c_add_adapter(&ali1535_adapter);
 }
 
@@ -571,7 +550,16 @@
 }
 
+static struct pci_device_id ali1535_ids[] __devinitdata = {
+	{
+	.vendor = PCI_VENDOR_ID_AL,
+	.device = PCI_DEVICE_ID_AL_M7101,
+	.subvendor = PCI_ANY_ID,
+	.subdevice = PCI_ANY_ID,
+	},
+	{ 0, }
+};
 
 static struct pci_driver ali1535_driver = {
-	.name		= "ali1535 smbus",
+	.name		= "ALi7101 SMBus",
 	.id_table	= ali1535_ids,
 	.probe		= ali1535_probe,
@@ -581,13 +569,12 @@
 static int __init i2c_ali1535_init(void)
 {
-	printk("i2c-ali1535.o version %s (%s)\n", LM_VERSION, LM_DATE);
+	printk("i2c-ali1535: version %s (%s)\n", LM_VERSION, LM_DATE);
 	return pci_module_init(&ali1535_driver);
 }
 
-
-static void __exit i2c_ali1535_exit(void)
+void __exit i2c_ali1535_exit(void)
 {
 	pci_unregister_driver(&ali1535_driver);
-	release_region(ali1535_smba, ALI1535_SMB_IOSIZE);
+	release_region(ali1535_smba, SMB_SMB_IOSIZE);
 }
 
@@ -598,11 +585,14 @@
 #endif
 
-MODULE_AUTHOR
-    ("Frodo Looijaard <frodol@dds.nl>, Philip Edelbrock <phil@netroedge.com>, "
-     "Mark D. Studebaker <mdsxyz123@yahoo.com> and Dan Eaton <dan.eaton@rocketlogix.com>");
-MODULE_DESCRIPTION("ALI1535 SMBus driver");
+MODULE_DEVICE_TABLE(pci, ali1535_ids);
+MODULE_AUTHOR("Matt Mercer <fee@users.sourceforge.net>, "
+		"Frodo Looijaard <frodol@dds.nl>, "
+		"Philip Edelbrock <phil@netroedge.com>, "
+		"Mark D. Studebaker <mdsxyz123@yahoo.com>, "
+		"Dan Eaton <dan.eaton@rocketlogix.com>, "
+		"Stephen Rousset<stephen.rousset@rocketlogix.com>");
+MODULE_DESCRIPTION("ALI1535/M7101 SMBus driver");
 MODULE_LICENSE("GPL");
 
 module_init(i2c_ali1535_init);
 module_exit(i2c_ali1535_exit);
-
