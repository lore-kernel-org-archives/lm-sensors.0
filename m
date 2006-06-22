From: greg@kroah.com (Greg KH)
Date: Thu, 22 Jun 2006 18:27:57 +0000
Subject: [lm-sensors] [PATCH 31/44] [PATCH] i2c: Mark block write buffers as
Message-Id: <11510010202912-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Krzysztof Halasa <khc at pm.waw.pl>

The attached patch marks i2c_smbus_write_block_data() and
i2c_smbus_write_i2c_block_data() buffers as const.

Signed-off-by: Krzysztof Halasa <khc at pm.waw.pl>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 drivers/i2c/i2c-core.c |    4 ++--
 include/linux/i2c.h    |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 45e2cdf..a45155f 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -916,7 +916,7 @@ s32 i2c_smbus_write_word_data(struct i2c
 }
 
 s32 i2c_smbus_write_block_data(struct i2c_client *client, u8 command,
-			       u8 length, u8 *values)
+			       u8 length, const u8 *values)
 {
 	union i2c_smbus_data data;
 
@@ -944,7 +944,7 @@ s32 i2c_smbus_read_i2c_block_data(struct
 }
 
 s32 i2c_smbus_write_i2c_block_data(struct i2c_client *client, u8 command,
-				   u8 length, u8 *values)
+				   u8 length, const u8 *values)
 {
 	union i2c_smbus_data data;
 
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 0510430..526ddc8 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -97,13 +97,13 @@ extern s32 i2c_smbus_write_word_data(str
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
1.4.0


