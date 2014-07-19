From: Axel Lin <axel.lin@ingics.com>
Date: Sat, 19 Jul 2014 03:41:37 +0000
Subject: [lm-sensors] [PATCH 3/4] hwmon: (lm85) Use DIV_ROUND_CLOSEST to simplify implementation for SCALE
Message-Id: <1405741297.13406.6.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/lm85.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
index b0129a5..9eb60db 100644
--- a/drivers/hwmon/lm85.c
+++ b/drivers/hwmon/lm85.c
@@ -133,7 +133,7 @@ static const int lm85_scaling[] = {  /* .001 Volts */
 	2500, 2250, 3300, 5000, 12000,
 	3300, 1500, 1800 /*EMC6D100*/
 };
-#define SCALE(val, from, to)	(((val) * (to) + ((from) / 2)) / (from))
+#define SCALE(val, from, to)	DIV_ROUND_CLOSEST((val) * (to), (from))
 
 #define INS_TO_REG(n, val)	\
 		clamp_val(SCALE(val, lm85_scaling[n], 192), 0, 255)
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
