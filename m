From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 29 Mar 2010 15:25:05 +0000
Subject: Re: [lm-sensors] G760A not working korrekt on NAS dlink 323 HW C1
Message-Id: <20100329172505.251c81c0@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1269292447.6810.21.camel@kusanagi>
In-Reply-To: <1269292447.6810.21.camel@kusanagi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Denny,

On Fri, 26 Mar 2010 01:48:11 +0100, Denny Schierz wrote:
> hi,
> 
> i was able to locate the chip on the board. His partnumber is AX3106
> (PWM controller)
> 
> http://www.micro-bridge.com/data/Axelite/AX3106.pdf

Not enough details... Not even sure if this chip is meant to control
fans, and no clue how it is accessed (I2C or something else.)

> Some debug:
> 
> nas:~# i2cdetect -l
> i2c-0   i2c             mv64xxx_i2c adapter                     I2C
> adapter
> 
> nas:~# i2cdetect 0
> WARNING! This program can confuse your I2C bus, cause data loss and
> worse!
> I will probe file /dev/i2c-0.
> I will probe address range 0x03-0x77.
> Continue? [Y/n] y
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          -- -- -- -- -- -- -- -- -- 0c -- -- -- 
> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- UU -- 
> 40: -- -- -- -- -- -- -- -- UU -- -- -- -- -- -- -- 
> 50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
> 60: -- -- -- -- -- -- -- -- UU -- -- -- -- -- -- -- 
> 70: -- -- -- -- -- -- -- --  
> 
> 
> so, that is the output, what now?

Unfortunately, with the new i2c device driver binding model, the output
of i2cdetect isn't that useful, because every device that has been
instantiated by the kernel (even if the physical device doesn't exist)
shows up. The devices above (at 0x3e, 0x48 and 0x68) are the ones
listed in the platform code.

We really need to update i2cdetect and the i2c-dev driver to better
deal with the new binding model. But this isn't that easy.

The only other one is 0x0c, which is the SMBus alert address. Support
for this feature was added in kernel 2.6.34. This won't help you for
the problem at hand though.

 I contacted the maintainer from the
> file dns323-setup.c, but he has no time nor the hardware :-/
> 
> any suggestions?
> 
> cu denny
> 
> 
> nas:~# i2cdump 0 0x0c 
> No size specified (using byte-data access)
> WARNING! This program can confuse your I2C bus, cause data loss and
> worse!
> I will probe file /dev/i2c-0, address 0xc, mode byte
> Continue? [Y/n] y
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91    ????????????????
> 10: 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91    ????????????????
> 20: 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91    ????????????????
> 30: 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91    ????????????????
> 40: 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91    ????????????????
> 50: 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91    ????????????????
> 60: 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91    ????????????????
> 70: 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91    ????????????????
> 80: 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91    ????????????????
> 90: 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91    ????????????????
> a0: 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91    ????????????????
> b0: 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91    ????????????????
> c0: 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91    ????????????????
> d0: 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91    ????????????????
> e0: 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91    ????????????????
> f0: 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91 91    ????????????????

FWIW, it means that device at 0x48 (0x91 / 2) has asked the kernel for
attention. Probably an over-temperature condition.

> 
> 
> nas:~# i2cdump 0 0x3 
> No size specified (using byte-data access)
> WARNING! This program can confuse your I2C bus, cause data loss and
> worse!
> I will probe file /dev/i2c-0, address 0x3, mode byte
> Continue? [Y/n] 
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX

Not sure what was your idea with this, there's no chip listed at 0x03.
Trying 0x3e would have been more useful.

That being said, I fear I can't help you much further without the
hardware in question in my hands (and even then...)

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
