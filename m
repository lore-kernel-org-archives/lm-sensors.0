From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 07 Aug 2015 08:44:16 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (ltc2978) Move code to read chip ID into separate function
Message-Id: <1438937057-1598-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Verifying the chip type is getting more complicated with new chips,
since not all chips support the same mechanism to read the chip type.
Move the code into a separate function to simplify adding support for
those chips.

Cc: Ananda Babu Nettam <anandab@juniper.net>
Cc: Amit U Jain <amjain@juniper.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
I just realized that the LTM4676 patch depends on two other patches
which I did not send out yet. These two patches have to be applied
first.

 drivers/hwmon/pmbus/ltc2978.c | 51 +++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 21 deletions(-)

diff --git a/drivers/hwmon/pmbus/ltc2978.c b/drivers/hwmon/pmbus/ltc2978.c
index 33081d1d1c5a..a27debafaad9 100644
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
+	int i;
 	struct ltc2978_data *data;
 	struct pmbus_driver_info *info;
 
@@ -404,27 +430,10 @@ static int ltc2978_probe(struct i2c_client *client,
 	if (!data)
 		return -ENOMEM;
 
-	chip_id = i2c_smbus_read_word_data(client, LTC2978_MFR_SPECIAL_ID);
-	if (chip_id < 0)
-		return chip_id;
+	data->id = ltc2978_get_id(client);
+	if (data->id < 0)
+		return data->id;
 
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
 	if (data->id != id->driver_data)
 		dev_warn(&client->dev,
 			 "Device mismatch: Configured %s, detected %s\n",
-- 
2.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
