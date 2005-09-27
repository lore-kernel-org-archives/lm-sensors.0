From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 27 Sep 2005 09:38:56 +0000
Subject: [lm-sensors] question about comment in i2c.h
Message-Id: <WLUQQsqi.1127806133.5461140.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <200509221706.AA01312@k7.kit.hi-ho.ne.jp>
In-Reply-To: <200509221706.AA01312@k7.kit.hi-ho.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Mark,

On 2005-09-26, Mark Studebaker wrote:
> the change in 2.4 / CVS probably won't create a binary compatibility
> problem because of alignment, but to be safe we may want to change it
> back. 2.6 change of course is fine. Comments?

I did the change on purpose, exactly for binary compatibility reasons. We
are trying to keep (or restore) binary compatibility between i2c-CVS and
Linux 2.4, right? It happens that in Linux 2.4, i2c_smbus_data has the
following definition:

union i2c_smbus_data {
    __u8 byte;
    __u16 word;
    __u8 block[I2C_SMBUS_BLOCK_MAX + 2]; /* block[0] is used for length */
                      /* one more for read length in block process call */
};

So block has size 34 (I2C_SMBUS_BLOCK_MAX + 2), while i2c-CVS had 35
(I2C_SMBUS_BLOCK_MAX + 3) before my recent change. Now i2c-CVS has 34
again. The use of the last byte of block differs (supposedly block
process call in linux-2.4, actually unused, and PEC in i2c-CVS) but this
shouldn't cause any trouble.

I wouldn't actually trust alignment, as my understanding is that the
alignment of anything placed after an i2c_smbus_data depends on that
thing and not the definition of i2c_smbus_data. I see no reason why a u8
couldn't be placed right after an i2c_smbus_data, but I would expect an
u32 to be aligned on a 4-byte boundary. This might all depend on
architecture and compilation options though, I'm not sure.

I just took a look at all uses of i2c_smbus_data in Linux 2.4(.30), and
we seem to be lucky, i2c_smbus_data is always last on the stack or
followed by something requiring at least 4-byte alignment (int or
pointer). This must explain why the difference in the definition did
never cause compatibility problems.

--
Jean Delvare
