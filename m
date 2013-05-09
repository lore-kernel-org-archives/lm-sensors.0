From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 09 May 2013 17:20:45 +0000
Subject: Re: [lm-sensors] [nct6775] Asus P8Z77-M Pro (#8)
Message-Id: <20130509172045.GA7593@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Andre,

On Thu, May 09, 2013 at 08:23:47AM -0700, Andre Schmidt wrote:
> Got an Asus P8Z77-M Pro board and i assume it has the NCT6779 chip, but `=
sensors` output seems to have some wrong values:
>=20
> ```
> nct6779-isa-0290
> Adapter: ISA adapter
> in0:                    +0.91 V  (min =3D  +0.00 V, max =3D  +1.74 V)
> in1:                    +1.02 V  (min =3D  +0.00 V, max =3D  +0.00 V)  AL=
ARM
> in2:                    +3.38 V  (min =3D  +0.00 V, max =3D  +0.00 V)  AL=
ARM
> in3:                    +3.38 V  (min =3D  +0.00 V, max =3D  +0.00 V)  AL=
ARM
> in4:                    +1.02 V  (min =3D  +0.00 V, max =3D  +0.00 V)  AL=
ARM
> in5:                    +2.04 V  (min =3D  +0.00 V, max =3D  +0.00 V)  AL=
ARM
> in6:                    +0.27 V  (min =3D  +0.00 V, max =3D  +0.00 V)  AL=
ARM
> in7:                    +3.42 V  (min =3D  +0.00 V, max =3D  +0.00 V)  AL=
ARM
> in8:                    +3.36 V  (min =3D  +0.00 V, max =3D  +0.00 V)  AL=
ARM
> in9:                    +1.06 V  (min =3D  +0.00 V, max =3D  +0.00 V)  AL=
ARM
> in10:                   +0.21 V  (min =3D  +0.00 V, max =3D  +0.00 V)  AL=
ARM
> in11:                   +0.17 V  (min =3D  +0.00 V, max =3D  +0.00 V)  AL=
ARM
> in12:                   +0.18 V  (min =3D  +0.00 V, max =3D  +0.00 V)  AL=
ARM
> in13:                   +0.17 V  (min =3D  +0.00 V, max =3D  +0.00 V)  AL=
ARM
> in14:                   +0.18 V  (min =3D  +0.00 V, max =3D  +0.00 V)  AL=
ARM
> fan1:                     0 RPM  (min =3D    0 RPM)
> fan2:                  1208 RPM  (min =3D    0 RPM)
> fan3:                   724 RPM  (min =3D    0 RPM)
> fan4:                   752 RPM  (min =3D    0 RPM)
> fan5:                     0 RPM  (min =3D    0 RPM)
> SYSTIN:                 +26.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0=
C)  ALARM  sensor =3D thermistor
> CPUTIN:                 +27.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0=
C)  sensor =3D thermistor
> AUXTIN0:               +101.0=B0C  (high =3D  +0.0=B0C, hyst =3D +64.0=B0=
C)  sensor =3D thermistor
> AUXTIN1:               +105.0=B0C  (high =3D +75.0=B0C, hyst =3D  +0.0=B0=
C)  sensor =3D thermistor
> AUXTIN2:               +105.0=B0C  (high =3D +64.0=B0C, hyst =3D +26.0=B0=
C)  sensor =3D thermistor
> AUXTIN3:                +16.0=B0C  (high =3D  +0.0=B0C, hyst =3D +27.0=B0=
C)  sensor =3D thermal diode
> PCH_CHIP_CPU_MAX_TEMP:   +0.0=B0C =20
> PCH_CHIP_TEMP:           +0.0=B0C =20
> PCH_CPU_TEMP:            +0.0=B0C =20
> PCH_MCH_TEMP:            +0.0=B0C =20
> intrusion0:            ALARM
> intrusion1:            ALARM
> ```
>=20
> * `in*` has no min/max values
> * `SYSTIN` has no high/hyst values

Probably because they are not configured. You'll have to define limits in t=
he
sensors configuration file and write the limits into the driver with "senso=
rs -s".

> * `AUXTIN0/1/2` has unrealistic values (i don't know what AUXTIN is)

AUXTINx are temperature sensor input pins on the NCT6779.

Most likely you see odd values because the sensors are not connected to any=
thing
on the board. I'll have a look into the driver to make sure the limit regis=
ters
are correct; I am a bit concerned about the odd values for both "high" and =
"hyst".

> * `intrusion0/1` alarm. (minor, don't actually care)
>=20
Does the chassis have intrusion detection headers, and are those connected =

and operational ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
