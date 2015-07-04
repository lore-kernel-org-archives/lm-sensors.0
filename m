From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 04 Jul 2015 22:19:45 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (nct7802) Add pwm mode
Message-Id: <55985C01.1040105@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1436044026-2882-1-git-send-email-const@MakeLinux.com>
In-Reply-To: <1436044026-2882-1-git-send-email-const@MakeLinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Constantine,

On 07/04/2015 02:07 PM, Constantine Shulyupin wrote:
> Introduced: show_pwm_mode, pwm1_mode, pwm2_mode, pwm2_mode
> Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>
> ---
>   drivers/hwmon/nct7802.c | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
>
> diff --git a/drivers/hwmon/nct7802.c b/drivers/hwmon/nct7802.c
> index 56b6f7b..16e0d17 100644
> --- a/drivers/hwmon/nct7802.c
> +++ b/drivers/hwmon/nct7802.c
> @@ -102,6 +102,24 @@ static ssize_t store_temp_type(struct device *dev,
>   	return err ? : count;
>   }
>
> +static ssize_t show_pwm_mode(struct device *dev, struct device_attribute *attr,
> +			     char *buf)
> +{
> +	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
> +	struct nct7802_data *data = dev_get_drvdata(dev);
> +	unsigned int regval;
> +	int ret;
> +
> +	if (sattr->index > 1)
> +		return sprintf(buf, "1\n");
> +
> +	ret = regmap_read(data->regmap, sattr->nr, &regval);
> +	if (ret < 0)
> +		return ret;
> +
> +	return sprintf(buf, "%u\n", !(regval & (1 << sattr->index)));
> +}
> +
>   static ssize_t show_pwm(struct device *dev, struct device_attribute *devattr,
>   			char *buf)
>   {
> @@ -765,6 +783,11 @@ static SENSOR_DEVICE_ATTR_2(fan3_alarm, S_IRUGO, show_alarm, NULL, 0x1a, 2);
>   static SENSOR_DEVICE_ATTR_2(fan3_beep, S_IRUGO | S_IWUSR, show_beep, store_beep,
>   			    0x5b, 2);
>
> +/* 7.2.89 Fan Control Output Type */
> +static SENSOR_DEVICE_ATTR_2(pwm1_mode, S_IRUGO, show_pwm_mode, NULL, 0x5E, 0);
> +static SENSOR_DEVICE_ATTR_2(pwm2_mode, S_IRUGO, show_pwm_mode, NULL, 0x5E, 1);
> +static SENSOR_DEVICE_ATTR_2(pwm3_mode, S_IRUGO, show_pwm_mode, NULL, 0, 2);

You don't really need SENSOR_DEVICE_ATTR_2 here; SENSOR_DEVICE_ATTR
is good enough. The register address doesn't change, and isn't used
for index = 2 anyway, so you can just hard-code it in show_pwm_mode().

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
