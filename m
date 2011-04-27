From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Wed, 27 Apr 2011 06:36:19 +0000
Subject: Re: [lm-sensors] Patch v5 Merge Pkgtemp with coretemp
Message-Id: <D6D887BA8C9DFF48B5233887EF04654109518EA46A@bgsmsx502.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <D6D887BA8C9DFF48B5233887EF046541095182D2CC@bgsmsx502.gar.corp.intel.com>
In-Reply-To: <D6D887BA8C9DFF48B5233887EF046541095182D2CC@bgsmsx502.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

Thanks for the comments.
Shall fix them and resubmit the patch.
But, I need clarifications on few things here.

> 
> Functionality-wise, there is still a problem: If one core of a HT CPU
> is taken offline, the driver used to replace it with its sibling if
> it was online. This way the core's temperature was still displayed as
> long as at least one of the HT cores was online. This is no longer the case.

I knew it..but I was thinking to do it as a separate patch,
Once this gets acked. If we have to add this support, the following is
my way of doing it:
When a cpu with a core_id is offlined,
check whether there is any other cpu with same core_id(by looping
through for_each_online_cpu()). If so, get that online.
Please let me know if there are any alternatives.

> You should update Documentation/hwmon/coretemp to reflect your changes.

Should that be a separate patch or part of this patch ?

> > +       /*
> > +        * Initialize ttarget value. Eventually this will be
> > +        * initialized with the value from MSR_IA32_THERM_INTERRUPT
> > +        * register. If IA32_TEMPERATURE_TARGET is supported, this
> > +        * value will be over written below.
> > +        * To Do: Patch to initialize ttarget from MSR_IA32_THERM_INTERRUPT
> > +        */
> Do you plan to submit a separate patch to address this ?

Yes. I already submitted a patch for this. Since we wanted any new patch
On coretemp should be done only after merging pkgtemp, I withheld that patch.

> >         for_each_online_cpu(i)
> > -               coretemp_device_add(i);
> > +               get_core_online(i);
> >
> This code should now be in the probe function, and be called before
> the hwmon device is registered.

Our probe function itself is called by coretemp_device_add()
which in turn is called by get_core_online(). So, If I move this code
to probe, not sure how the probe itself will be called. Hence, I feel
this code should be here only. Let me know your thoughts.

Thanks,
Durga

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
