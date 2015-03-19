From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Thu, 19 Mar 2015 14:30:19 +0000
Subject: [lm-sensors] [PATCH v3 3/4] hwmon: (lm85) use find_closest() in x_TO_REG() functions
Message-Id: <1426775420-31350-4-git-send-email-bgolaszewski@baylibre.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1426775420-31350-1-git-send-email-bgolaszewski@baylibre.com>
In-Reply-To: <1426775420-31350-1-git-send-email-bgolaszewski@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, lm-sensors <lm-sensors@lm-sensors.org>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <srostedt@redhat.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>

Replace RANGE_TO_REG() and FREQ_TO_REG() implementations with
calls to find_closest().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/hwmon/lm85.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
index 2b4b419..6ff773f 100644
--- a/drivers/hwmon/lm85.c
+++ b/drivers/hwmon/lm85.c
@@ -34,6 +34,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
+#include <linux/util_macros.h>
 
 /* Addresses to scan */
 static const unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
@@ -190,15 +191,7 @@ static const int lm85_range_map[] = {
 
 static int RANGE_TO_REG(long range)
 {
-	int i;
-
-	/* Find the closest match */
-	for (i = 0; i < 15; ++i) {
-		if (range <= (lm85_range_map[i] + lm85_range_map[i + 1]) / 2)
-			break;
-	}
-
-	return i;
+	return find_closest(range, lm85_range_map, ARRAY_SIZE(lm85_range_map));
 }
 #define RANGE_FROM_REG(val)	lm85_range_map[(val) & 0x0f]
 
@@ -209,16 +202,12 @@ static const int lm85_freq_map[8] = { /* 1 Hz */
 static const int adm1027_freq_map[8] = { /* 1 Hz */
 	11, 15, 22, 29, 35, 44, 59, 88
 };
+#define FREQ_MAP_LEN	8
 
-static int FREQ_TO_REG(const int *map, unsigned long freq)
+static int FREQ_TO_REG(const int *map,
+		       unsigned int map_size, unsigned long freq)
 {
-	int i;
-
-	/* Find the closest match */
-	for (i = 0; i < 7; ++i)
-		if (freq <= (map[i] + map[i + 1]) / 2)
-			break;
-	return i;
+	return find_closest(freq, map, map_size);
 }
 
 static int FREQ_FROM_REG(const int *map, u8 reg)
@@ -828,7 +817,8 @@ static ssize_t set_pwm_freq(struct device *dev,
 		data->cfg5 &= ~ADT7468_HFPWM;
 		lm85_write_value(client, ADT7468_REG_CFG5, data->cfg5);
 	} else {					/* Low freq. mode */
-		data->pwm_freq[nr] = FREQ_TO_REG(data->freq_map, val);
+		data->pwm_freq[nr] = FREQ_TO_REG(data->freq_map,
+						 FREQ_MAP_LEN, val);
 		lm85_write_value(client, LM85_REG_AFAN_RANGE(nr),
 				 (data->zone[nr].range << 4)
 				 | data->pwm_freq[nr]);
-- 
2.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
