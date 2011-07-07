From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 07 Jul 2011 14:11:03 +0000
Subject: [lm-sensors] [PATCH v2 2/3] hwmon: (lm95241) Fix negative
Message-Id: <1310047864-22691-3-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Negative temperatures were returned in degrees C instead of milli-Degrees C.
Fix by multiplying with 1000.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
Candidate for -stable.

 drivers/hwmon/lm95241.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/lm95241.c b/drivers/hwmon/lm95241.c
index 01c638e..4dcc770 100644
--- a/drivers/hwmon/lm95241.c
+++ b/drivers/hwmon/lm95241.c
@@ -101,7 +101,7 @@ struct lm95241_data {
 static int TempFromReg(u8 val_h, u8 val_l)
 {
 	if (val_h & 0x80)
-		return val_h - 0x100;
+		return (val_h - 0x100) * 1000;
 	return val_h * 1000 + val_l * 1000 / 256;
 }
 
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
