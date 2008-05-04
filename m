From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 04 May 2008 16:29:44 +0000
Subject: Re: [lm-sensors] sensors-detect killed my CPU
Message-Id: <20080504182944.4da48c2c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <481B851A.10800@ag-web.biz>
In-Reply-To: <481B851A.10800@ag-web.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Sun, 04 May 2008 17:27:22 +0200, achim wrote:
> Now with the 9600BE in the sapphire board there are additional chips 
> 
> X2 5000BE
> ---------------------------------------------------
>     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          -- -- -- -- -- -- -- -- -- -- -- -- -- 
> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- 2e -- 
> 30: -- -- -- -- -- -- -- -- 38 -- -- -- -- -- -- -- 
> 40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- 4e -- 
> 50: -- -- 52 53 -- -- -- 57 -- -- -- -- -- -- -- -- 
> 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- 6e -- 
> 70: 70 -- -- -- -- -- -- --                         
> ---------------------------------------------------
> 
> 9600BE
> ﻿---------------------------------------------------
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          -- -- -- -- -- -- -- -- -- -- -- -- -- 
> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- 2e -- 
> 30: -- -- -- -- -- -- -- -- 38 -- -- -- -- -- -- -- 
> 40: -- -- -- -- -- -- -- 47 -- -- -- -- 4c -- 4e -- 
> 50: -- -- 52 53 -- -- -- 57 -- -- -- -- -- -- -- -- 
> 60: -- -- -- -- -- -- -- -- -- 69 -- -- -- -- 6e -- 
> 70: 70 -- -- -- -- -- -- --                      
> ﻿---------------------------------------------------
> 
> Now the clock chips shows up at 0x69 maybe a second run with the X2
> would also have shown it.

Strange... This could be related to the chip at 0x70 if it's an I2C mux
as I suspect. Another possibility would be that the extra addresses are
in the CPU itself, but at least for 0x69 we know it's not the case.

> I spotted one thing. The output of 0x38 is identical on the M3A and the
> Sapphire board and slightly different on the GBT board.
> M3A and Sapphire use the same clock chip ﻿9LPRS477BKL the GBT
> an ﻿9LPRS477CKL. Seems this 0x38 address also point to the cloch
> generator.
> 
> I tried all types of bios modifications but none showed up at the dumps
> of 0x4e and 0x6e.
> 
> Trying to dump 0x47 results in XX till i reboot.

Never seen a chip at this address. sensors-detect does probe it,
because the Maxim MAX6633 can use this address in theory. However if it
is dangerous to probe this address, I think I'll just remove the probe.
We're probing 0x40-0x47 only for the MAX6633 and it's a rather rare
chip - not sure if we already saw a single user with it, so the risk is
just not worth the benefit.

> For the record I attached the dumps of 0x38 0x57 0x4c 0x69 0x6e and
> 0x70 

Doesn't look like anything I know. The chip at 0x70 doesn't look like a
mux after all.

> If I run sensors-detect and pass 0x2e,0x6e,0x47 as excludes, will it
> pass?

Yes, it should pass.

> With the current patch applied the scanning will be completely skipped,
> so i can't test the patch atm.

Of course. The second patch I sent was broken anyway, I've resent it to
the i2c list already but didn't Cc you, sorry. I'll send an updated
patch to you now.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
