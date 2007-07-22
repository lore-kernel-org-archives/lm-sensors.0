From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 22 Jul 2007 08:05:35 +0000
Subject: Re: [lm-sensors] sensors problem
Message-Id: <20070722100535.060375d1@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <017801c1eb62$f826cfa0$c36fa83e@compclub.sk>
In-Reply-To: <017801c1eb62$f826cfa0$c36fa83e@compclub.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Ryan,

On Mon, 9 Jul 2007 11:07:06 -0500, Ryan Underwood wrote:
>=20
> I have a MSI BXMaster, and lm-sensors 2.10.3 from Debian and kernel
> 2.6.21.1.  Why am I having the following issues in the sensors output:
>=20
> $ sensors
> w83782d-i2c-0-2d
> Adapter: SMBus PIIX4 adapter at 5000
> VCore 1:   +1.47 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> VCore 2:   +1.50 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> +3.3V:     +3.41 V  (min =3D  +2.82 V, max =3D  +3.79 V)
> +5V:       +5.05 V  (min =3D  +5.75 V, max =3D  +4.27 V)       ALARM
> +12V:     +12.34 V  (min =3D +15.50 V, max =3D  +7.72 V)       ALARM
> -12V:     -12.11 V  (min =3D  -9.40 V, max =3D  +3.10 V)       ALARM
> -5V:       -5.15 V  (min =3D  +5.10 V, max =3D  +1.89 V)       ALARM
> V5SB:      +5.05 V  (min =3D  +4.87 V, max =3D  +1.69 V)       ALARM
> VBat:      +2.90 V  (min =3D  +0.85 V, max =3D  +3.57 V)
> fan1:     3443 RPM  (min =3D 1670 RPM, div =3D 8)
> fan2:        0 RPM  (min =3D  669 RPM, div =3D 8)              ALARM
> fan3:     5232 RPM  (min =3D 2922 RPM, div =3D 2)
> temp1:       +42=B0C  (high =3D  +124=B0C, hyst =3D   -28=B0C)   sensor =
=3D thermistor     =20
> temp2:     +39.0=B0C  (high =3D   +80=B0C, hyst =3D   +75=B0C)   sensor =
=3D thermistor     =20
> temp3:     +40.5=B0C  (high =3D   +80=B0C, hyst =3D   +75=B0C)   sensor =
=3D thermistor     =20
> vid:      +1.500 V  (VRM Version 8.5)
> alarms:
> beep_enable:
>           Sound alarm enabled
>=20
> It appears the sensors themselves are correct, but the ranges are all wro=
ng...
> in fact the range slope is reversed.  I am using the default sensors.conf
> packaged with lm-sensors and ensured that it was active with sensors -s.

If you are using the stock 2.10.3 sensors.conf, set statements are
commented out by default. We did this because they were causing trouble
(beeps, reboot etc.) on some systems. It seems that your BIOS leaves
most limits uninitialized. Uncomment the set statements in the
w83782d-* section, run "sensors -s" again and it should be better.

For some features (e.g. fan2) you will have to add your own set
statement (set fan2_min 0) or even better ignore this fan if you don't
have it (ignore fan2).

> Not sure when this started, I had my monitoring script disabled for a whi=
le.
> At one point (year ago?) it worked fine.

Until 2.10.0, set statements were enabled by default.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
