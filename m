From: Trent Piepho <tpiepho@freescale.com>
Date: Fri, 26 Sep 2008 01:07:46 +0000
Subject: Re: [lm-sensors] [patch 2.6.27-rc7] i2c: smbalert# support
Message-Id: <Pine.LNX.4.64.0809251728130.7680@t2.domain.actdsltmp>
List-Id: <lm-sensors.vger.kernel.org>
References: <200804161434.54335.laurentp@cse-semaphore.com>
	<200805020410.44723.david-b@pacbell.net>
	<200805042256.49252.david-b@pacbell.net>
	<200809231532.40083.david-b@pacbell.net>
In-Reply-To: <200809231532.40083.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org

On Tue, 23 Sep 2008, David Brownell wrote:
> From: David Brownell <dbrownell@users.sourceforge.net>
>
>       NOTE:  it's nicest if this is edge triggered, but the code
>       should handle level triggered IRQs too.

It seems like one could miss an IRQ with edge triggered interrupts.  If a
second interrupt from another device occurs while the first is asserted, then
there won't be another edge and the second interrupt will be missed.

If all the devices on the irq are smbalerts, then maybe you are ok.  The smb
poll should let you find all alerting devices even if they didn't generate an
interrupt.  But any devices that don't support smbalert won't be found.

Level triggered interrupts don't have that problem, but it's necessary to
disable the interrupt in the irq handler until it can be acked from the work
queue, which isn't very nice if the irq is shared.

I didn't try to use smbalert.  I'm not sure if my i2c adapter supports it.  I
associated the irq with the lm63 instead of the i2c adapter and put the
handler in the lm63 driver.  The code in drivers/of/of_i2c.c will map the irq
for me and add it to board_info for the lm63.

A bigger problem is what happens while the alert continues.  The LM63 will
disable the alert irq until some code re-enables it.  At that point it will
generate a new alert irq at the next internal temperature conversion (default
16 Hz).  So when does the irq get re-enabled?  After acking it?  Then the
interrupt will be generated 16 times per second while the alert persists, is
that desirable?

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
