From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 01 Mar 2013 22:48:44 +0000
Subject: [lm-sensors] [PATCH] lib/smbus.c: Include stddef.h to fix build error
Message-Id: <1362178124-2796-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

lib/smbus.c fails to build since NULL is undefined.

Reported-by: Tobias Simon <tobias.simon@tu-ilmenau.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 CHANGES     |    1 +
 lib/smbus.c |    1 +
 2 files changed, 2 insertions(+)

diff --git a/CHANGES b/CHANGES
index 734d030..42573c0 100644
--- a/CHANGES
+++ b/CHANGES
@@ -21,6 +21,7 @@ SVN HEAD
   library: New libi2c library
            Properly propagate real error codes on read errors
            Use I2C_SMBUS_BLOCK_MAX instead of hard-coding 32
+  lib/smbus.c: Add missing include which was causing a build error
 
 3.1.0 (2011-12-04)
   decode-dimms: Decode module configuration type of DDR SDRAM
diff --git a/lib/smbus.c b/lib/smbus.c
index 6108fe6..d23ecff 100644
--- a/lib/smbus.c
+++ b/lib/smbus.c
@@ -22,6 +22,7 @@
 */
 
 #include <errno.h>
+#include <stddef.h>
 #include <i2c/smbus.h>
 #include <sys/ioctl.h>
 #include <linux/types.h>
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
