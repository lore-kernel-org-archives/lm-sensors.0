From: Dirk Eibach <eibach@gdsys.de>
Date: Thu, 03 Mar 2011 08:46:42 +0000
Subject: [lm-sensors] [PATCH] hwmon: (ads1015) Add MAINTAINERS entry
Message-Id: <1299142002-13080-1-git-send-email-eibach@gdsys.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Dirk Eibach <eibach@gdsys.de>
---
 MAINTAINERS |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 531c5cf..6c999e3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -365,6 +365,14 @@ W:	http://wiki-analog.com/ADP8860
 S:	Supported
 F:	drivers/video/backlight/adp8860_bl.c
 
+ADS1015 HARDWARE MONITOR DRIVER
+M:	Dirk Eibach <eibach@gdsys.de>
+L:	lm-sensors@lm-sensors.org
+S:	Maintained
+F:	Documentation/hwmon/ads1015
+F:	drivers/hwmon/ads1015.c
+F:	include/linux/i2c/ads1015.h
+
 ADT746X FAN DRIVER
 M:	Colin Leroy <colin@colino.net>
 S:	Maintained
-- 
1.5.6.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
