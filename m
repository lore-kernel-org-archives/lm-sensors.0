From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 08 Jul 2014 04:06:58 +0000
Subject: Re: [lm-sensors] [RFT][PATCH] hwmon: (smsc47b397) Convert to devm_hwmon_device_register_with_groups
Message-Id: <53BB6E62.3050301@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1404782858.10553.1.camel@phoenix>
In-Reply-To: <1404782858.10553.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/07/2014 06:27 PM, Axel Lin wrote:
> Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
> simplify the code a bit.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

We'll need a Tested-by: from someone for this one.

Guenter

> ---
>   drivers/hwmon/smsc47b397.c | 51 +++++++---------------------------------------
>   1 file changed, 7 insertions(+), 44 deletions(-)
>
> diff --git a/drivers/hwmon/smsc47b397.c b/drivers/hwmon/smsc47b397.c
> index bd89e87..221f093 100644
> --- a/drivers/hwmon/smsc47b397.c
> +++ b/drivers/hwmon/smsc47b397.c
> @@ -100,8 +100,6 @@ static u8 smsc47b397_reg_temp[] = {0x25, 0x26, 0x27, 0x80};
>
>   struct smsc47b397_data {
>   	unsigned short addr;
> -	const char *name;
> -	struct device *hwmon_dev;
>   	struct mutex lock;
>
>   	struct mutex update_lock;
> @@ -202,15 +200,7 @@ static SENSOR_DEVICE_ATTR(fan2_input, S_IRUGO, show_fan, NULL, 1);
>   static SENSOR_DEVICE_ATTR(fan3_input, S_IRUGO, show_fan, NULL, 2);
>   static SENSOR_DEVICE_ATTR(fan4_input, S_IRUGO, show_fan, NULL, 3);
>
> -static ssize_t show_name(struct device *dev, struct device_attribute
> -			 *devattr, char *buf)
> -{
> -	struct smsc47b397_data *data = dev_get_drvdata(dev);
> -	return sprintf(buf, "%s\n", data->name);
> -}
> -static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
> -
> -static struct attribute *smsc47b397_attributes[] = {
> +static struct attribute *smsc47b397_attrs[] = {
>   	&sensor_dev_attr_temp1_input.dev_attr.attr,
>   	&sensor_dev_attr_temp2_input.dev_attr.attr,
>   	&sensor_dev_attr_temp3_input.dev_attr.attr,
> @@ -220,23 +210,10 @@ static struct attribute *smsc47b397_attributes[] = {
>   	&sensor_dev_attr_fan3_input.dev_attr.attr,
>   	&sensor_dev_attr_fan4_input.dev_attr.attr,
>
> -	&dev_attr_name.attr,
>   	NULL
>   };
>
> -static const struct attribute_group smsc47b397_group = {
> -	.attrs = smsc47b397_attributes,
> -};
> -
> -static int smsc47b397_remove(struct platform_device *pdev)
> -{
> -	struct smsc47b397_data *data = platform_get_drvdata(pdev);
> -
> -	hwmon_device_unregister(data->hwmon_dev);
> -	sysfs_remove_group(&pdev->dev.kobj, &smsc47b397_group);
> -
> -	return 0;
> -}
> +ATTRIBUTE_GROUPS(smsc47b397);
>
>   static int smsc47b397_probe(struct platform_device *pdev);
>
> @@ -246,15 +223,14 @@ static struct platform_driver smsc47b397_driver = {
>   		.name	= DRVNAME,
>   	},
>   	.probe		= smsc47b397_probe,
> -	.remove		= smsc47b397_remove,
>   };
>
>   static int smsc47b397_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
>   	struct smsc47b397_data *data;
> +	struct device *hwmon_dev;
>   	struct resource *res;
> -	int err = 0;
>
>   	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
>   	if (!devm_request_region(dev, res->start, SMSC_EXTENT,
> @@ -270,26 +246,13 @@ static int smsc47b397_probe(struct platform_device *pdev)
>   		return -ENOMEM;
>
>   	data->addr = res->start;
> -	data->name = "smsc47b397";
>   	mutex_init(&data->lock);
>   	mutex_init(&data->update_lock);
> -	platform_set_drvdata(pdev, data);
> -
> -	err = sysfs_create_group(&dev->kobj, &smsc47b397_group);
> -	if (err)
> -		return err;
>
> -	data->hwmon_dev = hwmon_device_register(dev);
> -	if (IS_ERR(data->hwmon_dev)) {
> -		err = PTR_ERR(data->hwmon_dev);
> -		goto error_remove;
> -	}
> -
> -	return 0;
> -
> -error_remove:
> -	sysfs_remove_group(&dev->kobj, &smsc47b397_group);
> -	return err;
> +	hwmon_dev = devm_hwmon_device_register_with_groups(dev, "smsc47b397",
> +							   data,
> +							   smsc47b397_groups);
> +	return PTR_ERR_OR_ZERO(hwmon_dev);
>   }
>
>   static int __init smsc47b397_device_add(unsigned short address)
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
