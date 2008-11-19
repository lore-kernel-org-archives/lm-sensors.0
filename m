From: Trent Piepho <tpiepho@freescale.com>
Date: Wed, 19 Nov 2008 09:51:08 +0000
Subject: Re: [lm-sensors] [patch 2.6.27-rc7] i2c: smbalert# support
Message-Id: <Pine.LNX.4.64.0811190140510.11673@t2.domain.actdsltmp>
List-Id: <lm-sensors.vger.kernel.org>
References: <200804161434.54335.laurentp@cse-semaphore.com>
 <200809231532.40083.david-b@pacbell.net> <20081118091546.421d6b78@hyperion.delvare>
 <200811181401.34809.david-b@pacbell.net>
In-Reply-To: <200811181401.34809.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org

On Tue, 18 Nov 2008, David Brownell wrote:
> ---
> drivers/i2c/busses/i2c-gpio.c |   10 ++
> drivers/i2c/i2c-core.c        |  155 ++++++++++++++++++++++++++++++++++++++++
> include/linux/i2c.h           |   14 +++
> 3 files changed, 179 insertions(+)

Can this be made optional?  Seeing as nothing uses it yet and it increases a
brunch of core structs' sizes.

> +	smbalert = platform_get_resource_byname(pdev, IORESOURCE_IRQ,
> +			"smbalert#");

The handler for this irq uses the name "smbus_alert", maybe the resource and
the handler should use the same name?

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
