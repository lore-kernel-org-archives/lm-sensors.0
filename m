From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Thu, 29 Nov 2012 18:51:40 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: lm73: add device tree support to LM73 driver
Message-Id: <1354215100.2574.2.camel@pizza.hi.pengutronix.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20121129181823.GA14808@roeck-us.net>
In-Reply-To: <20121129181823.GA14808@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Am Donnerstag, den 29.11.2012, 10:18 -0800 schrieb Guenter Roeck:
> On Thu, Nov 29, 2012 at 03:59:25PM +0100, Philipp Zabel wrote:
> > This patch adds device tree support to the lm73 driver. It is a
> > trivial i2c device that matches against the compatible property
> > value "national,lm73":
> > 
> >     i2c {
> >             /* ... */
> > 
> >             temperature-sensor@49 {
> >                     compatible = "national,lm73";
> >                     reg = <0x49>;
> >             };
> >     };
> > 
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> 
> Hi Philipp,
> 
> You should not need explicit dt support in the driver source.
> I have been using dt to instantiate other i2c devices without it.
> Can you try with the original driver ?
> 
> Thanks,
> Guenter

Of course you are right. Please pretend this patch never happened :)

thanks
Philipp


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
