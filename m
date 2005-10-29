From: gregkh@suse.de (Greg KH)
Date: Sat, 29 Oct 2005 00:16:11 +0000
Subject: [lm-sensors] [PATCH] i2c-viapro: Cleanup ifdef usage
Message-Id: <11305336594054@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c-viapro: Cleanup ifdef usage

It's not nice to put #ifdef in the middle of functions.

CC: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

 drivers/i2c/busses/i2c-viapro.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

---
commit ca68f1193e8fc86470d4222d563d13b5584dc4f8
tree 6bfb26f76e4a0986bfed32080d6aa6cec45f1b38
parent ed5453e54f0c4a29605fd8399f58649d8739f5f0
author Greg KH <greg@kroah.com> Thu, 22 Sep 2005 22:23:32 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 28 Oct 2005 14:02:08 -0700

 drivers/i2c/busses/i2c-viapro.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-viapro.c b/drivers/i2c/busses/i2c-viapro.c
index c1c9eb1..566342d 100644
--- a/drivers/i2c/busses/i2c-viapro.c
+++ b/drivers/i2c/busses/i2c-viapro.c
@@ -126,6 +126,8 @@ static void vt596_dump_regs(const char *
 		printk("%02x\n", inb_p(SMBBLKDAT));
 	}
 }
+#else
+static inline void vt596_dump_regs(const char *msg, u8 size) { }
 #endif
 
 /* Return -1 on error, 0 on success */
@@ -135,9 +137,7 @@ static int vt596_transaction(u8 size)
 	int result = 0;
 	int timeout = 0;
 
-#ifdef DEBUG
 	vt596_dump_regs("Transaction (pre)", size);
-#endif
 
 	/* Make sure the SMBus host is ready to start transmitting */
 	if ((temp = inb_p(SMBHSTSTS)) & 0x1F) {
@@ -192,9 +192,7 @@ static int vt596_transaction(u8 size)
 	if (temp & 0x1F)
 		outb_p(temp, SMBHSTSTS);
 
-#ifdef DEBUG
 	vt596_dump_regs("Transaction (post)", size);
-#endif
 
 	return result;
 }

