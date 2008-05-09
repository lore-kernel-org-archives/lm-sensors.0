From: achim <achim@ag-web.biz>
Date: Fri, 09 May 2008 14:43:19 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Check for
Message-Id: <1210344199.3543.12.camel@debian-9850.ag-home.muc>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

> Note that i2cdump, by default, uses byte transactions, while some
> detections in sensors-detect make use of word transactions. It could be
> that one of your chips is happy with byte transactions but chokes on
> word transactions and then keeps the bus in a busy state. You could use
> the "w" mode of i2cdump to test this theory.
> 
> Thanks,

For sake of completenes here's the result of the dump test.

0x2e: skipped ;)
0x38: passed b and w dump
0x47: b,w and s result in no reply and if i cancle it i get XX's for
dumps afterwards
0x4c: passed b dump but does not like w dumps, resulting in XX's
The chip at 0x4e has the values 0x05 at the adresses 0x02 and 0x03 if a
phenom cpu is mounten and 0x00 with k8 cpu's. The interface only shows
up if an phenom is in use. 
As an alternative the registers at 0x01 and 0x30 could be used to detct
that special thermal sensor. The difference seems to be always in the
range 49-50. Also the hysteresis bytes at 0x10 and 0x31 can be checkd
they are eighter 0x00 or 0x80.
The value at 0x04 is always 0x08 and 0x07 is always 0x46 but those might
change with other phenoms.

0x4e: passed b w
0x52,0x53: ﻿passed b w
0x57:﻿ passed b w
0x70: ﻿passed b w
0x6e: only likes s dumps others stop at address 0x91 and result in XX's.
The datasheet for that chip is available so it might be possible to at
least detect this chip.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
