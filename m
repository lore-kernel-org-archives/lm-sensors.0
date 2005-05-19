From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:22 +0000
Subject: [PATCH 2.6] Cleanups to the recent smbus functions removal
Message-Id: <20041116223833.4fdeb1aa.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg, all,

This patch cleans up the recent removal of smbus functions proposed by
Arjan and then fixed by Gabriel. Changes are as follow:

1* Discard i2c_smbus_block_process_call, as it isn't used anywhere
   either. I guess that Arjan missed it because it wasn't exported.

2* Document the functions removal, so that people have at least an idea
   that the functions can be restored later if needed.

Maybe it would make sense to apply this before 2.6.10-rc2? Not critical
however, I agree. But obviously safe too, huh? ;)

Thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.6.10-rc2/Documentation/i2c/writing-clients.orig	2004-11-15 20:15:51.000000000 +0100
+++ linux-2.6.10-rc2/Documentation/i2c/writing-clients	2004-11-15 21:50:03.000000000 +0100
@@ -676,14 +676,26 @@
   extern s32 i2c_smbus_read_word_data(struct i2c_client * client, u8 command);
   extern s32 i2c_smbus_write_word_data(struct i2c_client * client,
                                        u8 command, u16 value);
-  extern s32 i2c_smbus_process_call(struct i2c_client * client,
-                                    u8 command, u16 value);
-  extern s32 i2c_smbus_read_block_data(struct i2c_client * client,
-                                       u8 command, u8 *values);
   extern s32 i2c_smbus_write_block_data(struct i2c_client * client,
                                         u8 command, u8 length,
                                         u8 *values);
 
+These ones were removed in Linux 2.6.10 because they had no users, but could
+be added back later if needed:
+
+  extern s32 i2c_smbus_read_i2c_block_data(struct i2c_client * client,
+                                           u8 command, u8 *values);
+  extern s32 i2c_smbus_read_block_data(struct i2c_client * client,
+                                       u8 command, u8 *values);
+  extern s32 i2c_smbus_write_i2c_block_data(struct i2c_client * client,
+                                            u8 command, u8 length,
+                                            u8 *values);
+  extern s32 i2c_smbus_process_call(struct i2c_client * client,
+                                    u8 command, u16 value);
+  extern s32 i2c_smbus_block_process_call(struct i2c_client *client,
+                                          u8 command, u8 length,
+                                          u8 *values)
+
 All these transactions return -1 on failure. The 'write' transactions 
 return 0 on success; the 'read' transactions return the read value, except 
 for read_block, which returns the number of values read. The block buffers 
--- linux-2.6.10-rc2/drivers/i2c/i2c-core.c.orig	2004-11-15 20:15:53.000000000 +0100
+++ linux-2.6.10-rc2/drivers/i2c/i2c-core.c	2004-11-15 21:47:56.000000000 +0100
@@ -1038,25 +1038,6 @@
 }
 
 /* Returns the number of read bytes */
-s32 i2c_smbus_block_process_call(struct i2c_client *client, u8 command, u8 length, u8 *values)
-{
-	union i2c_smbus_data data;
-	int i;
-	if (length > I2C_SMBUS_BLOCK_MAX - 1)
-		return -1;
-	data.block[0] = length;
-	for (i = 1; i <= length; i++)
-		data.block[i] = values[i-1];
-	if(i2c_smbus_xfer(client->adapter,client->addr,client->flags,
-	                  I2C_SMBUS_WRITE, command,
-	                  I2C_SMBUS_BLOCK_PROC_CALL, &data))
-		return -1;
-	for (i = 1; i <= data.block[0]; i++)
-		values[i-1] = data.block[i];
-	return data.block[0];
-}
-
-/* Returns the number of read bytes */
 s32 i2c_smbus_read_i2c_block_data(struct i2c_client *client, u8 command, u8 *values)
 {
 	union i2c_smbus_data data;



--
Jean Delvare
http://khali.linux-fr.org/
