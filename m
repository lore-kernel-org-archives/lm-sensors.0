From: hjk@linutronix.de (=?iso-8859-1?q?Hans-J=FCrgen_Koch?=)
Date: Thu, 01 Mar 2007 10:11:12 +0000
Subject: [lm-sensors] [PATCH] Add MAX6650 support
Message-Id: <200703011111.12790.hjk@linutronix.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200701171359.46334.hjk@linutronix.de>
In-Reply-To: <200701171359.46334.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Am Donnerstag 01 M?rz 2007 08:34 schrieb Jean Delvare:
> Hi Hans-J?rgen,
>
> On Wed, 28 Feb 2007 17:08:16 +0100, Hans-J?rgen Koch wrote:
> > Thanks a lot for testing, Matej! Jean, what do you say to that?
> > If you think you can apply this I'll update the documentation
> > file.
>
> Thanks for all the work you've been doing on the driver lately. I
> am waiting for Corentin Labbe to comment before I do the final
> review and merge the driver - I know he found some more things that
> could be fixed or improved since his first review, some of which I
> think you addressed yesterday, some not.

All right, I'm looking forward to his review.

>
> I look briefly at the new options you implemented. They are
> definitely better as module options than hardcoded in the driver
> code, however I'm not sure we really want all of them to be module
> options.

The problem is that all these parameters have to fit together and 
match the fan used. If you have a BIOS that configures the chip for 
one special fan, and you have to replace that fan with a different 
type, you have to calculate new values for prescaler and counttime. 
Or, you might notice your board becomes too hot in a certain 
application and decide to change the mode from "closed loop" to "full 
on". All these things happen frequently in industrial applications.

Having all the values as module parameters doesn't harm as you can 
safely ignore them if the BIOS values work for you. But to have them 
as sysfs files seems to be an advantage.

>
> General remark: the module parameters are driver-wide and not
> device-specific, so they must me checked at module load time (in
> sensors_max6650_init). 

I'll have a look at that.

> Also, for all settings that are not forced 
> by the user, it might be convenient to print in the logs the value
> that was found for each chip.

Agreed, that would be nice to have. I'll add that.

>
> voltage_12V: Must indeed be an option, although the convention you
> chose is a bit strange IMHO. What about a parameter named
> "fan_voltage" with possible values 0 (default, no change), 5 and
> 12?

OK, I agree, that looks better.

>
> (BTW, is this an output voltage? input voltage? both?)

Neither nor. It's simply an information for the chip. It measures the 
voltage at the low side of the fan. The parameter tells it whether 
there are 5V or 12V at the high side. If it measures e.g. 5V at the 
low side, a 5V fan is standing still while a 12V fan still has 7V 
across it and is running at almost half speed. 
If you accidentally set 12V where you really have a 5V fan, this 
doesn't damage the fan. The fan will probably always run with full 
speed, because the chip desperately tries to bring the voltage up.

>
> prescaler: What does it do? It smells like a fan clock divider to
> me. In that case it would be better implemented as a fan1_div sysfs
> file, which the user can adjust at runtime.

The chip generates a reference frequency which is determined by the 
speed register, the prescaler, and the internal clock (nominal value 
254kHz). The regulator then tries to make the tacho frequency equal 
to this reference frequency. 
As clock is fixed and speed has a well defined meaning, the prescaler 
is the only way to adapt to different tacho generators. The data 
sheet gives hints about how to select a prescaler value to achieve 
optimal range and resolution. If you get that wrong, the fan might 
not reach it's full speed, switch between two speed values only or 
similar effects.

I read Documentation/hwmon/sysfs-interface, but I have to admit that I 
don't really understand if fan[1-*]_div has this meaning. If it has, 
we could possibly make prescaler such a sysfs file. 

>
> clock: OK.

This is the only one where I think it could be omitted. The internal 
254kHz oscillator has a tolerance of +/-10%, so fan speed can also be 
off +/-10%. This parameter is just there to compensate for that. I 
doubt it will ever be used in practical applications.

>
> mode: This smells like fan speed control parameters, which we
> typically implement as the pwm1_enable sysfs file. Please take a
> look at the description in Documentation/hwmon/sysfs-interface and
> tell me what you think.

That looks good. We can implement pwm1_enable that way. Problem is 
that we can have up to four fan speeds (fan[1-4]_input), but the 
control values are there only once (pwm1, pwm1_enable). Is that 
possible?

>
> counttime: This one too seems to be related to a fan clock divider?
> How does it functionally differ from prescaler?

counttime is the time interval during which tacho pulses are counted.
It determines the resolution of the measured speed values. It should 
be set to the longest time that still ensures the 8-bit counter 
doesn't overflow under worst case conditions. 

Thanks,
Hans

