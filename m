From: joe@perches.com
Date: Mon, 13 Aug 2007 06:33:33 +0000
Subject: [lm-sensors] [PATCH] [366/2many] MAINTAINERS - PC87360 HARDWARE
Message-Id: <46bffb3d./BjKtJyDtveL1fJQ%joe@perches.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, jim.cromie@gmail.com, akpm@linux-foundation.org

Add file pattern to MAINTAINER entry

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index 44768ce..2eb1a7c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3528,6 +3528,8 @@ P:	Jim Cromie
 M:	jim.cromie@gmail.com
 L:	lm-sensors@lm-sensors.org
 S:	Maintained
+F:	Documentation/hwmon/pc87360
+F:	drivers/hwmon/pc87360.c
 
 PC8736x GPIO DRIVER
 P:	Jim Cromie

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
