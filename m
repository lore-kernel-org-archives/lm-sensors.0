From: Nikolaus Schulz <mail@microschulz.de>
Date: Wed, 22 Feb 2012 22:18:44 +0000
Subject: [lm-sensors] [PATCH 1/6] hwmon: (f75375s) Fix register write order when setting fans to full speed
Message-Id: <1329949129-4265-2-git-send-email-mail@microschulz.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Nikolaus Schulz <schulz@macnetix.de>

By hwmon sysfs interface convention, setting pwm_enable to zero sets a fan
to full speed.  In the f75375s driver, this need be done by enabling
manual fan control, plus duty mode for the F875387 chip, and then setting
the maximum duty cycle.  Fix a bug where the two necessary register writes
were swapped, effectively discarding the setting to full-speed.

Signed-off-by: Nikolaus Schulz <mail@microschulz.de>
---
 drivers/hwmon/f75375s.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/f75375s.c b/drivers/hwmon/f75375s.c
index faf66c8..5dae122 100644
--- a/drivers/hwmon/f75375s.c
+++ b/drivers/hwmon/f75375s.c
@@ -340,8 +340,6 @@ static int set_pwm_enable_direct(struct i2c_client *client, int nr, int val)
 			fanmode |= (1 << F75387_FAN_MANU_MODE(nr));
 			fanmode |= (1 << F75387_FAN_DUTY_MODE(nr));
 			data->pwm[nr] = 255;
-			f75375_write8(client, F75375_REG_FAN_PWM_DUTY(nr),
-					data->pwm[nr]);
 			break;
 		case 1: /* PWM */
 			fanmode  |= (1 << F75387_FAN_MANU_MODE(nr));
@@ -361,8 +359,6 @@ static int set_pwm_enable_direct(struct i2c_client *client, int nr, int val)
 		case 0: /* full speed */
 			fanmode  |= (3 << FAN_CTRL_MODE(nr));
 			data->pwm[nr] = 255;
-			f75375_write8(client, F75375_REG_FAN_PWM_DUTY(nr),
-					data->pwm[nr]);
 			break;
 		case 1: /* PWM */
 			fanmode  |= (3 << FAN_CTRL_MODE(nr));
@@ -377,6 +373,9 @@ static int set_pwm_enable_direct(struct i2c_client *client, int nr, int val)
 
 	f75375_write8(client, F75375_REG_FAN_TIMER, fanmode);
 	data->pwm_enable[nr] = val;
+	if (val = 0)
+		f75375_write8(client, F75375_REG_FAN_PWM_DUTY(nr),
+				data->pwm[nr]);
 	return 0;
 }
 
-- 
1.7.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
