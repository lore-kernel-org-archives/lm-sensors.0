From: gregkh@suse.de (gregkh at suse.de)
Date: Thu, 28 Sep 2006 06:59:24 +0000
Subject: [lm-sensors] patch hwmon-kconfig-update.patch added to gregkh-2.6
Message-Id: <20060928065921.9B95072C257@imap.suse.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: [PATCH 02/23] hwmon: Make a dozen drivers no more experimental

to my gregkh-2.6 tree.  Its filename is

     hwmon-kconfig-update.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


From khali at linux-fr.org Sun Sep 24 11:51:42 2006
Date: Sun, 24 Sep 2006 20:51:37 +0200
From: Jean Delvare <khali at linux-fr.org>
To: Greg KH <greg at kroah.com>
Cc: LM Sensors <lm-sensors at lm-sensors.org>
Subject: [PATCH 02/23] hwmon: Make a dozen drivers no more experimental
Message-Id: <20060924205137.3856fbfa.khali at linux-fr.org>
Content-Disposition: inline; filename=hwmon-kconfig-update.patch

hwmon: Make a dozen drivers no more experimental

Remove the EXPERIMENTAL tag from a dozen hardware monitoring drivers.
They are in the tree for quite a long time, so we would know by now if
they were causing trouble.

Also make it clearer that the VT8231 is a VIA chip.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
 drivers/hwmon/Kconfig |   26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

--- gregkh-2.6.orig/drivers/hwmon/Kconfig
+++ gregkh-2.6/drivers/hwmon/Kconfig
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


Patches currently in gregkh-2.6 which might be from khali at linux-fr.org are

i2c/hwmon-w83627ehf-add-pwm-support.patch
i2c/hwmon-w83627ehf-documentation.patch
i2c/hwmon-k8temp-documentation.patch
i2c/hwmon-abituguru-suspend-resume.patch
i2c/hwmon-individual-alarm-files-1.patch
i2c/hwmon-kconfig-update.patch
i2c/hwmon-it87-disabled-fans.patch
i2c/hwmon-remove-yuan-mu-address.patch
i2c/hwmon-unchecked-return-status-fixes-1.patch
i2c/hwmon-unchecked-return-status-fixes-2.patch
i2c/hwmon-unchecked-return-status-fixes-3.patch
i2c/hwmon-unchecked-return-status-fixes-4.patch
i2c/hwmon-unchecked-return-status-fixes-5.patch
i2c/hwmon-unchecked-return-status-fixes-6.patch
i2c/hwmon-unchecked-return-status-fixes-pc87360-1.patch
i2c/hwmon-unchecked-return-status-fixes-pc87360-2.patch
i2c/hwmon-unchecked-return-status-fixes-pc87360-3.patch
i2c/hwmon-unchecked-return-status-fixes-smsc.patch
i2c/hwmon-unchecked-return-status-fixes-vt8231.patch
i2c/hwmon-atxp1-signed-unsigned-char-bug.patch
i2c/hwmon-hdaps-handle-errors-from-input-register-device.patch
i2c/hwmon-it87-copyright-update.patch
i2c/hwmon-it87-div-to-reg-overflow.patch
i2c/hwmon-it87-in8-no-limits.patch
i2c/hwmon-it87-it8716f-support.patch
i2c/hwmon-it87-it8718f-support.patch
i2c/hwmon-it87-sane-limit-defaults.patch
i2c/hwmon-it87-set-fan-div.patch
i2c/hwmon-k8temp-autoload.patch
i2c/hwmon-k8temp-new-driver.patch
i2c/hwmon-smsc47m1-fix-dev-message.patch
i2c/hwmon-unchecked-return-status-fixes-w83627ehf.patch
i2c/hwmon-unchecked-return-status-fixes-w83781d.patch
i2c/hwmon-unchecked-return-status-fixes-w83792d.patch
i2c/hwmon-unchecked-return-status-fixes-w83l785ts.patch
i2c/hwmon-vt1211-add-module-parameters-description.patch
i2c/hwmon-vt1211-documentation.patch
i2c/hwmon-vt1211-new-driver.patch
i2c/hwmon-w83791d-doc-update.patch
driver-class/i2c-dev-device.patch
driver-class/i2c-dev-device.old.patch

