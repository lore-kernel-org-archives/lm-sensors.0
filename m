From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 27 Feb 2006 22:13:53 +0000
Subject: [lm-sensors] [PATCH 5/6] i2c: Drop unneeded i2c-dev.h includes
Message-Id: <20060227231353.9e7f6cc9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=i2c-drop-unneeded-i2c-dev-h-includes.patch

Several media/video and sound drivers include i2c-dev.h while they
don't need it at all. Clean it up.

This header file is really only needed by i2c-dev.c and
compat_ioctl.c, other drivers should never need it.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/media/video/adv7170.c       |    1 -
 drivers/media/video/adv7175.c       |    1 -
 drivers/media/video/bt819.c         |    1 -
 drivers/media/video/bt856.c         |    1 -
 drivers/media/video/saa7110.c       |    1 -
 drivers/media/video/saa7111.c       |    1 -
 drivers/media/video/saa7114.c       |    1 -
 drivers/media/video/saa711x.c       |    1 -
 drivers/media/video/saa7185.c       |    1 -
 drivers/media/video/vpx3220.c       |    1 -
 sound/oss/dmasound/dmasound_awacs.c |    2 --
 sound/ppc/daca.c                    |    1 -
 sound/ppc/keywest.c                 |    1 -
 sound/ppc/toonie.c                  |    1 -
 sound/ppc/tumbler.c                 |    1 -
 15 files changed, 16 deletions(-)

--- linux-2.6.16-rc4.orig/drivers/media/video/adv7170.c	2006-02-18 12:30:39.000000000 +0100
+++ linux-2.6.16-rc4/drivers/media/video/adv7170.c	2006-02-18 15:16:52.000000000 +0100
@@ -53,7 +53,6 @@
 MODULE_LICENSE("GPL");
 
 #include <linux/i2c.h>
-#include <linux/i2c-dev.h>
 
 #define I2C_NAME(x) (x)->name
 
--- linux-2.6.16-rc4.orig/drivers/media/video/adv7175.c	2006-02-18 12:30:39.000000000 +0100
+++ linux-2.6.16-rc4/drivers/media/video/adv7175.c	2006-02-18 15:16:49.000000000 +0100
@@ -49,7 +49,6 @@
 MODULE_LICENSE("GPL");
 
 #include <linux/i2c.h>
-#include <linux/i2c-dev.h>
 
 #define I2C_NAME(s) (s)->name
 
--- linux-2.6.16-rc4.orig/drivers/media/video/bt819.c	2006-02-18 12:30:39.000000000 +0100
+++ linux-2.6.16-rc4/drivers/media/video/bt819.c	2006-02-18 15:16:43.000000000 +0100
@@ -53,7 +53,6 @@
 MODULE_LICENSE("GPL");
 
 #include <linux/i2c.h>
-#include <linux/i2c-dev.h>
 
 #define I2C_NAME(s) (s)->name
 
--- linux-2.6.16-rc4.orig/drivers/media/video/bt856.c	2006-02-18 12:30:40.000000000 +0100
+++ linux-2.6.16-rc4/drivers/media/video/bt856.c	2006-02-18 15:16:40.000000000 +0100
@@ -53,7 +53,6 @@
 MODULE_LICENSE("GPL");
 
 #include <linux/i2c.h>
-#include <linux/i2c-dev.h>
 
 #define I2C_NAME(s) (s)->name
 
--- linux-2.6.16-rc4.orig/drivers/media/video/saa7110.c	2006-02-18 12:30:39.000000000 +0100
+++ linux-2.6.16-rc4/drivers/media/video/saa7110.c	2006-02-18 15:16:37.000000000 +0100
@@ -39,7 +39,6 @@
 MODULE_LICENSE("GPL");
 
 #include <linux/i2c.h>
-#include <linux/i2c-dev.h>
 
 #define I2C_NAME(s) (s)->name
 
--- linux-2.6.16-rc4.orig/drivers/media/video/saa7111.c	2006-02-18 12:30:39.000000000 +0100
+++ linux-2.6.16-rc4/drivers/media/video/saa7111.c	2006-02-18 15:16:34.000000000 +0100
@@ -52,7 +52,6 @@
 MODULE_LICENSE("GPL");
 
 #include <linux/i2c.h>
-#include <linux/i2c-dev.h>
 
 #define I2C_NAME(s) (s)->name
 
--- linux-2.6.16-rc4.orig/drivers/media/video/saa7114.c	2006-02-18 12:30:39.000000000 +0100
+++ linux-2.6.16-rc4/drivers/media/video/saa7114.c	2006-02-18 15:16:31.000000000 +0100
@@ -55,7 +55,6 @@
 MODULE_LICENSE("GPL");
 
 #include <linux/i2c.h>
-#include <linux/i2c-dev.h>
 
 #define I2C_NAME(x) (x)->name
 
--- linux-2.6.16-rc4.orig/drivers/media/video/saa711x.c	2006-02-09 19:26:55.000000000 +0100
+++ linux-2.6.16-rc4/drivers/media/video/saa711x.c	2006-02-18 15:16:28.000000000 +0100
@@ -45,7 +45,6 @@
 MODULE_LICENSE("GPL");
 
 #include <linux/i2c.h>
-#include <linux/i2c-dev.h>
 
 #define I2C_NAME(s) (s)->name
 
--- linux-2.6.16-rc4.orig/drivers/media/video/saa7185.c	2006-02-18 12:30:39.000000000 +0100
+++ linux-2.6.16-rc4/drivers/media/video/saa7185.c	2006-02-18 15:16:25.000000000 +0100
@@ -49,7 +49,6 @@
 MODULE_LICENSE("GPL");
 
 #include <linux/i2c.h>
-#include <linux/i2c-dev.h>
 
 #define I2C_NAME(s) (s)->name
 
--- linux-2.6.16-rc4.orig/drivers/media/video/vpx3220.c	2006-02-09 19:26:55.000000000 +0100
+++ linux-2.6.16-rc4/drivers/media/video/vpx3220.c	2006-02-18 15:16:21.000000000 +0100
@@ -30,7 +30,6 @@
 #include <asm/uaccess.h>
 
 #include <linux/i2c.h>
-#include <linux/i2c-dev.h>
 
 #define I2C_NAME(x) (x)->name
 
--- linux-2.6.16-rc4.orig/sound/oss/dmasound/dmasound_awacs.c	2006-02-09 19:27:11.000000000 +0100
+++ linux-2.6.16-rc4/sound/oss/dmasound/dmasound_awacs.c	2006-02-18 15:16:17.000000000 +0100
@@ -88,8 +88,6 @@
 #include <linux/pmu.h>
 #endif
 
-#include <linux/i2c-dev.h>
-
 #include <asm/uaccess.h>
 #include <asm/prom.h>
 #include <asm/machdep.h>
--- linux-2.6.16-rc4.orig/sound/ppc/daca.c	2006-02-09 19:27:12.000000000 +0100
+++ linux-2.6.16-rc4/sound/ppc/daca.c	2006-02-18 15:16:13.000000000 +0100
@@ -22,7 +22,6 @@
 #include <sound/driver.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
-#include <linux/i2c-dev.h>
 #include <linux/kmod.h>
 #include <linux/slab.h>
 #include <sound/core.h>
--- linux-2.6.16-rc4.orig/sound/ppc/keywest.c	2006-02-09 19:27:12.000000000 +0100
+++ linux-2.6.16-rc4/sound/ppc/keywest.c	2006-02-18 15:16:09.000000000 +0100
@@ -23,7 +23,6 @@
 #include <linux/init.h>
 #include <linux/i2c.h>
 #include <linux/delay.h>
-#include <linux/i2c-dev.h>
 #include <linux/slab.h>
 #include <sound/core.h>
 #include "pmac.h"
--- linux-2.6.16-rc4.orig/sound/ppc/toonie.c	2006-02-09 19:27:12.000000000 +0100
+++ linux-2.6.16-rc4/sound/ppc/toonie.c	2006-02-18 15:16:06.000000000 +0100
@@ -22,7 +22,6 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
-#include <linux/i2c-dev.h>
 #include <linux/kmod.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
--- linux-2.6.16-rc4.orig/sound/ppc/tumbler.c	2006-02-13 19:22:18.000000000 +0100
+++ linux-2.6.16-rc4/sound/ppc/tumbler.c	2006-02-18 15:16:03.000000000 +0100
@@ -28,7 +28,6 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
-#include <linux/i2c-dev.h>
 #include <linux/kmod.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>

-- 
Jean Delvare

