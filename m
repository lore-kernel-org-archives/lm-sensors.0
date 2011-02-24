From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 24 Feb 2011 10:23:22 +0000
Subject: [lm-sensors] [PATCH] hwmon: (lm75) Speed up detection
Message-Id: <20110224112322.3a47636e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Make the LM75/LM75A device detection faster:

* Don't read the current temperature value when we don't use it.
* Check for unused bits in the configuration register as soon as we
  have read its value.
* Don't use word reads, not all devices support this, and some which
  don't misbehave when you try.
* Check for cycling register values every 40 register addresses
  instead of every 8, it's 5 times faster and just as efficient.

Some of these improvements come straight from the user-space
sensors-detect script, so both detection routines are in line now.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
---
 drivers/hwmon/lm75.c |   40 +++++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

--- linux-2.6.38-rc5.orig/drivers/hwmon/lm75.c	2011-02-24 08:47:12.000000000 +0100
+++ linux-2.6.38-rc5/drivers/hwmon/lm75.c	2011-02-24 10:57:46.000000000 +0100
@@ -240,7 +240,7 @@ static int lm75_detect(struct i2c_client
 {
 	struct i2c_adapter *adapter = new_client->adapter;
 	int i;
-	int cur, conf, hyst, os;
+	int conf, hyst, os;
 	bool is_lm75a = 0;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
@@ -261,8 +261,10 @@ static int lm75_detect(struct i2c_client
 	   register 7, and unused registers return 0xff rather than the
 	   last read value. */
 
-	cur = i2c_smbus_read_word_data(new_client, 0);
+	/* Unused bits */
 	conf = i2c_smbus_read_byte_data(new_client, 1);
+	if (conf & 0xe0)
+		return -ENODEV;
 
 	/* First check for LM75A */
 	if (i2c_smbus_read_byte_data(new_client, 7) = LM75A_ID) {
@@ -273,33 +275,29 @@ static int lm75_detect(struct i2c_client
 		 || i2c_smbus_read_byte_data(new_client, 6) != 0xff)
 			return -ENODEV;
 		is_lm75a = 1;
-		hyst = i2c_smbus_read_word_data(new_client, 2);
-		os = i2c_smbus_read_word_data(new_client, 3);
+		hyst = i2c_smbus_read_byte_data(new_client, 2);
+		os = i2c_smbus_read_byte_data(new_client, 3);
 	} else { /* Traditional style LM75 detection */
 		/* Unused addresses */
-		hyst = i2c_smbus_read_word_data(new_client, 2);
-		if (i2c_smbus_read_word_data(new_client, 4) != hyst
-		 || i2c_smbus_read_word_data(new_client, 5) != hyst
-		 || i2c_smbus_read_word_data(new_client, 6) != hyst
-		 || i2c_smbus_read_word_data(new_client, 7) != hyst)
+		hyst = i2c_smbus_read_byte_data(new_client, 2);
+		if (i2c_smbus_read_byte_data(new_client, 4) != hyst
+		 || i2c_smbus_read_byte_data(new_client, 5) != hyst
+		 || i2c_smbus_read_byte_data(new_client, 6) != hyst
+		 || i2c_smbus_read_byte_data(new_client, 7) != hyst)
 			return -ENODEV;
-		os = i2c_smbus_read_word_data(new_client, 3);
-		if (i2c_smbus_read_word_data(new_client, 4) != os
-		 || i2c_smbus_read_word_data(new_client, 5) != os
-		 || i2c_smbus_read_word_data(new_client, 6) != os
-		 || i2c_smbus_read_word_data(new_client, 7) != os)
+		os = i2c_smbus_read_byte_data(new_client, 3);
+		if (i2c_smbus_read_byte_data(new_client, 4) != os
+		 || i2c_smbus_read_byte_data(new_client, 5) != os
+		 || i2c_smbus_read_byte_data(new_client, 6) != os
+		 || i2c_smbus_read_byte_data(new_client, 7) != os)
 			return -ENODEV;
 	}
 
-	/* Unused bits */
-	if (conf & 0xe0)
-		return -ENODEV;
-
 	/* Addresses cycling */
-	for (i = 8; i < 0xff; i += 8) {
+	for (i = 8; i <= 248; i += 40) {
 		if (i2c_smbus_read_byte_data(new_client, i + 1) != conf
-		 || i2c_smbus_read_word_data(new_client, i + 2) != hyst
-		 || i2c_smbus_read_word_data(new_client, i + 3) != os)
+		 || i2c_smbus_read_byte_data(new_client, i + 2) != hyst
+		 || i2c_smbus_read_byte_data(new_client, i + 3) != os)
 			return -ENODEV;
 		if (is_lm75a && i2c_smbus_read_byte_data(new_client, i + 7)
 				!= LM75A_ID)


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
