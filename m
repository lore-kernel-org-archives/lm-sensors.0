From: Robert Coulson <rob.coulson@gmail.com>
Date: Tue, 11 Jun 2013 01:46:02 +0000
Subject: [lm-sensors] [PATCH 1/2 v2] hwmon (ds1621): Add DS1731 chip support to ds1621 driver
Message-Id: <1370915163-30293-2-git-send-email-rob.coulson@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

These changes add DS1731 chip support to the ds1621 driver,
Kconfig, and documentation.

Signed-off-by: Robert Coulson <rob.coulson@gmail.com>
---

v2 - Updated with v1 review comments

 Documentation/hwmon/ds1621 |   30 ++++++++++++++++++------------
 drivers/hwmon/Kconfig      |    1 +
 drivers/hwmon/ds1621.c     |   12 +++++++-----
 3 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/Documentation/hwmon/ds1621 b/Documentation/hwmon/ds1621
index 2022379..201dc6b 100644
--- a/Documentation/hwmon/ds1621
+++ b/Documentation/hwmon/ds1621
@@ -22,6 +22,11 @@ Supported chips:
     Addresses scanned: none
     Datasheet: Publicly available from www.maximintegrated.com
 
+  * Maxim Integrated DS1731
+    Prefix: 'ds1731'
+    Addresses scanned: none
+    Datasheet: Publicly available from www.maximintegrated.com
+
 Authors:
         Christian W. Zuckschwerdt <zany@triq.net>
         valuable contributions by Jan M. Sendler <sendler@sendler.de>
@@ -72,7 +77,7 @@ Temperature conversion of the DS1621 takes up to 1000ms; internal access to
 non-volatile registers may last for 10ms or below.
 
 The DS1625 is pin compatible and functionally equivalent with the DS1621,
-but the DS1621 is meant to replace it. The DS1631 and DS1721 are also
+but the DS1621 is meant to replace it. The DS1631, DS1721, & DS1731 are also
 pin compatible with the DS1621, but provide multi-resolution support.
 
 Since there is no version or vendor identification register, there is
@@ -84,26 +89,27 @@ explicitly instantiated, one device per address, in this address
 range: 0x48..0x4f.
 
 The DS1721 is pin compatible with the DS1621, has an accuracy of +/- 1.0
-degree Celius over a -10 to +85 degree range, a minimum/maximum alarm
-default setting of 75 and 80 degrees respectifully, and a maximum conversion
-time of 750ms.
+degree Celius (from -10 to +85 degrees), a minimum/maximum alarm default
+setting of 75 and 80 degrees respectively, and a maximum conversion time
+of 750ms.
 
 In addition, the DS1721 supports four resolution settings from 9 to 12 bits
-(defined in degrees C per LSB: 0.5, 0.25, 0.125, and 0.0625, respectifully),
+(defined in degrees C per LSB: 0.5, 0.25, 0.125, and 0.0625, respectively),
 that are set at device power on to the highest resolution: 12-bits.
 
 One additional note about the ds1721 is that although the data sheet says
 the temperature flags (THF and TLF) are used internally, these flags do
 get set and cleared as the actual temperature crosses the min or max settings.
 
-The DS1631 is also pin compatible with the DS1621 and feature compatible with
-the DS1721, however the DS1631 accuracy is +/- 0.5 degree Celius over the
-same range.
+The DS1631 and DS1731 are pin compatible with the DS1621 and feature compatible
+with the DS1721. However, the DS1631 accuracy is +/- 0.5 degree Celius (from 0
+to +70 degrees), while the DS1731 accuracy is +/-1 degree Celius (from -10 to
++85 degrees).
 
-Changing the DS1631/1721 resolution mode affects the conversion time and can be
-done from userspace, via the device 'update_interval' sysfs attribute. This
-attribute will normalize range of input values to the device maximum resolution
-values defined in the datasheet as such:
+The resolution mode for the DS1631, DS1721, or DS1731 can be changed from
+userspace, via the device 'update_interval' sysfs attribute. This attribute
+will normalize the range of input values to the device maximum resolution
+values defined in the datasheet as follows:
 
 Resolution    Conversion Time    Input Range
  (C/LSB)       (msec)             (msec)
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 0f20eef..38c27b2 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -324,6 +324,7 @@ config SENSORS_DS1621
 	  - Dallas Semiconductor DS1625
 	  - Maxim Integrated DS1631
 	  - Maxim Integrated DS1721
+	  - Maxim Integrated DS1731
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called ds1621.
diff --git a/drivers/hwmon/ds1621.c b/drivers/hwmon/ds1621.c
index 1587a7c..317f683 100644
--- a/drivers/hwmon/ds1621.c
+++ b/drivers/hwmon/ds1621.c
@@ -10,8 +10,8 @@
  * resolution, a thermal alarm output (Tout), and user-defined minimum
  * and maximum temperature thresholds (TH & TL).
  *
- * The DS1625, DS1631, & DS1721 are pin compatible with the DS1621 and
- * similar in operation, with slight variations as noted in the device
+ * The DS1625, DS1631, DS1721, & DS1731 are pin compatible with the DS1621
+ * and similar in operation, with slight variations as noted in the device
  * datasheets (please refer to www.maximintegrated.com for specific
  * device information).
  *
@@ -47,7 +47,7 @@
 #include <linux/kernel.h>
 
 /* Supported devices */
-enum chips { ds1621, ds1625, ds1631, ds1721 };
+enum chips { ds1621, ds1625, ds1631, ds1721, ds1731 };
 
 /* Insmod parameters */
 static int polarity = -1;
@@ -65,7 +65,7 @@ MODULE_PARM_DESC(polarity, "Output's polarity: 0 = active high, 1 = active low")
  *   7    6    5    4    3    2    1    0
  * |Done|THF |TLF |NVB | 1  | 0  |POL |1SHOT|
  *
- * - DS1631:
+ * - DS1631, DS1731:
  *   7    6    5    4    3    2    1    0
  * |Done|THF |TLF |NVB | R1 | R0 |POL |1SHOT|
  *
@@ -140,7 +140,7 @@ static inline int DS1621_TEMP_FROM_REG(u16 reg)
  * TEMP: 0.001C/bit (-55C to +125C)
  * REG:
  *  - 1621, 1625: 0.5C/bit
- *  - 1631, 1721: 0.0625C/bit
+ *  - 1631, 1721, 1731: 0.0625C/bit
  * Assume highest resolution and let the bits fall where they may..
  */
 static inline u16 DS1621_TEMP_TO_REG(long temp)
@@ -176,6 +176,7 @@ static void ds1621_init_client(struct i2c_client *client)
 		break;
 	case ds1631:
 	case ds1721:
+	case ds1731:
 		resol = (new_conf & DS1621_REG_CONFIG_RESOL) >>
 			 DS1621_REG_CONFIG_RESOL_SHIFT;
 		data->update_interval = ds1721_convrates[resol];
@@ -406,6 +407,7 @@ static const struct i2c_device_id ds1621_id[] = {
 	{ "ds1625", ds1625 },
 	{ "ds1631", ds1631 },
 	{ "ds1721", ds1721 },
+	{ "ds1731", ds1731 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ds1621_id);
-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
