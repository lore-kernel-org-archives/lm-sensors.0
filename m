From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 08 Jul 2014 14:07:56 +0000
Subject: Re: [lm-sensors] [RFT][PATCH 1/2] hwmon: (da9052) Convert to devm_hwmon_device_register_with_groups
Message-Id: <53BBFB3C.4000101@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1404010388.5607.1.camel@phoenix>
In-Reply-To: <1404010388.5607.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 06/28/2014 07:53 PM, Axel Lin wrote:
> Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
> simplify the code a bit.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

I'll need a Tested-by: to apply this patch.

> ---
> Note, devm_hwmon_device_register_with_groups does not allow "-" in the name
> argument. So there is a change in 'name' attribute.
> It was "da9052-hwmon", and now it's "da9052".

It might be worthwhile to send a separate patch to address this problem.

Thanks,
Guenter

>   drivers/hwmon/da9052-hwmon.c | 54 ++++++++------------------------------------
>   1 file changed, 9 insertions(+), 45 deletions(-)
>
> diff --git a/drivers/hwmon/da9052-hwmon.c b/drivers/hwmon/da9052-hwmon.c
> index afd3104..692b3f3 100644
> --- a/drivers/hwmon/da9052-hwmon.c
> +++ b/drivers/hwmon/da9052-hwmon.c
> @@ -26,7 +26,6 @@
>
>   struct da9052_hwmon {
>   	struct da9052	*da9052;
> -	struct device	*class_device;
>   	struct mutex	hwmon_lock;
>   };
>
> @@ -190,13 +189,6 @@ static ssize_t da9052_read_vbbat(struct device *dev,
>   	return sprintf(buf, "%d\n", vbbat_reg_to_mv(ret));
>   }
>
> -static ssize_t da9052_hwmon_show_name(struct device *dev,
> -				      struct device_attribute *devattr,
> -				      char *buf)
> -{
> -	return sprintf(buf, "da9052-hwmon\n");
> -}
> -
>   static ssize_t show_label(struct device *dev,
>   			  struct device_attribute *devattr, char *buf)
>   {
> @@ -243,10 +235,7 @@ static SENSOR_DEVICE_ATTR(temp8_input, S_IRUGO, da9052_read_tjunc, NULL,
>   static SENSOR_DEVICE_ATTR(temp8_label, S_IRUGO, show_label, NULL,
>   			  DA9052_ADC_TJUNC);
>
> -static DEVICE_ATTR(name, S_IRUGO, da9052_hwmon_show_name, NULL);
> -
> -static struct attribute *da9052_attr[] = {
> -	&dev_attr_name.attr,
> +static struct attribute *da9052_attrs[] = {
>   	&sensor_dev_attr_in0_input.dev_attr.attr,
>   	&sensor_dev_attr_in0_label.dev_attr.attr,
>   	&sensor_dev_attr_in3_input.dev_attr.attr,
> @@ -268,54 +257,29 @@ static struct attribute *da9052_attr[] = {
>   	NULL
>   };
>
> -static const struct attribute_group da9052_attr_group = {.attrs = da9052_attr};
> +ATTRIBUTE_GROUPS(da9052);
>
>   static int da9052_hwmon_probe(struct platform_device *pdev)
>   {
> +	struct device *dev = &pdev->dev;
>   	struct da9052_hwmon *hwmon;
> -	int ret;
> +	struct device *hwmon_dev;
>
> -	hwmon = devm_kzalloc(&pdev->dev, sizeof(struct da9052_hwmon),
> -			     GFP_KERNEL);
> +	hwmon = devm_kzalloc(dev, sizeof(struct da9052_hwmon), GFP_KERNEL);
>   	if (!hwmon)
>   		return -ENOMEM;
>
>   	mutex_init(&hwmon->hwmon_lock);
>   	hwmon->da9052 = dev_get_drvdata(pdev->dev.parent);
>
> -	platform_set_drvdata(pdev, hwmon);
> -
> -	ret = sysfs_create_group(&pdev->dev.kobj, &da9052_attr_group);
> -	if (ret)
> -		goto err_mem;
> -
> -	hwmon->class_device = hwmon_device_register(&pdev->dev);
> -	if (IS_ERR(hwmon->class_device)) {
> -		ret = PTR_ERR(hwmon->class_device);
> -		goto err_sysfs;
> -	}
> -
> -	return 0;
> -
> -err_sysfs:
> -	sysfs_remove_group(&pdev->dev.kobj, &da9052_attr_group);
> -err_mem:
> -	return ret;
> -}
> -
> -static int da9052_hwmon_remove(struct platform_device *pdev)
> -{
> -	struct da9052_hwmon *hwmon = platform_get_drvdata(pdev);
> -
> -	hwmon_device_unregister(hwmon->class_device);
> -	sysfs_remove_group(&pdev->dev.kobj, &da9052_attr_group);
> -
> -	return 0;
> +	hwmon_dev = devm_hwmon_device_register_with_groups(dev, "da9052",
> +							   hwmon,
> +							   da9052_groups);
> +	return PTR_ERR_OR_ZERO(hwmon_dev);
>   }
>
>   static struct platform_driver da9052_hwmon_driver = {
>   	.probe = da9052_hwmon_probe,
> -	.remove = da9052_hwmon_remove,
>   	.driver = {
>   		.name = "da9052-hwmon",
>   		.owner = THIS_MODULE,
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
