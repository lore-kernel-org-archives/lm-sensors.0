From: Axel Thimm <Axel.Thimm@ATrpms.net>
Date: Mon, 25 Jun 2007 09:22:30 +0000
Subject: Re: [lm-sensors] Separate package for i2c tools
Message-Id: <20070625092230.GD3561@puariko.nirvana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4164816498154488853=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20070625111244.1ca5327a@hyperion.delvare>
In-Reply-To: <20070625111244.1ca5327a@hyperion.delvare>
To: lm-sensors@vger.kernel.org


--===============4164816498154488853==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oj4kGyHlBMXGt3Le"
Content-Disposition: inline


--oj4kGyHlBMXGt3Le
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 25, 2007 at 11:12:44AM +0200, Jean Delvare wrote:
> Axel, how can I create a brand new project in SVN? Do I need your help?

Not really (but see below for acls), technically it is one project, so
all you need to do is

svn mkdir my-new-project

at the top level next to lm_sensors and i2c.

The only thing that I need to do is setting up the acls in the httpd
config you want to use on that project. It can be
lm-sensors-commiters, i2c-commiters or something new.

> Is it possible to preserve the history while moving the files from one
> project to another?

Just use svn mv instead of svn rm/del and svn add. Move operations are
like copy and delete, and copy operations are crossed over when
traversing history unless you explicitely use --stop-on-copy.

See also

svn mkdir -h
svn mv -h
svn log -h
--=20
Axel.Thimm at ATrpms.net

--oj4kGyHlBMXGt3Le
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFGf4lWQBVS1GOamfERAuLRAJ9n3T5Ku2xdQ59VeWcyToxVKD2ZPwCglmlc
LgP5jo+502ymdq012j00oZ0=
=75KX
-----END PGP SIGNATURE-----

--oj4kGyHlBMXGt3Le--


--===============4164816498154488853==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4164816498154488853==--
