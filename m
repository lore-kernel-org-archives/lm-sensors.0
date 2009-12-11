From: Andrey Rahmatullin <wrar@altlinux.org>
Date: Fri, 11 Dec 2009 18:34:52 +0000
Subject: [lm-sensors] w83627hf fails with ENODEV on 2.6.33
Message-Id: <20091211183452.GD5165@wrars-comp.wrarsdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1318255558445726307=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org


--===============1318255558445726307==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+B+y8wtTXqdUj1xM"
Content-Disposition: inline


--+B+y8wtTXqdUj1xM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.
I've built v2.6.32-5254-g3067e02 with old working config and w83627hf
cannot be loaded now (modprobe shows No such device, dmes is empty).
On older kernels it warned about the resource conflict with ACPI, but
acpi_enforce_resources=3Dlax is passed to the kernel, so the module worked.
Now it doesn't show the warning and doesn't work.

--=20
WBR, wRAR (ALT Linux Team)

--+B+y8wtTXqdUj1xM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBCAAGBQJLIpDMAAoJEOih81koZvPBJuwH/3AQghNF527kfZJtWOvtZVj6
lcwPzIo8VddqJgVOHlp/73+5z3UVyMQjhEm335C9C69f0wTVp4ATnxXs9Yyq8FiX
OIai/SqQ8HDxH8S9iWG8NpIT2blDJVSoz/JWKh71O+mW4k2DgqegaYpFbUwQ05m0
NcUsxCFsjXoxrWIiciQdW4qXGj+rxuV7JG6GqUskDntYs3DCi6mbVvUAP+pWTDxt
oGaB9KQ4vhR2UnPIs8tYx47c857lt9NK/dyHV251u5EVdrjoCSUDl/zrQQHVT8OD
iSSwB3ZsPN65EHrKiyjfisO7e29ItHEy1oJAc5so62pO+mD7KSFoHk/kKqtZKgI=
=FgWW
-----END PGP SIGNATURE-----

--+B+y8wtTXqdUj1xM--


--===============1318255558445726307==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1318255558445726307==--
