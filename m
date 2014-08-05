From: Jean Delvare <jdelvare@suse.de>
Date: Tue, 05 Aug 2014 18:00:03 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (emc6w201) Fix temperature limit range
Message-Id: <20140805200003.5bb18818@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1407257823-6845-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1407257823-6845-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Tue,  5 Aug 2014 09:57:03 -0700, Guenter Roeck wrote:
> Temperature limit range is [-128, 127], not [-127, 128].
> The wrong range caused a bad limit to be written into the chip
> if the limit was set to a value of 128 degrees C or above.

According to the datasheet, -128 is not actually a valid temperature
limit, so I would clamp to [-127, 127]. The temperature sensors return
-128 to indicate an error, not a temperature of -128=B0C.

> Also use DIV_ROUND_CLOSEST instead of a plan divide operation
> to reduce the rounding error when writing temperature limits.

Good idea.

>=20
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/emc6w201.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hwmon/emc6w201.c b/drivers/hwmon/emc6w201.c
> index e87da90..80c2f42 100644
> --- a/drivers/hwmon/emc6w201.c
> +++ b/drivers/hwmon/emc6w201.c
> @@ -252,12 +252,12 @@ static ssize_t set_temp(struct device *dev, struct =
device_attribute *devattr,
>  	if (err < 0)
>  		return err;
> =20
> -	val /=3D 1000;
> +	val =3D DIV_ROUND_CLOSEST(val, 1000);
>  	reg =3D (sf =3D=3D min) ? EMC6W201_REG_TEMP_LOW(nr)
>  			  : EMC6W201_REG_TEMP_HIGH(nr);
> =20
>  	mutex_lock(&data->update_lock);
> -	data->temp[sf][nr] =3D clamp_val(val, -127, 128);
> +	data->temp[sf][nr] =3D clamp_val(val, -128, 127);
>  	err =3D emc6w201_write8(client, reg, data->temp[sf][nr]);
>  	mutex_unlock(&data->update_lock);
> =20


--=20
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
