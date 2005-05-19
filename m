From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: [PATCH 2.6] w83781d fan_div code refactoring
Message-Id: <20040331022619.GC29782@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040317220839.373babf0.khali@linux-fr.org>
In-Reply-To: <20040317220839.373babf0.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

(purposefully not trimming context this message is about a week late)

* Jean Delvare <khali@linux-fr.org> [2004-03-18 14:04:58 +0100]:
> Quoting "Mark M. Hoffman" <mhoffman@lightlink.com>:
> 
> > > While a corner case, we better fix it quickly since it is very
> > > likely to happen. We used to set fan divisors before fan mins in
> > > sensors.conf because setting fan divisors was breaking fan mins,
> > > and this will trigger the bug, since we invite users to run
> > > "sensors -s" prior to running "sensors".
> > 
> > But it's not real dangerous, since who inits fanX_div without also
> > init'ing fanX_min immediately after?
> 
> You're correct, this is what will most likely happen in a majority of
> cases. But not necessarily all the cases. One can comment out the set
> fanXmin lines in sensors.conf. And anyway, it still temporarily writes
> a random value for fanN_min into the chip, which could trigger an alarm
> and possibly other nasty actions. Remember these reports of "as I load
> module X, my computer instantly goes off"...
> 
> > > I can think of three ways to solve the issue and would like to
> > > hear opinions about which we should use:
> > > 
> > > 1* In the driver's init function, read fan_mins from the chip so
> > > they are initialized.
> > > 
> > > 2* In the store_fan_div function, call update_device.
> > > 
> > > 3* In the store_fan_div function, if data->valid = 0, read the
> > > fan_min from the chip.
> > > (...)
> > 
> > I prefer #1: it fixes the whole *class* of bugs which can arise from
> > interactions between set/show functions and uninit'ed <driver>_data
> > structure elements.  E.g. I can see this type of bug creeping in to
> > smart PWM control where it could be much more dangerous.
> 
> I don't think that #1 as I described it fixes the whole class, since it
> only works for fan_mins. Instead, what you seem to suggest would be:
> 
> 4* Call update_device upon driver init.

You're right, this is what I meant.

> This would really slow the driver loading, for sure. But then we're
> safe, and we even could get rid of data->valid (providing we add a
> "force" parameter to update_device; not sure it's worth it).
> 
> I also can think of another possibility now:
> 
> 5* Do not try to preserve fanN_min if data->valid = 0.
> 
> This one doesn't slow anything significantly. Ironically, this is the
> first thing I tried when finding the bug, and I forgot to mention it as
> a possible solution.
> 
> Of course, this one does only work for the store_fan_div case, other
> cases would have to handle the issue by themselves, in the same way or
> a different one.
> 
> Solution #4 can also be modified to something more subtle. We could
> divide internal register data in two sets. One set with registers we
> want to read at driver init, one set with the other registers. Each set
> would have its own "valid" and/or last_updated variables. This is
> somewhat similar to what Phil Pokorny does in the lm85 driver (one
> timestamp for limits, one for readings, each set has a different buffer
> validity limit) or me in the eeprom driver (each slice has its own
> validity bit and last_updated timestamp).
> 
> This requires more code, of course, but would slow down the init only
> as
> much as stricly necessary. I'm not sure the benefit is worth the work
> however.
> 
> I think I still prefer solution #1. Looks like the best tradeoff. If
> other sysfs functions need other registers, we simply add initializing
> reads for them in the init function.

I disagree, but I see that I'm a little late on this one since patches
have already been accepted.  As I mention in another message, I just
don't think that the update speed of these drivers is worth any extra
code... and I really do mean *any at all*.  What is the value of returning
a result 1/2 second faster using "sensors" at the command line?  More
likely people are using something like gkrellm, or capturing the data in
a script and plotting it, so they never experience that delay anyway.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
