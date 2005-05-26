From: R.Marek@sh.cvut.cz (R.Marek@sh.cvut.cz)
Date: Thu, 26 May 2005 14:48:01 +0000
Subject: [lm-sensors] [PATCH 2/3] I2C documentation update
Message-Id: <20050526124219.5162.qmail@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello,

This patch adds missing documentation for system health monitoring chips.
I would like to thank all people, who helped me with this project.

Signed-Off-By: Rudolf Marek <r.marek@sh.cvut.cz>

Please apply. It should apply against 2.6.12-rc5 or -mm-.

Thanks,
Regards

Rudolf


diff -Naur c/Documentation/i2c/chips/adm1021 d/Documentation/i2c/chips/adm1=
021
--- c/Documentation/i2c/chips/adm1021	1970-01-01 01:00:00.000000000 +0100
+++ d/Documentation/i2c/chips/adm1021	2005-05-23 21:35:04.000000000 +0200
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
+Each sensor has its own low and high limits. When they are crossed, the=20
+corresponding alarm is set and remains on as long as the temperature stays=
=20
+out of range. Temperatures are measured in degrees Celsius. Measurements=20
+are possible between -65 and +127 degrees, with a resolution of one degree.
+
+If an alarm triggers, it will remain triggered until the hardware register
+is read at least once. This means that the cause for the alarm may already
+have disappeared!
+
+This driver only updates its values each 1.5 seconds; reading it more often
+will do no harm, but will return 'old' values. It is possible to make=20
+ADM1021-clones do faster measurements, but there is really no good reason
+for that.
+
+Xeon support=20
+------------=20
+
+Some Xeon processors have real max1617, adm1021, or compatible chips=20
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
diff -Naur c/Documentation/i2c/chips/adm1025 d/Documentation/i2c/chips/adm1=
025
--- c/Documentation/i2c/chips/adm1025	1970-01-01 01:00:00.000000000 +0100
+++ d/Documentation/i2c/chips/adm1025	2005-05-23 21:35:12.000000000 +0200
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
+Authors:=20
+        Chen-Yuan Wu <gwu@esoft.com>,=20
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
+This driver also supports the ADM1025A, which differs from the ADM1025=20
+only in that it has "open-drain VID inputs while the ADM1025 has on-chip
+100k pull-ups on the VID inputs". It doesn't make any difference for us.=20
diff -Naur c/Documentation/i2c/chips/adm1026 d/Documentation/i2c/chips/adm1=
026
--- c/Documentation/i2c/chips/adm1026	1970-01-01 01:00:00.000000000 +0100
+++ d/Documentation/i2c/chips/adm1026	2005-05-23 21:35:25.000000000 +0200
@@ -0,0 +1,93 @@
+Kernel driver adm1026
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
+Supported chips:
+  * Analog Devices ADM1026
+    Prefix: 'adm1026'
+    Addresses scanned: I2C 0x2c, 0x2d, 0x2e
+    Datasheet: Publicly available at the Analog Devices website
+               http://www.analog.com/en/prod/0,,766_825_ADM1026,00.html
+	=09
+Authors:=20
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
+two pulse per revolution fan is 661 RPM.=20
+
+There are 17 voltage sensors. An alarm is triggered if the voltage has
+crossed a programmable minimum or maximum limit. Note that minimum in this
+case always means 'closest to zero'; this is important for negative voltage
+measurements. Several inputs have integrated attenuators so they can measu=
re=20
+higher voltages directly. 3.3V, 5V, 12V, -12V and battery voltage all have=
=20
+dedicated inputs. There are several inputs scaled to 0-3V full-scale range=
=20
+for SCSI terminator power. The remaining inputs are not scaled and have=20
+a 0-2.5V full-scale range. A 2.5V or 1.82V reference voltage is provided=20
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
+temperature sensor. The range of control is fixed at 20 =B0C, and the
+largest difference between current and tmin of the temperature sensors sets
+the control output. See the datasheet for several example circuits for
+controlling fan speed with the PWM and DAC outputs. The fan speed sensors
+do not have PWM compensation, so it is probably best to control the fan
+voltage from the power lead rather than on the ground lead.
+
+The datasheet shows an example application with VID signals attached to
+GPIO lines. Unfortunately, the chip may not be connected to the VID lines
+in this way. The driver assumes that the chips *is* connected this way to
+get a VID voltage.=20
diff -Naur c/Documentation/i2c/chips/adm1031 d/Documentation/i2c/chips/adm1=
031
--- c/Documentation/i2c/chips/adm1031	1970-01-01 01:00:00.000000000 +0100
+++ d/Documentation/i2c/chips/adm1031	2005-05-23 21:35:38.000000000 +0200
@@ -0,0 +1,35 @@
+Kernel driver adm1031
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
+Supported chips:=20
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
+Authors:=20
+        Alexandre d'Alton <alex@alexdalton.org>
+        Jean Delvare <khali@linux-fr.org>=20
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
diff -Naur c/Documentation/i2c/chips/asb100 d/Documentation/i2c/chips/asb100
--- c/Documentation/i2c/chips/asb100	1970-01-01 01:00:00.000000000 +0100
+++ d/Documentation/i2c/chips/asb100	2005-05-23 20:59:03.000000000 +0200
@@ -0,0 +1,72 @@
+Kernel driver asb100
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Supported Chips:
+  * Asus ASB100 and ASB100-A "Bach"
+    Prefix: 'asb100'
+    Addresses scanned: I2C 0x2d=20
+    Datasheet: none released
+
+Author: Mark M. Hoffman <mhoffman@lightlink.com>
+
+Description
+-----------
+
+This driver implements support for the Asus ASB100 and ASB100-A "Bach".=20
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
diff -Naur c/Documentation/i2c/chips/ds1621 d/Documentation/i2c/chips/ds1621
--- c/Documentation/i2c/chips/ds1621	1970-01-01 01:00:00.000000000 +0100
+++ d/Documentation/i2c/chips/ds1621	2005-05-23 21:35:53.000000000 +0200
@@ -0,0 +1,108 @@
+Kernel driver ds1621
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Supported chips:=20
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
+Authors:=20
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
+ =20
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
diff -Naur c/Documentation/i2c/chips/eeprom d/Documentation/i2c/chips/eeprom
--- c/Documentation/i2c/chips/eeprom	1970-01-01 01:00:00.000000000 +0100
+++ d/Documentation/i2c/chips/eeprom	2005-05-23 21:36:08.000000000 +0200
@@ -0,0 +1,96 @@
+Kernel driver eeprom
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Supported chips:
+  * Any EEPROM chip in the designated address range
+    Prefix: 'eeprom'
+    Addresses scanned: I2C 0x50 - 0x57
+    Datasheets: Publicly available from:
+                Atmel (www.atmel.com),
+                Catalyst (www.catsemi.com),
+                Fairchild (www.fairchildsemi.com),
+                Microchip (www.microchip.com),
+                Philips (www.semiconductor.philips.com),
+                Rohm (www.rohm.com),
+                ST (www.st.com),=09
+                Xicor (www.xicor.com),  =09
+                and others.
+
+        Chip     Size (bits)    Address
+        24C01     1K            0x50 (shadows at 0x51 - 0x57)
+        24C01A    1K            0x50 - 0x57 (Typical device on DIMMs)
+        24C02     2K            0x50 - 0x57
+        24C04     4K            0x50, 0x52, 0x54, 0x56
+                                (additional data at 0x51, 0x53, 0x55, 0x57)
+        24C08     8K            0x50, 0x54 (additional data at 0x51, 0x52,
+                                0x53, 0x55, 0x56, 0x57)
+        24C16    16K            0x50 (additional data at 0x51 - 0x57)
+        Sony      2K            0x57
+
+        Atmel     34C02B  2K    0x50 - 0x57, SW write protect at 0x30-37
+        Catalyst  34FC02  2K    0x50 - 0x57, SW write protect at 0x30-37
+        Catalyst  34RC02  2K    0x50 - 0x57, SW write protect at 0x30-37
+        Fairchild 34W02   2K    0x50 - 0x57, SW write protect at 0x30-37
+        Microchip 24AA52  2K    0x50 - 0x57, SW write protect at 0x30-37
+        ST        M34C02  2K    0x50 - 0x57, SW write protect at 0x30-37
+
+
+Authors:=20
+        Frodo Looijaard <frodol@dds.nl>,
+        Philip Edelbrock <phil@netroedge.com>,
+        Jean Delvare <khali@linux-fr.org>,
+        Greg Kroah-Hartman <greg@kroah.com>,
+        IBM Corp.
+
+Description
+-----------
+
+This is a simple EEPROM module meant to enable reading the first 256 bytes
+of an EEPROM (on a SDRAM DIMM for example). However, it will access serial
+EEPROMs on any I2C adapter. The supported devices are generically called
+24Cxx, and are listed above; however the numbering for these
+industry-standard devices may vary by manufacturer.
+
+This module was a programming exercise to get used to the new project
+organization laid out by Frodo, but it should be at least completely
+effective for decoding the contents of EEPROMs on DIMMs.=20
+
+DIMMS will typically contain a 24C01A or 24C02, or the 34C02 variants.=20
+The other devices will not be found on a DIMM because they respond to more=
=20
+than one address.
+
+DDC Monitors may contain any device. Often a 24C01, which responds to all 8
+addresses, is found.=20
+
+Recent Sony Vaio laptops have an EEPROM at 0x57. We couldn't get the
+specification, so it is guess work and far from being complete.
+
+The Microchip 24AA52/24LCS52, ST M34C02, and others support an additional
+software write protect register at 0x30 - 0x37 (0x20 less than the memory
+location). The chip responds to "write quick" detection at this address but
+does not respond to byte reads. If this register is present, the lower 128
+bytes of the memory array are not write protected. Any byte data write to
+this address will write protect the memory array permanently, and the
+device will no longer respond at the 0x30-37 address. The eeprom driver
+does not support this register.
+
+Lacking functionality:
+
+* Full support for larger devices (24C04, 24C08, 24C16). These are not
+typically found on a PC. These devices will appear as separate devices at
+multiple addresses.
+
+* Support for really large devices (24C32, 24C64, 24C128, 24C256, 24C512).
+These devices require two-byte address fields and are not supported.
+
+* Enable Writing. Again, no technical reason why not, but making it easy
+to change the contents of the EEPROMs (on DIMMs anyway) also makes it easy
+to disable the DIMMs (potentially preventing the computer from booting)
+until the values are restored somehow.
+
+Use:
+
+After inserting the module (and any other required SMBus/i2c modules), you
+should have some EEPROM directories in /sys/bus/i2c/devices/* of names such
+as "0-0050". Inside each of these is a series of files, the eeprom file
+contains the binary data from EEPROM.
diff -Naur c/Documentation/i2c/chips/fscher d/Documentation/i2c/chips/fscher
--- c/Documentation/i2c/chips/fscher	1970-01-01 01:00:00.000000000 +0100
+++ d/Documentation/i2c/chips/fscher	2005-05-23 21:36:22.000000000 +0200
@@ -0,0 +1,169 @@
+Kernel driver fscher
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Supported chips:
+  * Fujitsu-Siemens Hermes chip
+    Prefix: 'fscher'
+    Addresses scanned: I2C 0x73=20
+
+Authors:=20
+        Reinhard Nissl <rnissl@gmx.de> based on work=20
+        from Hermann Jung <hej@odn.de>,=20
+        Frodo Looijaard <frodol@dds.nl>,=20
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
+(power supply, CPU and auxiliary).=20
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
+  WRITING & 0x01 =3D 0x01: set software event=20
+  WRITING & 0x01 =3D 0x00: clear software event=20
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
+  WRITING & 0x02 =3D 0x02: clear watchdog event=20
+
+* watchdog_preset
+  READING & 0xff =3D 0x??: configured watch dog time in units (see wdog:3 =
0x40)
+ =20
+  WRITING & 0xff =3D 0x??: configure watch dog time in units
+
+* in*     (0: +5V, 1: +12V, 2: onboard 3V battery)
+  READING: actual voltage value
+
+* temp*_status   (1: CPU sensor, 2: onboard sensor, 3: auxiliary sensor)
+  READING & 0x02 =3D 0x02: thermal event (overtemperature)=20
+  READING & 0x02 =3D 0x00: no thermal event
+
+  READING & 0x01 =3D 0x01: sensor is working
+  READING & 0x01 =3D 0x00: sensor is faulty
+
+  WRITING & 0x02 =3D 0x02: clear thermal event
+
+* temp*_input   (1: CPU sensor, 2: onboard sensor, 3: auxiliary sensor)=20
+  READING: actual temperature value
+ =20
+* fan*_status   (1: power supply fan, 2: CPU fan, 3: auxiliary fan)
+  READING & 0x04 =3D 0x04: fan event (fan fault)
+  READING & 0x04 =3D 0x00: no fan event
+
+  WRITING & 0x04 =3D 0x04: clear fan event
+
+* fan*_div (1: power supply fan, 2: CPU fan, 3: auxiliary fan)
+  	Divisors 2,4 and 8 are supported, both for reading and writing
+ =20
+* fan*_pwm   (1: power supply fan, 2: CPU fan, 3: auxiliary fan)
+  READING & 0xff =3D 0x00: fan may be switched off
+  READING & 0xff =3D 0x01: fan must run at least at minimum speed (supply:=
 6V)
+  READING & 0xff =3D 0xff: fan must run at maximum speed (supply: 12V)=20
+  READING & 0xff =3D 0x??: fan must run at least at given speed (supply: 6=
V..12V)
+
+  WRITING & 0xff =3D 0x00: fan may be switched off
+  WRITING & 0xff =3D 0x01: fan must run at least at minimum speed (supply:=
 6V)
+  WRITING & 0xff =3D 0xff: fan must run at maximum speed (supply: 12V)=20
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
+It seems that the chip counts "ripples" (typical fans produce 2 ripples pe=
r=20
+rotation while VERAX fans produce 18) in a 9-bit register. This register is
+read out every second, then the ripple prescaler (2, 4 or 8) is applied and
+the result is stored in the 8 bit output register. Due to the limitation of
+the counting register to 9 bits, it is impossible to measure a VERAX fan
+properly (even with a prescaler of 8). At its maximum speed of 3500 RPM the
+fan produces 1080 ripples per second which causes the counting register to
+overflow twice, leading to only 186 RPM.=20
+
+* Measuring input voltages
+in2 ("battery") reports the voltage of the onboard lithium battery and not
++3.3V from the power supply.
+
+* Undocumented features
+Fujitsu-Siemens Computers has not documented all features of the chip so
+far. Their software, System Guard, shows that there are a still some
+features which cannot be controlled by this implementation.
diff -Naur c/Documentation/i2c/chips/gl518sm d/Documentation/i2c/chips/gl51=
8sm
--- c/Documentation/i2c/chips/gl518sm	1970-01-01 01:00:00.000000000 +0100
+++ d/Documentation/i2c/chips/gl518sm	2005-05-23 21:36:44.000000000 +0200
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
+Authors:=20
+        Frodo Looijaard <frodol@dds.nl>,
+        Ky=F6sti M=E4lkki <kmalkki@cc.hut.fi>
+        Hong-Gunn Chew <hglinux@gunnet.org>
+        Jean Delvare <khali@linux-fr.org>
+
+Description
+-----------
+
+IMPORTANT:
+
+For the revision 0x00 chip, the in0, in1, and in2  values (+5V, +3V,=20
+and +12V) CANNOT be read. This is a limitation of the chip, not the driver.
+			     =20
+This driver supports the Genesys Logic GL518SM chip. There are at least
+two revision of this chip, which we call revision 0x00 and 0x80. Revision
+0x80 chips support the reading of all voltages and revision 0x00 only=20
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
+Fan readings can be divided by a programmable divider (1, 2, 4 or 8) to=20
+give the readings more range or accuracy.  Not all RPM values can=20
+accurately be represented, so some rounding is done. With a divider=20
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
+alarms work fine, though.=20
+
+When an alarm is triggered, you can be warned by a beeping signal through =
your
+computer speaker. It is possible to enable all beeping globally, or only t=
he
+beeping for some alarms.
+
+If an alarm triggers, it will remain triggered until the hardware register
+is read at least once (except for temperature alarms). This means that the=
=20
+cause for the alarm may already have disappeared! Note that in the current=
=20
+implementation, all hardware registers are read whenever any data is read =

+(unless it is less than 1.5 seconds since the last update). This means tha=
t=20
+you can easily miss once-only alarms.
+
+The GL518SM only updates its values each 1.5 seconds; reading it more often
+will do no harm, but will return 'old' values.
diff -Naur c/Documentation/i2c/chips/it87 d/Documentation/i2c/chips/it87
--- c/Documentation/i2c/chips/it87	1970-01-01 01:00:00.000000000 +0100
+++ d/Documentation/i2c/chips/it87	2005-05-23 20:59:25.000000000 +0200
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
+=09
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
+  to fix this. Please contact your BIOS manufacturer and ask him for fix. =

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
+triggered if the rotation speed has dropped below a programmable limit. Fa=
n=20
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
+To change sensor N to a thermistor, 'echo 2 > tempN_type' where N is 1, 2,=
=20
+or 3. To change sensor N to a thermal diode, 'echo 3 > tempN_type'.=20
+Give 0 for unused sensor. Any other value is invalid. To configure this at
+startup, consult lm_sensors's /etc/sensors.conf. (2 =3D thermistor;=20
+3 =3D thermal diode) =09
+
+The fan speed control features are limited to manual PWM mode. Automatic
+"Smart Guardian" mode control handling is not implemented. However
+if you want to go for "manual mode" just write 1 to pwmN_enable.
diff -Naur c/Documentation/i2c/chips/lm63 d/Documentation/i2c/chips/lm63
--- c/Documentation/i2c/chips/lm63	1970-01-01 01:00:00.000000000 +0100
+++ d/Documentation/i2c/chips/lm63	2005-05-23 20:54:14.000000000 +0200
@@ -0,0 +1,57 @@
+Kernel driver lm63
+=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Supported chips:=20
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
+The LM63 is basically an LM86 with fan speed monitoring and control=20
+capabilities added. It misses some of the LM86 features though:=20
+ - No low limit for local temperature.=20
+ - No critical limit for local temperature.=20
+ - Critical limit for remote temperature can be changed only once. We=20
+   will consider that the critical limit is read-only.=20
+=20
+The datasheet isn't very clear about what the tachometer reading is.=20
+
+An explanation from National Semiconductor: The two lower bits of the read=
=20
+value have to be masked out. The value is still 16 bit in width.=20
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
diff -Naur c/Documentation/i2c/chips/lm75 d/Documentation/i2c/chips/lm75
--- c/Documentation/i2c/chips/lm75	1970-01-01 01:00:00.000000000 +0100
+++ d/Documentation/i2c/chips/lm75	2005-05-23 20:54:19.000000000 +0200
@@ -0,0 +1,65 @@
+Kernel driver lm75
+=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Supported chips:=20
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
be=20
+set and read to half-degree accuracy.
+An alarm is issued (usually to a connected LM78) when the temperature
+gets higher then the Overtemperature Shutdown value; it stays on until
+the temperature falls below the Hysteresis value.
+All temperatures are in degrees Celsius, and are guaranteed within a=20
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
diff -Naur c/Documentation/i2c/chips/lm77 d/Documentation/i2c/chips/lm77
--- c/Documentation/i2c/chips/lm77	1970-01-01 01:00:00.000000000 +0100
+++ d/Documentation/i2c/chips/lm77	2005-05-23 20:54:25.000000000 +0200
@@ -0,0 +1,22 @@
+Kernel driver lm77
+=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Supported chips:=20
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
+The LM77 implements one temperature sensor. The temperature=20
+sensor incorporates a band-gap type temperature sensor,=20
+10-bit ADC, and a digital comparator with user-programmable upper=20
+and lower limit values.=20
+
+Limits can be set through the Overtemperature Shutdown register and=20
+Hysteresis register.=20
diff -Naur c/Documentation/i2c/chips/lm78 d/Documentation/i2c/chips/lm78
--- c/Documentation/i2c/chips/lm78	1970-01-01 01:00:00.000000000 +0100
+++ d/Documentation/i2c/chips/lm78	2005-05-23 20:59:38.000000000 +0200
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
lly,=20
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
+as soon as it drops below the Hysteresis value. A more useful behavior=20
+can be found by setting the Hysteresis value to +127 degrees Celsius; in=20
+this case, alarms are issued during all the time when the actual temperatu=
re
+is above the Overtemperature Shutdown value. Measurements are guaranteed
+between -55 and +125 degrees, with a resolution of 1 degree.
+
+Fan rotation speeds are reported in RPM (rotations per minute). An alarm is
+triggered if the rotation speed has dropped below a programmable limit. Fan
+readings can be divided by a programmable divider (1, 2, 4 or 8) to give
+the readings more range or accuracy. Not all RPM values can accurately be =

+represented, so some rounding is done. With a divider of 2, the lowest=20
+representable value is around 2600 RPM.
+
+Voltage sensors (also known as IN sensors) report their values in volts.
+An alarm is triggered if the voltage has crossed a programmable minimum=20
+or maximum limit. Note that minimum in this case always means 'closest to
+zero'; this is important for negative voltage measurements. All voltage
+inputs can measure voltages between 0 and 4.08 volts, with a resolution
+of 0.016 volt.
+
+The VID lines encode the core voltage value: the voltage level your proces=
sor=20
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
+this condition usually indicates there is a problem with some other=20
+device.
+
+If an alarm triggers, it will remain triggered until the hardware register
+is read at least once. This means that the cause for the alarm may=20
+already have disappeared! Note that in the current implementation, all
+hardware registers are read whenever any data is read (unless it is less
+than 1.5 seconds since the last update). This means that you can easily
+miss once-only alarms.
+
+The LM7* only updates its values each 1.5 seconds; reading it more often
+will do no harm, but will return 'old' values.
diff -Naur c/Documentation/i2c/chips/lm80 d/Documentation/i2c/chips/lm80
--- c/Documentation/i2c/chips/lm80	1970-01-01 01:00:00.000000000 +0100
+++ d/Documentation/i2c/chips/lm80	2005-05-23 21:37:05.000000000 +0200
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
+Authors:=20
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
+the readings more range or accuracy. Not all RPM values can accurately be =

+represented, so some rounding is done. With a divider of 2, the lowest=20
+representable value is around 2600 RPM.
+
+Voltage sensors (also known as IN sensors) report their values in volts.
+An alarm is triggered if the voltage has crossed a programmable minimum=20
+or maximum limit. Note that minimum in this case always means 'closest to
+zero'; this is important for negative voltage measurements. All voltage
+inputs can measure voltages between 0 and 2.55 volts, with a resolution
+of 0.01 volt.
+
+If an alarm triggers, it will remain triggered until the hardware register
+is read at least once. This means that the cause for the alarm may=20
+already have disappeared! Note that in the current implementation, all
+hardware registers are read whenever any data is read (unless it is less
+than 2.0 seconds since the last update). This means that you can easily
+miss once-only alarms.
+
+The LM80 only updates its values each 1.5 seconds; reading it more often
+will do no harm, but will return 'old' values.
diff -Naur c/Documentation/i2c/chips/lm83 d/Documentation/i2c/chips/lm83
--- c/Documentation/i2c/chips/lm83	1970-01-01 01:00:00.000000000 +0100
+++ d/Documentation/i2c/chips/lm83	2005-05-23 20:54:45.000000000 +0200
@@ -0,0 +1,76 @@
+Kernel driver lm83
+=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Supported chips:=20
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
+The driver has been successfully tested by Magnus Forsstr=F6m, who I'd
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
diff -Naur c/Documentation/i2c/chips/lm85 d/Documentation/i2c/chips/lm85
--- c/Documentation/i2c/chips/lm85	1970-01-01 01:00:00.000000000 +0100
+++ d/Documentation/i2c/chips/lm85	2005-05-23 21:37:19.000000000 +0200
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
+   =20
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
+The temperatures measured are one internal diode, and two remote diodes.=20
+Remote 1 is generally the CPU temperature. These inputs are designed to
+measure a thermal diode like the one in a Pentium 4 processor in a socket
+423 or socket 478 package. They can also measure temperature using a
+transistor like the 2N3904.
+
+A sophisticated control system for the PWM outputs is designed into the
+LM85 that allows fan speed to be adjusted automatically based on any of the
+three temperature sensors. Each PWM output is individually adjustable and
+programmable. Once configured, the LM85 will adjust the PWM outputs in
+response to the measured temperatures without further host intervention.=20
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
+The LM85 has four fan speed monitoring modes. The ADM1027 has only two.=20
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
+config option but uses it to rate limit the changes to fan speed instead. =

+
+The ADM1027 and ADT7463 have a 10-bit ADC and can therefore measure
+temperatures with 0.25 degC resolution. They also provide an offset to the
+temperature readings that is automatically applied during measurement.=20
+This offset can be used to zero out any errors due to traces and placement=
.=20
+The documentation says that the offset is in 0.25 degC steps, but in
+initial testing of the ADM1027 it was 1.00 degC steps. Analog Devices has
+confirmed this "bug". The ADT7463 is reported to work as described in the =

+documentation. The current lm85 driver does not show the offset register. =

+
+The ADT7463 has a THERM asserted counter. This counter has a 22.76ms
+resolution and a range of 5.8 seconds. The driver implements a 32-bit
+accumulator of the counter value to extend the range to over a year. The
+counter will stay at it's max value until read.
+
+See the vendor datasheets for more information. There is application note
+from National (AN-1260) with some additional information about the LM85.=20
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
+=20
+* PWM Control
+
+There are three PWM outputs. The LM85 datasheet suggests that the
+pwm3 output control both fan3 and fan4. Each PWM can be individually
+configured and assigned to a zone for it's control value. Each PWM can be
+configured individually according to the following options.
+
+* pwm#_auto_pwm_min - this specifies the PWM value for temp#_auto_temp_off=
=20
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
diff -Naur c/Documentation/i2c/chips/lm87 d/Documentation/i2c/chips/lm87
--- c/Documentation/i2c/chips/lm87	1970-01-01 01:00:00.000000000 +0100
+++ d/Documentation/i2c/chips/lm87	2005-05-23 21:37:25.000000000 +0200
@@ -0,0 +1,73 @@
+Kernel driver lm87
+=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Supported chips:
+  * National Semiconductor LM87
+    Prefix: 'lm87'
+    Addresses scanned: I2C 0x2c - 0x2f
+    Datasheet: http://www.national.com/pf/LM/LM87.html
+   =20
+Authors:=20
+        Frodo Looijaard <frodol@dds.nl>,
+        Philip Edelbrock <phil@netroedge.com>,=20
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
+the readings more range or accuracy. Not all RPM values can accurately be =

+represented, so some rounding is done. With a divider of 2, the lowest=20
+representable value is around 2600 RPM.
+
+Voltage sensors (also known as IN sensors) report their values in
+volts. An alarm is triggered if the voltage has crossed a programmable
+minimum or maximum limit. Note that minimum in this case always means
+'closest to zero'; this is important for negative voltage measurements.
+
+If an alarm triggers, it will remain triggered until the hardware register
+is read at least once. This means that the cause for the alarm may=20
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
+Some functions share pins, so not all functions are available at the same =

+time. Which are depends on the hardware setup. This driver assumes that=20
+the BIOS configured the chip correctly. In that respect, it differs from=20
+the original driver (from lm_sensors for Linux 2.4), which would force the=
=20
+LM87 to an arbitrary, compile-time chosen mode, regardless of the actual=20
+chipset wiring.=20
+
+For reference, here is the list of exclusive functions:=20
+ - in0+in5 (default) or temp3=20
+ - fan1 (default) or in6
+ - fan2 (default) or in7
+ - VID lines (default) or IRQ lines (not handled by this driver)
diff -Naur c/Documentation/i2c/chips/lm90 d/Documentation/i2c/chips/lm90
--- c/Documentation/i2c/chips/lm90	1970-01-01 01:00:00.000000000 +0100
+++ d/Documentation/i2c/chips/lm90	2005-05-23 20:55:01.000000000 +0200
@@ -0,0 +1,121 @@
+Kernel driver lm90
+=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Supported chips:=20
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
+Note that there is no easy way to differentiate between the last three=20
+variants. The extra address and features of the MAX6659 are not supported =
by=20
+this driver. Additionally, the ADT7461 is supported if found in ADM1032
+compatibility mode.
+=20
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
+ =20
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
diff -Naur c/Documentation/i2c/chips/lm92 d/Documentation/i2c/chips/lm92
--- c/Documentation/i2c/chips/lm92	1970-01-01 01:00:00.000000000 +0100
+++ d/Documentation/i2c/chips/lm92	2005-05-23 21:00:06.000000000 +0200
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
+   =20
+Authors:=20
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
diff -Naur c/Documentation/i2c/chips/max1619 d/Documentation/i2c/chips/max1=
619
--- c/Documentation/i2c/chips/max1619	1970-01-01 01:00:00.000000000 +0100
+++ d/Documentation/i2c/chips/max1619	2005-05-23 21:37:40.000000000 +0200
@@ -0,0 +1,29 @@
+Kernel driver max1619
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
+Supported chips:=20
+  * Maxim MAX1619
+    Prefix: 'max1619'
+    Addresses scanned: I2C 0x18-0x1a, 0x29-0x2b, 0x4c-0x4e
+    Datasheet: Publicly available at the Maxim website
+               http://pdfserv.maxim-ic.com/en/ds/MAX1619.pdf
+
+Authors:=20
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
diff -Naur c/Documentation/i2c/chips/pcf8574 d/Documentation/i2c/chips/pcf8=
574
--- c/Documentation/i2c/chips/pcf8574	1970-01-01 01:00:00.000000000 +0100
+++ d/Documentation/i2c/chips/pcf8574	2005-05-23 21:38:10.000000000 +0200
@@ -0,0 +1,69 @@
+Kernel driver pcf8574
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
+Supported chips:
+  * Philips PCF8574
+    Prefix: 'pcf8574'
+    Addresses scanned: I2C 0x20 - 0x27
+    Datasheet: Publicly available at the Philips Semiconductors website
+               http://www.semiconductors.philips.com/pip/PCF8574P.html
+
+ * Philips PCF8574A
+    Prefix: 'pcf8574a'
+    Addresses scanned: I2C 0x38 - 0x3f
+    Datasheet: Publicly available at the Philips Semiconductors website
+               http://www.semiconductors.philips.com/pip/PCF8574P.html
+
+Authors:=20
+        Frodo Looijaard <frodol@dds.nl>,
+        Philip Edelbrock <phil@netroedge.com>,
+        Dan Eaton <dan.eaton@rocketlogix.com>,
+        Aurelien Jarno <aurelien@aurel32.net>,
+        Jean Delvare <khali@linux-fr.org>,
+
+
+Description
+-----------
+The PCF8574(A) is an 8-bit I/O expander for the I2C bus produced by Philip=
s=20
+Semiconductors. It is designed to provide a byte I2C interface to up to 16=
=20
+separate devices (8 x PCF8574 and 8 x PCF8574A).
+
+This device consists of a quasi-bidirectional port. Each of the eight I/Os
+can be independently used as an input or output. To setup an I/O as an
+input, you have to write a 1 to the corresponding output.
+
+For more informations see the datasheet.
+
+
+Accessing PCF8574(A) via /sys interface
+-------------------------------------
+
+! Be careful !
+The PCF8574(A) is plainly impossible to detect ! Stupid chip.
+So every chip with address in the interval [20..27] and [38..3f] are
+detected as PCF8574(A). If you have other chips in this address
+range, the workaround is to load this module after the one
+for your others chips.
+
+On detection (i.e. insmod, modprobe et al.), directories are being
+created for each detected PCF8574(A):
+
+/sys/bus/i2c/devices/<0>-<1>/
+where <0> is the bus the chip was detected on (e. g. i2c-0)
+and <1> the chip address ([20..27] or [38..3f]):=20
+
+(example: /sys/bus/i2c/devices/1-0020/)
+
+Inside these directories, there are two files each:
+read and write (and one file with chip name).
+
+The read file is read-only. Reading gives you the current I/O input
+if the corresponding output is set as 1, otherwise the current output
+value, that is to say 0.
+
+The write file is read/write. Writing a value outputs it on the I/O
+port. Reading returns the last written value.
+
+On module initialization the chip is configured as eight inputs (all
+outputs to 1), so you can connect any circuit to the PCF8574(A) without
+being afraid of short-circuit.
diff -Naur c/Documentation/i2c/chips/pcf8591 d/Documentation/i2c/chips/pcf8=
591
--- c/Documentation/i2c/chips/pcf8591	1970-01-01 01:00:00.000000000 +0100
+++ d/Documentation/i2c/chips/pcf8591	2005-05-23 21:15:07.000000000 +0200
@@ -0,0 +1,90 @@
+Kernel driver pcf8591
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
+Supported chips:
+  * Philips PCF8591
+    Prefix: 'pcf8591'
+    Addresses scanned: I2C 0x48 - 0x4f
+    Datasheet: Publicly available at the Philips Semiconductor website
+               http://www.semiconductors.philips.com/pip/PCF8591P.html
+
+Authors:=20
+        Aurelien Jarno <aurelien@aurel32.net>
+        valuable contributions by Jan M. Sendler <sendler@sendler.de>,
+        Jean Delvare <khali@linux-fr.org>
+=09
+
+Description
+-----------
+The PCF8591 is an 8-bit A/D and D/A converter (4 analog inputs and one
+analog output) for the I2C bus produced by Philips Semiconductors. It
+is designed to provide a byte I2C interface to up to 4 separate devices.
+
+The PCF8591 has 4 analog inputs programmable as single-ended or
+differential inputs :
+- mode 0 : four single ended inputs
+        Pins AIN0 to AIN3 are single ended inputs for channels 0 to 3
+
+- mode 1 : three differential inputs
+        Pins AIN3 is the common negative differential input
+        Pins AIN0 to AIN2 are positive differential inputs for channels 0 =
to 2
+
+- mode 2 : single ended and differential mixed
+        Pins AIN0 and AIN1 are single ended inputs for channels 0 and 1
+        Pins AIN2 is the positive differential input for channel 3
+        Pins AIN3 is the negative differential input for channel 3
+
+- mode 3 : two differential inputs
+        Pins AIN0 is the positive differential input for channel 0
+        Pins AIN1 is the negative differential input for channel 0
+        Pins AIN2 is the positive differential input for channel 1
+        Pins AIN3 is the negative differential input for channel 1
+
+See the datasheet for details.
+
+Module parameters
+-----------------
+
+* input_mode int
+
+    Analog input mode:
+         0 =3D four single ended inputs
+         1 =3D three differential inputs
+         2 =3D single ended and differential mixed
+         3 =3D two differential inputs
+
+
+Accessing PCF8591 via /sys interface
+-------------------------------------
+
+! Be careful !
+The PCF8591 is plainly impossible to detect ! Stupid chip.
+So every chip with address in the interval [48..4f] is
+detected as PCF8591. If you have other chips in this address
+range, the workaround is to load this module after the one
+for your others chips.
+
+On detection (i.e. insmod, modprobe et al.), directories are being
+created for each detected PCF8591:
+
+/sys/bus/devices/<0>-<1>/
+where <0> is the bus the chip was detected on (e. g. i2c-0)
+and <1> the chip address ([48..4f])
+
+Inside these directories, there are such files:
+in0, in1, in2, in3, out0_enable, out0_output, name
+
+Name contains chip name.
+
+The in0, in1, in2 and in3 files are RO. Reading gives the value of the
+corresponding channel. Depending on the current analog inputs configuratio=
n,
+files in2 and/or in3 do not exist. Values range are from 0 to 255 for sing=
le
+ended inputs and -128 to +127 for differential inputs (8-bit ADC).
+
+The out0_enable file is RW. Reading gives "1" for analog output enabled and
+"0" for analog output disabled. Writing accepts "0" and "1" accordingly.
+
+The out0_output file is RW. Writing a number between 0 and 255 (8-bit DAC)=
, send
+the value to the digital-to-analog converter. Note that a voltage will
+only appears on AOUT pin if aout0_enable equals 1. Reading returns the last
+value written.
diff -Naur c/Documentation/i2c/chips/pc87360 d/Documentation/i2c/chips/pc87=
360
--- c/Documentation/i2c/chips/pc87360	1970-01-01 01:00:00.000000000 +0100
+++ d/Documentation/i2c/chips/pc87360	2005-05-23 21:37:51.000000000 +0200
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
+  Chip        #vin    #fan    #pwm    #temp   devid=20
+
+  PC87360     -       2       2       -       0xE1=20
+  PC87363     -       2       2       -       0xE8=20
+  PC87364     -       3       3       -       0xE4=20
+  PC87365     11      3       3       2       0xE5=20
+  PC87366     11      3       3       3-4     0xE9=20
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
diff -Naur c/Documentation/i2c/chips/sis5595 d/Documentation/i2c/chips/sis5=
595
--- c/Documentation/i2c/chips/sis5595	1970-01-01 01:00:00.000000000 +0100
+++ d/Documentation/i2c/chips/sis5595	2005-05-23 21:14:05.000000000 +0200
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
+Authors:=20
+        Ky=F6sti M=E4lkki <kmalkki@cc.hut.fi>,
+        Mark D. Studebaker <mdsxyz123@yahoo.com>,
+        Aurelien Jarno <aurelien@aurel32.net> 2.6 port
+
+   SiS southbridge has a LM78-like chip integrated on the same IC.
+   This driver is a customized copy of lm78.c
+  =20
+   Supports following revisions:
+       Version         PCI ID          PCI Revision
+       1               1039/0008       AF or less
+       2               1039/0008       B0 or greater
+
+   Note: these chips contain a 0008 device which is incompatible with the
+        5595. We recognize these by the presence of the listed
+        "blacklist" PCI ID and refuse to load.
+
+   NOT SUPPORTED       PCI ID          BLACKLIST PCI ID       =20
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
+which was hopefully set by the BIOS.=20
+
+Temperatures are measured in degrees Celsius. An alarm is triggered once
+when the max is crossed; it is also triggered when it drops below the min
+value. Measurements are guaranteed between -55 and +125 degrees, with a
+resolution of 1 degree.
+
+Fan rotation speeds are reported in RPM (rotations per minute). An alarm is
+triggered if the rotation speed has dropped below a programmable limit. Fan
+readings can be divided by a programmable divider (1, 2, 4 or 8) to give
+the readings more range or accuracy. Not all RPM values can accurately be =

+represented, so some rounding is done. With a divider of 2, the lowest=20
+representable value is around 2600 RPM.
+
+Voltage sensors (also known as IN sensors) report their values in volts. An
+alarm is triggered if the voltage has crossed a programmable minimum or
+maximum limit. Note that minimum in this case always means 'closest to
+zero'; this is important for negative voltage measurements. All voltage
+inputs can measure voltages between 0 and 4.08 volts, with a resolution of
+0.016 volt.
+
+In addition to the alarms described above, there is a BTI alarm, which get=
s=20
+triggered when an external chip has crossed its limits. Usually, this is=20
+connected to some LM75-like chip; if at least one crosses its limits, this=
=20
+bit gets set.=20
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
diff -Naur c/Documentation/i2c/chips/smsc47b397 d/Documentation/i2c/chips/s=
msc47b397
--- c/Documentation/i2c/chips/smsc47b397	2005-05-25 05:31:20.000000000 +0200
+++ d/Documentation/i2c/chips/smsc47b397	2005-05-23 21:40:16.000000000 +0200
@@ -1,7 +1,19 @@
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
+	=20
 November 23, 2004
=20
 The following specification describes the SMSC LPC47B397-NC sensor chip
-(for which there is no public datasheet available).  This document was
+(for which there is no public datasheet available). This document was
 provided by Craig Kelly (In-Store Broadcast Network) and edited/corrected
 by Mark M. Hoffman <mhoffman@lightlink.com>.
=20
@@ -10,10 +22,10 @@
 Methods for detecting the HP SIO and reading the thermal data on a dc7100.
=20
 The thermal information on the dc7100 is contained in the SIO Hardware Mon=
itor
-(HWM).  The information is accessed through an index/data pair.  The index=
/data
-pair is located at the HWM Base Address + 0 and the HWM Base Address + 1. =
 The
+(HWM). The information is accessed through an index/data pair. The index/d=
ata
+pair is located at the HWM Base Address + 0 and the HWM Base Address + 1. =
The
 HWM Base address can be obtained from Logical Device 8, registers 0x60 (MS=
B)
-and 0x61 (LSB).  Currently we are using 0x480 for the HWM Base Address and
+and 0x61 (LSB). Currently we are using 0x480 for the HWM Base Address and
 0x480 and 0x481 for the index/data pair.
=20
 Reading temperature information.
@@ -50,7 +62,7 @@
 The LSB Must be read first.
=20
 How to convert the tach reading to RPM.
-The tach reading (TCount) is given by:  (Tach MSB * 256) + (Tach LSB)
+The tach reading (TCount) is given by: (Tach MSB * 256) + (Tach LSB)
 The SIO counts the number of 90kHz (11.111us) pulses per revolution.
 RPM =3D 60/(TCount * 11.111us)
=20
@@ -85,35 +97,35 @@
=20
 b.	Write the address of the desired configuration register within the
 	logical device to the INDEX PORT and then write or read the config-
-	uration register through the DATA PORT. =20
+	uration register through the DATA PORT.=20
=20
 Note: If accessing the Global Configuration Registers, step (a) is not req=
uired.
=20
 Exit Configuration Mode
 To exit the Configuration State the write 0xAA to the CONFIG PORT (0x2E).
-The chip returns to the RUN State.  (This is important).
+The chip returns to the RUN State. (This is important).
=20
 Programming Example
 The following is an example of how to read the SIO Device ID located at 0x=
20
=20
-; ENTER CONFIGURATION MODE  =20
+; ENTER CONFIGURATION MODE
 MOV	DX,02EH
 MOV	AX,055H
 OUT	DX,AL
-; GLOBAL CONFIGURATION  REGISTER=20
+; GLOBAL CONFIGURATION REGISTER=20
 MOV	DX,02EH
 MOV	AL,20H
 OUT	DX,AL=20
 ; READ THE DATA
 MOV	DX,02FH
 IN	AL,DX
-; EXIT CONFIGURATION MODE    =20
+; EXIT CONFIGURATION MODE
 MOV	DX,02EH
 MOV	AX,0AAH
 OUT	DX,AL
=20
 The registers of interest for identifying the SIO on the dc7100 are Device=
 ID
-(0x20) and Device Rev  (0x21).
+(0x20) and Device Rev (0x21).
=20
 The Device ID will read 0X6F
 The Device Rev currently reads 0x01
@@ -122,12 +134,12 @@
 The following is an example of how to read the HWM Base Address located in
 Logical Device 8.
=20
-; ENTER CONFIGURATION MODE  =20
+; ENTER CONFIGURATION MODE
 MOV	DX,02EH
 MOV	AX,055H
 OUT	DX,AL
-; CONFIGURE REGISTER CRE0,  =20
-; LOGICAL DEVICE 8          =20
+; CONFIGURE REGISTER CRE0,
+; LOGICAL DEVICE 8
 MOV	DX,02EH
 MOV	AL,07H
 OUT	DX,AL ;Point to LD# Config Reg
@@ -140,7 +152,7 @@
 OUT	DX,AL	; Point to HWM Base Addr MSB
 MOV	DX,02FH
 IN	AL,DX	; Get MSB of HWM Base Addr
-; EXIT CONFIGURATION MODE    =20
+; EXIT CONFIGURATION MODE
 MOV	DX,02EH
 MOV	AX,0AAH
 OUT	DX,AL
diff -Naur c/Documentation/i2c/chips/smsc47m1 d/Documentation/i2c/chips/sms=
c47m1
--- c/Documentation/i2c/chips/smsc47m1	1970-01-01 01:00:00.000000000 +0100
+++ d/Documentation/i2c/chips/smsc47m1	2005-05-23 21:40:41.000000000 +0200
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
+Authors:=20
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
+triggered if the rotation speed has dropped below a programmable limit. Fa=
n=20
+readings can be divided by a programmable divider (1, 2, 4 or 8) to give
+the readings more range or accuracy. Not all RPM values can accurately be =

+represented, so some rounding is done. With a divider of 2, the lowest=20
+representable value is around 2600 RPM.
+
+PWM values are from 0 to 255.
+
+If an alarm triggers, it will remain triggered until the hardware register
+is read at least once. This means that the cause for the alarm may=20
+already have disappeared! Note that in the current implementation, all
+hardware registers are read whenever any data is read (unless it is less
+than 1.5 seconds since the last update). This means that you can easily
+miss once-only alarms.
+
+
+**********************
+The lm_sensors project gratefully acknowledges the support of
+Intel in the development of this driver.
diff -Naur c/Documentation/i2c/chips/via686a d/Documentation/i2c/chips/via6=
86a
--- c/Documentation/i2c/chips/via686a	1970-01-01 01:00:00.000000000 +0100
+++ d/Documentation/i2c/chips/via686a	2005-05-23 21:34:49.000000000 +0200
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
+Authors:=20
+        Ky=F6sti M=E4lkki <kmalkki@cc.hut.fi>,
+        Mark D. Studebaker <mdsxyz123@yahoo.com>
+        Bob Dougherty <bobd@stanford.edu>
+        (Some conversion-factor data were contributed by=20
+        Jonathan Teh Soon Yew <j.teh@iname.com>=20
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
+as soon as it drops below the hysteresis value.=20
+
+Fan rotation speeds are reported in RPM (rotations per minute). An alarm is
+triggered if the rotation speed has dropped below a programmable limit. Fan
+readings can be divided by a programmable divider (1, 2, 4 or 8) to give
+the readings more range or accuracy. Not all RPM values can accurately be =

+represented, so some rounding is done. With a divider of 2, the lowest=20
+representable value is around 2600 RPM.
+
+Voltage sensors (also known as IN sensors) report their values in volts.
+An alarm is triggered if the voltage has crossed a programmable minimum=20
+or maximum limit. Voltages are internally scalled, so each voltage channel
+has a different resolution and range.
+
+If an alarm triggers, it will remain triggered until the hardware register
+is read at least once. This means that the cause for the alarm may=20
+already have disappeared! Note that in the current implementation, all
+hardware registers are read whenever any data is read (unless it is less
+than 1.5 seconds since the last update). This means that you can easily
+miss once-only alarms.
+
+The driver only updates its values each 1.5 seconds; reading it more often
+will do no harm, but will return 'old' values.
diff -Naur c/Documentation/i2c/chips/w83l785ts d/Documentation/i2c/chips/w8=
3l785ts
--- c/Documentation/i2c/chips/w83l785ts	1970-01-01 01:00:00.000000000 +0100
+++ d/Documentation/i2c/chips/w83l785ts	2005-05-23 21:47:18.000000000 +0200
@@ -0,0 +1,39 @@
+Kernel driver w83l785ts
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
+Supported chips:=20
+  * Winbond W83L785TS-S
+    Prefix: 'w83l785ts'
+    Addresses scanned: I2C 0x2e
+    Datasheet: Publicly available at the Winbond USA website
+               http://www.winbond-usa.com/products/winbond_products/pdfs/P=
CIC/W83L785TS-S.pdf
+
+Authors:=20
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
diff -Naur c/Documentation/i2c/chips/w83627hf d/Documentation/i2c/chips/w83=
627hf
--- c/Documentation/i2c/chips/w83627hf	1970-01-01 01:00:00.000000000 +0100
+++ d/Documentation/i2c/chips/w83627hf	2005-05-23 22:00:51.000000000 +0200
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
+Authors:=20
+        Frodo Looijaard <frodol@dds.nl>,=20
+        Philip Edelbrock <phil@netroedge.com>,
+        Mark Studebaker <mdsxyz123@yahoo.com>,
+        Bernhard C. Schrenk <clemy@clemy.org>=20
+
+Module Parameters
+-----------------
+
+* force_addr: int
+  Initialize the ISA address of the sensors
+* force_i2c: int
+  Initialize the I2C address of the sensors
+* init: int=20
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
diff -Naur c/Documentation/i2c/chips/w83781d d/Documentation/i2c/chips/w837=
81d
--- c/Documentation/i2c/chips/w83781d	1970-01-01 01:00:00.000000000 +0100
+++ d/Documentation/i2c/chips/w83781d	2005-05-24 22:04:53.000000000 +0200
@@ -0,0 +1,412 @@
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
+  * Winbond W83627THF
+    Prefix: 'w83627thf'
+    Addresses scanned: ISA address 0x290 (8 I/O ports)
+    Datasheet: http://www.winbond.com/PDF/sheet/w83627thf.pdf
+  * Winbond W83697HF
+    Prefix: 'w83697hf'
+    Addresses scanned: ISA 0x290 (8 I/O ports)
+    Datasheet: http://www.winbond-usa.com/products/winbond_products/pdfs/P=
CIC/w83697hf.pdf
+  * Asus AS99127F
+    Prefix: 'as99127f'
+    Addresses scanned: I2C 0x28 - 0x2f
+    Datasheet: Unavailable from Asus
+
+Authors:=20
+        Frodo Looijaard <frodol@dds.nl>,=20
+        Philip Edelbrock <phil@netroedge.com>,
+        Mark Studebaker <mdsxyz123@yahoo.com>
+
+Module parameters
+-----------------
+
+* init int=20
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
+This driver implements support for the Winbond W83627HF, W83627THF, W83781=
D,
+W83782D, W83783S, W83697HF chips, and the Asus AS99127F chips. We will ref=
er
+to them collectively as W8378* chips.
+
+There is quite some difference between these chips, but they are similar
+enough that it was sensible to put them together in one driver.=20
+The W83627HF chip is assumed to be identical to the ISA W83782D.
+The Asus chips are similar to an I2C-only W83782D.
+
+Chip        #vin    #fanin  #pwm    #temp   wchipid vendid  i2c     ISA=20
+as99127f    7       3       0       3       0x31    0x12c3  yes     no=20
+as99127f rev.2 (type_name =3D as99127f)       0x31    0x5ca3  yes     no=20
+w83781d     7       3       0       3       0x10-1  0x5ca3  yes     yes=20
+w83627hf    9       3       2       3       0x21    0x5ca3  yes     yes(LP=
C)
+w83627thf   9       3       2       3       0x90    0x5ca3  no      yes(LP=
C)
+w83782d     9       3       2-4     3       0x30    0x5ca3  yes     yes=20
+w83783s     5-6     3       2       1-2     0x40    0x5ca3  yes     no=20
+w83697hf    8       2       2       2       0x60    0x5ca3  no      yes(LP=
C)
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
+sensors. An alarm is triggered for the main sensor once when the=20
+Overtemperature Shutdown limit is crossed; it is triggered again as soon a=
s=20
+it drops below the Hysteresis value. A more useful behavior=20
+can be found by setting the Hysteresis value to +127 degrees Celsius; in=20
+this case, alarms are issued during all the time when the actual temperatu=
re
+is above the Overtemperature Shutdown value. The driver sets the
+hysteresis value for temp1 to 127 at initialization.
+
+For the other temperature sensor(s), an alarm is triggered when the
+temperature gets higher then the Overtemperature Shutdown value; it stays
+on until the temperature falls below the Hysteresis value. But on the
+W83781D, there is only one alarm that functions for both other sensors!=20
+Temperatures are guaranteed within a range of -55 to +125 degrees. The
+main temperature sensors has a resolution of 1 degree; the other sensor(s)
+of 0.5 degree.
+
+Fan rotation speeds are reported in RPM (rotations per minute). An alarm is
+triggered if the rotation speed has dropped below a programmable limit. Fan
+readings can be divided by a programmable divider (1, 2, 4 or 8 for the
+W83781D; 1, 2, 4, 8, 16, 32, 64 or 128 for the others) to give
+the readings more range or accuracy. Not all RPM values can accurately=20
+be represented, so some rounding is done. With a divider of 2, the lowest =

+representable value is around 2600 RPM.
+
+Voltage sensors (also known as IN sensors) report their values in volts.
+An alarm is triggered if the voltage has crossed a programmable minimum=20
+or maximum limit. Note that minimum in this case always means 'closest to
+zero'; this is important for negative voltage measurements. All voltage
+inputs can measure voltages between 0 and 4.08 volts, with a resolution
+of 0.016 volt.
+
+The VID lines encode the core voltage value: the voltage level your proces=
sor=20
+should work with. This is hardcoded by the mainboard and/or processor itse=
lf.
+It is a value in volts. When it is unconnected, you will often find the
+value 3.50 V here.
+
+The W83782D and W83783S temperature conversion machine understands about
+several kinds of temperature probes. You can program the so-called
+beta value in the sensor files. '1' is the PII/Celeron diode, '2' is the
+TN3904 transistor, and 3435 the default thermistor value. Other values
+are (not yet) supported.=20
+
+In addition to the alarms described above, there is a CHAS alarm on the
+chips which triggers if your computer case is open.
+
+When an alarm goes off, you can be warned by a beeping signal through
+your computer speaker. It is possible to enable all beeping globally,
+or only the beeping for some alarms.
+
+If an alarm triggers, it will remain triggered until the hardware register
+is read at least once. This means that the cause for the alarm may=20
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
+>=20
+> 1) In the W83781D data sheet section 7.2 last paragraph, it talks about
+>    reprogramming the R-T table if the Beta of the thermistor is not
+>    3435K. The R-T table is described briefly in section 8.20.
+>    What formulas do I use to program a new R-T table for a given Beta?
+>=20
+	We are sorry that the calculation for R-T table value is
+confidential. If you have another Beta value of thermistor, we can help
+to calculate the R-T table for you. But you should give us real R-T
+Table which can be gotten by thermistor vendor. Therefore we will calculate
+them and obtain 32-byte data, and you can fill the 32-byte data to the
+register in Bank0.CR51 of W83781D.
+
+
+> 2) In the W83782D data sheet, it mentions that pins 38, 39, and 40 are=20
+>    programmable to be either thermistor or Pentium II diode inputs.=20
+>    How do I program them for diode inputs? I can't find any register
+>    to program these to be diode inputs.
+ --> You may program Bank0 CR[5Dh] and CR[59h] registers.
+=20
+ 	CR[5Dh]    		bit 1(VTIN1)    bit 2(VTIN2)   bit 3(VTIN3)
+ 	     =20
+      	thermistor                0		 0		0=09
+ 	diode 		          1		 1		1	=09
+=20
+=20
+(error) CR[59h] 		bit 4(VTIN1)	bit 2(VTIN2)   bit 3(VTIN3)
+(right) CR[59h] 		bit 4(VTIN1)	bit 5(VTIN2)   bit 6(VTIN3)
+ =09
+ 	PII thermal diode         1		 1		1
+ 	2N3904	diode	          0		 0		0
+=20
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
