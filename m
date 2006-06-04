From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 04 Jun 2006 18:13:01 +0000
Subject: [lm-sensors] [PATCH 06/11] hwmon: Drop some maintainers entries
Message-Id: <20060604201301.0bc5da17.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=hwmon-maintenance-update.patch

I no more wish to be listed as the maintainer for the smsc47m1 and
w83l785ts drivers. I have no test device, and people will fallback
to me as the general hardware monitoring maintainer anyway.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 MAINTAINERS |   12 ------------
 1 file changed, 12 deletions(-)

--- linux-2.6.17-rc5.orig/MAINTAINERS	2006-06-04 09:33:13.000000000 +0200
+++ linux-2.6.17-rc5/MAINTAINERS	2006-06-04 09:46:07.000000000 +0200
@@ -2499,12 +2499,6 @@
 W:	http://www.winischhofer.at/linuxsisusbvga.shtml
 S:	Maintained
 
-SMSC47M1 HARDWARE MONITOR DRIVER
-P:	Jean Delvare
-M:	khali at linux-fr.org
-L:	lm-sensors at lm-sensors.org
-S:	Odd Fixes
-
 SMB FILESYSTEM
 P:	Urban Widmark
 M:	urban at teststation.com
@@ -3117,12 +3111,6 @@
 W:	http://projects.drzeus.cx/wbsd
 S:	Maintained
 
-W83L785TS HARDWARE MONITOR DRIVER
-P:	Jean Delvare
-M:	khali at linux-fr.org
-L:	lm-sensors at lm-sensors.org
-S:	Odd Fixes
-
 WATCHDOG DEVICE DRIVERS
 P:	Wim Van Sebroeck
 M:	wim at iguana.be

-- 
Jean Delvare

