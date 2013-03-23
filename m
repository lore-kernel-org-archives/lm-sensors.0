From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 23 Mar 2013 05:43:41 +0000
Subject: [lm-sensors] [PATCH] hwmon: (tmp401) Add support for TMP431
Message-Id: <1364017421-28279-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

TMP431 is compatible to TMP401.

Also add support for additional I2C addresses supported by TMP411B
and TMP411C.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/tmp401 |   16 ++++++++++------
 drivers/hwmon/Kconfig      |    4 ++--
 drivers/hwmon/tmp401.c     |   11 ++++++++---
 3 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/Documentation/hwmon/tmp401 b/Documentation/hwmon/tmp401
index 9fc4472..12e4781 100644
--- a/Documentation/hwmon/tmp401
+++ b/Documentation/hwmon/tmp401
@@ -8,8 +8,12 @@ Supported chips:
     Datasheet: http://focus.ti.com/docs/prod/folders/print/tmp401.html
   * Texas Instruments TMP411
     Prefix: 'tmp411'
-    Addresses scanned: I2C 0x4c
+    Addresses scanned: I2C 0x4c, 0x4d, 0x4e
     Datasheet: http://focus.ti.com/docs/prod/folders/print/tmp411.html
+  * Texas Instruments TMP431
+    Prefix: 'tmp431'
+    Addresses scanned: I2C 0x4c, 0x4d
+    Datasheet: http://focus.ti.com/docs/prod/folders/print/tmp431.html
 
 Authors:
          Hans de Goede <hdegoede@redhat.com>
@@ -18,8 +22,8 @@ Authors:
 Description
 -----------
 
-This driver implements support for Texas Instruments TMP401 and
-TMP411 chips. These chips implements one remote and one local
+This driver implements support for Texas Instruments TMP401, TMP411,
+and TMP431 chips. These chips implement one remote and one local
 temperature sensor. Temperature is measured in degrees
 Celsius. Resolution of the remote sensor is 0.0625 degree. Local
 sensor resolution can be set to 0.5, 0.25, 0.125 or 0.0625 degree (not
@@ -27,10 +31,10 @@ supported by the driver so far, so using the default resolution of 0.5
 degree).
 
 The driver provides the common sysfs-interface for temperatures (see
-/Documentation/hwmon/sysfs-interface under Temperatures).
+Documentation/hwmon/sysfs-interface under Temperatures).
 
-The TMP411 chip is compatible with TMP401. It provides some additional
-features.
+The TMP411 and TMP431 chips are compatible with TMP401. TMP411 provides
+some additional features.
 
 * Minimum and Maximum temperature measured since power-on, chip-reset
 
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 89ac1cb..30351de 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1204,8 +1204,8 @@ config SENSORS_TMP401
 	tristate "Texas Instruments TMP401 and compatibles"
 	depends on I2C
 	help
-	  If you say yes here you get support for Texas Instruments TMP401 and
-	  TMP411 temperature sensor chips.
+	  If you say yes here you get support for Texas Instruments TMP401,
+	  TMP411, and TMP431 temperature sensor chips.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called tmp401.
diff --git a/drivers/hwmon/tmp401.c b/drivers/hwmon/tmp401.c
index c85f696..763115a 100644
--- a/drivers/hwmon/tmp401.c
+++ b/drivers/hwmon/tmp401.c
@@ -40,9 +40,9 @@
 #include <linux/sysfs.h>
 
 /* Addresses to scan */
-static const unsigned short normal_i2c[] = { 0x4c, I2C_CLIENT_END };
+static const unsigned short normal_i2c[] = { 0x4c, 0x4d, 0x4e, I2C_CLIENT_END };
 
-enum chips { tmp401, tmp411 };
+enum chips { tmp401, tmp411, tmp431 };
 
 /*
  * The TMP401 registers, note some registers have different addresses for
@@ -90,6 +90,7 @@ static const u8 TMP411_TEMP_HIGHEST_LSB[2]		= { 0x33, 0x37 };
 #define TMP401_MANUFACTURER_ID			0x55
 #define TMP401_DEVICE_ID			0x11
 #define TMP411_DEVICE_ID			0x12
+#define TMP431_DEVICE_ID			0x31
 
 /*
  * Driver data (common to all clients)
@@ -98,6 +99,7 @@ static const u8 TMP411_TEMP_HIGHEST_LSB[2]		= { 0x33, 0x37 };
 static const struct i2c_device_id tmp401_id[] = {
 	{ "tmp401", tmp401 },
 	{ "tmp411", tmp411 },
+	{ "tmp431", tmp431 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tmp401_id);
@@ -559,6 +561,9 @@ static int tmp401_detect(struct i2c_client *client,
 	case TMP411_DEVICE_ID:
 		kind = tmp411;
 		break;
+	case TMP431_DEVICE_ID:
+		kind = tmp431;
+		break;
 	default:
 		return -ENODEV;
 	}
@@ -602,7 +607,7 @@ static int tmp401_probe(struct i2c_client *client,
 {
 	int i, err = 0;
 	struct tmp401_data *data;
-	const char *names[] = { "TMP401", "TMP411" };
+	const char *names[] = { "TMP401", "TMP411", "TMP431" };
 
 	data = devm_kzalloc(&client->dev, sizeof(struct tmp401_data),
 			    GFP_KERNEL);
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
