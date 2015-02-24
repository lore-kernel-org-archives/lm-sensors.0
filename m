From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Tue, 24 Feb 2015 17:48:28 +0000
Subject: [lm-sensors] [RESEND PATCH 3/4] hwmon: (lm85) replace x_TO_REG() functions with find_closest()
Message-Id: <1424800109-2969-4-git-send-email-bgolaszewski@baylibre.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1424800109-2969-1-git-send-email-bgolaszewski@baylibre.com>
In-Reply-To: <1424800109-2969-1-git-send-email-bgolaszewski@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.de>, lm-sensors <lm-sensors@lm-sensors.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>

Replace RANGE_TO_REG() and FREQ_TO_REG() functions with calls
to find_closest().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/hwmon/lm85.c | 43 ++++++++++++-------------------------------
 1 file changed, 12 insertions(+), 31 deletions(-)

diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
index 2b4b419..4e81c99 100644
--- a/drivers/hwmon/lm85.c
+++ b/drivers/hwmon/lm85.c
@@ -188,18 +188,6 @@ static const int lm85_range_map[] = {
 	13300, 16000, 20000, 26600, 32000, 40000, 53300, 80000
 };
 
-static int RANGE_TO_REG(long range)
-{
-	int i;
-
-	/* Find the closest match */
-	for (i = 0; i < 15; ++i) {
-		if (range <= (lm85_range_map[i] + lm85_range_map[i + 1]) / 2)
-			break;
-	}
-
-	return i;
-}
 #define RANGE_FROM_REG(val)	lm85_range_map[(val) & 0x0f]
 
 /* These are the PWM frequency encodings */
@@ -209,17 +197,7 @@ static const int lm85_freq_map[8] = { /* 1 Hz */
 static const int adm1027_freq_map[8] = { /* 1 Hz */
 	11, 15, 22, 29, 35, 44, 59, 88
 };
-
-static int FREQ_TO_REG(const int *map, unsigned long freq)
-{
-	int i;
-
-	/* Find the closest match */
-	for (i = 0; i < 7; ++i)
-		if (freq <= (map[i] + map[i + 1]) / 2)
-			break;
-	return i;
-}
+#define FREQ_MAP_SIZE		8
 
 static int FREQ_FROM_REG(const int *map, u8 reg)
 {
@@ -828,7 +806,8 @@ static ssize_t set_pwm_freq(struct device *dev,
 		data->cfg5 &= ~ADT7468_HFPWM;
 		lm85_write_value(client, ADT7468_REG_CFG5, data->cfg5);
 	} else {					/* Low freq. mode */
-		data->pwm_freq[nr] = FREQ_TO_REG(data->freq_map, val);
+		data->pwm_freq[nr] = find_closest(val, data->freq_map,
+						  FREQ_MAP_SIZE - 1);
 		lm85_write_value(client, LM85_REG_AFAN_RANGE(nr),
 				 (data->zone[nr].range << 4)
 				 | data->pwm_freq[nr]);
@@ -1186,7 +1165,7 @@ static ssize_t set_temp_auto_temp_min(struct device *dev,
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
-	long val;
+	long val, range;
 	int err;
 
 	err = kstrtol(buf, 10, &val);
@@ -1198,10 +1177,12 @@ static ssize_t set_temp_auto_temp_min(struct device *dev,
 	lm85_write_value(client, LM85_REG_AFAN_LIMIT(nr),
 		data->zone[nr].limit);
 
-/* Update temp_auto_max and temp_auto_range */
-	data->zone[nr].range = RANGE_TO_REG(
-		TEMP_FROM_REG(data->zone[nr].max_desired) -
-		TEMP_FROM_REG(data->zone[nr].limit));
+	/* Update temp_auto_max and temp_auto_range */
+	range = TEMP_FROM_REG(data->zone[nr].max_desired) -
+		TEMP_FROM_REG(data->zone[nr].limit);
+	data->zone[nr].range = find_closest(range, lm85_range_map,
+					    ARRAY_SIZE(lm85_range_map));
+
 	lm85_write_value(client, LM85_REG_AFAN_RANGE(nr),
 		((data->zone[nr].range & 0x0f) << 4)
 		| (data->pwm_freq[nr] & 0x07));
@@ -1236,8 +1217,8 @@ static ssize_t set_temp_auto_temp_max(struct device *dev,
 	mutex_lock(&data->update_lock);
 	min = TEMP_FROM_REG(data->zone[nr].limit);
 	data->zone[nr].max_desired = TEMP_TO_REG(val);
-	data->zone[nr].range = RANGE_TO_REG(
-		val - min);
+	data->zone[nr].range = find_closest(val - min, lm85_range_map,
+					    ARRAY_SIZE(lm85_range_map));
 	lm85_write_value(client, LM85_REG_AFAN_RANGE(nr),
 		((data->zone[nr].range & 0x0f) << 4)
 		| (data->pwm_freq[nr] & 0x07));
-- 
2.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
