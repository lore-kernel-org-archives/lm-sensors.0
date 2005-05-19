From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:51 +0000
Subject: [RFC PATCH 2.6.12-rc2-mm2 0/2] i2c: new sysfs class "hwmon"
Message-Id: <pn2icTMK.1113385939.5960440.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050411044427.GA4963@jupiter.solarsys.private>
In-Reply-To: <20050411044427.GA4963@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Mark, hi Greg,

Sorry for joining the thread late. Don't misinterpret this, I am *very*
interested by what Mark proposes.

Greg, I am working at one end of the problem (making it possible to
separate ISA hardware monitoring drivers from the i2c-core), while Mark
works at the other end (preparing a hwmon class which is independant
from i2c so all hardware monitoring device drivers can use it regardless
of the bus they are connected to). Hopefully we'll meet at some point,
and the job will be done.

> > Khali is working on patches to get rid of the i2c-isa 'pseudo-adapter'.
> > Since any sensor chip attached to the ISA bus will no longer appear in
> > the /sys/bus/i2c tree, a new way is needed.  Userspace tools can be
> > taught to look in /sys/class/hwmon first, and then /sys/bus/i2c for
> > backwards-compatibility.
>
> Ok, that sounds acceptable.

As Mark underlined, it's not only acceptable. It's needed. Newer
Super-I/O hardware monitoring logical devices just don't fit in the i2c
subsystem (for a reason: they are not I2C devices at all). These drivers
are currently very ugly and their registration is inefficient and
overall broken.

The key here is that, from the early days, it was assumed that i2c and
hardware monitoring were the same thing. That's simply not true, which
is the reason why I want us to clean up the mess now, and have drivers
really attach to where they belong instead of an arbitrary bus. The
embedded folks will thank us when they won't need to load i2c-core for
their ISA hardware monitoring devices anymore (let alone the shrink in
the size of the drivers themselves).

That being said, if your "acceptable" means that Mark's approach is
not the prefered way to do it, I'd certainly like to hear about the
proper way. We will change the hardware monitoring device drivers in a
major way, so we better get it right.

> > > > 1. I don't like "1-0290" for a class ID, but it was the easiest
> > > > thing to use at the time.  A better name might be w83627thf-0.
> > >
> > > As long as it's unique, that's the only requirement.
> >
> > I just strlcpy'd the '1-0290' ID from the /sys/bus/i2c tree because it
> > is unique.  My concern is that it's not very descriptive.
>
> True, pick something else if you don't like that :)

Once the ISA hardware monitoring drivers will have moved outside of the
i2c subsystem, their old client ID will make no more sense (the bus
part, that is), and will be changed to something that makes sense for an
ISA device. I don't know how other ISA device drivers do, but using the
base address alone would make sense. This means that 1-0290 would become
0290.

The reason why I mention that at this point is that it means that the
various driver types will have different ID schemes, so using the same
ID for the device and for its class sounds dangerous, as we wouldn't be
able to guarantee the uniqueness. (This is all new to me, I didn't know
that class entries needed an ID on their own.) Maybe we can take a look
at what other classes chose as an ID scheme?

> Ok, if you have _no_ sysfs files, and you have no where anyone else
> could ever grab ahold of a reference to you, then no, you don't need a
> release function.  But that's really not how a class_device structure
> should be used.

How should it be used then? Do you suggest that all sysfs files should be
"physically" moved from the i2c device to the hwmon class? This would
break compatibility with the current user-space stuff :(

I thought that classes were really only links to where the devices were
in the sysfs tree. Looks like I was wrong.

Thanks,
--
Jean Delvare
