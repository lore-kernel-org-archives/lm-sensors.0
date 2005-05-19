From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: Winbond chips - design questions
Message-Id: <20031023013126.GA27817@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031022022051.GB8764@earth.solarsys.private>
In-Reply-To: <20031022022051.GB8764@earth.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Mark D. Studebaker <mds@paradyne.com> [2003-10-22 20:32:55 -0400]:
<snip>
> Recently, I stopped the madness and started a new driver, w83627hf,
> specifically to support the super i/o chips.
> The old driver works for the super i/o chips only
> when their i2c address has been set by the bios or
> when their isa address is 0x290. It does not include super i/o
> access or detection mechanisms.
> 
> The new driver is isa-only and includes super i/o
> detection, so that the isa address is always discovered.
> This makes the new driver much better at finding a chip.

Is this just ISA PnP?  I have no experience with that.

<snip>
> Why recycle stuff in libsensors? just laziness.
> It's a pain to retype all that stuff. Plus if the
> #defines are different then you need a whole different
> print function in prog/sensors/chips.c.
> For big chips like the winbonds that's a _lot_ of extra work
> to add support.

Yes I've noticed - while working on an independent asb100 driver.

I'm not as familiar with the userland side as the kernel side.
Some of that drudgery could be tamed by macros.  But that's the
least of it really...

Why are those enormous tables present in libsensors at all?
And then again what is the point of libsensors if the
sensors program needs special code for each driver?  Yuck.
I guess I should go read the source of gkrellm and see what
they're doing.

> I would claim the w83627hf driver is in good shape but I'm
> open to suggestions.

As I mentioned, there's something broken about fan3.  I'm going
to look at that first.

> If you do want to tackle a w83781d rewrite it's fine w/ me.
> You should decide whether you want to do it in 2.4 or 2.6.
> But a couple of warnings.
> You should have a good sample of boards with these chips to test with.

I have a w83781d and a w83627thf.  A friend of mine apparently has
a closet full of old boards that he doesn't want anymore... so I
could get lucky and find more.

> And you should be careful. A _huge_ number of people have chips
> supported by the w83781d driver. When a release takes a step
> backwards or changes something in that driver we get a ton of mail.
> It's not fun.
> Not to mention the whole undocumented as99127f chip which
> is, historically, probably our #1 chip for complaints.

If the only difference is that you load w83wxyz instead of w83781d
after an upgrade - I don't see that as a problem.  We can warn
people against that on the website.  At least their sensors.conf
won't need to change.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
