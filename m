From: h-iwamoto@kit.hi-ho.ne.jp (Hideki IWAMOTO)
Date: Sat, 01 Oct 2005 18:14:10 +0000
Subject: [lm-sensors] [2.6]  comment in i2c.h
Message-Id: <200510011613.AA01324@k7.kit.hi-ho.ne.jp>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The following comment is included in i2c.h of kernel 2.6.
Since i2c_smbus_write_block_data does not return the transferred size,
this comment should be removed or should be moved before
i2c_smbus_read_i2c_block_data.


   /* Returns the number of bytes transferred */
   extern s32 i2c_smbus_write_block_data(struct i2c_client * client,
                                         u8 command, u8 length,
                                         u8 *values);
   extern s32 i2c_smbus_read_i2c_block_data(struct i2c_client * client,
                                            u8 command, u8 *values);

----
Hideki IWAMOTO  h-iwamoto@kit.hi-ho.ne.jp
