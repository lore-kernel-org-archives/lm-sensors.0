From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 04 Jun 2006 18:09:19 +0000
Subject: [lm-sensors] [PATCH 04/11] hwmon: Sysfs interface documentation
Message-Id: <20060604200919.0f92b0e6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=hwmon-sysfs-interface-update-2.patch

Reword and complete certain parts of the hwmon sysfs-interface
documentation file. Hopefully this will make things clearer for new
driver authors.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 Documentation/hwmon/sysfs-interface |   39 +++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 13 deletions(-)

--- linux-2.6.17-rc5.orig/Documentation/hwmon/sysfs-interface	2006-06-04 09:05:52.000000000 +0200
+++ linux-2.6.17-rc5/Documentation/hwmon/sysfs-interface	2006-06-04 09:16:38.000000000 +0200
@@ -3,7 +3,7 @@
 
 The libsensors library offers an interface to the raw sensors data
 through the sysfs interface. See libsensors documentation and source for
-more further information. As of writing this document, libsensors
+further information. As of writing this document, libsensors
 (from lm_sensors 2.8.3) is heavily chip-dependant. Adding or updating
 support for any given chip requires modifying the library's code.
 This is because libsensors was written for the procfs interface
@@ -39,15 +39,16 @@
 this standard.
 
 Note that this standard isn't completely established yet, so it is subject
-to changes, even important ones. One more reason to use the library instead
-of accessing sysfs files directly.
+to changes. If you are writing a new hardware monitoring driver those
+features can't seem to fit in this interface, please contact us with your
+extension proposal. Keep in mind that backward compatibility must be
+preserved.
 
 Each chip gets its own directory in the sysfs /sys/devices tree.  To
-find all sensor chips, it is easier to follow the symlinks from
-/sys/i2c/devices/
+find all sensor chips, it is easier to follow the device symlinks from
+/sys/class/hwmon/hwmon*.
 
-All sysfs values are fixed point numbers.  To get the true value of some
-of the values, you should divide by the specified value.
+All sysfs values are fixed point numbers.
 
 There is only one value per file, unlike the older /proc specification.
 The common scheme for files naming is: <type><number>_<item>. Usual
@@ -77,6 +78,9 @@
 Read/write values may be read-only for some chips, depending on the
 hardware implementation.
 
+All entries are optional, and should only be created in a given driver
+if the chip has the feature.
+
 ************
 * Voltages *
 ************
@@ -213,32 +217,32 @@
 		Not all types are supported by all chips
 
 temp[1-*]_max	Temperature max value.
-		Unit: millidegree Celcius
+		Unit: millidegree Celsius (or millivolt, see below)
 		RW
 
 temp[1-*]_min	Temperature min value.
-		Unit: millidegree Celcius
+		Unit: millidegree Celsius
 		RW
 
 temp[1-*]_max_hyst
 		Temperature hysteresis value for max limit.
-		Unit: millidegree Celcius
+		Unit: millidegree Celsius
 		Must be reported as an absolute temperature, NOT a delta
 		from the max value.
 		RW
 
 temp[1-*]_input Temperature input value.
-		Unit: millidegree Celcius
+		Unit: millidegree Celsius
 		RO
 
 temp[1-*]_crit	Temperature critical value, typically greater than
 		corresponding temp_max values.
-		Unit: millidegree Celcius
+		Unit: millidegree Celsius
 		RW
 
 temp[1-*]_crit_hyst
 		Temperature hysteresis value for critical limit.
-		Unit: millidegree Celcius
+		Unit: millidegree Celsius
 		Must be reported as an absolute temperature, NOT a delta
 		from the critical value.
 		RW
@@ -256,6 +260,15 @@
 		itself, for example the thermal diode inside the CPU or
 		a thermistor nearby.
 
+Some chips measure temperature using external thermistors and an ADC, and
+report the temperature measurement as a voltage. Converting this voltage
+back to a temperature (or the other way around for limits) requires
+mathematical functions not available in the kernel, so the conversion
+must occur in user space. For these chips, all temp* files described
+above should contain values expressed in millivolt instead of millidegree
+Celsius. In other words, such temperature channels are handled as voltage
+channels by the driver.
+
 Also see the Alarms section for status flags associated with temperatures.
 
 

-- 
Jean Delvare

