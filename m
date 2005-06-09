From: BGardner@Wabtec.com (BGardner@Wabtec.com)
Date: Thu, 09 Jun 2005 22:55:47 +0000
Subject: [lm-sensors] How can I skip i2c detection?
Message-Id: <F06EB2894F3F0D45AD9BEA7246DE9C908551D5@WCSEXCMBS1.ad.wabtec.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <F06EB2894F3F0D45AD9BEA7246DE9C90854F15@WCSEXCMBS1.ad.wabtec.com>
In-Reply-To: <F06EB2894F3F0D45AD9BEA7246DE9C90854F15@WCSEXCMBS1.ad.wabtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

<clip>
> > Oh, I'm using the lm83 driver with a lm82 chip - and it works great.
> 
> The lm83 driver could easily be extended to natively support the LM82.
> It wasn't done so far because no LM82 chip was ever seen, but now you 
> seem to have one. If you want support, just ask and I'll add it.
<clip>

Well, if it's not too much of a bother, I'd like that.
Using hwmon-sysfs.h would clean that module up a bit, too. =)

I looked into doing this briefly, but didn't see a clean way to support
both chips.

As for detection...
On the LM82, temperatures 2 and 4 always read 127. (The spec says
otherwise.)
Register 0xFF (the stepping) is 3 (same as LM83) so that can't be used.
So maybe the detection could be to read temp 2 & 4 and if they are both
127, then it is a lm82?
I hope that helps.

Thanks,
Ben

