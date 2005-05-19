From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:42 +0000
Subject: [PATCH 2.6] Kill unused struct members in w83627hf driver
Message-Id: <20050308203358.31e2aa92.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

I just noticed that the pwmenable struct members in the w83627hf driver
are not used anywhere (and quite rightly so, as PWM cannot be disabled
in these chips as far as I know). Let's just get rid of them and save
some bytes of memory.

Please apply,
thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.6.11-bk2/drivers/i2c/chips/w83627hf.c.orig	Mon Mar  7 10:56:02 2005
+++ linux-2.6.11-bk2/drivers/i2c/chips/w83627hf.c	Mon Mar  7 10:56:22 2005
@@ -304,7 +304,6 @@
 	u32 beep_mask;		/* Register encoding, combined */
 	u8 beep_enable;		/* Boolean */
 	u8 pwm[3];		/* Register value */
-	u8 pwmenable[3];	/* bool */
 	u16 sens[3];		/* 782D/783S only.
 				   1 = pentium diode; 2 = 3904 diode;
 				   3000-5000 = thermistor beta.
@@ -1316,10 +1315,6 @@
 		if ((type = w83697hf) && (i = 2))
 			break;
 	}
-
-	data->pwmenable[0] = 1;
-	data->pwmenable[1] = 1;
-	data->pwmenable[2] = 1;
 
 	if(init) {
 		/* Enable temp2 */


-- 
Jean Delvare
