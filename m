From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:44 +0000
Subject: [PATCH 2.6] I2C: Avoid repeated resets of i2c-viapro
Message-Id: <20050320115744.2ac878d4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

It was reported that the i2c-viapro SMBus driver sometimes has trouble
on recent systems (VT8237 south bridge). The "Host Status" register has
at least one additional bit used when compared with older south bridges
of this family. The driver currently considers this additional bit as an
error condition when it's set, causing repeated bus resets and sometimes
read failures.

This patch makes the driver ignore the bits of the "Host Status"
register for which no definition is known. I wish I had a datasheet for
the VIA VT8237, so that I could check what the additional bit is
supposed to mean, but I don't. If someone has a datasheet or good
contacts at VIA, please let me know.

The patch was reported to fix the problem on a system with the VT8237,
and was also tested not to break the driver on older VIA south bridges,
so it seems to be safe. Thanks to Aurelien Jarno for the tests.

Additionally, the patch makes the post-transaction bus reset slightly
more efficient by sparing a few unneeded I/O operations.

Please apply,
thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>


--- linux-2.6.11-mm3/drivers/i2c/busses/i2c-viapro.c.orig	2005-03-13 19:56:45.000000000 +0100
+++ linux-2.6.11-mm3/drivers/i2c/busses/i2c-viapro.c	2005-03-13 20:05:46.000000000 +0100
@@ -121,12 +121,12 @@
 		inb_p(SMBHSTDAT1));
 
 	/* Make sure the SMBus host is ready to start transmitting */
-	if ((temp = inb_p(SMBHSTSTS)) != 0x00) {
+	if ((temp = inb_p(SMBHSTSTS)) & 0x1F) {
 		dev_dbg(&vt596_adapter.dev, "SMBus busy (0x%02x). "
 				"Resetting...\n", temp);
 		
 		outb_p(temp, SMBHSTSTS);
-		if ((temp = inb_p(SMBHSTSTS)) != 0x00) {
+		if ((temp = inb_p(SMBHSTSTS)) & 0x1F) {
 			dev_dbg(&vt596_adapter.dev, "Failed! (0x%02x)\n", temp);
 			
 			return -1;
@@ -168,13 +168,14 @@
 		dev_dbg(&vt596_adapter.dev, "Error: no response!\n");
 	}
 
-	if (inb_p(SMBHSTSTS) != 0x00)
-		outb_p(inb(SMBHSTSTS), SMBHSTSTS);
-
-	if ((temp = inb_p(SMBHSTSTS)) != 0x00) {
-		dev_dbg(&vt596_adapter.dev, "Failed reset at end of "
-			"transaction (%02x)\n", temp);
+	if ((temp = inb_p(SMBHSTSTS)) & 0x1F) {
+		outb_p(temp, SMBHSTSTS);
+		if ((temp = inb_p(SMBHSTSTS)) & 0x1F) {
+			dev_warn(&vt596_adapter.dev, "Failed reset at end "
+				 "of transaction (%02x)\n", temp);
+		}
 	}
+
 	dev_dbg(&vt596_adapter.dev, "Transaction (post): CNT=%02x, CMD=%02x, "
 		"ADD=%02x, DAT0=%02x, DAT1=%02x\n", inb_p(SMBHSTCNT),
 		inb_p(SMBHSTCMD), inb_p(SMBHSTADD), inb_p(SMBHSTDAT0), 

-- 
Jean Delvare
