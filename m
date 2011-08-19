From: Todd Poynor <toddpoynor@google.com>
Date: Fri, 19 Aug 2011 05:34:38 +0000
Subject: Re: [lm-sensors] [RFC PATCH 6/6 V2] hwmon: OMAP4: On die
Message-Id: <20110819053438.GA2901@google.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1313664735-8917-1-git-send-email-j-keerthy@ti.com>
 <1313664735-8917-7-git-send-email-j-keerthy@ti.com>
In-Reply-To: <1313664735-8917-7-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Keerthy <j-keerthy@ti.com>
Cc: linux-omap@vger.kernel.org, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>, lm-sensors@lm-sensors.org

On Thu, Aug 18, 2011 at 04:22:15PM +0530, Keerthy wrote:
...
> +static int omap_temp_sensor_clk_enable(struct omap_temp_sensor *temp_sensor)
> +{
> +	u32 ret = 0;
> +
> +	if (temp_sensor->clk_on) {
> +		dev_err(temp_sensor->hwmon_dev, "clock already on\n");
> +		goto out;
> +	}
> +
> +	ret = pm_runtime_get_sync(temp_sensor->hwmon_dev);
> +	if (ret < 0) {
> +		dev_err(temp_sensor->hwmon_dev, "get sync failed\n");
> +		goto out;
> +	}
> +
> +	temp_sensor->clk_on = 1;


Probably should hold the mutex around this to keep clk_on consistent
with runtime PM state (and in disable method).

...
> +static int __devinit omap_temp_sensor_probe(struct platform_device *pdev)
> +{
> +	struct omap_temp_sensor_pdata	*pdata	= pdev->dev.platform_data;
> +	struct omap_temp_sensor		*temp_sensor;
> +	struct resource			*mem;
> +	int				ret = 0;
> +	int				val, clk_rate;
> +
> +	if (!pdata) {
> +		dev_err(&pdev->dev, "platform data missing\n");
> +		return -EINVAL;
> +	}
> +
> +	temp_sensor = kzalloc(sizeof(*temp_sensor), GFP_KERNEL);
> +	if (!temp_sensor)
> +		return -ENOMEM;
> +
> +	mutex_init(&temp_sensor->sensor_mutex);
> +
> +	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!mem) {
> +		dev_err(&pdev->dev, "no mem resource\n");
> +		ret = -ENOMEM;
> +		goto plat_res_err;
> +	}
> +
> +	temp_sensor->irq = platform_get_irq_byname(pdev, "thermal_alert");
> +	if (temp_sensor->irq < 0) {
> +		dev_err(&pdev->dev, "get_irq_byname failed\n");
> +		ret = temp_sensor->irq;
> +		goto plat_res_err;
> +	}
> +
> +	temp_sensor->phy_base = ioremap(mem->start, resource_size(mem));
> +	temp_sensor->clock = NULL;
> +	temp_sensor->registers = pdata->registers;
> +	temp_sensor->hwmon_dev = &pdev->dev;
> +
> +	pm_runtime_enable(&pdev->dev);
> +	pm_runtime_irq_safe(&pdev->dev);
> +
> +	/*
> +	 * check if the efuse has a non-zero value if not
> +	 * it is an untrimmed sample and the temperatures
> +	 * may not be accurate
> +	 */
> +
> +	if (omap_temp_sensor_readl(temp_sensor,
> +			temp_sensor->registers->bgap_efuse))
> +		temp_sensor->is_efuse_valid = 1;
> +
> +	platform_set_drvdata(pdev, temp_sensor);
> +	dev_set_drvdata(&pdev->dev, temp_sensor);
> +	temp_sensor->clock = clk_get(temp_sensor->hwmon_dev, "fck");
> +	if (IS_ERR(temp_sensor->clock)) {
> +		ret = PTR_ERR(temp_sensor->clock);
> +		dev_err(temp_sensor->hwmon_dev,
> +			"unable to get fclk: %d\n", ret);
> +		ret = -EINVAL;
> +		goto plat_res_err;
> +	}
> +
> +	ret = omap_temp_sensor_clk_enable(temp_sensor);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Cannot enable temp sensor\n");
> +		goto clken_err;
> +	}
> +
> +	clk_rate = clk_round_rate(temp_sensor->clock, 2000000);
> +	if (clk_rate < 1000000 || clk_rate = 0xffffffff) {
> +		dev_err(&pdev->dev, "Error round rate\n");
> +		ret = -EINVAL;
> +		goto clken_err;
> +	}
> +
> +	ret = clk_set_rate(temp_sensor->clock, clk_rate);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Cannot set clock rate\n");
> +		goto clken_err;
> +	}
> +
> +	temp_sensor->clk_rate = clk_rate;
> +	omap_enable_continuous_mode(temp_sensor, 1);
> +	omap_configure_temp_sensor_thresholds(temp_sensor);
> +	/* 1 ms */
> +	omap_configure_temp_sensor_counter(temp_sensor, 1);
> +
> +	/* Wait till the first conversion is done wait for at least 1ms */
> +	usleep_range(1000, 2000);
> +
> +	/* Read the temperature once due to hw issue*/
> +	omap_temp_sensor_readl(temp_sensor,
> +			temp_sensor->registers->temp_sensor_ctrl);
> +
> +	/* Set 2 seconds time as default counter */
> +	omap_configure_temp_sensor_counter(temp_sensor,
> +						temp_sensor->clk_rate * 2);
> +
> +	temp_sensor->hwmon_dev = hwmon_device_register(&pdev->dev);
> +	if (IS_ERR(temp_sensor->hwmon_dev)) {
> +		dev_err(&pdev->dev, "hwmon_device_register failed.\n");
> +		ret = PTR_ERR(temp_sensor->hwmon_dev);
> +		goto hwmon_reg_err;
> +	}
> +
> +	ret = sysfs_create_group(&pdev->dev.kobj,
> +				 &omap_temp_sensor_group);
> +	if (ret) {
> +		dev_err(&pdev->dev, "could not create sysfs files\n");
> +		goto sysfs_create_err;
> +	}
> +
> +	kobject_uevent(&temp_sensor->hwmon_dev->kobj, KOBJ_ADD);
> +
> +	ret = request_threaded_irq(temp_sensor->irq, NULL,
> +		omap_talert_irq_handler, IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> +			"temp_sensor", temp_sensor);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Request threaded irq failed.\n");
> +		goto req_irq_err;
> +	}
> +
> +	/* unmask the T_COLD and unmask T_HOT at init */
> +	val = omap_temp_sensor_readl(temp_sensor,
> +		temp_sensor->registers->bgap_mask_ctrl);
> +	val |= temp_sensor->registers->mask_cold_mask
> +		| temp_sensor->registers->mask_hot_mask;
> +
> +	omap_temp_sensor_writel(temp_sensor, val,
> +		temp_sensor->registers->bgap_mask_ctrl);
> +
> +	return 0;
> +
> +req_irq_err:
> +	kobject_uevent(&temp_sensor->hwmon_dev->kobj, KOBJ_REMOVE);
> +	sysfs_remove_group(&temp_sensor->hwmon_dev->kobj,
> +				&omap_temp_sensor_group);
> +sysfs_create_err:
> +	hwmon_device_unregister(&pdev->dev);
> +hwmon_reg_err:
> +	omap_temp_sensor_clk_disable(temp_sensor);
> +clken_err:
> +	clk_put(temp_sensor->clock);
> +plat_res_err:
> +	mutex_destroy(&temp_sensor->sensor_mutex);
> +	kfree(temp_sensor);

Should also:
        platform_set_drvdata(pdev, NULL);
        dev_set_drvdata(&pdev->dev, NULL);


> +	return ret;
> +}
> +
> +static int __devexit omap_temp_sensor_remove(struct platform_device *pdev)
> +{
> +	struct omap_temp_sensor *temp_sensor = platform_get_drvdata(pdev);
> +
> +	hwmon_device_unregister(&pdev->dev);
> +	kobject_uevent(&temp_sensor->hwmon_dev->kobj, KOBJ_REMOVE);
> +	sysfs_remove_group(&temp_sensor->hwmon_dev->kobj,
> +			&omap_temp_sensor_group);
> +	omap_temp_sensor_clk_disable(temp_sensor);
> +	clk_put(temp_sensor->clock);
> +	platform_set_drvdata(pdev, NULL);

And:
       dev_set_drvdata(&pdev->dev, NULL);

> +	free_irq(temp_sensor->irq, temp_sensor);

Need to free IRQ before clock is disabled (else ISR may access while
clock stopped, possible L3 interconnect error and ARM imprecise
external abort)?

> +	mutex_destroy(&temp_sensor->sensor_mutex);
> +	kfree(temp_sensor);
> +
> +	return 0;
> +}


Todd

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
