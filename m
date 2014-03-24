From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 24 Mar 2014 03:27:24 +0000
Subject: Re: [lm-sensors] [RFC V1 1/3] hwmon: da9063: HWMON driver
Message-Id: <532FA61C.7070601@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1395607051.git.stwiss.opensource@diasemi.com> <420d4f5c8436a66b511693531cfeda131258ce69.1395607051.git.stwiss.opensource@diasemi.com>
In-Reply-To: <420d4f5c8436a66b511693531cfeda131258ce69.1395607051.git.stwiss.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>, Jean Delvare <jdelvare@suse.de>
Cc: David Dajun Chen <david.chen@diasemi.com>, LINUX-DOC <linux-doc@vger.kernel.org>, LINUX-KERNEL <linux-kernel@vger.kernel.org>, LM-SENSORS <lm-sensors@lm-sensors.org>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>, Rob Landley <rob@landley.net>, Samuel Ortiz <sameo@linux.intel.com>

On 03/23/2014 01:37 PM, Opensource [Steve Twiss] wrote:
> From: Opensource [Steve Twiss] <stwiss.opensource@diasemi.com>
>
> Add the HWMON driver for DA9063
>
> Signed-off-by: Opensource [Steve Twiss] <stwiss.opensource@diasemi.com>
> ---

> +
> +	ret = sysfs_create_group(&pdev->dev.kobj, &da9063_attr_group);
> +	if (ret)
> +		return ret;
> +
> +	hwmon->classdev = hwmon_device_register(&pdev->dev);
> +	if (IS_ERR(hwmon->classdev)) {
> +		sysfs_remove_group(&pdev->dev.kobj, &da9063_attr_group);
> +		return PTR_ERR(hwmon->classdev);
> +	}
> +

Hi Steve,

This looks like an ideal candidate for devm_hwmon_device_register_with_groups().
Can you use that API, please ?

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
