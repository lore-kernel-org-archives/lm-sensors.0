From: Nikolaus Schulz <mail@microschulz.de>
Date: Sat, 11 Feb 2012 18:28:24 +0000
Subject: Re: [lm-sensors] [RFC] (F75387) How expose automatic fan control in sysfs?
Message-Id: <20120211182820.GE30859@luigi.zusammrottung.local>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120209222304.GA28989@luigi.zusammrottung.local>
In-Reply-To: <20120209222304.GA28989@luigi.zusammrottung.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Feb 11, 2012 at 01:12:08AM +0100, Jean Delvare wrote:
> On Fri, 10 Feb 2012 23:56:07 +0100, Nikolaus Schulz wrote:
> > On Fri, Feb 10, 2012 at 09:05:19AM +0100, Jean Delvare wrote:
> > > [...] if what your chip does is multiple RPM targets based on the
> > > temperature, i.e. a mix of temperature trip points mode and fan speed
> > > target mode, then indeed our sysfs interface is lacking standard file
> > > names for this
> > 
> > Yes, this is what the F75387 does in closed loop mode.  All fan target
> > values are then specified in RPM, not PWM, including the
> > temperature-bounded for automatic fan control.
> > 
> > > (I can't remember another chip supporting this.)
> > 
> > Apparently the F71805F does this, and it is supported by the hwmon
> > driver.  This driver uses the sysfs filenames pwm*_auto_point*_fan.
> 
> Wow. This is my driver, I didn't write this part of the code but I
> signed than patch so I must have reviewed it, and I did not remember it
> at all.
> 
> > > Following the other attribute names, the proper name could be
> > > pwm[1-*]_auto_point[1-*]_fan_target.
> > 
> > That sounds better and more consistent than the name chosen for the
> > f71805f.
> 
> What is bad is that the name used in the f71805f driver isn't part of
> the standard. Changing it now would be worse. Using a different name in
> your driver would be even worse. So you may not like it, but using it
> would be preferred. And documenting it, this time.

Okay.

This should then go into both the sysfs interface doc and the driver
specific doc.  I'm willing to try that.

[...]

> > Second, the F75387 draws a distinction between the actual (PWM or DAC)
> > output value and the configured target value.  The current definition of
> > pwm*, on the other hand, not only encodes the steering method (PWM), but
> > also mixes target value and actual value.  Does it make sense to keep
> > these values separate in sysfs?
> 
> How could the actual PWM duty cycle ever differ from the desired one? I
> don't get it.

At least in theory it can, since the desired PWM duty cycle is bound to
the open loop mode.  If the fan controller runs in closed loop mode,
that setting might be ignored.

One can consider this an example of your (smart) suggestion to expose
r/w sysfs configuration files for all modes, including inactive ones, so
that the user can use the sysfs files to compose a complete
configuration for a mode that is currently inactive, and activate the
mode when he is done, thereby activating all corresponding settings in
one go.

Nikolaus

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
