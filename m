From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 11 Feb 2014 12:46:12 +0000
Subject: [lm-sensors] [PATCH] hwmon: Fix trivial typo for LTC4260
Message-Id: <1392122772.1351.1.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 5bbc55b..7ed3aa6 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -839,7 +839,7 @@ config SENSORS_LTC4260
 	select REGMAP_I2C
 	default n
 	help
-	  If you say yes here you get support for Linear Technology LTC4261
+	  If you say yes here you get support for Linear Technology LTC4260
 	  Positive Voltage Hot Swap Controller I2C interface.
 
 	  This driver can also be built as a module. If so, the module will
-- 
1.8.1.2




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
