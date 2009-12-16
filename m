From: mikp <mikpolniak@roadrunner.com>
Date: Wed, 16 Dec 2009 20:33:00 +0000
Subject: Re: [lm-sensors] LM-Sensor support for W83667HG-A (or B)
Message-Id: <20091216153300.4f5b4fda.mikpolniak@roadrunner.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4B2923F1.7020403@web.de>
In-Reply-To: <4B2923F1.7020403@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Wed, 16 Dec 2009 19:16:17 +0100
Norbert Jurkeit <norbert.jurkeit@web.de> wrote:

> Dear all,
>=20
> recently I got a new PC with an ASRock P55DE3 mainboard. The first run
> of sensors-detect contained in openSUSE 11.2 reported an unknown chip
> with ID 0xb353. The newest version of sensors-detect told me that
> "Nuvoton W83667HG-B Super IO Sensors" at address 0x290 was found,
> although the chip on the mainboard is actually labelled W83667HG-A.
>=20
> Unfortunatately, sensors-detect also described this chip as unsupported
> and no available kernel module could be loaded instantly. Then I found
> out that driver w83627ehf now also supports the W83667HG (without A or
> B) and gave it a try with "modprobe w83627ehf force_id=3D0xa510". Together
> with the included configuration file I now get reasonable readings:
>=20
> $ sensors
> w83667hg-isa-0290
> Adapter: ISA adapter
> VCore:       +0.89 V  (min =3D  +0.62 V, max =3D  +1.47 V)
> VIN0 +12V:  +11.99 V  (min =3D +11.40 V, max =3D +12.62 V)
> AVCC:        +3.41 V  (min =3D  +3.14 V, max =3D  +3.47 V)
> 3VCC:        +3.41 V  (min =3D  +3.14 V, max =3D  +3.47 V)
> VIN2 +5V:    +5.11 V  (min =3D  +4.75 V, max =3D  +5.26 V)
> 3VSB:        +3.36 V  (min =3D  +3.14 V, max =3D  +3.47 V)
> VBat:        +3.18 V  (min =3D  +2.40 V, max =3D  +3.60 V)
> CPU Fan:    1132 RPM  (min =3D 1102 RPM, div =3D 8)
> Sys Temp:    +33.0=B0C  (high =3D +50.0=B0C, hyst =3D +47.0=B0C)  sensor =
=3D thermistor
> CPU Temp:    +34.5=B0C  (high =3D +60.0=B0C, hyst =3D +57.0=B0C)  sensor =
=3D thermistor
> cpu0_vid:   +0.075 V
>=20
> $ cat /etc/sensors3.conf
> chip "w83667hg-*"
>=20
>     label in0 "VCore"
>     label in1 "VIN0 +12V"
>     label in2 "AVCC"   =20
>     label in3 "3VCC"   =20
>     label in4 "VIN1"   =20
>     label in5 "VIN2 +5V"
>     label in7 "3VSB"   =20
>     label in8 "VBat"   =20
>     label fan1 "Case Fan"
>     label fan2 "CPU Fan"
>     label fan3 "Aux Fan"
>     label temp1 "Sys Temp"
>     label temp2 "CPU Temp"
>     label temp3 "AUX Temp"
>=20
>     compute in1 (56/10+1)*@, @/(56/10+1)
>     compute in5 (20/10+1)*@, @/(20/10+1)
>                                       =20
>     set in0_min 0.65*0.95             =20
>     set in0_max 1.4*1.05              =20
>     set in1_min 12*0.95               =20
>     set in1_max 12*1.05               =20
>     set in2_min 3.3*0.95              =20
>     set in2_max 3.3*1.05              =20
>     set in3_min 3.3*0.95              =20
>     set in3_max 3.3*1.05              =20
>     set in4_min 0                     =20
>     set in4_max 2.048                 =20
>     set in5_min 5*0.95
>     set in5_max 5*1.05
>     set in7_min 3.3*0.95
>     set in7_max 3.3*1.05
>     set in8_min 3*0.8
>     set in8_max 3*1.2
>     set fan2_min 1100
>     set temp1_max 50
>     set temp1_max_hyst 47
>     set temp2_max 60
>     set temp2_max_hyst 57
>=20
>     ignore in4
>     ignore fan1
>     ignore fan3
>     ignore temp3
>=20
> Why do I tell you this? First, I hope this information helps other
> users. Second, if no reasons speak against it, official support for
> device ID 0xb353 could be included into future versions of w83627ehf.
>

Thanks for that info. It works fine for w83667HG-A on my Asus P7P55D board.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
