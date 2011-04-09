From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 09 Apr 2011 16:31:56 +0000
Subject: [lm-sensors] hwmon: (adm1021) Clarify documentation regarding Xeon
Message-Id: <20110409183156.215fa01e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Recent Xeon processor thermal sensors are supported by the coretemp
driver and not the adm1021 driver. Only one old generation of Xeon
processors (the first Netburst ones) are supported by the adm1021
driver.

Reported-by: Darren Hart <dvhart@linux.intel.com>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 Documentation/hwmon/adm1021 |   36 +++++++++++++++++++-----------------
 drivers/hwmon/Kconfig       |    3 +--
 2 files changed, 20 insertions(+), 19 deletions(-)

--- linux-2.6.39-rc2.orig/Documentation/hwmon/adm1021	2010-08-02 00:11:14.000000000 +0200
+++ linux-2.6.39-rc2/Documentation/hwmon/adm1021	2011-04-08 10:11:13.000000000 +0200
@@ -14,10 +14,6 @@ Supported chips:
     Prefix: 'gl523sm'
     Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e
     Datasheet:
-  * Intel Xeon Processor
-    Prefix: - any other - may require 'force_adm1021' parameter
-    Addresses scanned: none
-    Datasheet: Publicly available at Intel website
   * Maxim MAX1617
     Prefix: 'max1617'
     Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e
@@ -91,21 +87,27 @@ will do no harm, but will return 'old' v
 ADM1021-clones do faster measurements, but there is really no good reason
 for that.
 
-Xeon support
-------------
 
-Some Xeon processors have real max1617, adm1021, or compatible chips
-within them, with two temperature sensors.
+Netburst-based Xeon support
+---------------------------
 
-Other Xeons have chips with only one sensor.
+Some Xeon processors based on the Netburst (early Pentium 4, from 2001 to
+2003) microarchitecture had real MAX1617, ADM1021, or compatible chips
+within them, with two temperature sensors. Other Xeon processors of this
+era (with 400 MHz FSB) had chips with only one temperature sensor.
 
-If you have a Xeon, and the adm1021 module loads, and both temperatures
-appear valid, then things are good.
+If you have such an old Xeon, and you get two valid temperatures when
+loading the adm1021 module, then things are good.
 
-If the adm1021 module doesn't load, you should try this:
-	modprobe adm1021 force_adm1021=BUS,ADDRESS
-	ADDRESS can only be 0x18, 0x1a, 0x29, 0x2b, 0x4c, or 0x4e.
+If nothing happens when loading the adm1021 module, are you are certain
+that your specific Xeon processor model includes compatible sensors, you
+will have to explicitly instantiate the sensor chips from user-space. See
+method 4 in Documentation/i2c/instantiating-devices. Possible slave
+addresses are 0x18, 0x1a, 0x29, 0x2b, 0x4c, or 0x4e. It is likely that
+only temp2 will be correct and temp1 will have to be ignored.
 
-If you have dual Xeons you may have appear to have two separate
-adm1021-compatible chips, or two single-temperature sensors, at distinct
-addresses.
+Previous generations of the Xeon processor (based on Pentium II/III)
+didn't have these sensors. Next generations of Xeon processors (533 MHz
+FSB and faster) lost them, until the Core-based generation which
+introduced integrated digital thermal sensors. These are supported by
+the coretemp driver.
--- linux-2.6.39-rc2.orig/drivers/hwmon/Kconfig	2011-04-07 18:51:51.000000000 +0200
+++ linux-2.6.39-rc2/drivers/hwmon/Kconfig	2011-04-08 09:36:50.000000000 +0200
@@ -110,8 +110,7 @@ config SENSORS_ADM1021
 	help
 	  If you say yes here you get support for Analog Devices ADM1021
 	  and ADM1023 sensor chips and clones: Maxim MAX1617 and MAX1617A,
-	  Genesys Logic GL523SM, National Semiconductor LM84, TI THMC10,
-	  and the XEON processor built-in sensor.
+	  Genesys Logic GL523SM, National Semiconductor LM84 and TI THMC10.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called adm1021.


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
