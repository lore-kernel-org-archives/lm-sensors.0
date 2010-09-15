From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 15 Sep 2010 14:02:25 +0000
Subject: [lm-sensors] [patch 32/36] hwmon: (w83795) Move register reads to
Message-Id: <20100915160225.263c70bd@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Move initial register reads out of probe, to dedicated functions.
This makes the code clearer, and will be needed if we want to delay
calling these functions until they are needed, or want to call them
periodically.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83795.c |  218 ++++++++++++++++++++++++++----------------------
 1 file changed, 119 insertions(+), 99 deletions(-)

--- linux-2.6.36-rc4.orig/drivers/hwmon/w83795.c	2010-09-15 15:15:29.000000000 +0200
+++ linux-2.6.36-rc4/drivers/hwmon/w83795.c	2010-09-15 15:15:33.000000000 +0200
@@ -438,6 +438,123 @@ static int w83795_write(struct i2c_clien
 	return err;
 }
 
+static void w83795_update_limits(struct i2c_client *client)
+{
+	struct w83795_data *data = i2c_get_clientdata(client);
+	int i, limit;
+
+	/* Read the voltage limits */
+	for (i = 0; i < ARRAY_SIZE(data->in); i++) {
+		if (!(data->has_in & (1 << i)))
+			continue;
+		data->in[i][IN_MAX] +			w83795_read(client, W83795_REG_IN[i][IN_MAX]);
+		data->in[i][IN_LOW] +			w83795_read(client, W83795_REG_IN[i][IN_LOW]);
+	}
+	for (i = 0; i < ARRAY_SIZE(data->in_lsb); i++) {
+		if ((i = 2 && data->chip_type = w83795adg) ||
+		    (i >= 4 && !(data->has_in & (1 << (i + 11)))))
+			continue;
+		data->in_lsb[i][IN_MAX] +			w83795_read(client, IN_LSB_REG(i, IN_MAX));
+		data->in_lsb[i][IN_LOW] +			w83795_read(client, IN_LSB_REG(i, IN_LOW));
+	}
+
+	/* Read the fan limits */
+	for (i = 0; i < ARRAY_SIZE(data->fan); i++) {
+		u8 lsb;
+
+		/* Each register contains LSB for 2 fans, but we want to
+		 * read it only once to save time */
+		if ((i & 1) = 0 && (data->has_fan & (3 << i)))
+			lsb = w83795_read(client, W83795_REG_FAN_MIN_LSB(i));
+
+		if (!(data->has_fan & (1 << i)))
+			continue;
+		data->fan_min[i] +			w83795_read(client, W83795_REG_FAN_MIN_HL(i)) << 4;
+		data->fan_min[i] |+			(lsb >> W83795_REG_FAN_MIN_LSB_SHIFT(i)) & 0x0F;
+	}
+
+	/* Read the temperature limits */
+	for (i = 0; i < ARRAY_SIZE(data->temp); i++) {
+		if (!(data->has_temp & (1 << i)))
+			continue;
+		for (limit = TEMP_CRIT; limit <= TEMP_WARN_HYST; limit++)
+			data->temp[i][limit] +				w83795_read(client, W83795_REG_TEMP[i][limit]);
+	}
+
+	/* Read the DTS limits */
+	if (data->enable_dts != 0) {
+		for (limit = DTS_CRIT; limit <= DTS_WARN_HYST; limit++)
+			data->dts_ext[limit] +				w83795_read(client, W83795_REG_DTS_EXT(limit));
+	}
+
+	/* Read beep settings */
+	for (i = 0; i < ARRAY_SIZE(data->beeps); i++)
+		data->beeps[i] = w83795_read(client, W83795_REG_BEEP(i));
+}
+
+static void w83795_update_pwm_config(struct i2c_client *client)
+{
+	struct w83795_data *data = i2c_get_clientdata(client);
+	int i, tmp;
+
+	/* Read temperature source selection */
+	for (i = 0; i < ARRAY_SIZE(data->temp_src); i++)
+		data->temp_src[i] = w83795_read(client, W83795_REG_TSS(i));
+
+	/* Read automatic fan speed control settings */
+	data->pwm_fcms[0] = w83795_read(client, W83795_REG_FCMS1);
+	data->pwm_fcms[1] = w83795_read(client, W83795_REG_FCMS2);
+	for (i = 0; i < ARRAY_SIZE(data->pwm_tfmr); i++)
+		data->pwm_tfmr[i] = w83795_read(client, W83795_REG_TFMR(i));
+	data->pwm_fomc = w83795_read(client, W83795_REG_FOMC);
+	for (i = 0; i < data->has_pwm; i++) {
+		for (tmp = PWM_START; tmp <= PWM_FREQ; tmp++)
+			data->pwm[i][tmp] +				w83795_read(client, W83795_REG_PWM(i, tmp));
+	}
+	for (i = 0; i < ARRAY_SIZE(data->target_speed); i++) {
+		data->target_speed[i] +			w83795_read(client, W83795_REG_FTSH(i)) << 4;
+		data->target_speed[i] |+			w83795_read(client, W83795_REG_FTSL(i)) >> 4;
+	}
+	data->tol_speed = w83795_read(client, W83795_REG_TFTS) & 0x3f;
+
+	for (i = 0; i < ARRAY_SIZE(data->pwm_temp); i++) {
+		data->pwm_temp[i][TEMP_PWM_TTTI] +			w83795_read(client, W83795_REG_TTTI(i)) & 0x7f;
+		data->pwm_temp[i][TEMP_PWM_CTFS] +			w83795_read(client, W83795_REG_CTFS(i));
+		tmp = w83795_read(client, W83795_REG_HT(i));
+		data->pwm_temp[i][TEMP_PWM_HCT] = (tmp >> 4) & 0x0f;
+		data->pwm_temp[i][TEMP_PWM_HOT] = tmp & 0x0f;
+	}
+
+	/* Read SmartFanIV trip points */
+	for (i = 0; i < ARRAY_SIZE(data->sf4_reg); i++) {
+		for (tmp = 0; tmp < 7; tmp++) {
+			data->sf4_reg[i][SF4_TEMP][tmp] +				w83795_read(client,
+					    W83795_REG_SF4_TEMP(i, tmp));
+			data->sf4_reg[i][SF4_PWM][tmp] +				w83795_read(client, W83795_REG_SF4_PWM(i, tmp));
+		}
+	}
+
+	/* Read setup PWM */
+	for (i = 0; i < ARRAY_SIZE(data->setup_pwm); i++)
+		data->setup_pwm[i] +			w83795_read(client, W83795_REG_SETUP_PWM(i));
+}
+
 static struct w83795_data *w83795_update_device(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -1899,112 +2016,15 @@ static int w83795_probe(struct i2c_clien
 		}
 	}
 
-	/* Read the voltage limits */
-	for (i = 0; i < ARRAY_SIZE(data->in); i++) {
-		if (!(data->has_in & (1 << i)))
-			continue;
-		data->in[i][IN_MAX] -			w83795_read(client, W83795_REG_IN[i][IN_MAX]);
-		data->in[i][IN_LOW] -			w83795_read(client, W83795_REG_IN[i][IN_LOW]);
-	}
-	for (i = 0; i < ARRAY_SIZE(data->in_lsb); i++) {
-		if ((i = 2 && data->chip_type = w83795adg) ||
-		    (i >= 4 && !(data->has_in & (1 << (i + 11)))))
-			continue;
-		data->in_lsb[i][IN_MAX] -			w83795_read(client, IN_LSB_REG(i, IN_MAX));
-		data->in_lsb[i][IN_LOW] -			w83795_read(client, IN_LSB_REG(i, IN_LOW));
-	}
 	data->has_gain = w83795_read(client, W83795_REG_VMIGB_CTRL) & 0x0f;
-
-	/* Read the fan limits */
-	for (i = 0; i < ARRAY_SIZE(data->fan); i++) {
-		/* Each register contains LSB for 2 fans, but we want to
-		 * read it only once to save time */
-		if ((i & 1) = 0 && (data->has_fan & (3 << i)))
-			tmp = w83795_read(client, W83795_REG_FAN_MIN_LSB(i));
-
-		if (!(data->has_fan & (1 << i)))
-			continue;
-		data->fan_min[i] -			w83795_read(client, W83795_REG_FAN_MIN_HL(i)) << 4;
-		data->fan_min[i] |-			(tmp >> W83795_REG_FAN_MIN_LSB_SHIFT(i)) & 0x0F;
-	}
-
-	/* Read the temperature limits */
-	for (i = 0; i < ARRAY_SIZE(data->temp); i++) {
-		if (!(data->has_temp & (1 << i)))
-			continue;
-		for (tmp = TEMP_CRIT; tmp <= TEMP_WARN_HYST; tmp++)
-			data->temp[i][tmp] -				w83795_read(client, W83795_REG_TEMP[i][tmp]);
-	}
-
-	/* Read the DTS limits */
-	if (data->enable_dts != 0) {
-		for (i = DTS_CRIT; i <= DTS_WARN_HYST; i++)
-			data->dts_ext[i] -				w83795_read(client, W83795_REG_DTS_EXT(i));
-	}
-
-	/* First update temp source selction */
-	for (i = 0; i < 3; i++)
-		data->temp_src[i] = w83795_read(client, W83795_REG_TSS(i));
+	w83795_update_limits(client);
 
 	/* pwm and smart fan */
 	if (data->chip_type = w83795g)
 		data->has_pwm = 8;
 	else
 		data->has_pwm = 2;
-	data->pwm_fcms[0] = w83795_read(client, W83795_REG_FCMS1);
-	data->pwm_fcms[1] = w83795_read(client, W83795_REG_FCMS2);
-	for (i = 0; i < ARRAY_SIZE(data->pwm_tfmr); i++)
-		data->pwm_tfmr[i] = w83795_read(client, W83795_REG_TFMR(i));
-	data->pwm_fomc = w83795_read(client, W83795_REG_FOMC);
-	for (i = 0; i < data->has_pwm; i++) {
-		for (tmp = PWM_START; tmp <= PWM_FREQ; tmp++)
-			data->pwm[i][tmp] -				w83795_read(client, W83795_REG_PWM(i, tmp));
-	}
-	for (i = 0; i < 8; i++) {
-		data->target_speed[i] -			w83795_read(client, W83795_REG_FTSH(i)) << 4;
-		data->target_speed[i] |-			w83795_read(client, W83795_REG_FTSL(i)) >> 4;
-	}
-	data->tol_speed = w83795_read(client, W83795_REG_TFTS) & 0x3f;
-
-	for (i = 0; i < ARRAY_SIZE(data->pwm_temp); i++) {
-		data->pwm_temp[i][TEMP_PWM_TTTI] -			w83795_read(client, W83795_REG_TTTI(i)) & 0x7f;
-		data->pwm_temp[i][TEMP_PWM_CTFS] -			w83795_read(client, W83795_REG_CTFS(i));
-		tmp = w83795_read(client, W83795_REG_HT(i));
-		data->pwm_temp[i][TEMP_PWM_HCT] = (tmp >> 4) & 0x0f;
-		data->pwm_temp[i][TEMP_PWM_HOT] = tmp & 0x0f;
-	}
-	for (i = 0; i < ARRAY_SIZE(data->sf4_reg); i++) {
-		for (tmp = 0; tmp < 7; tmp++) {
-			data->sf4_reg[i][SF4_TEMP][tmp] -				w83795_read(client,
-					    W83795_REG_SF4_TEMP(i, tmp));
-			data->sf4_reg[i][SF4_PWM][tmp] -				w83795_read(client, W83795_REG_SF4_PWM(i, tmp));
-		}
-	}
-
-	/* Setup PWM Register */
-	for (i = 0; i < 3; i++) {
-		data->setup_pwm[i] -			w83795_read(client, W83795_REG_SETUP_PWM(i));
-	}
-
-	/* Read beep settings */
-	for (i = 0; i < ARRAY_SIZE(data->beeps); i++)
-		data->beeps[i] = w83795_read(client, W83795_REG_BEEP(i));
+	w83795_update_pwm_config(client);
 
 	err = w83795_handle_files(dev, device_create_file);
 	if (err)


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
