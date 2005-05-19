From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:18 +0000
Subject: [PATCH] i2c driver fixes for 2.6.0-test5
Message-Id: <10642734213007@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10642734211077@kroah.com>
References: <1064273416272@kroah.com>
In-Reply-To: <1064273416272@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1315.1.8, 2003/09/15 16:54:37-07:00, rwhron@earthlink.net

[PATCH] I2C: drivers/i2c version.h cleanup

remove unnecessary version.h from drivers/i2c.
test compiled with 2.6.0-test5-bk2 on x86.


 drivers/i2c/busses/i2c-amd756.c |    1 -
 drivers/i2c/i2c-adap-ite.c      |    1 -
 drivers/i2c/i2c-algo-ite.c      |    1 -
 drivers/i2c/i2c-elektor.c       |    1 -
 drivers/i2c/i2c-keywest.c       |    1 -
 drivers/i2c/i2c-prosavage.c     |    1 -
 6 files changed, 6 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-amd756.c b/drivers/i2c/busses/i2c-amd756.c
--- a/drivers/i2c/busses/i2c-amd756.c	Mon Sep 22 16:14:51 2003
+++ b/drivers/i2c/busses/i2c-amd756.c	Mon Sep 22 16:14:51 2003
@@ -37,7 +37,6 @@
 
 /* #define DEBUG 1 */
 
-#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/kernel.h>
diff -Nru a/drivers/i2c/i2c-adap-ite.c b/drivers/i2c/i2c-adap-ite.c
--- a/drivers/i2c/i2c-adap-ite.c	Mon Sep 22 16:14:51 2003
+++ b/drivers/i2c/i2c-adap-ite.c	Mon Sep 22 16:14:51 2003
@@ -38,7 +38,6 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
-#include <linux/version.h>
 #include <linux/init.h>
 #include <asm/irq.h>
 #include <asm/io.h>
diff -Nru a/drivers/i2c/i2c-algo-ite.c b/drivers/i2c/i2c-algo-ite.c
--- a/drivers/i2c/i2c-algo-ite.c	Mon Sep 22 16:14:51 2003
+++ b/drivers/i2c/i2c-algo-ite.c	Mon Sep 22 16:14:51 2003
@@ -38,7 +38,6 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
-#include <linux/version.h>
 #include <linux/init.h>
 #include <asm/uaccess.h>
 #include <linux/ioport.h>
diff -Nru a/drivers/i2c/i2c-elektor.c b/drivers/i2c/i2c-elektor.c
--- a/drivers/i2c/i2c-elektor.c	Mon Sep 22 16:14:51 2003
+++ b/drivers/i2c/i2c-elektor.c	Mon Sep 22 16:14:51 2003
@@ -30,7 +30,6 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
-#include <linux/version.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/pci.h>
diff -Nru a/drivers/i2c/i2c-keywest.c b/drivers/i2c/i2c-keywest.c
--- a/drivers/i2c/i2c-keywest.c	Mon Sep 22 16:14:51 2003
+++ b/drivers/i2c/i2c-keywest.c	Mon Sep 22 16:14:51 2003
@@ -45,7 +45,6 @@
 
 #include <linux/module.h>
 #include <linux/config.h>
-#include <linux/version.h>
 #include <linux/kernel.h>
 #include <linux/ioport.h>
 #include <linux/pci.h>
diff -Nru a/drivers/i2c/i2c-prosavage.c b/drivers/i2c/i2c-prosavage.c
--- a/drivers/i2c/i2c-prosavage.c	Mon Sep 22 16:14:51 2003
+++ b/drivers/i2c/i2c-prosavage.c	Mon Sep 22 16:14:51 2003
@@ -54,7 +54,6 @@
  *    (Additional documentation needed :(
  */
 
-#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/pci.h>

