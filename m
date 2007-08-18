From: Axel Thimm <Axel.Thimm@ATrpms.net>
Date: Sat, 18 Aug 2007 19:48:47 +0000
Subject: Re: [lm-sensors] lm-sensors-3.0.0 snapshots
Message-Id: <20070818194847.GA13738@puariko.nirvana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4996662036366929070=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20070818175926.6ed4411e@hyperion.delvare>
In-Reply-To: <20070818175926.6ed4411e@hyperion.delvare>
To: lm-sensors@vger.kernel.org


--===============4996662036366929070==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Aug 18, 2007 at 05:59:26PM +0200, Jean Delvare wrote:
> I think that the time has come to generate lm-sensors-3.0.0 snapshots
> for testers to download. This branch is quite usable now, even though
> some tools are still not working (e.g. sensord).
>=20
> Could you please add lm-sensors/branches/lm-sensors-3.0.0 to the
> snapshot system? Then we can put the snapshots in
> http://dl.lm-sensors.org/lm-sensors-3/snapshots/ or similar.

we have now

http://dl.lm-sensors.org/{lm-sensors,i2c}/snapshots/{lm-sensors,i2c}-r<rev>=
-<date>.tar.bz2

If you'd like to have two snapshot series I'd suggest adding the
version into the path above, e.g.

{lm-sensors,i2c}-<version>-r<rev>-<date>.tar.bz2

or something similar.

> While we're here, it'd be nice to have snapshots for the new i2c-tools
> repository as well. We'll release the first i2c-tools package at the
> same time as lm-sensors-3.0.0.
--=20
Axel.Thimm at ATrpms.net

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFGx00fQBVS1GOamfERAtr1AJwOJzYbgAkp3DDv/LXg+px4bH4yeQCfUrFo
LYbZyAeSmlJu7sqQO7Qy+yE=
=70Qu
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--


--===============4996662036366929070==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4996662036366929070==--
