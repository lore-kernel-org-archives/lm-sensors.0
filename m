From: greg@kroah.com (Greg KH)
Date: Thu, 22 Jun 2006 18:27:50 +0000
Subject: [lm-sensors] [PATCH 24/44] [PATCH] hwmon: Drop some maintainers
Message-Id: <11510009793506-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali at linux-fr.org>

I no more wish to be listed as the maintainer for the smsc47m1 and
w83l785ts drivers. I have no test device, and people will fallback
to me as the general hardware monitoring maintainer anyway.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 MAINTAINERS |   12 ------------
 1 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d10e629..58d181d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2528,12 +2528,6 @@ M:	thomas at winischhofer.net
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
@@ -3146,12 +3140,6 @@ L:	wbsd-devel at list.drzeus.cx
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
1.4.0


