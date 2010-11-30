From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 30 Nov 2010 20:30:39 +0000
Subject: Re: [lm-sensors] [PATCH] adm1026: fix setting fan_div
Message-Id: <20101130213039.228bfaf8@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101130014623.GA26439@penguintown.net>
In-Reply-To: <20101130014623.GA26439@penguintown.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Phil,

On Tue, 30 Nov 2010 11:05:22 -0800, Phil Pokorny wrote:
> On Tue, Nov 30, 2010 at 1:17 AM, Jean Delvare <khali@linux-fr.org> wrote:
> > > +             mutex_lock(&data->update_lock);
> > > +             orig_div = data->fan_div[nr];
> > > +             data->fan_div[nr] = DIV_FROM_REG(new_div);
> > > +
> > > +             if (nr < 4) { /* 0 <= nr < 4 */
> > > +                     adm1026_write_value(client, ADM1026_REG_FAN_DIV_0_3,
> > > +                                 (DIV_TO_REG(data->fan_div[0]) << 0) |
> > > +                                 (DIV_TO_REG(data->fan_div[1]) << 2) |
> > > +                                 (DIV_TO_REG(data->fan_div[2]) << 4) |
> > > +                                 (DIV_TO_REG(data->fan_div[3]) << 6) );
> > > +             } else { /* 3 < nr < 8 */
> > > +                     adm1026_write_value(client, ADM1026_REG_FAN_DIV_4_7,
> > > +                                 (DIV_TO_REG(data->fan_div[4]) << 0) |
> > > +                                 (DIV_TO_REG(data->fan_div[5]) << 2) |
> > > +                                 (DIV_TO_REG(data->fan_div[6]) << 4) |
> > > +                                 (DIV_TO_REG(data->fan_div[7]) << 6) );
> > > +             }
> >
> > Note: this is horribly inefficient. In my opinion, data->fan_div should
> > hold split but un-decoded register values. Calling DIV_FROM_REG() is
> > cheap, calling DIV_TO_REG() is expensive. In fact DIV_TO_REG()
> > shouldn't exist in the first place, as the conversion should happen in
> > a single place. Again, this is material for a separate patch.
>
> I humbly suggest that you are forgetting something.  With your
> recommendation, the REG_TO_DIV function would be called many orders of
> magnitute more times (thousands? millions?) than the DIV_TO_REG function
> here.  REG_TO_DIV would have to be called every time the fan speed is _read_
> but DIV_TO_REG only needs to be called the one or two times that the fan_div
> is _written_  So while the macros might differ in complexity, the number of
> times they are called swamps any economy gained by changing the fan_div from
> divisor to register value.

You are right on one thing. In all honesty, I had forgotten that
DIV_FROM_REG() would not only get called for fanX_div sysfs attributes
but also for fanX_input and fanX_min attributes, which are obviously
called repeatedly by monitoring applications, so their performance
matters.

And I agree with you that calling DIV_FROM_REG() in show_fan() and
show_fan_min() - or even directly in FAN_FROM_REG() - would be costly.

However, we are allowed to be smart (at least I hope so!) Converting
the divisor register value (0 to 3) into an actual scaling factor (1,
2, 4 or 8) to divide or multiply by is inefficient. It's much better to
use the register value directly to bit-shift the fan input value or
limit value. Concretely, this means that, if data->fan_div[nr] contains
a split register value, you don't want to do:

#define FAN_FROM_REG(val, div) ((val) = 0 ? -1 : (val) = 0xff ? 0 : \
				1350000 / ((val) * DIV_FROM_REG(div)))

but:

#define FAN_FROM_REG(val, div) ((val) = 0 ? -1 : (val) = 0xff ? 0 : \
				1350000 / ((val) << (div)))

And the same holds for FAN_TO_REG(). In the end, DIV_FROM_REG() could
only be called from show_fan_div(), and DIV_TO_REG only called once
from set_fan_div() - so we could in fact get rid of both macros.

> The code above is clear in and appropriate in my opinion.

The code above is good enough and has the merit of not being too
intrusive. But I still claim that my counter-proposal would make the code
cleaner and more efficient... in a future kernel version.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
