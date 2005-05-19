From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: [PATCH] I2C update for 2.6.6
Message-Id: <10845773573133@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10845773573392@kroah.com>
References: <10845773562431@kroah.com>
In-Reply-To: <10845773562431@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1587.15.12, 2004/05/11 13:43:55-07:00, khali@linux-fr.org

[PATCH] I2C: kill duplicate includes in i2c bus drivers

Following a suggestion of Arthur Othieno, here is a trivial patch that
kills duplicate inclusions of config.h in four i2c bus drivers.

At first I was thinking of also removing inclusions of config.h wherever
it doesn't seem to be necessary but Eugene doesn't seem to think it's a
good idea. So I may give it a try later (in 2.7), but for now this
simple patch will be enough.


 drivers/i2c/busses/i2c-keywest.c |    1 -
 drivers/i2c/busses/i2c-piix4.c   |    1 -
 drivers/i2c/busses/scx200_acb.c  |    1 -
 drivers/i2c/busses/scx200_i2c.c  |    1 -
 4 files changed, 4 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-keywest.c b/drivers/i2c/busses/i2c-keywest.c
--- a/drivers/i2c/busses/i2c-keywest.c	Fri May 14 16:19:27 2004
+++ b/drivers/i2c/busses/i2c-keywest.c	Fri May 14 16:19:27 2004
@@ -48,7 +48,6 @@
 
 #include <linux/config.h>
 #include <linux/module.h>
-#include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/ioport.h>
 #include <linux/pci.h>
diff -Nru a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
--- a/drivers/i2c/busses/i2c-piix4.c	Fri May 14 16:19:27 2004
+++ b/drivers/i2c/busses/i2c-piix4.c	Fri May 14 16:19:27 2004
@@ -31,7 +31,6 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/config.h>
 #include <linux/pci.h>
 #include <linux/kernel.h>
 #include <linux/stddef.h>
diff -Nru a/drivers/i2c/busses/scx200_acb.c b/drivers/i2c/busses/scx200_acb.c
--- a/drivers/i2c/busses/scx200_acb.c	Fri May 14 16:19:27 2004
+++ b/drivers/i2c/busses/scx200_acb.c	Fri May 14 16:19:27 2004
@@ -25,7 +25,6 @@
 */
 
 #include <linux/config.h>
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
diff -Nru a/drivers/i2c/busses/scx200_i2c.c b/drivers/i2c/busses/scx200_i2c.c
--- a/drivers/i2c/busses/scx200_i2c.c	Fri May 14 16:19:27 2004
+++ b/drivers/i2c/busses/scx200_i2c.c	Fri May 14 16:19:27 2004
@@ -22,7 +22,6 @@
 */
 
 #include <linux/config.h>
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>

