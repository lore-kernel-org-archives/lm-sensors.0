From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Mon, 01 Oct 2007 17:21:10 +0000
Subject: Re: [lm-sensors] f71882fg and MSI K9AG Neo2-Digital
Message-Id: <47012C86.6060302@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <47011C45.5010808@thelangners.de>
In-Reply-To: <47011C45.5010808@thelangners.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Roland Langner wrote:
> Hi,
>=20
> here is my sensors output for MSI K9AG Neo2-Digital
>=20
> k8temp-pci-00c3
> Adapter: PCI adapter
> Core0 Temp:
>              +15=B0C
> Core1 Temp:
>              +15=B0C
>=20
> f71882fg-isa-0600
> Adapter: ISA adapter
> 3.3V:      +3.34 V
> Vcore:     +0.98 V  (max =3D  +2.04 V)
> Vram:      +2.19 V
> 5VSB:      +5.05 V
> +5V:       +3.78 V
> 12V:       +6.51 V
> Vchip:     +0.48 V
> 3VSB:      +3.33 V
> Battery:   +3.20 V
> CPU:       844 RPM
> System:      0 RPM  ALARM
> Power:     960 RPM
> Aux:         0 RPM  ALARM
> CPU:          +9=B0C  (high =3D   +85=B0C, hyst =3D   +81=B0C)
>                     (crit =3D  +100=B0C, hyst =3D   +96=B0C)  sensor =3D =
transistor
> System:      +92=B0C  (high =3D   +85=B0C, hyst =3D   +81=B0C)  ALARM
>                     (crit =3D  +100=B0C, hyst =3D   +96=B0C)  sensor =3D =
thermistor
> Temp3:       +26=B0C  (high =3D   +70=B0C, hyst =3D   +68=B0C)
>                     (crit =3D   +85=B0C, hyst =3D   +83=B0C)  sensor =3D =
thermistor
>=20
>=20
> Here the config:
>=20
> chip "f71882fg-*"
>=20
> # Temperature
>     label temp1       "CPU"
>     label temp2       "System"
>     label temp3       "Temp3"
>=20
> # Fans
>     label fan1        "CPU"
>     label fan2        "System"
>     label fan3        "Power"
>     label fan4        "Aux"
>=20
> # Voltage
>     label in0 "3.3V"
>     label in1 "Vcore"
>     label in2 "Vram"
>     label in3 "5VSB"
>     label in4 "+5V"
>     label in5 "12V"
>     label in6 "Vchip"
>     label in7 "3VSB"
>     label in8 "Battery"
>=20
> # never change the in0, in7 and in8 compute, these are hardwired in the
> chip!
>     compute in0 (@ * 2), (@ / 2)
>     compute in2 (@ * 2), (@ / 2)
>     compute in3 (@ * (1+200/47)), (@ / (1+200/47))
>     compute in4 (@ * (1+200/47)), (@ / (1+200/47))
>     compute in5 (@ * (1+200/20)), (@ / (1+200/20))
>     compute in7 (@ * 2), (@ / 2)
>     compute in8 (@ * 2), (@ / 2)
>=20
>=20
>=20
> Some Voltages are not right. (Vcore is)
> The board has 3 Fan-conectors. Fan at connector 3 doesn't show up.
> CPU Temp is to low.
>=20
> Config is a variation of msi P965 Platinum.
> Can someone help me with the config?
>=20

Sure, I'm the writer and maintainer of the f71882fg driver and I'll try to =

help. Can you for starters please write down the BIOS sensors readings (all=
 of=20
them, in order they appear in the BIOS) and post those, then I can try to=20
puzzle the pieces together.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
