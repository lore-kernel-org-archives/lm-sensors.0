From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Mon, 16 Jul 2007 20:09:55 +0000
Subject: Re: [lm-sensors] [PATCH] v3 of a adt7470 driver\
Message-Id: <20070716200954.GB2619@tree.beaverton.ibm.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2186934170164958412=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20070713002836.GR3435@tree.beaverton.ibm.com>
In-Reply-To: <20070713002836.GR3435@tree.beaverton.ibm.com>
To: lm-sensors@vger.kernel.org


--===============2186934170164958412==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WYTEVAkct0FjGQmd"
Content-Disposition: inline


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jul 14, 2007 at 10:00:27PM +0200, Jean Delvare wrote:

> Now Darrick says he has the problem with lm-sensors SVN, which is more
> surprising. Maybe sensors is linking with an older version of
> libsensors present on the system. This theory can be confirmed by
> running "sensors -v".

Yep, I'd linked it with an old version.  2.10.3 and 3.0.0 are both fine.

--D

--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGm9CSa6vRYYgWQuURAghKAJ0bjJ/LdIqXCwffS+ND5cYq/IaF4wCgh0w6
A4h7qcxi32Y3esSa0e27aJQ=
=Zkw4
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--


--===============2186934170164958412==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2186934170164958412==--
