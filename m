From: Trent Piepho <tpiepho@freescale.com>
Date: Sat, 27 Sep 2008 00:29:54 +0000
Subject: Re: [lm-sensors] [patch 2.6.27-rc7] i2c: smbalert# support
Message-Id: <Pine.LNX.4.64.0809261652040.7680@t2.domain.actdsltmp>
List-Id: <lm-sensors.vger.kernel.org>
References: <200804161434.54335.laurentp@cse-semaphore.com>
	<200809231532.40083.david-b@pacbell.net>
	<Pine.LNX.4.64.0809251728130.7680@t2.domain.actdsltmp>
	<200809251902.00201.david-b@pacbell.net>
In-Reply-To: <200809251902.00201.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org

On Thu, 25 Sep 2008, David Brownell wrote:
>> If all the devices on the irq are smbalerts, then maybe you are ok.
>
> If the line is not obeying SMBALERT# signaling rules ... your
> hardware design is deeply buggy, go and replace it.  Or at least
> get them to stop claiming SMBALERT# support; they've just got
> some kind of hard-to-manage shared IRQ line.

CPUs only have so many IRQ lines.  It might be necessary to share the hwmon's
irq line with some other device.  It seems like it should be possible to do
safely if the irq is level triggered.  The irq needs to be disabled in the
lm63/smbalert irq handler and re-enabled when the hwmon's signal (if it was
the interrupting device) has been turned off.  Which means the other device's
irq will be disabled during this time as well, which isn't very nice but if
it's something like an ethernet phy is probably not a problem.

>> I didn't try to use smbalert.  I'm not sure if my i2c adapter supports it.
>
> It's not a question of the I2C adapter supporting it.  It's a
> question of whether there's an SMBALERT# signal on your board,
> which can generate an interrupt.  If it can, this patch has an
> IRQ handler which implements the SMBus alert protocol.  Think
> of it as sideband signaling ... unknown to that adapter.

If nothing is alerting, then the read from the ARA address won't get an ack. 
Some i2c adapters don't handle this so well.

I've got two hwmon chips sharing an IRQ line, but they are on different
adapters (the lm63 only has one address).  It could be a problem if one
adapter's handler re-enabled a level triggered irq before the other handler
has run.  It should be ok if the other handle has started by not finished
since the disabled irqs should stack.  If the irq is edge triggered
the one could get lost:
chip1 (or random other thing on irq) generates irq
adapter2's handler runs, gets no ARA respons
chip2 alerts, line still low so no edge and no irq
adapter1's handler runs, gets chip1's ARA response
chip1 releases irq, but chip2 is still holding it low
Now the irq is wedged.

>> At that point it will
>> generate a new alert irq at the next internal temperature conversion (default
>> 16 Hz).  So when does the irq get re-enabled?  After acking it?  Then the
>> interrupt will be generated 16 times per second while the alert persists, is
>> that desirable?
>
> That's your job, if you're writing an alert() handler.  It'd
> probably be more intelligent not to re-enable the lm63 alert
> mode until the temperature is back in spec.  The TMP75 sensor
> I used was much more intelligent about that.

I guess that was more of an RFC for how userspace notification of alert irqs
should work.  Is it ok if sysfs_notify() keeps getting called while the alert
persists, or should it open happen when the alert changes?  The latter
probably makes the most sense.  Harder to do, as the lm63 doesn't produce an
"alarm stopped" signal.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
