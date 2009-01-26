From: Axel Thimm <Axel.Thimm@ATrpms.net>
Date: Mon, 26 Jan 2009 17:27:09 +0000
Subject: Re: [lm-sensors] Branches in lm-sensors repository
Message-Id: <20090126172709.GB10884@victor.nirvana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5495394704127575883=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20090119222636.0380a479@hyperion.delvare>
In-Reply-To: <20090119222636.0380a479@hyperion.delvare>
To: lm-sensors@vger.kernel.org


--===============5495394704127575883==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bn2rw/3z4jIqBvZU"
Content-Disposition: inline


--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 26, 2009 at 05:58:37PM +0100, Jean Delvare wrote:
> On Mon, 26 Jan 2009 16:51:19 +0100, Jean Delvare wrote:
> > This is done now. As I hopped, this was a simple matter of two "svn
> > move" commands. Kudos to the Subversion developers for making it so
> > easy.
>=20
> Oh, BTW, I expect this change to break nightly SVN snapshots.
>=20
> I suppose that we no longer really care about snapshots of the legacy
> (lm-sensors 2.10) branch.

OK, turning off.

> The snapshot command for trunk was operating on the legacy code before
> and is now operating on the development tree. Alright, that's exactly
> what we want.
>=20
> The snapshot command for the lm-sensors-3.0.0 branch will fail. So all
> you have to do is remove this part from the snapshot script.

OK.

It leaves the question of where the snapshots go to now. Previously
the 3.x snapshots went under /lm-sensors-3/snapshots/, I guess they
would now better show up under /lm-sensors/snapshots/?

Should we remove /lm-sensors-3/ altogether?
--=20
Axel.Thimm at ATrpms.net

--Bn2rw/3z4jIqBvZU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkl98mcACgkQQBVS1GOamfFIxQCcDTeoJapBAFtc/4JRgnVlbuyY
EXoAn2b0XLRT9Sr8RpQyCZ+Z7rfHh7I/
=qEM8
-----END PGP SIGNATURE-----

--Bn2rw/3z4jIqBvZU--


--===============5495394704127575883==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5495394704127575883==--
