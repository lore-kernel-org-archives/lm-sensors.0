From: Thierry Reding <thierry.reding@avionic-design.de>
Date: Mon, 21 Nov 2011 13:11:19 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (lm63) Fix checkpatch errors
Message-Id: <20111121131118.GA23122@avionic-0098.adnet.avionic-design.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8877365106182550195=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1321828936-15123-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1321828936-15123-1-git-send-email-guenter.roeck@ericsson.com>
To: lm-sensors@vger.kernel.org


--===============8877365106182550195==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Guenter Roeck wrote:
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
>  drivers/hwmon/lm63.c |   74 +++++++++++++++++++++++++++++++++++---------=
-----
>  1 files changed, 53 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/hwmon/lm63.c b/drivers/hwmon/lm63.c
> index 508cb29..e02d7f0 100644
> --- a/drivers/hwmon/lm63.c
> +++ b/drivers/hwmon/lm63.c
> @@ -204,7 +204,12 @@ static ssize_t set_fan(struct device *dev, struct de=
vice_attribute *dummy,
>  {
>  	struct i2c_client *client =3D to_i2c_client(dev);
>  	struct lm63_data *data =3D i2c_get_clientdata(client);
> -	unsigned long val =3D simple_strtoul(buf, NULL, 10);
> +	unsigned long val;
> +	int err;
> +
> +	err =3D kstrtoul(buf, 10, &val);
> +	if (err)
> +		return err;
> =20
>  	mutex_lock(&data->update_lock);
>  	data->fan[1] =3D FAN_TO_REG(val);
> @@ -231,11 +236,15 @@ static ssize_t set_pwm1(struct device *dev, struct =
device_attribute *dummy,
>  	struct i2c_client *client =3D to_i2c_client(dev);
>  	struct lm63_data *data =3D i2c_get_clientdata(client);
>  	unsigned long val;
> -=09
> +	int err;
> +
>  	if (!(data->config_fan & 0x20)) /* register is read-only */
>  		return -EPERM;
> =20
> -	val =3D simple_strtoul(buf, NULL, 10);
> +	err =3D kstrtoul(buf, 10, &val);
> +	if (err)
> +		return err;
> +
>  	mutex_lock(&data->update_lock);
>  	data->pwm1_value =3D val <=3D 0 ? 0 :
>  			   val >=3D 255 ? 2 * data->pwm1_freq :
> @@ -245,8 +254,8 @@ static ssize_t set_pwm1(struct device *dev, struct de=
vice_attribute *dummy,
>  	return count;
>  }
> =20
> -static ssize_t show_pwm1_enable(struct device *dev, struct device_attrib=
ute *dummy,
> -				char *buf)
> +static ssize_t show_pwm1_enable(struct device *dev,
> +				struct device_attribute *dummy, char *buf)
>  {
>  	struct lm63_data *data =3D lm63_update_device(dev);
>  	return sprintf(buf, "%d\n", data->config_fan & 0x20 ? 1 : 2);
> @@ -283,7 +292,12 @@ static ssize_t set_local_temp8(struct device *dev,
>  {
>  	struct i2c_client *client =3D to_i2c_client(dev);
>  	struct lm63_data *data =3D i2c_get_clientdata(client);
> -	long val =3D simple_strtol(buf, NULL, 10);
> +	long val;
> +	int err;
> +
> +	err =3D kstrtol(buf, 10, &val);
> +	if (err)
> +		return err;
> =20
>  	mutex_lock(&data->update_lock);
>  	data->temp8[1] =3D TEMP8_TO_REG(val);
> @@ -314,9 +328,14 @@ static ssize_t set_temp11(struct device *dev, struct=
 device_attribute *devattr,
>  	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
>  	struct i2c_client *client =3D to_i2c_client(dev);
>  	struct lm63_data *data =3D i2c_get_clientdata(client);
> -	long val =3D simple_strtol(buf, NULL, 10);
> +	long val;
> +	int err;
>  	int nr =3D attr->index;
> =20
> +	err =3D kstrtol(buf, 10, &val);
> +	if (err)
> +		return err;
> +
>  	mutex_lock(&data->update_lock);
>  	data->temp11[nr] =3D TEMP11_TO_REG(val - data->temp2_offset);
>  	i2c_smbus_write_byte_data(client, reg[(nr - 1) * 2],
> @@ -327,10 +346,12 @@ static ssize_t set_temp11(struct device *dev, struc=
t device_attribute *devattr,
>  	return count;
>  }
> =20
> -/* Hysteresis register holds a relative value, while we want to present
> -   an absolute to user-space */
> -static ssize_t show_temp2_crit_hyst(struct device *dev, struct device_at=
tribute *dummy,
> -				    char *buf)
> +/*
> + * Hysteresis register holds a relative value, while we want to present
> + * an absolute to user-space
> + */
> +static ssize_t show_temp2_crit_hyst(struct device *dev,
> +				    struct device_attribute *dummy, char *buf)
>  {
>  	struct lm63_data *data =3D lm63_update_device(dev);
>  	return sprintf(buf, "%d\n", TEMP8_FROM_REG(data->temp8[2])
> @@ -338,16 +359,24 @@ static ssize_t show_temp2_crit_hyst(struct device *=
dev, struct device_attribute
>  		       - TEMP8_FROM_REG(data->temp2_crit_hyst));
>  }
> =20
> -/* And now the other way around, user-space provides an absolute
> -   hysteresis value and we have to store a relative one */
> -static ssize_t set_temp2_crit_hyst(struct device *dev, struct device_att=
ribute *dummy,
> +/*
> + * And now the other way around, user-space provides an absolute
> + * hysteresis value and we have to store a relative one
> + */
> +static ssize_t set_temp2_crit_hyst(struct device *dev,
> +				   struct device_attribute *dummy,
>  				   const char *buf, size_t count)
>  {
>  	struct i2c_client *client =3D to_i2c_client(dev);
>  	struct lm63_data *data =3D i2c_get_clientdata(client);
> -	long val =3D simple_strtol(buf, NULL, 10);
> +	long val;
> +	int err;
>  	long hyst;
> =20
> +	err =3D kstrtol(buf, 10, &val);
> +	if (err)
> +		return err;
> +
>  	mutex_lock(&data->update_lock);
>  	hyst =3D TEMP8_FROM_REG(data->temp8[2]) + data->temp2_offset - val;
>  	i2c_smbus_write_byte_data(client, LM63_REG_REMOTE_TCRIT_HYST,
> @@ -518,12 +547,13 @@ static int lm63_probe(struct i2c_client *new_client,
>  	lm63_init_client(new_client);
> =20
>  	/* Register sysfs hooks */
> -	if ((err =3D sysfs_create_group(&new_client->dev.kobj,
> -				      &lm63_group)))
> +	err =3D sysfs_create_group(&new_client->dev.kobj, &lm63_group);
> +	if (err)
>  		goto exit_free;
>  	if (data->config & 0x04) { /* tachometer enabled */
> -		if ((err =3D sysfs_create_group(&new_client->dev.kobj,
> -					      &lm63_group_fan1)))
> +		err =3D sysfs_create_group(&new_client->dev.kobj,
> +					 &lm63_group_fan1);
> +		if (err)
>  			goto exit_remove_files;
>  	}
> =20
> @@ -544,8 +574,10 @@ exit:
>  	return err;
>  }
> =20
> -/* Idealy we shouldn't have to initialize anything, since the BIOS
> -   should have taken care of everything */
> +/*
> + * Ideally we shouldn't have to initialize anything, since the BIOS
> + * should have taken care of everything
> + */
>  static void lm63_init_client(struct i2c_client *client)
>  {
>  	struct lm63_data *data =3D i2c_get_clientdata(client);
> --=20
> 1.7.3.1

Tested-by: Thierry Reding <thierry.reding@avionic-design.de>

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk7KTfYACgkQZ+BJyKLjJp/SmgCeJHQkyMgBaaiXwba6ZyfP0n0W
yAMAnRHkjOKLb9Ob/dx1uo2rWumf2RB7
=+DTW
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--


--===============8877365106182550195==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8877365106182550195==--
