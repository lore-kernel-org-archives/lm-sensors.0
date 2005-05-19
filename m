From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:42 +0000
Subject: w83627hf driver: one pwm value, two fan speeds?
Message-Id: <20050309223124.66236a82.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050306230902.GA17472@nospam.com>
In-Reply-To: <20050306230902.GA17472@nospam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rutger,

> > The underlying technology is Winbond's
> > automatic fan control logic embedded in their Super-I/O chips
> > (W83627THF in your case, if I'm not mistaken).
> 
> Yup, using the w83627hf module, that's what I wrote.

The w83627hf drivers supports more than one chip, namely W83627HF,
W83627_T_HF, W836_9_7HF and W836_3_7HF. It happens that the 627THF
variant handles fan control differently from the other chips of the
family.

> > Winbond calls that "Cruise Mode".
> > In fact there are two of these, thermal cruise mode and fan speed
> > cruise mode. Q-Fan would be thermal cruise mode.
> 
> What is the difference? Thermal cruise mode probably adjusts the CPU
> fan speed according to the CPU temperature, what does 'fan speed
> cruise mode' do?

Thermal cruise mode adjusts the fan control *outputs* according to the
temperature (aiming at a given temperature). Fan speed cruise mode
adjusts the fan control ouputs according to the measured fan speed
(aiming at a given fan speed).

> > From motherboard manual: Q-Fan can be enabled/disabled, and a low
> > fan speed can be selected: 11/16, 12/16, 13/16, 14/16, 15/16 or
> > full speed. No temperature to be set.

This means that I am wrong, and what Asus names Q-Fan is not an alias
for any "cruise mode" but for manual control. As a side note, I wonder
how they achieve "full speed" since I cannot find a way to disable fan
control according to the datasheet.

I also would like to add that the fan control is NOT PWM-based as I
first thought and said. It is DC-based, according to the datasheet.
That's quite rare these days. The files are still called pwm* for the
sake of compatibility.

> > OTOH is seems that your qfan.rb script is a *software* fan control
> > script, so it's quite different. Our driver doesn't support either
> > cruise mode at the moment.
> 
> What do you mean with 'doesn't support'? It does provide the
> infrastructure (reading CPU temp, settings the pwm), so it does
> support it in my views.

Automatic modes are not supported. Manual mode is, as you could see.

Fan speed cruise mode has very little interest IMHO, but thermal cruise
mode is interesting and supporting this would be a good idea. I would
indeed add support if I has a board with such a chip.

> 0 or 64  + sleep 5 + 128 gives +-1125RPM.
>      80  + sleep 5 + 128 gives +-1125RPM.
>      96  + sleep 5 + 128 gives +-1900RPM.   <- change at 96
>      144 + sleep 5 + 128 gives +-1900RPM.
>      192 + sleep 5 + 128 gives +-1900RPM.
>      240 + sleep 5 + 128 gives +-1900RPM.
> 
> 0 or 64  + sleep 5 + 144 gives +-1400RPM.
>      80  + sleep 5 + 144 gives +-1400RPM.
>      96  + sleep 5 + 144 gives +-1400RPM.
>      112 + sleep 5 + 144 gives +-1400RPM.
>      128 + sleep 5 + 144 gives +-2250RPM.   <- change at 128
>      240 + sleep 5 + 144 gives +-2250RPM.
> 
> 0        + sleep 5 + 176 gives +-1875RPM.
>      128 + sleep 5 + 176 gives +-1875RPM.
>      192 + sleep 5 + 176 gives +-1875RPM.
>      208 + sleep 5 + 176 gives +-1875RPM.
>      224 + sleep 5 + 176 gives +-2909RPM.   <- change at 224
>      240 + sleep 5 + 176 gives +-2909RPM.
> 
> 0 or 64  + sleep 5 + 192 gives +-2136RPM.
>      128 + sleep 5 + 192 gives +-2136RPM.
>      224 + sleep 5 + 192 gives +-2136RPM.
>      240 + sleep 5 + 192 gives +-3308RPM.   <- change at 240
> 
> 0        + sleep 5 + 208 gives +-2350RPM.
>      128 + sleep 5 + 208 gives +-2350RPM.
>      192 + sleep 5 + 208 gives +-2350RPM.
>      240 + sleep 5 + 208 gives +-2350RPM.
> 
> 0 or 64  + sleep 5 + 240 gives +-2760RPM.
>      128 + sleep 5 + 240 gives +-2760RPM.
>      192 + sleep 5 + 240 gives +-2760RPM.
>      224 + sleep 5 + 240 gives +-2760RPM.
> 
> Strange, the point of change increases faster than the final speed
> does...

Completely strange, I agree. I don't see much logic here. Two comments
though:

* The ratio between "low" and "high" speeds for a same output value
seems to be always the same (around 1.5).

* The "high" value seems to exceed the max possible value (3308RPM at
192 > 2760RPM et 240). I wouldn't leave the fan in this state, possibly
it's running over its design voltage in this situation.

* The W83627HF outputs less than 5V max for the fans. I doubt you have
5V fans, most likely you have 12V fans like everyone. This means that
there must be some electronics (maybe a simple amplifier) between the
chip and the fan. I start suspecting that this electronics stuff is
bogus and causing the trouble.

If you have a voltmeter, I invite you to check the fan output voltage
when you play with the pwm2 file (power the fan from somewhere else in
the meantime).

> Yes. the granularity appears to be 16, therefore I write values like
> 128, 144, 192, ...

True, low nibble of the register is unused.

> This granularity corresponds to the BIOS Q-Fan settings: 11/16 is
> probably 176, etc.

True again.

> > Are you loading the w83627hf driver with init=0?
> 
> No, since I want the Q-Fan disabled since I want to do it myself in
> software. What should I retry with init=0?

Please do if possible, and report if it alters the behavior of pwm2.

>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 01 ff 01 cf 00 00 00 00 01 01 01 01 3c 3c 0a 0a 
> 10: 01 ff 00 00 00 01 01 3c 43 00 ff ff 24 32 00 e2 
> 20: a3 c4 d2 be ff 0a 00 1e 6f 4f ff f0 00 de 57 fe 
> 30: c2 2c 20 80 24 71 41 dd 4a 49 08 1a 12 0d 00 00 
> 40: 03 00 00 fe ff 00 00 ff 1f 03 89 c4 58 95 00 a3 
> 50: ff ff 80 ff ff ff 00 80 90 70 ff ff 11 84 ff 05 
> 60: a3 c4 d2 be ff 0a 00 1e 6f 4f ff f0 00 de 57 fe 
> 70: c2 2c 20 80 24 71 41 dd 4a 49 08 1a 12 0d 00 00 
> 80: 01 ff 01 cf 00 00 00 00 01 01 01 01 3c 3c 0a 0a 
> 90: 01 ff 00 00 00 01 01 3c 43 00 ff ff 24 32 00 e2 
> a0: a3 c4 d2 be ff 0a 00 1e 6f 4f ff f0 00 de 57 fe 
> b0: c2 2c 20 80 24 71 41 dd 4a 49 08 1a 12 0d 00 00 
> c0: 03 00 00 fe ff 00 00 ff 1f 03 89 c4 58 95 00 a3 
> d0: ff ff 80 ff ff ff 00 80 90 70 ff ff 11 84 ff 05 
> e0: a3 c4 d2 be ff 0a 00 1e 6f 4f ff f0 00 de 57 fe 
> f0: c2 2c 20 80 24 71 41 dd 4a 49 08 1a 12 0d 00 00 

Looks all OK to me. (Yes, really.)

-- 
Jean Delvare
