From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Fri, 17 Dec 2010 17:52:17 +0000
Subject: Re: [lm-sensors] [Patch]Adding_threshold_support_to_coretemp
Message-Id: <D6D887BA8C9DFF48B5233887EF04654105C1173B29@bgsmsx502.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <D6D887BA8C9DFF48B5233887EF04654105C117387C@bgsmsx502.gar.corp.intel.com>
In-Reply-To: <D6D887BA8C9DFF48B5233887EF04654105C117387C@bgsmsx502.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,
Thanks for the comments.
Shall fix them and re-submit the patch.

> What is supposed to happen if this threshold is reached ? Does it mean "it is
> too cold",
> or does it mean "it is ok to turn off some of the cooling devices which were
> turned on earlier" ?
> 
> If it means "it is too cold", question is what the system is supposed to do
> about it.
> I am not sure if such a use would be of much value.
> 
> If it means "it is no longer too hot", the atribute name should really be
> temp1_max_threshold.

It means "it is no longer too hot". So, shall change the name to _max_threshold.

> > +#define THERM_MASK_THRESHOLD1          (0x7f << THERM_OFFSET_THRESHOLD1)
> 
> OFFSET should be named SHIFT, since that is what it is.

Ok.

> You might want to merge those defines with the already existing defines
> in msr-index.h. Also, the THERM_STATUS_xxx and THERM_LOG_xxx defines are
> not used anywhere. If you don't plan to use them, please remove.
> 
> On the other side, you might be able to use them for supporting
> temp1_max_alarm.
> Please consider adding that attribute if it can be supported.

Yes. Shall check with the spec and do.

> >  #define DRVNAME	"coretemp"
> >
> > -typedef enum { SHOW_TEMP, SHOW_TJMAX, SHOW_TTARGET, SHOW_LABEL,
> > +typedef enum { SHOW_TEMP, SHOW_TJMAX, SHOW_TTARGET, SHOW_TMIN, SHOW_LABEL,
> >  		SHOW_NAME } SHOW;
> >
> Please remove the "typedef" here; it causes a checkpatch warning.
> Also, "SHOW_xxx" is no longer appropriate since at least some of the attributes
> can be written. Maybe use CORE_xxx or something else that doesn't imply "SHOW".

The typedef was already there. So I did not remove.
No problems...I can change it in the next submission.

> > +
> > +	wrmsr_on_cpu(data->id, MSR_IA32_THERM_INTERRUPT, eax, edx);
> > +
> If you enable the interrupt here, but there is no interrupt service routine
> registered for it,
> what exactly will happen ?

No harm...it will be just be dropped uncaught...
But in the second patch that I am sending I had a check,
that only if the interrupt handler is defined..interrupt is
Enabled...

> > +	/* Enable threshold support */
> > +	enable_thresh_support(data);
> > +
> Does this work for all Intel CPUs ? If not, you will need to check
> for the CPU revision and enable the functionality only if supported.

Yes.

> > +
> Those functions should only be called after the initial value of ttarget
> is known, and that value should be used to set the upper threshold.
> Otherwise, the threshold is set to one value but reading temp1_max
> may return something completely different. Also, please make sure that the
> upper threshold does not exceed tjmax.

Understood. I shall change it accordingly.

> > -			err = device_create_file(&pdev->dev,
> > -					&sensor_dev_attr_temp1_max.dev_attr);
> > -			if (err)
> > -				goto exit_free;
> >  		}
> You probably want to set ttarget to some other known value if it can not be
> read
> from the CPU, such as to tjmax.
> 
> The error case here does not disable the interrupt. Please add.

Got it. Thanks Guenter. I should have caught this...

Thanks,
Durga

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
