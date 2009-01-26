From: Axel Thimm <Axel.Thimm@ATrpms.net>
Date: Mon, 26 Jan 2009 17:48:23 +0000
Subject: Re: [lm-sensors] Branches in lm-sensors repository
Message-Id: <20090126174823.GE10884@victor.nirvana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4558408636434973223=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20090119222636.0380a479@hyperion.delvare>
In-Reply-To: <20090119222636.0380a479@hyperion.delvare>
To: lm-sensors@vger.kernel.org


--===============4558408636434973223==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IU5/I01NYhRvwH70"
Content-Disposition: inline


--IU5/I01NYhRvwH70
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 26, 2009 at 06:36:46PM +0100, Jean Delvare wrote:
> > It leaves the question of where the snapshots go to now. Previously
> > the 3.x snapshots went under /lm-sensors-3/snapshots/, I guess they
> > would now better show up under /lm-sensors/snapshots/?
>=20
> Yes. But I don't think you need to do anything special for this:
> snapshots of trunk already went into /lm-sensors/snapshots/, and the
> development branch is now trunk again. So the old command should
> already do the right thing.

True, so it just needed removing the cron job for lm-sensors-3. Well
planned when you set this up ;)

> > Should we remove /lm-sensors-3/ altogether?
>=20
> Yes, please.

OK, done. Should all work as you said, but maybe we should check the
contents of the next snapshot tomorrow (runs at 6:10 CET) just to make
sure.
--=20
Axel.Thimm at ATrpms.net

--IU5/I01NYhRvwH70
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkl992cACgkQQBVS1GOamfGgmwCeMQzYBXLI2DJB/WU9+3RZRFkH
5hcAn0LJJuPLyjiJYNUh+l1VAABnhOp4
=jqJr
-----END PGP SIGNATURE-----

--IU5/I01NYhRvwH70--


--===============4558408636434973223==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4558408636434973223==--
