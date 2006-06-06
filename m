From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Tue, 06 Jun 2006 14:41:09 +0000
Subject: [lm-sensors] [PATCH] I2C: *write_block* doesn't modify the data -
Message-Id: <m364jez6re.fsf@defiant.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

The attached patch marks i2c_smbus_write_block_data() and
i2c_smbus_write_i2c_block_data() buffers as const.

Signed-off-by: Krzysztof Halasa <khc at pm.waw.pl>

--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -916,6 +916,6 @@ s32 i2c_smbus_write_word_data(struct i2c
 }
 
 s32 i2c_smbus_write_block_data(struct i2c_client *client, u8 command,
-			       u8 length, u8 *values)
+			       u8 length, const u8 *values)
 {
 	union i2c_smbus_data data;
@@ -947,7 +947,7 @@ s32 i2c_smbus_read_i2c_block_data(struct
 }
 
 s32 i2c_smbus_write_i2c_block_data(struct i2c_client *client, u8 command,
-				   u8 length, u8 *values)
+				   u8 length, const u8 *values)
 {
 	union i2c_smbus_data data;
 
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -94,15 +94,14 @@ extern s32 i2c_smbus_write_byte_data(str
 extern s32 i2c_smbus_read_word_data(struct i2c_client * client, u8 command);
 extern s32 i2c_smbus_write_word_data(struct i2c_client * client,
                                      u8 command, u16 value);
-extern s32 i2c_smbus_write_block_data(struct i2c_client * client,
-				      u8 command, u8 length,
-				      u8 *values);
+extern s32 i2c_smbus_write_block_data(struct i2c_client * client, u8 command,
+				      u8 length, const u8 *values);
 /* Returns the number of read bytes */
 extern s32 i2c_smbus_read_i2c_block_data(struct i2c_client * client,
 					 u8 command, u8 *values);
 extern s32 i2c_smbus_write_i2c_block_data(struct i2c_client * client,
 					  u8 command, u8 length,
-					  u8 *values);
+					  const u8 *values);
 
 /*
  * A driver is capable of handling one or more physical devices present on

