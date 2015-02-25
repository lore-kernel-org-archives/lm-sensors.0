From: Eduardo Valentin <edubezval@gmail.com>
Date: Wed, 25 Feb 2015 18:29:18 +0000
Subject: Re: [lm-sensors] [PATCH v5 0/6] hwmon: thermal: Odroid U3: Provide support for Odroid U3 fan
Message-Id: <20150225182917.GB2306@developer.amazonguestwifi.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7654249215747121272=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1418897591-18332-1-git-send-email-l.majewski@samsung.com>
 <1424878462-15511-1-git-send-email-l.majewski@samsung.com>
 <20150225171820.GA2400@roeck-us.net>
In-Reply-To: <20150225171820.GA2400@roeck-us.net>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Lukasz Majewski <l.majewski@samsung.com>, Kamil Debski <k.debski@samsung.com>, Jean Delvare <jdelvare@suse.de>, Kukjin Kim <kgene@kernel.org>, lm-sensors@lm-sensors.org, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, linux-kernel@vger.kernel.org, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>


--===============7654249215747121272==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dc+cDN39EJAMEtIO"
Content-Disposition: inline


--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Guenter,

On Wed, Feb 25, 2015 at 09:18:20AM -0800, Guenter Roeck wrote:
> On Wed, Feb 25, 2015 at 04:34:16PM +0100, Lukasz Majewski wrote:
> > Presented patches add support for Odroid's U3 optional CPU FAN, which u=
ses PWM
> > subsystem for low level control.
> >=20
> > After successful probe it registers itself as a cooling device for ther=
mal
> > subsystem.
> >=20
> > This driver also supports devices without DTS specified.
> >=20
> > To provide correct functionality, new properties to device tree descrip=
tion for
> > Exynos4412 and in particular Odroid U3 have been added.
> >=20
> > Those patches were tested at Exynos4412 - Odroid U3 board.
> >=20
> > Patches were applied on:
> > linux-soc-thermal/fixes branch (Linux v4.0-rc1)
> > SHA1: b71d399c7f2fe06b60b96155ec0b9ae167334e4a
> >=20
> > Kamil Debski (1):
> >   ARM: dts: Add pwm-fan node to the Odroid-U3 board
> >=20
> > Lukasz Majewski (5):
> >   Documentation: dts: Documentation entry to explain how to use PWM FAN
> >     as a cooling device
> >   ARM: dts: Add properties to use pwm-fan device as a cooling device in
> >     Odroid U3
> >   hwmon: pwm-fan: Extract __set_pwm() function to only modify PWM duty
> >     cycle
> >   hwmon: pwm-fan: Read PWM FAN configuration from device tree
> >   hwmon: pwm-fan: Code for using PWM FAN as a cooling device
> >=20
> >  .../devicetree/bindings/hwmon/pwm-fan.txt          |  25 +++-
> >  arch/arm/boot/dts/exynos4.dtsi                     |   2 +-
> >  arch/arm/boot/dts/exynos4412-odroidu3.dts          |  43 ++++++
> >  drivers/hwmon/pwm-fan.c                            | 166 +++++++++++++=
++++++--
> >  4 files changed, 220 insertions(+), 16 deletions(-)
> >=20
> For the series:
>=20
> Acked-by: Guenter Roeck <linux@roeck-us.net>
>=20
> Should I take it through hwmon ? Might make sense given the majority
> of the changes is in hwmon code.

I believe the series should go via your tree, yes. I had only minor
comments in the code added for the cooling device code, as it lacks the
unregistration call in the .remove callback.=20

Also, the DTS changes may generate conflicts with platform code. Lukasz
may probably ask  Kukjin Kim to add them via the samsung tree.

BR,

Eduardo Valentin

>=20
> Thanks,
> Guenter

--dc+cDN39EJAMEtIO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU7hR1AAoJEMLUO4d9pOJWX7YH/0AzszI7w0H1frCpqPJsXquO
KpIe4Y1HMvlWtagEzrHvF2SZxchatenIWoEksAvWvny/gqD8LkgS9JyRt5b5SBSt
spm4Ossrt5DE3IyxIVZyShloL/m4XTSF68ufhkIFzveTRQaftoY4P+ar/D4v5OUM
jyQwJZzP5/CXir9SWhAeVkfcvuUTya/OyG8fXjgvdxKMyOjF4MHR5BvQ4aDfz/gv
QGNj3angjL9RvLsGkVg5w+QwUcS5c8R0lE28gsfdUKcnqnw4M8KI1O0H1nUiEC3u
zXe2XMOFr3o7NXmxZgQ6Or1ArCtBvG5uWImMmM8klzslaM/vL8y6Z8vL4TmwAcw=
=6xG6
-----END PGP SIGNATURE-----

--dc+cDN39EJAMEtIO--


--===============7654249215747121272==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7654249215747121272==--
