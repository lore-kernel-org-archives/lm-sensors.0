From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 03 Nov 2005 12:30:25 +0000
Subject: [lm-sensors] w83627hf, fan speed always high, unchangeable?
Message-Id: <VMARRl73.1131016660.7815020.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <43692C12.90301@gmail.com>
In-Reply-To: <43692C12.90301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Sebastian,

On 2005-11-02, Sebastian Nowozin wrote:
> I just installed an EPOX ES300 miniMe barebone with a EP-4PGF mainboard
> using Debian/testing, kernel 2.6.14.  The chip label on the board reads
> "Winbond W83627HF-AW", and sensors-detect finds it as such with a
> confidence of 8 at the ISA bus.

Great :)

> "sensors" displays fan1 (the case fan) with constant rpm around 4700,
> fan2 and fan3 at 0 rpm.  I tried everything with the w83781d driver,
> which also loads fine and displays two fan with non-zero rpm (the CPU
> fan with around 2600rpm).  I am only interested in the case fan though,
> as it is really loud.  The 4700rpm is consistent with what is shown in
> the BIOS.

The w83627hf driver should work better for you, don't use w83781d.

2600 RPM is the low limit of what the W83627HF chip can measure with a
fan clock divider of 2. I guess that you have fan2_div set to 2. That
would explain why you sometimes see the real CPU fan speed, and
sometimes 0 RPM.

Try setting fan2_div to 4 (add "set fan2_div 4" in the w83627hf-*
section of your configuration file, then run "sensors -s".) I expect
you to then have consistent CPU fan speed readings.

> Using the "pwmconfig" program, I get this output:
> 
> Found the following PWM controls:
>     9191-0290/pwm1
>     9191-0290/pwm2
>
> Found the following fan sensors:
>     9191-0290/fan1_input     current speed: 4687 RPM
>     9191-0290/fan2_input     current speed: 0 ... skipping!
>     9191-0290/fan3_input     current speed: 0 ... skipping!
>
> Testing pwm control 9191-0290/pwm1 ...
>    9191-0290/fan1_input ... speed was 4687 now 4720
>      no correlation
>
> Testing pwm control 9191-0290/pwm2 ...
>    9191-0290/fan1_input ... speed was 4687 now 4753
>      no correlation
>
> With no slowing down of the case fan.
>
> Now my question, limited by my understanding of the sensors package:
> What is most likely:
>
>   1. The w83627hf chip on the board can only provide readings but no
> control of the fanspeed.

Yes, this is the most probable. It is always a bit frustrating to know
that the chip could do it, but the motherboard manufacturer did not wire
it properly to do so. Unfortunately, this is a rather common situation.

Note however that the run of pwmconfig above only shows that the speed of
the case can cannot be controlled. When you get valid readings for your
CPU fan, try again. It is possible, though unlikely, that the CPU fan
can be controlled.

Likewise, if your motherboard has a third fan header, you may try to use
it for the case fan instead of fan1, and run pwmconfig again. Who knows?

>   2. The w83627hf chip may provide control of the fanspeed, but there is
> some hardware connector/cable missing.

No, no additional cable is required. Either the motherboard is properly
wired, or it's not.

>   3. Something else is wrong, eg. /etc/sensors.conf (attached), ...

Attaching a 70 kB file wasn't exactly wise ;) please only include the
relevant part next time.

The configuration look OK, but it's really only affecting monitoring,
not control, so it isn't related to your problem.

You may try to load the w83627hf driver with reset=1. Please report if it
helps. I don't expect it to actually help, but you may still want to
try.

Remember that there are always hardware solutions to reduce the fan
noise. You can use a potentiometer. You can use a thermoregulated fan.
Or you can simply use a fan with a lower nominal speed.

--
Jean Delvare
