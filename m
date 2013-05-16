From: Robert Coulson <rob.coulson@gmail.com>
Date: Thu, 16 May 2013 21:56:33 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon (ds1621): Add ds1631 chip support to ds1621 driver
Message-Id: <1368742242-15191-2-git-send-email-rob.coulson@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add definitions, information, and code for ds1631 chip support
in the ds1621 driver.

Signed-off-by: Robert Coulson <rob.coulson@gmail.com>
---
 drivers/hwmon/ds1621.c |   27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/ds1621.c b/drivers/hwmon/ds1621.c
index efd4cca..d4f02a8 100644
--- a/drivers/hwmon/ds1621.c
+++ b/drivers/hwmon/ds1621.c
@@ -10,8 +10,8 @@
  * resolution, a thermal alarm output (Tout), and user-defined minimum
  * and maximum temperature thresholds (TH & TL).
  *
- * The DS1625 & DS1721 are pin compatible with the DS1621 and similar
- * in operation, with slight variations as noted in the device
+ * The DS1625, DS1631, & DS1721 are pin compatible with the DS1621 and
+ * similar in operation, with slight variations as noted in the device
  * datasheets (please refer to www.maximintegrated.com for specific
  * device information).
  *
@@ -51,7 +51,7 @@ static const unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b, 0x4c,
 					0x4d, 0x4e, 0x4f, I2C_CLIENT_END };
 
 /* Supported devices */
-enum chips { ds1621, ds1625, ds1721 };
+enum chips { ds1621, ds1625, ds1631, ds1721 };
 
 /* Insmod parameters */
 static int polarity = -1;
@@ -69,6 +69,10 @@ MODULE_PARM_DESC(polarity, "Output's polarity: 0 = active high, 1 = active low")
  *   7    6    5    4    3    2    1    0
  * |Done|THF |TLF |NVB | 1  | 0  |POL |1SHOT|
  *
+ * - DS1631:
+ *   7    6    5    4    3    2    1    0
+ * |Done|THF |TLF |NVB | R1 | R0 |POL |1SHOT|
+ *
  * - DS1721:
  *   7    6    5    4    3    2    1    0
  * |Done| X  | X  | U  | R1 | R0 |POL |1SHOT|
@@ -139,8 +143,8 @@ static inline int DS1621_TEMP_FROM_REG(u16 reg)
 /*
  * TEMP: 0.001C/bit (-55C to +125C)
  * REG:
- *  - 1621, 1625: x = 0.5C
- *  - 1721:       x = 0.0625C
+ *  - 1621, 1625: 0.5C/bit
+ *  - 1631, 1721: 0.0625C/bit
  * Assume highest resolution and let the bits fall where they may..
  */
 static inline u16 DS1621_TEMP_TO_REG(long temp)
@@ -174,6 +178,7 @@ static void ds1621_init_client(struct i2c_client *client)
 		data->update_interval = DS1625_CONVERSION_MAX;
 		sreg = DS1621_COM_START;
 		break;
+	case ds1631:
 	case ds1721:
 		resol = (new_conf & DS1621_REG_CONFIG_RESOL) >>
 			 DS1621_REG_CONFIG_RESOL_SHIFT;
@@ -344,7 +349,7 @@ static umode_t ds1621_attribute_visible(struct kobject *kobj,
 
 	devattr = container_of(attr, struct device_attribute, attr);
 	if (attr = &dev_attr_update_interval.attr)
-		if (data->kind != ds1721)
+		if (data->kind = ds1621 || data->kind = ds1625)
 			/* shhh, we're hiding update_interval */
 			return 0;
 	return attr->mode;
@@ -378,7 +383,14 @@ static int ds1621_detect(struct i2c_client *client,
 	conf = i2c_smbus_read_byte_data(client, DS1621_REG_CONF);
 	if (conf < 0 || conf & DS1621_REG_CONFIG_NVB)
 		return -ENODEV;
-	/* The 7 lowest bits of a temperature should always be 0. */
+	/*
+	 * The ds1621 & ds1625 use 9-bit resolution, so the 7 lowest bits
+	 * of the temperature should always be 0 (NOTE: The other chips
+	 * have multi-resolution support, so if they have 9-bit resolution
+	 * configured and the min/max temperature values set accordingly,
+	 * then if not explicitly instantiated, they *will* appear as and
+	 * emulate a ds1621 device).
+	 */
 	for (i = 0; i < ARRAY_SIZE(DS1621_REG_TEMP); i++) {
 		temp = i2c_smbus_read_word_data(client, DS1621_REG_TEMP[i]);
 		if (temp < 0 || (temp & 0x7f00))
@@ -440,6 +452,7 @@ static int ds1621_remove(struct i2c_client *client)
 static const struct i2c_device_id ds1621_id[] = {
 	{ "ds1621", ds1621 },
 	{ "ds1625", ds1625 },
+	{ "ds1631", ds1631 },
 	{ "ds1721", ds1721 },
 	{ }
 };
-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
