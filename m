From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 22 Nov 2008 10:13:40 +0000
Subject: Re: [lm-sensors] [patch 2.6.27-rc7] i2c: smbalert# support
Message-Id: <20081122111340.0bfc2c05@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <200804161434.54335.laurentp@cse-semaphore.com>
	<200809231532.40083.david-b@pacbell.net>
	<20081118091546.421d6b78@hyperion.delvare>
	<200811181401.34809.david-b@pacbell.net>
	<Pine.LNX.4.64.0811190140510.11673@t2.domain.actdsltmp>
	<20081119161632.2d0bde9e@hyperion.delvare>
	<Pine.LNX.4.64.0811201354310.11673@t2.domain.actdsltmp>
	<20081121094218.34ecd82a@hyperion.delvare>
	<Pine.LNX.4.64.0811212122370.18022@t2.domain.actdsltmp>
In-Reply-To: <Pine.LNX.4.64.0811212122370.18022-3bmvVOk6DZ+DGx/iekXGtrjh7zpefjiS@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Trent Piepho <tpiepho-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org

Hi Trent,

On Fri, 21 Nov 2008 22:04:26 -0800 (PST), Trent Piepho wrote:
> On Fri, 21 Nov 2008, Jean Delvare wrote:
> > You are unfair. We have been continuously cleaning up the i2c subsystem
> > over the past few years, shrinking the main structures regularly,
> > killing unused code, etc. And this clean-up process is going on.
> 
> The size of i2c-core, struct i2c_client and struct i2c_adapter:
> v2.6.28 9718 392 500	w/ smbalert patch
> v2.6.28 8878 392 472
> v2.6.27 8732 368 448
> v2.6.26 7877 352 440
> v2.6.25 7854 376 444
> v2.6.24 9060 372 444
> v2.6.23 9359 404 476
> v2.6.22 9330 448 520
> v2.6.21 7814 464 692
> v2.6.20 7896 444 672
> v2.6.19 7871 444 668
> v2.6.18 6857 436 660

Thanks for providing these numbers, these are really useful! I'm
curious if you would be able to compute the same numbers down to, say,
kernel 2.6.5 or even 2.6.0? I'm curious where we started from.

I am also interested in the script / method you used to come up with
these numbers, so that maybe I can get the numbers myself if you do not
have the time.

> Other than some temporary bloat in 2.6.22-2.6.24, size the size of i2c core
> has been steadily increasing.

In 2.6.22 we merged the new-style i2c driver binding. The size increase
was pretty much expected, as all the legacy binding code was (and is)
still around.

In 2.6.24 we killed i2c_control() (actually, it essentially moved to
i2c-dev.)

In 2.6.25 we did many cleanups. So it is worth noting that what you
call "temporary bloat" isn't really that. The code duplication that was
introduced in 2.6.22 wasn't removed in 2.6.25. It is still present in
the kernel today and we should be able to get rid of it later, meaning
that the size of i2c-core will decrease.

In 2.6.27 we added detection capability to the new-style i2c binding
model, temporarily duplicating a lot of code again. The old code is
expected to go away in kernel 2.6.29 (I hope) or 2.6.30 together with
the legacy binding model. It will be interesting to see where it gets
us.

>                               The data structures got a shrink around
> 2.6.23-2.6.24, mostly from removing unneeded name fields, but most other
> changes have been an increase in size.

We should see a shrink again in kernel 2.6.29 or 2.6.30, as I wrote
above. Anyway, your numbers pretty much prove my point: overall, the
size of the i2c data structures has decreased over the last few years.
-10% for i2c_client, -24% for i2c_adapter between 2.6.18 and ~2.6.28. So
you can't claim that they are growing beyond control. We are clearly
paying attention to the size of these structures.

> > On top of that, your proposal isn't even optimal: if you have just one
> > driver that needs SMBus alert support, all adapters have their size
> > increased. Taking a concrete example, on my system, there are normally
> 
> Seeing as there are currently no clients with smbalert support, this shouldn't
> happen to most people for quite some time.  Forcing it on for people who don't
> need smbalert (and no one has it now, so there can't be that much demand)

How could there be support for a feature which we are just adding now?

And there _has_ been demand (Hendrik Sattler in August 2006 [1], David
Brownell in September 2007 [2], Srinivas Ramana in October 2008 [3]),
which is exactly why we are implementing support now.

At this point I simply don't know how popular the feature will be. It
may take years to find out, as people tend to not touch drivers that
work, even when new features could let them rewrite the code in a
better way.

[1] http://lists.lm-sensors.org/pipermail/i2c/2006-August/000204.html
[2] http://lists.lm-sensors.org/pipermail/i2c/2007-September/001845.html
[3] http://lists.lm-sensors.org/pipermail/i2c/2008-October/004949.html

> is
> clearly worse.  Maybe most distro kernels will have it on, but people who have
> a reason to care about kernel size and speed can turn it off.

As has been said before, you are welcome to submit a patch making the
feature optional, and we'll evaluate it. But I still admit I am
skeptical that you can come up with something with more advantages than
drawbacks. We are talking about less than 2 kB of run-time memory here,
aren't we?

> > The alternative, as mentioned in my initial answer, would be to let
> > each driver be built with or without support for SMBus alert, depending
> > on a central configuration option (which unfortunately would no longer
> > be possibly hidden.) After all, just because the hardware can do it and
> 
> Some drivers could select smbalert support and only build with it.  Other
> drivers could have a driver option to enable alert support, core smbalert
> support would only be selected if that option was one.  It would depend on how
> much bloat it adds and how complex it is to make optional.  The alarm irq code
> I wrote for the lm63 driver ended up being quite complicated.

Good point, not all drivers have to do the same. My previous point
remains though: this is adding complexity to the kernel configuration,
bringing its share of potential issues when it comes to test coverage
and bug reproducibility.

> > All in all I am simply not convinced that it it worth optimizing. There
> > appears to be more drawbacks than benefits. There are many different
> > areas where cleanups would save a lot more memory than what you can
> > hope for here. For example, completing the removal of the legacy i2c
> > binding model. Want to help?
> 
> Increased efficiency in one place is not exclusive of increase efficiency
> elsewhere.

In a fantasy world where spare time grows on trees, you may be correct.
In the real world though, you are clearly wrong. If we spend time making
SMBus alert support optional, this is time we aren't spending on
improving something else. I am trying to spend my time where it is well
spent, or where there is fun. Making SMBus alert optional doesn't fit
in either category as far as I can see.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
