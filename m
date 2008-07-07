From: "Pierre-Hugues HUSSON" <phhusson@free.fr>
Date: Mon, 07 Jul 2008 18:54:04 +0000
Subject: [lm-sensors] New winbond chip: W83667HG
Message-Id: <200807072054.10321.phhusson@free.fr>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2182739203558538266=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============2182739203558538266==
Content-Type: multipart/signed; boundary="nextPart4204674.bGiYotThgf";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart4204674.bGiYotThgf
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,
I own a brand new motherboard: an Asus P5Q-E, which features some interesti=
ng=20
things concerning energy, like measuring the current CPU's consumption, or=
=20
live (down|up)clocking. So sensors-detect haven't found anything else than=
=20
coretemp, so i searched on the board what could enable such features and I=
=20
found a W83667HG-A chip, and google doesn't know anything about it else tha=
n=20
it's announcement (in English at=20
http://www.winbond.com.tw/hq/enu/NewsAndEvents/News/ProductAndTechnology/20=
080602en-2.htm=20
).
Its ID is, according to sensors-detect, 0xa513
So I looked a bit at W83627EHF driver, and tried a quick=20
modprobe w83627ehf force_id=3D0x8860
And almost everything actually works:
pwmconfig/fancontrol works when using a DC-controlled (don't know for pwm=20
controlled) fan, sensors command gives right (I guess so at least) answers,=
=20
here's a paste of it (with coretemp values to compare):
coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +58.0=C2=B0C  (high =3D +84.0=C2=B0C, crit =3D +100.0=C2=B0C)

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +57.0=C2=B0C  (high =3D +84.0=C2=B0C, crit =3D +100.0=C2=B0C)

coretemp-isa-0002
Adapter: ISA adapter
Core 2:      +56.0=C2=B0C  (high =3D +84.0=C2=B0C, crit =3D +100.0=C2=B0C)

coretemp-isa-0003
Adapter: ISA adapter
Core 3:      +56.0=C2=B0C  (high =3D +84.0=C2=B0C, crit =3D +100.0=C2=B0C)

w83627ehf-isa-0290
Adapter: ISA adapter
VCore:       +1.14 V  (min =3D  +0.00 V, max =3D  +1.74 V)
in1:        +11.19 V  (min =3D +10.24 V, max =3D  +8.03 V)   ALARM
AVCC:        +3.33 V  (min =3D  +0.80 V, max =3D  +0.77 V)   ALARM
3VCC:        +3.30 V  (min =3D  +3.38 V, max =3D  +1.09 V)   ALARM
in4:         +1.67 V  (min =3D  +2.02 V, max =3D  +1.23 V)   ALARM
in5:         +2.04 V  (min =3D  +0.19 V, max =3D  +0.07 V)   ALARM
in6:         +4.40 V  (min =3D  +1.72 V, max =3D  +3.33 V)   ALARM
VSB:         +3.41 V  (min =3D  +2.21 V, max =3D  +1.57 V)   ALARM
VBAT:        +1.57 V  (min =3D  +3.47 V, max =3D  +1.36 V)   ALARM
in9:         +0.00 V  (min =3D  +0.01 V, max =3D  +0.18 V)   ALARM
Case Fan:      0 RPM  (min =3D 3515 RPM, div =3D 128)  ALARM
CPU Fan:       0 RPM  (min =3D 3515 RPM, div =3D 128)  ALARM
Aux Fan:       0 RPM  (min =3D 10546 RPM, div =3D 128)  ALARM
fan4:       1081 RPM  (min =3D 1318 RPM, div =3D 32)  ALARM
fan5:          0 RPM  (min =3D 5273 RPM, div =3D 128)  ALARM
Sys Temp:    +41.0=C2=B0C  (high =3D +106.0=C2=B0C, hyst =3D  +5.0=C2=B0C) =
 sensor =3D thermistor
CPU Temp:    +57.0=C2=B0C  (high =3D +80.0=C2=B0C, hyst =3D +75.0=C2=B0C)  =
sensor =3D diode
AUX Temp:    +17.5=C2=B0C  (high =3D +80.0=C2=B0C, hyst =3D +75.0=C2=B0C)  =
sensor =3D thermistor
cpu0_vid:   +1.219 V

The 17.5=C2=B0C temp is surely false (the ambiant temperature is around 25=
=C2=B0C, and i=20
use aircooling ...), and don't know what's supposed to be cpu0_vid, in4, in=
5=20
(maybe RAM voltage ?) and in6,but everything else works, so i guess you can=
=20
add this chip as-is.
If you need some more informations or some tests, just ask :)
So thank you for all your good work :)

=2D-=20
HUSSON Pierre-Hugues
phhusson@free.fr

--nextPart4204674.bGiYotThgf
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIcmZSe5aadcQEw5cRAigvAKCAMlaYvjbs2m7gppb6BIqdo+TGKgCfdM7x
fsGKZm6u8KLnMjLvbqiiRVY=
=CIV0
-----END PGP SIGNATURE-----

--nextPart4204674.bGiYotThgf--


--===============2182739203558538266==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2182739203558538266==--
