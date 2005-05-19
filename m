From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: [PATCH] i2c driver fixes for 2.6.1
Message-Id: <10745567571488@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <20040119235733.GA5549@kroah.com>
References: <1074556757661@kroah.com>
In-Reply-To: <1074556757661@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1474.98.1, 2004/01/14 11:08:59-08:00, trini@kernel.crashing.org

[PATCH] I2C: module_parm fixes for i2c-piix4.c


 drivers/i2c/busses/i2c-piix4.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
--- a/drivers/i2c/busses/i2c-piix4.c	Mon Jan 19 15:33:22 2004
+++ b/drivers/i2c/busses/i2c-piix4.c	Mon Jan 19 15:33:22 2004
@@ -31,6 +31,7 @@
 /* #define DEBUG 1 */
 
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/config.h>
 #include <linux/pci.h>
 #include <linux/kernel.h>
@@ -88,13 +89,13 @@
 /* If force is set to anything different from 0, we forcibly enable the
    PIIX4. DANGEROUS! */
 static int force = 0;
-MODULE_PARM(force, "i");
+module_param (force, int, 0);
 MODULE_PARM_DESC(force, "Forcibly enable the PIIX4. DANGEROUS!");
 
 /* If force_addr is set to anything different from 0, we forcibly enable
    the PIIX4 at the given address. VERY DANGEROUS! */
 static int force_addr = 0;
-MODULE_PARM(force_addr, "i");
+module_param (force_addr, int, 0);
 MODULE_PARM_DESC(force_addr,
 		 "Forcibly enable the PIIX4 at the given address. "
 		 "EXTREMELY DANGEROUS!");
@@ -102,7 +103,7 @@
 /* If fix_hstcfg is set to anything different from 0, we reset one of the
    registers to be a valid value. */
 static int fix_hstcfg = 0;
-MODULE_PARM(fix_hstcfg, "i");
+module_param (fix_hstcfg, int, 0);
 MODULE_PARM_DESC(fix_hstcfg,
 		"Fix config register. Needed on some boards (Force CPCI735).");
 

