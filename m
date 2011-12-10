From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 10 Dec 2011 22:39:15 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (coretemp) Fix oops on CPU offlining
Message-Id: <20111210223915.GA28179@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20111210214115.5f7cfb2b@endymion.delvare>
In-Reply-To: <20111210214115.5f7cfb2b@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Dec 10, 2011 at 03:41:15PM -0500, Jean Delvare wrote:
> From: Jean Delvare <khali@linux-fr.org>
> Subject: hwmon: (coretemp) Fix oops on CPU offlining
> 
> This is the same fix as "hwmon: (coretemp) Fix oops on driver load"
> but for the CPU offlining case. Sorry for missing it at first.
>     
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Durgadoss R <durgadoss.r@intel.com>
> Cc: Guenter Roeck <guenter.roeck@ericsson.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: stable@kernel.org

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>

> ---
> Once again only kernel branch 3.0 is affected.
> 
>  drivers/hwmon/coretemp.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- linux-3.0.orig/drivers/hwmon/coretemp.c	2011-12-10 14:05:08.000000000 +0100
> +++ linux-3.0/drivers/hwmon/coretemp.c	2011-12-10 16:26:59.000000000 +0100
> @@ -747,6 +747,8 @@ static void __cpuinit put_core_offline(u
>  		return;
>  
>  	pdata = platform_get_drvdata(pdev);
> +	if (!pdata)
> +		return;
>  
>  	indx = TO_ATTR_NO(cpu);
>  
> 
> 
> -- 
> Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
