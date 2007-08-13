From: joe@perches.com
Date: Mon, 13 Aug 2007 06:27:26 +0000
Subject: [lm-sensors] [PATCH] [189/2many] MAINTAINERS - F71805F HARDWARE
Message-Id: <46bff9ce.q5IFWhx41NPHIs5g%joe@perches.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, khali@linux-fr.org, akpm@linux-foundation.org

Add file pattern to MAINTAINER entry

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index 992a314..73ce5d8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1824,6 +1824,8 @@ P:	Jean Delvare
 M:	khali@linux-fr.org
 L:	lm-sensors@lm-sensors.org
 S:	Maintained
+F:	Documentation/hwmon/f71805f
+F:	drivers/hwmon/f71805f.c
 
 FARSYNC SYNCHRONOUS DRIVER
 P:	Kevin Curtis

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
