From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: Regarding standardized auto-fan control
Message-Id: <200407011004.i61A4jI3092984@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040630024326.GH3064@jupiter.solarsys.private>
In-Reply-To: <20040630024326.GH3064@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


>There are two decisions to be made:
>
>1) To expose chip-specific interfaces for auto-fan for each driver, or not.
>
>2) To expose a common subset of features for all chips, or not.
>
>Although IHMO #2 is going to prove very difficult, I won't argue against it.
>I think that the logic belongs in libsensors, and you disagree - ok, we
>can continue to discuss that.
>
>But this doesn't prevent us from still implementing #1, which people (myself
>included) want right now.  Let's at least agree about that.  More in-line...

Correct.

>You assume that a common subset of all auto-fan functionality is sufficient
>for everyone.  Why?  There are features of LM93 and w83627thf which do not
>fit any model that I have seen suggested.  Here's just one of many examples:
>
>The LM93 can ramp up the pwm in response to what is essentially a pwm
>*input* signal (called #PROCHOT), overriding its own auto fan control
>algorithm.  This feature has parameters of its own, of course.
>
>In fact, the two pwm outputs can each be bound to any (or all) of four
>temperature zones, two #PROCHOT inputs, and two #VRDHOT inputs.  It will
>use the largest result of any method to which it is bound.

OK, that's interesting, and can convince me that a common interface will
not be sufficent.

One thing I'm keeping in mind and more or less assuming is that most
configuration stuff is hardware dependent and should have already be
done by the BIOS. This is the reason why I don't want to expose the
whole chip features to userspace. One example of that are chips which
have some pins which can be used for different purposes (say voltage or
temperature). The function is defined at the moment the chip is soldered
on the motherboad. That's not a choice left to the user, although early
drivers would make him/her think so. In this example, I believe it's
better to provide a module parameter to workaround the BIOS brokeness
than make just about every configuration bit if the chip changeable at
run-time including things that are already decided and *must* match the
hardware for proper operation.

In that sense, I would almost assume that the BIOS should have already
defined which mode the auto-fan control should be in, and the user would
really only have to tweak the temperature limits to fine-tune its system.

Sadly, I guess that many BIOSes out there won't do their work properly,
which is why we need to do more that what should be needed. On the other
hand, remember tham us developers may like to play with every parameter,
especially on evaluation boards, but most users won't need to do so,
and, more importantly, don't want to see the whole mess it is. This is
why interfaces exist.

It's a pity that devices have become that complex with almost no common
lines between various manufacturers. That might be bearable for
closed-source (understand: redundant and unmaintained code) tools but
it's a real pain for us open-source folks.

>Yes of course, with no loss of functionality.
>(...)
>Again, if I understand correctly, you didn't sacrifice any feature of the
>H/W in order to normalize that interface.  The hardware was simply less
>capable than the API.  And importantly, it was a *strict subset*.

You got a point.

>In contrast, the auto-fan capable chips would have *reduced* functionality
>if *only* a common interface is allowed.

True.

>The LM93 example above among others, plus chips that have yet to be
>designed.

Not that we should not think of the future at all, but we definitely
cannot expect to do everything right for all future chips, whatever we
do (unless we don't design interfaces at all). Chip makers have weird
ideas all the time, sometimes for purely commercial reasons, or just
because they never wrote a driver.

>If anything, I expect future chips to be even more complicated (maybe even
>including PID controllers) as thermal management of newer processors demands
>it.

And I would hope that such systems woulc be fully automatic. The CPU
knows ahich temperature it can support, same for the other components.
Keeping the noise to a minimum to fit within the hardware-specified
range shouldn't require the user to set a dozen parameters he doesn't
understand anything about (if nothing else, simply because the user will
eventually not do the right thing and burn his/her hardware).

>Some chips have more complexity than most want.  That is no reason to
>deny the extra functionality to those who do want it.
>
>You wouldn't think that terminal drivers could be so different either,
>yet there are nearly countless IOCTLs for those as well.

And in the end I believe that only 0.5% of the users really know that
stuff and can make any benefit of it. So is it even worth implementing?

I am not designing (oh well, trying to...) this interface for my own use.
I don't even have a supported chip myself yet, and if I had, I could
just get the datasheet and program the chip myself for my own needs. The
interface I aim at is for the common guy, and, more importantly, for
applications to be able to expose this interface through a GUI to the
user without having to know the internal of each chip.

>(Assuming we expose a common interface from the drivers) we can make
>sure that chip-specific features will never have sysfs file name
>collisions with the common interface files.  A simple filename prefix
>by convention would do it.  The theoretical new libsensors can ignore
>anything else, just like the existing one does today.

s/can make sure/have to make really sure/
That's not an option, that's a requirement.

I agree that libsensors will simply ignore non-standard files so they can
safely exist.

>(...) I concede that a useful common interface
>might still be designed.
>
>I do still claim that any such common interface is *insufficient*.

OK, so some chips (the ones you use ;)) would have two interfaces. It is
going to be even more confusing in sysfs, but actually people are not
supposed to read the values here directly so it's not really a problem.
What may be OTOH is that the two interfaces will have to keep in sync,
whatever parameters are set. That's a chip-specific problem anyway.

One compromise I am now thinking of is that the chip-specific interface
for a given chip could be a complement to the common interface. You may
not need to duplicate the whole thing if you only want to add additional
features over the common interface.

I will rework my proposal for the common interface on Sunday (4th of
July) and post it here. Hopefully we'll agree on it and I'll submit a
patch for the documentation to Greg. This interface will be a
recommendation, not a requirement. It will state that some names are
reserved for the common interface, and that any chip driver using these
names must use them in the way the documented, commom interface says.
That's about it. Chips will be free to use other, non-reserved names
for whatever extra feature they want. Sounds OK?

Thanks,
Jean Delvare
