From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 18 Nov 2008 08:15:46 +0000
Subject: Re: [lm-sensors] [patch 2.6.27-rc7] i2c: smbalert# support
Message-Id: <20081118091546.421d6b78@hyperion.delvare>
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
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org

Hi Dave,

On Tue, 23 Sep 2008 15:32:39 -0700, David Brownell wrote:
> From: David Brownell <dbrownell@users.sourceforge.net>
> 
> Infrastructure supporting SMBALERT# interrupts and the related SMBus
> protocols.  These are defined as "optional" by the SMBus spec.
> 
>  - The i2c_adapter now includes a work_struct doing the work of talking
>    to the Alert Response Address until nobody responds any more (and
>    hence the IRQ is no longer asserted).  Follows SMBus 2.0 not 1.1;
>    there seems to be no point in trying to handle ten-bit addresses.
> 
>  - Some of the ways that work_struct could be driven:
> 
>      * Adapter driver provides an IRQ, which is bound to a handler
>        which schedules that work_struct (using keventd for now).
>        NOTE:  it's nicest if this is edge triggered, but the code
>        should handle level triggered IRQs too.
> 
>      * Adapter driver schedules that work struct itself, maybe even
>        on a workqueue of its own.  It asks the core to set it up by
>        setting i2c_adapter.do_setup_alert ... SMBALERT# could be a
>        subcase of the adapter's normal interrupt handler.  (Or, some
>        boards may want to use polling.)
> 
>  - The "i2c-gpio" driver now handles an optional named resource for
>    that SMBus alert signal.  Named since, when this is substituted
>    for a misbehaving "native" driver, positional ids should be left
>    alone.  (It might be better to put this logic into i2c core, to
>    apply whenever the i2c_adapter.dev.parent is a platform device.)
> 
>  - There's a new driver method used to report that a given device has
>    issued an alert. Its parameter includes the one bit of information
>    provided by the device in its alert response message.
> 
> The IRQ driven code path is always enabled, if it's available.
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

I guess it's about time that I review this patch and merge it. Is this
still the latest version of your code, or do you have anything more
recent?

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
