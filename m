From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:48 +0000
Subject: [PATCH] i2c driver fixes for 2.6.4
Message-Id: <10793913943831@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <1079391393684@kroah.com>
References: <10793913903814@kroah.com>
In-Reply-To: <10793913903814@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1608.74.7, 2004/03/09 15:29:46-08:00, khali@linux-fr.org

[PATCH] I2c: Kconfig for non-sensors i2c chip drivers

Quoting myself:

> I think that it would make sense to have a specific menu entry for
> these, separate from the sensors stuff. Looks like an easy thing to
> do.

Here is a proposed patch that does this. Comments welcome.


 drivers/i2c/chips/Kconfig |   31 ++++++++++++++++++-------------
 1 files changed, 18 insertions(+), 13 deletions(-)


diff -Nru a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
--- a/drivers/i2c/chips/Kconfig	Mon Mar 15 14:34:43 2004
+++ b/drivers/i2c/chips/Kconfig	Mon Mar 15 14:34:43 2004
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
@@ -192,5 +180,22 @@
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called w83627hf.
+
+endmenu
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
 
 endmenu

