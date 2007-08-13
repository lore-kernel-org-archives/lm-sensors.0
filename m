From: joe@perches.com
Date: Mon, 13 Aug 2007 06:26:27 +0000
Subject: [lm-sensors] [PATCH] [159/2many] MAINTAINERS - DME1737 HARDWARE
Message-Id: <46bff993.7OEwF3qQrioxyBDU%joe@perches.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, juergh@gmail.com, akpm@linux-foundation.org

Add file pattern to MAINTAINER entry

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index 70e5070..2fafb83 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1553,6 +1553,7 @@ P:	Juerg Haefliger
 M:	juergh@gmail.com
 L:	lm-sensors@lm-sensors.org
 S:	Maintained
+F:	drivers/hwmon/dme1737.c
 
 DOCBOOK FOR DOCUMENTATION
 P:	Randy Dunlap

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
