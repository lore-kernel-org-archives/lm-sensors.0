From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Fri, 13 May 2011 05:58:09 +0000
Subject: Re: [lm-sensors] [PATCHv6 1/1] Hwmon: Merge Pkgtemp with Coretemp
Message-Id: <D6D887BA8C9DFF48B5233887EF046541095AD0479F@bgsmsx502.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1305196125-10157-1-git-send-email-durgadoss.r@intel.com>
In-Reply-To: <1305196125-10157-1-git-send-email-durgadoss.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

Thanks for the comments.
Some clarifications..

+static struct platform_device *coretemp_get_pdev(unsigned int cpu)
> > +{
> > +       return NULL;
> 
> Unless I am missing something, there should still be one pdev entry.
> But because you never return it, the driver will never instantiate
> the one supported core. You should return the one and only list entry here.
> 
> It might be worthwhile testing the driver in a non-SMP configuration
> to make sure that it works.

Yes You are right...I have to return the one pdev entry here..
Added that code for my next version of patch and tested in a non-smp
Configuration. Works for me without crash.

But, My machine had only one core, in non-smp config(which cannot be offlined)
So could not test HOTPLU_CPU support with non-smp.

> > +static void coretemp_remove_core(struct platform_data *pdata,
> > +                               struct device *dev, int indx)
> > +{
> > +       int i;
> > +       struct temp_data *tdata = pdata->core_data[indx];
> > +
> > +       mutex_lock(&tdata->update_lock);
> > +
> I don't think the lock helps anything here. _If_ another caller tries
> to acquire the lock while you hold it here, it will get it right after
> the unlock below, just before you remove the data. Oops.
> If that ever happens, the code has a severe problem somewhere.
> 

I agree that the scenario you mentioned can happen.
But to protect it, we need a global lock, that is
alive even if we delete the temp_data.
Should I add a lock in platform_data structure ?

> > +       /* Remove the sysfs attributes */
> > +       for (i = 0; i < MAX_ATTRS; i++)
> > +               device_remove_file(dev, &tdata->sd_attrs[i].dev_attr);
> > +
> > +       mutex_unlock(&tdata->update_lock);
> > +
> > +       kfree(pdata->core_data[indx]);
> > +       pdata->core_data[indx] = NULL;
> > +}

Thanks,
Durga

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
