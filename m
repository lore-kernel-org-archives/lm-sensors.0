From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 09 Jan 2006 21:49:11 +0000
Subject: [lm-sensors] [PATCH 03/11] i2c: Resurrect
Message-Id: <20060109224911.163e5927.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=i2c-add-i2c-block-write.patch

Resurrect i2c_smbus_write_i2c_block_data. Benjamin Herrenschmidt
needs it.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Cc: Benjamin Herrenschmidt <benh at kernel.crashing.org>
---
 drivers/i2c/i2c-core.c |   15 +++++++++++++++
 include/linux/i2c.h    |    3 +++
 2 files changed, 18 insertions(+)

--- linux-2.6.15-git.orig/drivers/i2c/i2c-core.c	2006-01-08 10:55:58.000000000 +0100
+++ linux-2.6.15-git/drivers/i2c/i2c-core.c	2006-01-08 11:17:57.000000000 +0100
@@ -948,6 +948,20 @@
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
@@ -1152,6 +1166,7 @@
 EXPORT_SYMBOL(i2c_smbus_write_word_data);
 EXPORT_SYMBOL(i2c_smbus_write_block_data);
 EXPORT_SYMBOL(i2c_smbus_read_i2c_block_data);
+EXPORT_SYMBOL(i2c_smbus_write_i2c_block_data);
 
 MODULE_AUTHOR("Simon G. Vogl <simon at tk.uni-linz.ac.at>");
 MODULE_DESCRIPTION("I2C-Bus main module");
--- linux-2.6.15-git.orig/include/linux/i2c.h	2006-01-08 10:56:08.000000000 +0100
+++ linux-2.6.15-git/include/linux/i2c.h	2006-01-08 11:02:00.000000000 +0100
@@ -100,6 +100,9 @@
 /* Returns the number of read bytes */
 extern s32 i2c_smbus_read_i2c_block_data(struct i2c_client * client,
 					 u8 command, u8 *values);
+extern s32 i2c_smbus_write_i2c_block_data(struct i2c_client * client,
+					  u8 command, u8 length,
+					  u8 *values);
 
 /*
  * A driver is capable of handling one or more physical devices present on

-- 
Jean Delvare

