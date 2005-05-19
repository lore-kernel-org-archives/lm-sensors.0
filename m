From: com.ee@estudiants.urv.es (Carlos Olalla Martinez)
Date: Thu, 19 May 2005 06:23:55 +0000
Subject: w83781d.c from com.ee (ticket 1207) Patch
Message-Id: <0HDX00E8S1YGE9@estudiants.urv.es>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi sensorial staff :)

I posted ticket no.1207 referring to some mistakes about w83697hf datasheet.
Im sorry to tell you that the patch had some mistakes too, I have been looking into it, 
and finally I found the 'final' solution:
The registers described from section 9.7.50 (FAN1 pre-scale) to section 9.7.65 (Fan Step
Up time)
are wrong: winbond datasheet claims those registers are in range [0x00 - 0x0F], but in
fact they are in range [0x80 - 0x8F]. I have tought it would be good to know what winbond
says about that, but I don't know if they are very receptive...

Well, this is the patch for w83781d.c ; please note that the code from w83627hf.c is wrong
too, so it should be changed before the next lm_sensors release.

Im working in an aplication that uses lm_sensors, let me know if I can help you in any
way, and please, forgive me for my not-very-good english.
Carlos
--- w83781d.c	Sun Sep 22 00:11:56 2002
+++ w83781d_2.c	Thu Apr 24 11:47:31 2003
@@ -141,6 +141,14 @@
 #define W83781D_REG_PWM4 0x5F
 #define W83781D_REG_PWMCLK12 0x5C
 #define W83781D_REG_PWMCLK34 0x45C
+
+//w83697hf FAN SPEED CONTROL FUNCTIONALITY
+#define W83697hf_REG_PWM1 0x81
+#define W83697hf_REG_PWM2 0x83
+#define W83697hf_REG_PWMCLK1 0x80
+#define W83697hf_REG_PWMCLK2 0x82
+#define W83697hf_REG_FANCONF 0x84
+
 static const u8 regpwm[] = { W83781D_REG_PWM1, W83781D_REG_PWM2,
 	W83781D_REG_PWM3, W83781D_REG_PWM4
 };
@@ -1458,7 +1466,7 @@
 			w83781d_write_value(client, W83781D_REG_TEMP3_CONFIG,
 					    0x00);
 		}
-		if (type != w83781d) {
+		if ((type != w83781d)&&(type != w83697hf)) {
 			/* enable PWM2 control (can't hurt since PWM reg
 		           should have been reset to 0xff) */
 			w83781d_write_value(client, W83781D_REG_PWMCLK12, 0x19);
@@ -1466,6 +1474,12 @@
 		           alarm indication will work correctly */
 			w83781d_write_value(client, W83781D_REG_IRQ, 0x41);
 		}
+		if (type = w83697hf) {
+			/* enable PWM Manual Control (Again... cant hurt
+								since PWM reg should be 0xFF) */
+			w83781d_write_value(client, W83697hf_REG_FANCONF, 0x00);
+			w83781d_write_value(client, W83781D_REG_IRQ, 0x41);
+		}
 	}
 
 	/* Start monitoring */
@@ -1511,7 +1525,7 @@
 			    w83781d_read_value(client,
 					       W83781D_REG_FAN_MIN(i));
 		}
-		if (data->type != w83781d) {
+		if ((data->type != w83781d)&&(data->type != w83697hf)) {
 			for (i = 1; i <= 4; i++) {
 				data->pwm[i - 1]  				    w83781d_read_value(client,
@@ -1519,14 +1533,16 @@
 				if (((data->type = w83783s)
 				     || (data->type = w83627hf)
 				     || (data->type = as99127f)
-				     || (data->type = w83697hf)
 				     || ((data->type = w83782d)
 				        && i2c_is_isa_client(client)))
 				    && i = 2)
 					break;
 			}
 		}
-
+		if (data->type = w83697hf) {
+			data->pwm[0] = w83781d_read_value(client, W83697hf_REG_PWM1);
+			data->pwm[1] = w83781d_read_value(client, W83697hf_REG_PWM2);
+		}
 		data->temp = w83781d_read_value(client, W83781D_REG_TEMP);
 		data->temp_over  		    w83781d_read_value(client, W83781D_REG_TEMP_OVER);
@@ -1909,8 +1925,15 @@
 	} else if (operation = SENSORS_PROC_REAL_WRITE) {
 		if (*nrels_mag >= 1) {
 			data->pwm[nr - 1] = PWM_TO_REG(results[0]);
-			w83781d_write_value(client, W83781D_REG_PWM(nr),
+			if (data->type != w83697hf) {
+				w83781d_write_value(client, W83781D_REG_PWM(nr),
 					    data->pwm[nr - 1]);
+			}
+			//write to the apropiate PWM1 = 0x01, PWM2 = 0x03 registers
+			else {
+				if (nr = 1) w83781d_write_value(client, W83697hf_REG_PWM1, data->pwm[0]);
+				if (nr = 2) w83781d_write_value(client, W83697hf_REG_PWM2, data->pwm[1]);
+			}
 		}
 	}
 }






 

