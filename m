From: Jean Delvare <jdelvare@suse.de>
Date: Mon, 26 Aug 2019 08:10:04 +0000
Subject: [PATCH] libsensors: Prevent warning with glibc >= 2.20
Message-Id: <20190826101004.223ffb25@endymion>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Since glibc 2.20, the usage of _BSD_SOURCE is deprecated. Fix it like
described here:

https://sourceware.org/glibc/wiki/Release/2.20#Deprecation_of__BSD_SOURCE_and__SVID_SOURCE_feature_macros

Inspired from a similar patch by Wolfram Sang for i2c-tools.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
---
 lib/init.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- lm-sensors.orig/lib/init.c	2016-08-03 13:25:00.101098040 +0200
+++ lm-sensors/lib/init.c	2016-08-03 13:25:12.934237590 +0200
@@ -20,7 +20,8 @@
 */
 
 /* Needed for scandir() and alphasort() */
-#define _BSD_SOURCE
+#define _BSD_SOURCE 1 /* for glibc < 2.19 */
+#define _DEFAULT_SOURCE 1 /* for glibc >= 2.19 */
 
 #include <sys/types.h>
 #include <sys/stat.h>


-- 
Jean Delvare
SUSE L3 Support
