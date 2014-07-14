From: Kamil Debski <k.debski@samsung.com>
Date: Mon, 14 Jul 2014 13:47:24 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: pwm-fan: Add pwm-fan driver
Message-Id: <126901cf9f6a$2503f5c0$6f0be140$%debski@samsung.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1404917600-4430-1-git-send-email-k.debski@samsung.com>
In-Reply-To: <1404917600-4430-1-git-send-email-k.debski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I forgot to address one of the comments.

> From: Guenter Roeck [mailto:groeck7@gmail.com] On Behalf Of Guenter
> Roeck
> Sent: Wednesday, July 09, 2014 6:58 PM
> To: Kamil Debski
> Cc: devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; lm-
> sensors@lm-sensors.org; t.figa@samsung.com; m.szyprowski@samsung.com
> Subject: Re: [lm-sensors] [PATCH] hwmon: pwm-fan: Add pwm-fan driver
> 
> On Wed, Jul 09, 2014 at 04:53:20PM +0200, Kamil Debski wrote:
> > The pwm-fan driver enables control of fans connected to PWM lines.
> > This driver uses the PWM framework, so it is compatible with all PWM
> > devices that provide drivers through the PWM framework.
> >
> > Signed-off-by: Kamil Debski <k.debski@samsung.com>
> > ---
> >  .../devicetree/bindings/hwmon/pwm-fan.txt          |   12 ++
> >  drivers/hwmon/Kconfig                              |    9 +
> >  drivers/hwmon/Makefile                             |    1 +
> >  drivers/hwmon/pwm-fan.c                            |  199

<snip>

> > +static int pwm_fan_remove(struct platform_device *pdev) {
> > +	struct pwm_fan_ctx *ctx = platform_get_drvdata(pdev);
> > +
> > +	pwm_disable(ctx->pwm);
> 
> Is this needed ? I don't see it used by the leds-pwm driver on cleanup.

The pwm-samsung driver does not disable the PWM channel according to my
understanding of the code. But for example the pwm-renesas-tpu does
stop the PWM timer on free. What is the correct behavior?

Is the channel should be disabled on free then I agree that pwm_disable
is not necessary.

> > +	hwmon_device_unregister(ctx->hwmon);
> > +
> > +	return 0;
> > +}
> > +

<snip>

Best wishes,
-- 
Kamil Debski
Samsung R&D Institute Poland


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
