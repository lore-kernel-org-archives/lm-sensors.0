From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 26 Apr 2011 20:46:30 +0000
Subject: Re: [lm-sensors] Patch v5 Merge Pkgtemp with coretemp
Message-Id: <20110426204630.GA19751@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <D6D887BA8C9DFF48B5233887EF046541095182D2CC@bgsmsx502.gar.corp.intel.com>
In-Reply-To: <D6D887BA8C9DFF48B5233887EF046541095182D2CC@bgsmsx502.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Apr 18, 2011 at 08:56:34AM -0400, R, Durgadoss wrote:
> Hi,
> 
> This patch merges the pkgtemp with coretemp driver.
> It has support for CONFIG_HOTPLUG_CPU. So, the sysfs
> interfaces are created when each core comes online
> and are removed when it goes offline.
> 
> I have attached the logs when this driver is loaded on
> a SandyBridge(for pkgtemp testing) and a Non-Sandybridge(corei5)
> machine. I have tested this patch on these machines for cpu hotplug
> Support. As far as I could see, it seems to work fine.
> Kindly let me know if there are any crashes, with dmesg logs.
> ---

Please see Documentation/SubmitingPatches, #7 and #15.

> From: Durgadoss R <durgadoss.r@intel.com>
> 
> Date: Mon, 18 Apr 2011 22:38:57 +0530
> Subject: [PATCH 1/1] hwmon:v5:Merge Pkgtemp with Coretemp
> 
> This patch merges the pkgtemp with coretemp driver.
> It has support for CONFIG_HOTPLUG_CPU. So, the sysfs
> interfaces are created when each core comes online
> and are removed when it goes offline.
> 
> Signed-off-by: Durgadoss R <durgadoss.r@intel.com>

Functionality-wise, there is still a problem: If one core of a HT CPU
is taken offline, the driver used to replace it with its sibling if
it was online. This way the core's temperature was still displayed as 
long as at least one of the HT cores was online. This is no longer the case.

> ---
> v1:
> * Basic Merging of pkgtemp with coretemp.
> * Creates one hwmon device per core.
> v2:
> * Fixed some Data structure related comments from v1.
> * Creates one hwmon device per core.
> v3:
> * Creates one hwmon device per physical package.
> * No appropriate support for CPU hotplug.
> v4:
> * Creates one hwmon device per package.
> * Added appropriate support for CONFIG_HOTPLUG_CPU.
> v5:
> * Changed naming of sysfs based on core_id
> * Changed all %d to %u appropriately
> * Removed unnecessary variables crit/max_alarm
> * Fixed the flow of show_temp method
> * Removed unwanted print messages
> * Removed per-core related code from coretemp_device_add
> * Corrected the error handling in get_core_online
>  drivers/hwmon/coretemp.c |  602 +++++++++++++++++++++++++++++++---------------
>  1 files changed, 408 insertions(+), 194 deletions(-)

You should update Documentation/hwmon/coretemp to reflect your changes.

> 
> diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> index 194ca0a..bdf6bff 100644
> --- a/drivers/hwmon/coretemp.c
> +++ b/drivers/hwmon/coretemp.c
> @@ -41,119 +41,127 @@
> 
>  #define DRVNAME        "coretemp"
> 
> -typedef enum { SHOW_TEMP, SHOW_TJMAX, SHOW_TTARGET, SHOW_LABEL,
> -               SHOW_NAME } SHOW;
> +#define BASE_SYSFS_ATTR_NO     2       /* Sysfs Base attr no for coretemp */
> +#define NUM_REAL_CORES         16      /* Number of Real cores per cpu */
> +#define CORETEMP_NAME_LENGTH   17      /* String Length of attrs */
> +#define MAX_ATTRS              5       /* Maximum no of per-core attrs */
> +#define MAX_CORE_DATA          (NUM_REAL_CORES + BASE_SYSFS_ATTR_NO)
> +/* Macro to get sysfs attr no from cpu core id */
> +#define TO_ATTR_NO(core_id)    (core_id + BASE_SYSFS_ATTR_NO)
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
> + * @phys_proc_id:      The physical CPU id
>   */
> +struct platform_data {
> +       struct device *hwmon_dev;
> +       u16 phys_proc_id;
> +       struct temp_data *core_data[MAX_CORE_DATA];
> +       struct device_attribute name_attr;
> +};
> +
> +/* Function Declarations */
> +static void coretemp_remove_core(struct platform_data *data,
> +                                       struct device *dev, int i);
> +
Please rearrange the code to not require forward declarations.

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
> +               return sprintf(buf, "Physical id %u\n", pdata->phys_proc_id);
> +
> +       return sprintf(buf, "Core %u\n", tdata->cpu_core_id);
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
> +       rdmsr_on_cpu(tdata->cpu, tdata->status_reg, &eax, &edx);
> +
> +       return sprintf(buf, "%d\n", ((eax >> 5) & 1));

One set of () too much.

>  }
> 
> -static ssize_t show_temp(struct device *dev,
> -                        struct device_attribute *devattr, char *buf)
> +static ssize_t show_tjmax(struct device *dev,
> +                               struct device_attribute *devattr, char *buf)

I very much prefer the previous formatting, with the second line next to
the opening ( of the previous line.

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
> +static ssize_t show_temp(struct device *dev,
> +                               struct device_attribute *devattr, char *buf)
>  {
> -       struct coretemp_data *data = dev_get_drvdata(dev);
> -
> -       mutex_lock(&data->update_lock);
> +       u32 eax, edx;
> +       struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +       struct platform_data *pdata = dev_get_drvdata(dev);
> +       struct temp_data *tdata = pdata->core_data[attr->index];
> 
> -       if (!data->valid || time_after(jiffies, data->last_updated + HZ)) {
> -               u32 eax, edx;
> +       mutex_lock(&tdata->update_lock);
> 
> -               data->valid = 0;
> -               rdmsr_on_cpu(data->id, MSR_IA32_THERM_STATUS, &eax, &edx);
> -               data->alarm = (eax >> 5) & 1;
> -               /* update only if data has been valid */
> +       /* Check whether the time interval has elapsed */
> +       if (time_after(jiffies, tdata->last_updated + HZ)) {
> +               rdmsr_on_cpu(tdata->cpu, tdata->status_reg, &eax, &edx);
> +               /* Check whether the data is valid */
>                 if (eax & 0x80000000) {
> -                       data->temp = data->tjmax - (((eax >> 16)
> -                                                       & 0x7f) * 1000);
> -                       data->valid = 1;
> -               } else {
> -                       dev_dbg(dev, "Temperature data invalid (0x%x)\n", eax);
> +                       tdata->temp = tdata->tjmax -
> +                                       (((eax >> 16) & 0x7f) * 1000);
>                 }
> -               data->last_updated = jiffies;
> +               tdata->last_updated = jiffies;
>         }
> 
What happens if the data was not valid ? You still claim it was updated,
without really updating it. Worse, persistently invalid data is now silently ignored 
(or, rather, you kep displaying the old value and claim it is up to date).
Not a good idea. Worst case, the displayed temperature is never set in the first place.

Why did you remove the valid flag ?

> -       mutex_unlock(&data->update_lock);
> -       return data;
> +       mutex_unlock(&tdata->update_lock);
> +       return sprintf(buf, "%d\n", tdata->temp);
>  }
> 
>  static int __devinit adjust_tjmax(struct cpuinfo_x86 *c, u32 id, struct device *dev)
> @@ -300,115 +308,260 @@ static void __devinit get_ucode_rev_on_cpu(void *edx)
>         rdmsr(MSR_IA32_UCODE_REV, eax, *(u32 *)edx);
>  }
> 
> -static int __devinit coretemp_probe(struct platform_device *pdev)
> +static int get_pkg_tjmax(unsigned int cpu, struct device *dev)
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
> +       dev_warn(dev, "Unable to read Pkg-TjMax from CPU:%u\n", cpu);
> +       return default_tjmax;

Since default_tjmax is set and used only once, it is unnecessary.
Just return 100000 directly. If you wantto be fancy, define a constant and use it.

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
You might want to declare above variables static, to avoid re-initialization 
whenever this function is called.

> +       for (i = 0; i < MAX_ATTRS; i++) {
> +               snprintf(tdata->attr_name[i], CORETEMP_NAME_LENGTH, names[i],
> +                       attr_no);
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
> 
> -       /* Check if we have problem with errata AE18 of Core processors:
> -          Readings might stop update when processor visited too deep sleep,
> -          fixed for stepping D0 (6EC).
> -       */
> +exit_free:
> +       while (--i >= 0)
> +               device_remove_file(dev, &tdata->sd_attrs[i].dev_attr);
> +       return err;
> +}
> +
> +static void remove_attrs(struct device *dev, struct temp_data *tdata)
> +{
> +       int i;
> +
> +       /* Remove the sysfs attributes */
> +       for (i = 0; i < MAX_ATTRS; i++)
> +               device_remove_file(dev, &tdata->sd_attrs[i].dev_attr);
> +}
> +
> +static void update_ttarget(__u8 cpu_model, struct temp_data *tdata,
> +                               struct device *dev)
> +{
> +       int err;
> +       u32 eax, edx;
> +
> +       /*
> +        * Initialize ttarget value. Eventually this will be
> +        * initialized with the value from MSR_IA32_THERM_INTERRUPT
> +        * register. If IA32_TEMPERATURE_TARGET is supported, this
> +        * value will be over written below.
> +        * To Do: Patch to initialize ttarget from MSR_IA32_THERM_INTERRUPT
> +        */
Do you plan to submit a separate patch to address this ?

> +       tdata->ttarget = tdata->tjmax - 20000;
> +
> +       /*
> +        * Read the still undocumented IA32_TEMPERATURE_TARGET. It exists
> +        * on older CPUs but not in this register,
> +        * Atoms don't have it either.
> +        */
> +       if ((cpu_model > 0xe) && (cpu_model != 0x1c)) {
> +               err = rdmsr_safe_on_cpu(tdata->cpu,
> +                               MSR_IA32_TEMPERATURE_TARGET, &eax, &edx);
> +               if (err) {
> +                       dev_warn(dev,
> +                       "Unable to read IA32_TEMPERATURE_TARGET MSR\n");
> +               } else {
> +                       tdata->ttarget = tdata->tjmax -
> +                                       (((eax >> 8) & 0xff) * 1000);
> +               }
> +       }
> +}
> 
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

Why this formatting change ?

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
> +static struct temp_data *init_temp_data(unsigned int cpu, int core_id,
> +                                       int pkg_flag)
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
> +       tdata->last_updated = jiffies;

Really ? That means you won't read the temperature for one second after the driver 
is instantiated, and instead display invalid data - especially since you also removed
the valid flag. 

> +       mutex_init(&tdata->update_lock);
> +       return tdata;
> +}
> +
> +static int create_core_data(struct platform_data *pdata,
> +                               struct platform_device *pdev,
> +                               unsigned int cpu, int pkg_flag)
> +{
> +       struct temp_data *tdata;
> +       struct cpuinfo_x86 *c = &cpu_data(cpu);
> +       u32 eax, edx;
> +       int err, attr_no;
> 
>         /*
> -        * read the still undocumented IA32_TEMPERATURE_TARGET. It exists
> -        * on older CPUs but not in this register,
> -        * Atoms don't have it either.
> +        * Find attr number for sysfs:
> +        * We map the attr number to core id of the CPU
> +        * The attr number is always core id + 2
> +        * The Pkgtemp will always show up as temp1_*
>          */
> +       if (pkg_flag)
> +               attr_no = 1;
> +       else
> +               attr_no = TO_ATTR_NO(c->cpu_core_id);
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
> -       }
> +       if (attr_no > MAX_CORE_DATA - 1)
> +               return -ERANGE;
> 
> -       if ((err = sysfs_create_group(&pdev->dev.kobj, &coretemp_group)))
> -               goto exit_dev;
> +       /* Skip if it is a HT core, Not an error */
> +       if (pdata->core_data[attr_no] != NULL)
> +               return 0;
> +
> +       tdata = init_temp_data(cpu, c->cpu_core_id, pkg_flag);
> +       if (!tdata)
> +               return -ENOMEM;
> 
> -       data->hwmon_dev = hwmon_device_register(&pdev->dev);
> -       if (IS_ERR(data->hwmon_dev)) {
> -               err = PTR_ERR(data->hwmon_dev);
> -               dev_err(&pdev->dev, "Class registration failed (%d)\n",
> -                       err);
> -               goto exit_class;
> -       }
> +       /* Test if we can access the status register */
> +       err = rdmsr_safe_on_cpu(cpu, tdata->status_reg, &eax, &edx);
> +       if (err)
> +               goto exit_free;
> +
> +       /* Create sysfs interfaces */
> +       err = create_core_attrs(tdata, &pdev->dev, attr_no);
> +       if (err)
> +               goto exit_free;
> +
Creating sysfs attributes before initialization is complete is not a good idea
and results in race conditions.

> +       /* Get Critical Temperature */
> +       if (pkg_flag)
> +               tdata->tjmax = get_pkg_tjmax(pdev->id, &pdev->dev);
> +       else
> +               tdata->tjmax = get_tjmax(c, cpu, &pdev->dev);
> +
> +       update_ttarget(c->x86_model, tdata, &pdev->dev);
> +
> +       pdata->core_data[attr_no] = tdata;

... especially if this pointer isn't even set. 

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
> 
> +       /* Initialize the per-package data structures */
> +       pdata = kzalloc(sizeof(struct platform_data), GFP_KERNEL);
> +       if (!pdata)
> +               return -ENOMEM;
> +
> +       pdata->phys_proc_id = c->phys_proc_id;
> +
> +       err = create_name_attr(pdata, &pdev->dev);
> +       if (err)
> +               goto exit_free;
> +
> +       /* Check the microcode version of the CPU */
> +       err = chk_ucode_version(c, pdev);
> +       if (err)
> +               goto exit_name;
> +
You can and should check this before creating any attributes.

> +       platform_set_drvdata(pdev, pdata);
> +
> +       pdata->hwmon_dev = hwmon_device_register(&pdev->dev);
> +       if (IS_ERR(pdata->hwmon_dev)) {
> +               err = PTR_ERR(pdata->hwmon_dev);
> +               dev_err(&pdev->dev, "Class registration failed (%d)\n", err);
> +               goto exit_name;
> +       }
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
> +
> +       for (i = MAX_CORE_DATA - 1; i >= 0; --i)
> +               coretemp_remove_core(pdata, &pdev->dev, i);
> 
> -       hwmon_device_unregister(data->hwmon_dev);
> -       sysfs_remove_group(&pdev->dev.kobj, &coretemp_group);
> -       device_remove_file(&pdev->dev, &sensor_dev_attr_temp1_max.dev_attr);
> +       device_remove_file(&pdev->dev, &pdata->name_attr);
> +       hwmon_device_unregister(pdata->hwmon_dev);
>         platform_set_drvdata(pdev, NULL);
> -       kfree(data);
> +       kfree(pdata);
>         return 0;
>  }
> 
> @@ -434,6 +587,52 @@ struct pdev_entry {
>  static LIST_HEAD(pdev_list);
>  static DEFINE_MUTEX(pdev_list_mutex);
> 
> +static struct platform_device *coretemp_get_pdev(u16 phys_proc_id)
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
> +static void coretemp_add_core(unsigned int cpu, int pkg_flag)
> +{
> +       int err;
> +       struct platform_data *pdata;
> +       struct cpuinfo_x86 *c = &cpu_data(cpu);
> +       struct platform_device *pdev = coretemp_get_pdev(c->phys_proc_id);
> +
> +       if (!pdev)
> +               return;
> +
> +       pdata = platform_get_drvdata(pdev);
> +
> +       err = create_core_data(pdata, pdev, cpu, pkg_flag);
> +       if (err) {
> +               dev_err(&pdev->dev, "Adding Core %u on Pkg %u failed\n",
> +                       cpu, c->phys_proc_id);
> +       }
> +}
> +
> +static void coretemp_remove_core(struct platform_data *pdata,
> +                                       struct device *dev, int indx)
> +{
> +       if (pdata->core_data[indx] = NULL)
> +               return;
> +
> +       remove_attrs(dev, pdata->core_data[indx]);
> +       kfree(pdata->core_data[indx]);
> +       pdata->core_data[indx] = NULL;
> +}

I am quite concerned that above code is not mutex protected. Are you sure this
can not cause race conditions, for example if a CPU is taken offline while the
coretemp module is unloaded exactly at the same time ?

> +
>  static int __cpuinit coretemp_device_add(unsigned int cpu)
>  {
>         int err;
> @@ -441,30 +640,8 @@ static int __cpuinit coretemp_device_add(unsigned int cpu)
>         struct pdev_entry *pdev_entry;
>         struct cpuinfo_x86 *c = &cpu_data(cpu);
> 
> -       /*
> -        * CPUID.06H.EAX[0] indicates whether the CPU has thermal
> -        * sensors. We check this bit only, all the early CPUs
> -        * without thermal sensors will be filtered out.
> -        */
> -       if (!cpu_has(c, X86_FEATURE_DTS)) {
> -               pr_info("CPU (model=0x%x) has no thermal sensor\n",
> -                       c->x86_model);
> -               return 0;
> -       }
> -
>         mutex_lock(&pdev_list_mutex);
> 
> -#ifdef CONFIG_SMP
> -       /* Skip second HT entry of each core */
> -       list_for_each_entry(pdev_entry, &pdev_list, list) {
> -               if (c->phys_proc_id = pdev_entry->phys_proc_id &&
> -                   c->cpu_core_id = pdev_entry->cpu_core_id) {
> -                       err = 0;        /* Not an error */
> -                       goto exit;
> -               }
> -       }
> -#endif
> -
>         pdev = platform_device_alloc(DRVNAME, cpu);
>         if (!pdev) {
>                 err = -ENOMEM;
> @@ -504,26 +681,62 @@ exit:
>         return err;
>  }
> 
> -static void __cpuinit coretemp_device_remove(unsigned int cpu)
> +static void get_core_online(unsigned int cpu)
>  {
> -       struct pdev_entry *p;
> -       unsigned int i;
> -
> -       mutex_lock(&pdev_list_mutex);
> -       list_for_each_entry(p, &pdev_list, list) {
> -               if (p->cpu != cpu)
> -                       continue;
> +       struct cpuinfo_x86 *c = &cpu_data(cpu);
> +       struct platform_device *pdev = coretemp_get_pdev(c->phys_proc_id);
> +       int err;
> 
> -               platform_device_unregister(p->pdev);
> -               list_del(&p->list);
> -               mutex_unlock(&pdev_list_mutex);
> -               kfree(p);
> -               for_each_cpu(i, cpu_sibling_mask(cpu))
> -                       if (i != cpu && !coretemp_device_add(i))
> -                               break;
> +       /*
> +        * CPUID.06H.EAX[0] indicates whether the CPU has thermal
> +        * sensors. We check this bit only, all the early CPUs
> +        * without thermal sensors will be filtered out.
> +        */
> +       if (!cpu_has(c, X86_FEATURE_DTS))
>                 return;
> +
> +       if (!pdev) {
> +               /*
> +                * Alright, we have DTS support.
> +                * We are bringing the _first_ core in this pkg
> +                * online. So, initialize per-pkg data structures and
> +                * then bring this core online.
> +                */
> +               err = coretemp_device_add(cpu);
> +               if (err)
> +                       return;
> +               /*
> +                * Check whether pkgtemp support is available.
> +                * If so, add interfaces for pkgtemp.
> +                */
> +               if (cpu_has(c, X86_FEATURE_PTS))
> +                       coretemp_add_core(cpu, 1);
>         }
> -       mutex_unlock(&pdev_list_mutex);
> +
> +       /*
> +        * Physical CPU device already exists.
> +        * So, just add interfaces for this core.
> +        */
> +       coretemp_add_core(cpu, 0);
> +}
> +
> +static void put_core_offline(unsigned int cpu)
> +{
> +       int indx;
> +       struct platform_data *pdata;
> +       struct cpuinfo_x86 *c = &cpu_data(cpu);
> +       struct platform_device *pdev = coretemp_get_pdev(c->phys_proc_id);
> +
> +       /* If the physical CPU device does not exist, just return */
> +       if (!pdev)
> +               return;
> +
> +       pdata = platform_get_drvdata(pdev);
> +
> +       indx = TO_ATTR_NO(c->cpu_core_id);
> +
> +       if (pdata->core_data[indx] && pdata->core_data[indx]->cpu = cpu)
> +               coretemp_remove_core(pdata, &pdev->dev, indx);
>  }
> 
>  static int __cpuinit coretemp_cpu_callback(struct notifier_block *nfb,
> @@ -534,10 +747,10 @@ static int __cpuinit coretemp_cpu_callback(struct notifier_block *nfb,
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
> @@ -547,10 +760,11 @@ static struct notifier_block coretemp_cpu_notifier __refdata = {
>         .notifier_call = coretemp_cpu_callback,
>  };
> 
> +
>  static int __init coretemp_init(void)
>  {
>         int i, err = -ENODEV;
> -
> +
>         /* quick check if we run Intel */
>         if (cpu_data(0).x86_vendor != X86_VENDOR_INTEL)
>                 goto exit;
> @@ -560,7 +774,7 @@ static int __init coretemp_init(void)
>                 goto exit;
> 
>         for_each_online_cpu(i)
> -               coretemp_device_add(i);
> +               get_core_online(i);
> 
This code should now be in the probe function, and be called before
the hwmon device is registered.

>  #ifndef CONFIG_HOTPLUG_CPU
>         if (list_empty(&pdev_list)) {
> --
> 1.6.1
> 





_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
