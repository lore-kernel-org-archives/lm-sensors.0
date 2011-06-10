From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Fri, 10 Jun 2011 17:51:02 +0000
Subject: Re: [lm-sensors] [PATCHv1 1/1]Hwmon: Add core/pkg Threshold Support
Message-Id: <D6D887BA8C9DFF48B5233887EF046541095B015113@bgsmsx502.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1307721288-7463-1-git-send-email-durgadoss.r@intel.com>
In-Reply-To: <1307721288-7463-1-git-send-email-durgadoss.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

> > +static ssize_t store_ttarget(struct device *dev,
> > +				struct device_attribute *devattr,
> > +				const char *buf, size_t count)
> > +{
> > +	struct platform_data *pdata = dev_get_drvdata(dev);
> > +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> > +	struct temp_data *tdata = pdata->core_data[attr->index];
> > +	u32 eax, edx;
> > +	unsigned long val;
> > +	int diff;
> > +
> > +	if (strict_strtoul(buf, 10, &val))
> > +		return -EINVAL;
> > +
> > +	diff = (tdata->tjmax - val) / 1000;
> > +
> We need some range checking here. What if val > tjmax ?
> Also, THERM_MASK_THRESHOLD1 is 7 bits wide, so you'll never want to
> accept a value larger than 127.
> 

I will add code to check val > tjmax.

> > +	/* Initialize ttarget with bits 16:22 of MSR_IA32_THERM_INTERRUPT */
> > +	err = rdmsr_safe_on_cpu(tdata->cpu, MSR_IA32_THERM_INTERRUPT,
> > +				&eax, &edx);
> > +	if (err)
> > +		dev_warn(dev, "unable to read MSR_IA32_THERM_INTERRUPT\n");
> 
> So ttarget would be 0 in this case ? Doesn't that mean that we should
> not provide the max/max_hyst attributes in the first place if that is
> the case ?
> 

I completely agree with you. This means in the create_core_data function,
I will add code to check the accessibility of this register. Accordingly,
Will create these two interfaces.

I had thought of this..But all CPUs that have THERM_STATUS register accessible,
Should have this register accessible also, ideally. So, I thought it is
Unlikely that this rdmsr fails. Hence did not bother much about creating
these interfaces.

Anyway, would like to try implementing this change and see how it goes.

> Also, are you sure that MSR_IA32_THERM_INTERRUPT exists on all CPUs with
> temp sensor support, and that the (undocumented)
> MSR_IA32_TEMPERATURE_TARGET is no longer needed ?

Yes..It exists on all CPUs that have THERM_STATUS MSR.
We need MSR_IA32_TEMPERATURE_TARGET just to find TjMax.
Also, I tried my best to find documentation about MSR_IA32_TEMPERATURE_TARGET
but in Vain.

Thanks,
Durga
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
