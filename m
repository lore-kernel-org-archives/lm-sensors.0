From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 11 Aug 2008 07:04:32 +0000
Subject: [lm-sensors] [PATCH] powerpc/drivers: use linux/of_device.h instead
Message-Id: <20080811170432.f747ab5e.sfr@canb.auug.org.au>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: alsa-devel@alsa-project.org, Stelian Pop <stelian@popies.net>, Hanselmann <linux-kernel@hansmi.ch>, Michael@alsa-project.org, lm-sensors@lm-sensors.org, linuxppc-dev@ozlabs.org, Delvare <khali@linux-fr.org>, Johannes Berg <johannes@sipsolutions.net>, Jean@alsa-project.org


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/hwmon/ams/ams.h       |    2 +-
 sound/aoa/soundbus/soundbus.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

These are the last two users of asm/of_device.h.  If everyone is happy,
we can put this through the powerpc tree.  I have build tested for
ppc64_defconfig and ppc6xx_defconfig (which uses the relevant drivers).

After this we can remove the include of linux/of_device.h from
asm/of_device.h

diff --git a/drivers/hwmon/ams/ams.h b/drivers/hwmon/ams/ams.h
index a6221e5..221ef69 100644
--- a/drivers/hwmon/ams/ams.h
+++ b/drivers/hwmon/ams/ams.h
@@ -4,7 +4,7 @@
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
-#include <asm/of_device.h>
+#include <linux/of_device.h>
 
 enum ams_irq {
 	AMS_IRQ_FREEFALL = 0x01,
diff --git a/sound/aoa/soundbus/soundbus.h b/sound/aoa/soundbus/soundbus.h
index 622cd37..a0f223c 100644
--- a/sound/aoa/soundbus/soundbus.h
+++ b/sound/aoa/soundbus/soundbus.h
@@ -8,7 +8,7 @@
 #ifndef __SOUNDBUS_H
 #define __SOUNDBUS_H
 
-#include <asm/of_device.h>
+#include <linux/of_device.h>
 #include <sound/pcm.h>
 #include <linux/list.h>
 
-- 
1.5.6.3

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
