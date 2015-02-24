From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Tue, 24 Feb 2015 17:48:27 +0000
Subject: [lm-sensors] [RESEND PATCH 2/4] hwmon: (ina2xx) replace ina226_avg_bits() with find_closest()
Message-Id: <1424800109-2969-3-git-send-email-bgolaszewski@baylibre.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1424800109-2969-1-git-send-email-bgolaszewski@baylibre.com>
In-Reply-To: <1424800109-2969-1-git-send-email-bgolaszewski@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.de>, lm-sensors <lm-sensors@lm-sensors.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>

Use find_closest() to locate the closest average in ina226_avg_tab.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/hwmon/ina2xx.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
index d1542b7..fc7f023 100644
--- a/drivers/hwmon/ina2xx.c
+++ b/drivers/hwmon/ina2xx.c
@@ -141,19 +141,6 @@ static const struct ina2xx_config ina2xx_config[] = {
  */
 static const int ina226_avg_tab[] = { 1, 4, 16, 64, 128, 256, 512, 1024 };
 
-static int ina226_avg_bits(int avg)
-{
-	int i;
-
-	/* Get the closest average from the tab. */
-	for (i = 0; i < ARRAY_SIZE(ina226_avg_tab) - 1; i++) {
-		if (avg <= (ina226_avg_tab[i] + ina226_avg_tab[i + 1]) / 2)
-			break;
-	}
-
-	return i; /* Return 0b0111 for values greater than 1024. */
-}
-
 static int ina226_reg_to_interval(u16 config)
 {
 	int avg = ina226_avg_tab[INA226_READ_AVG(config)];
@@ -171,7 +158,8 @@ static u16 ina226_interval_to_reg(int interval, u16 config)
 
 	avg = DIV_ROUND_CLOSEST(interval * 1000,
 				INA226_TOTAL_CONV_TIME_DEFAULT);
-	avg_bits = ina226_avg_bits(avg);
+	avg_bits = find_closest(avg, ina226_avg_tab,
+				ARRAY_SIZE(ina226_avg_tab));
 
 	return (config & ~INA226_AVG_RD_MASK) | INA226_SHIFT_AVG(avg_bits);
 }
-- 
2.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
