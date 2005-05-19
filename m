From: kmalkki@cc.hut.fi (Kyosti Malkki)
Date: Thu, 19 May 2005 06:23:45 +0000
Subject: i2c changes Was: sensors in 2.5.54
Message-Id: <Pine.OSF.4.50.0301070020190.17118-200000@kosh.hut.fi>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 4 Jan 2003, Mark Studebaker wrote:

> The patch for i2c-amd756, i2c-amd8111, adm1021, and lm75,
> submitted by Pavel Machek, has been included,
> with modifications, in kernel 2.5.54 by Cristoph Hellwig.

Attached patch removes unnecessary include of i2c header files
at few locations. With luck it still compiles. Should..

It seems that sysctl enumeration has moved out of sensors.h, but
libsensors depends on this. While the list is long and boring, so is
linux/sysctl.h. I believe we want it back.

> Note that we'll have to go through the changes he made,
> figure them out, backport them into CVS, and apply
> to the other drivers.
>
> This will be somewhat easier after we remove 2.2 support.
> But there are still several 2.4<->2.5 differences which
> we will have to keep out of CVS, or at least #ifdef,
> and the patcher will have to deal with those.

One could generate a branch in CVS from i2c release V2-6-4 to trace back
changes in 2.5 tree, and then reapply it on 2.5 to sync revision tags.
I briefly reviewed some i2c diffs, they mostly handle module refcounting
and declarations which are not likely to change for 2.4 support.

Optimally, we could keep up with the pace and have relevant 2.5 patches
go through i2c CVS first and have files in sync. This seems not be the
case, so I say it is better to remove revision tags from i2c files in
Linus's tree altogether.

-- 
  Ky?sti M?lkki
  kmalkki@cc.hut.fi
-------------- next part --------------
diff -u -r orig/linux-2.5.54/drivers/media/video/tda7432.c linux-2.5.54/drivers/media/video/tda7432.c
--- orig/linux-2.5.54/drivers/media/video/tda7432.c	Thu Jan  2 05:22:35 2003
+++ linux-2.5.54/drivers/media/video/tda7432.c	Mon Jan  6 13:52:48 2003
@@ -42,7 +42,6 @@
 #include <linux/slab.h>
 #include <linux/videodev.h>
 #include <linux/i2c.h>
-#include <linux/i2c-algo-bit.h>
 
 #include "bttv.h"
 #include "audiochip.h"
Only in linux-2.5.54/drivers/media/video: tda7432.c~
diff -u -r orig/linux-2.5.54/drivers/media/video/tda9875.c linux-2.5.54/drivers/media/video/tda9875.c
--- orig/linux-2.5.54/drivers/media/video/tda9875.c	Thu Jan  2 05:21:51 2003
+++ linux-2.5.54/drivers/media/video/tda9875.c	Mon Jan  6 13:53:02 2003
@@ -27,7 +27,6 @@
 #include <linux/slab.h>
 #include <linux/videodev.h>
 #include <linux/i2c.h>
-#include <linux/i2c-algo-bit.h>
 #include <linux/init.h>
 
 #include "bttv.h"
Only in linux-2.5.54/drivers/media/video: tda9875.c~
diff -u -r orig/linux-2.5.54/drivers/media/video/tvaudio.c linux-2.5.54/drivers/media/video/tvaudio.c
--- orig/linux-2.5.54/drivers/media/video/tvaudio.c	Thu Jan  2 05:21:40 2003
+++ linux-2.5.54/drivers/media/video/tvaudio.c	Mon Jan  6 13:52:31 2003
@@ -25,7 +25,6 @@
 #include <linux/slab.h>
 #include <linux/videodev.h>
 #include <linux/i2c.h>
-#include <linux/i2c-algo-bit.h>
 #include <linux/init.h>
 #include <linux/smp_lock.h>
 
Only in linux-2.5.54/drivers/media/video: tvaudio.c~
diff -u -r orig/linux-2.5.54/drivers/video/matrox/matroxfb_crtc2.h linux-2.5.54/drivers/video/matrox/matroxfb_crtc2.h
--- orig/linux-2.5.54/drivers/video/matrox/matroxfb_crtc2.h	Thu Jan  2 05:21:11 2003
+++ linux-2.5.54/drivers/video/matrox/matroxfb_crtc2.h	Mon Jan  6 14:03:04 2003
@@ -2,8 +2,6 @@
 #define __MATROXFB_CRTC2_H__
 
 #include <linux/ioctl.h>
-#include <linux/i2c.h>
-#include <linux/i2c-algo-bit.h>
 #include "matroxfb_base.h"
 
 struct matroxfb_dh_fb_info {
Only in linux-2.5.54/drivers/video/matrox: matroxfb_crtc2.h~
diff -u -r orig/linux-2.5.54/sound/oss/dmasound/dmasound_awacs.c linux-2.5.54/sound/oss/dmasound/dmasound_awacs.c
--- orig/linux-2.5.54/sound/oss/dmasound/dmasound_awacs.c	Thu Jan  2 05:21:41 2003
+++ linux-2.5.54/sound/oss/dmasound/dmasound_awacs.c	Mon Jan  6 18:59:16 2003
@@ -76,8 +76,6 @@
 #include <linux/pmu.h>
 #endif
 
-#include <linux/i2c-dev.h>
-
 #include <asm/uaccess.h>
 #include <asm/prom.h>
 #include <asm/machdep.h>
diff -u -r orig/linux-2.5.54/sound/ppc/daca.c linux-2.5.54/sound/ppc/daca.c
--- orig/linux-2.5.54/sound/ppc/daca.c	Thu Jan  2 05:21:10 2003
+++ linux-2.5.54/sound/ppc/daca.c	Mon Jan  6 18:52:22 2003
@@ -22,7 +22,6 @@
 #include <sound/driver.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
-#include <linux/i2c-dev.h>
 #include <linux/kmod.h>
 #include <linux/slab.h>
 #include <sound/core.h>
diff -u -r orig/linux-2.5.54/sound/ppc/keywest.c linux-2.5.54/sound/ppc/keywest.c
--- orig/linux-2.5.54/sound/ppc/keywest.c	Thu Jan  2 05:23:10 2003
+++ linux-2.5.54/sound/ppc/keywest.c	Mon Jan  6 18:56:15 2003
@@ -22,7 +22,6 @@
 #include <sound/driver.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
-#include <linux/i2c-dev.h>
 #include <linux/slab.h>
 #include <sound/core.h>
 #include "pmac.h"
diff -u -r orig/linux-2.5.54/sound/ppc/tumbler.c linux-2.5.54/sound/ppc/tumbler.c
--- orig/linux-2.5.54/sound/ppc/tumbler.c	Thu Jan  2 05:20:59 2003
+++ linux-2.5.54/sound/ppc/tumbler.c	Mon Jan  6 18:53:24 2003
@@ -23,7 +23,6 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
-#include <linux/i2c-dev.h>
 #include <linux/kmod.h>
 #include <linux/slab.h>
 #include <sound/core.h>
