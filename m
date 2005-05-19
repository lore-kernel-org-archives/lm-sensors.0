From: bunk@stusta.de (Adrian Bunk)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: [2.6 patch] drivers/i2c/chips/ds1337.c: #if 0 an unused function
Message-Id: <20050417200056.GG3625@stusta.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Chapman <jchapman@katalix.com>
Cc: greg@kroah.com, khali@linux-fr.org, sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org

This patch #if 0's an unused global function.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc2-mm3-full/drivers/i2c/chips/ds1337.c.old	2005-04-17 18:32:54.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/i2c/chips/ds1337.c	2005-04-17 18:33:16.000000000 +0200
@@ -228,6 +228,7 @@
  * Public API for access to specific device. Useful for low-level
  * RTC access from kernel code.
  */
+#if 0
 int ds1337_do_command(int id, int cmd, void *arg)
 {
 	struct list_head *walk;
@@ -242,6 +243,7 @@
 
 	return -ENODEV;
 }
+#endif  /*  0  */
 
 static int ds1337_attach_adapter(struct i2c_adapter *adapter)
 {
