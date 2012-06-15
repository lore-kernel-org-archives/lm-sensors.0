From: Wolfram Sang <w.sang@pengutronix.de>
Date: Fri, 15 Jun 2012 15:52:30 +0000
Subject: Re: [lm-sensors] [PATCH 17/95] hwmon: (adt7411) Convert to use devm_ functions
Message-Id: <20120615155230.GA25453@pengutronix.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2767759209370898241=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1339773856-3443-18-git-send-email-linux@roeck-us.net>
In-Reply-To: <1339773856-3443-18-git-send-email-linux@roeck-us.net>
To: lm-sensors@vger.kernel.org


--===============2767759209370898241==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 15, 2012 at 08:22:58AM -0700, Guenter Roeck wrote:
> Convert to use devm_ functions to reduce code size and simplify the code.
>=20
> Cc: Wolfram Sang <w.sang@pengutronix.de>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

I won't NACK it, but I don't think it is worth it. It increases runtime
memory usage and execution time. Marginally, yes, but the gain in code
size reduction is also marginally. If there is lots of devm_* in a
driver, this is usually good, but I wouldn't care about converting
single kzalloc calls.

Regards,

   Wolfram

> ---
>  drivers/hwmon/adt7411.c |    9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/hwmon/adt7411.c b/drivers/hwmon/adt7411.c
> index 71bacc5..fe72c69 100644
> --- a/drivers/hwmon/adt7411.c
> +++ b/drivers/hwmon/adt7411.c
> @@ -283,7 +283,7 @@ static int __devinit adt7411_probe(struct i2c_client =
*client,
>  	struct adt7411_data *data;
>  	int ret;
> =20
> -	data =3D kzalloc(sizeof(*data), GFP_KERNEL);
> +	data =3D devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
>  	if (!data)
>  		return -ENOMEM;
> =20
> @@ -294,14 +294,14 @@ static int __devinit adt7411_probe(struct i2c_clien=
t *client,
>  	ret =3D adt7411_modify_bit(client, ADT7411_REG_CFG1,
>  				 ADT7411_CFG1_START_MONITOR, 1);
>  	if (ret < 0)
> -		goto exit_free;
> +		return ret;
> =20
>  	/* force update on first occasion */
>  	data->next_update =3D jiffies;
> =20
>  	ret =3D sysfs_create_group(&client->dev.kobj, &adt7411_attr_grp);
>  	if (ret)
> -		goto exit_free;
> +		return ret;
> =20
>  	data->hwmon_dev =3D hwmon_device_register(&client->dev);
>  	if (IS_ERR(data->hwmon_dev)) {
> @@ -315,8 +315,6 @@ static int __devinit adt7411_probe(struct i2c_client =
*client,
> =20
>   exit_remove:
>  	sysfs_remove_group(&client->dev.kobj, &adt7411_attr_grp);
> - exit_free:
> -	kfree(data);
>  	return ret;
>  }
> =20
> @@ -326,7 +324,6 @@ static int __devexit adt7411_remove(struct i2c_client=
 *client)
> =20
>  	hwmon_device_unregister(data->hwmon_dev);
>  	sysfs_remove_group(&client->dev.kobj, &adt7411_attr_grp);
> -	kfree(data);
>  	return 0;
>  }
> =20
> --=20
> 1.7.9.7
>=20

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk/bWj4ACgkQD27XaX1/VRtxbACcDz3znFaI0VZDbj+SyktAJlNF
vW8An14LdvwDNxsX+SIIEdeZTLHr12+e
=b6oM
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--


--===============2767759209370898241==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2767759209370898241==--
