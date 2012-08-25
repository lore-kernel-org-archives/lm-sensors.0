From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 25 Aug 2012 00:53:17 +0000
Subject: [lm-sensors] [PATCH] kernel.h: Introduce IDIV_ROUND_CLOSEST
Message-Id: <1345855997-9408-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Pekka Enberg <penberg@kernel.org>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Jean Delvare <khali@linux-fr.org>, lm-sensors@lm-sensors.org, Guenter Roeck <linux@roeck-us.net>

DIV_ROUND_CLOSEST returns a bad result for negative dividends:
	DIV_ROUND_CLOSEST(-2, 2) = 0

Most of the time this does not matter. However, in the hardware monitoring
subsystem, it is often used on integers which can be negative (such as
temperatures). Introduce new macro IDIV_ROUND_CLOSEST which also supports
negative dividends.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
I can take this patch through my hwmon tree, but would like to get an Ack first.
Alternative would be to put it into include/linux/hwmon.h, but I would prefer
to avoid that.

Also, if someone has an idea for a simpler implementation, I would really like
to know about it.

 include/linux/kernel.h |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 6043821..a89483c 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -89,6 +89,15 @@
 }							\
 )
 
+#define IDIV_ROUND_CLOSEST(x, divisor)(			\
+{							\
+	typeof(x) __x = x;				\
+	typeof(divisor) __d1 = divisor;			\
+	typeof(divisor) __d2 = (__x) < 0 ? -(__d1) : (__d1);\
+	(((__x) + ((__d2) / 2)) / (__d1));		\
+}							\
+)
+
 /*
  * Multiplies an integer by a fraction, while avoiding unnecessary
  * overflow or loss of precision.
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
