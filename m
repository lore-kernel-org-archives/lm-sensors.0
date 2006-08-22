From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 22 Aug 2006 10:01:38 +0000
Subject: [lm-sensors] generic chip support in libsensors
Message-Id: <20060822120138.93f1caf4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44C78622.8060808@hhs.nl>
In-Reply-To: <44C78622.8060808@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans, Mark,

Sorry for the late answer, I'm only finishing catching up with e-mail
from my vacation.

> > In fact, Jean Delvare & I discussed just how we would like to do this
> > at OLS.  It is long overdue.

Indeed Mark & I discussed that at the same time you posted to the
list :) I guess it just became obvious to several of us that we could
get a chip-independent library for a relatively low cost. At least lower
than a library rewrite.

> > I will let Jean reproduce the rest of the plan here from his notes.

Here we go. I scanned the sketch I drew at the restaurant with Mark, it
is attached.

The core idea is that in kernel 2.4, the kernel drivers provided the
sensor data, but not enough details about the chip "structure" (number
and type of inputs and features). For this reason the structure info was
put in libsensors. In kernel 2.6, the drivers provide both the
structure and the data, so the structure is redundant between the
drivers and libsensors. For now we try hard to keep both in sync, and
that sucks.

The long term solution is to kill all structure information from
libsensors, which will make it MUCH smaller and reduce the maintenance
work to basically nothing. When we do that we say bye-bye to 2.4
support.

But for now we can start by adding this generic support in the library.

Step 0: add individual alarm and beep files to all 2.6 drivers
Not shown on my sketch because I remembered it the day after. This is
the last step to a truly standard sysfs interface to hwmon chips.

Step 1: let libsensors scan /sysfs to discover the chip features
From there we can generate a structure like the ones hard-coded in
lib/chips.c.

With this alone we should be able to use "sensors -u" on any 2.6
driver. Not user friendly though.

Step 2: add sensor type information to the structure
For now the library is type-agnostic. This worked as long as we had
dedicated printing routines for every chip in "sensors", but the goal
of a chip-independent library is to have completely generic user-space
tools as well. We could let each user-space tool guess the sensor type
from the symbol name, but this would incur redundancy across tools. So
better have libsensors generate this information, and add a function to
the library interface for user-space tools to query for data type.

I'm waiting to see an implementation of this to actually decide if it's
the right thing to do.

Step 3: add generic printing routines to sensors
We want a function to print voltages, one for temperatures, one for fan
speed, and a few others. If libsensors provides the type for every
symbol, we can easily branch to the correct printing routine for every
set of symbols. We have some functions like this already, the idea is
to make them even more generic. For example temperature sensors can
come with many different type of limits (low, high, critical,
hysteresis) and depending on the ones available for a given chip we
need to display everything in the right order with proper formatting.

At this point we should be able to have something like "sensors -u" but
with per-sensor-type formatting so much nicer.

Step 4: new sensors.conf.eg
We need to use the standard symbol names in sensors.conf.eg. So far we
used the old symbol names (from 2.4) and libsensors was converting to
the new ones for 2.6 drivers. These old symbol names make no sense if
the driver interface is probed at runtime.

Step 5: take care of the 2.4 part of things
What to do here is not completely clear yet... Mark suggested killing
everything right away, but I think it's a bit early at this point. I'd
rather tweak the library as needed to allow the new "sensors -u" (which
should become the default) to work even with 2.4, so we can kill all
chip specific code in "sensors" to start with. And kill lib/chips.[ch]
only later.

Most of these steps are in fact independent and could be done in a
different order or even by different persons, however each change by
itself isn't really useful so we'll need to synchronize the efforts.

> > > There are still questions if to rewrite the libsensors and allow LGPL or
> > > change libsensors to what you propose.
> > 
> > This was never really a question in my mind.  I recognize that we've been
> > asked for a LGPL library in the past... too bad for them.  I'm not going to
> > take on the job of rewriting *all* of libsensors just to accomodate a license
> > change.  I think that I've brought Jean around to the same thinking.

Yep, I second that. A GPL library which works is magnitudes more useful
than an hypothetical LGPL library which we may not have the time to
write, ever.

If anyone is worried enough, that person gets to write a LGPL library,
not us.

> I've finally had some positive feedback from my uguru2 driver testers,
> so I'll need to write userspace support for the uguru2 one of these
> days. I would prefer to sole this by writing generic 2.6 only chip
> support as described above. Before I start doing this, I however would
> first like to know wether to use libsysfs for this or not.

That generic code whouls be easier to write than I first thought, but it
is still far from being trivial and will take some time. If you want to
work on it, this is welcome, but adding specific uguru2 code for now
may make sense as well. It can always be removed later.

> As a Fedora developer I've asked what Fedora is planning on doing with
> libsysfs now udev no longer needs it. The answer was that since some
> other apps and libs (directfb, lm_sensors) use it it will be kept in
> Fedora and be maintained there. So we could keep just using OTOH Fedora
> also said they would drop it if no one was any longer using it, so it
> would not be good to be the last remaining user of libsysfs.

There are still lots of package using it. There was a rumor at Suse
that it would be dropped soon, but in fact the libsysfs package is being
upgraded from 1.3 to 2.1 right now. The rumor also said that libsysfs
was no more supported by whoever wrote it, but 2.1 is just out so this
doesn't appear to be true either.

We'd better not wait for the world to settle on the libsysfs case to
work on libsensors. It doesn't matter much if we keep using libsysfs or
not, as long as the job is done. Whoever works on this if free to keep
or drop libsysfs, I don't really care.

If we keep using libsysfs and we end up being the only package doing
so, the distributions who want to get rid of libsysfs get to provide a
patch for libsensors.

> So which way will it be? As soon as this is decided upon I can start
> working on generic 2.6 chip support (as time permits).

Either way is fine with me.

I'll be working on step 0 of my plan for now (individual alarm files),
as soon as we are done with the __must_check fixes, as both set of fixes
confict badly with each other.

-- 
Jean Delvare
-------------- next part --------------
A non-text attachment was scrubbed...
Name: OLS2006_WorldDominationPlan.png
Type: image/png
Size: 75658 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060822/423cc575/attachment-0001.png 
