From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Date: Thu, 22 Jan 2015 22:44:14 +0000
Subject: [lm-sensors] [PATCH 2/2] drivers/hwmon/adc128d818.c: Do proper sign extension
Message-Id: <1421966655-16188-2-git-send-email-linux@rasmusvillemoes.dk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1421966655-16188-1-git-send-email-linux@rasmusvillemoes.dk>
In-Reply-To: <1421966655-16188-1-git-send-email-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

data->temp[index] has type s16. Because of C's promotion rules,
(data->temp[index] << 7) >> 7 is exactly the same as
data->temp[index]. The intention was to use bit 8 as a sign bit, so do
that using the existing API.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/hwmon/adc128d818.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/adc128d818.c b/drivers/hwmon/adc128d818.c
index 0625e50d7a6e..ad2b47e40345 100644
--- a/drivers/hwmon/adc128d818.c
+++ b/drivers/hwmon/adc128d818.c
@@ -27,6 +27,7 @@
 #include <linux/err.h>
 #include <linux/regulator/consumer.h>
 #include <linux/mutex.h>
+#include <linux/bitops.h>
 
 /* Addresses to scan
  * The chip also supports addresses 0x35..0x37. Don't scan those addresses
@@ -189,7 +190,7 @@ static ssize_t adc128_show_temp(struct device *dev,
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
-	temp = (data->temp[index] << 7) >> 7;	/* sign extend */
+	temp = sign_extend32(data->temp[index], 8);
 	return sprintf(buf, "%d\n", temp * 500);/* 0.5 degrees C resolution */
 }
 
-- 
2.1.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
