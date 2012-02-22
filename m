From: Nikolaus Schulz <mail@microschulz.de>
Date: Wed, 22 Feb 2012 22:18:45 +0000
Subject: [lm-sensors] [PATCH 2/6] hwmon: (f75375s) Fix writes to the pwm* attribute for the F75387
Message-Id: <1329949129-4265-3-git-send-email-mail@microschulz.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

For the F75387, the register holding the current PWM duty cycle value is
r/o; changing it requires writing to the fan expect register instead.

Signed-off-by: Nikolaus Schulz <mail@microschulz.de>
---
 drivers/hwmon/f75375s.c |   27 +++++++++++++++++++++------
 1 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/f75375s.c b/drivers/hwmon/f75375s.c
index 5dae122..fc6444d 100644
--- a/drivers/hwmon/f75375s.c
+++ b/drivers/hwmon/f75375s.c
@@ -308,8 +308,14 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
 		return err;
 
 	mutex_lock(&data->update_lock);
+	/* TODO: Improve representation in the register cache for the F75387 */
 	data->pwm[nr] = SENSORS_LIMIT(val, 0, 255);
-	f75375_write8(client, F75375_REG_FAN_PWM_DUTY(nr), data->pwm[nr]);
+	if (data->kind = f75387)
+		f75375_write16(client, F75375_REG_FAN_EXP(nr),
+				data->pwm[nr]);
+	else
+		f75375_write8(client, F75375_REG_FAN_PWM_DUTY(nr),
+				data->pwm[nr]);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -373,9 +379,14 @@ static int set_pwm_enable_direct(struct i2c_client *client, int nr, int val)
 
 	f75375_write8(client, F75375_REG_FAN_TIMER, fanmode);
 	data->pwm_enable[nr] = val;
-	if (val = 0)
-		f75375_write8(client, F75375_REG_FAN_PWM_DUTY(nr),
-				data->pwm[nr]);
+	if (val = 0) {
+		if (data->kind = f75387)
+			f75375_write16(client, F75375_REG_FAN_EXP(nr),
+					data->pwm[nr]);
+		else
+			f75375_write8(client, F75375_REG_FAN_PWM_DUTY(nr),
+					data->pwm[nr]);
+	}
 	return 0;
 }
 
@@ -759,8 +770,12 @@ static void f75375_init(struct i2c_client *client, struct f75375_data *data,
 	set_pwm_enable_direct(client, 1, f75375s_pdata->pwm_enable[1]);
 	for (nr = 0; nr < 2; nr++) {
 		data->pwm[nr] = SENSORS_LIMIT(f75375s_pdata->pwm[nr], 0, 255);
-		f75375_write8(client, F75375_REG_FAN_PWM_DUTY(nr),
-			data->pwm[nr]);
+		if (data->kind = f75387)
+			f75375_write16(client, F75375_REG_FAN_EXP(nr),
+					data->pwm[nr]);
+		else
+			f75375_write8(client, F75375_REG_FAN_PWM_DUTY(nr),
+					data->pwm[nr]);
 	}
 
 }
-- 
1.7.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
