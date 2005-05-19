From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: it87 pwm patch for 2.6.6
Message-Id: <20040605102716.037e9af3.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040516205100.GA9996@nemo.sby.abo.fi>
In-Reply-To: <20040516205100.GA9996@nemo.sby.abo.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > You could fix IN_FROM_REG(val) too, while you're at it. It misses a
> > +5 for correct rounding. It's fixed in 2.4, but was forgotten in
> > 2.6.
> 
> Hmm. Are you sure? I'm a bit confused about the rounding issue here. I
> think IN_TO_REG(val) should be rounded, but not IN_FROM_REG(val). (I'm
> looking at the 2.6 version). Just like in the
> TEMP_TO_REG(val)/TEMP_FROM_REG(val) case (btw, there was a bug in my
> cleanup patch with TEMP_TO_REG and rounding, fixed it).

It's not a matter of where the value come from, it's a matter of whether
the conversion includes a division or not. Whenever you divide, you have
to take care of proper rounding yourself because integer arithmetics
won't.

IN_FROM_REG(val) was including a division by 10 so far, thus my comment
about missing rounding. But since you also fixed this converter so as to
prevent unneeded accuracy loss, no division is used anymore, so there is
no rounding issue to be discussed.

Nice catching for TEMP_TO_REG, I completely missed that one. BTW, now
that I took a longer look at it, I really wonder how a negative
temperature limit could ever been set with this. Looks like it'll end up
with 0. OTOH, asking for a temperature higher than 127.5 degrees will
most likely lead to "random" negative values. This is probably true for
both the 2.4 and the 2.6 driver as of now. Could you please test and
confirm? Most likely nobody cares about setting negative limits, but
while we're at cleaning up this part of the driver...

> Attached is it87_cleanups_2.6.7-rc2-jm2.patch, same as the earlier one
> except for these rounding macros. I hope I got them right ;).

Yes, looks very good to me (except for my comment above about setting
negative temperature limits).

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
