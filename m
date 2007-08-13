From: joe@perches.com
Date: Mon, 13 Aug 2007 06:31:24 +0000
Subject: [lm-sensors] [PATCH] [299/2many] MAINTAINERS - LM83 HARDWARE
Message-Id: <46bffabc.mTwaAX+B+2q9aT7n%joe@perches.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, khali@linux-fr.org, akpm@linux-foundation.org

Add file pattern to MAINTAINER entry

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index 36c4960..9a65d56 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2874,6 +2874,8 @@ P:	Jean Delvare
 M:	khali@linux-fr.org
 L:	lm-sensors@lm-sensors.org
 S:	Maintained
+F:	Documentation/hwmon/lm83
+F:	drivers/hwmon/lm83.c
 
 LM90 HARDWARE MONITOR DRIVER
 P:	Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
