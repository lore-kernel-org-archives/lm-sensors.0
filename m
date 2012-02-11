From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 11 Feb 2012 00:12:08 +0000
Subject: Re: [lm-sensors] [RFC] (F75387) How expose automatic fan control in sysfs?
Message-Id: <20120211011208.3da858a6@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120209222304.GA28989@luigi.zusammrottung.local>
In-Reply-To: <20120209222304.GA28989@luigi.zusammrottung.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 10 Feb 2012 23:56:07 +0100, Nikolaus Schulz wrote:
> On Fri, Feb 10, 2012 at 09:05:19AM +0100, Jean Delvare wrote:
> > [...] if what your chip does is multiple RPM targets based on the
> > temperature, i.e. a mix of temperature trip points mode and fan speed
> > target mode, then indeed our sysfs interface is lacking standard file
> > names for this
> 
> Yes, this is what the F75387 does in closed loop mode.  All fan target
> values are then specified in RPM, not PWM, including the
> temperature-bounded for automatic fan control.
> 
> > (I can't remember another chip supporting this.)
> 
> Apparently the F71805F does this, and it is supported by the hwmon
> driver.  This driver uses the sysfs filenames pwm*_auto_point*_fan.

Wow. This is my driver, I didn't write this part of the code but I
signed than patch so I must have reviewed it, and I did not remember it
at all.

> > Following the other attribute names, the proper name could be
> > pwm[1-*]_auto_point[1-*]_fan_target.
> 
> That sounds better and more consistent than the name chosen for the
> f71805f.

What is bad is that the name used in the f71805f driver isn't part of
the standard. Changing it now would be worse. Using a different name in
your driver would be even worse. So you may not like it, but using it
would be preferred. And documenting it, this time.

> I am not very happy about using the pwm* prefix, since the fan speed
> need not be driven using PWM at all.  This issue alone probably doesn't
> warrant coming up with a more abstract naming scheme; unfortunately
> there are more.  But still, until such a scheme exists, I'll stick to
> your proposal.

"pwm" in all attribute names really mean "fan control". I agree it can
be confusing and was a design mistake in the first place. At least I'm
not to blame this time.

> > (...)
> > One (now) very obvious mistake I made back then is that I did not
> > abstract the fan speed controller units from PWM outputs.
> 
> Right, that's exactly my remaining unhappiness above was about.
> 
> Let me add two more things.
> 
> First, I doubt that it's a good idea to put the fan*_target value into
> the fan domain.  After all, this value is about fan *control*, not about
> fan state, which I think suggests it might better reside in the pwm
> domain (that is, the domain of the fan controller).  This is emphasized
> by having fan*_target in the fan domain, and pwm*_auto_point*_fan_target
> in the pwm domain, as you suggested above.  One domain should win here,
> and I think it should be the latter.

You're right. fan[1-*]_target was my idea (if I remember correctly) and
shows that I did not notice that "target speed control mode" was a
degenerated case of "closed-loop temperature trip point driven control
mode". OTOH it isn't always clear if we want to represent degenerated
cases differently to present a more simple interface to the user, or
not to keep things as consistent as possible. No doubt that this is
something we will have to revisit if/when designing a brand new
interface.

> Second, the F75387 draws a distinction between the actual (PWM or DAC)
> output value and the configured target value.  The current definition of
> pwm*, on the other hand, not only encodes the steering method (PWM), but
> also mixes target value and actual value.  Does it make sense to keep
> these values separate in sysfs?

How could the actual PWM duty cycle ever differ from the desired one? I
don't get it.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
