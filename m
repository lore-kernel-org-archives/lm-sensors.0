From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 14 Sep 2013 08:33:29 +0000
Subject: [lm-sensors] [PATCH 06/12] hwmon: (adt7462) Use error value returned from find_trange_value()
Message-Id: <1379147615-7703-7-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

find_trange_value() returns -ENODEV in case of errors, only to have it
ignored and replaced with -EINVAL. Make it return -EINVAL and use it.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/adt7462.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/adt7462.c b/drivers/hwmon/adt7462.c
index addb5a4..562cc38 100644
--- a/drivers/hwmon/adt7462.c
+++ b/drivers/hwmon/adt7462.c
@@ -700,7 +700,7 @@ static int find_trange_value(int trange)
 		if (trange_values[i] = trange)
 			return i;
 
-	return -ENODEV;
+	return -EINVAL;
 }
 
 static struct adt7462_data *adt7462_update_device(struct device *dev)
@@ -1294,9 +1294,8 @@ static ssize_t set_pwm_tmax(struct device *dev,
 	/* trange = tmax - tmin */
 	tmin = (data->pwm_tmin[attr->index] - 64) * 1000;
 	trange_value = find_trange_value(trange - tmin);
-
 	if (trange_value < 0)
-		return -EINVAL;
+		return trange_value;
 
 	temp = trange_value << ADT7462_PWM_RANGE_SHIFT;
 	temp |= data->pwm_trange[attr->index] & ADT7462_PWM_HYST_MASK;
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
