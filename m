From: greg@kroah.com (Greg KH)
Date: Fri, 14 Apr 2006 20:10:47 +0000
Subject: [lm-sensors] [PATCH 4/5] i2c-sis96x: Remove an init-time log message
Message-Id: <1145045447413-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch removes an init-time kernel log message.
http://marc.theaimsgroup.com/?l=linux-kernel&m4232987208628&w=3

Signed-off-by: Mark M. Hoffman <mhoffman at lightlink.com>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---

 drivers/i2c/busses/i2c-sis96x.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

3cb8e1a92ef7588d3acdecf493ddddd0dd71a709
diff --git a/drivers/i2c/busses/i2c-sis96x.c b/drivers/i2c/busses/i2c-sis96x.c
index 3024907..1a73c05 100644
--- a/drivers/i2c/busses/i2c-sis96x.c
+++ b/drivers/i2c/busses/i2c-sis96x.c
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
1.2.6



