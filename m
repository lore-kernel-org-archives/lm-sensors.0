From: joe@perches.com
Date: Mon, 13 Aug 2007 06:30:33 +0000
Subject: [lm-sensors] [PATCH] [273/2many] MAINTAINERS - K8TEMP HARDWARE
Message-Id: <46bffa89.j/g6mQ6Nh5XoqFGH%joe@perches.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org, r.marek@assembler.cz, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org

Add file pattern to MAINTAINER entry

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index f0d1bce..3a9c079 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2614,6 +2614,8 @@ P:	Rudolf Marek
 M:	r.marek@assembler.cz
 L:	lm-sensors@lm-sensors.org
 S:	Maintained
+F:	Documentation/hwmon/k8temp
+F:	drivers/hwmon/k8temp.c
 
 KCONFIG
 P:	Roman Zippel

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
