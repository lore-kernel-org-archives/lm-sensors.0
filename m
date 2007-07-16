From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Mon, 16 Jul 2007 22:14:30 +0000
Subject: Re: [lm-sensors] [PATCH] v1 Intel FB-DIMM AMB temperature sensor
Message-Id: <20070716221429.GF2619@tree.beaverton.ibm.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8704968297808288171=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20070713014814.GS3435@tree.beaverton.ibm.com>
In-Reply-To: <20070713014814.GS3435@tree.beaverton.ibm.com>
To: lm-sensors@vger.kernel.org


--===============8704968297808288171==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gdTfX7fkYsEEjebm"
Content-Disposition: inline


--gdTfX7fkYsEEjebm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 16, 2007 at 01:28:07PM -0700, Darrick J. Wong wrote:

> > HdG> Yes, thats a rather severe violation of the hwmon sysfs standard. =
I do not see=20

Vadim, I've tested out your patch to adjust the tempX numbers for i5k_amb. =
 It
looks, builds, and runs ok, so:

Acked-by: Darrick J. Wong <djwong@us.ibm.com>

--D

--gdTfX7fkYsEEjebm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGm+3Fa6vRYYgWQuURAhbyAJ9W0gjVHf33E+0Oqj0yjgkE9Mw0AQCeJz36
NsdKyz+O2BbtAbFp7Vu1r78=
=FfpT
-----END PGP SIGNATURE-----

--gdTfX7fkYsEEjebm--


--===============8704968297808288171==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8704968297808288171==--
