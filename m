From: Fabio Porcedda <fabio.porcedda@gmail.com>
Date: Thu, 14 Mar 2013 13:11:31 +0000
Subject: [lm-sensors] [PATCH 10/10] drivers: misc: use module_platform_driver_probe()
Message-Id: <1363266691-15757-12-git-send-email-fabio.porcedda@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1363266691-15757-1-git-send-email-fabio.porcedda@gmail.com>
In-Reply-To: <1363266691-15757-1-git-send-email-fabio.porcedda@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, linux-ide@vger.kernel.org, lm-sensors@lm-sensors.org, linux-input@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>

This patch converts the drivers to use the
module_platform_driver_probe() macro which makes the code smaller and
a bit simpler.

Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 drivers/misc/atmel_pwm.c  | 12 +-----------
 drivers/misc/ep93xx_pwm.c | 13 +------------
 2 files changed, 2 insertions(+), 23 deletions(-)

diff --git a/drivers/misc/atmel_pwm.c b/drivers/misc/atmel_pwm.c
index 28f5aaa..494d050 100644
--- a/drivers/misc/atmel_pwm.c
+++ b/drivers/misc/atmel_pwm.c
@@ -393,17 +393,7 @@ static struct platform_driver atmel_pwm_driver = {
 	 */
 };
 
-static int __init pwm_init(void)
-{
-	return platform_driver_probe(&atmel_pwm_driver, pwm_probe);
-}
-module_init(pwm_init);
-
-static void __exit pwm_exit(void)
-{
-	platform_driver_unregister(&atmel_pwm_driver);
-}
-module_exit(pwm_exit);
+module_platform_driver_probe(atmel_pwm_driver, pwm_probe);
 
 MODULE_DESCRIPTION("Driver for AT32/AT91 PWM module");
 MODULE_LICENSE("GPL");
diff --git a/drivers/misc/ep93xx_pwm.c b/drivers/misc/ep93xx_pwm.c
index 16d7179..96787ec 100644
--- a/drivers/misc/ep93xx_pwm.c
+++ b/drivers/misc/ep93xx_pwm.c
@@ -365,18 +365,7 @@ static struct platform_driver ep93xx_pwm_driver = {
 	.remove		= __exit_p(ep93xx_pwm_remove),
 };
 
-static int __init ep93xx_pwm_init(void)
-{
-	return platform_driver_probe(&ep93xx_pwm_driver, ep93xx_pwm_probe);
-}
-
-static void __exit ep93xx_pwm_exit(void)
-{
-	platform_driver_unregister(&ep93xx_pwm_driver);
-}
-
-module_init(ep93xx_pwm_init);
-module_exit(ep93xx_pwm_exit);
+module_platform_driver_probe(ep93xx_pwm_driver, ep93xx_pwm_probe);
 
 MODULE_AUTHOR("Matthieu Crapet <mcrapet@gmail.com>, "
 	      "H Hartley Sweeten <hsweeten@visionengravers.com>");
-- 
1.8.1.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
