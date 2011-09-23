From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 23 Sep 2011 17:37:58 +0000
Subject: Re: [lm-sensors] [PATCH] coretemp: don't use kernel assigned CPU
Message-Id: <1316799478.3888.41.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <4E7C7CF40200007800057865@nat28.tlf.novell.com>
In-Reply-To: <4E7C7CF40200007800057865@nat28.tlf.novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 2011-09-23 at 06:35 -0400, Jan Beulich wrote:
> ... as that has the potential to conflict with (particularly soft) CPU
> hot removal and re-adding.
> 
> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> 
> ---
>  drivers/hwmon/coretemp.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- 3.1-rc7-coretemp.orig/drivers/hwmon/coretemp.c
> +++ 3.1-rc7-coretemp/drivers/hwmon/coretemp.c
> @@ -724,7 +724,7 @@ static int __cpuinit coretemp_device_add
>  
>  	mutex_lock(&pdev_list_mutex);
>  
> -	pdev = platform_device_alloc(DRVNAME, cpu);
> +	pdev = platform_device_alloc(DRVNAME, TO_PHYS_ID(cpu));

This is incomplete, unfortunately. pdev->id is assumed to match the CPU
ID, not the physical ID, and the code executes TO_PHYS_ID() again on it.
I'll update the patch to fix that problem and apply it.

Guenter


>  	if (!pdev) {
>  		err = -ENOMEM;
>  		pr_err("Device allocation failed\n");
> 
> 
> 



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
