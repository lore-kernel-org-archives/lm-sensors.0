From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 24 Mar 2012 04:18:32 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (it87) Add support for IT8781F, IT8782F, IT8783E/F
Message-Id: <20120324041832.GA481@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1331180739-19470-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1331180739-19470-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Fri, Mar 23, 2012 at 05:17:40PM -0400, Jean Delvare wrote:
> Hi Guenter,
> 
> On Wed,  7 Mar 2012 20:25:39 -0800, Guenter Roeck wrote:
> > Assume all three are compatible and have the same functionality.
> 
> A dangerous assumption, if you ask me. The pin selection part in
> particular is tricky and I wouldn't be surprised if it differs between
> these chips. I don't think anyone asked for IT8781F or IT8782F support
> yet, so we could play it safe and ignore these chips for now?
> 

Agreed, especially since I stumbled over a datasheet for IT8782F, and it turns out
to be more closely related to IT8721F than to IT8783F.

I'll drop IT8781F and keep the other two.

[ ... ]

> > -On the IT8721F/IT8758E, some voltage inputs are internal and scaled inside
> > -the chip (in7, in8 and optionally in3). The driver handles this transparently
> > -so user-space doesn't have to care.
> > +On the IT8721F/IT8758E/IT8781F/IT8782F/IT8783E/F, some voltage inputs are
> 
> So far we used "/" to separate chip names which have the same device ID
> so they can't be differentiated by the driver. For really different
> chips we use a comma instead.
> 
> > +internal and scaled inside the chip (in7 (optional for IT8781/2/3), in8 and
> 
> I prefer when device names are spelled completely (except maybe the
> suffix) rather than shortened that way. This allows the users to grep
> quickly for their device name and find all occurrences right away.
> 
ok.

> >               else
> >                       return val * 12;
> > -     } else
> > -             return val * 16;
> > +     } else {
> > +             if (data->in_scaled & (1 << nr))
> > +                     return val * 32;
> > +             else
> > +                     return val * 16;
> > +     }
> >  }
> 
> I think both functions can then be rewritten more efficiently. I'll do
> some testing and send a patch later.
> 
I know, I was a bit lazy ;).

How about the following ?

static int adc_lsb(const struct it87_data *data)
{
	int lsb = has_12mv_adc(data) ? 12 : 16;
	if (data->in_scaled & (1 << nr))
		lsb <<= 1;
	return lsb;
}

and:
	val = DIV_ROUND_CLOSEST(val, adc_lsb(data));

and:
	return val * adc_lsb(data);

> >
> >  static inline u8 FAN_TO_REG(long rpm, int div)
> > @@ -407,7 +424,8 @@ static inline int has_16bit_fans(const struct it87_data *data)
> >           || data->type = it8718
> >           || data->type = it8720
> >           || data->type = it8721
> > -         || data->type = it8728;
> > +         || data->type = it8728
> > +         || data->type = it8783;
> >  }
> 
> As the list grows longer, it might make sense to cache the result of
> this function into struct it87_data itself. Right now it's called twice
> in it87_update_device() amongst other. Separate patch, obviously...
> 
Agreed.

> >
> >  static inline int has_old_autopwm(const struct it87_data *data)
> > @@ -1651,6 +1669,11 @@ static int __init it87_find(unsigned short *address,
> >       case IT8728F_DEVID:
> >               sio_data->type = it8728;
> >               break;
> > +     case IT8781F_DEVID:
> > +     case IT8782F_DEVID:
> > +     case IT8783E_DEVID:
> > +             sio_data->type = it8783;
> 
> I'm curious why you decided to go with a single chip type for all 3
> devices. Having separate prefixes would seem to have some value, from
> a supportability perspective is nothing else.
> 
No special reason, and it was wrong anyway since the IT8781F does not have 6 uarts
per its shortened data sheet and thus presumably does not multiplex the respective pins.
And IT8782F is all different.

I'll split it8782 and it8783 and drop IT8781F support until we get a daatasheet.

> > @@ -1686,6 +1709,54 @@ static int __init it87_find(unsigned short *address,
> >               /* The IT8705F has a different LD number for GPIO */
> >               superio_select(5);
> >               sio_data->beep_pin = superio_inb(IT87_SIO_BEEP_PIN_REG) & 0x3f;
> > +     } else if (sio_data->type = it8783) {
> > +             int reg25, reg27, reg2A, reg2C, regEF;
> > +
> > +             sio_data->skip_vid = 1; /* No VID */
> > +
> > +             superio_select(GPIO);
> > +
> > +             reg25 = superio_inb(IT87_SIO_GPIO1_REG);
> > +             reg27 = superio_inb(IT87_SIO_GPIO3_REG);
> > +             reg2A = superio_inb(IT87_SIO_PINX1_REG);
> > +             reg2C = superio_inb(IT87_SIO_PINX2_REG);
> > +             regEF = superio_inb(IT87_SIO_SPI_REG);
> > +
> > +             /* Check if fan3 is there or not */
> > +             if ((reg27 & (1 << 0)) || !(reg2C & (1 << 2)))
> > +                     sio_data->skip_fan |= (1 << 2);
> 
> I'm a bit skeptical how a single pin can be FAN_TAC3 and SIN6 at the
> same time...
> 

Issue here is that the pin is also multiplexed to VIN5 (see below), and it is
kind of difficult to determine how GP30, VIN5, FAN_TAC3, and SIN6 are selected
with only two configuration bits (one of which selects GP30). Maybe there is
another configuration bit somewhere, but I did not find it.

> > +             if ((reg25 & (1 << 4))
> > +                 || (!(reg2A & (1 << 1)) && (regEF & (1 << 0))))
> > +                     sio_data->skip_pwm |= (1 << 2);
> > +
> > +             /* Check if fan2 is there or not */
> > +             if (reg27 & (1 << 7))
> > +                     sio_data->skip_fan |= (1 << 1);
> > +             if (reg27 & (1 << 3))
> > +                     sio_data->skip_pwm |= (1 << 1);
> > +
> > +             /* VIN5 */
> > +             if ((reg27 & (1 << 0)) || (reg2C & (1 << 2)))
> > +                     ; /* No VIN5 */
> 
> Obviously we can't leave things that way. I presume we want to add a
> skip_in field to struct it87_sio_data and a has_in field to struct
> it87_data, same we have for fans? I'm fine having this as a separate
> patch, but both should go upstream together.
> 
Something like that. I'll think about it. I prefer a separate patch since
it will require quite some reshuffling of code (which is why I did not do it
in the first place). 

> > +
> > +             /* VIN6 */
> > +             if ((reg27 & (1 << 1)) || (reg2C & (1 << 2)))
> > +                     ; /* No VIN6 */
> > +
> > +             /*
> > +              * VIN7
> > +              * Does not depend on bit 2 of Reg2C, contrary to datasheet.
> 
> Datasheet is pretty confusing for this configuration bit. If the pin
> can be used for a 3rd function ("SO") there must be a extra bit to
> check somewhere... Hopefully it won't matter much as I expect vin7 to
> be internal on most systems.
> 
Same as with VIN5 ...

> > +              */
> > +             if (reg27 & (1 << 2))
> > +                     ; /* No VIN7 */
> 
> Unless vin7 is internal, in which case the test above doesn't matter.
> 
I'll add a note.

> > +
> > +             if (reg2C & (1 << 0))
> > +                     sio_data->internal |= (1 << 0);
> > +             if (reg2C & (1 << 1))
> > +                     sio_data->internal |= (1 << 1);
> > +
> > +             sio_data->beep_pin = superio_inb(IT87_SIO_BEEP_PIN_REG) & 0x3f;
> > +
> >       } else {
> >               int reg;
> >
> > @@ -1823,6 +1894,7 @@ static int __devinit it87_probe(struct platform_device *pdev)
> >               "it8720",
> >               "it8721",
> >               "it8728",
> > +             "it8783",
> >       };
> >
> >       res = platform_get_resource(pdev, IORESOURCE_IO, 0);
> > @@ -1867,6 +1939,11 @@ static int __devinit it87_probe(struct platform_device *pdev)
> >                       data->in_scaled |= (1 << 7);    /* in7 is VSB */
> >               if (sio_data->internal & (1 << 2))
> >                       data->in_scaled |= (1 << 8);    /* in8 is Vbat */
> > +     } else if (sio_data->type = it8783) {
> > +             if (sio_data->internal & (1 << 0))
> > +                     data->in_scaled |= (1 << 3);    /* in3 is VCC5V */
> > +             if (sio_data->internal & (1 << 1))
> > +                     data->in_scaled |= (1 << 7);    /* in7 is VCCH5V */
> 
> The "Features" page says that Vbat is measured internally. If this
> true, then it is necessarily always scaled too. This should let you
> merge both blocks.
> 
The IT8783F has a 16mv ADV which measures up to 4V, so scaling VBAT is not necessary.
I think the sensors output confirms that it is not scaled, unless I am missing something.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
