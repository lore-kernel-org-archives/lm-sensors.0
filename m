From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 01 Dec 2010 08:55:17 +0000
Subject: Re: [lm-sensors] [PATCH] adm1026: fix setting fan_div
Message-Id: <20101201095517.56bceb8b@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101130014623.GA26439@penguintown.net>
In-Reply-To: <20101130014623.GA26439@penguintown.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Phil,

On Tue, 30 Nov 2010 18:46:49 -0800, Phil Pokorny wrote:
> On Tue, Nov 30, 2010 at 12:30 PM, Jean Delvare <khali@linux-fr.org> wrote:
> > You are right on one thing. In all honesty, I had forgotten that
> > DIV_FROM_REG() would not only get called for fanX_div sysfs attributes
> > but also for fanX_input and fanX_min attributes, which are obviously
> > called repeatedly by monitoring applications, so their performance
> > matters.
> >
> > And I agree with you that calling DIV_FROM_REG() in show_fan() and
> > show_fan_min() - or even directly in FAN_FROM_REG() - would be costly.
> >
> > However, we are allowed to be smart (at least I hope so!) Converting
> > the divisor register value (0 to 3) into an actual scaling factor (1,
> > 2, 4 or 8) to divide or multiply by is inefficient. It's much better to
> > use the register value directly to bit-shift the fan input value or
> > limit value. Concretely, this means that, if data->fan_div[nr] contains
> > a split register value, you don't want to do:
> >
> > #define FAN_FROM_REG(val, div) ((val) = 0 ? -1 : (val) = 0xff ? 0 : \
> >                                1350000 / ((val) * DIV_FROM_REG(div)))
> >
> > but:
> >
> > #define FAN_FROM_REG(val, div) ((val) = 0 ? -1 : (val) = 0xff ? 0 : \
> >                                1350000 / ((val) << (div)))
> >
> > And the same holds for FAN_TO_REG(). In the end, DIV_FROM_REG() could
> > only be called from show_fan_div(), and DIV_TO_REG only called once
> > from set_fan_div() - so we could in fact get rid of both macros.
> 
> Hmm.  That's creative...
> 
> However, the optimization comes at the expense of generality.  This
> alternative only allows for power of 2 fan divisors.  This hardware only
> supports powers of 2, and probably all other chips are the same.  But other
> hardware might support other divisors.  Is there an advantage to having
> similar or identical FAN_FROM_REG macros across multiple chips?

No advantage that I can see. The available divisor values and their
respective encoding is device-specific. See for example the FSC
devices which only support divisors 2, 4 and 8, or fan3_div of old
IT87xxF devices which can only be set to 2 or 8 and is encoded on a
single bit.

We could still have a common function or macro for the two most common
cases (divisors being powers of 2 starting from 1 and encoded on 2 or 3
bits), but we could have done this years ago and nobody did, so it's
not obviously needed. Furthermore, in the case of powers of 2, as I just
explained, it's as easy and presumably cheaper to manipulate the raw
register values, so the need for conversion macros vanishes.
 
> Also, it's not necessarily a given that shifts are faster than multiplies.
> Integer multipliers can be faster than shifts if a CPU doesn't include a
> barrel shifter than can perform arbitrary shifts, but does them with the
> equivalent of a loop.  I think the Pentium PRO? had this issue.  It was
> mentioned during the AES design bakeoffs that multi-bit shifts could be
> expensive on some architectures.  Of course the first SPARC chips were
> notable for _not_ having an integer multiply instruction.

Obviously we depend on the actual CPU implementation, but at least on
recent x86 CPUs (and these are the main target for generic hardware
monitoring drivers such as the adm1026 driver in my experience)
shifting is somewhat faster than multiplying and much faster than
dividing.

But this is going deeper in the details than I originally wanted. My
main point was that my approach was replacing a single operation in the
hot path by another single operation, and not by a complex function or
macro call as you could fear.

> In this case, it seems like a multiplication is the appropriate operator for
> a "fan divisor" value.  Let the compiler choose the best code.

I don't think the compiler can optimize anything for us. Only constant
power-of-2 multiplications and divisions can be converted to shifts by
the compiler. We developers know that we only deal with powers of 2,
but as these aren't constants, I can't see how the compiler would know.

> And your alternative is still clever.

Not sure if this is a compliment or criticism ;)

> > The code above is good enough and has the merit of not being too
> > intrusive. But I still claim that my counter-proposal would make the code
> > cleaner and more efficient... in a future kernel version.
> 
> I would suggest that such a patch should change the name of "fan_div" to
> "fan_div_shift" or "fan_shift" since it's not a divisor.  However, I
> recognize that other drivers (Winbond family...) store a "register" shift
> value in fan_div...

This is an implementation detail. I'd be fine with "fan_div" as a
reference to the register name. What really matters IMO is that the
contents of the data structure members is properly documented in the
structure definition.

> But I think we've wandered far from the original issue of broken code that
> clobbered all the fan divisors when setting any one.

Definitely. I'm sorry I can't resist criticizing code I feel could be
optimized ;) Fixing the actual bugs with minimal patches is way more
important at the moment, I fully agree.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
