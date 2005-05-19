From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:46 +0000
Subject: non-sensors i2c chip drivers
Message-Id: <20040308191152.0f6ae915.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040306231034.469fef54.khali@linux-fr.org>
In-Reply-To: <20040306231034.469fef54.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting myself:

> I think that it would make sense to have a specific menu entry for
> these, separate from the sensors stuff. Looks like an easy thing to
> do.

Here is a proposed patch that does this. Comments welcome.

Thanks.

--- linux-2.6.4-rc1/drivers/i2c/chips.orig/Kconfig	2004-03-08 14:28:53.000000000 +0100
+++ linux-2.6.4-rc1/drivers/i2c/chips/Kconfig	2004-03-08 16:55:22.000000000 +0100
@@ -2,7 +2,7 @@
 # I2C Sensor device configuration
 #
 
-menu "I2C Hardware Sensors Chip support"
+menu "Hardware Sensors Chip support"
 	depends on I2C
 
 config I2C_SENSOR
@@ -33,18 +33,6 @@
 	  This driver can also be built as a module.  If so, the module
 	  will be called asb100.
 
-config SENSORS_EEPROM
-	tristate "EEPROM (DIMM) reader"
-	depends on I2C && EXPERIMENTAL
-	select I2C_SENSOR
-	help
-	  If you say yes here you get read-only access to the EEPROM data
-	  available on modern memory DIMMs, and which could theoretically
-	  also be available on other devices.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called eeprom.
-
 config SENSORS_FSCHER
 	tristate "FSC Hermes"
 	depends on I2C && EXPERIMENTAL
@@ -194,3 +182,20 @@
 	  will be called w83627hf.
 
 endmenu
+
+menu "Other I2C Chip support"
+	depends on I2C
+
+config SENSORS_EEPROM
+	tristate "EEPROM reader"
+	depends on I2C && EXPERIMENTAL
+	select I2C_SENSOR
+	help
+	  If you say yes here you get read-only access to the EEPROM data
+	  available on modern memory DIMMs and Sony Vaio laptops.  Such
+	  EEPROMs could theoretically be available on other devices as well.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called eeprom.
+
+endmenu


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
