From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 25 Feb 2011 18:57:25 +0000
Subject: [lm-sensors] [PATCH v4 3/4] hwmon: (lm85) Do not update hysteresis
Message-Id: <1298660246-6484-4-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

So far, the driver updates temp_auto_hyst and temp_auto_off if temp_auto_min changes.
This may cause problems if temp_auto_off was not configured before configuring
temp_auto_min, because one of the variables used (off_desired) is not initialized
in this case.

To simplify the code, and for consistency with other drivers, no longer update the delta
between "min" and "off" until the user sets the "off" value again.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/lm85.c |   17 -----------------
 1 files changed, 0 insertions(+), 17 deletions(-)

diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
index 590226a..fbb5189 100644
--- a/drivers/hwmon/lm85.c
+++ b/drivers/hwmon/lm85.c
@@ -283,10 +283,6 @@ struct lm85_zone {
 	u8 hyst;	/* Low limit hysteresis. (0-15) */
 	u8 range;	/* Temp range, encoded */
 	s8 critical;	/* "All fans ON" temp limit */
-	u8 off_desired; /* Actual "off" temperature specified.  Preserved
-			 * to prevent "drift" as other autofan control
-			 * values change.
-			 */
 	u8 max_desired; /* Actual "max" temperature specified.  Preserved
 			 * to prevent "drift" as other autofan control
 			 * values change.
@@ -892,7 +888,6 @@ static ssize_t set_temp_auto_temp_off(struct device *dev,
 
 	mutex_lock(&data->update_lock);
 	min = TEMP_FROM_REG(data->zone[nr].limit);
-	data->zone[nr].off_desired = TEMP_TO_REG(val);
 	data->zone[nr].hyst = HYST_TO_REG(min - val);
 	if (nr = 0 || nr = 1) {
 		lm85_write_value(client, LM85_REG_AFAN_HYST1,
@@ -935,18 +930,6 @@ static ssize_t set_temp_auto_temp_min(struct device *dev,
 		((data->zone[nr].range & 0x0f) << 4)
 		| (data->pwm_freq[nr] & 0x07));
 
-/* Update temp_auto_hyst and temp_auto_off */
-	data->zone[nr].hyst = HYST_TO_REG(TEMP_FROM_REG(
-		data->zone[nr].limit) - TEMP_FROM_REG(
-		data->zone[nr].off_desired));
-	if (nr = 0 || nr = 1) {
-		lm85_write_value(client, LM85_REG_AFAN_HYST1,
-			(data->zone[0].hyst << 4)
-			| data->zone[1].hyst);
-	} else {
-		lm85_write_value(client, LM85_REG_AFAN_HYST2,
-			(data->zone[2].hyst << 4));
-	}
 	mutex_unlock(&data->update_lock);
 	return count;
 }
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
