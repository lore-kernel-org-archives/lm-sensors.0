From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 12 Jun 2006 19:55:28 +0000
Subject: [lm-sensors] [PATCH 12/14] hwmon: Fix the Kconfig header
Message-Id: <20060612215528.e72133d5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=hwmon-kconfig-header-fix.patch

Hardware monitoring chips don't have to be on the I2C bus.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/hwmon/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.17-rc6.orig/drivers/hwmon/Kconfig	2006-06-12 18:41:00.000000000 +0200
+++ linux-2.6.17-rc6/drivers/hwmon/Kconfig	2006-06-12 19:16:40.000000000 +0200
@@ -1,5 +1,5 @@
 #
-# I2C Sensor chip drivers configuration
+# Hardware monitoring chip drivers configuration
 #
 
 menu "Hardware Monitoring support"

-- 
Jean Delvare

