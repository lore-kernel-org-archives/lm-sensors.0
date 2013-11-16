From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 16 Nov 2013 15:06:56 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: (nct6775) NCT6791 supports weight control only for CPUFAN
Message-Id: <1384614416-27489-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Unlike other chips supported by this driver, the NCT6791 only has a single
set of registers to configure weighted fan control. Enable it only for the
single channel supporting it.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/nct6775.c |   29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 3f4ef21..cf811c1 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -510,6 +510,13 @@ static const u16 NCT6779_REG_TEMP_CRIT[ARRAY_SIZE(nct6779_temp_label) - 1]
 
 #define NCT6791_REG_HM_IO_SPACE_LOCK_ENABLE	0x28
 
+static const u16 NCT6791_REG_WEIGHT_TEMP_SEL[6] = { 0, 0x239 };
+static const u16 NCT6791_REG_WEIGHT_TEMP_STEP[6] = { 0, 0x23a };
+static const u16 NCT6791_REG_WEIGHT_TEMP_STEP_TOL[6] = { 0, 0x23b };
+static const u16 NCT6791_REG_WEIGHT_DUTY_STEP[6] = { 0, 0x23c };
+static const u16 NCT6791_REG_WEIGHT_TEMP_BASE[6] = { 0, 0x23d };
+static const u16 NCT6791_REG_WEIGHT_DUTY_BASE[6] = { 0, 0x23e };
+
 static const u16 NCT6791_REG_ALARM[NUM_REG_ALARM] = {
 	0x459, 0x45A, 0x45B, 0x568, 0x45D };
 
@@ -1311,6 +1318,9 @@ static void nct6775_update_pwm(struct device *dev)
 		if (reg & 0x80)
 			data->pwm[2][i] = 0;
 
+		if (!data->REG_WEIGHT_TEMP_SEL[i])
+			continue;
+
 		reg = nct6775_read_value(data, data->REG_WEIGHT_TEMP_SEL[i]);
 		data->pwm_weight_temp_sel[i] = reg & 0x1f;
 		/* If weight is disabled, report weight source as 0 */
@@ -2856,6 +2866,9 @@ static umode_t nct6775_pwm_is_visible(struct kobject *kobj,
 	if (!(data->has_pwm & (1 << pwm)))
 		return 0;
 
+	if ((nr >= 14 && nr <= 18) || nr = 21)   /* weight */
+		if (!data->REG_WEIGHT_TEMP_SEL[pwm])
+			return 0;
 	if (nr = 19 && data->REG_PWM[3] = NULL) /* pwm_max */
 		return 0;
 	if (nr = 20 && data->REG_PWM[4] = NULL) /* pwm_step */
@@ -2949,11 +2962,11 @@ static struct sensor_device_template *nct6775_attributes_pwm_template[] = {
 	&sensor_dev_template_pwm_step_down_time,
 	&sensor_dev_template_pwm_start,
 	&sensor_dev_template_pwm_floor,
-	&sensor_dev_template_pwm_weight_temp_sel,
+	&sensor_dev_template_pwm_weight_temp_sel,	/* 14 */
 	&sensor_dev_template_pwm_weight_temp_step,
 	&sensor_dev_template_pwm_weight_temp_step_tol,
 	&sensor_dev_template_pwm_weight_temp_step_base,
-	&sensor_dev_template_pwm_weight_duty_step,
+	&sensor_dev_template_pwm_weight_duty_step,	/* 18 */
 	&sensor_dev_template_pwm_max,			/* 19 */
 	&sensor_dev_template_pwm_step,			/* 20 */
 	&sensor_dev_template_pwm_weight_duty_base,	/* 21 */
@@ -3615,8 +3628,8 @@ static int nct6775_probe(struct platform_device *pdev)
 		data->REG_PWM[0] = NCT6775_REG_PWM;
 		data->REG_PWM[1] = NCT6775_REG_FAN_START_OUTPUT;
 		data->REG_PWM[2] = NCT6775_REG_FAN_STOP_OUTPUT;
-		data->REG_PWM[5] = NCT6775_REG_WEIGHT_DUTY_STEP;
-		data->REG_PWM[6] = NCT6776_REG_WEIGHT_DUTY_BASE;
+		data->REG_PWM[5] = NCT6791_REG_WEIGHT_DUTY_STEP;
+		data->REG_PWM[6] = NCT6791_REG_WEIGHT_DUTY_BASE;
 		data->REG_PWM_READ = NCT6775_REG_PWM_READ;
 		data->REG_PWM_MODE = NCT6776_REG_PWM_MODE;
 		data->PWM_MODE_MASK = NCT6776_PWM_MODE_MASK;
@@ -3632,10 +3645,10 @@ static int nct6775_probe(struct platform_device *pdev)
 		data->REG_TEMP_OFFSET = NCT6779_REG_TEMP_OFFSET;
 		data->REG_TEMP_SOURCE = NCT6775_REG_TEMP_SOURCE;
 		data->REG_TEMP_SEL = NCT6775_REG_TEMP_SEL;
-		data->REG_WEIGHT_TEMP_SEL = NCT6775_REG_WEIGHT_TEMP_SEL;
-		data->REG_WEIGHT_TEMP[0] = NCT6775_REG_WEIGHT_TEMP_STEP;
-		data->REG_WEIGHT_TEMP[1] = NCT6775_REG_WEIGHT_TEMP_STEP_TOL;
-		data->REG_WEIGHT_TEMP[2] = NCT6775_REG_WEIGHT_TEMP_BASE;
+		data->REG_WEIGHT_TEMP_SEL = NCT6791_REG_WEIGHT_TEMP_SEL;
+		data->REG_WEIGHT_TEMP[0] = NCT6791_REG_WEIGHT_TEMP_STEP;
+		data->REG_WEIGHT_TEMP[1] = NCT6791_REG_WEIGHT_TEMP_STEP_TOL;
+		data->REG_WEIGHT_TEMP[2] = NCT6791_REG_WEIGHT_TEMP_BASE;
 		data->REG_ALARM = NCT6791_REG_ALARM;
 		data->REG_BEEP = NCT6776_REG_BEEP;
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
