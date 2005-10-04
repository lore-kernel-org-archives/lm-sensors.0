From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 04 Oct 2005 20:09:19 +0000
Subject: [lm-sensors] [PATCH] hwmon: Cleanup w83627hf initialization
Message-Id: <20051004200848.5f4f0182.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I am enqueuing the following patch. I would appreciate if owners of a
W83627HF chip could give it a try and confirm that PWM2 still works OK.
Also, if someone can tell why the code I plan to remove was there in
the first place, while the W83627HF datasheet suggest it's neither
needed nor correct, please speak up. Thanks.

Drop a useless initialization step in the w83627hf driver. The comment
says that the W83627HF PWM2 can be disabled, but it can't. I suppose
this is a leftover from the w83781d driver (from which the w83627hf
driver is derived), as for example the W83782D had the ability to
disable PWM2.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/hwmon/w83627hf.c |    7 -------
 1 files changed, 7 deletions(-)

--- linux-2.6.14-rc3.orig/drivers/hwmon/w83627hf.c	2005-10-04 14:56:33.000000000 +0200
+++ linux-2.6.14-rc3/drivers/hwmon/w83627hf.c	2005-10-04 15:04:02.000000000 +0200
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
