From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Thu, 26 Jul 2007 16:57:25 +0000
Subject: Re: [lm-sensors] [PATCH] adt7470: Update sensors periodically via
Message-Id: <20070726165725.GP19586@tree.beaverton.ibm.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2557882299257002992=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20070726010421.GM19586@tree.beaverton.ibm.com>
In-Reply-To: <20070726010421.GM19586@tree.beaverton.ibm.com>
To: lm-sensors@vger.kernel.org


--===============2557882299257002992==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4ZQ/M1iA+qg8otEW"
Content-Disposition: inline


--4ZQ/M1iA+qg8otEW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 26, 2007 at 08:08:09AM -0700, Juerg Haefliger wrote:
> Hi Darrick,
>=20
> I guess I'm not seeing the big picture :-) The problem you're trying
> to solve is that the reading of the registers takes a long time and
> needs to be able to sleep?

Yes, and also that sleeping in the sysfs read function is not desirable.
Personally, I was fine with that, but Mr. de Goede was concerned about
it, so I decided to try to fix it.  I admit, the dual-delayed-workqueue
method is a bit strange, but it solves the reading problem at a slight
cost of waking up the CPU even if nobody's watching the sensors.

> Hmm... Sounds rather complicated. Is there a problem with blocking
> apps for that long?
> How about forking off a kernel thread instead of using workqueues?

I was trying to use as little resources as possible, and a kernel thread
seemed like overkill for a hwmon device.

--D

--4ZQ/M1iA+qg8otEW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGqNJ1a6vRYYgWQuURAgU1AKCb2Ffv0onLkC6a0HC5mhZprIn5SACfXQXq
b3ZGlgGZfoAZiJW16SmWquE=
=A2od
-----END PGP SIGNATURE-----

--4ZQ/M1iA+qg8otEW--


--===============2557882299257002992==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2557882299257002992==--
