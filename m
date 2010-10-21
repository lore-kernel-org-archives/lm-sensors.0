From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 21 Oct 2010 20:26:38 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: add generic GPIO fan driver
Message-Id: <20101021202638.GA27794@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101017154021.GB29120@kw.sim.vm.gnt>
	<1287330612-11256-1-git-send-email-simon@sequanux.org>
	<20101018160830.GB9033@ericsson.com>
	<20101021200710.GR29120@kw.sim.vm.gnt>
In-Reply-To: <20101021200710.GR29120@kw.sim.vm.gnt>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Simon,

On Thu, Oct 21, 2010 at 04:07:10PM -0400, Simon Guinot wrote:
[ ... ]

> > > @@ -399,6 +399,15 @@ config SENSORS_GL520SM
> > >           This driver can also be built as a module.  If so, the module
> > >           will be called gl520sm.
> > > 
> > > +config SENSORS_GPIO_FAN
> > > +       tristate "GPIO fan"
> > > +       depends on GENERIC_GPIO
> > > +       help
> > > +         If you say yes here you get support for the GPIO connected fan.
> > > +
> > > +         This driver can also be built as a module.  If so, the module
> > > +         will be called gpio-fan.
> > > +
> > 
> > Can you move this up a bit, ahead of SENSORS_FSCHMD ? Trying to stay in sequence.
> 
> Ok. Let's try to figure out where is the right location :)
> After SENSORS_GL520SM or not ?
> 

My brain must have told me that "G" comes before "F". Or so. ABCDEGF, isn't it ?

After SENSORS_GL520SM. Sorry. Or whereever it fits in the alphabet,
if I got that wrong again ;).

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
