From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 17 Jul 2014 00:44:03 +0000
Subject: [lm-sensors] [PATCH] hwmon: (adt7470) Fix writes to temperature limit registers
Message-Id: <1405557843-15609-1-git-send-email-linux@roeck-us.net>
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
 drivers/hwmon/adt7470.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
index 0f4dea5..8fe1495 100644
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
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
