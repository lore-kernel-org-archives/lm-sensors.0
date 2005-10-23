From: R.Marek@sh.cvut.cz (R.Marek@sh.cvut.cz)
Date: Sun, 23 Oct 2005 21:52:29 +0000
Subject: [lm-sensors] [PATCH] add back i2c_smbus_read_block_data
Message-Id: <20051023195202.17325.qmail@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

This patch just adds back the i2c_smbus_read_block_data, it will be used
with lm93 driver.

This patch originated from Eric J. Bowersox [1], but never made it to mainline.
I just redodiffed the patch.

Signed-off-by: Eric J. Bowersox <ericb@aspsys.com>
Signed-off-by: Rudolf Marek <r.marek@sh.cvut.cz>

Please apply,

Regards
Rudolf

[1] 
http://lists.lm-sensors.org/pipermail/lm-sensors/2005-August/013228.html

diff -Naur a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	2005-10-20 08:23:05.000000000 +0200
+++ b/drivers/i2c/i2c-core.c	2005-10-23 18:17:22.731964000 +0200
@@ -984,6 +984,23 @@
 	                      I2C_SMBUS_WORD_DATA,&data);
 }
 
+/* Returns the number of read bytes */
+s32 i2c_smbus_read_block_data(struct i2c_client *client, u8 command,
+			      u8 *values)
+{
+	union i2c_smbus_data data;
+	int i;
+	if (i2c_smbus_xfer(client->adapter, client->addr, client->flags,
+		I2C_SMBUS_READ, command,
+		I2C_SMBUS_BLOCK_DATA, &data))
+		return -1;
+	else {
+		for (i = 1; i <= data.block[0]; i++)
+			values[i-1] = data.block[i];
+		return data.block[0];
+	}
+}
+
 s32 i2c_smbus_write_block_data(struct i2c_client *client, u8 command,
 			       u8 length, u8 *values)
 {
@@ -1227,6 +1244,7 @@
 EXPORT_SYMBOL(i2c_smbus_write_byte_data);
 EXPORT_SYMBOL(i2c_smbus_read_word_data);
 EXPORT_SYMBOL(i2c_smbus_write_word_data);
+EXPORT_SYMBOL(i2c_smbus_read_block_data);
 EXPORT_SYMBOL(i2c_smbus_write_block_data);
 EXPORT_SYMBOL(i2c_smbus_read_i2c_block_data);
 
diff -Naur a/include/linux/i2c.h b/include/linux/i2c.h
--- a/include/linux/i2c.h	2005-10-20 08:23:05.000000000 +0200
+++ b/include/linux/i2c.h	2005-10-23 18:17:22.735964250 +0200
@@ -95,6 +95,8 @@
 extern s32 i2c_smbus_write_word_data(struct i2c_client * client,
                                      u8 command, u16 value);
 /* Returns the number of bytes transferred */
+extern s32 i2c_smbus_read_block_data(struct i2c_client *client,
+					u8 command, u8 *values);
 extern s32 i2c_smbus_write_block_data(struct i2c_client * client,
 				      u8 command, u8 length,
 				      u8 *values);
