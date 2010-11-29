From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 29 Nov 2010 13:00:10 +0000
Subject: [lm-sensors] [PATCH] hwmon: (it87) Fix manual fan speed control on
Message-Id: <20101129140010.6165cd6e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The manual fan speed control logic of the IT8721F is much different
from what older devices had. Update the code to properly support that.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/it87.c |   61 ++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 16 deletions(-)

--- linux-2.6.37-rc3.orig/drivers/hwmon/it87.c	2010-11-24 10:06:22.000000000 +0100
+++ linux-2.6.37-rc3/drivers/hwmon/it87.c	2010-11-29 13:56:10.000000000 +0100
@@ -187,6 +187,7 @@ static const u8 IT87_REG_FANX_MIN[]	= {
 #define IT87_REG_FAN_MAIN_CTRL 0x13
 #define IT87_REG_FAN_CTL       0x14
 #define IT87_REG_PWM(nr)       (0x15 + (nr))
+#define IT87_REG_PWM_DUTY(nr)  (0x63 + (nr) * 8)
 
 #define IT87_REG_VIN(nr)       (0x20 + (nr))
 #define IT87_REG_TEMP(nr)      (0x29 + (nr))
@@ -251,12 +252,16 @@ struct it87_data {
 	u8 fan_main_ctrl;	/* Register value */
 	u8 fan_ctl;		/* Register value */
 
-	/* The following 3 arrays correspond to the same registers. The
-	 * meaning of bits 6-0 depends on the value of bit 7, and we want
-	 * to preserve settings on mode changes, so we have to track all
-	 * values separately. */
+	/* The following 3 arrays correspond to the same registers up to
+	 * the IT8720F. The meaning of bits 6-0 depends on the value of bit
+	 * 7, and we want to preserve settings on mode changes, so we have
+	 * to track all values separately.
+	 * Starting with the IT8721F, the manual PWM duty cycles are stored
+	 * in separate registers (8-bit values), so the separate tracking
+	 * is no longer needed, but it is still done to keep the driver
+	 * simple. */
 	u8 pwm_ctrl[3];		/* Register value */
-	u8 pwm_duty[3];		/* Manual PWM value set by user (bit 6-0) */
+	u8 pwm_duty[3];		/* Manual PWM value set by user */
 	u8 pwm_temp_map[3];	/* PWM to temp. chan. mapping (bits 1-0) */
 
 	/* Automatic fan speed control registers */
@@ -832,7 +837,9 @@ static ssize_t set_pwm_enable(struct dev
 				 data->fan_main_ctrl);
 	} else {
 		if (val = 1)				/* Manual mode */
-			data->pwm_ctrl[nr] = data->pwm_duty[nr];
+			data->pwm_ctrl[nr] = data->type = it8721 ?
+					     data->pwm_temp_map[nr] :
+					     data->pwm_duty[nr];
 		else					/* Automatic mode */
 			data->pwm_ctrl[nr] = 0x80 | data->pwm_temp_map[nr];
 		it87_write_value(data, IT87_REG_PWM(nr), data->pwm_ctrl[nr]);
@@ -858,12 +865,25 @@ static ssize_t set_pwm(struct device *de
 		return -EINVAL;
 
 	mutex_lock(&data->update_lock);
-	data->pwm_duty[nr] = pwm_to_reg(data, val);
-	/* If we are in manual mode, write the duty cycle immediately;
-	 * otherwise, just store it for later use. */
-	if (!(data->pwm_ctrl[nr] & 0x80)) {
-		data->pwm_ctrl[nr] = data->pwm_duty[nr];
-		it87_write_value(data, IT87_REG_PWM(nr), data->pwm_ctrl[nr]);
+	if (data->type = it8721) {
+		/* If we are in automatic mode, the PWM duty cycle register
+		 * is read-only so we can't write the value */
+		if (data->pwm_ctrl[nr] & 0x80) {
+			mutex_unlock(&data->update_lock);
+			return -EBUSY;
+		}
+		data->pwm_duty[nr] = pwm_to_reg(data, val);
+		it87_write_value(data, IT87_REG_PWM_DUTY(nr),
+				 data->pwm_duty[nr]);
+	} else {
+		data->pwm_duty[nr] = pwm_to_reg(data, val);
+		/* If we are in manual mode, write the duty cycle immediately;
+		 * otherwise, just store it for later use. */
+		if (!(data->pwm_ctrl[nr] & 0x80)) {
+			data->pwm_ctrl[nr] = data->pwm_duty[nr];
+			it87_write_value(data, IT87_REG_PWM(nr),
+					 data->pwm_ctrl[nr]);
+		}
 	}
 	mutex_unlock(&data->update_lock);
 	return count;
@@ -1958,7 +1978,10 @@ static void __devinit it87_init_device(s
 	 *   channels to use when later setting to automatic mode later.
 	 *   Use a 1:1 mapping by default (we are clueless.)
 	 * In both cases, the value can (and should) be changed by the user
-	 * prior to switching to a different mode. */
+	 * prior to switching to a different mode.
+	 * Note that this is no longer needed for the IT8721F and later, as
+	 * these have separate registers for the temperature mapping and the
+	 * manual duty cycle. */
 	for (i = 0; i < 3; i++) {
 		data->pwm_temp_map[i] = i;
 		data->pwm_duty[i] = 0x7f;	/* Full speed */
@@ -2034,10 +2057,16 @@ static void __devinit it87_init_device(s
 static void it87_update_pwm_ctrl(struct it87_data *data, int nr)
 {
 	data->pwm_ctrl[nr] = it87_read_value(data, IT87_REG_PWM(nr));
-	if (data->pwm_ctrl[nr] & 0x80)	/* Automatic mode */
+	if (data->type = it8721) {
 		data->pwm_temp_map[nr] = data->pwm_ctrl[nr] & 0x03;
-	else				/* Manual mode */
-		data->pwm_duty[nr] = data->pwm_ctrl[nr] & 0x7f;
+		data->pwm_duty[nr] = it87_read_value(data,
+						     IT87_REG_PWM_DUTY(nr));
+	} else {
+		if (data->pwm_ctrl[nr] & 0x80)	/* Automatic mode */
+			data->pwm_temp_map[nr] = data->pwm_ctrl[nr] & 0x03;
+		else				/* Manual mode */
+			data->pwm_duty[nr] = (data->pwm_ctrl[nr] & 0x7f) << 1;
+	}
 
 	if (has_old_autopwm(data)) {
 		int i;


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
