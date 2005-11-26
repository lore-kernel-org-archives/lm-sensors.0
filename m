From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 26 Nov 2005 10:36:03 +0000
Subject: [lm-sensors] Kernel hangs with i2c-i801 driver?
Message-Id: <20051126103659.4857dca9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051123100021.GA29473@oden.homeip.net>
In-Reply-To: <20051123100021.GA29473@oden.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Daniel,

> > Can you please just provide the output of "isadump 0x295 0x296" to rule
> > out the possibility that the IT8712F chips was connected to the SMBus
> > with the same address the W83792D chip uses? Unlikely, but you never
> > know...
> 
> Sure, here it is:
> 
> isadump 0x295 0x296
> WARNING! Running this program can cause system crashes, data loss and worse!
> I will probe address register 0x295 and data register 0x296.
> Continue? [Y/n]
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 19 10 ff 00 00 00 00 00 00 00 00 5b 00 ff ff 00
> 10: ff ff ff 37 b0 01 01 00 ff ff 00 ff ff ff ff ff
> 20: ff ff ff ff ff ff ff ff c7 80 80 80 ff ff ff ff
> 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 40: ff ff ff ff ff ff ff ff 2d ff ff ff ff ff ff ff

It would show at 0x2d, so it cannot conflict with your Winbond chip
(which is at 0x2c).

Anyway, I'm not even sure recent IT8712F chips really have an SMBus
interface. Later datasheets don't mention it anymore. We'll probably
drop SMBus interface support from the it87 driver at some point in the
future. ISA access is faster and always works (or can be made to work.)

Thanks,
-- 
Jean Delvare
