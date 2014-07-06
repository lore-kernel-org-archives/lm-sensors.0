From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 06 Jul 2014 20:55:00 +0000
Subject: [lm-sensors] [PATCH 2/3] hwmon: (tmp421) Add support for TMP441 and TMP442
Message-Id: <1404680101-8843-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

TMP441 and TMP442 are compatible to TMP421 and TMP422.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/tmp421 | 22 +++++++++++++++-------
 drivers/hwmon/Kconfig      |  2 +-
 drivers/hwmon/tmp421.c     | 19 ++++++++++++++++---
 3 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/Documentation/hwmon/tmp421 b/Documentation/hwmon/tmp421
index d0e7714..eac5423 100644
--- a/Documentation/hwmon/tmp421
+++ b/Documentation/hwmon/tmp421
@@ -14,6 +14,14 @@ Supported chips:
     Prefix: 'tmp423'
     Addresses scanned: I2C 0x4c and 0x4d
     Datasheet: http://focus.ti.com/docs/prod/folders/print/tmp421.html
+  * Texas Instruments TMP441
+    Prefix: 'tmp441'
+    Addresses scanned: I2C 0x2a, 0x4c, 0x4d, 0x4e and 0x4f
+    Datasheet: http://www.ti.com/product/tmp441
+  * Texas Instruments TMP442
+    Prefix: 'tmp442'
+    Addresses scanned: I2C 0x4c and 0x4d
+    Datasheet: http://www.ti.com/product/tmp441
 
 Authors:
 	Andre Prendel <andre.prendel@gmx.de>
@@ -21,13 +29,13 @@ Authors:
 Description
 -----------
 
-This driver implements support for Texas Instruments TMP421, TMP422
-and TMP423 temperature sensor chips. These chips implement one local
-and up to one (TMP421), up to two (TMP422) or up to three (TMP423)
-remote sensors. Temperature is measured in degrees Celsius. The chips
-are wired over I2C/SMBus and specified over a temperature range of -40
-to +125 degrees Celsius. Resolution for both the local and remote
-channels is 0.0625 degree C.
+This driver implements support for Texas Instruments TMP421, TMP422,
+TMP423, TMP441, and TMP442 temperature sensor chips. These chips
+implement one local and up to one (TMP421, TMP441), up to two (TMP422,
+TMP442) or up to three (TMP423) remote sensors. Temperature is measured
+in degrees Celsius. The chips are wired over I2C/SMBus and specified
+over a temperature range of -40 to +125 degrees Celsius. Resolution
+for both the local and remote channels is 0.0625 degree C.
 
 The chips support only temperature measurement. The driver exports
 the temperature values via the following sysfs files:
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index ae1e216..37908ff 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1431,7 +1431,7 @@ config SENSORS_TMP421
 	depends on I2C
 	help
 	  If you say yes here you get support for Texas Instruments TMP421,
-	  TMP422 and TMP423 temperature sensor chips.
+	  TMP422, TMP423, TMP441, and TMP442 temperature sensor chips.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called tmp421.
diff --git a/drivers/hwmon/tmp421.c b/drivers/hwmon/tmp421.c
index 9438c1b..f1ce845 100644
--- a/drivers/hwmon/tmp421.c
+++ b/drivers/hwmon/tmp421.c
@@ -21,7 +21,7 @@
 
 /*
  * Driver for the Texas Instruments TMP421 SMBus temperature sensor IC.
- * Supported models: TMP421, TMP422, TMP423
+ * Supported models: TMP421, TMP422, TMP423, TMP441, TMP442
  */
 
 #include <linux/module.h>
@@ -39,7 +39,7 @@
 static const unsigned short normal_i2c[] = { 0x2a, 0x4c, 0x4d, 0x4e, 0x4f,
 					     I2C_CLIENT_END };
 
-enum chips { tmp421, tmp422, tmp423 };
+enum chips { tmp421, tmp422, tmp423, tmp441, tmp442 };
 
 /* The TMP421 registers */
 #define TMP421_STATUS_REG			0x08
@@ -60,11 +60,15 @@ static const u8 TMP421_TEMP_LSB[4]		= { 0x10, 0x11, 0x12, 0x13 };
 #define TMP421_DEVICE_ID			0x21
 #define TMP422_DEVICE_ID			0x22
 #define TMP423_DEVICE_ID			0x23
+#define TMP441_DEVICE_ID			0x41
+#define TMP442_DEVICE_ID			0x42
 
 static const struct i2c_device_id tmp421_id[] = {
 	{ "tmp421", 2 },
 	{ "tmp422", 3 },
 	{ "tmp423", 4 },
+	{ "tmp441", 2 },
+	{ "tmp442", 3 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tmp421_id);
@@ -235,7 +239,8 @@ static int tmp421_detect(struct i2c_client *client,
 {
 	enum chips kind;
 	struct i2c_adapter *adapter = client->adapter;
-	const char *names[] = { "TMP421", "TMP422", "TMP423" };
+	const char * const names[] = { "TMP421", "TMP422", "TMP423",
+				       "TMP441", "TMP442" };
 	int addr = client->addr;
 	u8 reg;
 
@@ -269,6 +274,14 @@ static int tmp421_detect(struct i2c_client *client,
 			return -ENODEV;
 		kind = tmp423;
 		break;
+	case TMP441_DEVICE_ID:
+		kind = tmp441;
+		break;
+	case TMP442_DEVICE_ID:
+		if (addr != 0x4c && addr != 0x4d)
+			return -ENODEV;
+		kind = tmp442;
+		break;
 	default:
 		return -ENODEV;
 	}
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
