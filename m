From: gregkh@suse.de (Greg KH)
Date: Thu, 19 May 2005 06:25:47 +0000
Subject: [PATCH] I2C: Kill unused struct members in w83627hf driver
Message-Id: <1112311390987@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <1112311390426@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Cc: khali@linux-fr.org

ChangeSet 1.2327, 2005/03/31 14:06:47-08:00, khali@linux-fr.org

[PATCH] I2C: Kill unused struct members in w83627hf driver

I just noticed that the pwmenable struct members in the w83627hf driver
are not used anywhere (and quite rightly so, as PWM cannot be disabled
in these chips as far as I know). Let's just get rid of them and save
some bytes of memory.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/i2c/chips/w83627hf.c |    5 -----
 1 files changed, 5 deletions(-)


diff -Nru a/drivers/i2c/chips/w83627hf.c b/drivers/i2c/chips/w83627hf.c
--- a/drivers/i2c/chips/w83627hf.c	2005-03-31 15:18:44 -08:00
+++ b/drivers/i2c/chips/w83627hf.c	2005-03-31 15:18:44 -08:00
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

