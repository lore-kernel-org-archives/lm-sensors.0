From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 05 Jul 2011 14:36:32 +0000
Subject: [lm-sensors] [PATCH] hwmon: (lm95241) Fix negative temperature
Message-Id: <1309876592-24015-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Negative temperatures were returned in degrees C instead of milli-Degrees C.
Fix by multiplying with 1000.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/lm95241.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/lm95241.c b/drivers/hwmon/lm95241.c
index f2cfecf..d1bbdf8 100644
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
