From: Axel Lin <axel.lin@ingics.com>
Date: Sat, 02 Aug 2014 02:14:47 +0000
Subject: [lm-sensors] [PATCH] hwmon: (dme1737) Prevent overflow problem when writing large limits
Message-Id: <1406945687.12632.1.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On platforms with sizeof(int) < sizeof(long), writing a temperature
limit larger than MAXINT will result in unpredictable limit values
written to the chip. Avoid auto-conversion from long to int to fix
the problem.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/dme1737.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/dme1737.c b/drivers/hwmon/dme1737.c
index 4ae3fff..e9cd1e2 100644
--- a/drivers/hwmon/dme1737.c
+++ b/drivers/hwmon/dme1737.c
@@ -293,7 +293,7 @@ static inline int TEMP_FROM_REG(int reg, int res)
 	return (reg * 1000) >> (res - 8);
 }
 
-static inline int TEMP_TO_REG(int val)
+static inline int TEMP_TO_REG(long val)
 {
 	return clamp_val((val < 0 ? val - 500 : val + 500) / 1000, -128, 127);
 }
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
