From: "Yu, Fenghua" <fenghua.yu@intel.com>
Date: Fri, 19 Apr 2013 00:51:57 +0000
Subject: Re: [lm-sensors] [PATCH 1/4] hwmon: (coretemp) Add support for thermal threshold attributes
Message-Id: <3E5A0FA7E9CA944F9D5414FEC6C712205597D287@ORSMSX106.amr.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1365541282-19366-2-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1365541282-19366-2-git-send-email-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> From: Srinivas Pandruvada [mailto:srinivas.pandruvada@linux.intel.com]
> From: Guenter Roeck <linux@roeck-us.net>
> 
> Add support for T0 and T1 temperature thresholds using the new sysfs
> ABI
> attributes tempX_thresholdY and tempX_thresholdY_triggered.
> 
> This patch is based on commit c814a4c7c4aad795835583344353963a0a673eb0,
> which
> was reverted. For details on the threshold registers, see IA Manual vol
> 3A,
> which can be downloaded from here:
>         http://download.intel.com/design/processor/manuals/253668.pdf
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  Documentation/hwmon/coretemp |   8 +++
>  drivers/hwmon/coretemp.c     | 161
> ++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 159 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/hwmon/coretemp
> b/Documentation/hwmon/coretemp
> index fec5a9b..bb75856 100644
> --- a/Documentation/hwmon/coretemp
> +++ b/Documentation/hwmon/coretemp
> @@ -37,6 +37,14 @@ the Out-Of-Spec bit. Following table summarizes the
> exported sysfs files:
>  All Sysfs entries are named with their core_id (represented here by
> 'X').
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
>  tempX_crit	 - Maximum junction temperature (in millidegrees Celsius).
>  tempX_crit_alarm - Set when Out-of-spec bit is set, never clears.
>  		   Correct CPU operation is no longer guaranteed.
> diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> index 3f1e297..5a8973d 100644
> --- a/drivers/hwmon/coretemp.c
> +++ b/drivers/hwmon/coretemp.c
> @@ -52,9 +52,10 @@ MODULE_PARM_DESC(tjmax, "TjMax value in degrees
> Celsius");
> 
>  #define BASE_SYSFS_ATTR_NO	2	/* Sysfs Base attr no for coretemp
> */
>  #define NUM_REAL_CORES		32	/* Number of Real cores per cpu */
> -#define CORETEMP_NAME_LENGTH	17	/* String Length of attrs */
> -#define MAX_CORE_ATTRS		4	/* Maximum no of basic attrs */
> -#define TOTAL_ATTRS		(MAX_CORE_ATTRS + 1)
> +#define CORETEMP_NAME_LENGTH	33	/* String Length of attrs */
> +#define MAX_CORE_ATTRS		5	/* Maximum no of basic attrs */
> +#define MAX_THRESH_ATTRS	4	/* Maximum no of threshold attrs */
> +#define TOTAL_ATTRS		(MAX_CORE_ATTRS + MAX_THRESH_ATTRS)
>  #define MAX_CORE_DATA		(NUM_REAL_CORES + BASE_SYSFS_ATTR_NO)
> 
>  #define TO_PHYS_ID(cpu)		(cpu_data(cpu).phys_proc_id)
> @@ -88,6 +89,7 @@ struct temp_data {
>  	unsigned int cpu;
>  	u32 cpu_core_id;
>  	u32 status_reg;
> +	u32 intrpt_reg;
>  	int attr_size;
>  	bool is_pkg_data;
>  	bool valid;
> @@ -145,6 +147,110 @@ static ssize_t show_crit_alarm(struct device *dev,
>  	return sprintf(buf, "%d\n", (eax >> 5) & 1);
>  }
> 
> +static ssize_t show_tx_triggered(struct device *dev,
> +				 struct device_attribute *devattr, char *buf,
> +				 u32 mask)
> +{
> +	u32 eax, edx;
> +	struct sensor_device_attribute *attr > to_sensor_dev_attr(devattr);
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
> +	return show_tx_triggered(dev, devattr, buf,
> THERM_STATUS_THRESHOLD0);
> +}
> +
> +static ssize_t show_t1_triggered(struct device *dev,
> +				 struct device_attribute *devattr, char *buf)
> +{
> +	return show_tx_triggered(dev, devattr, buf,
> THERM_STATUS_THRESHOLD1);
> +}
> +
> +static ssize_t show_tx(struct device *dev,
> +		       struct device_attribute *devattr, char *buf,
> +		       u32 mask, int shift)
> +{
> +	struct platform_data *pdata = dev_get_drvdata(dev);
> +	struct sensor_device_attribute *attr > to_sensor_dev_attr(devattr);
> +	struct temp_data *tdata = pdata->core_data[attr->index];
> +	u32 eax, edx;
> +	int t;
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
> +	struct sensor_device_attribute *attr > to_sensor_dev_attr(devattr);
> +	struct temp_data *tdata = pdata->core_data[attr->index];
> +	u32 eax, edx;
> +	unsigned long val;
> +	int diff;
> +
> +	if (kstrtoul(buf, 0, &val))
> +		return -EINVAL;
> +
> +	/*
> +	 * Thermal threshold mask is 7 bits wide. Values are entered in
> terms
> +	 * of milli degree celsius. Hence don't accept val > (127 * 1000)
> +	 */
> +	if (val > tdata->tjmax || val > 127000)
> +		return -EINVAL;
> +
> +	diff = (tdata->tjmax - val) / 1000;
> +
> +	mutex_lock(&tdata->update_lock);
> +	rdmsr_on_cpu(tdata->cpu, tdata->intrpt_reg, &eax, &edx);
> +	eax = (eax & ~mask) | (diff << shift);
> +	wrmsr_on_cpu(tdata->cpu, tdata->intrpt_reg, eax, edx);

Is it safe to set up intrpt_reg while interrupt is still enabled?
Should the interrupt be disabled before the reg is changed?

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
>  static ssize_t show_tjmax(struct device *dev,
>  			struct device_attribute *devattr, char *buf)
>  {
> @@ -368,24 +474,40 @@ static int create_name_attr(struct platform_data
> *pdata,
>  }
> 
>  static int __cpuinit create_core_attrs(struct temp_data *tdata,
> -				       struct device *dev, int attr_no)
> +				       struct device *dev,
> +					int attr_no, bool have_ttarget)
>  {
>  	int err, i;
>  	static ssize_t (*const rd_ptr[TOTAL_ATTRS]) (struct device *dev,
>  			struct device_attribute *devattr, char *buf) = {
>  			show_label, show_crit_alarm, show_temp, show_tjmax,
> -			show_ttarget };
> +			show_ttarget, show_t0, show_t0_triggered,
> +			show_t1, show_t1_triggered };
> +	static ssize_t (*rw_ptr[TOTAL_ATTRS]) (struct device *dev,
> +			struct device_attribute *devattr, const char *buf,
> +			size_t count) = { NULL, NULL, NULL, NULL, NULL,
> +					store_t0, NULL, store_t1, NULL };
>  	static const char *const names[TOTAL_ATTRS] = {
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
>  		snprintf(tdata->attr_name[i], CORETEMP_NAME_LENGTH,
> names[i],
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
> @@ -395,8 +517,11 @@ static int __cpuinit create_core_attrs(struct
> temp_data *tdata,
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
> @@ -446,6 +571,9 @@ static struct temp_data __cpuinit
> *init_temp_data(unsigned int cpu,
> 
>  	tdata->status_reg = pkg_flag ? MSR_IA32_PACKAGE_THERM_STATUS :
>  							MSR_IA32_THERM_STATUS;
> +	tdata->intrpt_reg = pkg_flag ? MSR_IA32_PACKAGE_THERM_INTERRUPT :
> +						MSR_IA32_THERM_INTERRUPT;
> +
>  	tdata->is_pkg_data = pkg_flag;
>  	tdata->cpu = cpu;
>  	tdata->cpu_core_id = TO_CORE_ID(cpu);
> @@ -462,6 +590,7 @@ static int __cpuinit create_core_data(struct
> platform_device *pdev,
>  	struct cpuinfo_x86 *c = &cpu_data(cpu);
>  	u32 eax, edx;
>  	int err, attr_no;
> +	bool have_ttarget = false;
> 
>  	/*
>  	 * Find attr number for sysfs:
> @@ -507,14 +636,23 @@ static int __cpuinit create_core_data(struct
> platform_device *pdev,
>  		if (!err) {
>  			tdata->ttarget
>  			  = tdata->tjmax - ((eax >> 8) & 0xff) * 1000;
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
> +
>  	pdata->core_data[attr_no] = tdata;
> 
>  	/* Create sysfs interfaces */
> -	err = create_core_attrs(tdata, &pdev->dev, attr_no);
> +	err = create_core_attrs(tdata, &pdev->dev, attr_no, have_ttarget);
>  	if (err)
>  		goto exit_free;
> 
> @@ -545,8 +683,11 @@ static void coretemp_remove_core(struct
> platform_data *pdata,
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
> --
> 1.7.11.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
