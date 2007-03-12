From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 12 Mar 2007 13:50:42 +0000
Subject: [lm-sensors] [PATCH] Add MAX6650 support
Message-Id: <20070312145042.e500ab42.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200701171359.46334.hjk@linutronix.de>
In-Reply-To: <200701171359.46334.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans-J?rgen,

On Sun, 11 Mar 2007 22:08:01 +0100, Hans-J?rgen Koch wrote:
> Obviously, we've reached some limits of the current concept. IMHO, the 'pwm' 
> and 'divider' sysfs files are much too hardware dependent. We should have 
> more abstraction, e.g. like this:

Forget about it right away, this interface is here to stay and we're
not changing it.

> fan1_input: (ro) Current speed in RPM
> fan1_speed: (rw) Desired speed in RPM

We have fan1_input and fan1_target for this. Note though that many fan
speed controllers do not work by setting a desired fan speed, but by
setting a specific output voltage (DC) or duty cycle (PWM), or a target
temperature.

> fan1_min_speed,
> fan1_max_speed: (rw) Planned/defined operating range in RPM

We have fan1_min for the former. We could have fan1_max for the latter,
but no known chip actually supports upper limit for fan speeds.

> fan1_tacho: (rw) Pulses per round of the tacho generator

99% of the fans out there emit two pulses per revolution, so we didn't
bother, although a couple driver do expose a non-standard sysfs file
for that. The fact is that this can be addressed easily in user-space,
so the interest in implementing it in every driver is questionable.

> fan1_mode: (rw) on, off, closed_loop, open_loop, ...

This is exactly what pwm1_enable does. The name could have been chosen
better, granted.

So as you can see, all the concepts you want are already in place, just
not using the names you'd like.

> From this, _every_ driver could calculate the necessary register values it 
> needs, without bothering the user with chip internal details. Why should a 
> user care if the fan regulator chip uses PWM or not? The values I mentioned 
> above are the ones he/she knows and can easily set without having the data 
> sheet in one hand and the pocket calculator in the other.

We chose the interface we have now because this is how the vast
majority of chips work.

> Of course, implementation is slightly more complicated, as the values depend 
> on each other, so setting one of them might invalidate the setup until an 
> other is set. The driver needs to deal with that in a reasonable way. But I 
> think I could easily do it for the max6650. It shouldn't be difficult for 
> other drivers, too.

Again this isn't going to happen. We have a standard interface, it was
hard enough to put in place, we're not changing it again. If you want a
different interface, you get to build a timeback machine first, get
back 3 years in the past when we designed this interface, and inflence
the discussions ;)

The drivers must match the standard interface, and not the other way
around. The MAX6650 is quite different from the other chips, so
things look a bit odd from your point of view, and I'm sorry about
that, but in general the interface we have works well enough, and we
should be able to make the max6650 driver fit in it too.

> > Yes, this isn't a problem. I am not a specialist but I don't think it's
> > possible to have a closed loop fan control working with 4 inputs and 1
> > output, so I believe the output is really related to fan1 only. A
> > comment in the original driver seems to confirm that ("Only one fan's
> > speed (fan1) is controlled.")
> 
> That comment, as well as the data sheet, are a bit misleading. In fact, the 
> MAX6651 is NOT able to drive four independent fans. It just has four tacho 
> inputs. The first one can be used to close the loop if you want closed loop 
> operation. To the other three, you can connect whatever you like. The 
> intended use is to connect four identical fans in parallel to the output. The 
> tacho signal of one of them is used for closed loop regulation. If the fans 
> are _really_ identical, all of them should have the same speed. You can check 
> their actual speeds by looking at the other tacho inputs.

Correct. I don't see anything confusing here, BTW.

> > > counttime is the time interval during which tacho pulses are counted.
> > > It determines the resolution of the measured speed values. It should
> > > be set to the longest time that still ensures the 8-bit counter
> > > doesn't overflow under worst case conditions.
> >
> > _This_ really sounds like fan1_div. It changes the period of time
> > rather than the clock frequency, but from a functional point of view
> > the result is the same: preventing 8-bit register overflow for certain
> > speed fans. The only difference is that typical chips overflow for slow
> > fans, while the MAX6650 is more likely to overflow when the fan is too
> > fast, if I understood correctly.
> >
> > So please implement it that way. fan1_div = 1 should correspond to the
> > smaller period of time (faster fan.)
> 
> As I said above, I really believe we shouldn't do that but be less hardware 
> dependent.

It's just giving a different name to something to make it fit in the
standard. It's rather _less_ hardware dependent than what you propose.

> > Aren't the count time and precaler values somewhat related? Won't the
> > user have to change both the same way if he/she gets a new fan running
> > at a different speed? Maybe it would make sense to link fan1_div to
> > both the prescaler and the count time after all.
> 
> If I did that, confusion would be complete. A user would not only need data 
> sheet in one hand, pocket calculator in other hand, but also driver source 
> code in the third hand to understand what's going on :-)

I'm not insisting on this particular point then. This whole prescaler
thing is above my head anyway.

> Initially, I didn't want to make a lot of changes to that driver, just have it 
> in the mainline kernel. But meanwhile, I feel if we do it, we should do it 
> properly. That means, either we accept the driver as it is now (with special 
> sysfs files no other driver has), or we change the specification in 
> Documentation/hwmon/sysfs-interface to be more general so that all fan 
> drivers fit in.
> 
> What's your opinion?

That either the max6650 driver complies with the standard interface as
much as possible and I'll be pleased to merge it in mainline, or it uses
it's own sysfs files no other driver uses and no user-space application
supports, that makes it essentially useless and I can't take it in
mainline.

I'm not asking that you remove features from the driver because they
just don't fit in the interface (as seems to be the case of the
prescaler thing), just that you use the standard names where they
exist, even if the name itself doesn't match the physical reality.

Thanks,
-- 
Jean Delvare

