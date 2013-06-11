From: Robert Coulson <rob.coulson@gmail.com>
Date: Tue, 11 Jun 2013 01:46:03 +0000
Subject: [lm-sensors] [PATCH 2/2 v2] Documentation (hwmon): Update ds1621 device information
Message-Id: <1370915163-30293-3-git-send-email-rob.coulson@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Replace some written information with tables to improve the readability and
for adding newer devices in the future.

Signed-off-by: Robert Coulson <rob.coulson@gmail.com>
---

v2 - Updated with v1 review comments

 Documentation/hwmon/ds1621 |   81 +++++++++++++++++++++++++++-----------------
 1 file changed, 50 insertions(+), 31 deletions(-)

diff --git a/Documentation/hwmon/ds1621 b/Documentation/hwmon/ds1621
index 201dc6b..eea77d4 100644
--- a/Documentation/hwmon/ds1621
+++ b/Documentation/hwmon/ds1621
@@ -73,38 +73,57 @@ any of the limits have ever been met or exceeded since last power-up or
 reset. Be aware: When testing, it showed that the status of Tout can change
 with neither of the alarms set.
 
-Temperature conversion of the DS1621 takes up to 1000ms; internal access to
-non-volatile registers may last for 10ms or below.
-
-The DS1625 is pin compatible and functionally equivalent with the DS1621,
-but the DS1621 is meant to replace it. The DS1631, DS1721, & DS1731 are also
-pin compatible with the DS1621, but provide multi-resolution support.
-
 Since there is no version or vendor identification register, there is
 no unique identification for these devices. Therefore, explicit device
-instantiation is required for correct device identification and functionality.
-
-And, for correct identification and operation, each device must be
-explicitly instantiated, one device per address, in this address
-range: 0x48..0x4f.
+instantiation is required for correct device identification and functionality
+(one device per address in this address range: 0x48..0x4f).
 
-The DS1721 is pin compatible with the DS1621, has an accuracy of +/- 1.0
-degree Celius (from -10 to +85 degrees), a minimum/maximum alarm default
-setting of 75 and 80 degrees respectively, and a maximum conversion time
-of 750ms.
-
-In addition, the DS1721 supports four resolution settings from 9 to 12 bits
-(defined in degrees C per LSB: 0.5, 0.25, 0.125, and 0.0625, respectively),
-that are set at device power on to the highest resolution: 12-bits.
-
-One additional note about the ds1721 is that although the data sheet says
-the temperature flags (THF and TLF) are used internally, these flags do
-get set and cleared as the actual temperature crosses the min or max settings.
-
-The DS1631 and DS1731 are pin compatible with the DS1621 and feature compatible
-with the DS1721. However, the DS1631 accuracy is +/- 0.5 degree Celius (from 0
-to +70 degrees), while the DS1731 accuracy is +/-1 degree Celius (from -10 to
-+85 degrees).
+The DS1625 is pin compatible and functionally equivalent with the DS1621,
+but the DS1621 is meant to replace it. The DS1631, DS1721, & DS1731 are
+also pin compatible with the DS1621 and provide multi-resolution support.
+
+Additionally, the DS1721 data sheet says the temperature flags (THF and TLF)
+are used internally, however, these flags do get set and cleared as the actual
+temperature crosses the min or max settings (which by default are set to 75
+and 80 degrees respectively).
+
+Temperature Conversion:
+-----------------------
+DS1621 - 750ms (older devices may take up to 1000ms)
+DS1625 - 500ms
+DS1631 - 93ms..750ms for 9..12 bits resolution, respectively.
+DS1721 - 93ms..750ms for 9..12 bits resolution, respectively.
+DS1731 - 93ms..750ms for 9..12 bits resolution, respectively.
+
+Note:
+On the DS1621, internal access to non-volatile registers may last for 10ms
+or less (unverified on the other devices).
+
+Temperature Accuracy:
+---------------------
+DS1621: +/- 0.5 degree Celius (from 0 to +70 degrees)
+DS1625: +/- 0.5 degree Celius (from 0 to +70 degrees)
+DS1631: +/- 0.5 degree Celius (from 0 to +70 degrees)
+DS1721: +/- 1.0 degree Celius (from -10 to +85 degrees)
+DS1731: +/- 1.0 degree Celius (from -10 to +85 degrees)
+
+Note:
+Please refer to the device datasheets for accuracy at other temperatures.
+
+Temperature Resolution:
+-----------------------
+As mentioned above, the DS1631, DS1721, & DS1731 provide multi-resolution
+support, which is achieved via the R0 and R1 config register bits, where:
+
+R0..R1
+------
+ 0  0 => 9 bits, 0.5 degrees Celcius
+ 1  0 => 10 bits, 0.25 degrees Celcius
+ 0  1 => 11 bits, 0.125 degrees Celcius
+ 1  1 => 12 bits, 0.0625 degrees Celcius
+
+Note:
+At initial device power-on, the default resolution is set to 12-bits.
 
 The resolution mode for the DS1631, DS1721, or DS1731 can be changed from
 userspace, via the device 'update_interval' sysfs attribute. This attribute
@@ -113,12 +132,12 @@ values defined in the datasheet as follows:
 
 Resolution    Conversion Time    Input Range
  (C/LSB)       (msec)             (msec)
---------------------------------------------
+------------------------------------------------
 0.5             93.75              0....94
 0.25            187.5              95...187
 0.125           375                188..375
 0.0625          750                376..infinity
---------------------------------------
+------------------------------------------------
 
 The following examples show how the 'update_interval' attribute can be
 used to change the conversion time:
-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
