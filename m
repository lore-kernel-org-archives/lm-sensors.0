From: gregkh@suse.de (Greg KH)
Date: Tue, 12 Jul 2005 00:23:19 +0000
Subject: [lm-sensors] [PATCH] I2C: Move hwmon drivers (3/3)
Message-Id: <11211193792006@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

[PATCH] I2C: Move hwmon drivers (3/3)

Part 3: Move the drivers documentation, plus two general documentation
files.

Note that the patch "adds trailing whitespace", because it does move the
files as-is, and some files happen to have trailing whitespace.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit ede7fbdf526c314850c9f32dd8da1753bf8d0ad5
tree 2f1fefa6f6df58f5c27bf98bd7df0908e97e44ef
parent 8d5d45fb14680326f833295f2316a4ec5e357220
author Jean Delvare <khali@linux-fr.org> Sat, 02 Jul 2005 18:52:48 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 11 Jul 2005 14:47:41 -07=
00

 Documentation/hwmon/adm1021         |  111 ++++++++++
 Documentation/hwmon/adm1025         |   51 ++++
 Documentation/hwmon/adm1026         |   93 ++++++++
 Documentation/hwmon/adm1031         |   35 +++
 Documentation/hwmon/adm9240         |  177 +++++++++++++++
 Documentation/hwmon/asb100          |   72 ++++++
 Documentation/hwmon/ds1621          |  108 +++++++++
 Documentation/hwmon/fscher          |  169 +++++++++++++++
 Documentation/hwmon/gl518sm         |   74 ++++++
 Documentation/hwmon/it87            |   96 ++++++++
 Documentation/hwmon/lm63            |   57 +++++
 Documentation/hwmon/lm75            |   65 ++++++
 Documentation/hwmon/lm77            |   22 ++
 Documentation/hwmon/lm78            |   82 +++++++
 Documentation/hwmon/lm80            |   56 +++++
 Documentation/hwmon/lm83            |   76 +++++++
 Documentation/hwmon/lm85            |  221 +++++++++++++++++++
 Documentation/hwmon/lm87            |   73 ++++++
 Documentation/hwmon/lm90            |  121 +++++++++++
 Documentation/hwmon/lm92            |   37 +++
 Documentation/hwmon/max1619         |   29 +++
 Documentation/hwmon/pc87360         |  189 ++++++++++++++++
 Documentation/hwmon/sis5595         |  106 +++++++++
 Documentation/hwmon/smsc47b397      |  158 ++++++++++++++
 Documentation/hwmon/smsc47m1        |   52 +++++
 Documentation/hwmon/sysfs-interface |  274 ++++++++++++++++++++++++
 Documentation/hwmon/userspace-tools |   39 +++
 Documentation/hwmon/via686a         |   65 ++++++
 Documentation/hwmon/w83627hf        |   66 ++++++
 Documentation/hwmon/w83781d         |  402 +++++++++++++++++++++++++++++++=
++++
 Documentation/hwmon/w83l785ts       |   39 +++
 Documentation/i2c/chips/adm1021     |  111 ----------
 Documentation/i2c/chips/adm1025     |   51 ----
 Documentation/i2c/chips/adm1026     |   93 --------
 Documentation/i2c/chips/adm1031     |   35 ---
 Documentation/i2c/chips/adm9240     |  177 ---------------
 Documentation/i2c/chips/asb100      |   72 ------
 Documentation/i2c/chips/ds1621      |  108 ---------
 Documentation/i2c/chips/fscher      |  169 ---------------
 Documentation/i2c/chips/gl518sm     |   74 ------
 Documentation/i2c/chips/it87        |   96 --------
 Documentation/i2c/chips/lm63        |   57 -----
 Documentation/i2c/chips/lm75        |   65 ------
 Documentation/i2c/chips/lm77        |   22 --
 Documentation/i2c/chips/lm78        |   82 -------
 Documentation/i2c/chips/lm80        |   56 -----
 Documentation/i2c/chips/lm83        |   76 -------
 Documentation/i2c/chips/lm85        |  221 -------------------
 Documentation/i2c/chips/lm87        |   73 ------
 Documentation/i2c/chips/lm90        |  121 -----------
 Documentation/i2c/chips/lm92        |   37 ---
 Documentation/i2c/chips/max1619     |   29 ---
 Documentation/i2c/chips/pc87360     |  189 ----------------
 Documentation/i2c/chips/sis5595     |  106 ---------
 Documentation/i2c/chips/smsc47b397  |  158 --------------
 Documentation/i2c/chips/smsc47m1    |   52 -----
 Documentation/i2c/chips/via686a     |   65 ------
 Documentation/i2c/chips/w83627hf    |   66 ------
 Documentation/i2c/chips/w83781d     |  402 -------------------------------=
----
 Documentation/i2c/chips/w83l785ts   |   39 ---
 Documentation/i2c/sysfs-interface   |  274 ------------------------
 Documentation/i2c/userspace-tools   |   39 ---
 62 files changed, 3215 insertions(+), 3215 deletions(-)

diff --git a/Documentation/hwmon/adm1021 b/Documentation/hwmon/adm1021
new file mode 100644
--- /dev/null
+++ b/Documentation/hwmon/adm1021
@@ -0,0 +1,111 @@
+Kernel driver adm1021
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
+Supported chips:
+  * Analog Devices ADM1021
+    Prefix: 'adm1021'
+    Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e
+    Datasheet: Publicly available at the Analog Devices website
+  * Analog Devices ADM1021A/ADM1023
+    Prefix: 'adm1023'
+    Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e
+    Datasheet: Publicly available at the Analog Devices website
+  * Genesys Logic GL523SM
+    Prefix: 'gl523sm'
+    Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e
+    Datasheet:
+  * Intel Xeon Processor
+    Prefix: - any other - may require 'force_adm1021' parameter
+    Addresses scanned: none
+    Datasheet: Publicly available at Intel website
+  * Maxim MAX1617
+    Prefix: 'max1617'
+    Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e
+    Datasheet: Publicly available at the Maxim website
+  * Maxim MAX1617A
+    Prefix: 'max1617a'
+    Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e
+    Datasheet: Publicly available at the Maxim website
+  * National Semiconductor LM84
+    Prefix: 'lm84'
+    Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e
+    Datasheet: Publicly available at the National Semiconductor website
+  * Philips NE1617
+    Prefix: 'max1617' (probably detected as a max1617)
+    Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e
+    Datasheet: Publicly available at the Philips website
+  * Philips NE1617A
+    Prefix: 'max1617' (probably detected as a max1617)
+    Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e
+    Datasheet: Publicly available at the Philips website
+  * TI THMC10
+    Prefix: 'thmc10'
+    Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e
+    Datasheet: Publicly available at the TI website
+  * Onsemi MC1066
+    Prefix: 'mc1066'
+    Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e
+    Datasheet: Publicly available at the Onsemi website
+
+
+Authors:
+        Frodo Looijaard <frodol@dds.nl>,
+        Philip Edelbrock <phil@netroedge.com>
+
+Module Parameters
+-----------------
+
+* read_only: int
+  Don't set any values, read only mode
+
+
+Description
+-----------
+
+The chips supported by this driver are very similar. The Maxim MAX1617 is
+the oldest; it has the problem that it is not very well detectable. The
+MAX1617A solves that. The ADM1021 is a straight clone of the MAX1617A.
+Ditto for the THMC10. From here on, we will refer to all these chips as
+ADM1021-clones.
+
+The ADM1021 and MAX1617A reports a die code, which is a sort of revision
+code. This can help us pinpoint problems; it is not very useful
+otherwise.
+
+ADM1021-clones implement two temperature sensors. One of them is internal,
+and measures the temperature of the chip itself; the other is external and
+is realised in the form of a transistor-like device. A special alarm
+indicates whether the remote sensor is connected.
+
+Each sensor has its own low and high limits. When they are crossed, the
+corresponding alarm is set and remains on as long as the temperature stays
+out of range. Temperatures are measured in degrees Celsius. Measurements
+are possible between -65 and +127 degrees, with a resolution of one degree.
+
+If an alarm triggers, it will remain triggered until the hardware register
+is read at least once. This means that the cause for the alarm may already
+have disappeared!
+
+This driver only updates its values each 1.5 seconds; reading it more often
+will do no harm, but will return 'old' values. It is possible to make
+ADM1021-clones do faster measurements, but there is really no good reason
+for that.
+
+Xeon support
+------------
+
+Some Xeon processors have real max1617, adm1021, or compatible chips
+within them, with two temperature sensors.
+
+Other Xeons have chips with only one sensor.
+
+If you have a Xeon, and the adm1021 module loads, and both temperatures
+appear valid, then things are good.
+
+If the adm1021 module doesn't load, you should try this:
+	modprobe adm1021 force_adm1021=3DBUS,ADDRESS
+	ADDRESS can only be 0x18, 0x1a, 0x29, 0x2b, 0x4c, or 0x4e.
+
+If you have dual Xeons you may have appear to have two separate
+adm1021-compatible chips, or two single-temperature sensors, at distinct
+addresses.
diff --git a/Documentation/hwmon/adm1025 b/Documentation/hwmon/adm1025
new file mode 100644
--- /dev/null
+++ b/Documentation/hwmon/adm1025
@@ -0,0 +1,51 @@
+Kernel driver adm1025
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
+Supported chips:
+  * Analog Devices ADM1025, ADM1025A
+    Prefix: 'adm1025'
+    Addresses scanned: I2C 0x2c - 0x2e
+    Datasheet: Publicly available at the Analog Devices website
+  * Philips NE1619
+    Prefix: 'ne1619'
+    Addresses scanned: I2C 0x2c - 0x2d
+    Datasheet: Publicly available at the Philips website
+
+The NE1619 presents some differences with the original ADM1025:
+  * Only two possible addresses (0x2c - 0x2d).
+  * No temperature offset register, but we don't use it anyway.
+  * No INT mode for pin 16. We don't play with it anyway.
+
+Authors:
+        Chen-Yuan Wu <gwu@esoft.com>,
+        Jean Delvare <khali@linux-fr.org>
+
+Description
+-----------
+
+(This is from Analog Devices.) The ADM1025 is a complete system hardware
+monitor for microprocessor-based systems, providing measurement and limit
+comparison of various system parameters. Five voltage measurement inputs
+are provided, for monitoring +2.5V, +3.3V, +5V and +12V power supplies and
+the processor core voltage. The ADM1025 can monitor a sixth power-supply
+voltage by measuring its own VCC. One input (two pins) is dedicated to a
+remote temperature-sensing diode and an on-chip temperature sensor allows
+ambient temperature to be monitored.
+
+One specificity of this chip is that the pin 11 can be hardwired in two
+different manners. It can act as the +12V power-supply voltage analog
+input, or as the a fifth digital entry for the VID reading (bit 4). It's
+kind of strange since both are useful, and the reason for designing the
+chip that way is obscure at least to me. The bit 5 of the configuration
+register can be used to define how the chip is hardwired. Please note that
+it is not a choice you have to make as the user. The choice was already
+made by your motherboard's maker. If the configuration bit isn't set
+properly, you'll have a wrong +12V reading or a wrong VID reading. The way
+the driver handles that is to preserve this bit through the initialization
+process, assuming that the BIOS set it up properly beforehand. If it turns
+out not to be true in some cases, we'll provide a module parameter to force
+modes.
+
+This driver also supports the ADM1025A, which differs from the ADM1025
+only in that it has "open-drain VID inputs while the ADM1025 has on-chip
+100k pull-ups on the VID inputs". It doesn't make any difference for us.
diff --git a/Documentation/hwmon/adm1026 b/Documentation/hwmon/adm1026
new file mode 100644
--- /dev/null
+++ b/Documentation/hwmon/adm1026
@@ -0,0 +1,93 @@
+Kernel driver adm1026
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
+Supported chips:
+  * Analog Devices ADM1026
+    Prefix: 'adm1026'
+    Addresses scanned: I2C 0x2c, 0x2d, 0x2e
+    Datasheet: Publicly available at the Analog Devices website
+               http://www.analog.com/en/prod/0,,766_825_ADM1026,00.html
+
+Authors:
+        Philip Pokorny <ppokorny@penguincomputing.com> for Penguin Computi=
ng
+        Justin Thiessen <jthiessen@penguincomputing.com>
+
+Module Parameters
+-----------------
+
+* gpio_input: int array (min =3D 1, max =3D 17)
+  List of GPIO pins (0-16) to program as inputs
+* gpio_output: int array (min =3D 1, max =3D 17)
+  List of GPIO pins (0-16) to program as outputs
+* gpio_inverted: int array (min =3D 1, max =3D 17)
+  List of GPIO pins (0-16) to program as inverted
+* gpio_normal: int array (min =3D 1, max =3D 17)
+  List of GPIO pins (0-16) to program as normal/non-inverted
+* gpio_fan: int array (min =3D 1, max =3D 8)
+  List of GPIO pins (0-7) to program as fan tachs
+
+
+Description
+-----------
+
+This driver implements support for the Analog Devices ADM1026. Analog
+Devices calls it a "complete thermal system management controller."
+
+The ADM1026 implements three (3) temperature sensors, 17 voltage sensors,
+16 general purpose digital I/O lines, eight (8) fan speed sensors (8-bit),
+an analog output and a PWM output along with limit, alarm and mask bits for
+all of the above. There is even 8k bytes of EEPROM memory on chip.
+
+Temperatures are measured in degrees Celsius. There are two external
+sensor inputs and one internal sensor. Each sensor has a high and low
+limit. If the limit is exceeded, an interrupt (#SMBALERT) can be
+generated. The interrupts can be masked. In addition, there are over-temp
+limits for each sensor. If this limit is exceeded, the #THERM output will
+be asserted. The current temperature and limits have a resolution of 1
+degree.
+
+Fan rotation speeds are reported in RPM (rotations per minute) but measured
+in counts of a 22.5kHz internal clock. Each fan has a high limit which
+corresponds to a minimum fan speed. If the limit is exceeded, an interrupt
+can be generated. Each fan can be programmed to divide the reference clock
+by 1, 2, 4 or 8. Not all RPM values can accurately be represented, so some
+rounding is done. With a divider of 8, the slowest measurable speed of a
+two pulse per revolution fan is 661 RPM.
+
+There are 17 voltage sensors. An alarm is triggered if the voltage has
+crossed a programmable minimum or maximum limit. Note that minimum in this
+case always means 'closest to zero'; this is important for negative voltage
+measurements. Several inputs have integrated attenuators so they can measu=
re
+higher voltages directly. 3.3V, 5V, 12V, -12V and battery voltage all have
+dedicated inputs. There are several inputs scaled to 0-3V full-scale range
+for SCSI terminator power. The remaining inputs are not scaled and have
+a 0-2.5V full-scale range. A 2.5V or 1.82V reference voltage is provided
+for negative voltage measurements.
+
+If an alarm triggers, it will remain triggered until the hardware register
+is read at least once. This means that the cause for the alarm may already
+have disappeared! Note that in the current implementation, all hardware
+registers are read whenever any data is read (unless it is less than 2.0
+seconds since the last update). This means that you can easily miss
+once-only alarms.
+
+The ADM1026 measures continuously. Analog inputs are measured about 4
+times a second. Fan speed measurement time depends on fan speed and
+divisor. It can take as long as 1.5 seconds to measure all fan speeds.
+
+The ADM1026 has the ability to automatically control fan speed based on the
+temperature sensor inputs. Both the PWM output and the DAC output can be
+used to control fan speed. Usually only one of these two outputs will be
+used. Write the minimum PWM or DAC value to the appropriate control
+register. Then set the low temperature limit in the tmin values for each
+temperature sensor. The range of control is fixed at 20 ?C, and the
+largest difference between current and tmin of the temperature sensors sets
+the control output. See the datasheet for several example circuits for
+controlling fan speed with the PWM and DAC outputs. The fan speed sensors
+do not have PWM compensation, so it is probably best to control the fan
+voltage from the power lead rather than on the ground lead.
+
+The datasheet shows an example application with VID signals attached to
+GPIO lines. Unfortunately, the chip may not be connected to the VID lines
+in this way. The driver assumes that the chips *is* connected this way to
+get a VID voltage.
diff --git a/Documentation/hwmon/adm1031 b/Documentation/hwmon/adm1031
new file mode 100644
--- /dev/null
+++ b/Documentation/hwmon/adm1031
@@ -0,0 +1,35 @@
+Kernel driver adm1031
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
+Supported chips:
+  * Analog Devices ADM1030
+    Prefix: 'adm1030'
+    Addresses scanned: I2C 0x2c to 0x2e
+    Datasheet: Publicly available at the Analog Devices website
+               http://products.analog.com/products/info.asp?product=ADM1030
+
+  * Analog Devices ADM1031
+    Prefix: 'adm1031'
+    Addresses scanned: I2C 0x2c to 0x2e
+    Datasheet: Publicly available at the Analog Devices website
+               http://products.analog.com/products/info.asp?product=ADM1031
+
+Authors:
+        Alexandre d'Alton <alex@alexdalton.org>
+        Jean Delvare <khali@linux-fr.org>
+
+Description
+-----------
+
+The ADM1030 and ADM1031 are digital temperature sensors and fan controller=
s.
+They sense their own temperature as well as the temperature of up to one
+(ADM1030) or two (ADM1031) external diodes.
+
+All temperature values are given in degrees Celsius. Resolution is 0.5
+degree for the local temperature, 0.125 degree for the remote temperatures.
+
+Each temperature channel has its own high and low limits, plus a critical
+limit.
+
+The ADM1030 monitors a single fan speed, while the ADM1031 monitors up to
+two. Each fan channel has its own low speed limit.
diff --git a/Documentation/hwmon/adm9240 b/Documentation/hwmon/adm9240
new file mode 100644
--- /dev/null
+++ b/Documentation/hwmon/adm9240
@@ -0,0 +1,177 @@
+Kernel driver adm9240
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
+Supported chips:
+  * Analog Devices ADM9240
+    Prefix: 'adm9240'
+    Addresses scanned: I2C 0x2c - 0x2f
+    Datasheet: Publicly available at the Analog Devices website
+    http://www.analog.com/UploadedFiles/Data_Sheets/79857778ADM9240_0.pdf
+
+  * Dallas Semiconductor DS1780
+    Prefix: 'ds1780'
+    Addresses scanned: I2C 0x2c - 0x2f
+    Datasheet: Publicly available at the Dallas Semiconductor (Maxim) webs=
ite
+    http://pdfserv.maxim-ic.com/en/ds/DS1780.pdf
+
+  * National Semiconductor LM81
+    Prefix: 'lm81'
+    Addresses scanned: I2C 0x2c - 0x2f
+    Datasheet: Publicly available at the National Semiconductor website
+    http://www.national.com/ds.cgi/LM/LM81.pdf
+
+Authors:
+    Frodo Looijaard <frodol@dds.nl>,
+    Philip Edelbrock <phil@netroedge.com>,
+    Michiel Rook <michiel@grendelproject.nl>,
+    Grant Coady <gcoady@gmail.com> with guidance
+        from Jean Delvare <khali@linux-fr.org>
+
+Interface
+---------
+The I2C addresses listed above assume BIOS has not changed the
+chip MSB 5-bit address. Each chip reports a unique manufacturer
+identification code as well as the chip revision/stepping level.
+
+Description
+-----------
+[From ADM9240] The ADM9240 is a complete system hardware monitor for
+microprocessor-based systems, providing measurement and limit comparison
+of up to four power supplies and two processor core voltages, plus
+temperature, two fan speeds and chassis intrusion. Measured values can
+be read out via an I2C-compatible serial System Management Bus, and values
+for limit comparisons can be programmed in over the same serial bus. The
+high speed successive approximation ADC allows frequent sampling of all
+analog channels to ensure a fast interrupt response to any out-of-limit
+measurement.
+
+The ADM9240, DS1780 and LM81 are register compatible, the following
+details are common to the three chips. Chip differences are described
+after this section.
+
+
+Measurements
+------------
+The measurement cycle
+
+The adm9240 driver will take a measurement reading no faster than once
+each two seconds. User-space may read sysfs interface faster than the
+measurement update rate and will receive cached data from the most
+recent measurement.
+
+ADM9240 has a very fast 320us temperature and voltage measurement cycle
+with independent fan speed measurement cycles counting alternating rising
+edges of the fan tacho inputs.
+
+DS1780 measurement cycle is about once per second including fan speed.
+
+LM81 measurement cycle is about once per 400ms including fan speed.
+The LM81 12-bit extended temperature measurement mode is not supported.
+
+Temperature
+-----------
+On chip temperature is reported as degrees Celsius as 9-bit signed data
+with resolution of 0.5 degrees Celsius. High and low temperature limits
+are 8-bit signed data with resolution of one degree Celsius.
+
+Temperature alarm is asserted once the temperature exceeds the high limit,
+and is cleared when the temperature falls below the temp1_max_hyst value.
+
+Fan Speed
+---------
+Two fan tacho inputs are provided, the ADM9240 gates an internal 22.5kHz
+clock via a divider to an 8-bit counter. Fan speed (rpm) is calculated by:
+
+rpm =3D (22500 * 60) / (count * divider)
+
+Automatic fan clock divider
+
+  * User sets 0 to fan_min limit
+    - low speed alarm is disabled
+    - fan clock divider not changed
+    - auto fan clock adjuster enabled for valid fan speed reading
+
+  * User sets fan_min limit too low
+    - low speed alarm is enabled
+    - fan clock divider set to max
+    - fan_min set to register value 254 which corresponds
+      to 664 rpm on adm9240
+    - low speed alarm will be asserted if fan speed is
+      less than minimum measurable speed
+    - auto fan clock adjuster disabled
+
+  * User sets reasonable fan speed
+    - low speed alarm is enabled
+    - fan clock divider set to suit fan_min
+    - auto fan clock adjuster enabled: adjusts fan_min
+
+  * User sets unreasonably high low fan speed limit
+    - resolution of the low speed limit may be reduced
+    - alarm will be asserted
+    - auto fan clock adjuster enabled: adjusts fan_min
+
+    * fan speed may be displayed as zero until the auto fan clock divider
+      adjuster brings fan speed clock divider back into chip measurement
+      range, this will occur within a few measurement cycles.
+
+Analog Output
+-------------
+An analog output provides a 0 to 1.25 volt signal intended for an external
+fan speed amplifier circuit. The analog output is set to maximum value on
+power up or reset. This doesn't do much on the test Intel SE440BX-2.
+
+Voltage Monitor
+
+Voltage (IN) measurement is internally scaled:
+
+    nr  label       nominal     maximum   resolution
+                      mV          mV         mV
+    0   +2.5V        2500        3320       13.0
+    1   Vccp1        2700        3600       14.1
+    2   +3.3V        3300        4380       17.2
+    3     +5V        5000        6640       26.0
+    4    +12V       12000       15940       62.5
+    5   Vccp2        2700        3600       14.1
+
+The reading is an unsigned 8-bit value, nominal voltage measurement is
+represented by a reading of 192, being 3/4 of the measurement range.
+
+An alarm is asserted for any voltage going below or above the set limits.
+
+The driver reports and accepts voltage limits scaled to the above table.
+
+VID Monitor
+-----------
+The chip has five inputs to read the 5-bit VID and reports the mV value
+based on detected CPU type.
+
+Chassis Intrusion
+-----------------
+An alarm is asserted when the CI pin goes active high. The ADM9240
+Datasheet has an example of an external temperature sensor driving
+this pin. On an Intel SE440BX-2 the Chassis Intrusion header is
+connected to a normally open switch.
+
+The ADM9240 provides an internal open drain on this line, and may output
+a 20 ms active low pulse to reset an external Chassis Intrusion latch.
+
+Clear the CI latch by writing value 1 to the sysfs chassis_clear file.
+
+Alarm flags reported as 16-bit word
+
+    bit     label               comment
+    ---     -------------       --------------------------
+     0      +2.5 V_Error        high or low limit exceeded
+     1      VCCP_Error          high or low limit exceeded
+     2      +3.3 V_Error        high or low limit exceeded
+     3      +5 V_Error          high or low limit exceeded
+     4      Temp_Error          temperature error
+     6      FAN1_Error          fan low limit exceeded
+     7      FAN2_Error          fan low limit exceeded
+     8      +12 V_Error         high or low limit exceeded
+     9      VCCP2_Error         high or low limit exceeded
+    12      Chassis_Error       CI pin went high
+
+Remaining bits are reserved and thus undefined. It is important to note
+that alarm bits may be cleared on read, user-space may latch alarms and
+provide the end-user with a method to clear alarm memory.
diff --git a/Documentation/hwmon/asb100 b/Documentation/hwmon/asb100
new file mode 100644
--- /dev/null
+++ b/Documentation/hwmon/asb100
@@ -0,0 +1,72 @@
+Kernel driver asb100
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Supported Chips:
+  * Asus ASB100 and ASB100-A "Bach"
+    Prefix: 'asb100'
+    Addresses scanned: I2C 0x2d
+    Datasheet: none released
+
+Author: Mark M. Hoffman <mhoffman@lightlink.com>
+
+Description
+-----------
+
+This driver implements support for the Asus ASB100 and ASB100-A "Bach".
+These are custom ASICs available only on Asus mainboards. Asus refuses to
+supply a datasheet for these chips. Thanks go to many people who helped
+investigate their hardware, including:
+
+Vitaly V. Bursov
+Alexander van Kaam (author of MBM for Windows)
+Bertrik Sikken
+
+The ASB100 implements seven voltage sensors, three fan rotation speed
+sensors, four temperature sensors, VID lines and alarms. In addition to
+these, the ASB100-A also implements a single PWM controller for fans 2 and
+3 (i.e. one setting controls both.) If you have a plain ASB100, the PWM
+controller will simply not work (or maybe it will for you... it doesn't for
+me).
+
+Temperatures are measured and reported in degrees Celsius.
+
+Fan speeds are reported in RPM (rotations per minute). An alarm is
+triggered if the rotation speed has dropped below a programmable limit.
+
+Voltage sensors (also known as IN sensors) report values in volts.
+
+The VID lines encode the core voltage value: the voltage level your
+processor should work with. This is hardcoded by the mainboard and/or
+processor itself. It is a value in volts.
+
+Alarms: (TODO question marks indicate may or may not work)
+
+0x0001 =3D> in0 (?)
+0x0002 =3D> in1 (?)
+0x0004 =3D> in2
+0x0008 =3D> in3
+0x0010 =3D> temp1 (1)
+0x0020 =3D> temp2
+0x0040 =3D> fan1
+0x0080 =3D> fan2
+0x0100 =3D> in4
+0x0200 =3D> in5 (?) (2)
+0x0400 =3D> in6 (?) (2)
+0x0800 =3D> fan3
+0x1000 =3D> chassis switch
+0x2000 =3D> temp3
+
+Alarm Notes:
+
+(1) This alarm will only trigger if the hysteresis value is 127C.
+I.e. it behaves the same as w83781d.
+
+(2) The min and max registers for these values appear to
+be read-only or otherwise stuck at 0x00.
+
+TODO:
+* Experiment with fan divisors > 8.
+* Experiment with temp. sensor types.
+* Are there really 13 voltage inputs? Probably not...
+* Cleanups, no doubt...
+
diff --git a/Documentation/hwmon/ds1621 b/Documentation/hwmon/ds1621
new file mode 100644
--- /dev/null
+++ b/Documentation/hwmon/ds1621
@@ -0,0 +1,108 @@
+Kernel driver ds1621
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Supported chips:
+  * Dallas Semiconductor DS1621
+    Prefix: 'ds1621'
+    Addresses scanned: I2C 0x48 - 0x4f
+    Datasheet: Publicly available at the Dallas Semiconductor website
+               http://www.dalsemi.com/
+  * Dallas Semiconductor DS1625
+    Prefix: 'ds1621'
+    Addresses scanned: I2C 0x48 - 0x4f
+    Datasheet: Publicly available at the Dallas Semiconductor website
+               http://www.dalsemi.com/
+
+Authors:
+        Christian W. Zuckschwerdt <zany@triq.net>
+        valuable contributions by Jan M. Sendler <sendler@sendler.de>
+        ported to 2.6 by Aurelien Jarno <aurelien@aurel32.net>
+        with the help of Jean Delvare <khali@linux-fr.org>
+
+Module Parameters
+------------------
+
+* polarity int
+  Output's polarity: 0 =3D active high, 1 =3D active low
+
+Description
+-----------
+
+The DS1621 is a (one instance) digital thermometer and thermostat. It has
+both high and low temperature limits which can be user defined (i.e.
+programmed into non-volatile on-chip registers). Temperature range is -55
+degree Celsius to +125 in 0.5 increments. You may convert this into a
+Fahrenheit range of -67 to +257 degrees with 0.9 steps. If polarity
+parameter is not provided, original value is used.
+
+As for the thermostat, behavior can also be programmed using the polarity
+toggle. On the one hand ("heater"), the thermostat output of the chip,
+Tout, will trigger when the low limit temperature is met or underrun and
+stays high until the high limit is met or exceeded. On the other hand
+("cooler"), vice versa. That way "heater" equals "active low", whereas
+"conditioner" equals "active high". Please note that the DS1621 data sheet
+is somewhat misleading in this point since setting the polarity bit does
+not simply invert Tout.
+
+A second thing is that, during extensive testing, Tout showed a tolerance
+of up to +/- 0.5 degrees even when compared against precise temperature
+readings. Be sure to have a high vs. low temperature limit gap of al least
+1.0 degree Celsius to avoid Tout "bouncing", though!
+
+As for alarms, you can read the alarm status of the DS1621 via the 'alarms'
+/sys file interface. The result consists mainly of bit 6 and 5 of the
+configuration register of the chip; bit 6 (0x40 or 64) is the high alarm
+bit and bit 5 (0x20 or 32) the low one. These bits are set when the high or
+low limits are met or exceeded and are reset by the module as soon as the
+respective temperature ranges are left.
+
+The alarm registers are in no way suitable to find out about the actual
+status of Tout. They will only tell you about its history, whether or not
+any of the limits have ever been met or exceeded since last power-up or
+reset. Be aware: When testing, it showed that the status of Tout can change
+with neither of the alarms set.
+
+Temperature conversion of the DS1621 takes up to 1000ms; internal access to
+non-volatile registers may last for 10ms or below.
+
+High Accuracy Temperature Reading
+---------------------------------
+
+As said before, the temperature issued via the 9-bit i2c-bus data is
+somewhat arbitrary. Internally, the temperature conversion is of a
+different kind that is explained (not so...) well in the DS1621 data sheet.
+To cut the long story short: Inside the DS1621 there are two oscillators,
+both of them biassed by a temperature coefficient.
+
+Higher resolution of the temperature reading can be achieved using the
+internal projection, which means taking account of REG_COUNT and REG_SLOPE
+(the driver manages them):
+
+Taken from Dallas Semiconductors App Note 068: 'Increasing Temperature
+Resolution on the DS1620' and App Note 105: 'High Resolution Temperature
+Measurement with Dallas Direct-to-Digital Temperature Sensors'
+
+- Read the 9-bit temperature and strip the LSB (Truncate the .5 degs)
+- The resulting value is TEMP_READ.
+- Then, read REG_COUNT.
+- And then, REG_SLOPE.
+
+      TEMP =3D TEMP_READ - 0.25 + ((REG_SLOPE - REG_COUNT) / REG_SLOPE)
+
+Note that this is what the DONE bit in the DS1621 configuration register is
+good for: Internally, one temperature conversion takes up to 1000ms. Before
+that conversion is complete you will not be able to read valid things out
+of REG_COUNT and REG_SLOPE. The DONE bit, as you may have guessed by now,
+tells you whether the conversion is complete ("done", in plain English) and
+thus, whether the values you read are good or not.
+
+The DS1621 has two modes of operation: "Continuous" conversion, which can
+be understood as the default stand-alone mode where the chip gets the
+temperature and controls external devices via its Tout pin or tells other
+i2c's about it if they care. The other mode is called "1SHOT", that means
+that it only figures out about the temperature when it is explicitly told
+to do so; this can be seen as power saving mode.
+
+Now if you want to read REG_COUNT and REG_SLOPE, you have to either stop
+the continuous conversions until the contents of these registers are valid,
+or, in 1SHOT mode, you have to have one conversion made.
diff --git a/Documentation/hwmon/fscher b/Documentation/hwmon/fscher
new file mode 100644
--- /dev/null
+++ b/Documentation/hwmon/fscher
@@ -0,0 +1,169 @@
+Kernel driver fscher
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Supported chips:
+  * Fujitsu-Siemens Hermes chip
+    Prefix: 'fscher'
+    Addresses scanned: I2C 0x73
+
+Authors:
+        Reinhard Nissl <rnissl@gmx.de> based on work
+        from Hermann Jung <hej@odn.de>,
+        Frodo Looijaard <frodol@dds.nl>,
+        Philip Edelbrock <phil@netroedge.com>
+
+Description
+-----------
+
+This driver implements support for the Fujitsu-Siemens Hermes chip. It is
+described in the 'Register Set Specification BMC Hermes based Systemboard'
+from Fujitsu-Siemens.
+
+The Hermes chip implements a hardware-based system management, e.g. for
+controlling fan speed and core voltage. There is also a watchdog counter on
+the chip which can trigger an alarm and even shut the system down.
+
+The chip provides three temperature values (CPU, motherboard and
+auxiliary), three voltage values (+12V, +5V and battery) and three fans
+(power supply, CPU and auxiliary).
+
+Temperatures are measured in degrees Celsius. The resolution is 1 degree.
+
+Fan rotation speeds are reported in RPM (rotations per minute). The value
+can be divided by a programmable divider (1, 2 or 4) which is stored on
+the chip.
+
+Voltage sensors (also known as "in" sensors) report their values in volts.
+
+All values are reported as final values from the driver. There is no need
+for further calculations.
+
+
+Detailed description
+--------------------
+
+Below you'll find a single line description of all the bit values. With
+this information, you're able to decode e. g. alarms, wdog, etc. To make
+use of the watchdog, you'll need to set the watchdog time and enable the
+watchdog. After that it is necessary to restart the watchdog time within
+the specified period of time, or a system reset will occur.
+
+* revision
+  READING & 0xff =3D 0x??: HERMES revision identification
+
+* alarms
+  READING & 0x80 =3D 0x80: CPU throttling active
+  READING & 0x80 =3D 0x00: CPU running at full speed
+
+  READING & 0x10 =3D 0x10: software event (see control:1)
+  READING & 0x10 =3D 0x00: no software event
+
+  READING & 0x08 =3D 0x08: watchdog event (see wdog:2)
+  READING & 0x08 =3D 0x00: no watchdog event
+
+  READING & 0x02 =3D 0x02: thermal event (see temp*:1)
+  READING & 0x02 =3D 0x00: no thermal event
+
+  READING & 0x01 =3D 0x01: fan event (see fan*:1)
+  READING & 0x01 =3D 0x00: no fan event
+
+  READING & 0x13 ! 0x00: ALERT LED is flashing
+
+* control
+  READING & 0x01 =3D 0x01: software event
+  READING & 0x01 =3D 0x00: no software event
+
+  WRITING & 0x01 =3D 0x01: set software event
+  WRITING & 0x01 =3D 0x00: clear software event
+
+* watchdog_control
+  READING & 0x80 =3D 0x80: power off on watchdog event while thermal event
+  READING & 0x80 =3D 0x00: watchdog power off disabled (just system reset =
enabled)
+
+  READING & 0x40 =3D 0x40: watchdog timebase 60 seconds (see also wdog:1)
+  READING & 0x40 =3D 0x00: watchdog timebase  2 seconds
+
+  READING & 0x10 =3D 0x10: watchdog enabled
+  READING & 0x10 =3D 0x00: watchdog disabled
+
+  WRITING & 0x80 =3D 0x80: enable "power off on watchdog event while therm=
al event"
+  WRITING & 0x80 =3D 0x00: disable "power off on watchdog event while ther=
mal event"
+
+  WRITING & 0x40 =3D 0x40: set watchdog timebase to 60 seconds
+  WRITING & 0x40 =3D 0x00: set watchdog timebase to  2 seconds
+
+  WRITING & 0x20 =3D 0x20: disable watchdog
+
+  WRITING & 0x10 =3D 0x10: enable watchdog / restart watchdog time
+
+* watchdog_state
+  READING & 0x02 =3D 0x02: watchdog system reset occurred
+  READING & 0x02 =3D 0x00: no watchdog system reset occurred
+
+  WRITING & 0x02 =3D 0x02: clear watchdog event
+
+* watchdog_preset
+  READING & 0xff =3D 0x??: configured watch dog time in units (see wdog:3 =
0x40)
+
+  WRITING & 0xff =3D 0x??: configure watch dog time in units
+
+* in*     (0: +5V, 1: +12V, 2: onboard 3V battery)
+  READING: actual voltage value
+
+* temp*_status   (1: CPU sensor, 2: onboard sensor, 3: auxiliary sensor)
+  READING & 0x02 =3D 0x02: thermal event (overtemperature)
+  READING & 0x02 =3D 0x00: no thermal event
+
+  READING & 0x01 =3D 0x01: sensor is working
+  READING & 0x01 =3D 0x00: sensor is faulty
+
+  WRITING & 0x02 =3D 0x02: clear thermal event
+
+* temp*_input   (1: CPU sensor, 2: onboard sensor, 3: auxiliary sensor)
+  READING: actual temperature value
+
+* fan*_status   (1: power supply fan, 2: CPU fan, 3: auxiliary fan)
+  READING & 0x04 =3D 0x04: fan event (fan fault)
+  READING & 0x04 =3D 0x00: no fan event
+
+  WRITING & 0x04 =3D 0x04: clear fan event
+
+* fan*_div (1: power supply fan, 2: CPU fan, 3: auxiliary fan)
+  	Divisors 2,4 and 8 are supported, both for reading and writing
+
+* fan*_pwm   (1: power supply fan, 2: CPU fan, 3: auxiliary fan)
+  READING & 0xff =3D 0x00: fan may be switched off
+  READING & 0xff =3D 0x01: fan must run at least at minimum speed (supply:=
 6V)
+  READING & 0xff =3D 0xff: fan must run at maximum speed (supply: 12V)
+  READING & 0xff =3D 0x??: fan must run at least at given speed (supply: 6=
V..12V)
+
+  WRITING & 0xff =3D 0x00: fan may be switched off
+  WRITING & 0xff =3D 0x01: fan must run at least at minimum speed (supply:=
 6V)
+  WRITING & 0xff =3D 0xff: fan must run at maximum speed (supply: 12V)
+  WRITING & 0xff =3D 0x??: fan must run at least at given speed (supply: 6=
V..12V)
+
+* fan*_input   (1: power supply fan, 2: CPU fan, 3: auxiliary fan)
+  READING: actual RPM value
+
+
+Limitations
+-----------
+
+* Measuring fan speed
+It seems that the chip counts "ripples" (typical fans produce 2 ripples per
+rotation while VERAX fans produce 18) in a 9-bit register. This register is
+read out every second, then the ripple prescaler (2, 4 or 8) is applied and
+the result is stored in the 8 bit output register. Due to the limitation of
+the counting register to 9 bits, it is impossible to measure a VERAX fan
+properly (even with a prescaler of 8). At its maximum speed of 3500 RPM the
+fan produces 1080 ripples per second which causes the counting register to
+overflow twice, leading to only 186 RPM.
+
+* Measuring input voltages
+in2 ("battery") reports the voltage of the onboard lithium battery and not
++3.3V from the power supply.
+
+* Undocumented features
+Fujitsu-Siemens Computers has not documented all features of the chip so
+far. Their software, System Guard, shows that there are a still some
+features which cannot be controlled by this implementation.
diff --git a/Documentation/hwmon/gl518sm b/Documentation/hwmon/gl518sm
new file mode 100644
--- /dev/null
+++ b/Documentation/hwmon/gl518sm
@@ -0,0 +1,74 @@
+Kernel driver gl518sm
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
+Supported chips:
+  * Genesys Logic GL518SM release 0x00
+    Prefix: 'gl518sm'
+    Addresses scanned: I2C 0x2c and 0x2d
+    Datasheet: http://www.genesyslogic.com/pdf
+  * Genesys Logic GL518SM release 0x80
+    Prefix: 'gl518sm'
+    Addresses scanned: I2C 0x2c and 0x2d
+    Datasheet: http://www.genesyslogic.com/pdf
+
+Authors:
+        Frodo Looijaard <frodol@dds.nl>,
+        Ky?sti M?lkki <kmalkki@cc.hut.fi>
+        Hong-Gunn Chew <hglinux@gunnet.org>
+        Jean Delvare <khali@linux-fr.org>
+
+Description
+-----------
+
+IMPORTANT:
+
+For the revision 0x00 chip, the in0, in1, and in2  values (+5V, +3V,
+and +12V) CANNOT be read. This is a limitation of the chip, not the driver.
+
+This driver supports the Genesys Logic GL518SM chip. There are at least
+two revision of this chip, which we call revision 0x00 and 0x80. Revision
+0x80 chips support the reading of all voltages and revision 0x00 only
+for VIN3.
+
+The GL518SM implements one temperature sensor, two fan rotation speed
+sensors, and four voltage sensors. It can report alarms through the
+computer speakers.
+
+Temperatures are measured in degrees Celsius. An alarm goes off while the
+temperature is above the over temperature limit, and has not yet dropped
+below the hysteresis limit. The alarm always reflects the current
+situation. Measurements are guaranteed between -10 degrees and +110
+degrees, with a accuracy of +/-3 degrees.
+
+Rotation speeds are reported in RPM (rotations per minute). An alarm is
+triggered if the rotation speed has dropped below a programmable limit. In
+case when you have selected to turn fan1 off, no fan1 alarm is triggered.
+
+Fan readings can be divided by a programmable divider (1, 2, 4 or 8) to
+give the readings more range or accuracy.  Not all RPM values can
+accurately be represented, so some rounding is done. With a divider
+of 2, the lowest representable value is around 1900 RPM.
+
+Voltage sensors (also known as VIN sensors) report their values in volts.
+An alarm is triggered if the voltage has crossed a programmable minimum or
+maximum limit. Note that minimum in this case always means 'closest to
+zero'; this is important for negative voltage measurements. The VDD input
+measures voltages between 0.000 and 5.865 volt, with a resolution of 0.023
+volt. The other inputs measure voltages between 0.000 and 4.845 volt, with
+a resolution of 0.019 volt. Note that revision 0x00 chips do not support
+reading the current voltage of any input except for VIN3; limit setting and
+alarms work fine, though.
+
+When an alarm is triggered, you can be warned by a beeping signal through =
your
+computer speaker. It is possible to enable all beeping globally, or only t=
he
+beeping for some alarms.
+
+If an alarm triggers, it will remain triggered until the hardware register
+is read at least once (except for temperature alarms). This means that the
+cause for the alarm may already have disappeared! Note that in the current
+implementation, all hardware registers are read whenever any data is read
+(unless it is less than 1.5 seconds since the last update). This means that
+you can easily miss once-only alarms.
+
+The GL518SM only updates its values each 1.5 seconds; reading it more often
+will do no harm, but will return 'old' values.
diff --git a/Documentation/hwmon/it87 b/Documentation/hwmon/it87
new file mode 100644
--- /dev/null
+++ b/Documentation/hwmon/it87
@@ -0,0 +1,96 @@
+Kernel driver it87
+=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Supported chips:
+  * IT8705F
+    Prefix: 'it87'
+    Addresses scanned: from Super I/O config space, or default ISA 0x290 (=
8 I/O ports)
+    Datasheet: Publicly available at the ITE website
+               http://www.ite.com.tw/
+  * IT8712F
+    Prefix: 'it8712'
+    Addresses scanned: I2C 0x28 - 0x2f
+                       from Super I/O config space, or default ISA 0x290 (=
8 I/O ports)
+    Datasheet: Publicly available at the ITE website
+               http://www.ite.com.tw/
+  * SiS950   [clone of IT8705F]
+    Prefix: 'sis950'
+    Addresses scanned: from Super I/O config space, or default ISA 0x290 (=
8 I/O ports)
+    Datasheet: No longer be available
+
+Author: Christophe Gauthron <chrisg@0-in.com>
+
+
+Module Parameters
+-----------------
+
+* update_vbat: int
+
+  0 if vbat should report power on value, 1 if vbat should be updated after
+  each read. Default is 0. On some boards the battery voltage is provided
+  by either the battery or the onboard power supply. Only the first reading
+  at power on will be the actual battery voltage (which the chip does
+  automatically). On other boards the battery voltage is always fed to
+  the chip so can be read at any time. Excessive reading may decrease
+  battery life but no information is given in the datasheet.
+
+* fix_pwm_polarity int
+
+  Force PWM polarity to active high (DANGEROUS). Some chips are
+  misconfigured by BIOS - PWM values would be inverted. This option tries
+  to fix this. Please contact your BIOS manufacturer and ask him for fix.
+
+Description
+-----------
+
+This driver implements support for the IT8705F, IT8712F and SiS950 chips.
+
+This driver also supports IT8712F, which adds SMBus access, and a VID
+input, used to report the Vcore voltage of the Pentium processor.
+The IT8712F additionally features VID inputs.
+
+These chips are 'Super I/O chips', supporting floppy disks, infrared ports,
+joysticks and other miscellaneous stuff. For hardware monitoring, they
+include an 'environment controller' with 3 temperature sensors, 3 fan
+rotation speed sensors, 8 voltage sensors, and associated alarms.
+
+Temperatures are measured in degrees Celsius. An alarm is triggered once
+when the Overtemperature Shutdown limit is crossed.
+
+Fan rotation speeds are reported in RPM (rotations per minute). An alarm is
+triggered if the rotation speed has dropped below a programmable limit. Fan
+readings can be divided by a programmable divider (1, 2, 4 or 8) to give t=
he
+readings more range or accuracy. Not all RPM values can accurately be
+represented, so some rounding is done. With a divider of 2, the lowest
+representable value is around 2600 RPM.
+
+Voltage sensors (also known as IN sensors) report their values in volts. An
+alarm is triggered if the voltage has crossed a programmable minimum or
+maximum limit. Note that minimum in this case always means 'closest to
+zero'; this is important for negative voltage measurements. All voltage
+inputs can measure voltages between 0 and 4.08 volts, with a resolution of
+0.016 volt. The battery voltage in8 does not have limit registers.
+
+The VID lines (IT8712F only) encode the core voltage value: the voltage
+level your processor should work with. This is hardcoded by the mainboard
+and/or processor itself. It is a value in volts.
+
+If an alarm triggers, it will remain triggered until the hardware register
+is read at least once. This means that the cause for the alarm may already
+have disappeared! Note that in the current implementation, all hardware
+registers are read whenever any data is read (unless it is less than 1.5
+seconds since the last update). This means that you can easily miss
+once-only alarms.
+
+The IT87xx only updates its values each 1.5 seconds; reading it more often
+will do no harm, but will return 'old' values.
+
+To change sensor N to a thermistor, 'echo 2 > tempN_type' where N is 1, 2,
+or 3. To change sensor N to a thermal diode, 'echo 3 > tempN_type'.
+Give 0 for unused sensor. Any other value is invalid. To configure this at
+startup, consult lm_sensors's /etc/sensors.conf. (2 =3D thermistor;
+3 =3D thermal diode)
+
+The fan speed control features are limited to manual PWM mode. Automatic
+"Smart Guardian" mode control handling is not implemented. However
+if you want to go for "manual mode" just write 1 to pwmN_enable.
diff --git a/Documentation/hwmon/lm63 b/Documentation/hwmon/lm63
new file mode 100644
--- /dev/null
+++ b/Documentation/hwmon/lm63
@@ -0,0 +1,57 @@
+Kernel driver lm63
+=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Supported chips:
+  * National Semiconductor LM63
+    Prefix: 'lm63'
+    Addresses scanned: I2C 0x4c
+    Datasheet: Publicly available at the National Semiconductor website
+               http://www.national.com/pf/LM/LM63.html
+
+Author: Jean Delvare <khali@linux-fr.org>
+
+Thanks go to Tyan and especially Alex Buckingham for setting up a remote
+access to their S4882 test platform for this driver.
+  http://www.tyan.com/
+
+Description
+-----------
+
+The LM63 is a digital temperature sensor with integrated fan monitoring
+and control.
+
+The LM63 is basically an LM86 with fan speed monitoring and control
+capabilities added. It misses some of the LM86 features though:
+ - No low limit for local temperature.
+ - No critical limit for local temperature.
+ - Critical limit for remote temperature can be changed only once. We
+   will consider that the critical limit is read-only.
+
+The datasheet isn't very clear about what the tachometer reading is.
+
+An explanation from National Semiconductor: The two lower bits of the read
+value have to be masked out. The value is still 16 bit in width.
+
+All temperature values are given in degrees Celsius. Resolution is 1.0
+degree for the local temperature, 0.125 degree for the remote temperature.
+
+The fan speed is measured using a tachometer. Contrary to most chips which
+store the value in an 8-bit register and have a selectable clock divider
+to make sure that the result will fit in the register, the LM63 uses 16-bit
+value for measuring the speed of the fan. It can measure fan speeds down to
+83 RPM, at least in theory.
+
+Note that the pin used for fan monitoring is shared with an alert out
+function. Depending on how the board designer wanted to use the chip, fan
+speed monitoring will or will not be possible. The proper chip configurati=
on
+is left to the BIOS, and the driver will blindly trust it.
+
+A PWM output can be used to control the speed of the fan. The LM63 has two
+PWM modes: manual and automatic. Automatic mode is not fully implemented y=
et
+(you cannot define your custom PWM/temperature curve), and mode change isn=
't
+supported either.
+
+The lm63 driver will not update its values more frequently than every
+second; reading them more often will do no harm, but will return 'old'
+values.
+
diff --git a/Documentation/hwmon/lm75 b/Documentation/hwmon/lm75
new file mode 100644
--- /dev/null
+++ b/Documentation/hwmon/lm75
@@ -0,0 +1,65 @@
+Kernel driver lm75
+=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Supported chips:
+  * National Semiconductor LM75
+    Prefix: 'lm75'
+    Addresses scanned: I2C 0x48 - 0x4f
+    Datasheet: Publicly available at the National Semiconductor website
+               http://www.national.com/
+  * Dallas Semiconductor DS75
+    Prefix: 'lm75'
+    Addresses scanned: I2C 0x48 - 0x4f
+    Datasheet: Publicly available at the Dallas Semiconductor website
+               http://www.maxim-ic.com/
+  * Dallas Semiconductor DS1775
+    Prefix: 'lm75'
+    Addresses scanned: I2C 0x48 - 0x4f
+    Datasheet: Publicly available at the Dallas Semiconductor website
+               http://www.maxim-ic.com/
+  * Maxim MAX6625, MAX6626
+    Prefix: 'lm75'
+    Addresses scanned: I2C 0x48 - 0x4b
+    Datasheet: Publicly available at the Maxim website
+               http://www.maxim-ic.com/
+  * Microchip (TelCom) TCN75
+    Prefix: 'lm75'
+    Addresses scanned: I2C 0x48 - 0x4f
+    Datasheet: Publicly available at the Microchip website
+               http://www.microchip.com/
+
+Author: Frodo Looijaard <frodol@dds.nl>
+
+Description
+-----------
+
+The LM75 implements one temperature sensor. Limits can be set through the
+Overtemperature Shutdown register and Hysteresis register. Each value can =
be
+set and read to half-degree accuracy.
+An alarm is issued (usually to a connected LM78) when the temperature
+gets higher then the Overtemperature Shutdown value; it stays on until
+the temperature falls below the Hysteresis value.
+All temperatures are in degrees Celsius, and are guaranteed within a
+range of -55 to +125 degrees.
+
+The LM75 only updates its values each 1.5 seconds; reading it more often
+will do no harm, but will return 'old' values.
+
+The LM75 is usually used in combination with LM78-like chips, to measure
+the temperature of the processor(s).
+
+The DS75, DS1775, MAX6625, and MAX6626 are supported as well.
+They are not distinguished from an LM75. While most of these chips
+have three additional bits of accuracy (12 vs. 9 for the LM75),
+the additional bits are not supported. Not only that, but these chips will
+not be detected if not in 9-bit precision mode (use the force parameter if
+needed).
+
+The TCN75 is supported as well, and is not distinguished from an LM75.
+
+The LM75 is essentially an industry standard; there may be other
+LM75 clones not listed here, with or without various enhancements,
+that are supported.
+
+The LM77 is not supported, contrary to what we pretended for a long time.
+Both chips are simply not compatible, value encoding differs.
diff --git a/Documentation/hwmon/lm77 b/Documentation/hwmon/lm77
new file mode 100644
--- /dev/null
+++ b/Documentation/hwmon/lm77
@@ -0,0 +1,22 @@
+Kernel driver lm77
+=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Supported chips:
+  * National Semiconductor LM77
+    Prefix: 'lm77'
+    Addresses scanned: I2C 0x48 - 0x4b
+    Datasheet: Publicly available at the National Semiconductor website
+               http://www.national.com/
+
+Author: Andras BALI <drewie@freemail.hu>
+
+Description
+-----------
+
+The LM77 implements one temperature sensor. The temperature
+sensor incorporates a band-gap type temperature sensor,
+10-bit ADC, and a digital comparator with user-programmable upper
+and lower limit values.
+
+Limits can be set through the Overtemperature Shutdown register and
+Hysteresis register.
diff --git a/Documentation/hwmon/lm78 b/Documentation/hwmon/lm78
new file mode 100644
--- /dev/null
+++ b/Documentation/hwmon/lm78
@@ -0,0 +1,82 @@
+Kernel driver lm78
+=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Supported chips:
+  * National Semiconductor LM78
+    Prefix: 'lm78'
+    Addresses scanned: I2C 0x20 - 0x2f, ISA 0x290 (8 I/O ports)
+    Datasheet: Publicly available at the National Semiconductor website
+               http://www.national.com/
+  * National Semiconductor LM78-J
+    Prefix: 'lm78-j'
+    Addresses scanned: I2C 0x20 - 0x2f, ISA 0x290 (8 I/O ports)
+    Datasheet: Publicly available at the National Semiconductor website
+               http://www.national.com/
+  * National Semiconductor LM79
+    Prefix: 'lm79'
+    Addresses scanned: I2C 0x20 - 0x2f, ISA 0x290 (8 I/O ports)
+    Datasheet: Publicly available at the National Semiconductor website
+               http://www.national.com/
+
+Author: Frodo Looijaard <frodol@dds.nl>
+
+Description
+-----------
+
+This driver implements support for the National Semiconductor LM78, LM78-J
+and LM79. They are described as 'Microprocessor System Hardware Monitors'.
+
+There is almost no difference between the three supported chips. Functiona=
lly,
+the LM78 and LM78-J are exactly identical. The LM79 has one more VID line,
+which is used to report the lower voltages newer Pentium processors use.
+From here on, LM7* means either of these three types.
+
+The LM7* implements one temperature sensor, three fan rotation speed senso=
rs,
+seven voltage sensors, VID lines, alarms, and some miscellaneous stuff.
+
+Temperatures are measured in degrees Celsius. An alarm is triggered once
+when the Overtemperature Shutdown limit is crossed; it is triggered again
+as soon as it drops below the Hysteresis value. A more useful behavior
+can be found by setting the Hysteresis value to +127 degrees Celsius; in
+this case, alarms are issued during all the time when the actual temperatu=
re
+is above the Overtemperature Shutdown value. Measurements are guaranteed
+between -55 and +125 degrees, with a resolution of 1 degree.
+
+Fan rotation speeds are reported in RPM (rotations per minute). An alarm is
+triggered if the rotation speed has dropped below a programmable limit. Fan
+readings can be divided by a programmable divider (1, 2, 4 or 8) to give
+the readings more range or accuracy. Not all RPM values can accurately be
+represented, so some rounding is done. With a divider of 2, the lowest
+representable value is around 2600 RPM.
+
+Voltage sensors (also known as IN sensors) report their values in volts.
+An alarm is triggered if the voltage has crossed a programmable minimum
+or maximum limit. Note that minimum in this case always means 'closest to
+zero'; this is important for negative voltage measurements. All voltage
+inputs can measure voltages between 0 and 4.08 volts, with a resolution
+of 0.016 volt.
+
+The VID lines encode the core voltage value: the voltage level your proces=
sor
+should work with. This is hardcoded by the mainboard and/or processor itse=
lf.
+It is a value in volts. When it is unconnected, you will often find the
+value 3.50 V here.
+
+In addition to the alarms described above, there are a couple of additional
+ones. There is a BTI alarm, which gets triggered when an external chip has
+crossed its limits. Usually, this is connected to all LM75 chips; if at
+least one crosses its limits, this bit gets set. The CHAS alarm triggers
+if your computer case is open. The FIFO alarms should never trigger; it
+indicates an internal error. The SMI_IN alarm indicates some other chip
+has triggered an SMI interrupt. As we do not use SMI interrupts at all,
+this condition usually indicates there is a problem with some other
+device.
+
+If an alarm triggers, it will remain triggered until the hardware register
+is read at least once. This means that the cause for the alarm may
+already have disappeared! Note that in the current implementation, all
+hardware registers are read whenever any data is read (unless it is less
+than 1.5 seconds since the last update). This means that you can easily
+miss once-only alarms.
+
+The LM7* only updates its values each 1.5 seconds; reading it more often
+will do no harm, but will return 'old' values.
diff --git a/Documentation/hwmon/lm80 b/Documentation/hwmon/lm80
new file mode 100644
--- /dev/null
+++ b/Documentation/hwmon/lm80
@@ -0,0 +1,56 @@
+Kernel driver lm80
+=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Supported chips:
+  * National Semiconductor LM80
+    Prefix: 'lm80'
+    Addresses scanned: I2C 0x28 - 0x2f
+    Datasheet: Publicly available at the National Semiconductor website
+               http://www.national.com/
+
+Authors:
+        Frodo Looijaard <frodol@dds.nl>,
+        Philip Edelbrock <phil@netroedge.com>
+
+Description
+-----------
+
+This driver implements support for the National Semiconductor LM80.
+It is described as a 'Serial Interface ACPI-Compatible Microprocessor
+System Hardware Monitor'.
+
+The LM80 implements one temperature sensor, two fan rotation speed sensors,
+seven voltage sensors, alarms, and some miscellaneous stuff.
+
+Temperatures are measured in degrees Celsius. There are two sets of limits
+which operate independently. When the HOT Temperature Limit is crossed,
+this will cause an alarm that will be reasserted until the temperature
+drops below the HOT Hysteresis. The Overtemperature Shutdown (OS) limits
+should work in the same way (but this must be checked; the datasheet
+is unclear about this). Measurements are guaranteed between -55 and
++125 degrees. The current temperature measurement has a resolution of
+0.0625 degrees; the limits have a resolution of 1 degree.
+
+Fan rotation speeds are reported in RPM (rotations per minute). An alarm is
+triggered if the rotation speed has dropped below a programmable limit. Fan
+readings can be divided by a programmable divider (1, 2, 4 or 8) to give
+the readings more range or accuracy. Not all RPM values can accurately be
+represented, so some rounding is done. With a divider of 2, the lowest
+representable value is around 2600 RPM.
+
+Voltage sensors (also known as IN sensors) report their values in volts.
+An alarm is triggered if the voltage has crossed a programmable minimum
+or maximum limit. Note that minimum in this case always means 'closest to
+zero'; this is important for negative voltage measurements. All voltage
+inputs can measure voltages between 0 and 2.55 volts, with a resolution
+of 0.01 volt.
+
+If an alarm triggers, it will remain triggered until the hardware register
+is read at least once. This means that the cause for the alarm may
+already have disappeared! Note that in the current implementation, all
+hardware registers are read whenever any data is read (unless it is less
+than 2.0 seconds since the last update). This means that you can easily
+miss once-only alarms.
+
+The LM80 only updates its values each 1.5 seconds; reading it more often
+will do no harm, but will return 'old' values.
diff --git a/Documentation/hwmon/lm83 b/Documentation/hwmon/lm83
new file mode 100644
--- /dev/null
+++ b/Documentation/hwmon/lm83
@@ -0,0 +1,76 @@
+Kernel driver lm83
+=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Supported chips:
+  * National Semiconductor LM83
+    Prefix: 'lm83'
+    Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e
+    Datasheet: Publicly available at the National Semiconductor website
+               http://www.national.com/pf/LM/LM83.html
+
+
+Author: Jean Delvare <khali@linux-fr.org>
+
+Description
+-----------
+
+The LM83 is a digital temperature sensor. It senses its own temperature as
+well as the temperature of up to three external diodes. It is compatible
+with many other devices such as the LM84 and all other ADM1021 clones.
+The main difference between the LM83 and the LM84 in that the later can
+only sense the temperature of one external diode.
+
+Using the adm1021 driver for a LM83 should work, but only two temperatures
+will be reported instead of four.
+
+The LM83 is only found on a handful of motherboards. Both a confirmed
+list and an unconfirmed list follow. If you can confirm or infirm the
+fact that any of these motherboards do actually have an LM83, please
+contact us. Note that the LM90 can easily be misdetected as a LM83.
+
+Confirmed motherboards:
+    SBS         P014
+
+Unconfirmed motherboards:
+    Gigabyte    GA-8IK1100
+    Iwill       MPX2
+    Soltek      SL-75DRV5
+
+The driver has been successfully tested by Magnus Forsstr?m, who I'd
+like to thank here. More testers will be of course welcome.
+
+The fact that the LM83 is only scarcely used can be easily explained.
+Most motherboards come with more than just temperature sensors for
+health monitoring. They also have voltage and fan rotation speed
+sensors. This means that temperature-only chips are usually used as
+secondary chips coupled with another chip such as an IT8705F or similar
+chip, which provides more features. Since systems usually need three
+temperature sensors (motherboard, processor, power supply) and primary
+chips provide some temperature sensors, the secondary chip, if needed,
+won't have to handle more than two temperatures. Thus, ADM1021 clones
+are sufficient, and there is no need for a four temperatures sensor
+chip such as the LM83. The only case where using an LM83 would make
+sense is on SMP systems, such as the above-mentioned Iwill MPX2,
+because you want an additional temperature sensor for each additional
+CPU.
+
+On the SBS P014, this is different, since the LM83 is the only hardware
+monitoring chipset. One temperature sensor is used for the motherboard
+(actually measuring the LM83's own temperature), one is used for the
+CPU. The two other sensors must be used to measure the temperature of
+two other points of the motherboard. We suspect these points to be the
+north and south bridges, but this couldn't be confirmed.
+
+All temperature values are given in degrees Celsius. Local temperature
+is given within a range of 0 to +85 degrees. Remote temperatures are
+given within a range of 0 to +125 degrees. Resolution is 1.0 degree,
+accuracy is guaranteed to 3.0 degrees (see the datasheet for more
+details).
+
+Each sensor has its own high limit, but the critical limit is common to
+all four sensors. There is no hysteresis mechanism as found on most
+recent temperature sensors.
+
+The lm83 driver will not update its values more frequently than every
+other second; reading them more often will do no harm, but will return
+'old' values.
diff --git a/Documentation/hwmon/lm85 b/Documentation/hwmon/lm85
new file mode 100644
--- /dev/null
+++ b/Documentation/hwmon/lm85
@@ -0,0 +1,221 @@
+Kernel driver lm85
+=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Supported chips:
+  * National Semiconductor LM85 (B and C versions)
+    Prefix: 'lm85'
+    Addresses scanned: I2C 0x2c, 0x2d, 0x2e
+    Datasheet: http://www.national.com/pf/LM/LM85.html
+  * Analog Devices ADM1027
+    Prefix: 'adm1027'
+    Addresses scanned: I2C 0x2c, 0x2d, 0x2e
+    Datasheet: http://www.analog.com/en/prod/0,,766_825_ADM1027,00.html
+  * Analog Devices ADT7463
+    Prefix: 'adt7463'
+    Addresses scanned: I2C 0x2c, 0x2d, 0x2e
+    Datasheet: http://www.analog.com/en/prod/0,,766_825_ADT7463,00.html
+  * SMSC EMC6D100, SMSC EMC6D101
+    Prefix: 'emc6d100'
+    Addresses scanned: I2C 0x2c, 0x2d, 0x2e
+    Datasheet: http://www.smsc.com/main/tools/discontinued/6d100.pdf
+  * SMSC EMC6D102
+    Prefix: 'emc6d102'
+    Addresses scanned: I2C 0x2c, 0x2d, 0x2e
+    Datasheet: http://www.smsc.com/main/catalog/emc6d102.html
+
+Authors:
+        Philip Pokorny <ppokorny@penguincomputing.com>,
+        Frodo Looijaard <frodol@dds.nl>,
+        Richard Barrington <rich_b_nz@clear.net.nz>,
+        Margit Schubert-While <margitsw@t-online.de>,
+        Justin Thiessen <jthiessen@penguincomputing.com>
+
+Description
+-----------
+
+This driver implements support for the National Semiconductor LM85 and
+compatible chips including the Analog Devices ADM1027, ADT7463 and
+SMSC EMC6D10x chips family.
+
+The LM85 uses the 2-wire interface compatible with the SMBUS 2.0
+specification. Using an analog to digital converter it measures three (3)
+temperatures and five (5) voltages. It has four (4) 16-bit counters for
+measuring fan speed. Five (5) digital inputs are provided for sampling the
+VID signals from the processor to the VRM. Lastly, there are three (3) PWM
+outputs that can be used to control fan speed.
+
+The voltage inputs have internal scaling resistors so that the following
+voltage can be measured without external resistors:
+
+  2.5V, 3.3V, 5V, 12V, and CPU core voltage (2.25V)
+
+The temperatures measured are one internal diode, and two remote diodes.
+Remote 1 is generally the CPU temperature. These inputs are designed to
+measure a thermal diode like the one in a Pentium 4 processor in a socket
+423 or socket 478 package. They can also measure temperature using a
+transistor like the 2N3904.
+
+A sophisticated control system for the PWM outputs is designed into the
+LM85 that allows fan speed to be adjusted automatically based on any of the
+three temperature sensors. Each PWM output is individually adjustable and
+programmable. Once configured, the LM85 will adjust the PWM outputs in
+response to the measured temperatures without further host intervention.
+This feature can also be disabled for manual control of the PWM's.
+
+Each of the measured inputs (voltage, temperature, fan speed) has
+corresponding high/low limit values. The LM85 will signal an ALARM if any
+measured value exceeds either limit.
+
+The LM85 samples all inputs continuously. The lm85 driver will not read
+the registers more often than once a second. Further, configuration data is
+only read once each 5 minutes. There is twice as much config data as
+measurements, so this would seem to be a worthwhile optimization.
+
+Special Features
+----------------
+
+The LM85 has four fan speed monitoring modes. The ADM1027 has only two.
+Both have special circuitry to compensate for PWM interactions with the
+TACH signal from the fans. The ADM1027 can be configured to measure the
+speed of a two wire fan, but the input conditioning circuitry is different
+for 3-wire and 2-wire mode. For this reason, the 2-wire fan modes are not
+exposed to user control. The BIOS should initialize them to the correct
+mode. If you've designed your own ADM1027, you'll have to modify the
+init_client function and add an insmod parameter to set this up.
+
+To smooth the response of fans to changes in temperature, the LM85 has an
+optional filter for smoothing temperatures. The ADM1027 has the same
+config option but uses it to rate limit the changes to fan speed instead.
+
+The ADM1027 and ADT7463 have a 10-bit ADC and can therefore measure
+temperatures with 0.25 degC resolution. They also provide an offset to the
+temperature readings that is automatically applied during measurement.
+This offset can be used to zero out any errors due to traces and placement.
+The documentation says that the offset is in 0.25 degC steps, but in
+initial testing of the ADM1027 it was 1.00 degC steps. Analog Devices has
+confirmed this "bug". The ADT7463 is reported to work as described in the
+documentation. The current lm85 driver does not show the offset register.
+
+The ADT7463 has a THERM asserted counter. This counter has a 22.76ms
+resolution and a range of 5.8 seconds. The driver implements a 32-bit
+accumulator of the counter value to extend the range to over a year. The
+counter will stay at it's max value until read.
+
+See the vendor datasheets for more information. There is application note
+from National (AN-1260) with some additional information about the LM85.
+The Analog Devices datasheet is very detailed and describes a procedure for
+determining an optimal configuration for the automatic PWM control.
+
+The SMSC EMC6D100 & EMC6D101 monitor external voltages, temperatures, and
+fan speeds. They use this monitoring capability to alert the system to out
+of limit conditions and can automatically control the speeds of multiple
+fans in a PC or embedded system. The EMC6D101, available in a 24-pin SSOP
+package, and the EMC6D100, available in a 28-pin SSOP package, are designed
+to be register compatible. The EMC6D100 offers all the features of the
+EMC6D101 plus additional voltage monitoring and system control features.
+Unfortunately it is not possible to distinguish between the package
+versions on register level so these additional voltage inputs may read
+zero. The EMC6D102 features addtional ADC bits thus extending precision
+of voltage and temperature channels.
+
+
+Hardware Configurations
+-----------------------
+
+The LM85 can be jumpered for 3 different SMBus addresses. There are
+no other hardware configuration options for the LM85.
+
+The lm85 driver detects both LM85B and LM85C revisions of the chip. See the
+datasheet for a complete description of the differences. Other than
+identifying the chip, the driver behaves no differently with regard to
+these two chips. The LM85B is recommended for new designs.
+
+The ADM1027 and ADT7463 chips have an optional SMBALERT output that can be
+used to signal the chipset in case a limit is exceeded or the temperature
+sensors fail. Individual sensor interrupts can be masked so they won't
+trigger SMBALERT. The SMBALERT output if configured replaces one of the ot=
her
+functions (PWM2 or IN0). This functionality is not implemented in current
+driver.
+
+The ADT7463 also has an optional THERM output/input which can be connected
+to the processor PROC_HOT output. If available, the autofan control
+dynamic Tmin feature can be enabled to keep the system temperature within
+spec (just?!) with the least possible fan noise.
+
+Configuration Notes
+-------------------
+
+Besides standard interfaces driver adds following:
+
+* Temperatures and Zones
+
+Each temperature sensor is associated with a Zone. There are three
+sensors and therefore three zones (# 1, 2 and 3). Each zone has the follow=
ing
+temperature configuration points:
+
+* temp#_auto_temp_off - temperature below which fans should be off or spin=
ning very low.
+* temp#_auto_temp_min - temperature over which fans start to spin.
+* temp#_auto_temp_max - temperature when fans spin at full speed.
+* temp#_auto_temp_crit - temperature when all fans will run full speed.
+
+* PWM Control
+
+There are three PWM outputs. The LM85 datasheet suggests that the
+pwm3 output control both fan3 and fan4. Each PWM can be individually
+configured and assigned to a zone for it's control value. Each PWM can be
+configured individually according to the following options.
+
+* pwm#_auto_pwm_min - this specifies the PWM value for temp#_auto_temp_off
+                      temperature. (PWM value from 0 to 255)
+
+* pwm#_auto_pwm_freq - select base frequency of PWM output. You can select
+                       in range of 10.0 to 94.0 Hz in .1 Hz units.
+		       (Values 100 to 940).
+
+The pwm#_auto_pwm_freq can be set to one of the following 8 values. Settin=
g the
+frequency to a value not on this list, will result in the next higher freq=
uency
+being selected. The actual device frequency may vary slightly from this
+specification as designed by the manufacturer. Consult the datasheet for m=
ore
+details. (PWM Frequency values:  100, 150, 230, 300, 380, 470, 620, 940)
+
+* pwm#_auto_pwm_minctl - this flags selects for temp#_auto_temp_off temper=
ature
+                         the bahaviour of fans. Write 1 to let fans spinni=
ng at
+			 pwm#_auto_pwm_min or write 0 to let them off.
+
+NOTE: It has been reported that there is a bug in the LM85 that causes the=
 flag
+to be associated with the zones not the PWMs. This contradicts all the
+published documentation. Setting pwm#_min_ctl in this case actually affect=
s all
+PWMs controlled by zone '#'.
+
+* PWM Controlling Zone selection
+
+* pwm#_auto_channels - controls zone that is associated with PWM
+
+Configuration choices:
+
+   Value     Meaning
+  ------  ------------------------------------------------
+      1    Controlled by Zone 1
+      2    Controlled by Zone 2
+      3    Controlled by Zone 3
+     23    Controlled by higher temp of Zone 2 or 3
+    123    Controlled by highest temp of Zone 1, 2 or 3
+      0    PWM always 0%  (off)
+     -1    PWM always 100%  (full on)
+     -2    Manual control (write to 'pwm#' to set)
+
+The National LM85's have two vendor specific configuration
+features. Tach. mode and Spinup Control. For more details on these,
+see the LM85 datasheet or Application Note AN-1260.
+
+The Analog Devices ADM1027 has several vendor specific enhancements.
+The number of pulses-per-rev of the fans can be set, Tach monitoring
+can be optimized for PWM operation, and an offset can be applied to
+the temperatures to compensate for systemic errors in the
+measurements.
+
+In addition to the ADM1027 features, the ADT7463 also has Tmin control
+and THERM asserted counts. Automatic Tmin control acts to adjust the
+Tmin value to maintain the measured temperature sensor at a specified
+temperature. There isn't much documentation on this feature in the
+ADT7463 data sheet. This is not supported by current driver.
diff --git a/Documentation/hwmon/lm87 b/Documentation/hwmon/lm87
new file mode 100644
--- /dev/null
+++ b/Documentation/hwmon/lm87
@@ -0,0 +1,73 @@
+Kernel driver lm87
+=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Supported chips:
+  * National Semiconductor LM87
+    Prefix: 'lm87'
+    Addresses scanned: I2C 0x2c - 0x2f
+    Datasheet: http://www.national.com/pf/LM/LM87.html
+
+Authors:
+        Frodo Looijaard <frodol@dds.nl>,
+        Philip Edelbrock <phil@netroedge.com>,
+        Mark Studebaker <mdsxyz123@yahoo.com>,
+        Stephen Rousset <stephen.rousset@rocketlogix.com>,
+        Dan Eaton <dan.eaton@rocketlogix.com>,
+        Jean Delvare <khali@linux-fr.org>,
+        Original 2.6 port Jeff Oliver
+
+Description
+-----------
+
+This driver implements support for the National Semiconductor LM87.
+
+The LM87 implements up to three temperature sensors, up to two fan
+rotation speed sensors, up to seven voltage sensors, alarms, and some
+miscellaneous stuff.
+
+Temperatures are measured in degrees Celsius. Each input has a high
+and low alarm settings. A high limit produces an alarm when the value
+goes above it, and an alarm is also produced when the value goes below
+the low limit.
+
+Fan rotation speeds are reported in RPM (rotations per minute). An alarm is
+triggered if the rotation speed has dropped below a programmable limit. Fan
+readings can be divided by a programmable divider (1, 2, 4 or 8) to give
+the readings more range or accuracy. Not all RPM values can accurately be
+represented, so some rounding is done. With a divider of 2, the lowest
+representable value is around 2600 RPM.
+
+Voltage sensors (also known as IN sensors) report their values in
+volts. An alarm is triggered if the voltage has crossed a programmable
+minimum or maximum limit. Note that minimum in this case always means
+'closest to zero'; this is important for negative voltage measurements.
+
+If an alarm triggers, it will remain triggered until the hardware register
+is read at least once. This means that the cause for the alarm may
+already have disappeared! Note that in the current implementation, all
+hardware registers are read whenever any data is read (unless it is less
+than 1.0 seconds since the last update). This means that you can easily
+miss once-only alarms.
+
+The lm87 driver only updates its values each 1.0 seconds; reading it more
+often will do no harm, but will return 'old' values.
+
+
+Hardware Configurations
+-----------------------
+
+The LM87 has four pins which can serve one of two possible functions,
+depending on the hardware configuration.
+
+Some functions share pins, so not all functions are available at the same
+time. Which are depends on the hardware setup. This driver assumes that
+the BIOS configured the chip correctly. In that respect, it differs from
+the original driver (from lm_sensors for Linux 2.4), which would force the
+LM87 to an arbitrary, compile-time chosen mode, regardless of the actual
+chipset wiring.
+
+For reference, here is the list of exclusive functions:
+ - in0+in5 (default) or temp3
+ - fan1 (default) or in6
+ - fan2 (default) or in7
+ - VID lines (default) or IRQ lines (not handled by this driver)
diff --git a/Documentation/hwmon/lm90 b/Documentation/hwmon/lm90
new file mode 100644
--- /dev/null
+++ b/Documentation/hwmon/lm90
@@ -0,0 +1,121 @@
+Kernel driver lm90
+=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Supported chips:
+  * National Semiconductor LM90
+    Prefix: 'lm90'
+    Addresses scanned: I2C 0x4c
+    Datasheet: Publicly available at the National Semiconductor website
+               http://www.national.com/pf/LM/LM90.html
+  * National Semiconductor LM89
+    Prefix: 'lm99'
+    Addresses scanned: I2C 0x4c and 0x4d
+    Datasheet: Publicly available at the National Semiconductor website
+               http://www.national.com/pf/LM/LM89.html
+  * National Semiconductor LM99
+    Prefix: 'lm99'
+    Addresses scanned: I2C 0x4c and 0x4d
+    Datasheet: Publicly available at the National Semiconductor website
+               http://www.national.com/pf/LM/LM99.html
+  * National Semiconductor LM86
+    Prefix: 'lm86'
+    Addresses scanned: I2C 0x4c
+    Datasheet: Publicly available at the National Semiconductor website
+               http://www.national.com/pf/LM/LM86.html
+  * Analog Devices ADM1032
+    Prefix: 'adm1032'
+    Addresses scanned: I2C 0x4c
+    Datasheet: Publicly available at the Analog Devices website
+               http://products.analog.com/products/info.asp?product=ADM1032
+  * Analog Devices ADT7461
+    Prefix: 'adt7461'
+    Addresses scanned: I2C 0x4c
+    Datasheet: Publicly available at the Analog Devices website
+               http://products.analog.com/products/info.asp?product=ADT7461
+    Note: Only if in ADM1032 compatibility mode
+  * Maxim MAX6657
+    Prefix: 'max6657'
+    Addresses scanned: I2C 0x4c
+    Datasheet: Publicly available at the Maxim website
+               http://www.maxim-ic.com/quick_view2.cfm/qv_pk/2578
+  * Maxim MAX6658
+    Prefix: 'max6657'
+    Addresses scanned: I2C 0x4c
+    Datasheet: Publicly available at the Maxim website
+               http://www.maxim-ic.com/quick_view2.cfm/qv_pk/2578
+  * Maxim MAX6659
+    Prefix: 'max6657'
+    Addresses scanned: I2C 0x4c, 0x4d (unsupported 0x4e)
+    Datasheet: Publicly available at the Maxim website
+               http://www.maxim-ic.com/quick_view2.cfm/qv_pk/2578
+
+
+Author: Jean Delvare <khali@linux-fr.org>
+
+
+Description
+-----------
+
+The LM90 is a digital temperature sensor. It senses its own temperature as
+well as the temperature of up to one external diode. It is compatible
+with many other devices such as the LM86, the LM89, the LM99, the ADM1032,
+the MAX6657, MAX6658 and the MAX6659 all of which are supported by this dr=
iver.
+Note that there is no easy way to differentiate between the last three
+variants. The extra address and features of the MAX6659 are not supported =
by
+this driver. Additionally, the ADT7461 is supported if found in ADM1032
+compatibility mode.
+
+The specificity of this family of chipsets over the ADM1021/LM84
+family is that it features critical limits with hysteresis, and an
+increased resolution of the remote temperature measurement.
+
+The different chipsets of the family are not strictly identical, although
+very similar. This driver doesn't handle any specific feature for now,
+but could if there ever was a need for it. For reference, here comes a
+non-exhaustive list of specific features:
+
+LM90:
+  * Filter and alert configuration register at 0xBF.
+  * ALERT is triggered by temperatures over critical limits.
+
+LM86 and LM89:
+  * Same as LM90
+  * Better external channel accuracy
+
+LM99:
+  * Same as LM89
+  * External temperature shifted by 16 degrees down
+
+ADM1032:
+  * Consecutive alert register at 0x22.
+  * Conversion averaging.
+  * Up to 64 conversions/s.
+  * ALERT is triggered by open remote sensor.
+
+ADT7461
+  * Extended temperature range (breaks compatibility)
+  * Lower resolution for remote temperature
+
+MAX6657 and MAX6658:
+  * Remote sensor type selection
+
+MAX6659
+  * Selectable address
+  * Second critical temperature limit
+  * Remote sensor type selection
+
+All temperature values are given in degrees Celsius. Resolution
+is 1.0 degree for the local temperature, 0.125 degree for the remote
+temperature.
+
+Each sensor has its own high and low limits, plus a critical limit.
+Additionally, there is a relative hysteresis value common to both critical
+values. To make life easier to user-space applications, two absolute values
+are exported, one for each channel, but these values are of course linked.
+Only the local hysteresis can be set from user-space, and the same delta
+applies to the remote hysteresis.
+
+The lm90 driver will not update its values more frequently than every
+other second; reading them more often will do no harm, but will return
+'old' values.
+
diff --git a/Documentation/hwmon/lm92 b/Documentation/hwmon/lm92
new file mode 100644
--- /dev/null
+++ b/Documentation/hwmon/lm92
@@ -0,0 +1,37 @@
+Kernel driver lm92
+=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Supported chips:
+  * National Semiconductor LM92
+    Prefix: 'lm92'
+    Addresses scanned: I2C 0x48 - 0x4b
+    Datasheet: http://www.national.com/pf/LM/LM92.html
+  * National Semiconductor LM76
+    Prefix: 'lm92'
+    Addresses scanned: none, force parameter needed
+    Datasheet: http://www.national.com/pf/LM/LM76.html
+  * Maxim MAX6633/MAX6634/MAX6635
+    Prefix: 'lm92'
+    Addresses scanned: I2C 0x48 - 0x4b
+    MAX6633 with address in 0x40 - 0x47, 0x4c - 0x4f needs force parameter
+    and MAX6634 with address in 0x4c - 0x4f needs force parameter
+    Datasheet: http://www.maxim-ic.com/quick_view2.cfm/qv_pk/3074
+
+Authors:
+        Abraham van der Merwe <abraham@2d3d.co.za>
+        Jean Delvare <khali@linux-fr.org>
+
+
+Description
+-----------
+
+This driver implements support for the National Semiconductor LM92
+temperature sensor.
+
+Each LM92 temperature sensor supports a single temperature sensor. There a=
re
+alarms for high, low, and critical thresholds. There's also an hysteresis =
to
+control the thresholds for resetting alarms.
+
+Support was added later for the LM76 and Maxim MAX6633/MAX6634/MAX6635,
+which are mostly compatible. They have not all been tested, so you
+may need to use the force parameter.
diff --git a/Documentation/hwmon/max1619 b/Documentation/hwmon/max1619
new file mode 100644
--- /dev/null
+++ b/Documentation/hwmon/max1619
@@ -0,0 +1,29 @@
+Kernel driver max1619
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
+Supported chips:
+  * Maxim MAX1619
+    Prefix: 'max1619'
+    Addresses scanned: I2C 0x18-0x1a, 0x29-0x2b, 0x4c-0x4e
+    Datasheet: Publicly available at the Maxim website
+               http://pdfserv.maxim-ic.com/en/ds/MAX1619.pdf
+
+Authors:
+        Alexey Fisher <fishor@mail.ru>,
+        Jean Delvare <khali@linux-fr.org>
+
+Description
+-----------
+
+The MAX1619 is a digital temperature sensor. It senses its own temperature=
 as
+well as the temperature of up to one external diode.
+
+All temperature values are given in degrees Celsius. Resolution
+is 1.0 degree for the local temperature and for the remote temperature.
+
+Only the external sensor has high and low limits.
+
+The max1619 driver will not update its values more frequently than every
+other second; reading them more often will do no harm, but will return
+'old' values.
+
diff --git a/Documentation/hwmon/pc87360 b/Documentation/hwmon/pc87360
new file mode 100644
--- /dev/null
+++ b/Documentation/hwmon/pc87360
@@ -0,0 +1,189 @@
+Kernel driver pc87360
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
+Supported chips:
+  * National Semiconductor PC87360, PC87363, PC87364, PC87365 and PC87366
+    Prefixes: 'pc87360', 'pc87363', 'pc87364', 'pc87365', 'pc87366'
+    Addresses scanned: none, address read from Super I/O config space
+    Datasheets:
+        http://www.national.com/pf/PC/PC87360.html
+        http://www.national.com/pf/PC/PC87363.html
+        http://www.national.com/pf/PC/PC87364.html
+        http://www.national.com/pf/PC/PC87365.html
+        http://www.national.com/pf/PC/PC87366.html
+
+Authors: Jean Delvare <khali@linux-fr.org>
+
+Thanks to Sandeep Mehta, Tonko de Rooy and Daniel Ceregatti for testing.
+Thanks to Rudolf Marek for helping me investigate conversion issues.
+
+
+Module Parameters
+-----------------
+
+* init int
+  Chip initialization level:
+   0: None
+  *1: Forcibly enable internal voltage and temperature channels, except in9
+   2: Forcibly enable all voltage and temperature channels, except in9
+   3: Forcibly enable all voltage and temperature channels, including in9
+
+Note that this parameter has no effect for the PC87360, PC87363 and PC87364
+chips.
+
+Also note that for the PC87366, initialization levels 2 and 3 don't enable
+all temperature channels, because some of them share pins with each other,
+so they can't be used at the same time.
+
+
+Description
+-----------
+
+The National Semiconductor PC87360 Super I/O chip contains monitoring and
+PWM control circuitry for two fans. The PC87363 chip is similar, and the
+PC87364 chip has monitoring and PWM control for a third fan.
+
+The National Semiconductor PC87365 and PC87366 Super I/O chips are complete
+hardware monitoring chipsets, not only controlling and monitoring three fa=
ns,
+but also monitoring eleven voltage inputs and two (PC87365) or up to four
+(PC87366) temperatures.
+
+  Chip        #vin    #fan    #pwm    #temp   devid
+
+  PC87360     -       2       2       -       0xE1
+  PC87363     -       2       2       -       0xE8
+  PC87364     -       3       3       -       0xE4
+  PC87365     11      3       3       2       0xE5
+  PC87366     11      3       3       3-4     0xE9
+
+The driver assumes that no more than one chip is present, and one of the
+standard Super I/O addresses is used (0x2E/0x2F or 0x4E/0x4F)
+
+Fan Monitoring
+--------------
+
+Fan rotation speeds are reported in RPM (revolutions per minute). An alarm
+is triggered if the rotation speed has dropped below a programmable limit.
+A different alarm is triggered if the fan speed is too low to be measured.
+
+Fan readings are affected by a programmable clock divider, giving the
+readings more range or accuracy. Usually, users have to learn how it works,
+but this driver implements dynamic clock divider selection, so you don't
+have to care no more.
+
+For reference, here are a few values about clock dividers:
+
+                slowest         accuracy        highest
+                measurable      around 3000     accurate
+    divider     speed (RPM)     RPM (RPM)       speed (RPM)
+         1        1882              18           6928
+         2         941              37           4898
+         4         470              74           3464
+         8         235             150           2449
+
+For the curious, here is how the values above were computed:
+ * slowest measurable speed: clock/(255*divider)
+ * accuracy around 3000 RPM: 3000^2/clock
+ * highest accurate speed: sqrt(clock*100)
+The clock speed for the PC87360 family is 480 kHz. I arbitrarily chose 100
+RPM as the lowest acceptable accuracy.
+
+As mentioned above, you don't have to care about this no more.
+
+Note that not all RPM values can be represented, even when the best clock
+divider is selected. This is not only true for the measured speeds, but
+also for the programmable low limits, so don't be surprised if you try to
+set, say, fan1_min to 2900 and it finally reads 2909.
+
+
+Fan Control
+-----------
+
+PWM (pulse width modulation) values range from 0 to 255, with 0 meaning
+that the fan is stopped, and 255 meaning that the fan goes at full speed.
+
+Be extremely careful when changing PWM values. Low PWM values, even
+non-zero, can stop the fan, which may cause irreversible damage to your
+hardware if temperature increases too much. When changing PWM values, go
+step by step and keep an eye on temperatures.
+
+One user reported problems with PWM. Changing PWM values would break fan
+speed readings. No explanation nor fix could be found.
+
+
+Temperature Monitoring
+----------------------
+
+Temperatures are reported in degrees Celsius. Each temperature measured has
+associated low, high and overtemperature limits, each of which triggers an
+alarm when crossed.
+
+The first two temperature channels are external. The third one (PC87366
+only) is internal.
+
+The PC87366 has three additional temperature channels, based on
+thermistors (as opposed to thermal diodes for the first three temperature
+channels). For technical reasons, these channels are held by the VLM
+(voltage level monitor) logical device, not the TMS (temperature
+measurement) one. As a consequence, these temperatures are exported as
+voltages, and converted into temperatures in user-space.
+
+Note that these three additional channels share their pins with the
+external thermal diode channels, so you (physically) can't use them all at
+the same time. Although it should be possible to mix the two sensor types,
+the documents from National Semiconductor suggest that motherboard
+manufacturers should choose one type and stick to it. So you will more
+likely have either channels 1 to 3 (thermal diodes) or 3 to 6 (internal
+thermal diode, and thermistors).
+
+
+Voltage Monitoring
+------------------
+
+Voltages are reported relatively to a reference voltage, either internal or
+external. Some of them (in7:Vsb, in8:Vdd and in10:AVdd) are divided by two
+internally, you will have to compensate in sensors.conf. Others (in0 to in=
6)
+are likely to be divided externally. The meaning of each of these inputs as
+well as the values of the resistors used for division is left to the
+motherboard manufacturers, so you will have to document yourself and edit
+sensors.conf accordingly. National Semiconductor has a document with
+recommended resistor values for some voltages, but this still leaves much
+room for per motherboard specificities, unfortunately. Even worse,
+motherboard manufacturers don't seem to care about National Semiconductor's
+recommendations.
+
+Each voltage measured has associated low and high limits, each of which
+triggers an alarm when crossed.
+
+When available, VID inputs are used to provide the nominal CPU Core voltag=
e.
+The driver will default to VRM 9.0, but this can be changed from user-spac=
e.
+The chipsets can handle two sets of VID inputs (on dual-CPU systems), but
+the driver will only export one for now. This may change later if there is
+a need.
+
+
+General Remarks
+---------------
+
+If an alarm triggers, it will remain triggered until the hardware register
+is read at least once. This means that the cause for the alarm may already
+have disappeared! Note that all hardware registers are read whenever any
+data is read (unless it is less than 2 seconds since the last update, in
+which case cached values are returned instead). As a consequence, when
+a once-only alarm triggers, it may take 2 seconds for it to show, and 2
+more seconds for it to disappear.
+
+Monitoring of in9 isn't enabled at lower init levels (<3) because that
+channel measures the battery voltage (Vbat). It is a known fact that
+repeatedly sampling the battery voltage reduces its lifetime. National
+Semiconductor smartly designed their chipset so that in9 is sampled only
+once every 1024 sampling cycles (that is every 34 minutes at the default
+sampling rate), so the effect is attenuated, but still present.
+
+
+Limitations
+-----------
+
+The datasheets suggests that some values (fan mins, fan dividers)
+shouldn't be changed once the monitoring has started, but we ignore that
+recommendation. We'll reconsider if it actually causes trouble.
diff --git a/Documentation/hwmon/sis5595 b/Documentation/hwmon/sis5595
new file mode 100644
--- /dev/null
+++ b/Documentation/hwmon/sis5595
@@ -0,0 +1,106 @@
+Kernel driver sis5595
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
+Supported chips:
+  * Silicon Integrated Systems Corp. SiS5595 Southbridge Hardware Monitor
+    Prefix: 'sis5595'
+    Addresses scanned: ISA in PCI-space encoded address
+    Datasheet: Publicly available at the Silicon Integrated Systems Corp. =
site.
+
+Authors:
+        Ky?sti M?lkki <kmalkki@cc.hut.fi>,
+        Mark D. Studebaker <mdsxyz123@yahoo.com>,
+        Aurelien Jarno <aurelien@aurel32.net> 2.6 port
+
+   SiS southbridge has a LM78-like chip integrated on the same IC.
+   This driver is a customized copy of lm78.c
+
+   Supports following revisions:
+       Version         PCI ID          PCI Revision
+       1               1039/0008       AF or less
+       2               1039/0008       B0 or greater
+
+   Note: these chips contain a 0008 device which is incompatible with the
+        5595. We recognize these by the presence of the listed
+        "blacklist" PCI ID and refuse to load.
+
+   NOT SUPPORTED       PCI ID          BLACKLIST PCI ID
+        540            0008            0540
+        550            0008            0550
+       5513            0008            5511
+       5581            0008            5597
+       5582            0008            5597
+       5597            0008            5597
+        630            0008            0630
+        645            0008            0645
+        730            0008            0730
+        735            0008            0735
+
+
+Module Parameters
+-----------------
+force_addr=3D0xaddr	Set the I/O base address. Useful for boards
+			that don't set the address in the BIOS. Does not do a
+			PCI force; the device must still be present in lspci.
+			Don't use this unless the driver complains that the
+			base address is not set.
+			Example: 'modprobe sis5595 force_addr=3D0x290'
+
+
+Description
+-----------
+
+The SiS5595 southbridge has integrated hardware monitor functions. It also
+has an I2C bus, but this driver only supports the hardware monitor. For the
+I2C bus driver see i2c-sis5595.
+
+The SiS5595 implements zero or one temperature sensor, two fan speed
+sensors, four or five voltage sensors, and alarms.
+
+On the first version of the chip, there are four voltage sensors and one
+temperature sensor.
+
+On the second version of the chip, the temperature sensor (temp) and the
+fifth voltage sensor (in4) share a pin which is configurable, but not
+through the driver. Sorry. The driver senses the configuration of the pin,
+which was hopefully set by the BIOS.
+
+Temperatures are measured in degrees Celsius. An alarm is triggered once
+when the max is crossed; it is also triggered when it drops below the min
+value. Measurements are guaranteed between -55 and +125 degrees, with a
+resolution of 1 degree.
+
+Fan rotation speeds are reported in RPM (rotations per minute). An alarm is
+triggered if the rotation speed has dropped below a programmable limit. Fan
+readings can be divided by a programmable divider (1, 2, 4 or 8) to give
+the readings more range or accuracy. Not all RPM values can accurately be
+represented, so some rounding is done. With a divider of 2, the lowest
+representable value is around 2600 RPM.
+
+Voltage sensors (also known as IN sensors) report their values in volts. An
+alarm is triggered if the voltage has crossed a programmable minimum or
+maximum limit. Note that minimum in this case always means 'closest to
+zero'; this is important for negative voltage measurements. All voltage
+inputs can measure voltages between 0 and 4.08 volts, with a resolution of
+0.016 volt.
+
+In addition to the alarms described above, there is a BTI alarm, which gets
+triggered when an external chip has crossed its limits. Usually, this is
+connected to some LM75-like chip; if at least one crosses its limits, this
+bit gets set.
+
+If an alarm triggers, it will remain triggered until the hardware register
+is read at least once. This means that the cause for the alarm may already
+have disappeared! Note that in the current implementation, all hardware
+registers are read whenever any data is read (unless it is less than 1.5
+seconds since the last update). This means that you can easily miss
+once-only alarms.
+
+The SiS5595 only updates its values each 1.5 seconds; reading it more often
+will do no harm, but will return 'old' values.
+
+Problems
+--------
+Some chips refuse to be enabled. We don't know why.
+The driver will recognize this and print a message in dmesg.
+
diff --git a/Documentation/hwmon/smsc47b397 b/Documentation/hwmon/smsc47b397
new file mode 100644
--- /dev/null
+++ b/Documentation/hwmon/smsc47b397
@@ -0,0 +1,158 @@
+Kernel driver smsc47b397
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Supported chips:
+  * SMSC LPC47B397-NC
+    Prefix: 'smsc47b397'
+    Addresses scanned: none, address read from Super I/O config space
+    Datasheet: In this file
+
+Authors: Mark M. Hoffman <mhoffman@lightlink.com>
+         Utilitek Systems, Inc.
+
+November 23, 2004
+
+The following specification describes the SMSC LPC47B397-NC sensor chip
+(for which there is no public datasheet available). This document was
+provided by Craig Kelly (In-Store Broadcast Network) and edited/corrected
+by Mark M. Hoffman <mhoffman@lightlink.com>.
+
+* * * * *
+
+Methods for detecting the HP SIO and reading the thermal data on a dc7100.
+
+The thermal information on the dc7100 is contained in the SIO Hardware Mon=
itor
+(HWM). The information is accessed through an index/data pair. The index/d=
ata
+pair is located at the HWM Base Address + 0 and the HWM Base Address + 1. =
The
+HWM Base address can be obtained from Logical Device 8, registers 0x60 (MS=
B)
+and 0x61 (LSB). Currently we are using 0x480 for the HWM Base Address and
+0x480 and 0x481 for the index/data pair.
+
+Reading temperature information.
+The temperature information is located in the following registers:
+Temp1		0x25	(Currently, this reflects the CPU temp on all systems).
+Temp2		0x26
+Temp3		0x27
+Temp4		0x80
+
+Programming Example
+The following is an example of how to read the HWM temperature registers:
+MOV	DX,480H
+MOV	AX,25H
+OUT	DX,AL
+MOV	DX,481H
+IN	AL,DX
+
+AL contains the data in hex, the temperature in Celsius is the decimal
+equivalent.
+
+Ex: If AL contains 0x2A, the temperature is 42 degrees C.
+
+Reading tach information.
+The fan speed information is located in the following registers:
+		LSB	MSB
+Tach1		0x28	0x29	(Currently, this reflects the CPU
+				fan speed on all systems).
+Tach2		0x2A	0x2B
+Tach3		0x2C	0x2D
+Tach4		0x2E	0x2F
+
+Important!!!
+Reading the tach LSB locks the tach MSB.
+The LSB Must be read first.
+
+How to convert the tach reading to RPM.
+The tach reading (TCount) is given by: (Tach MSB * 256) + (Tach LSB)
+The SIO counts the number of 90kHz (11.111us) pulses per revolution.
+RPM =3D 60/(TCount * 11.111us)
+
+Example:
+Reg 0x28 =3D 0x9B
+Reg 0x29 =3D 0x08
+
+TCount =3D 0x89B =3D 2203
+
+RPM =3D 60 / (2203 * 11.11111 E-6) =3D 2451 RPM
+
+Obtaining the SIO version.
+
+CONFIGURATION SEQUENCE
+To program the configuration registers, the following sequence must be fol=
lowed:
+1. Enter Configuration Mode
+2. Configure the Configuration Registers
+3. Exit Configuration Mode.
+
+Enter Configuration Mode
+To place the chip into the Configuration State The config key (0x55) is wr=
itten
+to the CONFIG PORT (0x2E).
+
+Configuration Mode
+In configuration mode, the INDEX PORT is located at the CONFIG PORT addres=
s and
+the DATA PORT is at INDEX PORT address + 1.
+
+The desired configuration registers are accessed in two steps:
+a.	Write the index of the Logical Device Number Configuration Register
+	(i.e., 0x07) to the INDEX PORT and then write the number of the
+	desired logical device to the DATA PORT.
+
+b.	Write the address of the desired configuration register within the
+	logical device to the INDEX PORT and then write or read the config-
+	uration register through the DATA PORT.
+
+Note: If accessing the Global Configuration Registers, step (a) is not req=
uired.
+
+Exit Configuration Mode
+To exit the Configuration State the write 0xAA to the CONFIG PORT (0x2E).
+The chip returns to the RUN State.  (This is important).
+
+Programming Example
+The following is an example of how to read the SIO Device ID located at 0x=
20
+
+; ENTER CONFIGURATION MODE
+MOV	DX,02EH
+MOV	AX,055H
+OUT	DX,AL
+; GLOBAL CONFIGURATION  REGISTER
+MOV	DX,02EH
+MOV	AL,20H
+OUT	DX,AL
+; READ THE DATA
+MOV	DX,02FH
+IN	AL,DX
+; EXIT CONFIGURATION MODE
+MOV	DX,02EH
+MOV	AX,0AAH
+OUT	DX,AL
+
+The registers of interest for identifying the SIO on the dc7100 are Device=
 ID
+(0x20) and Device Rev  (0x21).
+
+The Device ID will read 0X6F
+The Device Rev currently reads 0x01
+
+Obtaining the HWM Base Address.
+The following is an example of how to read the HWM Base Address located in
+Logical Device 8.
+
+; ENTER CONFIGURATION MODE
+MOV	DX,02EH
+MOV	AX,055H
+OUT	DX,AL
+; CONFIGURE REGISTER CRE0,
+; LOGICAL DEVICE 8
+MOV	DX,02EH
+MOV	AL,07H
+OUT	DX,AL ;Point to LD# Config Reg
+MOV	DX,02FH
+MOV	AL, 08H
+OUT	DX,AL;Point to Logical Device 8
+;
+MOV	DX,02EH
+MOV	AL,60H
+OUT	DX,AL	; Point to HWM Base Addr MSB
+MOV	DX,02FH
+IN	AL,DX	; Get MSB of HWM Base Addr
+; EXIT CONFIGURATION MODE
+MOV	DX,02EH
+MOV	AX,0AAH
+OUT	DX,AL
diff --git a/Documentation/hwmon/smsc47m1 b/Documentation/hwmon/smsc47m1
new file mode 100644
--- /dev/null
+++ b/Documentation/hwmon/smsc47m1
@@ -0,0 +1,52 @@
+Kernel driver smsc47m1
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Supported chips:
+  * SMSC LPC47B27x, LPC47M10x, LPC47M13x, LPC47M14x, LPC47M15x and LPC47M1=
92
+    Addresses scanned: none, address read from Super I/O config space
+    Prefix: 'smsc47m1'
+    Datasheets:
+        http://www.smsc.com/main/datasheets/47b27x.pdf
+        http://www.smsc.com/main/datasheets/47m10x.pdf
+        http://www.smsc.com/main/tools/discontinued/47m13x.pdf
+        http://www.smsc.com/main/datasheets/47m14x.pdf
+        http://www.smsc.com/main/tools/discontinued/47m15x.pdf
+        http://www.smsc.com/main/datasheets/47m192.pdf
+
+Authors:
+        Mark D. Studebaker <mdsxyz123@yahoo.com>,
+        With assistance from Bruce Allen <ballen@uwm.edu>, and his
+        fan.c program: http://www.lsc-group.phys.uwm.edu/%7Eballen/driver/
+        Gabriele Gorla <gorlik@yahoo.com>,
+        Jean Delvare <khali@linux-fr.org>
+
+Description
+-----------
+
+The Standard Microsystems Corporation (SMSC) 47M1xx Super I/O chips
+contain monitoring and PWM control circuitry for two fans.
+
+The 47M15x and 47M192 chips contain a full 'hardware monitoring block'
+in addition to the fan monitoring and control. The hardware monitoring
+block is not supported by the driver.
+
+Fan rotation speeds are reported in RPM (rotations per minute). An alarm is
+triggered if the rotation speed has dropped below a programmable limit. Fan
+readings can be divided by a programmable divider (1, 2, 4 or 8) to give
+the readings more range or accuracy. Not all RPM values can accurately be
+represented, so some rounding is done. With a divider of 2, the lowest
+representable value is around 2600 RPM.
+
+PWM values are from 0 to 255.
+
+If an alarm triggers, it will remain triggered until the hardware register
+is read at least once. This means that the cause for the alarm may
+already have disappeared! Note that in the current implementation, all
+hardware registers are read whenever any data is read (unless it is less
+than 1.5 seconds since the last update). This means that you can easily
+miss once-only alarms.
+
+
+**********************
+The lm_sensors project gratefully acknowledges the support of
+Intel in the development of this driver.
diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysf=
s-interface
new file mode 100644
--- /dev/null
+++ b/Documentation/hwmon/sysfs-interface
@@ -0,0 +1,274 @@
+Naming and data format standards for sysfs files
+------------------------------------------------
+
+The libsensors library offers an interface to the raw sensors data
+through the sysfs interface. See libsensors documentation and source for
+more further information. As of writing this document, libsensors
+(from lm_sensors 2.8.3) is heavily chip-dependant. Adding or updating
+support for any given chip requires modifying the library's code.
+This is because libsensors was written for the procfs interface
+older kernel modules were using, which wasn't standardized enough.
+Recent versions of libsensors (from lm_sensors 2.8.2 and later) have
+support for the sysfs interface, though.
+
+The new sysfs interface was designed to be as chip-independant as
+possible.
+
+Note that motherboards vary widely in the connections to sensor chips.
+There is no standard that ensures, for example, that the second
+temperature sensor is connected to the CPU, or that the second fan is on
+the CPU. Also, some values reported by the chips need some computation
+before they make full sense. For example, most chips can only measure
+voltages between 0 and +4V. Other voltages are scaled back into that
+range using external resistors. Since the values of these resistors
+can change from motherboard to motherboard, the conversions cannot be
+hard coded into the driver and have to be done in user space.
+
+For this reason, even if we aim at a chip-independant libsensors, it will
+still require a configuration file (e.g. /etc/sensors.conf) for proper
+values conversion, labeling of inputs and hiding of unused inputs.
+
+An alternative method that some programs use is to access the sysfs
+files directly. This document briefly describes the standards that the
+drivers follow, so that an application program can scan for entries and
+access this data in a simple and consistent way. That said, such programs
+will have to implement conversion, labeling and hiding of inputs. For
+this reason, it is still not recommended to bypass the library.
+
+If you are developing a userspace application please send us feedback on
+this standard.
+
+Note that this standard isn't completely established yet, so it is subject
+to changes, even important ones. One more reason to use the library instead
+of accessing sysfs files directly.
+
+Each chip gets its own directory in the sysfs /sys/devices tree.  To
+find all sensor chips, it is easier to follow the symlinks from
+/sys/i2c/devices/
+
+All sysfs values are fixed point numbers.  To get the true value of some
+of the values, you should divide by the specified value.
+
+There is only one value per file, unlike the older /proc specification.
+The common scheme for files naming is: <type><number>_<item>. Usual
+types for sensor chips are "in" (voltage), "temp" (temperature) and
+"fan" (fan). Usual items are "input" (measured value), "max" (high
+threshold, "min" (low threshold). Numbering usually starts from 1,
+except for voltages which start from 0 (because most data sheets use
+this). A number is always used for elements that can be present more
+than once, even if there is a single element of the given type on the
+specific chip. Other files do not refer to a specific element, so
+they have a simple name, and no number.
+
+Alarms are direct indications read from the chips. The drivers do NOT
+make comparisons of readings to thresholds. This allows violations
+between readings to be caught and alarmed. The exact definition of an
+alarm (for example, whether a threshold must be met or must be exceeded
+to cause an alarm) is chip-dependent.
+
+
+-------------------------------------------------------------------------
+
+************
+* Voltages *
+************
+
+in[0-8]_min	Voltage min value.
+		Unit: millivolt
+		Read/Write
+	=09
+in[0-8]_max	Voltage max value.
+		Unit: millivolt
+		Read/Write
+	=09
+in[0-8]_input	Voltage input value.
+		Unit: millivolt
+		Read only
+		Actual voltage depends on the scaling resistors on the
+		motherboard, as recommended in the chip datasheet.
+		This varies by chip and by motherboard.
+		Because of this variation, values are generally NOT scaled
+		by the chip driver, and must be done by the application.
+		However, some drivers (notably lm87 and via686a)
+		do scale, with various degrees of success.
+		These drivers will output the actual voltage.
+
+		Typical usage:
+			in0_*	CPU #1 voltage (not scaled)
+			in1_*	CPU #2 voltage (not scaled)
+			in2_*	3.3V nominal (not scaled)
+			in3_*	5.0V nominal (scaled)
+			in4_*	12.0V nominal (scaled)
+			in5_*	-12.0V nominal (scaled)
+			in6_*	-5.0V nominal (scaled)
+			in7_*	varies
+			in8_*	varies
+
+cpu[0-1]_vid	CPU core reference voltage.
+		Unit: millivolt
+		Read only.
+		Not always correct.
+
+vrm		Voltage Regulator Module version number.=20
+		Read only.
+		Two digit number, first is major version, second is
+		minor version.
+		Affects the way the driver calculates the CPU core reference
+		voltage from the vid pins.
+
+
+********
+* Fans *
+********
+
+fan[1-3]_min	Fan minimum value
+		Unit: revolution/min (RPM)
+		Read/Write.
+
+fan[1-3]_input	Fan input value.
+		Unit: revolution/min (RPM)
+		Read only.
+
+fan[1-3]_div	Fan divisor.
+		Integer value in powers of two (1, 2, 4, 8, 16, 32, 64, 128).
+		Some chips only support values 1, 2, 4 and 8.
+		Note that this is actually an internal clock divisor, which
+		affects the measurable speed range, not the read value.
+
+*******
+* PWM *
+*******
+
+pwm[1-3]	Pulse width modulation fan control.
+		Integer value in the range 0 to 255
+		Read/Write
+		255 is max or 100%.
+
+pwm[1-3]_enable
+		Switch PWM on and off.
+		Not always present even if fan*_pwm is.
+		0 to turn off
+		1 to turn on in manual mode
+		2 to turn on in automatic mode
+		Read/Write
+
+pwm[1-*]_auto_channels_temp
+		Select which temperature channels affect this PWM output in
+		auto mode. Bitfield, 1 is temp1, 2 is temp2, 4 is temp3 etc...
+		Which values are possible depend on the chip used.
+
+pwm[1-*]_auto_point[1-*]_pwm
+pwm[1-*]_auto_point[1-*]_temp
+pwm[1-*]_auto_point[1-*]_temp_hyst
+		Define the PWM vs temperature curve. Number of trip points is
+		chip-dependent. Use this for chips which associate trip points
+		to PWM output channels.
+
+OR
+
+temp[1-*]_auto_point[1-*]_pwm
+temp[1-*]_auto_point[1-*]_temp
+temp[1-*]_auto_point[1-*]_temp_hyst
+		Define the PWM vs temperature curve. Number of trip points is
+		chip-dependent. Use this for chips which associate trip points
+		to temperature channels.
+
+
+****************
+* Temperatures *
+****************
+
+temp[1-3]_type	Sensor type selection.
+		Integers 1, 2, 3 or thermistor Beta value (3435)
+		Read/Write.
+		1: PII/Celeron Diode
+		2: 3904 transistor
+		3: thermal diode
+		Not all types are supported by all chips
+
+temp[1-4]_max	Temperature max value.
+		Unit: millidegree Celcius
+		Read/Write value.
+
+temp[1-3]_min	Temperature min value.
+		Unit: millidegree Celcius
+		Read/Write value.
+
+temp[1-3]_max_hyst
+		Temperature hysteresis value for max limit.
+		Unit: millidegree Celcius
+		Must be reported as an absolute temperature, NOT a delta
+		from the max value.
+		Read/Write value.
+
+temp[1-4]_input Temperature input value.
+		Unit: millidegree Celcius
+		Read only value.
+
+temp[1-4]_crit	Temperature critical value, typically greater than
+		corresponding temp_max values.
+		Unit: millidegree Celcius
+		Read/Write value.
+
+temp[1-2]_crit_hyst
+		Temperature hysteresis value for critical limit.
+		Unit: millidegree Celcius
+		Must be reported as an absolute temperature, NOT a delta
+		from the critical value.
+		Read/Write value.
+
+		If there are multiple temperature sensors, temp1_* is
+		generally the sensor inside the chip itself,
+		reported as "motherboard temperature".  temp2_* to
+		temp4_* are generally sensors external to the chip
+		itself, for example the thermal diode inside the CPU or
+		a thermistor nearby.
+
+
+************
+* Currents *
+************
+
+Note that no known chip provides current measurements as of writing,
+so this part is theoretical, so to say.
+
+curr[1-n]_max	Current max value
+		Unit: milliampere
+		Read/Write.
+
+curr[1-n]_min	Current min value.
+		Unit: milliampere
+		Read/Write.
+
+curr[1-n]_input	Current input value
+		Unit: milliampere
+		Read only.
+
+
+*********
+* Other *
+*********
+
+alarms		Alarm bitmask.
+		Read only.
+		Integer representation of one to four bytes.
+		A '1' bit means an alarm.
+		Chips should be programmed for 'comparator' mode so that
+		the alarm will 'come back' after you read the register
+		if it is still valid.
+		Generally a direct representation of a chip's internal
+		alarm registers; there is no standard for the position
+		of individual bits.
+		Bits are defined in kernel/include/sensors.h.
+
+beep_enable	Beep/interrupt enable
+		0 to disable.
+		1 to enable.
+		Read/Write
+
+beep_mask	Bitmask for beep.
+		Same format as 'alarms' with the same bit locations.
+		Read/Write
+
+eeprom		Raw EEPROM data in binary form.
+		Read only.
diff --git a/Documentation/hwmon/userspace-tools b/Documentation/hwmon/user=
space-tools
new file mode 100644
--- /dev/null
+++ b/Documentation/hwmon/userspace-tools
@@ -0,0 +1,39 @@
+Introduction
+------------
+
+Most mainboards have sensor chips to monitor system health (like temperatu=
res,
+voltages, fans speed). They are often connected through an I2C bus, but so=
me
+are also connected directly through the ISA bus.
+
+The kernel drivers make the data from the sensor chips available in the /s=
ys
+virtual filesystem. Userspace tools are then used to display or set or the
+data in a more friendly manner.
+
+Lm-sensors
+----------
+
+Core set of utilites that will allow you to obtain health information,
+setup monitoring limits etc. You can get them on their homepage
+http://www.lm-sensors.nu/ or as a package from your Linux distribution.
+
+If from website:
+Get lmsensors from project web site. Please note, you need only userspace
+part, so compile with "make user_install" target.
+
+General hints to get things working:
+
+0) get lm-sensors userspace utils
+1) compile all drivers in I2C section as modules in your kernel
+2) run sensors-detect script, it will tell you what modules you need to lo=
ad.
+3) load them and run "sensors" command, you should see some results.
+4) fix sensors.conf, labels, limits, fan divisors
+5) if any more problems consult FAQ, or documentation
+
+Other utilites
+--------------
+
+If you want some graphical indicators of system health look for applicatio=
ns
+like: gkrellm, ksensors, xsensors, wmtemp, wmsensors, wmgtemp, ksysguardd,
+hardware-monitor
+
+If you are server administrator you can try snmpd or mrtgutils.
diff --git a/Documentation/hwmon/via686a b/Documentation/hwmon/via686a
new file mode 100644
--- /dev/null
+++ b/Documentation/hwmon/via686a
@@ -0,0 +1,65 @@
+Kernel driver via686a
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
+Supported chips:
+  * Via VT82C686A, VT82C686B  Southbridge Integrated Hardware Monitor
+    Prefix: 'via686a'
+    Addresses scanned: ISA in PCI-space encoded address
+    Datasheet: On request through web form (http://www.via.com.tw/en/suppo=
rt/datasheets/)
+
+Authors:
+        Ky?sti M?lkki <kmalkki@cc.hut.fi>,
+        Mark D. Studebaker <mdsxyz123@yahoo.com>
+        Bob Dougherty <bobd@stanford.edu>
+        (Some conversion-factor data were contributed by
+        Jonathan Teh Soon Yew <j.teh@iname.com>
+        and Alex van Kaam <darkside@chello.nl>.)
+
+Module Parameters
+-----------------
+
+force_addr=3D0xaddr       Set the I/O base address. Useful for Asus A7V bo=
ards
+                        that don't set the address in the BIOS. Does not d=
o a
+                        PCI force; the via686a must still be present in ls=
pci.
+                        Don't use this unless the driver complains that the
+                        base address is not set.
+                        Example: 'modprobe via686a force_addr=3D0x6000'
+
+Description
+-----------
+
+The driver does not distinguish between the chips and reports
+all as a 686A.
+
+The Via 686a southbridge has integrated hardware monitor functionality.
+It also has an I2C bus, but this driver only supports the hardware monitor.
+For the I2C bus driver, see <file:Documentation/i2c/busses/i2c-viapro>
+
+The Via 686a implements three temperature sensors, two fan rotation speed
+sensors, five voltage sensors and alarms.
+
+Temperatures are measured in degrees Celsius. An alarm is triggered once
+when the Overtemperature Shutdown limit is crossed; it is triggered again
+as soon as it drops below the hysteresis value.
+
+Fan rotation speeds are reported in RPM (rotations per minute). An alarm is
+triggered if the rotation speed has dropped below a programmable limit. Fan
+readings can be divided by a programmable divider (1, 2, 4 or 8) to give
+the readings more range or accuracy. Not all RPM values can accurately be
+represented, so some rounding is done. With a divider of 2, the lowest
+representable value is around 2600 RPM.
+
+Voltage sensors (also known as IN sensors) report their values in volts.
+An alarm is triggered if the voltage has crossed a programmable minimum
+or maximum limit. Voltages are internally scalled, so each voltage channel
+has a different resolution and range.
+
+If an alarm triggers, it will remain triggered until the hardware register
+is read at least once. This means that the cause for the alarm may
+already have disappeared! Note that in the current implementation, all
+hardware registers are read whenever any data is read (unless it is less
+than 1.5 seconds since the last update). This means that you can easily
+miss once-only alarms.
+
+The driver only updates its values each 1.5 seconds; reading it more often
+will do no harm, but will return 'old' values.
diff --git a/Documentation/hwmon/w83627hf b/Documentation/hwmon/w83627hf
new file mode 100644
--- /dev/null
+++ b/Documentation/hwmon/w83627hf
@@ -0,0 +1,66 @@
+Kernel driver w83627hf
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Supported chips:
+  * Winbond W83627HF (ISA accesses ONLY)
+    Prefix: 'w83627hf'
+    Addresses scanned: ISA address retrieved from Super I/O registers
+    Datasheet: http://www.winbond.com/PDF/sheet/w83627hf.pdf
+  * Winbond W83627THF
+    Prefix: 'w83627thf'
+    Addresses scanned: ISA address retrieved from Super I/O registers
+    Datasheet: http://www.winbond.com/PDF/sheet/w83627thf.pdf
+  * Winbond W83697HF
+    Prefix: 'w83697hf'
+    Addresses scanned: ISA address retrieved from Super I/O registers
+    Datasheet: http://www.winbond.com/PDF/sheet/697hf.pdf
+  * Winbond W83637HF
+    Prefix: 'w83637hf'
+    Addresses scanned: ISA address retrieved from Super I/O registers
+    Datasheet: http://www.winbond.com/PDF/sheet/w83637hf.pdf
+
+Authors:
+        Frodo Looijaard <frodol@dds.nl>,
+        Philip Edelbrock <phil@netroedge.com>,
+        Mark Studebaker <mdsxyz123@yahoo.com>,
+        Bernhard C. Schrenk <clemy@clemy.org>
+
+Module Parameters
+-----------------
+
+* force_addr: int
+  Initialize the ISA address of the sensors
+* force_i2c: int
+  Initialize the I2C address of the sensors
+* init: int
+  (default is 1)
+  Use 'init=3D0' to bypass initializing the chip.
+  Try this if your computer crashes when you load the module.
+
+Description
+-----------
+
+This driver implements support for ISA accesses *only* for
+the Winbond W83627HF, W83627THF, W83697HF and W83637HF Super I/O chips.
+We will refer to them collectively as Winbond chips.
+
+This driver supports ISA accesses, which should be more reliable
+than i2c accesses. Also, for Tyan boards which contain both a
+Super I/O chip and a second i2c-only Winbond chip (often a W83782D),
+using this driver will avoid i2c address conflicts and complex
+initialization that were required in the w83781d driver.
+
+If you really want i2c accesses for these Super I/O chips,
+use the w83781d driver. However this is not the preferred method
+now that this ISA driver has been developed.
+
+Technically, the w83627thf does not support a VID reading. However, it's
+possible or even likely that your mainboard maker has routed these signals
+to a specific set of general purpose IO pins (the Asus P4C800-E is one such
+board). The w83627thf driver now interprets these as VID. If the VID on
+your board doesn't work, first see doc/vid in the lm_sensors package. If
+that still doesn't help, email us at lm-sensors@lm-sensors.org.
+
+For further information on this driver see the w83781d driver
+documentation.
+
diff --git a/Documentation/hwmon/w83781d b/Documentation/hwmon/w83781d
new file mode 100644
--- /dev/null
+++ b/Documentation/hwmon/w83781d
@@ -0,0 +1,402 @@
+Kernel driver w83781d
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
+Supported chips:
+  * Winbond W83781D
+    Prefix: 'w83781d'
+    Addresses scanned: I2C 0x20 - 0x2f, ISA 0x290 (8 I/O ports)
+    Datasheet: http://www.winbond-usa.com/products/winbond_products/pdfs/P=
CIC/w83781d.pdf
+  * Winbond W83782D
+    Prefix: 'w83782d'
+    Addresses scanned: I2C 0x20 - 0x2f, ISA 0x290 (8 I/O ports)
+    Datasheet: http://www.winbond.com/PDF/sheet/w83782d.pdf
+  * Winbond W83783S
+    Prefix: 'w83783s'
+    Addresses scanned: I2C 0x2d
+    Datasheet: http://www.winbond-usa.com/products/winbond_products/pdfs/P=
CIC/w83783s.pdf
+  * Winbond W83627HF
+    Prefix: 'w83627hf'
+    Addresses scanned: I2C 0x20 - 0x2f, ISA 0x290 (8 I/O ports)
+    Datasheet: http://www.winbond.com/PDF/sheet/w83627hf.pdf
+  * Asus AS99127F
+    Prefix: 'as99127f'
+    Addresses scanned: I2C 0x28 - 0x2f
+    Datasheet: Unavailable from Asus
+
+Authors:
+        Frodo Looijaard <frodol@dds.nl>,
+        Philip Edelbrock <phil@netroedge.com>,
+        Mark Studebaker <mdsxyz123@yahoo.com>
+
+Module parameters
+-----------------
+
+* init int
+  (default 1)
+  Use 'init=3D0' to bypass initializing the chip.
+  Try this if your computer crashes when you load the module.
+
+force_subclients=3Dbus,caddr,saddr,saddr
+  This is used to force the i2c addresses for subclients of
+  a certain chip. Typical usage is `force_subclients=3D0,0x2d,0x4a,0x4b'
+  to force the subclients of chip 0x2d on bus 0 to i2c addresses
+  0x4a and 0x4b. This parameter is useful for certain Tyan boards.
+
+Description
+-----------
+
+This driver implements support for the Winbond W83781D, W83782D, W83783S,
+W83627HF chips, and the Asus AS99127F chips. We will refer to them
+collectively as W8378* chips.
+
+There is quite some difference between these chips, but they are similar
+enough that it was sensible to put them together in one driver.
+The W83627HF chip is assumed to be identical to the ISA W83782D.
+The Asus chips are similar to an I2C-only W83782D.
+
+Chip        #vin    #fanin  #pwm    #temp   wchipid vendid  i2c     ISA
+as99127f    7       3       0       3       0x31    0x12c3  yes     no
+as99127f rev.2 (type_name =3D as99127f)       0x31    0x5ca3  yes     no
+w83781d     7       3       0       3       0x10-1  0x5ca3  yes     yes
+w83627hf    9       3       2       3       0x21    0x5ca3  yes     yes(LP=
C)
+w83782d     9       3       2-4     3       0x30    0x5ca3  yes     yes
+w83783s     5-6     3       2       1-2     0x40    0x5ca3  yes     no
+
+Detection of these chips can sometimes be foiled because they can be in
+an internal state that allows no clean access. If you know the address
+of the chip, use a 'force' parameter; this will put them into a more
+well-behaved state first.
+
+The W8378* implements temperature sensors (three on the W83781D and W83782=
D,
+two on the W83783S), three fan rotation speed sensors, voltage sensors
+(seven on the W83781D, nine on the W83782D and six on the W83783S), VID
+lines, alarms with beep warnings, and some miscellaneous stuff.
+
+Temperatures are measured in degrees Celsius. There is always one main
+temperature sensor, and one (W83783S) or two (W83781D and W83782D) other
+sensors. An alarm is triggered for the main sensor once when the
+Overtemperature Shutdown limit is crossed; it is triggered again as soon as
+it drops below the Hysteresis value. A more useful behavior
+can be found by setting the Hysteresis value to +127 degrees Celsius; in
+this case, alarms are issued during all the time when the actual temperatu=
re
+is above the Overtemperature Shutdown value. The driver sets the
+hysteresis value for temp1 to 127 at initialization.
+
+For the other temperature sensor(s), an alarm is triggered when the
+temperature gets higher then the Overtemperature Shutdown value; it stays
+on until the temperature falls below the Hysteresis value. But on the
+W83781D, there is only one alarm that functions for both other sensors!
+Temperatures are guaranteed within a range of -55 to +125 degrees. The
+main temperature sensors has a resolution of 1 degree; the other sensor(s)
+of 0.5 degree.
+
+Fan rotation speeds are reported in RPM (rotations per minute). An alarm is
+triggered if the rotation speed has dropped below a programmable limit. Fan
+readings can be divided by a programmable divider (1, 2, 4 or 8 for the
+W83781D; 1, 2, 4, 8, 16, 32, 64 or 128 for the others) to give
+the readings more range or accuracy. Not all RPM values can accurately
+be represented, so some rounding is done. With a divider of 2, the lowest
+representable value is around 2600 RPM.
+
+Voltage sensors (also known as IN sensors) report their values in volts.
+An alarm is triggered if the voltage has crossed a programmable minimum
+or maximum limit. Note that minimum in this case always means 'closest to
+zero'; this is important for negative voltage measurements. All voltage
+inputs can measure voltages between 0 and 4.08 volts, with a resolution
+of 0.016 volt.
+
+The VID lines encode the core voltage value: the voltage level your proces=
sor
+should work with. This is hardcoded by the mainboard and/or processor itse=
lf.
+It is a value in volts. When it is unconnected, you will often find the
+value 3.50 V here.
+
+The W83782D and W83783S temperature conversion machine understands about
+several kinds of temperature probes. You can program the so-called
+beta value in the sensor files. '1' is the PII/Celeron diode, '2' is the
+TN3904 transistor, and 3435 the default thermistor value. Other values
+are (not yet) supported.
+
+In addition to the alarms described above, there is a CHAS alarm on the
+chips which triggers if your computer case is open.
+
+When an alarm goes off, you can be warned by a beeping signal through
+your computer speaker. It is possible to enable all beeping globally,
+or only the beeping for some alarms.
+
+If an alarm triggers, it will remain triggered until the hardware register
+is read at least once. This means that the cause for the alarm may
+already have disappeared! Note that in the current implementation, all
+hardware registers are read whenever any data is read (unless it is less
+than 1.5 seconds since the last update). This means that you can easily
+miss once-only alarms.
+
+The chips only update values each 1.5 seconds; reading them more often
+will do no harm, but will return 'old' values.
+
+AS99127F PROBLEMS
+-----------------
+The as99127f support was developed without the benefit of a datasheet.
+In most cases it is treated as a w83781d (although revision 2 of the
+AS99127F looks more like a w83782d).
+This support will be BETA until a datasheet is released.
+One user has reported problems with fans stopping
+occasionally.
+
+Note that the individual beep bits are inverted from the other chips.
+The driver now takes care of this so that user-space applications
+don't have to know about it.
+
+Known problems:
+	- Problems with diode/thermistor settings (supported?)
+	- One user reports fans stopping under high server load.
+	- Revision 2 seems to have 2 PWM registers but we don't know
+	  how to handle them. More details below.
+
+These will not be fixed unless we get a datasheet.
+If you have problems, please lobby Asus to release a datasheet.
+Unfortunately several others have without success.
+Please do not send mail to us asking for better as99127f support.
+We have done the best we can without a datasheet.
+Please do not send mail to the author or the sensors group asking for
+a datasheet or ideas on how to convince Asus. We can't help.
+
+
+NOTES:
+-----
+  783s has no in1 so that in[2-6] are compatible with the 781d/782d.
+
+  783s pin is programmable for -5V or temp1; defaults to -5V,
+       no control in driver so temp1 doesn't work.
+
+  782d and 783s datasheets differ on which is pwm1 and which is pwm2.
+       We chose to follow 782d.
+
+  782d and 783s pin is programmable for fan3 input or pwm2 output;
+       defaults to fan3 input.
+       If pwm2 is enabled (with echo 255 1 > pwm2), then
+       fan3 will report 0.
+
+  782d has pwm1-2 for ISA, pwm1-4 for i2c. (pwm3-4 share pins with
+       the ISA pins)
+
+Data sheet updates:
+------------------
+	- PWM clock registers:
+
+		000: master /  512
+		001: master / 1024
+		010: master / 2048
+		011: master / 4096
+		100: master / 8192
+
+
+Answers from Winbond tech support
+---------------------------------
+>
+> 1) In the W83781D data sheet section 7.2 last paragraph, it talks about
+>    reprogramming the R-T table if the Beta of the thermistor is not
+>    3435K. The R-T table is described briefly in section 8.20.
+>    What formulas do I use to program a new R-T table for a given Beta?
+>
+	We are sorry that the calculation for R-T table value is
+confidential. If you have another Beta value of thermistor, we can help
+to calculate the R-T table for you. But you should give us real R-T
+Table which can be gotten by thermistor vendor. Therefore we will calculate
+them and obtain 32-byte data, and you can fill the 32-byte data to the
+register in Bank0.CR51 of W83781D.
+
+
+> 2) In the W83782D data sheet, it mentions that pins 38, 39, and 40 are
+>    programmable to be either thermistor or Pentium II diode inputs.
+>    How do I program them for diode inputs? I can't find any register
+>    to program these to be diode inputs.
+ --> You may program Bank0 CR[5Dh] and CR[59h] registers.
+
+ 	CR[5Dh]    		bit 1(VTIN1)    bit 2(VTIN2)   bit 3(VTIN3)
+
+      	thermistor                0		 0		0
+ 	diode 		          1		 1		1
+
+
+(error) CR[59h] 		bit 4(VTIN1)	bit 2(VTIN2)   bit 3(VTIN3)
+(right) CR[59h] 		bit 4(VTIN1)	bit 5(VTIN2)   bit 6(VTIN3)
+
+ 	PII thermal diode         1		 1		1
+ 	2N3904	diode	          0		 0		0
+
+
+Asus Clones
+-----------
+
+We have no datasheets for the Asus clones (AS99127F and ASB100 Bach).
+Here are some very useful information that were given to us by Alex Van
+Kaam about how to detect these chips, and how to read their values. He
+also gives advice for another Asus chipset, the Mozart-2 (which we
+don't support yet). Thanks Alex!
+I reworded some parts and added personal comments.
+
+# Detection:
+
+AS99127F rev.1, AS99127F rev.2 and ASB100:
+- I2C address range: 0x29 - 0x2F
+- If register 0x58 holds 0x31 then we have an Asus (either ASB100 or
+  AS99127F)
+- Which one depends on register 0x4F (manufacturer ID):
+  0x06 or 0x94: ASB100
+  0x12 or 0xC3: AS99127F rev.1
+  0x5C or 0xA3: AS99127F rev.2
+  Note that 0x5CA3 is Winbond's ID (WEC), which let us think Asus get their
+  AS99127F rev.2 direct from Winbond. The other codes mean ATT and DVC,
+  respectively. ATT could stand for Asustek something (although it would be
+  very badly chosen IMHO), I don't know what DVC could stand for. Maybe
+  these codes simply aren't meant to be decoded that way.
+
+Mozart-2:
+- I2C address: 0x77
+- If register 0x58 holds 0x56 or 0x10 then we have a Mozart-2
+- Of the Mozart there are 3 types:
+  0x58=3D0x56, 0x4E=3D0x94, 0x4F=3D0x36: Asus ASM58 Mozart-2
+  0x58=3D0x56, 0x4E=3D0x94, 0x4F=3D0x06: Asus AS2K129R Mozart-2
+  0x58=3D0x10, 0x4E=3D0x5C, 0x4F=3D0xA3: Asus ??? Mozart-2
+  You can handle all 3 the exact same way :)
+
+# Temperature sensors:
+
+ASB100:
+- sensor 1: register 0x27
+- sensor 2 & 3 are the 2 LM75's on the SMBus
+- sensor 4: register 0x17
+Remark: I noticed that on Intel boards sensor 2 is used for the CPU
+  and 4 is ignored/stuck, on AMD boards sensor 4 is the CPU and sensor 2 is
+  either ignored or a socket temperature.
+
+AS99127F (rev.1 and 2 alike):
+- sensor 1: register 0x27
+- sensor 2 & 3 are the 2 LM75's on the SMBus
+Remark: Register 0x5b is suspected to be temperature type selector. Bit 1
+  would control temp1, bit 3 temp2 and bit 5 temp3.
+
+Mozart-2:
+- sensor 1: register 0x27
+- sensor 2: register 0x13
+
+# Fan sensors:
+
+ASB100, AS99127F (rev.1 and 2 alike):
+- 3 fans, identical to the W83781D
+
+Mozart-2:
+- 2 fans only, 1350000/RPM/div
+- fan 1: register 0x28,  divisor on register 0xA1 (bits 4-5)
+- fan 2: register 0x29,  divisor on register 0xA1 (bits 6-7)
+
+# Voltages:
+
+This is where there is a difference between AS99127F rev.1 and 2.
+Remark: The difference is similar to the difference between
+  W83781D and W83782D.
+
+ASB100:
+in0=3Dr(0x20)*0.016
+in1=3Dr(0x21)*0.016
+in2=3Dr(0x22)*0.016
+in3=3Dr(0x23)*0.016*1.68
+in4=3Dr(0x24)*0.016*3.8
+in5=3Dr(0x25)*(-0.016)*3.97
+in6=3Dr(0x26)*(-0.016)*1.666
+
+AS99127F rev.1:
+in0=3Dr(0x20)*0.016
+in1=3Dr(0x21)*0.016
+in2=3Dr(0x22)*0.016
+in3=3Dr(0x23)*0.016*1.68
+in4=3Dr(0x24)*0.016*3.8
+in5=3Dr(0x25)*(-0.016)*3.97
+in6=3Dr(0x26)*(-0.016)*1.503
+
+AS99127F rev.2:
+in0=3Dr(0x20)*0.016
+in1=3Dr(0x21)*0.016
+in2=3Dr(0x22)*0.016
+in3=3Dr(0x23)*0.016*1.68
+in4=3Dr(0x24)*0.016*3.8
+in5=3D(r(0x25)*0.016-3.6)*5.14+3.6
+in6=3D(r(0x26)*0.016-3.6)*3.14+3.6
+
+Mozart-2:
+in0=3Dr(0x20)*0.016
+in1%5
+in2=3Dr(0x22)*0.016
+in3=3Dr(0x23)*0.016*1.68
+in4=3Dr(0x24)*0.016*4
+in5%5
+in6%5
+
+
+# PWM
+
+Additional info about PWM on the AS99127F (may apply to other Asus
+chips as well) by Jean Delvare as of 2004-04-09:
+
+AS99127F revision 2 seems to have two PWM registers at 0x59 and 0x5A,
+and a temperature sensor type selector at 0x5B (which basically means
+that they swapped registers 0x59 and 0x5B when you compare with Winbond
+chips).
+Revision 1 of the chip also has the temperature sensor type selector at
+0x5B, but PWM registers have no effect.
+
+We don't know exactly how the temperature sensor type selection works.
+Looks like bits 1-0 are for temp1, bits 3-2 for temp2 and bits 5-4 for
+temp3, although it is possible that only the most significant bit matters
+each time. So far, values other than 0 always broke the readings.
+
+PWM registers seem to be split in two parts: bit 7 is a mode selector,
+while the other bits seem to define a value or threshold.
+
+When bit 7 is clear, bits 6-0 seem to hold a threshold value. If the value
+is below a given limit, the fan runs at low speed. If the value is above
+the limit, the fan runs at full speed. We have no clue as to what the limit
+represents. Note that there seem to be some inertia in this mode, speed
+changes may need some time to trigger. Also, an hysteresis mechanism is
+suspected since walking through all the values increasingly and then
+decreasingly led to slightly different limits.
+
+When bit 7 is set, bits 3-0 seem to hold a threshold value, while bits 6-4
+would not be significant. If the value is below a given limit, the fan runs
+at full speed, while if it is above the limit it runs at low speed (so this
+is the contrary of the other mode, in a way). Here again, we don't know
+what the limit is supposed to represent.
+
+One remarkable thing is that the fans would only have two or three
+different speeds (transitional states left apart), not a whole range as
+you usually get with PWM.
+
+As a conclusion, you can write 0x00 or 0x8F to the PWM registers to make
+fans run at low speed, and 0x7F or 0x80 to make them run at full speed.
+
+Please contact us if you can figure out how it is supposed to work. As
+long as we don't know more, the w83781d driver doesn't handle PWM on
+AS99127F chips at all.
+
+Additional info about PWM on the AS99127F rev.1 by Hector Martin:
+
+I've been fiddling around with the (in)famous 0x59 register and
+found out the following values do work as a form of coarse pwm:
+
+0x80 - seems to turn fans off after some time(1-2 minutes)... might be
+some form of auto-fan-control based on temp? hmm (Qfan? this mobo is an
+old ASUS, it isn't marketed as Qfan. Maybe some beta pre-attemp at Qfan
+that was dropped at the BIOS)
+0x81 - off
+0x82 - slightly "on-ner" than off, but my fans do not get to move. I can
+hear the high-pitched PWM sound that motors give off at too-low-pwm.
+0x83 - now they do move. Estimate about 70% speed or so.
+0x84-0x8f - full on
+
+Changing the high nibble doesn't seem to do much except the high bit
+(0x80) must be set for PWM to work, else the current pwm doesn't seem to
+change.
+
+My mobo is an ASUS A7V266-E. This behavior is similar to what I got
+with speedfan under Windows, where 0-15% would be off, 15-2x% (can't
+remember the exact value) would be 70% and higher would be full on.
diff --git a/Documentation/hwmon/w83l785ts b/Documentation/hwmon/w83l785ts
new file mode 100644
--- /dev/null
+++ b/Documentation/hwmon/w83l785ts
@@ -0,0 +1,39 @@
+Kernel driver w83l785ts
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
+Supported chips:
+  * Winbond W83L785TS-S
+    Prefix: 'w83l785ts'
+    Addresses scanned: I2C 0x2e
+    Datasheet: Publicly available at the Winbond USA website
+               http://www.winbond-usa.com/products/winbond_products/pdfs/P=
CIC/W83L785TS-S.pdf
+
+Authors:
+        Jean Delvare <khali@linux-fr.org>
+
+Description
+-----------
+
+The W83L785TS-S is a digital temperature sensor. It senses the
+temperature of a single external diode. The high limit is
+theoretically defined as 85 or 100 degrees C through a combination
+of external resistors, so the user cannot change it. Values seen so
+far suggest that the two possible limits are actually 95 and 110
+degrees C. The datasheet is rather poor and obviously inaccurate
+on several points including this one.
+
+All temperature values are given in degrees Celsius. Resolution
+is 1.0 degree. See the datasheet for details.
+
+The w83l785ts driver will not update its values more frequently than
+every other second; reading them more often will do no harm, but will
+return 'old' values.
+
+Known Issues
+------------
+
+On some systems (Asus), the BIOS is known to interfere with the driver
+and cause read errors. The driver will retry a given number of times
+(5 by default) and then give up, returning the old value (or 0 if
+there is no old value). It seems to work well enough so that you should
+not notice anything. Thanks to James Bolt for helping test this feature.
diff --git a/Documentation/i2c/chips/adm1021 b/Documentation/i2c/chips/adm1=
021
deleted file mode 100644
--- a/Documentation/i2c/chips/adm1021
+++ /dev/null
@@ -1,111 +0,0 @@
-Kernel driver adm1021
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-
-Supported chips:
-  * Analog Devices ADM1021
-    Prefix: 'adm1021'
-    Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e
-    Datasheet: Publicly available at the Analog Devices website
-  * Analog Devices ADM1021A/ADM1023
-    Prefix: 'adm1023'
-    Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e
-    Datasheet: Publicly available at the Analog Devices website
-  * Genesys Logic GL523SM
-    Prefix: 'gl523sm'
-    Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e
-    Datasheet:
-  * Intel Xeon Processor
-    Prefix: - any other - may require 'force_adm1021' parameter
-    Addresses scanned: none
-    Datasheet: Publicly available at Intel website
-  * Maxim MAX1617
-    Prefix: 'max1617'
-    Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e
-    Datasheet: Publicly available at the Maxim website
-  * Maxim MAX1617A
-    Prefix: 'max1617a'
-    Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e
-    Datasheet: Publicly available at the Maxim website
-  * National Semiconductor LM84
-    Prefix: 'lm84'
-    Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e
-    Datasheet: Publicly available at the National Semiconductor website
-  * Philips NE1617
-    Prefix: 'max1617' (probably detected as a max1617)
-    Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e
-    Datasheet: Publicly available at the Philips website
-  * Philips NE1617A
-    Prefix: 'max1617' (probably detected as a max1617)
-    Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e
-    Datasheet: Publicly available at the Philips website
-  * TI THMC10
-    Prefix: 'thmc10'
-    Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e
-    Datasheet: Publicly available at the TI website
-  * Onsemi MC1066
-    Prefix: 'mc1066'
-    Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e
-    Datasheet: Publicly available at the Onsemi website
-
-
-Authors:
-        Frodo Looijaard <frodol@dds.nl>,
-        Philip Edelbrock <phil@netroedge.com>
-
-Module Parameters
------------------
-
-* read_only: int
-  Don't set any values, read only mode
-
-
-Description
------------
-
-The chips supported by this driver are very similar. The Maxim MAX1617 is
-the oldest; it has the problem that it is not very well detectable. The
-MAX1617A solves that. The ADM1021 is a straight clone of the MAX1617A.
-Ditto for the THMC10. From here on, we will refer to all these chips as
-ADM1021-clones.
-
-The ADM1021 and MAX1617A reports a die code, which is a sort of revision
-code. This can help us pinpoint problems; it is not very useful
-otherwise.
-
-ADM1021-clones implement two temperature sensors. One of them is internal,
-and measures the temperature of the chip itself; the other is external and
-is realised in the form of a transistor-like device. A special alarm
-indicates whether the remote sensor is connected.
-
-Each sensor has its own low and high limits. When they are crossed, the
-corresponding alarm is set and remains on as long as the temperature stays
-out of range. Temperatures are measured in degrees Celsius. Measurements
-are possible between -65 and +127 degrees, with a resolution of one degree.
-
-If an alarm triggers, it will remain triggered until the hardware register
-is read at least once. This means that the cause for the alarm may already
-have disappeared!
-
-This driver only updates its values each 1.5 seconds; reading it more often
-will do no harm, but will return 'old' values. It is possible to make
-ADM1021-clones do faster measurements, but there is really no good reason
-for that.
-
-Xeon support
-------------
-
-Some Xeon processors have real max1617, adm1021, or compatible chips
-within them, with two temperature sensors.
-
-Other Xeons have chips with only one sensor.
-
-If you have a Xeon, and the adm1021 module loads, and both temperatures
-appear valid, then things are good.
-
-If the adm1021 module doesn't load, you should try this:
-	modprobe adm1021 force_adm1021=3DBUS,ADDRESS
-	ADDRESS can only be 0x18, 0x1a, 0x29, 0x2b, 0x4c, or 0x4e.
-
-If you have dual Xeons you may have appear to have two separate
-adm1021-compatible chips, or two single-temperature sensors, at distinct
-addresses.
diff --git a/Documentation/i2c/chips/adm1025 b/Documentation/i2c/chips/adm1=
025
deleted file mode 100644
--- a/Documentation/i2c/chips/adm1025
+++ /dev/null
@@ -1,51 +0,0 @@
-Kernel driver adm1025
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-
-Supported chips:
-  * Analog Devices ADM1025, ADM1025A
-    Prefix: 'adm1025'
-    Addresses scanned: I2C 0x2c - 0x2e
-    Datasheet: Publicly available at the Analog Devices website
-  * Philips NE1619
-    Prefix: 'ne1619'
-    Addresses scanned: I2C 0x2c - 0x2d
-    Datasheet: Publicly available at the Philips website
-
-The NE1619 presents some differences with the original ADM1025:
-  * Only two possible addresses (0x2c - 0x2d).
-  * No temperature offset register, but we don't use it anyway.
-  * No INT mode for pin 16. We don't play with it anyway.
-
-Authors:
-        Chen-Yuan Wu <gwu@esoft.com>,
-        Jean Delvare <khali@linux-fr.org>
-
-Description
------------
-
-(This is from Analog Devices.) The ADM1025 is a complete system hardware
-monitor for microprocessor-based systems, providing measurement and limit
-comparison of various system parameters. Five voltage measurement inputs
-are provided, for monitoring +2.5V, +3.3V, +5V and +12V power supplies and
-the processor core voltage. The ADM1025 can monitor a sixth power-supply
-voltage by measuring its own VCC. One input (two pins) is dedicated to a
-remote temperature-sensing diode and an on-chip temperature sensor allows
-ambient temperature to be monitored.
-
-One specificity of this chip is that the pin 11 can be hardwired in two
-different manners. It can act as the +12V power-supply voltage analog
-input, or as the a fifth digital entry for the VID reading (bit 4). It's
-kind of strange since both are useful, and the reason for designing the
-chip that way is obscure at least to me. The bit 5 of the configuration
-register can be used to define how the chip is hardwired. Please note that
-it is not a choice you have to make as the user. The choice was already
-made by your motherboard's maker. If the configuration bit isn't set
-properly, you'll have a wrong +12V reading or a wrong VID reading. The way
-the driver handles that is to preserve this bit through the initialization
-process, assuming that the BIOS set it up properly beforehand. If it turns
-out not to be true in some cases, we'll provide a module parameter to force
-modes.
-
-This driver also supports the ADM1025A, which differs from the ADM1025
-only in that it has "open-drain VID inputs while the ADM1025 has on-chip
-100k pull-ups on the VID inputs". It doesn't make any difference for us.
diff --git a/Documentation/i2c/chips/adm1026 b/Documentation/i2c/chips/adm1=
026
deleted file mode 100644
--- a/Documentation/i2c/chips/adm1026
+++ /dev/null
@@ -1,93 +0,0 @@
-Kernel driver adm1026
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-
-Supported chips:
-  * Analog Devices ADM1026
-    Prefix: 'adm1026'
-    Addresses scanned: I2C 0x2c, 0x2d, 0x2e
-    Datasheet: Publicly available at the Analog Devices website
-               http://www.analog.com/en/prod/0,,766_825_ADM1026,00.html
-
-Authors:
-        Philip Pokorny <ppokorny@penguincomputing.com> for Penguin Computi=
ng
-        Justin Thiessen <jthiessen@penguincomputing.com>
-
-Module Parameters
------------------
-
-* gpio_input: int array (min =3D 1, max =3D 17)
-  List of GPIO pins (0-16) to program as inputs
-* gpio_output: int array (min =3D 1, max =3D 17)
-  List of GPIO pins (0-16) to program as outputs
-* gpio_inverted: int array (min =3D 1, max =3D 17)
-  List of GPIO pins (0-16) to program as inverted
-* gpio_normal: int array (min =3D 1, max =3D 17)
-  List of GPIO pins (0-16) to program as normal/non-inverted
-* gpio_fan: int array (min =3D 1, max =3D 8)
-  List of GPIO pins (0-7) to program as fan tachs
-
-
-Description
------------
-
-This driver implements support for the Analog Devices ADM1026. Analog
-Devices calls it a "complete thermal system management controller."
-
-The ADM1026 implements three (3) temperature sensors, 17 voltage sensors,
-16 general purpose digital I/O lines, eight (8) fan speed sensors (8-bit),
-an analog output and a PWM output along with limit, alarm and mask bits for
-all of the above. There is even 8k bytes of EEPROM memory on chip.
-
-Temperatures are measured in degrees Celsius. There are two external
-sensor inputs and one internal sensor. Each sensor has a high and low
-limit. If the limit is exceeded, an interrupt (#SMBALERT) can be
-generated. The interrupts can be masked. In addition, there are over-temp
-limits for each sensor. If this limit is exceeded, the #THERM output will
-be asserted. The current temperature and limits have a resolution of 1
-degree.
-
-Fan rotation speeds are reported in RPM (rotations per minute) but measured
-in counts of a 22.5kHz internal clock. Each fan has a high limit which
-corresponds to a minimum fan speed. If the limit is exceeded, an interrupt
-can be generated. Each fan can be programmed to divide the reference clock
-by 1, 2, 4 or 8. Not all RPM values can accurately be represented, so some
-rounding is done. With a divider of 8, the slowest measurable speed of a
-two pulse per revolution fan is 661 RPM.
-
-There are 17 voltage sensors. An alarm is triggered if the voltage has
-crossed a programmable minimum or maximum limit. Note that minimum in this
-case always means 'closest to zero'; this is important for negative voltage
-measurements. Several inputs have integrated attenuators so they can measu=
re
-higher voltages directly. 3.3V, 5V, 12V, -12V and battery voltage all have
-dedicated inputs. There are several inputs scaled to 0-3V full-scale range
-for SCSI terminator power. The remaining inputs are not scaled and have
-a 0-2.5V full-scale range. A 2.5V or 1.82V reference voltage is provided
-for negative voltage measurements.
-
-If an alarm triggers, it will remain triggered until the hardware register
-is read at least once. This means that the cause for the alarm may already
-have disappeared! Note that in the current implementation, all hardware
-registers are read whenever any data is read (unless it is less than 2.0
-seconds since the last update). This means that you can easily miss
-once-only alarms.
-
-The ADM1026 measures continuously. Analog inputs are measured about 4
-times a second. Fan speed measurement time depends on fan speed and
-divisor. It can take as long as 1.5 seconds to measure all fan speeds.
-
-The ADM1026 has the ability to automatically control fan speed based on the
-temperature sensor inputs. Both the PWM output and the DAC output can be
-used to control fan speed. Usually only one of these two outputs will be
-used. Write the minimum PWM or DAC value to the appropriate control
-register. Then set the low temperature limit in the tmin values for each
-temperature sensor. The range of control is fixed at 20 ?C, and the
-largest difference between current and tmin of the temperature sensors sets
-the control output. See the datasheet for several example circuits for
-controlling fan speed with the PWM and DAC outputs. The fan speed sensors
-do not have PWM compensation, so it is probably best to control the fan
-voltage from the power lead rather than on the ground lead.
-
-The datasheet shows an example application with VID signals attached to
-GPIO lines. Unfortunately, the chip may not be connected to the VID lines
-in this way. The driver assumes that the chips *is* connected this way to
-get a VID voltage.
diff --git a/Documentation/i2c/chips/adm1031 b/Documentation/i2c/chips/adm1=
031
deleted file mode 100644
--- a/Documentation/i2c/chips/adm1031
+++ /dev/null
@@ -1,35 +0,0 @@
-Kernel driver adm1031
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-
-Supported chips:
-  * Analog Devices ADM1030
-    Prefix: 'adm1030'
-    Addresses scanned: I2C 0x2c to 0x2e
-    Datasheet: Publicly available at the Analog Devices website
-               http://products.analog.com/products/info.asp?product=ADM1030
-
-  * Analog Devices ADM1031
-    Prefix: 'adm1031'
-    Addresses scanned: I2C 0x2c to 0x2e
-    Datasheet: Publicly available at the Analog Devices website
-               http://products.analog.com/products/info.asp?product=ADM1031
-
-Authors:
-        Alexandre d'Alton <alex@alexdalton.org>
-        Jean Delvare <khali@linux-fr.org>
-
-Description
------------
-
-The ADM1030 and ADM1031 are digital temperature sensors and fan controller=
s.
-They sense their own temperature as well as the temperature of up to one
-(ADM1030) or two (ADM1031) external diodes.
-
-All temperature values are given in degrees Celsius. Resolution is 0.5
-degree for the local temperature, 0.125 degree for the remote temperatures.
-
-Each temperature channel has its own high and low limits, plus a critical
-limit.
-
-The ADM1030 monitors a single fan speed, while the ADM1031 monitors up to
-two. Each fan channel has its own low speed limit.
diff --git a/Documentation/i2c/chips/adm9240 b/Documentation/i2c/chips/adm9=
240
deleted file mode 100644
--- a/Documentation/i2c/chips/adm9240
+++ /dev/null
@@ -1,177 +0,0 @@
-Kernel driver adm9240
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-
-Supported chips:
-  * Analog Devices ADM9240
-    Prefix: 'adm9240'
-    Addresses scanned: I2C 0x2c - 0x2f
-    Datasheet: Publicly available at the Analog Devices website
-    http://www.analog.com/UploadedFiles/Data_Sheets/79857778ADM9240_0.pdf
-
-  * Dallas Semiconductor DS1780
-    Prefix: 'ds1780'
-    Addresses scanned: I2C 0x2c - 0x2f
-    Datasheet: Publicly available at the Dallas Semiconductor (Maxim) webs=
ite
-    http://pdfserv.maxim-ic.com/en/ds/DS1780.pdf
-
-  * National Semiconductor LM81
-    Prefix: 'lm81'
-    Addresses scanned: I2C 0x2c - 0x2f
-    Datasheet: Publicly available at the National Semiconductor website
-    http://www.national.com/ds.cgi/LM/LM81.pdf
-
-Authors:
-    Frodo Looijaard <frodol@dds.nl>,
-    Philip Edelbrock <phil@netroedge.com>,
-    Michiel Rook <michiel@grendelproject.nl>,
-    Grant Coady <gcoady@gmail.com> with guidance
-        from Jean Delvare <khali@linux-fr.org>
-
-Interface
----------
-The I2C addresses listed above assume BIOS has not changed the
-chip MSB 5-bit address. Each chip reports a unique manufacturer
-identification code as well as the chip revision/stepping level.
-
-Description
------------
-[From ADM9240] The ADM9240 is a complete system hardware monitor for
-microprocessor-based systems, providing measurement and limit comparison
-of up to four power supplies and two processor core voltages, plus
-temperature, two fan speeds and chassis intrusion. Measured values can
-be read out via an I2C-compatible serial System Management Bus, and values
-for limit comparisons can be programmed in over the same serial bus. The
-high speed successive approximation ADC allows frequent sampling of all
-analog channels to ensure a fast interrupt response to any out-of-limit
-measurement.
-
-The ADM9240, DS1780 and LM81 are register compatible, the following
-details are common to the three chips. Chip differences are described
-after this section.
-
-
-Measurements
-------------
-The measurement cycle
-
-The adm9240 driver will take a measurement reading no faster than once
-each two seconds. User-space may read sysfs interface faster than the
-measurement update rate and will receive cached data from the most
-recent measurement.
-
-ADM9240 has a very fast 320us temperature and voltage measurement cycle
-with independent fan speed measurement cycles counting alternating rising
-edges of the fan tacho inputs.
-
-DS1780 measurement cycle is about once per second including fan speed.
-
-LM81 measurement cycle is about once per 400ms including fan speed.
-The LM81 12-bit extended temperature measurement mode is not supported.
-
-Temperature
------------
-On chip temperature is reported as degrees Celsius as 9-bit signed data
-with resolution of 0.5 degrees Celsius. High and low temperature limits
-are 8-bit signed data with resolution of one degree Celsius.
-
-Temperature alarm is asserted once the temperature exceeds the high limit,
-and is cleared when the temperature falls below the temp1_max_hyst value.
-
-Fan Speed
----------
-Two fan tacho inputs are provided, the ADM9240 gates an internal 22.5kHz
-clock via a divider to an 8-bit counter. Fan speed (rpm) is calculated by:
-
-rpm =3D (22500 * 60) / (count * divider)
-
-Automatic fan clock divider
-
-  * User sets 0 to fan_min limit
-    - low speed alarm is disabled
-    - fan clock divider not changed
-    - auto fan clock adjuster enabled for valid fan speed reading
-
-  * User sets fan_min limit too low
-    - low speed alarm is enabled
-    - fan clock divider set to max
-    - fan_min set to register value 254 which corresponds
-      to 664 rpm on adm9240
-    - low speed alarm will be asserted if fan speed is
-      less than minimum measurable speed
-    - auto fan clock adjuster disabled
-
-  * User sets reasonable fan speed
-    - low speed alarm is enabled
-    - fan clock divider set to suit fan_min
-    - auto fan clock adjuster enabled: adjusts fan_min
-
-  * User sets unreasonably high low fan speed limit
-    - resolution of the low speed limit may be reduced
-    - alarm will be asserted
-    - auto fan clock adjuster enabled: adjusts fan_min
-
-    * fan speed may be displayed as zero until the auto fan clock divider
-      adjuster brings fan speed clock divider back into chip measurement
-      range, this will occur within a few measurement cycles.
-
-Analog Output
--------------
-An analog output provides a 0 to 1.25 volt signal intended for an external
-fan speed amplifier circuit. The analog output is set to maximum value on
-power up or reset. This doesn't do much on the test Intel SE440BX-2.
-
-Voltage Monitor
-
-Voltage (IN) measurement is internally scaled:
-
-    nr  label       nominal     maximum   resolution
-                      mV          mV         mV
-    0   +2.5V        2500        3320       13.0
-    1   Vccp1        2700        3600       14.1
-    2   +3.3V        3300        4380       17.2
-    3     +5V        5000        6640       26.0
-    4    +12V       12000       15940       62.5
-    5   Vccp2        2700        3600       14.1
-
-The reading is an unsigned 8-bit value, nominal voltage measurement is
-represented by a reading of 192, being 3/4 of the measurement range.
-
-An alarm is asserted for any voltage going below or above the set limits.
-
-The driver reports and accepts voltage limits scaled to the above table.
-
-VID Monitor
------------
-The chip has five inputs to read the 5-bit VID and reports the mV value
-based on detected CPU type.
-
-Chassis Intrusion
------------------
-An alarm is asserted when the CI pin goes active high. The ADM9240
-Datasheet has an example of an external temperature sensor driving
-this pin. On an Intel SE440BX-2 the Chassis Intrusion header is
-connected to a normally open switch.
-
-The ADM9240 provides an internal open drain on this line, and may output
-a 20 ms active low pulse to reset an external Chassis Intrusion latch.
-
-Clear the CI latch by writing value 1 to the sysfs chassis_clear file.
-
-Alarm flags reported as 16-bit word
-
-    bit     label               comment
-    ---     -------------       --------------------------
-     0      +2.5 V_Error        high or low limit exceeded
-     1      VCCP_Error          high or low limit exceeded
-     2      +3.3 V_Error        high or low limit exceeded
-     3      +5 V_Error          high or low limit exceeded
-     4      Temp_Error          temperature error
-     6      FAN1_Error          fan low limit exceeded
-     7      FAN2_Error          fan low limit exceeded
-     8      +12 V_Error         high or low limit exceeded
-     9      VCCP2_Error         high or low limit exceeded
-    12      Chassis_Error       CI pin went high
-
-Remaining bits are reserved and thus undefined. It is important to note
-that alarm bits may be cleared on read, user-space may latch alarms and
-provide the end-user with a method to clear alarm memory.
diff --git a/Documentation/i2c/chips/asb100 b/Documentation/i2c/chips/asb100
deleted file mode 100644
--- a/Documentation/i2c/chips/asb100
+++ /dev/null
@@ -1,72 +0,0 @@
-Kernel driver asb100
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-Supported Chips:
-  * Asus ASB100 and ASB100-A "Bach"
-    Prefix: 'asb100'
-    Addresses scanned: I2C 0x2d
-    Datasheet: none released
-
-Author: Mark M. Hoffman <mhoffman@lightlink.com>
-
-Description
------------
-
-This driver implements support for the Asus ASB100 and ASB100-A "Bach".
-These are custom ASICs available only on Asus mainboards. Asus refuses to
-supply a datasheet for these chips. Thanks go to many people who helped
-investigate their hardware, including:
-
-Vitaly V. Bursov
-Alexander van Kaam (author of MBM for Windows)
-Bertrik Sikken
-
-The ASB100 implements seven voltage sensors, three fan rotation speed
-sensors, four temperature sensors, VID lines and alarms. In addition to
-these, the ASB100-A also implements a single PWM controller for fans 2 and
-3 (i.e. one setting controls both.) If you have a plain ASB100, the PWM
-controller will simply not work (or maybe it will for you... it doesn't for
-me).
-
-Temperatures are measured and reported in degrees Celsius.
-
-Fan speeds are reported in RPM (rotations per minute). An alarm is
-triggered if the rotation speed has dropped below a programmable limit.
-
-Voltage sensors (also known as IN sensors) report values in volts.
-
-The VID lines encode the core voltage value: the voltage level your
-processor should work with. This is hardcoded by the mainboard and/or
-processor itself. It is a value in volts.
-
-Alarms: (TODO question marks indicate may or may not work)
-
-0x0001 =3D> in0 (?)
-0x0002 =3D> in1 (?)
-0x0004 =3D> in2
-0x0008 =3D> in3
-0x0010 =3D> temp1 (1)
-0x0020 =3D> temp2
-0x0040 =3D> fan1
-0x0080 =3D> fan2
-0x0100 =3D> in4
-0x0200 =3D> in5 (?) (2)
-0x0400 =3D> in6 (?) (2)
-0x0800 =3D> fan3
-0x1000 =3D> chassis switch
-0x2000 =3D> temp3
-
-Alarm Notes:
-
-(1) This alarm will only trigger if the hysteresis value is 127C.
-I.e. it behaves the same as w83781d.
-
-(2) The min and max registers for these values appear to
-be read-only or otherwise stuck at 0x00.
-
-TODO:
-* Experiment with fan divisors > 8.
-* Experiment with temp. sensor types.
-* Are there really 13 voltage inputs? Probably not...
-* Cleanups, no doubt...
-
diff --git a/Documentation/i2c/chips/ds1621 b/Documentation/i2c/chips/ds1621
deleted file mode 100644
--- a/Documentation/i2c/chips/ds1621
+++ /dev/null
@@ -1,108 +0,0 @@
-Kernel driver ds1621
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-Supported chips:
-  * Dallas Semiconductor DS1621
-    Prefix: 'ds1621'
-    Addresses scanned: I2C 0x48 - 0x4f
-    Datasheet: Publicly available at the Dallas Semiconductor website
-               http://www.dalsemi.com/
-  * Dallas Semiconductor DS1625
-    Prefix: 'ds1621'
-    Addresses scanned: I2C 0x48 - 0x4f
-    Datasheet: Publicly available at the Dallas Semiconductor website
-               http://www.dalsemi.com/
-
-Authors:
-        Christian W. Zuckschwerdt <zany@triq.net>
-        valuable contributions by Jan M. Sendler <sendler@sendler.de>
-        ported to 2.6 by Aurelien Jarno <aurelien@aurel32.net>
-        with the help of Jean Delvare <khali@linux-fr.org>
-
-Module Parameters
-------------------
-
-* polarity int
-  Output's polarity: 0 =3D active high, 1 =3D active low
-
-Description
------------
-
-The DS1621 is a (one instance) digital thermometer and thermostat. It has
-both high and low temperature limits which can be user defined (i.e.
-programmed into non-volatile on-chip registers). Temperature range is -55
-degree Celsius to +125 in 0.5 increments. You may convert this into a
-Fahrenheit range of -67 to +257 degrees with 0.9 steps. If polarity
-parameter is not provided, original value is used.
-
-As for the thermostat, behavior can also be programmed using the polarity
-toggle. On the one hand ("heater"), the thermostat output of the chip,
-Tout, will trigger when the low limit temperature is met or underrun and
-stays high until the high limit is met or exceeded. On the other hand
-("cooler"), vice versa. That way "heater" equals "active low", whereas
-"conditioner" equals "active high". Please note that the DS1621 data sheet
-is somewhat misleading in this point since setting the polarity bit does
-not simply invert Tout.
-
-A second thing is that, during extensive testing, Tout showed a tolerance
-of up to +/- 0.5 degrees even when compared against precise temperature
-readings. Be sure to have a high vs. low temperature limit gap of al least
-1.0 degree Celsius to avoid Tout "bouncing", though!
-
-As for alarms, you can read the alarm status of the DS1621 via the 'alarms'
-/sys file interface. The result consists mainly of bit 6 and 5 of the
-configuration register of the chip; bit 6 (0x40 or 64) is the high alarm
-bit and bit 5 (0x20 or 32) the low one. These bits are set when the high or
-low limits are met or exceeded and are reset by the module as soon as the
-respective temperature ranges are left.
-
-The alarm registers are in no way suitable to find out about the actual
-status of Tout. They will only tell you about its history, whether or not
-any of the limits have ever been met or exceeded since last power-up or
-reset. Be aware: When testing, it showed that the status of Tout can change
-with neither of the alarms set.
-
-Temperature conversion of the DS1621 takes up to 1000ms; internal access to
-non-volatile registers may last for 10ms or below.
-
-High Accuracy Temperature Reading
----------------------------------
-
-As said before, the temperature issued via the 9-bit i2c-bus data is
-somewhat arbitrary. Internally, the temperature conversion is of a
-different kind that is explained (not so...) well in the DS1621 data sheet.
-To cut the long story short: Inside the DS1621 there are two oscillators,
-both of them biassed by a temperature coefficient.
-
-Higher resolution of the temperature reading can be achieved using the
-internal projection, which means taking account of REG_COUNT and REG_SLOPE
-(the driver manages them):
-
-Taken from Dallas Semiconductors App Note 068: 'Increasing Temperature
-Resolution on the DS1620' and App Note 105: 'High Resolution Temperature
-Measurement with Dallas Direct-to-Digital Temperature Sensors'
-
-- Read the 9-bit temperature and strip the LSB (Truncate the .5 degs)
-- The resulting value is TEMP_READ.
-- Then, read REG_COUNT.
-- And then, REG_SLOPE.
-
-      TEMP =3D TEMP_READ - 0.25 + ((REG_SLOPE - REG_COUNT) / REG_SLOPE)
-
-Note that this is what the DONE bit in the DS1621 configuration register is
-good for: Internally, one temperature conversion takes up to 1000ms. Before
-that conversion is complete you will not be able to read valid things out
-of REG_COUNT and REG_SLOPE. The DONE bit, as you may have guessed by now,
-tells you whether the conversion is complete ("done", in plain English) and
-thus, whether the values you read are good or not.
-
-The DS1621 has two modes of operation: "Continuous" conversion, which can
-be understood as the default stand-alone mode where the chip gets the
-temperature and controls external devices via its Tout pin or tells other
-i2c's about it if they care. The other mode is called "1SHOT", that means
-that it only figures out about the temperature when it is explicitly told
-to do so; this can be seen as power saving mode.
-
-Now if you want to read REG_COUNT and REG_SLOPE, you have to either stop
-the continuous conversions until the contents of these registers are valid,
-or, in 1SHOT mode, you have to have one conversion made.
diff --git a/Documentation/i2c/chips/fscher b/Documentation/i2c/chips/fscher
deleted file mode 100644
--- a/Documentation/i2c/chips/fscher
+++ /dev/null
@@ -1,169 +0,0 @@
-Kernel driver fscher
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-Supported chips:
-  * Fujitsu-Siemens Hermes chip
-    Prefix: 'fscher'
-    Addresses scanned: I2C 0x73
-
-Authors:
-        Reinhard Nissl <rnissl@gmx.de> based on work
-        from Hermann Jung <hej@odn.de>,
-        Frodo Looijaard <frodol@dds.nl>,
-        Philip Edelbrock <phil@netroedge.com>
-
-Description
------------
-
-This driver implements support for the Fujitsu-Siemens Hermes chip. It is
-described in the 'Register Set Specification BMC Hermes based Systemboard'
-from Fujitsu-Siemens.
-
-The Hermes chip implements a hardware-based system management, e.g. for
-controlling fan speed and core voltage. There is also a watchdog counter on
-the chip which can trigger an alarm and even shut the system down.
-
-The chip provides three temperature values (CPU, motherboard and
-auxiliary), three voltage values (+12V, +5V and battery) and three fans
-(power supply, CPU and auxiliary).
-
-Temperatures are measured in degrees Celsius. The resolution is 1 degree.
-
-Fan rotation speeds are reported in RPM (rotations per minute). The value
-can be divided by a programmable divider (1, 2 or 4) which is stored on
-the chip.
-
-Voltage sensors (also known as "in" sensors) report their values in volts.
-
-All values are reported as final values from the driver. There is no need
-for further calculations.
-
-
-Detailed description
---------------------
-
-Below you'll find a single line description of all the bit values. With
-this information, you're able to decode e. g. alarms, wdog, etc. To make
-use of the watchdog, you'll need to set the watchdog time and enable the
-watchdog. After that it is necessary to restart the watchdog time within
-the specified period of time, or a system reset will occur.
-
-* revision
-  READING & 0xff =3D 0x??: HERMES revision identification
-
-* alarms
-  READING & 0x80 =3D 0x80: CPU throttling active
-  READING & 0x80 =3D 0x00: CPU running at full speed
-
-  READING & 0x10 =3D 0x10: software event (see control:1)
-  READING & 0x10 =3D 0x00: no software event
-
-  READING & 0x08 =3D 0x08: watchdog event (see wdog:2)
-  READING & 0x08 =3D 0x00: no watchdog event
-
-  READING & 0x02 =3D 0x02: thermal event (see temp*:1)
-  READING & 0x02 =3D 0x00: no thermal event
-
-  READING & 0x01 =3D 0x01: fan event (see fan*:1)
-  READING & 0x01 =3D 0x00: no fan event
-
-  READING & 0x13 ! 0x00: ALERT LED is flashing
-
-* control
-  READING & 0x01 =3D 0x01: software event
-  READING & 0x01 =3D 0x00: no software event
-
-  WRITING & 0x01 =3D 0x01: set software event
-  WRITING & 0x01 =3D 0x00: clear software event
-
-* watchdog_control
-  READING & 0x80 =3D 0x80: power off on watchdog event while thermal event
-  READING & 0x80 =3D 0x00: watchdog power off disabled (just system reset =
enabled)
-
-  READING & 0x40 =3D 0x40: watchdog timebase 60 seconds (see also wdog:1)
-  READING & 0x40 =3D 0x00: watchdog timebase  2 seconds
-
-  READING & 0x10 =3D 0x10: watchdog enabled
-  READING & 0x10 =3D 0x00: watchdog disabled
-
-  WRITING & 0x80 =3D 0x80: enable "power off on watchdog event while therm=
al event"
-  WRITING & 0x80 =3D 0x00: disable "power off on watchdog event while ther=
mal event"
-
-  WRITING & 0x40 =3D 0x40: set watchdog timebase to 60 seconds
-  WRITING & 0x40 =3D 0x00: set watchdog timebase to  2 seconds
-
-  WRITING & 0x20 =3D 0x20: disable watchdog
-
-  WRITING & 0x10 =3D 0x10: enable watchdog / restart watchdog time
-
-* watchdog_state
-  READING & 0x02 =3D 0x02: watchdog system reset occurred
-  READING & 0x02 =3D 0x00: no watchdog system reset occurred
-
-  WRITING & 0x02 =3D 0x02: clear watchdog event
-
-* watchdog_preset
-  READING & 0xff =3D 0x??: configured watch dog time in units (see wdog:3 =
0x40)
-
-  WRITING & 0xff =3D 0x??: configure watch dog time in units
-
-* in*     (0: +5V, 1: +12V, 2: onboard 3V battery)
-  READING: actual voltage value
-
-* temp*_status   (1: CPU sensor, 2: onboard sensor, 3: auxiliary sensor)
-  READING & 0x02 =3D 0x02: thermal event (overtemperature)
-  READING & 0x02 =3D 0x00: no thermal event
-
-  READING & 0x01 =3D 0x01: sensor is working
-  READING & 0x01 =3D 0x00: sensor is faulty
-
-  WRITING & 0x02 =3D 0x02: clear thermal event
-
-* temp*_input   (1: CPU sensor, 2: onboard sensor, 3: auxiliary sensor)
-  READING: actual temperature value
-
-* fan*_status   (1: power supply fan, 2: CPU fan, 3: auxiliary fan)
-  READING & 0x04 =3D 0x04: fan event (fan fault)
-  READING & 0x04 =3D 0x00: no fan event
-
-  WRITING & 0x04 =3D 0x04: clear fan event
-
-* fan*_div (1: power supply fan, 2: CPU fan, 3: auxiliary fan)
-  	Divisors 2,4 and 8 are supported, both for reading and writing
-
-* fan*_pwm   (1: power supply fan, 2: CPU fan, 3: auxiliary fan)
-  READING & 0xff =3D 0x00: fan may be switched off
-  READING & 0xff =3D 0x01: fan must run at least at minimum speed (supply:=
 6V)
-  READING & 0xff =3D 0xff: fan must run at maximum speed (supply: 12V)
-  READING & 0xff =3D 0x??: fan must run at least at given speed (supply: 6=
V..12V)
-
-  WRITING & 0xff =3D 0x00: fan may be switched off
-  WRITING & 0xff =3D 0x01: fan must run at least at minimum speed (supply:=
 6V)
-  WRITING & 0xff =3D 0xff: fan must run at maximum speed (supply: 12V)
-  WRITING & 0xff =3D 0x??: fan must run at least at given speed (supply: 6=
V..12V)
-
-* fan*_input   (1: power supply fan, 2: CPU fan, 3: auxiliary fan)
-  READING: actual RPM value
-
-
-Limitations
------------
-
-* Measuring fan speed
-It seems that the chip counts "ripples" (typical fans produce 2 ripples per
-rotation while VERAX fans produce 18) in a 9-bit register. This register is
-read out every second, then the ripple prescaler (2, 4 or 8) is applied and
-the result is stored in the 8 bit output register. Due to the limitation of
-the counting register to 9 bits, it is impossible to measure a VERAX fan
-properly (even with a prescaler of 8). At its maximum speed of 3500 RPM the
-fan produces 1080 ripples per second which causes the counting register to
-overflow twice, leading to only 186 RPM.
-
-* Measuring input voltages
-in2 ("battery") reports the voltage of the onboard lithium battery and not
-+3.3V from the power supply.
-
-* Undocumented features
-Fujitsu-Siemens Computers has not documented all features of the chip so
-far. Their software, System Guard, shows that there are a still some
-features which cannot be controlled by this implementation.
diff --git a/Documentation/i2c/chips/gl518sm b/Documentation/i2c/chips/gl51=
8sm
deleted file mode 100644
--- a/Documentation/i2c/chips/gl518sm
+++ /dev/null
@@ -1,74 +0,0 @@
-Kernel driver gl518sm
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-
-Supported chips:
-  * Genesys Logic GL518SM release 0x00
-    Prefix: 'gl518sm'
-    Addresses scanned: I2C 0x2c and 0x2d
-    Datasheet: http://www.genesyslogic.com/pdf
-  * Genesys Logic GL518SM release 0x80
-    Prefix: 'gl518sm'
-    Addresses scanned: I2C 0x2c and 0x2d
-    Datasheet: http://www.genesyslogic.com/pdf
-
-Authors:
-        Frodo Looijaard <frodol@dds.nl>,
-        Ky?sti M?lkki <kmalkki@cc.hut.fi>
-        Hong-Gunn Chew <hglinux@gunnet.org>
-        Jean Delvare <khali@linux-fr.org>
-
-Description
------------
-
-IMPORTANT:
-
-For the revision 0x00 chip, the in0, in1, and in2  values (+5V, +3V,
-and +12V) CANNOT be read. This is a limitation of the chip, not the driver.
-
-This driver supports the Genesys Logic GL518SM chip. There are at least
-two revision of this chip, which we call revision 0x00 and 0x80. Revision
-0x80 chips support the reading of all voltages and revision 0x00 only
-for VIN3.
-
-The GL518SM implements one temperature sensor, two fan rotation speed
-sensors, and four voltage sensors. It can report alarms through the
-computer speakers.
-
-Temperatures are measured in degrees Celsius. An alarm goes off while the
-temperature is above the over temperature limit, and has not yet dropped
-below the hysteresis limit. The alarm always reflects the current
-situation. Measurements are guaranteed between -10 degrees and +110
-degrees, with a accuracy of +/-3 degrees.
-
-Rotation speeds are reported in RPM (rotations per minute). An alarm is
-triggered if the rotation speed has dropped below a programmable limit. In
-case when you have selected to turn fan1 off, no fan1 alarm is triggered.
-
-Fan readings can be divided by a programmable divider (1, 2, 4 or 8) to
-give the readings more range or accuracy.  Not all RPM values can
-accurately be represented, so some rounding is done. With a divider
-of 2, the lowest representable value is around 1900 RPM.
-
-Voltage sensors (also known as VIN sensors) report their values in volts.
-An alarm is triggered if the voltage has crossed a programmable minimum or
-maximum limit. Note that minimum in this case always means 'closest to
-zero'; this is important for negative voltage measurements. The VDD input
-measures voltages between 0.000 and 5.865 volt, with a resolution of 0.023
-volt. The other inputs measure voltages between 0.000 and 4.845 volt, with
-a resolution of 0.019 volt. Note that revision 0x00 chips do not support
-reading the current voltage of any input except for VIN3; limit setting and
-alarms work fine, though.
-
-When an alarm is triggered, you can be warned by a beeping signal through =
your
-computer speaker. It is possible to enable all beeping globally, or only t=
he
-beeping for some alarms.
-
-If an alarm triggers, it will remain triggered until the hardware register
-is read at least once (except for temperature alarms). This means that the
-cause for the alarm may already have disappeared! Note that in the current
-implementation, all hardware registers are read whenever any data is read
-(unless it is less than 1.5 seconds since the last update). This means that
-you can easily miss once-only alarms.
-
-The GL518SM only updates its values each 1.5 seconds; reading it more often
-will do no harm, but will return 'old' values.
diff --git a/Documentation/i2c/chips/it87 b/Documentation/i2c/chips/it87
deleted file mode 100644
--- a/Documentation/i2c/chips/it87
+++ /dev/null
@@ -1,96 +0,0 @@
-Kernel driver it87
-=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-Supported chips:
-  * IT8705F
-    Prefix: 'it87'
-    Addresses scanned: from Super I/O config space, or default ISA 0x290 (=
8 I/O ports)
-    Datasheet: Publicly available at the ITE website
-               http://www.ite.com.tw/
-  * IT8712F
-    Prefix: 'it8712'
-    Addresses scanned: I2C 0x28 - 0x2f
-                       from Super I/O config space, or default ISA 0x290 (=
8 I/O ports)
-    Datasheet: Publicly available at the ITE website
-               http://www.ite.com.tw/
-  * SiS950   [clone of IT8705F]
-    Prefix: 'sis950'
-    Addresses scanned: from Super I/O config space, or default ISA 0x290 (=
8 I/O ports)
-    Datasheet: No longer be available
-
-Author: Christophe Gauthron <chrisg@0-in.com>
-
-
-Module Parameters
------------------
-
-* update_vbat: int
-
-  0 if vbat should report power on value, 1 if vbat should be updated after
-  each read. Default is 0. On some boards the battery voltage is provided
-  by either the battery or the onboard power supply. Only the first reading
-  at power on will be the actual battery voltage (which the chip does
-  automatically). On other boards the battery voltage is always fed to
-  the chip so can be read at any time. Excessive reading may decrease
-  battery life but no information is given in the datasheet.
-
-* fix_pwm_polarity int
-
-  Force PWM polarity to active high (DANGEROUS). Some chips are
-  misconfigured by BIOS - PWM values would be inverted. This option tries
-  to fix this. Please contact your BIOS manufacturer and ask him for fix.
-
-Description
------------
-
-This driver implements support for the IT8705F, IT8712F and SiS950 chips.
-
-This driver also supports IT8712F, which adds SMBus access, and a VID
-input, used to report the Vcore voltage of the Pentium processor.
-The IT8712F additionally features VID inputs.
-
-These chips are 'Super I/O chips', supporting floppy disks, infrared ports,
-joysticks and other miscellaneous stuff. For hardware monitoring, they
-include an 'environment controller' with 3 temperature sensors, 3 fan
-rotation speed sensors, 8 voltage sensors, and associated alarms.
-
-Temperatures are measured in degrees Celsius. An alarm is triggered once
-when the Overtemperature Shutdown limit is crossed.
-
-Fan rotation speeds are reported in RPM (rotations per minute). An alarm is
-triggered if the rotation speed has dropped below a programmable limit. Fan
-readings can be divided by a programmable divider (1, 2, 4 or 8) to give t=
he
-readings more range or accuracy. Not all RPM values can accurately be
-represented, so some rounding is done. With a divider of 2, the lowest
-representable value is around 2600 RPM.
-
-Voltage sensors (also known as IN sensors) report their values in volts. An
-alarm is triggered if the voltage has crossed a programmable minimum or
-maximum limit. Note that minimum in this case always means 'closest to
-zero'; this is important for negative voltage measurements. All voltage
-inputs can measure voltages between 0 and 4.08 volts, with a resolution of
-0.016 volt. The battery voltage in8 does not have limit registers.
-
-The VID lines (IT8712F only) encode the core voltage value: the voltage
-level your processor should work with. This is hardcoded by the mainboard
-and/or processor itself. It is a value in volts.
-
-If an alarm triggers, it will remain triggered until the hardware register
-is read at least once. This means that the cause for the alarm may already
-have disappeared! Note that in the current implementation, all hardware
-registers are read whenever any data is read (unless it is less than 1.5
-seconds since the last update). This means that you can easily miss
-once-only alarms.
-
-The IT87xx only updates its values each 1.5 seconds; reading it more often
-will do no harm, but will return 'old' values.
-
-To change sensor N to a thermistor, 'echo 2 > tempN_type' where N is 1, 2,
-or 3. To change sensor N to a thermal diode, 'echo 3 > tempN_type'.
-Give 0 for unused sensor. Any other value is invalid. To configure this at
-startup, consult lm_sensors's /etc/sensors.conf. (2 =3D thermistor;
-3 =3D thermal diode)
-
-The fan speed control features are limited to manual PWM mode. Automatic
-"Smart Guardian" mode control handling is not implemented. However
-if you want to go for "manual mode" just write 1 to pwmN_enable.
diff --git a/Documentation/i2c/chips/lm63 b/Documentation/i2c/chips/lm63
deleted file mode 100644
--- a/Documentation/i2c/chips/lm63
+++ /dev/null
@@ -1,57 +0,0 @@
-Kernel driver lm63
-=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-Supported chips:
-  * National Semiconductor LM63
-    Prefix: 'lm63'
-    Addresses scanned: I2C 0x4c
-    Datasheet: Publicly available at the National Semiconductor website
-               http://www.national.com/pf/LM/LM63.html
-
-Author: Jean Delvare <khali@linux-fr.org>
-
-Thanks go to Tyan and especially Alex Buckingham for setting up a remote
-access to their S4882 test platform for this driver.
-  http://www.tyan.com/
-
-Description
------------
-
-The LM63 is a digital temperature sensor with integrated fan monitoring
-and control.
-
-The LM63 is basically an LM86 with fan speed monitoring and control
-capabilities added. It misses some of the LM86 features though:
- - No low limit for local temperature.
- - No critical limit for local temperature.
- - Critical limit for remote temperature can be changed only once. We
-   will consider that the critical limit is read-only.
-
-The datasheet isn't very clear about what the tachometer reading is.
-
-An explanation from National Semiconductor: The two lower bits of the read
-value have to be masked out. The value is still 16 bit in width.
-
-All temperature values are given in degrees Celsius. Resolution is 1.0
-degree for the local temperature, 0.125 degree for the remote temperature.
-
-The fan speed is measured using a tachometer. Contrary to most chips which
-store the value in an 8-bit register and have a selectable clock divider
-to make sure that the result will fit in the register, the LM63 uses 16-bit
-value for measuring the speed of the fan. It can measure fan speeds down to
-83 RPM, at least in theory.
-
-Note that the pin used for fan monitoring is shared with an alert out
-function. Depending on how the board designer wanted to use the chip, fan
-speed monitoring will or will not be possible. The proper chip configurati=
on
-is left to the BIOS, and the driver will blindly trust it.
-
-A PWM output can be used to control the speed of the fan. The LM63 has two
-PWM modes: manual and automatic. Automatic mode is not fully implemented y=
et
-(you cannot define your custom PWM/temperature curve), and mode change isn=
't
-supported either.
-
-The lm63 driver will not update its values more frequently than every
-second; reading them more often will do no harm, but will return 'old'
-values.
-
diff --git a/Documentation/i2c/chips/lm75 b/Documentation/i2c/chips/lm75
deleted file mode 100644
--- a/Documentation/i2c/chips/lm75
+++ /dev/null
@@ -1,65 +0,0 @@
-Kernel driver lm75
-=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-Supported chips:
-  * National Semiconductor LM75
-    Prefix: 'lm75'
-    Addresses scanned: I2C 0x48 - 0x4f
-    Datasheet: Publicly available at the National Semiconductor website
-               http://www.national.com/
-  * Dallas Semiconductor DS75
-    Prefix: 'lm75'
-    Addresses scanned: I2C 0x48 - 0x4f
-    Datasheet: Publicly available at the Dallas Semiconductor website
-               http://www.maxim-ic.com/
-  * Dallas Semiconductor DS1775
-    Prefix: 'lm75'
-    Addresses scanned: I2C 0x48 - 0x4f
-    Datasheet: Publicly available at the Dallas Semiconductor website
-               http://www.maxim-ic.com/
-  * Maxim MAX6625, MAX6626
-    Prefix: 'lm75'
-    Addresses scanned: I2C 0x48 - 0x4b
-    Datasheet: Publicly available at the Maxim website
-               http://www.maxim-ic.com/
-  * Microchip (TelCom) TCN75
-    Prefix: 'lm75'
-    Addresses scanned: I2C 0x48 - 0x4f
-    Datasheet: Publicly available at the Microchip website
-               http://www.microchip.com/
-
-Author: Frodo Looijaard <frodol@dds.nl>
-
-Description
------------
-
-The LM75 implements one temperature sensor. Limits can be set through the
-Overtemperature Shutdown register and Hysteresis register. Each value can =
be
-set and read to half-degree accuracy.
-An alarm is issued (usually to a connected LM78) when the temperature
-gets higher then the Overtemperature Shutdown value; it stays on until
-the temperature falls below the Hysteresis value.
-All temperatures are in degrees Celsius, and are guaranteed within a
-range of -55 to +125 degrees.
-
-The LM75 only updates its values each 1.5 seconds; reading it more often
-will do no harm, but will return 'old' values.
-
-The LM75 is usually used in combination with LM78-like chips, to measure
-the temperature of the processor(s).
-
-The DS75, DS1775, MAX6625, and MAX6626 are supported as well.
-They are not distinguished from an LM75. While most of these chips
-have three additional bits of accuracy (12 vs. 9 for the LM75),
-the additional bits are not supported. Not only that, but these chips will
-not be detected if not in 9-bit precision mode (use the force parameter if
-needed).
-
-The TCN75 is supported as well, and is not distinguished from an LM75.
-
-The LM75 is essentially an industry standard; there may be other
-LM75 clones not listed here, with or without various enhancements,
-that are supported.
-
-The LM77 is not supported, contrary to what we pretended for a long time.
-Both chips are simply not compatible, value encoding differs.
diff --git a/Documentation/i2c/chips/lm77 b/Documentation/i2c/chips/lm77
deleted file mode 100644
--- a/Documentation/i2c/chips/lm77
+++ /dev/null
@@ -1,22 +0,0 @@
-Kernel driver lm77
-=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-Supported chips:
-  * National Semiconductor LM77
-    Prefix: 'lm77'
-    Addresses scanned: I2C 0x48 - 0x4b
-    Datasheet: Publicly available at the National Semiconductor website
-               http://www.national.com/
-
-Author: Andras BALI <drewie@freemail.hu>
-
-Description
------------
-
-The LM77 implements one temperature sensor. The temperature
-sensor incorporates a band-gap type temperature sensor,
-10-bit ADC, and a digital comparator with user-programmable upper
-and lower limit values.
-
-Limits can be set through the Overtemperature Shutdown register and
-Hysteresis register.
diff --git a/Documentation/i2c/chips/lm78 b/Documentation/i2c/chips/lm78
deleted file mode 100644
--- a/Documentation/i2c/chips/lm78
+++ /dev/null
@@ -1,82 +0,0 @@
-Kernel driver lm78
-=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-Supported chips:
-  * National Semiconductor LM78
-    Prefix: 'lm78'
-    Addresses scanned: I2C 0x20 - 0x2f, ISA 0x290 (8 I/O ports)
-    Datasheet: Publicly available at the National Semiconductor website
-               http://www.national.com/
-  * National Semiconductor LM78-J
-    Prefix: 'lm78-j'
-    Addresses scanned: I2C 0x20 - 0x2f, ISA 0x290 (8 I/O ports)
-    Datasheet: Publicly available at the National Semiconductor website
-               http://www.national.com/
-  * National Semiconductor LM79
-    Prefix: 'lm79'
-    Addresses scanned: I2C 0x20 - 0x2f, ISA 0x290 (8 I/O ports)
-    Datasheet: Publicly available at the National Semiconductor website
-               http://www.national.com/
-
-Author: Frodo Looijaard <frodol@dds.nl>
-
-Description
------------
-
-This driver implements support for the National Semiconductor LM78, LM78-J
-and LM79. They are described as 'Microprocessor System Hardware Monitors'.
-
-There is almost no difference between the three supported chips. Functiona=
lly,
-the LM78 and LM78-J are exactly identical. The LM79 has one more VID line,
-which is used to report the lower voltages newer Pentium processors use.
-From here on, LM7* means either of these three types.
-
-The LM7* implements one temperature sensor, three fan rotation speed senso=
rs,
-seven voltage sensors, VID lines, alarms, and some miscellaneous stuff.
-
-Temperatures are measured in degrees Celsius. An alarm is triggered once
-when the Overtemperature Shutdown limit is crossed; it is triggered again
-as soon as it drops below the Hysteresis value. A more useful behavior
-can be found by setting the Hysteresis value to +127 degrees Celsius; in
-this case, alarms are issued during all the time when the actual temperatu=
re
-is above the Overtemperature Shutdown value. Measurements are guaranteed
-between -55 and +125 degrees, with a resolution of 1 degree.
-
-Fan rotation speeds are reported in RPM (rotations per minute). An alarm is
-triggered if the rotation speed has dropped below a programmable limit. Fan
-readings can be divided by a programmable divider (1, 2, 4 or 8) to give
-the readings more range or accuracy. Not all RPM values can accurately be
-represented, so some rounding is done. With a divider of 2, the lowest
-representable value is around 2600 RPM.
-
-Voltage sensors (also known as IN sensors) report their values in volts.
-An alarm is triggered if the voltage has crossed a programmable minimum
-or maximum limit. Note that minimum in this case always means 'closest to
-zero'; this is important for negative voltage measurements. All voltage
-inputs can measure voltages between 0 and 4.08 volts, with a resolution
-of 0.016 volt.
-
-The VID lines encode the core voltage value: the voltage level your proces=
sor
-should work with. This is hardcoded by the mainboard and/or processor itse=
lf.
-It is a value in volts. When it is unconnected, you will often find the
-value 3.50 V here.
-
-In addition to the alarms described above, there are a couple of additional
-ones. There is a BTI alarm, which gets triggered when an external chip has
-crossed its limits. Usually, this is connected to all LM75 chips; if at
-least one crosses its limits, this bit gets set. The CHAS alarm triggers
-if your computer case is open. The FIFO alarms should never trigger; it
-indicates an internal error. The SMI_IN alarm indicates some other chip
-has triggered an SMI interrupt. As we do not use SMI interrupts at all,
-this condition usually indicates there is a problem with some other
-device.
-
-If an alarm triggers, it will remain triggered until the hardware register
-is read at least once. This means that the cause for the alarm may
-already have disappeared! Note that in the current implementation, all
-hardware registers are read whenever any data is read (unless it is less
-than 1.5 seconds since the last update). This means that you can easily
-miss once-only alarms.
-
-The LM7* only updates its values each 1.5 seconds; reading it more often
-will do no harm, but will return 'old' values.
diff --git a/Documentation/i2c/chips/lm80 b/Documentation/i2c/chips/lm80
deleted file mode 100644
--- a/Documentation/i2c/chips/lm80
+++ /dev/null
@@ -1,56 +0,0 @@
-Kernel driver lm80
-=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-Supported chips:
-  * National Semiconductor LM80
-    Prefix: 'lm80'
-    Addresses scanned: I2C 0x28 - 0x2f
-    Datasheet: Publicly available at the National Semiconductor website
-               http://www.national.com/
-
-Authors:
-        Frodo Looijaard <frodol@dds.nl>,
-        Philip Edelbrock <phil@netroedge.com>
-
-Description
------------
-
-This driver implements support for the National Semiconductor LM80.
-It is described as a 'Serial Interface ACPI-Compatible Microprocessor
-System Hardware Monitor'.
-
-The LM80 implements one temperature sensor, two fan rotation speed sensors,
-seven voltage sensors, alarms, and some miscellaneous stuff.
-
-Temperatures are measured in degrees Celsius. There are two sets of limits
-which operate independently. When the HOT Temperature Limit is crossed,
-this will cause an alarm that will be reasserted until the temperature
-drops below the HOT Hysteresis. The Overtemperature Shutdown (OS) limits
-should work in the same way (but this must be checked; the datasheet
-is unclear about this). Measurements are guaranteed between -55 and
-+125 degrees. The current temperature measurement has a resolution of
-0.0625 degrees; the limits have a resolution of 1 degree.
-
-Fan rotation speeds are reported in RPM (rotations per minute). An alarm is
-triggered if the rotation speed has dropped below a programmable limit. Fan
-readings can be divided by a programmable divider (1, 2, 4 or 8) to give
-the readings more range or accuracy. Not all RPM values can accurately be
-represented, so some rounding is done. With a divider of 2, the lowest
-representable value is around 2600 RPM.
-
-Voltage sensors (also known as IN sensors) report their values in volts.
-An alarm is triggered if the voltage has crossed a programmable minimum
-or maximum limit. Note that minimum in this case always means 'closest to
-zero'; this is important for negative voltage measurements. All voltage
-inputs can measure voltages between 0 and 2.55 volts, with a resolution
-of 0.01 volt.
-
-If an alarm triggers, it will remain triggered until the hardware register
-is read at least once. This means that the cause for the alarm may
-already have disappeared! Note that in the current implementation, all
-hardware registers are read whenever any data is read (unless it is less
-than 2.0 seconds since the last update). This means that you can easily
-miss once-only alarms.
-
-The LM80 only updates its values each 1.5 seconds; reading it more often
-will do no harm, but will return 'old' values.
diff --git a/Documentation/i2c/chips/lm83 b/Documentation/i2c/chips/lm83
deleted file mode 100644
--- a/Documentation/i2c/chips/lm83
+++ /dev/null
@@ -1,76 +0,0 @@
-Kernel driver lm83
-=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-Supported chips:
-  * National Semiconductor LM83
-    Prefix: 'lm83'
-    Addresses scanned: I2C 0x18 - 0x1a, 0x29 - 0x2b, 0x4c - 0x4e
-    Datasheet: Publicly available at the National Semiconductor website
-               http://www.national.com/pf/LM/LM83.html
-
-
-Author: Jean Delvare <khali@linux-fr.org>
-
-Description
------------
-
-The LM83 is a digital temperature sensor. It senses its own temperature as
-well as the temperature of up to three external diodes. It is compatible
-with many other devices such as the LM84 and all other ADM1021 clones.
-The main difference between the LM83 and the LM84 in that the later can
-only sense the temperature of one external diode.
-
-Using the adm1021 driver for a LM83 should work, but only two temperatures
-will be reported instead of four.
-
-The LM83 is only found on a handful of motherboards. Both a confirmed
-list and an unconfirmed list follow. If you can confirm or infirm the
-fact that any of these motherboards do actually have an LM83, please
-contact us. Note that the LM90 can easily be misdetected as a LM83.
-
-Confirmed motherboards:
-    SBS         P014
-
-Unconfirmed motherboards:
-    Gigabyte    GA-8IK1100
-    Iwill       MPX2
-    Soltek      SL-75DRV5
-
-The driver has been successfully tested by Magnus Forsstr?m, who I'd
-like to thank here. More testers will be of course welcome.
-
-The fact that the LM83 is only scarcely used can be easily explained.
-Most motherboards come with more than just temperature sensors for
-health monitoring. They also have voltage and fan rotation speed
-sensors. This means that temperature-only chips are usually used as
-secondary chips coupled with another chip such as an IT8705F or similar
-chip, which provides more features. Since systems usually need three
-temperature sensors (motherboard, processor, power supply) and primary
-chips provide some temperature sensors, the secondary chip, if needed,
-won't have to handle more than two temperatures. Thus, ADM1021 clones
-are sufficient, and there is no need for a four temperatures sensor
-chip such as the LM83. The only case where using an LM83 would make
-sense is on SMP systems, such as the above-mentioned Iwill MPX2,
-because you want an additional temperature sensor for each additional
-CPU.
-
-On the SBS P014, this is different, since the LM83 is the only hardware
-monitoring chipset. One temperature sensor is used for the motherboard
-(actually measuring the LM83's own temperature), one is used for the
-CPU. The two other sensors must be used to measure the temperature of
-two other points of the motherboard. We suspect these points to be the
-north and south bridges, but this couldn't be confirmed.
-
-All temperature values are given in degrees Celsius. Local temperature
-is given within a range of 0 to +85 degrees. Remote temperatures are
-given within a range of 0 to +125 degrees. Resolution is 1.0 degree,
-accuracy is guaranteed to 3.0 degrees (see the datasheet for more
-details).
-
-Each sensor has its own high limit, but the critical limit is common to
-all four sensors. There is no hysteresis mechanism as found on most
-recent temperature sensors.
-
-The lm83 driver will not update its values more frequently than every
-other second; reading them more often will do no harm, but will return
-'old' values.
diff --git a/Documentation/i2c/chips/lm85 b/Documentation/i2c/chips/lm85
deleted file mode 100644
--- a/Documentation/i2c/chips/lm85
+++ /dev/null
@@ -1,221 +0,0 @@
-Kernel driver lm85
-=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-Supported chips:
-  * National Semiconductor LM85 (B and C versions)
-    Prefix: 'lm85'
-    Addresses scanned: I2C 0x2c, 0x2d, 0x2e
-    Datasheet: http://www.national.com/pf/LM/LM85.html
-  * Analog Devices ADM1027
-    Prefix: 'adm1027'
-    Addresses scanned: I2C 0x2c, 0x2d, 0x2e
-    Datasheet: http://www.analog.com/en/prod/0,,766_825_ADM1027,00.html
-  * Analog Devices ADT7463
-    Prefix: 'adt7463'
-    Addresses scanned: I2C 0x2c, 0x2d, 0x2e
-    Datasheet: http://www.analog.com/en/prod/0,,766_825_ADT7463,00.html
-  * SMSC EMC6D100, SMSC EMC6D101
-    Prefix: 'emc6d100'
-    Addresses scanned: I2C 0x2c, 0x2d, 0x2e
-    Datasheet: http://www.smsc.com/main/tools/discontinued/6d100.pdf
-  * SMSC EMC6D102
-    Prefix: 'emc6d102'
-    Addresses scanned: I2C 0x2c, 0x2d, 0x2e
-    Datasheet: http://www.smsc.com/main/catalog/emc6d102.html
-
-Authors:
-        Philip Pokorny <ppokorny@penguincomputing.com>,
-        Frodo Looijaard <frodol@dds.nl>,
-        Richard Barrington <rich_b_nz@clear.net.nz>,
-        Margit Schubert-While <margitsw@t-online.de>,
-        Justin Thiessen <jthiessen@penguincomputing.com>
-
-Description
------------
-
-This driver implements support for the National Semiconductor LM85 and
-compatible chips including the Analog Devices ADM1027, ADT7463 and
-SMSC EMC6D10x chips family.
-
-The LM85 uses the 2-wire interface compatible with the SMBUS 2.0
-specification. Using an analog to digital converter it measures three (3)
-temperatures and five (5) voltages. It has four (4) 16-bit counters for
-measuring fan speed. Five (5) digital inputs are provided for sampling the
-VID signals from the processor to the VRM. Lastly, there are three (3) PWM
-outputs that can be used to control fan speed.
-
-The voltage inputs have internal scaling resistors so that the following
-voltage can be measured without external resistors:
-
-  2.5V, 3.3V, 5V, 12V, and CPU core voltage (2.25V)
-
-The temperatures measured are one internal diode, and two remote diodes.
-Remote 1 is generally the CPU temperature. These inputs are designed to
-measure a thermal diode like the one in a Pentium 4 processor in a socket
-423 or socket 478 package. They can also measure temperature using a
-transistor like the 2N3904.
-
-A sophisticated control system for the PWM outputs is designed into the
-LM85 that allows fan speed to be adjusted automatically based on any of the
-three temperature sensors. Each PWM output is individually adjustable and
-programmable. Once configured, the LM85 will adjust the PWM outputs in
-response to the measured temperatures without further host intervention.
-This feature can also be disabled for manual control of the PWM's.
-
-Each of the measured inputs (voltage, temperature, fan speed) has
-corresponding high/low limit values. The LM85 will signal an ALARM if any
-measured value exceeds either limit.
-
-The LM85 samples all inputs continuously. The lm85 driver will not read
-the registers more often than once a second. Further, configuration data is
-only read once each 5 minutes. There is twice as much config data as
-measurements, so this would seem to be a worthwhile optimization.
-
-Special Features
-----------------
-
-The LM85 has four fan speed monitoring modes. The ADM1027 has only two.
-Both have special circuitry to compensate for PWM interactions with the
-TACH signal from the fans. The ADM1027 can be configured to measure the
-speed of a two wire fan, but the input conditioning circuitry is different
-for 3-wire and 2-wire mode. For this reason, the 2-wire fan modes are not
-exposed to user control. The BIOS should initialize them to the correct
-mode. If you've designed your own ADM1027, you'll have to modify the
-init_client function and add an insmod parameter to set this up.
-
-To smooth the response of fans to changes in temperature, the LM85 has an
-optional filter for smoothing temperatures. The ADM1027 has the same
-config option but uses it to rate limit the changes to fan speed instead.
-
-The ADM1027 and ADT7463 have a 10-bit ADC and can therefore measure
-temperatures with 0.25 degC resolution. They also provide an offset to the
-temperature readings that is automatically applied during measurement.
-This offset can be used to zero out any errors due to traces and placement.
-The documentation says that the offset is in 0.25 degC steps, but in
-initial testing of the ADM1027 it was 1.00 degC steps. Analog Devices has
-confirmed this "bug". The ADT7463 is reported to work as described in the
-documentation. The current lm85 driver does not show the offset register.
-
-The ADT7463 has a THERM asserted counter. This counter has a 22.76ms
-resolution and a range of 5.8 seconds. The driver implements a 32-bit
-accumulator of the counter value to extend the range to over a year. The
-counter will stay at it's max value until read.
-
-See the vendor datasheets for more information. There is application note
-from National (AN-1260) with some additional information about the LM85.
-The Analog Devices datasheet is very detailed and describes a procedure for
-determining an optimal configuration for the automatic PWM control.
-
-The SMSC EMC6D100 & EMC6D101 monitor external voltages, temperatures, and
-fan speeds. They use this monitoring capability to alert the system to out
-of limit conditions and can automatically control the speeds of multiple
-fans in a PC or embedded system. The EMC6D101, available in a 24-pin SSOP
-package, and the EMC6D100, available in a 28-pin SSOP package, are designed
-to be register compatible. The EMC6D100 offers all the features of the
-EMC6D101 plus additional voltage monitoring and system control features.
-Unfortunately it is not possible to distinguish between the package
-versions on register level so these additional voltage inputs may read
-zero. The EMC6D102 features addtional ADC bits thus extending precision
-of voltage and temperature channels.
-
-
-Hardware Configurations
------------------------
-
-The LM85 can be jumpered for 3 different SMBus addresses. There are
-no other hardware configuration options for the LM85.
-
-The lm85 driver detects both LM85B and LM85C revisions of the chip. See the
-datasheet for a complete description of the differences. Other than
-identifying the chip, the driver behaves no differently with regard to
-these two chips. The LM85B is recommended for new designs.
-
-The ADM1027 and ADT7463 chips have an optional SMBALERT output that can be
-used to signal the chipset in case a limit is exceeded or the temperature
-sensors fail. Individual sensor interrupts can be masked so they won't
-trigger SMBALERT. The SMBALERT output if configured replaces one of the ot=
her
-functions (PWM2 or IN0). This functionality is not implemented in current
-driver.
-
-The ADT7463 also has an optional THERM output/input which can be connected
-to the processor PROC_HOT output. If available, the autofan control
-dynamic Tmin feature can be enabled to keep the system temperature within
-spec (just?!) with the least possible fan noise.
-
-Configuration Notes
--------------------
-
-Besides standard interfaces driver adds following:
-
-* Temperatures and Zones
-
-Each temperature sensor is associated with a Zone. There are three
-sensors and therefore three zones (# 1, 2 and 3). Each zone has the follow=
ing
-temperature configuration points:
-
-* temp#_auto_temp_off - temperature below which fans should be off or spin=
ning very low.
-* temp#_auto_temp_min - temperature over which fans start to spin.
-* temp#_auto_temp_max - temperature when fans spin at full speed.
-* temp#_auto_temp_crit - temperature when all fans will run full speed.
-
-* PWM Control
-
-There are three PWM outputs. The LM85 datasheet suggests that the
-pwm3 output control both fan3 and fan4. Each PWM can be individually
-configured and assigned to a zone for it's control value. Each PWM can be
-configured individually according to the following options.
-
-* pwm#_auto_pwm_min - this specifies the PWM value for temp#_auto_temp_off
-                      temperature. (PWM value from 0 to 255)
-
-* pwm#_auto_pwm_freq - select base frequency of PWM output. You can select
-                       in range of 10.0 to 94.0 Hz in .1 Hz units.
-		       (Values 100 to 940).
-
-The pwm#_auto_pwm_freq can be set to one of the following 8 values. Settin=
g the
-frequency to a value not on this list, will result in the next higher freq=
uency
-being selected. The actual device frequency may vary slightly from this
-specification as designed by the manufacturer. Consult the datasheet for m=
ore
-details. (PWM Frequency values:  100, 150, 230, 300, 380, 470, 620, 940)
-
-* pwm#_auto_pwm_minctl - this flags selects for temp#_auto_temp_off temper=
ature
-                         the bahaviour of fans. Write 1 to let fans spinni=
ng at
-			 pwm#_auto_pwm_min or write 0 to let them off.
-
-NOTE: It has been reported that there is a bug in the LM85 that causes the=
 flag
-to be associated with the zones not the PWMs. This contradicts all the
-published documentation. Setting pwm#_min_ctl in this case actually affect=
s all
-PWMs controlled by zone '#'.
-
-* PWM Controlling Zone selection
-
-* pwm#_auto_channels - controls zone that is associated with PWM
-
-Configuration choices:
-
-   Value     Meaning
-  ------  ------------------------------------------------
-      1    Controlled by Zone 1
-      2    Controlled by Zone 2
-      3    Controlled by Zone 3
-     23    Controlled by higher temp of Zone 2 or 3
-    123    Controlled by highest temp of Zone 1, 2 or 3
-      0    PWM always 0%  (off)
-     -1    PWM always 100%  (full on)
-     -2    Manual control (write to 'pwm#' to set)
-
-The National LM85's have two vendor specific configuration
-features. Tach. mode and Spinup Control. For more details on these,
-see the LM85 datasheet or Application Note AN-1260.
-
-The Analog Devices ADM1027 has several vendor specific enhancements.
-The number of pulses-per-rev of the fans can be set, Tach monitoring
-can be optimized for PWM operation, and an offset can be applied to
-the temperatures to compensate for systemic errors in the
-measurements.
-
-In addition to the ADM1027 features, the ADT7463 also has Tmin control
-and THERM asserted counts. Automatic Tmin control acts to adjust the
-Tmin value to maintain the measured temperature sensor at a specified
-temperature. There isn't much documentation on this feature in the
-ADT7463 data sheet. This is not supported by current driver.
diff --git a/Documentation/i2c/chips/lm87 b/Documentation/i2c/chips/lm87
deleted file mode 100644
--- a/Documentation/i2c/chips/lm87
+++ /dev/null
@@ -1,73 +0,0 @@
-Kernel driver lm87
-=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-Supported chips:
-  * National Semiconductor LM87
-    Prefix: 'lm87'
-    Addresses scanned: I2C 0x2c - 0x2f
-    Datasheet: http://www.national.com/pf/LM/LM87.html
-
-Authors:
-        Frodo Looijaard <frodol@dds.nl>,
-        Philip Edelbrock <phil@netroedge.com>,
-        Mark Studebaker <mdsxyz123@yahoo.com>,
-        Stephen Rousset <stephen.rousset@rocketlogix.com>,
-        Dan Eaton <dan.eaton@rocketlogix.com>,
-        Jean Delvare <khali@linux-fr.org>,
-        Original 2.6 port Jeff Oliver
-
-Description
------------
-
-This driver implements support for the National Semiconductor LM87.
-
-The LM87 implements up to three temperature sensors, up to two fan
-rotation speed sensors, up to seven voltage sensors, alarms, and some
-miscellaneous stuff.
-
-Temperatures are measured in degrees Celsius. Each input has a high
-and low alarm settings. A high limit produces an alarm when the value
-goes above it, and an alarm is also produced when the value goes below
-the low limit.
-
-Fan rotation speeds are reported in RPM (rotations per minute). An alarm is
-triggered if the rotation speed has dropped below a programmable limit. Fan
-readings can be divided by a programmable divider (1, 2, 4 or 8) to give
-the readings more range or accuracy. Not all RPM values can accurately be
-represented, so some rounding is done. With a divider of 2, the lowest
-representable value is around 2600 RPM.
-
-Voltage sensors (also known as IN sensors) report their values in
-volts. An alarm is triggered if the voltage has crossed a programmable
-minimum or maximum limit. Note that minimum in this case always means
-'closest to zero'; this is important for negative voltage measurements.
-
-If an alarm triggers, it will remain triggered until the hardware register
-is read at least once. This means that the cause for the alarm may
-already have disappeared! Note that in the current implementation, all
-hardware registers are read whenever any data is read (unless it is less
-than 1.0 seconds since the last update). This means that you can easily
-miss once-only alarms.
-
-The lm87 driver only updates its values each 1.0 seconds; reading it more
-often will do no harm, but will return 'old' values.
-
-
-Hardware Configurations
------------------------
-
-The LM87 has four pins which can serve one of two possible functions,
-depending on the hardware configuration.
-
-Some functions share pins, so not all functions are available at the same
-time. Which are depends on the hardware setup. This driver assumes that
-the BIOS configured the chip correctly. In that respect, it differs from
-the original driver (from lm_sensors for Linux 2.4), which would force the
-LM87 to an arbitrary, compile-time chosen mode, regardless of the actual
-chipset wiring.
-
-For reference, here is the list of exclusive functions:
- - in0+in5 (default) or temp3
- - fan1 (default) or in6
- - fan2 (default) or in7
- - VID lines (default) or IRQ lines (not handled by this driver)
diff --git a/Documentation/i2c/chips/lm90 b/Documentation/i2c/chips/lm90
deleted file mode 100644
--- a/Documentation/i2c/chips/lm90
+++ /dev/null
@@ -1,121 +0,0 @@
-Kernel driver lm90
-=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-Supported chips:
-  * National Semiconductor LM90
-    Prefix: 'lm90'
-    Addresses scanned: I2C 0x4c
-    Datasheet: Publicly available at the National Semiconductor website
-               http://www.national.com/pf/LM/LM90.html
-  * National Semiconductor LM89
-    Prefix: 'lm99'
-    Addresses scanned: I2C 0x4c and 0x4d
-    Datasheet: Publicly available at the National Semiconductor website
-               http://www.national.com/pf/LM/LM89.html
-  * National Semiconductor LM99
-    Prefix: 'lm99'
-    Addresses scanned: I2C 0x4c and 0x4d
-    Datasheet: Publicly available at the National Semiconductor website
-               http://www.national.com/pf/LM/LM99.html
-  * National Semiconductor LM86
-    Prefix: 'lm86'
-    Addresses scanned: I2C 0x4c
-    Datasheet: Publicly available at the National Semiconductor website
-               http://www.national.com/pf/LM/LM86.html
-  * Analog Devices ADM1032
-    Prefix: 'adm1032'
-    Addresses scanned: I2C 0x4c
-    Datasheet: Publicly available at the Analog Devices website
-               http://products.analog.com/products/info.asp?product=ADM1032
-  * Analog Devices ADT7461
-    Prefix: 'adt7461'
-    Addresses scanned: I2C 0x4c
-    Datasheet: Publicly available at the Analog Devices website
-               http://products.analog.com/products/info.asp?product=ADT7461
-    Note: Only if in ADM1032 compatibility mode
-  * Maxim MAX6657
-    Prefix: 'max6657'
-    Addresses scanned: I2C 0x4c
-    Datasheet: Publicly available at the Maxim website
-               http://www.maxim-ic.com/quick_view2.cfm/qv_pk/2578
-  * Maxim MAX6658
-    Prefix: 'max6657'
-    Addresses scanned: I2C 0x4c
-    Datasheet: Publicly available at the Maxim website
-               http://www.maxim-ic.com/quick_view2.cfm/qv_pk/2578
-  * Maxim MAX6659
-    Prefix: 'max6657'
-    Addresses scanned: I2C 0x4c, 0x4d (unsupported 0x4e)
-    Datasheet: Publicly available at the Maxim website
-               http://www.maxim-ic.com/quick_view2.cfm/qv_pk/2578
-
-
-Author: Jean Delvare <khali@linux-fr.org>
-
-
-Description
------------
-
-The LM90 is a digital temperature sensor. It senses its own temperature as
-well as the temperature of up to one external diode. It is compatible
-with many other devices such as the LM86, the LM89, the LM99, the ADM1032,
-the MAX6657, MAX6658 and the MAX6659 all of which are supported by this dr=
iver.
-Note that there is no easy way to differentiate between the last three
-variants. The extra address and features of the MAX6659 are not supported =
by
-this driver. Additionally, the ADT7461 is supported if found in ADM1032
-compatibility mode.
-
-The specificity of this family of chipsets over the ADM1021/LM84
-family is that it features critical limits with hysteresis, and an
-increased resolution of the remote temperature measurement.
-
-The different chipsets of the family are not strictly identical, although
-very similar. This driver doesn't handle any specific feature for now,
-but could if there ever was a need for it. For reference, here comes a
-non-exhaustive list of specific features:
-
-LM90:
-  * Filter and alert configuration register at 0xBF.
-  * ALERT is triggered by temperatures over critical limits.
-
-LM86 and LM89:
-  * Same as LM90
-  * Better external channel accuracy
-
-LM99:
-  * Same as LM89
-  * External temperature shifted by 16 degrees down
-
-ADM1032:
-  * Consecutive alert register at 0x22.
-  * Conversion averaging.
-  * Up to 64 conversions/s.
-  * ALERT is triggered by open remote sensor.
-
-ADT7461
-  * Extended temperature range (breaks compatibility)
-  * Lower resolution for remote temperature
-
-MAX6657 and MAX6658:
-  * Remote sensor type selection
-
-MAX6659
-  * Selectable address
-  * Second critical temperature limit
-  * Remote sensor type selection
-
-All temperature values are given in degrees Celsius. Resolution
-is 1.0 degree for the local temperature, 0.125 degree for the remote
-temperature.
-
-Each sensor has its own high and low limits, plus a critical limit.
-Additionally, there is a relative hysteresis value common to both critical
-values. To make life easier to user-space applications, two absolute values
-are exported, one for each channel, but these values are of course linked.
-Only the local hysteresis can be set from user-space, and the same delta
-applies to the remote hysteresis.
-
-The lm90 driver will not update its values more frequently than every
-other second; reading them more often will do no harm, but will return
-'old' values.
-
diff --git a/Documentation/i2c/chips/lm92 b/Documentation/i2c/chips/lm92
deleted file mode 100644
--- a/Documentation/i2c/chips/lm92
+++ /dev/null
@@ -1,37 +0,0 @@
-Kernel driver lm92
-=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-Supported chips:
-  * National Semiconductor LM92
-    Prefix: 'lm92'
-    Addresses scanned: I2C 0x48 - 0x4b
-    Datasheet: http://www.national.com/pf/LM/LM92.html
-  * National Semiconductor LM76
-    Prefix: 'lm92'
-    Addresses scanned: none, force parameter needed
-    Datasheet: http://www.national.com/pf/LM/LM76.html
-  * Maxim MAX6633/MAX6634/MAX6635
-    Prefix: 'lm92'
-    Addresses scanned: I2C 0x48 - 0x4b
-    MAX6633 with address in 0x40 - 0x47, 0x4c - 0x4f needs force parameter
-    and MAX6634 with address in 0x4c - 0x4f needs force parameter
-    Datasheet: http://www.maxim-ic.com/quick_view2.cfm/qv_pk/3074
-
-Authors:
-        Abraham van der Merwe <abraham@2d3d.co.za>
-        Jean Delvare <khali@linux-fr.org>
-
-
-Description
------------
-
-This driver implements support for the National Semiconductor LM92
-temperature sensor.
-
-Each LM92 temperature sensor supports a single temperature sensor. There a=
re
-alarms for high, low, and critical thresholds. There's also an hysteresis =
to
-control the thresholds for resetting alarms.
-
-Support was added later for the LM76 and Maxim MAX6633/MAX6634/MAX6635,
-which are mostly compatible. They have not all been tested, so you
-may need to use the force parameter.
diff --git a/Documentation/i2c/chips/max1619 b/Documentation/i2c/chips/max1=
619
deleted file mode 100644
--- a/Documentation/i2c/chips/max1619
+++ /dev/null
@@ -1,29 +0,0 @@
-Kernel driver max1619
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-
-Supported chips:
-  * Maxim MAX1619
-    Prefix: 'max1619'
-    Addresses scanned: I2C 0x18-0x1a, 0x29-0x2b, 0x4c-0x4e
-    Datasheet: Publicly available at the Maxim website
-               http://pdfserv.maxim-ic.com/en/ds/MAX1619.pdf
-
-Authors:
-        Alexey Fisher <fishor@mail.ru>,
-        Jean Delvare <khali@linux-fr.org>
-
-Description
------------
-
-The MAX1619 is a digital temperature sensor. It senses its own temperature=
 as
-well as the temperature of up to one external diode.
-
-All temperature values are given in degrees Celsius. Resolution
-is 1.0 degree for the local temperature and for the remote temperature.
-
-Only the external sensor has high and low limits.
-
-The max1619 driver will not update its values more frequently than every
-other second; reading them more often will do no harm, but will return
-'old' values.
-
diff --git a/Documentation/i2c/chips/pc87360 b/Documentation/i2c/chips/pc87=
360
deleted file mode 100644
--- a/Documentation/i2c/chips/pc87360
+++ /dev/null
@@ -1,189 +0,0 @@
-Kernel driver pc87360
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-
-Supported chips:
-  * National Semiconductor PC87360, PC87363, PC87364, PC87365 and PC87366
-    Prefixes: 'pc87360', 'pc87363', 'pc87364', 'pc87365', 'pc87366'
-    Addresses scanned: none, address read from Super I/O config space
-    Datasheets:
-        http://www.national.com/pf/PC/PC87360.html
-        http://www.national.com/pf/PC/PC87363.html
-        http://www.national.com/pf/PC/PC87364.html
-        http://www.national.com/pf/PC/PC87365.html
-        http://www.national.com/pf/PC/PC87366.html
-
-Authors: Jean Delvare <khali@linux-fr.org>
-
-Thanks to Sandeep Mehta, Tonko de Rooy and Daniel Ceregatti for testing.
-Thanks to Rudolf Marek for helping me investigate conversion issues.
-
-
-Module Parameters
------------------
-
-* init int
-  Chip initialization level:
-   0: None
-  *1: Forcibly enable internal voltage and temperature channels, except in9
-   2: Forcibly enable all voltage and temperature channels, except in9
-   3: Forcibly enable all voltage and temperature channels, including in9
-
-Note that this parameter has no effect for the PC87360, PC87363 and PC87364
-chips.
-
-Also note that for the PC87366, initialization levels 2 and 3 don't enable
-all temperature channels, because some of them share pins with each other,
-so they can't be used at the same time.
-
-
-Description
------------
-
-The National Semiconductor PC87360 Super I/O chip contains monitoring and
-PWM control circuitry for two fans. The PC87363 chip is similar, and the
-PC87364 chip has monitoring and PWM control for a third fan.
-
-The National Semiconductor PC87365 and PC87366 Super I/O chips are complete
-hardware monitoring chipsets, not only controlling and monitoring three fa=
ns,
-but also monitoring eleven voltage inputs and two (PC87365) or up to four
-(PC87366) temperatures.
-
-  Chip        #vin    #fan    #pwm    #temp   devid
-
-  PC87360     -       2       2       -       0xE1
-  PC87363     -       2       2       -       0xE8
-  PC87364     -       3       3       -       0xE4
-  PC87365     11      3       3       2       0xE5
-  PC87366     11      3       3       3-4     0xE9
-
-The driver assumes that no more than one chip is present, and one of the
-standard Super I/O addresses is used (0x2E/0x2F or 0x4E/0x4F)
-
-Fan Monitoring
---------------
-
-Fan rotation speeds are reported in RPM (revolutions per minute). An alarm
-is triggered if the rotation speed has dropped below a programmable limit.
-A different alarm is triggered if the fan speed is too low to be measured.
-
-Fan readings are affected by a programmable clock divider, giving the
-readings more range or accuracy. Usually, users have to learn how it works,
-but this driver implements dynamic clock divider selection, so you don't
-have to care no more.
-
-For reference, here are a few values about clock dividers:
-
-                slowest         accuracy        highest
-                measurable      around 3000     accurate
-    divider     speed (RPM)     RPM (RPM)       speed (RPM)
-         1        1882              18           6928
-         2         941              37           4898
-         4         470              74           3464
-         8         235             150           2449
-
-For the curious, here is how the values above were computed:
- * slowest measurable speed: clock/(255*divider)
- * accuracy around 3000 RPM: 3000^2/clock
- * highest accurate speed: sqrt(clock*100)
-The clock speed for the PC87360 family is 480 kHz. I arbitrarily chose 100
-RPM as the lowest acceptable accuracy.
-
-As mentioned above, you don't have to care about this no more.
-
-Note that not all RPM values can be represented, even when the best clock
-divider is selected. This is not only true for the measured speeds, but
-also for the programmable low limits, so don't be surprised if you try to
-set, say, fan1_min to 2900 and it finally reads 2909.
-
-
-Fan Control
------------
-
-PWM (pulse width modulation) values range from 0 to 255, with 0 meaning
-that the fan is stopped, and 255 meaning that the fan goes at full speed.
-
-Be extremely careful when changing PWM values. Low PWM values, even
-non-zero, can stop the fan, which may cause irreversible damage to your
-hardware if temperature increases too much. When changing PWM values, go
-step by step and keep an eye on temperatures.
-
-One user reported problems with PWM. Changing PWM values would break fan
-speed readings. No explanation nor fix could be found.
-
-
-Temperature Monitoring
-----------------------
-
-Temperatures are reported in degrees Celsius. Each temperature measured has
-associated low, high and overtemperature limits, each of which triggers an
-alarm when crossed.
-
-The first two temperature channels are external. The third one (PC87366
-only) is internal.
-
-The PC87366 has three additional temperature channels, based on
-thermistors (as opposed to thermal diodes for the first three temperature
-channels). For technical reasons, these channels are held by the VLM
-(voltage level monitor) logical device, not the TMS (temperature
-measurement) one. As a consequence, these temperatures are exported as
-voltages, and converted into temperatures in user-space.
-
-Note that these three additional channels share their pins with the
-external thermal diode channels, so you (physically) can't use them all at
-the same time. Although it should be possible to mix the two sensor types,
-the documents from National Semiconductor suggest that motherboard
-manufacturers should choose one type and stick to it. So you will more
-likely have either channels 1 to 3 (thermal diodes) or 3 to 6 (internal
-thermal diode, and thermistors).
-
-
-Voltage Monitoring
-------------------
-
-Voltages are reported relatively to a reference voltage, either internal or
-external. Some of them (in7:Vsb, in8:Vdd and in10:AVdd) are divided by two
-internally, you will have to compensate in sensors.conf. Others (in0 to in=
6)
-are likely to be divided externally. The meaning of each of these inputs as
-well as the values of the resistors used for division is left to the
-motherboard manufacturers, so you will have to document yourself and edit
-sensors.conf accordingly. National Semiconductor has a document with
-recommended resistor values for some voltages, but this still leaves much
-room for per motherboard specificities, unfortunately. Even worse,
-motherboard manufacturers don't seem to care about National Semiconductor's
-recommendations.
-
-Each voltage measured has associated low and high limits, each of which
-triggers an alarm when crossed.
-
-When available, VID inputs are used to provide the nominal CPU Core voltag=
e.
-The driver will default to VRM 9.0, but this can be changed from user-spac=
e.
-The chipsets can handle two sets of VID inputs (on dual-CPU systems), but
-the driver will only export one for now. This may change later if there is
-a need.
-
-
-General Remarks
----------------
-
-If an alarm triggers, it will remain triggered until the hardware register
-is read at least once. This means that the cause for the alarm may already
-have disappeared! Note that all hardware registers are read whenever any
-data is read (unless it is less than 2 seconds since the last update, in
-which case cached values are returned instead). As a consequence, when
-a once-only alarm triggers, it may take 2 seconds for it to show, and 2
-more seconds for it to disappear.
-
-Monitoring of in9 isn't enabled at lower init levels (<3) because that
-channel measures the battery voltage (Vbat). It is a known fact that
-repeatedly sampling the battery voltage reduces its lifetime. National
-Semiconductor smartly designed their chipset so that in9 is sampled only
-once every 1024 sampling cycles (that is every 34 minutes at the default
-sampling rate), so the effect is attenuated, but still present.
-
-
-Limitations
------------
-
-The datasheets suggests that some values (fan mins, fan dividers)
-shouldn't be changed once the monitoring has started, but we ignore that
-recommendation. We'll reconsider if it actually causes trouble.
diff --git a/Documentation/i2c/chips/sis5595 b/Documentation/i2c/chips/sis5=
595
deleted file mode 100644
--- a/Documentation/i2c/chips/sis5595
+++ /dev/null
@@ -1,106 +0,0 @@
-Kernel driver sis5595
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-
-Supported chips:
-  * Silicon Integrated Systems Corp. SiS5595 Southbridge Hardware Monitor
-    Prefix: 'sis5595'
-    Addresses scanned: ISA in PCI-space encoded address
-    Datasheet: Publicly available at the Silicon Integrated Systems Corp. =
site.
-
-Authors:
-        Ky?sti M?lkki <kmalkki@cc.hut.fi>,
-        Mark D. Studebaker <mdsxyz123@yahoo.com>,
-        Aurelien Jarno <aurelien@aurel32.net> 2.6 port
-
-   SiS southbridge has a LM78-like chip integrated on the same IC.
-   This driver is a customized copy of lm78.c
-
-   Supports following revisions:
-       Version         PCI ID          PCI Revision
-       1               1039/0008       AF or less
-       2               1039/0008       B0 or greater
-
-   Note: these chips contain a 0008 device which is incompatible with the
-        5595. We recognize these by the presence of the listed
-        "blacklist" PCI ID and refuse to load.
-
-   NOT SUPPORTED       PCI ID          BLACKLIST PCI ID
-        540            0008            0540
-        550            0008            0550
-       5513            0008            5511
-       5581            0008            5597
-       5582            0008            5597
-       5597            0008            5597
-        630            0008            0630
-        645            0008            0645
-        730            0008            0730
-        735            0008            0735
-
-
-Module Parameters
------------------
-force_addr=3D0xaddr	Set the I/O base address. Useful for boards
-			that don't set the address in the BIOS. Does not do a
-			PCI force; the device must still be present in lspci.
-			Don't use this unless the driver complains that the
-			base address is not set.
-			Example: 'modprobe sis5595 force_addr=3D0x290'
-
-
-Description
------------
-
-The SiS5595 southbridge has integrated hardware monitor functions. It also
-has an I2C bus, but this driver only supports the hardware monitor. For the
-I2C bus driver see i2c-sis5595.
-
-The SiS5595 implements zero or one temperature sensor, two fan speed
-sensors, four or five voltage sensors, and alarms.
-
-On the first version of the chip, there are four voltage sensors and one
-temperature sensor.
-
-On the second version of the chip, the temperature sensor (temp) and the
-fifth voltage sensor (in4) share a pin which is configurable, but not
-through the driver. Sorry. The driver senses the configuration of the pin,
-which was hopefully set by the BIOS.
-
-Temperatures are measured in degrees Celsius. An alarm is triggered once
-when the max is crossed; it is also triggered when it drops below the min
-value. Measurements are guaranteed between -55 and +125 degrees, with a
-resolution of 1 degree.
-
-Fan rotation speeds are reported in RPM (rotations per minute). An alarm is
-triggered if the rotation speed has dropped below a programmable limit. Fan
-readings can be divided by a programmable divider (1, 2, 4 or 8) to give
-the readings more range or accuracy. Not all RPM values can accurately be
-represented, so some rounding is done. With a divider of 2, the lowest
-representable value is around 2600 RPM.
-
-Voltage sensors (also known as IN sensors) report their values in volts. An
-alarm is triggered if the voltage has crossed a programmable minimum or
-maximum limit. Note that minimum in this case always means 'closest to
-zero'; this is important for negative voltage measurements. All voltage
-inputs can measure voltages between 0 and 4.08 volts, with a resolution of
-0.016 volt.
-
-In addition to the alarms described above, there is a BTI alarm, which gets
-triggered when an external chip has crossed its limits. Usually, this is
-connected to some LM75-like chip; if at least one crosses its limits, this
-bit gets set.
-
-If an alarm triggers, it will remain triggered until the hardware register
-is read at least once. This means that the cause for the alarm may already
-have disappeared! Note that in the current implementation, all hardware
-registers are read whenever any data is read (unless it is less than 1.5
-seconds since the last update). This means that you can easily miss
-once-only alarms.
-
-The SiS5595 only updates its values each 1.5 seconds; reading it more often
-will do no harm, but will return 'old' values.
-
-Problems
---------
-Some chips refuse to be enabled. We don't know why.
-The driver will recognize this and print a message in dmesg.
-
diff --git a/Documentation/i2c/chips/smsc47b397 b/Documentation/i2c/chips/s=
msc47b397
deleted file mode 100644
--- a/Documentation/i2c/chips/smsc47b397
+++ /dev/null
@@ -1,158 +0,0 @@
-Kernel driver smsc47b397
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-Supported chips:
-  * SMSC LPC47B397-NC
-    Prefix: 'smsc47b397'
-    Addresses scanned: none, address read from Super I/O config space
-    Datasheet: In this file
-
-Authors: Mark M. Hoffman <mhoffman@lightlink.com>
-         Utilitek Systems, Inc.
-
-November 23, 2004
-
-The following specification describes the SMSC LPC47B397-NC sensor chip
-(for which there is no public datasheet available). This document was
-provided by Craig Kelly (In-Store Broadcast Network) and edited/corrected
-by Mark M. Hoffman <mhoffman@lightlink.com>.
-
-* * * * *
-
-Methods for detecting the HP SIO and reading the thermal data on a dc7100.
-
-The thermal information on the dc7100 is contained in the SIO Hardware Mon=
itor
-(HWM). The information is accessed through an index/data pair. The index/d=
ata
-pair is located at the HWM Base Address + 0 and the HWM Base Address + 1. =
The
-HWM Base address can be obtained from Logical Device 8, registers 0x60 (MS=
B)
-and 0x61 (LSB). Currently we are using 0x480 for the HWM Base Address and
-0x480 and 0x481 for the index/data pair.
-
-Reading temperature information.
-The temperature information is located in the following registers:
-Temp1		0x25	(Currently, this reflects the CPU temp on all systems).
-Temp2		0x26
-Temp3		0x27
-Temp4		0x80
-
-Programming Example
-The following is an example of how to read the HWM temperature registers:
-MOV	DX,480H
-MOV	AX,25H
-OUT	DX,AL
-MOV	DX,481H
-IN	AL,DX
-
-AL contains the data in hex, the temperature in Celsius is the decimal
-equivalent.
-
-Ex: If AL contains 0x2A, the temperature is 42 degrees C.
-
-Reading tach information.
-The fan speed information is located in the following registers:
-		LSB	MSB
-Tach1		0x28	0x29	(Currently, this reflects the CPU
-				fan speed on all systems).
-Tach2		0x2A	0x2B
-Tach3		0x2C	0x2D
-Tach4		0x2E	0x2F
-
-Important!!!
-Reading the tach LSB locks the tach MSB.
-The LSB Must be read first.
-
-How to convert the tach reading to RPM.
-The tach reading (TCount) is given by: (Tach MSB * 256) + (Tach LSB)
-The SIO counts the number of 90kHz (11.111us) pulses per revolution.
-RPM =3D 60/(TCount * 11.111us)
-
-Example:
-Reg 0x28 =3D 0x9B
-Reg 0x29 =3D 0x08
-
-TCount =3D 0x89B =3D 2203
-
-RPM =3D 60 / (2203 * 11.11111 E-6) =3D 2451 RPM
-
-Obtaining the SIO version.
-
-CONFIGURATION SEQUENCE
-To program the configuration registers, the following sequence must be fol=
lowed:
-1. Enter Configuration Mode
-2. Configure the Configuration Registers
-3. Exit Configuration Mode.
-
-Enter Configuration Mode
-To place the chip into the Configuration State The config key (0x55) is wr=
itten
-to the CONFIG PORT (0x2E).
-
-Configuration Mode
-In configuration mode, the INDEX PORT is located at the CONFIG PORT addres=
s and
-the DATA PORT is at INDEX PORT address + 1.
-
-The desired configuration registers are accessed in two steps:
-a.	Write the index of the Logical Device Number Configuration Register
-	(i.e., 0x07) to the INDEX PORT and then write the number of the
-	desired logical device to the DATA PORT.
-
-b.	Write the address of the desired configuration register within the
-	logical device to the INDEX PORT and then write or read the config-
-	uration register through the DATA PORT.
-
-Note: If accessing the Global Configuration Registers, step (a) is not req=
uired.
-
-Exit Configuration Mode
-To exit the Configuration State the write 0xAA to the CONFIG PORT (0x2E).
-The chip returns to the RUN State.  (This is important).
-
-Programming Example
-The following is an example of how to read the SIO Device ID located at 0x=
20
-
-; ENTER CONFIGURATION MODE
-MOV	DX,02EH
-MOV	AX,055H
-OUT	DX,AL
-; GLOBAL CONFIGURATION  REGISTER
-MOV	DX,02EH
-MOV	AL,20H
-OUT	DX,AL
-; READ THE DATA
-MOV	DX,02FH
-IN	AL,DX
-; EXIT CONFIGURATION MODE
-MOV	DX,02EH
-MOV	AX,0AAH
-OUT	DX,AL
-
-The registers of interest for identifying the SIO on the dc7100 are Device=
 ID
-(0x20) and Device Rev  (0x21).
-
-The Device ID will read 0X6F
-The Device Rev currently reads 0x01
-
-Obtaining the HWM Base Address.
-The following is an example of how to read the HWM Base Address located in
-Logical Device 8.
-
-; ENTER CONFIGURATION MODE
-MOV	DX,02EH
-MOV	AX,055H
-OUT	DX,AL
-; CONFIGURE REGISTER CRE0,
-; LOGICAL DEVICE 8
-MOV	DX,02EH
-MOV	AL,07H
-OUT	DX,AL ;Point to LD# Config Reg
-MOV	DX,02FH
-MOV	AL, 08H
-OUT	DX,AL;Point to Logical Device 8
-;
-MOV	DX,02EH
-MOV	AL,60H
-OUT	DX,AL	; Point to HWM Base Addr MSB
-MOV	DX,02FH
-IN	AL,DX	; Get MSB of HWM Base Addr
-; EXIT CONFIGURATION MODE
-MOV	DX,02EH
-MOV	AX,0AAH
-OUT	DX,AL
diff --git a/Documentation/i2c/chips/smsc47m1 b/Documentation/i2c/chips/sms=
c47m1
deleted file mode 100644
--- a/Documentation/i2c/chips/smsc47m1
+++ /dev/null
@@ -1,52 +0,0 @@
-Kernel driver smsc47m1
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-Supported chips:
-  * SMSC LPC47B27x, LPC47M10x, LPC47M13x, LPC47M14x, LPC47M15x and LPC47M1=
92
-    Addresses scanned: none, address read from Super I/O config space
-    Prefix: 'smsc47m1'
-    Datasheets:
-        http://www.smsc.com/main/datasheets/47b27x.pdf
-        http://www.smsc.com/main/datasheets/47m10x.pdf
-        http://www.smsc.com/main/tools/discontinued/47m13x.pdf
-        http://www.smsc.com/main/datasheets/47m14x.pdf
-        http://www.smsc.com/main/tools/discontinued/47m15x.pdf
-        http://www.smsc.com/main/datasheets/47m192.pdf
-
-Authors:
-        Mark D. Studebaker <mdsxyz123@yahoo.com>,
-        With assistance from Bruce Allen <ballen@uwm.edu>, and his
-        fan.c program: http://www.lsc-group.phys.uwm.edu/%7Eballen/driver/
-        Gabriele Gorla <gorlik@yahoo.com>,
-        Jean Delvare <khali@linux-fr.org>
-
-Description
------------
-
-The Standard Microsystems Corporation (SMSC) 47M1xx Super I/O chips
-contain monitoring and PWM control circuitry for two fans.
-
-The 47M15x and 47M192 chips contain a full 'hardware monitoring block'
-in addition to the fan monitoring and control. The hardware monitoring
-block is not supported by the driver.
-
-Fan rotation speeds are reported in RPM (rotations per minute). An alarm is
-triggered if the rotation speed has dropped below a programmable limit. Fan
-readings can be divided by a programmable divider (1, 2, 4 or 8) to give
-the readings more range or accuracy. Not all RPM values can accurately be
-represented, so some rounding is done. With a divider of 2, the lowest
-representable value is around 2600 RPM.
-
-PWM values are from 0 to 255.
-
-If an alarm triggers, it will remain triggered until the hardware register
-is read at least once. This means that the cause for the alarm may
-already have disappeared! Note that in the current implementation, all
-hardware registers are read whenever any data is read (unless it is less
-than 1.5 seconds since the last update). This means that you can easily
-miss once-only alarms.
-
-
-**********************
-The lm_sensors project gratefully acknowledges the support of
-Intel in the development of this driver.
diff --git a/Documentation/i2c/chips/via686a b/Documentation/i2c/chips/via6=
86a
deleted file mode 100644
--- a/Documentation/i2c/chips/via686a
+++ /dev/null
@@ -1,65 +0,0 @@
-Kernel driver via686a
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-
-Supported chips:
-  * Via VT82C686A, VT82C686B  Southbridge Integrated Hardware Monitor
-    Prefix: 'via686a'
-    Addresses scanned: ISA in PCI-space encoded address
-    Datasheet: On request through web form (http://www.via.com.tw/en/suppo=
rt/datasheets/)
-
-Authors:
-        Ky?sti M?lkki <kmalkki@cc.hut.fi>,
-        Mark D. Studebaker <mdsxyz123@yahoo.com>
-        Bob Dougherty <bobd@stanford.edu>
-        (Some conversion-factor data were contributed by
-        Jonathan Teh Soon Yew <j.teh@iname.com>
-        and Alex van Kaam <darkside@chello.nl>.)
-
-Module Parameters
------------------
-
-force_addr=3D0xaddr       Set the I/O base address. Useful for Asus A7V bo=
ards
-                        that don't set the address in the BIOS. Does not d=
o a
-                        PCI force; the via686a must still be present in ls=
pci.
-                        Don't use this unless the driver complains that the
-                        base address is not set.
-                        Example: 'modprobe via686a force_addr=3D0x6000'
-
-Description
------------
-
-The driver does not distinguish between the chips and reports
-all as a 686A.
-
-The Via 686a southbridge has integrated hardware monitor functionality.
-It also has an I2C bus, but this driver only supports the hardware monitor.
-For the I2C bus driver, see <file:Documentation/i2c/busses/i2c-viapro>
-
-The Via 686a implements three temperature sensors, two fan rotation speed
-sensors, five voltage sensors and alarms.
-
-Temperatures are measured in degrees Celsius. An alarm is triggered once
-when the Overtemperature Shutdown limit is crossed; it is triggered again
-as soon as it drops below the hysteresis value.
-
-Fan rotation speeds are reported in RPM (rotations per minute). An alarm is
-triggered if the rotation speed has dropped below a programmable limit. Fan
-readings can be divided by a programmable divider (1, 2, 4 or 8) to give
-the readings more range or accuracy. Not all RPM values can accurately be
-represented, so some rounding is done. With a divider of 2, the lowest
-representable value is around 2600 RPM.
-
-Voltage sensors (also known as IN sensors) report their values in volts.
-An alarm is triggered if the voltage has crossed a programmable minimum
-or maximum limit. Voltages are internally scalled, so each voltage channel
-has a different resolution and range.
-
-If an alarm triggers, it will remain triggered until the hardware register
-is read at least once. This means that the cause for the alarm may
-already have disappeared! Note that in the current implementation, all
-hardware registers are read whenever any data is read (unless it is less
-than 1.5 seconds since the last update). This means that you can easily
-miss once-only alarms.
-
-The driver only updates its values each 1.5 seconds; reading it more often
-will do no harm, but will return 'old' values.
diff --git a/Documentation/i2c/chips/w83627hf b/Documentation/i2c/chips/w83=
627hf
deleted file mode 100644
--- a/Documentation/i2c/chips/w83627hf
+++ /dev/null
@@ -1,66 +0,0 @@
-Kernel driver w83627hf
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-Supported chips:
-  * Winbond W83627HF (ISA accesses ONLY)
-    Prefix: 'w83627hf'
-    Addresses scanned: ISA address retrieved from Super I/O registers
-    Datasheet: http://www.winbond.com/PDF/sheet/w83627hf.pdf
-  * Winbond W83627THF
-    Prefix: 'w83627thf'
-    Addresses scanned: ISA address retrieved from Super I/O registers
-    Datasheet: http://www.winbond.com/PDF/sheet/w83627thf.pdf
-  * Winbond W83697HF
-    Prefix: 'w83697hf'
-    Addresses scanned: ISA address retrieved from Super I/O registers
-    Datasheet: http://www.winbond.com/PDF/sheet/697hf.pdf
-  * Winbond W83637HF
-    Prefix: 'w83637hf'
-    Addresses scanned: ISA address retrieved from Super I/O registers
-    Datasheet: http://www.winbond.com/PDF/sheet/w83637hf.pdf
-
-Authors:
-        Frodo Looijaard <frodol@dds.nl>,
-        Philip Edelbrock <phil@netroedge.com>,
-        Mark Studebaker <mdsxyz123@yahoo.com>,
-        Bernhard C. Schrenk <clemy@clemy.org>
-
-Module Parameters
------------------
-
-* force_addr: int
-  Initialize the ISA address of the sensors
-* force_i2c: int
-  Initialize the I2C address of the sensors
-* init: int
-  (default is 1)
-  Use 'init=3D0' to bypass initializing the chip.
-  Try this if your computer crashes when you load the module.
-
-Description
------------
-
-This driver implements support for ISA accesses *only* for
-the Winbond W83627HF, W83627THF, W83697HF and W83637HF Super I/O chips.
-We will refer to them collectively as Winbond chips.
-
-This driver supports ISA accesses, which should be more reliable
-than i2c accesses. Also, for Tyan boards which contain both a
-Super I/O chip and a second i2c-only Winbond chip (often a W83782D),
-using this driver will avoid i2c address conflicts and complex
-initialization that were required in the w83781d driver.
-
-If you really want i2c accesses for these Super I/O chips,
-use the w83781d driver. However this is not the preferred method
-now that this ISA driver has been developed.
-
-Technically, the w83627thf does not support a VID reading. However, it's
-possible or even likely that your mainboard maker has routed these signals
-to a specific set of general purpose IO pins (the Asus P4C800-E is one such
-board). The w83627thf driver now interprets these as VID. If the VID on
-your board doesn't work, first see doc/vid in the lm_sensors package. If
-that still doesn't help, email us at lm-sensors@lm-sensors.org.
-
-For further information on this driver see the w83781d driver
-documentation.
-
diff --git a/Documentation/i2c/chips/w83781d b/Documentation/i2c/chips/w837=
81d
deleted file mode 100644
--- a/Documentation/i2c/chips/w83781d
+++ /dev/null
@@ -1,402 +0,0 @@
-Kernel driver w83781d
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-
-Supported chips:
-  * Winbond W83781D
-    Prefix: 'w83781d'
-    Addresses scanned: I2C 0x20 - 0x2f, ISA 0x290 (8 I/O ports)
-    Datasheet: http://www.winbond-usa.com/products/winbond_products/pdfs/P=
CIC/w83781d.pdf
-  * Winbond W83782D
-    Prefix: 'w83782d'
-    Addresses scanned: I2C 0x20 - 0x2f, ISA 0x290 (8 I/O ports)
-    Datasheet: http://www.winbond.com/PDF/sheet/w83782d.pdf
-  * Winbond W83783S
-    Prefix: 'w83783s'
-    Addresses scanned: I2C 0x2d
-    Datasheet: http://www.winbond-usa.com/products/winbond_products/pdfs/P=
CIC/w83783s.pdf
-  * Winbond W83627HF
-    Prefix: 'w83627hf'
-    Addresses scanned: I2C 0x20 - 0x2f, ISA 0x290 (8 I/O ports)
-    Datasheet: http://www.winbond.com/PDF/sheet/w83627hf.pdf
-  * Asus AS99127F
-    Prefix: 'as99127f'
-    Addresses scanned: I2C 0x28 - 0x2f
-    Datasheet: Unavailable from Asus
-
-Authors:
-        Frodo Looijaard <frodol@dds.nl>,
-        Philip Edelbrock <phil@netroedge.com>,
-        Mark Studebaker <mdsxyz123@yahoo.com>
-
-Module parameters
------------------
-
-* init int
-  (default 1)
-  Use 'init=3D0' to bypass initializing the chip.
-  Try this if your computer crashes when you load the module.
-
-force_subclients=3Dbus,caddr,saddr,saddr
-  This is used to force the i2c addresses for subclients of
-  a certain chip. Typical usage is `force_subclients=3D0,0x2d,0x4a,0x4b'
-  to force the subclients of chip 0x2d on bus 0 to i2c addresses
-  0x4a and 0x4b. This parameter is useful for certain Tyan boards.
-
-Description
------------
-
-This driver implements support for the Winbond W83781D, W83782D, W83783S,
-W83627HF chips, and the Asus AS99127F chips. We will refer to them
-collectively as W8378* chips.
-
-There is quite some difference between these chips, but they are similar
-enough that it was sensible to put them together in one driver.
-The W83627HF chip is assumed to be identical to the ISA W83782D.
-The Asus chips are similar to an I2C-only W83782D.
-
-Chip        #vin    #fanin  #pwm    #temp   wchipid vendid  i2c     ISA
-as99127f    7       3       0       3       0x31    0x12c3  yes     no
-as99127f rev.2 (type_name =3D as99127f)       0x31    0x5ca3  yes     no
-w83781d     7       3       0       3       0x10-1  0x5ca3  yes     yes
-w83627hf    9       3       2       3       0x21    0x5ca3  yes     yes(LP=
C)
-w83782d     9       3       2-4     3       0x30    0x5ca3  yes     yes
-w83783s     5-6     3       2       1-2     0x40    0x5ca3  yes     no
-
-Detection of these chips can sometimes be foiled because they can be in
-an internal state that allows no clean access. If you know the address
-of the chip, use a 'force' parameter; this will put them into a more
-well-behaved state first.
-
-The W8378* implements temperature sensors (three on the W83781D and W83782=
D,
-two on the W83783S), three fan rotation speed sensors, voltage sensors
-(seven on the W83781D, nine on the W83782D and six on the W83783S), VID
-lines, alarms with beep warnings, and some miscellaneous stuff.
-
-Temperatures are measured in degrees Celsius. There is always one main
-temperature sensor, and one (W83783S) or two (W83781D and W83782D) other
-sensors. An alarm is triggered for the main sensor once when the
-Overtemperature Shutdown limit is crossed; it is triggered again as soon as
-it drops below the Hysteresis value. A more useful behavior
-can be found by setting the Hysteresis value to +127 degrees Celsius; in
-this case, alarms are issued during all the time when the actual temperatu=
re
-is above the Overtemperature Shutdown value. The driver sets the
-hysteresis value for temp1 to 127 at initialization.
-
-For the other temperature sensor(s), an alarm is triggered when the
-temperature gets higher then the Overtemperature Shutdown value; it stays
-on until the temperature falls below the Hysteresis value. But on the
-W83781D, there is only one alarm that functions for both other sensors!
-Temperatures are guaranteed within a range of -55 to +125 degrees. The
-main temperature sensors has a resolution of 1 degree; the other sensor(s)
-of 0.5 degree.
-
-Fan rotation speeds are reported in RPM (rotations per minute). An alarm is
-triggered if the rotation speed has dropped below a programmable limit. Fan
-readings can be divided by a programmable divider (1, 2, 4 or 8 for the
-W83781D; 1, 2, 4, 8, 16, 32, 64 or 128 for the others) to give
-the readings more range or accuracy. Not all RPM values can accurately
-be represented, so some rounding is done. With a divider of 2, the lowest
-representable value is around 2600 RPM.
-
-Voltage sensors (also known as IN sensors) report their values in volts.
-An alarm is triggered if the voltage has crossed a programmable minimum
-or maximum limit. Note that minimum in this case always means 'closest to
-zero'; this is important for negative voltage measurements. All voltage
-inputs can measure voltages between 0 and 4.08 volts, with a resolution
-of 0.016 volt.
-
-The VID lines encode the core voltage value: the voltage level your proces=
sor
-should work with. This is hardcoded by the mainboard and/or processor itse=
lf.
-It is a value in volts. When it is unconnected, you will often find the
-value 3.50 V here.
-
-The W83782D and W83783S temperature conversion machine understands about
-several kinds of temperature probes. You can program the so-called
-beta value in the sensor files. '1' is the PII/Celeron diode, '2' is the
-TN3904 transistor, and 3435 the default thermistor value. Other values
-are (not yet) supported.
-
-In addition to the alarms described above, there is a CHAS alarm on the
-chips which triggers if your computer case is open.
-
-When an alarm goes off, you can be warned by a beeping signal through
-your computer speaker. It is possible to enable all beeping globally,
-or only the beeping for some alarms.
-
-If an alarm triggers, it will remain triggered until the hardware register
-is read at least once. This means that the cause for the alarm may
-already have disappeared! Note that in the current implementation, all
-hardware registers are read whenever any data is read (unless it is less
-than 1.5 seconds since the last update). This means that you can easily
-miss once-only alarms.
-
-The chips only update values each 1.5 seconds; reading them more often
-will do no harm, but will return 'old' values.
-
-AS99127F PROBLEMS
------------------
-The as99127f support was developed without the benefit of a datasheet.
-In most cases it is treated as a w83781d (although revision 2 of the
-AS99127F looks more like a w83782d).
-This support will be BETA until a datasheet is released.
-One user has reported problems with fans stopping
-occasionally.
-
-Note that the individual beep bits are inverted from the other chips.
-The driver now takes care of this so that user-space applications
-don't have to know about it.
-
-Known problems:
-	- Problems with diode/thermistor settings (supported?)
-	- One user reports fans stopping under high server load.
-	- Revision 2 seems to have 2 PWM registers but we don't know
-	  how to handle them. More details below.
-
-These will not be fixed unless we get a datasheet.
-If you have problems, please lobby Asus to release a datasheet.
-Unfortunately several others have without success.
-Please do not send mail to us asking for better as99127f support.
-We have done the best we can without a datasheet.
-Please do not send mail to the author or the sensors group asking for
-a datasheet or ideas on how to convince Asus. We can't help.
-
-
-NOTES:
------
-  783s has no in1 so that in[2-6] are compatible with the 781d/782d.
-
-  783s pin is programmable for -5V or temp1; defaults to -5V,
-       no control in driver so temp1 doesn't work.
-
-  782d and 783s datasheets differ on which is pwm1 and which is pwm2.
-       We chose to follow 782d.
-
-  782d and 783s pin is programmable for fan3 input or pwm2 output;
-       defaults to fan3 input.
-       If pwm2 is enabled (with echo 255 1 > pwm2), then
-       fan3 will report 0.
-
-  782d has pwm1-2 for ISA, pwm1-4 for i2c. (pwm3-4 share pins with
-       the ISA pins)
-
-Data sheet updates:
-------------------
-	- PWM clock registers:
-
-		000: master /  512
-		001: master / 1024
-		010: master / 2048
-		011: master / 4096
-		100: master / 8192
-
-
-Answers from Winbond tech support
----------------------------------
->
-> 1) In the W83781D data sheet section 7.2 last paragraph, it talks about
->    reprogramming the R-T table if the Beta of the thermistor is not
->    3435K. The R-T table is described briefly in section 8.20.
->    What formulas do I use to program a new R-T table for a given Beta?
->
-	We are sorry that the calculation for R-T table value is
-confidential. If you have another Beta value of thermistor, we can help
-to calculate the R-T table for you. But you should give us real R-T
-Table which can be gotten by thermistor vendor. Therefore we will calculate
-them and obtain 32-byte data, and you can fill the 32-byte data to the
-register in Bank0.CR51 of W83781D.
-
-
-> 2) In the W83782D data sheet, it mentions that pins 38, 39, and 40 are
->    programmable to be either thermistor or Pentium II diode inputs.
->    How do I program them for diode inputs? I can't find any register
->    to program these to be diode inputs.
- --> You may program Bank0 CR[5Dh] and CR[59h] registers.
-
- 	CR[5Dh]    		bit 1(VTIN1)    bit 2(VTIN2)   bit 3(VTIN3)
-
-      	thermistor                0		 0		0
- 	diode 		          1		 1		1
-
-
-(error) CR[59h] 		bit 4(VTIN1)	bit 2(VTIN2)   bit 3(VTIN3)
-(right) CR[59h] 		bit 4(VTIN1)	bit 5(VTIN2)   bit 6(VTIN3)
-
- 	PII thermal diode         1		 1		1
- 	2N3904	diode	          0		 0		0
-
-
-Asus Clones
------------
-
-We have no datasheets for the Asus clones (AS99127F and ASB100 Bach).
-Here are some very useful information that were given to us by Alex Van
-Kaam about how to detect these chips, and how to read their values. He
-also gives advice for another Asus chipset, the Mozart-2 (which we
-don't support yet). Thanks Alex!
-I reworded some parts and added personal comments.
-
-# Detection:
-
-AS99127F rev.1, AS99127F rev.2 and ASB100:
-- I2C address range: 0x29 - 0x2F
-- If register 0x58 holds 0x31 then we have an Asus (either ASB100 or
-  AS99127F)
-- Which one depends on register 0x4F (manufacturer ID):
-  0x06 or 0x94: ASB100
-  0x12 or 0xC3: AS99127F rev.1
-  0x5C or 0xA3: AS99127F rev.2
-  Note that 0x5CA3 is Winbond's ID (WEC), which let us think Asus get their
-  AS99127F rev.2 direct from Winbond. The other codes mean ATT and DVC,
-  respectively. ATT could stand for Asustek something (although it would be
-  very badly chosen IMHO), I don't know what DVC could stand for. Maybe
-  these codes simply aren't meant to be decoded that way.
-
-Mozart-2:
-- I2C address: 0x77
-- If register 0x58 holds 0x56 or 0x10 then we have a Mozart-2
-- Of the Mozart there are 3 types:
-  0x58=3D0x56, 0x4E=3D0x94, 0x4F=3D0x36: Asus ASM58 Mozart-2
-  0x58=3D0x56, 0x4E=3D0x94, 0x4F=3D0x06: Asus AS2K129R Mozart-2
-  0x58=3D0x10, 0x4E=3D0x5C, 0x4F=3D0xA3: Asus ??? Mozart-2
-  You can handle all 3 the exact same way :)
-
-# Temperature sensors:
-
-ASB100:
-- sensor 1: register 0x27
-- sensor 2 & 3 are the 2 LM75's on the SMBus
-- sensor 4: register 0x17
-Remark: I noticed that on Intel boards sensor 2 is used for the CPU
-  and 4 is ignored/stuck, on AMD boards sensor 4 is the CPU and sensor 2 is
-  either ignored or a socket temperature.
-
-AS99127F (rev.1 and 2 alike):
-- sensor 1: register 0x27
-- sensor 2 & 3 are the 2 LM75's on the SMBus
-Remark: Register 0x5b is suspected to be temperature type selector. Bit 1
-  would control temp1, bit 3 temp2 and bit 5 temp3.
-
-Mozart-2:
-- sensor 1: register 0x27
-- sensor 2: register 0x13
-
-# Fan sensors:
-
-ASB100, AS99127F (rev.1 and 2 alike):
-- 3 fans, identical to the W83781D
-
-Mozart-2:
-- 2 fans only, 1350000/RPM/div
-- fan 1: register 0x28,  divisor on register 0xA1 (bits 4-5)
-- fan 2: register 0x29,  divisor on register 0xA1 (bits 6-7)
-
-# Voltages:
-
-This is where there is a difference between AS99127F rev.1 and 2.
-Remark: The difference is similar to the difference between
-  W83781D and W83782D.
-
-ASB100:
-in0=3Dr(0x20)*0.016
-in1=3Dr(0x21)*0.016
-in2=3Dr(0x22)*0.016
-in3=3Dr(0x23)*0.016*1.68
-in4=3Dr(0x24)*0.016*3.8
-in5=3Dr(0x25)*(-0.016)*3.97
-in6=3Dr(0x26)*(-0.016)*1.666
-
-AS99127F rev.1:
-in0=3Dr(0x20)*0.016
-in1=3Dr(0x21)*0.016
-in2=3Dr(0x22)*0.016
-in3=3Dr(0x23)*0.016*1.68
-in4=3Dr(0x24)*0.016*3.8
-in5=3Dr(0x25)*(-0.016)*3.97
-in6=3Dr(0x26)*(-0.016)*1.503
-
-AS99127F rev.2:
-in0=3Dr(0x20)*0.016
-in1=3Dr(0x21)*0.016
-in2=3Dr(0x22)*0.016
-in3=3Dr(0x23)*0.016*1.68
-in4=3Dr(0x24)*0.016*3.8
-in5=3D(r(0x25)*0.016-3.6)*5.14+3.6
-in6=3D(r(0x26)*0.016-3.6)*3.14+3.6
-
-Mozart-2:
-in0=3Dr(0x20)*0.016
-in1%5
-in2=3Dr(0x22)*0.016
-in3=3Dr(0x23)*0.016*1.68
-in4=3Dr(0x24)*0.016*4
-in5%5
-in6%5
-
-
-# PWM
-
-Additional info about PWM on the AS99127F (may apply to other Asus
-chips as well) by Jean Delvare as of 2004-04-09:
-
-AS99127F revision 2 seems to have two PWM registers at 0x59 and 0x5A,
-and a temperature sensor type selector at 0x5B (which basically means
-that they swapped registers 0x59 and 0x5B when you compare with Winbond
-chips).
-Revision 1 of the chip also has the temperature sensor type selector at
-0x5B, but PWM registers have no effect.
-
-We don't know exactly how the temperature sensor type selection works.
-Looks like bits 1-0 are for temp1, bits 3-2 for temp2 and bits 5-4 for
-temp3, although it is possible that only the most significant bit matters
-each time. So far, values other than 0 always broke the readings.
-
-PWM registers seem to be split in two parts: bit 7 is a mode selector,
-while the other bits seem to define a value or threshold.
-
-When bit 7 is clear, bits 6-0 seem to hold a threshold value. If the value
-is below a given limit, the fan runs at low speed. If the value is above
-the limit, the fan runs at full speed. We have no clue as to what the limit
-represents. Note that there seem to be some inertia in this mode, speed
-changes may need some time to trigger. Also, an hysteresis mechanism is
-suspected since walking through all the values increasingly and then
-decreasingly led to slightly different limits.
-
-When bit 7 is set, bits 3-0 seem to hold a threshold value, while bits 6-4
-would not be significant. If the value is below a given limit, the fan runs
-at full speed, while if it is above the limit it runs at low speed (so this
-is the contrary of the other mode, in a way). Here again, we don't know
-what the limit is supposed to represent.
-
-One remarkable thing is that the fans would only have two or three
-different speeds (transitional states left apart), not a whole range as
-you usually get with PWM.
-
-As a conclusion, you can write 0x00 or 0x8F to the PWM registers to make
-fans run at low speed, and 0x7F or 0x80 to make them run at full speed.
-
-Please contact us if you can figure out how it is supposed to work. As
-long as we don't know more, the w83781d driver doesn't handle PWM on
-AS99127F chips at all.
-
-Additional info about PWM on the AS99127F rev.1 by Hector Martin:
-
-I've been fiddling around with the (in)famous 0x59 register and
-found out the following values do work as a form of coarse pwm:
-
-0x80 - seems to turn fans off after some time(1-2 minutes)... might be
-some form of auto-fan-control based on temp? hmm (Qfan? this mobo is an
-old ASUS, it isn't marketed as Qfan. Maybe some beta pre-attemp at Qfan
-that was dropped at the BIOS)
-0x81 - off
-0x82 - slightly "on-ner" than off, but my fans do not get to move. I can
-hear the high-pitched PWM sound that motors give off at too-low-pwm.
-0x83 - now they do move. Estimate about 70% speed or so.
-0x84-0x8f - full on
-
-Changing the high nibble doesn't seem to do much except the high bit
-(0x80) must be set for PWM to work, else the current pwm doesn't seem to
-change.
-
-My mobo is an ASUS A7V266-E. This behavior is similar to what I got
-with speedfan under Windows, where 0-15% would be off, 15-2x% (can't
-remember the exact value) would be 70% and higher would be full on.
diff --git a/Documentation/i2c/chips/w83l785ts b/Documentation/i2c/chips/w8=
3l785ts
deleted file mode 100644
--- a/Documentation/i2c/chips/w83l785ts
+++ /dev/null
@@ -1,39 +0,0 @@
-Kernel driver w83l785ts
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-
-Supported chips:
-  * Winbond W83L785TS-S
-    Prefix: 'w83l785ts'
-    Addresses scanned: I2C 0x2e
-    Datasheet: Publicly available at the Winbond USA website
-               http://www.winbond-usa.com/products/winbond_products/pdfs/P=
CIC/W83L785TS-S.pdf
-
-Authors:
-        Jean Delvare <khali@linux-fr.org>
-
-Description
------------
-
-The W83L785TS-S is a digital temperature sensor. It senses the
-temperature of a single external diode. The high limit is
-theoretically defined as 85 or 100 degrees C through a combination
-of external resistors, so the user cannot change it. Values seen so
-far suggest that the two possible limits are actually 95 and 110
-degrees C. The datasheet is rather poor and obviously inaccurate
-on several points including this one.
-
-All temperature values are given in degrees Celsius. Resolution
-is 1.0 degree. See the datasheet for details.
-
-The w83l785ts driver will not update its values more frequently than
-every other second; reading them more often will do no harm, but will
-return 'old' values.
-
-Known Issues
-------------
-
-On some systems (Asus), the BIOS is known to interfere with the driver
-and cause read errors. The driver will retry a given number of times
-(5 by default) and then give up, returning the old value (or 0 if
-there is no old value). It seems to work well enough so that you should
-not notice anything. Thanks to James Bolt for helping test this feature.
diff --git a/Documentation/i2c/sysfs-interface b/Documentation/i2c/sysfs-in=
terface
deleted file mode 100644
--- a/Documentation/i2c/sysfs-interface
+++ /dev/null
@@ -1,274 +0,0 @@
-Naming and data format standards for sysfs files
-------------------------------------------------
-
-The libsensors library offers an interface to the raw sensors data
-through the sysfs interface. See libsensors documentation and source for
-more further information. As of writing this document, libsensors
-(from lm_sensors 2.8.3) is heavily chip-dependant. Adding or updating
-support for any given chip requires modifying the library's code.
-This is because libsensors was written for the procfs interface
-older kernel modules were using, which wasn't standardized enough.
-Recent versions of libsensors (from lm_sensors 2.8.2 and later) have
-support for the sysfs interface, though.
-
-The new sysfs interface was designed to be as chip-independant as
-possible.
-
-Note that motherboards vary widely in the connections to sensor chips.
-There is no standard that ensures, for example, that the second
-temperature sensor is connected to the CPU, or that the second fan is on
-the CPU. Also, some values reported by the chips need some computation
-before they make full sense. For example, most chips can only measure
-voltages between 0 and +4V. Other voltages are scaled back into that
-range using external resistors. Since the values of these resistors
-can change from motherboard to motherboard, the conversions cannot be
-hard coded into the driver and have to be done in user space.
-
-For this reason, even if we aim at a chip-independant libsensors, it will
-still require a configuration file (e.g. /etc/sensors.conf) for proper
-values conversion, labeling of inputs and hiding of unused inputs.
-
-An alternative method that some programs use is to access the sysfs
-files directly. This document briefly describes the standards that the
-drivers follow, so that an application program can scan for entries and
-access this data in a simple and consistent way. That said, such programs
-will have to implement conversion, labeling and hiding of inputs. For
-this reason, it is still not recommended to bypass the library.
-
-If you are developing a userspace application please send us feedback on
-this standard.
-
-Note that this standard isn't completely established yet, so it is subject
-to changes, even important ones. One more reason to use the library instead
-of accessing sysfs files directly.
-
-Each chip gets its own directory in the sysfs /sys/devices tree.  To
-find all sensor chips, it is easier to follow the symlinks from
-/sys/i2c/devices/
-
-All sysfs values are fixed point numbers.  To get the true value of some
-of the values, you should divide by the specified value.
-
-There is only one value per file, unlike the older /proc specification.
-The common scheme for files naming is: <type><number>_<item>. Usual
-types for sensor chips are "in" (voltage), "temp" (temperature) and
-"fan" (fan). Usual items are "input" (measured value), "max" (high
-threshold, "min" (low threshold). Numbering usually starts from 1,
-except for voltages which start from 0 (because most data sheets use
-this). A number is always used for elements that can be present more
-than once, even if there is a single element of the given type on the
-specific chip. Other files do not refer to a specific element, so
-they have a simple name, and no number.
-
-Alarms are direct indications read from the chips. The drivers do NOT
-make comparisons of readings to thresholds. This allows violations
-between readings to be caught and alarmed. The exact definition of an
-alarm (for example, whether a threshold must be met or must be exceeded
-to cause an alarm) is chip-dependent.
-
-
--------------------------------------------------------------------------
-
-************
-* Voltages *
-************
-
-in[0-8]_min	Voltage min value.
-		Unit: millivolt
-		Read/Write
-	=09
-in[0-8]_max	Voltage max value.
-		Unit: millivolt
-		Read/Write
-	=09
-in[0-8]_input	Voltage input value.
-		Unit: millivolt
-		Read only
-		Actual voltage depends on the scaling resistors on the
-		motherboard, as recommended in the chip datasheet.
-		This varies by chip and by motherboard.
-		Because of this variation, values are generally NOT scaled
-		by the chip driver, and must be done by the application.
-		However, some drivers (notably lm87 and via686a)
-		do scale, with various degrees of success.
-		These drivers will output the actual voltage.
-
-		Typical usage:
-			in0_*	CPU #1 voltage (not scaled)
-			in1_*	CPU #2 voltage (not scaled)
-			in2_*	3.3V nominal (not scaled)
-			in3_*	5.0V nominal (scaled)
-			in4_*	12.0V nominal (scaled)
-			in5_*	-12.0V nominal (scaled)
-			in6_*	-5.0V nominal (scaled)
-			in7_*	varies
-			in8_*	varies
-
-cpu[0-1]_vid	CPU core reference voltage.
-		Unit: millivolt
-		Read only.
-		Not always correct.
-
-vrm		Voltage Regulator Module version number.=20
-		Read only.
-		Two digit number, first is major version, second is
-		minor version.
-		Affects the way the driver calculates the CPU core reference
-		voltage from the vid pins.
-
-
-********
-* Fans *
-********
-
-fan[1-3]_min	Fan minimum value
-		Unit: revolution/min (RPM)
-		Read/Write.
-
-fan[1-3]_input	Fan input value.
-		Unit: revolution/min (RPM)
-		Read only.
-
-fan[1-3]_div	Fan divisor.
-		Integer value in powers of two (1, 2, 4, 8, 16, 32, 64, 128).
-		Some chips only support values 1, 2, 4 and 8.
-		Note that this is actually an internal clock divisor, which
-		affects the measurable speed range, not the read value.
-
-*******
-* PWM *
-*******
-
-pwm[1-3]	Pulse width modulation fan control.
-		Integer value in the range 0 to 255
-		Read/Write
-		255 is max or 100%.
-
-pwm[1-3]_enable
-		Switch PWM on and off.
-		Not always present even if fan*_pwm is.
-		0 to turn off
-		1 to turn on in manual mode
-		2 to turn on in automatic mode
-		Read/Write
-
-pwm[1-*]_auto_channels_temp
-		Select which temperature channels affect this PWM output in
-		auto mode. Bitfield, 1 is temp1, 2 is temp2, 4 is temp3 etc...
-		Which values are possible depend on the chip used.
-
-pwm[1-*]_auto_point[1-*]_pwm
-pwm[1-*]_auto_point[1-*]_temp
-pwm[1-*]_auto_point[1-*]_temp_hyst
-		Define the PWM vs temperature curve. Number of trip points is
-		chip-dependent. Use this for chips which associate trip points
-		to PWM output channels.
-
-OR
-
-temp[1-*]_auto_point[1-*]_pwm
-temp[1-*]_auto_point[1-*]_temp
-temp[1-*]_auto_point[1-*]_temp_hyst
-		Define the PWM vs temperature curve. Number of trip points is
-		chip-dependent. Use this for chips which associate trip points
-		to temperature channels.
-
-
-****************
-* Temperatures *
-****************
-
-temp[1-3]_type	Sensor type selection.
-		Integers 1, 2, 3 or thermistor Beta value (3435)
-		Read/Write.
-		1: PII/Celeron Diode
-		2: 3904 transistor
-		3: thermal diode
-		Not all types are supported by all chips
-
-temp[1-4]_max	Temperature max value.
-		Unit: millidegree Celcius
-		Read/Write value.
-
-temp[1-3]_min	Temperature min value.
-		Unit: millidegree Celcius
-		Read/Write value.
-
-temp[1-3]_max_hyst
-		Temperature hysteresis value for max limit.
-		Unit: millidegree Celcius
-		Must be reported as an absolute temperature, NOT a delta
-		from the max value.
-		Read/Write value.
-
-temp[1-4]_input Temperature input value.
-		Unit: millidegree Celcius
-		Read only value.
-
-temp[1-4]_crit	Temperature critical value, typically greater than
-		corresponding temp_max values.
-		Unit: millidegree Celcius
-		Read/Write value.
-
-temp[1-2]_crit_hyst
-		Temperature hysteresis value for critical limit.
-		Unit: millidegree Celcius
-		Must be reported as an absolute temperature, NOT a delta
-		from the critical value.
-		Read/Write value.
-
-		If there are multiple temperature sensors, temp1_* is
-		generally the sensor inside the chip itself,
-		reported as "motherboard temperature".  temp2_* to
-		temp4_* are generally sensors external to the chip
-		itself, for example the thermal diode inside the CPU or
-		a thermistor nearby.
-
-
-************
-* Currents *
-************
-
-Note that no known chip provides current measurements as of writing,
-so this part is theoretical, so to say.
-
-curr[1-n]_max	Current max value
-		Unit: milliampere
-		Read/Write.
-
-curr[1-n]_min	Current min value.
-		Unit: milliampere
-		Read/Write.
-
-curr[1-n]_input	Current input value
-		Unit: milliampere
-		Read only.
-
-
-*********
-* Other *
-*********
-
-alarms		Alarm bitmask.
-		Read only.
-		Integer representation of one to four bytes.
-		A '1' bit means an alarm.
-		Chips should be programmed for 'comparator' mode so that
-		the alarm will 'come back' after you read the register
-		if it is still valid.
-		Generally a direct representation of a chip's internal
-		alarm registers; there is no standard for the position
-		of individual bits.
-		Bits are defined in kernel/include/sensors.h.
-
-beep_enable	Beep/interrupt enable
-		0 to disable.
-		1 to enable.
-		Read/Write
-
-beep_mask	Bitmask for beep.
-		Same format as 'alarms' with the same bit locations.
-		Read/Write
-
-eeprom		Raw EEPROM data in binary form.
-		Read only.
diff --git a/Documentation/i2c/userspace-tools b/Documentation/i2c/userspac=
e-tools
deleted file mode 100644
--- a/Documentation/i2c/userspace-tools
+++ /dev/null
@@ -1,39 +0,0 @@
-Introduction
-------------
-
-Most mainboards have sensor chips to monitor system health (like temperatu=
res,
-voltages, fans speed). They are often connected through an I2C bus, but so=
me
-are also connected directly through the ISA bus.
-
-The kernel drivers make the data from the sensor chips available in the /s=
ys
-virtual filesystem. Userspace tools are then used to display or set or the
-data in a more friendly manner.
-
-Lm-sensors
-----------
-
-Core set of utilites that will allow you to obtain health information,
-setup monitoring limits etc. You can get them on their homepage
-http://www.lm-sensors.nu/ or as a package from your Linux distribution.
-
-If from website:
-Get lmsensors from project web site. Please note, you need only userspace
-part, so compile with "make user_install" target.
-
-General hints to get things working:
-
-0) get lm-sensors userspace utils
-1) compile all drivers in I2C section as modules in your kernel
-2) run sensors-detect script, it will tell you what modules you need to lo=
ad.
-3) load them and run "sensors" command, you should see some results.
-4) fix sensors.conf, labels, limits, fan divisors
-5) if any more problems consult FAQ, or documentation
-
-Other utilites
---------------
-
-If you want some graphical indicators of system health look for applicatio=
ns
-like: gkrellm, ksensors, xsensors, wmtemp, wmsensors, wmgtemp, ksysguardd,
-hardware-monitor
-
-If you are server administrator you can try snmpd or mrtgutils.

