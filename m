From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 21 Sep 2011 19:56:40 +0000
Subject: Re: [lm-sensors] [PATCH v3 1/2] hwmon: (coretemp) Don't use
Message-Id: <20110921215640.1c03a550@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1316536503-26883-2-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1316536503-26883-2-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Tue, 20 Sep 2011 09:35:02 -0700, Guenter Roeck wrote:
> With commit c814a4c7c4aad795835583344353963a0a673eb0, the meaning of tempX_max
> was changed. It no longer returns the value of the undocumented register
> MSR_IA32_TEMPERATURE_TARGET, but instead returns the value of CPU threshold
> register T1. tempX_max_hyst was added to reflect the value of temperature
> threshold register T0.

For completeness, register MSR_IA32_TEMPERATURE_TARGET is not
completely undocumented. The register itself is listed by now and bits
23:16 are documented. The undocumented bits we are using are 15:8.

> As it turns out, T0 and T1 are used on some systems, presumably by the BIOS.
> Also, T0 and T1 don't have a well defined meaning. The thresholds may be used
> as upper or lower limits, and it is not guaranteed that T0 <= T1. Thus, the new
> attribute mapping does not reflect the actual usage of the threshold registers.
> Also, register contents are changed during runtime by an entity other than the
> hwmon driver, meaning the values cached by the driver do not reflect actual
> register contents.
> 
> Revert most of c814a4c7c4aad795835583344353963a0a673eb0 to address the problem.
> Support for T0 and T1 will be added back in with a separate commit, using new
> attribute names.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
>  Documentation/hwmon/coretemp |    7 --
>  drivers/hwmon/coretemp.c     |  134 ++++-------------------------------------
>  2 files changed, 13 insertions(+), 128 deletions(-)
> 
> diff --git a/Documentation/hwmon/coretemp b/Documentation/hwmon/coretemp
> index 49c0d42..84d46c0 100644
> --- a/Documentation/hwmon/coretemp
> +++ b/Documentation/hwmon/coretemp
> @@ -35,13 +35,6 @@ the Out-Of-Spec bit. Following table summarizes the exported sysfs files:
>  All Sysfs entries are named with their core_id (represented here by 'X').
>  tempX_input	 - Core temperature (in millidegrees Celsius).
>  tempX_max	 - All cooling devices should be turned on (on Core2).
> -		   Initialized with IA32_THERM_INTERRUPT. When the CPU
> -		   temperature reaches this temperature, an interrupt is
> -		   generated and tempX_max_alarm is set.
> -tempX_max_hyst   - If the CPU temperature falls below than temperature,
> -		   an interrupt is generated and tempX_max_alarm is reset.
> -tempX_max_alarm  - Set if the temperature reaches or exceeds tempX_max.
> -		   Reset if the temperature drops to or below tempX_max_hyst.
>  tempX_crit	 - Maximum junction temperature (in millidegrees Celsius).
>  tempX_crit_alarm - Set when Out-of-spec bit is set, never clears.
>  		   Correct CPU operation is no longer guaranteed.
> diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> index 5a41e9d..7b1035e 100644
> --- a/drivers/hwmon/coretemp.c
> +++ b/drivers/hwmon/coretemp.c
> @@ -54,8 +54,7 @@ MODULE_PARM_DESC(tjmax, "TjMax value in degrees Celsius");
>  #define NUM_REAL_CORES		16	/* Number of Real cores per cpu */
>  #define CORETEMP_NAME_LENGTH	17	/* String Length of attrs */
>  #define MAX_CORE_ATTRS		4	/* Maximum no of basic attrs */
> -#define MAX_THRESH_ATTRS	3	/* Maximum no of Threshold attrs */
> -#define TOTAL_ATTRS		(MAX_CORE_ATTRS + MAX_THRESH_ATTRS)
> +#define TOTAL_ATTRS		(MAX_CORE_ATTRS + 1)
>  #define MAX_CORE_DATA		(NUM_REAL_CORES + BASE_SYSFS_ATTR_NO)
>  
>  #ifdef CONFIG_SMP
> @@ -78,8 +77,6 @@ MODULE_PARM_DESC(tjmax, "TjMax value in degrees Celsius");
>   *		This value is passed as "id" field to rdmsr/wrmsr functions.
>   * @status_reg: One of IA32_THERM_STATUS or IA32_PACKAGE_THERM_STATUS,
>   *		from where the temperature values should be read.
> - * @intrpt_reg: One of IA32_THERM_INTERRUPT or IA32_PACKAGE_THERM_INTERRUPT,
> - *		from where the thresholds are read.
>   * @attr_size:  Total number of pre-core attrs displayed in the sysfs.
>   * @is_pkg_data: If this is 1, the temp_data holds pkgtemp data.
>   *		Otherwise, temp_data holds coretemp data.
> @@ -88,13 +85,11 @@ MODULE_PARM_DESC(tjmax, "TjMax value in degrees Celsius");
>  struct temp_data {
>  	int temp;
>  	int ttarget;
> -	int tmin;
>  	int tjmax;
>  	unsigned long last_updated;
>  	unsigned int cpu;
>  	u32 cpu_core_id;
>  	u32 status_reg;
> -	u32 intrpt_reg;
>  	int attr_size;
>  	bool is_pkg_data;
>  	bool valid;
> @@ -152,19 +147,6 @@ static ssize_t show_crit_alarm(struct device *dev,
>  	return sprintf(buf, "%d\n", (eax >> 5) & 1);
>  }
>  
> -static ssize_t show_max_alarm(struct device *dev,
> -				struct device_attribute *devattr, char *buf)
> -{
> -	u32 eax, edx;
> -	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -	struct platform_data *pdata = dev_get_drvdata(dev);
> -	struct temp_data *tdata = pdata->core_data[attr->index];
> -
> -	rdmsr_on_cpu(tdata->cpu, tdata->status_reg, &eax, &edx);
> -
> -	return sprintf(buf, "%d\n", !!(eax & THERM_STATUS_THRESHOLD1));
> -}
> -
>  static ssize_t show_tjmax(struct device *dev,
>  			struct device_attribute *devattr, char *buf)
>  {
> @@ -183,83 +165,6 @@ static ssize_t show_ttarget(struct device *dev,
>  	return sprintf(buf, "%d\n", pdata->core_data[attr->index]->ttarget);
>  }
>  
> -static ssize_t store_ttarget(struct device *dev,
> -				struct device_attribute *devattr,
> -				const char *buf, size_t count)
> -{
> -	struct platform_data *pdata = dev_get_drvdata(dev);
> -	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -	struct temp_data *tdata = pdata->core_data[attr->index];
> -	u32 eax, edx;
> -	unsigned long val;
> -	int diff;
> -
> -	if (strict_strtoul(buf, 10, &val))
> -		return -EINVAL;
> -
> -	/*
> -	 * THERM_MASK_THRESHOLD1 is 7 bits wide. Values are entered in terms
> -	 * of milli degree celsius. Hence don't accept val > (127 * 1000)
> -	 */
> -	if (val > tdata->tjmax || val > 127000)
> -		return -EINVAL;
> -
> -	diff = (tdata->tjmax - val) / 1000;
> -
> -	mutex_lock(&tdata->update_lock);
> -	rdmsr_on_cpu(tdata->cpu, tdata->intrpt_reg, &eax, &edx);
> -	eax = (eax & ~THERM_MASK_THRESHOLD1) |
> -				(diff << THERM_SHIFT_THRESHOLD1);
> -	wrmsr_on_cpu(tdata->cpu, tdata->intrpt_reg, eax, edx);
> -	tdata->ttarget = val;
> -	mutex_unlock(&tdata->update_lock);
> -
> -	return count;
> -}
> -
> -static ssize_t show_tmin(struct device *dev,
> -			struct device_attribute *devattr, char *buf)
> -{
> -	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -	struct platform_data *pdata = dev_get_drvdata(dev);
> -
> -	return sprintf(buf, "%d\n", pdata->core_data[attr->index]->tmin);
> -}
> -
> -static ssize_t store_tmin(struct device *dev,
> -				struct device_attribute *devattr,
> -				const char *buf, size_t count)
> -{
> -	struct platform_data *pdata = dev_get_drvdata(dev);
> -	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -	struct temp_data *tdata = pdata->core_data[attr->index];
> -	u32 eax, edx;
> -	unsigned long val;
> -	int diff;
> -
> -	if (strict_strtoul(buf, 10, &val))
> -		return -EINVAL;
> -
> -	/*
> -	 * THERM_MASK_THRESHOLD0 is 7 bits wide. Values are entered in terms
> -	 * of milli degree celsius. Hence don't accept val > (127 * 1000)
> -	 */
> -	if (val > tdata->tjmax || val > 127000)
> -		return -EINVAL;
> -
> -	diff = (tdata->tjmax - val) / 1000;
> -
> -	mutex_lock(&tdata->update_lock);
> -	rdmsr_on_cpu(tdata->cpu, tdata->intrpt_reg, &eax, &edx);
> -	eax = (eax & ~THERM_MASK_THRESHOLD0) |
> -				(diff << THERM_SHIFT_THRESHOLD0);
> -	wrmsr_on_cpu(tdata->cpu, tdata->intrpt_reg, eax, edx);
> -	tdata->tmin = val;
> -	mutex_unlock(&tdata->update_lock);
> -
> -	return count;
> -}
> -
>  static ssize_t show_temp(struct device *dev,
>  			struct device_attribute *devattr, char *buf)
>  {
> @@ -445,16 +350,11 @@ static int create_core_attrs(struct temp_data *tdata, struct device *dev,
>  	static ssize_t (*rd_ptr[TOTAL_ATTRS]) (struct device *dev,
>  			struct device_attribute *devattr, char *buf) = {
>  			show_label, show_crit_alarm, show_temp, show_tjmax,
> -			show_max_alarm, show_ttarget, show_tmin };
> -	static ssize_t (*rw_ptr[TOTAL_ATTRS]) (struct device *dev,
> -			struct device_attribute *devattr, const char *buf,
> -			size_t count) = { NULL, NULL, NULL, NULL, NULL,
> -					store_ttarget, store_tmin };
> +			show_ttarget };
>  	static const char *names[TOTAL_ATTRS] = {
>  					"temp%d_label", "temp%d_crit_alarm",
>  					"temp%d_input", "temp%d_crit",
> -					"temp%d_max_alarm", "temp%d_max",
> -					"temp%d_max_hyst" };
> +					"temp%d_max" };
>  
>  	for (i = 0; i < tdata->attr_size; i++) {
>  		snprintf(tdata->attr_name[i], CORETEMP_NAME_LENGTH, names[i],
> @@ -462,10 +362,6 @@ static int create_core_attrs(struct temp_data *tdata, struct device *dev,
>  		sysfs_attr_init(&tdata->sd_attrs[i].dev_attr.attr);
>  		tdata->sd_attrs[i].dev_attr.attr.name = tdata->attr_name[i];
>  		tdata->sd_attrs[i].dev_attr.attr.mode = S_IRUGO;
> -		if (rw_ptr[i]) {
> -			tdata->sd_attrs[i].dev_attr.attr.mode |= S_IWUSR;
> -			tdata->sd_attrs[i].dev_attr.store = rw_ptr[i];
> -		}
>  		tdata->sd_attrs[i].dev_attr.show = rd_ptr[i];
>  		tdata->sd_attrs[i].index = attr_no;
>  		err = device_create_file(dev, &tdata->sd_attrs[i].dev_attr);
> @@ -538,8 +434,6 @@ static struct temp_data *init_temp_data(unsigned int cpu, int pkg_flag)
>  
>  	tdata->status_reg = pkg_flag ? MSR_IA32_PACKAGE_THERM_STATUS :
>  							MSR_IA32_THERM_STATUS;
> -	tdata->intrpt_reg = pkg_flag ? MSR_IA32_PACKAGE_THERM_INTERRUPT :
> -						MSR_IA32_THERM_INTERRUPT;
>  	tdata->is_pkg_data = pkg_flag;
>  	tdata->cpu = cpu;
>  	tdata->cpu_core_id = TO_CORE_ID(cpu);
> @@ -591,19 +485,17 @@ static int create_core_data(struct platform_data *pdata,
>  	tdata->tjmax = get_tjmax(c, cpu, &pdev->dev);
>  
>  	/*
> -	 * Test if we can access the intrpt register. If so, increase the
> -	 * 'size' enough to have ttarget/tmin/max_alarm interfaces.
> -	 * Initialize ttarget with bits 16:22 of MSR_IA32_THERM_INTERRUPT
> +	 * Read the still undocumented IA32_TEMPERATURE_TARGET. It exists
> +	 * on older CPUs but not in this register. Atoms don't have it either.
>  	 */
> -	err = rdmsr_safe_on_cpu(cpu, tdata->intrpt_reg, &eax, &edx);
> -	if (!err) {
> -		tdata->attr_size += MAX_THRESH_ATTRS;
> -		tdata->tmin = tdata->tjmax -
> -			      ((eax & THERM_MASK_THRESHOLD0) >>
> -			       THERM_SHIFT_THRESHOLD0) * 1000;
> -		tdata->ttarget = tdata->tjmax -
> -				 ((eax & THERM_MASK_THRESHOLD1) >>
> -				  THERM_SHIFT_THRESHOLD1) * 1000;
> +	if (c->x86_model > 0xe && c->x86_model != 0x1c) {
> +		err = rdmsr_safe_on_cpu(cpu, MSR_IA32_TEMPERATURE_TARGET,
> +					&eax, &edx);
> +		if (!err) {

I would appreciate a debug message on error, so that we can adjust the
tests above as needed. For example I'm not sure if the more recent Atom
series have this register. Furthermore, it might make sense to play it
safe and discard the value if it reads 0 (as I would expect if a CPU
doesn't support these bits.)

> +			tdata->ttarget
> +			  = tdata->tjmax - (((eax >> 8) & 0xff) * 1000);
> +			tdata->attr_size++;
> +		}
>  	}
>  
>  	pdata->core_data[attr_no] = tdata;

Patch tested on a Xeon E5520 and a Core Duo T2600, works OK.

Acked-by: Jean Delvare <khali@linux-fr.org>

(with or without the suggested improvements.)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
