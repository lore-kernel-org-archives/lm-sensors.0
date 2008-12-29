From: Tobias Preclik <public@tobias.preclik.de>
Date: Mon, 29 Dec 2008 12:26:27 +0000
Subject: [lm-sensors] Error getting sensor data: w83627ehf/#34
Message-Id: <4958C1F3.9020108@tobias.preclik.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1949504950537203251=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============1949504950537203251==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigCF50CA29913BFB40F4F2DFF5"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCF50CA29913BFB40F4F2DFF5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,

i encountered a problem running sensord. I am running version 2.10.7 and
have a w83627ehf sensor chip on my P4V800D-X Asus mainboard. The kernel
is a Gentoo Linux kernel version 2.6.27. The syslog states the following:=


sensord started
Chip: w83627ehf-isa-0290
Adapter: ISA adapter
  Case Fan: 0 RPM (min =3D 0 RPM, div =3D 128)
  CPU Fan: 2481 RPM (min =3D 0 RPM, div =3D 4)
  Aux Fan: 0 RPM (min =3D 0 RPM, div =3D 128)
Error getting sensor data: w83627ehf/#34: Can't access procfs/sysfs file
sensord failed (23)

As I understand it I am supposed to add "#34" to the ignore list in the
corresponding chip section in /etc/sensors.conf. However this does not
fix the problem. The sensors tool does not complain btw:

w83627ehf-isa-0290
Adapter: ISA adapter
VCore:     +1.59 V  (min =3D  +0.00 V, max =3D  +1.85 V)
in1:      +12.04 V  (min =3D  +1.80 V, max =3D  +0.00 V) ALARM
AVCC:      +3.38 V  (min =3D  +0.00 V, max =3D  +0.00 V) ALARM
3VCC:      +3.36 V  (min =3D  +0.00 V, max =3D  +0.00 V) ALARM
in4:       +1.32 V  (min =3D  +0.01 V, max =3D  +0.00 V) ALARM
in5:       +1.71 V  (min =3D  +0.26 V, max =3D  +0.06 V) ALARM
in6:       +4.28 V  (min =3D  +0.00 V, max =3D  +0.00 V) ALARM
VSB:       +3.38 V  (min =3D  +0.00 V, max =3D  +0.00 V) ALARM
VBAT:      +3.28 V  (min =3D  +0.00 V, max =3D  +0.00 V) ALARM
in9:       +1.26 V  (min =3D  +0.00 V, max =3D  +0.00 V) ALARM
Case Fan:    0 RPM  (min =3D    0 RPM, div =3D 128) ALARM
CPU Fan:  2463 RPM  (min =3D    0 RPM, div =3D 4) ALARM
Aux Fan:     0 RPM  (min =3D    0 RPM, div =3D 128) ALARM
fan5:        0 RPM  (min =3D    0 RPM, div =3D 128)
Sys Temp:    +27=B0C  (high =3D    +0=B0C, hyst =3D    +0=B0C)  [thermist=
or] ALARM
CPU Temp:   +9.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  [CPU diod=
e ]
AUX Temp:  +77.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  [thermist=
or]


How can I fix this?

regards,
Tobias


--------------enigCF50CA29913BFB40F4F2DFF5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAklYwgEACgkQc8GdoDrONNFMmQCgsKHhZMhbQ4H1ZaIf7XmbMqdz
uoEAoOXy44bU70vC5a6HyNuYst21fDWd
=w7aL
-----END PGP SIGNATURE-----

--------------enigCF50CA29913BFB40F4F2DFF5--


--===============1949504950537203251==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1949504950537203251==--
