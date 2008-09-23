From: David Brownell <david-b@pacbell.net>
Date: Tue, 23 Sep 2008 23:02:51 +0000
Subject: Re: [lm-sensors] Sensor chip interrupt
Message-Id: <200809231602.51867.david-b@pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.64.0809171500190.3610@t2.domain.actdsltmp>
In-Reply-To: <Pine.LNX.4.64.0809171500190.3610@t2.domain.actdsltmp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

In http://marc.info/?t2169327700002&r=1&w=2 I noticed this thread...

Trent Piepho replied to Mark Hoffman:
>
> > 1) It may be more efficient, but for this class of hardware the
> > difference is not meaningful.  By "this class" I mean processor and main
> > board temp and voltage sensors, where the measurements are not expected
> > to fluctuate wildly.  Modern processors will throttle down in response to
> > over- temp situations all by themselves, so the hwmon drivers do not need
> > to react any faster than 1 second even.  The hwmon drivers are not
> > intended for real-time or safety critical usage, nor do they need to be.
>
> I don't have a typical desktop use case.  The processor doesn't have any
> thermal throttling.  There is also a second hwmon chip that is monitoring
> the internal thermal diode of a very expensive and high power FPGA chip.

Plus I happen to think that limiting the Linux hwmon framework to
hardware which pretty much doesn't need sensor monitoring seems
kind of the wrong idea.  One monitors in order to control, but if
the hardware controls itself there's little point in monitoring.

We've got a hwmon framework, and rather than expecting something new
to address slightly less common hardware monitoring requirements
(like the "industrial I/O" stuff, which has plenty of other work to
do getting things like reusable accelerometer models) ... I think it
would make more sense to fill in a few of the obvious gaps in hwmon.
It'd help to avoid reinventing wheels.

Being unable to use the existing framework for quicker feedback
loops (milliseconds not seconds), even when the hardware support for
them is available, seems like such a gap to me.  I've just resent
my SMBALERT# support patch, which helps address part of that little
problem, within the kernel.  It should be usable with LM63 sensors;
I last tested it with a two different alerting devices sharing the
same SMBALERT# signal, and it worked fine.

I think the approach of notifying userspace via sysfs_notify() or
other standard tools is appropriate ... but suspect some work on
tools will be needed to get past the current polling models.

- Dave


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
