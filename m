From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 30 Jul 2014 10:35:01 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: (lm92) Prevent overflow problem when writing large limits
Message-Id: <1406716501.28163.3.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On platforms with sizeof(int) < sizeof(long), writing a temperature
limit larger than MAXINT will result in unpredictable limit values
written to the chip. Avoid auto-conversion from long to int to fix
the problem.

Also uses clamp_val to simplify the code a bit.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/lm92.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/lm92.c b/drivers/hwmon/lm92.c
index d2060e2..3dbced2 100644
--- a/drivers/hwmon/lm92.c
+++ b/drivers/hwmon/lm92.c
@@ -74,12 +74,9 @@ static inline int TEMP_FROM_REG(s16 reg)
 	return reg / 8 * 625 / 10;
 }
 
-static inline s16 TEMP_TO_REG(int val)
+static inline s16 TEMP_TO_REG(long val)
 {
-	if (val <= -60000)
-		return -60000 * 10 / 625 * 8;
-	if (val >= 160000)
-		return 160000 * 10 / 625 * 8;
+	val = clamp_val(val, -60000, 160000);
 	return val * 10 / 625 * 8;
 }
 
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
