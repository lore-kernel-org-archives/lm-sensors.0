From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 21 Sep 2012 18:18:44 +0000
Subject: Re: [lm-sensors] [PATCH v4] hwmon: Versatile Express hwmon driver
Message-Id: <20120921181844.GA20763@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1348246591-2409-1-git-send-email-mail@pawelmoll.com>
In-Reply-To: <1348246591-2409-1-git-send-email-mail@pawelmoll.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Sep 21, 2012 at 05:56:31PM +0100, Pawel Moll wrote:
> From: Pawel Moll <pawel.moll@arm.com>
> 
> hwmon framework driver for Versatile Express sensors, providing
> information about board level voltage (only when regulator driver
> is not configured), currents, temperature and power/energy usage.
> Labels for the values can be defined as DT properties.
> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> ---
>  .../devicetree/bindings/hwmon/vexpress.txt         |   23 ++
>  Documentation/hwmon/vexpress                       |   34 +++
>  drivers/hwmon/Kconfig                              |    8 +
>  drivers/hwmon/Makefile                             |    1 +
>  drivers/hwmon/vexpress.c                           |  229 ++++++++++++++++++++
>  5 files changed, 295 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/vexpress.txt
>  create mode 100644 Documentation/hwmon/vexpress
>  create mode 100644 drivers/hwmon/vexpress.c
> 
[ ... ]

> +
> +	err = sysfs_create_group(&pdev->dev.kobj, match->data);
> +	if (err)
> +		goto error;

You'll need a second label for that. Since the group was not created, you can
not delete it.

> +
> +	data->hwmon_dev = hwmon_device_register(&pdev->dev);
> +	if (IS_ERR(data->hwmon_dev)) {
> +		err = PTR_ERR(data->hwmon_dev);
> +		goto error;
> +	}
> +
> +	return 0;
> +
> +error:
> +	sysfs_remove_group(&pdev->dev.kobj, match->data);
> +	vexpress_config_func_put(data->func);
> +	return err;
> +}
> +
> +static int __devexit vexpress_hwmon_remove(struct platform_device *pdev)
> +{
> +	struct vexpress_hwmon_data *data = platform_get_drvdata(pdev);
> +	const struct of_device_id *match;
> +
> +	hwmon_device_unregister(data->hwmon_dev);
> +
> +	match = of_match_device(vexpress_hwmon_of_match, &pdev->dev);
> +	sysfs_remove_group(&pdev->dev.kobj, match->data);
> +
> +	vexpress_config_func_put(data->func);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver vexpress_hwmon_driver = {
> +	.probe = vexpress_hwmon_probe,
> +	.remove = __devexit_p(vexpress_hwmon_remove),
> +	.driver	= {
> +		.name = DRVNAME,
> +		.owner = THIS_MODULE,
> +		.of_match_table = vexpress_hwmon_of_match,
> +	},
> +};
> +
> +module_platform_driver(vexpress_hwmon_driver);
> +
> +MODULE_AUTHOR("Pawel Moll <pawel.moll@arm.com>");
> +MODULE_DESCRIPTION("Versatile Express hwmon sensors driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:vexpress-hwmon");
> -- 
> 1.7.9.5
> 
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
