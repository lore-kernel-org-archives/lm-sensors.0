From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Thu, 27 Jun 2013 09:17:32 +0000
Subject: Re: [lm-sensors] [PATCH 3/4] hwmon: Add a simple driver to read the MXS SoC temperature
Message-Id: <20130627091732.GP5803@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4873096881483283572=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1372236673-20725-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1372236673-20725-4-git-send-email-alexandre.belloni@free-electrons.com>
 <20130626143927.GB31998@roeck-us.net>
In-Reply-To: <20130626143927.GB31998@roeck-us.net>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Shawn Guo <shawn.guo@linaro.org>, Jean Delvare <khali@linux-fr.org>, jimwall@q.com, brian@crystalfontz.com, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Russell King <linux@arm.linux.org.uk>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org


--===============4873096881483283572==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ga5bsqHr1s/xcZEm"
Content-Disposition: inline


--ga5bsqHr1s/xcZEm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2013 at 07:39:27AM -0700, Guenter Roeck wrote:
> On Wed, Jun 26, 2013 at 10:51:12AM +0200, Alexandre Belloni wrote:
> > The low resolution ADC of the mxs is able to read an internal temperatu=
re
> > sensor, expose that using hwmon.
> >=20
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > ---
>=20
> Wouldn't it make more sense to use iio-hwmon and improve it if necessary ?

Actually, I wonder if we should not just put the hwmon driver
capabilities directly into the mxs-lradc driver, just like it's already
been done in this driver for the touchscreen support.

The probing of this hwmon driver doesn't really belong to the DT, it's
not really realistic to probe it from the machine definition, and it
really is the IP that is wired that way.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--ga5bsqHr1s/xcZEm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRzAMsAAoJEBx+YmzsjxAgH7YP/j1sJHX0pBnLRoA7suWcPK/M
ydWSdH9e9cX2NmNKi5qk2rKZb6pt041v2c5qGhlBG27B/ksYWQRggljtkFup2LCO
3oewUreyrgVB3OIoJ15/JyIbkgLQsPNqdCf0dZbiefxwAAgnP5j45PlqNCtIvdS5
KMkXcRT5CgXdMqUHBxXCdjdpSFCNdepbEQad1HX/90pddHaAvo8X9w7r0pmcIKkh
oY6bE9EqgfwbCi22x1BwkS12S8WgVPh1EuJ+WjLb4PuhrVJ2+Yx1cMqmK8Qc0sDa
IsmUaq9YZqqtihflSewUsBfTQynq43W6XkA4tuukooOc+D4nlndtvmnLn/ILjDpo
Zr0wEiYAetGWDMVOKwqoZtPx2/awux5AUb4CfCAUQyDQVtVVMLLN3vNwPPlgZypt
RCIj+SVSYFto1Qys0p+sTGioOXkDWtBJQKlYP0JqfIGJOGpxe/nHlaukmiMmJ7uA
fF8k2q7pC1xTTGQ8XXGf+24wwc/7ASzLewpDmbqrT1hRfIeydWQtSZj3bTdS6kJf
8yYtyE1tgwDYSWNDE2IjJCh0XQWqiTOXOS1S7adq3wvFnYNrqz4xoJT/kMNG7UMq
4uj+8+2I6L4zJQds5iI5EXI5zp6FjK2HxV9K4mIp4ft6+aoSsfNywkHqAjPn54jq
xSLjqihfQtMCBQS0A+PL
=JG3w
-----END PGP SIGNATURE-----

--ga5bsqHr1s/xcZEm--


--===============4873096881483283572==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4873096881483283572==--
