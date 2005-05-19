From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:58 +0000
Subject: lm_sensors
Message-Id: <X4octIaT.1115901414.5569860.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <OF0351D9C0.5474FFE2-ON87256C2B.005D8AC8@boulder.ibm.com>
In-Reply-To: <OF0351D9C0.5474FFE2-ON87256C2B.005D8AC8@boulder.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Dmitry,

> I've upgraded BIOS to the latest version (4), downloaded rc4, copied
> it87.c into 2.6.11.5 branch, reinstalled kernel. Now pwm registers are
> seen.

OK. Did you have to use the "fix_pwm_polarity" parameter, or did the
BIOS upgrade fix it for you?

> But during pwmconfig fan doesn't stop:

I would recommend that you first experiment manually with the pwm files.
pwmconfig works fine in the general case, but will hide most problems to
you.

> It looks I'm near the end but I need your help.

First, check your BIOS for an automatic fan speed adjustment option. Is
there one? If there is one, disable it.

Then start experimenting with the PWM values manually, after you checked
that pwmN_enable is set to 1 (manual control enabled).

One common pitfall with PWM is that motherboards may not be properly
wired for fan speed control. Are you certain that your motherboard
supports it?

Another possible problem is that your fan has internal thermal
regulation. This would explain why the speed seems to increase over
time: the temperature is likely to increase over time as well. In this
case there's not much you can do with lm_sensors. If the CPU fan is
very loud, either change it for a quiter model (possibly not
thermoregulated), or add a 12 cm fan in your computer case. Large fans
are quiter, and the additional air flow might lower the temperature
enough to let the CPU fan spin down a bit, for a lower total noise.

Yet another possible problem is that the PWM frequency may not suit your
fan. We have had several reports of this lately. You may try other
frequencies but unfortunately there is no sysfs interface for this yet,
so you'd have to get the datasheet and set the register values manually
(using the isaset tool). Only try this is everything else failed and you
are certain that your motherboard supports fan speed control.

> Additionally I've dicovered that CPU temp is negative.
> (...)
> M/B Temp: +25?C (low = +15?C, high = +40?C) sensor = thermistor
> CPU Temp: -55?C (low = +15?C, high = +45?C) sensor = thermistor
> Temp3: +49?C (low = +15?C, high = +45?C) sensor = diode

I don't think it is. More likely, temp2 is not wired and temp3 is the
CPU temperature. It's only a matter of labelling them properly (edit
/etc/sensors.conf).

You can try changing temp2's sensor type from thermistor to diode, just
in case, but chances are that this input simply has nothing connected to
it. Feel free to add an "ignore" statement for it if this is the case.

--
Jean Delvare
