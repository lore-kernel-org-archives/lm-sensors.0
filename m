From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 16 Nov 2014 18:23:14 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (lm95245) Add support for LM95235
Message-Id: <1416162195-25193-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

LM95235 is register compatible to LM95245.

Also update link to LM95245 data sheet.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/lm95245 | 14 +++++++++-----
 drivers/hwmon/lm95245.c     | 31 ++++++++++++++++++++++++-------
 2 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/Documentation/hwmon/lm95245 b/Documentation/hwmon/lm95245
index 77eaf28..d755901 100644
--- a/Documentation/hwmon/lm95245
+++ b/Documentation/hwmon/lm95245
@@ -2,10 +2,14 @@ Kernel driver lm95245
 =========
 
 Supported chips:
-  * National Semiconductor LM95245
+  * TI LM95235
+    Addresses scanned: I2C 0x18, 0x29, 0x4c
+    Datasheet: Publicly available at the TI website
+               http://www.ti.com/lit/ds/symlink/lm95235.pdf
+  * TI / National Semiconductor LM95245
     Addresses scanned: I2C 0x18, 0x19, 0x29, 0x4c, 0x4d
-    Datasheet: Publicly available at the National Semiconductor website
-               http://www.national.com/mpf/LM/LM95245.html
+    Datasheet: Publicly available at the TI website
+               http://www.ti.com/lit/ds/symlink/lm95245.pdf
 
 
 Author: Alexander Stein <alexander.stein@systec-electronic.com>
@@ -13,10 +17,10 @@ Author: Alexander Stein <alexander.stein@systec-electronic.com>
 Description
 -----------
 
-The LM95245 is an 11-bit digital temperature sensor with a 2-wire System
+LM95235 and LM95245 are 11-bit digital temperature sensors with a 2-wire System
 Management Bus (SMBus) interface and TruTherm technology that can monitor
 the temperature of a remote diode as well as its own temperature.
-The LM95245 can be used to very accurately monitor the temperature of
+The chips can be used to very accurately monitor the temperature of
 external devices such as microprocessors.
 
 All temperature values are given in millidegrees Celsius. Local temperature
diff --git a/drivers/hwmon/lm95245.c b/drivers/hwmon/lm95245.c
index 0ae0dfd..a804651 100644
--- a/drivers/hwmon/lm95245.c
+++ b/drivers/hwmon/lm95245.c
@@ -98,7 +98,8 @@ static const unsigned short normal_i2c[] = {
 #define STATUS1_LOC		0x01
 
 #define MANUFACTURER_ID		0x01
-#define DEFAULT_REVISION	0xB3
+#define LM95235_REVISION	0xB1
+#define LM95245_REVISION	0xB3
 
 static const u8 lm95245_reg_address[] = {
 	LM95245_REG_R_LOCAL_TEMPH_S,
@@ -427,17 +428,32 @@ static int lm95245_detect(struct i2c_client *new_client,
 			  struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = new_client->adapter;
+	int address = new_client->addr;
+	const char *name;
+	int rev, id;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -ENODEV;
 
-	if (i2c_smbus_read_byte_data(new_client, LM95245_REG_R_MAN_ID)
-			!= MANUFACTURER_ID
-		|| i2c_smbus_read_byte_data(new_client, LM95245_REG_R_CHIP_ID)
-			!= DEFAULT_REVISION)
+	id = i2c_smbus_read_byte_data(new_client, LM95245_REG_R_MAN_ID);
+	if (id != MANUFACTURER_ID)
 		return -ENODEV;
 
-	strlcpy(info->type, DEVNAME, I2C_NAME_SIZE);
+	rev = i2c_smbus_read_byte_data(new_client, LM95245_REG_R_CHIP_ID);
+	switch (rev) {
+	case LM95235_REVISION:
+		if (address != 0x18 && address != 0x29 && address != 0x4c)
+			return -ENODEV;
+		name = "lm95235";
+		break;
+	case LM95245_REVISION:
+		name = "lm95245";
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	strlcpy(info->type, name, I2C_NAME_SIZE);
 	return 0;
 }
 
@@ -484,7 +500,8 @@ static int lm95245_probe(struct i2c_client *client,
 
 /* Driver data (common to all clients) */
 static const struct i2c_device_id lm95245_id[] = {
-	{ DEVNAME, 0 },
+	{ "lm95235", 0 },
+	{ "lm95245", 1 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, lm95245_id);
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
