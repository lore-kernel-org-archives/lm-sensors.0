From: R.Marek@sh.cvut.cz (R.Marek@sh.cvut.cz)
Date: Thu, 19 May 2005 06:25:53 +0000
Subject: [PATCH] ALI1563 SMBus driver fix - take 2
Message-Id: <20050421090756.13436.qmail@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

This patch fixes "grave" bugs in i2c-ali1563 driver. It seems on recent
chipset revisions the HSTS_DONE is set only for block transfers, so we
must detect the end of ordinary transaction other way. Also due to missing
and mask, setting other transfer modes was not possible. Moreover the 
continous byte mode transfer uses DAT0 for command rather than CMD command.
All those changes were tested with help of Chunhao Huang from Winbond.

I'm willing to maintain the driver. Second patch adds me as maintainer
if this is neccessary.

Signed-Off-By: Rudolf Marek <r.marek@sh.cvut.cz>

Regards

Rudolf

diff -Naur a/drivers/i2c/busses/i2c-ali1563.c b/drivers/i2c/busses/i2c-ali1563.c
--- a/drivers/i2c/busses/i2c-ali1563.c	2005-04-04 18:40:16.000000000 +0200
+++ b/drivers/i2c/busses/i2c-ali1563.c	2005-04-21 00:37:06.052205792 +0200
@@ -2,6 +2,7 @@
  *	i2c-ali1563.c - i2c driver for the ALi 1563 Southbridge
  *
  *	Copyright (C) 2004 Patrick Mochel
+ *		      2005 Rudolf Marek <r.marek@sh.cvut.cz>
  *
  *	The 1563 southbridge is deceptively similar to the 1533, with a
  *	few notable exceptions. One of those happens to be the fact they
@@ -57,10 +58,11 @@
 #define HST_CNTL2_BLOCK		0x05
 
 
+#define HST_CNTL2_SIZEMASK	0x38
 
 static unsigned short ali1563_smba;
 
-static int ali1563_transaction(struct i2c_adapter * a)
+static int ali1563_transaction(struct i2c_adapter * a, int size)
 {
 	u32 data;
 	int timeout;
@@ -73,7 +75,7 @@
 
 	data = inb_p(SMB_HST_STS);
 	if (data & HST_STS_BAD) {
-		dev_warn(&a->dev,"ali1563: Trying to reset busy device\n");
+		dev_err(&a->dev, "ali1563: Trying to reset busy device\n");
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
+	/* device error - no response, ignore the autodetection case */	
+	if ((data & HST_STS_DEVERR) && (size != HST_CNTL2_QUICK)) {
+		dev_err(&a->dev, "Device error!\n");
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
+			/* Beware it uses DAT0 register and not CMD! */
+			outb_p(cmd, SMB_HST_DAT0);
 		break;
 	case HST_CNTL2_BYTE_DATA:
 		outb_p(cmd, SMB_HST_CMD);
@@ -268,7 +284,7 @@
 		goto Done;
 	}
 
-	if ((error = ali1563_transaction(a)))
+	if ((error = ali1563_transaction(a, size)))
 		goto Done;
 
 	if ((rw = I2C_SMBUS_WRITE) || (size = HST_CNTL2_QUICK))
diff -Naur a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS	2005-04-04 18:38:36.000000000 +0200
+++ b/MAINTAINERS	2005-04-21 10:51:28.457954008 +0200
@@ -247,6 +247,12 @@
 W:	http://www.linux-usb.org/SpeedTouch/
 S:	Maintained
 
+ALI1563 I2C DRIVER
+P:	Rudolf Marek
+M:	r.marek@sh.cvut.cz
+L:	sensors@stimpy.netroedge.com
+S:	Maintained
+
 ALPHA PORT
 P:	Richard Henderson
 M:	rth@twiddle.net
