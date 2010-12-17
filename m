From: Fenghua Yu <fenghua.yu@intel.com>
Date: Fri, 17 Dec 2010 18:17:09 +0000
Subject: Re: [lm-sensors] [Patch]Adding_threshold_support_to_coretemp
Message-Id: <20101217181709.GA6734@linux-os.sc.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <D6D887BA8C9DFF48B5233887EF04654105C117387C@bgsmsx502.gar.corp.intel.com>
In-Reply-To: <D6D887BA8C9DFF48B5233887EF04654105C117387C@bgsmsx502.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Dec 17, 2010 at 09:15:46AM -0800, Guenter Roeck wrote:
> On Fri, Dec 17, 2010 at 12:56:15AM -0500, R, Durgadoss wrote:
> > Hi,
> > 
> > I am submitting a patch to enable core thermal threshold
> > Support to coretemp.c. There are two core thermal thresholds
> > available through sysfs interfaces temp1_max and temp1_min.
> > 
> > The expectation is that _min is lesser than the current temperature
> > and _max is higher than the current temperature. Whenever the current
> > temperature crosses these limits, an interrupt is generated.
> > 
> > This patch is generated against stable Linux-2.6 kernel.
> > 
> > As per Guenter's earlier comments the ABI names are changed to
> > _max and _min.
> > 
> > Kindly review and merge.
> > ------------------------------------------------------------------
> > From: Durgadoss R <durgadoss.r@intel.com>
> > 
> > Date: Thu, 16 Dec 2010 23:09:54 +0530
> > Subject: [PATCH] Adding_threshold_support_to_coretemp
> > 
> > This patch adds the core thermal threshold support to coretemp.c.
> > These thresholds can be read/written using the sysfs interface
> > temp1_max and temp1_min. These can be used to generate interrupts,
> > to do dynamic power management.
> > 
> > Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> > 
> > ---
> Ok, trying to go to the merits.
> 
> Couple of generic comments.
> 
> First, it is customary to add comments here, after the --- line.
> This ensures that the comments are not committed.
> 
> Second, it is customary to add a version log here. This helps reviewers to track
> changes between versions.
> 
> >  Documentation/hwmon/coretemp     |    6 ++
> >  arch/x86/include/asm/msr-index.h |   12 ++++
> >  drivers/hwmon/coretemp.c         |  118 +++++++++++++++++++++++++++++++++++---
> >  3 files changed, 127 insertions(+), 9 deletions(-)
> > 
> > diff --git a/Documentation/hwmon/coretemp b/Documentation/hwmon/coretemp
> > index 25568f8..096cd8b 100644
> > --- a/Documentation/hwmon/coretemp
> > +++ b/Documentation/hwmon/coretemp
> > @@ -29,6 +29,12 @@ the Out-Of-Spec bit. Following table summarizes the exported sysfs files:
> >  
> >  temp1_input	 - Core temperature (in millidegrees Celsius).
> >  temp1_max	 - All cooling devices should be turned on (on Core2).
> > +		   If the IA32_TEMPERATURE_TARGET is not supported, this
> > +		   value indicates the higher core threshold. When the CPU
> > +		   temperature crosses this temperature, an interrupt is
> > +		   generated.
The temp1_max explanation is confusing. This is not what your code is doing. 
If both IA32_TEMPERATURE_TARGET and threshold are supported (most likely in
new processors), this explanation goes nowhere.

> > +temp1_min	 - Indicates the lower threshold of the core. An interrupt is
> > +		   generated when CPU temperature crosses this threshold.

Guenter and Durgadoss, I don't want to discuss this back and forth. But can we
use temp1_max_alarm and temp1_min_alarm as the threshold interfaces? Seems they
are existing interfaces and won't chang legacy temp1_max meaning in coretemp?

> 
> What is supposed to happen if this threshold is reached ? Does it mean "it is too cold",
> or does it mean "it is ok to turn off some of the cooling devices which were turned on earlier" ?
> 
> If it means "it is too cold", question is what the system is supposed to do about it.
> I am not sure if such a use would be of much value.
> 
> If it means "it is no longer too hot", the atribute name should really be temp1_max_threshold.
> 
> >  temp1_crit	 - Maximum junction temperature (in millidegrees Celsius).
> >  temp1_crit_alarm - Set when Out-of-spec bit is set, never clears.
> >  		   Correct CPU operation is no longer guaranteed.
> > diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> > index 3ea3dc4..31cefad 100644
> > --- a/arch/x86/include/asm/msr-index.h
> > +++ b/arch/x86/include/asm/msr-index.h
> > @@ -253,6 +253,18 @@
> >  #define PACKAGE_THERM_INT_LOW_ENABLE		(1 << 1)
> >  #define PACKAGE_THERM_INT_PLN_ENABLE		(1 << 24)
> >  
> > +/* Thermal Thresholds Support */
> > +#define THERM_INT_THRESHOLD0_ENABLE    (1 << 15)
> > +#define THERM_OFFSET_THRESHOLD0        8
> > +#define THERM_MASK_THRESHOLD0          (0x7f << THERM_OFFSET_THRESHOLD0)
> > +#define THERM_INT_THRESHOLD1_ENABLE    (1 << 23)
> > +#define THERM_OFFSET_THRESHOLD1        16
> > +#define THERM_MASK_THRESHOLD1          (0x7f << THERM_OFFSET_THRESHOLD1)
> 
> OFFSET should be named SHIFT, since that is what it is.
> 
> > +#define THERM_STATUS_THRESHOLD0        (1 << 6)
> > +#define THERM_LOG_THRESHOLD0           (1 << 7)
> > +#define THERM_STATUS_THRESHOLD1        (1 << 8)
> > +#define THERM_LOG_THRESHOLD1           (1 << 9)
> > +
> 
> You might want to merge those defines with the already existing defines 
> in msr-index.h. Also, the THERM_STATUS_xxx and THERM_LOG_xxx defines are
> not used anywhere. If you don't plan to use them, please remove.
> 
> On the other side, you might be able to use them for supporting temp1_max_alarm.
> Please consider adding that attribute if it can be supported.
> 
> >  /* MISC_ENABLE bits: architectural */
> >  #define MSR_IA32_MISC_ENABLE_FAST_STRING	(1ULL << 0)
> >  #define MSR_IA32_MISC_ENABLE_TCC		(1ULL << 1)
> > diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> > index 42de98d..30d873e 100644
> > --- a/drivers/hwmon/coretemp.c
> > +++ b/drivers/hwmon/coretemp.c
> > @@ -39,7 +39,7 @@
> >  
> >  #define DRVNAME	"coretemp"
> >  
> > -typedef enum { SHOW_TEMP, SHOW_TJMAX, SHOW_TTARGET, SHOW_LABEL,
> > +typedef enum { SHOW_TEMP, SHOW_TJMAX, SHOW_TTARGET, SHOW_TMIN, SHOW_LABEL,
> >  		SHOW_NAME } SHOW;
> >  
> Please remove the "typedef" here; it causes a checkpatch warning.
> Also, "SHOW_xxx" is no longer appropriate since at least some of the attributes
> can be written. Maybe use CORE_xxx or something else that doesn't imply "SHOW".
> 
> >  /*
> > @@ -59,9 +59,11 @@ struct coretemp_data {
> >  	int temp;
> >  	int tjmax;
> >  	int ttarget;
> > +	int tmin;
> >  	u8 alarm;
> >  };
> >  
> > +static int set_core_threshold(struct coretemp_data *data, int val, int indx);
> 
> I dislike forward declarations, but there is already another one ... oh well.
> 
> >  /*
> >   * Sysfs stuff
> >   */
> > @@ -99,17 +101,37 @@ static ssize_t show_temp(struct device *dev,
> >  		err = data->valid ? sprintf(buf, "%d\n", data->temp) : -EAGAIN;
> >  	else if (attr->index = SHOW_TJMAX)
> >  		err = sprintf(buf, "%d\n", data->tjmax);
> > -	else
> > +	else if (attr->index = SHOW_TTARGET)
> >  		err = sprintf(buf, "%d\n", data->ttarget);
> > +	else
> > +		err = sprintf(buf, "%d\n", data->tmin);
> >  	return err;
> >  }
> >  
> > +static ssize_t store_temp(struct device *dev,
> > +		struct device_attribute *devattr, const char *buf, size_t count)
> > +{
> > +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> > +	struct coretemp_data *data = coretemp_update_device(dev);
> > +	unsigned long val;
> > +	int err;
> > +
> > +	if (strict_strtoul(buf, 10, &val))
> > +		return -EINVAL;
> > +
> > +	err = set_core_threshold(data, val, attr->index);
> > +
> > +	return (err) ? -EINVAL : count;
> 
> Better
> 	if (err)
> 		return err;
> 	return count;
> 
> or 
> 	return err ? err : count;
> 
> No reason to drop the error value returned from set_core_threshold().
> 
> > +}
> > +
> >  static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL,
> >  			  SHOW_TEMP);
> >  static SENSOR_DEVICE_ATTR(temp1_crit, S_IRUGO, show_temp, NULL,
> >  			  SHOW_TJMAX);
> > -static SENSOR_DEVICE_ATTR(temp1_max, S_IRUGO, show_temp, NULL,
> > -			  SHOW_TTARGET);
> > +static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp,
> > +						store_temp, SHOW_TTARGET);
> > +static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO, show_temp,
> > +						store_temp, SHOW_TMIN);
> >  static DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_alarm, NULL);
> >  static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, show_name, NULL, SHOW_LABEL);
> >  static SENSOR_DEVICE_ATTR(name, S_IRUGO, show_name, NULL, SHOW_NAME);
> > @@ -120,6 +142,8 @@ static struct attribute *coretemp_attributes[] = {
> >  	&dev_attr_temp1_crit_alarm.attr,
> >  	&sensor_dev_attr_temp1_input.dev_attr.attr,
> >  	&sensor_dev_attr_temp1_crit.dev_attr.attr,
> > +	&sensor_dev_attr_temp1_max.dev_attr.attr,
> > +	&sensor_dev_attr_temp1_min.dev_attr.attr,
> >  	NULL
> >  };
> >  
> > @@ -298,6 +322,76 @@ static void __devinit get_ucode_rev_on_cpu(void *edx)
> >  	rdmsr(MSR_IA32_UCODE_REV, eax, *(u32 *)edx);
> >  }
> >  
> > +static void configure_apic(void *info)
> > +{
> > +	u32 l;
> > +	int *flag = (int *)info;
> > +
> > +	l = apic_read(APIC_LVTTHMR);
> > +
> > +	if (*flag)	/* Non-Zero flag Masks the APIC */
> > +		apic_write(APIC_LVTTHMR, l | APIC_LVT_MASKED);
> > +	else		/* Zero flag UnMasks the APIC */
> > +		apic_write(APIC_LVTTHMR, l & ~APIC_LVT_MASKED);
> > +}
> > +
> > +static int set_core_threshold(struct coretemp_data *data, int temp, int thres)
> > +{
> > +	u32 eax, edx;
> > +	int diff;
> > +	int flag = 1;
> > +
> > +	if (temp > data->tjmax)
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&data->update_lock);
> > +
> > +	diff = (data->tjmax - temp)/1000;
> > +
> > +	/* Mask the APIC */
> > +	smp_call_function_single(data->id, &configure_apic, &flag, 1);
> > +
> > +	rdmsr_on_cpu(data->id, MSR_IA32_THERM_INTERRUPT, &eax, &edx);
> > +
> > +	if (thres = SHOW_TMIN) {
> > +		eax = (eax & ~THERM_MASK_THRESHOLD0) |
> > +					(diff << THERM_OFFSET_THRESHOLD0);
> > +		data->tmin = temp;
> > +	} else {
> > +		eax = (eax & ~THERM_MASK_THRESHOLD1) |
> > +					(diff << THERM_OFFSET_THRESHOLD1);
> > +		data->ttarget = temp;
> > +	}
> > +
> > +	wrmsr_on_cpu(data->id, MSR_IA32_THERM_INTERRUPT, eax, edx);
> > +
> > +	/* Unmask the APIC */
> > +	flag = 0;
> > +	smp_call_function_single(data->id, &configure_apic, &flag, 1);
> > +
> > +	mutex_unlock(&data->update_lock);
> > +	return 0;
> > +}
> > +
> > +static int __devinit enable_thresh_support(struct coretemp_data *data)
> > +{
> > +	u32 eax, edx;
> > +	int flag = 1; /* Non-Zero Flag masks the apic */
> > +
> > +	smp_call_function_single(data->id, &configure_apic, &flag, 1);
> > +
> > +	rdmsr_on_cpu(data->id, MSR_IA32_THERM_INTERRUPT, &eax, &edx);
> > +
> > +	eax |= (THERM_INT_THRESHOLD0_ENABLE | THERM_INT_THRESHOLD1_ENABLE);
> > +
> > +	wrmsr_on_cpu(data->id, MSR_IA32_THERM_INTERRUPT, eax, edx);
> > +
> If you enable the interrupt here, but there is no interrupt service routine registered for it,
> what exactly will happen ?
> 
> > +	flag = 0; /*Flag should be zero to unmask the apic */
> > +	smp_call_function_single(data->id, &configure_apic, &flag, 1);
> > +
> > +	return 0;
> > +}
> > +
> >  static int __devinit coretemp_probe(struct platform_device *pdev)
> >  {
> >  	struct coretemp_data *data;
> > @@ -353,10 +447,21 @@ static int __devinit coretemp_probe(struct platform_device *pdev)
> >  	data->tjmax = get_tjmax(c, data->id, &pdev->dev);
> >  	platform_set_drvdata(pdev, data);
> >  
> > +	/* Enable threshold support */
> > +	enable_thresh_support(data);
> > +
> Does this work for all Intel CPUs ? If not, you will need to check
> for the CPU revision and enable the functionality only if supported.
> 
> You should only call this function _after_ the thresholds are initialized.
> 
> > +	/* Set Initial Core thresholds.
> > +	 * The lower and upper threshold values here are assumed
> > +	 */
> > +	set_core_threshold(data, 0, SHOW_TMIN);
> > +	set_core_threshold(data, 90000, SHOW_TTARGET);
> > +
> Those functions should only be called after the initial value of ttarget 
> is known, and that value should be used to set the upper threshold.
> Otherwise, the threshold is set to one value but reading temp1_max 
> may return something completely different. Also, please make sure that the
> upper threshold does not exceed tjmax.
> 
> >  	/*
> >  	 * read the still undocumented IA32_TEMPERATURE_TARGET. It exists
> >  	 * on older CPUs but not in this register,
> >  	 * Atoms don't have it either.
> > +	 * If this register is not supported, then ttarget has the value
> > +	 * of upper core threshold, set by set_core_threshold;
> >  	 */
> >  
> >  	if ((c->x86_model > 0xe) && (c->x86_model != 0x1c)) {
> > @@ -368,10 +473,6 @@ static int __devinit coretemp_probe(struct platform_device *pdev)
> >  		} else {
> >  			data->ttarget = data->tjmax -
> >  					(((eax >> 8) & 0xff) * 1000);
> > -			err = device_create_file(&pdev->dev,
> > -					&sensor_dev_attr_temp1_max.dev_attr);
> > -			if (err)
> > -				goto exit_free;
> >  		}
> You probably want to set ttarget to some other known value if it can not be read
> from the CPU, such as to tjmax.
> 
> The error case here does not disable the interrupt. Please add.
> 
> >  	}
> >  
> > @@ -404,7 +505,6 @@ static int __devexit coretemp_remove(struct platform_device *pdev)
> >  
> >  	hwmon_device_unregister(data->hwmon_dev);
> >  	sysfs_remove_group(&pdev->dev.kobj, &coretemp_group);
> > -	device_remove_file(&pdev->dev, &sensor_dev_attr_temp1_max.dev_attr);
> >  	platform_set_drvdata(pdev, NULL);
> >  	kfree(data);
> 
> You should also disable the interrupt here.

Maybe it does make sense to have the interrupt handling in coretemp. Put it in
therm_throt.c isn't good because this is not throttling. And seems the
threshold interrupt handling is only used for this coretemp which handles r/w
the threshold values already. The interrupt handler has close dependency on
coretemp. If coretemp is not running, the interrupt handler shouldn't run. I'm not in a position to make this judgement either. 

> 
> >  	return 0;
> > -- 
> > 1.6.5.2
> > 
> 
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
