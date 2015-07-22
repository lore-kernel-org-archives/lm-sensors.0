From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 22 Jul 2015 00:17:17 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (nct7802) Add autopoint attributes
Message-Id: <55AEE10D.6080604@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1436989088-16461-1-git-send-email-const@MakeLinux.com>
In-Reply-To: <1436989088-16461-1-git-send-email-const@MakeLinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/15/2015 12:38 PM, Constantine Shulyupin wrote:
> Introduced pwm[1..3]_auto_point[1..5]_temp, pwm[1..3]_auto_point[1..5]_pwm,
> nct7802_auto_point_attrs, nct7802_auto_point_group.
> nct7802_auto_point_is_visible,
>
> ---
>
> Changed in v2:
> - removed PWM_REG, TEMP_REG
> - removed auto_point[1..4]_temp, auto_point[1..4]_pwm
>    and auto_point_crit_temp
> - introduced pwm[1..3]_auto_point[1..5]_temp
>    and pwm[1..3]_auto_point[1..5]_pwm.
> - introduced nct7802_auto_point_is_visible
> - used sysfs_update_group in store_pwm_enable
>
> Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>
> ---
>   drivers/hwmon/nct7802.c | 179 +++++++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 162 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/hwmon/nct7802.c b/drivers/hwmon/nct7802.c
> index b8ca21b..32d06b7 100644
> --- a/drivers/hwmon/nct7802.c
> +++ b/drivers/hwmon/nct7802.c
> @@ -130,6 +130,9 @@ static ssize_t show_pwm(struct device *dev, struct device_attribute *devattr,
>   	unsigned int val;
>   	int ret;
>
> +	if (!attr->index)
> +		return sprintf(buf, "255\n");
> +
>   	ret = regmap_read(data->regmap, attr->index, &val);
>   	if (ret < 0)
>   		return ret;
> @@ -170,23 +173,7 @@ static ssize_t show_pwm_enable(struct device *dev,
>
>   static ssize_t store_pwm_enable(struct device *dev,
>   				struct device_attribute *attr,
> -				const char *buf, size_t count)
> -{
> -	struct nct7802_data *data = dev_get_drvdata(dev);
> -	struct sensor_device_attribute *sattr = to_sensor_dev_attr(attr);
> -	u8 val;
> -	int ret;
> -
> -	ret = kstrtou8(buf, 0, &val);
> -	if (ret < 0)
> -		return ret;
> -	if (val < 1 || val > 2)
> -		return -EINVAL;
> -	ret = regmap_update_bits(data->regmap, REG_SMARTFAN_EN(sattr->index),
> -				 1 << SMARTFAN_EN_SHIFT(sattr->index),
> -				 (val - 1) << SMARTFAN_EN_SHIFT(sattr->index));
> -	return ret ? : count;
> -}
> +				const char *buf, size_t count);

Please avoid forward declarations. Also see below.

>
>   static int nct7802_read_temp(struct nct7802_data *data,
>   			     u8 reg_temp, u8 reg_temp_low, int *temp)
> @@ -893,11 +880,169 @@ static struct attribute_group nct7802_pwm_group = {
>   	.attrs = nct7802_pwm_attrs,
>   };
>
> +/* 7.2.115... 0x80-0x83, 0x84 Temperature (X-axis) transition */
> +static SENSOR_DEVICE_ATTR_2(pwm1_auto_point1_temp, S_IRUGO | S_IWUSR,
> +			    show_temp, store_temp, 0x80, 0);
> +static SENSOR_DEVICE_ATTR_2(pwm1_auto_point2_temp, S_IRUGO | S_IWUSR,
> +			    show_temp, store_temp, 0x81, 0);
> +static SENSOR_DEVICE_ATTR_2(pwm1_auto_point3_temp, S_IRUGO | S_IWUSR,
> +			    show_temp, store_temp, 0x82, 0);
> +static SENSOR_DEVICE_ATTR_2(pwm1_auto_point4_temp, S_IRUGO | S_IWUSR,
> +			    show_temp, store_temp, 0x83, 0);
> +static SENSOR_DEVICE_ATTR_2(pwm1_auto_point5_temp, S_IRUGO | S_IWUSR,
> +			    show_temp, store_temp, 0x84, 0);
> +
> +/* 7.2.120... 0x85-0x88 PWM (Y-axis) transition */
> +static SENSOR_DEVICE_ATTR(pwm1_auto_point1_pwm, S_IRUGO | S_IWUSR,
> +			  show_pwm, store_pwm, 0x85);
> +static SENSOR_DEVICE_ATTR(pwm1_auto_point2_pwm, S_IRUGO | S_IWUSR,
> +			  show_pwm, store_pwm, 0x86);
> +static SENSOR_DEVICE_ATTR(pwm1_auto_point3_pwm, S_IRUGO | S_IWUSR,
> +			  show_pwm, store_pwm, 0x87);
> +static SENSOR_DEVICE_ATTR(pwm1_auto_point4_pwm, S_IRUGO | S_IWUSR,
> +			  show_pwm, store_pwm, 0x88);
> +static SENSOR_DEVICE_ATTR(pwm1_auto_point5_pwm, S_IRUGO | S_IWUSR,
> +			  show_pwm, NULL, 0);

This attribute does not have a write function, and should thus be read-only.
When you load the driver you should see a kernel backtrace because of this.

> +
> +/* 7.2.124 Table 2 X-axis Transition Point 1 Register */
> +static SENSOR_DEVICE_ATTR_2(pwm2_auto_point1_temp, S_IRUGO | S_IWUSR,
> +			    show_temp, store_temp, 0x90, 0);
> +static SENSOR_DEVICE_ATTR_2(pwm2_auto_point2_temp, S_IRUGO | S_IWUSR,
> +			    show_temp, store_temp, 0x91, 0);
> +static SENSOR_DEVICE_ATTR_2(pwm2_auto_point3_temp, S_IRUGO | S_IWUSR,
> +			    show_temp, store_temp, 0x92, 0);
> +static SENSOR_DEVICE_ATTR_2(pwm2_auto_point4_temp, S_IRUGO | S_IWUSR,
> +			    show_temp, store_temp, 0x93, 0);
> +static SENSOR_DEVICE_ATTR_2(pwm2_auto_point5_temp, S_IRUGO | S_IWUSR,
> +			    show_temp, store_temp, 0x94, 0);
> +
> +/* 7.2.129 Table 2 Y-axis Transition Point 1 Register */
> +static SENSOR_DEVICE_ATTR(pwm2_auto_point1_pwm, S_IRUGO | S_IWUSR,
> +			  show_pwm, store_pwm, 0x95);
> +static SENSOR_DEVICE_ATTR(pwm2_auto_point2_pwm, S_IRUGO | S_IWUSR,
> +			  show_pwm, store_pwm, 0x96);
> +static SENSOR_DEVICE_ATTR(pwm2_auto_point3_pwm, S_IRUGO | S_IWUSR,
> +			  show_pwm, store_pwm, 0x97);
> +static SENSOR_DEVICE_ATTR(pwm2_auto_point4_pwm, S_IRUGO | S_IWUSR,
> +			  show_pwm, store_pwm, 0x98);
> +static SENSOR_DEVICE_ATTR(pwm2_auto_point5_pwm, S_IRUGO | S_IWUSR,
> +			  show_pwm, NULL, 0);
> +
> +/* 7.2.133 Table 3 X-axis Transition Point 1 Register */
> +static SENSOR_DEVICE_ATTR_2(pwm3_auto_point1_temp, S_IRUGO | S_IWUSR,
> +			    show_temp, store_temp, 0xA0, 0);
> +static SENSOR_DEVICE_ATTR_2(pwm3_auto_point2_temp, S_IRUGO | S_IWUSR,
> +			    show_temp, store_temp, 0xA1, 0);
> +static SENSOR_DEVICE_ATTR_2(pwm3_auto_point3_temp, S_IRUGO | S_IWUSR,
> +			    show_temp, store_temp, 0xA2, 0);
> +static SENSOR_DEVICE_ATTR_2(pwm3_auto_point4_temp, S_IRUGO | S_IWUSR,
> +			    show_temp, store_temp, 0xA3, 0);
> +static SENSOR_DEVICE_ATTR_2(pwm3_auto_point5_temp, S_IRUGO | S_IWUSR,
> +			    show_temp, store_temp, 0xA4, 0);
> +
> +/* 7.2.138 Table 3 Y-axis Transition Point 1 Register */
> +static SENSOR_DEVICE_ATTR(pwm3_auto_point1_pwm, S_IRUGO | S_IWUSR,
> +			  show_pwm, store_pwm, 0xA5);
> +static SENSOR_DEVICE_ATTR(pwm3_auto_point2_pwm, S_IRUGO | S_IWUSR,
> +			  show_pwm, store_pwm, 0xA6);
> +static SENSOR_DEVICE_ATTR(pwm3_auto_point3_pwm, S_IRUGO | S_IWUSR,
> +			  show_pwm, store_pwm, 0xA7);
> +static SENSOR_DEVICE_ATTR(pwm3_auto_point4_pwm, S_IRUGO | S_IWUSR,
> +			  show_pwm, store_pwm, 0xA8);
> +static SENSOR_DEVICE_ATTR(pwm3_auto_point5_pwm, S_IRUGO | S_IWUSR,
> +			  show_pwm, NULL, 0);
> +
> +
Please no double empty lines.

> +static struct attribute *nct7802_auto_point_attrs[] = {
> +	&sensor_dev_attr_pwm1_auto_point1_temp.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point2_temp.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point3_temp.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point4_temp.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point5_temp.dev_attr.attr,
> +
> +	&sensor_dev_attr_pwm1_auto_point1_pwm.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point2_pwm.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point3_pwm.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point4_pwm.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point5_pwm.dev_attr.attr,
> +
> +	&sensor_dev_attr_pwm2_auto_point1_temp.dev_attr.attr,
> +	&sensor_dev_attr_pwm2_auto_point2_temp.dev_attr.attr,
> +	&sensor_dev_attr_pwm2_auto_point3_temp.dev_attr.attr,
> +	&sensor_dev_attr_pwm2_auto_point4_temp.dev_attr.attr,
> +	&sensor_dev_attr_pwm2_auto_point5_temp.dev_attr.attr,
> +
> +	&sensor_dev_attr_pwm2_auto_point1_pwm.dev_attr.attr,
> +	&sensor_dev_attr_pwm2_auto_point2_pwm.dev_attr.attr,
> +	&sensor_dev_attr_pwm2_auto_point3_pwm.dev_attr.attr,
> +	&sensor_dev_attr_pwm2_auto_point4_pwm.dev_attr.attr,
> +	&sensor_dev_attr_pwm2_auto_point5_pwm.dev_attr.attr,
> +
> +	&sensor_dev_attr_pwm3_auto_point1_temp.dev_attr.attr,
> +	&sensor_dev_attr_pwm3_auto_point2_temp.dev_attr.attr,
> +	&sensor_dev_attr_pwm3_auto_point3_temp.dev_attr.attr,
> +	&sensor_dev_attr_pwm3_auto_point4_temp.dev_attr.attr,
> +	&sensor_dev_attr_pwm3_auto_point5_temp.dev_attr.attr,
> +
> +	&sensor_dev_attr_pwm3_auto_point1_pwm.dev_attr.attr,
> +	&sensor_dev_attr_pwm3_auto_point2_pwm.dev_attr.attr,
> +	&sensor_dev_attr_pwm3_auto_point3_pwm.dev_attr.attr,
> +	&sensor_dev_attr_pwm3_auto_point4_pwm.dev_attr.attr,
> +	&sensor_dev_attr_pwm3_auto_point5_pwm.dev_attr.attr,
> +
> +	NULL
> +};
> +
> +static umode_t nct7802_auto_point_is_visible(struct kobject *kobj,
> +					     struct attribute *attr, int index)
> +{
> +	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct nct7802_data *data = dev_get_drvdata(dev);
> +	unsigned int reg, enabled;
> +	int ret;
> +
> +	ret = regmap_read(data->regmap, REG_SMARTFAN_EN(index / 10), &reg);
> +	if (ret < 0)
> +		return 0;
> +
> +	enabled = reg >> SMARTFAN_EN_SHIFT(index / 10) & 1;
> +
> +	return enabled ? attr->mode : 0;
> +}

You want to be able to set data points prior to enabling automatic mode.
Otherwise you would have to enable automatic mode, which would confuse
the chip if its parameters are not set to useful values.

So this set of attributes should always be visible,

> +
> +static struct attribute_group nct7802_auto_point_group = {
> +	.attrs = nct7802_auto_point_attrs,
> +	.is_visible = nct7802_auto_point_is_visible,
> +};
> +
> +static ssize_t store_pwm_enable(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t count)
> +{
> +	struct nct7802_data *data = dev_get_drvdata(dev);
> +	struct sensor_device_attribute *sattr = to_sensor_dev_attr(attr);
> +	u8 val;
> +	int ret;
> +
> +	ret = kstrtou8(buf, 0, &val);
> +	if (ret < 0)
> +		return ret;
> +	if (val < 1 || val > 2)
> +		return -EINVAL;
> +	ret = regmap_update_bits(data->regmap, REG_SMARTFAN_EN(sattr->index),
> +				 1 << SMARTFAN_EN_SHIFT(sattr->index),
> +				 (val - 1) << SMARTFAN_EN_SHIFT(sattr->index));
> +
> +	sysfs_update_group(&dev->kobj, &nct7802_auto_point_group);

and you don't need the is_visible function, and you don't need to call
sysfs_update_group.

Question, however, might be if you want to validate auto point settings
if automatic mode is enabled, similar to other drivers. Any thoughts ?

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
