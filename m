From: Jean Delvare <jdelvare@suse.de>
Date: Sun, 23 Feb 2014 15:59:44 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] hwmon: (coretemp) Convert to use devm_hwmon_device_register_with_groups
Message-Id: <20140223165944.2fc0a7c5@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392595175-7589-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1392595175-7589-3-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Sun, 16 Feb 2014 15:59:35 -0800, Guenter Roeck wrote:
> Simplify code, reduce code size, and attach sysfs attributes to hwmon device.
> 
> For this driver, the only attribute created is the name attribute.
> Other attributes are still created and removed dynamically as cores
> are added or removed.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/coretemp.c |   49 +++++++++-------------------------------------
>  1 file changed, 9 insertions(+), 40 deletions(-)
>
> diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> index 944f850..87e0fa9 100644
> --- a/drivers/hwmon/coretemp.c
> +++ b/drivers/hwmon/coretemp.c
> (...)
> @@ -524,7 +508,7 @@ static int create_core_data(struct platform_device *pdev, unsigned int cpu,
>  		goto exit_free;
>  
>  	/* We can access status register. Get Critical Temperature */
> -	tdata->tjmax = get_tjmax(c, cpu, &pdev->dev);
> +	tdata->tjmax = get_tjmax(c, cpu, pdata->hwmon_dev);

I disagree with this change. This will cause log messages to look like
that:

hwmon hwmon1: TjMax is 97 degrees C

Instead of the previous:

coretemp coretemp.0: TjMax is 97 degrees C

I thought we agreed that probe-time messages should be attached to the
physical device?

>  
>  	/*
>  	 * Read the still undocumented bits 8:15 of IA32_TEMPERATURE_TARGET.
> (...)

Everything else looks OK.

Reviewed-by: Jean Delvare <jdelvare@suse.de>
Tested-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
Suse L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
