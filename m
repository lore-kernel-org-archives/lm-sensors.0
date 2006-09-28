From: greg@kroah.com (Greg KH)
Date: Thu, 28 Sep 2006 22:48:38 +0000
Subject: [lm-sensors] [PATCH 18/39] hwmon: Make a dozen drivers no more
Message-Id: <11594837971334-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali at linux-fr.org>

hwmon: Make a dozen drivers no more experimental

Remove the EXPERIMENTAL tag from a dozen hardware monitoring drivers.
They are in the tree for quite a long time, so we would know by now if
they were causing trouble.

Also make it clearer that the VT8231 is a VIA chip.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 drivers/hwmon/Kconfig |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index d9f86e9..696543b 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -53,7 +53,7 @@ config SENSORS_ADM1021
 
 config SENSORS_ADM1025
 	tristate "Analog Devices ADM1025 and compatibles"
-	depends on HWMON && I2C && EXPERIMENTAL
+	depends on HWMON && I2C
 	select HWMON_VID
 	help
 	  If you say yes here you get support for Analog Devices ADM1025
@@ -131,7 +131,7 @@ config SENSORS_ATXP1
 
 config SENSORS_DS1621
 	tristate "Dallas Semiconductor DS1621 and DS1625"
-	depends on HWMON && I2C && EXPERIMENTAL
+	depends on HWMON && I2C
 	help
 	  If you say yes here you get support for Dallas Semiconductor
 	  DS1621 and DS1625 sensor chips.
@@ -151,7 +151,7 @@ config SENSORS_F71805F
 
 config SENSORS_FSCHER
 	tristate "FSC Hermes"
-	depends on HWMON && I2C && EXPERIMENTAL
+	depends on HWMON && I2C
 	help
 	  If you say yes here you get support for Fujitsu Siemens
 	  Computers Hermes sensor chips.
@@ -161,7 +161,7 @@ config SENSORS_FSCHER
 
 config SENSORS_FSCPOS
 	tristate "FSC Poseidon"
-	depends on HWMON && I2C && EXPERIMENTAL
+	depends on HWMON && I2C
 	help
 	  If you say yes here you get support for Fujitsu Siemens
 	  Computers Poseidon sensor chips.
@@ -181,7 +181,7 @@ config SENSORS_GL518SM
 
 config SENSORS_GL520SM
 	tristate "Genesys Logic GL520SM"
-	depends on HWMON && I2C && EXPERIMENTAL
+	depends on HWMON && I2C
 	select HWMON_VID
 	help
 	  If you say yes here you get support for Genesys Logic GL520SM
@@ -204,7 +204,7 @@ config SENSORS_IT87
 
 config SENSORS_LM63
 	tristate "National Semiconductor LM63"
-	depends on HWMON && I2C && EXPERIMENTAL
+	depends on HWMON && I2C
 	help
 	  If you say yes here you get support for the National Semiconductor
 	  LM63 remote diode digital temperature sensor with integrated fan
@@ -241,7 +241,7 @@ config SENSORS_LM75
 
 config SENSORS_LM77
 	tristate "National Semiconductor LM77"
-	depends on HWMON && I2C && EXPERIMENTAL
+	depends on HWMON && I2C
 	help
 	  If you say yes here you get support for National Semiconductor LM77
 	  sensor chips.
@@ -251,7 +251,7 @@ config SENSORS_LM77
 
 config SENSORS_LM78
 	tristate "National Semiconductor LM78 and compatibles"
-	depends on HWMON && I2C && EXPERIMENTAL
+	depends on HWMON && I2C
 	select I2C_ISA
 	select HWMON_VID
 	help
@@ -294,7 +294,7 @@ config SENSORS_LM85
 
 config SENSORS_LM87
 	tristate "National Semiconductor LM87"
-	depends on HWMON && I2C && EXPERIMENTAL
+	depends on HWMON && I2C
 	select HWMON_VID
 	help
 	  If you say yes here you get support for National Semiconductor LM87
@@ -319,7 +319,7 @@ config SENSORS_LM90
 
 config SENSORS_LM92
 	tristate "National Semiconductor LM92 and compatibles"
-	depends on HWMON && I2C && EXPERIMENTAL
+	depends on HWMON && I2C
 	help
 	  If you say yes here you get support for National Semiconductor LM92
 	  and Maxim MAX6635 sensor chips.
@@ -329,7 +329,7 @@ config SENSORS_LM92
 
 config SENSORS_MAX1619
 	tristate "Maxim MAX1619 sensor chip"
-	depends on HWMON && I2C && EXPERIMENTAL
+	depends on HWMON && I2C
 	help
 	  If you say yes here you get support for MAX1619 sensor chip.
 
@@ -364,7 +364,7 @@ config SENSORS_SIS5595
 
 config SENSORS_SMSC47M1
 	tristate "SMSC LPC47M10x and compatibles"
-	depends on HWMON && I2C && EXPERIMENTAL
+	depends on HWMON && I2C
 	select I2C_ISA
 	help
 	  If you say yes here you get support for the integrated fan
@@ -418,7 +418,7 @@ config SENSORS_VIA686A
 	  will be called via686a.
 
 config SENSORS_VT8231
-	tristate "VT8231"
+	tristate "VIA VT8231"
 	depends on HWMON && I2C && PCI && EXPERIMENTAL
 	select HWMON_VID
 	select I2C_ISA
-- 
1.4.2.1


