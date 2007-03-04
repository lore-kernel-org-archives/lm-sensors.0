From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 04 Mar 2007 10:54:40 +0000
Subject: [lm-sensors] Could the k8temp driver be interfering with ACPI?
Message-Id: <20070304115440.b212d7ff.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <45D6DDCE.5050803@assembler.cz>
	<20070228213803.GA4877@ucw.cz>
	<20070301152655.f232db64.khali@linux-fr.org>
	<20070302114023.GD2163@elf.ucw.cz>
	<20070302114747.GB1212@srcf.ucam.org>
	<20070302151055.d2665d66.khali@linux-fr.org>
	<20070302141840.GA3441@srcf.ucam.org>
	<20070302220454.a0c66d04.khali@linux-fr.org>
	<20070302211251.GA10035@srcf.ucam.org>
	<20070303105316.d51e032d.khali@linux-fr.org>
	<4dfa50520703030747g3c887f5bxe25caefd1723c635@mail.gmail.com>
In-Reply-To: <4dfa50520703030747g3c887f5bxe25caefd1723c635@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Hubbard <david.c.hubbard@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Pavel Machek <pavel@ucw.cz>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, linux-acpi@vger.kernel.org, Chuck Ebbert <cebbert@redhat.com>, Rudolf@atrpms.net

Hi David,

On Sat, 3 Mar 2007 08:47:21 -0700, David Hubbard wrote:
> > Is there anything preventing us from doing such a walk and pre-allocate
> > all the I/O ranges? I am not familiar with the ACPI code at all, would
> > you possibly propose a patch doing that?
> 
> Here's a random idea -- what do you think of it?
> 
> ACPI already allocates some I/O ranges, which was a surprise to me:
> 
> > My machine looks like this:
> >
> > 1000-107f : 0000:00:1f.0
> >  1000-1003 : ACPI PM1a_EVT_BLK
> >  1004-1005 : ACPI PM1a_CNT_BLK
> >  1008-100b : ACPI PM_TMR
> >  1010-1015 : ACPI CPU throttle
> >  1020-1020 : ACPI PM2_CNT_BLK
> >  1028-102b : ACPI GPE0_BLK
> >  102c-102f : ACPI GPE1_BLK
> 
> For I/O and memory that ACPI accesses and has not reserved, the AML
> interpreter could allocate at run-time.
> 
> I'm not sure how to implement exactly. For example, it would be bad to
> have a /proc/ioports that had a lot of single ports allocated, for
> example:
> 1000-107f : 0000:00:1f.0
>  1000-1000 : ACPI PM1a_EVT_BLK
>  1001-1001 : ACPI PM1a_EVT_BLK
>  1002-1002 : ACPI PM1a_EVT_BLK
>  1003-1003 : ACPI PM1a_EVT_BLK
> 
> Thus the AML interpreter would need to have some reasonable
> intelligence when allocating regions. Conflict resolution would also
> be more difficult, e.g. if a hwmon driver was loaded first and then
> acpi as a module, ACPI could not allocate the region. Maybe run-time
> allocating won't work.
> 
> And then, how would ACPI release a region after it has used it? The
> easiest method would be to never release anything used even once.

I've been thinking about it too, but I could convince myself quickly
that it would never work, so I didn't bother posting about it ;)

As you found out yourself, it isn't trivial to allocate the ports
dynamically. Either you'll end up with lots of 1-address ranges, or
you'll allocate more than is actually needed, or you'll need a
buddy-allocator like mechanism to merge contiguous ranges. This sounds
quite complex to get right. And very costly, too. I don't know the
exact algorithm to find out whether an I/O range is already allocated
or not, and by who, but having to do it for each port access from AML,
forever, sounds like a huge overhead.

On top of that, there is a risk that another driver already requested
the I/O range. And we do not want to prevent ACPI from accessing it!
OK, it would be cleaner that the current situation in a way, but it
could also have bad consequences as was underlined elsewhere in this
thread.

What we want is to grant access to the resources to at least ACPI (and
ACPI only if we can't do better), or if possible to both ACPI and
individual drivers but with some mechanism avoiding concurrent access
(be it a mutex or a port forwarder.)

-- 
Jean Delvare

