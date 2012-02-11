From: Nikolaus Schulz <mail@microschulz.de>
Date: Sat, 11 Feb 2012 22:03:49 +0000
Subject: Re: [lm-sensors] [RFC] (F75387) How expose automatic fan control in sysfs?
Message-Id: <20120211220345.GA31758@luigi.zusammrottung.local>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120209222304.GA28989@luigi.zusammrottung.local>
In-Reply-To: <20120209222304.GA28989@luigi.zusammrottung.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Feb 11, 2012 at 07:28:24PM +0100, Nikolaus Schulz wrote:
> > > Second, the F75387 draws a distinction between the actual (PWM or DAC)
> > > output value and the configured target value.  The current definition of
> > > pwm*, on the other hand, not only encodes the steering method (PWM), but
> > > also mixes target value and actual value.  Does it make sense to keep
> > > these values separate in sysfs?
> > 
> > How could the actual PWM duty cycle ever differ from the desired one? I
> > don't get it.
> 
> At least in theory it can, since the desired PWM duty cycle is bound to
> the open loop mode.  If the fan controller runs in closed loop mode,
> that setting might be ignored.
> 
> One can consider this an example of your (smart) suggestion to expose
> r/w sysfs configuration files for all modes, including inactive ones, so
> that the user can use the sysfs files to compose a complete
> configuration for a mode that is currently inactive, and activate the
> mode when he is done, thereby activating all corresponding settings in
> one go.

Here actually lies another problem when programming the F78387.

This chip exposes the current duty cycle in a register that is always
r/o.  The fan is steered using a second register, which is used in both
open loop mode, where it is interpreted as a PWM value, and closed loop
mode, where it is interpreted as a RPM value.  (In automatic mode, this
steering register is automatically set, depending on the temperature.)

This is similar to the problem with the automatic mode of the F75387 I
mentioned in my initial post: the configuration register is reused, thus
a switch between manual open loop mode and manual closed loop mode is a
dangerous operation.

To support such a mode switch safely, there should be a way to set the
values for the new mode before the switch.

For automatic mode, you proposed to always expose separate r/w sysfs
files for both open and closed loop mode, and handle this in the driver.

For manual mode, switching from open to closed loop can be done by
writing to fan*_target before the switch, and again handle this in the
driver.  However, the other direction doesn't work, since the pwm* file
is overloaded, providing measurement *and* configuration.  What can be
done here?  Introduce a new file pwm*_target?

I have to say I am not particularly excited about this.  Better ideas
are welcome.

Nikolaus

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
