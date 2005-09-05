From: gregkh@suse.de (Greg KH)
Date: Mon, 05 Sep 2005 23:47:33 +0000
Subject: [lm-sensors] [PATCH] hwmon: lm85: trivial cleanups
Message-Id: <11259567683582@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] hwmon: lm85: trivial cleanups

Remove an unused macro and an outdated comment from the lm85 driver.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 5cb802293e87035920d47979107af8cf42a2f62a
tree f543daa9379e4ddfbf1de92283680d3c49ee69e5
parent 53ae11b08353268c4012ef107bf205a0724d71aa
author Jean Delvare <khali@linux-fr.org> Fri, 29 Jul 2005 20:51:54 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 05 Sep 2005 09:14:17 -0700

 drivers/hwmon/lm85.c |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
--- a/drivers/hwmon/lm85.c
+++ b/drivers/hwmon/lm85.c
@@ -282,15 +282,6 @@ static int ZONE_TO_REG( int zone )
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

