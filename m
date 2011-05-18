From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Wed, 18 May 2011 15:32:04 +0000
Subject: Re: [lm-sensors] [PATCHv8 1/1] Hwmon: Merge Pkgtemp with Coretemp
Message-Id: <D6D887BA8C9DFF48B5233887EF046541095ADA9D6A@bgsmsx502.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1305729702-11126-1-git-send-email-durgadoss.r@intel.com>
In-Reply-To: <1305729702-11126-1-git-send-email-durgadoss.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

First of All, Thanks for the quick reply.

> > v8:
> > * Fixed retrieval of phys_proc_id in probe
> > * Added coretemp_remove_device to handle CPU offlining properly
> 
> There is no coretemp_remove_device() in the code. You mean
> coretemp_device_remove(), presumably.

oops.. my bad.. :(

> 
> [ ... ]
> > +static struct platform_device *coretemp_get_pdev(unsigned int cpu)
> > +{
> > +       struct pdev_entry *p;
> > +
> > +       mutex_lock(&pdev_list_mutex);
> > +       list_for_each_entry(p, &pdev_list, list)
> > +               if (p->cpu = cpu) {
> > +                       mutex_unlock(&pdev_list_mutex);
> > +                       return p->pdev;
> > +               }
> >
> I have been wondering about this. In the non-SMP case, can there ever be more
> than one entry ?
> 
> If so, you should not need the loop but could just use list_first_entry()
> instead.

Did not know about the list_first_entry() function..shall use it hereafter..

> 
> [ ... ]
> > -static void __cpuinit coretemp_device_remove(unsigned int cpu)
> > +static void coretemp_device_remove(unsigned int cpu)
> >  {
> >         struct pdev_entry *p;
> > -       unsigned int i;
> >
> >         mutex_lock(&pdev_list_mutex);
> >         list_for_each_entry(p, &pdev_list, list) {
> 
> I think this should be list_for_each_safe() since you remove p.
> 
> > +       #ifdef CONFIG_SMP
> > +               if (p->phys_proc_id != cpu_data(cpu).phys_proc_id)
> > +                       continue;
> > +       #else
> >                 if (p->cpu != cpu)
> >                         continue;
> > +       #endif
> >
> #ifdef at column 0, please.
> 

Didn't know this rule..And checkpatch.pl did not teach me either :)

> I wonder about the !SMP case. Doesn't that imply that there is only one CPU ?
> If so, why compare the CPU ID ?
> 

Agree that there will be only one entry..Shall change it accordingly..

> [ ... ]
> > +{
> > +       int i;
> > +
> > +       /* Find online cores, except pkgtemp data */
> > +       for (i = MAX_CORE_DATA - 1; i >= 0; --i) {
> 
> Not that it matters, but starting at 0 and iterating upwards is more common.
> Is that just personal preference, or do you have a reason ? Just wondering.
> 

Initially I had this code in coretemp_remove. There, the pkgtemp will be
removed after all its cores are removed if we loop this way.
Wanted to keep the same code here too..

But again as you said, it doesn't matter.. Should I change ??

> > +       /* If all cores in this pkg are offline, remove the device */
> > +       if (!is_any_core_online(pdata))
> > +               coretemp_device_remove(cpu);
> 
> Where do you remove the package sensor entry ?

Coretemp_device_remove will call platform_device_unregister,
Which in turn calls coretemp_remove. This will remove the pkgtemp
entry and do other cleanups like removing the name attr etc..

Thanks,
Durga

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
