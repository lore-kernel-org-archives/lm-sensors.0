From: greg@kroah.com (Greg KH)
Date: Thu, 22 Jun 2006 18:27:49 +0000
Subject: [lm-sensors] [PATCH 23/44] [PATCH] hwmon: Fix a typo in the hdaps
Message-Id: <11510009701160-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali at linux-fr.org>

Fix a typo in the hdaps driver.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Acked-by: Robert Love <rml at novell.com>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 drivers/hwmon/hdaps.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/hdaps.c b/drivers/hwmon/hdaps.c
index 7841fa0..42b6328 100644
--- a/drivers/hwmon/hdaps.c
+++ b/drivers/hwmon/hdaps.c
@@ -41,7 +41,7 @@ #define HDAPS_NR_PORTS		0x30	/* number o
 #define HDAPS_PORT_STATE	0x1611	/* device state */
 #define HDAPS_PORT_YPOS		0x1612	/* y-axis position */
 #define	HDAPS_PORT_XPOS		0x1614	/* x-axis position */
-#define HDAPS_PORT_TEMP1	0x1616	/* device temperature, in celcius */
+#define HDAPS_PORT_TEMP1	0x1616	/* device temperature, in Celsius */
 #define HDAPS_PORT_YVAR		0x1617	/* y-axis variance (what is this?) */
 #define HDAPS_PORT_XVAR		0x1619	/* x-axis variance (what is this?) */
 #define HDAPS_PORT_TEMP2	0x161b	/* device temperature (again?) */
-- 
1.4.0


