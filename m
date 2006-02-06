From: gregkh@suse.de (Greg KH)
Date: Mon, 06 Feb 2006 20:18:58 +0000
Subject: [lm-sensors] [PATCH] i2c: Use module_param in i2c-algo-sibyte
Message-Id: <1139257138769@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: Use module_param in i2c-algo-sibyte

this patch changes MODULE_PARM usage
to module_param in i2c-algo-sibyte.c

Signed-off-by: Eric Sesterhenn <snakebyte at gmx.de>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
commit 8104a9a9c9ad8c849d931c46ef6841b23d1fc729
tree aa3eedb4db3ab3cb79a74208971f756b3ab99155
parent 0d0ab7fe4c009c40dc485731f9ad98e1d336ddae
author Eric Sesterhenn <snakebyte at gmx.de> Mon, 09 Jan 2006 23:09:57 +0100
committer Greg Kroah-Hartman <gregkh at suse.de> Mon, 06 Feb 2006 12:02:15 -0800

 drivers/i2c/algos/i2c-algo-sibyte.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/algos/i2c-algo-sibyte.c b/drivers/i2c/algos/i2c-algo-sibyte.c
index 938848a..3df3f09 100644
--- a/drivers/i2c/algos/i2c-algo-sibyte.c
+++ b/drivers/i2c/algos/i2c-algo-sibyte.c
@@ -202,7 +202,7 @@ EXPORT_SYMBOL(i2c_sibyte_del_bus);
 #ifdef MODULE
 MODULE_AUTHOR("Kip Walker, Broadcom Corp.");
 MODULE_DESCRIPTION("SiByte I2C-Bus algorithm");
-MODULE_PARM(bit_scan, "i");
+module_param(bit_scan, int, 0);
 MODULE_PARM_DESC(bit_scan, "Scan for active chips on the bus");
 MODULE_LICENSE("GPL");
 


