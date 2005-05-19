From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: Second auto pwm interface proposal
Message-Id: <40B8B708.90409@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040522142546.0ddb37c0.khali@linux-fr.org>
In-Reply-To: <20040522142546.0ddb37c0.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

At Khali's urging I'm finally joining the debate.

First of all let me say that I reviewed the discussion about the ADM1030
from mid-April and found a lot to read but didn't find a precise 'proposal'.
Maybe I didn't look hard enough. 
Or is the submitted ADM1031 driver the current proposal?

But anyway, on the second proposal below, I like the idea of
keeping things relatively simple, if possible.
Let's start with something that will work across all the chips
we support (does somebody have the definitive list of smart-fan chips... this would be helpful
in reviewing proposals... is it adm1026, 1031, lm85, it87, w83627hf?).
Any standardization will inevitably leave out some chip-specific capabilities.
That's what standardization does. But that's what we have to do. Let's do it,
then we can think about what optional extensions would be required to support
additional features.

We do want to survey the field but we should look at the design decisions
companies are making and see if a consensus is forming on the way
the smart fan feature is being implemented in hardware. We should
favor recent devices such as adm1031 over older ones such as it87,
and market leaders (Nat'l, ADI) over the others.
This leads me to agree w/ Khali below about targeting the 1031
way of doing things and molding it87 to fit rather than vice versa. 

On whether we should strongly favor the existing implementations we have in it87 and lm85,
I don't think so. When those drivers were under development, we purposely
let things go their own way, as we didn't have a standard and wanted to
see what developed and see was best. Now we have a 3rd in adm1031. 
The plan has always been to come up with a standard and then change all the drivers to match.

Can somebody do a brief sysfs-interface (and/or proc-interface) document addition proposal
so we can all see clearly what the propsal is. Please include summary of how existing
interfaces (fan_min, fan_pwm, fan_pwm_enable) would change when a chip is in auto-mode.
Please identify what's required and what's optional; if optional, which driver is it for.

mds



Jean Delvare wrote:
> Hi all,
> 
> After reviewing the adm1031 and it87 drivers auto pwm interface
> implementations, I think that the auto pwm interface that was debated a
> few weeks ago could be reworked a bit.
> 
> My main motivation is that I believe that these chips (and this is
> probably true for others with the same function as well) offer complex
> possibilities most people don't care about. When first designing the
> auto pwm interface, I had in mind that it should cover everything the
> chips could do. This resulted in a complex interface with (too) many
> files.
> 
> Now I believe that the interface could be simplified to reflect the
> users needs instead. There are two different things that the user can
> configure: the trip points (pwm value, temperature value couples) and
> the fan channel/temperature channel matching. Both areas could be
> simplified.
> 
> Temperature channel selection
> -----------------------------
> 
> The interface was designed so that more than one channel can be
> associated with one given fan. I proposed that because the ADM1031 can
> do that. Question is: does the user need this? I doubt it.
> 
> The drawback of the current interface is that you never know which
> values are supported by the chip. Reading from the files is fine, it
> reflects the current state in a standard way. But writing is not, which
> makes the interface bad IMHO.
> 
> Can't we just support one channel per fan? 0 would still mean disabled,
> 1-N for the channel number. This is easier to understand for the user,
> and I'd expect it to be enough for almost all users.
> 
> Trip points
> -----------
> 
> The idea of defining trip points came from the IT87xx hardware
> implementation. The ADM1031 has a completely different approach. Let's
> have some ASCII art :)
> 
> 
> This is the ADM1031 model:
> 
>    PWM
>     ^
> 100%|                               __________
>     |                             ,'
>     |                           ,'
>     |                         ,'
>     |                       ,'
>     |                     ,'
>     |                   ,'
> min |            ____ ,'
>     |           |    |
>     |           |    |
>   0%|___________|____|
>     |
>     |----------------------------------------->temperature
>                 ^    ^              ^
>               off    min            max
> 
> (Toff = Tmin - 5, this is an hysteresis so that fan doesn't start/stop
> repeatedly it T is too near from Tmin)
> 
> All in all there are only three values that have to be defined: Tmin,
> Tmax and PWMmin. The chip computes the fan speed between Tmin and Tmax
> as a weigthed average between PWMmin and 100%.
> 
> Now, this is the IT87xx model:
> 
>    PWM
>     ^
> 100%|                                   ______
>     |                                  |
> high|                              ____|
>     |                             |
> med |                        _____|
>     |                       |
>     |                       |
> low |            ___________|
>     |           |    |
>     |           |    |
>   0%|___________|____|
>     |
>     |----------------------------------------->temperature
>                 ^    ^      ^     ^    ^
>               off   low  medium  high  full
> 
> Here, there are predefined PWM values and the chip sticks to these,
> there is no averaging done. A total of 8 values have to be set.
> 
> I wonder if this is really necessary to expose these eight registers to
> the user. I think that all the user wants to be able to configure is:
> * Temperature at which the fan starts spinning, associated PWM, and
>   associated hysteresis temperature.
> * Critical temperature, at which the fan must run at full speed.
> All in all it corresponds to what the ADM1031 has.
> 
> Thus, I would propose that we do the same for the it87 driver. Values
> for non-exposed registers would be computed automatically using weighted
> averaging.
> 
> Does it sound OK, or is the fine grained trip points selection
> considered useful and shouldn't be dropped?
> 
> Comments welcome.
> 
> Thanks.
> 
