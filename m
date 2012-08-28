From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 28 Aug 2012 11:19:21 +0000
Subject: Re: [lm-sensors] Configuration file for Intel DQ67EP Mini-ITX board
Message-Id: <20120828131921.54159423@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <503B75E0.8080006@pacanka.com>
In-Reply-To: <503B75E0.8080006@pacanka.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Mon, 27 Aug 2012 09:28:00 -0400, Who Carez? wrote:
> Hello,
>=20
> Attached, you will find the .conf file I use for my DQ67EP. Here are the =

> results I get, with i3-2100t.
>=20
> First raw:
>=20
> Adapter: ISA adapter
> in0:            +0.76 V  (min =3D  +0.00 V, max =3D  +1.74 V)
> in1:            +0.77 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
> in2:            +3.41 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> in3:            +3.41 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> in4:            +1.28 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
> in5:            +1.47 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
> in6:            +1.04 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
> in7:            +3.30 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> in8:            +3.20 V  (min =3D  +2.70 V, max =3D  +3.30 V)
> fan1:             0 RPM  (min =3D    0 RPM, div =3D 128)
> fan2:           937 RPM  (min =3D    0 RPM, div =3D 32)  ALARM
> fan3:             0 RPM  (min =3D    0 RPM, div =3D 128)
> fan4:             0 RPM  (div =3D 128)
> SYSTIN:         +35.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  ALAR=
M  sensor=20
> =3D diode
> CPUTIN:         +38.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sens=
or =3D diode
> PECI Agent 0:   +36.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sens=
or =3D=20
> Intel PECI
> PCH_CHIP_TEMP:  +51.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)
> PECI Agent 1:    +0.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)
> cpu0_vid:      +0.000 V
> intrusion0:    OK
>=20
> and now, with the attached file:
>=20
> Adapter: ISA adapter
> Vcore:        +0.77 V  (min =3D  +0.60 V, max =3D  +1.60 V)
> +12V:        +12.29 V  (min =3D +11.14 V, max =3D +12.93 V)
> AVCC:         +3.41 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> +3.3V:        +3.41 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> +5V:          +5.12 V  (min =3D  +4.70 V, max =3D  +5.31 V)
> +1.5V:        +1.47 V  (min =3D  +1.40 V, max =3D  +1.60 V)
> PCH:          +1.04 V  (min =3D  +0.60 V, max =3D  +1.60 V)
> 3VSB:         +3.30 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> Vbat:         +3.20 V  (min =3D  +2.70 V, max =3D  +3.30 V)
> Rear fan:       0 RPM  (min =3D  251 RPM, div =3D 128)
> CPU fan:      958 RPM  (min =3D  251 RPM, div =3D 32)
> DIMM temp:    +36.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor=
 =3D diode
> VR temp:      +38.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor=
 =3D diode
> CPU temp:     +36.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor=
 =3D Intel PECI
> PCH temp:     +52.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)
> intrusion0:  OK
>=20
> Please see the file.

Added to the wiki:

http://www.lm-sensors.org/wiki/Configurations/Intel/DQ67EP

Thanks for your contribution.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
