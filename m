From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 16 Feb 2011 19:18:59 +0000
Subject: Re: [lm-sensors] [PATCH-v2:RFC][hwmon]:Merging_Pkgtemp_with_Coretemp
Message-Id: <20110216191859.GA15398@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1297637681-1275-1-git-send-email-durgadoss.r@intel.com>
In-Reply-To: <1297637681-1275-1-git-send-email-durgadoss.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Feb 13, 2011 at 05:54:41PM -0500, Durgadoss R wrote:
> This patch merges the pkg temp driver with the coretemp driver.
> 
> The data common to both the pkgtemp and coretemp is moved to a
> common structure temp_data. The CPU id related info are stored in
> struct cpu_id_info.
> 
> Changes from v1 of this patch:
> There will be one hwmon device per physical CPU. This device will
> have all the attributes for the temperature sensors supported by
> the physical CPU.
> 
> Signed-off-by: Durgadoss R <durgadoss.r@intel.com>

I tried to install your patch, but must have done something wrong - it crashes for 
me with a null pointer access. System is running 2.6.35, so it might not be the 
driver's fault but something I missed while backporting it.

Anyway, couple of comments inline.

> ---
>  drivers/hwmon/coretemp.c |  363 ++++++++++++++++++++++++++++++++--------------
>  1 files changed, 253 insertions(+), 110 deletions(-)
> 
> diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> index 42de98d..63874a6 100644
> --- a/drivers/hwmon/coretemp.c
> +++ b/drivers/hwmon/coretemp.c
> @@ -39,87 +39,151 @@
> 
>  #define DRVNAME        "coretemp"
> 
> -typedef enum { SHOW_TEMP, SHOW_TJMAX, SHOW_TTARGET, SHOW_LABEL,
> -               SHOW_NAME } SHOW;
> +static DEFINE_MUTEX(update_lock);
> 
Not a good idea. You don't want any global variables.

> -/*
> - * Functions declaration
> - */
> +enum { COREID, PHYS_PROCID, DRV_NAME };
> 
> -static struct coretemp_data *coretemp_update_device(struct device *dev);
> +struct temp_data {     /* Temperature Data common to both pkg and core */
> +       int temp;
> +       int ttarget;
> +       u8 crit_alarm;
> +       u8 max_alarm;
> +       unsigned long last_updated;     /* in jiffies */
> +};
> 
> -struct coretemp_data {
> -       struct device *hwmon_dev;
> -       struct mutex update_lock;
> -       const char *name;
> +struct cpu_id_info {
>         u32 id;
>         u16 core_id;
> -       char valid;             /* zero until following fields are valid */
> -       unsigned long last_updated;     /* in jiffies */
> -       int temp;
> +       u16 phys_proc_id;
> +};
> +
> +struct platform_data {
> +       struct device *hwmon_dev;
> +       const char *name;
>         int tjmax;
> -       int ttarget;
> -       u8 alarm;
> +       int pkg_support;
> +       struct cpu_id_info *cpu_data;
> +       struct temp_data *core_data;
> +       struct temp_data *pkg_data;
>  };
> 
> +/* Functions Declaration */
> +static int update_curr_temp(struct temp_data *tdata, u32 eax, int tjmax);
> +
>  /*
>   * Sysfs stuff
>   */
> 
>  static ssize_t show_name(struct device *dev, struct device_attribute
> -                         *devattr, char *buf)
> +                                                         *devattr, char *buf)
>  {
> -       int ret;
>         struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -       struct coretemp_data *data = dev_get_drvdata(dev);
> +       struct platform_data *data = dev_get_drvdata(dev);
> +
> +       switch (attr->index) {
> +       case DRV_NAME:
> +               return sprintf(buf, "%s\n", data->name);
> +       case COREID:
> +               return sprintf(buf, "Core %d\n", data->cpu_data->core_id);
> +       case PHYS_PROCID:
> +               return sprintf(buf, "Physical id %d\n",
> +                                               data->cpu_data->phys_proc_id);
> +       default:
> +               return -EINVAL;
> +       }
> +}
> 
> -       if (attr->index = SHOW_NAME)
> -               ret = sprintf(buf, "%s\n", data->name);
> -       else    /* show label */
> -               ret = sprintf(buf, "Core %d\n", data->core_id);
> -       return ret;
> +static ssize_t show_crit_alarm(struct device *dev, struct device_attribute
> +                                                         *devattr, char *buf)
> +{
> +       u32 eax, edx;
> +       struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +       struct platform_data *data = dev_get_drvdata(dev);
> +
> +       switch (attr->index) {
> +       case 0:
> +               rdmsr_on_cpu(data->cpu_data->id, MSR_IA32_THERM_STATUS,
> +                                                               &eax, &edx);
> +               data->core_data->crit_alarm = (eax >> 5) & 1;
> +               return sprintf(buf, "%d\n", data->core_data->crit_alarm);
> +       case 1:
> +               rdmsr_on_cpu(data->cpu_data->id, MSR_IA32_PACKAGE_THERM_STATUS,
> +                                                               &eax, &edx);
> +               data->pkg_data->crit_alarm = (eax >> 5) & 1;
> +               return sprintf(buf, "%d\n", data->pkg_data->crit_alarm);
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
> +static ssize_t show_tjmax(struct device *dev,
> +                               struct device_attribute *devattr, char *buf)
> +{
> +       struct platform_data *data = dev_get_drvdata(dev);
> +       return sprintf(buf, "%d\n", data->tjmax);
>  }
> 
> -static ssize_t show_alarm(struct device *dev, struct device_attribute
> -                         *devattr, char *buf)
> +static ssize_t show_ttarget(struct device *dev,
> +                               struct device_attribute *devattr, char *buf)
>  {
> -       struct coretemp_data *data = coretemp_update_device(dev);
> -       /* read the Out-of-spec log, never clear */
> -       return sprintf(buf, "%d\n", data->alarm);
> +       struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +       struct platform_data *data = dev_get_drvdata(dev);
> +
> +       switch (attr->index) {
> +       case 0:
> +               return sprintf(buf, "%d\n", data->core_data->ttarget);
> +       case 1:
> +               return sprintf(buf, "%d\n", data->pkg_data->ttarget);
> +       default:
> +               return -EINVAL;
> +       }
>  }
> 
>  static ssize_t show_temp(struct device *dev,
> -                        struct device_attribute *devattr, char *buf)
> +                               struct device_attribute *devattr, char *buf)
>  {
> +       u32 eax, edx;
>         struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -       struct coretemp_data *data = coretemp_update_device(dev);
> +       struct platform_data *data = dev_get_drvdata(dev);
>         int err;
> 
> -       if (attr->index = SHOW_TEMP)
> -               err = data->valid ? sprintf(buf, "%d\n", data->temp) : -EAGAIN;
> -       else if (attr->index = SHOW_TJMAX)
> -               err = sprintf(buf, "%d\n", data->tjmax);
> -       else
> -               err = sprintf(buf, "%d\n", data->ttarget);
> -       return err;
> +       switch (attr->index) {
> +       case 0:
> +               rdmsr_on_cpu(data->cpu_data->id, MSR_IA32_THERM_STATUS,
> +                                                               &eax, &edx);
> +               err = update_curr_temp(data->core_data, eax, data->tjmax);
> +               return err ? err : sprintf(buf, "%d\n", data->core_data->temp);
> +       case 1:
> +               rdmsr_on_cpu(data->cpu_data->id, MSR_IA32_PACKAGE_THERM_STATUS,
> +                                                               &eax, &edx);
> +               err = update_curr_temp(data->pkg_data, eax, data->tjmax);
> +               return err ? err : sprintf(buf, "%d\n", data->pkg_data->temp);
> +       default:
> +               return -EINVAL;
> +       }
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
> +/* Attributes per physical CPU */
> +static SENSOR_DEVICE_ATTR(name, S_IRUGO, show_name, NULL, DRV_NAME);
> +static SENSOR_DEVICE_ATTR(temp1_crit, S_IRUGO, show_tjmax, NULL, 0);
> +/* Coretemp attributes */
> +static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, show_name, NULL, COREID);
> +static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);
> +static SENSOR_DEVICE_ATTR(temp1_max, S_IRUGO, show_ttarget, NULL, 0);
> +static SENSOR_DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_crit_alarm, NULL, 0);
> +/* Packagetemp attributes */
> +static SENSOR_DEVICE_ATTR(temp2_label, S_IRUGO, show_name, NULL, PHYS_PROCID);
> +static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 1);
> +static SENSOR_DEVICE_ATTR(temp2_max, S_IRUGO, show_ttarget, NULL, 1);
> +static SENSOR_DEVICE_ATTR(temp2_crit_alarm, S_IRUGO, show_crit_alarm, NULL, 1);
> 
Still not the right approach here. I could not test the driver, but since you
only have two sets of sensors it can not do what it is supposed to do if there
are multiple cores. Again, we would expect a single instance of the driver
to handle all cores plus the package sensor. Looks like you merged core temp
with pkg temp, but you still create an instance of the driver per core.
And I am not sure if the package temp now shows up on each core.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
