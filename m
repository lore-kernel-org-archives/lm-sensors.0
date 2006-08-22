From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 22 Aug 2006 21:38:42 +0000
Subject: [lm-sensors] [PATCH 1/2 RESEND 2] hwmon: new vt1211 driver
Message-Id: <20060822233842.124facf3.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0605311844n3d24f429k8942ffaa15e864a8@mail.gmail.com>
In-Reply-To: <191fb4ca0605311844n3d24f429k8942ffaa15e864a8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

> > > +#define TEMP_FROM_REG(ix, val)       ((ix) = 0 ? \
> > > +                              (val) < 51 ? 0 : ((val) - 51) * 1000 : \
> > > +                              (val) * 1000)
> > > +#define TEMP_TO_REG(ix, val) ((ix) = 0 ? \
> > > +                              SENSORS_LIMIT((((val) / 1000) + 51), \
> > > +                                     0, 255) : \
> > > +                              SENSORS_LIMIT(((val) / 1000), 0, 255))
> >
> > For all other temperature channels, I'm not OK. These are
> > thermistor-based measurements with external resistors and thermistors,
> > so most scaling belongs to userspace. What we want to export here is
> > the voltage at the pins, in mV. This wasn't done correctly in the
> > Linux 2.4 driver, but in 2.6 we have a standard interface and we have
> > to respect it. This is exactly the same as for the VT8231 so the same
> > formula should work:
> >
> > #define TEMP_FROM_REG(reg)              (((253 * 4 - (reg)) * 550 + 105) / 210)
> > #define TEMP_MAXMIN_FROM_REG(reg)       (((253 - (reg)) * 2200 + 105) / 210)
> > #define TEMP_MAXMIN_TO_REG(val)         (253 - ((val) * 210 + 1100) / 2200)
> 
> OK, I don't get it. How were these formulaes derived and what are they
> supposed to do?

These temperature channels use thermistors. Physically, this means that
the chip measures a voltage at its pin. This pin is behind a voltage
divider, made of a regular resistor, and a thermistor. It is very
similar to what is used to monitor +12V, the only difference being that
one of the resistors has a value which changes with temperature.

The formula is taken from the BIOS porting guide (last page):

8-Bit Value = 253-[R9/(R10+R9)]*210

What we want to export to userspace is the voltage at the pin, which is
Vmax * (R10+R9)/R9. Vmax is the max ADC value, 2.2V for this chip. So
the formula becomes:

8-Bit Value = 253-[1/Vmax]*210

I.e.:

8-Bit Value = 253-210/Vmax

Which is TEMP_MAXMIN_TO_REG. Revert it and you get TEMP_MAXMIN_FROM_REG.

The "+105" and "+1100" are for proper rounding. The "*4" is to take the
two additional resolution bits into account.

From this voltage value we can find out the temperature in user-space,
using a simplified thermistor equation. Take a look at the vt8231
section of sensors.conf.eg for an example, the vt1211 should soon have
the same.

> > As I understand it, the default case can't happen unless the driver is
> > broken. Thus it would make sense to make this a debug message. Also,
> > please convert all these printk calls to dev_err, dev_dbg, etc. These
> > provide a uniform way to print device messages.
> 
> How do I get to &pdev->dev inside a callback?

The device is passed as the first parameter of the callback, so just
use "dev". Of course you could also do:

struct platform_device* pdev = to_platform_device(dev);
dev_dbg(&pdev->dev, "...");

But that would be a waste of time and energy as you already had dev in
the first place ;)

> > > +     case SHOW_SET_FAN_DIV:
> > > +             data->fan_div[ix] = DIV_TO_REG(val);
> > > +             vt1211_write8(data, VT1211_REG_FAN_DIV,
> > > +                           ((data->fan_div[1] << 6) |
> > > +                            (data->fan_div[0] << 4) |
> > > +                             data->fan_ctl));
> > > +             break;
> >
> > Not correct. You assume the data cache is in synch with register
> > VT1211_REG_FAN_DIV, while it may not be (e.g. if this function is
> > called before the update function ever is.) Please read the contents of
> > VT1211_REG_FAN_DIV so that you are sure you won't change bits in that
> > register.
> 
> Hmm... If this is indeed an issue then it's true in a lot of places.
> I.e., whenever a callback function modifies a value rather than
> overwrites it (e.g., data->value |= x vs data->value = y).

Yes, you are right.

> It becomes very cumbersome if I have to read the registers first in
> these cases since the mapping between the data cache and the physical
> registers isn't exactly straight forward. It's all hidden in
> vt1211_update_device and I would have to duplicate part of that logic
> in the individual callbacks, ugly. It would be easiest to just call
> vt1211_update_device rather than dev_get_drvdata but that's of course
> not very efficient.

Agreed, we have to choose between code redundancy and lack of
efficiency. In general write functions do not change too many register
values, so we go for redundancy and this is acceptable. Calling the
update_device function on register write would incur a severe
performance penalty to "sensors -s".

If there a callback in particular where you think the code redundancy
is not acceptable? I don't remember any.

> > > +	if (!(data = kzalloc(sizeof(struct vt1211_data), GFP_KERNEL))) {
> > > +		err = -ENOMEM;
> > > +		printk(KERN_ERR DRVNAME ": Out of memory\n");
> >
> > dev_err()
> 
> Is &pdev->dev already initialized at this point?

Yes. Platform devices are fully initialized as soon as you
platform_device_add() them, and the .probe function is only called after
that. so dev_err() and friends will work everywhere in the .probe
function.

Note that this is NOT true for i2c chip drivers at the moment, because
the i2c subsystem doesn't follow the device driver model and i2c
devices currently do not exist before the probe function itself
instanciate them. Hopefully we will fix that mess someday.

> > > +     val = ((superio_inb(SIO_VT1211_BADDR) << 8) |
> > > +            (superio_inb(SIO_VT1211_BADDR + 1)));
> > > +     *address = val & SIO_VT1211_BADDR_MASK;
> >
> > I see nothing in the datasheet justifying this masking.
> 
> Hmm, that mask is weird indeed. I changed it to 0xfff0 since page 27
> states that bits 7-0 are reserved (but always read 0). I don't trust
> the datasheet (it's erronous in other places too) so I keep the mask.

Bits 7-0 reserved would set the mask to 0xff00, not 0xfff0.

No objection to keeping the mask anyway, as long as it works on all
systems I'm fine.

-- 
Jean Delvare

