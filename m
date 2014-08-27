From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 27 Aug 2014 18:38:43 +0000
Subject: Re: [lm-sensors] [PATCH v6 4/4] drivers/hwmon/menf21bmc_hwmon: introduce MEN14F021P00 BMC HWMON driv
Message-Id: <20140827183843.GC2198@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1409161615.git.andreas.werner@men.de>
 <65074740dfc6363134384b45fcd3acf5f2b4254f.1409161615.git.andreas.werner@men.de>
In-Reply-To: <65074740dfc6363134384b45fcd3acf5f2b4254f.1409161615.git.andreas.werner@men.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andreas Werner <andreas.werner@men.de>
Cc: linux-kernel@vger.kernel.org, sameo@linux.intel.com, lee.jones@linaro.org, lm-sensors@lm-sensors.org, wim@iguana.be, linux-watchdog@vger.kernel.org, cooloney@gmail.com, rpurdie@rpsys.net, linux-leds@vger.kernel.org

On Wed, Aug 27, 2014 at 07:53:06PM +0200, Andreas Werner wrote:
> Added driver to support the 14F021P00 BMC Hardware Monitoring.
> The BMC is a Board Management Controller including monitoring of the
> board voltages.
> 
> Signed-off-by: Andreas Werner <andreas.werner@men.de>

Looks good, though I do have one comment ...

> +
> +	hwmon_dev = devm_hwmon_device_register_with_groups(&pdev->dev,
> +						   "menf21bmc", drv_data,
> +						   menf21bmc_hwmon_groups);
> +	if (IS_ERR(hwmon_dev))
> +		return PTR_ERR(hwmon_dev);
> +
> +	dev_info(&pdev->dev, "MEN 14F021P00 BMC hwmon device enabled");
> +
You removed the dev_info from the mfd driver but left it in the client
drivers.  If you'd drop it here as well, you could use
'return PTR_ERR_OR_ZERO(hwmon_dev);'.  Just a suggestion, not mandatory.

Either case,

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

I assume this will go in through the mfd tree.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
