From: Robert Coulson <rob.coulson@gmail.com>
Date: Thu, 23 May 2013 16:22:22 +0000
Subject: [lm-sensors] [PATCH v3] hwmon (ds1621): Remove detection function
Message-Id: <1369326142-30781-1-git-send-email-rob.coulson@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Due to a lack of device and vendor identification registers, the
Dallas/Maxim DS16xx devices cannot be uniquely detected, sometimes
resulting in false positives. Therefore, the detection function is
being removed in favor of explicit device instantiation.

Signed-off-by: Robert Coulson <rob.coulson@gmail.com>
---
 Documentation/hwmon/ds1621 |   25 +++++++++++------------
 drivers/hwmon/ds1621.c     |   48 --------------------------------------------
 2 files changed, 12 insertions(+), 61 deletions(-)

v2:
- removed detect function references in ds1621 documentation
- replaced deprecated with removed and fixed a spelling error
v3:
- removed scanned addresses info, tables, and list

diff --git a/Documentation/hwmon/ds1621 b/Documentation/hwmon/ds1621
index 140eab5..2022379 100644
--- a/Documentation/hwmon/ds1621
+++ b/Documentation/hwmon/ds1621
@@ -4,24 +4,22 @@ Kernel driver ds1621
 Supported chips:
   * Dallas Semiconductor & Maxim Integrated DS1621
     Prefix: 'ds1621'
-    Addresses scanned: I2C 0x48 - 0x4f
+    Addresses scanned: none
     Datasheet: Publicly available from www.maximintegrated.com
 
   * Dallas Semiconductor DS1625
-    Prefix:
-     'ds1621' - if binding via _detect function
-     'ds1625' - explicit instantiation
-    Addresses scanned: I2C 0x48 - 0x4f
+    Prefix: 'ds1625'
+    Addresses scanned: none
     Datasheet: Publicly available from www.datasheetarchive.com
 
   * Maxim Integrated DS1631
     Prefix: 'ds1631'
-    Addresses scanned: I2C 0x48 - 0x4f
+    Addresses scanned: none
     Datasheet: Publicly available from www.maximintegrated.com
 
   * Maxim Integrated DS1721
     Prefix: 'ds1721'
-    Addresses scanned: I2C 0x48 - 0x4f
+    Addresses scanned: none
     Datasheet: Publicly available from www.maximintegrated.com
 
 Authors:
@@ -77,12 +75,13 @@ The DS1625 is pin compatible and functionally equivalent with the DS1621,
 but the DS1621 is meant to replace it. The DS1631 and DS1721 are also
 pin compatible with the DS1621, but provide multi-resolution support.
 
-Since there is no version register, there is no unique identification
-for these devices. In addition, the DS1631 and DS1721 will emulate a
-DS1621 device, if not explicitly instantiated (why? because the detect
-function compares the temperature register values bits and checks for a
-9-bit resolution). Therefore, for correct device identification and
-functionality, explicit device instantiation is required.
+Since there is no version or vendor identification register, there is
+no unique identification for these devices. Therefore, explicit device
+instantiation is required for correct device identification and functionality.
+
+And, for correct identification and operation, each device must be
+explicitly instantiated, one device per address, in this address
+range: 0x48..0x4f.
 
 The DS1721 is pin compatible with the DS1621, has an accuracy of +/- 1.0
 degree Celius over a -10 to +85 degree range, a minimum/maximum alarm
diff --git a/drivers/hwmon/ds1621.c b/drivers/hwmon/ds1621.c
index d4f02a8..1ecfcd0 100644
--- a/drivers/hwmon/ds1621.c
+++ b/drivers/hwmon/ds1621.c
@@ -46,10 +46,6 @@
 #include <linux/sysfs.h>
 #include <linux/kernel.h>
 
-/* Addresses to scan */
-static const unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b, 0x4c,
-					0x4d, 0x4e, 0x4f, I2C_CLIENT_END };
-
 /* Supported devices */
 enum chips { ds1621, ds1625, ds1631, ds1721 };
 
@@ -360,48 +356,6 @@ static const struct attribute_group ds1621_group = {
 	.is_visible = ds1621_attribute_visible
 };
 
-
-/* Return 0 if detection is successful, -ENODEV otherwise */
-static int ds1621_detect(struct i2c_client *client,
-			 struct i2c_board_info *info)
-{
-	struct i2c_adapter *adapter = client->adapter;
-	int conf, temp;
-	int i;
-
-	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA
-				     | I2C_FUNC_SMBUS_WORD_DATA
-				     | I2C_FUNC_SMBUS_WRITE_BYTE))
-		return -ENODEV;
-
-	/*
-	 * Now, we do the remaining detection. It is lousy.
-	 *
-	 * The NVB bit should be low if no EEPROM write has been requested
-	 * during the latest 10ms, which is highly improbable in our case.
-	 */
-	conf = i2c_smbus_read_byte_data(client, DS1621_REG_CONF);
-	if (conf < 0 || conf & DS1621_REG_CONFIG_NVB)
-		return -ENODEV;
-	/*
-	 * The ds1621 & ds1625 use 9-bit resolution, so the 7 lowest bits
-	 * of the temperature should always be 0 (NOTE: The other chips
-	 * have multi-resolution support, so if they have 9-bit resolution
-	 * configured and the min/max temperature values set accordingly,
-	 * then if not explicitly instantiated, they *will* appear as and
-	 * emulate a ds1621 device).
-	 */
-	for (i = 0; i < ARRAY_SIZE(DS1621_REG_TEMP); i++) {
-		temp = i2c_smbus_read_word_data(client, DS1621_REG_TEMP[i]);
-		if (temp < 0 || (temp & 0x7f00))
-			return -ENODEV;
-	}
-
-	strlcpy(info->type, "ds1621", I2C_NAME_SIZE);
-
-	return 0;
-}
-
 static int ds1621_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
@@ -467,8 +421,6 @@ static struct i2c_driver ds1621_driver = {
 	.probe		= ds1621_probe,
 	.remove		= ds1621_remove,
 	.id_table	= ds1621_id,
-	.detect		= ds1621_detect,
-	.address_list	= normal_i2c,
 };
 
 module_i2c_driver(ds1621_driver);
-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
