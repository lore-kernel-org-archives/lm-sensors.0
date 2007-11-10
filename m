From: Axel Thimm <Axel.Thimm@ATrpms.net>
Date: Sat, 10 Nov 2007 09:56:38 +0000
Subject: [lm-sensors] 2.10.5 on 2.4 kernel requires sysfs/libsysfs.h?
Message-Id: <20071110095638.GA29181@puariko.nirvana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2524038626999158383=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org


--===============2524038626999158383==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

up to 2.10.4 sysfsutils was only required for 2.6 kernels. Now the
build fails on 2.4 kernel system w/o sysfsutils with

make: *** No rule to make target `sysfs/libsysfs.h', needed by `lib/sysfs.a=
d'.

Is that a bug in the Makefiles or is sysfsutils now really required
for 2.4. kernels as well?

(I hit this while building rpms for RHEL3).

Thanks!
--=20
Axel.Thimm at ATrpms.net

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHNYBWQBVS1GOamfERAjS2AKCDj37reKWHCibnSPqExO/qRAS96gCgmpvE
6G45tpzg+43nCQOXM3m73/I=
=dvdu
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--


--===============2524038626999158383==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2524038626999158383==--
