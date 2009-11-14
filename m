From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 14 Nov 2009 15:33:07 +0000
Subject: [lm-sensors] [PATCH 2/3] hwmon: (adt7475) New documentation
Message-Id: <20091114163307.1fef2bcf@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

New documentation for the adt7475 driver, based on the adt7473 driver
documentation. It is IMHO much more useful that the previous
documentation which was essentially redundant with sysfs-interface.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Jordan Crouse <jordan@cosmicpenguin.net>
Cc: "Darrick J. Wong" <djwong@us.ibm.com>
---
 Documentation/hwmon/adt7475 |  168 ++++++++++++++++++++-----------------------
 1 file changed, 82 insertions(+), 86 deletions(-)

--- linux-2.6.32-rc7.orig/Documentation/hwmon/adt7475	2009-11-14 13:04:32.000000000 +0100
+++ linux-2.6.32-rc7/Documentation/hwmon/adt7475	2009-11-14 13:36:24.000000000 +0100
@@ -1,87 +1,83 @@
-This describes the interface for the ADT7475 driver:
+Kernel driver adt7475
+========== 
-(there are 4 fans, numbered fan1 to fan4):
-
-fanX_input		Read the current speed of the fan (in RPMs)
-fanX_min		Read/write the minimum speed of the fan.  Dropping
-			below this sets an alarm.
-
-(there are three PWMs, numbered pwm1 to pwm3):
-
-pwmX			Read/write the current duty cycle of the PWM.  Writes
-			only have effect when auto mode is turned off (see
-			below).  Range is 0 - 255.
-
-pwmX_enable		Fan speed control method:
-
-			0 - No control (fan at full speed)
-			1 - Manual fan speed control (using pwm[1-*])
-			2 - Automatic fan speed control
-
-pwmX_auto_channels_temp	Select which channels affect this PWM
-
-			1 - TEMP1 controls PWM
-			2 - TEMP2 controls PWM
-			4 - TEMP3 controls PWM
-			6 - TEMP2 and TEMP3 control PWM
-			7 - All three inputs control PWM
-
-pwmX_freq		Read/write the PWM frequency in Hz. The number
-			should be one of the following:
-
-			11 Hz
-			14 Hz
-			22 Hz
-			29 Hz
-			35 Hz
-			44 Hz
-			58 Hz
-			88 Hz
-
-pwmX_auto_point1_pwm	Read/write the minimum PWM duty cycle in automatic mode
-
-pwmX_auto_point2_pwm	Read/write the maximum PWM duty cycle in automatic mode
-
-(there are three temperature settings numbered temp1 to temp3):
-
-tempX_input		Read the current temperature.  The value is in milli
-			degrees of Celsius.
-
-tempX_max		Read/write the upper temperature limit - exceeding this
-			will cause an alarm.
-
-tempX_min		Read/write the lower temperature limit - exceeding this
-			will cause an alarm.
-
-tempX_offset		Read/write the temperature adjustment offset
-
-tempX_crit		Read/write the THERM limit for remote1.
-
-tempX_crit_hyst		Set the temperature value below crit where the
-			fans will stay on - this helps drive the temperature
-			low enough so it doesn't stay near the edge and
-			cause THERM to keep tripping.
-
-tempX_auto_point1_temp	Read/write the minimum temperature where the fans will
-			turn on in automatic mode.
-
-tempX_auto_point2_temp	Read/write the maximum temperature over which the fans
-			will run in automatic mode.  tempX_auto_point1_temp
-			and tempX_auto_point2_temp together define the
-			range of automatic control.
-
-tempX_alarm		Read a 1 if the max/min alarm is set
-tempX_fault		Read a 1 if either temp1 or temp3 diode has a fault
-
-(There are two voltage settings, in1 and in2):
-
-inX_input		Read the current voltage on VCC.  Value is in
-			millivolts.
-
-inX_min			read/write the minimum voltage limit.
-			Dropping below this causes an alarm.
-
-inX_max			read/write the maximum voltage limit.
-			Exceeding this causes an alarm.
-
-inX_alarm		Read a 1 if the max/min alarm is set.
+Supported chips:
+  * Analog Devices ADT7473
+    Prefix: 'adt7473'
+    Addresses scanned: I2C 0x2C, 0x2D, 0x2E
+    Datasheet: Publicly available at the On Semiconductors website
+  * Analog Devices ADT7475
+    Prefix: 'adt7475'
+    Addresses scanned: I2C 0x2E
+    Datasheet: Publicly available at the On Semiconductors website
+
+Authors:
+	Jordan Crouse
+	Hans de Goede
+	Darrick J. Wong (documentation)
+
+
+Description
+-----------
+
+This driver implements support for the Analog Devices ADT7473 and ADT7475
+chip family. Both chips differ only in minor details. They will be
+collectively designed by the name "ADT747x" in the rest of this document.
+
+The ADT747x uses the 2-wire interface compatible with the SMBus 2.0
+specification. Using an analog to digital converter it measures three (3)
+temperatures and two (2) voltages. It has four (4) 16-bit counters for
+measuring fan speed. There are three (3) PWM outputs that can be used
+to control fan speed.
+
+A sophisticated control system for the PWM outputs is designed into the
+ADT747x that allows fan speed to be adjusted automatically based on any of the
+three temperature sensors. Each PWM output is individually adjustable and
+programmable. Once configured, the ADT747x will adjust the PWM outputs in
+response to the measured temperatures without further host intervention.
+This feature can also be disabled for manual control of the PWM's.
+
+Each of the measured inputs (voltage, temperature, fan speed) has
+corresponding high/low limit values. The ADT747x will signal an ALARM if
+any measured value exceeds either limit.
+
+The ADT747x samples all inputs continuously. The driver will not read
+the registers more often than once every other second. Further,
+configuration data is only read once per minute.
+
+Special Features
+----------------
+
+The ADT747x has a 10-bit ADC and can therefore measure temperatures
+with a resolution of 0.25 degree Celsius. Temperature readings can be
+configured either for two's complement format or "Offset 64" format,
+wherein 64 is subtracted from the raw value to get the temperature value.
+
+The datasheet is very detailed and describes a procedure for determining
+an optimal configuration for the automatic PWM control.
+
+Fan Speed Control
+-----------------
+
+The driver exposes two trip points per PWM channel.
+
+point1: Set the PWM speed at the lower temperature bound
+point2: Set the PWM speed at the higher temperature bound
+
+The ADT747x will scale the PWM linearly between the lower and higher PWM
+speed when the temperature is between the two temperature boundaries.
+Temperature boundaries are associated to temperature channels rather than
+PWM outputs, and a given PWM output can be controlled by several temperature
+channels. As a result, the ADT747x may compute more than one PWM value
+for a channel at a given time, in which case the maximum value (fastest
+fan speed) is applied. PWM values range from 0 (off) to 255 (full speed).
+
+Fan speed may be set to maximum when the temperature sensor associated with
+the PWM control exceeds temp#_max.
+
+Notes
+-----
+
+The nVidia binary driver presents an ADT7473 chip via an on-card i2c bus.
+Unfortunately, they fail to set the i2c adapter class, so this driver may
+fail to find the chip until the nvidia driver is patched.


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
