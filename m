From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 20 Oct 2010 00:50:26 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: add generic GPIO fan driver
Message-Id: <1287535826.9690.358.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101017154021.GB29120@kw.sim.vm.gnt>
	<1287330612-11256-1-git-send-email-simon@sequanux.org>
	<1287525825.9690.313.camel@groeck-laptop>
	<20101020001913.GI29120@kw.sim.vm.gnt>
In-Reply-To: <20101020001913.GI29120@kw.sim.vm.gnt>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Simon,

On Tue, 2010-10-19 at 20:19 -0400, Simon Guinot wrote:
> Hi Guenter,
> 
> On Tue, Oct 19, 2010 at 03:03:45PM -0700, Guenter Roeck wrote:
> > Hi Simon,
> > 
> > one more comment ...
> > 
> > On Sun, 2010-10-17 at 11:50 -0400, Simon Guinot wrote:
> > [ ... ]
> > > +static int __devinit
> > > +fan_alarm_init(struct gpio_fan_data *fan_data, struct gpio_fan_alarm *alarm)
> > > +{
> > 
> > __devinit and __devexit can cause problems if this driver is built into
> > the kernel, but the underlying i2c master driver is built as module.
> 
> I am not sure I understand this. Are you talking about a I2C GPIO
> expander ? or about the hwmon registration process ?

Not related to I2C specifically, since you don't use I2C. No idea why I
mentioned I2C, really. Probably because I had I2C in my mind.

Anyway, there are gpio drivers which can be loaded and unloaded. GPIO
pin(s) on one of those could point to the gpio-fan driver. If gpio-fan
is built into the kernel, but the underlying gpio driver is built as
module, loading the gpio driver might cause the gpio-fan probe function
to be called - but that function no longer exists if it is tagged as
__devinit.

Browsing through the gpio code, it seems the problem doesn't really
exist, since the above scenario does not happen (unless I am missing
something, of course). Also, other drivers using gpio calls also use
__devinit and __devexit. So just ignore what I said.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
