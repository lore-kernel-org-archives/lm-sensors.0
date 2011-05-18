From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 18 May 2011 14:24:26 +0000
Subject: Re: [lm-sensors] [PATCHv8 1/1] Hwmon: Merge Pkgtemp with Coretemp
Message-Id: <20110518142426.GA10953@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1305729702-11126-1-git-send-email-durgadoss.r@intel.com>
In-Reply-To: <1305729702-11126-1-git-send-email-durgadoss.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Durga,

On Wed, May 18, 2011 at 10:41:42AM -0400, Durgadoss R wrote:
> This patch merges the pkgtemp with coretemp driver.
> The sysfs interfaces for all cores in the same pkg
> are shown under one directory, in hwmon. It also
> supports CONFIG_HOTPLUG_CPU. So, the sysfs interfaces
> are created when each core comes online and are
> removed when it goes offline.
> 
> Signed-off-by: Durgadoss R <durgadoss.r@intel.com>

[ ... ]
> v8:
> * Fixed retrieval of phys_proc_id in probe
> * Added coretemp_remove_device to handle CPU offlining properly

There is no coretemp_remove_device() in the code. You mean
coretemp_device_remove(), presumably.

[ ... ]
> +static struct platform_device *coretemp_get_pdev(unsigned int cpu)
> +{
> +       struct pdev_entry *p;
> +
> +       mutex_lock(&pdev_list_mutex);
> +       list_for_each_entry(p, &pdev_list, list)
> +               if (p->cpu = cpu) {
> +                       mutex_unlock(&pdev_list_mutex);
> +                       return p->pdev;
> +               }
> 
I have been wondering about this. In the non-SMP case, can there ever be more than one entry ?

If so, you should not need the loop but could just use list_first_entry() instead.

[ ... ]
> -static void __cpuinit coretemp_device_remove(unsigned int cpu)
> +static void coretemp_device_remove(unsigned int cpu)
>  {
>         struct pdev_entry *p;
> -       unsigned int i;
> 
>         mutex_lock(&pdev_list_mutex);
>         list_for_each_entry(p, &pdev_list, list) {

I think this should be list_for_each_safe() since you remove p. 

> +       #ifdef CONFIG_SMP
> +               if (p->phys_proc_id != cpu_data(cpu).phys_proc_id)
> +                       continue;
> +       #else
>                 if (p->cpu != cpu)
>                         continue;
> +       #endif
> 
#ifdef at column 0, please.

I wonder about the !SMP case. Doesn't that imply that there is only one CPU ?
If so, why compare the CPU ID ?

[ ... ]
> +{
> +       int i;
> +
> +       /* Find online cores, except pkgtemp data */
> +       for (i = MAX_CORE_DATA - 1; i >= 0; --i) {

Not that it matters, but starting at 0 and iterating upwards is more common.
Is that just personal preference, or do you have a reason ? Just wondering.

> +               if (pdata->core_data[i] &&
> +                       !pdata->core_data[i]->is_pkg_data) {
> +                       return 1;

Please return a boolean.

> +               }
> +       }
> +       return 0;
> +}
> +
[ ... ]
> +
> +static void put_core_offline(unsigned int cpu)
> +{
> +       int i, indx;
> +       struct platform_data *pdata;
> +       struct platform_device *pdev = coretemp_get_pdev(cpu);
> +
> +       /* If the physical CPU device does not exist, just return */
> +       if (!pdev)
> +               return;
> +
> +       pdata = platform_get_drvdata(pdev);
> +
> +       indx = get_attr_no(cpu, 0);
> +
> +       if (pdata->core_data[indx] && pdata->core_data[indx]->cpu = cpu)
> +               coretemp_remove_core(pdata, &pdev->dev, indx);
> +
> +       /* Online the HT version of this core, if any */
> +       for_each_cpu(i, cpu_sibling_mask(cpu))
> +               if (i != cpu) {
> +                       get_core_online(i);
> +                       break;
> +               }
> +
> +       /* If all cores in this pkg are offline, remove the device */
> +       if (!is_any_core_online(pdata))
> +               coretemp_device_remove(cpu);

Where do you remove the package sensor entry ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
