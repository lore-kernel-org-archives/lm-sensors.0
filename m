From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Wed, 11 Sep 2013 04:31:48 +0000
Subject: [lm-sensors] [PATCH 1/5] hwmon: (emc2103) Fix return value
Message-Id: <1378873192-6297-1-git-send-email-sachin.kamat@linaro.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

kstrtol() returns appropriate error values. Use those instead of
hardcoding. Silences several sparse messages of following type:
"why not propagate 'result' from kstrtol() instead of (-22)?"

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Steve Glendinning <steve.glendinning@shawell.net>
---
Series is compile tested.
---
 drivers/hwmon/emc2103.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/emc2103.c b/drivers/hwmon/emc2103.c
index b073056..2c137b2 100644
--- a/drivers/hwmon/emc2103.c
+++ b/drivers/hwmon/emc2103.c
@@ -248,7 +248,7 @@ static ssize_t set_temp_min(struct device *dev, struct device_attribute *da,
 
 	int result = kstrtol(buf, 10, &val);
 	if (result < 0)
-		return -EINVAL;
+		return result;
 
 	val = DIV_ROUND_CLOSEST(val, 1000);
 	if ((val < -63) || (val > 127))
@@ -272,7 +272,7 @@ static ssize_t set_temp_max(struct device *dev, struct device_attribute *da,
 
 	int result = kstrtol(buf, 10, &val);
 	if (result < 0)
-		return -EINVAL;
+		return result;
 
 	val = DIV_ROUND_CLOSEST(val, 1000);
 	if ((val < -63) || (val > 127))
@@ -320,7 +320,7 @@ static ssize_t set_fan_div(struct device *dev, struct device_attribute *da,
 
 	int status = kstrtol(buf, 10, &new_div);
 	if (status < 0)
-		return -EINVAL;
+		return status;
 
 	if (new_div = old_div) /* No change */
 		return count;
@@ -394,7 +394,7 @@ static ssize_t set_fan_target(struct device *dev, struct device_attribute *da,
 
 	int result = kstrtol(buf, 10, &rpm_target);
 	if (result < 0)
-		return -EINVAL;
+		return result;
 
 	/* Datasheet states 16384 as maximum RPM target (table 3.2) */
 	if ((rpm_target < 0) || (rpm_target > 16384))
@@ -440,7 +440,7 @@ static ssize_t set_pwm_enable(struct device *dev, struct device_attribute *da,
 
 	int result = kstrtol(buf, 10, &new_value);
 	if (result < 0)
-		return -EINVAL;
+		return result;
 
 	mutex_lock(&data->update_lock);
 	switch (new_value) {
-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
