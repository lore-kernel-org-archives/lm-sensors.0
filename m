From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 12 Aug 2010 18:31:21 +0000
Subject: Re: [lm-sensors] [PATCH 3/6] hwmon: (pc87427) Add support for
Message-Id: <20100812203121.4907714f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100811171059.4fb5813f@hyperion.delvare>
In-Reply-To: <20100811171059.4fb5813f@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 12 Aug 2010 10:16:09 -0700, Guenter Roeck wrote:
> On Wed, 2010-08-11 at 11:10 -0400, Jean Delvare wrote:
> > Add initial support for PWM outputs of the PC87427 Super-I/O chip.
> > Only mode change and manual fan speed control are supported. Automatic
> > mode configuration isn't supported, and won't be until at least one
> > board is known, which makes uses of the PWM outputs.
> > 
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> 
> Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>
> 
> Minor question inline.
> 
> > (...)
> > @@ -188,6 +196,61 @@ static inline u16 fan_to_reg(unsigned lo
> >  }
> > 
> >  /*
> > + * PWM registers and conversions
> > + */
> > +
> > +#define PC87427_REG_PWM_ENABLE         0x10
> > +#define PC87427_REG_PWM_DUTY           0x12
> > +
> > +#define PWM_ENABLE_MODE_MASK           (7 << 4)
> > +#define PWM_ENABLE_CTLEN               (1 << 0)
> > +
> > +#define PWM_MODE_MANUAL                        (0 << 4)
> > +#define PWM_MODE_AUTO                  (1 << 4)
> > +#define PWM_MODE_OFF                   (2 << 4)
> > +#define PWM_MODE_ON                    (7 << 4)
> 
> Just wondering ... ON is 0x01110000, not 0x01000000 ?

Yes.

> No problem with it, only that the OFF overlaps the ON bit which seems a
> bit odd.

This isn't a bitfield, this is a 3-bit value (as can be deduced from
PWM_ENABLE_MODE_MASK.) No idea why they left values 3 to 6 unused,
instead of simply going for a 2-bit value.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
