From: Zac Storer <zac.3.14159@gmail.com>
Date: Fri, 18 Nov 2011 08:15:58 +0000
Subject: [lm-sensors] [PATCH 33/33] Drivers: hwmon: adm1031: fixed a coding
Message-Id: <1321604158-13150-1-git-send-email-zac.3.14159@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: khali@linux-fr.org
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Zac Storer <zac.3.14159@gmail.com>

Fixed a coding style issue.

Signed-off-by: Zac Storer <zac.3.14159@gmail.com>
---
 drivers/hwmon/adm1031.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/adm1031.c b/drivers/hwmon/adm1031.c
index 04e2adc..6e80cf0 100644
--- a/drivers/hwmon/adm1031.c
+++ b/drivers/hwmon/adm1031.c
@@ -175,7 +175,7 @@ static int FAN_TO_REG(int reg, int div)
 
 #define AUTO_TEMP_MIN_TO_REG(val, reg)	\
 	((((val)/500) & 0xf8)|((reg) & 0x7))
-#define AUTO_TEMP_RANGE_FROM_REG(reg)	(5000 * (1<< ((reg)&0x7)))
+#define AUTO_TEMP_RANGE_FROM_REG(reg)	(5000 * (1 << ((reg)&0x7)))
 #define AUTO_TEMP_MIN_FROM_REG(reg)	(1000 * ((((reg) >> 3) & 0x1f) << 2))
 
 #define AUTO_TEMP_MIN_FROM_REG_DEG(reg)	((((reg) >> 3) & 0x1f) << 2)
-- 
1.7.7.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
