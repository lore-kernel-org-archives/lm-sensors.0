From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: [PATCH 2.6] kill duplicate includes in i2c bus drivers
Message-Id: <20040509202400.4b5b4a90.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

Following a suggestion of Arthur Othieno, here is a trivial patch that
kills duplicate inclusions of config.h in four i2c bus drivers.

At first I was thinking of also removing inclusions of config.h wherever
it doesn't seem to be necessary but Eugene doesn't seem to think it's a
good idea. So I may give it a try later (in 2.7), but for now this
simple patch will be enough.

Please apply,
thanks.

diff -ru linux-2.6.6-rc3-mm2/drivers/i2c.orig/busses/i2c-keywest.c linux-2.6.6-rc3-mm2/drivers/i2c/busses/i2c-keywest.c
--- linux-2.6.6-rc3-mm2/drivers/i2c.orig/busses/i2c-keywest.c	Sun Apr  4 09:52:29 2004
+++ linux-2.6.6-rc3-mm2/drivers/i2c/busses/i2c-keywest.c	Sun May  9 19:45:24 2004
@@ -48,7 +48,6 @@
 
 #include <linux/config.h>
 #include <linux/module.h>
-#include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/ioport.h>
 #include <linux/pci.h>
diff -ru linux-2.6.6-rc3-mm2/drivers/i2c.orig/busses/i2c-piix4.c linux-2.6.6-rc3-mm2/drivers/i2c/busses/i2c-piix4.c
--- linux-2.6.6-rc3-mm2/drivers/i2c.orig/busses/i2c-piix4.c	Sun Apr  4 09:52:29 2004
+++ linux-2.6.6-rc3-mm2/drivers/i2c/busses/i2c-piix4.c	Sun May  9 19:45:43 2004
@@ -31,7 +31,6 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/config.h>
 #include <linux/pci.h>
 #include <linux/kernel.h>
 #include <linux/stddef.h>
diff -ru linux-2.6.6-rc3-mm2/drivers/i2c.orig/busses/scx200_acb.c linux-2.6.6-rc3-mm2/drivers/i2c/busses/scx200_acb.c
--- linux-2.6.6-rc3-mm2/drivers/i2c.orig/busses/scx200_acb.c	Sun Apr  4 09:52:29 2004
+++ linux-2.6.6-rc3-mm2/drivers/i2c/busses/scx200_acb.c	Sun May  9 19:45:30 2004
@@ -25,7 +25,6 @@
 */
 
 #include <linux/config.h>
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
diff -ru linux-2.6.6-rc3-mm2/drivers/i2c.orig/busses/scx200_i2c.c linux-2.6.6-rc3-mm2/drivers/i2c/busses/scx200_i2c.c
--- linux-2.6.6-rc3-mm2/drivers/i2c.orig/busses/scx200_i2c.c	Sun Apr  4 09:52:29 2004
+++ linux-2.6.6-rc3-mm2/drivers/i2c/busses/scx200_i2c.c	Sun May  9 19:45:34 2004
@@ -22,7 +22,6 @@
 */
 
 #include <linux/config.h>
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>


-- 
Jean Delvare
http://khali.linux-fr.org/
