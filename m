From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Wed, 03 Oct 2007 17:41:10 +0000
Subject: Re: [lm-sensors] f71882fg and MSI K9AG Neo2-Digital
Message-Id: <4703D436.9030500@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <47011C45.5010808@thelangners.de>
In-Reply-To: <47011C45.5010808@thelangners.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Roland Langner wrote:
> Hans de Goede schrieb:
>>> Roland Langner wrote:
>>>>> Hi,
>>>>>
>>>>> here is my sensors output for MSI K9AG Neo2-Digital
>>>>>
>>>>> k8temp-pci-00c3
>>>>> Adapter: PCI adapter
>>>>> Core0 Temp:
>>>>>              +15=B0C
>>>>> Core1 Temp:
>>>>>              +15=B0C
>>>>>
>>>>> f71882fg-isa-0600
>>>>> Adapter: ISA adapter
>>>>> 3.3V:      +3.34 V
>>>>> Vcore:     +0.98 V  (max =3D  +2.04 V)
>>>>> Vram:      +2.19 V
>>>>> 5VSB:      +5.05 V
>>>>> +5V:       +3.78 V
>>>>> 12V:       +6.51 V
>>>>> Vchip:     +0.48 V
>>>>> 3VSB:      +3.33 V
>>>>> Battery:   +3.20 V
>>>>> CPU:       844 RPM
>>>>> System:      0 RPM  ALARM
>>>>> Power:     960 RPM
>>>>> Aux:         0 RPM  ALARM
>>>>> CPU:          +9=B0C  (high =3D   +85=B0C, hyst =3D   +81=B0C)
>>>>>                     (crit =3D  +100=B0C, hyst =3D   +96=B0C)  sensor =
> transistor
>>>>> System:      +92=B0C  (high =3D   +85=B0C, hyst =3D   +81=B0C)  ALARM
>>>>>                     (crit =3D  +100=B0C, hyst =3D   +96=B0C)  sensor =
> thermistor
>>>>> Temp3:       +26=B0C  (high =3D   +70=B0C, hyst =3D   +68=B0C)
>>>>>                     (crit =3D   +85=B0C, hyst =3D   +83=B0C)  sensor =
> thermistor
>>>>>
>>>>> Here the config:
>>>>>
>>>>> chip "f71882fg-*"
>>>>>
>>>>> # Temperature
>>>>>     label temp1       "CPU"
>>>>>     label temp2       "System"
>>>>>     label temp3       "Temp3"
>>>>>
>>>>> # Fans
>>>>>     label fan1        "CPU"
>>>>>     label fan2        "System"
>>>>>     label fan3        "Power"
>>>>>     label fan4        "Aux"
>>>>>
>>>>> # Voltage
>>>>>     label in0 "3.3V"
>>>>>     label in1 "Vcore"
>>>>>     label in2 "Vram"
>>>>>     label in3 "5VSB"
>>>>>     label in4 "+5V"
>>>>>     label in5 "12V"
>>>>>     label in6 "Vchip"
>>>>>     label in7 "3VSB"
>>>>>     label in8 "Battery"
>>>>>
>>>>> # never change the in0, in7 and in8 compute, these are hardwired
> in the
>>>>> chip!
>>>>>     compute in0 (@ * 2), (@ / 2)
>>>>>     compute in2 (@ * 2), (@ / 2)
>>>>>     compute in3 (@ * (1+200/47)), (@ / (1+200/47))
>>>>>     compute in4 (@ * (1+200/47)), (@ / (1+200/47))
>>>>>     compute in5 (@ * (1+200/20)), (@ / (1+200/20))
>>>>>     compute in7 (@ * 2), (@ / 2)
>>>>>     compute in8 (@ * 2), (@ / 2)
>>>>>
>>>>>
>>>>>
>>>>> Some Voltages are not right. (Vcore is)
>>>>> The board has 3 Fan-conectors. Fan at connector 3 doesn't show up.
>>>>> CPU Temp is to low.
>>>>>
>>>>> Config is a variation of msi P965 Platinum.
>>>>> Can someone help me with the config?
>>>>>
>>> Sure, I'm the writer and maintainer of the f71882fg driver and I'll try
>>> to help. Can you for starters please write down the BIOS sensors
>>> readings (all of them, in order they appear in the BIOS) and post those,
>>> then I can try to puzzle the pieces together.
>>>
> Hi Hans,
>=20
> sorry, yesterday i didn't replay to the list.
>=20
> thanks for the driver and the help.
>=20
> Here are the BIOS-Values:
>=20
> CPU Temp:   10=B0C
> System Temp 25=B0C
> CPU Fan Speed  843
> Sys Fan1 Speed 964
> CPU Vcore   0.984V
> 3.3VCC      3.344V
> 5V          5.088V
> 12V        12.056V
> 3.3V SB     3.344V
>=20
>=20
> CPU Temp in BIOS seems also a bit to low (room temp is 15=B0C)
>=20

Hmm,

I'm afraid I cannot find any reasonable mapping between the BIOS readings a=
nd=20
the sensors readings using well known multipliers. So I'm afraid I cannot h=
elp you.

The BIOS only sees 2 fans too, so I guess the 3th connector simply isn't ho=
oked=20
up to the chip (which is a pitty, as the chip does have the capability to=20
monitor more then 2 fans). Also the CPU reading indeed is wrong. Probably t=
he=20
BIOS hasn't configured the sensor type correctly. You could go and see if t=
here=20
is a BIOS update for this, esp since the reading in the BIOS itself is clea=
rly=20
wrong too.

As for the mapping, you could try sending MSI a polite mail asking which=20
voltages are hooked up to which pins and what dividers they are using.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
