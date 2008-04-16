From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 16 Apr 2008 20:45:55 +0000
Subject: Re: [lm-sensors] [PATCH 3/6] thermal: add hwmon sysfs I/F
Message-Id: <20080416224555.15304b3d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1207815360.27304.39.camel@acpi-hp-zz.sh.intel.com>
In-Reply-To: <1207815360.27304.39.camel@acpi-hp-zz.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: Len Brown <lenb@kernel.org>, Hans de Goede <j.w.r.degoede@hhs.nl>, linux-acpi <linux-acpi@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, waldi@debian.org

Hi Rui,

On Thu, 10 Apr 2008 16:16:00 +0800, Zhang, Rui wrote:
> 
> Add hwmon sys I/F for generic thermal driver.
> 
> Note: we have one hwmon class device for EACH TYPE of the thermal zone device.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/thermal/thermal.c |  164 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/thermal.h   |   24 ++++++
>  2 files changed, 188 insertions(+)

Much better than the previous version but there are a few problems left:

> 
> Index: linux-2.6/drivers/thermal/thermal.c
> =================================> --- linux-2.6.orig/drivers/thermal/thermal.c
> +++ linux-2.6/drivers/thermal/thermal.c
> @@ -291,6 +291,165 @@ thermal_cooling_device_trip_point_show(s
>  
>  /* Device management */
>  
> +#if defined(CONFIG_HWMON) ||	\
> +	(defined(CONFIG_HWMON_MODULE) && defined(CONFIG_THERMAL_MODULE))
> +/* hwmon sys I/F */
> +#include <linux/hwmon.h>
> +static LIST_HEAD(thermal_hwmon_list);
> +
> +static ssize_t
> +name_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct thermal_hwmon_device *hwmon = dev->driver_data;
> +	return sprintf(buf, "%s\n", hwmon->type);
> +}
> +static DEVICE_ATTR(name, 0444, name_show, NULL);
> +
> +static ssize_t
> +temp_input_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct thermal_hwmon_attr *hwmon_attr
> +			= container_of(attr, struct thermal_hwmon_attr, attr);
> +	struct thermal_zone_device *tz
> +			= container_of(hwmon_attr, struct thermal_zone_device,
> +				       temp_input);
> +
> +	return tz->ops->get_temp(tz, buf);
> +}
> +
> +static ssize_t
> +temp_crit_show(struct device *dev, struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct thermal_hwmon_attr *hwmon_attr
> +			= container_of(attr, struct thermal_hwmon_attr, attr);
> +	struct thermal_zone_device *tz
> +			= container_of(hwmon_attr, struct thermal_zone_device,
> +				       temp_crit);
> +
> +	return tz->ops->get_trip_temp(tz, 0, buf);
> +}
> +
> +
> +static int
> +thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
> +{
> +	struct thermal_hwmon_device *hwmon;
> +	int new_hwmon_device = 0;
> +	int result;
> +
> +	mutex_lock(&thermal_list_lock);
> +	list_for_each_entry(hwmon, &thermal_hwmon_list, node)
> +		if (!strcmp(hwmon->type, tz->type)) {
> +			new_hwmon_device = 1;
> +			mutex_unlock(&thermal_list_lock);
> +			goto register_sys_interface;
> +		}
> +	mutex_unlock(&thermal_list_lock);

I'm confused. new_hwmon_device is set to 1 when you do NOT create a new
hwmon device, and to 0 when you DO create a new hwmon device? Wouldn't
it make way more sense the other way around?

> +
> +	hwmon = kzalloc(sizeof(struct thermal_hwmon_device), GFP_KERNEL);
> +	if (!hwmon)
> +		return -ENOMEM;
> +
> +	INIT_LIST_HEAD(&hwmon->tz_list);
> +	strncpy(hwmon->type, tz->type, THERMAL_NAME_LENGTH);

strlcpy please. strncpy is broken by design and should never be used.

> +	hwmon->device = hwmon_device_register(NULL);
> +	if (IS_ERR(hwmon->device)) {
> +		result = -EINVAL;

Better return the actual error code: PTR_ERR(hwmon->device).

> +		goto free_mem;
> +	}
> +	hwmon->device->driver_data = hwmon;
> +	result = device_create_file(hwmon->device, &dev_attr_name);
> +	if (result)
> +		goto unregister_hwmon_device;
> +
> + register_sys_interface:
> +	tz->hwmon = hwmon;
> +	hwmon->count++;
> +
> +	snprintf(tz->temp_input.name, THERMAL_NAME_LENGTH,
> +		 "temp%d_input", hwmon->count);
> +	tz->temp_input.attr.attr.name = tz->temp_input.name;
> +	tz->temp_input.attr.attr.mode = 0444;
> +	tz->temp_input.attr.show = temp_input_show;
> +	result = device_create_file(hwmon->device, &tz->temp_input.attr);
> +	if (result)
> +		goto unregister_hwmon_device;
> +
> +	if (tz->ops->get_crit_temp) {
> +		unsigned long temperature;
> +		if (!tz->ops->get_crit_temp(tz, &temperature)) {
> +			snprintf(tz->temp_crit.name, THERMAL_NAME_LENGTH,
> +				"temp%d_crit", hwmon->count);
> +			tz->temp_crit.attr.attr.name = tz->temp_crit.name;
> +			tz->temp_crit.attr.attr.mode = 0444;
> +			tz->temp_crit.attr.show = temp_crit_show;
> +			result = device_create_file(hwmon->device,
> +						    &tz->temp_crit.attr);
> +			if (result)
> +				goto unregister_hwmon_device;
> +		}
> +	}
> +
> +	mutex_lock(&thermal_list_lock);
> +	if (!new_hwmon_device)
> +		list_add_tail(&hwmon->node, &thermal_hwmon_list);
> +	list_add_tail(&tz->hwmon_node, &hwmon->tz_list);
> +	mutex_unlock(&thermal_list_lock);
> +
> +	return 0;
> +
> + unregister_hwmon_device:
> +	device_remove_file(hwmon->device, &tz->temp_crit.attr);
> +	device_remove_file(hwmon->device, &tz->temp_input.attr);
> +	if (!new_hwmon_device) {
> +		device_remove_file(hwmon->device, &dev_attr_name);
> +		hwmon_device_unregister(hwmon->device);
> +	}
> + free_mem:
> +	kfree(hwmon);

This kfree should be conditioned by the value of new_hwmon_device.

> +
> +	return result;
> +}
> +
> +static void
> +thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz)
> +{
> +	struct thermal_hwmon_device *hwmon = tz->hwmon;
> +
> +	tz->hwmon = NULL;
> +	device_remove_file(hwmon->device, &tz->temp_input.attr);
> +	device_remove_file(hwmon->device, &tz->temp_crit.attr);
> +
> +	mutex_lock(&thermal_list_lock);
> +	list_del(&tz->hwmon_node);
> +	if (!list_empty(&hwmon->tz_list)) {
> +		mutex_unlock(&thermal_list_lock);
> +		return;
> +	}
> +	list_del(&hwmon->node);
> +	mutex_unlock(&thermal_list_lock);
> +
> +	device_remove_file(hwmon->device, &dev_attr_name);
> +	hwmon_device_unregister(hwmon->device);
> +	kfree(hwmon);
> +	return;

Void functions need no return.

> +}
> +#else
> +static int
> +thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
> +{
> +	return 0;
> +}
> +
> +static void
> +thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz)
> +{
> +	return;

Idem.

> +}
> +#endif
> +
> +
>  /**
>   * thermal_zone_bind_cooling_device - bind a cooling device to a thermal zone
>   * @tz:		thermal zone device
> @@ -638,6 +797,10 @@ struct thermal_zone_device *thermal_zone
>  			goto unregister;
>  	}
>  
> +	result = thermal_add_hwmon_sysfs(tz);
> +	if (result)
> +		goto unregister;
> +
>  	mutex_lock(&thermal_list_lock);
>  	list_add_tail(&tz->node, &thermal_tz_list);
>  	if (ops->bind)
> @@ -696,6 +859,7 @@ void thermal_zone_device_unregister(stru
>  	for (count = 0; count < tz->trips; count++)
>  		TRIP_POINT_ATTR_REMOVE(&tz->device, count);
>  
> +	thermal_remove_hwmon_sysfs(tz);
>  	release_idr(&thermal_tz_idr, &thermal_idr_lock, tz->id);
>  	idr_destroy(&tz->idr);
>  	mutex_destroy(&tz->lock);
> Index: linux-2.6/include/linux/thermal.h
> =================================> --- linux-2.6.orig/include/linux/thermal.h
> +++ linux-2.6/include/linux/thermal.h
> @@ -66,6 +66,23 @@ struct thermal_cooling_device {
>  				((long)t-2732+5)/10 : ((long)t-2732-5)/10)
>  #define CELSIUS_TO_KELVIN(t)	((t)*10+2732)
>  
> +#if defined(CONFIG_HWMON) ||	\
> +	(defined(CONFIG_HWMON_MODULE) && defined(CONFIG_THERMAL_MODULE))
> +/* thermal zone devices with the same type share one hwmon device */
> +struct thermal_hwmon_device {
> +	char type[THERMAL_NAME_LENGTH];
> +	struct device *device;
> +	int count;
> +	struct list_head tz_list;
> +	struct list_head node;
> +};
> +
> +struct thermal_hwmon_attr {
> +	struct device_attribute attr;
> +	char name[16];
> +};
> +#endif
> +
>  struct thermal_zone_device {
>  	int id;
>  	char type[THERMAL_NAME_LENGTH];
> @@ -77,6 +94,13 @@ struct thermal_zone_device {
>  	struct idr idr;
>  	struct mutex lock;	/* protect cooling devices list */
>  	struct list_head node;
> +#if defined(CONFIG_HWMON) ||	\
> +	(defined(CONFIG_HWMON_MODULE) && defined(CONFIG_THERMAL_MODULE))
> +	struct list_head hwmon_node;
> +	struct thermal_hwmon_device *hwmon;
> +	struct thermal_hwmon_attr temp_input;	/* hwmon sys attr */
> +	struct thermal_hwmon_attr temp_crit;	/* hwmon sys attr */
> +#endif
>  };
>  
>  struct thermal_zone_device *thermal_zone_device_register(char *, int, void *,
> 
> 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
