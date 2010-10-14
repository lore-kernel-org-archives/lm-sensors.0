From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 14 Oct 2010 07:58:40 +0000
Subject: [lm-sensors] [PATCH 2/3] hwmon: (lm85) Document the ADT7468 as
Message-Id: <20101014095840.6be018a2@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Darrick J. Wong <djwong@us.ibm.com>
---
 Documentation/hwmon/lm85 |   55 +++++++++++++++++++++++++-----------------=
----
 drivers/hwmon/Kconfig    |    3 +-
 2 files changed, 32 insertions(+), 26 deletions(-)

--- linux-2.6.36-rc7.orig/Documentation/hwmon/lm85	2010-10-14 09:25:50.0000=
00000 +0200
+++ linux-2.6.36-rc7/Documentation/hwmon/lm85	2010-10-14 09:30:03.000000000=
 +0200
@@ -14,6 +14,10 @@ Supported chips:
     Prefix: 'adt7463'
     Addresses scanned: I2C 0x2c, 0x2d, 0x2e
     Datasheet: http://www.onsemi.com/PowerSolutions/product.do?id=ADT7463
+  * Analog Devices ADT7468
+    Prefix: 'adt7468'
+    Addresses scanned: I2C 0x2c, 0x2d, 0x2e
+    Datasheet: http://www.onsemi.com/PowerSolutions/product.do?id=ADT7468
   * SMSC EMC6D100, SMSC EMC6D101
     Prefix: 'emc6d100'
     Addresses scanned: I2C 0x2c, 0x2d, 0x2e
@@ -34,7 +38,7 @@ Description
 -----------
=20
 This driver implements support for the National Semiconductor LM85 and
-compatible chips including the Analog Devices ADM1027, ADT7463 and
+compatible chips including the Analog Devices ADM1027, ADT7463, ADT7468 and
 SMSC EMC6D10x chips family.
=20
 The LM85 uses the 2-wire interface compatible with the SMBUS 2.0
@@ -87,14 +91,15 @@ To smooth the response of fans to change
 optional filter for smoothing temperatures. The ADM1027 has the same
 config option but uses it to rate limit the changes to fan speed instead.
=20
-The ADM1027 and ADT7463 have a 10-bit ADC and can therefore measure
-temperatures with 0.25 degC resolution. They also provide an offset to the
-temperature readings that is automatically applied during measurement.
-This offset can be used to zero out any errors due to traces and placement.
-The documentation says that the offset is in 0.25 degC steps, but in
-initial testing of the ADM1027 it was 1.00 degC steps. Analog Devices has
-confirmed this "bug". The ADT7463 is reported to work as described in the
-documentation. The current lm85 driver does not show the offset register.
+The ADM1027, ADT7463 and ADT7468 have a 10-bit ADC and can therefore
+measure temperatures with 0.25 degC resolution. They also provide an offset
+to the temperature readings that is automatically applied during
+measurement. This offset can be used to zero out any errors due to traces
+and placement. The documentation says that the offset is in 0.25 degC
+steps, but in initial testing of the ADM1027 it was 1.00 degC steps. Analog
+Devices has confirmed this "bug". The ADT7463 is reported to work as
+described in the documentation. The current lm85 driver does not show the
+offset register.
=20
 See the vendor datasheets for more information. There is application note
 from National (AN-1260) with some additional information about the LM85.
@@ -125,17 +130,17 @@ datasheet for a complete description of
 identifying the chip, the driver behaves no differently with regard to
 these two chips. The LM85B is recommended for new designs.
=20
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
+The ADM1027, ADT7463 and ADT7468 chips have an optional SMBALERT output
+that can be used to signal the chipset in case a limit is exceeded or the
+temperature sensors fail. Individual sensor interrupts can be masked so
+they won't trigger SMBALERT. The SMBALERT output if configured replaces one
+of the other functions (PWM2 or IN0). This functionality is not implemented
+in current driver.
+
+The ADT7463 and ADT7468 also have an optional THERM output/input which can
+be connected to the processor PROC_HOT output. If available, the autofan
+control dynamic Tmin feature can be enabled to keep the system temperature
+within spec (just?!) with the least possible fan noise.
=20
 Configuration Notes
 -------------------
@@ -201,8 +206,8 @@ the temperatures to compensate for syste
 measurements. These features are not currently supported by the lm85
 driver.
=20
-In addition to the ADM1027 features, the ADT7463 also has Tmin control
-and THERM asserted counts. Automatic Tmin control acts to adjust the
-Tmin value to maintain the measured temperature sensor at a specified
-temperature. There isn't much documentation on this feature in the
-ADT7463 data sheet. This is not supported by current driver.
+In addition to the ADM1027 features, the ADT7463 and ADT7468 also have
+Tmin control and THERM asserted counts. Automatic Tmin control acts to
+adjust the Tmin value to maintain the measured temperature sensor at a
+specified temperature. There isn't much documentation on this feature in
+the ADT7463 data sheet. This is not supported by current driver.
--- linux-2.6.36-rc7.orig/drivers/hwmon/Kconfig	2010-10-14 09:25:50.0000000=
00 +0200
+++ linux-2.6.36-rc7/drivers/hwmon/Kconfig	2010-10-14 09:30:03.000000000 +0=
200
@@ -556,7 +556,8 @@ config SENSORS_LM85
 	select HWMON_VID
 	help
 	  If you say yes here you get support for National Semiconductor LM85
-	  sensor chips and clones: ADT7463, EMC6D100, EMC6D102 and ADM1027.
+	  sensor chips and clones: ADM1027, ADT7463, ADT7468, EMC6D100,
+	  EMC6D101 and EMC6D102.
=20
 	  This driver can also be built as a module.  If so, the module
 	  will be called lm85.


--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
