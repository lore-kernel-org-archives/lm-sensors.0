From: Forest Bond <forest@alittletooquiet.net>
Date: Fri, 11 Dec 2009 12:05:22 +0000
Subject: Re: [lm-sensors] sensors-detect: probing i2c sensors racy?
Message-Id: <20091211120522.GC719@alittletooquiet.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8135510442117573385=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20091209153225.GA3947@alittletooquiet.net>
In-Reply-To: <20091209153225.GA3947@alittletooquiet.net>
To: lm-sensors@vger.kernel.org


--===============8135510442117573385==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m51xatjYGsM+13rf"
Content-Disposition: inline


--m51xatjYGsM+13rf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Dec 11, 2009 at 09:56:47AM +0100, Jean Delvare wrote:
> Hi Forest,
>=20
> On Thu, 10 Dec 2009 22:31:58 -0500, Forest Bond wrote:
> > On Wed, Dec 09, 2009 at 05:11:48PM +0100, Jean Delvare wrote:
> > > give a try to the latest one:
> > > http://dl.lm-sensors.org/lm-sensors/files/sensors-detect
> >=20
> > This seems to work fine.  Thanks for the help.
>=20
> Without the extra patch? Hmm, then I don't know if I should apply it.
> On the one hand, why change the code if it works... OTOH, there may be
> cases where udev will still be too slow and the bug you've hit will
> resurface again.

I only tested once.  I guess the race condition is more likely to fall the =
right
way with the new script (based on your comments, I assume the race still
exists).  Would it be helpful if I tested a few more times?

The patch seemed small enough that I wouldn't think it would cause problems.

-Forest
--=20
Forest Bond
http://www.alittletooquiet.net
http://www.pytagsfs.org

--m51xatjYGsM+13rf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFLIjWCRO4fQQdv5AwRAtkKAJ4oELBCO1A7MwAPiXJbNPyUXNtuBwCgvWUK
Takp/8npJTeKmYX9JU2Cez8=
=k3Kc
-----END PGP SIGNATURE-----

--m51xatjYGsM+13rf--


--===============8135510442117573385==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8135510442117573385==--
