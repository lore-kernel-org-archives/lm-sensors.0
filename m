From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 03 May 2008 21:09:17 +0000
Subject: Re: [lm-sensors] sensors-detect killed my CPU
Message-Id: <20080503230917.65ad38cf@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <481B851A.10800@ag-web.biz>
In-Reply-To: <481B851A.10800@ag-web.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hallo Achim,

On Sat, 03 May 2008 22:30:46 +0200, achim wrote:
> I tried the dump of 0x2e and the system froze. I'm glad it boot's
> without problems with the X2 cpu.
> However I could make a dump of 0x4e and 0x6e.
> ﻿﻿------------------------------------------------------------------------
> i2cdump 0 0x4e
> No size specified (using byte-data access)
> WARNING! This program can confuse your I2C bus, cause data loss and
> worse!
> I will probe file /dev/i2c-0, address 0x4e, mode byte
> Continue? [Y/n] 
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 02 00 00 00 3f 00 00 00 00 00 00 00 00 00 00 00    ?...?...........
> 10: 00 00 ff 0f 00 00 00 00 00 00 00 00 00 00 00 00    ...?............
> 20: 00 00 00 00 00 00 00 00 83 12 12 28 00 00 00 00    ........???(....
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> ﻿------------------------------------------------------------------------

Very interesting, it looks very similar to the dump at:
http://bugzilla.kernel.org/show_bug.cgi?idX89#c18
This really has to be the same chip. If we knew what chip it is and if
that chip has some read-only registers will well-defined value, we
could check 0x4e first and blacklist 0x2e if we recognize the chip.
Registers 0x28-0x2b look promising, but without a datasheet I just
can't tell if we can reliably use them for identification purposes.

> #i2cdump 0 0x6e
> No size specified (using byte-data access)
> WARNING! This program can confuse your I2C bus, cause data loss and
> worse!
> I will probe file /dev/i2c-0, address 0x6e, mode byte
> Continue? [Y/n] 
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07    ????????????????
> 10: 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07    ????????????????
> 20: 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07    ????????????????
> 30: 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07    ????????????????
> 40: 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07    ????????????????
> 50: 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07    ????????????????
> 60: 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07    ????????????????
> 70: 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07    ????????????????
> 80: 07 ff 00 40 31 43 07 00 00 00 80 00 00 00 00 dd    ?..@1C?...?....?
> 90: dd dd dd dd dd dd dd dd dd dd dd dd dd dd XX XX    ??????????????XX
> a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> ﻿------------------------------------------------------------------------
> 
> ﻿I spotted one odd thin. As i ran the dump of 0x6e the first time it
> stuck for a few seconds at around the line starting with 90.
> since then both dumps look like this:
> 
> ------------------------------------------------------------------------
> debian-9850:/home/achim# i2cdump 0 0x4e 
> No size specified (using byte-data access)
> WARNING! This program can confuse your I2C bus, cause data loss and
> worse!
> I will probe file /dev/i2c-0, address 0x4e, mode byte
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
> debian-9850:/home/achim# i2cdump 0 0x6e 
> No size specified (using byte-data access)
> WARNING! This program can confuse your I2C bus, cause data loss and
> worse!
> I will probe file /dev/i2c-0, address 0x6e, mode byte
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
> ﻿------------------------------------------------------------------------

Basically the SMBus is stuck. Could be because you accessed the chip at
0x6e in a way it didn't expect and didn't like (in this case, reading
from register 0x9e). I wonder how reproducible it is. Most probably,
you have to reboot before the SMBus will work again. It might even
require a cold boot.

> I'll try a different version of the Sapphire bios now and then the DFI
> bios.
> I like overclocking and a dead cpu is something i estimate every now and
> then due to that. Phenoms however tend to stop working more or less out
> of the blue, in many cases the systems freeze after starting tools like
> everest, speedfan, sandra or even cpu-z. Sometimes a bios reflash helps
> sometimes the cpu is non functional afterwards. Having that io access
> problem tracked down is really exciting and I appreciate your support.

I expected you to be much more angry about losing a brand new CPU...
I'd like to fix the problem so that other users don't experience the
same. Even if the CPU doesn't die, freezing your machine when running a
script is no good. Even if I consider that the motherboard manufacturer
is to blame for using dangerous chips or designs, let's still try to
prevent the problem from happening too frequently.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
