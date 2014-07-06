From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 06 Jul 2014 20:54:59 +0000
Subject: [lm-sensors] [PATCH 1/3] hwmon: (tmp421) Strengthen detect function
Message-Id: <1404680101-8843-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Not all supported chips support the entire I2C address range.
Only accept specific chips at the addresses supported by that chip.
Check for invalid values in conversion rate and status registers.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/tmp421 |  4 ++--
 drivers/hwmon/tmp421.c     | 14 ++++++++++++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/hwmon/tmp421 b/Documentation/hwmon/tmp421
index 0cf07f8..d0e7714 100644
--- a/Documentation/hwmon/tmp421
+++ b/Documentation/hwmon/tmp421
@@ -8,11 +8,11 @@ Supported chips:
     Datasheet: http://focus.ti.com/docs/prod/folders/print/tmp421.html
   * Texas Instruments TMP422
     Prefix: 'tmp422'
-    Addresses scanned: I2C 0x2a, 0x4c, 0x4d, 0x4e and 0x4f
+    Addresses scanned: I2C 0x4c, 0x4d, 0x4e and 0x4f
     Datasheet: http://focus.ti.com/docs/prod/folders/print/tmp421.html
   * Texas Instruments TMP423
     Prefix: 'tmp423'
-    Addresses scanned: I2C 0x2a, 0x4c, 0x4d, 0x4e and 0x4f
+    Addresses scanned: I2C 0x4c and 0x4d
     Datasheet: http://focus.ti.com/docs/prod/folders/print/tmp421.html
 
 Authors:
diff --git a/drivers/hwmon/tmp421.c b/drivers/hwmon/tmp421.c
index 7bab7a9..9438c1b 100644
--- a/drivers/hwmon/tmp421.c
+++ b/drivers/hwmon/tmp421.c
@@ -42,6 +42,7 @@ static const unsigned short normal_i2c[] = { 0x2a, 0x4c, 0x4d, 0x4e, 0x4f,
 enum chips { tmp421, tmp422, tmp423 };
 
 /* The TMP421 registers */
+#define TMP421_STATUS_REG			0x08
 #define TMP421_CONFIG_REG_1			0x09
 #define TMP421_CONVERSION_RATE_REG		0x0B
 #define TMP421_MANUFACTURER_ID_REG		0xFE
@@ -235,6 +236,7 @@ static int tmp421_detect(struct i2c_client *client,
 	enum chips kind;
 	struct i2c_adapter *adapter = client->adapter;
 	const char *names[] = { "TMP421", "TMP422", "TMP423" };
+	int addr = client->addr;
 	u8 reg;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
@@ -244,15 +246,27 @@ static int tmp421_detect(struct i2c_client *client,
 	if (reg != TMP421_MANUFACTURER_ID)
 		return -ENODEV;
 
+	reg = i2c_smbus_read_byte_data(client, TMP421_CONVERSION_RATE_REG);
+	if (reg & 0xf8)
+		return -ENODEV;
+
+	reg = i2c_smbus_read_byte_data(client, TMP421_STATUS_REG);
+	if (reg & 0x7f)
+		return -ENODEV;
+
 	reg = i2c_smbus_read_byte_data(client, TMP421_DEVICE_ID_REG);
 	switch (reg) {
 	case TMP421_DEVICE_ID:
 		kind = tmp421;
 		break;
 	case TMP422_DEVICE_ID:
+		if (addr = 0x2a)
+			return -ENODEV;
 		kind = tmp422;
 		break;
 	case TMP423_DEVICE_ID:
+		if (addr != 0x4c && addr != 0x4d)
+			return -ENODEV;
 		kind = tmp423;
 		break;
 	default:
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
