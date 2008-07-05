From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 05 Jul 2008 14:54:15 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: it87 support for 16-bit fan reading
Message-Id: <20080705165415.49d58d17@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <76366b180802102232o60442894gfca038eb4b6f181d@mail.gmail.com>
In-Reply-To: <76366b180802102232o60442894gfca038eb4b6f181d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sat, 5 Jul 2008 16:22:45 +0200, Bruno Pr=E9mont wrote:
> On Sat, 05 July 2008 Jean Delvare <khali@linux-fr.org> wrote:
> > I don't remember any change in the voltage computations. More likely
> > you simply need to tweak your configuration file to match your
> > motherboard wiring, as is the case with all motherboards. This
> > includes changing the labels and adjusting the compute statements as
> > well. We can help you a bit with this if you tell us all the voltage
> > labels and values displayed by your BIOS, and the voltages values
> > reported by "sensors -c /dev/null".
>=20
> Raw sensors readings:
>=20
>   it8712-isa-0e80
>   Adapter: ISA adapter
>   in0:         +1.17 V  (min =3D  +0.00 V, max =3D  +4.08 V)
>   in1:         +0.82 V  (min =3D  +0.00 V, max =3D  +4.08 V)
>   in2:         +3.01 V  (min =3D  +0.00 V, max =3D  +4.08 V)
>   in3:         +2.93 V  (min =3D  +0.00 V, max =3D  +4.08 V)
>   in4:         +1.25 V  (min =3D  +0.00 V, max =3D  +4.08 V)
>   in5:         +1.76 V  (min =3D  +0.00 V, max =3D  +4.08 V)
>   in6:         +1.60 V  (min =3D  +0.00 V, max =3D  +4.08 V)
>   in7:         +2.94 V  (min =3D  +0.00 V, max =3D  +4.08 V)
>   in8:         +3.26 V
>   fan1:       3245 RPM  (min =3D    0 RPM, div =3D 8)
>   fan2:       1520 RPM  (min =3D    0 RPM, div =3D 8)
>   temp1:       +20.0=B0C  (low  =3D  -1.0=B0C, high =3D +127.0=B0C)  sens=
or =3D thermal diode
>   temp2:       +48.0=B0C  (low  =3D  -1.0=B0C, high =3D +127.0=B0C)  sens=
or =3D thermal diode
>   temp3:       +25.0=B0C  (low  =3D  -1.0=B0C, high =3D +127.0=B0C)  sens=
or =3D transistor
>   cpu0_vid:   +1.550 V
>=20
> Bios readings:
>=20
>   CPU Temp: 33=B0C
>   System temp: 45=B0C
>   CPU FAN: 5769 RPM
>   Sys FAN: 1496 RPM
>=20
>   CPU Core: 1.1V
>   +1.2V:   1.168V
>   +3.3V:   3.008V
>   +5V:     4.992V
>   +1.8V:   1.76V
>=20
> Looking at those values there could be:
>   in0 =3D +1.2V

Unlikely. Vcore is almost always in0, and it seems to be the case
here. +1.2V would rather be in4.

>   in2 =3D +3.3V
>   in5 =3D +1.8V
>=20
> For the other voltages which do seem to be wired somehow even tough far l=
ess
> are mentionned in BIOS monitoring section it's hard to tell what they cou=
ld
> match...

The IT8712F can only measure voltages up to 4.08V directly. Other
voltages need scaling resistors. The nominal voltage after scaling is
typically 3V (3/4 of the full scale). in3 and in7 are almost 3V so they
are most probably voltages > 4V scaled down. I would guess in3 is +5V
and in7 maybe 5VSB. Now you have to figure out the scaling factor.
4.992/2.93 =3D 1.703. Typical factors for +5V are 1.666 and 1.68, the
later is the standard for the IT8712F so I'd say that's what you have.

in8 is normally the battery voltage, unscaled.

So my guess for the configuration of your board would be:

   label in0 "Vcore"
   label in2 "+3.3V"
   label in3 "+5V"
   label in4 "+1.2V"
   label in5 "+1.8V"
   label in7 "5VSB"
   label in8 "Vbat"

   compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
   compute in8 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)

It's a bit strange that +12V isn't monitored. And this leaves in1 and
in6 without labels. Maybe they aren't wired at all. Ideally you would
ask your motherboard manufacturer and they would tell you. The above is
just guesswork based on my personal experience, I might as well be
plain wrong ;)

> For temperatures:
> - temp1 is related to CPU temp (no idea what's the right formula, looks
>   like combination of offset and multiplier when compared to value
>   reported by k8temp-pci-00c3)
> - temp2 is system temp
> - temp3 is constant at 25=B0C and probably not wired at all

Indeed, 25=B0C constant for a thermistor usually means that there is no
thermistor but a dumb resistor instead. I've seen this many times...

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
