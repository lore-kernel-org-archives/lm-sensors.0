From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 10 Feb 2012 08:05:19 +0000
Subject: Re: [lm-sensors] [RFC] (F75387) How expose automatic fan control in sysfs?
Message-Id: <20120210090519.0e3485b5@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120209222304.GA28989@luigi.zusammrottung.local>
In-Reply-To: <20120209222304.GA28989@luigi.zusammrottung.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 9 Feb 2012 23:54:52 +0100, Nikolaus Schulz wrote:
> On Thu, Feb 09, 2012 at 02:34:54PM -0800, Guenter Roeck wrote:
> > On Thu, 2012-02-09 at 17:23 -0500, Nikolaus Schulz wrote:
> > > I am working on adding automatic fan control configuration to the
> > > f75375s driver.  I have code that is almost complete and working well,
> > > but I wonder what is the best way to expose this in the sysfs.
> > > 
> > > The F75387 fan control chip configuration can be fully switched between
> > > open loop mode, where it is programmed with raw PWM values, and closed
> > > loop mode, where one specifies desired RPM fan speeds instead.
> > > 
> > > However, both modes use the same configuration input registers.
> > > 
> > > The lm-sensors standard sysfs interface defines that RPM target values
> > > should be exposed using filenames fan*_target, and PWM values via pwm*.
> > > For automatic, temperature-bounded fan control values, only
> > > pwm*_auto_point*_pwm files are defined.
> > > 
> > > Now I wonder, what is the best way to expose the configuration for the
> > > F75387 in sysfs?
> > > 
> > > Trying to match the standard sysfs interface makes me think I need to
> > > expose different files in sysfs, depending on the mode.  That is, pwm*
> > > and pwm*_auto_point*_pwm for open loop mode, and for closed loop mode
> > > fan*_target and, hmm, I guess ${TYPE}*_auto_point*_fan where I'm not
> > > sure what to put into $TYPE...  Any suggestions for $TYPE?

I'm not sure what exactly you want to put in this file, so I can't
answer. The mapping between PWM output and fan input? If so that would
be pwm[1-*]_auto_channels_fan (which isn't yet defined in out standard
sysfs interface but could be added.)

Or, if what your chip does is multiple RPM targets based on the
temperature, i.e. a mix of temperature trip points mode and fan speed
target mode, then indeed our sysfs interface is lacking standard file
names for this (I can't remember another chip supporting this.)
Following the other attribute names, the proper name could be
pwm[1-*]_auto_point[1-*]_fan_target.

I hope I replied to your question.

> > Maybe Jean has an idea here. There are various drivers with slightly
> > different (and sometimes undocumented) pwm attributes around. Maybe it
> > is time to clean up the ABI and define a complete (or at least more
> > complete) set of attributes.
> 
> Yes, it looks like the current sysfs interface standard is lacking.

Blame it on my, I designed it, years ago. I remember a number of people
argued about it, but I did not listen, in part because I am stubborn,
in part because they did not propose any alternative. This is possibly
the worse memory I have since I am involved in the lm-sensors project.

One (now) very obvious mistake I made back then is that I did not
abstract the fan speed controller units from PWM outputs. If we design
a new API then we really want to start with controllers, and then
associate one or more PWM (or DC) outputs, zero or more temperature
channels, and zero or more fan speed inputs to the controller. Note
that depending on the mode, temperature or fan input may be irrelevant.
Also note that for some (most?) chips, some of these settings will be
hard-coded and not changeable by the user. Lastly, note that in some
cases we will NOT know the associations, in particular for the fan
inputs, the chip only needs to know in speed target mode, so if the
chip doesn't support that, we just don't know.

I do not exactly have the amount of spare time it would take to work on
this right now. If someone wants to work on this, go ahead and I'll be
happy to review the proposal. If not, I'm putting this on my to-do list.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
