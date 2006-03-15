From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Wed, 15 Mar 2006 03:52:12 +0000
Subject: [lm-sensors] [PATCH 2.6.16-rc6] i2c: remove a log message from
Message-Id: <20060315035212.GB21733@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This patch removes an init-time kernel log message.
http://marc.theaimsgroup.com/?l=linux-kernel&m4232987208628&w=3

Signed-off-by: Mark M. Hoffman <mhoffman at lightlink.com>

--- linux-2.6.16-rc6.orig/drivers/i2c/busses/i2c-sis96x.c
+++ linux-2.6.16-rc6/drivers/i2c/busses/i2c-sis96x.c
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
 
@@ -337,7 +330,6 @@ static struct pci_driver sis96x_driver  
 static int __init i2c_sis96x_init(void)
 {
-	printk(KERN_INFO "i2c-sis96x version %s\n", SIS96x_VERSION);
 	return pci_register_driver(&sis96x_driver);
 }
 
-- 
Mark M. Hoffman
mhoffman at lightlink.com


