From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 14 Dec 2008 14:33:48 +0000
Subject: [lm-sensors] PATCH: f71882fg: cleanup fan and temp hyst functions
Message-Id: <4945194C.5030903@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------080004080306070004060504"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------080004080306070004060504
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jean,

As discussed during the review here is a separate version of the hyst cleanup 
changes. This version makes the same changes in some other places of the driver 
too for consistency throughout the driver.

Thanks & Regards,

Hans

--------------080004080306070004060504
Content-Type: text/plain;
	name="hwmon-f71882fg-09-simplify-hyst-functions.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="hwmon-f71882fg-09-simplify-hyst-functions.patch"

Simplify fan and temp hyst. handling by treating the registers as an array of
nibbles instead of using switch cases. Also unify the way hysts are handled
between temp and fans, the temp code was storing the actual per temp hyst
values in 4 u8's, where as the fan code was stroing actual register values.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
--- linux/drivers/hwmon/f71882fg.c.08-applied	2008-12-14 14:22:40.000000000 +0100
+++ linux/drivers/hwmon/f71882fg.c	2008-12-14 15:16:30.000000000 +0100
@@ -68,8 +68,7 @@
 #define F71882FG_REG_TEMP_HIGH(nr)	(0x81 + 2 * (nr))
 #define F71882FG_REG_TEMP_STATUS	0x62
 #define F71882FG_REG_TEMP_BEEP		0x63
-#define F71882FG_REG_TEMP_HYST1		0x6C
-#define F71882FG_REG_TEMP_HYST23	0x6D
+#define F71882FG_REG_TEMP_HYST(nr)	(0x6C + (nr))
 #define F71882FG_REG_TEMP_TYPE		0x6B
 #define F71882FG_REG_TEMP_DIODE_OPEN	0x6F
 
@@ -77,8 +76,7 @@
 #define F71882FG_REG_PWM_TYPE		0x94
 #define F71882FG_REG_PWM_ENABLE		0x96
 
-#define F71882FG_REG_FAN_HYST0		0x98
-#define F71882FG_REG_FAN_HYST1		0x99
+#define F71882FG_REG_FAN_HYST(nr)	(0x98 + (nr))
 
 #define F71882FG_REG_POINT_PWM(pwm, point)	(0xAA + (point) + (16 * (pwm)))
 #define F71882FG_REG_POINT_TEMP(pwm, point)	(0xA6 + (point) + (16 * (pwm)))
@@ -144,7 +142,7 @@
 	u8	temp[4];
 	u8	temp_ovt[4];
 	u8	temp_high[4];
-	u8	temp_hyst[4];
+	u8	temp_hyst[2]; /* 2 hysts stored per reg */
 	u8	temp_type[4];
 	u8	temp_status;
 	u8	temp_beep;
@@ -688,13 +686,11 @@
 						F71882FG_REG_TEMP_HIGH(nr));
 		}
 
-		/* Have to hardcode hyst*/
-		data->temp_hyst[1] = f71882fg_read8(data,
-						F71882FG_REG_TEMP_HYST1) >> 4;
-		/* Hyst temps 2 & 3 stored in same register */
-		reg = f71882fg_read8(data, F71882FG_REG_TEMP_HYST23);
-		data->temp_hyst[2] = reg & 0x0F;
-		data->temp_hyst[3] = reg >> 4;
+		/* hyst */
+		data->temp_hyst[0] =
+			f71882fg_read8(data, F71882FG_REG_TEMP_HYST(0));
+		data->temp_hyst[1] =
+			f71882fg_read8(data, F71882FG_REG_TEMP_HYST(1));
 
 		/* Have to hardcode type, because temp1 is special */
 		reg  = f71882fg_read8(data, F71882FG_REG_TEMP_TYPE);
@@ -715,10 +711,11 @@
 
 		data->pwm_enable = f71882fg_read8(data,
 						  F71882FG_REG_PWM_ENABLE);
-		data->pwm_auto_point_hyst[0] = f71882fg_read8(data,
-						      F71882FG_REG_FAN_HYST0);
-		data->pwm_auto_point_hyst[1] = f71882fg_read8(data,
-						      F71882FG_REG_FAN_HYST1);
+		data->pwm_auto_point_hyst[0] =
+			f71882fg_read8(data, F71882FG_REG_FAN_HYST(0));
+		data->pwm_auto_point_hyst[1] =
+			f71882fg_read8(data, F71882FG_REG_FAN_HYST(1));
+
 		for (nr = 0; nr < nr_fans; nr++) {
 			data->pwm_auto_point_mapping[nr] =
 			    f71882fg_read8(data,
@@ -1011,7 +1008,11 @@
 	int temp_max_hyst;
 
 	mutex_lock(&data->update_lock);
-	temp_max_hyst = (data->temp_high[nr] - data->temp_hyst[nr]) * 1000;
+	if (nr & 1)
+		temp_max_hyst = data->temp_hyst[nr / 2] >> 4;
+	else
+		temp_max_hyst = data->temp_hyst[nr / 2] & 0x0f;
+	temp_max_hyst = (data->temp_high[nr] - temp_max_hyst) * 1000;
 	mutex_unlock(&data->update_lock);
 
 	return sprintf(buf, "%d\n", temp_max_hyst);
@@ -1033,26 +1034,15 @@
 	val = SENSORS_LIMIT(val, data->temp_high[nr] - 15,
 			    data->temp_high[nr]);
 	val = data->temp_high[nr] - val;
-	data->temp_hyst[nr] = val;
 
 	/* convert value to register contents */
-	switch (nr) {
-		case 1:
-			reg = f71882fg_read8(data, F71882FG_REG_TEMP_HYST1);
-			reg = (reg & 0x0f) | (val << 4);
-			break;
-		case 2:
-			reg = f71882fg_read8(data, F71882FG_REG_TEMP_HYST23);
-			reg = (reg & 0xf0) | val;
-			break;
-		case 3:
-			reg = f71882fg_read8(data, F71882FG_REG_TEMP_HYST23);
-			reg = (reg & 0x0f) | (val << 4);
-			break;
-	}
-
-	f71882fg_write8(data, (nr <= 1) ? F71882FG_REG_TEMP_HYST1 :
-		F71882FG_REG_TEMP_HYST23, reg);
+	reg = f71882fg_read8(data, F71882FG_REG_TEMP_HYST(nr / 2));
+	if (nr & 1)
+		reg = (reg & 0x0f) | (val << 4);
+	else
+		reg = (reg & 0xf0) | val;
+	f71882fg_write8(data, F71882FG_REG_TEMP_HYST(nr / 2), reg);
+	data->temp_hyst[nr / 2] = reg;
 
 	mutex_unlock(&data->update_lock);
 	return ret;
@@ -1091,7 +1081,11 @@
 	int temp_crit_hyst;
 
 	mutex_lock(&data->update_lock);
-	temp_crit_hyst = (data->temp_ovt[nr] - data->temp_hyst[nr]) * 1000;
+	if (nr & 1)
+		temp_crit_hyst = data->temp_hyst[nr / 2] >> 4;
+	else
+		temp_crit_hyst = data->temp_hyst[nr / 2] & 0x0f;
+	temp_crit_hyst = (data->temp_ovt[nr] - temp_crit_hyst) * 1000;
 	mutex_unlock(&data->update_lock);
 
 	return sprintf(buf, "%d\n", temp_crit_hyst);
@@ -1320,20 +1314,10 @@
 	int point = to_sensor_dev_attr_2(devattr)->nr;
 
 	mutex_lock(&data->update_lock);
-	switch (nr) {
-	case 0:
-		result = data->pwm_auto_point_hyst[0] & 0x0f;
-		break;
-	case 1:
-		result = data->pwm_auto_point_hyst[0] >> 4;
-		break;
-	case 2:
-		result = data->pwm_auto_point_hyst[1] & 0x0f;
-		break;
-	case 3:
-		result = data->pwm_auto_point_hyst[1] >> 4;
-		break;
-	}
+	if (nr & 1)
+		result = data->pwm_auto_point_hyst[nr / 2] >> 4;
+	else
+		result = data->pwm_auto_point_hyst[nr / 2] & 0x0f;
 	result = 1000 * (data->pwm_auto_point_temp[nr][point] - result);
 	mutex_unlock(&data->update_lock);
 
@@ -1348,6 +1332,7 @@
 	int nr = to_sensor_dev_attr_2(devattr)->index;
 	int point = to_sensor_dev_attr_2(devattr)->nr;
 	long val = simple_strtol(buf, NULL, 10) / 1000;
+	u8 reg;
 
 	mutex_lock(&data->update_lock);
 	data->pwm_auto_point_temp[nr][point] =
@@ -1356,34 +1341,14 @@
 				data->pwm_auto_point_temp[nr][point]);
 	val = data->pwm_auto_point_temp[nr][point] - val;
 
-	if (nr == 0 || nr == 1) {
-		data->pwm_auto_point_hyst[0] =
-			f71882fg_read8(data, F71882FG_REG_FAN_HYST0, val);
-	} else {
-		data->pwm_auto_point_hyst[1] =
-			f71882fg_read8(data, F71882FG_REG_FAN_HYST1, val);
-	}
-	switch (nr) {
-	case 0:
-		val = (data->pwm_auto_point_hyst[0] & 0xf0) | val;
-		break;
-	case 1:
-		val = (data->pwm_auto_point_hyst[0] & 0x0f) | (val << 4);
-		break;
-	case 2:
-		val = (data->pwm_auto_point_hyst[1] & 0xf0) | val;
-		break;
-	case 3:
-		val = (data->pwm_auto_point_hyst[1] & 0x0f) | (val << 4);
-		break;
-	}
-	if (nr == 0 || nr == 1) {
-		f71882fg_write8(data, F71882FG_REG_FAN_HYST0, val);
-		data->pwm_auto_point_hyst[0] = val;
-	} else {
-		f71882fg_write8(data, F71882FG_REG_FAN_HYST1, val);
-		data->pwm_auto_point_hyst[1] = val;
-	}
+	reg = f71882fg_read8(data, F71882FG_REG_FAN_HYST(nr / 2));
+	if (nr & 1)
+		reg = (reg & 0x0f) | (val << 4);
+	else
+		reg = (reg & 0xf0) | val;
+
+	f71882fg_write8(data, F71882FG_REG_FAN_HYST(nr / 2), reg);
+	data->pwm_auto_point_hyst[nr / 2] = reg;
 	mutex_unlock(&data->update_lock);
 
 	return count;

--------------080004080306070004060504
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------080004080306070004060504--
