From: Axel Thimm <Axel.Thimm@ATrpms.net>
Date: Sun, 22 Apr 2007 19:03:02 +0000
Subject: Re: [lm-sensors] Checking out and comitting to the libsensors-3.x
Message-Id: <20070422190302.GC14565@neu.nirvana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0889669989757109336=="
List-Id: <lm-sensors.vger.kernel.org>
References: <4610BC25.8050507@hhs.nl>
In-Reply-To: <4610BC25.8050507@hhs.nl>
To: lm-sensors@vger.kernel.org


--===============0889669989757109336==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iFRdW5/EC4oqxDHL"
Content-Disposition: inline


--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Apr 08, 2007 at 07:40:30PM +0200, Jean Delvare wrote:
> > But you do get a marker for copies or merges that you can follow to
> > fork off A's history into B's.
>=20
> True, but that's hardly convenient if merges are frequent and/or if the
> number of branches is important. I start understanding why people
> working with many branches don't even consider Subversion.

Well, git was written with merges as the first priority, as the kernel
is being cloned and developed as several places
simultaneously. mercurial has also better merge support.

I just stumbled over the following (which is why I'm replying to this
old mail):

http://subversion.tigris.org/merge-tracking/
http://www.orcaware.com/svn/wiki/Svnmerge.py

E.g. svn will one day have the support you need, but you need it
today. :(

(and I wouldn't recommend using the semi-official svnmerge.py, because
the official implemenation may look different and we'd be stuck with
broken upgrade paths - better to switch to git/mercurial if the need
becomes larger - mercurial works under trac, too, and git is about to)
--=20
Axel.Thimm at ATrpms.net

--iFRdW5/EC4oqxDHL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFGK7FmQBVS1GOamfERAqeOAJ97HbjsSOkxKjSahkvIGzA+4V1ZDQCfYcDj
+/PYgKXflfRWUgia/jTYHsw=
=X2tK
-----END PGP SIGNATURE-----

--iFRdW5/EC4oqxDHL--


--===============0889669989757109336==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0889669989757109336==--
