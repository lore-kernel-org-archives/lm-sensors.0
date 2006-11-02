From: david.c.hubbard@gmail.com (David Hubbard)
Date: Thu, 02 Nov 2006 19:38:32 +0000
Subject: [lm-sensors] ASUS P5B DELUXE WiFi with Winbond W83627DHG
Message-Id: <4dfa50520611021138q5d2ca562x1ab7671ac7973db0@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4536788E.8010504@fibertel.com.ar>
In-Reply-To: <4536788E.8010504@fibertel.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Christian,

> On this board, fan1, fan4 and fan5 (named CHA_FAN1, CHA_FAN3, CHA_FAN2
> externally) are synchroneously controlled by pwm4. (I have not checked
> CHA_FAN4 and 5) since I could not finde a corresponding fan read out. May=
be
> they are not monitored at all)

Okay, that is good to know. It's a popular board, and I expect more
people will ask similar questions about their fan behavior.

> I succeded to establish a control loop by setting _enable=3D2,
> _target8000,_mode=3D1, _min_output=95. Now I can observe when loading the
> cpu with "while true ; do a=3D1; done" ,after some while the Fans do real=
ly
> speed up.

That sounds like correct behavior to me also.

> Interesting enough, the circuit seems to react on the CPU temperature, not
> on the SYS-temperature.

In the future, we will provide sysfs entries which will document how
the chip connects a temperature to a fan output when doing automatic
fan control (like _enable=3D2). You are correct in noting that CPU
temperature is the current configuration.

> I am still working on fan2 and 3. Monitoring fan speed works.
>
> I expected them to be controlled by one of the other 3 pwm?s but I am sti=
ll
> not able to control them.
>
> Fan3 ist connected to "PWR-FAN" which seems to be non-controllable at all.
> The BIOS does not offer any choice either. Only fan speed is supervised.

That's probably the way the motherboard is designed. Even though the
chip outputs a control voltage / PWM signal for the fan, the fan is
not designed to be controlled like this. It is still a good thing to
be able to monitor the fan so that an alarm can trigger if it fails.

> Fan2 seems to be connected to "CPU-FAN", the 4-pin connector. Here I am
> still experimenting. The main problem is that the CPU cooler I do use now
> has only 3 pins. If I connect any 3 pin fan to these 4 pins, the fan just
> turns at high speed - no control. Is there any adapter for such purposes?
The pins on a 3-pin fan are (not in order): ground, PWM signal
(typically +12V, but the signal switches on and off rapidly) and RPM
sensor. The problem is that the RPM sensor is powered by the PWM
signal, resulting in an inaccurate RPM reading. The pins on a 4-pin
fan are (not in order): ground, PWM signal drives the fan, power for
the RPM sensor (I think it's +12V, or it might be +5V) and the RPM
reading. This gives a more accurate reading. If you found the ground,
PWM, and RPM pins, you could connect a 3-pin fan. You should use a
voltmeter, and you might still damage your board. (If, for instance,
the RPM sensor on the 3-pin fan outputs a +12V sense signal and the
motherboard is designed for a +5V sense signal, you could damage it.)
That's all I know on the subject, but you could google for a while and
look for more information.

> On the fans measurements: I do have fans that are able to operate lower t=
han
> 600 rpm. But when I turn down power below "95" and the fan reading is bel=
ow
> 620 rpm, the measurement becomes erroneous - it jumps up to values like
> 10.546 rpm even at a _div=128. This might be area of improvement in the
> driver?
No, the driver can only report readings from the chip. If the _div is
128, the readings are as low as they can get. Erroneous readings are
typical at low speeds. One way to get a more accurate reading would be
to average multiple values (two options: a moving window average, or
an alpha filter) -- this is not something that a kernel driver should
do, in keeping with the lm-sensors design philosophy. The sensors
package might be the right place to add this feature, but I am not
certain.

Hope that helps,
David

