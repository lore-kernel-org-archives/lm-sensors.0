From: gregkh@suse.de (Greg KH)
Date: Sat, 29 Oct 2005 00:56:32 +0000
Subject: [lm-sensors] [PATCH] i2c: Fix misplaced i2c.h comment
Message-Id: <11305336602942@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: Fix misplaced i2c.h comment

Fix a misplaced comment in i2c.h. Spotted by Hideki Iwamoto.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 31ec5bc57146a479fac6f6878146059180413e43
tree 1d07157c39a0ed694c5a2cfb97254b1a2f04d25a
parent 7865e24935ec7e76fb482c749015a23052e51f76
author Jean Delvare <khali@linux-fr.org> Sat, 08 Oct 2005 00:04:13 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 28 Oct 2005 14:02:09 -0700

 include/linux/i2c.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index ec81884..6a1f342 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -92,10 +92,10 @@ extern s32 i2c_smbus_write_byte_data(str
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
 

