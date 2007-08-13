From: joe@perches.com
Date: Mon, 13 Aug 2007 06:22:20 +0000
Subject: [lm-sensors] [PATCH] [30/2many] MAINTAINERS - ADM1029 HARDWARE
Message-Id: <46bff89c.FBiaofxrQB6NbVOc%joe@perches.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, corentin.labbe@geomatys.fr, akpm@linux-foundation.org

Add file pattern to MAINTAINER entry

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index 91bc5cd..641cebb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -314,6 +314,7 @@ P:	Corentin Labbe
 M:	corentin.labbe@geomatys.fr
 L:	lm-sensors@lm-sensors.org
 S:	Maintained
+F:	drivers/hwmon/adm1029.c
 
 ADT746X FAN DRIVER
 P:	Colin Leroy

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
