From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: Winbond chips - design questions
Message-Id: <3F9721B7.4BAC686A@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031022022051.GB8764@earth.solarsys.private>
In-Reply-To: <20031022022051.GB8764@earth.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

It's my doing so I can answer your questions.

There's not much good reason for the monster w83781d driver.
I'm not defending it, just explaining how we got here.

Generally I would start supporting a new chip by
simply recognizing the ID and treating it like an old chip.
Later (maybe much later) when a datasheet was available, 
when the unique parts of the new chip were known,
the driver was enhanced with more if statements
to support the new chip better.

Recently, I stopped the madness and started a new driver, w83627hf,
specifically to support the super i/o chips.
The old driver works for the super i/o chips only
when their i2c address has been set by the bios or
when their isa address is 0x290. It does not include super i/o
access or detection mechanisms.

The new driver is isa-only and includes super i/o
detection, so that the isa address is always discovered.
This makes the new driver much better at finding a chip.

You could make the argument that I should have removed
627hf/697hf support from the w83781d driver at the same time.
But I didn't want to disrupt people that were using that
driver (see below). And remember the new driver is isa-only.
So if you want i2c access for whatever reason you have to
use the old driver.

Why recycle stuff in libsensors? just laziness.
It's a pain to retype all that stuff. Plus if the
#defines are different then you need a whole different
print function in prog/sensors/chips.c.
For big chips like the winbonds that's a _lot_ of extra work
to add support.

I would claim the w83627hf driver is in good shape but I'm
open to suggestions.

If you do want to tackle a w83781d rewrite it's fine w/ me.
You should decide whether you want to do it in 2.4 or 2.6.
But a couple of warnings.
You should have a good sample of boards with these chips to test with.
And you should be careful. A _huge_ number of people have chips
supported by the w83781d driver. When a release takes a step
backwards or changes something in that driver we get a ton of mail.
It's not fun.
Not to mention the whole undocumented as99127f chip which
is, historically, probably our #1 chip for complaints.



mds




"Mark M. Hoffman" wrote:
> 
> * Mark M. Hoffman <mhoffman@lightlink.com> [2003-10-21 21:51:13 -0400]:
> > OK, I committed a partial fix - go ahead and try it.  I already see that
> > sensors doesn't report fan3 (which corresponds to "Power Fan" in P4C800
> > BIOS.)  I will start another thread on the mailing list about that...
> 
> OK, new subject anyway...
> 
> What is the benefit of having all of the Winbond drivers in two files?
> 
> And related - what is the benefit of recycling feature tables etc. between
> all the Winbond types in lib/chips.c and prog/sensors/chips.c?
> 
> I can tell you the downside, for sure: I'm afraid to touch any of it for
> fear of breaking one of the other 5 chips that I *don't* have and *can't*
> test.  Sure it's free software and I don't have any obligation... but right
> now those particular bits are nigh unmaintainable.
> 
> I guess I'm asking for permission (and help!) in refactoring the Winbond
> drivers.  The NatSemi (lm??) drivers are closer to where I think we
> should go: two (or at most, three) related chips per file... and only
> if they are trivially different or one has a subset of features of the
> other, etc.
> 
> Also, what (kinds of) changes in libsensors will cause an ABI change?  Is
> it absolutely limited to the contents of lib/sensors.h?
> 
> Regards,
> 
> --
> Mark M. Hoffman
> mhoffman@lightlink.com
