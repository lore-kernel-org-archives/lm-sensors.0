From: rossb@google.com (Ross Biro)
Date: Thu, 19 May 2005 06:23:56 +0000
Subject: w83791d
Message-Id: <3ECBB576.2090509@google.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Here's a patch against 2.7.0 that seems to make the w83791d readable.  I 
haven't tested setting anything with it, and I've only really looked at 
the voltage and temperature outputs.

I've also included a patch to 2.7.0 sensors to make the sensors program 
work with the w83791d chip.

Again these patches have not been thoroughly tested, but seem to work in 
the few cases that I've tried.

	Ross

-------------- next part --------------
diff -urbBd linux-2.4.18-56/drivers/sensors/w83781d.c linux-2.4.18-57/drivers/sensors/w83781d.c
--- linux-2.4.18-56/drivers/sensors/w83781d.c	Thu Apr 17 10:53:53 2003
+++ linux-2.4.18-57/drivers/sensors/w83781d.c	Fri Apr 18 16:42:46 2003
@@ -69,7 +69,7 @@
 static unsigned int normal_isa_range[] = { SENSORS_ISA_END };
 
 /* Insmod parameters */
-SENSORS_INSMOD_6(w83781d, w83782d, w83783s, w83627hf, as99127f, w83697hf);
+SENSORS_INSMOD_7(w83781d, w83782d, w83783s, w83627hf, as99127f, w83697hf, w83791d);
 SENSORS_MODULE_PARM(force_subclients, "List of subclient addresses: " \
                       "{bus, clientaddr, subclientaddr1, subclientaddr2}");
 
@@ -95,8 +95,17 @@
 #define W83781D_REG_IN(nr)     ((nr < 7) ? (0x20 + (nr)) : \
 					   (0x550 + (nr) - 7))
 
-#define W83781D_REG_FAN_MIN(nr) (0x3a + (nr))
-#define W83781D_REG_FAN(nr) (0x27 + (nr))
+#define W83791D_REG_IN_MAX(nr) ((nr < 7) ? (0x2b + (nr) * 2) : \
+					   (0xb4 + (((nr) - 7) * 2)))
+#define W83791D_REG_IN_MIN(nr) ((nr < 7) ? (0x2c + (nr) * 2) : \
+					   (0xb5 + (((nr) - 7) * 2)))
+#define W83791D_REG_IN(nr)     ((nr < 7) ? (0x20 + (nr)) : \
+					   (0xb0 + (nr) - 7))
+
+#define W83781D_REG_FAN_MIN(nr) ((nr < 4) ? (0x3a + (nr)) : \
+                                            (0xba + (nr) - 4))
+#define W83781D_REG_FAN(nr)     ((nr < 4) ? (0x27 + (nr)) : \
+                                            (0xbc + (nr) - 4))
 
 #define W83781D_REG_TEMP2 0x0150
 #define W83781D_REG_TEMP3 0x0250
@@ -142,10 +151,23 @@
 #define W83781D_REG_PWM4 0x5F
 #define W83781D_REG_PWMCLK12 0x5C
 #define W83781D_REG_PWMCLK34 0x45C
+
+#define W83791D_REG_PWM1 0x88	/* 782d and 783s/627hf datasheets disagree */
+				/* on which is which; */
+#define W83791D_REG_PWM2 0x89	/* We follow the 782d convention here, */
+				/* However 782d is probably wrong. */
+#define W83791D_REG_PWM3 0x98
+
 static const u8 regpwm[] = { W83781D_REG_PWM1, W83781D_REG_PWM2,
 	W83781D_REG_PWM3, W83781D_REG_PWM4
 };
+
+static const u8 regpwm_w83791d[] = { W83791D_REG_PWM1, W83791D_REG_PWM2,
+                                   W83791D_REG_PWM3
+};
+        
 #define W83781D_REG_PWM(nr) (regpwm[(nr) - 1])
+#define W83791D_REG_PWM(nr) (regpwm_w83791d[(nr) - 1])
 
 #define W83781D_REG_I2C_ADDR 0x48
 #define W83781D_REG_I2C_SUBADDR 0x4A
@@ -227,6 +249,7 @@
 #define W83781D_INIT_IN_6 (((-500)  * -604)/909)
 #define W83781D_INIT_IN_7 (((500)   * 100)/168)
 #define W83781D_INIT_IN_8 300
+#define W83781D_INIT_IN_9 250 /* 2.5 Volt for the DDR interface. */
 /* Initial limits for 782d/783s negative voltages */
 /* Note level shift. Change min/max below if you change these. */
 #define W83782D_INIT_IN_5 ((((-1200) + 1491) * 100)/514)
@@ -288,6 +311,12 @@
 #define W83781D_INIT_IN_MAX_8 \
         (W83781D_INIT_IN_8 + W83781D_INIT_IN_8 * W83781D_INIT_IN_PERCENTAGE \
          / 100)
+#define W83781D_INIT_IN_MIN_9 \
+        (W83781D_INIT_IN_9 - W83781D_INIT_IN_9 * W83781D_INIT_IN_PERCENTAGE \
+         / 100)
+#define W83781D_INIT_IN_MAX_9 \
+        (W83781D_INIT_IN_9 + W83781D_INIT_IN_9 * W83781D_INIT_IN_PERCENTAGE \
+         / 100)
 /* Initial limits for 782d/783s negative voltages */
 /* These aren't direct multiples because of level shift */
 /* Beware going negative - check */
@@ -351,11 +380,11 @@
 	struct i2c_client *lm75;	/* for secondary I2C addresses */
 	/* pointer to array of 2 subclients */
 
-	u8 in[9];		/* Register value - 8 & 9 for 782D only */
-	u8 in_max[9];		/* Register value - 8 & 9 for 782D only */
-	u8 in_min[9];		/* Register value - 8 & 9 for 782D only */
-	u8 fan[3];		/* Register value */
-	u8 fan_min[3];		/* Register value */
+	u8 in[10];		/* Register value - 8 & 9 for 782D and 791D only 10 for 791D */
+	u8 in_max[10];		/* Register value - 8 & 9 for 782D and 791D only 10 for 791D */
+	u8 in_min[10];		/* Register value - 8 & 9 for 782D and 791D only 10 for 791D */
+	u8 fan[5];		/* Register value - 4 & 5 for 791D only */
+	u8 fan_min[5];		/* Register value - 4 & 5 for 791D only */
 	u8 temp;
 	u8 temp_over;		/* Register value */
 	u8 temp_hyst;		/* Register value */
@@ -568,7 +597,7 @@
 	 &i2c_sysctl_real, NULL, &w83781d_in},
 	{W83781D_SYSCTL_IN8, "in8", NULL, 0, 0644, NULL, &i2c_proc_real,
 	 &i2c_sysctl_real, NULL, &w83781d_in},
-	{W83781D_SYSCTL_FAN1, "fan1", NULL, 0, 0644, NULL, &i2c_proc_real,
+{W83781D_SYSCTL_FAN1, "fan1", NULL, 0, 0644, NULL, &i2c_proc_real,
 	 &i2c_sysctl_real, NULL, &w83781d_fan},
 	{W83781D_SYSCTL_FAN2, "fan2", NULL, 0, 0644, NULL, &i2c_proc_real,
 	 &i2c_sysctl_real, NULL, &w83781d_fan},
@@ -662,6 +691,66 @@
 	{0}
 };
 
+/* w83791D has 10 voltages 5 fans and 3 temps.  2 of the temps are on other 
+ devices. */
+static ctl_table w83791d_dir_table_template[] = {
+	{W83781D_SYSCTL_IN0, "in0", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_in},
+	{W83781D_SYSCTL_IN1, "in1", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_in},
+	{W83781D_SYSCTL_IN2, "in2", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_in},
+	{W83781D_SYSCTL_IN3, "in3", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_in},
+	{W83781D_SYSCTL_IN4, "in4", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_in},
+	{W83781D_SYSCTL_IN5, "in5", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_in},
+	{W83781D_SYSCTL_IN6, "in6", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_in},
+	{W83781D_SYSCTL_IN7, "in7", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_in},
+	{W83781D_SYSCTL_IN8, "in8", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_in},
+	{W83781D_SYSCTL_IN9, "in9", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_in},
+	{W83781D_SYSCTL_FAN1, "fan1", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_fan},
+	{W83781D_SYSCTL_FAN2, "fan2", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_fan},
+	{W83781D_SYSCTL_FAN3, "fan3", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_fan},
+	{W83781D_SYSCTL_FAN4, "fan4", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_fan},
+	{W83781D_SYSCTL_FAN5, "fan5", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_fan},
+	{W83781D_SYSCTL_TEMP1, "temp1", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_temp},
+	{W83781D_SYSCTL_TEMP2, "temp2", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_temp_add},
+	{W83781D_SYSCTL_TEMP3, "temp3", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_temp_add},
+	{W83781D_SYSCTL_VID, "vid", NULL, 0, 0444, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_vid},
+	{W83781D_SYSCTL_FAN_DIV, "fan_div", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_fan_div},
+	{W83781D_SYSCTL_ALARMS, "alarms", NULL, 0, 0444, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_alarms},
+	{W83781D_SYSCTL_BEEP, "beep", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_beep},
+	{W83781D_SYSCTL_PWM1, "pwm1", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_pwm},
+	{W83781D_SYSCTL_PWM2, "pwm2", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_pwm},
+	{W83781D_SYSCTL_PWM3, "pwm3", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_pwm},
+	{W83781D_SYSCTL_PWM4, "pwm4", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_pwm},
+	{W83781D_SYSCTL_VRM, "vrm", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &w83781d_vrm},
+	{0}
+};
+
 static ctl_table w83783s_dir_table_template[] = {
 	{W83781D_SYSCTL_IN0, "in0", NULL, 0, 0644, NULL, &i2c_proc_real,
 	 &i2c_sysctl_real, NULL, &w83781d_in},
@@ -884,6 +973,8 @@
 			kind = w83783s;
 		else if (val1 = 0x20 && vendid = winbond)
 			kind = w83627hf;
+		else if (val1 = 0x70 && vendid = winbond)
+			kind = w83791d;
 		else if (val1 = 0x30 && vendid = asus && !is_isa)
 			kind = as99127f;
 		else if (val1 = 0x60 && vendid = winbond && is_isa)
@@ -916,6 +1007,9 @@
 	} else if (kind = w83697hf) {
 		type_name = "w83697hf";
 		client_name = "W83697HF chip";
+        } else if (kind = w83791d) {
+ 		type_name = "w83791d";
+ 		client_name = "W83791D chip";
 	} else {
 #ifdef DEBUG
 		printk(KERN_ERR "w83781d.o: Internal error: unknown kind (%d)?!?",
@@ -990,6 +1084,9 @@
 			client_name = "W83627HF subclient";
 		else if (kind = as99127f)
 			client_name = "AS99127F subclient";
+                else if (kind = w83791d)
+			client_name = "W83791D subclient";
+
 
 		for (i = 0; i <= 1; i++) {
 			data->lm75[i].data = NULL;	/* store all data in w83781d */
@@ -1023,8 +1120,10 @@
 					   w83783s_dir_table_template :
 					(kind = w83697hf) ?
 					   w83697hf_dir_table_template :
-					(is_isa || kind = w83627hf) ?
+                                        (kind = w83791d ) ?
 					   w83782d_isa_dir_table_template :
+					(is_isa || kind = w83627hf) ?
+                                           w83791d_dir_table_template :
 					   w83782d_i2c_dir_table_template,
 					THIS_MODULE)) < 0) {
 		err = i;
@@ -1300,7 +1399,11 @@
 		vid = w83781d_read_value(client, W83781D_REG_VID_FANDIV) & 0x0f;
 		vid | 		    (w83781d_read_value(client, W83781D_REG_CHIPID) & 0x01) << 4;
+                if (type = w83791d) {
+                        data->vrm = 92;
+                } else {
 		data->vrm = DEFAULT_VRM;
+                }
 		vid = vid_from_reg(vid, data->vrm);
 	}
 
@@ -1351,6 +1454,48 @@
 #endif				/* W83781D_RT */
 
 	if(init) {
+                if (type = w83791d) {
+                        w83781d_write_value(client, W83791D_REG_IN_MIN(0),
+                                            IN_TO_REG(W83781D_INIT_IN_MIN_0));
+                        w83781d_write_value(client, W83791D_REG_IN_MAX(0),
+                                            IN_TO_REG(W83781D_INIT_IN_MAX_0));
+                        w83781d_write_value(client, W83791D_REG_IN_MIN(1),
+                                            IN_TO_REG(W83781D_INIT_IN_MIN_1));
+                        w83781d_write_value(client, W83791D_REG_IN_MAX(1),
+                                            IN_TO_REG(W83781D_INIT_IN_MAX_1));
+                        w83781d_write_value(client, W83791D_REG_IN_MIN(2),
+                                            IN_TO_REG(W83781D_INIT_IN_MIN_2));
+                        w83781d_write_value(client, W83791D_REG_IN_MAX(2),
+                                            IN_TO_REG(W83781D_INIT_IN_MAX_2));
+                        w83781d_write_value(client, W83791D_REG_IN_MIN(3),
+                                            IN_TO_REG(W83781D_INIT_IN_MIN_3));
+                        w83781d_write_value(client, W83791D_REG_IN_MAX(3),
+                                            IN_TO_REG(W83781D_INIT_IN_MAX_3));
+                        w83781d_write_value(client, W83791D_REG_IN_MIN(4),
+                                            IN_TO_REG(W83781D_INIT_IN_MIN_4));
+                        w83781d_write_value(client, W83791D_REG_IN_MAX(4),
+                                            IN_TO_REG(W83781D_INIT_IN_MAX_4));
+                        w83781d_write_value(client, W83791D_REG_IN_MIN(5),
+                                            IN_TO_REG(W83781D_INIT_IN_MIN_5));
+                        w83781d_write_value(client, W83791D_REG_IN_MAX(5),
+                                            IN_TO_REG(W83781D_INIT_IN_MAX_5));
+                        w83781d_write_value(client, W83791D_REG_IN_MIN(6),
+                                            IN_TO_REG(W83781D_INIT_IN_MIN_6));
+                        w83781d_write_value(client, W83791D_REG_IN_MAX(6),
+                                            IN_TO_REG(W83781D_INIT_IN_MAX_6));
+                        w83781d_write_value(client, W83791D_REG_IN_MIN(7),
+                                            IN_TO_REG(W83781D_INIT_IN_MIN_7));
+                        w83781d_write_value(client, W83791D_REG_IN_MAX(7),
+                                            IN_TO_REG(W83781D_INIT_IN_MAX_7));
+                        w83781d_write_value(client, W83791D_REG_IN_MIN(8),
+                                            IN_TO_REG(W83781D_INIT_IN_MIN_8));
+                        w83781d_write_value(client, W83791D_REG_IN_MAX(8),
+                                            IN_TO_REG(W83781D_INIT_IN_MAX_8));
+                        w83781d_write_value(client, W83791D_REG_IN_MIN(9),
+                                            IN_TO_REG(W83781D_INIT_IN_MIN_9));
+                        w83781d_write_value(client, W83791D_REG_IN_MAX(9),
+                                            IN_TO_REG(W83781D_INIT_IN_MAX_9));
+                } else {
 		w83781d_write_value(client, W83781D_REG_IN_MIN(0),
 				    IN_TO_REG(W83781D_INIT_IN_MIN_0));
 		w83781d_write_value(client, W83781D_REG_IN_MAX(0),
@@ -1409,6 +1554,8 @@
 			w83781d_write_value(client, W83781D_REG_VBAT,
 			    (w83781d_read_value(client, W83781D_REG_VBAT) | 0x01));
 		}
+                }
+
 		w83781d_write_value(client, W83781D_REG_FAN_MIN(1),
 				    FAN_TO_REG(W83781D_INIT_FAN_MIN_1, 2));
 		w83781d_write_value(client, W83781D_REG_FAN_MIN(2),
@@ -1493,6 +1640,16 @@
 			if ((data->type = w83783s || data->type = w83697hf)
 			    && (i = 1))
 				continue;	/* 783S has no in1 */
+                        if (data->type = w83791d) {
+                                data->in[i] +                                        w83781d_read_value(client, W83791D_REG_IN(i));
+                                data->in_min[i] +                                        w83781d_read_value(client,
+                                                           W83791D_REG_IN_MIN(i));
+                                data->in_max[i] +                                        w83781d_read_value(client,
+                                                           W83791D_REG_IN_MAX(i));
+                        } else {
 			data->in[i]  			    w83781d_read_value(client, W83781D_REG_IN(i));
 			data->in_min[i] @@ -1501,26 +1658,36 @@
 			data->in_max[i]  			    w83781d_read_value(client,
 					       W83781D_REG_IN_MAX(i));
+                        }
 			if ((data->type != w83782d) && (data->type != w83697hf)
-			    && (data->type != w83627hf) && (i = 6))
+			    && (data->type != w83627hf) && (data->type != w83791d)
+                            && (i = 6))
+				break;
+                        if ((data->type != w83791d)  && (i = 7))
 				break;
 		}
-		for (i = 1; i <= 3; i++) {
+		for (i = 1; i <= 5; i++) {
 			data->fan[i - 1]  			    w83781d_read_value(client, W83781D_REG_FAN(i));
 			data->fan_min[i - 1]  			    w83781d_read_value(client,
 					       W83781D_REG_FAN_MIN(i));
+                        if ((data->type != w83791d)
+                            && (i = 3))
+                                break;
 		}
 		if (data->type != w83781d) {
 			for (i = 1; i <= 4; i++) {
 				data->pwm[i - 1]  				    w83781d_read_value(client,
+						       data->type = w83791d?
+                                                       W83791D_REG_PWM(i):
 						       W83781D_REG_PWM(i));
 				if (((data->type = w83783s)
 				     || (data->type = w83627hf)
 				     || (data->type = as99127f)
 				     || (data->type = w83697hf)
+                                     || (data->type = w83791d)
 				     || ((data->type = w83782d)
 				        && i2c_is_isa_client(client)))
 				    && i = 2)
@@ -1580,7 +1747,8 @@
 		data->beep_enable = i >> 7;
 		data->beeps = ((i & 0x7f) << 8) +
 		    w83781d_read_value(client, W83781D_REG_BEEP_INTS1);
-		if ((data->type != w83781d) && (data->type != as99127f)) {
+		if ((data->type != w83781d) && (data->type != as99127f)
+                    && (data->type != w83791d)) {
 			data->beeps | 			    w83781d_read_value(client,
 					       W83781D_REG_BEEP_INTS3) << 16;
diff -urbBd linux-2.4.18-56/include/linux/sensors.h linux-2.4.18-57/include/linux/sensors.h
--- linux-2.4.18-56/include/linux/sensors.h	Thu Apr 17 10:53:53 2003
+++ linux-2.4.18-57/include/linux/sensors.h	Fri Apr 18 14:12:00 2003
@@ -63,9 +63,14 @@
 #define W83781D_SYSCTL_IN6 1006
 #define W83781D_SYSCTL_IN7 1007
 #define W83781D_SYSCTL_IN8 1008
+#define W83781D_SYSCTL_IN9 1009
+
 #define W83781D_SYSCTL_FAN1 1101	/* Rotations/min */
 #define W83781D_SYSCTL_FAN2 1102
 #define W83781D_SYSCTL_FAN3 1103
+#define W83781D_SYSCTL_FAN4 1104
+#define W83781D_SYSCTL_FAN5 1105
+
 #define W83781D_SYSCTL_TEMP1 1200	/* Degrees Celcius * 10 */
 #define W83781D_SYSCTL_TEMP2 1201	/* Degrees Celcius * 10 */
 #define W83781D_SYSCTL_TEMP3 1202	/* Degrees Celcius * 10 */
-------------- next part --------------
diff -durbB lm_sensors-2.7.0/kernel/include/sensors.h lm_sensors-2.7.0-w83791d/kernel/include/sensors.h
--- lm_sensors-2.7.0/kernel/include/sensors.h	Fri Nov 15 18:02:44 2002
+++ lm_sensors-2.7.0-w83791d/kernel/include/sensors.h	Mon Apr 21 09:29:11 2003
@@ -63,9 +63,14 @@
 #define W83781D_SYSCTL_IN6 1006
 #define W83781D_SYSCTL_IN7 1007
 #define W83781D_SYSCTL_IN8 1008
+#define W83781D_SYSCTL_IN9 1009
+
 #define W83781D_SYSCTL_FAN1 1101	/* Rotations/min */
 #define W83781D_SYSCTL_FAN2 1102
 #define W83781D_SYSCTL_FAN3 1103
+#define W83781D_SYSCTL_FAN4 1104
+#define W83781D_SYSCTL_FAN5 1105
+
 #define W83781D_SYSCTL_TEMP1 1200	/* Degrees Celcius * 10 */
 #define W83781D_SYSCTL_TEMP2 1201	/* Degrees Celcius * 10 */
 #define W83781D_SYSCTL_TEMP3 1202	/* Degrees Celcius * 10 */
diff -durbB lm_sensors-2.7.0/lib/chips.c lm_sensors-2.7.0-w83791d/lib/chips.c
--- lm_sensors-2.7.0/lib/chips.c	Sat Nov 16 11:08:55 2002
+++ lm_sensors-2.7.0-w83791d/lib/chips.c	Mon Apr 21 11:40:33 2003
@@ -3333,6 +3334,167 @@
     { 0 }
   };
 
+static sensors_chip_feature w83791d_features[] +  { 
+    { SENSORS_W83791D_IN0, "in0", SENSORS_NO_MAPPING, SENSORS_NO_MAPPING, 
+                        SENSORS_MODE_R, W83781D_SYSCTL_IN0, VALUE(3), 2 },
+    { SENSORS_W83791D_IN1, "in1", SENSORS_NO_MAPPING, SENSORS_NO_MAPPING,
+                        SENSORS_MODE_R, W83781D_SYSCTL_IN1, VALUE(3), 2 },
+    { SENSORS_W83791D_IN2, "in2", SENSORS_NO_MAPPING, SENSORS_NO_MAPPING,
+                        SENSORS_MODE_R, W83781D_SYSCTL_IN2, VALUE(3), 2 },
+    { SENSORS_W83791D_IN3, "in3", SENSORS_NO_MAPPING, SENSORS_NO_MAPPING,
+                        SENSORS_MODE_R, W83781D_SYSCTL_IN3, VALUE(3), 2 },
+    { SENSORS_W83791D_IN4, "in4", SENSORS_NO_MAPPING, SENSORS_NO_MAPPING,
+                        SENSORS_MODE_R, W83781D_SYSCTL_IN4, VALUE(3), 2 },
+    { SENSORS_W83791D_IN5, "in5", SENSORS_NO_MAPPING, SENSORS_NO_MAPPING,
+                        SENSORS_MODE_R, W83781D_SYSCTL_IN5, VALUE(3), 2 },
+    { SENSORS_W83791D_IN6, "in6", SENSORS_NO_MAPPING, SENSORS_NO_MAPPING,
+                        SENSORS_MODE_R, W83781D_SYSCTL_IN6, VALUE(3), 2 },
+    { SENSORS_W83791D_IN7, "in7", SENSORS_NO_MAPPING, SENSORS_NO_MAPPING,
+                        SENSORS_MODE_R, W83781D_SYSCTL_IN7, VALUE(3), 2 },
+    { SENSORS_W83791D_IN8, "in8", SENSORS_NO_MAPPING, SENSORS_NO_MAPPING,
+                        SENSORS_MODE_R, W83781D_SYSCTL_IN8, VALUE(3), 2 },
+    { SENSORS_W83791D_IN9, "in9", SENSORS_NO_MAPPING, SENSORS_NO_MAPPING,
+                        SENSORS_MODE_R, W83781D_SYSCTL_IN9, VALUE(3), 2 },
+    { SENSORS_W83791D_IN0_MIN, "in0_min", SENSORS_W83791D_IN0, 
+                        SENSORS_W83791D_IN0, SENSORS_MODE_RW, 
+                        W83781D_SYSCTL_IN0, VALUE(1), 2 },
+    { SENSORS_W83791D_IN1_MIN, "in1_min", SENSORS_W83791D_IN1, 
+                        SENSORS_W83791D_IN1, SENSORS_MODE_RW, 
+                        W83781D_SYSCTL_IN1, VALUE(1), 2 },
+    { SENSORS_W83791D_IN2_MIN, "in2_min", SENSORS_W83791D_IN2, 
+                        SENSORS_W83791D_IN2, SENSORS_MODE_RW, 
+                        W83781D_SYSCTL_IN2, VALUE(1), 2 },
+    { SENSORS_W83791D_IN3_MIN, "in3_min", SENSORS_W83791D_IN3, 
+                        SENSORS_W83791D_IN3, SENSORS_MODE_RW, 
+                        W83781D_SYSCTL_IN3, VALUE(1), 2 },
+    { SENSORS_W83791D_IN4_MIN, "in4_min", SENSORS_W83791D_IN4, 
+                        SENSORS_W83791D_IN4, SENSORS_MODE_RW, 
+                        W83781D_SYSCTL_IN4, VALUE(1), 2 },
+    { SENSORS_W83791D_IN5_MIN, "in5_min", SENSORS_W83791D_IN5, 
+                        SENSORS_W83791D_IN5, SENSORS_MODE_RW, 
+                        W83781D_SYSCTL_IN5, VALUE(1), 2 },
+    { SENSORS_W83791D_IN6_MIN, "in6_min", SENSORS_W83791D_IN6, 
+                        SENSORS_W83791D_IN6, SENSORS_MODE_RW, 
+                        W83781D_SYSCTL_IN6, VALUE(1), 2 },
+    { SENSORS_W83791D_IN7_MIN, "in7_min", SENSORS_W83791D_IN7, 
+                        SENSORS_W83791D_IN7, SENSORS_MODE_RW, 
+                        W83781D_SYSCTL_IN7, VALUE(1), 2 },
+    { SENSORS_W83791D_IN8_MIN, "in8_min", SENSORS_W83791D_IN8, 
+                        SENSORS_W83791D_IN8, SENSORS_MODE_RW, 
+                        W83781D_SYSCTL_IN8, VALUE(1), 2 },
+    { SENSORS_W83791D_IN9_MIN, "in9_min", SENSORS_W83791D_IN9, 
+                        SENSORS_W83791D_IN9, SENSORS_MODE_RW, 
+                        W83781D_SYSCTL_IN9, VALUE(1), 2 },
+    { SENSORS_W83791D_IN0_MAX, "in0_max", SENSORS_W83791D_IN0, 
+                        SENSORS_W83791D_IN0, SENSORS_MODE_RW,
+                        W83781D_SYSCTL_IN0, VALUE(2), 2 },
+    { SENSORS_W83791D_IN1_MAX, "in1_max", SENSORS_W83791D_IN1, 
+                        SENSORS_W83791D_IN1, SENSORS_MODE_RW, 
+                        W83781D_SYSCTL_IN1, VALUE(2), 2 },
+    { SENSORS_W83791D_IN2_MAX, "in2_max", SENSORS_W83791D_IN2, 
+                        SENSORS_W83791D_IN2, SENSORS_MODE_RW, 
+                        W83781D_SYSCTL_IN2, VALUE(2), 2 },
+    { SENSORS_W83791D_IN3_MAX, "in3_max", SENSORS_W83791D_IN3, 
+                        SENSORS_W83791D_IN3, SENSORS_MODE_RW, 
+                        W83781D_SYSCTL_IN3, VALUE(2), 2 },
+    { SENSORS_W83791D_IN4_MAX, "in4_max", SENSORS_W83791D_IN4, 
+                        SENSORS_W83791D_IN4, SENSORS_MODE_RW,
+                        W83781D_SYSCTL_IN4, VALUE(2), 2 },
+    { SENSORS_W83791D_IN5_MAX, "in5_max", SENSORS_W83791D_IN5, 
+                        SENSORS_W83791D_IN5, SENSORS_MODE_RW, 
+                        W83781D_SYSCTL_IN5, VALUE(2), 2 },
+    { SENSORS_W83791D_IN6_MAX, "in6_max", SENSORS_W83791D_IN6, 
+                        SENSORS_W83791D_IN6, SENSORS_MODE_RW, 
+                        W83781D_SYSCTL_IN6, VALUE(2), 2 },
+    { SENSORS_W83791D_IN7_MAX, "in7_max", SENSORS_W83791D_IN7, 
+                        SENSORS_W83791D_IN7, SENSORS_MODE_RW, 
+                        W83781D_SYSCTL_IN7, VALUE(2), 2 },
+    { SENSORS_W83791D_IN8_MAX, "in8_max", SENSORS_W83791D_IN8, 
+                        SENSORS_W83791D_IN8, SENSORS_MODE_RW, 
+                        W83781D_SYSCTL_IN8, VALUE(2), 2 },
+    { SENSORS_W83791D_IN9_MAX, "in9_max", SENSORS_W83791D_IN9, 
+                        SENSORS_W83791D_IN9, SENSORS_MODE_RW, 
+                        W83781D_SYSCTL_IN9, VALUE(2), 2 },
+    { SENSORS_W83791D_FAN1, "fan1", SENSORS_NO_MAPPING, SENSORS_NO_MAPPING,
+                        SENSORS_MODE_R, W83781D_SYSCTL_FAN1, VALUE(2), 0 },
+    { SENSORS_W83791D_FAN2, "fan2", SENSORS_NO_MAPPING, SENSORS_NO_MAPPING,
+                        SENSORS_MODE_R, W83781D_SYSCTL_FAN2, VALUE(2), 0 },
+    { SENSORS_W83791D_FAN3, "fan3", SENSORS_NO_MAPPING, SENSORS_NO_MAPPING,
+                        SENSORS_MODE_R, W83781D_SYSCTL_FAN3, VALUE(2), 0 },
+    { SENSORS_W83791D_FAN4, "fan4", SENSORS_NO_MAPPING, SENSORS_NO_MAPPING,
+                        SENSORS_MODE_R, W83781D_SYSCTL_FAN4, VALUE(2), 0 },
+    { SENSORS_W83791D_FAN5, "fan5", SENSORS_NO_MAPPING, SENSORS_NO_MAPPING,
+                        SENSORS_MODE_R, W83781D_SYSCTL_FAN5, VALUE(2), 0 },
+    { SENSORS_W83791D_FAN1_MIN, "fan1_min", SENSORS_W83791D_FAN1,
+                        SENSORS_W83791D_FAN1, SENSORS_MODE_RW, 
+                        W83781D_SYSCTL_FAN1, VALUE(1), 0 },
+    { SENSORS_W83791D_FAN2_MIN, "fan2_min", SENSORS_W83791D_FAN2, 
+                        SENSORS_W83791D_FAN2, SENSORS_MODE_RW, 
+                        W83781D_SYSCTL_FAN2, VALUE(1), 0 },
+    { SENSORS_W83791D_FAN3_MIN, "fan3_min", SENSORS_W83791D_FAN3, 
+                        SENSORS_W83791D_FAN3, SENSORS_MODE_RW, 
+                        W83781D_SYSCTL_FAN3, VALUE(1), 0 },
+    { SENSORS_W83791D_FAN4_MIN, "fan4_min", SENSORS_W83791D_FAN4, 
+                        SENSORS_W83791D_FAN4, SENSORS_MODE_RW, 
+                        W83781D_SYSCTL_FAN4, VALUE(1), 0 },
+    { SENSORS_W83791D_FAN5_MIN, "fan5_min", SENSORS_W83791D_FAN5, 
+                        SENSORS_W83791D_FAN5, SENSORS_MODE_RW, 
+                        W83781D_SYSCTL_FAN5, VALUE(1), 0 },
+    { SENSORS_W83791D_TEMP1, "temp1", SENSORS_NO_MAPPING, SENSORS_NO_MAPPING,
+                         SENSORS_MODE_R, W83781D_SYSCTL_TEMP1, VALUE(3), 1 },
+    { SENSORS_W83791D_TEMP1_HYST, "temp1_hyst", SENSORS_W83791D_TEMP1,
+                         SENSORS_W83791D_TEMP1, SENSORS_MODE_RW, 
+                         W83781D_SYSCTL_TEMP1, VALUE(2), 1 },
+    { SENSORS_W83791D_TEMP1_OVER, "temp1_over", SENSORS_W83791D_TEMP1,
+                         SENSORS_W83791D_TEMP1, SENSORS_MODE_RW, 
+                         W83781D_SYSCTL_TEMP1, VALUE(1), 1 },
+    { SENSORS_W83791D_TEMP2, "temp2", SENSORS_NO_MAPPING, SENSORS_NO_MAPPING,
+                         SENSORS_MODE_R, W83781D_SYSCTL_TEMP2, VALUE(3), 1 },
+    { SENSORS_W83791D_TEMP2_HYST, "temp2_hyst", SENSORS_W83791D_TEMP2,
+                         SENSORS_W83791D_TEMP2, SENSORS_MODE_RW, 
+                         W83781D_SYSCTL_TEMP2, VALUE(2), 1 },
+    { SENSORS_W83791D_TEMP2_OVER, "temp2_over", SENSORS_W83791D_TEMP2,
+                         SENSORS_W83791D_TEMP2, SENSORS_MODE_RW, 
+                         W83781D_SYSCTL_TEMP2, VALUE(1), 1 },
+    { SENSORS_W83791D_TEMP3, "temp3", SENSORS_NO_MAPPING, SENSORS_NO_MAPPING,
+                         SENSORS_MODE_R, W83781D_SYSCTL_TEMP3, VALUE(3), 1 },
+    { SENSORS_W83791D_TEMP3_HYST, "temp3_hyst", SENSORS_W83791D_TEMP3,
+                         SENSORS_W83791D_TEMP3, SENSORS_MODE_RW, 
+                         W83781D_SYSCTL_TEMP3, VALUE(2), 1 },
+    { SENSORS_W83791D_TEMP3_OVER, "temp3_over", SENSORS_W83791D_TEMP3,
+                         SENSORS_W83791D_TEMP3, SENSORS_MODE_RW, 
+                         W83781D_SYSCTL_TEMP3, VALUE(1), 1 },
+    { SENSORS_W83791D_VID, "vid", SENSORS_NO_MAPPING, SENSORS_NO_MAPPING,
+                         SENSORS_MODE_R, W83781D_SYSCTL_VID, VALUE(1), 3 },
+    { SENSORS_W83791D_VRM, "vrm", SENSORS_NO_MAPPING, SENSORS_NO_MAPPING,
+                         SENSORS_MODE_RW, W83781D_SYSCTL_VRM, VALUE(1), 1 },
+    { SENSORS_W83791D_FAN1_DIV, "fan1_div", SENSORS_W83791D_FAN1, 
+                         SENSORS_NO_MAPPING, SENSORS_MODE_RW, 
+                         W83781D_SYSCTL_FAN_DIV, VALUE(1), 0 },
+    { SENSORS_W83791D_FAN2_DIV, "fan2_div", SENSORS_W83791D_FAN2, 
+                         SENSORS_NO_MAPPING, SENSORS_MODE_RW, 
+                         W83781D_SYSCTL_FAN_DIV, VALUE(2), 0 },
+    { SENSORS_W83791D_FAN3_DIV, "fan3_div", SENSORS_W83781D_FAN3, 
+                         SENSORS_NO_MAPPING, SENSORS_MODE_RW, 
+                         W83781D_SYSCTL_FAN_DIV, VALUE(3), 0 },
+    { SENSORS_W83791D_FAN4_DIV, "fan4_div", SENSORS_W83791D_FAN4, 
+                         SENSORS_NO_MAPPING, SENSORS_MODE_RW, 
+                         W83781D_SYSCTL_FAN_DIV, VALUE(4), 0 },
+    { SENSORS_W83791D_FAN5_DIV, "fan5_div", SENSORS_W83791D_FAN5, 
+                         SENSORS_NO_MAPPING, SENSORS_MODE_RW, 
+                         W83781D_SYSCTL_FAN_DIV, VALUE(5), 0 },
+    { SENSORS_W83791D_ALARMS, "alarms", SENSORS_NO_MAPPING, SENSORS_NO_MAPPING, 
+                         SENSORS_MODE_R, W83781D_SYSCTL_ALARMS, VALUE(1), 0 },
+    { SENSORS_W83791D_BEEP_ENABLE, "beep_enable", SENSORS_W83791D_ALARMS,
+                         SENSORS_NO_MAPPING, SENSORS_MODE_RW,
+                         W83781D_SYSCTL_BEEP, VALUE(1), 0 },
+    { SENSORS_W83791D_BEEPS, "beeps", SENSORS_W83791D_ALARMS,
+                         SENSORS_W83791D_ALARMS, SENSORS_MODE_RW,
+                         W83781D_SYSCTL_BEEP, VALUE(2), 0 },
+    { 0 }
+  };
+
 sensors_chip_features sensors_chip_features_list[]  {
  { SENSORS_LM78_PREFIX, lm78_features },
@@ -3348,6 +3510,7 @@
  { SENSORS_W83697HF_PREFIX, w83782d_features }, /* same as 782d */
 		/* Cheat on 83627HF for now - no separate #defines */
  { SENSORS_W83627HF_PREFIX, w83782d_features },
+ { SENSORS_W83791D_PREFIX, w83791d_features },
  { SENSORS_AS99127F_PREFIX, as99127f_features },
  { SENSORS_ADM9240_PREFIX, adm9240_features },
 		/* Cheat on LM81 for now - no separate #defines */
diff -durbB lm_sensors-2.7.0/lib/chips.h lm_sensors-2.7.0-w83791d/lib/chips.h
--- lm_sensors-2.7.0/lib/chips.h	Sat Nov 16 10:23:54 2002
+++ lm_sensors-2.7.0-w83791d/lib/chips.h	Mon Apr 21 09:41:09 2003
@@ -377,6 +377,84 @@
 
 #define SENSORS_W83782D_PREFIX "w83782d"
 #define SENSORS_W83627HF_PREFIX "w83627hf"
+
+#define SENSORS_W83791D_PREFIX "w83791d"
+
+
+#define SENSORS_W83791D_IN0 1 /* R */
+#define SENSORS_W83791D_IN1 2 /* R */
+#define SENSORS_W83791D_IN2 3 /* R */
+#define SENSORS_W83791D_IN3 4 /* R */
+#define SENSORS_W83791D_IN4 5 /* R */
+#define SENSORS_W83791D_IN5 6 /* R */
+#define SENSORS_W83791D_IN6 7 /* R */
+#define SENSORS_W83791D_IN7 8 /* R */
+#define SENSORS_W83791D_IN8 9 /* R */
+#define SENSORS_W83791D_IN9 10 /* R */
+
+#define SENSORS_W83791D_IN0_MIN 11 /* RW */
+#define SENSORS_W83791D_IN1_MIN 12 /* RW */
+#define SENSORS_W83791D_IN2_MIN 13 /* RW */
+#define SENSORS_W83791D_IN3_MIN 14 /* RW */
+#define SENSORS_W83791D_IN4_MIN 15 /* RW */
+#define SENSORS_W83791D_IN5_MIN 16 /* RW */
+#define SENSORS_W83791D_IN6_MIN 17 /* RW */
+#define SENSORS_W83791D_IN7_MIN 18 /* RW */
+#define SENSORS_W83791D_IN8_MIN 19 /* RW */
+#define SENSORS_W83791D_IN9_MIN 20 /* RW */
+
+#define SENSORS_W83791D_IN0_MAX 21 /* RW */
+#define SENSORS_W83791D_IN1_MAX 22 /* RW */
+#define SENSORS_W83791D_IN2_MAX 23 /* RW */
+#define SENSORS_W83791D_IN3_MAX 24 /* RW */
+#define SENSORS_W83791D_IN4_MAX 25 /* RW */
+#define SENSORS_W83791D_IN5_MAX 26 /* RW */
+#define SENSORS_W83791D_IN6_MAX 27 /* RW */
+#define SENSORS_W83791D_IN7_MAX 28 /* RW */
+#define SENSORS_W83791D_IN8_MAX 29 /* RW */
+#define SENSORS_W83791D_IN9_MAX 30 /* RW */
+
+#define SENSORS_W83791D_FAN1 31 /* R */
+#define SENSORS_W83791D_FAN2 32 /* R */
+#define SENSORS_W83791D_FAN3 33 /* R */
+#define SENSORS_W83791D_FAN4 34 /* R */
+#define SENSORS_W83791D_FAN5 35 /* R */
+
+#define SENSORS_W83791D_FAN1_MIN 41 /* RW */
+#define SENSORS_W83791D_FAN2_MIN 42 /* RW */
+#define SENSORS_W83791D_FAN3_MIN 43 /* RW */
+#define SENSORS_W83791D_FAN4_MIN 44 /* RW */
+#define SENSORS_W83791D_FAN5_MIN 45 /* RW */
+
+
+#define SENSORS_W83791D_TEMP1 51 /* R */
+#define SENSORS_W83791D_TEMP1_HYST 52 /* RW */
+#define SENSORS_W83791D_TEMP1_OVER 53 /* RW */
+#define SENSORS_W83791D_TEMP2 54 /* R */
+#define SENSORS_W83791D_TEMP2_HYST 55 /* RW */
+#define SENSORS_W83791D_TEMP2_OVER 56 /* RW */
+#define SENSORS_W83791D_TEMP3 57 /* R */
+#define SENSORS_W83791D_TEMP3_HYST 58 /* RW */
+#define SENSORS_W83791D_TEMP3_OVER 59 /* RW */
+#define SENSORS_W83791D_VID 61 /* R */
+#define SENSORS_W83791D_VRM 62 /* RW */
+
+#define SENSORS_W83791D_FAN1_DIV 71 /* RW */
+#define SENSORS_W83791D_FAN2_DIV 72 /* RW */
+#define SENSORS_W83791D_FAN3_DIV 73 /* R (yes, really! */
+#define SENSORS_W83791D_FAN4_DIV 74 /* R (yes, really! */
+#define SENSORS_W83791D_FAN5_DIV 75 /* R (yes, really! */
+
+#define SENSORS_W83791D_ALARMS 81 /* R */
+#define SENSORS_W83791D_BEEP_ENABLE 82 /* RW */
+#define SENSORS_W83791D_BEEPS 83 /* RW */
+#define SENSORS_W83791D_SENS1 91 /* RW */
+#define SENSORS_W83791D_SENS2 92 /* RW */
+#define SENSORS_W83791D_SENS3 93 /* RW */
+
+
+
+
 #define SENSORS_AS99127F_PREFIX "as99127f"
 
 #define SENSORS_W83782D_IN0 1 /* R */
