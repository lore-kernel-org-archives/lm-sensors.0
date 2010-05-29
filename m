From: Wolfram Sang <w.sang@pengutronix.de>
Date: Sat, 29 May 2010 08:53:01 +0000
Subject: Re: [lm-sensors] PMBus support in Linux
Message-Id: <20100529085301.GA14982@pengutronix.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1765185529910013817=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1275063391.2631.137.camel@groeck-laptop> <20100529023401.GB12507@pengutronix.de> <20100529044239.GA19155@ericsson.com>
In-Reply-To: <20100529044239.GA19155-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
To: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>


--===============1765185529910013817==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> If there is no activity yet, question is if I should write individual dri=
vers or=20
> if I should define a PMBus infrastructure on top of i2c/smbus first.
> Any thoughts on which approach would be more likely to be accepted into t=
he kernel ?

Did I get this correct: The plan is to support PMBus-devices and let them
report their data in a hwmon-compatible-way?

(If so, did you already check how well PMBus data maps to the
hwmon-sysfs-interface?)

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkwA1e0ACgkQD27XaX1/VRt7+wCdFqZv57iH00l0cyC9Mq+Uesii
rDEAn0Z8XI8CoR8g5lKGpe62a5mKSMC+
=Ry/q
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--


--===============1765185529910013817==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1765185529910013817==--
