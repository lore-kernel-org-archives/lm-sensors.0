From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 04 Jun 2006 18:10:55 +0000
Subject: [lm-sensors] [PATCH 05/11] hwmon: Fix a typo in the hdaps driver
Message-Id: <20060604201055.93571684.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=hwmon-hdaps-typo.patch

Fix a typo in the hdaps driver.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Cc: Robert Love <rlove at rlove.org>
---
 drivers/hwmon/hdaps.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.17-rc5.orig/drivers/hwmon/hdaps.c	2006-06-04 08:01:56.000000000 +0200
+++ linux-2.6.17-rc5/drivers/hwmon/hdaps.c	2006-06-04 09:34:42.000000000 +0200
@@ -41,7 +41,7 @@
 #define HDAPS_PORT_STATE	0x1611	/* device state */
 #define HDAPS_PORT_YPOS		0x1612	/* y-axis position */
 #define	HDAPS_PORT_XPOS		0x1614	/* x-axis position */
-#define HDAPS_PORT_TEMP1	0x1616	/* device temperature, in celcius */
+#define HDAPS_PORT_TEMP1	0x1616	/* device temperature, in Celsius */
 #define HDAPS_PORT_YVAR		0x1617	/* y-axis variance (what is this?) */
 #define HDAPS_PORT_XVAR		0x1619	/* x-axis variance (what is this?) */
 #define HDAPS_PORT_TEMP2	0x161b	/* device temperature (again?) */

-- 
Jean Delvare

