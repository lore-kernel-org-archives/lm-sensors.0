From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 09 Jan 2006 22:09:57 +0000
Subject: [lm-sensors] [PATCH 05/11] i2c: Use module_param in i2c-algo-sibyte
Message-Id: <20060109230957.041f41af.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Eric Sesterhenn <snakebyte at gmx.de>
Content-Disposition: inline; filename=i2c-algo-sibyte-module-param.patch

this patch changes MODULE_PARM usage
to module_param in i2c-algo-sibyte.c

Signed-off-by: Eric Sesterhenn <snakebyte at gmx.de>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/i2c/algos/i2c-algo-sibyte.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.15-rc6.orig/drivers/i2c/algos/i2c-algo-sibyte.c	2005-11-12 15:49:51.000000000 +0100
+++ linux-2.6.15-rc6/drivers/i2c/algos/i2c-algo-sibyte.c	2005-12-23 10:50:12.000000000 +0100
@@ -202,7 +202,7 @@
 #ifdef MODULE
 MODULE_AUTHOR("Kip Walker, Broadcom Corp.");
 MODULE_DESCRIPTION("SiByte I2C-Bus algorithm");
-MODULE_PARM(bit_scan, "i");
+module_param(bit_scan, int, 0);
 MODULE_PARM_DESC(bit_scan, "Scan for active chips on the bus");
 MODULE_LICENSE("GPL");
 

-- 
Jean Delvare

