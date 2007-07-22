From: Axel Thimm <Axel.Thimm@ATrpms.net>
Date: Sun, 22 Jul 2007 19:33:43 +0000
Subject: Re: [lm-sensors] 2.10.4 fails on 2.4 platform (RHEL3)
Message-Id: <20070722193343.GC11686@puariko.nirvana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5565187461958900690=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20070722183807.GA11686@puariko.nirvana>
In-Reply-To: <20070722183807.GA11686@puariko.nirvana>
To: lm-sensors@vger.kernel.org


--===============5565187461958900690==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CblX+4bnyfN0pR09"
Content-Disposition: inline


--CblX+4bnyfN0pR09
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jul 22, 2007 at 08:38:07PM +0200, Axel Thimm wrote:
> building the kernel modules parts for RHEL3 (kernel 2.4.21 based) the
> build fails with the log below.

sorry, false alarm! For being able to build userland vs kernelland I
had to hardwire a SRCDIR=3D"... kernel ..." some time back to support
just kmdl builds (and no userland at all), so I was carrying the
obsoleted kernel subdir build.
--=20
Axel.Thimm at ATrpms.net

--CblX+4bnyfN0pR09
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFGo7EXQBVS1GOamfERAlGmAKCNjVB5r5TLEnVJ5+uFwC0t5mAXUACfVudj
CG1TiB42/k7337OUCV39R5Y=
=rWgh
-----END PGP SIGNATURE-----

--CblX+4bnyfN0pR09--


--===============5565187461958900690==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5565187461958900690==--
