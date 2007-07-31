From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Tue, 31 Jul 2007 15:24:45 +0000
Subject: Re: [lm-sensors] [PATCH] v3 of a adt7470 driver
Message-Id: <20070731152444.GE2795@tree.beaverton.ibm.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3739280823225938428=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20070711183825.GP3435@tree.beaverton.ibm.com>
In-Reply-To: <20070711183825.GP3435@tree.beaverton.ibm.com>
To: lm-sensors@vger.kernel.org


--===============3739280823225938428==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FkmkrVfFsRoUs1wW"
Content-Disposition: inline


--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 31, 2007 at 09:06:54AM -0400, Mark M. Hoffman wrote:
> My bad.  I see you sent a patch for it anyway, so I'll leave it up to you.

sparse complains about ARRAY_SIZE() so your method of structuring code
is less likely to raise eyebrows. :)
>=20
> Could you please just respin a single patch to add the driver with all
> cleanups, against v2.6.23-rc1?  What you've given me at this point is...
>=20
> 1) adt7470 v3 against v2.6.22
>=20
> 	(you must have done a merge up to v2.6.23-rc1 here)
> 	=09
> 2) cleanups against #1 + v2.6.23-rc1
>=20
> 3) etc.
>=20
> I shouldn't have to reproduce that merge here.
>=20
> I'm sorry if you feel like I'm being a PITA here... but it's not my prima=
ry
> goal as a volunteer to optimize the use of your (employer's) time.

Merging a patchset isn't a problem; I can take care of that pretty
quickly.  However, I thought that it would be a good idea to have a
public airing of those last three patches individually.

Sorry I came off a bit more harshly than I intended in that last email.
My apologies.

Also, I think git has the ability to import a patchset from a series of
emails in mbox format.  That said, I know a lot of new drivers tend to
show up as a giant block of code and not a patch stream. :)

--D

--FkmkrVfFsRoUs1wW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGr1Q8a6vRYYgWQuURAjFyAJ4jdEGuGYXcdUuGwflRHE3FDlq3LgCfXjat
FQutTTsSEfntqeiVhCDxqNc=
=8dDv
-----END PGP SIGNATURE-----

--FkmkrVfFsRoUs1wW--


--===============3739280823225938428==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3739280823225938428==--
