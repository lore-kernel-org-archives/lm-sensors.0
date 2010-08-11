From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 11 Aug 2010 06:53:07 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/3] hwmon: (coretemp) update hotplug
Message-Id: <20100811085307.718c2f58@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Wed, 21 Jul 2010 21:09:49 +0800, Chen Gong wrote:
> 于 7/19/2010 5:05 PM, Chen Gong 写道:
> > this patch fixes two errors about hotplug. One is for
> > hotplug notifier. The other is unnecessary driver unregister.
> > Because even none of online cpus supports coretemp, we can't
> > assume new onlined cpu doesn't support it either. If related
> > driver is unregistered there we have no chance to use coretemp
> > from then on.
> >
> > Signed-off-by: Chen Gong<gong.chen@linux.intel.com>
> > ---
> >   drivers/hwmon/coretemp.c |    5 +++++
> >   1 files changed, 5 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> > index 05344af..c05dc91 100644
> > --- a/drivers/hwmon/coretemp.c
> > +++ b/drivers/hwmon/coretemp.c
> > @@ -502,10 +502,13 @@ static int __cpuinit coretemp_cpu_callback(struct notifier_block *nfb,
> >
> >   	switch (action) {
> >   	case CPU_ONLINE:
> > +	case CPU_ONLINE_FROZEN:
> >   	case CPU_DOWN_FAILED:
> > +	case CPU_DOWN_FAILED_FROZEN:
> >   		coretemp_device_add(cpu);
> >   		break;
> >   	case CPU_DOWN_PREPARE:
> > +	case CPU_DOWN_PREPARE_FROZEN:
> >   		coretemp_device_remove(cpu);
> >   		break;
> >   	}
> > @@ -566,7 +569,9 @@ exit_devices_unreg:
> >   	}
> >   	mutex_unlock(&pdev_list_mutex);
> >   exit_driver_unreg:
> > +#ifndef CONFIG_HOTPLUG_CPU
> >   	platform_driver_unregister(&coretemp_driver);
> > +#endif
> >   exit:
> >   	return err;
> >   }
> 
> Hi, Jean
>    what's your opinion for the left part after deleting 
> CPU_ONLINE_FROZEN/CPU_DOWN_FAILED_FROZEN etc ?
> 
>    Is it still reasonable ?

I was on vacation, sorry for the delay. I don't have any opinion on
this other than what I already said. And apparently Andrew is taking
care, thanks Andrew.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
