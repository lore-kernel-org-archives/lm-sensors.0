From: Axel Thimm <Axel.Thimm@ATrpms.net>
Date: Tue, 10 Apr 2007 14:43:54 +0000
Subject: Re: [lm-sensors] Checking out and comitting to the libsensors-3.x
Message-Id: <20070410144354.GE19101@neu.nirvana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8954026984932476285=="
List-Id: <lm-sensors.vger.kernel.org>
References: <4610BC25.8050507@hhs.nl>
In-Reply-To: <4610BC25.8050507@hhs.nl>
To: lm-sensors@vger.kernel.org


--===============8954026984932476285==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J4XPiPrVK1ev6Sgr"
Content-Disposition: inline


--J4XPiPrVK1ev6Sgr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 10, 2007 at 04:23:10PM +0200, Jean Delvare wrote:
> On Thu, 5 Apr 2007 22:31:59 +0200, Axel Thimm wrote:
> > On Thu, Apr 05, 2007 at 10:15:04PM +0200, Jean Delvare wrote:
> > > http://www.lm-sensors.org/wiki/Devices
> > >=20
> > > Oops=E2=80=A6
> > > Trac detected an internal error:
> > >=20

> > > RuntimeError: instance.__dict__ not accessible in restricted mode
> > >=20
> > > It's an intermittent error, sometimes I get it, sometimes I don't.
> >=20
> > That's the errors one loves. Looks like it's a known issue for more
> > than a year:
> >=20
> > http://trac.edgewall.org/ticket/3371
>=20
> Ugh. But we didn't have the problem before. Any idea what changed, that
> could explain why we suddenly have the problem? Maybe the switch to
> mod_python? I think we have to switch back to the previous state until
> the Trac folks provide a fix.

I tried one of the fixes mentioned ("PythonInterpreter
main_interpreter"), I can't provoke the bug anymore (tried reload on
the Devices page which previously was giving the error for me). Is
that true on your side, too?
--=20
Axel.Thimm at ATrpms.net

--J4XPiPrVK1ev6Sgr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFGG6KqQBVS1GOamfERAhnYAJ0fVt3C0hR9vEVqrvpz0AZVqFowUQCfQhPt
SgyvUhUJdDS1/Yxhjpvd9gU=
=4cMf
-----END PGP SIGNATURE-----

--J4XPiPrVK1ev6Sgr--


--===============8954026984932476285==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8954026984932476285==--
