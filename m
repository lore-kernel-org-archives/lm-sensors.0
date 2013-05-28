From: Robert Coulson <rob.coulson@gmail.com>
Date: Tue, 28 May 2013 23:56:02 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon (ds1621): Update ds1621 device information
Message-Id: <1369785362-19133-3-git-send-email-rob.coulson@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Replace some written information with tables to improve the readability and
for adding newer devices in the future.

Signed-off-by: Robert Coulson <rob.coulson@gmail.com>
---
 Documentation/hwmon/ds1621 |   82 ++++++++++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 38 deletions(-)

diff --git a/Documentation/hwmon/ds1621 b/Documentation/hwmon/ds1621
index 64ee39f..e70a575 100644
--- a/Documentation/hwmon/ds1621
+++ b/Documentation/hwmon/ds1621
@@ -73,13 +73,6 @@ any of the limits have ever been met or exceeded since last power-up or
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
 instantiation is required for correct device identification and functionality.
@@ -88,37 +81,50 @@ And, for correct identification and operation, each device must be
 explicitly instantiated, one device per address, in this address
 range: 0x48..0x4f.
 
-The DS1721 is pin compatible with the DS1621, has an accuracy of +/- 1.0
-degree Celius over a -10 to +85 degree range, a minimum/maximum alarm
-default setting of 75 and 80 degrees respectifully, and a maximum conversion
-time of 750ms.
-
-In addition, the DS1721 supports four resolution settings from 9 to 12 bits
-(defined in degrees C per LSB: 0.5, 0.25, 0.125, and 0.0625, respectifully),
-that are set at device power on to the highest resolution: 12-bits.
-
-One additional note about the ds1721 is that although the data sheet says
-the temperature flags (THF and TLF) are used internally, these flags do
-get set and cleared as the actual temperature crosses the min or max settings.
-
-The DS1631 and DS1731 are pin compatible with the DS1621 and feature compatible
-with the DS1721, however, the DS1631 accuracy is +/- 0.5 degree Celius over
-the 0 to +70 degrees, while the DS1731 accuracy is +/-1 degree Celius over the
--10 to +85 degree range.
-
-Changing the DS1631, DS1721, or DS1731 resolution mode affects the conversion
-time and can be done from userspace, via the device 'update_interval' sysfs
-attribute. This attribute will normalize range of input values to the device
-maximum resolution values defined in the datasheet as such:
-
-Resolution    Conversion Time    Input Range
- (C/LSB)       (msec)             (msec)
---------------------------------------------
-0.5             93.75              0....94
-0.25            187.5              95...187
-0.125           375                188..375
-0.0625          750                376..infinity
---------------------------------------
+The DS1625 is pin compatible and functionally equivalent with the DS1621,
+but the DS1621 is meant to replace it. The DS1631, DS1721, & DS1731 are
+also pin compatible with the DS1621, but provide multi-resolution support.
+
+Additionally, the DS1721 data sheet says the temperature flags (THF and TLF)
+are used internally, however, these flags do get set and cleared as the actual
+temperature crosses the min or max settings (which by default are set to 75
+and 80 degrees respectifully).
+
+Temperature Conversion:
+-----------------------
+DS1621 - 750ms (older devices may take upto 1000ms)
+DS1625 - 500ms
+DS1631 - 93ms..750ms for 9..12 bits resolution, respectifully.
+DS1721 - 93ms..750ms for 9..12 bits resolution, respectifully.
+DS1731 - 93ms..750ms for 9..12 bits resolution, respectifully.
+
+Note:
+On the DS1621, internal access to non-volatile registers may last for 10ms
+or below (unverified on the other devices).
+
+Temperature Accuracy:
+----------------------
+DS1621: +/- 0.5 degree Celius over 0 to +70 degree range
+DS1625: +/- 0.5 degree Celius over 0 to +70 degree range
+DS1631: +/- 0.5 degree Celius over 0 to +70 degree range
+DS1721: +/- 1.0 degree Celius over -10 to +85 degree range
+DS1731: +/- 1.0 degree Celius over -10 to +85 degree range
+
+Note:
+Please refer to the device datasheet for accuracy over other ranges.
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
+{At device power, the default resolution is set to 12-bits}
 
 The following examples show how the 'update_interval' attribute can be
 used to change the conversion time:
-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
