From: Nikolaus Schulz <mail@microschulz.de>
Date: Wed, 08 Feb 2012 17:56:11 +0000
Subject: [lm-sensors] [PATCH 4/4] hwmon: (f75375s) Let f75375_update_device treat pwmX as a measured value
Message-Id: <1328723771-22163-5-git-send-email-mail@microschulz.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Nikolaus Schulz <schulz@macnetix.de>

Treat pwmX as a measured value, not as a (mostly static) limit value, so
that it is updated more frequently from the device register.

Signed-off-by: Nikolaus Schulz <mail@microschulz.de>
---
 drivers/hwmon/f75375s.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/f75375s.c b/drivers/hwmon/f75375s.c
index 0aabaaf..f609b57 100644
--- a/drivers/hwmon/f75375s.c
+++ b/drivers/hwmon/f75375s.c
@@ -200,9 +200,6 @@ static struct f75375_data *f75375_update_device(struct device *dev)
 				f75375_read16(client, F75375_REG_FAN_MIN(nr));
 			data->fan_target[nr]  				f75375_read16(client, F75375_REG_FAN_EXP(nr));
-			data->pwm[nr] =	f75375_read8(client,
-				F75375_REG_FAN_PWM_DUTY(nr));
-
 		}
 		for (nr = 0; nr < 4; nr++) {
 			data->in_max[nr] @@ -218,6 +215,8 @@ static struct f75375_data *f75375_update_device(struct device *dev)
 	if (time_after(jiffies, data->last_updated + 2 * HZ)
 		|| !data->valid) {
 		for (nr = 0; nr < 2; nr++) {
+			data->pwm[nr] =	f75375_read8(client,
+				F75375_REG_FAN_PWM_DUTY(nr));
 			/* assign MSB, therefore shift it by 8 bits */
 			data->temp11[nr]  				f75375_read8(client, F75375_REG_TEMP(nr)) << 8;
-- 
1.7.9


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
