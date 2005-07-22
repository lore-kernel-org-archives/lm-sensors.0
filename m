From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 22 Jul 2005 21:20:36 +0000
Subject: [lm-sensors] [patches pc87360]  printk-format, magic-init
Message-Id: <20050722212020.7a87774e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

> 1st is self-explanatory.

And obviously correct, but it happens that I already have a patch
pending solving 5 more of this type of error in 4 different drivers:

http://khali.linux-fr.org/devel/i2c/linux-2.6/linux-2.6.13-rc3-i2c-missing-space-in-split-strings.diff

Note that since 2.6.13-rc3, hardware monitoring drivers are in
drivers/hwmon and no more in drivers/i2c/chips. Thus I'd invite you to
send any future patch at least based on 2.6.13-rc3.

> 2nd adds some missing parts of the magic init sequence.

The missing part is thiner than you seem to think, and is additionally
missing on purpose. You seem to have missed the fact that:

  pc87360_write_value(data, LD_TEMP, 0xF, 0xA, 0x08);

actually writes *two* bytes, one at 0x9 and one at 0xA. And the 0x00
write to 0x08 I voluntarily omitted, because it would force the chip to
use an internal vref, while the system manufacturer may provide an
external one instead. Instead, my code carefully forces *only* bit 0 to
0 so as to start monitoring if needs be.

Of course, if anyone ever proves that restoring the missing write helps
in any way, I'll reconsider.

> Incidentally, the reason I got into this that,
> despite the fact that Ive got an 'ignore fan2' in my config,
> Im getting this error:
> 
>     prog/sensors/chips.c:    printf("ERROR: Can't get FAN2 data!\n");

Fixed in CVS:

revision 1.158
date: 2005/04/22 18:08:06;  author: khali;  state: Exp;  lines: +1 -2
(Khali) No error on missing pc87360 fan2, as this can happen with the
Linux 2.6 version of the driver. Reported by Christian Schwamborn.

The fix is in the "sensors" program, file chips.c.

> fwiw, my soekris board has no fans, so I think the module-code
> detects that lack via extra_isa, and sets fannr = 0, so never creates
> the sysfs files.  The lib code apparently doesnt handle a missing
> sysfs node well.

Yes, your analysis is correct. libsensors was written for the old procfs
interface which always created files even when the features were
missing, and was hacked later for sysfs, just enough to make it work for
most cases. We know that not all corner cases are handled, we currently
hack the "sensors" program to hide most errors, until the library is
rewritten from scratch with the sysfs interface in mind.

-- 
Jean Delvare
