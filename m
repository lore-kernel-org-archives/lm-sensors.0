From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 29 Oct 2012 10:27:01 +0000
Subject: Re: [lm-sensors] [PATCH v2 5/9] hwmon: (it87) Save fan registers in 2-dimensional array
Message-Id: <20121029112701.5fbfda51@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1351448401-13985-6-git-send-email-linux@roeck-us.net>
In-Reply-To: <1351448401-13985-6-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sun, 28 Oct 2012 11:19:57 -0700, Guenter Roeck wrote:
> Also unify fan functions to use the same code for 8 and 16 bit fans
>=20
> This patch reduces code size by approximately 1,200 bytes on x86_64.
>=20
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Drop has_16bit_fans flag, since we'll deal with it in patch 8/8.
>=20
>  drivers/hwmon/it87.c |  255 +++++++++++++++++++-------------------------=
------
>  1 file changed, 96 insertions(+), 159 deletions(-)
>=20
> diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
> index fe2cdd4..c6426c0 100644
> --- a/drivers/hwmon/it87.c
> +++ b/drivers/hwmon/it87.c
> @@ -262,8 +262,7 @@ struct it87_data {
>  	u16 in_scaled;		/* Internal voltage sensors are scaled */
>  	u8 in[9][3];		/* [nr][0]=3Din, [1]=3Dmin, [2]=3Dmax */
>  	u8 has_fan;		/* Bitfield, fans enabled */
> -	u16 fan[5];		/* Register values, possibly combined */
> -	u16 fan_min[5];		/* Register values, possibly combined */
> +	u16 fan[5][2];		/* Register values, [nr][0]=FAn, [1]=3Dmin */
>  	u8 has_temp;		/* Bitfield, temp sensors enabled */
>  	s8 temp[3][4];		/* [nr][0]=3Dtemp, [1]=3Dmin, [2]=3Dmax, [3]=3Doffset */
>  	u8 sensor;		/* Register value */
> @@ -641,25 +640,21 @@ static int pwm_mode(const struct it87_data *data, i=
nt nr)
>  }
> =20
>  static ssize_t show_fan(struct device *dev, struct device_attribute *att=
r,
> -		char *buf)
> +			char *buf)
>  {
> -	struct sensor_device_attribute *sensor_attr =3D to_sensor_dev_attr(attr=
);
> -	int nr =3D sensor_attr->index;
> -
> +	struct sensor_device_attribute_2 *sattr =3D to_sensor_dev_attr_2(attr);
> +	int nr =3D sattr->nr;
> +	int index =3D sattr->index;
> +	int speed;
>  	struct it87_data *data =3D it87_update_device(dev);
> -	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[nr],
> -				DIV_FROM_REG(data->fan_div[nr])));
> -}
> -static ssize_t show_fan_min(struct device *dev, struct device_attribute =
*attr,
> -		char *buf)
> -{
> -	struct sensor_device_attribute *sensor_attr =3D to_sensor_dev_attr(attr=
);
> -	int nr =3D sensor_attr->index;
> =20
> -	struct it87_data *data =3D it87_update_device(dev);
> -	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan_min[nr],
> -				DIV_FROM_REG(data->fan_div[nr])));
> +	speed =3D has_16bit_fans(data) ?

has_16bit_fans() is slow so I don't like it being called at run-time.
That's why we had different sets of sysfs callback functions
originally. The change above is only acceptable because I see you'll
fix the performance regression in patch 8/9. Ideally you should have
ordered them in the other direction, but don't bother swapping them if
it means more work for you.

> +		FAN16_FROM_REG(data->fan[nr][index]) :
> +		FAN_FROM_REG(data->fan[nr][index],
> +			     DIV_FROM_REG(data->fan_div[nr]));
> +	return sprintf(buf, "%d\n", speed);
>  }
> +
>  static ssize_t show_fan_div(struct device *dev, struct device_attribute =
*attr,
>  		char *buf)
>  {
> @@ -696,11 +691,13 @@ static ssize_t show_pwm_freq(struct device *dev, st=
ruct device_attribute *attr,
> =20
>  	return sprintf(buf, "%u\n", pwm_freq[index]);
>  }
> -static ssize_t set_fan_min(struct device *dev, struct device_attribute *=
attr,
> -		const char *buf, size_t count)
> +
> +static ssize_t set_fan(struct device *dev, struct device_attribute *attr,
> +		       const char *buf, size_t count)
>  {
> -	struct sensor_device_attribute *sensor_attr =3D to_sensor_dev_attr(attr=
);
> -	int nr =3D sensor_attr->index;
> +	struct sensor_device_attribute_2 *sattr =3D to_sensor_dev_attr_2(attr);
> +	int nr =3D sattr->nr;
> +	int index =3D sattr->index;
> =20
>  	struct it87_data *data =3D dev_get_drvdata(dev);
>  	long val;
> @@ -710,24 +707,36 @@ static ssize_t set_fan_min(struct device *dev, stru=
ct device_attribute *attr,
>  		return -EINVAL;
> =20
>  	mutex_lock(&data->update_lock);
> -	reg =3D it87_read_value(data, IT87_REG_FAN_DIV);
> -	switch (nr) {
> -	case 0:
> -		data->fan_div[nr] =3D reg & 0x07;
> -		break;
> -	case 1:
> -		data->fan_div[nr] =3D (reg >> 3) & 0x07;
> -		break;
> -	case 2:
> -		data->fan_div[nr] =3D (reg & 0x40) ? 3 : 1;
> -		break;
> +
> +	if (!has_16bit_fans(data)) {

You could swap the blocks and save a negation.

> +		reg =3D it87_read_value(data, IT87_REG_FAN_DIV);
> +		switch (nr) {
> +		case 0:
> +			data->fan_div[nr] =3D reg & 0x07;
> +			break;
> +		case 1:
> +			data->fan_div[nr] =3D (reg >> 3) & 0x07;
> +			break;
> +		case 2:
> +			data->fan_div[nr] =3D (reg & 0x40) ? 3 : 1;
> +			break;
> +		}
> +		data->fan[nr][index] > +		  FAN_TO_REG(val, DIV_FROM_REG(data->fan_div=
[nr]));
> +		it87_write_value(data, IT87_REG_FAN_MIN[nr],
> +				 data->fan[nr][index]);
> +	} else {
> +		data->fan[nr][index] =3D FAN16_TO_REG(val);
> +		it87_write_value(data, IT87_REG_FAN_MIN[nr],
> +				 data->fan[nr][index] & 0xff);
> +		it87_write_value(data, IT87_REG_FANX_MIN[nr],
> +				 data->fan[nr][index] >> 8);
>  	}
> =20
> -	data->fan_min[nr] =3D FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
> -	it87_write_value(data, IT87_REG_FAN_MIN[nr], data->fan_min[nr]);
>  	mutex_unlock(&data->update_lock);
>  	return count;
>  }

Other than these details, very nice cleanup :)

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
