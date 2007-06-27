From: Axel Thimm <Axel.Thimm@ATrpms.net>
Date: Wed, 27 Jun 2007 08:58:47 +0000
Subject: Re: [lm-sensors] Separate package for i2c tools
Message-Id: <20070627085847.GA5688@puariko.nirvana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8506561504211114486=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20070625111244.1ca5327a@hyperion.delvare>
In-Reply-To: <20070625111244.1ca5327a@hyperion.delvare>
To: lm-sensors@vger.kernel.org


--===============8506561504211114486==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 27, 2007 at 10:18:28AM +0200, Jean Delvare wrote:
> On Mon, 25 Jun 2007 11:22:30 +0200, Axel Thimm wrote:
> > On Mon, Jun 25, 2007 at 11:12:44AM +0200, Jean Delvare wrote:
> > > Axel, how can I create a brand new project in SVN? Do I need your hel=
p?
> >=20
> > Not really (but see below for acls), technically it is one project, so
> > all you need to do is
> >=20
> > svn mkdir my-new-project
> >=20
> > at the top level next to lm_sensors and i2c.
>=20
> This is so easy :) OK, done that.
>=20
> > The only thing that I need to do is setting up the acls in the httpd
> > config you want to use on that project. It can be
> > lm-sensors-commiters, i2c-commiters or something new.
>=20
> That would be something new: i2c-tools-commiters. This is an
> essentially separate package, that could have developers with no
> interest in sensors at all. And i2c-commiters is a restricted group, so
> it wouldn't fit either.

OK, the group is setup.

> BTW, how come that I was allowed to create and fill the i2c-tools
> directory before you created the new group? Am I almighty or something? ;)

Every lm-sensors committer is almighty :)

> > > Is it possible to preserve the history while moving the files from one
> > > project to another?
> >=20
> > Just use svn mv instead of svn rm/del and svn add. Move operations are
> > like copy and delete, and copy operations are crossed over when
> > traversing history unless you explicitely use --stop-on-copy.
>=20
> Wow, very nice.
>=20
> Thanks,

--=20
Axel.Thimm at ATrpms.net

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFGgibGQBVS1GOamfERAmqaAJ9vRYlNxaZNo6Y9LUYuZw7gzOjrygCeNMzY
kpMoTHP5wN8VIt6soIBDz7k=
=nPxA
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--


--===============8506561504211114486==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8506561504211114486==--
