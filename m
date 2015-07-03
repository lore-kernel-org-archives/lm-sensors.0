From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 03 Jul 2015 01:26:51 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (nct7802) Add fan output control
Message-Id: <5595E4DB.6080403@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1435876843-1216-1-git-send-email-const@MakeLinux.com>
In-Reply-To: <1435876843-1216-1-git-send-email-const@MakeLinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Constantine Shulyupin <const@MakeLinux.com>, jdelvare@suse.de, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Hi Constantine,

On 07/02/2015 03:40 PM, Constantine Shulyupin wrote:
> Notes:
>
> Some lines intentionally more than 80 characters because wrapping
> this lines decreases readability.
> The patch was checked with scripts/checkpatch.pl --max-line-length=88
>
> Following code is not typecasting.
> It is inline struct attribute_group definition using compound literal.
> (See https://gcc.gnu.org/onlinedocs/gcc-3.2.2/gcc/Compound-Literals.html)
>
> static const struct attribute_group *nct7802_groups[] =3D {
> 	...
> 	&(const struct attribute_group){ .attrs =3D fan_output_attributes },
> 	...
>
I still don't like it. See below.

> Reference:
>
> Nuvoton Hardware Monitoring IC NCT7802Y
> 7.2.91 Fan Control 1 Output Value
> Location : Index 60h
>
> 7.2.92 Fan Control 2 Output Value
> Location : Index 61h
>
> 7.2.93 Fan Control 3 Output Value
> Location : Index 62h
>
This all doesn't really belong into the change log.


> Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>
> ---
>   drivers/hwmon/nct7802.c | 45 ++++++++++++++++++++++++++++++++++++++++++=
+++
>   1 file changed, 45 insertions(+)
>
> diff --git a/drivers/hwmon/nct7802.c b/drivers/hwmon/nct7802.c
> index afa242d..56d3547 100644
> --- a/drivers/hwmon/nct7802.c
> +++ b/drivers/hwmon/nct7802.c
> @@ -102,6 +102,38 @@ static ssize_t store_temp_type(struct device *dev,
>   	return err ? : count;
>   }
>
> +static ssize_t show_dec(struct device *dev, struct device_attribute *dev=
attr, char *buf)

Please make this show_pwm.

> +{
> +	int ret =3D -1;
> +	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
> +	struct nct7802_data *data =3D dev_get_drvdata(dev);
> +	unsigned int val =3D 0;
> +
> +	ret =3D regmap_read(data->regmap, attr->index, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D sprintf(buf, "%d\n", val);
> +	return ret;

	return sprintf(buf, "%d\n", val);

> +}
> +
> +static ssize_t store_u8(struct device *dev, struct device_attribute *dev=
attr,
> +			const char *buf, size_t count)

store_pwm, and please align the continuation line with '('.

> +{
> +	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
> +	struct nct7802_data *data =3D dev_get_drvdata(dev);
> +	int err;
> +	unsigned int val;
> +
> +	err =3D kstrtouint(buf, 0, &val);
> +	if (err < 0)
> +		return err;
> +	if (val > 0xFF)
> +		return -EINVAL;

You might consider using kstrtou8 instead.

> +
> +	err =3D regmap_write(data->regmap, attr->index, val);
> +	return err ? : count;
> +}
>
>   static int nct7802_read_temp(struct nct7802_data *data,
>   			     u8 reg_temp, u8 reg_temp_low, int *temp)
> @@ -735,6 +767,11 @@ static SENSOR_DEVICE_ATTR_2(fan3_alarm, S_IRUGO, sho=
w_alarm, NULL, 0x1a, 2);
>   static SENSOR_DEVICE_ATTR_2(fan3_beep, S_IRUGO | S_IWUSR, show_beep, st=
ore_beep,
>   			    0x5b, 2);
>
> +/* 7.2.91... Fan Control Output Value */
> +static SENSOR_DEVICE_ATTR(fan1_output, S_IRUGO | S_IWUSR, show_dec, stor=
e_u8, 0x60);
> +static SENSOR_DEVICE_ATTR(fan2_output, S_IRUGO | S_IWUSR, show_dec, stor=
e_u8, 0x61);
> +static SENSOR_DEVICE_ATTR(fan3_output, S_IRUGO | S_IWUSR, show_dec, stor=
e_u8, 0x62);
> +
Please use pwm[1-3] for the attribute names.

>   static struct attribute *nct7802_fan_attrs[] =3D {
>   	&sensor_dev_attr_fan1_input.dev_attr.attr,
>   	&sensor_dev_attr_fan1_min.dev_attr.attr,
> @@ -773,10 +810,18 @@ static struct attribute_group nct7802_fan_group =3D=
 {
>   	.is_visible =3D nct7802_fan_is_visible,
>   };
>
> +static struct attribute *fan_output_attributes[] =3D {
> +	&sensor_dev_attr_fan1_output.dev_attr.attr,
> +	&sensor_dev_attr_fan2_output.dev_attr.attr,
> +	&sensor_dev_attr_fan3_output.dev_attr.attr,
> +	NULL
> +};
> +
Please use an explicit variable for the group, similar to the other groups.
I would suggest to use nct7802_pwm_attrs and nct7802_pwm_group.

_attrs is a naming convention used by macros such as ATTRIBUTE_GROUPS,
so it makes sense to stick with it.

>   static const struct attribute_group *nct7802_groups[] =3D {
>   	&nct7802_temp_group,
>   	&nct7802_in_group,
>   	&nct7802_fan_group,
> +	&(const struct attribute_group){ .attrs =3D fan_output_attributes },

... as I am not in favor of such constructs.

Thanks,
Guenter

>   	NULL
>   };
>
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
