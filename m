From: Axel Thimm <Axel.Thimm@ATrpms.net>
Date: Thu, 12 Mar 2009 17:41:30 +0000
Subject: Re: [lm-sensors] Revision of sensors-detect
Message-Id: <20090312174130.GA22484@victor.dsa>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8541504437693738980=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20090312131620.29f81395@hyperion.delvare>
In-Reply-To: <20090312131620.29f81395@hyperion.delvare>
To: lm-sensors@vger.kernel.org


--===============8541504437693738980==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 12, 2009 at 01:16:20PM +0100, Jean Delvare wrote:
> Hi Axel,
>=20
> We often ask our users to test the latest version of sensors-detect.
> They typically get it from SVN through the trac interface:
>   http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/detect/sensors-=
detect?format=3Dtxt
> Unfortunately, trac doesn't honor keyword substitutions, so when the
> user reports the output, we get:
>=20
> # sensors-detect revision $Revision$
>=20
> Not very useful. The bug (or at least missing feature) has already been
> reported upstream 5 years ago, and I've added a comment there yesterday:
>   http://trac.edgewall.org/ticket/717#comment:10
> I don't expect this ticket to get fixed soon.
>=20
> An alternative is to use the SVN web interface:
>   http://www.lm-sensors.org/svn/lm-sensors/trunk/prog/detect/sensors-dete=
ct
> Unfortunately there is no keyword substitution there either. Does
> anyone know if there is a way to enable it?

I don't know, but that would be the best solution. Anyone with more
svn (web) experience under the belt?

> If not, it would be nice to have a workaround. I have one, which is a
> simple CGI script which fetches the file using the svn command line
> client and prints its contents:
>=20
> #!/bin/sh
> echo "Content-type: text/plain"
> echo
> svn cat http://www.lm-sensors.org/svn/lm-sensors/trunk/prog/detect/sensor=
s-detect
>=20
> I've tested it locally and it works fine for me. I could run it on my
> home server, however I think it is better for the users if they get the
> script from lm-sensors.org. They really have no reason to trust my
> personal server (which may also disappear someday.)
>=20
> Axel, is there a chance we could run this CGI script on lm-sensors.org
> and point users to it when we want them to test the latest version of
> sensors-detect?

I think I'd rather prefer a static solution, e.g. create a daily
checkout w/ keyword substitution. Could be part of the snapshot
creation script.

CGIs are nasty in the sense that for security one may turn it off on a whit=
elist
basis (actually nothing uses CGI currenlty) and a simply CGI script
could be forgotten in a server update/hardening messing up the
download.
--=20
Axel.Thimm at ATrpms.net

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkm5SUMACgkQQBVS1GOamfEEZwCeNvj/lrVI992+oq69jJG5fkIh
BA0An2hv1jWCP9Rj8Bq7i2Tdw02v+77+
=cV63
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--


--===============8541504437693738980==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8541504437693738980==--
