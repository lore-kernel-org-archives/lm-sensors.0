From: Wolfram Sang <w.sang@pengutronix.de>
Date: Tue, 27 Sep 2011 08:12:32 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/mc13xxx-adc: add support for the
Message-Id: <20110927081231.GB1959@pengutronix.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5005249648939643105=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1317049670-8049-1-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1317049670-8049-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: lm-sensors@vger.kernel.org


--===============5005249648939643105==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vGgW1X5XWziG23Ko"
Content-Disposition: inline


--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Yes, but from the filename you'd already have a hint. If you only know mc=
13892
> and don't know that the mc13783 is an almost compatible part, you'd never=
 find
> the former was already supported.

When looking for suitable drivers, 'grep' is a way better friend than
'find' :)

> OTOH, I know that many other drivers tend to have names reflecting the fi=
rst
> supported model of a family, so that is usual practice.

Yes, otherwise drivers/rtc/rtc-ds1307 would be rtc-xxxxxx.c these days.
Also, using those 'x' tends to create conflicts like 30cb35b
("leds-pca9532.c: change driver name to be unique"). Spoiled history for
git blame is another drawback.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--vGgW1X5XWziG23Ko
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk6BhW8ACgkQD27XaX1/VRvATQCgtDp/y9e93YnLxq4WRO2i7yAy
Q+kAnRozepBJ/R2qSWUOFYd4fZuq1qzR
=aqj/
-----END PGP SIGNATURE-----

--vGgW1X5XWziG23Ko--


--===============5005249648939643105==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5005249648939643105==--
