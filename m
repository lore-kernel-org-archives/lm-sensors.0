From: gregkh@suse.de (Greg KH)
Date: Sat, 29 Oct 2005 01:14:42 +0000
Subject: [lm-sensors] [PATCH] i2c-viapro: Refactor control outb
Message-Id: <1130533659577@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c-viapro: Refactor control outb

By slightly shifting the interface between vt596_access and
vt596_transaction, we can save two I/O accesses per SMBus transaction.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

 drivers/i2c/busses/i2c-viapro.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

---
commit 50c1cc339ca72f7cb95d440d384346f4238dc494
tree 061a3c28705b77386f9598bee2c154d688d6d4cd
parent aaf7f1477668f34dda65aba17e87c0bc2ebe84d1
author Jean Delvare <khali@linux-fr.org> Thu, 22 Sep 2005 22:15:53 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 28 Oct 2005 14:02:08 -0700

 drivers/i2c/busses/i2c-viapro.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-viapro.c b/drivers/i2c/busses/i2c-viapro.c
index 3be476c..a89a212 100644
--- a/drivers/i2c/busses/i2c-viapro.c
+++ b/drivers/i2c/busses/i2c-viapro.c
@@ -105,7 +105,7 @@ static struct i2c_adapter vt596_adapter;
 static unsigned int vt596_features;
 
 /* Return -1 on error, 0 on success */
-static int vt596_transaction(void)
+static int vt596_transaction(u8 size)
 {
 	int temp;
 	int result = 0;
@@ -131,7 +131,7 @@ static int vt596_transaction(void)
 	}
 
 	/* Start the transaction by setting bit 6 */
-	outb_p(inb(SMBHSTCNT) | 0x40, SMBHSTCNT);
+	outb_p(0x40 | (size & 0x3C), SMBHSTCNT);
 
 	/* We will always wait for a fraction of a second */
 	do {
@@ -232,9 +232,8 @@ static s32 vt596_access(struct i2c_adapt
 	}
 
 	outb_p(((addr & 0x7f) << 1) | read_write, SMBHSTADD);
-	outb_p((size & 0x3C), SMBHSTCNT);
 
-	if (vt596_transaction()) /* Error in transaction */
+	if (vt596_transaction(size)) /* Error in transaction */
 		return -1;
 
 	if ((read_write = I2C_SMBUS_WRITE) || (size = VT596_QUICK))

