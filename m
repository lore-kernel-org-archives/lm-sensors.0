From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 22 Sep 2005 22:15:09 +0000
Subject: [lm-sensors] [PATCH] (6/7) i2c-viapro: Refactor control outb
Message-Id: <20050922221553.1a51a3a0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg, all,

By slightly shifting the interface between vt596_access and
vt596_transaction, we can save two I/O accesses per SMBus transaction.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/i2c/busses/i2c-viapro.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- linux-2.6.13.orig/drivers/i2c/busses/i2c-viapro.c	2005-09-04 16:13:32.000000000 +0200
+++ linux-2.6.13/drivers/i2c/busses/i2c-viapro.c	2005-09-04 16:13:35.000000000 +0200
@@ -105,7 +105,7 @@
 static unsigned int vt596_features;
 
 /* Return -1 on error, 0 on success */
-static int vt596_transaction(void)
+static int vt596_transaction(u8 size)
 {
 	int temp;
 	int result = 0;
@@ -131,7 +131,7 @@
 	}
 
 	/* Start the transaction by setting bit 6 */
-	outb_p(inb(SMBHSTCNT) | 0x40, SMBHSTCNT);
+	outb_p(0x40 | (size & 0x3C), SMBHSTCNT);
 
 	/* We will always wait for a fraction of a second */
 	do {
@@ -232,9 +232,8 @@
 	}
 
 	outb_p(((addr & 0x7f) << 1) | read_write, SMBHSTADD);
-	outb_p((size & 0x3C), SMBHSTCNT);
 
-	if (vt596_transaction()) /* Error in transaction */
+	if (vt596_transaction(size)) /* Error in transaction */
 		return -1;
 
 	if ((read_write = I2C_SMBUS_WRITE) || (size = VT596_QUICK))

-- 
Jean Delvare
