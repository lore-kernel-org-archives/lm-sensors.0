From: "Jan Beulich" <JBeulich@novell.com>
Date: Mon, 27 Sep 2010 07:10:57 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: uniform the init style of
Message-Id: <4CA05FA10200007800018F8B@vpn.id2.novell.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1285480800-14558-1-git-send-email-gong.chen@linux.intel.com>
 <1285480800-14558-2-git-send-email-gong.chen@linux.intel.com>
In-Reply-To: <1285480800-14558-2-git-send-email-gong.chen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chen Gong <gong.chen@linux.intel.com>, lm-sensors@lm-sensors.org
Cc: linux-kernel@vger.kernel.org

>>> On 26.09.10 at 07:59, Chen Gong <gong.chen@linux.intel.com> wrote:
> pkgtemp is derived from coretemp, so some reasonable
> logics should be applied onto pkgtemp, too. Such as
> the init logic here.
> 
> Signed-off-by: Chen Gong <gong.chen@linux.intel.com>

Acked-by: Jan Beulich <jbeulich@novell.com>

> ---
>  drivers/hwmon/pkgtemp.c |   23 +++++++----------------
>  1 files changed, 7 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/hwmon/pkgtemp.c b/drivers/hwmon/pkgtemp.c
> index f119039..6186041 100644
> --- a/drivers/hwmon/pkgtemp.c
> +++ b/drivers/hwmon/pkgtemp.c
> @@ -392,7 +392,6 @@ static struct notifier_block pkgtemp_cpu_notifier 
> __refdata = {
>  static int __init pkgtemp_init(void)
>  {
>  	int i, err = -ENODEV;
> -	struct pdev_entry *p, *n;
>  
>  	/* quick check if we run Intel */
>  	if (cpu_data(0).x86_vendor != X86_VENDOR_INTEL)
> @@ -402,31 +401,23 @@ static int __init pkgtemp_init(void)
>  	if (err)
>  		goto exit;
>  
> -	for_each_online_cpu(i) {
> -		err = pkgtemp_device_add(i);
> -		if (err)
> -			goto exit_devices_unreg;
> -	}
> +	for_each_online_cpu(i)
> +		pkgtemp_device_add(i);
> +
> +#ifndef CONFIG_HOTPLUG_CPU
>  	if (list_empty(&pdev_list)) {
>  		err = -ENODEV;
>  		goto exit_driver_unreg;
>  	}
> +#endif
>  
> -#ifdef CONFIG_HOTPLUG_CPU
>  	register_hotcpu_notifier(&pkgtemp_cpu_notifier);
> -#endif
>  	return 0;
>  
> -exit_devices_unreg:
> -	mutex_lock(&pdev_list_mutex);
> -	list_for_each_entry_safe(p, n, &pdev_list, list) {
> -		platform_device_unregister(p->pdev);
> -		list_del(&p->list);
> -		kfree(p);
> -	}
> -	mutex_unlock(&pdev_list_mutex);
> +#ifndef CONFIG_HOTPLUG_CPU
>  exit_driver_unreg:
>  	platform_driver_unregister(&pkgtemp_driver);
> +#endif
>  exit:
>  	return err;
>  }





_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
