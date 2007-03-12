From: hjk@linutronix.de (=?iso-8859-1?q?Hans-J=FCrgen_Koch?=)
Date: Mon, 12 Mar 2007 14:44:19 +0000
Subject: [lm-sensors] [PATCH] Add MAX6650 support
Message-Id: <200703121544.20827.hjk@linutronix.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200701171359.46334.hjk@linutronix.de>
In-Reply-To: <200701171359.46334.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Am Montag, 12. M?rz 2007 14:50 schrieb Jean Delvare:
> Hi Hans-J?rgen,
>
> On Sun, 11 Mar 2007 22:08:01 +0100, Hans-J?rgen Koch wrote:
> > Obviously, we've reached some limits of the current concept. IMHO, the
> > 'pwm' and 'divider' sysfs files are much too hardware dependent. We
> > should have more abstraction, e.g. like this:
>
> Forget about it right away, this interface is here to stay and we're
> not changing it.

All right, I accept that and won't argue.

>
> > fan1_input: (ro) Current speed in RPM
> > fan1_speed: (rw) Desired speed in RPM
>
> We have fan1_input and fan1_target for this. 

Documentation/hwmon/sysfs-interface doesn't mention fan1_target. I tried to 
follow that specification. I'll rename "speed" accordingly.

[...]
>
> > fan1_min_speed,
> > fan1_max_speed: (rw) Planned/defined operating range in RPM
>
> We have fan1_min for the former. We could have fan1_max for the latter,
> but no known chip actually supports upper limit for fan speeds.

My intention was not to set upper/lower limits but to allow the driver to 
calculate things like "divider" or "counttime". If I make "divider" 
or "counttime" (or whatever algorithm a chip uses) sysfs attributes, then a 
user needs data sheet and calculator to find appropriate values for them. 
Min/max values are either known or can simply be found by experimenting and 
the rest is calculated by the driver, not by the user.
But as I said, I won't argue, I'll implement it your way.

>
> > fan1_tacho: (rw) Pulses per round of the tacho generator
>
> 99% of the fans out there emit two pulses per revolution, so we didn't
> bother, although a couple driver do expose a non-standard sysfs file
> for that. The fact is that this can be addressed easily in user-space,
> so the interest in implementing it in every driver is questionable.

Again, I won't argue.

>
> > fan1_mode: (rw) on, off, closed_loop, open_loop, ...
>
> This is exactly what pwm1_enable does. The name could have been chosen
> better, granted.

I don't understand Documentation/hwmon/sysfs-interface in this point. Which 
values for pwm1_enable correspond to on, off, closed_loop, and open_loop? Can 
I define new ones? The text mentions "2+"...

[...]
>
> > > > counttime is the time interval during which tacho pulses are counted.
> > > > It determines the resolution of the measured speed values. It should
> > > > be set to the longest time that still ensures the 8-bit counter
> > > > doesn't overflow under worst case conditions.
> > >
> > > _This_ really sounds like fan1_div. It changes the period of time
> > > rather than the clock frequency, but from a functional point of view
> > > the result is the same: preventing 8-bit register overflow for certain
> > > speed fans. The only difference is that typical chips overflow for slow
> > > fans, while the MAX6650 is more likely to overflow when the fan is too
> > > fast, if I understood correctly.
> > >
> > > So please implement it that way. fan1_div = 1 should correspond to the
> > > smaller period of time (faster fan.)

I'll do that if possible. After all, I have two registers (prescaler and 
countime) that are affected. As I'm limited to powers of two by the 
specification, it might not fit. If that is the case, I'll leave that 
attribute away and we have to live with a fixed value given by a module 
parameter.

> >
> > As I said above, I really believe we shouldn't do that but be less
> > hardware dependent.
>
> It's just giving a different name to something to make it fit in the
> standard. It's rather _less_ hardware dependent than what you propose.
>
> > > Aren't the count time and precaler values somewhat related? Won't the
> > > user have to change both the same way if he/she gets a new fan running
> > > at a different speed? Maybe it would make sense to link fan1_div to
> > > both the prescaler and the count time after all.
> >
> > If I did that, confusion would be complete. A user would not only need
> > data sheet in one hand, pocket calculator in other hand, but also driver
> > source code in the third hand to understand what's going on :-)
>
> I'm not insisting on this particular point then. This whole prescaler
> thing is above my head anyway.

OK.

>
> > Initially, I didn't want to make a lot of changes to that driver, just
> > have it in the mainline kernel. But meanwhile, I feel if we do it, we
> > should do it properly. That means, either we accept the driver as it is
> > now (with special sysfs files no other driver has), or we change the
> > specification in Documentation/hwmon/sysfs-interface to be more general
> > so that all fan drivers fit in.
> >
> > What's your opinion?
>
> That either the max6650 driver complies with the standard interface as
> much as possible and I'll be pleased to merge it in mainline, or it uses
> it's own sysfs files no other driver uses and no user-space application
> supports, that makes it essentially useless and I can't take it in
> mainline.

All right. New version will follow soon.

>
> I'm not asking that you remove features from the driver because they
> just don't fit in the interface (as seems to be the case of the
> prescaler thing), just that you use the standard names where they
> exist, even if the name itself doesn't match the physical reality.

I remove the feature of being able to adapt to a special fan through sysfs 
files, but I don't really care. To get the driver merged is more important to 
me.

Thanks,
Hans


