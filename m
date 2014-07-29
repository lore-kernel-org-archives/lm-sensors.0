From: Jean Delvare <jdelvare@suse.de>
Date: Tue, 29 Jul 2014 07:10:13 +0000
Subject: Re: [lm-sensors] Sensors configuration for Intel D201GLY2 motherboard
Message-Id: <20140729091013.01366c68@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAKWkBZiTFXYvuq8jH8y2+HzxtY2GdJD17_c=3k9PZBLvoFcSNA@mail.gmail.com>
In-Reply-To: <CAKWkBZiTFXYvuq8jH8y2+HzxtY2GdJD17_c=3k9PZBLvoFcSNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Salut =C9ric,

On Mon, 28 Jul 2014 16:50:48 +0200, =C9ric Le Bras wrote:
> Hi Jean,
>=20
> I have followed your advices and updated the D201GLY2. Here it is:
>=20
>=20
> # libsensors configuration file
> # -----------------------------
> #
> # Configuration file for Intel D201GLY2 motherboard
> # Hardware monitor subsystem controlled by Winbond W83627DHG-B I/O
> controller.
> # Created using information from BIOS and board documentation.
>=20
> chip "w83627dhg-*"
>=20
>     label in1 "+12.0V"
>     label in4 "+5V"
>     label in6 "+1.5V"
>=20
> # in5 is obvioulsy unconnected, so ignore it

Typo: obviously

>     ignore in5
>=20
>     compute in1 @*(55/8),@/(55/8)
>     compute in4 @*(1+18/10),@/(1+18/10)
>=20
>     set in1_min 12.0 * 0.95
>     set in1_max 12.0 * 1.05
>     set in4_min  5.0 * 0.90
>     set in4_max  5.0 * 1.10

As for +12V, the ATX specification says +5V should stay within +/- 5%.

>     set in6_min  1.5 * 0.90
>     set in6_max  1.5 * 1.10
>=20
>     label fan1 "Chassis fan"
>     label fan2 "CPU fan"
>=20
> # By default the D201GLY2 has a passive heatsink. If the optional active
> # heatsink is present, then one of the following lines is to be commented
> out
> # (very likely fan2, though not tried).
>     ignore fan2
>     ignore fan3
>     ignore fan4
>=20
>     label temp1 "Sys temp"
>     label temp2 "CPU temp"
>     ignore temp3
>=20
>     ignore cpu0_vid
>     ignore intrusion0

I've updated the wiki page, thanks for your contribution.

> And here is the output from sensors:
> eric@tangha ~/srv_conf % sensors
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:       +55.0=B0C  (high =3D +100.0=B0C, crit =3D +100.0=B0C)
>=20
> w83627dhg-isa-0290
> Adapter: ISA adapter
> Vcore:        +1.34 V  (min =3D  +0.00 V, max =3D  +1.74 V)
> +12.0V:      +11.82 V  (min =3D +11.38 V, max =3D +12.60 V)
> AVCC:         +3.25 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> +3.3V:        +3.25 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> +5V:          +5.06 V  (min =3D  +4.50 V, max =3D  +5.51 V)
> +1.5V:        +1.56 V  (min =3D  +1.35 V, max =3D  +1.65 V)
> 3VSB:         +3.25 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> Vbat:         +3.09 V  (min =3D  +2.70 V, max =3D  +3.63 V)
> Chassis fan: 2721 RPM  (min =3D  777 RPM, div =3D 8)
> Sys temp:     +43.0=B0C  (high =3D +43.0=B0C, hyst =3D +14.0=B0C)  ALARM =
 sensor =3D thermistor
> CPU temp:     +49.5=B0C  (high =3D +110.0=B0C, hyst =3D +75.0=B0C)  senso=
r =3D CPU diode

Looks good :)

One possible improvement would be to set in0_min and in0_max limits, as
0 to 1.74 V is way too permissive. You should check the allowed voltage
range for your CPU and allow for a 5% deviance.

Also I see that the fan1 limit changed so I guess it is also
uninitialized. You should set it to something that makes sense for your
case fan. This would avoid spurious alarms and would also let the
driver select the right fan clock divisor so that you get the most
accurate readings as possible.

--=20
Jean Delvare
http://jdelvare.nerim.net/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
