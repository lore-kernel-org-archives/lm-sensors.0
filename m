From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 24 Jul 2007 12:06:04 +0000
Subject: Re: [lm-sensors]
Message-Id: <20070724140604.43773b09@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <87ekb9s3tn.wl%info@wore.ma.cx>
In-Reply-To: <87ekb9s3tn.wl%info@wore.ma.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Christian,

On Tue, 24 Jul 2007 11:35:37 +0200, Christian Hohnstaedt wrote:
> writing values < 0=B0C to TLow and THigh of the LM75 is not=20
> supported by the driver, since it strtoul()s instead
> of strtol()ing.
>=20
> Trivial fix attached.

Good catch, however your fix is not correct:

> diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
> index a40166f..4fa3220 100644
> --- a/drivers/hwmon/lm75.c
> +++ b/drivers/hwmon/lm75.c
> @@ -95,7 +95,7 @@ static ssize_t set_temp(struct device *dev, struct devi=
ce_attribute *da,
>  	struct i2c_client *client =3D to_i2c_client(dev);
>  	struct lm75_data *data =3D i2c_get_clientdata(client);
>  	int nr =3D attr->index;
> -	unsigned long temp =3D simple_strtoul(buf, NULL, 10);
> +	int temp =3D simple_strtol(buf, NULL, 10);
> =20
>  	mutex_lock(&data->update_lock);
>  	data->temp[nr] =3D LM75_TEMP_TO_REG(temp);

temp should be a long rather than an int. Otherwise the input value
might wrap before LM75_TEMP_TO_REG has a chance to clamp it.

Your patch also lacks a Signed-off-by line (see
Documentation/SubmittingPatches, section 12.)

Care to resend an updated patch?

Thanks,
--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
