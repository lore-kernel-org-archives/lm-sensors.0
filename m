From: joe@perches.com
Date: Mon, 13 Aug 2007 06:39:30 +0000
Subject: [lm-sensors] [PATCH] [535/2many] MAINTAINERS - VT1211 HARDWARE
Message-Id: <46bffca2.MZVCmUtcDSpkWn9z%joe@perches.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, juergh@gmail.com, akpm@linux-foundation.org

Add file pattern to MAINTAINER entry

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index 25bc39a..52b7742 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5056,6 +5056,8 @@ P:	Juerg Haefliger
 M:	juergh@gmail.com
 L:	lm-sensors@lm-sensors.org
 S:	Maintained
+F:	Documentation/hwmon/vt1211
+F:	drivers/hwmon/vt1211.c
 
 VT8231 HARDWARE MONITOR DRIVER
 P:	Roger Lucas

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
