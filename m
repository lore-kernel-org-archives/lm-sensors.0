From: Simon Guinot <simon@sequanux.org>
Date: Wed, 21 Mar 2012 08:59:29 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (gpio-fan) Fix Kconfig dependencies
Message-Id: <20120321085928.GB6111@kw.sim.vm.gnt>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1464999186359139386=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1332299195-23898-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1332299195-23898-1-git-send-email-linux@roeck-us.net>
To: lm-sensors@vger.kernel.org


--===============1464999186359139386==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CUfgB8w4ZwR/yMy5"
Content-Disposition: inline


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 20, 2012 at 08:06:34PM -0700, Guenter Roeck wrote:
> gpio-fan depends on GPIOLIB, not on GENERIC_GPIO.
>=20
> This fixes the following build error, seen if GPIOLIB is not defined:
>=20
> src/drivers/hwmon/gpio-fan.c: error: implicit declaration of function 'gp=
io_direction_output': =3D> 372:3
> src/drivers/hwmon/gpio-fan.c: error: implicit declaration of function 'gp=
io_free': =3D> 130:2
> src/drivers/hwmon/gpio-fan.c: error: implicit declaration of function 'gp=
io_get_value': =3D> 79:2
> src/drivers/hwmon/gpio-fan.c: error: implicit declaration of function 'gp=
io_request': =3D> 98:2
> src/drivers/hwmon/gpio-fan.c: error: implicit declaration of function 'gp=
io_set_value': =3D> 156:3
> src/drivers/hwmon/gpio-fan.c: error: implicit declaration of function 'gp=
io_to_irq': =3D> 114:2
>=20
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 811e6c4..93b442d 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -425,7 +425,7 @@ config SENSORS_GL520SM
> =20
>  config SENSORS_GPIO_FAN
>  	tristate "GPIO fan"
> -	depends on GENERIC_GPIO
> +	depends on GPIOLIB
>  	help
>  	  If you say yes here you get support for fans connected to GPIO lines.
> =20

Thanks.

Acked-by: Simon Guinot <sguinot@lacie.com>

--CUfgB8w4ZwR/yMy5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk9pmHAACgkQgtp0PDeOcDqo6gCfe1U9R6n5oHMnjBPA+x60/Aen
faoAnjWHhuTzL4UnG3bZrQF5kqumOeSp
=Cb76
-----END PGP SIGNATURE-----

--CUfgB8w4ZwR/yMy5--


--===============1464999186359139386==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1464999186359139386==--
