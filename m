From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Sun, 23 Aug 2009 15:17:19 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Fix freeing of gpio_data and irq
Message-Id: <4A915D7F.9090305@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A8FFA0F.1070101@gmail.com>
In-Reply-To: <4A8FFA0F.1070101@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Roel,

> If already requested, gpio_data and irq should be freed in
> the case of an error.

All looks good to me.  Good spot in both cases, thanks.

Acked-by: Jonathan Cameron <jic23@cam.ac.uk>

Andrew, can you push these through as fixes?
You'd be pretty unlucky to hit either of them, but better
safe than sorry.

Thanks
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
> please review, especially the added free_irq(): are its
> arguments ok like this?
Yup, same as in the remove function and given irq is disabled
anyway at that point all should be fine.
> 
> diff --git a/drivers/hwmon/sht15.c b/drivers/hwmon/sht15.c
> index 6290a25..303c026 100644
> --- a/drivers/hwmon/sht15.c
> +++ b/drivers/hwmon/sht15.c
> @@ -562,7 +562,7 @@ static int __devinit sht15_probe(struct platform_device *pdev)
>  	ret = sysfs_create_group(&pdev->dev.kobj, &sht15_attr_group);
>  	if (ret) {
>  		dev_err(&pdev->dev, "sysfs create failed");
> -		goto err_free_data;
> +		goto err_release_gpio_data;
>  	}
>  
>  	ret = request_irq(gpio_to_irq(data->pdata->gpio_data),
> @@ -581,10 +581,12 @@ static int __devinit sht15_probe(struct platform_device *pdev)
>  	data->hwmon_dev = hwmon_device_register(data->dev);
>  	if (IS_ERR(data->hwmon_dev)) {
>  		ret = PTR_ERR(data->hwmon_dev);
> -		goto err_release_gpio_data;
> +		goto err_release_irq;
>  	}
>  	return 0;
>  
> +err_release_irq:
> +	free_irq(gpio_to_irq(data->pdata->gpio_data), data);
>  err_release_gpio_data:
>  	gpio_free(data->pdata->gpio_data);
>  err_release_gpio_sck:


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
