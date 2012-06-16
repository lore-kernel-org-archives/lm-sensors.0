From: Simon Guinot <simon@sequanux.org>
Date: Sat, 16 Jun 2012 12:05:24 +0000
Subject: Re: [lm-sensors] [PATCH 39/95] hwmon: (gpio-fan) Convert to use devm_ functions
Message-Id: <20120616120524.GI3454@kw.sim.vm.gnt>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7495941510804727657=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1339773856-3443-40-git-send-email-linux@roeck-us.net>
In-Reply-To: <1339773856-3443-40-git-send-email-linux@roeck-us.net>
To: lm-sensors@vger.kernel.org


--===============7495941510804727657==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gTY1JhLGodeuSBqf"
Content-Disposition: inline


--gTY1JhLGodeuSBqf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

On Fri, Jun 15, 2012 at 08:23:20AM -0700, Guenter Roeck wrote:
> Convert to use devm_ functions to reduce code size and simplify the code.
>=20
> Cc: Simon Guinot <sguinot@lacie.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/gpio-fan.c |   56 +++++++++++++---------------------------=
------
>  1 file changed, 15 insertions(+), 41 deletions(-)
>=20
> diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
> index 2ce8c44..b90b3e9 100644
> --- a/drivers/hwmon/gpio-fan.c
> +++ b/drivers/hwmon/gpio-fan.c
> @@ -95,17 +95,17 @@ static int fan_alarm_init(struct gpio_fan_data *fan_d=
ata,
> =20
>  	fan_data->alarm =3D alarm;
> =20
> -	err =3D gpio_request(alarm->gpio, "GPIO fan alarm");
> +	err =3D devm_gpio_request(&pdev->dev, alarm->gpio, "GPIO fan alarm");
>  	if (err)
>  		return err;
> =20
>  	err =3D gpio_direction_input(alarm->gpio);
>  	if (err)
> -		goto err_free_gpio;
> +		return err;
> =20
>  	err =3D device_create_file(&pdev->dev, &dev_attr_fan1_alarm);
>  	if (err)
> -		goto err_free_gpio;
> +		return err;
> =20
>  	/*
>  	 * If the alarm GPIO don't support interrupts, just leave
> @@ -117,8 +117,8 @@ static int fan_alarm_init(struct gpio_fan_data *fan_d=
ata,
> =20
>  	INIT_WORK(&fan_data->alarm_work, fan_alarm_notify);
>  	irq_set_irq_type(alarm_irq, IRQ_TYPE_EDGE_BOTH);
> -	err =3D request_irq(alarm_irq, fan_alarm_irq_handler, IRQF_SHARED,
> -			  "GPIO fan alarm", fan_data);
> +	err =3D devm_request_irq(&pdev->dev, alarm_irq, fan_alarm_irq_handler,
> +			       IRQF_SHARED, "GPIO fan alarm", fan_data);
>  	if (err)
>  		goto err_free_sysfs;

I am not sure you can skip GPIO freeing here. After:

        /*
         * If the alarm GPIO don't support interrupts, just leave
         * without initializing the fail notification support.
         */
        alarm_irq =3D gpio_to_irq(alarm->gpio);
        if (alarm_irq < 0)
                return 0;

You can leave fan_alarm_init() without any error and with some GPIOs
configured but not used.=20

Simon

> =20
> @@ -126,21 +126,14 @@ static int fan_alarm_init(struct gpio_fan_data *fan=
_data,
> =20
>  err_free_sysfs:
>  	device_remove_file(&pdev->dev, &dev_attr_fan1_alarm);
> -err_free_gpio:
> -	gpio_free(alarm->gpio);
> -
>  	return err;
>  }
> =20
>  static void fan_alarm_free(struct gpio_fan_data *fan_data)
>  {
>  	struct platform_device *pdev =3D fan_data->pdev;
> -	int alarm_irq =3D gpio_to_irq(fan_data->alarm->gpio);
> =20
> -	if (alarm_irq >=3D 0)
> -		free_irq(alarm_irq, fan_data);
>  	device_remove_file(&pdev->dev, &dev_attr_fan1_alarm);
> -	gpio_free(fan_data->alarm->gpio);
>  }
> =20
>  /*
> @@ -365,15 +358,14 @@ static int fan_ctrl_init(struct gpio_fan_data *fan_=
data,
>  	int i, err;
> =20
>  	for (i =3D 0; i < num_ctrl; i++) {
> -		err =3D gpio_request(ctrl[i], "GPIO fan control");
> +		err =3D devm_gpio_request(&pdev->dev, ctrl[i],
> +					"GPIO fan control");
>  		if (err)
> -			goto err_free_gpio;
> +			return err;
> =20
>  		err =3D gpio_direction_output(ctrl[i], gpio_get_value(ctrl[i]));
> -		if (err) {
> -			gpio_free(ctrl[i]);
> -			goto err_free_gpio;
> -		}
> +		if (err)
> +			return err;
>  	}
> =20
>  	fan_data->num_ctrl =3D num_ctrl;
> @@ -382,32 +374,18 @@ static int fan_ctrl_init(struct gpio_fan_data *fan_=
data,
>  	fan_data->speed =3D pdata->speed;
>  	fan_data->pwm_enable =3D true; /* Enable manual fan speed control. */
>  	fan_data->speed_index =3D get_fan_speed_index(fan_data);
> -	if (fan_data->speed_index < 0) {
> -		err =3D -ENODEV;
> -		goto err_free_gpio;
> -	}
> +	if (fan_data->speed_index < 0)
> +		return -ENODEV;
> =20
>  	err =3D sysfs_create_group(&pdev->dev.kobj, &gpio_fan_ctrl_group);
> -	if (err)
> -		goto err_free_gpio;
> -
> -	return 0;
> -
> -err_free_gpio:
> -	for (i =3D i - 1; i >=3D 0; i--)
> -		gpio_free(ctrl[i]);
> -
>  	return err;
>  }
> =20
>  static void fan_ctrl_free(struct gpio_fan_data *fan_data)
>  {
>  	struct platform_device *pdev =3D fan_data->pdev;
> -	int i;
> =20
>  	sysfs_remove_group(&pdev->dev.kobj, &gpio_fan_ctrl_group);
> -	for (i =3D 0; i < fan_data->num_ctrl; i++)
> -		gpio_free(fan_data->ctrl[i]);
>  }
> =20
>  /*
> @@ -431,7 +409,8 @@ static int __devinit gpio_fan_probe(struct platform_d=
evice *pdev)
>  	if (!pdata)
>  		return -EINVAL;
> =20
> -	fan_data =3D kzalloc(sizeof(struct gpio_fan_data), GFP_KERNEL);
> +	fan_data =3D devm_kzalloc(&pdev->dev, sizeof(struct gpio_fan_data),
> +				GFP_KERNEL);
>  	if (!fan_data)
>  		return -ENOMEM;
> =20
> @@ -443,7 +422,7 @@ static int __devinit gpio_fan_probe(struct platform_d=
evice *pdev)
>  	if (pdata->alarm) {
>  		err =3D fan_alarm_init(fan_data, pdata->alarm);
>  		if (err)
> -			goto err_free_data;
> +			return err;
>  	}
> =20
>  	/* Configure control GPIOs if available. */
> @@ -480,10 +459,6 @@ err_free_ctrl:
>  err_free_alarm:
>  	if (fan_data->alarm)
>  		fan_alarm_free(fan_data);
> -err_free_data:
> -	platform_set_drvdata(pdev, NULL);
> -	kfree(fan_data);
> -
>  	return err;
>  }
> =20
> @@ -497,7 +472,6 @@ static int __devexit gpio_fan_remove(struct platform_=
device *pdev)
>  		fan_alarm_free(fan_data);
>  	if (fan_data->ctrl)
>  		fan_ctrl_free(fan_data);
> -	kfree(fan_data);
> =20
>  	return 0;
>  }
> --=20
> 1.7.9.7
>=20
>=20
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

--gTY1JhLGodeuSBqf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk/cdoQACgkQgtp0PDeOcDpT1ACeJtCY6vU41kU4GUGIqSZJXFqv
Ly4An0C1gV16fo+sLXyPdnImMWpIRqY7
=DhZn
-----END PGP SIGNATURE-----

--gTY1JhLGodeuSBqf--


--===============7495941510804727657==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7495941510804727657==--
