From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 21 Jan 2010 14:07:38 +0000
Subject: [lm-sensors] [PATCH 8/8] hwmon: (it87) Add an entry in MAINTAINERS
Message-Id: <20100121150738.5e6de097@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali@linux-fr.org>

As I've just done a lot of changes to the it87 driver, I volunteer to
maintain it for the year to come.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 MAINTAINERS |    7 +++++++
 1 file changed, 7 insertions(+)

--- linux-2.6.33-rc4.orig/MAINTAINERS	2010-01-18 15:02:42.000000000 +0100
+++ linux-2.6.33-rc4/MAINTAINERS	2010-01-21 10:35:40.000000000 +0100
@@ -3010,6 +3010,13 @@ W:	http://www.melware.de
 S:	Maintained
 F:	drivers/isdn/hardware/eicon/
 
+IT87 HARDWARE MONITORING DRIVER
+M:	Jean Delvare <khali@linux-fr.org>
+L:	lm-sensors@lm-sensors.org
+S:	Maintained
+F:	Documentation/hwmon/it87
+F:	drivers/hwmon/it87.c
+
 IVTV VIDEO4LINUX DRIVER
 M:	Hans Verkuil <hverkuil@xs4all.nl>
 L:	ivtv-devel@ivtvdriver.org

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
