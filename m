From: Nikolaus Schulz <mail@microschulz.de>
Date: Fri, 10 Feb 2012 22:56:07 +0000
Subject: Re: [lm-sensors] [RFC] (F75387) How expose automatic fan control in sysfs?
Message-Id: <20120210225607.GA13380@luigi.zusammrottung.local>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120209222304.GA28989@luigi.zusammrottung.local>
In-Reply-To: <20120209222304.GA28989@luigi.zusammrottung.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Feb 10, 2012 at 09:05:19AM +0100, Jean Delvare wrote:
> On Thu, 9 Feb 2012 23:54:52 +0100, Nikolaus Schulz wrote:
> > On Thu, Feb 09, 2012 at 02:34:54PM -0800, Guenter Roeck wrote:
> > > On Thu, 2012-02-09 at 17:23 -0500, Nikolaus Schulz wrote:
> > > > The F75387 fan control chip configuration can be fully switched between
> > > > open loop mode, where it is programmed with raw PWM values, and closed
> > > > loop mode, where one specifies desired RPM fan speeds instead.
> > > > 
> > > > However, both modes use the same configuration input registers.
> > > > 
> > > > The lm-sensors standard sysfs interface defines that RPM target values
> > > > should be exposed using filenames fan*_target, and PWM values via pwm*.
> > > > For automatic, temperature-bounded fan control values, only
> > > > pwm*_auto_point*_pwm files are defined.
> > > > 
> > > > Now I wonder, what is the best way to expose the configuration for the
> > > > F75387 in sysfs?
> > > > 
> > > > Trying to match the standard sysfs interface makes me think I need to
> > > > expose different files in sysfs, depending on the mode.  That is, pwm*
> > > > and pwm*_auto_point*_pwm for open loop mode, and for closed loop mode
> > > > fan*_target and, hmm, I guess ${TYPE}*_auto_point*_fan where I'm not
> > > > sure what to put into $TYPE...  Any suggestions for $TYPE?

[...]

> [...] if what your chip does is multiple RPM targets based on the
> temperature, i.e. a mix of temperature trip points mode and fan speed
> target mode, then indeed our sysfs interface is lacking standard file
> names for this

Yes, this is what the F75387 does in closed loop mode.  All fan target
values are then specified in RPM, not PWM, including the
temperature-bounded for automatic fan control.

> (I can't remember another chip supporting this.)

Apparently the F71805F does this, and it is supported by the hwmon
driver.  This driver uses the sysfs filenames pwm*_auto_point*_fan.

> Following the other attribute names, the proper name could be
> pwm[1-*]_auto_point[1-*]_fan_target.

That sounds better and more consistent than the name chosen for the
f71805f.

I am not very happy about using the pwm* prefix, since the fan speed
need not be driven using PWM at all.  This issue alone probably doesn't
warrant coming up with a more abstract naming scheme; unfortunately
there are more.  But still, until such a scheme exists, I'll stick to
your proposal.

> I hope I replied to your question.

You did, at least the part about the file naming, thanks. :)

> > > Maybe Jean has an idea here. There are various drivers with slightly
> > > different (and sometimes undocumented) pwm attributes around. Maybe it
> > > is time to clean up the ABI and define a complete (or at least more
> > > complete) set of attributes.
> > 
> > Yes, it looks like the current sysfs interface standard is lacking.
[...]
> 
> One (now) very obvious mistake I made back then is that I did not
> abstract the fan speed controller units from PWM outputs.

Right, that's exactly my remaining unhappiness above was about.

Let me add two more things.

First, I doubt that it's a good idea to put the fan*_target value into
the fan domain.  After all, this value is about fan *control*, not about
fan state, which I think suggests it might better reside in the pwm
domain (that is, the domain of the fan controller).  This is emphasized
by having fan*_target in the fan domain, and pwm*_auto_point*_fan_target
in the pwm domain, as you suggested above.  One domain should win here,
and I think it should be the latter.

Second, the F75387 draws a distinction between the actual (PWM or DAC)
output value and the configured target value.  The current definition of
pwm*, on the other hand, not only encodes the steering method (PWM), but
also mixes target value and actual value.  Does it make sense to keep
these values separate in sysfs?

> If we design a new API then we really want to start with controllers,
> and then associate one or more PWM (or DC) outputs, zero or more
> temperature channels, and zero or more fan speed inputs to the
> controller. Note that depending on the mode, temperature or fan input
> may be irrelevant.  Also note that for some (most?) chips, some of
> these settings will be hard-coded and not changeable by the user.
> Lastly, note that in some cases we will NOT know the associations, in
> particular for the fan inputs, the chip only needs to know in speed
> target mode, so if the chip doesn't support that, we just don't know.
> 
> I do not exactly have the amount of spare time it would take to work
> on this right now. If someone wants to work on this, go ahead and I'll
> be happy to review the proposal. If not, I'm putting this on my to-do
> list.

I doubt I will make it, due to lack of time, and lack of experience in
the sensors area. :/ 

Nikolaus

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
