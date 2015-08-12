From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 12 Aug 2015 18:18:49 +0000
Subject: [lm-sensors] [PATCH v2 1/4] hwmon: (ltc2978) Move code to read chip ID into separate function
Message-Id: <1439403532-30884-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Verifying the chip type is getting more complicated with new chips,
since not all chips support the same mechanism to read the chip type.
Move the code into a separate function to simplify adding support for
those chips.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Fixed bug handling chip ID if ltc2978_get_id() returns a negative number

 drivers/hwmon/pmbus/ltc2978.c | 48 ++++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/drivers/hwmon/pmbus/ltc2978.c b/drivers/hwmon/pmbus/ltc2978.c
index 33081d1d1c5a..7e10fbf8e133 100644
--- a/drivers/hwmon/pmbus/ltc2978.c
+++ b/drivers/hwmon/pmbus/ltc2978.c
@@ -388,10 +388,36 @@ static const struct regulator_desc ltc2978_reg_desc[] = {
 };
 #endif /* CONFIG_SENSORS_LTC2978_REGULATOR */
 
+static int ltc2978_get_id(struct i2c_client *client)
+{
+	int chip_id;
+
+	chip_id = i2c_smbus_read_word_data(client, LTC2978_MFR_SPECIAL_ID);
+	if (chip_id < 0)
+		return chip_id;
+
+	if (chip_id = LTC2974_ID_REV1 || chip_id = LTC2974_ID_REV2)
+		return ltc2974;
+	else if (chip_id = LTC2977_ID)
+		return ltc2977;
+	else if (chip_id = LTC2978_ID_REV1 || chip_id = LTC2978_ID_REV2 ||
+		 chip_id = LTC2978A_ID)
+		return ltc2978;
+	else if ((chip_id & LTC3880_ID_MASK) = LTC3880_ID)
+		return ltc3880;
+	else if ((chip_id & LTC3883_ID_MASK) = LTC3883_ID)
+		return ltc3883;
+	else if ((chip_id & LTM4676_ID_MASK) = LTM4676_ID)
+		return ltm4676;
+
+	dev_err(&client->dev, "Unsupported chip ID 0x%x\n", chip_id);
+	return -ENODEV;
+}
+
 static int ltc2978_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
-	int chip_id, i;
+	int i, chip_id;
 	struct ltc2978_data *data;
 	struct pmbus_driver_info *info;
 
@@ -404,27 +430,11 @@ static int ltc2978_probe(struct i2c_client *client,
 	if (!data)
 		return -ENOMEM;
 
-	chip_id = i2c_smbus_read_word_data(client, LTC2978_MFR_SPECIAL_ID);
+	chip_id = ltc2978_get_id(client);
 	if (chip_id < 0)
 		return chip_id;
 
-	if (chip_id = LTC2974_ID_REV1 || chip_id = LTC2974_ID_REV2) {
-		data->id = ltc2974;
-	} else if (chip_id = LTC2977_ID) {
-		data->id = ltc2977;
-	} else if (chip_id = LTC2978_ID_REV1 || chip_id = LTC2978_ID_REV2 ||
-		   chip_id = LTC2978A_ID) {
-		data->id = ltc2978;
-	} else if ((chip_id & LTC3880_ID_MASK) = LTC3880_ID) {
-		data->id = ltc3880;
-	} else if ((chip_id & LTC3883_ID_MASK) = LTC3883_ID) {
-		data->id = ltc3883;
-	} else if ((chip_id & LTM4676_ID_MASK) = LTM4676_ID) {
-		data->id = ltm4676;
-	} else {
-		dev_err(&client->dev, "Unsupported chip ID 0x%x\n", chip_id);
-		return -ENODEV;
-	}
+	data->id = chip_id;
 	if (data->id != id->driver_data)
 		dev_warn(&client->dev,
 			 "Device mismatch: Configured %s, detected %s\n",
-- 
2.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
