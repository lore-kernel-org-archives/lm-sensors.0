From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 02 Oct 2005 13:36:42 +0000
Subject: [lm-sensors] [2.6]  comment in i2c.h
Message-Id: <20051002133634.3a9373e7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200510011613.AA01324@k7.kit.hi-ho.ne.jp>
In-Reply-To: <200510011613.AA01324@k7.kit.hi-ho.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Konnichiwa Hideki,

> The following comment is included in i2c.h of kernel 2.6.
> Since i2c_smbus_write_block_data does not return the transferred size,
> this comment should be removed or should be moved before
> i2c_smbus_read_i2c_block_data.
> 
> 
>    /* Returns the number of bytes transferred */
>    extern s32 i2c_smbus_write_block_data(struct i2c_client * client,
>                                          u8 command, u8 length,
>                                          u8 *values);
>    extern s32 i2c_smbus_read_i2c_block_data(struct i2c_client * client,
>                                             u8 command, u8 *values);
> 

You're correct (as usual). This mistake was introduced when we removed
some of these helper functions in 2.6.10-rc2.

I'm enqueuing the following fix:

Fix a misplaced comment in i2c.h. Spotted by Hideki Iwamoto.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 include/linux/i2c.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.14-rc3.orig/include/linux/i2c.h	2005-10-02 11:23:41.000000000 +0200
+++ linux-2.6.14-rc3/include/linux/i2c.h	2005-10-02 13:29:38.000000000 +0200
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
 


Arigato,
-- 
Jean Delvare
