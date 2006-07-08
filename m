From: com.ea@tinet.org (com.ea)
Date: Sat, 08 Jul 2006 17:37:46 +0000
Subject: [lm-sensors] [PATCH] w83627hf and w83697hf - pwm and pwm clock
Message-Id: <7gqva212eqhh3frln1ea8ga01o92mq927j@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This patch modifies the following 3 files from the svn snapshot

lm-sensors-r4065-20060705.tar.bz2


1) kernel/chips/w83627hf.c

Brings the improvements I made to the 2.6 kernel driver w83627hf.c to the 2.4 kernel driver. The
"improvements" allow acces to the pwm clock selection registers and pwm clock scale registers (both
features are the same registers-> bit encoded)

2) lib/chips.c

Gives libsensors access to the new features (pwm clock) and also to other features present in the
driver that were not present in libsensors (pwm).

3) lib/chips.h 

I separated the defines for the 627hf and the 697hf, which were the same as W83782D and W83781D, but
still there is more work to be done.

pls any feedback is appreciated

Regards
Carlos
http://www.tinet.org/~com.ea/


==========================

diff -uprN lm-sensors-r4065-20060705.orig/kernel/chips/w83627hf.c
lm-sensors-r4065-20060705/kernel/chips/w83627hf.c
--- lm-sensors-r4065-20060705.orig/kernel/chips/w83627hf.c	2006-07-05 06:10:10.000000000 +0200
+++ lm-sensors-r4065-20060705/kernel/chips/w83627hf.c	2006-07-08 19:00:06.000000000 +0200
@@ -212,6 +212,15 @@ static const u8 regpwm[] = { W83627THF_R
 #define W836X7HF_REG_PWM(type, nr) (((type) = w83627hf) ? \
                                      regpwm_627hf[(nr) - 1] : regpwm[(nr) - 1])
 
+#define W83697HF_REG_PWMCLK1	0x00	/* Only for the 697HF */
+#define W83697HF_REG_PWMCLK2	0x02	/* Only for the 697HF */
+		 
+static const u8 reg_pwmclk_697hf[] = {W83697HF_REG_PWMCLK1, W83697HF_REG_PWMCLK2};
+							 
+#define W83627HF_REG_PWMCLK12	0x5C	/* Only for the 627HF */
+
+// To do : w83627thf, w83637hf and w83687thf pwmclk support
+							 
 #define W83781D_REG_I2C_ADDR 0x48
 #define W83781D_REG_I2C_SUBADDR 0x4A
 
@@ -311,6 +320,7 @@ struct w83627hf_data {
 	u32 beeps;		/* Register encoding, combined */
 	u8 beep_enable;		/* Boolean */
 	u8 pwm[3];		/* Register value */
+	u8 pwmclk[3];		/* Register value */
 	u16 sens[3];		/* 782D/783S only.
 				   1 = pentium diode; 2 = 3904 diode;
 				   3000-5000 = thermistor beta.
@@ -353,6 +363,8 @@ static void w83627hf_fan_div(struct i2c_
 			    int ctl_name, int *nrels_mag, long *results);
 static void w83627hf_pwm(struct i2c_client *client, int operation,
 			int ctl_name, int *nrels_mag, long *results);
+static void w83627hf_pwmclk(struct i2c_client *client, int operation,
+			int ctl_name, int *nrels_mag, long *results);
 static void w83627hf_sens(struct i2c_client *client, int operation,
 			 int ctl_name, int *nrels_mag, long *results);
 
@@ -369,6 +381,8 @@ static struct i2c_driver w83627hf_driver
    Note that the 627hf is supported by both drivers.
    Do not make incompatible changes here or we will have errors
    in the generated file ../include/sensors.h !!!
+   Added three entries for pwm clock selection and pwm clock scaling
+   W83781D_SYSCTL_PWMCLK
 */
 /* -- SENSORS SYSCTL START -- */
 
@@ -395,6 +409,9 @@ static struct i2c_driver w83627hf_driver
 #define W83781D_SYSCTL_SENS1 1501	/* 1, 2, or Beta (3000-5000) */
 #define W83781D_SYSCTL_SENS2 1502
 #define W83781D_SYSCTL_SENS3 1503
+#define W83781D_SYSCTL_PWMCLK1 1601
+#define W83781D_SYSCTL_PWMCLK2 1602
+#define W83781D_SYSCTL_PWMCLK3 1603
 #define W83781D_SYSCTL_FAN_DIV 2000	/* 1, 2, 4 or 8 */
 #define W83781D_SYSCTL_ALARMS 2001	/* bitvector */
 #define W83781D_SYSCTL_BEEP 2002	/* bitvector */
@@ -471,6 +488,8 @@ static ctl_table w83627hf_dir_table_temp
 	 &i2c_sysctl_real, NULL, &w83627hf_pwm},
 	{W83781D_SYSCTL_PWM2, "pwm2", NULL, 0, 0644, NULL, &i2c_proc_real,
 	 &i2c_sysctl_real, NULL, &w83627hf_pwm},
+	{W83781D_SYSCTL_PWMCLK1, "pwmclk12", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83627hf_pwmclk},
 	{W83781D_SYSCTL_SENS1, "sensor1", NULL, 0, 0644, NULL, &i2c_proc_real,
 	 &i2c_sysctl_real, NULL, &w83627hf_sens},
 	{W83781D_SYSCTL_SENS2, "sensor2", NULL, 0, 0644, NULL, &i2c_proc_real,
@@ -517,6 +536,10 @@ static ctl_table w83697hf_dir_table_temp
 	 &i2c_sysctl_real, NULL, &w83627hf_pwm},
 	{W83781D_SYSCTL_PWM2, "pwm2", NULL, 0, 0644, NULL, &i2c_proc_real,
 	 &i2c_sysctl_real, NULL, &w83627hf_pwm},
+	{W83781D_SYSCTL_PWMCLK1, "pwmclk1", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83627hf_pwmclk},
+	{W83781D_SYSCTL_PWMCLK2, "pwmclk2", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83627hf_pwmclk},
 	{W83781D_SYSCTL_SENS1, "sensor1", NULL, 0, 0644, NULL, &i2c_proc_real,
 	 &i2c_sysctl_real, NULL, &w83627hf_sens},
 	{W83781D_SYSCTL_SENS2, "sensor2", NULL, 0, 0644, NULL, &i2c_proc_real,
@@ -1030,6 +1053,26 @@ static void w83627hf_update_client(struc
 			if(i = 2 && (data->type = w83627hf || data->type = w83697hf))
 				break;
 		}
+		for (i = 1; i <= 3; i++) {
+			if (data->type = w83627hf) {
+				u8 tmp = w83627hf_read_value(client,
+						W83627HF_REG_PWMCLK12);
+				/* bits 7 and 3 are reserved  in 627HF */
+				/* bits 6..4 pwmclk2 .. bits 2..0 pwmclk1 */
+				data->pwmclk[i-1] = tmp & 0x77;
+				break;
+			}
+			else if (data->type = w83697hf) {
+				u8 tmp = w83627hf_read_value(client,
+						reg_pwmclk_697hf[i-1]);
+				data->pwmclk[i-1] = tmp ;
+				if (i=2) 
+					break;
+			}
+			else {
+			/* TODO w83627thf, w83637hf and w83687thf */
+			}
+		}
 
 		data->temp = w83627hf_read_value(client, W83781D_REG_TEMP);
 		data->temp_over @@ -1406,6 +1449,41 @@ void w83627hf_pwm(struct i2c_client *cli
 	}
 }
 
+void w83627hf_pwmclk(struct i2c_client *client, int operation, int ctl_name,
+		 int *nrels_mag, long *results)
+{
+	struct w83627hf_data *data = client->data;
+	int nr = 1 + ctl_name - W83781D_SYSCTL_PWMCLK1;
+
+	if (operation = SENSORS_PROC_REAL_INFO)
+		*nrels_mag = 0;
+	else if (operation = SENSORS_PROC_REAL_READ) {
+		w83627hf_update_client(client);
+		results[0] = data->pwmclk[nr - 1];
+		*nrels_mag = 1;
+	} else if (operation = SENSORS_PROC_REAL_WRITE) {
+		if (*nrels_mag >= 1) {
+			if (data->type = w83627hf) {
+				/* bits 7 and 3 are reserved  in 627HF */
+				data->pwm[nr - 1] = PWM_TO_REG(results[0]) & 0x77;
+				/* bits 6..4 pwmclk2 .. bits 2..0 pwmclk1 */
+				w83627hf_write_value(client,
+						     W83627HF_REG_PWMCLK12,
+						     data->pwmclk[nr - 1] |
+						     (w83627hf_read_value(client,
+						      W83627HF_REG_PWMCLK12 & 0x88)) );
+			} else if (data->type = w83697hf) {
+				data->pwm[nr - 1] = PWM_TO_REG(results[0]);
+				w83627hf_write_value(client,
+						     reg_pwmclk_697hf[nr - 1],
+						     data->pwmclk[nr - 1]);
+			} else {
+				/* TODO w83627thf, w83637hf and w83687thf */
+			}
+		}
+	}
+}
+
 void w83627hf_sens(struct i2c_client *client, int operation, int ctl_name,
 		  int *nrels_mag, long *results)
 {
diff -uprN lm-sensors-r4065-20060705.orig/lib/chips.c lm-sensors-r4065-20060705/lib/chips.c
--- lm-sensors-r4065-20060705.orig/lib/chips.c	2006-07-05 06:10:20.000000000 +0200
+++ lm-sensors-r4065-20060705/lib/chips.c	2006-07-08 13:22:20.000000000 +0200
@@ -1273,7 +1273,285 @@ static sensors_chip_feature asb100_featu
 		ASB100_SYSCTL_ALARMS, VALUE(1), 0 },
 	{ 0 }
 };
+
+static sensors_chip_feature w83697hf_features[] +  { 
+    { SENSORS_W83697HF_IN0, "in0", NOMAP, NOMAP, 
+                        R, W83781D_SYSCTL_IN0, VALUE(3), 2 },
+    { SENSORS_W83697HF_IN2, "in2", NOMAP, NOMAP,
+                        R, W83781D_SYSCTL_IN2, VALUE(3), 2 },
+    { SENSORS_W83697HF_IN3, "in3", NOMAP, NOMAP,
+                        R, W83781D_SYSCTL_IN3, VALUE(3), 2 },
+    { SENSORS_W83697HF_IN4, "in4", NOMAP, NOMAP,
+                        R, W83781D_SYSCTL_IN4, VALUE(3), 2 },
+    { SENSORS_W83697HF_IN5, "in5", NOMAP, NOMAP,
+                        R, W83781D_SYSCTL_IN5, VALUE(3), 2 },
+    { SENSORS_W83697HF_IN6, "in6", NOMAP, NOMAP,
+                        R, W83781D_SYSCTL_IN6, VALUE(3), 2 },
+    { SENSORS_W83697HF_IN7, "in7", NOMAP, NOMAP,
+                        R, W83781D_SYSCTL_IN7, VALUE(3), 2 },
+    { SENSORS_W83697HF_IN8, "in8", NOMAP, NOMAP,
+                        R, W83781D_SYSCTL_IN8, VALUE(3), 2 },
+    { SENSORS_W83697HF_IN0_MIN, "in0_min", SENSORS_W83697HF_IN0, 
+                        SENSORS_W83697HF_IN0, RW, 
+                        W83781D_SYSCTL_IN0, VALUE(1), 2 },
+    { SENSORS_W83697HF_IN2_MIN, "in2_min", SENSORS_W83697HF_IN2, 
+                        SENSORS_W83697HF_IN2, RW, 
+                        W83781D_SYSCTL_IN2, VALUE(1), 2 },
+    { SENSORS_W83697HF_IN3_MIN, "in3_min", SENSORS_W83697HF_IN3, 
+                        SENSORS_W83697HF_IN3, RW, 
+                        W83781D_SYSCTL_IN3, VALUE(1), 2 },
+    { SENSORS_W83697HF_IN4_MIN, "in4_min", SENSORS_W83697HF_IN4, 
+                        SENSORS_W83697HF_IN4, RW, 
+                        W83781D_SYSCTL_IN4, VALUE(1), 2 },
+    { SENSORS_W83697HF_IN5_MIN, "in5_min", SENSORS_W83697HF_IN5, 
+                        SENSORS_W83697HF_IN5, RW, 
+                        W83781D_SYSCTL_IN5, VALUE(1), 2 },
+    { SENSORS_W83697HF_IN6_MIN, "in6_min", SENSORS_W83697HF_IN6, 
+                        SENSORS_W83697HF_IN6, RW, 
+                        W83781D_SYSCTL_IN6, VALUE(1), 2 },
+    { SENSORS_W83697HF_IN7_MIN, "in7_min", SENSORS_W83697HF_IN7, 
+                        SENSORS_W83697HF_IN7, RW, 
+                        W83781D_SYSCTL_IN7, VALUE(1), 2 },
+    { SENSORS_W83697HF_IN8_MIN, "in8_min", SENSORS_W83697HF_IN8, 
+                        SENSORS_W83697HF_IN8, RW, 
+                        W83781D_SYSCTL_IN8, VALUE(1), 2 },
+    { SENSORS_W83697HF_IN0_MAX, "in0_max", SENSORS_W83697HF_IN0, 
+                        SENSORS_W83697HF_IN0, RW,
+                        W83781D_SYSCTL_IN0, VALUE(2), 2 },
+    { SENSORS_W83697HF_IN2_MAX, "in2_max", SENSORS_W83697HF_IN2, 
+                        SENSORS_W83697HF_IN2, RW, 
+                        W83781D_SYSCTL_IN2, VALUE(2), 2 },
+    { SENSORS_W83697HF_IN3_MAX, "in3_max", SENSORS_W83697HF_IN3, 
+                        SENSORS_W83697HF_IN3, RW, 
+                        W83781D_SYSCTL_IN3, VALUE(2), 2 },
+    { SENSORS_W83697HF_IN4_MAX, "in4_max", SENSORS_W83697HF_IN4, 
+                        SENSORS_W83697HF_IN4, RW,
+                        W83781D_SYSCTL_IN4, VALUE(2), 2 },
+    { SENSORS_W83697HF_IN5_MAX, "in5_max", SENSORS_W83697HF_IN5, 
+                        SENSORS_W83697HF_IN5, RW, 
+                        W83781D_SYSCTL_IN5, VALUE(2), 2 },
+    { SENSORS_W83697HF_IN6_MAX, "in6_max", SENSORS_W83697HF_IN6, 
+                        SENSORS_W83697HF_IN6, RW, 
+                        W83781D_SYSCTL_IN6, VALUE(2), 2 },
+    { SENSORS_W83697HF_IN7_MAX, "in7_max", SENSORS_W83697HF_IN7, 
+                        SENSORS_W83697HF_IN7, RW, 
+                        W83781D_SYSCTL_IN7, VALUE(2), 2 },
+    { SENSORS_W83697HF_IN8_MAX, "in8_max", SENSORS_W83697HF_IN8, 
+                        SENSORS_W83697HF_IN8, RW, 
+                        W83781D_SYSCTL_IN8, VALUE(2), 2 },
+    { SENSORS_W83697HF_FAN1, "fan1", NOMAP, NOMAP,
+                        R, W83781D_SYSCTL_FAN1, VALUE(2), 0 },
+    { SENSORS_W83697HF_FAN2, "fan2", NOMAP, NOMAP,
+                        R, W83781D_SYSCTL_FAN2, VALUE(2), 0 },
+    { SENSORS_W83697HF_FAN1_MIN, "fan1_min", SENSORS_W83697HF_FAN1,
+                        SENSORS_W83697HF_FAN1, RW, 
+                        W83781D_SYSCTL_FAN1, VALUE(1), 0 },
+    { SENSORS_W83697HF_FAN2_MIN, "fan2_min", SENSORS_W83697HF_FAN2, 
+                        SENSORS_W83697HF_FAN2, RW, 
+                        W83781D_SYSCTL_FAN2, VALUE(1), 0 },
+    { SENSORS_W83697HF_TEMP1, "temp1", NOMAP, NOMAP,
+                         R, W83781D_SYSCTL_TEMP1, VALUE(3), 1 },
+    { SENSORS_W83697HF_TEMP1_HYST, "temp1_hyst", SENSORS_W83697HF_TEMP1,
+                         SENSORS_W83697HF_TEMP1, RW, 
+                         W83781D_SYSCTL_TEMP1, VALUE(2), 1 },
+    { SENSORS_W83697HF_TEMP1_OVER, "temp1_over", SENSORS_W83697HF_TEMP1,
+                         SENSORS_W83697HF_TEMP1, RW, 
+                         W83781D_SYSCTL_TEMP1, VALUE(1), 1 },
+    { SENSORS_W83697HF_TEMP2, "temp2", NOMAP, NOMAP,
+                         R, W83781D_SYSCTL_TEMP2, VALUE(3), 1 },
+    { SENSORS_W83697HF_TEMP2_HYST, "temp2_hyst", SENSORS_W83697HF_TEMP2,
+                         SENSORS_W83697HF_TEMP2, RW, 
+                         W83781D_SYSCTL_TEMP2, VALUE(2), 1 },
+    { SENSORS_W83697HF_TEMP2_OVER, "temp2_over", SENSORS_W83697HF_TEMP2,
+                         SENSORS_W83697HF_TEMP2, RW, 
+                         W83781D_SYSCTL_TEMP2, VALUE(1), 1 },
+    { SENSORS_W83697HF_TEMP3, "temp3", NOMAP, NOMAP,
+                         R, W83781D_SYSCTL_TEMP3, VALUE(3), 1 },
+    { SENSORS_W83697HF_TEMP3_HYST, "temp3_hyst", SENSORS_W83697HF_TEMP3,
+                         SENSORS_W83697HF_TEMP3, RW, 
+                         W83781D_SYSCTL_TEMP3, VALUE(2), 1 },
+    { SENSORS_W83697HF_TEMP3_OVER, "temp3_over", SENSORS_W83697HF_TEMP3,
+                         SENSORS_W83697HF_TEMP3, RW, 
+                         W83781D_SYSCTL_TEMP3, VALUE(1), 1 },
+    { SENSORS_W83697HF_FAN1_DIV, "fan1_div", SENSORS_W83697HF_FAN1, 
+                         NOMAP, RW, 
+                         W83781D_SYSCTL_FAN_DIV, VALUE(1), 0 },
+    { SENSORS_W83697HF_FAN2_DIV, "fan2_div", SENSORS_W83697HF_FAN2, 
+                         NOMAP, RW, 
+                         W83781D_SYSCTL_FAN_DIV, VALUE(2), 0 },
+    { SENSORS_W83697HF_PWM1, "pwm1", SENSORS_W83697HF_FAN1, NOMAP, 
+                         RW, W83781D_SYSCTL_PWM1, VALUE(1), 0 },
+    { SENSORS_W83697HF_PWM2, "pwm2", SENSORS_W83697HF_FAN2, NOMAP, 
+                         RW, W83781D_SYSCTL_PWM2, VALUE(1), 0 },
+    { SENSORS_W83697HF_PWMCLK1, "pwmclk1", SENSORS_W83697HF_FAN1, NOMAP, 
+                         RW, W83781D_SYSCTL_PWMCLK1, VALUE(1), 0 },
+    { SENSORS_W83697HF_PWMCLK2, "pwmclk2", SENSORS_W83697HF_FAN2, NOMAP, 
+                         RW, W83781D_SYSCTL_PWMCLK2, VALUE(1), 0 }, +    { SENSORS_W83697HF_ALARMS,
"alarms", NOMAP, NOMAP, 
+                         R, W83781D_SYSCTL_ALARMS, VALUE(1), 0 },
+    { SENSORS_W83697HF_BEEP_ENABLE, "beep_enable", SENSORS_W83697HF_ALARMS,
+                         NOMAP, RW,
+                         W83781D_SYSCTL_BEEP, VALUE(1), 0 },
+    { SENSORS_W83697HF_BEEPS, "beeps", SENSORS_W83697HF_ALARMS,
+                         SENSORS_W83697HF_ALARMS, RW,
+                         W83781D_SYSCTL_BEEP, VALUE(2), 0 },
+    { SENSORS_W83697HF_SENS1, "sensor1", NOMAP, NOMAP,
+                         RW, W83781D_SYSCTL_SENS1, VALUE(1), 0 },
+    { SENSORS_W83697HF_SENS2, "sensor2", NOMAP, NOMAP,
+                         RW, W83781D_SYSCTL_SENS2, VALUE(1), 0 },
+    { 0 }
+  };
   
+static sensors_chip_feature w83627hf_features[] +  { 
+    { SENSORS_W83627HF_IN0, "in0", NOMAP, NOMAP, 
+                        R, W83781D_SYSCTL_IN0, VALUE(3), 2 },
+    { SENSORS_W83627HF_IN1, "in1", NOMAP, NOMAP,
+                        R, W83781D_SYSCTL_IN1, VALUE(3), 2 },
+    { SENSORS_W83627HF_IN2, "in2", NOMAP, NOMAP,
+                        R, W83781D_SYSCTL_IN2, VALUE(3), 2 },
+    { SENSORS_W83627HF_IN3, "in3", NOMAP, NOMAP,
+                        R, W83781D_SYSCTL_IN3, VALUE(3), 2 },
+    { SENSORS_W83627HF_IN4, "in4", NOMAP, NOMAP,
+                        R, W83781D_SYSCTL_IN4, VALUE(3), 2 },
+    { SENSORS_W83627HF_IN5, "in5", NOMAP, NOMAP,
+                        R, W83781D_SYSCTL_IN5, VALUE(3), 2 },
+    { SENSORS_W83627HF_IN6, "in6", NOMAP, NOMAP,
+                        R, W83781D_SYSCTL_IN6, VALUE(3), 2 },
+    { SENSORS_W83627HF_IN7, "in7", NOMAP, NOMAP,
+                        R, W83781D_SYSCTL_IN7, VALUE(3), 2 },
+    { SENSORS_W83627HF_IN8, "in8", NOMAP, NOMAP,
+                        R, W83781D_SYSCTL_IN8, VALUE(3), 2 },
+    { SENSORS_W83627HF_IN0_MIN, "in0_min", SENSORS_W83627HF_IN0, 
+                        SENSORS_W83627HF_IN0, RW, 
+                        W83781D_SYSCTL_IN0, VALUE(1), 2 },
+    { SENSORS_W83627HF_IN1_MIN, "in1_min", SENSORS_W83627HF_IN1, 
+                        SENSORS_W83627HF_IN1, RW, 
+                        W83781D_SYSCTL_IN1, VALUE(1), 2 },
+    { SENSORS_W83627HF_IN2_MIN, "in2_min", SENSORS_W83627HF_IN2, 
+                        SENSORS_W83627HF_IN2, RW, 
+                        W83781D_SYSCTL_IN2, VALUE(1), 2 },
+    { SENSORS_W83627HF_IN3_MIN, "in3_min", SENSORS_W83627HF_IN3, 
+                        SENSORS_W83627HF_IN3, RW, 
+                        W83781D_SYSCTL_IN3, VALUE(1), 2 },
+    { SENSORS_W83627HF_IN4_MIN, "in4_min", SENSORS_W83627HF_IN4, 
+                        SENSORS_W83627HF_IN4, RW, 
+                        W83781D_SYSCTL_IN4, VALUE(1), 2 },
+    { SENSORS_W83627HF_IN5_MIN, "in5_min", SENSORS_W83627HF_IN5, 
+                        SENSORS_W83627HF_IN5, RW, 
+                        W83781D_SYSCTL_IN5, VALUE(1), 2 },
+    { SENSORS_W83627HF_IN6_MIN, "in6_min", SENSORS_W83627HF_IN6, 
+                        SENSORS_W83627HF_IN6, RW, 
+                        W83781D_SYSCTL_IN6, VALUE(1), 2 },
+    { SENSORS_W83627HF_IN7_MIN, "in7_min", SENSORS_W83627HF_IN7, 
+                        SENSORS_W83627HF_IN7, RW, 
+                        W83781D_SYSCTL_IN7, VALUE(1), 2 },
+    { SENSORS_W83627HF_IN8_MIN, "in8_min", SENSORS_W83627HF_IN8, 
+                        SENSORS_W83627HF_IN8, RW, 
+                        W83781D_SYSCTL_IN8, VALUE(1), 2 },
+    { SENSORS_W83627HF_IN0_MAX, "in0_max", SENSORS_W83627HF_IN0, 
+                        SENSORS_W83627HF_IN0, RW,
+                        W83781D_SYSCTL_IN0, VALUE(2), 2 },
+    { SENSORS_W83627HF_IN1_MAX, "in1_max", SENSORS_W83627HF_IN1, 
+                        SENSORS_W83627HF_IN1, RW, 
+                        W83781D_SYSCTL_IN1, VALUE(2), 2 },
+    { SENSORS_W83627HF_IN2_MAX, "in2_max", SENSORS_W83627HF_IN2, 
+                        SENSORS_W83627HF_IN2, RW, 
+                        W83781D_SYSCTL_IN2, VALUE(2), 2 },
+    { SENSORS_W83627HF_IN3_MAX, "in3_max", SENSORS_W83627HF_IN3, 
+                        SENSORS_W83627HF_IN3, RW, 
+                        W83781D_SYSCTL_IN3, VALUE(2), 2 },
+    { SENSORS_W83627HF_IN4_MAX, "in4_max", SENSORS_W83627HF_IN4, 
+                        SENSORS_W83627HF_IN4, RW,
+                        W83781D_SYSCTL_IN4, VALUE(2), 2 },
+    { SENSORS_W83627HF_IN5_MAX, "in5_max", SENSORS_W83627HF_IN5, 
+                        SENSORS_W83627HF_IN5, RW, 
+                        W83781D_SYSCTL_IN5, VALUE(2), 2 },
+    { SENSORS_W83627HF_IN6_MAX, "in6_max", SENSORS_W83627HF_IN6, 
+                        SENSORS_W83627HF_IN6, RW, 
+                        W83781D_SYSCTL_IN6, VALUE(2), 2 },
+    { SENSORS_W83627HF_IN7_MAX, "in7_max", SENSORS_W83627HF_IN7, 
+                        SENSORS_W83627HF_IN7, RW, 
+                        W83781D_SYSCTL_IN7, VALUE(2), 2 },
+    { SENSORS_W83627HF_IN8_MAX, "in8_max", SENSORS_W83627HF_IN8, 
+                        SENSORS_W83627HF_IN8, RW, 
+                        W83781D_SYSCTL_IN8, VALUE(2), 2 },
+    { SENSORS_W83627HF_FAN1, "fan1", NOMAP, NOMAP,
+                        R, W83781D_SYSCTL_FAN1, VALUE(2), 0 },
+    { SENSORS_W83627HF_FAN2, "fan2", NOMAP, NOMAP,
+                        R, W83781D_SYSCTL_FAN2, VALUE(2), 0 },
+    { SENSORS_W83781D_FAN3, "fan3", NOMAP, NOMAP,
+                        R, W83781D_SYSCTL_FAN3, VALUE(2), 0 },
+    { SENSORS_W83627HF_FAN1_MIN, "fan1_min", SENSORS_W83627HF_FAN1,
+                        SENSORS_W83627HF_FAN1, RW, 
+                        W83781D_SYSCTL_FAN1, VALUE(1), 0 },
+    { SENSORS_W83627HF_FAN2_MIN, "fan2_min", SENSORS_W83627HF_FAN2, 
+                        SENSORS_W83627HF_FAN2, RW, 
+                        W83781D_SYSCTL_FAN2, VALUE(1), 0 },
+    { SENSORS_W83781D_FAN3_MIN, "fan3_min", SENSORS_W83781D_FAN3, 
+                        SENSORS_W83627HF_FAN3, RW, 
+                        W83781D_SYSCTL_FAN3, VALUE(1), 0 },
+    { SENSORS_W83627HF_TEMP1, "temp1", NOMAP, NOMAP,
+                         R, W83781D_SYSCTL_TEMP1, VALUE(3), 1 },
+    { SENSORS_W83627HF_TEMP1_HYST, "temp1_hyst", SENSORS_W83627HF_TEMP1,
+                         SENSORS_W83627HF_TEMP1, RW, 
+                         W83781D_SYSCTL_TEMP1, VALUE(2), 1 },
+    { SENSORS_W83627HF_TEMP1_OVER, "temp1_over", SENSORS_W83627HF_TEMP1,
+                         SENSORS_W83627HF_TEMP1, RW, 
+                         W83781D_SYSCTL_TEMP1, VALUE(1), 1 },
+    { SENSORS_W83627HF_TEMP2, "temp2", NOMAP, NOMAP,
+                         R, W83781D_SYSCTL_TEMP2, VALUE(3), 1 },
+    { SENSORS_W83627HF_TEMP2_HYST, "temp2_hyst", SENSORS_W83627HF_TEMP2,
+                         SENSORS_W83627HF_TEMP2, RW, 
+                         W83781D_SYSCTL_TEMP2, VALUE(2), 1 },
+    { SENSORS_W83627HF_TEMP2_OVER, "temp2_over", SENSORS_W83627HF_TEMP2,
+                         SENSORS_W83627HF_TEMP2, RW, 
+                         W83781D_SYSCTL_TEMP2, VALUE(1), 1 },
+    { SENSORS_W83627HF_TEMP3, "temp3", NOMAP, NOMAP,
+                         R, W83781D_SYSCTL_TEMP3, VALUE(3), 1 },
+    { SENSORS_W83627HF_TEMP3_HYST, "temp3_hyst", SENSORS_W83627HF_TEMP3,
+                         SENSORS_W83627HF_TEMP3, RW, 
+                         W83781D_SYSCTL_TEMP3, VALUE(2), 1 },
+    { SENSORS_W83627HF_TEMP3_OVER, "temp3_over", SENSORS_W83627HF_TEMP3,
+                         SENSORS_W83627HF_TEMP3, RW, 
+                         W83781D_SYSCTL_TEMP3, VALUE(1), 1 },
+    { SENSORS_W83627HF_VID, "vid", NOMAP, NOMAP,
+                         R, W83781D_SYSCTL_VID, VALUE(1), 3 },
+    { SENSORS_W83627HF_VRM, "vrm", NOMAP, NOMAP,
+                         RW, W83781D_SYSCTL_VRM, VALUE(1), 1 },
+    { SENSORS_W83627HF_FAN1_DIV, "fan1_div", SENSORS_W83627HF_FAN1, 
+                         NOMAP, RW, 
+                         W83781D_SYSCTL_FAN_DIV, VALUE(1), 0 },
+    { SENSORS_W83627HF_FAN2_DIV, "fan2_div", SENSORS_W83627HF_FAN2, 
+                         NOMAP, RW, 
+                         W83781D_SYSCTL_FAN_DIV, VALUE(2), 0 },
+    { SENSORS_W83627HF_FAN3_DIV, "fan3_div", SENSORS_W83781D_FAN3, 
+                         NOMAP, RW, 
+                         W83781D_SYSCTL_FAN_DIV, VALUE(3), 0 },
+    { SENSORS_W83627HF_PWM1, "pwm1", SENSORS_W83697HF_FAN1, NOMAP, 
+                         RW, W83781D_SYSCTL_PWM1, VALUE(1), 0 },
+    { SENSORS_W83627HF_PWM2, "pwm2", SENSORS_W83697HF_FAN2, NOMAP, 
+                         RW, W83781D_SYSCTL_PWM2, VALUE(1), 0 },
+    { SENSORS_W83627HF_PWMCLK12, "pwmclk12", NOMAP, NOMAP, 
+                         RW, W83781D_SYSCTL_PWMCLK1, VALUE(1), 0 },
+    { SENSORS_W83627HF_ALARMS, "alarms", NOMAP, NOMAP, 
+                         R, W83781D_SYSCTL_ALARMS, VALUE(1), 0 },
+    { SENSORS_W83627HF_BEEP_ENABLE, "beep_enable", SENSORS_W83627HF_ALARMS,
+                         NOMAP, RW,
+                         W83781D_SYSCTL_BEEP, VALUE(1), 0 },
+    { SENSORS_W83627HF_BEEPS, "beeps", SENSORS_W83627HF_ALARMS,
+                         SENSORS_W83627HF_ALARMS, RW,
+                         W83781D_SYSCTL_BEEP, VALUE(2), 0 },
+    { SENSORS_W83627HF_SENS1, "sensor1", NOMAP, NOMAP,
+                         RW, W83781D_SYSCTL_SENS1, VALUE(1), 0 },
+    { SENSORS_W83627HF_SENS2, "sensor2", NOMAP, NOMAP,
+                         RW, W83781D_SYSCTL_SENS2, VALUE(1), 0 },
+    { SENSORS_W83627HF_SENS3, "sensor3", NOMAP, NOMAP,
+                         RW, W83781D_SYSCTL_SENS3, VALUE(1), 0 },
+    { 0 }
+  };  
+
 static sensors_chip_feature w83782d_features[]    { 
     { SENSORS_W83782D_IN0, "in0", NOMAP, NOMAP, 
@@ -1417,6 +1695,7 @@ static sensors_chip_feature w83782d_feat
     { 0 }
   };
   
+
 static sensors_chip_feature w83783s_features[]    { 
     { SENSORS_W83783S_IN0, "in0", NOMAP, NOMAP, 
@@ -5853,10 +6132,11 @@ sensors_chip_features sensors_chip_featu
  { SENSORS_W83781D_PREFIX, w83781d_features },
  { SENSORS_W83782D_PREFIX, w83782d_features },
  { SENSORS_W83783S_PREFIX, w83783s_features },
- { SENSORS_W83697HF_PREFIX, w83782d_features }, /* same as 782d */
-		/* Cheat on 83627HF for now - no separate #defines */
- { SENSORS_W83627HF_PREFIX, w83782d_features },
-		/* Cheat on 83627THF for now - no separate #defines */
+ //{ SENSORS_W83697HF_PREFIX, w83782d_features }, /* same as 782d */
+ { SENSORS_W83697HF_PREFIX, w83697hf_features }, 
+ //{ SENSORS_W83627HF_PREFIX, w83782d_features },
+ { SENSORS_W83697HF_PREFIX, w83627hf_features }, 
+	 /* Cheat on 83627THF for now - no separate #defines */
  { SENSORS_W83627THF_PREFIX, w83782d_features },
 		/* Cheat on 83637HF for now - no separate #defines */
  { SENSORS_W83637HF_PREFIX, w83782d_features },
diff -uprN lm-sensors-r4065-20060705.orig/lib/chips.h lm-sensors-r4065-20060705/lib/chips.h
--- lm-sensors-r4065-20060705.orig/lib/chips.h	2006-07-05 06:10:20.000000000 +0200
+++ lm-sensors-r4065-20060705/lib/chips.h	2006-07-07 17:16:51.000000000 +0200
@@ -566,20 +566,76 @@
 #define SENSORS_W83781D_SENS2 92 /* RW */
 #define SENSORS_W83781D_SENS3 93 /* RW */
 
+/* Winbond W83627HF chips */
+
+#define SENSORS_W83627HF_PREFIX "w83627hf"
+
+#define SENSORS_W83627HF_IN0 1 /* R */
+#define SENSORS_W83627HF_IN1 2 /* R */
+#define SENSORS_W83627HF_IN2 3 /* R */
+#define SENSORS_W83627HF_IN3 4 /* R */
+#define SENSORS_W83627HF_IN4 5 /* R */
+#define SENSORS_W83627HF_IN5 6 /* R */
+#define SENSORS_W83627HF_IN6 7 /* R */
+#define SENSORS_W83627HF_IN7 8 /* R */
+#define SENSORS_W83627HF_IN8 9 /* R */
+#define SENSORS_W83627HF_IN0_MIN 11 /* RW */
+#define SENSORS_W83627HF_IN1_MIN 12 /* RW */
+#define SENSORS_W83627HF_IN2_MIN 13 /* RW */
+#define SENSORS_W83627HF_IN3_MIN 14 /* RW */
+#define SENSORS_W83627HF_IN4_MIN 15 /* RW */
+#define SENSORS_W83627HF_IN5_MIN 16 /* RW */
+#define SENSORS_W83627HF_IN6_MIN 17 /* RW */
+#define SENSORS_W83627HF_IN7_MIN 18 /* RW */
+#define SENSORS_W83627HF_IN8_MIN 19 /* RW */
+#define SENSORS_W83627HF_IN0_MAX 21 /* RW */
+#define SENSORS_W83627HF_IN1_MAX 22 /* RW */
+#define SENSORS_W83627HF_IN2_MAX 23 /* RW */
+#define SENSORS_W83627HF_IN3_MAX 24 /* RW */
+#define SENSORS_W83627HF_IN4_MAX 25 /* RW */
+#define SENSORS_W83627HF_IN5_MAX 26 /* RW */
+#define SENSORS_W83627HF_IN6_MAX 27 /* RW */
+#define SENSORS_W83627HF_IN7_MAX 28 /* RW */
+#define SENSORS_W83627HF_IN8_MAX 29 /* RW */
+#define SENSORS_W83627HF_FAN1 31 /* R */
+#define SENSORS_W83627HF_FAN2 32 /* R */
+#define SENSORS_W83627HF_FAN3 33 /* R */
+#define SENSORS_W83627HF_FAN1_MIN 41 /* RW */
+#define SENSORS_W83627HF_FAN2_MIN 42 /* RW */
+#define SENSORS_W83627HF_FAN3_MIN 43 /* RW */
+#define SENSORS_W83627HF_TEMP1 51 /* R */
+#define SENSORS_W83627HF_TEMP1_HYST 52 /* RW */
+#define SENSORS_W83627HF_TEMP1_OVER 53 /* RW */
+#define SENSORS_W83627HF_TEMP2 54 /* R */
+#define SENSORS_W83627HF_TEMP2_HYST 55 /* RW */
+#define SENSORS_W83627HF_TEMP2_OVER 56 /* RW */
+#define SENSORS_W83627HF_TEMP3 57 /* R */
+#define SENSORS_W83627HF_TEMP3_HYST 58 /* RW */
+#define SENSORS_W83627HF_TEMP3_OVER 59 /* RW */
+#define SENSORS_W83627HF_VID 61 /* R */
+#define SENSORS_W83627HF_VRM 62 /* RW */
+#define SENSORS_W83627HF_FAN1_DIV 71 /* RW */
+#define SENSORS_W83627HF_FAN2_DIV 72 /* RW */
+#define SENSORS_W83627HF_FAN3_DIV 73 /* R (yes, really! */
+#define SENSORS_W83627HF_ALARMS 81 /* R */
+#define SENSORS_W83627HF_BEEP_ENABLE 82 /* RW */
+#define SENSORS_W83627HF_BEEPS 83 /* RW */
+#define SENSORS_W83627HF_SENS1 91 /* RW */
+#define SENSORS_W83627HF_SENS2 92 /* RW */
+#define SENSORS_W83627HF_SENS3 93 /* RW */
+#define SENSORS_W83627HF_PWM1 131 /* RW */
+#define SENSORS_W83627HF_PWM2 132 /* RW */
+#define SENSORS_W83627HF_PWMCLK12 231 /* RW */
 
 /* Winbond W83782D chips */
-/* Cheat on 627HF for now - no separate #defines */
 /* Cheat on 127F for now - no separate #defines */
 
 #define SENSORS_W83782D_PREFIX "w83782d"
-#define SENSORS_W83627HF_PREFIX "w83627hf"
 #define SENSORS_W83627THF_PREFIX "w83627thf"
 #define SENSORS_W83637HF_PREFIX "w83637hf"
 #define SENSORS_W83687THF_PREFIX "w83687thf"
-
 #define SENSORS_W83791D_PREFIX "w83791d"
 
-
 #define SENSORS_W83791D_IN0 1 /* R */
 #define SENSORS_W83791D_IN1 2 /* R */
 #define SENSORS_W83791D_IN2 3 /* R */
@@ -653,8 +709,8 @@
 
 
 /* Winbond W83792AD/D chip */
-#define SENSORS_W83792D_PREFIX "w83792d"
 
+#define SENSORS_W83792D_PREFIX "w83792d"
 
 #define SENSORS_W83792D_IN0 1 /* R */
 #define SENSORS_W83792D_IN1 2 /* R */
@@ -785,12 +841,64 @@
 #define SENSORS_W83782D_SENS2 92 /* RW */
 #define SENSORS_W83782D_SENS3 93 /* RW */
 
+/* Winbond W83697HF chips */
+/* Same as w83782d but no in1, fan3, sensor3, vrm and vid
+   added pwm and pwm clock support */
+   
+#define SENSORS_W83697HF_PREFIX "w83697hf"
+
+#define SENSORS_W83697HF_IN0 1 /* R */
+#define SENSORS_W83697HF_IN2 3 /* R */
+#define SENSORS_W83697HF_IN3 4 /* R */
+#define SENSORS_W83697HF_IN4 5 /* R */
+#define SENSORS_W83697HF_IN5 6 /* R */
+#define SENSORS_W83697HF_IN6 7 /* R */
+#define SENSORS_W83697HF_IN7 8 /* R */
+#define SENSORS_W83697HF_IN8 9 /* R */
+#define SENSORS_W83697HF_IN0_MIN 11 /* RW */
+#define SENSORS_W83697HF_IN2_MIN 13 /* RW */
+#define SENSORS_W83697HF_IN3_MIN 14 /* RW */
+#define SENSORS_W83697HF_IN4_MIN 15 /* RW */
+#define SENSORS_W83697HF_IN5_MIN 16 /* RW */
+#define SENSORS_W83697HF_IN6_MIN 17 /* RW */
+#define SENSORS_W83697HF_IN7_MIN 18 /* RW */
+#define SENSORS_W83697HF_IN8_MIN 19 /* RW */
+#define SENSORS_W83697HF_IN0_MAX 21 /* RW */
+#define SENSORS_W83697HF_IN2_MAX 23 /* RW */
+#define SENSORS_W83697HF_IN3_MAX 24 /* RW */
+#define SENSORS_W83697HF_IN4_MAX 25 /* RW */
+#define SENSORS_W83697HF_IN5_MAX 26 /* RW */
+#define SENSORS_W83697HF_IN6_MAX 27 /* RW */
+#define SENSORS_W83697HF_IN7_MAX 28 /* RW */
+#define SENSORS_W83697HF_IN8_MAX 29 /* RW */
+#define SENSORS_W83697HF_FAN1 31 /* R */
+#define SENSORS_W83697HF_FAN2 32 /* R */
+#define SENSORS_W83697HF_FAN1_MIN 41 /* RW */
+#define SENSORS_W83697HF_FAN2_MIN 42 /* RW */
+#define SENSORS_W83697HF_TEMP1 51 /* R */
+#define SENSORS_W83697HF_TEMP1_HYST 52 /* RW */
+#define SENSORS_W83697HF_TEMP1_OVER 53 /* RW */
+#define SENSORS_W83697HF_TEMP2 54 /* R */
+#define SENSORS_W83697HF_TEMP2_HYST 55 /* RW */
+#define SENSORS_W83697HF_TEMP2_OVER 56 /* RW */
+#define SENSORS_W83697HF_TEMP3 57 /* R */
+#define SENSORS_W83697HF_TEMP3_HYST 58 /* RW */
+#define SENSORS_W83697HF_TEMP3_OVER 59 /* RW */
+#define SENSORS_W83697HF_FAN1_DIV 71 /* RW */
+#define SENSORS_W83697HF_FAN2_DIV 72 /* RW */
+#define SENSORS_W83697HF_ALARMS 81 /* R */
+#define SENSORS_W83697HF_BEEP_ENABLE 82 /* RW */
+#define SENSORS_W83697HF_BEEPS 83 /* RW */
+#define SENSORS_W83697HF_SENS1 91 /* RW */
+#define SENSORS_W83697HF_SENS2 92 /* RW */
+#define SENSORS_W83697HF_PWM1 131 /* RW */
+#define SENSORS_W83697HF_PWM2 132 /* RW */
+#define SENSORS_W83697HF_PWMCLK1 231 /* RW */
+#define SENSORS_W83697HF_PWMCLK2 232 /* RW */
 
 /* Winbond W83783S chips */
-/* Cheat on 697HF for now - no separate #defines */
 
 #define SENSORS_W83783S_PREFIX "w83783s"
-#define SENSORS_W83697HF_PREFIX "w83697hf"
 
 #define SENSORS_W83783S_IN0 1 /* R */
 #define SENSORS_W83783S_IN1 2 /* R */


