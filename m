From: Chen Gong <gong.chen@linux.intel.com>
Date: Tue, 14 Sep 2010 07:24:07 +0000
Subject: Re: [lm-sensors] [PATCH] x86/hwmon: {core, pkg,
Message-Id: <4C8F2317.60506@linux.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4C8E19500200007800015B15@vpn.id2.novell.com>
In-Reply-To: <4C8E19500200007800015B15@vpn.id2.novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Jan Beulich <JBeulich@novell.com>
Cc: khali@linux-fr.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

于 9/13/2010 6:30 PM, Jan Beulich 写道:
> ... as they're being called only from a __cpuinit function.
>
> Signed-off-by: Jan Beulich<jbeulich@novell.com>
>
> ---
>   drivers/hwmon/coretemp.c    |    2 +-
>   drivers/hwmon/pkgtemp.c     |    2 +-
>   drivers/hwmon/via-cputemp.c |    2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
>
> --- linux-2.6.36-rc4/drivers/hwmon/coretemp.c	2010-09-13 08:45:02.000000000 +0200
> +++ 2.6.36-rc4-x86-hwmon-sections/drivers/hwmon/coretemp.c	2010-09-03 17:54:14.000000000 +0200
> @@ -480,7 +480,7 @@ exit:
>   	return err;
>   }
>
> -static void coretemp_device_remove(unsigned int cpu)
> +static void __cpuinit coretemp_device_remove(unsigned int cpu)
>   {
>   	struct pdev_entry *p, *n;
>   	mutex_lock(&pdev_list_mutex);
> --- linux-2.6.36-rc4/drivers/hwmon/pkgtemp.c	2010-09-13 08:45:03.000000000 +0200
> +++ 2.6.36-rc4-x86-hwmon-sections/drivers/hwmon/pkgtemp.c	2010-09-01 09:00:45.000000000 +0200
> @@ -337,7 +337,7 @@ exit:
>   }
>
>   #ifdef CONFIG_HOTPLUG_CPU
> -static void pkgtemp_device_remove(unsigned int cpu)
> +static void __cpuinit pkgtemp_device_remove(unsigned int cpu)
>   {
>   	struct pdev_entry *p, *n;
>   	unsigned int i;
> --- linux-2.6.36-rc4/drivers/hwmon/via-cputemp.c	2010-09-13 08:45:03.000000000 +0200
> +++ 2.6.36-rc4-x86-hwmon-sections/drivers/hwmon/via-cputemp.c	2010-09-13 00:00:00.000000000 +0200
> @@ -238,7 +238,7 @@ exit:
>   }
>
>   #ifdef CONFIG_HOTPLUG_CPU
> -static void via_cputemp_device_remove(unsigned int cpu)
> +static void __cpuinit via_cputemp_device_remove(unsigned int cpu)
>   {
>   	struct pdev_entry *p, *n;
>   	mutex_lock(&pdev_list_mutex);
>
>
>
>

I think the change in the coretemp.c is needed but other 2 are 
unnecessary because CONFIG_HOTPLUG_CPU has covered the codes final
status after init done.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
