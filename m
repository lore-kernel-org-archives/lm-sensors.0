From: Axel Lin <axel.lin@ingics.com>
Date: Sat, 19 Jul 2014 03:37:59 +0000
Subject: [lm-sensors] [PATCH 1/4] hwmon: (adm1026) Use DIV_ROUND_CLOSEST to simplify implementation for SCALE
Message-Id: <1405741079.13406.2.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/adm1026.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/adm1026.c b/drivers/hwmon/adm1026.c
index ca8430f..c632e46 100644
--- a/drivers/hwmon/adm1026.c
+++ b/drivers/hwmon/adm1026.c
@@ -196,7 +196,7 @@ static int adm1026_scaling[] = { /* .001 Volts */
 		3330, 4995, 2250, 12000, 13875
 	};
 #define NEG12_OFFSET  16000
-#define SCALE(val, from, to) (((val)*(to) + ((from)/2))/(from))
+#define SCALE(val, from, to) DIV_ROUND_CLOSEST((val) * (to), (from))
 #define INS_TO_REG(n, val)  (clamp_val(SCALE(val, adm1026_scaling[n], 192),\
 	0, 255))
 #define INS_FROM_REG(n, val) (SCALE(val, 192, adm1026_scaling[n]))
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
