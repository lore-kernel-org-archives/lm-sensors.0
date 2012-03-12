From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 12 Mar 2012 15:43:24 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (w83627ehf) Fix writing into fan_stop_time for NCT6775F/NCT6776F
Message-Id: <1331567005-13734-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

NCT6775F and NCT6776F have their own set of registers for FAN_STOP_TIME. The
correct registers were used to read FAN_STOP_TIME, but writes used the wrong
registers. Fix it.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/w83627ehf.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
index 57a31a0..378142c 100644
--- a/drivers/hwmon/w83627ehf.c
+++ b/drivers/hwmon/w83627ehf.c
@@ -1622,7 +1622,7 @@ store_##reg(struct device *dev, struct device_attribute *attr, \
 	val = step_time_to_reg(val, data->pwm_mode[nr]); \
 	mutex_lock(&data->update_lock); \
 	data->reg[nr] = val; \
-	w83627ehf_write_value(data, W83627EHF_REG_##REG[nr], val); \
+	w83627ehf_write_value(data, data->REG_##REG[nr], val); \
 	mutex_unlock(&data->update_lock); \
 	return count; \
 } \
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
