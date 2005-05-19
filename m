From: R.Marek@sh.cvut.cz (R.Marek@sh.cvut.cz)
Date: Thu, 19 May 2005 06:25:50 +0000
Subject: [PATCH] ALI1563 SMBus driver fix
Message-Id: <20050411081712.17417.qmail@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

Following patch contains fixies to "grave" errors of ALI1563 SMBus driver.
It removes checking for HST_STS_DONE bit, because this bit is raised
only after finishing for block transfers in newer chips revisions. 
Then it fixes missing "and" mask for transfer type settings. And to third it fixes
the "continous byte mode" transaction, because command is not transfered
in command register but in DAT0 register. Last thing it changes is error
recovery and error messages. All was successfully tested with help
of Chunhao Huang from Winbond.

I added my name to source because now I feel quite familiar with the chip. :)

Please apply.

Thanks

Regards

Rudolf

diff -Naur a/drivers/i2c/busses/i2c-ali1563.c c/drivers/i2c/busses/i2c-ali1563.c
--- a/drivers/i2c/busses/i2c-ali1563.c	2005-03-09 09:13:19.000000000 +0100
+++ c/drivers/i2c/busses/i2c-ali1563.c	2005-04-08 21:55:19.000000000 +0200
@@ -1,4 +1,4 @@
-/**
+/*
  *	i2c-ali1563.c - i2c driver for the ALi 1563 Southbridge
  *
  *	Copyright (C) 2004 Patrick Mochel
@@ -13,6 +13,9 @@
  *	with a little help from the ALi 1563 spec.
  *
  *	This file is released under the GPLv2
+ *
+ *	2005-04-08: Fixed SMBus mode setting, fixed byte data transactions 	 
+ *			Rudolf Marek <r.marek@sh.cvut.cz>
  */
 
 #include <linux/module.h>
@@ -55,8 +58,7 @@
 #define HST_CNTL2_BYTE_DATA	0x02
 #define HST_CNTL2_WORD_DATA	0x03
 #define HST_CNTL2_BLOCK		0x05
-
-
+#define HST_CNTL2_SIZEMASK	0x38
 
 static unsigned short ali1563_smba;
 
@@ -73,7 +75,7 @@
 
 	data = inb_p(SMB_HST_STS);
 	if (data & HST_STS_BAD) {
-		dev_warn(&a->dev,"ali1563: Trying to reset busy device\n");
+		dev_err(&a->dev,"ali1563: Trying to reset busy device\n");
 		outb_p(data | HST_STS_BAD,SMB_HST_STS);
 		data = inb_p(SMB_HST_STS);
 		if (data & HST_STS_BAD)
@@ -94,19 +96,31 @@
 
 	if (timeout && !(data & HST_STS_BAD))
 		return 0;
-	dev_warn(&a->dev, "SMBus Error: %s%s%s%s%s\n",
-		timeout ? "Timeout " : "",
-		data & HST_STS_FAIL ? "Transaction Failed " : "",
-		data & HST_STS_BUSERR ? "No response or Bus Collision " : "",
-		data & HST_STS_DEVERR ? "Device Error " : "",
-		!(data & HST_STS_DONE) ? "Transaction Never Finished " : "");
 
-	if (!(data & HST_STS_DONE))
+	if (!timeout) {
+		dev_err(&a->dev, "Timeout - Trying to KILL transaction!\n");
 		/* Issue 'kill' to host controller */
 		outb_p(HST_CNTL2_KILL,SMB_HST_CNTL2);
-	else
-		/* Issue timeout to reset all devices on bus */
+		data = inb_p(SMB_HST_STS);		
+ 	}
+	
+	/* device error - probably missing ACK, from autdetection I2C_QUICK */	
+	if (data & HST_STS_DEVERR) {
+		dev_dbg(&a->dev, "Device error!\n");
+	}
+
+	/* bus collision */
+	if (data & HST_STS_BUSERR) {
+		dev_err(&a->dev, "Bus collision!\n");
+		/* Issue timeout, hoping it helps */
 		outb_p(HST_CNTL1_TIMEOUT,SMB_HST_CNTL1);
+	}
+
+	if (data & HST_STS_FAIL) {
+		dev_err(&a->dev, "Cleaning fail after KILL!\n");
+		outb_p(0x0,SMB_HST_CNTL2);
+	}
+
 	return -1;
 }
 
@@ -149,7 +163,7 @@
 
 	if (timeout && !(data & HST_STS_BAD))
 		return 0;
-	dev_warn(&a->dev, "SMBus Error: %s%s%s%s%s\n",
+	dev_err(&a->dev, "SMBus Error: %s%s%s%s%s\n",
 		timeout ? "Timeout " : "",
 		data & HST_STS_FAIL ? "Transaction Failed " : "",
 		data & HST_STS_BUSERR ? "No response or Bus Collision " : "",
@@ -242,13 +256,15 @@
 	}
 
 	outb_p(((addr & 0x7f) << 1) | (rw & 0x01), SMB_HST_ADD);
-	outb_p(inb_p(SMB_HST_CNTL2) | (size << 3), SMB_HST_CNTL2);
+	outb_p((inb_p(SMB_HST_CNTL2) & ~HST_CNTL2_SIZEMASK) | (size << 3), SMB_HST_CNTL2);
 
 	/* Write the command register */
+
 	switch(size) {
 	case HST_CNTL2_BYTE:
 		if (rw= I2C_SMBUS_WRITE)
-			outb_p(cmd, SMB_HST_CMD);
+			/* Beware it uses DAT0 register and not CMD !!! */
+			outb_p(cmd, SMB_HST_DAT0);
 		break;
 	case HST_CNTL2_BYTE_DATA:
 		outb_p(cmd, SMB_HST_CMD);
