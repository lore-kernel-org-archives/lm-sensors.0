From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 24 Jun 2008 13:23:38 +0000
Subject: Re: [lm-sensors] sysfs-interface: pwm [0-100] rather than [0-255] ?
Message-Id: <20080624152338.4f3f3ae4@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <486064B5.5070704@fhmtech.com>
In-Reply-To: <486064B5.5070704@fhmtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Frank,

On Tue, 24 Jun 2008 08:39:10 -0400, Frank Myhr wrote:
> Jean Delvare wrote:
> > I see very little benefit in doing this. In fact the only benefit is
> > your point 3 above. Drawbacks are many:
> 
> > bigger drivers, higher memory usage,
> 
> A couple of extra functions... is this significant?

I agree that this should be just a couple of extra functions, and very
simple ones at that. But then you multiply this by the number of
drivers, and for run-time memory, you multiply it by the number of pwm
outputs, too.

This wouldn't be enough to stop doing it if we had a good reason to do
it and no other drawbacks. But here it sums up with the other drawbacks.

> > possible confusion between both interfaces.
> 
> Yes.

Note that I didn't only mean for the user. For the driver authors and
reviewers, it would be a possible source of confusion as well.

> > The 0-255 range for pwm values has its share of benefits. It is the
> > natural range for many chips, so it saves conversions back and forth.
> 
> lm_sensors does conversions for other attributes like rpm, pwm frequency.

The reason for these conversions is to make all drivers export the data
in a standard format. This was needed because you need to know how each
chip works to interpret the register values. For voltage inputs you
need to know the DAC resolution, for fan speeds you need to know the
frequency of the gated clock, etc. The actual unit doesn't matter much.
We could have decided to export voltages with a unit of 8 mV, fan
speeds as the time in ms needed for the fan to spin once, and
temperatures in hundredth of Kelvin. We decided for units which were as
chip-neutral as possible, with enough margin so that future chips
should fit as well (with more or less success...) For voltages and
fans, a non-trivial conversion was needed, no matter the unit, so it
made sense to go for units which were human-friendly.

For PWM that was a bit different because it was possible to handle all
chips with almost no conversions. Shifting and masking is very cheap. I
guess that's the reason why range 0-255 was chosen.

> > Other chips almost always have a 0-2^n range which can easily be mapped
> > to 0-255 with no resolution loss.
> > 
> > The 0-100 range, on the other hand, required conversions. Given that
> > only integer values can be used in sysfs, this would decrease the
> > resolution. This would be a real problem. It is frequent that only the
> > smallest pwm values are usable to control a fan, so if you can't use
> > all the available values, the granularity can become too important for
> > smooth fan speed control to be possible.
> 
> I didn't imagine that greater than 1% precision in pwm setting would
> ever be necessary. Of course the range could just as easily be [0-1000]
> or some other decimal range, as is done for voltage and temperature.

I didn't imagine 1% precision being needed either, but experience has
proven me wrong.

Going with range 0-1000 would not necessarily be more natural than
0-255. While people commonly think of duty cycles in %, per-thousand is
not commonly used in this context.

> I suppose this discussion can be summarized by stating that I prefer
> to express pwm in decimal units, whereas you prefer binary.

Actually I prefer the standard that is already established over a new
one. I'm not think of it in terms of binary vs. decimal.

> We each have
> some valid reasons (well, I have ONE at least!) for our preferences. If it
> were a new interface, I might try to continue to argue for my preference.
> But since it's already established (by you!) I'll adjust my thinking, as
> hard as that may be ;-)

It wasn't actually established by me personally. Looking at the
lm-sensors project history, the first pwm interface was implemented by
Mark S. Studebaker on March 14th, 1999, for the W83782D and W83783S
chips:
  http://www.lm-sensors.org/changeset/314
That's presumably where the de-facto standard of using a 0-255 range
was established, and we're living with it since then.

I agree that, if there was no such standard, we could discuss what the
best strategy would be. Having a human-friendly unit would have its
weight in the balance. Honestly I don't know what the decision would be.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
