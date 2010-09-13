From: "Jan Beulich" <JBeulich@novell.com>
Date: Mon, 13 Sep 2010 10:32:08 +0000
Subject: [lm-sensors] x86/hwmon: remove inclusion of unnecessary headers
Message-Id: <4C8E19C80200007800015B18@vpn.id2.novell.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: khali@linux-fr.org
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

These likely originate from these drivers being clones of one another
and/or other drivers which actually needed these includes.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

---
 drivers/hwmon/coretemp.c    |    1 -
 drivers/hwmon/pkgtemp.c     |    1 -
 drivers/hwmon/via-cputemp.c |    2 --
 3 files changed, 4 deletions(-)

--- linux-2.6.36-rc4/drivers/hwmon/coretemp.c	2010-09-13 08:45:02.000000000 +0200
+++ 2.6.36-rc4-x86-hwmon-no-delay-h/drivers/hwmon/coretemp.c	2010-09-03 17:54:14.000000000 +0200
@@ -21,7 +21,6 @@
  */
 
 #include <linux/module.h>
-#include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/jiffies.h>
--- linux-2.6.36-rc4/drivers/hwmon/pkgtemp.c	2010-09-13 08:45:03.000000000 +0200
+++ 2.6.36-rc4-x86-hwmon-no-delay-h/drivers/hwmon/pkgtemp.c	2010-09-03 17:54:30.000000000 +0200
@@ -21,7 +21,6 @@
  */
 
 #include <linux/module.h>
-#include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/jiffies.h>
--- linux-2.6.36-rc4/drivers/hwmon/via-cputemp.c	2010-09-13 08:45:03.000000000 +0200
+++ 2.6.36-rc4-x86-hwmon-no-delay-h/drivers/hwmon/via-cputemp.c	2010-09-13 00:00:00.000000000 +0200
@@ -22,10 +22,8 @@
  */
 
 #include <linux/module.h>
-#include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/slab.h>
-#include <linux/jiffies.h>
 #include <linux/hwmon.h>
 #include <linux/sysfs.h>
 #include <linux/hwmon-sysfs.h>




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
