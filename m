From: Robert Coulson <robert.coulson@ericsson.com>
Date: Wed, 09 May 2012 06:15:20 +0000
Subject: Re: [lm-sensors] [PATCH 3/4] hwmon: (ntc_thermistor) Convert to devm_kzalloc
Message-Id: <C379E95F3359F140B21F5259C55CC8315219967FB7@EUSAACMS0714.eamcs.ericsson.se>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Reviewed-by: Robert Coulson <robert.coulson@ericsson.com>

> -----Original Message-----
> From: Guenter Roeck 
> Sent: Monday, April 23, 2012 8:37 PM
> To: lm-sensors
> Cc: Jean Delvare; Guenter Roeck; Donggeun Kim
> Subject: [PATCH 3/4] hwmon: (ntc_thermistor) Convert to devm_kzalloc
> 
> This avoids memory leaks, and makes the code a bit simpler 
> and smaller.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> Cc: Donggeun Kim <dg77.kim@samsung.com>
> ---
>  drivers/hwmon/ntc_thermistor.c |   11 +++--------
>  1 files changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hwmon/ntc_thermistor.c 
> b/drivers/hwmon/ntc_thermistor.c
> index 6b131252..09a1b26 100644
> --- a/drivers/hwmon/ntc_thermistor.c
> +++ b/drivers/hwmon/ntc_thermistor.c
> @@ -345,7 +345,7 @@ static int __devinit 
> ntc_thermistor_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	data = kzalloc(sizeof(struct ntc_data), GFP_KERNEL);
> +	data = devm_kzalloc(&pdev->dev, sizeof(struct 
> ntc_data), GFP_KERNEL);
>  	if (!data)
>  		return -ENOMEM;
>  
> @@ -366,8 +366,7 @@ static int __devinit 
> ntc_thermistor_probe(struct platform_device *pdev)
>  		dev_err(&pdev->dev, "Unknown device type: %lu(%s)\n",
>  				pdev->id_entry->driver_data,
>  				pdev->id_entry->name);
> -		ret = -EINVAL;
> -		goto err;
> +		return -EINVAL;
>  	}
>  
>  	platform_set_drvdata(pdev, data);
> @@ -375,7 +374,7 @@ static int __devinit 
> ntc_thermistor_probe(struct platform_device *pdev)
>  	ret = sysfs_create_group(&data->dev->kobj, &ntc_attr_group);
>  	if (ret) {
>  		dev_err(data->dev, "unable to create sysfs files\n");
> -		goto err;
> +		return ret;
>  	}
>  
>  	data->hwmon_dev = hwmon_device_register(data->dev);
> @@ -391,8 +390,6 @@ static int __devinit 
> ntc_thermistor_probe(struct platform_device *pdev)
>  	return 0;
>  err_after_sysfs:
>  	sysfs_remove_group(&data->dev->kobj, &ntc_attr_group);
> -err:
> -	kfree(data);
>  	return ret;
>  }
>  
> @@ -404,8 +401,6 @@ static int __devexit 
> ntc_thermistor_remove(struct platform_device *pdev)
>  	sysfs_remove_group(&data->dev->kobj, &ntc_attr_group);
>  	platform_set_drvdata(pdev, NULL);
>  
> -	kfree(data);
> -
>  	return 0;
>  }
>  
> -- 
> 1.7.9.48.g85da4d
> 
> 
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
