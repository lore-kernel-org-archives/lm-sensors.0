From: gregkh@suse.de (Greg KH)
Date: Mon, 06 Feb 2006 20:18:56 +0000
Subject: [lm-sensors] [PATCH] I2C: Resurrect i2c_smbus_write_i2c_block_data.
Message-Id: <11392571364148@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] I2C: Resurrect i2c_smbus_write_i2c_block_data.

Signed-off-by: Jean Delvare <khali at linux-fr.org>

---
commit 21bbd691827e3610ef975a88863859381ac8d8e0
tree 3fc8283b25f55f4f216b4fc1bda64fd10335861e
parent 8254fc4afcc81e69428c453cc216aa612c80e98b
author Jean Delvare <khali at linux-fr.org> Mon, 09 Jan 2006 15:19:18 +1100
committer Greg Kroah-Hartman <gregkh at suse.de> Mon, 06 Feb 2006 12:02:14 -0800

 drivers/i2c/i2c-core.c |   15 +++++++++++++++
 include/linux/i2c.h    |    3 +++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 0ce58b5..1a2c9ab 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -946,6 +946,20 @@ s32 i2c_smbus_read_i2c_block_data(struct
 	}
 }
 
+s32 i2c_smbus_write_i2c_block_data(struct i2c_client *client, u8 command,
+				   u8 length, u8 *values)
+{
+	union i2c_smbus_data data;
+
+	if (length > I2C_SMBUS_BLOCK_MAX)
+		length = I2C_SMBUS_BLOCK_MAX;
+	data.block[0] = length;
+	memcpy(data.block + 1, values, length);
+	return i2c_smbus_xfer(client->adapter, client->addr, client->flags,
+			      I2C_SMBUS_WRITE, command,
+			      I2C_SMBUS_I2C_BLOCK_DATA, &data);
+}
+
 /* Simulate a SMBus command using the i2c protocol 
    No checking of parameters is done!  */
 static s32 i2c_smbus_xfer_emulated(struct i2c_adapter * adapter, u16 addr, 
@@ -1150,6 +1164,7 @@ EXPORT_SYMBOL(i2c_smbus_read_word_data);
 EXPORT_SYMBOL(i2c_smbus_write_word_data);
 EXPORT_SYMBOL(i2c_smbus_write_block_data);
 EXPORT_SYMBOL(i2c_smbus_read_i2c_block_data);
+EXPORT_SYMBOL(i2c_smbus_write_i2c_block_data);
 
 MODULE_AUTHOR("Simon G. Vogl <simon at tk.uni-linz.ac.at>");
 MODULE_DESCRIPTION("I2C-Bus main module");
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 7863a59..63f1d63 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -100,6 +100,9 @@ extern s32 i2c_smbus_write_block_data(st
 /* Returns the number of read bytes */
 extern s32 i2c_smbus_read_i2c_block_data(struct i2c_client * client,
 					 u8 command, u8 *values);
+extern s32 i2c_smbus_write_i2c_block_data(struct i2c_client * client,
+					  u8 command, u8 length,
+					  u8 *values);
 
 /*
  * A driver is capable of handling one or more physical devices present on


