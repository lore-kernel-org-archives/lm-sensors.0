From: joe@perches.com
Date: Mon, 13 Aug 2007 06:23:39 +0000
Subject: [lm-sensors] [PATCH] [72/2many] MAINTAINERS - ASUS ASB100 HARDWARE
Message-Id: <46bff8eb.i5dgFSy2ayFkYfzx%joe@perches.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org, mhoffman@lightlink.com, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org

Add file pattern to MAINTAINER entry

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index 622a600..a165698 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -716,6 +716,7 @@ P:	Mark M. Hoffman
 M:	mhoffman@lightlink.com
 L:	lm-sensors@lm-sensors.org
 S:	Maintained
+F:	drivers/hwmon/asb100.c
 
 ASUS LAPTOP EXTRAS DRIVER
 P:	Corentin Chary

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
