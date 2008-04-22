From: Laurent Pinchart <laurentp@cse-semaphore.com>
Date: Tue, 22 Apr 2008 12:38:06 +0000
Subject: Re: [lm-sensors] [patch 2.6.25-rc9 3/5] lm75: support 12-bit
Message-Id: <200804221438.09304.laurentp@cse-semaphore.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6428882974880451851=="
List-Id: <lm-sensors.vger.kernel.org>
References: <200804161030.56626.david-b@pacbell.net>
In-Reply-To: <200804161030.56626.david-b@pacbell.net>
To: lm-sensors@vger.kernel.org

--===============6428882974880451851==
Content-Type: multipart/signed; boundary="nextPart1459583.7BILqGnvvh";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1459583.7BILqGnvvh
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi David,

On Wednesday 16 April 2008 19:30, David Brownell wrote:
> Make the lm75 driver so that use the best resolution available on
> each chip it finds ... usually this is 12 bits (0.0625 degrees C).
>=20
> Note that this preserves the quirky "round away from zero" behavior
> for converting temperatures to sensor values.  (I'd think no rounding
> at all would be better.)
>=20
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> ---
>  drivers/hwmon/Kconfig |    4 +++-
>  drivers/hwmon/lm75.c  |   44 ++++++++++++++++++++++++++++++++++++--------
>  2 files changed, 39 insertions(+), 9 deletions(-)
>=20
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -391,7 +391,9 @@ config SENSORS_LM75
>  		- Texas Instruments TMP100, TMP101, TMP75, TMP175, TMP275
> =20
>  	  This driver supports driver model based binding through board
> -	  specific I2C device tables.
> +	  specific I2C device tables.  When those tables report a chip
> +	  type that's recognized as supporting it, this driver uses 12-bit
> +	  sample resolution (to 1/16 degree C).
> =20
>  	  It also supports the "legacy" style of driver binding.  To use
>  	  that with some chips which don't replicate LM75 quirks exactly,
> --- a/drivers/hwmon/lm75.c
> +++ b/drivers/hwmon/lm75.c
> @@ -27,7 +27,6 @@
>  #include <linux/hwmon-sysfs.h>
>  #include <linux/err.h>
>  #include <linux/mutex.h>
> -#include "lm75.h"
> =20
> =20
>  /*
> @@ -65,6 +64,8 @@ struct lm75_data {
>  						   0 =3D input
>  						   1 =3D max
>  						   2 =3D hyst */
> +	u16			round;		/* f(resolution) */
> +	u16			mask;
>  };
> =20
>  static int lm75_read_value(struct i2c_client *client, u8 reg);
> @@ -74,7 +75,7 @@ static struct lm75_data *lm75_update_dev
> =20
>  /*----------------------------------------------------------------------=
=2D*/
> =20
> -/* sysfs attributes for hwmon */
> +/* sysfs attributes for hwmon, handling any sample resolution */
> =20
>  static inline s16 temp_to_reg(struct lm75_data *lm75, long temp)
>  {
> @@ -83,12 +84,19 @@ static inline s16 temp_to_reg(struct lm7
>  	else if (temp > lm75->max)
>  		temp =3D lm75->max;
> =20
> -	return LM75_TEMP_TO_REG(temp);
> +	/* "Round away from zero" -- unusual but backwards-compatible.
> +	 * Rounding should really be done *after* conversion.
> +	 */
> +	temp +=3D (temp < 0) ? -lm75->round : lm75->round;
> +	return ((temp * 256) / 1000) & lm75->mask;
>  }
> =20
>  static inline int reg_to_temp(s16 reg)
>  {
> -	return LM75_TEMP_FROM_REG(reg);
> +	/* Use integer division instead of logical right shift to
> +	 * preserve sign (compiler uses arithmetic right shift).
> +	 */
> +	return (reg * 1000) / 256;
>  }
> =20
>  static ssize_t show_temp(struct device *dev, struct device_attribute *da,
> @@ -97,7 +105,8 @@ static ssize_t show_temp(struct device *
>  	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(da);
>  	struct lm75_data *data =3D lm75_update_device(dev);
> =20
> -	return sprintf(buf, "%d\n", reg_to_temp(data->temp[attr->index]));
> +	return sprintf(buf, "%d\n",
> +		reg_to_temp(data->temp[attr->index]) & data->mask);

This should be

	return sprintf(buf, "%d\n",
		reg_to_temp(data->temp[attr->index] & data->mask));

>  }
> =20
>  static ssize_t set_temp(struct device *dev, struct device_attribute *da,
> @@ -144,6 +153,7 @@ static int lm75_probe(struct i2c_client=20
>  	int status;
>  	u8 set_mask, clr_mask;
>  	int new;
> +	int resolution;
> =20
>  	if (!i2c_check_functionality(client->adapter,
>  			I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA))
> @@ -163,13 +173,27 @@ static int lm75_probe(struct i2c_client=20
>  	set_mask =3D 0;
>  	clr_mask =3D (1 << 0)			/* continuous conversions */
>  		| (1 << 6) | (1 << 5);		/* 9-bit mode */
> +	resolution =3D 9;
> =20
>  	data->min =3D -55 * 1000;
>  	data->max =3D 125 * 1000;
> =20
>  	/* for tmp175 or tmp275, use name "tmp75" */
> -	if (strcmp(client->name, "tmp75") =3D=3D 0)
> +	if (strcmp(client->name, "tmp75") =3D=3D 0) {
>  		data->min =3D -40 * 1000;
> +		set_mask |=3D (1 << 6) | (1 << 5);
> +		resolution =3D 12;
> +
> +	/* for ds1775, use name "ds75" */
> +	} else if (strcmp(client->name, "ds75") =3D=3D 0
> +			|| strcmp(client->name, "mcp980x") =3D=3D 0
> +			|| strcmp(client->name, "tmp100") =3D=3D 0
> +			|| strcmp(client->name, "tmp101") =3D=3D 0) {
> +		set_mask |=3D (1 << 6) | (1 << 5);
> +		resolution =3D 12;
> +
> +	} else if (strcmp(client->name, "max6626") =3D=3D 0)
> +		resolution =3D 12;
> =20
>  	/* NOTE:  also need to ensure that the chip is in interrupt mode
>  	 * in various cases, and maybe handle SMBALERT#.
> @@ -188,6 +212,9 @@ static int lm75_probe(struct i2c_client=20
>  		lm75_write_value(client, LM75_REG_CONF, new);
>  	dev_dbg(&client->dev, "Config %02x\n", new);
> =20
> +	data->round =3D 500 / (1 << (resolution - 8));
> +	data->mask =3D ~((1 << (16 - resolution)) - 1);
> +
>  	/* Register sysfs hooks */
>  	if ((status =3D sysfs_create_group(&client->dev.kobj, &lm75_group)))
>  		goto exit_free;
> @@ -198,8 +225,9 @@ static int lm75_probe(struct i2c_client=20
>  		goto exit_remove;
>  	}
> =20
> -	dev_info(&client->dev, "%s: sensor '%s'\n",
> -		data->hwmon_dev->bus_id, client->name);
> +	dev_info(&client->dev,
> +		"%s: sensor '%s', resolution %d millidegrees C\n",
> +		data->hwmon_dev->bus_id, client->name, data->round * 2);
> =20
>  	return 0;
> =20
>=20
>=20

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart1459583.7BILqGnvvh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBIDdwx8y9gWxC9vpcRAoIqAJ47sJTK09DWA/5a6v+q90yEj18g9QCgh6Wy
+kuDzTLzuQxCG8IUKWJSKVU=
=u5GN
-----END PGP SIGNATURE-----

--nextPart1459583.7BILqGnvvh--


--===============6428882974880451851==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6428882974880451851==--
