From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 30 Jul 2014 03:52:29 +0000
Subject: [lm-sensors] [PATCH] hwmon: (lm78) Fix overflow problems seen when writing large limits
Message-Id: <1406692349-13923-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On platforms with sizeof(int) < sizeof(long), writing a temperature
limit larger than MAXINT will result in unpredictable limit values
written to the chip. Avoid auto-conversion from long to int to fix
the problem.

Cc: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm78.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/lm78.c b/drivers/hwmon/lm78.c
index 9efadfc..c1eb464f 100644
--- a/drivers/hwmon/lm78.c
+++ b/drivers/hwmon/lm78.c
@@ -108,7 +108,7 @@ static inline int FAN_FROM_REG(u8 val, int div)
  * TEMP: mC (-128C to +127C)
  * REG: 1C/bit, two's complement
  */
-static inline s8 TEMP_TO_REG(int val)
+static inline s8 TEMP_TO_REG(long val)
 {
 	int nval = clamp_val(val, -128000, 127000) ;
 	return nval < 0 ? (nval - 500) / 1000 : (nval + 500) / 1000;
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
