From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:20 +0000
Subject: adm1026 driver port for kernel 2.6.X
Message-Id: <20041025223958.5cfdb5ef.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041018210758.GB14960@penguincomputing.com>
In-Reply-To: <20041018210758.GB14960@penguincomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > BTW, how are pwm1 and pwm2 (aka DAC) linked? if pwm1 and pwm2
> > correspond to the same output, shouldn't they be a single pwm file?
> 
> You can have one or the other, but not both.  And since all
> PWM/DAC-controlled fans are driven by no more than one output at a
> time, providing access to both seems even less useful.

This convinces me that we need a single pwm file then.

> But I see your point.  If we keep the DAC output as well as the PWM
> output in the interface, there really is no reason to provide separate
> pwm1_* and pwm2_* entries, since only one can operate at a time.  Then
> we would need to replace
> 
> pwm[1-2]_enable, {0,1,2}
> 
> with a single file such as:
> 
> pwm_enable, {0,1,2,3,4}
> 
> where:
> 
> 0 -> no fan control, fans set @ full speed
> 1 -> manual PWM fan control
> 2 -> manual DAC fan control
> 3 -> automatic PWM fan control
> 4 -> automatic DAC fan control

This won't be allowed since value 2 is standardized as auto mode. You
could default to PWM and allow the used to switch to DAC, or provide a
non-standard file to switch from PWM to DAC and back (pwm1_mode?)

> > Should be scaled so that this max value matches the max pwm value
> > (around 250).
> 
> Ugh.  Is this really a good idea?  Is scaling pwnN_auto_pwm_min so
> that it matches pwmN worth:
> 
> (A)  Obscuring the actual granularity of pwmN_auto_pwm_min

We don't much care about the granularity. All measured values are
reported in a fixed unit (mV...) regardless of the chip. This is the
only way to provide a unified interface where the user (or user-space
application) doesn't need to know anything about the chip.

The granularity issue and the rounding errors are really not a problem.
Noone can differenciate between 80% and 82% duty cycle anyway.

The ultimate goal is that the user can echo 192 to the pwm file and get
around 75% duty cycle regardless of the chip.

> (B)  Introducing "best fit" functions/macros to scale {0-255} =>
> {0-15}.

Converting from 0-15 to 0-255 is easy and lossless (X << 4 + X, X >> 4).

> Especially since the PWM := PWM(PWM_min) equation actually just
> generates values in the {0-100} range.  Which granularity level should
> we respect?{0-255}? {0-100}? {0-15}?

0-255. Think standard.

> Is pwmN_auto_pwm_min using a different scale than pwmN any more
> confusing when compared to the effect that the "invisible" granularity
> a pwmN_auto_pwm_min scaled {0-255} or {0-100} will have?

pwmN_auto_* files have to be consistent with pwmN values of course.

> Moreover, if we are to keep the DAC as a 2nd "PWM" output, then
> shouldn't its pwmN_auto_pwm_min scale {0-240}, rather than {0-255}?

I admit I don't really care about 0-240 vs 0-255. I think we have
drivers doing both. Since the underlying hardware only knows of 16 steps
anyway, this doesn't make much difference. 255 is the standard though ;)

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
