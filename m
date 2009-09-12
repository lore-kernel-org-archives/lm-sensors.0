From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 12 Sep 2009 13:31:48 +0000
Subject: [lm-sensors] [PATCH] hwmon: (pcf8591) Documentation clean-ups
Message-Id: <20090912153148.580f79e7@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Clean up the pcf8591 driver documentation:
* The PCF8591 chip is now an NXP product.
* Fix a sysfs path.
* Fix the name of sysfs attributes.
* And a few other random fixes.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Aurelien Jarno <aurelien@aurel32.net>
---
 Documentation/hwmon/pcf8591 |   28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

--- linux-2.6.32-pre.orig/Documentation/hwmon/pcf8591	2009-06-10 05:05:27.000000000 +0200
+++ linux-2.6.32-pre/Documentation/hwmon/pcf8591	2009-09-12 15:27:57.000000000 +0200
@@ -2,11 +2,11 @@ Kernel driver pcf8591
 ========== 
 Supported chips:
-  * Philips PCF8591
+  * Philips/NXP PCF8591
     Prefix: 'pcf8591'
     Addresses scanned: I2C 0x48 - 0x4f
-    Datasheet: Publicly available at the Philips Semiconductor website
-               http://www.semiconductors.philips.com/pip/PCF8591P.html
+    Datasheet: Publicly available at the NXP website
+               http://www.nxp.com/pip/PCF8591_6.html
 
 Authors:
         Aurelien Jarno <aurelien@aurel32.net>
@@ -16,9 +16,10 @@ Authors:
 
 Description
 -----------
+
 The PCF8591 is an 8-bit A/D and D/A converter (4 analog inputs and one
-analog output) for the I2C bus produced by Philips Semiconductors. It
-is designed to provide a byte I2C interface to up to 4 separate devices.
+analog output) for the I2C bus produced by Philips Semiconductors (now NXP).
+It is designed to provide a byte I2C interface to up to 4 separate devices.
 
 The PCF8591 has 4 analog inputs programmable as single-ended or
 differential inputs :
@@ -58,8 +59,8 @@ Accessing PCF8591 via /sys interface
 -------------------------------------
 
 ! Be careful !
-The PCF8591 is plainly impossible to detect ! Stupid chip.
-So every chip with address in the interval [48..4f] is
+The PCF8591 is plainly impossible to detect! Stupid chip.
+So every chip with address in the interval [0x48..0x4f] is
 detected as PCF8591. If you have other chips in this address
 range, the workaround is to load this module after the one
 for your others chips.
@@ -67,19 +68,20 @@ for your others chips.
 On detection (i.e. insmod, modprobe et al.), directories are being
 created for each detected PCF8591:
 
-/sys/bus/devices/<0>-<1>/
+/sys/bus/i2c/devices/<0>-<1>/
 where <0> is the bus the chip was detected on (e. g. i2c-0)
 and <1> the chip address ([48..4f])
 
 Inside these directories, there are such files:
-in0, in1, in2, in3, out0_enable, out0_output, name
+in0_input, in1_input, in2_input, in3_input, out0_enable, out0_output, name
 
 Name contains chip name.
 
-The in0, in1, in2 and in3 files are RO. Reading gives the value of the
-corresponding channel. Depending on the current analog inputs configuration,
-files in2 and/or in3 do not exist. Values range are from 0 to 255 for single
-ended inputs and -128 to +127 for differential inputs (8-bit ADC).
+The in0_input, in1_input, in2_input and in3_input files are RO. Reading gives
+the value of the corresponding channel. Depending on the current analog inputs
+configuration, files in2_input and in3_input may not exist. Values range
+from 0 to 255 for single ended inputs and -128 to +127 for differential inputs
+(8-bit ADC).
 
 The out0_enable file is RW. Reading gives "1" for analog output enabled and
 "0" for analog output disabled. Writing accepts "0" and "1" accordingly.


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
