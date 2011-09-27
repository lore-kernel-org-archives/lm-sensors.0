From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 27 Sep 2011 14:33:59 +0000
Subject: Re: [lm-sensors] [PATCH v3 2/2] hwmon: (coretemp) Add support for
Message-Id: <20110927163359.73d337e2@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1316536503-26883-3-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1316536503-26883-3-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

Again, sorry for the late review.

On Tue, 20 Sep 2011 09:35:03 -0700, Guenter Roeck wrote:
> Add support for T0 and T1 temperature thresholds using the new sysfs ABI
> attributes tempX_thresholdY and tempX_thresholdY_triggered.
> 
> This patch is based on commit c814a4c7c4aad795835583344353963a0a673eb0, which
> was reverted. For details on the threshold registers, see IA Manual vol 3A,
> which can be downloaded from here:
>         http://download.intel.com/design/processor/manuals/253668.pdf
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
>  Documentation/hwmon/coretemp |    8 ++
>  drivers/hwmon/coretemp.c     |  160 +++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 158 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/hwmon/coretemp b/Documentation/hwmon/coretemp
> index 84d46c0..3c8dd70 100644
> --- a/Documentation/hwmon/coretemp
> +++ b/Documentation/hwmon/coretemp
> @@ -35,6 +35,14 @@ the Out-Of-Spec bit. Following table summarizes the exported sysfs files:
>  All Sysfs entries are named with their core_id (represented here by 'X').
>  tempX_input	 - Core temperature (in millidegrees Celsius).
>  tempX_max	 - All cooling devices should be turned on (on Core2).
> +tempX_threshold1 - Reflects value of CPU thermal threshold T0.
> +tempX_threshold1_triggered
> +	         - Reflects status of CPU thermal status register bit 6
> +		   (THERM_STATUS_THRESHOLD0).
> +tempX_threshold2 - Reflects value of CPU thermal threshold T1.
> +tempX_threshold2_triggered
> +	         - Reflects status of CPU thermal status register bit 8
> +		   (THERM_STATUS_THRESHOLD1).

It's questionable whether we want to map the status bits to _triggered
files. I'd rather map the log bits THERM_LOG_THRESHOLD[01] to
_triggered, because these attributes are direction-neutral, and sticky.
The status bits merely show the result of the real-time comparison
between the current temperature and the threshold value, this is
something user-space can compute by itself.

If we really want to expose the status bits, these shouldn't be
considered an alarm (as the thresholds can be used as low or high
temperature limits). _above may be a suitable suffix. But then again
I'm not sure if we really want to expose this.

>  tempX_crit	 - Maximum junction temperature (in millidegrees Celsius).
>  tempX_crit_alarm - Set when Out-of-spec bit is set, never clears.
>  		   Correct CPU operation is no longer guaranteed.
> diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> index 7b1035e..5377041 100644
> --- a/drivers/hwmon/coretemp.c
> +++ b/drivers/hwmon/coretemp.c
> @@ -52,9 +52,10 @@ MODULE_PARM_DESC(tjmax, "TjMax value in degrees Celsius");
>  
>  #define BASE_SYSFS_ATTR_NO	2	/* Sysfs Base attr no for coretemp */
>  #define NUM_REAL_CORES		16	/* Number of Real cores per cpu */
> -#define CORETEMP_NAME_LENGTH	17	/* String Length of attrs */
> -#define MAX_CORE_ATTRS		4	/* Maximum no of basic attrs */
> -#define TOTAL_ATTRS		(MAX_CORE_ATTRS + 1)
> +#define CORETEMP_NAME_LENGTH	33	/* String Length of attrs */
> +#define MAX_CORE_ATTRS		5	/* Maximum no of basic attrs */
> +#define MAX_THRESH_ATTRS	4	/* Maximum no of threshold attrs */
> +#define TOTAL_ATTRS		(MAX_CORE_ATTRS + MAX_THRESH_ATTRS)
>  #define MAX_CORE_DATA		(NUM_REAL_CORES + BASE_SYSFS_ATTR_NO)
>  
>  #ifdef CONFIG_SMP
> @@ -77,6 +78,8 @@ MODULE_PARM_DESC(tjmax, "TjMax value in degrees Celsius");
>   *		This value is passed as "id" field to rdmsr/wrmsr functions.
>   * @status_reg: One of IA32_THERM_STATUS or IA32_PACKAGE_THERM_STATUS,
>   *		from where the temperature values should be read.
> + * @intrpt_reg: One of IA32_THERM_INTERRUPT or IA32_PACKAGE_THERM_INTERRUPT,
> + *		from where the thresholds are read.
>   * @attr_size:  Total number of pre-core attrs displayed in the sysfs.
>   * @is_pkg_data: If this is 1, the temp_data holds pkgtemp data.
>   *		Otherwise, temp_data holds coretemp data.
> @@ -90,6 +93,7 @@ struct temp_data {
>  	unsigned int cpu;
>  	u32 cpu_core_id;
>  	u32 status_reg;
> +	u32 intrpt_reg;
>  	int attr_size;
>  	bool is_pkg_data;
>  	bool valid;
> @@ -147,6 +151,32 @@ static ssize_t show_crit_alarm(struct device *dev,
>  	return sprintf(buf, "%d\n", (eax >> 5) & 1);
>  }
>  
> +static ssize_t show_tx_triggered(struct device *dev,

tx is confusing, it's a common acronym for "transmit" at least in
network drivers. "thresh" or even "threshold" would be way less cryptic.

> +				 struct device_attribute *devattr, char *buf,
> +				 u32 mask)
> +{
> +	u32 eax, edx;
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct platform_data *pdata = dev_get_drvdata(dev);
> +	struct temp_data *tdata = pdata->core_data[attr->index];
> +
> +	rdmsr_on_cpu(tdata->cpu, tdata->status_reg, &eax, &edx);
> +
> +	return sprintf(buf, "%d\n", !!(eax & mask));
> +}
> +
> +static ssize_t show_t0_triggered(struct device *dev,
> +				 struct device_attribute *devattr, char *buf)
> +{
> +	return show_tx_triggered(dev, devattr, buf, THERM_STATUS_THRESHOLD0);
> +}

I don't like this kind of stubs, it's rather inefficient. Maybe it's
time to turn temp_data->sd_attrs to struct sensor_device_attribute_2?
That way you could use attr->nr to differentiate between thresholds.

> +
> +static ssize_t show_t1_triggered(struct device *dev,
> +				 struct device_attribute *devattr, char *buf)
> +{
> +	return show_tx_triggered(dev, devattr, buf, THERM_STATUS_THRESHOLD1);
> +}
> +
>  static ssize_t show_tjmax(struct device *dev,
>  			struct device_attribute *devattr, char *buf)
>  {
> @@ -165,6 +195,84 @@ static ssize_t show_ttarget(struct device *dev,
>  	return sprintf(buf, "%d\n", pdata->core_data[attr->index]->ttarget);
>  }
>  
> +static ssize_t show_tx(struct device *dev,
> +		       struct device_attribute *devattr, char *buf,
> +		       u32 mask, int shift)
> +{
> +	struct platform_data *pdata = dev_get_drvdata(dev);
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct temp_data *tdata = pdata->core_data[attr->index];
> +	u32 eax, edx;
> +	int t;

I don't like single-letter variable names. It may be clear to you what
it represents when you write the code, but that may not be the case for
other readers, or even for you in a couple years.

> +
> +	rdmsr_on_cpu(tdata->cpu, tdata->intrpt_reg, &eax, &edx);
> +	t = tdata->tjmax - ((eax & mask) >> shift) * 1000;
> +	return sprintf(buf, "%d\n", t);
> +}
> +
> +static ssize_t store_tx(struct device *dev,
> +			struct device_attribute *devattr,
> +			const char *buf, size_t count,
> +			u32 mask, int shift)
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
> +	/*
> +	 * Thermal threshold mask is 7 bits wide. Values are entered in terms
> +	 * of milli degree celsius. Hence don't accept val > (127 * 1000)
> +	 */
> +	if (val > tdata->tjmax || val > 127000)
> +		return -EINVAL;

This looks wrong. What need to fit on 7 bits isn't the threshold value
but tjmax - threshold. This even means that negative threshold values
are acceptable (even though I don't expect this to ever happen), so we
shouldn't use strict_strtoul() but strict_strtol().
> +
> +	diff = (tdata->tjmax - val) / 1000;
> +
> +	mutex_lock(&tdata->update_lock);
> +	rdmsr_on_cpu(tdata->cpu, tdata->intrpt_reg, &eax, &edx);
> +	eax = (eax & ~mask) | (diff << shift);
> +	wrmsr_on_cpu(tdata->cpu, tdata->intrpt_reg, eax, edx);
> +	mutex_unlock(&tdata->update_lock);
> +
> +	return count;
> +}
> +
> +static ssize_t show_t0(struct device *dev,
> +		       struct device_attribute *devattr, char *buf)
> +{
> +	return show_tx(dev, devattr, buf, THERM_MASK_THRESHOLD0,
> +		       THERM_SHIFT_THRESHOLD0);
> +}
> +
> +static ssize_t store_t0(struct device *dev,
> +			struct device_attribute *devattr,
> +			const char *buf, size_t count)
> +{
> +	return store_tx(dev, devattr, buf, count, THERM_MASK_THRESHOLD0,
> +			THERM_SHIFT_THRESHOLD0);
> +}
> +
> +static ssize_t show_t1(struct device *dev,
> +		       struct device_attribute *devattr, char *buf)
> +{
> +	return show_tx(dev, devattr, buf, THERM_MASK_THRESHOLD1,
> +		       THERM_SHIFT_THRESHOLD1);
> +}
> +
> +static ssize_t store_t1(struct device *dev,
> +			struct device_attribute *devattr,
> +			const char *buf, size_t count)
> +{
> +	return store_tx(dev, devattr, buf, count, THERM_MASK_THRESHOLD1,
> +			THERM_SHIFT_THRESHOLD1);
> +}
> +
>  static ssize_t show_temp(struct device *dev,
>  			struct device_attribute *devattr, char *buf)
>  {
> @@ -344,24 +452,39 @@ static int create_name_attr(struct platform_data *pdata, struct device *dev)
>  }
>  
>  static int create_core_attrs(struct temp_data *tdata, struct device *dev,
> -				int attr_no)
> +				int attr_no, bool have_ttarget)
>  {
>  	int err, i;
>  	static ssize_t (*rd_ptr[TOTAL_ATTRS]) (struct device *dev,
>  			struct device_attribute *devattr, char *buf) = {
>  			show_label, show_crit_alarm, show_temp, show_tjmax,
> -			show_ttarget };
> +			show_ttarget, show_t0, show_t0_triggered,
> +			show_t1, show_t1_triggered };
> +	static ssize_t (*rw_ptr[TOTAL_ATTRS]) (struct device *dev,
> +			struct device_attribute *devattr, const char *buf,
> +			size_t count) = { NULL, NULL, NULL, NULL, NULL,
> +					store_t0, NULL, store_t1, NULL };
>  	static const char *names[TOTAL_ATTRS] = {
>  					"temp%d_label", "temp%d_crit_alarm",
>  					"temp%d_input", "temp%d_crit",
> -					"temp%d_max" };
> +					"temp%d_max",
> +					"temp%d_threshold1",
> +					"temp%d_threshold1_triggered",
> +					"temp%d_threshold2",
> +					"temp%d_threshold2_triggered" };
>  
>  	for (i = 0; i < tdata->attr_size; i++) {
> +		if (rd_ptr[i] = show_ttarget && !have_ttarget)
> +			continue;
>  		snprintf(tdata->attr_name[i], CORETEMP_NAME_LENGTH, names[i],
>  			attr_no);
>  		sysfs_attr_init(&tdata->sd_attrs[i].dev_attr.attr);
>  		tdata->sd_attrs[i].dev_attr.attr.name = tdata->attr_name[i];
>  		tdata->sd_attrs[i].dev_attr.attr.mode = S_IRUGO;
> +		if (rw_ptr[i]) {
> +			tdata->sd_attrs[i].dev_attr.attr.mode |= S_IWUSR;
> +			tdata->sd_attrs[i].dev_attr.store = rw_ptr[i];
> +		}
>  		tdata->sd_attrs[i].dev_attr.show = rd_ptr[i];
>  		tdata->sd_attrs[i].index = attr_no;
>  		err = device_create_file(dev, &tdata->sd_attrs[i].dev_attr);
> @@ -371,8 +494,11 @@ static int create_core_attrs(struct temp_data *tdata, struct device *dev,
>  	return 0;
>  
>  exit_free:
> -	while (--i >= 0)
> +	while (--i >= 0) {
> +		if (!tdata->sd_attrs[i].dev_attr.attr.name)
> +			continue;
>  		device_remove_file(dev, &tdata->sd_attrs[i].dev_attr);
> +	}
>  	return err;
>  }
>  
> @@ -434,6 +560,8 @@ static struct temp_data *init_temp_data(unsigned int cpu, int pkg_flag)
>  
>  	tdata->status_reg = pkg_flag ? MSR_IA32_PACKAGE_THERM_STATUS :
>  							MSR_IA32_THERM_STATUS;
> +	tdata->intrpt_reg = pkg_flag ? MSR_IA32_PACKAGE_THERM_INTERRUPT :
> +						MSR_IA32_THERM_INTERRUPT;
>  	tdata->is_pkg_data = pkg_flag;
>  	tdata->cpu = cpu;
>  	tdata->cpu_core_id = TO_CORE_ID(cpu);
> @@ -450,6 +578,7 @@ static int create_core_data(struct platform_data *pdata,
>  	struct cpuinfo_x86 *c = &cpu_data(cpu);
>  	u32 eax, edx;
>  	int err, attr_no;
> +	bool have_ttarget = false;
>  
>  	/*
>  	 * Find attr number for sysfs:
> @@ -494,14 +623,22 @@ static int create_core_data(struct platform_data *pdata,
>  		if (!err) {
>  			tdata->ttarget
>  			  = tdata->tjmax - (((eax >> 8) & 0xff) * 1000);
> -			tdata->attr_size++;
> +			have_ttarget = true;
>  		}
>  	}
>  
> +	/*
> +	 * Test if we can access the intrpt register. If so, increase
> +	 * 'size' enough to support t0 and t1 attributes.
> +	 */
> +	err = rdmsr_safe_on_cpu(cpu, tdata->intrpt_reg, &eax, &edx);
> +	if (!err)
> +		tdata->attr_size += MAX_THRESH_ATTRS;
> +
>  	pdata->core_data[attr_no] = tdata;
>  
>  	/* Create sysfs interfaces */
> -	err = create_core_attrs(tdata, &pdev->dev, attr_no);
> +	err = create_core_attrs(tdata, &pdev->dev, attr_no, have_ttarget);
>  	if (err)
>  		goto exit_free;
>  
> @@ -534,8 +671,11 @@ static void coretemp_remove_core(struct platform_data *pdata,
>  	struct temp_data *tdata = pdata->core_data[indx];
>  
>  	/* Remove the sysfs attributes */
> -	for (i = 0; i < tdata->attr_size; i++)
> +	for (i = 0; i < tdata->attr_size; i++) {
> +		if (!tdata->sd_attrs[i].dev_attr.attr.name)
> +			continue;
>  		device_remove_file(dev, &tdata->sd_attrs[i].dev_attr);
> +	}
>  
>  	kfree(pdata->core_data[indx]);
>  	pdata->core_data[indx] = NULL;

From a functional perspective, I tested the patch on two Xeon E5520 and
it works OK. Both threshold are initialized to TjMax originally, but I
could write lower values and see _triggered turn to 1 as expected. It
did not seem to cause any action as a result, but this is probably
expected.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
