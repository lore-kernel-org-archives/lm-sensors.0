From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 09 Jan 2013 16:59:08 +0000
Subject: [lm-sensors] [PATCH 2/3] platform/x86: (eeepc-laptop) Replace SENSORS_LIMIT with clamp_val
Message-Id: <1357750750-30512-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1357750750-30512-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1357750750-30512-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@lm-sensors.org
Cc: Jean Delvare <khali@linux-fr.org>, "Mark M. Hoffman" <mhoffman@lightlink.com>, George Joseph <george.joseph@fairview5.com>, Juerg Haefliger <juergh@gmail.com>, Steve Glendinning <steve.glendinning@shawell.net>, Riku Voipio <riku.voipio@iki.fi>, Guillaume Ligneul <guillaume.ligneul@gmail.com>, "Hans J. Koch" <hjk@hansjkoch.de>, Roger Lucas <vt8231@hiddenengine.co.uk>, Marc Hulsman <m.hulsman@tudelft.nl>, Rudolf Marek <r.marek@assembler.cz>, Corentin Chary <corentin.chary@gmail.com>, Matthew Garrett <mjg@redhat.com>, platform-driver-x86@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>

SENSORS_LIMIT and clamp_val have the same functionality, so retire SENSORS_LIMIT
as it is no longer needed.

The change reduces text size by 26 bytes and bss size by 16 bytes on x86_86
builds.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/platform/x86/eeepc-laptop.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 528e949..a5da0b5 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -1007,7 +1007,7 @@ static int eeepc_get_fan_pwm(void)
 
 static void eeepc_set_fan_pwm(int value)
 {
-	value = SENSORS_LIMIT(value, 0, 255);
+	value = clamp_val(value, 0, 255);
 	value = value * 100 / 255;
 	ec_write(EEEPC_EC_FAN_PWM, value);
 }
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
