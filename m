From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Sat, 14 May 2011 08:48:53 +0000
Subject: Re: [lm-sensors] [PATCHv6 1/1] Hwmon: Merge Pkgtemp with Coretemp
Message-Id: <D6D887BA8C9DFF48B5233887EF046541095AD5677E@bgsmsx502.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1305196125-10157-1-git-send-email-durgadoss.r@intel.com>
In-Reply-To: <1305196125-10157-1-git-send-email-durgadoss.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

> > >
> > > My understanding is that once you removed the sysfs files associated with a
> > > core,
> > > it is safe to remove its tdata entry since sysfs access to the data
> associated
> > > with the core is no longer possible. So a lock should not be needed here.
> > >
> > > I am curious - did you experience a scenario which made you believe
> > > that you need the lock ?
> > >
> >
> > No I did not experience. While offlining this core, we can possibly unload
> the whole module..
> > That's the thought with which I included the lock.
> >
> Protecting tdata won't help in that case, though. You would need to protect
> pdata.
> If I understand you correctly, you are concerned that coretemp_remove_core()
> can be called from both coretemp_remove() and from put_core_offline().

Yes..Exactly this is my concern.

> 
> I don't think that can happen, since the notifier function is removed before
> the platform devices are unregistered. 

...got it...Shall remove this unnecessary mutex and roll out v7 soon..

Thanks,
Durga


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
