From: David Brownell <david-b@pacbell.net>
Date: Fri, 26 Sep 2008 02:01:59 +0000
Subject: Re: [lm-sensors] [patch 2.6.27-rc7] i2c: smbalert# support
Message-Id: <200809251902.00201.david-b@pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200804161434.54335.laurentp@cse-semaphore.com>
	<200809231532.40083.david-b@pacbell.net>
	<Pine.LNX.4.64.0809251728130.7680@t2.domain.actdsltmp>
In-Reply-To: <Pine.LNX.4.64.0809251728130.7680-3bmvVOk6DZ+DGx/iekXGtrjh7zpefjiS@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Trent Piepho <tpiepho-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org

On Thursday 25 September 2008, Trent Piepho wrote:
> On Tue, 23 Sep 2008, David Brownell wrote:
> > From: David Brownell <dbrownell@users.sourceforge.net>
> >
> >       NOTE:  it's nicest if this is edge triggered, but the code
> >       should handle level triggered IRQs too.
> 
> It seems like one could miss an IRQ with edge triggered interrupts.  If a
> second interrupt from another device

You mean, a second device pulling SMBALERT# low?  No problem.
SMB hosts must poll until no more devices respond to the Alert
Response Address -- and thus nobody will be pulling it low.

> occurs while the first is asserted, then 
> there won't be another edge and the second interrupt will be missed.

SMBALERT# is defined to be level triggered, active low.  But
it's common to have only edge-triggered IRQ lines available.
And there's an obvious equivalence between triggering once on
a falling edge, and once when the edge has completely fallen.
(And an obvious difference too, which is why "it's nicest if
this is edge triggered.")

So long that line isn't shared with device(s) not following
the SMBALERT# protcool you're fine.  By design and definition.


> If all the devices on the irq are smbalerts, then maybe you are ok. 

If the line is not obeying SMBALERT# signaling rules ... your
hardware design is deeply buggy, go and replace it.  Or at least
get them to stop claiming SMBALERT# support; they've just got
some kind of hard-to-manage shared IRQ line.


> I didn't try to use smbalert.  I'm not sure if my i2c adapter supports it.

It's not a question of the I2C adapter supporting it.  It's a
question of whether there's an SMBALERT# signal on your board,
which can generate an interrupt.  If it can, this patch has an
IRQ handler which implements the SMBus alert protocol.  Think
of it as sideband signaling ... unknown to that adapter.


> I associated the irq with the lm63 instead of the i2c adapter and put the
> handler in the lm63 driver.  The code in drivers/of/of_i2c.c will map the irq
> for me and add it to board_info for the lm63.

Which may be fine for your specific application.  But it's not
the SMBALERT# protocol, and that solution won't work when the
system requires SMBALERT#.  (I read the lm63 spec.  It's very
explicit about supporting that protocol.  There are other ways
to use its IRQ generation too.)


> A bigger problem is what happens while the alert continues.  The LM63 will
> disable the alert irq until some code re-enables it. 

That is, it disables its own generation of the alert signal.
IRQs are on the host side; the lm63 hardware can't disable them.


> At that point it will 
> generate a new alert irq at the next internal temperature conversion (default
> 16 Hz).  So when does the irq get re-enabled?  After acking it?  Then the
> interrupt will be generated 16 times per second while the alert persists, is
> that desirable?

That's your job, if you're writing an alert() handler.  It'd
probably be more intelligent not to re-enable the lm63 alert
mode until the temperature is back in spec.  The TMP75 sensor
I used was much more intelligent about that.

- Dave




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
