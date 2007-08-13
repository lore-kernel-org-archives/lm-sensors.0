From: joe@perches.com
Date: Mon, 13 Aug 2007 06:25:36 +0000
Subject: [lm-sensors] [PATCH] [134/2many] MAINTAINERS - CORETEMP HARDWARE
Message-Id: <46bff960.WIP0LRYr3U/rYI1a%joe@perches.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org, r.marek@assembler.cz, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org

Add file pattern to MAINTAINER entry

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index d0a436a..a51b89e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1294,6 +1294,7 @@ P:	Rudolf Marek
 M:	r.marek@assembler.cz
 L:	lm-sensors@lm-sensors.org
 S:	Maintained
+F:	drivers/hwmon/coretemp.c
 
 COSA/SRP SYNC SERIAL DRIVER
 P:	Jan "Yenya" Kasprzak

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
