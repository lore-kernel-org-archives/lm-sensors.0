From: Jonathan Cameron <jic23@kernel.org>
Date: Sat, 11 Aug 2012 17:21:03 +0000
Subject: Re: [lm-sensors] [PATCH 33/39] hwmon: (sht15) Convert to use devm_ functions
Message-Id: <5026947F.1070401@kernel.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1344352828-25143-34-git-send-email-linux@roeck-us.net>
In-Reply-To: <1344352828-25143-34-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 08/07/2012 04:20 PM, Guenter Roeck wrote:
> Convert to use devm_ functions to reduce code size and simplify the code.
> 
Hi Guenter, sorry for the slow reply.

Looks fine to me. Can't easily test at the moment though... Given
most of the changes effect error paths anyway never mind ;)
> Cc: Jonathan Cameron <jic23@cam.ac.uk>
> Cc: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/hwmon/sht15.c |   58 +++++++++++++++++--------------------------------
>  1 file changed, 20 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/hwmon/sht15.c b/drivers/hwmon/sht15.c
> index 8b011d0..e461464 100644
> --- a/drivers/hwmon/sht15.c
> +++ b/drivers/hwmon/sht15.c
> @@ -884,14 +884,12 @@ static int sht15_invalidate_voltage(struct notifier_block *nb,
>  static int __devinit sht15_probe(struct platform_device *pdev)
>  {
>  	int ret;
> -	struct sht15_data *data = kzalloc(sizeof(*data), GFP_KERNEL);
> +	struct sht15_data *data;
>  	u8 status = 0;
>  
> -	if (!data) {
> -		ret = -ENOMEM;
> -		dev_err(&pdev->dev, "kzalloc failed\n");
> -		goto error_ret;
> -	}
> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
>  
>  	INIT_WORK(&data->read_work, sht15_bh_read_data);
>  	INIT_WORK(&data->update_supply_work, sht15_update_voltage);
> @@ -901,9 +899,8 @@ static int __devinit sht15_probe(struct platform_device *pdev)
>  	init_waitqueue_head(&data->wait_queue);
>  
>  	if (pdev->dev.platform_data = NULL) {
> -		ret = -EINVAL;
>  		dev_err(&pdev->dev, "no platform data supplied\n");
> -		goto err_free_data;
> +		return -EINVAL;
>  	}
>  	data->pdata = pdev->dev.platform_data;
>  	data->supply_uV = data->pdata->supply_mv * 1000;
> @@ -918,7 +915,7 @@ static int __devinit sht15_probe(struct platform_device *pdev)
>  	 * If a regulator is available,
>  	 * query what the supply voltage actually is!
>  	 */
> -	data->reg = regulator_get(data->dev, "vcc");
> +	data->reg = devm_regulator_get(data->dev, "vcc");
>  	if (!IS_ERR(data->reg)) {
>  		int voltage;
>  
> @@ -937,51 +934,51 @@ static int __devinit sht15_probe(struct platform_device *pdev)
>  			dev_err(&pdev->dev,
>  				"regulator notifier request failed\n");
>  			regulator_disable(data->reg);
> -			regulator_put(data->reg);
> -			goto err_free_data;
> +			return ret;
>  		}
>  	}
>  
>  	/* Try requesting the GPIOs */
> -	ret = gpio_request(data->pdata->gpio_sck, "SHT15 sck");
> +	ret = devm_gpio_request(&pdev->dev, data->pdata->gpio_sck, "SHT15 sck");
>  	if (ret) {
>  		dev_err(&pdev->dev, "gpio request failed\n");
>  		goto err_release_reg;
>  	}
>  	gpio_direction_output(data->pdata->gpio_sck, 0);
>  
> -	ret = gpio_request(data->pdata->gpio_data, "SHT15 data");
> +	ret = devm_gpio_request(&pdev->dev, data->pdata->gpio_data,
> +				"SHT15 data");
>  	if (ret) {
>  		dev_err(&pdev->dev, "gpio request failed\n");
> -		goto err_release_gpio_sck;
> +		goto err_release_reg;
>  	}
>  
> -	ret = request_irq(gpio_to_irq(data->pdata->gpio_data),
> -			  sht15_interrupt_fired,
> -			  IRQF_TRIGGER_FALLING,
> -			  "sht15 data",
> -			  data);
> +	ret = devm_request_irq(&pdev->dev, gpio_to_irq(data->pdata->gpio_data),
> +			       sht15_interrupt_fired,
> +			       IRQF_TRIGGER_FALLING,
> +			       "sht15 data",
> +			       data);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to get irq for data line\n");
> -		goto err_release_gpio_data;
> +		goto err_release_reg;
>  	}
>  	disable_irq_nosync(gpio_to_irq(data->pdata->gpio_data));
>  	sht15_connection_reset(data);
>  	ret = sht15_soft_reset(data);
>  	if (ret)
> -		goto err_release_irq;
> +		goto err_release_reg;
>  
>  	/* write status with platform data options */
>  	if (status) {
>  		ret = sht15_send_status(data, status);
>  		if (ret)
> -			goto err_release_irq;
> +			goto err_release_reg;
>  	}
>  
>  	ret = sysfs_create_group(&pdev->dev.kobj, &sht15_attr_group);
>  	if (ret) {
>  		dev_err(&pdev->dev, "sysfs create failed\n");
> -		goto err_release_irq;
> +		goto err_release_reg;
>  	}
>  
>  	data->hwmon_dev = hwmon_device_register(data->dev);
> @@ -994,21 +991,11 @@ static int __devinit sht15_probe(struct platform_device *pdev)
>  
>  err_release_sysfs_group:
>  	sysfs_remove_group(&pdev->dev.kobj, &sht15_attr_group);
> -err_release_irq:
> -	free_irq(gpio_to_irq(data->pdata->gpio_data), data);
> -err_release_gpio_data:
> -	gpio_free(data->pdata->gpio_data);
> -err_release_gpio_sck:
> -	gpio_free(data->pdata->gpio_sck);
>  err_release_reg:
>  	if (!IS_ERR(data->reg)) {
>  		regulator_unregister_notifier(data->reg, &data->nb);
>  		regulator_disable(data->reg);
> -		regulator_put(data->reg);
>  	}
> -err_free_data:
> -	kfree(data);
> -error_ret:
>  	return ret;
>  }
>  
> @@ -1030,14 +1017,9 @@ static int __devexit sht15_remove(struct platform_device *pdev)
>  	if (!IS_ERR(data->reg)) {
>  		regulator_unregister_notifier(data->reg, &data->nb);
>  		regulator_disable(data->reg);
> -		regulator_put(data->reg);
>  	}
>  
> -	free_irq(gpio_to_irq(data->pdata->gpio_data), data);
> -	gpio_free(data->pdata->gpio_data);
> -	gpio_free(data->pdata->gpio_sck);
>  	mutex_unlock(&data->read_lock);
> -	kfree(data);
>  
>  	return 0;
>  }
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
