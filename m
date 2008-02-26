From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Tue, 26 Feb 2008 08:39:42 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] thermal: add hwmon sys I/F for thermal
Message-Id: <47C3D04E.6090609@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <1203975102.10256.82.camel@acpi-hp-zz.sh.intel.com>
In-Reply-To: <1203975102.10256.82.camel@acpi-hp-zz.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>, Jean Delvare <khali@linux-fr.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Thomas Renninger <trenn@suse.de>, "Thomas, Sujith" <sujith.thomas@intel.com>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <lenb@kernel.org>, Richard Hughes <hughsient@gmail.com>

Zhang, Rui wrote:
> Add hwmon sys I/F for the generic thermal device.
> 

Great!

But I have several remarks:
1) Looking at the new code, you only add temp1_input, so I'm guessing that you
are registering a seperate hwmon class entry per zone? Please don't do that, 
please register one hwmon class entry, and add multiple temp#_input attr to it 
(and the same for crit).

2) I see that temp_crit may not be always available:
 > +static ssize_t
 > +crit_trip_temp_show(struct device *dev, struct device_attribute *attr,
 > +			char *buf)
 > +{
 > +	struct device *device = dev->parent;
 > +	struct thermal_zone_device *tz = to_thermal_zone(device);
 > +	int result;
 > +
 > +	if (!tz->ops->get_trip_temp )
 > +		return -EPERM;
 > +
 > +	/* assume trip 0 to be the critical trip point by default */
 > +	if (tz->ops->get_trip_type) {
 > +		result = tz->ops->get_trip_type(tz, 0, buf);
 > +		if (result < 0)
 > +			return result;
 > +		if (strcmp(buf, "critical\n"))
 > +			return -ENODEV;
 > +	}
 > +
 > +	return tz->ops->get_trip_temp(tz, 0, buf);
 > +}

But you do always register a temp#_crit sysfs attr, it would be much much 
better to only add this if reading it actually has a chance of returning a 
value, so if tz->ops->get_trip_temp != NULL and tz->ops->get_trip_type(tz, 0, 
buf) returns "critical" in buf.

Thanks & Regards,

Hans



> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  Documentation/thermal/sysfs-api.txt |   22 +++++----
>  drivers/thermal/Kconfig             |    1 
>  drivers/thermal/thermal.c           |   86 ++++++++++++++++++++++++++++++++----
>  include/linux/thermal.h             |    1 
>  4 files changed, 92 insertions(+), 18 deletions(-)
> 
> Index: linux-2.6.25-rc2/Documentation/thermal/sysfs-api.txt
> =================================> --- linux-2.6.25-rc2.orig/Documentation/thermal/sysfs-api.txt	2008-02-25 22:43:29.000000000 -0500
> +++ linux-2.6.25-rc2/Documentation/thermal/sysfs-api.txt	2008-02-25 22:43:38.000000000 -0500
> @@ -141,12 +141,14 @@
>  
>  type				Strings which represent the thermal zone type.
>  				This is given by thermal zone driver as part of registration.
> +				In order to keep the compatibility with hwmon,
> +				it should not contain any spaces or dashes.
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
> @@ -163,7 +165,7 @@
>  					  charge of the thermal management.
>  
>  trip_point_[0-*]_temp		The temperature above which trip point will be fired
> -				Unit: degree Celsius
> +				Unit: millidegree Celsius
>  				RO
>  				Optional
>  
> @@ -219,16 +221,16 @@
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
> Index: linux-2.6.25-rc2/drivers/thermal/Kconfig
> =================================> --- linux-2.6.25-rc2.orig/drivers/thermal/Kconfig	2008-02-25 22:43:29.000000000 -0500
> +++ linux-2.6.25-rc2/drivers/thermal/Kconfig	2008-02-25 22:43:38.000000000 -0500
> @@ -4,6 +4,7 @@
>  
>  menuconfig THERMAL
>  	bool "Generic Thermal sysfs driver"
> +	select HWMON
>  	default y
>  	help
>  	  Generic Thermal Sysfs driver offers a generic mechanism for
> Index: linux-2.6.25-rc2/drivers/thermal/thermal.c
> =================================> --- linux-2.6.25-rc2.orig/drivers/thermal/thermal.c	2008-02-25 22:43:29.000000000 -0500
> +++ linux-2.6.25-rc2/drivers/thermal/thermal.c	2008-02-26 00:37:57.000000000 -0500
> @@ -30,8 +30,9 @@
>  #include <linux/idr.h>
>  #include <linux/thermal.h>
>  #include <linux/spinlock.h>
> +#include <linux/hwmon.h>
>  
> -MODULE_AUTHOR("Zhang Rui")
> +MODULE_AUTHOR("Zhang Rui");
>  MODULE_DESCRIPTION("Generic thermal management sysfs support");
>  MODULE_LICENSE("GPL");
>  
> @@ -171,6 +172,47 @@
>  	return tz->ops->get_trip_temp(tz, trip, buf);
>  }
>  
> +static ssize_t
> +hwmon_type_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct device *device = dev->parent;
> +	return type_show(device, attr, buf);
> +}
> +
> +static ssize_t
> +hwmon_temp_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct device *device = dev->parent;
> +	return temp_show(device, attr, buf);
> +}
> +
> +static ssize_t
> +crit_trip_temp_show(struct device *dev, struct device_attribute *attr,
> +			char *buf)
> +{
> +	struct device *device = dev->parent;
> +	struct thermal_zone_device *tz = to_thermal_zone(device);
> +	int result;
> +
> +	if (!tz->ops->get_trip_temp )
> +		return -EPERM;
> +
> +	/* assume trip 0 to be the critical trip point by default */
> +	if (tz->ops->get_trip_type) {
> +		result = tz->ops->get_trip_type(tz, 0, buf);
> +		if (result < 0)
> +			return result;
> +		if (strcmp(buf, "critical\n"))
> +			return -ENODEV;
> +	}
> +
> +	return tz->ops->get_trip_temp(tz, 0, buf);
> +}
> +
> +static DEVICE_ATTR(name, 0444, hwmon_type_show, NULL);
> +static DEVICE_ATTR(temp1_input, 0444, hwmon_temp_show, NULL);
> +static DEVICE_ATTR(temp1_crit, 0444, crit_trip_temp_show, NULL);
> +
>  static DEVICE_ATTR(type, 0444, type_show, NULL);
>  static DEVICE_ATTR(temp, 0444, temp_show, NULL);
>  static DEVICE_ATTR(mode, 0644, mode_show, mode_store);
> @@ -569,6 +611,9 @@
>  	int result;
>  	int count;
>  
> +	if (!type)
> +		return ERR_PTR(-EINVAL);
> +
>  	if (strlen(type) >= THERMAL_NAME_LENGTH)
>  		return NULL;
>  
> @@ -604,13 +649,33 @@
>  		return NULL;
>  	}
>  
> -	/* sys I/F */
> -	if (type) {
> -		result = device_create_file(&tz->device, &dev_attr_type);
> -		if (result)
> -			goto unregister;
> +	/* hwmon sys I/F */
> +	tz->hwmon = hwmon_device_register(&tz->device);
> +	if (IS_ERR(tz->hwmon)) {
> +		result = PTR_ERR(tz->hwmon);
> +		tz->hwmon = NULL;
> +		printk(KERN_ERR PREFIX
> +			"unable to register hwmon device\n");
> +		goto unregister;
>  	}
>  
> +	result = device_create_file(tz->hwmon, &dev_attr_name);
> +	if (result)
> +		goto unregister;
> +
> +	result = device_create_file(tz->hwmon, &dev_attr_temp1_input);
> +	if (result)
> +		goto unregister;
> +
> +	result = device_create_file(tz->hwmon, &dev_attr_temp1_crit);
> +	if (result)
> +		goto unregister;
> +
> +	/* sys I/F */
> +	result = device_create_file(&tz->device, &dev_attr_type);
> +	if (result)
> +		goto unregister;
> +
>  	result = device_create_file(&tz->device, &dev_attr_temp);
>  	if (result)
>  		goto unregister;
> @@ -676,8 +741,13 @@
>  		    tz->ops->unbind(tz, cdev);
>  	mutex_unlock(&thermal_list_lock);
>  
> -	if (tz->type[0])
> -		device_remove_file(&tz->device, &dev_attr_type);
> +	device_remove_file(&tz->device, &dev_attr_name);
> +	device_remove_file(&tz->device, &dev_attr_temp1_input);
> +	device_remove_file(&tz->device, &dev_attr_temp1_crit);
> +	hwmon_device_unregister(tz->hwmon);
> +	tz->hwmon = NULL;
> +
> +	device_remove_file(&tz->device, &dev_attr_type);
>  	device_remove_file(&tz->device, &dev_attr_temp);
>  	if (tz->ops->get_mode)
>  		device_remove_file(&tz->device, &dev_attr_mode);
> Index: linux-2.6.25-rc2/include/linux/thermal.h
> =================================> --- linux-2.6.25-rc2.orig/include/linux/thermal.h	2008-02-25 22:43:29.000000000 -0500
> +++ linux-2.6.25-rc2/include/linux/thermal.h	2008-02-25 22:43:38.000000000 -0500
> @@ -69,6 +69,7 @@
>  	int id;
>  	char type[THERMAL_NAME_LENGTH];
>  	struct device device;
> +	struct device *hwmon;
>  	void *devdata;
>  	int trips;
>  	struct thermal_zone_device_ops *ops;
> 
> 
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
