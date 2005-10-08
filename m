From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 08 Oct 2005 00:12:20 +0000
Subject: [lm-sensors] [PATCH 10/16] hwmon: Drop useless w83627hf
Message-Id: <20051008001201.33cb9a33.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Drop a useless initialization step in the w83627hf driver. The comment
says that the W83627HF PWM2 can be disabled, but it can't. I suppose
this is a leftover from the w83781d driver (from which the w83627hf
driver is derived), as for example the W83782D had the ability to
disable PWM2.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/hwmon/w83627hf.c |    7 -------
 1 file changed, 7 deletions(-)

--- linux-2.6.14-rc3.orig/drivers/hwmon/w83627hf.c	2005-10-07 20:42:22.000000000 +0200
+++ linux-2.6.14-rc3/drivers/hwmon/w83627hf.c	2005-10-07 21:30:53.000000000 +0200
@@ -201,7 +201,6 @@
 
 #define W83627HF_REG_PWM1 0x5A
 #define W83627HF_REG_PWM2 0x5B
-#define W83627HF_REG_PWMCLK12 0x5C
 
 #define W83627THF_REG_PWM1		0x01	/* 697HF and 637HF too */
 #define W83627THF_REG_PWM2		0x03	/* 697HF and 637HF too */
@@ -1373,12 +1372,6 @@
 			}
 		}
 
-		if (type = w83627hf) {
-			/* enable PWM2 control (can't hurt since PWM reg
-		           should have been reset to 0xff) */
-			w83627hf_write_value(client, W83627HF_REG_PWMCLK12,
-					    0x19);
-		}
 		/* enable comparator mode for temp2 and temp3 so
 	           alarm indication will work correctly */
 		i = w83627hf_read_value(client, W83781D_REG_IRQ);

-- 
Jean Delvare
