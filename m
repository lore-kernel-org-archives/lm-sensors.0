From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:11 +0000
Subject: Third auto-fan control interface proposal
Message-Id: <20040811222616.50fe9331.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200407051449.i65Enjdq031467@zone3.gcu-squad.org>
In-Reply-To: <200407051449.i65Enjdq031467@zone3.gcu-squad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I think these should be named e.g. pwm1_auto_channels to make clear
> the distinction between a tacho input (fanX) and a pwm output (pwmX).
> 
> (/me goes off to look at 2.6 sysfs_interface doc again)
> 
> Oh dear.  I'm sorry I wasn't paying attention to this sooner, but I
> think our interface needs revision again.  All of the fan[nr]_pwm*
> files should really just be pwm[nr]*.
> 
> The association between tacho input and pwm output is arbitrary and
> depends on mainboard maker.  E.g. our script prog/pwm/pwmconfig is
> made to discover the relationships.
> 
> Would anyone object to such a patch for 2.6 kernel drivers?

I wish someone noticed that *before* I did the change the other way
around back in version 2.6.5...

I'm not sure I agree with you. Old chips clearly had PWM outputs and
tachometers unlinked, but newer chips (Analog ADM1031, SMSC LPC47M1xx,
National PC8736x) clearly assume that pwmN and fanN refer to the same
physical fan. Of course, some motherboard manufacturers will ignore that
recommendation, but they are to blame. For example, the SMSC LPC47M1xx
chips will stop monitoring fan1 when pwm1 is enabled and has a duty
cycle of 0%. Thus the driver has to force fan1 to 0 in this case. If the
manufacturer used fan1 and pwm1 for different fans, then the monitored
fan cannot be monitored anymore when the controlled fan is turned off.

Are there examples of recent chips which obviously don't consider that
pwmN and fanN are linked? For example chips having a different count of
tachometers and PWM outputs?

If fanN and pwmN match like 90% of the time and the trend is to increase
that rate even more, then changing the names again now doesn't make much
sense (IMHO). But since I am the one who broke the interface in the
first place, I guess that my opinion doesn't really matter here.

> This also seems like a good time to introduce an idea that Khali
> and I discussed on IRC some days ago, actually, a rule-of-thumb:
> 
> Any patch to the 2.6 kernel which changes/breaks some part of the
> documented sysfs interface must be accompanied by a patch to
> libsensors.  The libsensors patch must preserve backwards compat.
> to the sysfs interface as it existed in every kernel.org kernel
> from 2.6.5-rc1 to present.
> 
> I'm not suggesting we support forward-compat... nobody should
> complain if, after upgrading to a newer kernel, they are asked
> to upgrade to a newer libsensors. 
> 
> We've had sort of a honeymoon period where we could change the 2.6
> kernel interface at will, and not support older ones with our current
> libsensors.  That pissed some people off, and now that distros are
> releasing not-quite-current 2.6 kernels, it's a real PIA all around.
> So, let's declare the honeymoon over.

Agreed. If you failed to notice, I've already added the needed code in
libsensors. Basically it lets you define 2 sysfs files instead of 1 for
each symbol. Both files are tried in turn, and the operation fails if
both files are missing. I have not defined an alternate magnitude yet,
because I doubt we'll need it, but this could be added if needed.

This change in libsensors isn't exactly elegant, but the previous code
wasn't either, and it was actually less complex that I first feared.

I've already included the in0_ref <-> cpu0_vid compatibility, although
the 2.6 drivers have not been updated yet. The in0_ref name was one
other unnoticed mistake I made back in version 2.6.5 or so. And this
time I definitely agree that we can never say which "in" channel will be
used for vcore monitoring, since even on recent chips the motherboard
manufacturers don't follow the recommendations.

There's also a lm83-specific compatibility rule for critical temperature
- driver update has already been sent to Greg.

Thanks.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
