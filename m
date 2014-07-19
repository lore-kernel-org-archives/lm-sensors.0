From: Axel Lin <axel.lin@ingics.com>
Date: Sat, 19 Jul 2014 03:40:04 +0000
Subject: [lm-sensors] [PATCH 2/4] hwmon: (adm9240) Use DIV_ROUND_CLOSEST to simplify implementation for SCALE
Message-Id: <1405741204.13406.4.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/adm9240.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/hwmon/adm9240.c b/drivers/hwmon/adm9240.c
index 98114ce..6e75ff1 100644
--- a/drivers/hwmon/adm9240.c
+++ b/drivers/hwmon/adm9240.c
@@ -82,10 +82,7 @@ enum chips { adm9240, ds1780, lm81 };
 /* generalised scaling with integer rounding */
 static inline int SCALE(long val, int mul, int div)
 {
-	if (val < 0)
-		return (val * mul - div / 2) / div;
-	else
-		return (val * mul + div / 2) / div;
+	return DIV_ROUND_CLOSEST(val * mul, div);
 }
 
 /* adm9240 internally scales voltage measurements */
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
