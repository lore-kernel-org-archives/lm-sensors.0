From: Robert Coulson <rob.coulson@gmail.com>
Date: Thu, 16 May 2013 21:56:26 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon (ds1621): Add ds1631 information to ds1621 Documentation and Kconfig
Message-Id: <1368742242-15191-3-git-send-email-rob.coulson@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add the ds1631 chip information into the ds1621 driver Kconfig and
Documentation.

Signed-off-by: Robert Coulson <rob.coulson@gmail.com>
---
 Documentation/hwmon/ds1621 |   27 ++++++++++++++++++++++++---
 drivers/hwmon/Kconfig      |    1 +
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/Documentation/hwmon/ds1621 b/Documentation/hwmon/ds1621
index ae29036..140eab5 100644
--- a/Documentation/hwmon/ds1621
+++ b/Documentation/hwmon/ds1621
@@ -14,6 +14,11 @@ Supported chips:
     Addresses scanned: I2C 0x48 - 0x4f
     Datasheet: Publicly available from www.datasheetarchive.com
 
+  * Maxim Integrated DS1631
+    Prefix: 'ds1631'
+    Addresses scanned: I2C 0x48 - 0x4f
+    Datasheet: Publicly available from www.maximintegrated.com
+
   * Maxim Integrated DS1721
     Prefix: 'ds1721'
     Addresses scanned: I2C 0x48 - 0x4f
@@ -69,7 +74,15 @@ Temperature conversion of the DS1621 takes up to 1000ms; internal access to
 non-volatile registers may last for 10ms or below.
 
 The DS1625 is pin compatible and functionally equivalent with the DS1621,
-but the DS1621 is meant to replace it.
+but the DS1621 is meant to replace it. The DS1631 and DS1721 are also
+pin compatible with the DS1621, but provide multi-resolution support.
+
+Since there is no version register, there is no unique identification
+for these devices. In addition, the DS1631 and DS1721 will emulate a
+DS1621 device, if not explicitly instantiated (why? because the detect
+function compares the temperature register values bits and checks for a
+9-bit resolution). Therefore, for correct device identification and
+functionality, explicit device instantiation is required.
 
 The DS1721 is pin compatible with the DS1621, has an accuracy of +/- 1.0
 degree Celius over a -10 to +85 degree range, a minimum/maximum alarm
@@ -78,9 +91,17 @@ time of 750ms.
 
 In addition, the DS1721 supports four resolution settings from 9 to 12 bits
 (defined in degrees C per LSB: 0.5, 0.25, 0.125, and 0.0625, respectifully),
-that are set at device power on to the highest resolution: 12-bits (0.0625 degree C).
+that are set at device power on to the highest resolution: 12-bits.
+
+One additional note about the ds1721 is that although the data sheet says
+the temperature flags (THF and TLF) are used internally, these flags do
+get set and cleared as the actual temperature crosses the min or max settings.
+
+The DS1631 is also pin compatible with the DS1621 and feature compatible with
+the DS1721, however the DS1631 accuracy is +/- 0.5 degree Celius over the
+same range.
 
-Changing the DS1721 resolution mode affects the conversion time and can be
+Changing the DS1631/1721 resolution mode affects the conversion time and can be
 done from userspace, via the device 'update_interval' sysfs attribute. This
 attribute will normalize range of input values to the device maximum resolution
 values defined in the datasheet as such:
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 92e784e..0f20eef 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -322,6 +322,7 @@ config SENSORS_DS1621
 	  Integrated DS1621 sensor chips and compatible models including:
 
 	  - Dallas Semiconductor DS1625
+	  - Maxim Integrated DS1631
 	  - Maxim Integrated DS1721
 
 	  This driver can also be built as a module.  If so, the module
-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
