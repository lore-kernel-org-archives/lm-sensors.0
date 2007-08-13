From: joe@perches.com
Date: Mon, 13 Aug 2007 06:28:20 +0000
Subject: [lm-sensors] [PATCH] [210/2many] MAINTAINERS - HARDWARE MONITORING
Message-Id: <46bffa04.JW3S0ykNGAQACMv1%joe@perches.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org, mhoffman@lightlink.com, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org

Add file pattern to MAINTAINER entry

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index e35e29c..f422277 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2015,6 +2015,7 @@ L:	lm-sensors@lm-sensors.org
 W:	http://www.lm-sensors.org/
 T:	git lm-sensors.org:/kernel/mhoffman/hwmon-2.6.git
 S:	Maintained
+F:	drivers/hwmon/
 
 HARDWARE RANDOM NUMBER GENERATOR CORE
 P:	Michael Buesch

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
