From: Eduardo Valentin <edubezval@gmail.com>
Date: Tue, 24 Feb 2015 19:29:35 +0000
Subject: Re: [lm-sensors] [PATCH V2] (gpio-fan): Add thermal control hooks
Message-Id: <20150224192933.GJ3448@developer.amazonguestwifi.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1268542347415150694=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1420740303-12529-1-git-send-email-nm@ti.com>
 <54AF5DA8.6080408@roeck-us.net>
In-Reply-To: <54AF5DA8.6080408@roeck-us.net>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Nishanth Menon <nm@ti.com>, Jean Delvare <jdelvare@suse.de>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org


--===============1268542347415150694==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fjX3cMESU3XgGmZ"
Content-Disposition: inline


--2fjX3cMESU3XgGmZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Guenter,

On Thu, Jan 08, 2015 at 08:48:40PM -0800, Guenter Roeck wrote:
> On 01/08/2015 10:05 AM, Nishanth Menon wrote:
> > Allow gpio-fan to be used as thermal cooling device for platforms that
> > use GPIO maps to control fans.
> >
> > As part of this change, we make the shutdown and remove logic the same
> > as well.
> >
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > ---
>=20
> Applied to -next.

What is the target kernel version for this change? It didn't make
4.0-rc1

BR,

Eduardo Valentin

>=20
> Thanks,
> Guenter
>=20

--2fjX3cMESU3XgGmZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU7NEVAAoJEMLUO4d9pOJWEsAH/R7uky9Zi0WMoKPPD7yAawN6
CueEfNwfE81LaRqa0d9+zWgeZE1y0zEE3zglwApV0bdy5z6MOSLJCVc1Xw/ZdSVZ
Ju/QUPrqTnGdoRFDC9fMn88P/OkczEXfAX2w5ptYNgS8hoPEc+2gdOz6ku2Uo8ID
dYLjI2jDHDEN3oT9IiACHvR2TBUaorQfSAPROM/ghgJny8SzwRceGgWCLgQjMgCm
lLblGFcJCuoOcf8/1Kh9yfIKYE9pp7G5vn5cgjp0NwR1qkC+8vOKEoQfwieN+2oW
Tw96xpoBU2FBST3Kqqi+kpU3Y/HAdFUFU0PnBbYMILiFqUZHo3p0emZSRaPrWgI=
=odHT
-----END PGP SIGNATURE-----

--2fjX3cMESU3XgGmZ--


--===============1268542347415150694==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1268542347415150694==--
