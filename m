From: "Jan Beulich" <JBeulich@novell.com>
Date: Wed, 15 Sep 2010 07:35:25 +0000
Subject: Re: [lm-sensors] [PATCH] x86/hwmon: avoid deadlock on CPU removal
Message-Id: <4C90935D020000780001630D@vpn.id2.novell.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4C8E14D90200007800015AAE@vpn.id2.novell.com>
 <20100915001259.GA1237@fenghua-desk.sc.intel.com>
In-Reply-To: <20100915001259.GA1237@fenghua-desk.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Fenghua Yu <fenghua.yu@intel.com>
Cc: "khali@linux-fr.org" <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

>>> On 15.09.10 at 02:13, Fenghua Yu <fenghua.yu@intel.com> wrote:
> From: Fenghua Yu <fenghua.yu@intel.com>
> 
> When a sibling is added to dev_list after a cpu is hot-removed, 
> pdev_list_mutex
> has been locked already. But pkgtemp_device_add() tries to lock 
> pdev_list_mutex
> again. This is incorrect. The patch fixes this issue.
> 
> The patch also removes __cpuinit for pkgtemp_device_add() to avoid section
> mismatch warning.

But that the wrong direction of a change - __cpuinit should be added
to pkgtemp_device_remove() instead.

> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
>  drivers/hwmon/pkgtemp.c |   18 +++++++++++++-----
>  1 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwmon/pkgtemp.c b/drivers/hwmon/pkgtemp.c
> index 74157fc..928a016 100644
> --- a/drivers/hwmon/pkgtemp.c
> +++ b/drivers/hwmon/pkgtemp.c
> @@ -276,7 +276,7 @@ struct pdev_entry {
>  static LIST_HEAD(pdev_list);
>  static DEFINE_MUTEX(pdev_list_mutex);
>  
> -static int __cpuinit pkgtemp_device_add(unsigned int cpu)
> +static int pkgtemp_device_add(unsigned int cpu)
>  {
>  	int err;
>  	struct platform_device *pdev;
> @@ -341,26 +341,34 @@ static void pkgtemp_device_remove(unsigned int cpu)
>  {
>  	struct pdev_entry *p, *n;
>  	unsigned int i;
> -	int err;
>  
> -	mutex_lock(&pdev_list_mutex);
>  	list_for_each_entry_safe(p, n, &pdev_list, list) {
>  		if (p->cpu != cpu)
>  			continue;
>  
> +		mutex_lock(&pdev_list_mutex);
>  		platform_device_unregister(p->pdev);
>  		list_del(&p->list);
>  		kfree(p);
> +		mutex_unlock(&pdev_list_mutex);

While probably not very important, it's nevertheless unclear why you
need to do the kfree() with the mutex held.

Jan

> +		/*
> +		 * Select one of removed cpu's siblings to represent sensor
> +		 * for this package.
> +		 * If there is no more running sibling in a package, the
> +		 * package sensor for this package is not available to user
> +		 * space any more.
> +		 */
>  		for_each_cpu(i, cpu_core_mask(cpu)) {
> +			int err;
> +
>  			if (i != cpu) {
>  				err = pkgtemp_device_add(i);
>  				if (!err)
>  					break;
>  			}
>  		}
> -		break;
> +		return;
>  	}
> -	mutex_unlock(&pdev_list_mutex);
>  }
>  
>  static int __cpuinit pkgtemp_cpu_callback(struct notifier_block *nfb,



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
