From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Thu, 26 Jul 2007 07:30:40 +0000
Subject: Re: [lm-sensors] [PATCH] adt7470: Update sensors periodically via
Message-Id: <20070726073040.GO19586@tree.beaverton.ibm.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6981133785057947455=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20070726010421.GM19586@tree.beaverton.ibm.com>
In-Reply-To: <20070726010421.GM19586@tree.beaverton.ibm.com>
To: lm-sensors@vger.kernel.org


--===============6981133785057947455==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wmhq21yAGFMoSpeN"
Content-Disposition: inline


--wmhq21yAGFMoSpeN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 25, 2007 at 06:19:22PM -0700, Juerg Haefliger wrote:
> Hi Darrick,
>=20
> Why using a workqueue at all? Can't you just run a timer and do the
> update when it expires and restart the timer?

Currently, I use mutexes (and msleep) which require the ability to
sleep.  Timers can't sleep because they are implemented as a softirq.
That said, I think the solution is to have two workqueue items--one to
start the read and another to run after the temperature sensors have
been read.  The delays for both can be handled via schedule_delayed_work().
It could be done with two timers and spinlocks, but ... yuck.

New patch forthcoming.

--D

--wmhq21yAGFMoSpeN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGqE2ga6vRYYgWQuURApRaAKCAKsf8b2EQWGDJ3TSFT4dDY5cNsACdFzlI
yvfRi5A+xgLK8bJ7ea7oVZA=
=8vm8
-----END PGP SIGNATURE-----

--wmhq21yAGFMoSpeN--


--===============6981133785057947455==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6981133785057947455==--
