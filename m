From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Date: Fri, 15 Jun 2012 19:13:57 +0000
Subject: Re: [lm-sensors] [PATCH 01/95] hwmon: (mc13783-adc.c) Convert to use devm_ functions
Message-Id: <20120615191357.GB5027@pengutronix.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1339773856-3443-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1339773856-3443-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Fri, Jun 15, 2012 at 08:22:42AM -0700, Guenter Roeck wrote:
> Convert to use devm_ functions to reduce code size and simplify the code.
>=20
> Cc: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Looks good, Acked-by: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

> ---
>  drivers/hwmon/mc13783-adc.c |   12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/hwmon/mc13783-adc.c b/drivers/hwmon/mc13783-adc.c
> index ce86c5e..cf47a59 100644
> --- a/drivers/hwmon/mc13783-adc.c
> +++ b/drivers/hwmon/mc13783-adc.c
> @@ -179,7 +179,7 @@ static int __init mc13783_adc_probe(struct platform_d=
evice *pdev)
>  	const struct platform_device_id *id =3D platform_get_device_id(pdev);
>  	char *dash;
> =20
> -	priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
> +	priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
>  		return -ENOMEM;
> =20
> @@ -194,7 +194,7 @@ static int __init mc13783_adc_probe(struct platform_d=
evice *pdev)
>  	/* Register sysfs hooks */
>  	ret =3D sysfs_create_group(&pdev->dev.kobj, &mc13783_group_base);
>  	if (ret)
> -		goto out_err_create_base;
> +		return ret;
> =20
>  	if (id->driver_data & MC13783_ADC_16CHANS) {
>  		ret =3D sysfs_create_group(&pdev->dev.kobj,
> @@ -230,11 +230,6 @@ out_err_create_ts:
>  out_err_create_16chans:
> =20
>  	sysfs_remove_group(&pdev->dev.kobj, &mc13783_group_base);
> -out_err_create_base:
> -
> -	platform_set_drvdata(pdev, NULL);
> -	kfree(priv);
> -
>  	return ret;
>  }
> =20
> @@ -253,9 +248,6 @@ static int __devexit mc13783_adc_remove(struct platfo=
rm_device *pdev)
> =20
>  	sysfs_remove_group(&pdev->dev.kobj, &mc13783_group_base);
> =20
> -	platform_set_drvdata(pdev, NULL);
> -	kfree(priv);
> -
>  	return 0;
>  }
> =20
> --=20
> 1.7.9.7
>=20
>=20

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
