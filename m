From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 29 Apr 2010 08:57:40 +0000
Subject: Re: [lm-sensors] Simple fan question
Message-Id: <20100429105740.6e3b7716@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1272518506.24542.163.camel@pasglop>
In-Reply-To: <1272518506.24542.163.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: lm-sensors@lm-sensors.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Ben,

On Thu, 29 Apr 2010 15:21:46 +1000, Benjamin Herrenschmidt wrote:
> I'm writing some support for d-link dns323 rev C1 NAS. It has a fan that
> is controlled by some non-programmable PWM circuit. Basically, all I can
> do is tweak to GPIOs that controls the feed into the circuitry for the
> fans to be off, slow or fast.
> 
> I don't know what the actual PWM values are for "slow" or "fast". I
> -might- be able to do some measurements but I can't promise it.
> 
> Now I'm trying to do a simple hwmon driver for that in order to easy
> userspace support for these guys, and I don't really see a 'nice' way to
> expose that which would fit the interfaces documented
> Documentation/hwmon/sysfs-interface.
> 
> So before I do something horrible, I felt I might poke you guys see if
> you have a good idea here :-)
> 
> Before I read the above document I was thinking about a sysfs file that
> contains "off", "slow" or "fast" but it looks like this won't fit at all
> the typical hwmon APIs.

Indeed, that wouldn't fit. The nearest entry in the document is:

pwm[1-*]	Pulse width modulation fan control.
		Integer value in the range 0 to 255
		RW
		255 is max or 100%.

In your case, the file would have only 3 possible values, with "off"
mapping to 0, and "slow" and "fast" mapping to arbitrary positive
values, like 64 and 192 or whatever you think is suitable. I understand
that in your case, you don't really control the PWM output directly,
but we do not have any interface for this, and I don't think there
would be much value in adding one.

That being said, I am also only mildly convinced that fitting your chip
in the standard pwm1 interface will be very helpful. I don't really
expect tools such as the fancontrol script to behave properly when the
pwm1 file only support a small number of discrete values. So the
benefit of using the standard file name and semantics seems thin.

> Another comment while at it is when implementing the thermal control for
> PowerMacs a while back (windfarm etc...) I had to deal with two
> different type of interfaces to fans. RPM controlled and PWM controlled.
> 
> The later basically let me program a percentile value (a percent of the
> duty cycle).

This is exactly what pwm[1-*] files are about, except that we used
range 0-255 instead of 0-100 for historical and practical reasons.

> I looks like the described sysfs interface only does RPM, or at least
> doesn't provide a way to expose the units used...

For RPM-controlled, look at the following entry instead:

fan[1-*]_target
		Desired fan speed
		Unit: revolution/min (RPM)
		RW
		Only makes sense if the chip supports closed-loop fan speed
		control based on the measured fan speed.

One significant difference is that, in this case, you always know which
fan you control, while in the pwm[1-*] case you don't.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
