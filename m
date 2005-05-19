From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:58 +0000
Subject: as99127f PWM kinda working
Message-Id: <20040516134423.575813e9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <40A74A47.6010601@marcansoft.com>
In-Reply-To: <40A74A47.6010601@marcansoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Hi! I've been fiddling around with the (in)famous 0x59 register and 
> found out the following values do work as a form of coarse pwm:
> 
> 0x80 - seems to turn fans off after some time(1-2 minutes)... might
> be some form of auto-fan-control based on temp? hmm (Qfan? this mobo
> is an old ASUS, it isn't marketed as Qfan. Maybe some beta pre-attemp
> at Qfan that was dropped at the BIOS)
> 0x81 - off
> 0x82 - slightly "on-ner" than off, but my fans do not get to move. I
> can hear the high-pitched PWM sound that motors give off at
> too-low-pwm. 0x83 - now they do move. Estimate about 70% speed or so.
> 0x84-0x8f - full on
> 
> Changing the high nibble doesn't seem to do much except the high bit 
> (0x80) must be set for PWM to work, else the current pwm doesn't seem
> to change.

This more or less corroborates what I observed mysef and summuarized at
the end of the w83781d driver documentation here:
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/chips/w83781d

There are a few differences though.

1* When the high bit is clear, I would observe speed changes (different
from when high bit is set).

2* When high bit is set, my results differ from yours. For one thing I
was never able to turn the fan completely off.

What we definitely agree on is that the high bit sets a kind of mode and
bits 6-4 don't matter when high bit is set. We also agree on the fact
than only a limited number speeds are possible.

I invite you to read my summary and comment on it.

I'll quote your report after mine in that document.

> My mobo is an ASUS A7V266-E. This behaviour is similar to what I got 
> with speedfan under Windows, where 0-15% would be off, 15-2x% (can't 
> remember the exact value) would be 70% and higher would be full on.

Is it a revision 1 or revision 2 chip? (sensors-detect should tell you)

Did you tried playing with register 0x5A as well? It's suspected to be
PWM2.

In any case, I don't plan to implement PWM support for the as99127f. It
would bloat the w83781d driver, so I think we would have to make the
as99127f support move to a new driver. And I'm too busy with chips which
have a datasheet to even think of worrying about chips with no datasheet
available.

> If you need any more information please contact me! By the way,
> thanks for making temperature readings working under Linux, now fix
> those 2.6 kernel problems! ;)

Which problems are you referring to? 2.6 driver works well enough for
me.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
