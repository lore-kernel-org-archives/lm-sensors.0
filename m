From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 27 Jun 2015 21:44:00 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (nct7802) add temperature sensor type attribute
Message-Id: <558F1920.1080000@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1435440228-16625-1-git-send-email-const@MakeLinux.com>
In-Reply-To: <1435440228-16625-1-git-send-email-const@MakeLinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Constantine Shulyupin <const@MakeLinux.com>, jdelvare@suse.de, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Hi Constantine,

On 06/27/2015 02:23 PM, Constantine Shulyupin wrote:
> From: const <const@MakeLinux.com>
>
> 0, 3 - Temperature attributes are hidden

Not really per your code (though they should be hidden).

> 1 - Current mode
> 2 - Thermistor mode
>
Wrong - that should be 3 for current (diode) mode and 4 for thermistor mode.
The values are part of the ABI and must not be changed
(look at the output of the sensors command and you'll understand why).

> Reference:
> Nuvoton Hardware Monitoring IC NCT7802Y
> 7.2.32 Mode Selection Register
> Location : Index 22h
>
> Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>
> ---
>   drivers/hwmon/nct7802.c | 53 ++++++++++++++++++++++++++++++++++++++++++=
++++++-
>   scripts/checkpatch.pl   |  2 +-
>   2 files changed, 53 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hwmon/nct7802.c b/drivers/hwmon/nct7802.c
> index 60cf5d1..444eedf 100644
> --- a/drivers/hwmon/nct7802.c
> +++ b/drivers/hwmon/nct7802.c
> @@ -49,7 +49,7 @@ static const u8 REG_VOLTAGE_LIMIT_MSB_SHIFT[2][5] =3D {
>   #define REG_VOLTAGE_LOW		0x0f
>   #define REG_FANCOUNT_LOW	0x13
>   #define REG_START		0x21
> -#define REG_MODE		0x22
> +#define REG_MODE		0x22 /* 7.2.32 Mode Selection Register */
>   #define REG_PECI_ENABLE		0x23
>   #define REG_FAN_ENABLE		0x24
>   #define REG_VMON_ENABLE		0x25
> @@ -725,7 +725,58 @@ static struct attribute_group nct7802_fan_group =3D {
>   	.is_visible =3D nct7802_fan_is_visible,
>   };
>
> +static ssize_t show_temp_type(struct device *dev, struct device_attribut=
e *attr,
> +		char *buf)
> +{
> +	struct nct7802_data *data =3D dev_get_drvdata(dev);
> +	struct sensor_device_attribute *sattr =3D to_sensor_dev_attr(attr);
> +	unsigned int val;
> +	int ret;
> +
> +	ret =3D regmap_read(data->regmap, REG_MODE, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	return sprintf(buf, "%u\n", val >> (2 * sattr->index) & 3);

Please convert to correct ABI values.

> +}
> +
> +static ssize_t store_temp_type(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct nct7802_data *data =3D dev_get_drvdata(dev);
> +	struct sensor_device_attribute *sattr =3D to_sensor_dev_attr(attr);
> +	unsigned int val;
> +	int err;
> +
> +	err =3D kstrtouint(buf, 0, &val);
> +	if (err < 0)
> +		return err;
> +	if (val > 0xF)
> +		return -EINVAL;
> +
Please only accept 3 and 4 for the first two sensors,
and only 4 for the third sensor, and convert to register
values as needed.

> +	err =3D regmap_update_bits(data->regmap, REG_MODE,
> +			3 << 2 * sattr->index, val << 2 * sattr->index);
> +	sysfs_update_group(&dev->kobj, &nct7802_temp_group);
> +	return err ? : count;
> +}
> +
> +/* 7.2.32 Mode Selection Register */
> +static SENSOR_DEVICE_ATTR(temp1_type, S_IRUGO | S_IWUSR,
> +		show_temp_type, store_temp_type, 0);
> +static SENSOR_DEVICE_ATTR(temp2_type, S_IRUGO | S_IWUSR,
> +		show_temp_type, store_temp_type, 1);
> +static SENSOR_DEVICE_ATTR(temp3_type, S_IRUGO | S_IWUSR,
> +		show_temp_type, store_temp_type, 2);

Please align continuation lines with '('.

> +
> +static struct attribute *general_attributes[] =3D {
> +	&sensor_dev_attr_temp1_type.dev_attr.attr,
> +	&sensor_dev_attr_temp2_type.dev_attr.attr,
> +	&sensor_dev_attr_temp3_type.dev_attr.attr,
> +	NULL
> +};
> +
>   static const struct attribute_group *nct7802_groups[] =3D {
> +	&(const struct attribute_group){ .attrs =3D general_attributes },

Please merge the new attributes into temp_group to get correct visibility.

>   	&nct7802_temp_group,
>   	&nct7802_in_group,
>   	&nct7802_fan_group,
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 4f484ac..bf9a680 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -14,7 +14,7 @@ my $V =3D '0.32';
>
>   use Getopt::Long qw(:config no_auto_abbrev);
>
> -my $LINELENGTH=120;
> +my $LINELENGTH=80;
>
That doesn't belong here.

>   my $quiet =3D 0;
>   my $tree =3D 1;
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
