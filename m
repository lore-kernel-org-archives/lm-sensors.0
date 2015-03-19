From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Thu, 19 Mar 2015 14:30:20 +0000
Subject: [lm-sensors] [PATCH v3 4/4] hwmon: (w83795) use find_closest_descending() in pwm_freq_to_reg()
Message-Id: <1426775420-31350-5-git-send-email-bgolaszewski@baylibre.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1426775420-31350-1-git-send-email-bgolaszewski@baylibre.com>
In-Reply-To: <1426775420-31350-1-git-send-email-bgolaszewski@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, lm-sensors <lm-sensors@lm-sensors.org>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <srostedt@redhat.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>

Replace the loop iterating over pwm_freq_cksel0 with a call to
find_closest_descending().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/hwmon/w83795.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/w83795.c b/drivers/hwmon/w83795.c
index 2189413..49276bb 100644
--- a/drivers/hwmon/w83795.c
+++ b/drivers/hwmon/w83795.c
@@ -35,6 +35,7 @@
 #include <linux/err.h>
 #include <linux/mutex.h>
 #include <linux/jiffies.h>
+#include <linux/util_macros.h>
 
 /* Addresses to scan */
 static const unsigned short normal_i2c[] = {
@@ -308,11 +309,8 @@ static u8 pwm_freq_to_reg(unsigned long val, u16 clkin)
 	unsigned long best0, best1;
 
 	/* Best fit for cksel = 0 */
-	for (reg0 = 0; reg0 < ARRAY_SIZE(pwm_freq_cksel0) - 1; reg0++) {
-		if (val > (pwm_freq_cksel0[reg0] +
-			   pwm_freq_cksel0[reg0 + 1]) / 2)
-			break;
-	}
+	reg0 = find_closest_descending(val, pwm_freq_cksel0,
+				       ARRAY_SIZE(pwm_freq_cksel0));
 	if (val < 375)	/* cksel = 1 can't beat this */
 		return reg0;
 	best0 = pwm_freq_cksel0[reg0];
-- 
2.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
