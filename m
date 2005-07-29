From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 29 Jul 2005 20:52:30 +0000
Subject: [lm-sensors] [PATCH 2.6] hwmon: lm85: trivial cleanups
Message-Id: <20050729205154.4cc9a9f7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg, all,

Remove an unused macro and an outdated comment from the lm85 driver.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/hwmon/lm85.c |    9 ---------
 1 files changed, 9 deletions(-)

--- linux-2.6.13-rc3.orig/drivers/hwmon/lm85.c	2005-07-29 19:50:36.000000000 +0200
+++ linux-2.6.13-rc3/drivers/hwmon/lm85.c	2005-07-29 19:50:56.000000000 +0200
@@ -282,15 +282,6 @@
 #define PPR_TO_REG(val,fan) (SENSORS_LIMIT((val)-1,0,3)<<(fan *2))
 #define PPR_FROM_REG(val,fan) ((((val)>>(fan * 2))&0x03)+1)
 
-/* i2c-vid.h defines vid_from_reg() */
-#define VID_FROM_REG(val,vrm) (vid_from_reg((val),(vrm)))
-
-/* Unlike some other drivers we DO NOT set initial limits.  Use
- * the config file to set limits.  Some users have reported
- * motherboards shutting down when we set limits in a previous
- * version of the driver.
- */
-
 /* Chip sampling rates
  *
  * Some sensors are not updated more frequently than once per second


-- 
Jean Delvare
