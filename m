From: Simon Guinot <simon@sequanux.org>
Date: Tue, 09 Nov 2010 09:41:32 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (gpio-fan) Fix fan_ctrl_init
Message-Id: <20101109094132.GD32648@kw.sim.vm.gnt>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8800941682546409631=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1289292108.28671.1.camel@mola>
In-Reply-To: <1289292108.28671.1.camel@mola>
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Simon Guinot <sguinot@lacie.com>, lm-sensors@lm-sensors.org


--===============8800941682546409631==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C1iGAkRnbeBonpVg"
Content-Disposition: inline


--C1iGAkRnbeBonpVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 09, 2010 at 04:41:48PM +0800, Axel Lin wrote:
> In current implementation, the sysfs entries is not removed before return=
 -ENODEV.
>=20
> Creating the sysfs attribute should be the last thing done by the functio=
n,
> after all the rest has been successful.
> Otherwise there is a small window during which user-space can access the =
attribute
> but the driver isn't ready to deal with the requests.
>=20
> Fix it by moving sysfs_create_group to be the last thing done by the func=
tion.
>=20
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Thanks for the patch.

Acked-by: Simon Guinot <sguinot@lacie.com>

> ---
>  drivers/hwmon/gpio-fan.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
> index aa701a1..f141a1d 100644
> --- a/drivers/hwmon/gpio-fan.c
> +++ b/drivers/hwmon/gpio-fan.c
> @@ -376,10 +376,6 @@ static int fan_ctrl_init(struct gpio_fan_data *fan_d=
ata,
>  		}
>  	}
> =20
> -	err =3D sysfs_create_group(&pdev->dev.kobj, &gpio_fan_ctrl_group);
> -	if (err)
> -		goto err_free_gpio;
> -
>  	fan_data->num_ctrl =3D num_ctrl;
>  	fan_data->ctrl =3D ctrl;
>  	fan_data->num_speed =3D pdata->num_speed;
> @@ -391,6 +387,10 @@ static int fan_ctrl_init(struct gpio_fan_data *fan_d=
ata,
>  		goto err_free_gpio;
>  	}
> =20
> +	err =3D sysfs_create_group(&pdev->dev.kobj, &gpio_fan_ctrl_group);
> +	if (err)
> +		goto err_free_gpio;
> +
>  	return 0;
> =20
>  err_free_gpio:
> --=20
> 1.7.2
>=20
>=20
>=20
>=20
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

--C1iGAkRnbeBonpVg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkzZF0wACgkQgtp0PDeOcDrX0QCfXzeBApH/+3+ZL7w7/x3kUHIi
FmAAnRReJqF13v9nk/wY64d2+MF01JEv
=9Z0I
-----END PGP SIGNATURE-----

--C1iGAkRnbeBonpVg--


--===============8800941682546409631==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8800941682546409631==--
