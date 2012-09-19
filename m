From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 19 Sep 2012 04:00:09 +0000
Subject: [lm-sensors] [PATCH] linux/kernel.h: Fix warning seen with W=1 due to change in DIV_ROUND_CLOSEST
Message-Id: <1348027209-29710-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Jean Delvare <khali@linux-fr.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, lm-sensors@lm-sensors.org, Guenter Roeck <linux@roeck-us.net>

After commit b6d86d3d (Fix DIV_ROUND_CLOSEST to support negative dividends),
the following warning is seen if the kernel is compiled with W=1 (-Wextra):

warning: comparison of unsigned expression >= 0 is always true

The warning is due to the test '((typeof(x))-1) >= 0', which is used to detect
if the variable type is unsigned. Research on the web suggests that the warning
disappears if '>' instead of '>=' is used for the comparison.

Tests after changing the macro along that line show that the warning is gone,
and that the result is still correct:

i=-4: DIV_ROUND_CLOSEST(i, 2)=-2
i=-3: DIV_ROUND_CLOSEST(i, 2)=-2
i=-2: DIV_ROUND_CLOSEST(i, 2)=-1
i=-1: DIV_ROUND_CLOSEST(i, 2)=-1
i=0: DIV_ROUND_CLOSEST(i, 2)=0
i=1: DIV_ROUND_CLOSEST(i, 2)=1
i=2: DIV_ROUND_CLOSEST(i, 2)=1
i=3: DIV_ROUND_CLOSEST(i, 2)=2
i=4: DIV_ROUND_CLOSEST(i, 2)=2

Code size is the same as before.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 include/linux/kernel.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 594b419..2451f1f 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -91,7 +91,7 @@
 {							\
 	typeof(x) __x = x;				\
 	typeof(divisor) __d = divisor;			\
-	(((typeof(x))-1) >= 0 || (__x) >= 0) ?		\
+	(((typeof(x))-1) > 0 || (__x) > 0) ?		\
 		(((__x) + ((__d) / 2)) / (__d)) :	\
 		(((__x) - ((__d) / 2)) / (__d));	\
 }							\
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
