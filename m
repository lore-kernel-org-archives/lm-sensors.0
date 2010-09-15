From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 15 Sep 2010 14:02:04 +0000
Subject: [lm-sensors] [patch 30/36] hwmon: (w83795) Make W83795_REG_PWM more
Message-Id: <20100915160204.1dd4c562@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Cascaded conditionals are inefficient. Reorder the fields so that
PWM register addresses can be computed more efficiently.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83795.c |   18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

--- linux-2.6.36-rc4.orig/drivers/hwmon/w83795.c	2010-09-15 15:14:13.000000000 +0200
+++ linux-2.6.36-rc4/drivers/hwmon/w83795.c	2010-09-15 15:15:24.000000000 +0200
@@ -178,15 +178,11 @@ static const u8 IN_LSB_SHIFT_IDX[][2]  #define W83795_REG_TSS(index)		(0x209 + (index))
 
 #define PWM_OUTPUT			0
-#define PWM_START			1
-#define PWM_NONSTOP			2
-#define PWM_STOP_TIME			3
-#define PWM_FREQ			4
-#define W83795_REG_PWM(index, nr) \
-	(((nr) = 0 ? 0x210 : \
-	  (nr) = 1 ? 0x220 : \
-	  (nr) = 2 ? 0x228 : \
-	  (nr) = 3 ? 0x230 : 0x218) + (index))
+#define PWM_FREQ			1
+#define PWM_START			2
+#define PWM_NONSTOP			3
+#define PWM_STOP_TIME			4
+#define W83795_REG_PWM(index, nr)	(0x210 + (nr) * 8 + (index))
 
 #define W83795_REG_FTSH(index)		(0x240 + (index) * 2)
 #define W83795_REG_FTSL(index)		(0x241 + (index) * 2)
@@ -356,8 +352,8 @@ struct w83795_data {
 	u8 has_pwm;		/* 795g supports 8 pwm, 795adg only supports 2,
 				 * no config register, only affected by chip
 				 * type */
-	u8 pwm[8][5];		/* Register value, output, start, non stop, stop
-				 * time, freq */
+	u8 pwm[8][5];		/* Register value, output, freq, start,
+				 *  non stop, stop time */
 	u16 clkin;		/* CLKIN frequency in kHz */
 	u8 pwm_fcms[2];		/* Register value */
 	u8 pwm_tfmr[6];		/* Register value */


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
