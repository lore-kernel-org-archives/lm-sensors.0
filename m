From: "Soeren D. Schulze" <soeren.d.schulze@gmx.de>
Date: Sun, 06 Nov 2011 19:18:41 +0000
Subject: Re: [lm-sensors] Intel 2500K stock fan control
Message-Id: <4EB6DD91.7040606@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <4EB6CC0B.8050909@gmx.de>
In-Reply-To: <4EB6CC0B.8050909@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Am 06.11.2011 19:45, schrieb Jean Delvare:
> On Sun, 06 Nov 2011 19:03:55 +0100, Soeren D. Schulze wrote:
>> It's me with my NCT6776 again.
>>
>> It doesn't seem to be the driver that is causing problems.
>>
>> When I force the PWM to full duty cycle at low CPU temperature, I get
>> about 2200 RPM.  I get the same thing when I disconnect the PWM pin
>> completely (so apparently the driver sets the PWM duty cycle correctly).
>> Voltage on the supply pin of the fan is 12 V.
>>
>> When put load on the system and CPU temperature rises, though, the fan
>> RPM rise up to 2800.  The question is:  What is the reason for this RPM
>> rise?  It can't be the PWM signal, as the PWM pin is disconnected.  It
>> can't be the voltage, because the voltage stays at 12 V (I measured it).
>>
>> The only explanation that comes to my mind is that the fan does not
>> actually go to full speed even at full PWM duty cycle until it senses
>> high temperature itself.  This implies that the fan has some integrated
>> temperature sensor.
>>
>> Is this possible?  And if so, why would they do such a thing?
>=20
> Yes, this is possible, I've seen this before.
>=20
> Reason is that it allows for totally software and hardware agnostic fan
> speed control. CPU safety is guaranteed by the fan itself and there is
> no way to screw it (short of removing or under-powering the fan itself.)
>=20
> Obviously the major drawback is that it takes control away from the
> user, so I would stay away from such hardware if I can. But for lambda
> users it makes some sense.

Eww...

In that case, they should the high speed make available to UEFI/software
anyway.  If the fan thinks the speed the user chose is too low, it can
still increase it.

But what it does is exactly the opposite: if the user chooses a low
speed, the fan speed does not increase, either, even at high temperature.

And if they *must* do it this way, the fan should speed up long before
70=B0C (which is a value I actually reach).

But OK, this means there is nothing wrong with any hardware or driver,
but it's just an ignorantly designed fan.


So thanks a lot or your response,

S=F6ren

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
