From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 24 Apr 2011 07:19:37 +0000
Subject: [lm-sensors] [PATCH] hwmon: (asc7621) Drop duplicate dependency
Message-Id: <20110424091937.02f4943e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The config SENSORS_ASC7621 entry is inside an if HWMON / endif block,
so it already depends on HWMON.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.39-rc4.orig/drivers/hwmon/Kconfig	2011-04-24 08:57:23.000000000 +0200
+++ linux-2.6.39-rc4/drivers/hwmon/Kconfig	2011-04-24 09:10:42.000000000 +0200
@@ -213,7 +213,7 @@ config SENSORS_ADT7475
 
 config SENSORS_ASC7621
 	tristate "Andigilog aSC7621"
-	depends on HWMON && I2C
+	depends on I2C
 	help
 	  If you say yes here you get support for the aSC7621
 	  family of SMBus sensors chip found on most Intel X38, X48, X58,


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
