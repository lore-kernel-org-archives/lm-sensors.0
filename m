From: gregkh@suse.de (Greg KH)
Date: Fri, 06 Jan 2006 22:07:33 +0000
Subject: [lm-sensors] [PATCH] i2c: i2c-i801 explicitly enables/disables PEC
Message-Id: <11365852532723@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: i2c-i801 explicitly enables/disables PEC

This patch tweaks i2c-i801.c so that the driver always sets the SMBAUXCTL
register (which enables/disables PEC) explicitly before each transaction.

Signed-off-by: Mark M. Hoffman <mhoffman at lightlink.com>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
commit 2e3e13f8e9d9b2111404cdccaa4e1b988b70acce
tree de95ee215c2189cbfb98829e32e7fb117c94a160
parent 46f25dffbaba48c571d75f5f574f31978287b8d2
author Mark M. Hoffman <mhoffman at lightlink.com> Sun, 06 Nov 2005 23:04:51 +0100
committer Greg Kroah-Hartman <gregkh at suse.de> Thu, 05 Jan 2006 22:16:20 -0800

 drivers/i2c/busses/i2c-i801.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index ac3eafa..1c752dd 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -468,8 +468,7 @@ static s32 i801_access(struct i2c_adapte
 		return -1;
 	}
 
-	if (hwpec)
-		outb_p(1, SMBAUXCTL);	/* enable hardware PEC */
+	outb_p(hwpec, SMBAUXCTL);	/* enable/disable hardware PEC */
 
 	if(block)
 		ret = i801_block_transaction(data, read_write, size, hwpec);
@@ -478,9 +477,6 @@ static s32 i801_access(struct i2c_adapte
 		ret = i801_transaction();
 	}
 
-	if (hwpec)
-		outb_p(0, SMBAUXCTL);	/* disable hardware PEC */
-
 	if(block)
 		return ret;
 	if(ret)


