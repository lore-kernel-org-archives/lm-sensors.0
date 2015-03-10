From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Tue, 10 Mar 2015 17:27:19 +0000
Subject: [lm-sensors] [PATCH v2 1/4] kernel.h: add find_closest() macro
Message-Id: <1426008442-26236-2-git-send-email-bgolaszewski@baylibre.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1426008442-26236-1-git-send-email-bgolaszewski@baylibre.com>
In-Reply-To: <1426008442-26236-1-git-send-email-bgolaszewski@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, lm-sensors <lm-sensors@lm-sensors.org>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <srostedt@redhat.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>

Searching for the member of an array closest to 'x' is
duplicated in several places.

Add two macros that implement this algorithm for arrays
sorted both in ascending and descending order.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/kernel.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index d6d630d..f4294da 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -116,6 +116,29 @@
 }							\
 )
 
+#define __find_closest(x, a, as, op)(					\
+{									\
+	typeof(as) _i, _as = (as) - 1;					\
+	typeof(x) _x = (x);						\
+	typeof(*a) *_a = (a);						\
+	for (_i = 0; _i < _as; _i++) {					\
+		if (_x op DIV_ROUND_CLOSEST(_a[_i] + _a[_i + 1], 2))	\
+			break;						\
+	}								\
+	(_i);								\
+}									\
+)
+
+/*
+ * Given an array 'a' (sorted in ascending order) of size 'as' return
+ * the index of the element in that array closest to 'x'.
+ */
+#define find_closest(x, a, as) __find_closest(x, a, as, <=)
+/*
+ * Similar to find_closest(), but 'a' is expected to be sorted
+ * in descending order.
+ */
+#define find_closest_desc(x, a, as) __find_closest(x, a, as, >)
 
 #define _RET_IP_		(unsigned long)__builtin_return_address(0)
 #define _THIS_IP_  ({ __label__ __here; __here: (unsigned long)&&__here; })
-- 
2.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
