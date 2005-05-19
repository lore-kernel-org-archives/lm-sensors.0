From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:33 +0000
Subject: Problem with eeprom module in 2.9.0
Message-Id: <20050126061842.GA4434@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <41DDAE4F.9030606@earthlink.net>
In-Reply-To: <41DDAE4F.9030606@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi again:

> * Mark D. Studebaker <mds4@verizon.net> [2005-01-22 11:54:37 -0500]:
> > good diagnosis khali.
> > the 6300ESB definitely supports i2c block so there must be a bug in there 
> > somewhere.
> > I just reviewed the code and didn't see anything obvious.
> > David can you recompile i2c-i801 with the DEBUG=1 uncommented and
> > send us the dmesg output?

* Mark M. Hoffman <mhoffman@lightlink.com> [2005-01-25 00:01:45 -0500]:
> I may have found it.  There is a note on page 240 of the ICH5 datasheet
> that says:
> 
> 	For I2C Read command, the value written into bit 0 of the
> 	Transmit Slave Address Register (SMB I/O register, offset
> 	04h) needs to be 0.
> 
> We're writing a 1 (as would be expected: it's a read after all).  I'll
> test this hypothesis tomorrow evening... right now I need sleep.

Before I made the change above, my 'scope wasn't even triggering when
I tried to do an I2C block read.  After making that change, at least I
had something to look at...

Next, I found that the "command" field for I2C block read must be
written into SMBHSTDAT1 instead of SMBHSTCMD.  After making that change,
the picture on the 'scope is correct, but...

The driver still complains "bus timeout".  Now, I guess that the host
block data byte register is in "block buffer" mode for the I2C block read
command, regardless of the value of E32B.  That's the only thing I can
think of that explains why it never gets a "byte done status" in the
host status reg.  As it stands, the block transfer loop looks for "byte
done" but ignores "intr", and again that would explain what I'm seeing
on the 'scope and in the kernel logs.

Here's my patch so far.  There's some noise because I tried to make a
better xfer-killer (though it didn't seem to help any).  The important
changes are in the last chunk.  I probably won't get to play with this
again before the weekend.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

Index: kernel/busses/i2c-i801.c
=================================RCS file: /home/cvs/lm_sensors2/kernel/busses/i2c-i801.c,v
retrieving revision 1.44
diff -u -r1.44 i2c-i801.c
--- kernel/busses/i2c-i801.c	22 Jan 2005 11:02:40 -0000	1.44
+++ kernel/busses/i2c-i801.c	26 Jan 2005 06:26:15 -0000
@@ -41,7 +41,7 @@
 
 /* Note: we assume there can only be one I801, with one SMBus interface */
 
-/* #define DEBUG 1 */
+#define DEBUG 1
 
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -217,6 +217,37 @@
 	return error_return;
 }
 
+/* This function kills any transaction in progress
+ * status is the most recently read SMBHSTSTS - useful for debug
+ * messages but doesn't affect the outcome of this function
+ * returns 0 if the abort was successful, -1 otherwise */
+static int i801_abort(int status)
+{
+	int timeout = 0;
+
+	dev_dbg(I801_dev, "SMBus busy (%02x). Resetting... \n", status);
+
+	/* set kill bit */
+	outb_p(0x02, SMBHSTCNT);
+
+	/* wait for fail status */
+	do {
+		i2c_delay(1);
+		status = inb_p(SMBHSTSTS);
+	} while (((status & 0x10) = 0) && (timeout++ < MAX_TIMEOUT));
+
+	if (timeout >= MAX_TIMEOUT) {
+		dev_dbg(I801_dev, "Host bus timeout while attempting to "
+			"abort!  You might need to power-cycle the whole "
+			"machine to fix this.\n");
+		return -1;
+	}
+
+	/* clear control and status regs */
+	outb_p(0x00, SMBHSTCNT);
+	outb_p(0xbe, SMBHSTSTS);
+	return 0;
+}
 
 static int i801_transaction(void)
 {
@@ -224,24 +255,16 @@
 	int result = 0;
 	int timeout = 0;
 
-	dev_dbg(I801_dev, "Transaction (pre): CNT=%02x, CMD=%02x,"
+	dev_dbg(I801_dev, "Transaction (pre): CNT=%02x, CMD=%02x, "
 		"ADD=%02x, DAT0=%02x, DAT1=%02x\n", inb_p(SMBHSTCNT),
 		inb_p(SMBHSTCMD), inb_p(SMBHSTADD), inb_p(SMBHSTDAT0),
 		inb_p(SMBHSTDAT1));
 
 	/* Make sure the SMBus host is ready to start transmitting */
 	/* 0x1f = Failed, Bus_Err, Dev_Err, Intr, Host_Busy */
-	if ((temp = (0x1f & inb_p(SMBHSTSTS))) != 0x00) {
-		dev_dbg(I801_dev, "SMBus busy (%02x). Resetting... \n",
-			temp);
-		outb_p(temp, SMBHSTSTS);
-		if ((temp = (0x1f & inb_p(SMBHSTSTS))) != 0x00) {
-			dev_dbg(I801_dev, "Failed! (%02x)\n", temp);
+	if ((temp = (0x1f & inb_p(SMBHSTSTS))) != 0x00)
+		if (i801_abort(temp) = -1)
 			return -1;
-		} else {
-			dev_dbg(I801_dev, "Successfull!\n");
-		}
-	}
 
 	outb_p(inb(SMBHSTCNT) | I801_START, SMBHSTCNT);
 
@@ -355,15 +378,11 @@
 			errmask=0x1e; 
 		}
 		if (temp & errmask) {
-			dev_dbg(I801_dev, "SMBus busy (%02x). "
-				"Resetting... \n", temp);
-			outb_p(temp, SMBHSTSTS);
-			if (((temp = inb_p(SMBHSTSTS)) & errmask) != 0x00) {
-				dev_err(I801_dev,
-					"Reset failed! (%02x)\n", temp);
+			if (i801_abort(temp) = -1) {
 				result = -1;
-                                goto END;
+				goto END;
 			}
+
 			if (i != 1) {
 				/* if die in middle of block transaction, fail */
 				result = -1;
@@ -515,9 +534,25 @@
 		if(hwpec && size = I2C_SMBUS_BLOCK_DATA)
 			size = I2C_SMBUS_BLOCK_DATA_PEC;
 #endif
-		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
-		       SMBHSTADD);
-		outb_p(command, SMBHSTCMD);
+		if (size = I2C_SMBUS_I2C_BLOCK_DATA) {
+			/* NB: page 240 of ICH5 datasheet shows that the R/#W
+			 * bit should be cleared here, even when reading */
+			outb_p( ((addr & 0x7f) << 1), SMBHSTADD);
+
+			if (read_write)
+				/* NB: page 240 of ICH5 datasheet also shows
+				 * that DATA1 is the cmd field when reading */
+				outb_p(command, SMBHSTDAT1);
+			else
+				outb_p(command, SMBHSTCMD);
+				
+		} else {
+			outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
+				SMBHSTADD);
+
+			outb_p(command, SMBHSTCMD);
+		}
+
 		block = 1;
 		break;
 	case I2C_SMBUS_PROC_CALL:
