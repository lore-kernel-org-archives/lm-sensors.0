From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 19 Nov 2009 16:52:24 +0000
Subject: [lm-sensors] [PATCH] MAINTAINERS: Add missing hwmon files
Message-Id: <20091119175224.249d1924@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add missing documentation and header files to the hardware monitoring
subsystem section.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 MAINTAINERS |    2 ++
 1 file changed, 2 insertions(+)

--- linux-2.6.32-rc7.orig/MAINTAINERS	2009-11-19 13:06:02.000000000 +0100
+++ linux-2.6.32-rc7/MAINTAINERS	2009-11-19 17:20:20.000000000 +0100
@@ -2352,7 +2352,9 @@ HARDWARE MONITORING
 L:	lm-sensors@lm-sensors.org
 W:	http://www.lm-sensors.org/
 S:	Orphan
+F:	Documentation/hwmon/
 F:	drivers/hwmon/
+F:	include/linux/hwmon*.h
 
 HARDWARE RANDOM NUMBER GENERATOR CORE
 M:	Matt Mackall <mpm@selenic.com>


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
