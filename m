From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 23 Mar 2006 15:49:34 +0000
Subject: [lm-sensors] [PATCH 09/10] i2c-sis96x: Remove an init-time log
Message-Id: <20060323164934.5bc2122f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: "Mark M. Hoffman" <mhoffman at lightlink.com>
Content-Disposition: inline; filename=i2c-sis96x-remove-init-log-message.patch

This patch removes an init-time kernel log message.
http://marc.theaimsgroup.com/?l=linux-kernel&m4232987208628&w=3

Signed-off-by: Mark M. Hoffman <mhoffman at lightlink.com>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/i2c/busses/i2c-sis96x.c |    8 --------
 1 file changed, 8 deletions(-)

--- linux-2.6.16-rc6.orig/drivers/i2c/busses/i2c-sis96x.c	2006-03-13 21:41:04.000000000 +0100
+++ linux-2.6.16-rc6/drivers/i2c/busses/i2c-sis96x.c	2006-03-15 19:30:03.000000000 +0100
@@ -43,13 +43,6 @@
 #include <linux/init.h>
 #include <asm/io.h>
 
-/*
-	HISTORY:
-	2003-05-11	1.0.0 	Updated from lm_sensors project for kernel 2.5
-				(was i2c-sis645.c from lm_sensors 2.7.0)
-*/
-#define SIS96x_VERSION "1.0.0"
-
 /* base address register in PCI config space */
 #define SIS96x_BAR 0x04
 
@@ -337,7 +330,6 @@
 
 static int __init i2c_sis96x_init(void)
 {
-	printk(KERN_INFO "i2c-sis96x version %s\n", SIS96x_VERSION);
 	return pci_register_driver(&sis96x_driver);
 }
 

-- 
Jean Delvare

