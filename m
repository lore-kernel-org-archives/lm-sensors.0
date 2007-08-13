From: joe@perches.com
Date: Mon, 13 Aug 2007 06:21:55 +0000
Subject: [lm-sensors] [PATCH] [17/2many] MAINTAINERS - ABIT UGURU HARDWARE
Message-Id: <46bff883.o9E4xFtxERfeWZpB%joe@perches.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, j.w.r.degoede@hhs.nl, akpm@linux-foundation.org

Add file pattern to MAINTAINER entry

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index 2de2083..909875d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -209,6 +209,7 @@ P:	Hans de Goede
 M:	j.w.r.degoede@hhs.nl
 L:	lm-sensors@lm-sensors.org
 S:	Maintained
+F:	drivers/hwmon/abitguru*
 
 ACENIC DRIVER
 P:	Jes Sorensen

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
