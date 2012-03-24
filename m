From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 24 Mar 2012 08:37:44 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (it87) Add support for IT8781F, IT8782F, IT8783E/F
Message-Id: <20120324093744.49cb5983@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1331180739-19470-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1331180739-19470-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 23 Mar 2012 21:18:32 -0700, Guenter Roeck wrote:
> On Fri, Mar 23, 2012 at 05:17:40PM -0400, Jean Delvare wrote:
> > On Wed,  7 Mar 2012 20:25:39 -0800, Guenter Roeck wrote:
> > >               else
> > >                       return val * 12;
> > > -     } else
> > > -             return val * 16;
> > > +     } else {
> > > +             if (data->in_scaled & (1 << nr))
> > > +                     return val * 32;
> > > +             else
> > > +                     return val * 16;
> > > +     }
> > >  }
> > 
> > I think both functions can then be rewritten more efficiently. I'll do
> > some testing and send a patch later.
>
> I know, I was a bit lazy ;).
> 
> How about the following ?
> 
> static int adc_lsb(const struct it87_data *data)
> {
> 	int lsb = has_12mv_adc(data) ? 12 : 16;
> 	if (data->in_scaled & (1 << nr))
> 		lsb <<= 1;
> 	return lsb;
> }
> 
> and:
> 	val = DIV_ROUND_CLOSEST(val, adc_lsb(data));
> 
> and:
> 	return val * adc_lsb(data);

Except that you have to pass nr around as a parameter, but otherwise
yes, that's what I had in mind.

> > > +             /* Check if fan3 is there or not */
> > > +             if ((reg27 & (1 << 0)) || !(reg2C & (1 << 2)))
> > > +                     sio_data->skip_fan |= (1 << 2);
> > 
> > I'm a bit skeptical how a single pin can be FAN_TAC3 and SIN6 at the
> > same time...
> 
> Issue here is that the pin is also multiplexed to VIN5 (see below), and it is
> kind of difficult to determine how GP30, VIN5, FAN_TAC3, and SIN6 are selected
> with only two configuration bits (one of which selects GP30). Maybe there is
> another configuration bit somewhere, but I did not find it.

Neither did I. I think the datasheet is incomplete.

> > > (...)
> > > @@ -1867,6 +1939,11 @@ static int __devinit it87_probe(struct platform_device *pdev)
> > >                       data->in_scaled |= (1 << 7);    /* in7 is VSB */
> > >               if (sio_data->internal & (1 << 2))
> > >                       data->in_scaled |= (1 << 8);    /* in8 is Vbat */
> > > +     } else if (sio_data->type = it8783) {
> > > +             if (sio_data->internal & (1 << 0))
> > > +                     data->in_scaled |= (1 << 3);    /* in3 is VCC5V */
> > > +             if (sio_data->internal & (1 << 1))
> > > +                     data->in_scaled |= (1 << 7);    /* in7 is VCCH5V */
> > 
> > The "Features" page says that Vbat is measured internally. If this
> > true, then it is necessarily always scaled too. This should let you
> > merge both blocks.
>
> The IT8783F has a 16mv ADV which measures up to 4V, so scaling VBAT is not necessary.
> I think the sensors output confirms that it is not scaled, unless I am missing something.

Oh, you're completely right, I had forgotten about the different LSB
value, sorry.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
