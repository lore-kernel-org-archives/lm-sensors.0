From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Wed, 27 Feb 2008 08:32:15 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] thermal: add hwmon sys I/F for thermal
Message-Id: <47C5200F.7000006@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <1203975102.10256.82.camel@acpi-hp-zz.sh.intel.com>	 <47C3D04E.6090609@hhs.nl> <1204062023.10256.100.camel@acpi-hp-zz.sh.intel.com>
In-Reply-To: <1204062023.10256.100.camel@acpi-hp-zz.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>, Jean Delvare <khali@linux-fr.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Thomas Renninger <trenn@suse.de>, "Thomas, Sujith" <sujith.thomas@intel.com>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <lenb@kernel.org>, Richard Hughes <hughsient@gmail.com>

Zhang, Rui wrote:
> On Tue, 2008-02-26 at 16:39 +0800, Hans de Goede wrote:
>> Zhang, Rui wrote:
>>> Add hwmon sys I/F for the generic thermal device.
>>>
>> Great!
>>
>> But I have several remarks:
>> 1) Looking at the new code, you only add temp1_input, so I'm guessing
>> that you
>> are registering a seperate hwmon class entry per zone? Please don't do
>> that,
>> please register one hwmon class entry, and add multiple temp#_input
>> attr to it
>> (and the same for crit).
>>
>> 2) I see that temp_crit may not be always available:
>>  > +static ssize_t
>>  > +crit_trip_temp_show(struct device *dev, struct device_attribute
>> *attr,
>>  > +                    char *buf)
>>  > +{
>>  > +    struct device *device = dev->parent;
>>  > +    struct thermal_zone_device *tz = to_thermal_zone(device);
>>  > +    int result;
>>  > +
>>  > +    if (!tz->ops->get_trip_temp )
>>  > +            return -EPERM;
>>  > +
>>  > +    /* assume trip 0 to be the critical trip point by default */
>>  > +    if (tz->ops->get_trip_type) {
>>  > +            result = tz->ops->get_trip_type(tz, 0, buf);
>>  > +            if (result < 0)
>>  > +                    return result;
>>  > +            if (strcmp(buf, "critical\n"))
>>  > +                    return -ENODEV;
>>  > +    }
>>  > +
>>  > +    return tz->ops->get_trip_temp(tz, 0, buf);
>>  > +}
>>
>> But you do always register a temp#_crit sysfs attr, it would be much
>> much
>> better to only add this if reading it actually has a chance of
>> returning a
>> value, so if tz->ops->get_trip_temp != NULL and
>> tz->ops->get_trip_type(tz, 0,
>> buf) returns "critical" in buf.
> then how about this one? :)
> 

 From a hwmon interface perspective its much better, thanks! As for doing a 
full review, I'm afraid I'm not familiar enough with the code for that.

Regards,

Hans



> Add hwmon sys I/F for the generic thermal device.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> Cc: Hans de Geode <j.w.r.degoede@hhs.nl>
> ---
>  Documentation/thermal/sysfs-api.txt |   22 ++--
>  drivers/thermal/Kconfig             |    1 
>  drivers/thermal/thermal.c           |  161 ++++++++++++++++++++++++++++++------
>  3 files changed, 147 insertions(+), 37 deletions(-)
> 
> Index: linux-2.6/Documentation/thermal/sysfs-api.txt
> =================================> --- linux-2.6.orig/Documentation/thermal/sysfs-api.txt
> +++ linux-2.6/Documentation/thermal/sysfs-api.txt
> @@ -143,10 +143,10 @@ type				Strings which represent the ther
>  				This is given by thermal zone driver as part of registration.
>  				Eg: "ACPI thermal zone" indicates it's a ACPI thermal device
>  				RO
> -				Optional
> +				Required
>  
>  temp				Current temperature as reported by thermal zone (sensor)
> -				Unit: degree Celsius
> +				Unit: millidegree Celsius
>  				RO
>  				Required
>  
> @@ -163,7 +163,7 @@ mode				One of the predefined values in 
>  					  charge of the thermal management.
>  
>  trip_point_[0-*]_temp		The temperature above which trip point will be fired
> -				Unit: degree Celsius
> +				Unit: millidegree Celsius
>  				RO
>  				Optional
>  
> @@ -193,7 +193,7 @@ type				String which represents the type
>  				eg. For memory controller device on intel_menlow platform:
>  				this should be "Memory controller"
>  				RO
> -				Optional
> +				Required
>  
>  max_state			The maximum permissible cooling state of this cooling device.
>  				RO
> @@ -219,16 +219,16 @@ the sys I/F structure will be built like
>  
>  |thermal_zone1:
>  	|-----type:			ACPI thermal zone
> -	|-----temp:			37
> +	|-----temp:			37000
>  	|-----mode:			kernel
> -	|-----trip_point_0_temp:	100
> +	|-----trip_point_0_temp:	100000
>  	|-----trip_point_0_type:	critical
> -	|-----trip_point_1_temp:	80
> +	|-----trip_point_1_temp:	80000
>  	|-----trip_point_1_type:	passive
> -	|-----trip_point_2_temp:	70
> -	|-----trip_point_2_type:	active[0]
> -	|-----trip_point_3_temp:	60
> -	|-----trip_point_3_type:	active[1]
> +	|-----trip_point_2_temp:	70000
> +	|-----trip_point_2_type:	active0
> +	|-----trip_point_3_temp:	60000
> +	|-----trip_point_3_type:	active1
>  	|-----cdev0:			--->/sys/class/thermal/cooling_device0
>  	|-----cdev0_trip_point:		1	/* cdev0 can be used for passive */
>  	|-----cdev1:			--->/sys/class/thermal/cooling_device3
> Index: linux-2.6/drivers/thermal/Kconfig
> =================================> --- linux-2.6.orig/drivers/thermal/Kconfig
> +++ linux-2.6/drivers/thermal/Kconfig
> @@ -4,6 +4,7 @@
>  
>  menuconfig THERMAL
>  	bool "Generic Thermal sysfs driver"
> +	select HWMON
>  	default y
>  	help
>  	  Generic Thermal Sysfs driver offers a generic mechanism for
> Index: linux-2.6/drivers/thermal/thermal.c
> =================================> --- linux-2.6.orig/drivers/thermal/thermal.c
> +++ linux-2.6/drivers/thermal/thermal.c
> @@ -30,8 +30,10 @@
>  #include <linux/idr.h>
>  #include <linux/thermal.h>
>  #include <linux/spinlock.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
>  
> -MODULE_AUTHOR("Zhang Rui")
> +MODULE_AUTHOR("Zhang Rui");
>  MODULE_DESCRIPTION("Generic thermal management sysfs support");
>  MODULE_LICENSE("GPL");
>  
> @@ -56,6 +58,8 @@ static LIST_HEAD(thermal_tz_list);
>  static LIST_HEAD(thermal_cdev_list);
>  static DEFINE_MUTEX(thermal_list_lock);
>  
> +static struct device *thermal_hwmon;
> +
>  static int get_idr(struct idr *idr, struct mutex *lock, int *id)
>  {
>  	int err;
> @@ -87,7 +91,67 @@ static void release_idr(struct idr *idr,
>  		mutex_unlock(lock);
>  }
>  
> -/* sys I/F for thermal zone */
> +/* hwmon sys I/F*/
> +static ssize_t
> +name_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	return sprintf(buf, "thermal_sys_class\n");
> +}
> +
> +static ssize_t
> +temp_input_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct thermal_zone_device *tz;
> +	struct sensor_device_attribute *sensor_attr
> +						= to_sensor_dev_attr(attr);
> +
> +	list_for_each_entry(tz, &thermal_tz_list, node)
> +		if (tz->id = sensor_attr->index)
> +			return tz->ops->get_temp(tz, buf);
> +
> +	return -ENODEV;
> +}
> +
> +static ssize_t
> +temp_crit_show(struct device *dev, struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct thermal_zone_device *tz;
> +	struct sensor_device_attribute *sensor_attr
> +						= to_sensor_dev_attr(attr);
> +
> +	list_for_each_entry(tz, &thermal_tz_list, node)
> +		if (tz->id = sensor_attr->index)
> +			return tz->ops->get_trip_temp(tz, 0, buf);
> +
> +	return -ENODEV;
> +}
> +
> +static DEVICE_ATTR(name, 0444, name_show, NULL);
> +static struct sensor_device_attribute sensor_attrs[] = {
> +	SENSOR_ATTR(temp1_input, 0444, temp_input_show, NULL, 0),
> +	SENSOR_ATTR(temp1_crit, 0444, temp_crit_show, NULL, 0),
> +	SENSOR_ATTR(temp2_input, 0444, temp_input_show, NULL, 1),
> +	SENSOR_ATTR(temp2_crit, 0444, temp_crit_show, NULL, 1),
> +	SENSOR_ATTR(temp3_input, 0444, temp_input_show, NULL, 2),
> +	SENSOR_ATTR(temp3_crit, 0444, temp_crit_show, NULL, 2),
> +	SENSOR_ATTR(temp4_input, 0444, temp_input_show, NULL, 3),
> +	SENSOR_ATTR(temp4_crit, 0444, temp_crit_show, NULL, 3),
> +	SENSOR_ATTR(temp5_input, 0444, temp_input_show, NULL, 4),
> +	SENSOR_ATTR(temp5_crit, 0444, temp_crit_show, NULL, 4),
> +	SENSOR_ATTR(temp6_input, 0444, temp_input_show, NULL, 5),
> +	SENSOR_ATTR(temp6_crit, 0444, temp_crit_show, NULL, 5),
> +	SENSOR_ATTR(temp7_input, 0444, temp_input_show, NULL, 6),
> +	SENSOR_ATTR(temp7_crit, 0444, temp_crit_show, NULL, 6),
> +	SENSOR_ATTR(temp8_input, 0444, temp_input_show, NULL, 7),
> +	SENSOR_ATTR(temp8_crit, 0444, temp_crit_show, NULL, 7),
> +	SENSOR_ATTR(temp9_input, 0444, temp_input_show, NULL, 8),
> +	SENSOR_ATTR(temp9_crit, 0444, temp_crit_show, NULL, 8),
> +	SENSOR_ATTR(temp10_input, 0444, temp_input_show, NULL, 9),
> +	SENSOR_ATTR(temp10_crit, 0444, temp_crit_show, NULL, 9),
> +};
> +
> +/* thermal zone sys I/F */
>  
>  #define to_thermal_zone(_dev) \
>  	container_of(_dev, struct thermal_zone_device, device)
> @@ -214,7 +278,7 @@ do {	\
>  	device_remove_file(_dev, &trip_point_attrs[_index * 2 + 1]);	\
>  } while (0)
>  
> -/* sys I/F for cooling device */
> +/* cooling device sys I/F */
>  #define to_cooling_device(_dev)	\
>  	container_of(_dev, struct thermal_cooling_device, device)
>  
> @@ -447,6 +511,9 @@ struct thermal_cooling_device *thermal_c
>  	struct thermal_zone_device *pos;
>  	int result;
>  
> +	if (!type)
> +		return ERR_PTR(-EINVAL);
> +
>  	if (strlen(type) >= THERMAL_NAME_LENGTH)
>  		return ERR_PTR(-EINVAL);
>  
> @@ -477,11 +544,9 @@ struct thermal_cooling_device *thermal_c
>  	}
>  
>  	/* sys I/F */
> -	if (type) {
> -		result = device_create_file(&cdev->device, &dev_attr_cdev_type);
> -		if (result)
> -			goto unregister;
> -	}
> +	result = device_create_file(&cdev->device, &dev_attr_cdev_type);
> +	if (result)
> +		goto unregister;
>  
>  	result = device_create_file(&cdev->device, &dev_attr_max_state);
>  	if (result)
> @@ -547,8 +612,8 @@ void thermal_cooling_device_unregister(s
>  		tz->ops->unbind(tz, cdev);
>  	}
>  	mutex_unlock(&thermal_list_lock);
> -	if (cdev->type[0])
> -		device_remove_file(&cdev->device, &dev_attr_cdev_type);
> +
> +	device_remove_file(&cdev->device, &dev_attr_cdev_type);
>  	device_remove_file(&cdev->device, &dev_attr_max_state);
>  	device_remove_file(&cdev->device, &dev_attr_cur_state);
>  
> @@ -580,6 +645,9 @@ struct thermal_zone_device *thermal_zone
>  	int result;
>  	int count;
>  
> +	if (!type)
> +		return ERR_PTR(-EINVAL);
> +
>  	if (strlen(type) >= THERMAL_NAME_LENGTH)
>  		return ERR_PTR(-EINVAL);
>  
> @@ -615,13 +683,28 @@ struct thermal_zone_device *thermal_zone
>  		return ERR_PTR(result);
>  	}
>  
> -	/* sys I/F */
> -	if (type) {
> -		result = device_create_file(&tz->device, &dev_attr_type);
> -		if (result)
> -			goto unregister;
> +	/* hwmon sys I/F */
> +	result = device_create_file(thermal_hwmon,
> +					&sensor_attrs[tz->id * 2].dev_attr);
> +	if (result)
> +		goto unregister;
> +
> +	if (trips > 0) {
> +		char buf[40];
> +		result = tz->ops->get_trip_type(tz, 0, buf);
> +		if (result > 0 && !strcmp(buf, "critical\n")) {
> +			result = device_create_file(thermal_hwmon,
> +					&sensor_attrs[tz->id * 2 + 1].dev_attr);
> +			if (result)
> +				goto unregister;
> +		}
>  	}
>  
> +	/* sys I/F */
> +	result = device_create_file(&tz->device, &dev_attr_type);
> +	if (result)
> +		goto unregister;
> +
>  	result = device_create_file(&tz->device, &dev_attr_temp);
>  	if (result)
>  		goto unregister;
> @@ -687,8 +770,17 @@ void thermal_zone_device_unregister(stru
>  		    tz->ops->unbind(tz, cdev);
>  	mutex_unlock(&thermal_list_lock);
>  
> -	if (tz->type[0])
> -		device_remove_file(&tz->device, &dev_attr_type);
> +	device_remove_file(thermal_hwmon,
> +				&sensor_attrs[tz->id * 2].dev_attr);
> +	if (tz->trips > 0) {
> +		char buf[40];
> +		if (tz->ops->get_trip_type(tz, 0, buf) > 0)
> +			if (!strcmp(buf, "critical\n"))
> +				device_remove_file(thermal_hwmon,
> +				&sensor_attrs[tz->id * 2 + 1].dev_attr);
> +	}
> +
> +	device_remove_file(&tz->device, &dev_attr_type);
>  	device_remove_file(&tz->device, &dev_attr_temp);
>  	if (tz->ops->get_mode)
>  		device_remove_file(&tz->device, &dev_attr_mode);
> @@ -705,6 +797,19 @@ void thermal_zone_device_unregister(stru
>  
>  EXPORT_SYMBOL(thermal_zone_device_unregister);
>  
> +static void __exit thermal_exit(void)
> +{
> +	if (thermal_hwmon) {
> +		device_remove_file(thermal_hwmon, &dev_attr_name);
> +		hwmon_device_unregister(thermal_hwmon);
> +	}
> +	class_unregister(&thermal_class);
> +	idr_destroy(&thermal_tz_idr);
> +	idr_destroy(&thermal_cdev_idr);
> +	mutex_destroy(&thermal_idr_lock);
> +	mutex_destroy(&thermal_list_lock);
> +}
> +
>  static int __init thermal_init(void)
>  {
>  	int result = 0;
> @@ -716,16 +821,20 @@ static int __init thermal_init(void)
>  		mutex_destroy(&thermal_idr_lock);
>  		mutex_destroy(&thermal_list_lock);
>  	}
> -	return result;
> -}
>  
> -static void __exit thermal_exit(void)
> -{
> -	class_unregister(&thermal_class);
> -	idr_destroy(&thermal_tz_idr);
> -	idr_destroy(&thermal_cdev_idr);
> -	mutex_destroy(&thermal_idr_lock);
> -	mutex_destroy(&thermal_list_lock);
> +	thermal_hwmon = hwmon_device_register(NULL);
> +	if (IS_ERR(thermal_hwmon)) {
> +		result = PTR_ERR(thermal_hwmon);
> +		thermal_hwmon = NULL;
> +		printk(KERN_ERR PREFIX
> +			"unable to register hwmon device\n");
> +		thermal_exit();
> +		return result;
> +	}
> +
> +	result = device_create_file(thermal_hwmon, &dev_attr_name);
> +
> +	return result;
>  }
>  
>  subsys_initcall(thermal_init);
> 
> 
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
