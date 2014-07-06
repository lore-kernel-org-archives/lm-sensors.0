From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 06 Jul 2014 18:43:44 +0000
Subject: [lm-sensors] [PATCH] hwmon: (emc2103) Clamp limits instead of bailing out
Message-Id: <1404672224-30984-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

It is customary to clamp limits instead of bailing out with an error
if a configured limit is out of the range supported by the driver.
This simplifies limit configuration, since the user will not typically
know chip and/or driver specific limits.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/emc2103.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/emc2103.c b/drivers/hwmon/emc2103.c
index fd892dd..0f38294 100644
--- a/drivers/hwmon/emc2103.c
+++ b/drivers/hwmon/emc2103.c
@@ -250,9 +250,7 @@ static ssize_t set_temp_min(struct device *dev, struct device_attribute *da,
 	if (result < 0)
 		return result;
 
-	val = DIV_ROUND_CLOSEST(val, 1000);
-	if ((val < -63) || (val > 127))
-		return -EINVAL;
+	val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), -63, 127);
 
 	mutex_lock(&data->update_lock);
 	data->temp_min[nr] = val;
@@ -274,9 +272,7 @@ static ssize_t set_temp_max(struct device *dev, struct device_attribute *da,
 	if (result < 0)
 		return result;
 
-	val = DIV_ROUND_CLOSEST(val, 1000);
-	if ((val < -63) || (val > 127))
-		return -EINVAL;
+	val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), -63, 127);
 
 	mutex_lock(&data->update_lock);
 	data->temp_max[nr] = val;
@@ -397,8 +393,7 @@ static ssize_t set_fan_target(struct device *dev, struct device_attribute *da,
 		return result;
 
 	/* Datasheet states 16384 as maximum RPM target (table 3.2) */
-	if ((rpm_target < 0) || (rpm_target > 16384))
-		return -EINVAL;
+	rpm_target = clamp_val(rpm_target, 0, 16384);
 
 	mutex_lock(&data->update_lock);
 
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
