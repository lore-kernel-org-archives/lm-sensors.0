From: Axel Lin <axel.lin@ingics.com>
Date: Sat, 19 Jul 2014 03:42:50 +0000
Subject: [lm-sensors] [PATCH 4/4] hwmon: (smsc47m192) Use DIV_ROUND_CLOSEST to simplify implementation for SC
Message-Id: <1405741370.13406.8.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/smsc47m192.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/hwmon/smsc47m192.c b/drivers/hwmon/smsc47m192.c
index 5c59f8b..380e277 100644
--- a/drivers/hwmon/smsc47m192.c
+++ b/drivers/hwmon/smsc47m192.c
@@ -59,10 +59,7 @@ static u8 SMSC47M192_REG_TEMP_MIN[3] =	{ 0x3A, 0x38, 0x59 };
 /* generalised scaling with integer rounding */
 static inline int SCALE(long val, int mul, int div)
 {
-	if (val < 0)
-		return (val * mul - div / 2) / div;
-	else
-		return (val * mul + div / 2) / div;
+	return DIV_ROUND_CLOSEST(val * mul, div);
 }
 
 /* Conversions */
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
