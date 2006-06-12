From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 12 Jun 2006 19:42:20 +0000
Subject: [lm-sensors] [PATCH 02/14] i2c: Mark block write buffers as const
Message-Id: <20060612214220.46bb23be.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Krzysztof Halasa <khc at pm.waw.pl>
Content-Disposition: inline; filename=i2c-mark-data-const-for-write-block.patch

The attached patch marks i2c_smbus_write_block_data() and
i2c_smbus_write_i2c_block_data() buffers as const.

Signed-off-by: Krzysztof Halasa <khc at pm.waw.pl>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/i2c/i2c-core.c |    4 ++--
 include/linux/i2c.h    |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.17-rc5.orig/drivers/i2c/i2c-core.c	2006-06-06 19:29:30.000000000 +0200
+++ linux-2.6.17-rc5/drivers/i2c/i2c-core.c	2006-06-06 19:29:42.000000000 +0200
@@ -916,7 +916,7 @@
 }
 
 s32 i2c_smbus_write_block_data(struct i2c_client *client, u8 command,
-			       u8 length, u8 *values)
+			       u8 length, const u8 *values)
 {
 	union i2c_smbus_data data;
 
@@ -944,7 +944,7 @@
 }
 
 s32 i2c_smbus_write_i2c_block_data(struct i2c_client *client, u8 command,
-				   u8 length, u8 *values)
+				   u8 length, const u8 *values)
 {
 	union i2c_smbus_data data;
 
--- linux-2.6.17-rc5.orig/include/linux/i2c.h	2006-06-06 19:29:30.000000000 +0200
+++ linux-2.6.17-rc5/include/linux/i2c.h	2006-06-06 19:31:45.000000000 +0200
@@ -96,13 +96,13 @@
                                      u8 command, u16 value);
 extern s32 i2c_smbus_write_block_data(struct i2c_client * client,
 				      u8 command, u8 length,
-				      u8 *values);
+				      const u8 *values);
 /* Returns the number of read bytes */
 extern s32 i2c_smbus_read_i2c_block_data(struct i2c_client * client,
 					 u8 command, u8 *values);
 extern s32 i2c_smbus_write_i2c_block_data(struct i2c_client * client,
 					  u8 command, u8 length,
-					  u8 *values);
+					  const u8 *values);
 
 /*
  * A driver is capable of handling one or more physical devices present on

-- 
Jean Delvare

