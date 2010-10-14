From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 14 Oct 2010 08:32:39 +0000
Subject: [lm-sensors] [PATCH] hwmon: Remove many EXPERIMENTAL flags
Message-Id: <20101014103239.1096f962@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Remove the dependency on EXPERIMENTAL for all drivers which are in
the kernel tree for a long time, are known to work properly and for
which we have documentation.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Corentin Labbe <corentin.labbe@geomatys.fr>
Cc: Riku Voipio <riku.voipio@iki.fi>
Cc: Juerg Haefliger <juergh@gmail.com>
---
 drivers/hwmon/Kconfig |   29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

--- linux-2.6.36-rc7.orig/drivers/hwmon/Kconfig	2010-10-14 10:02:46.000000000 +0200
+++ linux-2.6.36-rc7/drivers/hwmon/Kconfig	2010-10-14 10:05:58.000000000 +0200
@@ -129,7 +129,7 @@ config SENSORS_ADM1025
 
 config SENSORS_ADM1026
 	tristate "Analog Devices ADM1026 and compatibles"
-	depends on I2C && EXPERIMENTAL
+	depends on I2C
 	select HWMON_VID
 	help
 	  If you say yes here you get support for Analog Devices ADM1026
@@ -140,7 +140,7 @@ config SENSORS_ADM1026
 
 config SENSORS_ADM1029
 	tristate "Analog Devices ADM1029"
-	depends on I2C && EXPERIMENTAL
+	depends on I2C
 	help
 	  If you say yes here you get support for Analog Devices ADM1029
 	  sensor chip.
@@ -151,7 +151,7 @@ config SENSORS_ADM1029
 
 config SENSORS_ADM1031
 	tristate "Analog Devices ADM1031 and compatibles"
-	depends on I2C && EXPERIMENTAL
+	depends on I2C
 	help
 	  If you say yes here you get support for Analog Devices ADM1031
 	  and ADM1030 sensor chips.
@@ -202,7 +202,7 @@ config SENSORS_ADT7470
 
 config SENSORS_ADT7475
 	tristate "Analog Devices ADT7473, ADT7475, ADT7476 and ADT7490"
-	depends on I2C && EXPERIMENTAL
+	depends on I2C
 	select HWMON_VID
 	help
 	  If you say yes here you get support for the Analog Devices
@@ -296,7 +296,6 @@ config SENSORS_I5K_AMB
 
 config SENSORS_F71805F
 	tristate "Fintek F71805F/FG, F71806F/FG and F71872F/FG"
-	depends on EXPERIMENTAL
 	help
 	  If you say yes here you get support for hardware monitoring
 	  features of the Fintek F71805F/FG, F71806F/FG and F71872F/FG
@@ -307,7 +306,7 @@ config SENSORS_F71805F
 
 config SENSORS_F71882FG
 	tristate "Fintek F71858FG, F71862FG, F71882FG, F71889FG and F8000"
-	depends on EXPERIMENTAL
+	depends
 	help
 	  If you say yes here you get support for hardware monitoring
 	  features of the Fintek F71858FG, F71862FG/71863FG, F71882FG/F71883FG,
@@ -317,8 +316,8 @@ config SENSORS_F71882FG
 	  will be called f71882fg.
 
 config SENSORS_F75375S
-	tristate "Fintek F75375S/SP and F75373";
-	depends on I2C && EXPERIMENTAL
+	tristate "Fintek F75375S/SP and F75373"
+	depends on I2C
 	help
 	  If you say yes here you get support for hardware monitoring
 	  features of the Fintek F75375S/SP and F75373
@@ -464,7 +463,7 @@ config SENSORS_LM63
 
 config SENSORS_LM70
 	tristate "National Semiconductor LM70 / Texas Instruments TMP121"
-	depends on SPI_MASTER && EXPERIMENTAL
+	depends on SPI_MASTER
 	help
 	  If you say yes here you get support for the National Semiconductor
 	  LM70 and Texas Instruments TMP121/TMP123 digital temperature
@@ -532,7 +531,7 @@ config SENSORS_LM78
 
 config SENSORS_LM80
 	tristate "National Semiconductor LM80"
-	depends on I2C && EXPERIMENTAL
+	depends on I2C
 	help
 	  If you say yes here you get support for National Semiconductor
 	  LM80 sensor chips.
@@ -552,7 +551,7 @@ config SENSORS_LM83
 
 config SENSORS_LM85
 	tristate "National Semiconductor LM85 and compatibles"
-	depends on I2C && EXPERIMENTAL
+	depends on I2C
 	select HWMON_VID
 	help
 	  If you say yes here you get support for National Semiconductor LM85
@@ -681,7 +680,6 @@ config SENSORS_PC87360
 
 config SENSORS_PC87427
 	tristate "National Semiconductor PC87427"
-	depends on EXPERIMENTAL
 	help
 	  If you say yes here you get access to the hardware monitoring
 	  functions of the National Semiconductor PC87427 Super-I/O chip.
@@ -809,7 +807,7 @@ config SENSORS_SMSC47M1
 
 config SENSORS_SMSC47M192
 	tristate "SMSC LPC47M192 and compatibles"
-	depends on I2C && EXPERIMENTAL
+	depends on I2C
 	select HWMON_VID
 	help
 	  If you say yes here you get support for the temperature and
@@ -865,7 +863,7 @@ config SENSORS_AMC6821
 
 config SENSORS_THMC50
 	tristate "Texas Instruments THMC50 / Analog Devices ADM1022"
-	depends on I2C && EXPERIMENTAL
+	depends on I2C
 	help
 	  If you say yes here you get support for Texas Instruments THMC50
 	  sensor chips and clones: the Analog Devices ADM1022.
@@ -923,7 +921,6 @@ config SENSORS_VIA686A
 
 config SENSORS_VT1211
 	tristate "VIA VT1211"
-	depends on EXPERIMENTAL
 	select HWMON_VID
 	help
 	  If you say yes here then you get support for hardware monitoring
@@ -967,7 +964,7 @@ config SENSORS_W83791D
 
 config SENSORS_W83792D
 	tristate "Winbond W83792D"
-	depends on I2C && EXPERIMENTAL
+	depends on I2C
 	help
 	  If you say yes here you get support for the Winbond W83792D chip.
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
