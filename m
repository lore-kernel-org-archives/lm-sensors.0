From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Thu, 26 Jul 2007 00:57:00 +0000
Subject: Re: [lm-sensors] [PATCH] v3 of a adt7470 driver\
Message-Id: <20070726005700.GL19586@tree.beaverton.ibm.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7358922436023506003=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20070713002836.GR3435@tree.beaverton.ibm.com>
In-Reply-To: <20070713002836.GR3435@tree.beaverton.ibm.com>
To: lm-sensors@vger.kernel.org


--===============7358922436023506003==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9a9Vq1BJdYBEXpLG"
Content-Disposition: inline


--9a9Vq1BJdYBEXpLG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 24, 2007 at 08:56:51PM +0200, Hans de Goede wrote:

> Never mind about this I've already requested Mark to pick up the v3 patch=
 +=20
> the 2 fixes.
>=20
> Jean, if you are reading this what do you think about this whole sleep fo=
r=20
> a sesond in device_update stuff and possible workarounds?

I could modify the driver to update the sensor values periodically with
a timer, though the msleep forces me to push the actual work of reading
the sensor values into a workqueue.  This has the effect of making sysfs
reads nearly instantaneous though I don't know if sleeping for a second
in the system workqueue is agreeable.  It might be useful to create a
separate workqueue for slow sensor chip reads.

Ugh, the patch is buggy, so I'll have to hack on it a little longer.

--D

--9a9Vq1BJdYBEXpLG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGp/Fca6vRYYgWQuURAh+8AKCm5T6W/b+cfQkv28Jc37/BdhS+FwCfVzmh
nq+cCUkzm7/aHtLt1qECE+o=
=xkrv
-----END PGP SIGNATURE-----

--9a9Vq1BJdYBEXpLG--


--===============7358922436023506003==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7358922436023506003==--
