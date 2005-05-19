From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:24 +0000
Subject: ASB100 PWM
Message-Id: <20031111062929.GA30118@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

vitalyb wrote in ticket #1437:

> asb100??s chip address: 0x2d
> pwm data address: 0x59
> default value: 0x8f
> 
> lower nybble (with a mask 0x0f) regulates Power and Chassis Fans, but not a CPU
> fan
> 
> it looks like if higher (7) bit is set, manual control is enabled, ie if
> register contains 0x85 fan??s speed will be around 5/16
> 
> but if bits 5 and/or 6 are set and bit 7 is not, fan speed is constantly
> lowering (approx. every 4 sec.)

So, I tried the attached patch (vs. current CVS) with no result here:
modifying the pwm did not change any fan speeds at all.  But maybe
there are different ASB100 revs?  Who knows?  The patch didn't
seem to hurt anything, so if it works for you I'll commit it.

BTW: thanks for the info... anything else you can find out about
that chip, please email (sensors@stimpy.netroedge.com) us.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

-------------- next part --------------
Index: kernel/chips/asb100.c
=================================RCS file: /home/cvs/lm_sensors2/kernel/chips/asb100.c,v
retrieving revision 1.1
diff -u -r1.1 asb100.c
--- kernel/chips/asb100.c	29 Oct 2003 05:37:52 -0000	1.1
+++ kernel/chips/asb100.c	11 Nov 2003 06:47:24 -0000
@@ -29,7 +29,7 @@
     This driver supports the hardware sensor chip: Asus ASB100(A) BACH
 
     Chip	#vin	#fanin	#pwm	#temp	wchipid	vendid	i2c	ISA
-    asb100	7	3	0	4	0x31	0x0694	yes	no
+    asb100	7	3	1	4	0x31	0x0694	yes	no
 */
 
 //#define DEBUG 1
@@ -102,7 +102,9 @@
 #define ASB100_REG_BEEP_INTS1	0x56
 #define ASB100_REG_BEEP_INTS2	0x57
 #define ASB100_REG_WCHIPID	0x58
-#define ASB100_REG_DIODE	0x59
+
+/* bit 7 -> enable, bits 0-3 -> duty cycle */
+#define ASB100_REG_PWM1		0x59
 
 /* <TODO> Does this exist on ASB100? */
 /* The following are undocumented in the data sheets however we
@@ -186,6 +188,19 @@
 	return ((s16)reg / 128) * 5;
 }
 
+/* PWM: 0 - 255 per sensors documentation
+   REG: (6.25% duty cycle per bit) */
+static u8 ASB100_PWM_TO_REG(int pwm)
+{
+	pwm = SENSORS_LIMIT(pwm, 0, 255);
+	return (u8)(pwm / 16);
+}
+
+static int ASB100_PWM_FROM_REG(u8 reg)
+{
+	return reg * 16;
+}
+
 #define ALARMS_FROM_REG(val) (val)
 #define BEEPS_FROM_REG(val) (val)
 #define BEEPS_TO_REG(val) ((val) & 0xffffff)
@@ -228,6 +243,7 @@
 	u16 temp_over[4];	/* Register value (0 and 3 are u8 only) */
 	u16 temp_hyst[4];	/* Register value (0 and 3 are u8 only) */
 	u8 fan_div[3];		/* Register encoding, right justified */
+	u8 pwm;			/* Register encoding */
 	u8 vid;			/* Register encoding, combined */
 	u32 alarms;		/* Register encoding, combined */
 	u32 beeps;		/* Register encoding, combined */
@@ -263,6 +279,8 @@
 		int ctl_name, int *nrels_mag, long *results);
 static void asb100_fan_div(struct i2c_client *client, int operation,
 		int ctl_name, int *nrels_mag, long *results);
+static void asb100_pwm(struct i2c_client *client, int operation,
+		int ctl_name, int *nrels_mag, long *results);
 
 static struct i2c_driver asb100_driver = {
 	.owner		= THIS_MODULE,
@@ -296,6 +314,8 @@
 #define ASB100_SYSCTL_VID	1300	/* Volts * 1000 */
 #define ASB100_SYSCTL_VRM	1301
 
+#define ASB100_SYSCTL_PWM1	1401	/* 0-255 => 0-100% duty cycle */
+
 #define ASB100_SYSCTL_FAN_DIV	2000	/* 1, 2, 4 or 8 */
 #define ASB100_SYSCTL_ALARMS	2001	/* bitvector */
 #define ASB100_SYSCTL_BEEP	2002	/* bitvector */
@@ -362,7 +382,8 @@
 	 &i2c_sysctl_real, NULL, &asb100_alarms},
 	{ASB100_SYSCTL_BEEP, "beep", NULL, 0, 0644, NULL, &i2c_proc_real,
 	 &i2c_sysctl_real, NULL, &asb100_beep},
-
+	{ASB100_SYSCTL_PWM1, "pwm1", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &asb100_pwm},
 	{0}
 };
 
@@ -784,6 +805,9 @@
 		data->fan_div[2] = (asb100_read_value(client,
 				ASB100_REG_PIN) >> 6) & 0x03;
 
+		/* PWM */
+		data->pwm = asb100_read_value(client, ASB100_REG_PWM1);
+
 		/* alarms */
 		data->alarms = asb100_read_value(client, ASB100_REG_ALARM1) +
 			(asb100_read_value(client, ASB100_REG_ALARM2) << 8);
@@ -1040,6 +1064,33 @@
 			data->fan_div[0] = DIV_TO_REG(results[0]);
 			old = (old & 0xcf) | ((data->fan_div[0] & 0x03) << 4);
 			asb100_write_value(client, ASB100_REG_VID_FANDIV, old);
+		}
+	}
+}
+
+void asb100_pwm(struct i2c_client *client, int operation, int ctl_name,
+		int *nrels_mag, long *results)
+{
+	struct asb100_data *data = client->data;
+
+	if (operation = SENSORS_PROC_REAL_INFO)
+		*nrels_mag = 0;
+	else if (operation = SENSORS_PROC_REAL_READ) {
+		asb100_update_client(client);
+		results[0] = ASB100_PWM_FROM_REG(data->pwm & 0x0f);
+		results[1] = (data->pwm & 0x80) ? 1 : 0;
+		*nrels_mag = 2;
+	} else if (operation = SENSORS_PROC_REAL_WRITE) {
+		u8 val = data->pwm;
+		if (*nrels_mag >= 1) {
+			val = 0x0f & ASB100_PWM_TO_REG(results[0]);
+			if (*nrels_mag >= 2) {
+				if (results[1])
+					val |= 0x80;
+				else
+					val &= ~0x80;
+			}
+			asb100_write_value(client, ASB100_REG_PWM1, val);
 		}
 	}
 }
