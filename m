From: Fenghua Yu <fenghua.yu@intel.com>
Date: Tue, 31 Aug 2010 17:04:43 +0000
Subject: Re: [lm-sensors] [Patch-next] Trival fixes in
Message-Id: <20100831170443.GA30454@fenghua-desk.sc.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4C75D3C4.6040802@np.css.fujitsu.com> <20100826060822.GA15021@fenghua-desk.sc.intel.com> <4C7625D1.4060201@np.css.fujitsu.com> <20100827152007.27636fa5@hyperion.delvare> <4C7B64A8.2030208@np.css.fujitsu.com> <493994B35A117E4F832F97C4719C4C04A111EEDF@orsmsx505.amr.corp.intel.com> <4C7C5314.7090404@np.css.fujitsu.com> <20100831010251.GA28885@fenghua-desk.sc.intel.com> <20100831090725.5d83eedb@hyperion.delvare>
In-Reply-To: <20100831090725.5d83eedb@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: "Yu, Fenghua" <fenghua.yu@intel.com>, Jin Dongming <jin.dongming@np.css.fujitsu.com>, "Brown, Len" <len.brown@intel.com>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, "H. Peter Anvin" <hpa@linux.jf.intel.com>, LKLM <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, mingo Redhat <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>

On Tue, Aug 31, 2010 at 12:07:25AM -0700, Jean Delvare wrote:
> On Mon, 30 Aug 2010 18:02:52 -0700, Fenghua Yu wrote:
> > On Mon, Aug 30, 2010 at 05:55:48PM -0700, Jin Dongming wrote:
> > > diff --git a/arch/x86/kernel/cpu/mcheck/therm_throt.c b/arch/x86/kernel/cpu/mcheck/therm_throt.c
> > > index d9368ee..79d563a 100644
> > > --- a/arch/x86/kernel/cpu/mcheck/therm_throt.c
> > > +++ b/arch/x86/kernel/cpu/mcheck/therm_throt.c
> > > @@ -216,14 +216,27 @@ static __cpuinit int thermal_throttle_add_dev(struct sys_device *sys_dev,
> > >  		err = sysfs_add_file_to_group(&sys_dev->kobj,
> > >  					      &attr_core_power_limit_count.attr,
> > >  					      thermal_attr_group.name);
> > > -	if (cpu_has(c, X86_FEATURE_PTS))
> > > +	if (err)
> > > +		goto error;
> > > +
> > > +	if (cpu_has(c, X86_FEATURE_PTS)) {
> > >  		err = sysfs_add_file_to_group(&sys_dev->kobj,
> > >  					      &attr_package_throttle_count.attr,
> > >  					      thermal_attr_group.name);
> > > +		if (err)
> > > +			goto error;
> > > +
> > >  		if (cpu_has(c, X86_FEATURE_PLN))
> > >  			err = sysfs_add_file_to_group(&sys_dev->kobj,
> > >  					&attr_package_power_limit_count.attr,
> > >  					thermal_attr_group.name);
> > > +		if (err)
> > > +			goto error;
> > > +	}
> > > +
> > > +	return 0;
> > > +error:
> > > +	sysfs_remove_group(&sys_dev->kobj, &thermal_attr_group);
> > >  
> > >  	return err;
> > >  }
> > 
> > This fix is incorrect. In this patch, a previous error prevents from adding any
> > further devices. There shouldn't be such dependency among the devices.
> 
> I don't quite follow you. Did you mean to write that a previous error
> prevents from creating further _attributes_ for the same device? This
> would be true.
> 
> Now I don't think this is a problem because 1* such errors should never
> happen anyway and 2* if they do happen then further attempts to create
> the other attributes are unlikely to succeed either.

I don't think there is dependency among the count files, i.e. failure to add a
count file to the group shouldn't impact other files. Other filles can still be
added to the group. In this case, user application only sees part of count
numbers. And kernel may just warn on the failure instead of providing nothing
to user.

In the patch, any failure to add a file will remove the whole group. This is
too strict. Kernel doesn't provide any count number to user application.

Agree with you that such errors should never happen anyway. So original code
works fine.

If to be picky to the error handling, a patch may just ignore returning errors
from sysfs_add_file_to_group. Or use err |= sysfs_add_file_to_group to collect
all errors and return err but without calling sysfs_remove_group.

Thanks.

-Fenghua

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
