From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 19 Dec 2012 14:40:15 +0000
Subject: [lm-sensors] [PATCH v2] linux/kernel.h: Fix DIV_ROUND_CLOSEST with unsigned divisors
Message-Id: <1355928015-26212-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, lm-sensors@lm-sensors.org, Juergen Beisert <jbe@pengutronix.de>, Guenter Roeck <linux@roeck-us.net>, Jean Delvare <khali@linux-fr.org>

Commit 263a523 fixes a warning seen with W=1 due to change in
DIV_ROUND_CLOSEST. Unfortunately, the C compiler converts divide operations
with unsigned divisors to unsigned, even if the dividend is signed and
negative (for example, -10 / 5U = 858993457). The C standard says "If one
operand has unsigned int type, the other operand is converted to unsigned
int", so the compiler is not to blame.
As a result, DIV_ROUND_CLOSEST(0, 2U) and similar operations now return
bad values, since the automatic conversion of expressions such as "0 - 2U/2"
to unsigned was not taken into account.

Fix by checking for the divisor variable type when deciding which operation
to perform. This fixes DIV_ROUND_CLOSEST(0, 2U), but still returns bad values
for negative dividends divided by unsigned divisors. Mark the latter case as
unsupported.

Reported-by: Juergen Beisert <jbe@pengutronix.de>
Tested-by: Juergen Beisert <jbe@pengutronix.de>
Cc: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Description update (v1 wasn't supposed to make it to lkml)

 include/linux/kernel.h |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index d97ed58..45726dc 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -77,13 +77,15 @@
 
 /*
  * Divide positive or negative dividend by positive divisor and round
- * to closest integer. Result is undefined for negative divisors.
+ * to closest integer. Result is undefined for negative divisors and
+ * for negative dividends if the divisor variable type is unsigned.
  */
 #define DIV_ROUND_CLOSEST(x, divisor)(			\
 {							\
 	typeof(x) __x = x;				\
 	typeof(divisor) __d = divisor;			\
-	(((typeof(x))-1) > 0 || (__x) > 0) ?		\
+	(((typeof(x))-1) > 0 ||				\
+	 ((typeof(divisor))-1) > 0 || (__x) > 0) ?	\
 		(((__x) + ((__d) / 2)) / (__d)) :	\
 		(((__x) - ((__d) / 2)) / (__d));	\
 }							\
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
