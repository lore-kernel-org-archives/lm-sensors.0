From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 07 Apr 2008 09:46:48 +0000
Subject: Re: [lm-sensors] [PATCH 2/3] thermal: add hwmon sys I/F
Message-Id: <20080407114648.46cec5c6@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1207123693.27304.6.camel@acpi-hp-zz.sh.intel.com>
In-Reply-To: <1207123693.27304.6.camel@acpi-hp-zz.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>, Hans de Goede <j.w.r.degoede@hhs.nl>

Hi Rui,

On Wed, 02 Apr 2008 16:08:13 +0800, Zhang, Rui wrote:
> 
> Add hwmon sys I/F for generic thermal driver.
> 
> Note: we have one hwmon class device for _EACH_ type of the thermal zone device.

Great. Review:

> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/thermal/thermal.c |  155 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/thermal.h   |   25 +++++++
>  2 files changed, 180 insertions(+)
> 
> Index: linux-2.6/drivers/thermal/thermal.c
> =================================> --- linux-2.6.orig/drivers/thermal/thermal.c
> +++ linux-2.6/drivers/thermal/thermal.c
> @@ -30,6 +30,7 @@
>  #include <linux/idr.h>
>  #include <linux/thermal.h>
>  #include <linux/spinlock.h>
> +#include <linux/hwmon.h>

This should probably be moved down inside the #if block.

>  
>  MODULE_AUTHOR("Zhang Rui");
>  MODULE_DESCRIPTION("Generic thermal management sysfs support");
> @@ -291,6 +292,155 @@ thermal_cooling_device_trip_point_show(s
>  
>  /* Device management */
>  
> +#if defined(CONFIG_HWMON) ||	\
> +	(defined(CONFIG_HWMON_MODULE) && defined(CONFIG_THERMAL_MODULE))
> +/* hwmon sys I/F */
> +static LIST_HEAD(thermal_hwmon_list);
> +
> +static ssize_t
> +name_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct hwmon_device_instance *hwmon > +			container_of(attr, struct hwmon_device_instance, name);
> +	return sprintf(buf, "%s\n", hwmon->type);
> +}
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
> +	struct hwmon_device_instance *hwmon;
> +	int result;
> +
> +	mutex_lock(&thermal_list_lock);
> +	list_for_each_entry(hwmon, &thermal_hwmon_list, node)
> +		if (!strcmp(hwmon->type, tz->type)) {
> +			list_add_tail(&tz->hwmon_node,
> +				      &hwmon->tz_list);
> +			mutex_unlock(&thermal_list_lock);
> +			tz->hwmon = hwmon;
> +			goto register_sys_interface;
> +		}
> +	mutex_unlock(&thermal_list_lock);
> +
> +	hwmon = kzalloc(sizeof(struct hwmon_device_instance), GFP_KERNEL);
> +	if (!hwmon)
> +		return -ENOMEM;
> +
> +	INIT_LIST_HEAD(&hwmon->tz_list);
> +	strcpy(hwmon->type, tz->type);

Please use strlcpy instead (or don't copy the string at all, see below).

> +	hwmon->device = hwmon_device_register(NULL);
> +	hwmon->name.attr.name = "name";
> +	hwmon->name.attr.mode = 0444;
> +	hwmon->name.show = name_show;
> +	result = device_create_file(hwmon->device, &hwmon->name);

The name attribute is the same for all hwmon devices you create, so it
doesn't need to be created dynamically. Create it once and for all
using DEVICE_ATTR().

> +	if (result)
> +		return result;

This lacks error handling. You have allocated hwmon, you need to free
it before returning an error.

> +
> +

Double blank line, please remove one.

> +	mutex_lock(&thermal_list_lock);
> +	list_add_tail(&hwmon->node, &thermal_hwmon_list);
> +	list_add_tail(&tz->hwmon_node, &hwmon->tz_list);
> +	mutex_unlock(&thermal_list_lock);
> +
> +	tz->hwmon = hwmon;
> +
> +  register_sys_interface:

Should be indented with a single space according to checkpatch.

> +	hwmon->count++;
> +
> +	sprintf(tz->temp_input.name, "temp%d_input", hwmon->count);
> +	tz->temp_input.attr.attr.name = tz->temp_input.name;
> +	tz->temp_input.attr.attr.mode = 0444;
> +	tz->temp_input.attr.show = temp_input_show;
> +	result = device_create_file(hwmon->device, &tz->temp_input.attr);
> +	if (result)
> +		return result;

Here again, you need a proper error path, otherwise you leave things
half registered and bad things will happen.

> +
> +	if (tz->trips > 0) {
> +		char buf[40];
> +		result = tz->ops->get_trip_type(tz, 0, buf);

What guarantees that buf won't be overrun?

> +		if (result > 0 && !strcmp(buf, "critical\n")) {
> +			sprintf(tz->temp_crit.name,
> +				"temp%d_crit", hwmon->count);

Please use snprintf instead.

> +			tz->temp_crit.attr.attr.name = tz->temp_crit.name;
> +			tz->temp_crit.attr.attr.mode = 0444;
> +			tz->temp_crit.attr.show = temp_crit_show;
> +			result = device_create_file(hwmon->device,
> +						    &tz->temp_crit.attr);
> +			if (result)
> +				return result;

Missing error path.

> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int
> +thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz)
> +{
> +	struct hwmon_device_instance *hwmon;
> +
> +	mutex_lock(&thermal_list_lock);
> +	list_for_each_entry(hwmon, &thermal_hwmon_list, node) {
> +		if (strcmp(hwmon->type, tz->type))
> +			continue;

I don't get why you are walking thermal_hwmon_list to find the right
hwmon_device_instance, when you have it available directly as tz->hwmon?

> +
> +		device_remove_file(hwmon->device, &tz->temp_input.attr);
> +		if (!tz->temp_crit.attr.attr.name)

This test looks broken. Note that you don't really need a test,
as it's OK to remove a sysfs file that does not exist.

> +			device_remove_file(hwmon->device, &tz->temp_crit.attr);
> +		list_del(&tz->hwmon_node);
> +		if (list_empty(&tz->hwmon->tz_list)) {
> +			device_remove_file(tz->hwmon->device, &tz->hwmon->name);
> +			hwmon_device_unregister(tz->hwmon->device);
> +			list_del(&tz->hwmon->node);
> +			mutex_unlock(&thermal_list_lock);
> +			return 0;
> +		}

The logic looks incorrect to me. If tz->hwmon->tz_list is not empty, you
should still return 0 (success).

> +	}
> +	mutex_unlock(&thermal_list_lock);
> +
> +	return -EINVAL;
> +}
> +#else
> +static int
> +thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
> +{
> +	return 0;
> +}
> +
> +static int
> +thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz)
> +{
> +	return 0;
> +}
> +#endif
> +
> +
>  /**
>   * thermal_zone_bind_cooling_device - bind a cooling device to a thermal zone
>   * @tz:		thermal zone device
> @@ -638,6 +788,10 @@ struct thermal_zone_device *thermal_zone
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
> @@ -696,6 +850,7 @@ void thermal_zone_device_unregister(stru
>  	for (count = 0; count < tz->trips; count++)
>  		TRIP_POINT_ATTR_REMOVE(&tz->device, count);
>  
> +	thermal_remove_hwmon_sysfs(tz);

No check for error? If so, the function should return void.

>  	release_idr(&thermal_tz_idr, &thermal_idr_lock, tz->id);
>  	idr_destroy(&tz->idr);
>  	mutex_destroy(&tz->lock);
> Index: linux-2.6/include/linux/thermal.h
> =================================> --- linux-2.6.orig/include/linux/thermal.h
> +++ linux-2.6/include/linux/thermal.h
> @@ -65,6 +65,24 @@ struct thermal_cooling_device {
>  				((long)t-2732+5)/10 : ((long)t-2732-5)/10)
>  #define CELSIUS_TO_KELVIN(t)	((t)*10+2732)
>  
> +#if defined(CONFIG_HWMON) ||	\
> +	(defined(CONFIG_HWMON_MODULE) && defined(CONFIG_THERMAL_MODULE))
> +/* thermal zone devices with the same type share one hwmon device */
> +struct hwmon_device_instance {

I'd rather name this thermal_hwmon_device. Something starting with
"hwmon_" could collide with future evolutions of the hwmon subsystem.

> +	char type[THERMAL_NAME_LENGTH];

Can't this be a simple pointer to the thermal zone's type field? This
would save a string copy.

> +	struct device *device;
> +	struct device_attribute name;
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
> @@ -76,6 +94,13 @@ struct thermal_zone_device {
>  	struct idr idr;
>  	struct mutex lock;	/* protect cooling devices list */
>  	struct list_head node;
> +#if defined(CONFIG_HWMON) ||	\
> +	(defined(CONFIG_HWMON_MODULE) && defined(CONFIG_THERMAL_MODULE))
> +	struct list_head hwmon_node;	/* node in thermal_hwmon_list */

The comment doesn't match the code: hwmon_node goes in one of the
hwmon->tz_list lists, not thermal_hwmon_list.

> +	struct hwmon_device_instance *hwmon;
> +	struct thermal_hwmon_attr temp_input;	/* hwmon sys attr */
> +	struct thermal_hwmon_attr temp_crit;	/* hwmon sys attr */
> +#endif
>  };
>  
>  struct thermal_zone_device *thermal_zone_device_register(char *, int, void *,
> 
> 

I will look into the required libsensors changes to handle this patch.
I have something already by Hans wasn't totally happy with it IIRC.

One thing that worries me is the hwmon device name. It comes directly
from the thermal zone's type ("ACPI thermal zone" in the ACPI case".)
We have no control over that name, while libsensors makes some
assumptions on it. For example it assumes that there is no dash in a
hwmon device name. So far, all hwmon device names also didn't have
spaces, nor uppercase letters, and were much shorter (ACPI thermal zone
would be something like "acpi_tz".) I hope that applications didn't
make too many assumptions on length or content...

I'm not sure yet if and how we want to address this problem. Maybe we
could have a "short name" field in struct thermal_zone_device. Or
alternatively I could add a conversion function to libsensors, that
would convert "ACPI thermal zone" to "acpi_thermal_zone". The latter
approach doesn't help with the length, but at least it normalizes the
character set.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
