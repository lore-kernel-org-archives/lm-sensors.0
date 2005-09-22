From: h-iwamoto@kit.hi-ho.ne.jp (Hideki IWAMOTO)
Date: Thu, 22 Sep 2005 19:13:11 +0000
Subject: [lm-sensors] question about comment in i2c.h
Message-Id: <200509221706.AA01312@k7.kit.hi-ho.ne.jp>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I want to ask about the following comment in i2c.h.
What does "one more for read length in block process call" mean?
In i2c_smbus_block_process_call and i2c_smbus_xfer_emulated,
block[0] is used for the read length.

 union i2c_smbus_data {
         __u8 byte;
         __u16 word;
         __u8 block[I2C_SMBUS_BLOCK_MAX + 3]; /* block[0] is used for length */
                           /* one more for read length in block process call */
                                                     /* and one more for PEC */
 };


----
Hideki IWAMOTO  h-iwamoto@kit.hi-ho.ne.jp
