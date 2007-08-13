From: joe@perches.com
Date: Mon, 13 Aug 2007 06:22:18 +0000
Subject: [lm-sensors] [PATCH] [29/2many] MAINTAINERS - ADM1025 HARDWARE
Message-Id: <46bff89a.xYL7oyBOdTr8eyH/%joe@perches.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, khali@linux-fr.org, akpm@linux-foundation.org

Add file pattern to MAINTAINER entry

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index 4faf1ce..91bc5cd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -307,6 +307,7 @@ P:	Jean Delvare
 M:	khali@linux-fr.org
 L:	lm-sensors@lm-sensors.org
 S:	Maintained
+F:	drivers/hwmon/adm1025.c
 
 ADM1029 HARDWARE MONITOR DRIVER
 P:	Corentin Labbe

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
