From: Wolfram Sang <w.sang@pengutronix.de>
Date: Tue, 27 Sep 2011 09:22:20 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/mc13xxx-adc: add support for the
Message-Id: <20110927092220.GD1959@pengutronix.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4004303859321390713=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1317049670-8049-1-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1317049670-8049-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: lm-sensors@vger.kernel.org


--===============4004303859321390713==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GpGaEY17fSl8rd50"
Content-Disposition: inline


--GpGaEY17fSl8rd50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > Yes, but from the filename you'd already have a hint. If you only know
> > > mc13892 and don't know that the mc13783 is an almost compatible part,
> > > you'd never find the former was already supported.
> >=20
> > When looking for suitable drivers, 'grep' is a way better friend than
> > 'find' :)
>=20
> Can you easily 'grep' on git-web? :-)

;) You might also try searching for "<partnr> lkddb" which should likely
give you the entry found in the Linux Kernel Driver Database which knows
about all platform_ids and so forth of every driver.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--GpGaEY17fSl8rd50
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk6BlcwACgkQD27XaX1/VRuWRACguTn9zkFE4gfeykhK44GnbIm2
yNQAn39IYXTthFOSFAhy/f0MWyPzYKjM
=X37p
-----END PGP SIGNATURE-----

--GpGaEY17fSl8rd50--


--===============4004303859321390713==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4004303859321390713==--
