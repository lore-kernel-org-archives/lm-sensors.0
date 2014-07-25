From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 25 Jul 2014 14:19:35 +0000
Subject: [lm-sensors] [PATCH] hwmon: (pwm-fan) Make SENSORS_PWM_FAN depend on OF
Message-Id: <1406297975.4906.1.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This driver won't instantiate if OF is not configured, thus add OF dependency.
Also add COMPILE_TEST to increase build testing coverage.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index b93ab97..b9a2764 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1130,7 +1130,7 @@ source drivers/hwmon/pmbus/Kconfig
 
 config SENSORS_PWM_FAN
 	tristate "PWM fan"
-	depends on PWM
+	depends on (PWM && OF) || COMPILE_TEST
 	help
 	  If you say yes here you get support for fans connected to PWM lines.
 	  The driver uses the generic PWM interface, thus it will work on a
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
