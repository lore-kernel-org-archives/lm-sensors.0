From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 02 Dec 2009 15:42:38 +0000
Subject: [lm-sensors] [PATCH 10/11] hwmon: (adt7475) Add an entry in
Message-Id: <20091202164238.3dcd7b35@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

As I've just done a lot of changes to the adt7475 driver, I volunteer
to maintain it for the year to come.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Jordan Crouse <jordan@cosmicpenguin.net>
Cc: "Darrick J. Wong" <djwong@us.ibm.com>
---
 MAINTAINERS |    7 +++++++
 1 file changed, 7 insertions(+)

--- linux-2.6.32-rc8.orig/MAINTAINERS	2009-12-02 11:17:10.000000000 +0100
+++ linux-2.6.32-rc8/MAINTAINERS	2009-12-02 15:18:50.000000000 +0100
@@ -327,6 +327,13 @@ M:	Colin Leroy <colin@colino.net>
 S:	Maintained
 F:	drivers/macintosh/therm_adt746x.c
 
+ADT7475 HARDWARE MONITOR DRIVER
+M:	Jean Delvare <khali@linux-fr.org>
+L:	lm-sensors@lm-sensors.org
+S:	Maintained
+F:	Documentation/hwmon/adt7475
+F:	drivers/hwmon/adt7475.c
+
 ADVANSYS SCSI DRIVER
 M:	Matthew Wilcox <matthew@wil.cx>
 L:	linux-scsi@vger.kernel.org

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
