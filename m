From: Chen Gong <gong.chen@linux.intel.com>
Date: Mon, 13 Dec 2010 03:25:11 +0000
Subject: Re: [lm-sensors] Patch[1/1] Adding Core Thermal Threshold Support
Message-Id: <4D059217.9070905@linux.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <D6D887BA8C9DFF48B5233887EF04654105C1077008@bgsmsx502.gar.corp.intel.com>
In-Reply-To: <D6D887BA8C9DFF48B5233887EF04654105C1077008@bgsmsx502.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: "Yu, Fenghua" <fenghua.yu@intel.com>, "khali@linux-fr.org" <khali@linux-fr.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "lenb@kernel.org" <lenb@kernel.org>

于 12/10/2010 5:30 PM, R, Durgadoss 写道:
> Hi Fenghua/Jean,
>
> I am submitting a patch to enable core thermal threshold
> Support to coretemp.c. There are two core thermal thresholds
> available through sysfs interfaces temp1_core_thresh[0/1].
>
> The expectation is that thresh0 is lesser than the current temperature
> and thresh1 is higher than the current temperature. Whenever the current
> temperature crosses these limits, an interrupt is generated.
> This interrupt is handles by the user space to do power
> Management via CPU throttling, etc..
>
> This patch is generated against stable Linux-2.6 kernel.
>
> Kindly review and merge.
> -------------------------------------------------------------------------
> From: Durgadoss R<durgadoss.r@intel.com>
>
> Date: Fri, 10 Dec 2010 02:16:36 +0530
> Subject: [PATCH] Adding_Threshold_support_to_coretemp
>
> This patch adds the core thermal threshold support to coretemp.c.
> These thresholds can be read/written using the sysfs interface
> temp1_core_thresh[0/1]. These can be used to generate interrupts,
> to do dynamic power management.
>
> Signed-off-by: Durgadoss R<durgadoss.r@intel.com>
>
> ---
>   arch/x86/include/asm/msr-index.h |   12 ++++
>   drivers/hwmon/coretemp.c         |  122 ++++++++++++++++++++++++++++++++++++++
>   2 files changed, 134 insertions(+), 0 deletions(-)
>
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 3ea3dc4..31cefad 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -253,6 +253,18 @@
>   #define PACKAGE_THERM_INT_LOW_ENABLE		(1<<  1)
>   #define PACKAGE_THERM_INT_PLN_ENABLE		(1<<  24)
>
> +/* Thermal Thresholds Support */
> +#define THERM_INT_THRESHOLD0_ENABLE    (1<<  15)
> +#define THERM_OFFSET_THRESHOLD0        8
> +#define THERM_MASK_THRESHOLD0          (0x7f<<  THERM_OFFSET_THRESHOLD0)
> +#define THERM_INT_THRESHOLD1_ENABLE    (1<<  23)
> +#define THERM_OFFSET_THRESHOLD1        16
> +#define THERM_MASK_THRESHOLD1          (0x7f<<  THERM_OFFSET_THRESHOLD1)
> +#define THERM_STATUS_THRESHOLD0        (1<<  6)
> +#define THERM_LOG_THRESHOLD0           (1<<  7)
> +#define THERM_STATUS_THRESHOLD1        (1<<  8)
> +#define THERM_LOG_THRESHOLD1           (1<<  9)
> +
>   /* MISC_ENABLE bits: architectural */
>   #define MSR_IA32_MISC_ENABLE_FAST_STRING	(1ULL<<  0)
>   #define MSR_IA32_MISC_ENABLE_TCC		(1ULL<<  1)
> diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> index 42de98d..fe0699f 100644
> --- a/drivers/hwmon/coretemp.c
> +++ b/drivers/hwmon/coretemp.c
> @@ -42,6 +42,9 @@
>   typedef enum { SHOW_TEMP, SHOW_TJMAX, SHOW_TTARGET, SHOW_LABEL,
>   		SHOW_NAME } SHOW;
>
> +/* C indicates core thermal thresholds */
> +enum thresholds { C_TTHRESH0, C_TTHRESH1} THRESH;
> +
>   /*
>    * Functions declaration
>    */
> @@ -59,9 +62,13 @@ struct coretemp_data {
>   	int temp;
>   	int tjmax;
>   	int ttarget;
> +	int c_tthresh0;
> +	int c_tthresh1;
>   	u8 alarm;
>   };
>
> +static int set_core_threshold(struct coretemp_data *data, int val,
> +						enum thresholds thresh);
>   /*
>    * Sysfs stuff
>    */
> @@ -104,6 +111,41 @@ static ssize_t show_temp(struct device *dev,
>   	return err;
>   }
>
> +static ssize_t show_threshold(struct device *dev,
> +				struct device_attribute *devattr, char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct coretemp_data *data = coretemp_update_device(dev);
> +
> +	if (!data->valid)
> +		return -EINVAL;
> +
> +	switch (attr->index) {
> +	case C_TTHRESH0:
> +		return sprintf(buf, "%d\n", data->c_tthresh0);
> +	case C_TTHRESH1:
> +		return sprintf(buf, "%d\n", data->c_tthresh1);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static ssize_t set_threshold(struct device *dev,
> +		struct device_attribute *devattr, const char *buf, size_t count)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct coretemp_data *data = coretemp_update_device(dev);
> +	unsigned long val;
> +	int err;
> +
> +	if (strict_strtoul(buf, 10,&val))
> +		return -EINVAL;
> +
> +	err = set_core_threshold(data, val, attr->index);
> +
> +	return (err) ? -EINVAL : count;
> +}
> +
>   static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL,
>   			  SHOW_TEMP);
>   static SENSOR_DEVICE_ATTR(temp1_crit, S_IRUGO, show_temp, NULL,
> @@ -114,12 +156,19 @@ static DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_alarm, NULL);
>   static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, show_name, NULL, SHOW_LABEL);
>   static SENSOR_DEVICE_ATTR(name, S_IRUGO, show_name, NULL, SHOW_NAME);
>
> +static SENSOR_DEVICE_ATTR(temp1_core_thresh0, S_IWUSR | S_IRUGO,
> +				show_threshold,	set_threshold, C_TTHRESH0);
> +static SENSOR_DEVICE_ATTR(temp1_core_thresh1, S_IWUSR | S_IRUGO,
> +				show_threshold, set_threshold, C_TTHRESH1);
> +
>   static struct attribute *coretemp_attributes[] = {
>   	&sensor_dev_attr_name.dev_attr.attr,
>   	&sensor_dev_attr_temp1_label.dev_attr.attr,
>   	&dev_attr_temp1_crit_alarm.attr,
>   	&sensor_dev_attr_temp1_input.dev_attr.attr,
>   	&sensor_dev_attr_temp1_crit.dev_attr.attr,
> +	&sensor_dev_attr_temp1_core_thresh0.dev_attr.attr,
> +	&sensor_dev_attr_temp1_core_thresh1.dev_attr.attr,
>   	NULL
>   };
>
> @@ -298,6 +347,66 @@ static void __devinit get_ucode_rev_on_cpu(void *edx)
>   	rdmsr(MSR_IA32_UCODE_REV, eax, *(u32 *)edx);
>   }
>
> +static int set_core_threshold(struct coretemp_data *data, int temp,
> +						enum thresholds thresh)
> +{
> +	u32 eax, edx, l;
> +	int diff;
> +
> +	if (temp>  data->tjmax)
> +		return -EINVAL;
> +
> +	mutex_lock(&data->update_lock);
> +
> +	diff = (data->tjmax - temp)/1000;
> +
> +	/* Mask the thermal vector in the lapic */
> +	l = apic_read(APIC_LVTTHMR);
> +	apic_write(APIC_LVTTHMR, l | APIC_LVT_MASKED);
> +
> +	rdmsr_on_cpu(data->id, MSR_IA32_THERM_INTERRUPT,&eax,&edx);

apic_write and rdmsr_on_cpu maybe don't point to the same CPU.
Maybe it is a potential issue. The below apic_xxx etc. are same situations.

> +
> +	if (thresh = C_TTHRESH0) {
> +		eax = (eax&  ~THERM_MASK_THRESHOLD0) |
> +					(diff<<  THERM_OFFSET_THRESHOLD0);
> +		data->c_tthresh0 = temp;
> +	} else {
> +		eax = (eax&  ~THERM_MASK_THRESHOLD1) |
> +					(diff<<  THERM_OFFSET_THRESHOLD1);
> +		data->c_tthresh1 = temp;
> +	}
> +
> +	wrmsr_on_cpu(data->id, MSR_IA32_THERM_INTERRUPT, eax, edx);
> +
> +	/* Unmask the thermal vector */
> +	l = apic_read(APIC_LVTTHMR);
> +	apic_write(APIC_LVTTHMR, l&  ~APIC_LVT_MASKED);
> +
> +	mutex_unlock(&data->update_lock);
> +	return 0;
> +}
> +
> +static int __devinit enable_thresh_support(struct coretemp_data *data)
> +{
> +	u32 eax, edx, l;
> +
> +	/* Mask the thermal vector in the lapic */
> +	l = apic_read(APIC_LVTTHMR);
> +	apic_write(APIC_LVTTHMR, l | APIC_LVT_MASKED);
> +
> +	rdmsr_on_cpu(data->id, MSR_IA32_THERM_INTERRUPT,&eax,&edx);
> +
> +	eax |= (THERM_INT_THRESHOLD0_ENABLE | THERM_INT_THRESHOLD1_ENABLE);
> +
> +	wrmsr_on_cpu(data->id, MSR_IA32_THERM_INTERRUPT, eax, edx);
> +
> +	/* Unmask the thermal vector */
> +	l = apic_read(APIC_LVTTHMR);
> +	apic_write(APIC_LVTTHMR, l&  ~APIC_LVT_MASKED);
> +
> +	return 0;
> +}
> +
>   static int __devinit coretemp_probe(struct platform_device *pdev)
>   {
>   	struct coretemp_data *data;
> @@ -353,6 +462,15 @@ static int __devinit coretemp_probe(struct platform_device *pdev)
>   	data->tjmax = get_tjmax(c, data->id,&pdev->dev);
>   	platform_set_drvdata(pdev, data);
>
> +	/* Enable threshold support */
> +	enable_thresh_support(data);
> +
> +	/* Set Initial Core thresholds.
> +	 * The lower and upper threshold values here are assumed
> +	 */
> +	set_core_threshold(data, 0, C_TTHRESH0);
> +	set_core_threshold(data, 90000, C_TTHRESH1);
> +
>   	/*
>   	 * read the still undocumented IA32_TEMPERATURE_TARGET. It exists
>   	 * on older CPUs but not in this register,
> @@ -405,6 +523,10 @@ static int __devexit coretemp_remove(struct platform_device *pdev)
>   	hwmon_device_unregister(data->hwmon_dev);
>   	sysfs_remove_group(&pdev->dev.kobj,&coretemp_group);
>   	device_remove_file(&pdev->dev,&sensor_dev_attr_temp1_max.dev_attr);
> +	device_remove_file(&pdev->dev,
> +				&sensor_dev_attr_temp1_core_thresh0.dev_attr);
> +	device_remove_file(&pdev->dev,
> +				&sensor_dev_attr_temp1_core_thresh1.dev_attr);
>   	platform_set_drvdata(pdev, NULL);
>   	kfree(data);
>   	return 0;
>
>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
