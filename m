From: Nikolaus Schulz <mail@microschulz.de>
Date: Thu, 09 Feb 2012 22:23:08 +0000
Subject: [lm-sensors] [RFC] (F75387) How expose automatic fan control in sysfs?
Message-Id: <20120209222304.GA28989@luigi.zusammrottung.local>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I am working on adding automatic fan control configuration to the
f75375s driver.  I have code that is almost complete and working well,
but I wonder what is the best way to expose this in the sysfs.

The F75387 fan control chip configuration can be fully switched between
open loop mode, where it is programmed with raw PWM values, and closed
loop mode, where one specifies desired RPM fan speeds instead.

However, both modes use the same configuration input registers.

The lm-sensors standard sysfs interface defines that RPM target values
should be exposed using filenames fan*_target, and PWM values via pwm*.
For automatic, temperature-bounded fan control values, only
pwm*_auto_point*_pwm files are defined.

Now I wonder, what is the best way to expose the configuration for the
F75387 in sysfs?

Trying to match the standard sysfs interface makes me think I need to
expose different files in sysfs, depending on the mode.  That is, pwm*
and pwm*_auto_point*_pwm for open loop mode, and for closed loop mode
fan*_target and, hmm, I guess ${TYPE}*_auto_point*_fan where I'm not
sure what to put into $TYPE...  Any suggestions for $TYPE?

But then, if the user switches between open and closed loop mode, all
these mode-specific filenames in sysfs need be switched over, since it
would make no sense to keep the files for the inactive mode around,
right?  This makes me feel slightly unhappy.  Thoughts?

Of course, one could inhibit the mode switching and just stick with the
mode that was enabled by the BIOS.  But I don't see why the user should
not be empowered to switch modes; and I have tested this, and it works
like a charm.

I would very much appreciate your thoughts on this.

Thanks,
Nikolaus

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
