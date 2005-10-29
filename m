From: gregkh@suse.de (Greg KH)
Date: Sat, 29 Oct 2005 01:25:20 +0000
Subject: [lm-sensors] [PATCH] i2c-viapro: Improve register dump
Message-Id: <11305336591931@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c-viapro: Improve register dump

Improve the register dump used to debug the i2c-viapro driver. The
original dump was missing the HSTSTS register and the block data
buffer.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

 drivers/i2c/busses/i2c-viapro.c |   38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

---
commit ed5453e54f0c4a29605fd8399f58649d8739f5f0
tree 935b4cb15b7baefb836cc80b45c814be51a8ce8c
parent 50c1cc339ca72f7cb95d440d384346f4238dc494
author Jean Delvare <khali@linux-fr.org> Thu, 22 Sep 2005 22:23:32 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 28 Oct 2005 14:02:08 -0700

 drivers/i2c/busses/i2c-viapro.c |   38 ++++++++++++++++++++++++++++++--------
 1 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-viapro.c b/drivers/i2c/busses/i2c-viapro.c
index a89a212..c1c9eb1 100644
--- a/drivers/i2c/busses/i2c-viapro.c
+++ b/drivers/i2c/busses/i2c-viapro.c
@@ -104,6 +104,30 @@ static struct i2c_adapter vt596_adapter;
 #define FEATURE_I2CBLOCK	(1<<0)
 static unsigned int vt596_features;
 
+#ifdef DEBUG
+static void vt596_dump_regs(const char *msg, u8 size)
+{
+	dev_dbg(&vt596_adapter.dev, "%s: STS=%02x CNT=%02x CMD=%02x ADD=%02x "
+		"DAT=%02x,%02x\n", msg, inb_p(SMBHSTSTS), inb_p(SMBHSTCNT),
+		inb_p(SMBHSTCMD), inb_p(SMBHSTADD), inb_p(SMBHSTDAT0),
+		inb_p(SMBHSTDAT1));
+
+	if (size = VT596_BLOCK_DATA
+	 || size = VT596_I2C_BLOCK_DATA) {
+		int i;
+
+		dev_dbg(&vt596_adapter.dev, "BLK=");
+		for (i = 0; i < I2C_SMBUS_BLOCK_MAX / 2; i++)
+			printk("%02x,", inb_p(SMBBLKDAT));
+		printk("\n");
+		dev_dbg(&vt596_adapter.dev, "    ");
+		for (; i < I2C_SMBUS_BLOCK_MAX - 1; i++)
+			printk("%02x,", inb_p(SMBBLKDAT));
+		printk("%02x\n", inb_p(SMBBLKDAT));
+	}
+}
+#endif
+
 /* Return -1 on error, 0 on success */
 static int vt596_transaction(u8 size)
 {
@@ -111,10 +135,9 @@ static int vt596_transaction(u8 size)
 	int result = 0;
 	int timeout = 0;
 
-	dev_dbg(&vt596_adapter.dev, "Transaction (pre): CNT=%02x, CMD=%02x, "
-		"ADD=%02x, DAT0=%02x, DAT1=%02x\n", inb_p(SMBHSTCNT),
-		inb_p(SMBHSTCMD), inb_p(SMBHSTADD), inb_p(SMBHSTDAT0),
-		inb_p(SMBHSTDAT1));
+#ifdef DEBUG
+	vt596_dump_regs("Transaction (pre)", size);
+#endif
 
 	/* Make sure the SMBus host is ready to start transmitting */
 	if ((temp = inb_p(SMBHSTSTS)) & 0x1F) {
@@ -169,10 +192,9 @@ static int vt596_transaction(u8 size)
 	if (temp & 0x1F)
 		outb_p(temp, SMBHSTSTS);
 
-	dev_dbg(&vt596_adapter.dev, "Transaction (post): CNT=%02x, CMD=%02x, "
-		"ADD=%02x, DAT0=%02x, DAT1=%02x\n", inb_p(SMBHSTCNT),
-		inb_p(SMBHSTCMD), inb_p(SMBHSTADD), inb_p(SMBHSTDAT0),
-		inb_p(SMBHSTDAT1));
+#ifdef DEBUG
+	vt596_dump_regs("Transaction (post)", size);
+#endif
 
 	return result;
 }

