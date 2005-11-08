From: gregkh@suse.de (Greg KH)
Date: Tue, 08 Nov 2005 06:53:19 +0000
Subject: [lm-sensors] [PATCH] i2c-viapro: Some adjustments
Message-Id: <11314291491579@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c-viapro: Some adjustments

The big i2c-viapro SMBus driver update which went into 2.6.14-git1
introduced a few minor issues. Nothing critical, but I would like a
few adjustments to be merged in to fix the following problems:

* VIA should not be spelled Via.
* Frodo Looijaard and Philip Edelbrock did not write the i2c-viapro
  driver.
* When debugging is disabled, half of messages would be logged.
* Drop an unneeded masking.
* Some port reads can be avoided now that the transaction size is
  passed as a parameter to vt596_transaction().
* SMBus Receive Byte transactions are used for probing too (for
  EEPROMs), so hide errors on these too.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 8750197f0e8f5467297d72e11444cf32f29d790f
tree 9fdac6bbc7934e2fb5ff609f9c202950d245f68b
parent 4a1c4447e523003019a2bf9b972ed6fe411e84d2
author Jean Delvare <khali@linux-fr.org> Mon, 31 Oct 2005 18:51:21 +0100
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 07 Nov 2005 21:46:38 -0800

 Documentation/i2c/busses/i2c-viapro |    6 ++----
 drivers/i2c/busses/i2c-viapro.c     |   27 ++++++++++++++-------------
 2 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/Documentation/i2c/busses/i2c-viapro b/Documentation/i2c/busses/i2c-viapro
index 9363b8b..1677566 100644
--- a/Documentation/i2c/busses/i2c-viapro
+++ b/Documentation/i2c/busses/i2c-viapro
@@ -7,12 +7,10 @@ Supported adapters:
   * VIA Technologies, Inc. VT82C686A/B
     Datasheet: Sometimes available at the VIA website
 
-  * VIA Technologies, Inc. VT8231, VT8233, VT8233A, VT8235, VT8237
-    Datasheet: available on request from Via
+  * VIA Technologies, Inc. VT8231, VT8233, VT8233A, VT8235, VT8237R
+    Datasheet: available on request from VIA
 
 Authors:
-	Frodo Looijaard <frodol@dds.nl>,
-	Philip Edelbrock <phil@netroedge.com>,
 	Ky?sti M?lkki <kmalkki@cc.hut.fi>,
 	Mark D. Studebaker <mdsxyz123@yahoo.com>,
 	Jean Delvare <khali@linux-fr.org>
diff --git a/drivers/i2c/busses/i2c-viapro.c b/drivers/i2c/busses/i2c-viapro.c
index c9366b5..a2237d4 100644
--- a/drivers/i2c/busses/i2c-viapro.c
+++ b/drivers/i2c/busses/i2c-viapro.c
@@ -142,19 +142,18 @@ static int vt596_transaction(u8 size)
 	/* Make sure the SMBus host is ready to start transmitting */
 	if ((temp = inb_p(SMBHSTSTS)) & 0x1F) {
 		dev_dbg(&vt596_adapter.dev, "SMBus busy (0x%02x). "
-			"Resetting... ", temp);
+			"Resetting...\n", temp);
 
 		outb_p(temp, SMBHSTSTS);
 		if ((temp = inb_p(SMBHSTSTS)) & 0x1F) {
-			printk("Failed! (0x%02x)\n", temp);
+			dev_err(&vt596_adapter.dev, "SMBus reset failed! "
+				"(0x%02x)\n", temp);
 			return -1;
-		} else {
-			printk("Successful!\n");
 		}
 	}
 
 	/* Start the transaction by setting bit 6 */
-	outb_p(0x40 | (size & 0x3C), SMBHSTCNT);
+	outb_p(0x40 | size, SMBHSTCNT);
 
 	/* We will always wait for a fraction of a second */
 	do {
@@ -171,7 +170,7 @@ static int vt596_transaction(u8 size)
 	if (temp & 0x10) {
 		result = -1;
 		dev_err(&vt596_adapter.dev, "Transaction failed (0x%02x)\n",
-			inb_p(SMBHSTCNT) & 0x3C);
+			size);
 	}
 
 	if (temp & 0x08) {
@@ -180,11 +179,13 @@ static int vt596_transaction(u8 size)
 	}
 
 	if (temp & 0x04) {
+		int read = inb_p(SMBHSTADD) & 0x01;
 		result = -1;
-		/* Quick commands are used to probe for chips, so
-		   errors are expected, and we don't want to frighten the
-		   user. */
-		if ((inb_p(SMBHSTCNT) & 0x3C) != VT596_QUICK)
+		/* The quick and receive byte commands are used to probe
+		   for chips, so errors are expected, and we don't want
+		   to frighten the user. */
+		if (!((size = VT596_QUICK && !read) ||
+		      (size = VT596_BYTE && read)))
 			dev_err(&vt596_adapter.dev, "Transaction error!\n");
 	}
 
@@ -462,9 +463,9 @@ static void __exit i2c_vt596_exit(void)
 	}
 }
 
-MODULE_AUTHOR(
-    "Frodo Looijaard <frodol@dds.nl> and "
-    "Philip Edelbrock <phil@netroedge.com>");
+MODULE_AUTHOR("Kyosti Malkki <kmalkki@cc.hut.fi>, "
+	      "Mark D. Studebaker <mdsxyz123@yahoo.com> and "
+	      "Jean Delvare <khali@linux-fr.org>");
 MODULE_DESCRIPTION("vt82c596 SMBus driver");
 MODULE_LICENSE("GPL");
 

