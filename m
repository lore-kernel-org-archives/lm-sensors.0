From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 03 Jul 2014 20:56:59 +0000
Subject: [lm-sensors] [PATCH] hwmon: (adm1031) Fix writes to limit registers
Message-Id: <1404421019-16103-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Upper limit for write operations to temperature limit registers
was clamped to a fractional value. However, limit registers do
not support fractional values. As a result, upper limits of 127.5
degrees C or higher resulted in a rounded limit of 128 degrees C.
Since limit registers are signed, this was stored as -128 degrees C.
Clamp limits to (-55, +127) degrees C to solve the problem.

Value on writes to auto_temp[12]_min and auto_temp[12]_max were not
clamped at all, but masked. As a result, out-of-range writes resulted
in a more or less arbitrary limit. Clamp those attributes to (0, 127)
degrees C for more predictable results.

Cc: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/adm1031.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/adm1031.c b/drivers/hwmon/adm1031.c
index a8a540c..9eaa235 100644
--- a/drivers/hwmon/adm1031.c
+++ b/drivers/hwmon/adm1031.c
@@ -366,6 +366,7 @@ set_auto_temp_min(struct device *dev, struct device_attribute *attr,
 		return ret;
 
 	mutex_lock(&data->update_lock);
+	val = clamp_val(val, 0, 127000);
 	data->auto_temp[nr] = AUTO_TEMP_MIN_TO_REG(val, data->auto_temp[nr]);
 	adm1031_write_value(client, ADM1031_REG_AUTO_TEMP(nr),
 			    data->auto_temp[nr]);
@@ -395,6 +396,7 @@ set_auto_temp_max(struct device *dev, struct device_attribute *attr,
 		return ret;
 
 	mutex_lock(&data->update_lock);
+	val = clamp_val(val, 0, 127000);
 	data->temp_max[nr] = AUTO_TEMP_MAX_TO_REG(val, data->auto_temp[nr],
 						  data->pwm[nr]);
 	adm1031_write_value(client, ADM1031_REG_AUTO_TEMP(nr),
@@ -696,7 +698,7 @@ static ssize_t set_temp_min(struct device *dev, struct device_attribute *attr,
 	if (ret)
 		return ret;
 
-	val = clamp_val(val, -55000, nr = 0 ? 127750 : 127875);
+	val = clamp_val(val, -55000, 127000);
 	mutex_lock(&data->update_lock);
 	data->temp_min[nr] = TEMP_TO_REG(val);
 	adm1031_write_value(client, ADM1031_REG_TEMP_MIN(nr),
@@ -717,7 +719,7 @@ static ssize_t set_temp_max(struct device *dev, struct device_attribute *attr,
 	if (ret)
 		return ret;
 
-	val = clamp_val(val, -55000, nr = 0 ? 127750 : 127875);
+	val = clamp_val(val, -55000, 127000);
 	mutex_lock(&data->update_lock);
 	data->temp_max[nr] = TEMP_TO_REG(val);
 	adm1031_write_value(client, ADM1031_REG_TEMP_MAX(nr),
@@ -738,7 +740,7 @@ static ssize_t set_temp_crit(struct device *dev, struct device_attribute *attr,
 	if (ret)
 		return ret;
 
-	val = clamp_val(val, -55000, nr = 0 ? 127750 : 127875);
+	val = clamp_val(val, -55000, 127000);
 	mutex_lock(&data->update_lock);
 	data->temp_crit[nr] = TEMP_TO_REG(val);
 	adm1031_write_value(client, ADM1031_REG_TEMP_CRIT(nr),
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
