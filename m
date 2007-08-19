From: Axel Thimm <Axel.Thimm@ATrpms.net>
Date: Sun, 19 Aug 2007 15:04:35 +0000
Subject: Re: [lm-sensors] lm-sensors-3.0.0 snapshots
Message-Id: <20070819150435.GA14928@puariko.nirvana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6286808747312266105=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20070818175926.6ed4411e@hyperion.delvare>
In-Reply-To: <20070818175926.6ed4411e@hyperion.delvare>
To: lm-sensors@vger.kernel.org


--===============6286808747312266105==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 19, 2007 at 04:26:17PM +0200, Jean Delvare wrote:
> On Sat, 18 Aug 2007 21:48:47 +0200, Axel Thimm wrote:
> > On Sat, Aug 18, 2007 at 05:59:26PM +0200, Jean Delvare wrote:
> > > Could you please add lm-sensors/branches/lm-sensors-3.0.0 to the
> > > snapshot system? Then we can put the snapshots in
> > > http://dl.lm-sensors.org/lm-sensors-3/snapshots/ or similar.
> >=20
> > we have now
> >=20
> > http://dl.lm-sensors.org/{lm-sensors,i2c}/snapshots/{lm-sensors,i2c}-r<=
rev>-<date>.tar.bz2
> >=20
> > If you'd like to have two snapshot series I'd suggest adding the
> > version into the path above, e.g.
> >=20
> > {lm-sensors,i2c}-<version>-r<rev>-<date>.tar.bz2
> >=20
> > or something similar.
>=20
> I would be fine with
>=20
> http://dl.lm-sensors.org/lm-sensors/snapshots/lm-sensors-3-r<rev>-<date>.=
tar.bz2

I changed /lm-sensors/ -> /lm-sensors-3/ for symmetry's sake 8and
because it was easier to script ;)

> For i2c, no need to change anything as there is no development branch.
>=20
> > > While we're here, it'd be nice to have snapshots for the new i2c-tools
> > > repository as well. We'll release the first i2c-tools package at the
> > > same time as lm-sensors-3.0.0.
>=20
> For i2c-tools, this really doesn't have anything to do with i2c, so I
> would like to have a separate base directory:
>=20
> http://dl.lm-sensors.org/i2c-tools/snapshots/i2c-tools-r<rev>-<date>.tar.=
bz2

OK, done. I manually kicked in the first snapshots, the next should
follow once bits in the respective dir change (in daily frequencies).
--=20
Axel.Thimm at ATrpms.net

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFGyFwDQBVS1GOamfERAqcnAJ0XBd2SVLUA/hXHpNWyBtzagScUIgCbBjia
AEmIGRiMioJLHGZIoYog2Bw=
=wrUQ
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--


--===============6286808747312266105==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6286808747312266105==--
