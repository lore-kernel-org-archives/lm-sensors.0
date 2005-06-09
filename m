From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 09 Jun 2005 23:08:39 +0000
Subject: [lm-sensors] How can I skip i2c detection?
Message-Id: <20050609230759.44315ad7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <F06EB2894F3F0D45AD9BEA7246DE9C90854F15@WCSEXCMBS1.ad.wabtec.com>
In-Reply-To: <F06EB2894F3F0D45AD9BEA7246DE9C90854F15@WCSEXCMBS1.ad.wabtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ben,

> Well, if it's not too much of a bother, I'd like that.
> Using hwmon-sysfs.h would clean that module up a bit, too. =)

Patch is already on its way to -mm :)

http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-02-i2c/i2c-device-attr-lm83.patch

> I looked into doing this briefly, but didn't see a clean way to
> support both chips.

I'll look into it, but I can't see any difficulty. What do you think
they are? It should only be a matter of not creating the sysfs files
which aren't needed on the LM82 (which is a subset of the LM83 IIRC).

> As for detection...
> On the LM82, temperatures 2 and 4 always read 127. (The spec says
> otherwise.)
> Register 0xFF (the stepping) is 3 (same as LM83) so that can't be
> used. So maybe the detection could be to read temp 2 & 4 and if they
> are both 127, then it is a lm82?
> I hope that helps.

Yes it does, but I'm a bit surprised. You said you had to force the lm83
driver. If the LM82 and LM83 chips have the same ID, this shouldn't be
needed. Could you please check which test made by the lm83 driver was
failing? This may be used to differenciate between both chips. Using the
temperatures may not work, as a LM83 with no diodes connected would
probably have 127 too.

Thanks,
-- 
Jean Delvare
