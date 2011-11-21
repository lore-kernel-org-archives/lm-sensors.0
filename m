From: Thierry Reding <thierry.reding@avionic-design.de>
Date: Mon, 21 Nov 2011 13:11:54 +0000
Subject: Re: [lm-sensors] [PATCH v2 2/2] hwmon: (lm63) Add support for
Message-Id: <20111121131154.GB23122@avionic-0098.adnet.avionic-design.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5683902207217862505=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1321830618-15817-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1321830618-15817-1-git-send-email-guenter.roeck@ericsson.com>
To: lm-sensors@vger.kernel.org


--===============5683902207217862505==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
Content-Disposition: inline


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Guenter Roeck wrote:
> LM96163 is an enhanced version of LM63 with improved PWM resolution. Add =
chip
> detection code as well as support for improved PWM resolution if the chip=
 is
> configured to use it.
>=20
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
> Tested with LM63 and LM96163.
>=20
> v2: Update documentation.
>=20
>  Documentation/hwmon/lm63 |    8 ++++++++
>  drivers/hwmon/Kconfig    |    2 +-
>  drivers/hwmon/lm63.c     |   33 ++++++++++++++++++++++++++++-----
>  3 files changed, 37 insertions(+), 6 deletions(-)
>=20
> diff --git a/Documentation/hwmon/lm63 b/Documentation/hwmon/lm63
> index b9843ea..a4172ee 100644
> --- a/Documentation/hwmon/lm63
> +++ b/Documentation/hwmon/lm63
> @@ -12,6 +12,11 @@ Supported chips:
>      Addresses scanned: I2C 0x18 and 0x4e
>      Datasheet: Publicly available at the National Semiconductor website
>                 http://www.national.com/pf/LM/LM64.html
> +  * National Semiconductor LM96163
> +    Prefix: 'lm96163'
> +    Addresses scanned: I2C 0x4c
> +    Datasheet: Publicly available at the National Semiconductor website
> +               http://www.national.com/ds/LM/LM96163.pdf
> =20
>  Author: Jean Delvare <khali@linux-fr.org>
> =20
> @@ -62,3 +67,6 @@ values.
> =20
>  The LM64 is effectively an LM63 with GPIO lines. The driver does not
>  support these GPIO lines at present.
> +
> +The LM96163 is an enhanced version of LM63 with improved temperature acc=
uracy
> +and better PWM resolution.
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 91be41f..e5739a0 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -519,7 +519,7 @@ config SENSORS_LM63
>  	depends on I2C
>  	help
>  	  If you say yes here you get support for the National
> -	  Semiconductor LM63 and LM64 remote diode digital temperature
> +	  Semiconductor LM63, LM64, and LM96163 remote diode digital temperature
>  	  sensors with integrated fan control.  Such chips are found
>  	  on the Tyan S4882 (Thunder K8QS Pro) motherboard, among
>  	  others.
> diff --git a/drivers/hwmon/lm63.c b/drivers/hwmon/lm63.c
> index e02d7f0..3e20da9 100644
> --- a/drivers/hwmon/lm63.c
> +++ b/drivers/hwmon/lm63.c
> @@ -91,6 +91,8 @@ static const unsigned short normal_i2c[] =3D { 0x18, 0x=
4c, 0x4e, I2C_CLIENT_END };
>  #define LM63_REG_MAN_ID			0xFE
>  #define LM63_REG_CHIP_ID		0xFF
> =20
> +#define LM96163_REG_CONFIG_ENHANCED	0x45
> +
>  /*
>   * Conversions and various macros
>   * For tachometer counts, the LM63 uses 16-bit values.
> @@ -134,7 +136,7 @@ static struct lm63_data *lm63_update_device(struct de=
vice *dev);
>  static int lm63_detect(struct i2c_client *client, struct i2c_board_info =
*info);
>  static void lm63_init_client(struct i2c_client *client);
> =20
> -enum chips { lm63, lm64 };
> +enum chips { lm63, lm64, lm96163 };
> =20
>  /*
>   * Driver data (common to all clients)
> @@ -143,6 +145,7 @@ enum chips { lm63, lm64 };
>  static const struct i2c_device_id lm63_id[] =3D {
>  	{ "lm63", lm63 },
>  	{ "lm64", lm64 },
> +	{ "lm96163", lm96163 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, lm63_id);
> @@ -185,6 +188,7 @@ struct lm63_data {
>  			   2: remote high limit */
>  	u8 temp2_crit_hyst;
>  	u8 alarms;
> +	bool pwm_highres;
>  };
> =20
>  /*
> @@ -225,9 +229,16 @@ static ssize_t show_pwm1(struct device *dev, struct =
device_attribute *dummy,
>  			 char *buf)
>  {
>  	struct lm63_data *data =3D lm63_update_device(dev);
> -	return sprintf(buf, "%d\n", data->pwm1_value >=3D 2 * data->pwm1_freq ?
> +	int pwm;
> +
> +	if (data->pwm_highres)
> +		pwm =3D data->pwm1_value;
> +	else
> +		pwm =3D data->pwm1_value >=3D 2 * data->pwm1_freq ?
>  		       255 : (data->pwm1_value * 255 + data->pwm1_freq) /
> -		       (2 * data->pwm1_freq));
> +		       (2 * data->pwm1_freq);
> +
> +	return sprintf(buf, "%d\n", pwm);
>  }
> =20
>  static ssize_t set_pwm1(struct device *dev, struct device_attribute *dum=
my,
> @@ -245,9 +256,9 @@ static ssize_t set_pwm1(struct device *dev, struct de=
vice_attribute *dummy,
>  	if (err)
>  		return err;
> =20
> +	val =3D SENSORS_LIMIT(val, 0, 255);
>  	mutex_lock(&data->update_lock);
> -	data->pwm1_value =3D val <=3D 0 ? 0 :
> -			   val >=3D 255 ? 2 * data->pwm1_freq :
> +	data->pwm1_value =3D data->pwm_highres ? val :
>  			   (val * data->pwm1_freq * 2 + 127) / 255;
>  	i2c_smbus_write_byte_data(client, LM63_REG_PWM_VALUE, data->pwm1_value);
>  	mutex_unlock(&data->update_lock);
> @@ -516,6 +527,8 @@ static int lm63_detect(struct i2c_client *new_client,
>  		strlcpy(info->type, "lm63", I2C_NAME_SIZE);
>  	else if (chip_id =3D=3D 0x51 && (address =3D=3D 0x18 || address =3D=3D =
0x4e))
>  		strlcpy(info->type, "lm64", I2C_NAME_SIZE);
> +	else if (chip_id =3D=3D 0x49 && address =3D=3D 0x4c)
> +		strlcpy(info->type, "lm96163", I2C_NAME_SIZE);
>  	else
>  		return -ENODEV;
> =20
> @@ -599,6 +612,16 @@ static void lm63_init_client(struct i2c_client *clie=
nt)
>  	if (data->pwm1_freq =3D=3D 0)
>  		data->pwm1_freq =3D 1;
> =20
> +	/* For LM96163, check if high resolution PWM is enabled */
> +	if (data->kind =3D=3D lm96163
> +	    && !(data->config_fan & 0x08) && data->pwm1_freq =3D=3D 8) {
> +		u8 config_enhanced
> +		  =3D i2c_smbus_read_byte_data(client,
> +					     LM96163_REG_CONFIG_ENHANCED);
> +		if (config_enhanced & 0x10)
> +			data->pwm_highres =3D true;
> +	}
> +
>  	/* Show some debug info about the LM63 configuration */
>  	dev_dbg(&client->dev, "Alert/tach pin configured for %s\n",
>  		(data->config & 0x04) ? "tachometer input" :
> --=20
> 1.7.3.1

Thanks for taking care of this.

Tested-by: Thierry Reding <thierry.reding@avionic-design.de>

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk7KThoACgkQZ+BJyKLjJp8flACgiHvSCvosbHTHozZz5DYl2zAY
zjgAn2iuGpXxXlygpqTJYaVvGF4+7MYb
=LI0c
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--


--===============5683902207217862505==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5683902207217862505==--
