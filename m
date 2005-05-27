From: grant_lkml@dodo.com.au (Grant Coady)
Date: Fri, 27 May 2005 07:10:34 +0000
Subject: [lm-sensors] RFC PATCH lm_sensors2: remove w83697hf,
Message-Id: <o7ad91ltnq1aeeu41kca15fbmn86ulc4qn@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings,

This patch removes non-i2c drivers from lm_sensors and complements 
removal of same from 2.6 kernel.  Compile tested. 'make clean; make'

Needs a tester?

--Grant.


Signed-off-by: Grant Coady <gcoady@gmail.com>

---
 CHANGES                |    1 
 kernel/chips/w83781d.c |  110 +++++++------------------------------------------
 2 files changed, 18 insertions(+), 93 deletions(-)

diff -X /usr/src/dontdiff -rupN lm_sensors2/CHANGES lm_sensors2a/CHANGES
--- lm_sensors2/CHANGES	2005-05-16 08:31:02.000000000 +1000
+++ lm_sensors2a/CHANGES	2005-05-27 15:05:44.000000000 +1000
@@ -22,6 +22,7 @@ ask CVS about it:
   Module i2c-ali1563: New (2.6 backport by Winbond)
   Modules i2c-ipmb, i2c-ipmi: Support ipmi_request() additional argument
   Module smsc47m1: Fix PWM enable polarity on read
+  Module w83781d: remove non-i2c drivers w83697hf, w83627hf (Grant Coady)
   Program fancontrol.pl: Fix compile errors
   Program mkpatch: Include i2c-ali1563
                    Include w83792d
diff -X /usr/src/dontdiff -rupN lm_sensors2/kernel/chips/w83781d.c lm_sensors2a/kernel/chips/w83781d.c
--- lm_sensors2/kernel/chips/w83781d.c	2005-05-16 08:31:03.000000000 +1000
+++ lm_sensors2a/kernel/chips/w83781d.c	2005-05-27 15:01:05.000000000 +1000
@@ -26,8 +26,6 @@
     Chip	#vin	#fanin	#pwm	#temp	wchipid	vendid	i2c	ISA
     as99127f	7	3	0	3	0x31	0x12c3	yes	no
     as99127f rev.2 (type name = as99127f)	0x31	0x5ca3	yes	no
-    w83627hf	9	3	2	3	0x21	0x5ca3	yes	yes(LPC)
-    w83697hf	8	2	2	2	0x60	0x5ca3	no	yes(LPC)
     w83781d	7	3	0	3	0x10-1	0x5ca3	yes	yes
     w83782d	9	3	2-4	3	0x30	0x5ca3	yes	yes
     w83783s	5-6	3	2	1-2	0x40	0x5ca3	yes	no
@@ -56,7 +54,7 @@ static unsigned int normal_isa[] = { 0x0
 static unsigned int normal_isa_range[] = { SENSORS_ISA_END };
 
 /* Insmod parameters */
-SENSORS_INSMOD_7(w83781d, w83782d, w83783s, w83627hf, as99127f, w83697hf, w83791d);
+SENSORS_INSMOD_5(w83781d, w83782d, w83783s, as99127f, w83791d);
 SENSORS_MODULE_PARM(force_subclients, "List of subclient addresses: " \
                       "{bus, clientaddr, subclientaddr1, subclientaddr2}");
 
@@ -158,8 +156,6 @@ static const u8 regpwm_w83791d[] = { W83
         
 #define W83781D_REG_PWM(type, nr) (((type) = w83791d) ? \
                                          regpwm_w83791d[(nr) - 1] : \
-                                   ((type) = w83697hf) ? \
-                                         (((nr) * 2) - 1) : \
                                          regpwm[(nr) - 1])
 
 #define W83781D_REG_I2C_ADDR 0x48
@@ -705,51 +701,6 @@ static ctl_table w83783s_dir_table_templ
 	{0}
 };
 
-/* similar to w83782d but no fan3, no vid */
-static ctl_table w83697hf_dir_table_template[] = {
-	{W83781D_SYSCTL_IN0, "in0", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_in},
-	/* no in1 to maintain compatibility with 781d and 782d. */
-	{W83781D_SYSCTL_IN2, "in2", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_in},
-	{W83781D_SYSCTL_IN3, "in3", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_in},
-	{W83781D_SYSCTL_IN4, "in4", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_in},
-	{W83781D_SYSCTL_IN5, "in5", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_in},
-	{W83781D_SYSCTL_IN6, "in6", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_in},
-	{W83781D_SYSCTL_IN7, "in7", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_in},
-	{W83781D_SYSCTL_IN8, "in8", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_in},
-	{W83781D_SYSCTL_FAN1, "fan1", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_fan},
-	{W83781D_SYSCTL_FAN2, "fan2", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_fan},
-	{W83781D_SYSCTL_TEMP1, "temp1", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_temp},
-	{W83781D_SYSCTL_TEMP2, "temp2", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_temp_add},
-	{W83781D_SYSCTL_FAN_DIV, "fan_div", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_fan_div},
-	{W83781D_SYSCTL_ALARMS, "alarms", NULL, 0, 0444, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_alarms},
-	{W83781D_SYSCTL_BEEP, "beep", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_beep},
-	{W83781D_SYSCTL_PWM1, "pwm1", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_pwm},
-	{W83781D_SYSCTL_PWM2, "pwm2", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_pwm},
-	{W83781D_SYSCTL_SENS1, "sensor1", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_sens},
-	{W83781D_SYSCTL_SENS2, "sensor2", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &w83781d_sens},
-	{0}
-};
-
-
 /* This function is called when:
      * w83781d_driver is inserted (when this module is loaded), for each
        available adapter
@@ -881,14 +832,10 @@ static int w83781d_detect(struct i2c_ada
 			kind = w83782d;
 		else if (val1 = 0x40 && vendid = winbond && !is_isa && address = 0x2d)
 			kind = w83783s;
-		else if (val1 = 0x21 && vendid = winbond)
-			kind = w83627hf;
 		else if (val1 = 0x71 && vendid = winbond && address >= 0x2c)
 			kind = w83791d;
 		else if (val1 = 0x31 && !is_isa && address >= 0x28)
 			kind = as99127f;
-		else if (val1 = 0x60 && vendid = winbond && is_isa)
-			kind = w83697hf;
 		else {
 			if (kind = 0)
 				printk
@@ -908,15 +855,9 @@ static int w83781d_detect(struct i2c_ada
 	} else if (kind = w83783s) {
 		type_name = "w83783s";
 		client_name = "W83783S chip";
-	} else if (kind = w83627hf) {
-		type_name = "w83627hf";
-		client_name = "W83627HF chip";
 	} else if (kind = as99127f) {
 		type_name = "as99127f";
 		client_name = "AS99127F chip";
-	} else if (kind = w83697hf) {
-		type_name = "w83697hf";
-		client_name = "W83697HF chip";
         } else if (kind = w83791d) {
  		type_name = "w83791d";
  		client_name = "W83791D chip";
@@ -989,8 +930,6 @@ static int w83781d_detect(struct i2c_ada
 			client_name = "W83782D subclient";
 		else if (kind = w83783s)
 			client_name = "W83783S subclient";
-		else if (kind = w83627hf)
-			client_name = "W83627HF subclient";
 		else if (kind = as99127f)
 			client_name = "AS99127F subclient";
                 else if (kind = w83791d)
@@ -1026,11 +965,9 @@ static int w83781d_detect(struct i2c_ada
 					   w83781d_dir_table_template :
 					(kind = w83783s) ?
 					   w83783s_dir_table_template :
-					(kind = w83697hf) ?
-					   w83697hf_dir_table_template :
                                         (kind = w83791d ) ?
                                             w83791d_dir_table_template :
-                                        (is_isa || kind = w83627hf) ?
+                                        (is_isa) ?
 					   w83782d_isa_dir_table_template :
 					   w83782d_i2c_dir_table_template,
 					THIS_MODULE)) < 0) {
@@ -1284,7 +1221,7 @@ static void w83781d_init_client(struct i
 				else
 					data->sens[i - 1] = 2;
 			}
-			if ((type = w83783s || type = w83697hf) && (i = 2))
+			if ((type = w83783s) && (i = 2))
 				break;
 		}
 	}
@@ -1319,7 +1256,7 @@ static void w83781d_init_client(struct i
 
 	if (init && type != as99127f) {
 		w83781d_write_value(client, W83781D_REG_TEMP2_CONFIG, 0x00);
-		if (type != w83783s && type != w83697hf) {
+		if (type != w83783s) {
 			w83781d_write_value(client, W83781D_REG_TEMP3_CONFIG,
 					    0x00);
 		}
@@ -1352,7 +1289,7 @@ static void w83781d_update_client(struct
                pr_debug(KERN_DEBUG "Starting device update\n");
 
                for (i = 0; i <= 9; i++) {
-                       if ((data->type = w83783s || data->type = w83697hf)
+                       if ((data->type = w83783s)
                            && (i = 1))
                                continue;       /* 783S has no in1 */
                        if (data->type = w83791d) {
@@ -1374,8 +1311,8 @@ static void w83781d_update_client(struct
                            w83781d_read_value(client,
                                               W83781D_REG_IN_MAX(i));
                        }
-                       if ((data->type != w83782d) && (data->type != w83697hf)
-                           && (data->type != w83627hf) && (i = 6)
+                       if ((data->type != w83782d)
+                           && (i = 6)
                            && (data->type != w83791d))
                                break;
 
@@ -1396,8 +1333,6 @@ static void w83781d_update_client(struct
                                    w83781d_read_value(client,
 				             W83781D_REG_PWM(data->type, i));
                                if (((data->type = w83783s)
-                                    || (data->type = w83627hf)
-                                    || (data->type = w83697hf)
                                     || ((data->type = w83782d)
                                        && i2c_is_isa_client(client)))
                                    && i = 2)
@@ -1419,7 +1354,7 @@ static void w83781d_update_client(struct
                    w83781d_read_value(client, W83781D_REG_TEMP2_OVER);
                data->temp_add_hyst[0]                     w83781d_read_value(client, W83781D_REG_TEMP2_HYST);
-               if (data->type != w83783s && data->type != w83697hf) {
+               if (data->type != w83783s) {
                        data->temp_add[1]                             w83781d_read_value(client, W83781D_REG_TEMP3);
                        data->temp_add_over[1] @@ -1428,31 +1363,24 @@ static void w83781d_update_client(struct
                            w83781d_read_value(client, W83781D_REG_TEMP3_HYST);
                }
                i = w83781d_read_value(client, W83781D_REG_VID_FANDIV);
-               if (data->type != w83697hf) {
-                       data->vid = i & 0x0f;
-                       data->vid |-                           (w83781d_read_value(client, W83781D_REG_CHIPID) & 0x01)
-                           << 4;
-               }
+               data->vid = i & 0x0f;
+               data->vid |= (w83781d_read_value(client,
+					W83781D_REG_CHIPID) & 0x01) << 4;
                data->fan_div[0] = (i >> 4) & 0x03;
                data->fan_div[1] = (i >> 6) & 0x03;
-               if (data->type != w83697hf) {
-                       data->fan_div[2] = (w83781d_read_value(client,
+               data->fan_div[2] = (w83781d_read_value(client,
                                               W83781D_REG_PIN) >> 6) & 0x03;
-               }
                if ((data->type != w83781d) && (data->type != as99127f)) {
                        i = w83781d_read_value(client, W83781D_REG_VBAT);
                        data->fan_div[0] |= (i >> 3) & 0x04;
                        data->fan_div[1] |= (i >> 4) & 0x04;
-                       if (data->type != w83697hf)
-                               data->fan_div[2] |= (i >> 5) & 0x04;
+                       data->fan_div[2] |= (i >> 5) & 0x04;
                }
                data->alarms                     w83781d_read_value(client,
                                       W83781D_REG_ALARM1) +
                    (w83781d_read_value(client, W83781D_REG_ALARM2) << 8);
-               if ((data->type = w83782d) || (data->type = w83627hf) ||
-		   (data->type = w83697hf)) {
+               if (data->type = w83782d) {
                        data->alarms |                            w83781d_read_value(client,
                                               W83781D_REG_ALARM3) << 16;
@@ -1697,12 +1625,8 @@ void w83781d_fan_div(struct i2c_client *
 		w83781d_update_client(client);
 		results[0] = DIV_FROM_REG(data->fan_div[0]);
 		results[1] = DIV_FROM_REG(data->fan_div[1]);
-		if (data->type = w83697hf) {
-			*nrels_mag = 2;
-		} else {
-			results[2] = DIV_FROM_REG(data->fan_div[2]);
-			*nrels_mag = 3;
-		}
+		results[2] = DIV_FROM_REG(data->fan_div[2]);
+		*nrels_mag = 3;
 	} else if (operation = SENSORS_PROC_REAL_WRITE) {
 		old = w83781d_read_value(client, W83781D_REG_VID_FANDIV);
 		/* w83781d and as99127f don't have extended divisor bits */
@@ -1710,7 +1634,7 @@ void w83781d_fan_div(struct i2c_client *
 			old3  			    w83781d_read_value(client, W83781D_REG_VBAT);
 		}
-		if (*nrels_mag >= 3 && data->type != w83697hf) {
+		if (*nrels_mag >= 3) {
 			data->fan_div[2]  			    DIV_TO_REG(results[2], data->type);
 			old2 = w83781d_read_value(client, W83781D_REG_PIN);
