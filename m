From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 15 Sep 2010 14:01:50 +0000
Subject: [lm-sensors] [patch 29/36] hwmon: (w83795) Dont pre-read values
Message-Id: <20100915160150.2f9d9329@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

There is no point in reading registers during initialization if we
will refresh the values in the update function later. This is only
slowing down the driver loading with no benefit, stop doing it.
This change saves 480 ms on driver load on my test system.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83795.c |   33 +++++++--------------------------
 1 file changed, 7 insertions(+), 26 deletions(-)

--- linux-2.6.36-rc4.orig/drivers/hwmon/w83795.c	2010-09-15 15:14:11.000000000 +0200
+++ linux-2.6.36-rc4/drivers/hwmon/w83795.c	2010-09-15 15:14:13.000000000 +0200
@@ -1903,7 +1903,7 @@ static int w83795_probe(struct i2c_clien
 		}
 	}
 
-	/* First update the voltages measured value and limits */
+	/* Read the voltage limits */
 	for (i = 0; i < ARRAY_SIZE(data->in); i++) {
 		if (!(data->has_in & (1 << i)))
 			continue;
@@ -1911,9 +1911,6 @@ static int w83795_probe(struct i2c_clien
 			w83795_read(client, W83795_REG_IN[i][IN_MAX]);
 		data->in[i][IN_LOW]  			w83795_read(client, W83795_REG_IN[i][IN_LOW]);
-		tmp = w83795_read(client, W83795_REG_IN[i][IN_READ]) << 2;
-		tmp |= w83795_read(client, W83795_REG_VRLSB) >> 6;
-		data->in[i][IN_READ] = tmp;
 	}
 	for (i = 0; i < ARRAY_SIZE(data->in_lsb); i++) {
 		if ((i = 2 && data->chip_type = w83795adg) ||
@@ -1926,7 +1923,7 @@ static int w83795_probe(struct i2c_clien
 	}
 	data->has_gain = w83795_read(client, W83795_REG_VMIGB_CTRL) & 0x0f;
 
-	/* First update fan and limits */
+	/* Read the fan limits */
 	for (i = 0; i < ARRAY_SIZE(data->fan); i++) {
 		/* Each register contains LSB for 2 fans, but we want to
 		 * read it only once to save time */
@@ -1939,11 +1936,9 @@ static int w83795_probe(struct i2c_clien
 			w83795_read(client, W83795_REG_FAN_MIN_HL(i)) << 4;
 		data->fan_min[i] | 			(tmp >> W83795_REG_FAN_MIN_LSB_SHIFT(i)) & 0x0F;
-		data->fan[i] = w83795_read(client, W83795_REG_FAN(i)) << 4;
-		data->fan[i] |= w83795_read(client, W83795_REG_VRLSB) >> 4;
 	}
 
-	/* temperature and limits */
+	/* Read the temperature limits */
 	for (i = 0; i < ARRAY_SIZE(data->temp); i++) {
 		if (!(data->has_temp & (1 << i)))
 			continue;
@@ -1955,13 +1950,9 @@ static int w83795_probe(struct i2c_clien
 			w83795_read(client, W83795_REG_TEMP[i][TEMP_WARN]);
 		data->temp[i][TEMP_WARN_HYST]  			w83795_read(client, W83795_REG_TEMP[i][TEMP_WARN_HYST]);
-		data->temp[i][TEMP_READ] -			w83795_read(client, W83795_REG_TEMP[i][TEMP_READ]);
-		data->temp_read_vrlsb[i] -			w83795_read(client, W83795_REG_VRLSB);
 	}
 
-	/* dts temperature and limits */
+	/* Read the DTS limits */
 	if (data->enable_dts != 0) {
 		data->dts_ext[DTS_CRIT]  			w83795_read(client, W83795_REG_DTS_EXT(DTS_CRIT));
@@ -1971,13 +1962,6 @@ static int w83795_probe(struct i2c_clien
 			w83795_read(client, W83795_REG_DTS_EXT(DTS_WARN));
 		data->dts_ext[DTS_WARN_HYST]  			w83795_read(client, W83795_REG_DTS_EXT(DTS_WARN_HYST));
-		for (i = 0; i < ARRAY_SIZE(data->dts); i++) {
-			if (!(data->has_dts & (1 << i)))
-				continue;
-			data->dts[i] = w83795_read(client, W83795_REG_DTS(i));
-			data->dts_read_vrlsb[i] -				w83795_read(client, W83795_REG_VRLSB);
-		}
 	}
 
 	/* First update temp source selction */
@@ -1995,10 +1979,9 @@ static int w83795_probe(struct i2c_clien
 		data->pwm_tfmr[i] = w83795_read(client, W83795_REG_TFMR(i));
 	data->pwm_fomc = w83795_read(client, W83795_REG_FOMC);
 	for (i = 0; i < data->has_pwm; i++) {
-		for (tmp = 0; tmp < 5; tmp++) {
+		for (tmp = PWM_START; tmp <= PWM_FREQ; tmp++)
 			data->pwm[i][tmp]  				w83795_read(client, W83795_REG_PWM(i, tmp));
-		}
 	}
 	for (i = 0; i < 8; i++) {
 		data->target_speed[i] @@ -2033,11 +2016,9 @@ static int w83795_probe(struct i2c_clien
 			w83795_read(client, W83795_REG_SETUP_PWM(i));
 	}
 
-	/* alarm and beep */
-	for (i = 0; i < ARRAY_SIZE(data->alarms); i++) {
-		data->alarms[i] = w83795_read(client, W83795_REG_ALARM(i));
+	/* Read beep settings */
+	for (i = 0; i < ARRAY_SIZE(data->beeps); i++)
 		data->beeps[i] = w83795_read(client, W83795_REG_BEEP(i));
-	}
 
 	err = w83795_handle_files(dev, device_create_file);
 	if (err)


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
