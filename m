From: Trent Piepho <tpiepho@freescale.com>
Date: Mon, 22 Sep 2008 20:50:34 +0000
Subject: Re: [lm-sensors] Sensor chip interrupt
Message-Id: <Pine.LNX.4.64.0809191049430.3476@t2.domain.actdsltmp>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.64.0809171500190.3610@t2.domain.actdsltmp>
In-Reply-To: <Pine.LNX.4.64.0809171500190.3610@t2.domain.actdsltmp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 18 Sep 2008, Mark M. Hoffman wrote:
>>> Suppose all that is worked out, how does the interrupt actually _do_ anything?
>>> The kernel could print a message, power off the system, change the processor
>>> speed or some other stuff.
>
>
> No, the kernel should not directly make such decisions about what to do in
> response to the interrupt.  Policy vs. mechanism, and all that.

It could be a latency issue.  The extra delays of going through userspace
might be too much.  For things like laptop freefall and shock sensors for
example, which can change a lot faster than temperature.

I've written some initial support for the alert interrupt and did some
measurements with a scope.  Here's a picture of an alert event,
http://www.speakeasy.org/~xyzzy/pictures/lm63alarm.png

The bottom signal is the ALERT# line that generates an IRQ, the upper signal
is a CPU GPIO line connected to an LED that is being changed in response to
it.  Changing the GPIO only takes about 60 ns.

The events start when alert# drops because the temperature got too high (I put
my finger on the fan).  This triggers an IRQ.

The first thing I have the alert IRQ handler do is to raise the GPIO, that's
the upper signal going high.  It looks immediate, do to the scale in that
picture, but it takes on the order of 2 us.

Since I2C can sleep, I can't do anything else with the LM63 in the IRQ
handler, so it schedules a workqueue.

The first thing that work queue does it lower the gpio, which is when the top
signal goes low again after 1.008 ms.  Seems a wq adds a surprising amount of
latency.  Be interesting to try a tasklet and see how that compares.

Next the work function reads the alarm register from the LM63, which resets
the alert# signal.  That's the bottom signal going high after 1.496 ms.  Which
shows how long it takes the ack the interrupt.

Then the work function uses sysfs_notify() to wake a process that has blocked
on one of the sysfs alarm files with select().  That process raises the gpio
again via sysfs, which is when the top signal goes high again after 2.814 ms.

So, if this gpio were to so something like turn the power off, the latency
depending on where it's done:
From the interrupt:                  2 us
From a kernel work queue,
   if you don't check what alarm was: 1.0 ms
   if you do check/ack the alarm:     1.5 ms
From userspace:                      3.8 ms

So, about 2000x more latency for userspace vs IRQ, and about 3x the latency
for userspace vs the kernel in process context.

Of course if the userspace process is swapped out, it could take much much
longer.  I can see that being a big argument in favor of putting alert
handling in the kernel.  If the IDE bus hangs (my DVD-RW does this all time)
over temperature shutdown stops working?  That could be really bad.

> 1) It may be more efficient, but for this class of hardware the difference
> is not meaningful.  By "this class" I mean processor and main board temp and
> voltage sensors, where the measurements are not expected to fluctuate
> wildly.  Modern processors will throttle down in response to over- temp
> situations all by themselves, so the hwmon drivers do not need to react any
> faster than 1 second even.  The hwmon drivers are not intended for real-time
> or safety critical usage, nor do they need to be.

I don't have a typical desktop use case.  The processor doesn't have any
thermal throttling.  There is also a second hwmon chip that is monitoring the
internal thermal diode of a very expensive and high power FPGA chip.

If the FPGA starts to overheat, using the interrupt will certainly give it
attention much faster than polling once per second.

Another argument for support of interrupts is the I2C overhead of polling.
The way the hwmon drivers work, polling the alarm doesn't read just one
register, it reads them all.  Some i2c adapters don't use interrupts are very
expensive, and even the ones that do usually only transfer one byte at a time.
Those that send bits manually are even worse.  Since the cost is based on the
real time constraints of the I2C protocol, as CPUs get faster the relative cost
of I2C polling goes _up_.

Polling requires the CPU (and i2c controller) to wake out of any sleep states.
That will hurt power consumption, especially when you're talking about waking
out of the deep sleeps.

The CPU won't overheat in sleep?  There are all kinds of other alarms, like
the power supply fan, or in my case, the temperature of the FPGA chip which
could easily overheat while the CPU is sleeping.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
