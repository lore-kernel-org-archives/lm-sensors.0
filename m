From: gregkh@suse.de (Greg KH)
Date: Sat, 29 Oct 2005 00:16:58 +0000
Subject: [lm-sensors] [PATCH] hwmon: Drop useless w83627hf initialization
Message-Id: <1130533661554@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] hwmon: Drop useless w83627hf initialization step

Drop a useless initialization step in the w83627hf driver. The comment
says that the W83627HF PWM2 can be disabled, but it can't. I suppose
this is a leftover from the w83781d driver (from which the w83627hf
driver is derived), as for example the W83782D had the ability to
disable PWM2.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 862bc36f682b25dd97833f702b4f8c97661b8811
tree bdafe5326e72ec7cc9a677746ca7332ae73e7bd3
parent 91749996287c230671788014f422f72e594e7b86
author Jean Delvare <khali@linux-fr.org> Sat, 08 Oct 2005 00:12:01 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 28 Oct 2005 14:02:10 -0700

 drivers/hwmon/w83627hf.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/w83627hf.c b/drivers/hwmon/w83627hf.c
index 494274d..4827081 100644
--- a/drivers/hwmon/w83627hf.c
+++ b/drivers/hwmon/w83627hf.c
@@ -201,7 +201,6 @@ superio_exit(void)
 
 #define W83627HF_REG_PWM1 0x5A
 #define W83627HF_REG_PWM2 0x5B
-#define W83627HF_REG_PWMCLK12 0x5C
 
 #define W83627THF_REG_PWM1		0x01	/* 697HF and 637HF too */
 #define W83627THF_REG_PWM2		0x03	/* 697HF and 637HF too */
@@ -1373,12 +1372,6 @@ static void w83627hf_init_client(struct 
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

