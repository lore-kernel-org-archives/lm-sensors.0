From: Nikolaus Schulz <mail@microschulz.de>
Date: Tue, 28 Feb 2012 21:15:54 +0000
Subject: [lm-sensors] [PATCH v2 4/4] hwmon: (f75375s) Catch some attempts to write to r/o registers
Message-Id: <1330463755-5763-5-git-send-email-mail@microschulz.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

It makes no sense to attempt to manually configure the fan in auto mode,
or set the duty cycle directly in closed loop mode.  The corresponding
registers are then read-only.  If the user tries it nonetheless, error out
with EINVAL instead of silently doing nothing.

Signed-off-by: Nikolaus Schulz <mail@microschulz.de>
---
 drivers/hwmon/f75375s.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/f75375s.c b/drivers/hwmon/f75375s.c
index 3fee82dc..5374501 100644
--- a/drivers/hwmon/f75375s.c
+++ b/drivers/hwmon/f75375s.c
@@ -278,6 +278,21 @@ static bool duty_mode_enabled(u8 pwm_enable)
 	}
 }
 
+static bool auto_mode_enabled(u8 pwm_enable)
+{
+	switch (pwm_enable) {
+	case 0: /* Manual, duty mode (full speed) */
+	case 1: /* Manual, duty mode */
+	case 3: /* Manual, speed mode */
+		return false;
+	case 2: /* Auto, speed mode */
+	case 4: /* Auto, duty mode */
+		return true;
+	default:
+		BUG();
+	}
+}
+
 static ssize_t set_fan_min(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
 {
@@ -311,6 +326,11 @@ static ssize_t set_fan_target(struct device *dev, struct device_attribute *attr,
 	if (err < 0)
 		return err;
 
+	if (auto_mode_enabled(data->pwm_enable[nr]))
+		return -EINVAL;
+	if (data->kind = f75387 && duty_mode_enabled(data->pwm_enable[nr]))
+		return -EINVAL;
+
 	mutex_lock(&data->update_lock);
 	data->fan_target[nr] = rpm_to_reg(val);
 	f75375_write16(client, F75375_REG_FAN_EXP(nr), data->fan_target[nr]);
@@ -331,6 +351,10 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
 	if (err < 0)
 		return err;
 
+	if (auto_mode_enabled(data->pwm_enable[nr]) ||
+			!duty_mode_enabled(data->pwm_enable[nr]))
+		return -EINVAL;
+
 	mutex_lock(&data->update_lock);
 	data->pwm[nr] = SENSORS_LIMIT(val, 0, 255);
 	f75375_write_pwm(client, nr, data->pwm[nr]);
@@ -792,6 +816,9 @@ static void f75375_init(struct i2c_client *client, struct f75375_data *data,
 	set_pwm_enable_direct(client, 0, f75375s_pdata->pwm_enable[0]);
 	set_pwm_enable_direct(client, 1, f75375s_pdata->pwm_enable[1]);
 	for (nr = 0; nr < 2; nr++) {
+		if (auto_mode_enabled(f75375s_pdata->pwm_enable[nr]) ||
+		   !duty_mode_enabled(f75375s_pdata->pwm_enable[nr]))
+			continue;
 		data->pwm[nr] = SENSORS_LIMIT(f75375s_pdata->pwm[nr], 0, 255);
 		f75375_write_pwm(client, nr, data->pwm[nr]);
 	}
-- 
1.7.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
