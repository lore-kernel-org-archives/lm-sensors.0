From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 11 Mar 2007 15:21:30 +0000
Subject: [lm-sensors] [PATCH] Add MAX6650 support
Message-Id: <20070311162130.79ba1a4d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200701171359.46334.hjk@linutronix.de>
In-Reply-To: <200701171359.46334.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

Sorry for the delay, I've been busy with large i2c-core changes.

On Thu, 1 Mar 2007 11:11:12 +0100, Hans-J?rgen Koch wrote:
> Am Donnerstag 01 M?rz 2007 08:34 schrieb Jean Delvare:
> > prescaler: What does it do? It smells like a fan clock divider to
> > me. In that case it would be better implemented as a fan1_div sysfs
> > file, which the user can adjust at runtime.
> 
> The chip generates a reference frequency which is determined by the 
> speed register, the prescaler, and the internal clock (nominal value 
> 254kHz). The regulator then tries to make the tacho frequency equal 
> to this reference frequency. 
> As clock is fixed and speed has a well defined meaning, the prescaler 
> is the only way to adapt to different tacho generators. The data 
> sheet gives hints about how to select a prescaler value to achieve 
> optimal range and resolution. If you get that wrong, the fan might 
> not reach it's full speed, switch between two speed values only or 
> similar effects.
> 
> I read Documentation/hwmon/sysfs-interface, but I have to admit that I 
> don't really understand if fan[1-*]_div has this meaning. If it has, 
> we could possibly make prescaler such a sysfs file. 

I'm not certain myself. fan1_div is usually related to the monitoring
only and not to the output.

Typical chips monitor fan speeds by gating a well defined frequency
with the tachometer pulses. The result is stored in an 8-bit register,
so basically you can only measure fan speeds down to F/255, speeds
below this limit overflow the register. So the chips usually let the
user divide F by a power of two to be able to monitor slower fans - at
the price of resolution.

So the concept is similar to your "prescaler" in that it's a tradeoff
between resolution and range. But the fan speed control method of the
MAX6650 is completely different from what the other chips do, so other
chips don't need any kind of divider for fan speed control.

> > clock: OK.
> 
> This is the only one where I think it could be omitted. The internal 
> 254kHz oscillator has a tolerance of +/-10%, so fan speed can also be 
> off +/-10%. This parameter is just there to compensate for that. I 
> doubt it will ever be used in practical applications.

Agreed, it probably makes sense to get rid of this one.

> > mode: This smells like fan speed control parameters, which we
> > typically implement as the pwm1_enable sysfs file. Please take a
> > look at the description in Documentation/hwmon/sysfs-interface and
> > tell me what you think.
> 
> That looks good. We can implement pwm1_enable that way. Problem is 
> that we can have up to four fan speeds (fan[1-4]_input), but the 
> control values are there only once (pwm1, pwm1_enable). Is that 
> possible?

Yes, this isn't a problem. I am not a specialist but I don't think it's
possible to have a closed loop fan control working with 4 inputs and 1
output, so I believe the output is really related to fan1 only. A
comment in the original driver seems to confirm that ("Only one fan's
speed (fan1) is controlled.")

I don't think the MAX6650 implements anything like pwm1, but more like
pwm1_enable and fan1_target. "speed" is expressed in RPM, isn't it?

> > counttime: This one too seems to be related to a fan clock divider?
> > How does it functionally differ from prescaler?
> 
> counttime is the time interval during which tacho pulses are counted.
> It determines the resolution of the measured speed values. It should 
> be set to the longest time that still ensures the 8-bit counter 
> doesn't overflow under worst case conditions. 

_This_ really sounds like fan1_div. It changes the period of time
rather than the clock frequency, but from a functional point of view
the result is the same: preventing 8-bit register overflow for certain
speed fans. The only difference is that typical chips overflow for slow
fans, while the MAX6650 is more likely to overflow when the fan is too
fast, if I understood correctly.

So please implement it that way. fan1_div = 1 should correspond to the
smaller period of time (faster fan.)

Aren't the count time and precaler values somewhat related? Won't the
user have to change both the same way if he/she gets a new fan running
at a different speed? Maybe it would make sense to link fan1_div to
both the prescaler and the count time after all.

Thanks,
-- 
Jean Delvare

