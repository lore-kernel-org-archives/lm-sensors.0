From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 09 Jun 2005 18:57:56 +0000
Subject: [lm-sensors] More archs need to include hwmon/Kconfig
Message-Id: <20050609185703.78784b2f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg, Mark, all,

In 2.6.12-mm6-rc1 there is a fixup patch to have hwmon/Kconfig included
on arch/sparc64:

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc6/2.6.12-rc6-mm1/broken-out/gregkh-i2c-hwmon-02-sparc64-fix.patch

A quick search shows that arm and h3800 would need the same fix.

Additionally, until the hardware monitoring drivers are actually moved
from drivers/i2c/chips to drivers/hwmon, hwmon/Kconfig should be
included before i2c/Kconfig (not correct on sparc64 ATM). We will have
to swap them when moving the drivers.

A replacement patch follows.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.6.12-rc6/arch/arm/Kconfig.orig	Wed Jun  8 09:47:43 2005
+++ linux-2.6.12-rc6/arch/arm/Kconfig	Wed Jun  8 09:54:39 2005
@@ -715,6 +715,10 @@
 
 source "drivers/char/Kconfig"
 
+# hwmon before i2c - i2c/chips depends on it.
+
+source "drivers/hwmon/Kconfig"
+
 source "drivers/i2c/Kconfig"
 
 #source "drivers/l3/Kconfig"
--- linux-2.6.12-rc6/arch/h8300/Kconfig.orig	Wed Jun  8 09:22:26 2005
+++ linux-2.6.12-rc6/arch/h8300/Kconfig	Wed Jun  8 10:06:15 2005
@@ -177,6 +177,10 @@
 
 source "drivers/serial/Kconfig"
 
+# hwmon before i2c - i2c/chips depends on it.
+
+source "drivers/hwmon/Kconfig"
+
 source "drivers/i2c/Kconfig"
 
 source "drivers/usb/Kconfig"
--- linux-2.6.12-rc6/arch/sparc64/Kconfig.orig	Wed Jun  8 10:27:54 2005
+++ linux-2.6.12-rc6/arch/sparc64/Kconfig	Wed Jun  8 10:29:00 2005
@@ -608,6 +608,10 @@
 
 source "drivers/input/Kconfig"
 
+# hwmon before i2c - i2c/chips depends on it.
+
+source "drivers/hwmon/Kconfig"
+
 source "drivers/i2c/Kconfig"
 
 source "fs/Kconfig"

-- 
Jean Delvare
