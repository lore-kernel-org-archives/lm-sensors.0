From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Thu, 26 Jul 2007 01:08:44 +0000
Subject: Re: [lm-sensors] [PATCH] adt7470: Update sensors periodically via
Message-Id: <20070726010843.GN19586@tree.beaverton.ibm.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7257591389946652135=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20070726010421.GM19586@tree.beaverton.ibm.com>
In-Reply-To: <20070726010421.GM19586@tree.beaverton.ibm.com>
To: lm-sensors@vger.kernel.org


--===============7257591389946652135==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YIwHDYD8sUXtBKvt"
Content-Disposition: inline


--YIwHDYD8sUXtBKvt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 25, 2007 at 06:04:21PM -0700, Darrick J. Wong wrote:
> To avoid blocking for 1s in the sysfs read functions, make it so
> that adt7470 updates are done periodically with a timer instead
> of being called from the read functions directly.

Hm... sleeping for long periods of time in the system workqueue causes
the console to become really slow.  Will migrate to a separate workqueue
tomorrow.

--D

--YIwHDYD8sUXtBKvt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGp/Qba6vRYYgWQuURAkStAKCnoSbfjqDBSpK48TwjSrNEsqzxNwCgqTdK
pDzqpqTitn2vyKmKCwlm16k=
=UjzS
-----END PGP SIGNATURE-----

--YIwHDYD8sUXtBKvt--


--===============7257591389946652135==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7257591389946652135==--
