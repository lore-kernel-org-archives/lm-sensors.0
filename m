From: Robert Coulson <rob.coulson@gmail.com>
Date: Mon, 20 May 2013 22:31:57 +0000
Subject: [lm-sensors] [PATCH] hwmon (ds1621): Deprecate detection function
Message-Id: <1369089117-28584-1-git-send-email-rob.coulson@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20130520222921.GA8207@roeck-us.net>
In-Reply-To: <20130520222921.GA8207@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Due to a lack of device and vendor identification registers, the
Dallas/Maxim DS16xx devices cannot be uniquely detected, sometimes
resulting in false positives. Therefore, the detection function is
being deprecated in favor of explicit device instatiation.

Signed-off-by: Robert Coulson <rob.coulson@gmail.com>
---
 drivers/hwmon/ds1621.c |   43 -------------------------------------------
 1 file changed, 43 deletions(-)

diff --git a/drivers/hwmon/ds1621.c b/drivers/hwmon/ds1621.c
index d4f02a8..124fc83 100644
--- a/drivers/hwmon/ds1621.c
+++ b/drivers/hwmon/ds1621.c
@@ -360,48 +360,6 @@ static const struct attribute_group ds1621_group = {
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
@@ -467,7 +425,6 @@ static struct i2c_driver ds1621_driver = {
 	.probe		= ds1621_probe,
 	.remove		= ds1621_remove,
 	.id_table	= ds1621_id,
-	.detect		= ds1621_detect,
 	.address_list	= normal_i2c,
 };
 
-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
