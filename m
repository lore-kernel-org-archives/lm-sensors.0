From: "Soeren D. Schulze" <soeren.d.schulze@gmx.de>
Date: Mon, 31 Oct 2011 07:46:43 +0000
Subject: Re: [lm-sensors] Something wrong with support for NCT6776F in
Message-Id: <4EAE5263.3040309@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <4EA9CECA.4050007@gmx.de>
In-Reply-To: <4EA9CECA.4050007@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On 31.10.2011 05:57, Guenter Roeck wrote:
>> I have an ASRock H67M-ITX motherboard.
>>
>> The w83626ehf driver detects:
>>
>> [ 3904.608693] w83627ehf: Found NCT6776F chip at 0x290
>>
>> "sensors" shows me:
>>
>> coretemp-isa-0000
>> Adapter: ISA adapter
>> Physical id 0:  +46.0=B0C  (high =3D +80.0=B0C, crit =3D +98.0=B0C)
>> Core 0:         +46.0=B0C  (high =3D +80.0=B0C, crit =3D +98.0=B0C)
>> Core 1:         +45.0=B0C  (high =3D +80.0=B0C, crit =3D +98.0=B0C)
>> Core 2:         +46.0=B0C  (high =3D +80.0=B0C, crit =3D +98.0=B0C)
>> Core 3:         +46.0=B0C  (high =3D +80.0=B0C, crit =3D +98.0=B0C)
>>
>> nct6776-isa-0290
>> Adapter: ISA adapter
>> Vcore:         +0.96 V  (min =3D  +0.00 V, max =3D  +1.74 V)
>> in1:           +0.18 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
>> AVCC:          +3.39 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
>> +3.3V:         +3.39 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
>> in4:           +0.54 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
>> in5:           +1.69 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
>> 3VSB:          +3.41 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
>> Vbat:          +3.31 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
>> fan1:            0 RPM  (min =3D    0 RPM)  ALARM
>> fan2:         2180 RPM  (min =3D    0 RPM)  ALARM
>> SYSTIN:        +42.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  ALAR=
M  sensor
>> =3D thermistor
>> CPUTIN:       +127.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  ALAR=
M  sensor
>> =3D thermistor
>> AUXTIN:        -24.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sens=
or =3D
>> thermistor
>> PECI Agent 0:  +46.5=B0C
>> cpu0_vid:     +2.050 V
>> intrusion0:   ALARM
>> intrusion1:   ALARM
>>
>>
>> Here, CPUTIN and AUXTIN (whatever it is) are obviously wrong.  CPUTIN
>> *decreases* towards 17=B0C when the CPU gets hot (non-linearly, though).
>>
> Odd. No idea what is going on, though. The registers are quite straightfo=
rward,
> and the same for NCT6775F and NCT6776F. And it works on my system with NC=
T6775F.

Is there the option that auto-detection was wrong and I have a=20
completely different chip?

>> This was the first problem.  The second problem occurs when I try to
>> control fan2 manually.  The "pwm2" file in sysfs is 255 for anything
>> above 2000 RPM, but as you can see above, the fan can do more (I've been
>> at 2600 RPM -- maybe it can do even more), but pwm2 stays at 255.
>>
> Looking through the datasheet, I did not find anything obvious. It might
> be possible that the PWM output frequency (register 2 bank 0) somehow aff=
ects
> the fan speed as well. What causes the fan speed to go higher in your sys=
tem ?

High temperature in Temperature Cruise mode.

My firmware setup interface actually provides me with both the options=20
"Target fan speed" and "Target temperature", but I have the impression=20
that while the driver reports that I'm in Temperature Cruise mode, the=20
fan speed does not vary that much, but it rather tries to keep the fan=20
speed constant unless temperature is completely out of range.

The fan speeds up only when I'm above 60=B0C, and even that with a certain =

delay, so under full load, I get above 70=B0C when my fans are=20
firmware-controlled...  That's basically the reason why I want software=20
control.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
