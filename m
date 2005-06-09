From: BGardner@Wabtec.com (BGardner@Wabtec.com)
Date: Thu, 09 Jun 2005 23:47:03 +0000
Subject: [lm-sensors] How can I skip i2c detection?
Message-Id: <F06EB2894F3F0D45AD9BEA7246DE9C90855202@WCSEXCMBS1.ad.wabtec.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <F06EB2894F3F0D45AD9BEA7246DE9C90854F15@WCSEXCMBS1.ad.wabtec.com>
In-Reply-To: <F06EB2894F3F0D45AD9BEA7246DE9C90854F15@WCSEXCMBS1.ad.wabtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

If I do 'modprobe lm83' from the command line, it always works with the
lm82.

I added the 'force' param because when I added the 'ignore' params to my
'load modules' script, _sometimes_ it wouldn't detect the lm82.  When
that occurs, I see a timeout in the scx200/cs5535 driver. 
I added some logs to lm83.c and found out that it doesn't call
lm83_detect() when detection fails, so there's nothing wrong with the
lm83 driver.

If, after it fails to detect, I do a 'rmmod lm83' and then re-run the
same modprobe as is in the script, it detects fine.
So, it's probably a timing bug in the scx200/cs5535 driver. Or maybe it
is because the ds2482 is in the middle of a w1 search when the lm83 is
loaded.
Either way, the force parameter gets around that problem.

Good point about the 127.
Perhaps there isn't a reliable way to distinguish the two chips. =(

Thanks,
Ben

-----Original Message-----
From: Jean Delvare [mailto:khali@linux-fr.org] 
Sent: Thursday, June 09, 2005 4:08 PM
To: Gardner, Ben
Cc: lm-sensors@lm-sensors.org
Subject: Re: [lm-sensors] How can I skip i2c detection?

Hi Ben,

> Well, if it's not too much of a bother, I'd like that.
> Using hwmon-sysfs.h would clean that module up a bit, too. =)

Patch is already on its way to -mm :)

http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-0
2-i2c/i2c-device-attr-lm83.patch

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


