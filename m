From: "Hector Lahoz" <hectorlahoz@gmail.com>
Date: Thu, 18 Sep 2008 20:25:04 +0000
Subject: Re: [lm-sensors] Sensor chip interrupt
Message-Id: <efa7127e0809181325o1fd8fd1k5a8b68286709bd24@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.64.0809171500190.3610@t2.domain.actdsltmp>
In-Reply-To: <Pine.LNX.4.64.0809171500190.3610@t2.domain.actdsltmp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Sep 18, 2008 at 1:02 AM, Trent Piepho <tpiepho@freescale.com> wrote:
> I'd like to add alert IRQ support to the lm63 driver.  The new LM63 version,
> LM96163, no longer shares the same pin for both the tach input and the alert
> output, so it's quite a bit more useful.
>
> I've determined that with my prototype board that has an LM63, I can get
> either an alert IRQ or a tach input, without hardware modification.  In order
> to get the IRQ all I need to do is not connect a 3-pin fan (or not connect the
> tach pin), as the tach signal effectively causes IRQs.  My patch to let the
> lm63 fan be enabled/disabled via "fan1_enable" in sysfs has turned out to be
> quite useful, contrary to some claims that no one would ever use this feature.
> It's entirely possible to switch back and forth between tach and alert mode
> without rebooting.
>
> It looks like there aren't any hwmon drivers that support interrupts, despite
> it being a feature of virtually every hwmon chip.  Is this correct, that
> there is no established way for dealing with the IRQs?
>
> Where should the code go?  In platform code or in the lm63 driver?  Which IRQ
> to request is platform specific, but actually doing so shouldn't be platform
> specific.  The IRQ handler needs to somehow talk to the lm63, which if the
> handler is in platform code will be rather hard to do.
>
> The IRQ handler will need to read the lm63 alert (alarm in hwmon) status
> register to find out why the alert was generated (or _if_ an alert was
> generated, since there could be other chips in the same IRQ, for example I'll
> have two lm96163 chips with a common alert line).  Reading the alert status
> register clears it if the alert condition no longer exists.  This means there
> needs to be some communication between the IRQ handler and the lm63 driver so
> one doesn't prevent the other from seeing an alert bit.
>
> Suppose all that is worked out, how does the interrupt actually _do_ anything?
> The kernel could print a message, power off the system, change the processor
> speed or some other stuff.  It would be nice to notify userspace somehow, but
> how?  Cause a program to get run, like /sbin/hotplug (how about
> /sbin/toohotplug)?  Send a signal to or wake a process blocked on one of the
> sysfs alarm files?  I'm not sure how hard that is to do, but it does seem nice
> to be able to select() on temp2_max_alarm and then get woken when it changes.
> Or is there some other mechanism for this?
>

I've also wondered many times why are hwmon drivers not using interrupts. I have
always learnt that using interrupts is more efficient than polling
except in some
exceptional cases. I guess polling the sensor chip every 5 seconds is not a
meaningful overload. But anyway I'd loike to get an answer from the lm-sensors
gurus.
The it87 is also able to send an interrupt when any value exceeds a
limit but the driver
does not make use of it.
For example, sensord wouldn't have to sleep and poll taking advance of
this feature.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
