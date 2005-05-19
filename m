From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:21 +0000
Subject: [PATCH] i2c driver fixes for 2.6.0-test7
Message-Id: <10658274953710@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <1065827494796@kroah.com>
References: <1065827494796@kroah.com>
In-Reply-To: <1065827494796@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1337.1.2, 2003/10/09 13:35:09-07:00, khali@linux-fr.org

[PATCH] I2C: correct some errors in i2c/chips/Kconfig


 drivers/i2c/chips/Kconfig |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)


diff -Nru a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
--- a/drivers/i2c/chips/Kconfig	Fri Oct 10 16:00:47 2003
+++ b/drivers/i2c/chips/Kconfig	Fri Oct 10 16:00:47 2003
@@ -15,7 +15,7 @@
 	help
 	  If you say yes here you get support for Analog Devices ADM1021 
 	  and ADM1023 sensor chips and clones: Maxim MAX1617 and MAX1617A,
-	  Genesys Logic GL523SM, National Semi LM84, TI THMC10,
+	  Genesys Logic GL523SM, National Semiconductor LM84, TI THMC10,
 	  and the XEON processor built-in sensor.
 
 	  This driver can also be built as a module.  If so, the module
@@ -34,30 +34,30 @@
 	  will be called eeprom.
 
 config SENSORS_IT87
-	tristate "National Semiconductors IT87 and compatibles"
+	tristate "ITE IT87xx and compatibles"
 	depends on I2C && EXPERIMENTAL
 	select I2C_SENSOR
 	help
-	  If you say yes here you get support for National Semiconductor IT87
-	  sensor chips and clones: IT8705F, IT8712F and SiS960.
+	  If you say yes here you get support for ITE IT87xx sensor chips
+	  and clones: SiS960.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called it87.
 
 config SENSORS_LM75
-	tristate "National Semiconductors LM75 and compatibles"
+	tristate "National Semiconductor LM75 and compatibles"
 	depends on I2C && EXPERIMENTAL
 	select I2C_SENSOR
 	help
 	  If you say yes here you get support for National Semiconductor LM75
 	  sensor chips and clones: Dallas Semi DS75 and DS1775, TelCon
-	  TCN75, and National Semi LM77.
+	  TCN75, and National Semiconductor LM77.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called lm75.
 
 config SENSORS_LM78
-	tristate "National Semiconductors LM78 and compatibles"
+	tristate "National Semiconductor LM78 and compatibles"
 	depends on I2C && EXPERIMENTAL
 	select I2C_SENSOR
 	help
@@ -69,7 +69,7 @@
 	  will be called lm78.
 
 config SENSORS_LM85
-	tristate "National Semiconductors LM85 and compatibles"
+	tristate "National Semiconductor LM85 and compatibles"
 	depends on I2C && EXPERIMENTAL
 	select I2C_SENSOR
 	help

