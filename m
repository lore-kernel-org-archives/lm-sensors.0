From: Axel Thimm <Axel.Thimm@ATrpms.net>
Date: Wed, 18 Jul 2007 14:26:55 +0000
Subject: Re: [lm-sensors] Call for 2.10.4
Message-Id: <20070718142655.GE4843@puariko.nirvana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8157237260528094721=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20070625101648.511dc9c4@hyperion.delvare>
In-Reply-To: <20070625101648.511dc9c4@hyperion.delvare>
To: lm-sensors@vger.kernel.org


--===============8157237260528094721==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lteA1dqeVaWQ9QQl"
Content-Disposition: inline


--lteA1dqeVaWQ9QQl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 17, 2007 at 03:16:18PM +0200, Jean Delvare wrote:
> On Mon, 16 Jul 2007 22:41:57 -0700, Philip Edelbrock wrote:
> > On Jul 16, 2007, at 2:15 AM, Jean Delvare wrote:
> > > I am done with the testing. I've made some fixes to sensors-detect, =
=20
> > > and minor documentation updates as well. Things look mostly OK to
> > > me now. Phil, you can proceed with the release as your time permits.
> > > (...)
> >=20
> > OK, I've prepared and signed the release.  The files are in my home =20
> > directory on devel.atrpms.net.  Normally I'd move the files into the =
=20
> > proper place in /srv/lm-sensors.org and edit the wiki to link to =20
> > them, but that directory doesn't seem to be mounted for me.
>=20
> Same problem here. I can still login to devel-old.atrpms.net though,
> and there the /srv/lm-sensors.org directory exists. So I guess that's
> where you want to work for now.
>=20
> Axel, can you please give us a quick update on the new devel server and
> also confirm that we are still supposed to use devel-old for now?

Hi,

the new devel server was just missing symlinks which I now added in. I
haven't tested if everything works under devel as it did under
devel-old (actually I also let the date for introducing the new devel
server slip, as we just had our son get born :). If something is
broken/missing on devel please ping me in PM and use devel-old
instead. Once you're happy on devel (new) we can decomission
devel-old, but there is no hurry.
--=20
Axel.Thimm at ATrpms.net

--lteA1dqeVaWQ9QQl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFGniMvQBVS1GOamfERAtZOAJ4zk8FVBbD+9AfNfJPyD50jx8iFzQCfb7lJ
Dsh6FmfgAxuH/beCXpmhaXo=
=1z8b
-----END PGP SIGNATURE-----

--lteA1dqeVaWQ9QQl--


--===============8157237260528094721==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8157237260528094721==--
