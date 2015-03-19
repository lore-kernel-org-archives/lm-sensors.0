From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Thu, 19 Mar 2015 17:27:42 +0000
Subject: [lm-sensors] [PATCH v4 2/5] documentation: update CodingStyle on local variables naming in macros
Message-Id: <1426786065-9798-3-git-send-email-bgolaszewski@baylibre.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1426786065-9798-1-git-send-email-bgolaszewski@baylibre.com>
In-Reply-To: <1426786065-9798-1-git-send-email-bgolaszewski@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, lm-sensors <lm-sensors@lm-sensors.org>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>

Describe proper naming convention for local variables in macros
resembling functions.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 Documentation/CodingStyle | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/CodingStyle b/Documentation/CodingStyle
index 449a8a1..4d4f06d 100644
--- a/Documentation/CodingStyle
+++ b/Documentation/CodingStyle
@@ -659,6 +659,19 @@ macros using parameters.
 #define CONSTANT 0x4000
 #define CONSTEXP (CONSTANT | 3)
 
+5) namespace collisions when defining local variables in macros resembling
+functions:
+
+#define FOO(x)				\
+({					\
+	typeof(x) ret;			\
+	ret = calc_ret(x);		\
+	(ret);				\
+)}
+
+ret is a common name for a local variable - __foo_ret is less likely
+to collide with an existing variable.
+
 The cpp manual deals with macros exhaustively. The gcc internals manual also
 covers RTL which is used frequently with assembly language in the kernel.
 
-- 
2.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
