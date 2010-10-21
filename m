From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 21 Oct 2010 14:43:46 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: add generic GPIO fan driver
Message-Id: <20101021144346.GA26460@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1287592646-18109-1-git-send-email-sguinot@lacie.com>
	<1287592646-18109-2-git-send-email-sguinot@lacie.com>
	<20101021064145.GA25095@ericsson.com>
	<20101021140626.GQ29120@kw.sim.vm.gnt>
In-Reply-To: <20101021140626.GQ29120@kw.sim.vm.gnt>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Simon,

On Thu, Oct 21, 2010 at 10:06:27AM -0400, Simon Guinot wrote:

[ ... ]
> > > 
> > > +config SENSORS_GPIO_FAN
> > > +       tristate "GPIO fan"
> > > +       depends on GENERIC_GPIO
> > > +       help
> > > +         If you say yes here you get support for the GPIO connected fan.
> > > +
> > 
> > "for GPIO connected fans.". Can be more than one.
> 
> My bad English...
> 
> > 
> > > +         This driver can also be built as a module.  If so, the module
> > > +         will be called gpio-fan.
> > > +
> > >  config SENSORS_G760A
> > >         tristate "GMT G760A"
> > >         depends on I2C
> > > diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> > > index e3c2484..5df7e4a 100644
> > > --- a/drivers/hwmon/Makefile
> > > +++ b/drivers/hwmon/Makefile
> > > @@ -48,6 +48,7 @@ obj-$(CONFIG_SENSORS_F71805F) += f71805f.o
> > >  obj-$(CONFIG_SENSORS_F71882FG) += f71882fg.o
> > >  obj-$(CONFIG_SENSORS_F75375S)  += f75375s.o
> > >  obj-$(CONFIG_SENSORS_FSCHMD)   += fschmd.o
> > > +obj-$(CONFIG_SENSORS_GPIO_FAN) += gpio-fan.o
> > 
> > "gp" is alphabetically after "g7". Please move.
> 
> It was the original place...
> 
> Ok, I have been confused with the Kconfig "sequence" order: put
> SENSORS_GPIO_FAN before SENSORS_G760A seems wrong to me.
> 
Which is why I asked you to move it in Makefile.

> Why we don't have to respect the alphabetical order for Kconfig ?
> 
Oh, we should. I just didn't notice that it is out of order in Kconfig
as well. So please move the definition there as well.

[ ... ]

> > 
> > Would it make more sense to return the closest rpm instead ?
> > 
> > For example, if one sets a value of 1900, and the closest value
> > in the table is 1800, it might make more sense to set the speed
> > to 1800 and not to, say, 3000, if that is the next value.
> 
> On the other hand, you can set rpm to 500 and the closest value could be
> 0 and the fan stop (or don't start). That's a disturbing experience.
> If you agree, I prefer to set the upper speed.
> 
Ok.

> > 
> > No strong opinion, though. One might as well argue that it is safer
> > to run at the higher speed.
> > 
> 
> Some fans have problems with the low speeds and needs a little boost to
> start up.
> 
Ok. Not sure if rounding up really helps there, though.

> > 
> > The combination of DIV_ROUND_UP() and DIV_ROUND_CLOSEST() causes inconsistency.
> > 
> > Assume num_speed = 8, pwm is set to 128.
> > 
> > set: 128 * (8 - 1) / 255 = 3.513 => 4
> > get: 4 * 255 / (8 - 1) = 145.7 => 146
> > set: 146 * (8 - 1) / 255 = 4.007 => 5
> > get: 5 * 255 / (8 - 1) = 182.142 => 182
> > set: 182 * (8 - 1) / 255 = 4.996 => 5
> > 
> > Unless there is a really good reason to use DIV_ROUND_UP(), you might
> > want to use DIV_ROUND_CLOSEST() instead.
> 
> This choice is coherent with the rpm interface one and the reason is the
> same: start the fan even with a low value. In your example, 36 is first
> speed threshold.
> 
Yes, but here it causes an inconsistency between setting and reporting.
I don't expect the speed to change if I set the same value that was read.
Exactly this happens if one writes 146 in my example. That is much worse
than a potential startup problem, or the observation that pwm values below X 
don't start the fan.

Besides, one can set min and max values for pwm in fancontrol to avoid
the startup problem.

Thanks,

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
