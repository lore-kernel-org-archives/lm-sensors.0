From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 10 Jun 2011 16:31:28 +0000
Subject: Re: [lm-sensors] [PATCHv1 1/1]Hwmon: Add core/pkg Threshold Support
Message-Id: <1307723488.8271.208.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1307721288-7463-1-git-send-email-durgadoss.r@intel.com>
In-Reply-To: <1307721288-7463-1-git-send-email-durgadoss.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Durgadoss,

On Fri, 2011-06-10 at 11:54 -0400, Durgadoss R wrote:
> This patch adds the core and pkg support to coretemp.
> These thresholds can be configured via the sysfs interfaces tempX_max
> and tempX_max_hyst. An interrupt is generated when CPU temperature reaches
> or crosses above tempX_max OR drops below tempX_max_hyst.
> 
> This patch is based on the documentation in sec:14.5 of IA Manual vol 3A,
> that can be downloaded from here:
> http://download.intel.com/design/processor/manuals/253668.pdf
> 
> Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> ---
>  Documentation/hwmon/coretemp |    7 ++
>  drivers/hwmon/coretemp.c     |  135 ++++++++++++++++++++++++++++++++----------
>  2 files changed, 110 insertions(+), 32 deletions(-)
> 
> diff --git a/Documentation/hwmon/coretemp b/Documentation/hwmon/coretemp
> index f85e913..fa8776a 100644
> --- a/Documentation/hwmon/coretemp
> +++ b/Documentation/hwmon/coretemp
> @@ -35,6 +35,13 @@ the Out-Of-Spec bit. Following table summarizes the exported sysfs files:
>  All Sysfs entries are named with their core_id (represented here by 'X').
>  tempX_input	 - Core temperature (in millidegrees Celsius).
>  tempX_max	 - All cooling devices should be turned on (on Core2).
> +		   Initialized with IA32_THERM_INTERRUPT. When the CPU
> +		   temperature reaches this temperature, an interrupt is
> +		   generated and tempX_max_alarm is set.
> +tempX_max_hyst   - If the CPU temperature falls below than temperature,
> +		   an interrupt is generated and tempX_max_alarm is reset.
> +tempX_max_alarm  - Set if the temperature reaches or exceeds tempX_max.
> +		   Reset if the temperature drops to or below tempX_max_hyst.
>  tempX_crit	 - Maximum junction temperature (in millidegrees Celsius).
>  tempX_crit_alarm - Set when Out-of-spec bit is set, never clears.
>  		   Correct CPU operation is no longer guaranteed.
> diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> index de3d246..c155ae2 100644
> --- a/drivers/hwmon/coretemp.c
> +++ b/drivers/hwmon/coretemp.c
> @@ -44,7 +44,7 @@
>  #define BASE_SYSFS_ATTR_NO	2	/* Sysfs Base attr no for coretemp */
>  #define NUM_REAL_CORES		16	/* Number of Real cores per cpu */
>  #define CORETEMP_NAME_LENGTH	17	/* String Length of attrs */
> -#define MAX_ATTRS		5	/* Maximum no of per-core attrs */
> +#define MAX_ATTRS		7	/* Maximum no of per-core attrs */
>  #define MAX_CORE_DATA		(NUM_REAL_CORES + BASE_SYSFS_ATTR_NO)
>  
>  #ifdef CONFIG_SMP
> @@ -74,11 +74,13 @@
>  struct temp_data {
>  	int temp;
>  	int ttarget;
> +	int tmin;
>  	int tjmax;
>  	unsigned long last_updated;
>  	unsigned int cpu;
>  	u32 cpu_core_id;
>  	u32 status_reg;
> +	u32 intrpt_reg;
>  	bool is_pkg_data;
>  	bool valid;
>  	struct sensor_device_attribute sd_attrs[MAX_ATTRS];
> @@ -137,6 +139,22 @@ static ssize_t show_crit_alarm(struct device *dev,
>  	return sprintf(buf, "%d\n", (eax >> 5) & 1);
>  }
>  
> +static ssize_t show_max_alarm(struct device *dev,
> +				struct device_attribute *devattr, char *buf)
> +{
> +	u32 eax, edx;
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct platform_data *pdata = dev_get_drvdata(dev);
> +	struct temp_data *tdata = pdata->core_data[attr->index];
> +
> +	rdmsr_on_cpu(tdata->cpu, tdata->status_reg, &eax, &edx);
> +
> +	if (eax & THERM_LOG_THRESHOLD1)
> +		return sprintf(buf, "1\n");
> +
> +	return sprintf(buf, "0\n");

	return sprintf(buf, "%d\n", !!(eax & THERM_LOG_THRESHOLD1));

would be much simpler.

> +}
> +
>  static ssize_t show_tjmax(struct device *dev,
>  			struct device_attribute *devattr, char *buf)
>  {
> @@ -155,6 +173,69 @@ static ssize_t show_ttarget(struct device *dev,
>  	return sprintf(buf, "%d\n", pdata->core_data[attr->index]->ttarget);
>  }
>  
> +static ssize_t store_ttarget(struct device *dev,
> +				struct device_attribute *devattr,
> +				const char *buf, size_t count)
> +{
> +	struct platform_data *pdata = dev_get_drvdata(dev);
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct temp_data *tdata = pdata->core_data[attr->index];
> +	u32 eax, edx;
> +	unsigned long val;
> +	int diff;
> +
> +	if (strict_strtoul(buf, 10, &val))
> +		return -EINVAL;
> +
> +	diff = (tdata->tjmax - val) / 1000;
> +
We need some range checking here. What if val > tjmax ?
Also, THERM_MASK_THRESHOLD1 is 7 bits wide, so you'll never want to
accept a value larger than 127.

> +	mutex_lock(&tdata->update_lock);
> +	rdmsr_on_cpu(tdata->cpu, tdata->intrpt_reg, &eax, &edx);
> +	eax = (eax & ~THERM_MASK_THRESHOLD1) |
> +				(diff << THERM_SHIFT_THRESHOLD1);
> +	wrmsr_on_cpu(tdata->cpu, tdata->intrpt_reg, eax, edx);
> +	tdata->ttarget = val;
> +	mutex_unlock(&tdata->update_lock);
> +
> +	return count;
> +}
> +
> +static ssize_t show_tmin(struct device *dev,
> +			struct device_attribute *devattr, char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct platform_data *pdata = dev_get_drvdata(dev);
> +
> +	return sprintf(buf, "%d\n", pdata->core_data[attr->index]->tmin);
> +}
> +
> +static ssize_t store_tmin(struct device *dev,
> +				struct device_attribute *devattr,
> +				const char *buf, size_t count)
> +{
> +	struct platform_data *pdata = dev_get_drvdata(dev);
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct temp_data *tdata = pdata->core_data[attr->index];
> +	u32 eax, edx;
> +	unsigned long val;
> +	int diff;
> +
> +	if (strict_strtoul(buf, 10, &val))
> +		return -EINVAL;
> +
> +	diff = (tdata->tjmax - val) / 1000;
> +
Again, need to have a range check here.

> +	mutex_lock(&tdata->update_lock);
> +	rdmsr_on_cpu(tdata->cpu, tdata->intrpt_reg, &eax, &edx);
> +	eax = (eax & ~THERM_MASK_THRESHOLD0) |
> +				(diff << THERM_SHIFT_THRESHOLD0);
> +	wrmsr_on_cpu(tdata->cpu, tdata->intrpt_reg, eax, edx);
> +	tdata->tmin = val;
> +	mutex_unlock(&tdata->update_lock);
> +
> +	return count;
> +}
> +
>  static ssize_t show_temp(struct device *dev,
>  			struct device_attribute *devattr, char *buf)
>  {
> @@ -364,11 +445,16 @@ static int create_core_attrs(struct temp_data *tdata, struct device *dev,
>  	static ssize_t (*rd_ptr[MAX_ATTRS]) (struct device *dev,
>  			struct device_attribute *devattr, char *buf) = {
>  			show_label, show_crit_alarm, show_ttarget,
> -			show_temp, show_tjmax };
> +			show_temp, show_tjmax, show_tmin, show_max_alarm };
> +	static ssize_t (*rw_ptr[MAX_ATTRS]) (struct device *dev,
> +			struct device_attribute *devattr, const char *buf,
> +			size_t count) = { NULL, NULL, store_ttarget, NULL,
> +			NULL, store_tmin, NULL };
>  	static const char *names[MAX_ATTRS] = {
>  					"temp%d_label", "temp%d_crit_alarm",
>  					"temp%d_max", "temp%d_input",
> -					"temp%d_crit" };
> +					"temp%d_crit", "temp%d_max_hyst",
> +					"temp%d_max_alarm" };
>  
>  	for (i = 0; i < MAX_ATTRS; i++) {
>  		snprintf(tdata->attr_name[i], CORETEMP_NAME_LENGTH, names[i],
> @@ -376,8 +462,10 @@ static int create_core_attrs(struct temp_data *tdata, struct device *dev,
>  		sysfs_attr_init(&tdata->sd_attrs[i].dev_attr.attr);
>  		tdata->sd_attrs[i].dev_attr.attr.name = tdata->attr_name[i];
>  		tdata->sd_attrs[i].dev_attr.attr.mode = S_IRUGO;
> +		if (rw_ptr[i])
> +			tdata->sd_attrs[i].dev_attr.attr.mode |= S_IWUSR;
>  		tdata->sd_attrs[i].dev_attr.show = rd_ptr[i];
> -		tdata->sd_attrs[i].dev_attr.store = NULL;
> +		tdata->sd_attrs[i].dev_attr.store = rw_ptr[i];
>  		tdata->sd_attrs[i].index = attr_no;
>  		err = device_create_file(dev, &tdata->sd_attrs[i].dev_attr);
>  		if (err)
> @@ -391,37 +479,18 @@ exit_free:
>  	return err;
>  }
>  
> -static void update_ttarget(__u8 cpu_model, struct temp_data *tdata,
> -				struct device *dev)
> +static void get_ttarget(struct temp_data *tdata, struct device *dev)
>  {
>  	int err;
>  	u32 eax, edx;
>  
> -	/*
> -	 * Initialize ttarget value. Eventually this will be
> -	 * initialized with the value from MSR_IA32_THERM_INTERRUPT
> -	 * register. If IA32_TEMPERATURE_TARGET is supported, this
> -	 * value will be over written below.
> -	 * To Do: Patch to initialize ttarget from MSR_IA32_THERM_INTERRUPT
> -	 */
> -	tdata->ttarget = tdata->tjmax - 20000;
> -
> -	/*
> -	 * Read the still undocumented IA32_TEMPERATURE_TARGET. It exists
> -	 * on older CPUs but not in this register,
> -	 * Atoms don't have it either.
> -	 */
> -	if (cpu_model > 0xe && cpu_model != 0x1c) {
> -		err = rdmsr_safe_on_cpu(tdata->cpu,
> -				MSR_IA32_TEMPERATURE_TARGET, &eax, &edx);
> -		if (err) {
> -			dev_warn(dev,
> -			"Unable to read IA32_TEMPERATURE_TARGET MSR\n");
> -		} else {
> -			tdata->ttarget = tdata->tjmax -
> -					((eax >> 8) & 0xff) * 1000;
> -		}
> -	}
> +	/* Initialize ttarget with bits 16:22 of MSR_IA32_THERM_INTERRUPT */
> +	err = rdmsr_safe_on_cpu(tdata->cpu, MSR_IA32_THERM_INTERRUPT,
> +				&eax, &edx);
> +	if (err)
> +		dev_warn(dev, "unable to read MSR_IA32_THERM_INTERRUPT\n");

So ttarget would be 0 in this case ? Doesn't that mean that we should
not provide the max/max_hyst attributes in the first place if that is
the case ?

Also, are you sure that MSR_IA32_THERM_INTERRUPT exists on all CPUs with
temp sensor support, and that the (undocumented)
MSR_IA32_TEMPERATURE_TARGET is no longer needed ?

> +	else
> +		tdata->ttarget = tdata->tjmax - ((eax >> 16) & 0x7f) * 1000;
>  }
>  
>  static int __devinit chk_ucode_version(struct platform_device *pdev)
> @@ -481,6 +550,8 @@ static struct temp_data *init_temp_data(unsigned int cpu, int pkg_flag)
>  
>  	tdata->status_reg = pkg_flag ? MSR_IA32_PACKAGE_THERM_STATUS :
>  							MSR_IA32_THERM_STATUS;
> +	tdata->intrpt_reg = pkg_flag ? MSR_IA32_PACKAGE_THERM_INTERRUPT :
> +						MSR_IA32_THERM_INTERRUPT;
>  	tdata->is_pkg_data = pkg_flag;
>  	tdata->cpu = cpu;
>  	tdata->cpu_core_id = TO_CORE_ID(cpu);
> @@ -533,7 +604,7 @@ static int create_core_data(struct platform_data *pdata,
>  	else
>  		tdata->tjmax = get_tjmax(c, cpu, &pdev->dev);
>  
> -	update_ttarget(c->x86_model, tdata, &pdev->dev);
> +	get_ttarget(tdata, &pdev->dev);
>  	pdata->core_data[attr_no] = tdata;
>  
>  	/* Create sysfs interfaces */



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
