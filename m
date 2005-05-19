From: minyard@acm.org (Corey Minyard)
Date: Thu, 19 May 2005 06:25:40 +0000
Subject: [PATCH] Add a non-blocking interface to the I2C code, part 6
Message-Id: <42261C39.30000@acm.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <42261AFB.40001@acm.org>
In-Reply-To: <42261AFB.40001@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>, Sensors <sensors@stimpy.netroedge.com>

See part 1 for details on what this does...

-------------- next part --------------
This adds back in the i2c_smbus_read_block_data() function
which is needed by the IPMI SMB driver (coming soon).

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.11-rc5-mm1/drivers/i2c/i2c-core.c
=================================--- linux-2.6.11-rc5-mm1.orig/drivers/i2c/i2c-core.c
+++ linux-2.6.11-rc5-mm1/drivers/i2c/i2c-core.c
@@ -1250,6 +1250,23 @@
 }
 
 /* Returns the number of read bytes */
+s32 i2c_smbus_read_block_data(struct i2c_client *client, u8 command,
+			      u8 *values)
+{
+	union i2c_smbus_data data;
+	int i;
+	if (i2c_smbus_xfer(client->adapter,client->addr,client->flags,
+	                      I2C_SMBUS_READ,command,
+	                      I2C_SMBUS_BLOCK_DATA,&data))
+		return -1;
+	else {
+		for (i = 1; i <= data.block[0]; i++)
+			values[i-1] = data.block[i];
+		return data.block[0];
+	}
+}
+
+/* Returns the number of read bytes */
 s32 i2c_smbus_read_i2c_block_data(struct i2c_client *client, u8 command, u8 *values)
 {
 	union i2c_smbus_data data;
@@ -1731,6 +1748,7 @@
 EXPORT_SYMBOL(i2c_smbus_read_word_data);
 EXPORT_SYMBOL(i2c_smbus_write_word_data);
 EXPORT_SYMBOL(i2c_smbus_write_block_data);
+EXPORT_SYMBOL(i2c_smbus_read_block_data);
 EXPORT_SYMBOL(i2c_smbus_read_i2c_block_data);
 
 EXPORT_SYMBOL(i2c_non_blocking_capable);
Index: linux-2.6.11-rc5-mm1/include/linux/i2c.h
=================================--- linux-2.6.11-rc5-mm1.orig/include/linux/i2c.h
+++ linux-2.6.11-rc5-mm1/include/linux/i2c.h
@@ -99,6 +99,8 @@
 extern s32 i2c_smbus_write_block_data(struct i2c_client * client,
 				      u8 command, u8 length,
 				      u8 *values);
+extern s32 i2c_smbus_read_block_data(struct i2c_client * client,
+				     u8 command, u8 *values);
 extern s32 i2c_smbus_read_i2c_block_data(struct i2c_client * client,
 					 u8 command, u8 *values);
 
