From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Thu, 18 Sep 2008 22:01:42 +0000
Subject: Re: [lm-sensors] Sensor chip interrupt
Message-Id: <20080918220142.GJ12753@mars.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.64.0809171500190.3610@t2.domain.actdsltmp>
In-Reply-To: <Pine.LNX.4.64.0809171500190.3610@t2.domain.actdsltmp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

* Hector Lahoz <hectorlahoz@gmail.com> [2008-09-18 22:25:04 +0200]:
> On Thu, Sep 18, 2008 at 1:02 AM, Trent Piepho <tpiepho@freescale.com> wrote:
> > I'd like to add alert IRQ support to the lm63 driver.  The new LM63 version,
> > LM96163, no longer shares the same pin for both the tach input and the alert
> > output, so it's quite a bit more useful.
> >
> > I've determined that with my prototype board that has an LM63, I can get
> > either an alert IRQ or a tach input, without hardware modification.  In order
> > to get the IRQ all I need to do is not connect a 3-pin fan (or not connect the
> > tach pin), as the tach signal effectively causes IRQs.  My patch to let the
> > lm63 fan be enabled/disabled via "fan1_enable" in sysfs has turned out to be
> > quite useful, contrary to some claims that no one would ever use this feature.
> > It's entirely possible to switch back and forth between tach and alert mode
> > without rebooting.
> >
> > It looks like there aren't any hwmon drivers that support interrupts, despite
> > it being a feature of virtually every hwmon chip.  Is this correct, that
> > there is no established way for dealing with the IRQs?

Yes, that is correct.

> > Where should the code go?  In platform code or in the lm63 driver?  Which IRQ
> > to request is platform specific, but actually doing so shouldn't be platform
> > specific.  The IRQ handler needs to somehow talk to the lm63, which if the
> > handler is in platform code will be rather hard to do.
> >
> > The IRQ handler will need to read the lm63 alert (alarm in hwmon) status
> > register to find out why the alert was generated (or _if_ an alert was
> > generated, since there could be other chips in the same IRQ, for example I'll
> > have two lm96163 chips with a common alert line).  Reading the alert status
> > register clears it if the alert condition no longer exists.  This means there
> > needs to be some communication between the IRQ handler and the lm63 driver so
> > one doesn't prevent the other from seeing an alert bit.
> >
> > Suppose all that is worked out, how does the interrupt actually _do_ anything?
> > The kernel could print a message, power off the system, change the processor
> > speed or some other stuff.


No, the kernel should not directly make such decisions about what to do in
response to the interrupt.  Policy vs. mechanism, and all that.

> > It would be nice to notify userspace somehow, but how?  Cause a program to
> > get run, like /sbin/hotplug (how about /sbin/toohotplug)?  Send a signal to
> > or wake a process blocked on one of the sysfs alarm files?  I'm not sure
> > how hard that is to do, but it does seem nice to be able to select() on
> > temp2_max_alarm and then get woken when it changes.  Or is there some other
> > mechanism for this?
> >
> 
> I've also wondered many times why are hwmon drivers not using interrupts. I
> have always learnt that using interrupts is more efficient than polling
> except in some exceptional cases. I guess polling the sensor chip every 5
> seconds is not a meaningful overload. But anyway I'd loike to get an answer
> from the lm-sensors gurus.  The it87 is also able to send an interrupt when
> any value exceeds a limit but the driver does not make use of it.  For
> example, sensord wouldn't have to sleep and poll taking advance of this
> feature.

Two part answer...

1) It may be more efficient, but for this class of hardware the difference is
not meaningful.  By "this class" I mean processor and main board temp and
voltage sensors, where the measurements are not expected to fluctuate wildly.
Modern processors will throttle down in response to over- temp situations all
by themselves, so the hwmon drivers do not need to react any faster than 1
second even.  The hwmon drivers are not intended for real-time or safety
critical usage, nor do they need to be.

2) On most mainboards, the interrupt line from a discrete hwmon chip is not
connected.  In the case of chips using the SMBus, the SMBalert line may not
be connected either.  And even if it was, the Linux I2C subsystem does not
yet support it anyway.

In summary... lots of work to do if you want interrupts from hwmon drivers;
but very little real value (for the majority of users) in doing it.

I hope that helps; regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
