From: Ryan Underwood <nemesis-lists@icequake.net>
Date: Mon, 09 Jul 2007 16:07:06 +0000
Subject: [lm-sensors] sensors problem
Message-Id: <20070709160706.GA28047@dbz.icequake.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1702618179417163114=="
List-Id: <lm-sensors.vger.kernel.org>
References: <017801c1eb62$f826cfa0$c36fa83e@compclub.sk>
In-Reply-To: <017801c1eb62$f826cfa0$c36fa83e@compclub.sk>
To: lm-sensors@vger.kernel.org


--===============1702618179417163114==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


I have a MSI BXMaster, and lm-sensors 2.10.3 from Debian and kernel
2.6.21.1.  Why am I having the following issues in the sensors output:

$ sensors
w83782d-i2c-0-2d
Adapter: SMBus PIIX4 adapter at 5000
VCore 1:   +1.47 V  (min =3D  +0.00 V, max =3D  +4.08 V)
VCore 2:   +1.50 V  (min =3D  +0.00 V, max =3D  +4.08 V)
+3.3V:     +3.41 V  (min =3D  +2.82 V, max =3D  +3.79 V)
+5V:       +5.05 V  (min =3D  +5.75 V, max =3D  +4.27 V)       ALARM
+12V:     +12.34 V  (min =3D +15.50 V, max =3D  +7.72 V)       ALARM
-12V:     -12.11 V  (min =3D  -9.40 V, max =3D  +3.10 V)       ALARM
-5V:       -5.15 V  (min =3D  +5.10 V, max =3D  +1.89 V)       ALARM
V5SB:      +5.05 V  (min =3D  +4.87 V, max =3D  +1.69 V)       ALARM
VBat:      +2.90 V  (min =3D  +0.85 V, max =3D  +3.57 V)
fan1:     3443 RPM  (min =3D 1670 RPM, div =3D 8)
fan2:        0 RPM  (min =3D  669 RPM, div =3D 8)              ALARM
fan3:     5232 RPM  (min =3D 2922 RPM, div =3D 2)
temp1:       +42=B0C  (high =3D  +124=B0C, hyst =3D   -28=B0C)   sensor =3D=
 thermistor     =20
temp2:     +39.0=B0C  (high =3D   +80=B0C, hyst =3D   +75=B0C)   sensor =3D=
 thermistor     =20
temp3:     +40.5=B0C  (high =3D   +80=B0C, hyst =3D   +75=B0C)   sensor =3D=
 thermistor     =20
vid:      +1.500 V  (VRM Version 8.5)
alarms:
beep_enable:
          Sound alarm enabled

It appears the sensors themselves are correct, but the ranges are all wrong=
=2E..
in fact the range slope is reversed.  I am using the default sensors.conf
packaged with lm-sensors and ensured that it was active with sensors -s.

Not sure when this started, I had my monitoring script disabled for a while.
At one point (year ago?) it worked fine.

--=20
Ryan C. Underwood, <nemesis@icequake.net>

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGkl0qIonHnh+67jkRAhA1AKCTCz6YMRTZQ1Alsj+qWOSdAcVvVwCfYQjN
lqCvdXstKLRdmBtXesGLIlA=
=ybKj
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--


--===============1702618179417163114==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1702618179417163114==--
