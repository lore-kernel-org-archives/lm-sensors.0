From: joe@perches.com
Date: Mon, 13 Aug 2007 06:39:36 +0000
Subject: [lm-sensors] [PATCH] [538/2many] MAINTAINERS - W83793 HARDWARE
Message-Id: <46bffca8.KnIBclsJw5/Ay0TK%joe@perches.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org, r.marek@assembler.cz, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org

Add file pattern to MAINTAINER entry

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index 4e7906f..dcbcd74 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5086,6 +5086,8 @@ P:	Rudolf Marek
 M:	r.marek@assembler.cz
 L:	lm-sensors@lm-sensors.org
 S:	Maintained
+F:	Documentation/hwmon/w83793
+F:	drivers/hwmon/w83793.c
 
 W83L51xD SD/MMC CARD INTERFACE DRIVER
 P:	Pierre Ossman

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
