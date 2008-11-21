From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 21 Nov 2008 08:42:18 +0000
Subject: Re: [lm-sensors] [patch 2.6.27-rc7] i2c: smbalert# support
Message-Id: <20081121094218.34ecd82a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <200804161434.54335.laurentp@cse-semaphore.com>
	<200809231532.40083.david-b@pacbell.net>
	<20081118091546.421d6b78@hyperion.delvare>
	<200811181401.34809.david-b@pacbell.net>
	<Pine.LNX.4.64.0811190140510.11673@t2.domain.actdsltmp>
	<20081119161632.2d0bde9e@hyperion.delvare>
	<Pine.LNX.4.64.0811201354310.11673@t2.domain.actdsltmp>
In-Reply-To: <Pine.LNX.4.64.0811201354310.11673-3bmvVOk6DZ+DGx/iekXGtrjh7zpefjiS@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Trent Piepho <tpiepho-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org

Hi Trent.

On Thu, 20 Nov 2008 14:00:21 -0800 (PST), Trent Piepho wrote:
> On Wed, 19 Nov 2008, Jean Delvare wrote:
> > On Wed, 19 Nov 2008 01:51:08 -0800 (PST), Trent Piepho wrote:
> >> On Tue, 18 Nov 2008, David Brownell wrote:
> >>> ---
> >>> drivers/i2c/busses/i2c-gpio.c |   10 ++
> >>> drivers/i2c/i2c-core.c        |  155 ++++++++++++++++++++++++++++++++++++++++
> >>> include/linux/i2c.h           |   14 +++
> >>> 3 files changed, 179 insertions(+)
> >>
> >> Can this be made optional?  Seeing as nothing uses it yet and it increases a
> >> brunch of core structs' sizes.
> >
> > Did you actually check the size increase? struct i2c_driver is added
> > one pointer, so 4 or 8 bytes, hardly worth mentioning. struct
> > i2c_adapter is added 72 bytes on x86-64, to 1360 bytes initially so an
> > increase of less than 6%. Is this really such a big issue? I doubt it.
> > You don't have that many i2c_adapters registered on any given system
> > for it to really matter, methinks.
> 
> Except every other subsystem in the kernel does the same thing.  Each release
> of 2.6 is significantly more bloated than the last and this is how it happens. 
> One "it's not that much wasted" change at a time.

You are unfair. We have been continuously cleaning up the i2c subsystem
over the past few years, shrinking the main structures regularly,
killing unused code, etc. And this clean-up process is going on.

> > Making it optional would have its problems as well. Either the drivers
> > which implement or make use of SMBus alert would have to depend on said
> > option being enabled, or you'd have to put #ifdefs in all these drivers
> 
> What's so hard about having them depend on smbus alert support?  They already
> depend on I2C and so on.  If any drivers ever get code for this, how hard is
> it to add one dependency or select to their Kconfig section?

While you are complaining about ever-growing memory footprints, other
users of the Linux kernel complain about ever-growing kernel config
option list. There are so many kernel configuration options these days
that it has become very hard for newcomers to configure their kernel on
their own. Even distribution kernel maintainers start complaining that
they don't know which options to select. So, adding new kernel options
for something else than hardware drivers should be considered with
great care.

In practice, this means that I am opposed to an option that would
appear in the configuration menu. If anything, that would be an hidden
option that would have to be selected by drivers which need it (much as
the "i2c algorithm" helper modules.) However, this approach has its
shares of problems as well. For one, driver authors might forget to
select the option in question, and this may lead to build failures
later on. Even if they do not forget, that's still one more thing for
them to think of (and for us to check when a driver is submitted for
review.) For another, if anyone needs the option for an out-of-tree
driver, they will ask for a manual way to select it anyway.

On top of that, your proposal isn't even optimal: if you have just one
driver that needs SMBus alert support, all adapters have their size
increased. Taking a concrete example, on my system, there are normally
3 I2C adapters (the mainboard's SMBus and 2 multimedia adapters) and
they don't make use of SMBus alert (not yet.) But I also have an
evaluation board for a thermal sensor which connects to the parallel
port. That one needs SMBus alert support. With your proposal, in order
to be able to make use of my evaluation board once in a while, every
other I2C adapter in my system would need to have the extra structure
fields. I fear that, in practice, this means that the SMBus alert
option will end up being selected in almost every kernel out there.
Once the support for this functionality is added to the kernel, you
will see drivers implementing support for it (David has not been the
only person asking for it.)

On the other hand, trying to optimize the memory usage isn't trivial.
Moving the extra structure fields to a separate, dynamically allocated
structure might increase the memory fragmentation and in practice use
_more_ memory. This would also make the code more complex, so what you
win on data structures, you lose on code.

The alternative, as mentioned in my initial answer, would be to let
each driver be built with or without support for SMBus alert, depending
on a central configuration option (which unfortunately would no longer
be possibly hidden.) After all, just because the hardware can do it and
the driver has support for it doesn't mean that your system makes use
of it! But then, not only you bloat the code with ifdefs, but you also
introduce one more thing for every driver author to test: he/she will
have to test his/her code with and without the option in question. If
we later add a couple similar options, this can quickly become
impossible to test all combinations in practice. And this will make bug
reproduction more difficult too.

All in all I am simply not convinced that it it worth optimizing. There
appears to be more drawbacks than benefits. There are many different
areas where cleanups would save a lot more memory than what you can
hope for here. For example, completing the removal of the legacy i2c
binding model. Want to help?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
