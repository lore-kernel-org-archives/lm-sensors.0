From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 05 Jul 2011 19:58:19 +0000
Subject: Re: [lm-sensors] [PATCHv3 1/1] Hwmon: Add core_pkg Threshold
Message-Id: <20110705195819.GA29844@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1309885334-16106-1-git-send-email-durgadoss.r@intel.com>
In-Reply-To: <1309885334-16106-1-git-send-email-durgadoss.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Durgadoss,

On Tue, Jul 05, 2011 at 01:02:14PM -0400, Durgadoss R wrote:
> This patch adds the core and pkg support to coretemp.
> These thresholds can be configured via the sysfs interfaces tempX_max
> and tempX_max_hyst. An interrupt is generated when CPU temperature reaches
> or crosses above tempX_max OR drops below tempX_max_hyst.
> 
> This patch is based on the documentation in IA Manual vol 3A, that can be
> downloaded from here:
> http://download.intel.com/design/processor/manuals/253668.pdf
> 
> Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> ---
>  Documentation/hwmon/coretemp |    7 ++
>  drivers/hwmon/coretemp.c     |  171 +++++++++++++++++++++++++++++++-----------
>  2 files changed, 133 insertions(+), 45 deletions(-)
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
> index de3d246..4aec5f3 100644
> --- a/drivers/hwmon/coretemp.c
> +++ b/drivers/hwmon/coretemp.c
> @@ -44,7 +44,9 @@
>  #define BASE_SYSFS_ATTR_NO	2	/* Sysfs Base attr no for coretemp */
>  #define NUM_REAL_CORES		16	/* Number of Real cores per cpu */
>  #define CORETEMP_NAME_LENGTH	17	/* String Length of attrs */
> -#define MAX_ATTRS		5	/* Maximum no of per-core attrs */
> +#define MAX_CORE_ATTRS		4	/* Maximum no of basic attrs */
> +#define MAX_THRESH_ATTRS	3	/* Maximum no of Threshold attrs */
> +#define TOTAL_ATTRS		(MAX_CORE_ATTRS + MAX_THRESH_ATTRS)
>  #define MAX_CORE_DATA		(NUM_REAL_CORES + BASE_SYSFS_ATTR_NO)
>  
>  #ifdef CONFIG_SMP
> @@ -67,6 +69,9 @@
>   *		This value is passed as "id" field to rdmsr/wrmsr functions.
>   * @status_reg: One of IA32_THERM_STATUS or IA32_PACKAGE_THERM_STATUS,
>   *		from where the temperature values should be read.
> + * @intrpt_reg: One of IA32_THERM_INTERRUPT or IA32_PACKAGE_THERM_INTERRUPT,
> + *		from where the thresholds are read.
> + * @attr_size:  Total number of pre-core attrs displayed in the sysfs.
>   * @is_pkg_data: If this is 1, the temp_data holds pkgtemp data.
>   *		Otherwise, temp_data holds coretemp data.
>   * @valid: If this is 1, the current temperature is valid.
> @@ -74,15 +79,18 @@
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
> +	int attr_size;
>  	bool is_pkg_data;
>  	bool valid;
> -	struct sensor_device_attribute sd_attrs[MAX_ATTRS];
> -	char attr_name[MAX_ATTRS][CORETEMP_NAME_LENGTH];
> +	struct sensor_device_attribute sd_attrs[TOTAL_ATTRS];
> +	char attr_name[TOTAL_ATTRS][CORETEMP_NAME_LENGTH];
>  	struct mutex update_lock;
>  };
>  
> @@ -137,6 +145,19 @@ static ssize_t show_crit_alarm(struct device *dev,
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
> +	return sprintf(buf, "%d\n", !!(eax & THERM_LOG_THRESHOLD1));
> +}
> +
>  static ssize_t show_tjmax(struct device *dev,
>  			struct device_attribute *devattr, char *buf)
>  {
> @@ -155,6 +176,77 @@ static ssize_t show_ttarget(struct device *dev,
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
> +	/* THERM_MASK_THRESHOLD1 is 7 bits wide. So don't accept val > 127 */
> +	if (val > tdata->tjmax || val > 127)

This needs to be 127000, since val is in mill-degrees C.

> +		return -EINVAL;
> +
> +	diff = (tdata->tjmax - val) / 1000;
> +
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
> +	/* THERM_MASK_THRESHOLD0 is 7 bits wide. So don't accept val > 127 */
> +	if (val > tdata->tjmax || val > 127)

Same here.

Other observations:

I tested the patch on two systems (Sandy Bridge and Xeon C5528). On both, critical
temperature and max temperatures are the same. tempX_max_hyst is 0 in both cases.
Is this as expected ?

It is possible to set tempX_max_hyst to a value >= tempX_max. Not sure if this makes sense.

I can trigger max_alarm by setting the max temperature below the current temperature.
However, I seem to be unable to reset the alarm flag; it looks like once it is set,
it stays set forever. That may be because I am triggering the alarm by reducing
the max limit, but one should assume that the flag is reset once all limits
are set to values above the current temperature. What is the expected behavior,
and how can the alarm flag be reset ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
