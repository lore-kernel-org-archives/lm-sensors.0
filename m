From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Thu, 01 Dec 2011 10:54:06 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (coretemp) Fix oops on driver load
Message-Id: <D6D887BA8C9DFF48B5233887EF04654109F13A7DF4@bgsmsx502.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20111201110047.130190a5@endymion.delvare>
In-Reply-To: <20111201110047.130190a5@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks Jean for the fix.

> If the CPU microcode is too old, the coretemp driver won't work. But
> instead of failing gracefully, it currently oops. Check for NULL
> platform device data to avoid this.

Acked-by: Durgadoss R <durgadoss.r@intel.com>

Thanks,
Durga

> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Durgadoss R <Durgadoss.r@intel.com>
> Cc: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
> This is for stable kernel branch 3.0 only. Previous and later versions
> have different code paths and are not affected by this bug.
> 
>  drivers/hwmon/coretemp.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- linux-3.0.orig/drivers/hwmon/coretemp.c	2011-12-01 08:39:45.000000000
> +0100
> +++ linux-3.0/drivers/hwmon/coretemp.c	2011-12-01 08:49:32.000000000 +0100
> @@ -539,6 +539,8 @@ static void coretemp_add_core(unsigned i
>  		return;
> 
>  	pdata = platform_get_drvdata(pdev);
> +	if (!pdata)
> +		return;
> 
>  	err = create_core_data(pdata, pdev, cpu, pkg_flag);
>  	if (err)
> 
> --
> Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
