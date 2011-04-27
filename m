From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 27 Apr 2011 14:31:12 +0000
Subject: Re: [lm-sensors] Patch v5 Merge Pkgtemp with coretemp
Message-Id: <20110427143112.GA23165@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <D6D887BA8C9DFF48B5233887EF046541095182D2CC@bgsmsx502.gar.corp.intel.com>
In-Reply-To: <D6D887BA8C9DFF48B5233887EF046541095182D2CC@bgsmsx502.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Durga,

On Wed, Apr 27, 2011 at 02:24:19AM -0400, R, Durgadoss wrote:
> Hi Guenter,
> 
> Thanks for the comments.
> Shall fix them and resubmit the patch.
> But, I need clarifications on few things here.
> 
> > 
> > Functionality-wise, there is still a problem: If one core of a HT CPU
> > is taken offline, the driver used to replace it with its sibling if
> > it was online. This way the core's temperature was still displayed as
> > long as at least one of the HT cores was online. This is no longer the case.
> 
> I knew it..but I was thinking to do it as a separate patch,
> Once this gets acked. If we have to add this support, the following is
> my way of doing it:
> When a cpu with a core_id is offlined,
> check whether there is any other cpu with same core_id(by looping
> through for_each_online_cpu()). If so, get that online.
> Please let me know if there are any alternatives.
> 
The original code (which you deleted) handled that case pretty well.

	for_each_cpu(i, cpu_sibling_mask(cpu))
		if (i != cpu && !coretemp_device_add(i))
			break;

> > You should update Documentation/hwmon/coretemp to reflect your changes.
> 
> Should that be a separate patch or part of this patch ?
> 
Part of this patch.

> > > +       /*
> > > +        * Initialize ttarget value. Eventually this will be
> > > +        * initialized with the value from MSR_IA32_THERM_INTERRUPT
> > > +        * register. If IA32_TEMPERATURE_TARGET is supported, this
> > > +        * value will be over written below.
> > > +        * To Do: Patch to initialize ttarget from MSR_IA32_THERM_INTERRUPT
> > > +        */
> > Do you plan to submit a separate patch to address this ?
> 
> Yes. I already submitted a patch for this. Since we wanted any new patch
> On coretemp should be done only after merging pkgtemp, I withheld that patch.
> 
Maybe it wouild make sense to mention that in your intro (not part of the commit log).

> > >         for_each_online_cpu(i)
> > > -               coretemp_device_add(i);
> > > +               get_core_online(i);
> > >
> > This code should now be in the probe function, and be called before
> > the hwmon device is registered.
> 
> Our probe function itself is called by coretemp_device_add()
> which in turn is called by get_core_online(). So, If I move this code
> to probe, not sure how the probe itself will be called. Hence, I feel
> this code should be here only. Let me know your thoughts.
> 
Problem is that get_core_online() handles both adding a new processor and adding
a new core, which results in a lot of if statements and isn't really clean.

Maybe you can separate adding processors (or platform devices), which needs to be 
handled from the _init function, and adding cores, which should be handled from within 
the platform device, ie from the _probe function. This way, the _init function would
only create the platform devices (one per processor), and the _probe function would
initialize the per-processor information, create the package sensor attributes, create
the core attributes, and finally register with hwmon.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
