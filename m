From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 28 Aug 2011 20:34:05 +0000
Subject: [lm-sensors] [PATCH] hwmon: (max16065) Fix current calculation
Message-Id: <1314563645-12021-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Current calculation is completely wrong. Add missing brackets to fix it.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
Candidate for stable (2.6.39+).

 drivers/hwmon/max16065.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/max16065.c b/drivers/hwmon/max16065.c
index d94a24f..dd2d7b9 100644
--- a/drivers/hwmon/max16065.c
+++ b/drivers/hwmon/max16065.c
@@ -124,7 +124,7 @@ static inline int MV_TO_LIMIT(int mv, int range)
 
 static inline int ADC_TO_CURR(int adc, int gain)
 {
-	return adc * 1400000 / gain * 255;
+	return adc * 1400000 / (gain * 255);
 }
 
 /*
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
