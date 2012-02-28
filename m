From: Nikolaus Schulz <mail@microschulz.de>
Date: Tue, 28 Feb 2012 21:15:53 +0000
Subject: [lm-sensors] [PATCH v2 3/4] hwmon: (f75375s) Properly map the F75387 automatic modes to pwm_enable
Message-Id: <1330463755-5763-4-git-send-email-mail@microschulz.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Nikolaus Schulz <schulz@macnetix.de>

The F75387 supports automatic fan control using either PWM duty cycle or
RPM speed values.  Make the driver detect the latter mode, and expose the
different modes in sysfs as per pwm_enable, so that the user can switch
between them.

The interpretation of the pwm_enable attribute for the F75387 is adjusted
to be a superset of those values used for similar Fintek chips which do
not support automatic duty mode, with 2 mapping to automatic speed mode,
and moving automatic duty mode to the new value 4.

Toggling the duty mode via pwm_enable is currently denied for the F75387,
as the chip then simply reinterprets the fan configuration register values
according to the new mode, switching between RPM and PWM units, which
makes this a dangerous operation.

Signed-off-by: Nikolaus Schulz <mail@microschulz.de>
---
 drivers/hwmon/f75375s.c |   42 ++++++++++++++++++++++++++++++++++--------
 1 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/f75375s.c b/drivers/hwmon/f75375s.c
index 29c0d06..3fee82dc 100644
--- a/drivers/hwmon/f75375s.c
+++ b/drivers/hwmon/f75375s.c
@@ -263,6 +263,21 @@ static inline u16 rpm_to_reg(int rpm)
 	return 1500000 / rpm;
 }
 
+static bool duty_mode_enabled(u8 pwm_enable)
+{
+	switch (pwm_enable) {
+	case 0: /* Manual, duty mode (full speed) */
+	case 1: /* Manual, duty mode */
+	case 4: /* Auto, duty mode */
+		return true;
+	case 2: /* Auto, speed mode */
+	case 3: /* Manual, speed mode */
+		return false;
+	default:
+		BUG();
+	}
+}
+
 static ssize_t set_fan_min(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
 {
@@ -336,11 +351,15 @@ static int set_pwm_enable_direct(struct i2c_client *client, int nr, int val)
 	struct f75375_data *data = i2c_get_clientdata(client);
 	u8 fanmode;
 
-	if (val < 0 || val > 3)
+	if (val < 0 || val > 4)
 		return -EINVAL;
 
 	fanmode = f75375_read8(client, F75375_REG_FAN_TIMER);
 	if (data->kind = f75387) {
+		/* For now, deny dangerous toggling of duty mode */
+		if (duty_mode_enabled(data->pwm_enable[nr]) !+				duty_mode_enabled(val))
+			return -EOPNOTSUPP;
 		/* clear each fanX_mode bit before setting them properly */
 		fanmode &= ~(1 << F75387_FAN_DUTY_MODE(nr));
 		fanmode &= ~(1 << F75387_FAN_MANU_MODE(nr));
@@ -354,12 +373,14 @@ static int set_pwm_enable_direct(struct i2c_client *client, int nr, int val)
 			fanmode  |= (1 << F75387_FAN_MANU_MODE(nr));
 			fanmode  |= (1 << F75387_FAN_DUTY_MODE(nr));
 			break;
-		case 2: /* AUTOMATIC*/
-			fanmode  |=  (1 << F75387_FAN_DUTY_MODE(nr));
+		case 2: /* Automatic, speed mode */
 			break;
 		case 3: /* fan speed */
 			fanmode |= (1 << F75387_FAN_MANU_MODE(nr));
 			break;
+		case 4: /* Automatic, pwm */
+			fanmode |= (1 << F75387_FAN_DUTY_MODE(nr));
+			break;
 		}
 	} else {
 		/* clear each fanX_mode bit before setting them properly */
@@ -377,6 +398,8 @@ static int set_pwm_enable_direct(struct i2c_client *client, int nr, int val)
 			break;
 		case 3: /* fan speed */
 			break;
+		case 4: /* Automatic pwm */
+			return -EINVAL;
 		}
 	}
 
@@ -734,14 +757,17 @@ static void f75375_init(struct i2c_client *client, struct f75375_data *data,
 
 				manu = ((mode >> F75387_FAN_MANU_MODE(nr)) & 1);
 				duty = ((mode >> F75387_FAN_DUTY_MODE(nr)) & 1);
-				if (manu && duty)
-					/* speed */
+				if (!manu && duty)
+					/* auto, pwm */
+					data->pwm_enable[nr] = 4;
+				else if (manu && !duty)
+					/* manual, speed */
 					data->pwm_enable[nr] = 3;
-				else if (!manu && duty)
-					/* automatic */
+				else if (!manu && !duty)
+					/* automatic, speed */
 					data->pwm_enable[nr] = 2;
 				else
-					/* manual */
+					/* manual, pwm */
 					data->pwm_enable[nr] = 1;
 			} else {
 				if (!(conf & (1 << F75375_FAN_CTRL_LINEAR(nr))))
-- 
1.7.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
