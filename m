From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 30 Aug 2011 20:05:17 +0000
Subject: [lm-sensors] [PATCH] hwmon: (lm73) Make detection less problematic
Message-Id: <20110830220517.381f6b4e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Word reads can cause trouble with some I2C devices, so do as much
detection as we can using only byte reads, and only use a word read in
the end to confirm the positive match. Also properly handle read
errors.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Robert Casanova <robertcasanova@nanometrics.ca>
---
 drivers/hwmon/lm73.c |   22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

--- linux-3.1-rc4.orig/drivers/hwmon/lm73.c	2011-07-22 04:17:23.000000000 +0200
+++ linux-3.1-rc4/drivers/hwmon/lm73.c	2011-08-30 21:13:46.000000000 +0200
@@ -150,17 +150,31 @@ static int lm73_detect(struct i2c_client
 			struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = new_client->adapter;
-	u16 id;
-	u8 ctrl;
+	int id, ctrl, conf;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
 					I2C_FUNC_SMBUS_WORD_DATA))
 		return -ENODEV;
 
+	/*
+	 * Do as much detection as possible with byte reads first, as word
+	 * reads can confuse other devices.
+	 */
+	ctrl = i2c_smbus_read_byte_data(new_client, LM73_REG_CTRL);
+	if (ctrl < 0 || (ctrl & 0x10))
+		return -ENODEV;
+
+	conf = i2c_smbus_read_byte_data(new_client, LM73_REG_CONF);
+	if (conf < 0 || (conf & 0x0c))
+		return -ENODEV;
+
+	id = i2c_smbus_read_byte_data(new_client, LM73_REG_ID);
+	if (id < 0 || id != (LM73_ID & 0xff))
+		return -ENODEV;
+
 	/* Check device ID */
 	id = i2c_smbus_read_word_data(new_client, LM73_REG_ID);
-	ctrl = i2c_smbus_read_byte_data(new_client, LM73_REG_CTRL);
-	if ((id != LM73_ID) || (ctrl & 0x10))
+	if (id < 0 || id != LM73_ID)
 		return -ENODEV;
 
 	strlcpy(info->type, "lm73", I2C_NAME_SIZE);


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
