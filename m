From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 14 Jun 2014 05:12:31 +0000
Subject: Re: [lm-sensors] [PATCH RFT] hwmon: (twl4030-madc-hwmon) Convert to devm_hwmon_device_register_with_
Message-Id: <539BD9BF.6020808@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1402717089.5496.1.camel@phoenix>
In-Reply-To: <1402717089.5496.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 06/13/2014 08:38 PM, Axel Lin wrote:
> Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
> simplify the code a bit.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
> Hi,
> I don't have the h/w to test, I'd appreciate if someone can review and test this
> patch.
> Thanks,
> Axel
>   drivers/hwmon/twl4030-madc-hwmon.c | 37 +++++--------------------------------
>   1 file changed, 5 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/hwmon/twl4030-madc-hwmon.c b/drivers/hwmon/twl4030-madc-hwmon.c
> index 6c6d440..9904f3d 100644
> --- a/drivers/hwmon/twl4030-madc-hwmon.c
> +++ b/drivers/hwmon/twl4030-madc-hwmon.c
> @@ -74,7 +74,7 @@ static SENSOR_DEVICE_ATTR(in11_input, S_IRUGO, madc_read, NULL, 11);
>   static SENSOR_DEVICE_ATTR(in12_input, S_IRUGO, madc_read, NULL, 12);
>   static SENSOR_DEVICE_ATTR(in15_input, S_IRUGO, madc_read, NULL, 15);
>
> -static struct attribute *twl4030_madc_attributes[] = {
> +static struct attribute *twl4030_madc_attrs[] = {
>   	&sensor_dev_attr_in0_input.dev_attr.attr,
>   	&sensor_dev_attr_temp1_input.dev_attr.attr,
>   	&sensor_dev_attr_in2_input.dev_attr.attr,
> @@ -91,46 +91,19 @@ static struct attribute *twl4030_madc_attributes[] = {
>   	&sensor_dev_attr_in15_input.dev_attr.attr,
>   	NULL
>   };
> -
> -static const struct attribute_group twl4030_madc_group = {
> -	.attrs = twl4030_madc_attributes,
> -};
> +ATTRIBUTE_GROUPS(twl4030_madc);
>
>   static int twl4030_madc_hwmon_probe(struct platform_device *pdev)
>   {
> -	int ret;
>   	struct device *hwmon;
>
> -	ret = sysfs_create_group(&pdev->dev.kobj, &twl4030_madc_group);
> -	if (ret)
> -		goto err_sysfs;
> -	hwmon = hwmon_device_register(&pdev->dev);
> -	if (IS_ERR(hwmon)) {
> -		dev_err(&pdev->dev, "hwmon_device_register failed.\n");
> -		ret = PTR_ERR(hwmon);
> -		goto err_reg;
> -	}
> -
> -	return 0;
> -
> -err_reg:
> -	sysfs_remove_group(&pdev->dev.kobj, &twl4030_madc_group);
> -err_sysfs:
> -
> -	return ret;
> -}
> -
> -static int twl4030_madc_hwmon_remove(struct platform_device *pdev)
> -{
> -	hwmon_device_unregister(&pdev->dev);
> -	sysfs_remove_group(&pdev->dev.kobj, &twl4030_madc_group);
> -
> -	return 0;
> +	hwmon = devm_hwmon_device_register_with_groups(&pdev->dev, NULL, NULL,

Hi Axel,

You'll need to pass a name here. Hmmm... that wasn't there before either,
meaning the 'sensors' command never worked with this driver. I must
have had a bad day when I reviewed it, especially since
hwmon_device_unregister() takes the hwmon device as argument,
not the platform device.

I would suggest to use "twl4030_madc" as name string for simplicity.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
