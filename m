From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 03 Jul 2015 23:31:55 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (nct7802) Add pwm control
Message-Id: <55971B6B.6090209@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1435957911-19044-1-git-send-email-const@MakeLinux.com>
In-Reply-To: <1435957911-19044-1-git-send-email-const@MakeLinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Constantine,

On 07/03/2015 02:11 PM, Constantine Shulyupin wrote:
> Notes:
>
> Some lines intentionally more than 80 characters because wrapping
> this lines decreases readability.
> The patch was checked with scripts/checkpatch.pl --max-line-length=88
>

Please see section 2 of Documentation/SubmittingPatches for how to describe
a patch. The above is not a patch description, and provides no value
in the change log.

I got three copies of this patch, two of them marked as v2. I have no idea
which is the newest one, or what you changed in v2. Above mentioned document
also tells you how to describe patch versions.

> Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>
> ---

FWIW, here would be the place to add notes.

>   drivers/hwmon/nct7802.c | 47 ++++++++++++++++++++++++++++++++++++++++++=
+++++
>   1 file changed, 47 insertions(+)
>
> diff --git a/drivers/hwmon/nct7802.c b/drivers/hwmon/nct7802.c
> index afa242d..104d8b9 100644
> --- a/drivers/hwmon/nct7802.c
> +++ b/drivers/hwmon/nct7802.c
> @@ -102,6 +102,36 @@ static ssize_t store_temp_type(struct device *dev,
>   	return err ? : count;
>   }
>
> +static ssize_t show_pwm(struct device *dev, struct device_attribute *dev=
attr, char *buf)

Please split this line. It does not hurt readability at all.
Besides, the same split is already done for other similar functions.

> +{
> +	int ret =3D -1;

Unnecessary initialization.

> +	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
> +	struct nct7802_data *data =3D dev_get_drvdata(dev);
> +	unsigned int val =3D 0;

Unnecessary initialization.

Please arrange variable declarations length wise where possible.

> +
> +	ret =3D regmap_read(data->regmap, attr->index, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D sprintf(buf, "%d\n", val);
> +	return ret;

I think I already asked for
	return sprintf(buf, "%d\n", val);

> +}
> +
> +static ssize_t store_u8(struct device *dev, struct device_attribute *dev=
attr,
> +			const char *buf, size_t count)

store_pwm, please.

Thanks,
Guenter

> +{
> +	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
> +	struct nct7802_data *data =3D dev_get_drvdata(dev);
> +	int err;
> +	u8 val;
> +
> +	err =3D kstrtou8(buf, 0, &val);
> +	if (err < 0)
> +		return err;
> +
> +	err =3D regmap_write(data->regmap, attr->index, val);
> +	return err ? : count;
> +}
>
>   static int nct7802_read_temp(struct nct7802_data *data,
>   			     u8 reg_temp, u8 reg_temp_low, int *temp)
> @@ -735,6 +765,11 @@ static SENSOR_DEVICE_ATTR_2(fan3_alarm, S_IRUGO, sho=
w_alarm, NULL, 0x1a, 2);
>   static SENSOR_DEVICE_ATTR_2(fan3_beep, S_IRUGO | S_IWUSR, show_beep, st=
ore_beep,
>   			    0x5b, 2);
>
> +/* 7.2.91... Fan Control Output Value */
> +static SENSOR_DEVICE_ATTR(pwm1, S_IRUGO | S_IWUSR, show_pwm, store_u8, 0=
x60);
> +static SENSOR_DEVICE_ATTR(pwm2, S_IRUGO | S_IWUSR, show_pwm, store_u8, 0=
x61);
> +static SENSOR_DEVICE_ATTR(pwm3, S_IRUGO | S_IWUSR, show_pwm, store_u8, 0=
x62);
> +
>   static struct attribute *nct7802_fan_attrs[] =3D {
>   	&sensor_dev_attr_fan1_input.dev_attr.attr,
>   	&sensor_dev_attr_fan1_min.dev_attr.attr,
> @@ -773,10 +808,22 @@ static struct attribute_group nct7802_fan_group =3D=
 {
>   	.is_visible =3D nct7802_fan_is_visible,
>   };
>
> +static struct attribute *nct7802_pwm_attrs[] =3D {
> +	&sensor_dev_attr_pwm1.dev_attr.attr,
> +	&sensor_dev_attr_pwm2.dev_attr.attr,
> +	&sensor_dev_attr_pwm3.dev_attr.attr,
> +	NULL
> +};
> +
> +static struct attribute_group nct7802_pwm_group =3D {
> +	.attrs =3D nct7802_pwm_attrs,
> +};
> +
>   static const struct attribute_group *nct7802_groups[] =3D {
>   	&nct7802_temp_group,
>   	&nct7802_in_group,
>   	&nct7802_fan_group,
> +	&nct7802_pwm_group,
>   	NULL
>   };
>
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
