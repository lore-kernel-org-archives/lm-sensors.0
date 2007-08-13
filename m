From: joe@perches.com
Date: Mon, 13 Aug 2007 06:39:34 +0000
Subject: [lm-sensors] [PATCH] [537/2many] MAINTAINERS - W83791D HARDWARE
Message-Id: <46bffca6.C3ZDFVo2GLTkFeKl%joe@perches.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, bezaur@gmail.com, akpm@linux-foundation.org

Add file pattern to MAINTAINER entry

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index 3871621..4e7906f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5070,12 +5070,16 @@ W1 DALLAS'S 1-WIRE BUS
 P:	Evgeniy Polyakov
 M:	johnpol@2ka.mipt.ru
 S:	Maintained
+F:	Documentation/w1/
+F:	drivers/w1/
 
 W83791D HARDWARE MONITORING DRIVER
 P:	Charles Spirakis
 M:	bezaur@gmail.com
 L:	lm-sensors@lm-sensors.org
 S:	Maintained
+F:	Documentation/hwmon/w83791d
+F:	drivers/hwmon/w83791d.c
 
 W83793 HARDWARE MONITORING DRIVER
 P:	Rudolf Marek

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
