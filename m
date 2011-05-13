From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Fri, 13 May 2011 09:41:29 +0000
Subject: Re: [lm-sensors] [PATCHv6 1/1] Hwmon: Merge Pkgtemp with Coretemp
Message-Id: <D6D887BA8C9DFF48B5233887EF046541095AD0494B@bgsmsx502.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1305196125-10157-1-git-send-email-durgadoss.r@intel.com>
In-Reply-To: <1305196125-10157-1-git-send-email-durgadoss.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

> > > +       mutex_lock(&tdata->update_lock);
> > > > +
> > > I don't think the lock helps anything here. _If_ another caller tries
> > > to acquire the lock while you hold it here, it will get it right after
> > > the unlock below, just before you remove the data. Oops.
> > > If that ever happens, the code has a severe problem somewhere.
> > >
> >
> > I agree that the scenario you mentioned can happen.
> > But to protect it, we need a global lock, that is
> > alive even if we delete the temp_data.
> > Should I add a lock in platform_data structure ?
> >
> My reasoning was that _if_ the scenario protected by the lock can happen,
> ie you have a file access while a core is removed, you are in big trouble
> anyway. A lock anywhere would not help you, since the access to the per-core
> data you are trying to remove is already underway.
> 
> > > > +       /* Remove the sysfs attributes */
> > > > +       for (i = 0; i < MAX_ATTRS; i++)
> > > > +               device_remove_file(dev, &tdata->sd_attrs[i].dev_attr);
> > > > +
> 
> My understanding is that once you removed the sysfs files associated with a
> core,
> it is safe to remove its tdata entry since sysfs access to the data associated
> with the core is no longer possible. So a lock should not be needed here.
> 
> I am curious - did you experience a scenario which made you believe
> that you need the lock ?
> 

No I did not experience. While offlining this core, we can possibly unload the whole module..
That's the thought with which I included the lock.

Thanks,
Durga


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
