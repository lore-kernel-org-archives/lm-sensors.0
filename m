From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:59 +0000
Subject: Second auto pwm interface proposal
Message-Id: <20040525003305.GB23246@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040522142546.0ddb37c0.khali@linux-fr.org>
In-Reply-To: <20040522142546.0ddb37c0.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2004-05-22 14:25:46 +0200]:

<big snip>

> I wonder if this is really necessary to expose these eight registers to
> the user. I think that all the user wants to be able to configure is:
> * Temperature at which the fan starts spinning, associated PWM, and
>   associated hysteresis temperature.
> * Critical temperature, at which the fan must run at full speed.
> All in all it corresponds to what the ADM1031 has.

The w83627thf "thermal cruise" mode doesn't quite fit this model.  It
only knows these parameters:

1. target temp
2. tolerance (+/-)
3. minimum PWM (optional)

It's difficult to tell, but there is apparently no direct linear
relationship between temp and PWM.  Instead, it starts to ramp up
the PWM when the temp is > target + tolerance... it starts to ramp
down the PWM when the temp is < target - tolerance (stopping at the
minimum PWM instead of 0 if that option is enabled.)

Again, the characteristics of the PWM ramp-[up,down] are not clear
from the datasheet.  Perhaps it's some kind of PID controller, but
if so there's no way to tune it.

So, if you wanted to force that square peg into the round hole...
The difference of start temp and crit temp gets divided by 2 to
set the tolerance.  The target temp is then start temp + tolerance.

That still leaves no good way to set the H/W min PWM unless you 
add another parameter.  I do think this is a useful enough feature
to warrant it.

> Thus, I would propose that we do the same for the it87 driver. Values
> for non-exposed registers would be computed automatically using weighted
> averaging.
> 
> Does it sound OK, or is the fine grained trip points selection
> considered useful and shouldn't be dropped?

Well, I haven't answered this question at all... just reporting what
a third type of H/W looks like.  Maybe these things are dissimilar
enough that a standard interface just isn't desirable?

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
