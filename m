From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Mon, 28 Mar 2011 18:11:02 +0000
Subject: Re: [lm-sensors]
Message-Id: <D6D887BA8C9DFF48B5233887EF0465410951570A5E@bgsmsx502.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <87ekb9s3tn.wl%info@wore.ma.cx>
In-Reply-To: <87ekb9s3tn.wl%info@wore.ma.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Fenghua,

Could you please let us know your comments on this patch ?

Thanks,
Durga

> -----Original Message-----
> From: lm-sensors-bounces@lm-sensors.org [mailto:lm-sensors-bounces@lm-
> sensors.org] On Behalf Of R, Durgadoss
> Sent: Friday, March 25, 2011 6:34 PM
> To: Guenter Roeck; lm-sensors@lm-sensors.org
> Subject: [lm-sensors] [PATCH:hwmon:v4:Resend]Merging_pkgtemp_with_coretemp
>
> Hi Guenter,
>
> This patch merges the pkgtemp driver with the coretemp driver.
> This merged driver creates one hwmon device per physical CPU i.e
> per Physical Package. Also, the sysfs interfaces per core are created
> as each core comes online and removed when it goes offline.
>
> v1 of this patch:
> Basic Merging of pkgtemp with coretemp. This creates one hwmon device
> per core.
> v2 of this patch:
> Fixed some Data structure related comments from v1. This also
> creates one hwmon device per core.
> v3 of this patch:
> This version creates one hwmon device per physical package, but
> no appropriate support for CPU hotplug.
> v4 of this patch:
> This creates one hwmon device per package.
> Added appropriate support for CONFIG_HOTPLUG_CPU.
>
> ---
> From: Durgadoss R <durgadoss.r@intel.com>
>
> Date: Thu, 3 Mar 2011 02:37:40 +0530
> Subject: [PATCH:hwmon:v4:Resend]Merging_pkgtemp_with_coretemp
>
> This patch merges the pkgtemp driver with the coretemp driver.
> This merged driver creates one hwmon device per physical CPU i.e
> per Physical Package. Also, the sysfs interfaces per core are created
> as each core comes online and removed when it goes offline.
>
> Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
>
> ---
>  drivers/hwmon/coretemp.c |  618 ++++++++++++++++++++++++++++++++++------------
>  1 files changed, 455 insertions(+), 163 deletions(-)
>
> diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> index 42de98d..2667828 100644
> --- a/drivers/hwmon/coretemp.c
> +++ b/drivers/hwmon/coretemp.c
> @@ -39,119 +39,140 @@
>
>  #define DRVNAME        "coretemp"
>
> -typedef enum { SHOW_TEMP, SHOW_TJMAX, SHOW_TTARGET, SHOW_LABEL,
> -               SHOW_NAME } SHOW;
> +#define CORES_PER_CPU          16      /* No of Real Cores per CPU */
> +#define CORETEMP_NAME_LENGTH   17      /* String Length of attrs */
> +#define MAX_ATTRS              5       /* Maximum no of per-core attrs */
>
>  /*
> - * Functions declaration
> + * Per-Core Temperature Data
> + * @last_updated: The time when the current temperature value was updated
> + *             earlier (in jiffies).
> + * @cpu_core_id: The CPU Core from which temperature values should be read
> + *             This value is passed as "id" field to rdmsr/wrmsr functions.
> + * @status_reg: One of IA32_THERM_STATUS or IA32_PACKAGE_THERM_STATUS,
> + *             from where the temperature values should be read.
> + * @is_pkg_data: If this is 1, the temp_data holds pkgtemp data.
> + *             Otherwise, temp_data holds coretemp data.
>   */
> -
> -static struct coretemp_data *coretemp_update_device(struct device *dev);
> -
> -struct coretemp_data {
> -       struct device *hwmon_dev;
> -       struct mutex update_lock;
> -       const char *name;
> -       u32 id;
> -       u16 core_id;
> -       char valid;             /* zero until following fields are valid */
> -       unsigned long last_updated;     /* in jiffies */
> +struct temp_data {
>         int temp;
> -       int tjmax;
>         int ttarget;
> -       u8 alarm;
> +       int tjmax;
> +       u8 crit_alarm;
> +       u8 max_alarm;
> +       unsigned long last_updated;
> +       unsigned int cpu;
> +       u32 cpu_core_id;
> +       u32 status_reg;
> +       bool is_pkg_data;
> +       struct sensor_device_attribute sd_attrs[MAX_ATTRS];
> +       char attr_name[MAX_ATTRS][CORETEMP_NAME_LENGTH];
> +       struct mutex update_lock;
>  };
>
>  /*
> - * Sysfs stuff
> + * Platform Data per Physical CPU
> + * @core_count:                Number of real cores(not HT ones) in a CPU
> + * @phys_proc_id:      The physical CPU id
>   */
> +struct platform_data {
> +       struct device *hwmon_dev;
> +       int core_count;
> +       u16 phys_proc_id;
> +       struct temp_data *core_data[CORES_PER_CPU];
> +       struct device_attribute name_attr;
> +};
> +
> +/* Function Declarations */
> +static void remove_core(struct platform_data *data, struct device *dev, int
> i);
> +
> +static ssize_t show_name(struct device *dev,
> +                               struct device_attribute *devattr, char *buf)
> +{
> +       return sprintf(buf, "%s\n", DRVNAME);
> +}
>
> -static ssize_t show_name(struct device *dev, struct device_attribute
> -                         *devattr, char *buf)
> +static ssize_t show_label(struct device *dev,
> +                               struct device_attribute *devattr, char *buf)
>  {
> -       int ret;
>         struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -       struct coretemp_data *data = dev_get_drvdata(dev);
> +       struct platform_data *pdata = dev_get_drvdata(dev);
> +       struct temp_data *tdata = pdata->core_data[attr->index];
>
> -       if (attr->index = SHOW_NAME)
> -               ret = sprintf(buf, "%s\n", data->name);
> -       else    /* show label */
> -               ret = sprintf(buf, "Core %d\n", data->core_id);
> -       return ret;
> +       if (tdata->is_pkg_data)
> +               return sprintf(buf, "Physical id %d\n", pdata->phys_proc_id);
> +
> +       return sprintf(buf, "Core %d\n", tdata->cpu_core_id);
>  }
>
> -static ssize_t show_alarm(struct device *dev, struct device_attribute
> -                         *devattr, char *buf)
> +static ssize_t show_crit_alarm(struct device *dev,
> +                               struct device_attribute *devattr, char *buf)
>  {
> -       struct coretemp_data *data = coretemp_update_device(dev);
> -       /* read the Out-of-spec log, never clear */
> -       return sprintf(buf, "%d\n", data->alarm);
> +       u32 eax, edx;
> +       struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +       struct platform_data *pdata = dev_get_drvdata(dev);
> +       struct temp_data *tdata = pdata->core_data[attr->index];
> +
> +       rdmsr_on_cpu(tdata->cpu_core_id, tdata->status_reg, &eax, &edx);
> +       tdata->crit_alarm = (eax >> 5) & 1;
> +
> +       return sprintf(buf, "%d\n", tdata->crit_alarm);
>  }
>
> -static ssize_t show_temp(struct device *dev,
> -                        struct device_attribute *devattr, char *buf)
> +static ssize_t show_tjmax(struct device *dev,
> +                               struct device_attribute *devattr, char *buf)
>  {
>         struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -       struct coretemp_data *data = coretemp_update_device(dev);
> -       int err;
> +       struct platform_data *pdata = dev_get_drvdata(dev);
>
> -       if (attr->index = SHOW_TEMP)
> -               err = data->valid ? sprintf(buf, "%d\n", data->temp) : -EAGAIN;
> -       else if (attr->index = SHOW_TJMAX)
> -               err = sprintf(buf, "%d\n", data->tjmax);
> -       else
> -               err = sprintf(buf, "%d\n", data->ttarget);
> -       return err;
> +       return sprintf(buf, "%d\n", pdata->core_data[attr->index]->tjmax);
>  }
>
> -static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL,
> -                         SHOW_TEMP);
> -static SENSOR_DEVICE_ATTR(temp1_crit, S_IRUGO, show_temp, NULL,
> -                         SHOW_TJMAX);
> -static SENSOR_DEVICE_ATTR(temp1_max, S_IRUGO, show_temp, NULL,
> -                         SHOW_TTARGET);
> -static DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_alarm, NULL);
> -static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, show_name, NULL, SHOW_LABEL);
> -static SENSOR_DEVICE_ATTR(name, S_IRUGO, show_name, NULL, SHOW_NAME);
> -
> -static struct attribute *coretemp_attributes[] = {
> -       &sensor_dev_attr_name.dev_attr.attr,
> -       &sensor_dev_attr_temp1_label.dev_attr.attr,
> -       &dev_attr_temp1_crit_alarm.attr,
> -       &sensor_dev_attr_temp1_input.dev_attr.attr,
> -       &sensor_dev_attr_temp1_crit.dev_attr.attr,
> -       NULL
> -};
> +static ssize_t show_ttarget(struct device *dev,
> +                               struct device_attribute *devattr, char *buf)
> +{
> +       struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +       struct platform_data *pdata = dev_get_drvdata(dev);
>
> -static const struct attribute_group coretemp_group = {
> -       .attrs = coretemp_attributes,
> -};
> +       return sprintf(buf, "%d\n", pdata->core_data[attr->index]->ttarget);
> +}
>
> -static struct coretemp_data *coretemp_update_device(struct device *dev)
> +static int update_curr_temp(struct temp_data *tdata, u32 eax, int tjmax)
>  {
> -       struct coretemp_data *data = dev_get_drvdata(dev);
> +       int err = -EINVAL;
>
> -       mutex_lock(&data->update_lock);
> +       mutex_lock(&tdata->update_lock);
> +       /*
> +        * Update the current temperature only if:
> +        * 1. The time interval has elapsed _and_
> +        * 2. The data is valid
> +        */
> +       if (time_after(jiffies, tdata->last_updated + HZ) &&
> +                                               (eax & 0x80000000)) {
> +               tdata->temp = tjmax - (((eax >> 16) & 0x7f) * 1000);
> +               tdata->last_updated = jiffies;
> +               err = 0;
> +       }
>
> -       if (!data->valid || time_after(jiffies, data->last_updated + HZ)) {
> -               u32 eax, edx;
> +       mutex_unlock(&tdata->update_lock);
> +       return err;
> +}
>
> -               data->valid = 0;
> -               rdmsr_on_cpu(data->id, MSR_IA32_THERM_STATUS, &eax, &edx);
> -               data->alarm = (eax >> 5) & 1;
> -               /* update only if data has been valid */
> -               if (eax & 0x80000000) {
> -                       data->temp = data->tjmax - (((eax >> 16)
> -                                                       & 0x7f) * 1000);
> -                       data->valid = 1;
> -               } else {
> -                       dev_dbg(dev, "Temperature data invalid (0x%x)\n", eax);
> -               }
> -               data->last_updated = jiffies;
> -       }
> +static ssize_t show_temp(struct device *dev,
> +                               struct device_attribute *devattr, char *buf)
> +{
> +       u32 eax, edx;
> +       struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +       struct platform_data *pdata = dev_get_drvdata(dev);
> +       struct temp_data *tdata = pdata->core_data[attr->index];
> +       int err;
>
> -       mutex_unlock(&data->update_lock);
> -       return data;
> +       rdmsr_on_cpu(tdata->cpu_core_id, tdata->status_reg, &eax, &edx);
> +       err = update_curr_temp(tdata, eax, tdata->tjmax);
> +       if (err)
> +               return err;
> +
> +       return sprintf(buf, "%d\n", tdata->temp);
>  }
>
>  static int __devinit adjust_tjmax(struct cpuinfo_x86 *c, u32 id, struct device
> *dev)
> @@ -298,115 +319,242 @@ static void __devinit get_ucode_rev_on_cpu(void *edx)
>         rdmsr(MSR_IA32_UCODE_REV, eax, *(u32 *)edx);
>  }
>
> -static int __devinit coretemp_probe(struct platform_device *pdev)
> +static int get_pkg_tjmax(int cpu, struct device *dev)
>  {
> -       struct coretemp_data *data;
> -       struct cpuinfo_x86 *c = &cpu_data(pdev->id);
> +       int default_tjmax = 100000;     /* 100 degree celsius */
>         int err;
> -       u32 eax, edx;
> +       u32 eax, edx, val;
>
> -       if (!(data = kzalloc(sizeof(struct coretemp_data), GFP_KERNEL))) {
> -               err = -ENOMEM;
> -               dev_err(&pdev->dev, "Out of memory\n");
> -               goto exit;
> +       err = rdmsr_safe_on_cpu(cpu, MSR_IA32_TEMPERATURE_TARGET, &eax, &edx);
> +       if (!err) {
> +               val = (eax >> 16) & 0xff;
> +               if ((val > 80) && (val < 120))
> +                       return val * 1000;
>         }
> +       dev_warn(dev, "Unable to read Pkg-TjMax from CPU:%d\n", cpu);
> +       return default_tjmax;
> +}
>
> -       data->id = pdev->id;
> -#ifdef CONFIG_SMP
> -       data->core_id = c->cpu_core_id;
> -#endif
> -       data->name = "coretemp";
> -       mutex_init(&data->update_lock);
> +static int create_name_attr(struct platform_data *pdata, struct device *dev)
> +{
> +       pdata->name_attr.attr.name = "name";
> +       pdata->name_attr.attr.mode = S_IRUGO;
> +       pdata->name_attr.show = show_name;
> +       return device_create_file(dev, &pdata->name_attr);
> +}
>
> -       /* test if we can access the THERM_STATUS MSR */
> -       err = rdmsr_safe_on_cpu(data->id, MSR_IA32_THERM_STATUS, &eax, &edx);
> -       if (err) {
> -               dev_err(&pdev->dev,
> -                       "Unable to access THERM_STATUS MSR, giving up\n");
> -               goto exit_free;
> +static int create_core_attrs(struct temp_data *tdata, struct device *dev,
> +                               int attr_no)
> +{
> +       int err, i;
> +       ssize_t (*rd_ptr[MAX_ATTRS]) (struct device *dev,
> +                       struct device_attribute *devattr, char *buf) = {
> +                       show_label, show_crit_alarm, show_ttarget,
> +                       show_temp, show_tjmax };
> +       const char *names[MAX_ATTRS] = { "temp%d_label", "temp%d_crit_alarm",
> +                                       "temp%d_max", "temp%d_input",
> +                                       "temp%d_crit" };
> +
> +       /* Increment attr_no since the sysfs interfaces start with temp1_* */
> +       int sysfs_attr_no = attr_no + 1;
> +
> +       for (i = 0; i < MAX_ATTRS; i++) {
> +               snprintf(tdata->attr_name[i], CORETEMP_NAME_LENGTH, names[i],
> +                       sysfs_attr_no);
> +               tdata->sd_attrs[i].dev_attr.attr.name = tdata->attr_name[i];
> +               tdata->sd_attrs[i].dev_attr.attr.mode = S_IRUGO;
> +               tdata->sd_attrs[i].dev_attr.show = rd_ptr[i];
> +               tdata->sd_attrs[i].dev_attr.store = NULL;
> +               tdata->sd_attrs[i].index = attr_no;
> +               err = device_create_file(dev, &tdata->sd_attrs[i].dev_attr);
> +               if (err)
> +                       goto exit_free;
>         }
> +       return 0;
> +
> +exit_free:
> +       while (--i >= 0)
> +               device_remove_file(dev, &tdata->sd_attrs[i].dev_attr);
> +       return err;
> +}
> +
> +static void remove_attrs(struct device *dev, struct temp_data *tdata)
> +{
> +       int i;
>
> -       /* Check if we have problem with errata AE18 of Core processors:
> -          Readings might stop update when processor visited too deep sleep,
> -          fixed for stepping D0 (6EC).
> -       */
> +       /* Remove the sysfs attributes */
> +       for (i = 0; i < MAX_ATTRS; i++)
> +               device_remove_file(dev, &tdata->sd_attrs[i].dev_attr);
> +}
>
> +static void update_ttarget(__u8 cpu_model, struct temp_data *tdata,
> +                               struct device *dev)
> +{
> +       int err;
> +       u32 eax, edx;
> +
> +       /*
> +        * Read the still undocumented IA32_TEMPERATURE_TARGET. It exists
> +        * on older CPUs but not in this register,
> +        * Atoms don't have it either.
> +        */
> +       if ((cpu_model > 0xe) && (cpu_model != 0x1c)) {
> +               err = rdmsr_safe_on_cpu(tdata->cpu_core_id,
> +                               MSR_IA32_TEMPERATURE_TARGET, &eax, &edx);
> +               if (err) {
> +                       dev_warn(dev,
> +                       "Unable to read IA32_TEMPERATURE_TARGET MSR\n");
> +
> +               } else {
> +                       tdata->ttarget = tdata->tjmax -
> +                                       (((eax >> 8) & 0xff) * 1000);
> +               }
> +       }
> +}
> +
> +static int chk_ucode_version(struct cpuinfo_x86 *c,
> +                               struct platform_device *pdev)
> +{
> +       int err;
> +       u32 edx;
> +
> +       /*
> +        * Check if we have problem with errata AE18 of Core processors:
> +        * Readings might stop update when processor visited too deep sleep,
> +        * fixed for stepping D0 (6EC).
> +        */
>         if ((c->x86_model = 0xe) && (c->x86_mask < 0xc)) {
>                 /* check for microcode update */
> -               err = smp_call_function_single(data->id, get_ucode_rev_on_cpu,
> -                                              &edx, 1);
> +               err = smp_call_function_single(pdev->id, get_ucode_rev_on_cpu,
> +                                                               &edx, 1);
>                 if (err) {
>                         dev_err(&pdev->dev,
>                                 "Cannot determine microcode revision of "
> -                               "CPU#%u (%d)!\n", data->id, err);
> -                       err = -ENODEV;
> -                       goto exit_free;
> +                               "CPU#%u (%d)!\n", pdev->id, err);
> +                       return -ENODEV;
>                 } else if (edx < 0x39) {
> -                       err = -ENODEV;
>                         dev_err(&pdev->dev,
>                                 "Errata AE18 not fixed, update BIOS or "
>                                 "microcode of the CPU!\n");
> -                       goto exit_free;
> +                       return -ENODEV;
>                 }
>         }
> +       return 0;
> +}
>
> -       data->tjmax = get_tjmax(c, data->id, &pdev->dev);
> -       platform_set_drvdata(pdev, data);
> +static struct temp_data *init_temp_data(int cpu, int core_id, int pkg_flag)
> +{
> +       struct temp_data *tdata;
> +
> +       tdata = kzalloc(sizeof(struct temp_data), GFP_KERNEL);
> +       if (!tdata)
> +               return NULL;
> +
> +       tdata->status_reg = pkg_flag ? MSR_IA32_PACKAGE_THERM_STATUS :
> +                                                       MSR_IA32_THERM_STATUS;
> +       tdata->is_pkg_data = pkg_flag;
> +       tdata->cpu_core_id = core_id;
> +       tdata->cpu = cpu;
> +       mutex_init(&tdata->update_lock);
> +       return tdata;
> +}
>
> -       /*
> -        * read the still undocumented IA32_TEMPERATURE_TARGET. It exists
> -        * on older CPUs but not in this register,
> -        * Atoms don't have it either.
> -        */
> +static int create_core_data(struct platform_data *pdata,
> +                               struct platform_device *pdev,
> +                               unsigned int cpu, int pkg_flag)
> +{
> +       struct temp_data *tdata;
> +       struct cpuinfo_x86 *c = &cpu_data(cpu);
> +       u32 eax, edx;
> +       int err;
> +       int core_id = c->cpu_core_id;
>
> -       if ((c->x86_model > 0xe) && (c->x86_model != 0x1c)) {
> -               err = rdmsr_safe_on_cpu(data->id, MSR_IA32_TEMPERATURE_TARGET,
> -                   &eax, &edx);
> -               if (err) {
> -                       dev_warn(&pdev->dev, "Unable to read"
> -                                       " IA32_TEMPERATURE_TARGET MSR\n");
> -               } else {
> -                       data->ttarget = data->tjmax -
> -                                       (((eax >> 8) & 0xff) * 1000);
> -                       err = device_create_file(&pdev->dev,
> -                                       &sensor_dev_attr_temp1_max.dev_attr);
> -                       if (err)
> -                               goto exit_free;
> -               }
> +       tdata = init_temp_data(cpu, core_id, pkg_flag);
> +       if (!tdata)
> +               return -ENOMEM;
> +
> +       /* Test if we can access the status register */
> +       err = rdmsr_safe_on_cpu(core_id, tdata->status_reg, &eax, &edx);
> +       if (err)
> +               goto exit_free;
> +
> +       /* Create sysfs interfaces */
> +       err = create_core_attrs(tdata, &pdev->dev, pdata->core_count);
> +       if (err)
> +               goto exit_free;
> +
> +       /* Get Critical Temperature */
> +       if (pkg_flag)
> +               tdata->tjmax = get_pkg_tjmax(pdev->id, &pdev->dev);
> +       else
> +               tdata->tjmax = get_tjmax(c, core_id, &pdev->dev);
> +
> +       update_ttarget(c->x86_model, tdata, &pdev->dev);
> +
> +       pdata->core_data[pdata->core_count] = tdata;
> +       pdata->core_count++;
> +
> +       return 0;
> +exit_free:
> +       kfree(tdata);
> +       return err;
> +}
> +
> +static int __devinit coretemp_probe(struct platform_device *pdev)
> +{
> +       struct platform_data *pdata;
> +       struct cpuinfo_x86 *c = &cpu_data(pdev->id);
> +       int err;
> +
> +       /* Initialize the per-package data structures */
> +       pdata = kzalloc(sizeof(struct platform_data), GFP_KERNEL);
> +       if (!pdata) {
> +               dev_err(&pdev->dev, "Out of memory\n");
> +               return -ENOMEM;
>         }
>
> -       if ((err = sysfs_create_group(&pdev->dev.kobj, &coretemp_group)))
> -               goto exit_dev;
> +       pdata->core_count = 0;
> +       pdata->phys_proc_id = c->phys_proc_id;
>
> -       data->hwmon_dev = hwmon_device_register(&pdev->dev);
> -       if (IS_ERR(data->hwmon_dev)) {
> -               err = PTR_ERR(data->hwmon_dev);
> -               dev_err(&pdev->dev, "Class registration failed (%d)\n",
> -                       err);
> -               goto exit_class;
> +       err = create_name_attr(pdata, &pdev->dev);
> +       if (err)
> +               goto exit_free;
> +
> +       /* Check the microcode version of the CPU */
> +       err = chk_ucode_version(c, pdev);
> +       if (err)
> +               goto exit_name;
> +
> +       platform_set_drvdata(pdev, pdata);
> +
> +       pdata->hwmon_dev = hwmon_device_register(&pdev->dev);
> +       if (IS_ERR(pdata->hwmon_dev)) {
> +               err = PTR_ERR(pdata->hwmon_dev);
> +               dev_err(&pdev->dev, "Class registration failed (%d)\n", err);
> +               goto exit_name;
>         }
>
>         return 0;
>
> -exit_class:
> -       sysfs_remove_group(&pdev->dev.kobj, &coretemp_group);
> -exit_dev:
> -       device_remove_file(&pdev->dev, &sensor_dev_attr_temp1_max.dev_attr);
> +exit_name:
> +       device_remove_file(&pdev->dev, &pdata->name_attr);
>  exit_free:
> -       kfree(data);
> -exit:
> +       kfree(pdata);
>         return err;
>  }
>
>  static int __devexit coretemp_remove(struct platform_device *pdev)
>  {
> -       struct coretemp_data *data = platform_get_drvdata(pdev);
> +       struct platform_data *pdata = platform_get_drvdata(pdev);
> +       int i;
>
> -       hwmon_device_unregister(data->hwmon_dev);
> -       sysfs_remove_group(&pdev->dev.kobj, &coretemp_group);
> -       device_remove_file(&pdev->dev, &sensor_dev_attr_temp1_max.dev_attr);
> +       for (i = pdata->core_count - 1; i >= 0; --i)
> +               remove_core(pdata, &pdev->dev, i);
> +
> +       device_remove_file(&pdev->dev, &pdata->name_attr);
> +       hwmon_device_unregister(pdata->hwmon_dev);
>         platform_set_drvdata(pdev, NULL);
> -       kfree(data);
> +       kfree(pdata);
>         return 0;
>  }
>
> @@ -432,6 +580,96 @@ struct pdev_entry {
>  static LIST_HEAD(pdev_list);
>  static DEFINE_MUTEX(pdev_list_mutex);
>
> +static struct platform_device *get_pdev(int phys_proc_id)
> +{
> +       struct pdev_entry *p;
> +
> +       mutex_lock(&pdev_list_mutex);
> +
> +       list_for_each_entry(p, &pdev_list, list)
> +               if (p->phys_proc_id = phys_proc_id) {
> +                       mutex_unlock(&pdev_list_mutex);
> +                       return p->pdev;
> +               }
> +
> +       mutex_unlock(&pdev_list_mutex);
> +       return NULL;
> +}
> +
> +static int get_core_indx(struct platform_data *pdata, int core_id)
> +{
> +       int i;
> +
> +       for (i = 0; i < pdata->core_count; i++) {
> +               if (pdata->core_data[i]->cpu_core_id = core_id &&
> +                       !pdata->core_data[i]->is_pkg_data)
> +                       return i;
> +       }
> +       return -ENODEV;
> +}
> +
> +static void add_core(unsigned int cpu, int pkg_flag)
> +{
> +       int indx, err;
> +       struct platform_data *pdata;
> +       struct cpuinfo_x86 *c = &cpu_data(cpu);
> +       struct platform_device *pdev = get_pdev(c->phys_proc_id);
> +
> +       if (!pdev)
> +               return;
> +
> +       pdata = platform_get_drvdata(pdev);
> +
> +       /* If this core is a HT one, do not create any interfaces */
> +       indx = get_core_indx(pdata, c->cpu_core_id);
> +       if (indx >= 0) {
> +               dev_info(&pdev->dev, "A HT core (%u) is onlined\n", cpu);
> +               return;
> +       }
> +
> +       err = create_core_data(pdata, pdev, cpu, pkg_flag);
> +       if (err) {
> +               dev_err(&pdev->dev, "Onlining Core %u on Pkg %d failed\n",
> +                       cpu, c->phys_proc_id);
> +       }
> +}
> +
> +static void remove_core(struct platform_data *pdata, struct device *dev,
> +                       int indx)
> +{
> +       int i;
> +       int max = pdata->core_count - 1;
> +
> +       /* Remove all sysfs attrs for this core */
> +       remove_attrs(dev, pdata->core_data[indx]);
> +
> +       /* Shift the core_data elements */
> +       for (i = indx; i < max; i++)
> +               pdata->core_data[i] = pdata->core_data[i + 1];
> +
> +       /* Free the _last_ element */
> +       kfree(pdata->core_data[max]);
> +       pdata->core_data[max] = NULL;
> +
> +       pdata->core_count--;
> +
> +       /*
> +        * If count is _only_ one and the device is pkg temp
> +        * remove those interfaces and get rid off this 'pdev' entry
> +        * in the pdev_entry list.
> +        *
> +        * The pkg temp is alive as long as atleast one of the
> +        * cores inside the pkg is online. And it is removed
> +        * when all cores in a pkg go offline.
> +        */
> +       if (pdata->core_count = 1 && pdata->core_data[0]->is_pkg_data) {
> +               remove_attrs(dev, pdata->core_data[0]);
> +               kfree(pdata->core_data[0]);
> +               pdata->core_data[0] = NULL;
> +               pdata->core_count--;
> +       }
> +}
> +
>  static int __cpuinit coretemp_device_add(unsigned int cpu)
>  {
>         int err;
> @@ -503,28 +741,81 @@ exit:
>         return err;
>  }
>
> -static void __cpuinit coretemp_device_remove(unsigned int cpu)
> +static void __cpuinit coretemp_device_remove(int phys_proc_id)
>  {
>         struct pdev_entry *p;
> -       unsigned int i;
>
>         mutex_lock(&pdev_list_mutex);
>         list_for_each_entry(p, &pdev_list, list) {
> -               if (p->cpu != cpu)
> +               if (p->phys_proc_id != phys_proc_id)
>                         continue;
>
>                 platform_device_unregister(p->pdev);
>                 list_del(&p->list);
>                 mutex_unlock(&pdev_list_mutex);
>                 kfree(p);
> -               for_each_cpu(i, cpu_sibling_mask(cpu))
> -                       if (i != cpu && !coretemp_device_add(i))
> -                               break;
>                 return;
>         }
>         mutex_unlock(&pdev_list_mutex);
>  }
>
> +static void get_core_online(unsigned int cpu)
> +{
> +       struct cpuinfo_x86 *c = &cpu_data(cpu);
> +       struct platform_device *pdev = get_pdev(c->phys_proc_id);
> +
> +       if (!pdev) {
> +               /*
> +                * We are bringing the _first_ core in this pkg
> +                * online. So initialize per-pkg data structures and
> +                * then bring this core online.
> +                */
> +               coretemp_device_add(cpu);
> +               if (cpu_has(c, X86_FEATURE_PTS))
> +                       add_core(cpu, 1);
> +       }
> +       /*
> +        * Physical CPU device already exists.
> +        * So, just bring this core online.
> +        */
> +       add_core(cpu, 0);
> +}
> +
> +
> +static void put_core_offline(unsigned int cpu)
> +{
> +       int indx;
> +       struct platform_data *pdata;
> +       struct cpuinfo_x86 *c = &cpu_data(cpu);
> +       struct platform_device *pdev = get_pdev(c->phys_proc_id);
> +
> +       /* If the physical CPU device does not exist, just return */
> +       if (!pdev)
> +               return;
> +
> +       pdata = platform_get_drvdata(pdev);
> +
> +       indx = get_core_indx(pdata, c->cpu_core_id);
> +       if (indx < 0) {
> +               dev_info(&pdev->dev, "Core %d does not exist\n",
> +                       c->cpu_core_id);
> +               return;
> +       }
> +
> +       if (pdata->core_data[indx]->cpu = cpu)
> +               remove_core(pdata, &pdev->dev, indx);
> +       else
> +               dev_info(&pdev->dev, "A HT CPU (%u) is offlined\n", cpu);
> +
> +       /*
> +        * If all cores in this pkg are offline,
> +        * remove this device from the pdev_entry list and
> +        * do pkg level clean ups
> +        */
> +       if (pdata->core_count = 0)
> +               coretemp_device_remove(c->phys_proc_id);
> +}
> +
>  static int __cpuinit coretemp_cpu_callback(struct notifier_block *nfb,
>                                  unsigned long action, void *hcpu)
>  {
> @@ -533,10 +824,10 @@ static int __cpuinit coretemp_cpu_callback(struct
> notifier_block *nfb,
>         switch (action) {
>         case CPU_ONLINE:
>         case CPU_DOWN_FAILED:
> -               coretemp_device_add(cpu);
> +               get_core_online(cpu);
>                 break;
>         case CPU_DOWN_PREPARE:
> -               coretemp_device_remove(cpu);
> +               put_core_offline(cpu);
>                 break;
>         }
>         return NOTIFY_OK;
> @@ -546,6 +837,7 @@ static struct notifier_block coretemp_cpu_notifier
> __refdata = {
>         .notifier_call = coretemp_cpu_callback,
>  };
>
> +
>  static int __init coretemp_init(void)
>  {
>         int i, err = -ENODEV;
> @@ -559,7 +851,7 @@ static int __init coretemp_init(void)
>                 goto exit;
>
>         for_each_online_cpu(i)
> -               coretemp_device_add(i);
> +               get_core_online(i);
>
>  #ifndef CONFIG_HOTPLUG_CPU
>         if (list_empty(&pdev_list)) {
> --
> 1.7.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
