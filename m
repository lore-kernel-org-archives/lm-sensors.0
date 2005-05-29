From: grant_lkml@dodo.com.au (Grant Coady)
Date: Sun, 29 May 2005 05:20:33 +0000
Subject: [lm-sensors] RFC PATCH lm_sensors2: w83781d: remove non-i2c
Message-Id: <0cci9197ou579v4v9drecriedotimshe6i@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings,

This patch against today's CVS removes non-i2c w83697hf SuperIO sensor 
chip support from w83781d driver.  Compile tested with 2.4.30-hf2 kernel.

The w83697hf chip is supported by w83627hf driver on 2.4.30-hf2 and 
lm_sensors-2.9.1 compiled as option 1 separate modules.  

---
Still works:
root@sempro:/usr/local/src/cvs/lm_sensors2a# sensors -s
root@sempro:/usr/local/src/cvs/lm_sensors2a# sensors
w83697hf-isa-0290
Adapter: ISA adapter
  VCore:   +1.55 V  (min =  +1.52 V, max =  +1.68 V)
   3.3V:   +3.30 V  (min =  +3.14 V, max =  +3.46 V)
     5V:   +5.11 V  (min =  +4.74 V, max =  +5.24 V)
    12V:  +12.05 V  (min = +11.36 V, max = +12.58 V)
   -12V:  -11.85 V  (min = -12.62 V, max = -11.44 V)
    -5V:   -5.04 V  (min =  -5.26 V, max =  -4.76 V)
   V5SB:   +4.97 V  (min =  +4.76 V, max =  +5.24 V)
  VBatt:   +3.38 V  (min =  +2.90 V, max =  +3.41 V)
CPU Fan:  3154 RPM  (min = 1500 RPM, div = 4)
CaseFan:  1480 RPM  (min = 1196 RPM, div = 8)
Ambient:     +32?C  (high =   +50?C, hyst =   +45?C)   sensor = thermistor
    CPU:   +50.0?C  (high =   +60?C, hyst =   +55?C)   sensor = diode           (beep)
alarms:
beep_enable:
          Sound alarm enabled

root@sempro:/usr/local/src/cvs/lm_sensors2a# sensors -v
sensors version 2.9.2-CVS with libsensors version 2.9.2-CVS
root@sempro:/usr/local/src/cvs/lm_sensors2a# uname -a
Linux sempro 2.4.30-hf2 #3 Fri May 27 14:03:51 EST 2005 i686 unknown unknown GNU/Linux

--Grant.


Signed-off-by: Grant Coady <gcoady@gmail.com>

---
 w83781d.c |   54 ++++++++++++++++--------------------------------------
 1 files changed, 16 insertions(+), 38 deletions(-)

--- lm_sensors2/kernel/chips/w83781d.c	2005-05-16 08:31:03.000000000 +1000
+++ lm_sensors2a/kernel/chips/w83781d.c	2005-05-29 12:31:19.000000000 +1000
@@ -56,7 +56,7 @@ static unsigned int normal_isa[] = { 0x0
 static unsigned int normal_isa_range[] = { SENSORS_ISA_END };
 
 /* Insmod parameters */
-SENSORS_INSMOD_7(w83781d, w83782d, w83783s, w83627hf, as99127f, w83697hf, w83791d);
+SENSORS_INSMOD_6(w83781d, w83782d, w83783s, w83627hf, as99127f, w83791d);
 SENSORS_MODULE_PARM(force_subclients, "List of subclient addresses: " \
                       "{bus, clientaddr, subclientaddr1, subclientaddr2}");
 
@@ -158,8 +158,6 @@ static const u8 regpwm_w83791d[] = { W83
         
 #define W83781D_REG_PWM(type, nr) (((type) = w83791d) ? \
                                          regpwm_w83791d[(nr) - 1] : \
-                                   ((type) = w83697hf) ? \
-                                         (((nr) * 2) - 1) : \
                                          regpwm[(nr) - 1])
 
 #define W83781D_REG_I2C_ADDR 0x48
@@ -887,8 +885,6 @@ static int w83781d_detect(struct i2c_ada
 			kind = w83791d;
 		else if (val1 = 0x31 && !is_isa && address >= 0x28)
 			kind = as99127f;
-		else if (val1 = 0x60 && vendid = winbond && is_isa)
-			kind = w83697hf;
 		else {
 			if (kind = 0)
 				printk
@@ -914,9 +910,6 @@ static int w83781d_detect(struct i2c_ada
 	} else if (kind = as99127f) {
 		type_name = "as99127f";
 		client_name = "AS99127F chip";
-	} else if (kind = w83697hf) {
-		type_name = "w83697hf";
-		client_name = "W83697HF chip";
         } else if (kind = w83791d) {
  		type_name = "w83791d";
  		client_name = "W83791D chip";
@@ -1026,8 +1019,6 @@ static int w83781d_detect(struct i2c_ada
 					   w83781d_dir_table_template :
 					(kind = w83783s) ?
 					   w83783s_dir_table_template :
-					(kind = w83697hf) ?
-					   w83697hf_dir_table_template :
                                         (kind = w83791d ) ?
                                             w83791d_dir_table_template :
                                         (is_isa || kind = w83627hf) ?
@@ -1284,7 +1275,7 @@ static void w83781d_init_client(struct i
 				else
 					data->sens[i - 1] = 2;
 			}
-			if ((type = w83783s || type = w83697hf) && (i = 2))
+			if (type = w83783s && i = 2)
 				break;
 		}
 	}
@@ -1319,7 +1310,7 @@ static void w83781d_init_client(struct i
 
 	if (init && type != as99127f) {
 		w83781d_write_value(client, W83781D_REG_TEMP2_CONFIG, 0x00);
-		if (type != w83783s && type != w83697hf) {
+		if (type != w83783s) {
 			w83781d_write_value(client, W83781D_REG_TEMP3_CONFIG,
 					    0x00);
 		}
@@ -1352,7 +1343,7 @@ static void w83781d_update_client(struct
                pr_debug(KERN_DEBUG "Starting device update\n");
 
                for (i = 0; i <= 9; i++) {
-                       if ((data->type = w83783s || data->type = w83697hf)
+                       if ((data->type = w83783s)
                            && (i = 1))
                                continue;       /* 783S has no in1 */
                        if (data->type = w83791d) {
@@ -1374,7 +1365,7 @@ static void w83781d_update_client(struct
                            w83781d_read_value(client,
                                               W83781D_REG_IN_MAX(i));
                        }
-                       if ((data->type != w83782d) && (data->type != w83697hf)
+                       if ((data->type != w83782d)
                            && (data->type != w83627hf) && (i = 6)
                            && (data->type != w83791d))
                                break;
@@ -1397,7 +1388,6 @@ static void w83781d_update_client(struct
 				             W83781D_REG_PWM(data->type, i));
                                if (((data->type = w83783s)
                                     || (data->type = w83627hf)
-                                    || (data->type = w83697hf)
                                     || ((data->type = w83782d)
                                        && i2c_is_isa_client(client)))
                                    && i = 2)
@@ -1419,7 +1409,7 @@ static void w83781d_update_client(struct
                    w83781d_read_value(client, W83781D_REG_TEMP2_OVER);
                data->temp_add_hyst[0]                     w83781d_read_value(client, W83781D_REG_TEMP2_HYST);
-               if (data->type != w83783s && data->type != w83697hf) {
+               if (data->type != w83783s) {
                        data->temp_add[1]                             w83781d_read_value(client, W83781D_REG_TEMP3);
                        data->temp_add_over[1] @@ -1428,31 +1418,24 @@ static void w83781d_update_client(struct
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
+				       W83781D_REG_CHIPID) & 0x01) << 4;
                data->fan_div[0] = (i >> 4) & 0x03;
                data->fan_div[1] = (i >> 6) & 0x03;
-               if (data->type != w83697hf) {
-                       data->fan_div[2] = (w83781d_read_value(client,
-                                              W83781D_REG_PIN) >> 6) & 0x03;
-               }
+               data->fan_div[2] = (w83781d_read_value(client,
+				       W83781D_REG_PIN) >> 6) & 0x03;
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
+               if ((data->type = w83782d) || (data->type = w83627hf)) {
                        data->alarms |                            w83781d_read_value(client,
                                               W83781D_REG_ALARM3) << 16;
@@ -1684,7 +1667,6 @@ void w83781d_beep(struct i2c_client *cli
 	}
 }
 
-/* w83697hf only has two fans */
 void w83781d_fan_div(struct i2c_client *client, int operation,
 		     int ctl_name, int *nrels_mag, long *results)
 {
@@ -1697,12 +1679,8 @@ void w83781d_fan_div(struct i2c_client *
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
@@ -1710,7 +1688,7 @@ void w83781d_fan_div(struct i2c_client *
 			old3  			    w83781d_read_value(client, W83781D_REG_VBAT);
 		}
-		if (*nrels_mag >= 3 && data->type != w83697hf) {
+		if (*nrels_mag >= 3) {
 			data->fan_div[2]  			    DIV_TO_REG(results[2], data->type);
 			old2 = w83781d_read_value(client, W83781D_REG_PIN);
