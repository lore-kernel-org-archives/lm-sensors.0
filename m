From: R.Marek@sh.cvut.cz (R.Marek@sh.cvut.cz)
Date: Wed, 27 Jul 2005 12:01:33 +0000
Subject: [lm-sensors] [PATCH] I2C W83792D documentation 3/3
Message-Id: <20050727092528.23822.qmail@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello,

This patch adds documentation entry for W83792D chip.
Signed-Off-By: Rudolf Marek <r.marek@sh.cvut.cz>

Please apply.

Regards
Rudolf

diff -Naur a/Documentation/hwmon/w83792d b/Documentation/hwmon/w83792d
--- a/Documentation/hwmon/w83792d	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/hwmon/w83792d	2005-07-15 12:47:57.152695750 +0200
@@ -0,0 +1,174 @@
+Kernel driver w83792d
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
+Supported chips:
+  * Winbond W83792D
+    Prefix: 'w83792d'
+    Addresses scanned: I2C 0x2c - 0x2f
+    Datasheet: http://www.winbond.com.tw/E-WINBONDHTM/partner/PDFresult.as=
p?Pname=1035
+
+Author: Chunhao Huang
+Contact: DZShen <DZShen@Winbond.com.tw>
+
+
+Module Parameters
+-----------------
+
+* init int=20
+  (default 1)
+  Use 'init=3D0' to bypass initializing the chip.
+  Try this if your computer crashes when you load the module.
+
+* force_subclients=3Dbus,caddr,saddr,saddr
+  This is used to force the i2c addresses for subclients of
+  a certain chip. Example usage is `force_subclients=3D0,0x2f,0x4a,0x4b'
+  to force the subclients of chip 0x2f on bus 0 to i2c addresses
+  0x4a and 0x4b.
+
+
+Description
+-----------
+
+This driver implements support for the Winbond W83792AD/D.
+
+Detection of the chip can sometimes be foiled because it can be in an
+internal state that allows no clean access (Bank with ID register is not
+currently selected). If you know the address of the chip, use a 'force'
+parameter; this will put it into a more well-behaved state first.
+
+The driver implements three temperature sensors, seven fan rotation speed
+sensors, nine voltage sensors, and two automatic fan regulation
+strategies called: Smart Fan I (Thermal Cruise mode) and Smart Fan II.
+Automatic fan control mode is possible only for fan1-fan3. Fan4-fan7 can r=
un
+synchronized with selected fan (fan1-fan3). This functionality and manual =
PWM
+control for fan4-fan7 is not yet implemented.
+
+Temperatures are measured in degrees Celsius and measurement resolution is=
 1
+degC for temp1 and 0.5 degC for temp2 and temp3. An alarm is triggered when
+the temperature gets higher than the Overtemperature Shutdown value; it st=
ays
+on until the temperature falls below the Hysteresis value.
+
+Fan rotation speeds are reported in RPM (rotations per minute). An alarm is
+triggered if the rotation speed has dropped below a programmable limit. Fa=
n=20
+readings can be divided by a programmable divider (1, 2, 4, 8, 16, 32, 64 =
or
+128) to give the readings more range or accuracy.=20
+
+Voltage sensors (also known as IN sensors) report their values in millivol=
ts.
+An alarm is triggered if the voltage has crossed a programmable minimum=20
+or maximum limit.
+
+Alarms are provided as output from "realtime status register". Following b=
its
+are defined:
+
+bit - alarm on:
+0  - in0
+1  - in1
+2  - temp1
+3  - temp2
+4  - temp3
+5  - fan1
+6  - fan2
+7  - fan3
+8  - in2
+9  - in3
+10 - in4
+11 - in5
+12 - in6
+13 - VID change
+14 - chassis
+15 - fan7
+16 - tart1
+17 - tart2
+18 - tart3
+19 - in7
+20 - in8
+21 - fan4
+22 - fan5
+23 - fan6
+
+Tart will be asserted while target temperature cannot be achieved after 3 =
minutes
+of full speed rotation of corresponding fan.=20
+
+In addition to the alarms described above, there is a CHAS alarm on the ch=
ips
+which triggers if your computer case is open (This one is latched, contrary
+to realtime alarms).
+
+The chips only update values each 3 seconds; reading them more often will
+do no harm, but will return 'old' values.
+
+
+W83792D PROBLEMS
+----------------
+Known problems:
+	- This driver is only for Winbond W83792D C version device, there
+	  are also some motherboards with B version W83792D device. The=20
+	  calculation method to in6-in7(measured value, limits) is a little
+	  different between C and B version. C or B version can be identified
+	  by CR[0x49h].
+	- The function of vid and vrm has not been finished, because I'm NOT
+	  very familiar with them. Adding support is welcome.
+=A0	- The function of chassis open detection needs more tests.
+	- If you have ASUS server board and chip was not found: Then you will
+	  need to upgrade to latest (or beta) BIOS. If it does not help please
+	  contact us.
+
+Fan control
+-----------
+
+Manual mode
+-----------
+
+Works as expected. You just need to specify desired PWM/DC value (fan spee=
d)
+in appropriate pwm# file.
+
+Thermal cruise
+--------------
+
+In this mode, W83792D provides the Smart Fan system to automatically contr=
ol
+fan speed to keep the temperatures of CPU and the system within specific
+range. At first a wanted temperature and interval must be set. This is done
+via thermal_cruise# file. The tolerance# file serves to create T +- tolera=
nce
+interval. The fan speed will be lowered as long as the current temperature
+remains below the thermal_cruise# +- tolerance# value. Once the temperature
+exceeds the high limit (T+tolerance), the fan will be turned on with a
+specific speed set by pwm# and automatically controlled its PWM duty cycle
+with the temperature varying. Three conditions may occur:
+
+(1) If the temperature still exceeds the high limit, PWM duty
+cycle will increase slowly.=20
+
+(2) If the temperature goes below the high limit, but still above the low
+limit (T-tolerance), the fan speed will be fixed at the current speed beca=
use
+the temperature is in the target range.
+
+(3) If the temperature goes below the low limit, PWM duty cycle will decre=
ase
+slowly to 0 or a preset stop value until the temperature exceeds the low
+limit. (The preset stop value handling is not yet implemented in driver)
+
+Smart Fan II
+------------
+
+W83792D also provides a special mode for fan. Four temperature points are
+available. When related temperature sensors detects the temperature in pre=
set
+temperature region (sf2_point@_fan# +- tolerance#) it will cause fans to r=
un
+on programmed value from sf2_level@_fan#. You need to set four temperatures
+for each fan.
+
+
+/sys files
+----------
+
+pwm[1-3] - this file stores PWM duty cycle or DC value (fan speed) in rang=
e:
+	0 (stop) to 255 (full)
+pwm[1-3]_enable - this file controls mode of fan/temperature control:
+            * 0 Disabled
+            * 1 Manual mode
+            * 2 Smart Fan II
+            * 3 Thermal Cruise
+pwm[1-3]_mode - Select PWM of DC mode
+            * 0 DC
+            * 1 PWM
+thermal_cruise[1-3] - Selects the desired temperature for cruise (degC)
+tolerance[1-3] - Value in degrees of Celsius (degC) for +- T=20
+sf2_point[1-4]_fan[1-3] - four temperature points for each fan for Smart F=
an II
+sf2_level[1-3]_fan[1-3] - three PWM/DC levels for each fan for Smart Fan II
