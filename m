From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 08 Jul 2014 14:08:24 +0000
Subject: Re: [lm-sensors] [RFT][PATCH] hwmon: (jz4740) Convert to devm_hwmon_device_register_with_groups
Message-Id: <53BBFB58.9060000@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 06/29/2014 06:39 AM, Axel Lin wrote:
> Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
> simplify the code a bit.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

I'll need a tested-by: to apply this patch.

Thanks,
Guenter

> ---
>   drivers/hwmon/jz4740-hwmon.c | 65 ++++++++++----------------------------------
>   1 file changed, 14 insertions(+), 51 deletions(-)
>
> diff --git a/drivers/hwmon/jz4740-hwmon.c b/drivers/hwmon/jz4740-hwmon.c
> index 7488e36..32f10cc 100644
> --- a/drivers/hwmon/jz4740-hwmon.c
> +++ b/drivers/hwmon/jz4740-hwmon.c
> @@ -29,23 +29,13 @@
>
>   struct jz4740_hwmon {
>   	void __iomem *base;
> -
>   	int irq;
> -
>   	const struct mfd_cell *cell;
> -	struct device *hwmon;
> -
> +	struct platform_device *pdev;
>   	struct completion read_completion;
> -
>   	struct mutex lock;
>   };
>
> -static ssize_t jz4740_hwmon_show_name(struct device *dev,
> -	struct device_attribute *dev_attr, char *buf)
> -{
> -	return sprintf(buf, "jz4740\n");
> -}
> -
>   static irqreturn_t jz4740_hwmon_irq(int irq, void *data)
>   {
>   	struct jz4740_hwmon *hwmon = data;
> @@ -58,6 +48,7 @@ static ssize_t jz4740_hwmon_read_adcin(struct device *dev,
>   	struct device_attribute *dev_attr, char *buf)
>   {
>   	struct jz4740_hwmon *hwmon = dev_get_drvdata(dev);
> +	struct platform_device *pdev = hwmon->pdev;
>   	struct completion *completion = &hwmon->read_completion;
>   	long t;
>   	unsigned long val;
> @@ -68,7 +59,7 @@ static ssize_t jz4740_hwmon_read_adcin(struct device *dev,
>   	reinit_completion(completion);
>
>   	enable_irq(hwmon->irq);
> -	hwmon->cell->enable(to_platform_device(dev));
> +	hwmon->cell->enable(pdev);
>
>   	t = wait_for_completion_interruptible_timeout(completion, HZ);
>
> @@ -80,7 +71,7 @@ static ssize_t jz4740_hwmon_read_adcin(struct device *dev,
>   		ret = t ? t : -ETIMEDOUT;
>   	}
>
> -	hwmon->cell->disable(to_platform_device(dev));
> +	hwmon->cell->disable(pdev);
>   	disable_irq(hwmon->irq);
>
>   	mutex_unlock(&hwmon->lock);
> @@ -88,26 +79,24 @@ static ssize_t jz4740_hwmon_read_adcin(struct device *dev,
>   	return ret;
>   }
>
> -static DEVICE_ATTR(name, S_IRUGO, jz4740_hwmon_show_name, NULL);
>   static DEVICE_ATTR(in0_input, S_IRUGO, jz4740_hwmon_read_adcin, NULL);
>
> -static struct attribute *jz4740_hwmon_attributes[] = {
> -	&dev_attr_name.attr,
> +static struct attribute *jz4740_attrs[] = {
>   	&dev_attr_in0_input.attr,
>   	NULL
>   };
>
> -static const struct attribute_group jz4740_hwmon_attr_group = {
> -	.attrs = jz4740_hwmon_attributes,
> -};
> +ATTRIBUTE_GROUPS(jz4740);
>
>   static int jz4740_hwmon_probe(struct platform_device *pdev)
>   {
>   	int ret;
> +	struct device *dev = &pdev->dev;
>   	struct jz4740_hwmon *hwmon;
> +	struct device *hwmon_dev;
>   	struct resource *mem;
>
> -	hwmon = devm_kzalloc(&pdev->dev, sizeof(*hwmon), GFP_KERNEL);
> +	hwmon = devm_kzalloc(dev, sizeof(*hwmon), GFP_KERNEL);
>   	if (!hwmon)
>   		return -ENOMEM;
>
> @@ -125,12 +114,11 @@ static int jz4740_hwmon_probe(struct platform_device *pdev)
>   	if (IS_ERR(hwmon->base))
>   		return PTR_ERR(hwmon->base);
>
> +	hwmon->pdev = pdev;
>   	init_completion(&hwmon->read_completion);
>   	mutex_init(&hwmon->lock);
>
> -	platform_set_drvdata(pdev, hwmon);
> -
> -	ret = devm_request_irq(&pdev->dev, hwmon->irq, jz4740_hwmon_irq, 0,
> +	ret = devm_request_irq(dev, hwmon->irq, jz4740_hwmon_irq, 0,
>   			       pdev->name, hwmon);
>   	if (ret) {
>   		dev_err(&pdev->dev, "Failed to request irq: %d\n", ret);
> @@ -138,38 +126,13 @@ static int jz4740_hwmon_probe(struct platform_device *pdev)
>   	}
>   	disable_irq(hwmon->irq);
>
> -	ret = sysfs_create_group(&pdev->dev.kobj, &jz4740_hwmon_attr_group);
> -	if (ret) {
> -		dev_err(&pdev->dev, "Failed to create sysfs group: %d\n", ret);
> -		return ret;
> -	}
> -
> -	hwmon->hwmon = hwmon_device_register(&pdev->dev);
> -	if (IS_ERR(hwmon->hwmon)) {
> -		ret = PTR_ERR(hwmon->hwmon);
> -		goto err_remove_file;
> -	}
> -
> -	return 0;
> -
> -err_remove_file:
> -	sysfs_remove_group(&pdev->dev.kobj, &jz4740_hwmon_attr_group);
> -	return ret;
> -}
> -
> -static int jz4740_hwmon_remove(struct platform_device *pdev)
> -{
> -	struct jz4740_hwmon *hwmon = platform_get_drvdata(pdev);
> -
> -	hwmon_device_unregister(hwmon->hwmon);
> -	sysfs_remove_group(&pdev->dev.kobj, &jz4740_hwmon_attr_group);
> -
> -	return 0;
> +	hwmon_dev = devm_hwmon_device_register_with_groups(dev, "jz4740", hwmon,
> +							   jz4740_groups);
> +	return PTR_ERR_OR_ZERO(hwmon_dev);
>   }
>
>   static struct platform_driver jz4740_hwmon_driver = {
>   	.probe	= jz4740_hwmon_probe,
> -	.remove = jz4740_hwmon_remove,
>   	.driver = {
>   		.name = "jz4740-hwmon",
>   		.owner = THIS_MODULE,
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
