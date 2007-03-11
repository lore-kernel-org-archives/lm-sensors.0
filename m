From: hjk@linutronix.de (=?iso-8859-1?q?Hans-J=FCrgen_Koch?=)
Date: Sun, 11 Mar 2007 21:08:01 +0000
Subject: [lm-sensors] [PATCH] Add MAX6650 support
Message-Id: <200703112208.02348.hjk@linutronix.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200701171359.46334.hjk@linutronix.de>
In-Reply-To: <200701171359.46334.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Am Sonntag 11 M?rz 2007 16:21 schrieb Jean Delvare:
> Hi Hans,
>
> Sorry for the delay, I've been busy with large i2c-core changes.

I noticed :-) 
No problem.

> >
> > I read Documentation/hwmon/sysfs-interface, but I have to admit that I
> > don't really understand if fan[1-*]_div has this meaning. If it has,
> > we could possibly make prescaler such a sysfs file.
>
> I'm not certain myself. fan1_div is usually related to the monitoring
> only and not to the output.
>
> Typical chips monitor fan speeds by gating a well defined frequency
> with the tachometer pulses. The result is stored in an 8-bit register,
> so basically you can only measure fan speeds down to F/255, speeds
> below this limit overflow the register. So the chips usually let the
> user divide F by a power of two to be able to monitor slower fans - at
> the price of resolution.
>
> So the concept is similar to your "prescaler" in that it's a tradeoff
> between resolution and range. But the fan speed control method of the
> MAX6650 is completely different from what the other chips do, so other
> chips don't need any kind of divider for fan speed control.

Obviously, we've reached some limits of the current concept. IMHO, the 'pwm' 
and 'divider' sysfs files are much too hardware dependent. We should have 
more abstraction, e.g. like this:

fan1_input: (ro) Current speed in RPM
fan1_speed: (rw) Desired speed in RPM
fan1_min_speed,
fan1_max_speed: (rw) Planned/defined operating range in RPM
fan1_tacho: (rw) Pulses per round of the tacho generator
fan1_mode: (rw) on, off, closed_loop, open_loop, ...

From this, _every_ driver could calculate the necessary register values it 
needs, without bothering the user with chip internal details. Why should a 
user care if the fan regulator chip uses PWM or not? The values I mentioned 
above are the ones he/she knows and can easily set without having the data 
sheet in one hand and the pocket calculator in the other.

Of course, implementation is slightly more complicated, as the values depend 
on each other, so setting one of them might invalidate the setup until an 
other is set. The driver needs to deal with that in a reasonable way. But I 
think I could easily do it for the max6650. It shouldn't be difficult for 
other drivers, too.

[...]

>
> Yes, this isn't a problem. I am not a specialist but I don't think it's
> possible to have a closed loop fan control working with 4 inputs and 1
> output, so I believe the output is really related to fan1 only. A
> comment in the original driver seems to confirm that ("Only one fan's
> speed (fan1) is controlled.")

That comment, as well as the data sheet, are a bit misleading. In fact, the 
MAX6651 is NOT able to drive four independent fans. It just has four tacho 
inputs. The first one can be used to close the loop if you want closed loop 
operation. To the other three, you can connect whatever you like. The 
intended use is to connect four identical fans in parallel to the output. The 
tacho signal of one of them is used for closed loop regulation. If the fans 
are _really_ identical, all of them should have the same speed. You can check 
their actual speeds by looking at the other tacho inputs.

> >
> > counttime is the time interval during which tacho pulses are counted.
> > It determines the resolution of the measured speed values. It should
> > be set to the longest time that still ensures the 8-bit counter
> > doesn't overflow under worst case conditions.
>
> _This_ really sounds like fan1_div. It changes the period of time
> rather than the clock frequency, but from a functional point of view
> the result is the same: preventing 8-bit register overflow for certain
> speed fans. The only difference is that typical chips overflow for slow
> fans, while the MAX6650 is more likely to overflow when the fan is too
> fast, if I understood correctly.
>
> So please implement it that way. fan1_div = 1 should correspond to the
> smaller period of time (faster fan.)

As I said above, I really believe we shouldn't do that but be less hardware 
dependent.

>
> Aren't the count time and precaler values somewhat related? Won't the
> user have to change both the same way if he/she gets a new fan running
> at a different speed? Maybe it would make sense to link fan1_div to
> both the prescaler and the count time after all.

If I did that, confusion would be complete. A user would not only need data 
sheet in one hand, pocket calculator in other hand, but also driver source 
code in the third hand to understand what's going on :-)

Initially, I didn't want to make a lot of changes to that driver, just have it 
in the mainline kernel. But meanwhile, I feel if we do it, we should do it 
properly. That means, either we accept the driver as it is now (with special 
sysfs files no other driver has), or we change the specification in 
Documentation/hwmon/sysfs-interface to be more general so that all fan 
drivers fit in.

What's your opinion?

Thanks,
Hans


