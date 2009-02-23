From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 23 Feb 2009 16:23:59 +0000
Subject: Re: [lm-sensors] W83667HG on ASUS P6T6 WS Revolution
Message-Id: <20090223172359.293762cd@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <498B944A.3060502@ioerror.us>
In-Reply-To: <498B944A.3060502@ioerror.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Michael,

On Thu, 05 Feb 2009 20:37:14 -0500, Michael Hampton wrote:
> This is just a report to state that the two patches posted to this list
> previously [1] [2] got my sensors up and running on my new ASUS P6T6 WS
> Revolution board. They aren't perfect yet, as temp3 is reporting an
> obviously incorrect value, and I haven't figured out which sensors map
> to which physical devices on the motherboard yet, but it seems to be OK.
> Perhaps temp3 just isn't hooked up to anything.

On this chip, in6 and temp3 share the same pin, so you can't have both.
Which one is present depends on the motherboard wiring. So it is
possible that on your chip the pin is used for in6. Ideally we'd have a
way to know which is there and only export that reading. Gong Jun is
supposedly working on this. Gong Jun, any progress? How is the chip
told which function is used? Pin strapping, configuration register...?

For the labels, you should be able to figure out the fan and temp
labels by comparing with the BIOS. For voltages that's a little more
difficult, but I would assume that the internal voltages are the same
as those of the W83627DHG:

    label in0 "Vcore"
    label in2 "AVCC"
    label in3 "VCC"
    label in7 "3VSB"
    label in8 "Vbat"

    set in2_min  3.3 * 0.90
    set in2_max  3.3 * 1.10
    set in3_min  3.3 * 0.90
    set in3_max  3.3 * 1.10
    set in7_min  3.3 * 0.90
    set in7_max  3.3 * 1.10
    set in8_min  3.0 * 0.90
    set in8_max  3.0 * 1.10

> For the sake of convenience I've merged the two patches together and
> included it here. Hopefully this gets into a future kernel release, and
> soon.
>=20
> w83667hg-isa-0290
> Adapter: ISA adapter
> in0:         +1.22 V  (min =3D  +0.00 V, max =3D  +1.74 V) =20
> in1:         +1.70 V  (min =3D  +0.02 V, max =3D  +0.00 V)   ALARM
> in2:         +3.22 V  (min =3D  +1.02 V, max =3D  +0.26 V)   ALARM
> in3:         +3.18 V  (min =3D  +2.59 V, max =3D  +0.00 V)   ALARM
> in4:         +1.70 V  (min =3D  +0.13 V, max =3D  +1.04 V)   ALARM
> in5:         +2.04 V  (min =3D  +0.77 V, max =3D  +0.62 V)   ALARM
> in6:         +1.02 V  (min =3D  +0.58 V, max =3D  +0.13 V)   ALARM
> in7:         +3.36 V  (min =3D  +0.02 V, max =3D  +1.34 V)   ALARM
> in8:         +3.31 V  (min =3D  +2.91 V, max =3D  +1.22 V)   ALARM
> fan1:       1854 RPM  (min =3D 1288 RPM, div =3D 8)
> fan2:       1917 RPM  (min =3D 14062 RPM, div =3D 16)  ALARM
> fan3:       1795 RPM  (min =3D 5273 RPM, div =3D 4)  ALARM
> fan4:       1896 RPM  (min =3D 1298 RPM, div =3D 8)
> fan5:       2410 RPM  (min =3D 2636 RPM, div =3D 8)  ALARM
> temp1:       +37.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +4.0=B0C)  ALARM  =
sensor > thermistor
> temp2:       +50.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D diode
> temp3:      +124.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  ALARM  =
sensor > thermistor
> cpu0_vid:   +1.950 V
>=20
> [1]
> http://lists.lm-sensors.org/pipermail/lm-sensors/2008-December/024903.html
> [2]
> http://lists.lm-sensors.org/pipermail/lm-sensors/2009-January/025232.html
>=20


--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
