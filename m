From: gregkh@suse.de (Greg KH)
Date: Thu, 23 Mar 2006 22:43:52 +0000
Subject: [lm-sensors] [PATCH 34/36] I2C: Drop unneeded i2c-dev.h includes
Message-Id: <11431538321730-git-send-email-gregkh@suse.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Several media/video and sound drivers include i2c-dev.h while they
don't need it at all. Clean it up.

This header file is really only needed by i2c-dev.c and
compat_ioctl.c, other drivers should never need it.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

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
 15 files changed, 0 insertions(+), 16 deletions(-)

279a022d4a12598b58aee47a73faf2d8cc72c91f
diff --git a/drivers/media/video/adv7170.c b/drivers/media/video/adv7170.c
index 4ce07ae..6e2004c 100644
--- a/drivers/media/video/adv7170.c
+++ b/drivers/media/video/adv7170.c
@@ -53,7 +53,6 @@ MODULE_AUTHOR("Maxim Yevtyushkin");
 MODULE_LICENSE("GPL");
 
 #include <linux/i2c.h>
-#include <linux/i2c-dev.h>
 
 #define I2C_NAME(x) (x)->name
 
diff --git a/drivers/media/video/adv7175.c b/drivers/media/video/adv7175.c
index 4e218f2..6b17247 100644
--- a/drivers/media/video/adv7175.c
+++ b/drivers/media/video/adv7175.c
@@ -49,7 +49,6 @@ MODULE_AUTHOR("Dave Perks");
 MODULE_LICENSE("GPL");
 
 #include <linux/i2c.h>
-#include <linux/i2c-dev.h>
 
 #define I2C_NAME(s) (s)->name
 
diff --git a/drivers/media/video/bt819.c b/drivers/media/video/bt819.c
index d644779..2bf63e7 100644
--- a/drivers/media/video/bt819.c
+++ b/drivers/media/video/bt819.c
@@ -53,7 +53,6 @@ MODULE_AUTHOR("Mike Bernson & Dave Perks
 MODULE_LICENSE("GPL");
 
 #include <linux/i2c.h>
-#include <linux/i2c-dev.h>
 
 #define I2C_NAME(s) (s)->name
 
diff --git a/drivers/media/video/bt856.c b/drivers/media/video/bt856.c
index 909b593..da3be00 100644
--- a/drivers/media/video/bt856.c
+++ b/drivers/media/video/bt856.c
@@ -53,7 +53,6 @@ MODULE_AUTHOR("Mike Bernson & Dave Perks
 MODULE_LICENSE("GPL");
 
 #include <linux/i2c.h>
-#include <linux/i2c-dev.h>
 
 #define I2C_NAME(s) (s)->name
 
diff --git a/drivers/media/video/saa7110.c b/drivers/media/video/saa7110.c
index 7bb85a7..dff0689 100644
--- a/drivers/media/video/saa7110.c
+++ b/drivers/media/video/saa7110.c
@@ -39,7 +39,6 @@ MODULE_AUTHOR("Pauline Middelink");
 MODULE_LICENSE("GPL");
 
 #include <linux/i2c.h>
-#include <linux/i2c-dev.h>
 
 #define I2C_NAME(s) (s)->name
 
diff --git a/drivers/media/video/saa7111.c b/drivers/media/video/saa7111.c
index 8c06592..5e06cc9 100644
--- a/drivers/media/video/saa7111.c
+++ b/drivers/media/video/saa7111.c
@@ -52,7 +52,6 @@ MODULE_AUTHOR("Dave Perks");
 MODULE_LICENSE("GPL");
 
 #include <linux/i2c.h>
-#include <linux/i2c-dev.h>
 
 #define I2C_NAME(s) (s)->name
 
diff --git a/drivers/media/video/saa7114.c b/drivers/media/video/saa7114.c
index fd0a4b4..ce5a740 100644
--- a/drivers/media/video/saa7114.c
+++ b/drivers/media/video/saa7114.c
@@ -55,7 +55,6 @@ MODULE_AUTHOR("Maxim Yevtyushkin");
 MODULE_LICENSE("GPL");
 
 #include <linux/i2c.h>
-#include <linux/i2c-dev.h>
 
 #define I2C_NAME(x) (x)->name
 
diff --git a/drivers/media/video/saa711x.c b/drivers/media/video/saa711x.c
index 6c161f2..708fae5 100644
--- a/drivers/media/video/saa711x.c
+++ b/drivers/media/video/saa711x.c
@@ -45,7 +45,6 @@ MODULE_AUTHOR("Dave Perks, Jose Ignacio 
 MODULE_LICENSE("GPL");
 
 #include <linux/i2c.h>
-#include <linux/i2c-dev.h>
 
 #define I2C_NAME(s) (s)->name
 
diff --git a/drivers/media/video/saa7185.c b/drivers/media/video/saa7185.c
index 3ed0edb..e1718e8 100644
--- a/drivers/media/video/saa7185.c
+++ b/drivers/media/video/saa7185.c
@@ -49,7 +49,6 @@ MODULE_AUTHOR("Dave Perks");
 MODULE_LICENSE("GPL");
 
 #include <linux/i2c.h>
-#include <linux/i2c-dev.h>
 
 #define I2C_NAME(s) (s)->name
 
diff --git a/drivers/media/video/vpx3220.c b/drivers/media/video/vpx3220.c
index d0a1e72..4cd5799 100644
--- a/drivers/media/video/vpx3220.c
+++ b/drivers/media/video/vpx3220.c
@@ -30,7 +30,6 @@
 #include <asm/uaccess.h>
 
 #include <linux/i2c.h>
-#include <linux/i2c-dev.h>
 
 #define I2C_NAME(x) (x)->name
 
diff --git a/sound/oss/dmasound/dmasound_awacs.c b/sound/oss/dmasound/dmasound_awacs.c
index a173751..6ba8d6f 100644
--- a/sound/oss/dmasound/dmasound_awacs.c
+++ b/sound/oss/dmasound/dmasound_awacs.c
@@ -88,8 +88,6 @@
 #include <linux/pmu.h>
 #endif
 
-#include <linux/i2c-dev.h>
-
 #include <asm/uaccess.h>
 #include <asm/prom.h>
 #include <asm/machdep.h>
diff --git a/sound/ppc/daca.c b/sound/ppc/daca.c
index 08cde51..aa09ebd 100644
--- a/sound/ppc/daca.c
+++ b/sound/ppc/daca.c
@@ -22,7 +22,6 @@
 #include <sound/driver.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
-#include <linux/i2c-dev.h>
 #include <linux/kmod.h>
 #include <linux/slab.h>
 #include <sound/core.h>
diff --git a/sound/ppc/keywest.c b/sound/ppc/keywest.c
index 6058c2d..fb05938 100644
--- a/sound/ppc/keywest.c
+++ b/sound/ppc/keywest.c
@@ -23,7 +23,6 @@
 #include <linux/init.h>
 #include <linux/i2c.h>
 #include <linux/delay.h>
-#include <linux/i2c-dev.h>
 #include <linux/slab.h>
 #include <sound/core.h>
 #include "pmac.h"
diff --git a/sound/ppc/toonie.c b/sound/ppc/toonie.c
index 053b8f2..210be20 100644
--- a/sound/ppc/toonie.c
+++ b/sound/ppc/toonie.c
@@ -22,7 +22,6 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
-#include <linux/i2c-dev.h>
 #include <linux/kmod.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
diff --git a/sound/ppc/tumbler.c b/sound/ppc/tumbler.c
index 838fc11..1146dd8 100644
--- a/sound/ppc/tumbler.c
+++ b/sound/ppc/tumbler.c
@@ -28,7 +28,6 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
-#include <linux/i2c-dev.h>
 #include <linux/kmod.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
-- 
1.2.4



