From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 15 Sep 2010 14:01:28 +0000
Subject: [lm-sensors] [patch 27/36] hwmon: (w83795) Drop _NUM constants
Message-Id: <20100915160128.470e661c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Consistently use ARRAY_SIZE() to control for loops.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83795.c |   16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

--- linux-2.6.36-rc4.orig/drivers/hwmon/w83795.c	2010-09-15 15:14:05.000000000 +0200
+++ linux-2.6.36-rc4/drivers/hwmon/w83795.c	2010-09-15 15:14:08.000000000 +0200
@@ -145,8 +145,6 @@ static const u8 W83795_REG_IN_HL_LSB[]  	(((type) = 1) ? W83795_REG_IN_HL_LSB[(index)] \
 	: (W83795_REG_IN_HL_LSB[(index)] + 1))
 
-#define IN_LSB_REG_NUM			10
-
 #define IN_LSB_SHIFT			0
 #define IN_LSB_IDX			1
 static const u8 IN_LSB_SHIFT_IDX[][2] = {
@@ -183,14 +181,12 @@ static const u8 IN_LSB_SHIFT_IDX[][2]  
 #define W83795_REG_VID_CTRL		0x6A
 
-#define ALARM_BEEP_REG_NUM		6
 #define W83795_REG_ALARM(index)		(0x41 + (index))
 #define W83795_REG_BEEP(index)		(0x50 + (index))
 
 #define W83795_REG_CLR_CHASSIS		0x4D
 
 
-#define W83795_REG_TEMP_NUM		6
 #define W83795_REG_FCMS1		0x201
 #define W83795_REG_FCMS2		0x208
 #define W83795_REG_TFMR(index)		(0x202 + (index))
@@ -545,7 +541,7 @@ static struct w83795_data *w83795_update
 	}
 
 	/* update alarm */
-	for (i = 0; i < ALARM_BEEP_REG_NUM; i++)
+	for (i = 0; i < ARRAY_SIZE(data->alarms); i++)
 		data->alarms[i] = w83795_read(client, W83795_REG_ALARM(i));
 
 	data->last_updated = jiffies;
@@ -1978,7 +1974,7 @@ static int w83795_probe(struct i2c_clien
 		tmp |= w83795_read(client, W83795_REG_VRLSB) >> 6;
 		data->in[i][IN_READ] = tmp;
 	}
-	for (i = 0; i < IN_LSB_REG_NUM; i++) {
+	for (i = 0; i < ARRAY_SIZE(data->in_lsb); i++) {
 		if ((i = 2 && data->chip_type = w83795adg) ||
 		    (i >= 4 && !(data->has_in & (1 << (i + 11)))))
 			continue;
@@ -2054,7 +2050,7 @@ static int w83795_probe(struct i2c_clien
 		data->has_pwm = 2;
 	data->pwm_fcms[0] = w83795_read(client, W83795_REG_FCMS1);
 	data->pwm_fcms[1] = w83795_read(client, W83795_REG_FCMS2);
-	for (i = 0; i < W83795_REG_TEMP_NUM; i++)
+	for (i = 0; i < ARRAY_SIZE(data->pwm_tfmr); i++)
 		data->pwm_tfmr[i] = w83795_read(client, W83795_REG_TFMR(i));
 	data->pwm_fomc = w83795_read(client, W83795_REG_FOMC);
 	for (i = 0; i < data->has_pwm; i++) {
@@ -2071,7 +2067,7 @@ static int w83795_probe(struct i2c_clien
 	}
 	data->tol_speed = w83795_read(client, W83795_REG_TFTS) & 0x3f;
 
-	for (i = 0; i < W83795_REG_TEMP_NUM; i++) {
+	for (i = 0; i < ARRAY_SIZE(data->pwm_temp); i++) {
 		data->pwm_temp[i][TEMP_PWM_TTTI]  			w83795_read(client, W83795_REG_TTTI(i)) & 0x7f;
 		data->pwm_temp[i][TEMP_PWM_CTFS] @@ -2080,7 +2076,7 @@ static int w83795_probe(struct i2c_clien
 		data->pwm_temp[i][TEMP_PWM_HCT] = (tmp >> 4) & 0x0f;
 		data->pwm_temp[i][TEMP_PWM_HOT] = tmp & 0x0f;
 	}
-	for (i = 0; i < W83795_REG_TEMP_NUM; i++) {
+	for (i = 0; i < ARRAY_SIZE(data->sf4_reg); i++) {
 		for (tmp = 0; tmp < 7; tmp++) {
 			data->sf4_reg[i][SF4_TEMP][tmp]  				w83795_read(client,
@@ -2097,7 +2093,7 @@ static int w83795_probe(struct i2c_clien
 	}
 
 	/* alarm and beep */
-	for (i = 0; i < ALARM_BEEP_REG_NUM; i++) {
+	for (i = 0; i < ARRAY_SIZE(data->alarms); i++) {
 		data->alarms[i] = w83795_read(client, W83795_REG_ALARM(i));
 		data->beeps[i] = w83795_read(client, W83795_REG_BEEP(i));
 	}


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
