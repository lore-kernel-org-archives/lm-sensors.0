From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 09 Feb 2012 22:34:54 +0000
Subject: Re: [lm-sensors] [RFC] (F75387) How expose automatic fan control in sysfs?
Message-Id: <1328826894.29825.12.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120209222304.GA28989@luigi.zusammrottung.local>
In-Reply-To: <20120209222304.GA28989@luigi.zusammrottung.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 2012-02-09 at 17:23 -0500, Nikolaus Schulz wrote:
> Hi,
> 
> I am working on adding automatic fan control configuration to the
> f75375s driver.  I have code that is almost complete and working well,
> but I wonder what is the best way to expose this in the sysfs.
> 
> The F75387 fan control chip configuration can be fully switched between
> open loop mode, where it is programmed with raw PWM values, and closed
> loop mode, where one specifies desired RPM fan speeds instead.
> 
> However, both modes use the same configuration input registers.
> 
> The lm-sensors standard sysfs interface defines that RPM target values
> should be exposed using filenames fan*_target, and PWM values via pwm*.
> For automatic, temperature-bounded fan control values, only
> pwm*_auto_point*_pwm files are defined.
> 
> Now I wonder, what is the best way to expose the configuration for the
> F75387 in sysfs?
> 
> Trying to match the standard sysfs interface makes me think I need to
> expose different files in sysfs, depending on the mode.  That is, pwm*
> and pwm*_auto_point*_pwm for open loop mode, and for closed loop mode
> fan*_target and, hmm, I guess ${TYPE}*_auto_point*_fan where I'm not
> sure what to put into $TYPE...  Any suggestions for $TYPE?
> 

Maybe Jean has an idea here. There are various drivers with slightly
different (and sometimes undocumented) pwm attributes around. Maybe it
is time to clean up the ABI and define a complete (or at least more
complete) set of attributes.

> But then, if the user switches between open and closed loop mode, all
> these mode-specific filenames in sysfs need be switched over, since it
> would make no sense to keep the files for the inactive mode around,
> right?  This makes me feel slightly unhappy.  Thoughts?
> 
You should be able to keep all attributes around, even if some may not
be active at a given time. Otherwise, you would not be able to program
auto mode parameters until you enabled auto mode ... which would not be
a good idea.

> Of course, one could inhibit the mode switching and just stick with the
> mode that was enabled by the BIOS.  But I don't see why the user should
> not be empowered to switch modes; and I have tested this, and it works
> like a charm.
> 
More a matter of avoiding risk, I would guess. If you let the user
program auto mode, you probably want to have some kind of validation
before the mode is actually enabled, to at least try to avoid board
fatalities. This is really highly driver specific, and has to be very
well tested.

I have been thinking about doing the same for the w83627ehf driver.
Pretty much the same problem - some attributes are missing in the ABI,
and others only apply to certain modes. So I am definitely interested in
a generic set of attibutes.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
