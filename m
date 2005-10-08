From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 08 Oct 2005 00:04:29 +0000
Subject: [lm-sensors] [PATCH 07/16] i2c: Fix misplaced i2c.h comment
Message-Id: <20051008000413.2d4f3976.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fix a misplaced comment in i2c.h. Spotted by Hideki Iwamoto.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 include/linux/i2c.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.14-rc3.orig/include/linux/i2c.h	2005-10-07 20:37:30.000000000 +0200
+++ linux-2.6.14-rc3/include/linux/i2c.h	2005-10-07 20:56:57.000000000 +0200
@@ -92,10 +92,10 @@
 extern s32 i2c_smbus_read_word_data(struct i2c_client * client, u8 command);
 extern s32 i2c_smbus_write_word_data(struct i2c_client * client,
                                      u8 command, u16 value);
-/* Returns the number of bytes transferred */
 extern s32 i2c_smbus_write_block_data(struct i2c_client * client,
 				      u8 command, u8 length,
 				      u8 *values);
+/* Returns the number of read bytes */
 extern s32 i2c_smbus_read_i2c_block_data(struct i2c_client * client,
 					 u8 command, u8 *values);
 

-- 
Jean Delvare
