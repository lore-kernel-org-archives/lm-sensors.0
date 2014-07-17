From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 17 Jul 2014 01:08:56 +0000
Subject: [lm-sensors] [PATCH v2] hwmon: (adt7470) Fix writes to temperature limit registers
Message-Id: <1405559336-11068-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Temperature limit registers are signed. Limits therefore need
to be clamped to (-128, 127) degrees C and not to (0, 255)
degrees C.

Without this fix, writing a limit of 128 degrees C sets the
actual limit to -128 degrees C.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Apply to pwm[1-4]_auto_point1_temp as well. While the datasheet
    does not state clearly that the register is signed, anything else
    does not really make sense. Either case, since the data is stored
    as s8, the bug as described applies to this register as well.

 drivers/hwmon/adt7470.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
index 0f4dea5..9ee3913 100644
--- a/drivers/hwmon/adt7470.c
+++ b/drivers/hwmon/adt7470.c
@@ -515,7 +515,7 @@ static ssize_t set_temp_min(struct device *dev,
 		return -EINVAL;
 
 	temp = DIV_ROUND_CLOSEST(temp, 1000);
-	temp = clamp_val(temp, 0, 255);
+	temp = clamp_val(temp, -128, 127);
 
 	mutex_lock(&data->lock);
 	data->temp_min[attr->index] = temp;
@@ -549,7 +549,7 @@ static ssize_t set_temp_max(struct device *dev,
 		return -EINVAL;
 
 	temp = DIV_ROUND_CLOSEST(temp, 1000);
-	temp = clamp_val(temp, 0, 255);
+	temp = clamp_val(temp, -128, 127);
 
 	mutex_lock(&data->lock);
 	data->temp_max[attr->index] = temp;
@@ -826,7 +826,7 @@ static ssize_t set_pwm_tmin(struct device *dev,
 		return -EINVAL;
 
 	temp = DIV_ROUND_CLOSEST(temp, 1000);
-	temp = clamp_val(temp, 0, 255);
+	temp = clamp_val(temp, -128, 127);
 
 	mutex_lock(&data->lock);
 	data->pwm_tmin[attr->index] = temp;
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
