From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Wed, 13 Apr 2011 11:37:37 +0000
Subject: Re: [lm-sensors] [PATCH v2 2/4] hwmon: (sht15) clean-up the probe
Message-Id: <4DA58B01.8090205@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1302636879-16615-3-git-send-email-vivien.didelot@savoirfairelinux.com>
In-Reply-To: <1302636879-16615-3-git-send-email-vivien.didelot@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 04/12/11 20:34, Vivien Didelot wrote:
> * Move the creation of sysfs attributes after the end of the
>   initialization, and remove them in the error path.
> * Release regulator in the error path.
> * Add a soft reset command (need to wait 11ms before next command).
Ideally add something to say why this is needed. (the heater issue that
Guenter raised).
> 
> Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/hwmon/sht15.c |   54 +++++++++++++++++++++++++++++++++++++++++-------
>  1 files changed, 46 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hwmon/sht15.c b/drivers/hwmon/sht15.c
> index 5fd880d..42992fe 100644
> --- a/drivers/hwmon/sht15.c
> +++ b/drivers/hwmon/sht15.c
> @@ -33,11 +33,13 @@
>  /* Commands */
>  #define SHT15_MEASURE_TEMP		0x03
>  #define SHT15_MEASURE_RH		0x05
> +#define SHT15_SOFT_RESET		0x1E
>  
>  /* Min timings */
>  #define SHT15_TSCKL			100	/* (nsecs) clock low */
>  #define SHT15_TSCKH			100	/* (nsecs) clock high */
>  #define SHT15_TSU			150	/* (nsecs) data setup time */
> +#define SHT15_TSRST			11	/* (msecs) soft reset time */
>  
>  /* Actions the driver may be doing */
>  enum sht15_state {
> @@ -229,6 +231,24 @@ static int sht15_send_cmd(struct sht15_data *data, u8 cmd)
>  }
>  
>  /**
> + * sht15_soft_reset() - send a soft reset command
> + * @data:	sht15 specific data.
> + *
> + * As described in section 3.2 of the datasheet.
> + */
> +static int sht15_soft_reset(struct sht15_data *data)
> +{
> +	int ret;
> +
> +	ret = sht15_send_cmd(data, SHT15_SOFT_RESET);
> +	if (ret)
> +		return ret;
> +	msleep(SHT15_TSRST);
> +
> +	return 0;
> +}
> +
> +/**
>   * sht15_measurement() - get a new value from device
>   * @data:		device instance specific data
>   * @command:		command sent to request value
> @@ -588,13 +608,20 @@ static int __devinit sht15_probe(struct platform_device *pdev)
>  		 */
>  		data->nb.notifier_call = &sht15_invalidate_voltage;
>  		ret = regulator_register_notifier(data->reg, &data->nb);
> +		if (ret) {
> +			dev_err(&pdev->dev,
> +				"regulator notifier request failed\n");
> +			regulator_disable(data->reg);
> +			regulator_put(data->reg);
> +			goto err_free_data;
> +		}
>  	}
>  
>  	/* Try requesting the GPIOs */
>  	ret = gpio_request(data->pdata->gpio_sck, "SHT15 sck");
>  	if (ret) {
>  		dev_err(&pdev->dev, "gpio request failed\n");
> -		goto err_free_data;
> +		goto err_release_reg;
>  	}
>  	gpio_direction_output(data->pdata->gpio_sck, 0);
>  
> @@ -603,11 +630,6 @@ static int __devinit sht15_probe(struct platform_device *pdev)
>  		dev_err(&pdev->dev, "gpio request failed\n");
>  		goto err_release_gpio_sck;
>  	}
> -	ret = sysfs_create_group(&pdev->dev.kobj, &sht15_attr_group);
> -	if (ret) {
> -		dev_err(&pdev->dev, "sysfs create failed");
> -		goto err_release_gpio_data;
> -	}
>  
>  	ret = request_irq(gpio_to_irq(data->pdata->gpio_data),
>  			  sht15_interrupt_fired,
> @@ -620,22 +642,38 @@ static int __devinit sht15_probe(struct platform_device *pdev)
>  	}
>  	disable_irq_nosync(gpio_to_irq(data->pdata->gpio_data));
>  	sht15_connection_reset(data);
> -	sht15_send_cmd(data, 0x1E);
> +	ret = sht15_soft_reset(data);
> +	if (ret)
> +		goto err_release_irq;
> +
> +	ret = sysfs_create_group(&pdev->dev.kobj, &sht15_attr_group);
> +	if (ret) {
> +		dev_err(&pdev->dev, "sysfs create failed\n");
> +		goto err_release_irq;
> +	}
>  
>  	data->hwmon_dev = hwmon_device_register(data->dev);
>  	if (IS_ERR(data->hwmon_dev)) {
>  		ret = PTR_ERR(data->hwmon_dev);
> -		goto err_release_irq;
> +		goto err_release_sysfs_group;
>  	}
>  
>  	return 0;
>  
> +err_release_sysfs_group:
> +	sysfs_remove_group(&pdev->dev.kobj, &sht15_attr_group);
>  err_release_irq:
>  	free_irq(gpio_to_irq(data->pdata->gpio_data), data);
>  err_release_gpio_data:
>  	gpio_free(data->pdata->gpio_data);
>  err_release_gpio_sck:
>  	gpio_free(data->pdata->gpio_sck);
> +err_release_reg:
> +	if (!IS_ERR(data->reg)) {
> +		regulator_unregister_notifier(data->reg, &data->nb);
> +		regulator_disable(data->reg);
> +		regulator_put(data->reg);
> +	}
>  err_free_data:
>  	kfree(data);
>  error_ret:


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
