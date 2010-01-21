From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 21 Jan 2010 13:48:20 +0000
Subject: [lm-sensors] [PATCH 1/8] hwmon: (it87) Display fan outputs in
Message-Id: <20100121144820.7d933c2a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali@linux-fr.org>
Subject: hwmon: (it87) Display fan outputs in automatic mode as such

The it87 driver doesn't yet support automatic fan control. Let it at
least tell the user when a fan output is in automatic mode. Also let
the user switch from automatic mode (possibly set by the BIOS) to
manual mode and back without losing the settings.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/it87.c |  100 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 62 insertions(+), 38 deletions(-)

--- linux-2.6.33-rc4.orig/drivers/hwmon/it87.c	2010-01-18 09:47:27.000000000 +0100
+++ linux-2.6.33-rc4/drivers/hwmon/it87.c	2010-01-18 11:10:00.000000000 +0100
@@ -281,7 +281,14 @@ struct it87_data {
 	u32 alarms;		/* Register encoding, combined */
 	u8 fan_main_ctrl;	/* Register value */
 	u8 fan_ctl;		/* Register value */
-	u8 manual_pwm_ctl[3];   /* manual PWM value set by user */
+
+	/* The following 3 arrays correspond to the same registers. The
+	 * meaning of bits 6-0 depends on the value of bit 7, and we want
+	 * to preserve settings on mode changes, so we have to track all
+	 * values separately. */
+	u8 pwm_ctrl[3];		/* Register value */
+	u8 pwm_duty[3];		/* Manual PWM value set by user (bit 6-0) */
+	u8 pwm_temp_map[3];	/* PWM to temp. chan. mapping (bits 1-0) */
 };
 
 static inline int has_16bit_fans(const struct it87_data *data)
@@ -531,6 +538,19 @@ show_sensor_offset(2);
 show_sensor_offset(3);
 
 /* 3 Fans */
+
+static int pwm_mode(const struct it87_data *data, int nr)
+{
+	int ctrl = data->fan_main_ctrl & (1 << nr);
+
+	if (ctrl = 0)					/* Full speed */
+		return 0;
+	if (data->pwm_ctrl[nr] & 0x80)			/* Automatic mode */
+		return 2;
+	else						/* Manual mode */
+		return 1;
+}
+
 static ssize_t show_fan(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
@@ -567,7 +587,7 @@ static ssize_t show_pwm_enable(struct de
 	int nr = sensor_attr->index;
 
 	struct it87_data *data = it87_update_device(dev);
-	return sprintf(buf,"%d\n", (data->fan_main_ctrl & (1 << nr)) ? 1 : 0);
+	return sprintf(buf, "%d\n", pwm_mode(data, nr));
 }
 static ssize_t show_pwm(struct device *dev, struct device_attribute *attr,
 		char *buf)
@@ -576,7 +596,7 @@ static ssize_t show_pwm(struct device *d
 	int nr = sensor_attr->index;
 
 	struct it87_data *data = it87_update_device(dev);
-	return sprintf(buf,"%d\n", data->manual_pwm_ctl[nr]);
+	return sprintf(buf, "%d\n", PWM_FROM_REG(data->pwm_duty[nr]));
 }
 static ssize_t show_pwm_freq(struct device *dev, struct device_attribute *attr,
 		char *buf)
@@ -660,6 +680,9 @@ static ssize_t set_pwm_enable(struct dev
 	struct it87_data *data = dev_get_drvdata(dev);
 	int val = simple_strtol(buf, NULL, 10);
 
+	if (val < 0 || val > 2)
+		return -EINVAL;
+
 	mutex_lock(&data->update_lock);
 
 	if (val = 0) {
@@ -670,15 +693,15 @@ static ssize_t set_pwm_enable(struct dev
 		/* set on/off mode */
 		data->fan_main_ctrl &= ~(1 << nr);
 		it87_write_value(data, IT87_REG_FAN_MAIN_CTRL, data->fan_main_ctrl);
-	} else if (val = 1) {
+	} else {
+		if (val = 1)				/* Manual mode */
+			data->pwm_ctrl[nr] = data->pwm_duty[nr];
+		else					/* Automatic mode */
+			data->pwm_ctrl[nr] = 0x80 | data->pwm_temp_map[nr];
+		it87_write_value(data, IT87_REG_PWM(nr), data->pwm_ctrl[nr]);
 		/* set SmartGuardian mode */
 		data->fan_main_ctrl |= (1 << nr);
 		it87_write_value(data, IT87_REG_FAN_MAIN_CTRL, data->fan_main_ctrl);
-		/* set saved pwm value, clear FAN_CTLX PWM mode bit */
-		it87_write_value(data, IT87_REG_PWM(nr), PWM_TO_REG(data->manual_pwm_ctl[nr]));
-	} else {
-		mutex_unlock(&data->update_lock);
-		return -EINVAL;
 	}
 
 	mutex_unlock(&data->update_lock);
@@ -697,9 +720,13 @@ static ssize_t set_pwm(struct device *de
 		return -EINVAL;
 
 	mutex_lock(&data->update_lock);
-	data->manual_pwm_ctl[nr] = val;
-	if (data->fan_main_ctrl & (1 << nr))
-		it87_write_value(data, IT87_REG_PWM(nr), PWM_TO_REG(data->manual_pwm_ctl[nr]));
+	data->pwm_duty[nr] = PWM_TO_REG(val);
+	/* If we are in manual mode, write the duty cycle immediately;
+	 * otherwise, just store it for later use. */
+	if (!(data->pwm_ctrl[nr] & 0x80)) {
+		data->pwm_ctrl[nr] = data->pwm_duty[nr];
+		it87_write_value(data, IT87_REG_PWM(nr), data->pwm_ctrl[nr]);
+	}
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -1387,15 +1414,18 @@ static void __devinit it87_init_device(s
 	int tmp, i;
 	u8 mask;
 
-	/* initialize to sane defaults:
-	 * - if the chip is in manual pwm mode, this will be overwritten with
-	 *   the actual settings on the chip (so in this case, initialization
-	 *   is not needed)
-	 * - if in automatic or on/off mode, we could switch to manual mode,
-	 *   read the registers and set manual_pwm_ctl accordingly, but currently
-	 *   this is not implemented, so we initialize to something sane */
+	/* For each PWM channel:
+	 * - If it is in automatic mode, setting to manual mode should set
+	 *   the fan to full speed by default.
+	 * - If it is in manual mode, we need a mapping to temperature
+	 *   channels to use when later setting to automatic mode later.
+	 *   Use a 1:1 mapping by default (we are clueless.)
+	 * In both cases, the value can (and should) be changed by the user
+	 * prior to switching to a different mode. */
 	for (i = 0; i < 3; i++) {
-		data->manual_pwm_ctl[i] = 0xff;
+		data->pwm_temp_map[i] = i;
+		data->pwm_duty[i] = 0x7f;	/* Full speed */
+
 	}
 
 	/* Some chips seem to have default value 0xff for all limit
@@ -1461,30 +1491,21 @@ static void __devinit it87_init_device(s
 	/* Fan input pins may be used for alternative functions */
 	data->has_fan &= ~sio_data->skip_fan;
 
-	/* Set current fan mode registers and the default settings for the
-	 * other mode registers */
-	for (i = 0; i < 3; i++) {
-		if (data->fan_main_ctrl & (1 << i)) {
-			/* pwm mode */
-			tmp = it87_read_value(data, IT87_REG_PWM(i));
-			if (tmp & 0x80) {
-				/* automatic pwm - not yet implemented, but
-				 * leave the settings made by the BIOS alone
-				 * until a change is requested via the sysfs
-				 * interface */
-			} else {
-				/* manual pwm */
-				data->manual_pwm_ctl[i] = PWM_FROM_REG(tmp);
-			}
-		}
- 	}
-
 	/* Start monitoring */
 	it87_write_value(data, IT87_REG_CONFIG,
 			 (it87_read_value(data, IT87_REG_CONFIG) & 0x36)
 			 | (update_vbat ? 0x41 : 0x01));
 }
 
+static void it87_update_pwm_ctrl(struct it87_data *data, int nr)
+{
+	data->pwm_ctrl[nr] = it87_read_value(data, IT87_REG_PWM(nr));
+	if (data->pwm_ctrl[nr] & 0x80)	/* Automatic mode */
+		data->pwm_temp_map[nr] = data->pwm_ctrl[nr] & 0x03;
+	else				/* Manual mode */
+		data->pwm_duty[nr] = data->pwm_ctrl[nr] & 0x7f;
+}
+
 static struct it87_data *it87_update_device(struct device *dev)
 {
 	struct it87_data *data = dev_get_drvdata(dev);
@@ -1551,9 +1572,12 @@ static struct it87_data *it87_update_dev
 			it87_read_value(data, IT87_REG_ALARM1) |
 			(it87_read_value(data, IT87_REG_ALARM2) << 8) |
 			(it87_read_value(data, IT87_REG_ALARM3) << 16);
+
 		data->fan_main_ctrl = it87_read_value(data,
 				IT87_REG_FAN_MAIN_CTRL);
 		data->fan_ctl = it87_read_value(data, IT87_REG_FAN_CTL);
+		for (i = 0; i < 3; i++)
+			it87_update_pwm_ctrl(data, i);
 
 		data->sensor = it87_read_value(data, IT87_REG_TEMP_ENABLE);
 		/* The 8705 does not have VID capability.


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
