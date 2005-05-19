From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:55 +0000
Subject: RFC PATCH 2.6 sysfs names: fscher: change div to ripple
Message-Id: <CBCq0wM1.1114590758.9393700.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <o99t61p4c255uvjrhpavjejblb2r1cdts5@4ax.com>
In-Reply-To: <o99t61p4c255uvjrhpavjejblb2r1cdts5@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Grant, Philip,

> > So a ripple counter is the equivalent to a fan divisor and therefore I
> > would recommend *not* to apply this patch to rename it.  Keep the
> > original fan_div name.

A ripple counter is indeed equivalent to a fan divisor in the true sense
of the term (dividing the fan speed value), but unfortunately the term
"fan divisor" was used as a shortcut for "fan clock divider" for so
long that using it for something different is now confusing. Using a
fanN_div accessor for something else than a fan clock divider should be
avoided, so as to not add to the confusion.

The way the Hermes and Poseidon chips deal with fans is very different
from what other chips do, and their "ripple" value isn't equivalent
to the common "fan clock divider" concept used elsewhere. So using the
same accessor name wasn't wise. I am sorry I let it happen in the first
place.

> Disagree, if you have access to these chips, please perform the test
> and let me know result, then we can say the datasheet is a poor
> translation.  (pulses <=> ripples struck me as strange translation).

I've read the Hermes datasheet again and it looks rather clear to me.
The pulses <=> ripples relation makes sense, in that the chip will
provide the correct fan speed if and only if the ripple counter has been
setup to match the fan's pulses per revolution.

> Having the same name for a fundamentally different function would
> not be useful.
>
> The current different names for the same function is plainly wrong.

The functions are not "fundamentally different", in that both are ways
to avoid register overflows by accomodating to different fans. Still,
the purpose of the sysfs interface is to be chip-independant, so the
current situation is bad.

> (fanX_pulses_per_rev) --> user-space should have this too, to scale
> fan speed when they have other than two pulses per rev fans.

Yes, this is how the accessor should be named when the chip supports this
functionality. I would have gone for fanN_ppr for something shorter. I
think I remember a Linux 2.4 driver using that name already.

At any rate, the name fanN_ripple doesn't sound good to me. The fact
that a ripple counter is used is an implementation detail the user
doesn't need to know. The sysfs interface should focus on the function
rather than the implementation. So the proposed patch doesn't please
me, and I would like to see a patch for fscpos to change the name there
as well.

Note that such patches can only be accepted in Linux 2.6 if an equivalent
patch is provided for libsensors.

Thanks,
--
Jean Delvare
