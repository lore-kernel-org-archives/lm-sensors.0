From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 13 May 2011 10:30:30 +0000
Subject: Re: [lm-sensors] [PATCHv6 1/1] Hwmon: Merge Pkgtemp with Coretemp
Message-Id: <20110513103030.GA16229@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1305196125-10157-1-git-send-email-durgadoss.r@intel.com>
In-Reply-To: <1305196125-10157-1-git-send-email-durgadoss.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Durga,

On Fri, May 13, 2011 at 05:29:29AM -0400, R, Durgadoss wrote:
> Hi Guenter,
> 
> > > > +       mutex_lock(&tdata->update_lock);
> > > > > +
> > > > I don't think the lock helps anything here. _If_ another caller tries
> > > > to acquire the lock while you hold it here, it will get it right after
> > > > the unlock below, just before you remove the data. Oops.
> > > > If that ever happens, the code has a severe problem somewhere.
> > > >
> > >
> > > I agree that the scenario you mentioned can happen.
> > > But to protect it, we need a global lock, that is
> > > alive even if we delete the temp_data.
> > > Should I add a lock in platform_data structure ?
> > >
> > My reasoning was that _if_ the scenario protected by the lock can happen,
> > ie you have a file access while a core is removed, you are in big trouble
> > anyway. A lock anywhere would not help you, since the access to the per-core
> > data you are trying to remove is already underway.
> > 
> > > > > +       /* Remove the sysfs attributes */
> > > > > +       for (i = 0; i < MAX_ATTRS; i++)
> > > > > +               device_remove_file(dev, &tdata->sd_attrs[i].dev_attr);
> > > > > +
> > 
> > My understanding is that once you removed the sysfs files associated with a
> > core,
> > it is safe to remove its tdata entry since sysfs access to the data associated
> > with the core is no longer possible. So a lock should not be needed here.
> > 
> > I am curious - did you experience a scenario which made you believe
> > that you need the lock ?
> > 
> 
> No I did not experience. While offlining this core, we can possibly unload the whole module..
> That's the thought with which I included the lock.
> 
Protecting tdata won't help in that case, though. You would need to protect pdata.
If I understand you correctly, you are concerned that coretemp_remove_core()
can be called from both coretemp_remove() and from put_core_offline().

I don't think that can happen, since the notifier function is removed before
the platform devices are unregistered. Either case, protecting against race
conditions during unload has to be implemented by preventing the race condition
in the first place (ie by making sure that the unload sequence does not permit
any races).

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
