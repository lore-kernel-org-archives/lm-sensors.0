From: joe@perches.com
Date: Mon, 13 Aug 2007 06:31:26 +0000
Subject: [lm-sensors] [PATCH] [300/2many] MAINTAINERS - LM90 HARDWARE
Message-Id: <46bffabe.ezGWPX+Et/7FTcVC%joe@perches.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, khali@linux-fr.org, akpm@linux-foundation.org

Add file pattern to MAINTAINER entry

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index 9a65d56..be709c1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2882,6 +2882,8 @@ P:	Jean Delvare
 M:	khali@linux-fr.org
 L:	lm-sensors@lm-sensors.org
 S:	Maintained
+F:	Documentation/hwmon/lm90
+F:	drivers/hwmon/lm90.c
 
 LOGICAL DISK MANAGER SUPPORT (LDM, Windows 2000/XP/Vista Dynamic Disks)
 P:	Richard Russon (FlatCap)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
