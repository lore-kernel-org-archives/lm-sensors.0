From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Sun, 13 Aug 2006 19:45:32 +0000
Subject: [lm-sensors] [RFC-patch] pc87360 - unchecked
Message-Id: <20060813194532.GB3091@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <44D2514B.2090202@gmail.com>
In-Reply-To: <44D2514B.2090202@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim:

> Jean Delvare wrote:
> > Yup, I don't much like Jim's approach, because it's meant to be
> > temporary. Mark's approach seems better, especially since it is less
> > difficult than I first thought. Now let's see how it scales to more
> > complex drivers. Jim, would you like to try implementing something
> > similar for the pc87360 driver (or any other complex driver of your
> > choice, as long as you can test it) and see how it goes?

* Jim Cromie <jim.cromie at gmail.com> [2006-08-03 13:40:59 -0600]:
> Im completely impressed by how clean Mark's patch is.
> In the end, the elegance seduced me, patch follows.
> 
> in the start, I cut-pasted my own remove-bunch/group.
> its if-0'd now, to be yanked..
> 
> In contrast with Mark's declarative grouping, Im doing it at runtime:
>      pc87360_detect()
>             calls add_tothe_group() to add it to one_big_group[] for 
> each sensor-attr wanted,
>              then calls sysfs_create_group()

What is the point of generating the group at runtime?

> NB - the var and fn names are chosen to convey the implicit context,
> and some sheepishness on my part for the obvious laziness ;-)
> OTOH - all the implicit-ness is in the 1st 30 lines of the patch.
> 
> 
> I thought about trying to generalize the fn a bit better :
>     sysfs_addto_group( attr_group, new_attr);
> 
> but that seemed to imply promises about a dynamically allocated (and 
> resized) group,
> which probly should be done as a real LIST or something, but I wanted 
> static allocation
> (ENOUGH_ATTRS) since the driver has *only* statically declared attributes.
> 
> Its probly worth noting that pc87360 now does:    hwmon_register b4 
> sysfs_create_group
> whereas Mark's patch does the opposite.   Does this matter ??

I changed the ordering in asb100 on purpose... it closes the small window
of time between when the hwmon class is registered and the device attributes
are populated.  It's something of a race condition... sensors(1) could run
in the middle of that.

> Ive left a few other comments in the code...
> 
> 
> diff -ruNp -X dontdiff -X exclude-diffs ../linux-2.6.18-rc3-sk/drivers/hwmon/pc87360.c sysdev/drivers/hwmon/pc87360.c
> --- ../linux-2.6.18-rc3-sk/drivers/hwmon/pc87360.c	2006-06-17 19:49:35.000000000 -0600
> +++ sysdev/drivers/hwmon/pc87360.c	2006-08-03 12:58:29.000000000 -0600
> @@ -829,6 +829,83 @@ static int __init pc87360_find(int sioad
>  	return 0;
>  }
>  
> +/* Declare and use an attribute-group for simplicity.
> +   This driver declares all attributes statically, so we count uses of 
> +   SENSOR_ATTR, DEVICE_ATTR, and add 1 space for trailing NULL (+0 fudge)
> +*/
> +#define ENOUGH_ATTRS	89 + 4 + 1 + 0
> +static struct attribute *one_big_group[ENOUGH_ATTRS];
> +static int next_member;
> +
> +static struct attribute_group my_group = {
> +	.attrs = one_big_group
> +};
> +
> +static void add_tothe_group(struct device *dev,
> +				struct device_attribute *devattr)
> +{
> +	/* add attr to the group for later sysfs_create_group */
> +	if (next_member < ENOUGH_ATTRS)
> +		one_big_group[next_member++] = &devattr->attr;
> +	else {
> +		BUG_ON("too many in group for static alloc!\n");
> +		dev_err(dev, "too many in group for static alloc!\n");
> +	}
> +}
> +
> +#if 0
> +static void remove_all_devattr_files(struct device *dev)
> +{
> +	int i;
> +	/* Mark Hoffman used sysfs_remove_group here, it nicely tracks
> +	   group membership, at cost of array of pointers.  For now,
> +	   stick w non-group approach - cost is cut-paste in-elegance
> +	   & maint if sensor set changes */
> +
> +	dev_info(dev, "created %d attr-files, w errs %d.  now destroying\n",
> +		 next_member, devattr_file_create_errs);
> +
> +	/* tiny cheat - rely on size equivalence of {type}_{attr}[]
> +	   arrays across all attrs for each type (declared that way)
> +	*/
> +	for (i = 0; i < ARRAY_SIZE(in_input); i++) {
> +		device_remove_file(dev, &in_input[i].dev_attr);
> +		device_remove_file(dev, &in_min[i].dev_attr);
> +		device_remove_file(dev, &in_max[i].dev_attr);
> +		device_remove_file(dev, &in_status[i].dev_attr);
> +	}
> +	device_remove_file(dev, &dev_attr_cpu0_vid);
> +	device_remove_file(dev, &dev_attr_vrm);
> +	device_remove_file(dev, &dev_attr_alarms_in);
> +
> +	for (i = 0; i < ARRAY_SIZE(temp_input); i++) {
> +		device_remove_file(dev, &temp_input[i].dev_attr);
> +		device_remove_file(dev, &temp_min[i].dev_attr);
> +		device_remove_file(dev, &temp_max[i].dev_attr);
> +		device_remove_file(dev, &temp_crit[i].dev_attr);
> +		device_remove_file(dev, &temp_status[i].dev_attr);
> +	}
> +	device_remove_file(dev, &dev_attr_alarms_temp);
> +
> +	for (i = 0; i < ARRAY_SIZE(therm_input); i++) {
> +		device_remove_file(dev, &therm_input[i].dev_attr);
> +		device_remove_file(dev, &therm_min[i].dev_attr);
> +		device_remove_file(dev, &therm_max[i].dev_attr);
> +		device_remove_file(dev, &therm_crit[i].dev_attr);
> +		device_remove_file(dev, &therm_status[i].dev_attr);
> +	}
> +	for (i = 0; i < ARRAY_SIZE(fan_input); i++) {
> +		device_remove_file(dev, &fan_input[i].dev_attr);
> +		device_remove_file(dev, &fan_min[i].dev_attr);
> +		device_remove_file(dev, &fan_div[i].dev_attr);
> +		device_remove_file(dev, &fan_status[i].dev_attr);
> +		device_remove_file(dev, &pwm[i].dev_attr);
> +	}
> +
> +	dev_info(dev, "remaining attr-files %d\n", next_member);
> +}
> +#endif
> +
>  static int pc87360_detect(struct i2c_adapter *adapter)

You can't fill your static array from here.  What if you have two
pc87360s?  If you're going to do it at runtime, it has to be during
module init.  But again, why do it at runtime in the first place?

>  {
>  	int i;
> @@ -944,50 +1021,61 @@ static int pc87360_detect(struct i2c_ada
>  
>  	if (data->innr) {
>  		for (i = 0; i < 11; i++) {
> -			device_create_file(dev, &in_input[i].dev_attr);
> -			device_create_file(dev, &in_min[i].dev_attr);
> -			device_create_file(dev, &in_max[i].dev_attr);
> -			device_create_file(dev, &in_status[i].dev_attr);
> -		}
> -		device_create_file(dev, &dev_attr_cpu0_vid);
> -		device_create_file(dev, &dev_attr_vrm);
> -		device_create_file(dev, &dev_attr_alarms_in);
> +			add_tothe_group(dev, &in_input[i].dev_attr);
> +			add_tothe_group(dev, &in_min[i].dev_attr);
> +			add_tothe_group(dev, &in_max[i].dev_attr);
> +			add_tothe_group(dev, &in_status[i].dev_attr);
> +		}
> +		add_tothe_group(dev, &dev_attr_cpu0_vid);
> +		add_tothe_group(dev, &dev_attr_vrm);
> +		add_tothe_group(dev, &dev_attr_alarms_in);
>  	}
>  
>  	if (data->tempnr) {
>  		for (i = 0; i < data->tempnr; i++) {
> -			device_create_file(dev, &temp_input[i].dev_attr);
> -			device_create_file(dev, &temp_min[i].dev_attr);
> -			device_create_file(dev, &temp_max[i].dev_attr);
> -			device_create_file(dev, &temp_crit[i].dev_attr);
> -			device_create_file(dev, &temp_status[i].dev_attr);
> +			add_tothe_group(dev, &temp_input[i].dev_attr);
> +			add_tothe_group(dev, &temp_min[i].dev_attr);
> +			add_tothe_group(dev, &temp_max[i].dev_attr);
> +			add_tothe_group(dev, &temp_crit[i].dev_attr);
> +			add_tothe_group(dev, &temp_status[i].dev_attr);
>  		}
> -		device_create_file(dev, &dev_attr_alarms_temp);
> +		add_tothe_group(dev, &dev_attr_alarms_temp);
>  	}
>  
>  	if (data->innr = 14) {
>  		for (i = 0; i < 3; i++) {
> -			device_create_file(dev, &therm_input[i].dev_attr);
> -			device_create_file(dev, &therm_min[i].dev_attr);
> -			device_create_file(dev, &therm_max[i].dev_attr);
> -			device_create_file(dev, &therm_crit[i].dev_attr);
> -			device_create_file(dev, &therm_status[i].dev_attr);
> +			add_tothe_group(dev, &therm_input[i].dev_attr);
> +			add_tothe_group(dev, &therm_min[i].dev_attr);
> +			add_tothe_group(dev, &therm_max[i].dev_attr);
> +			add_tothe_group(dev, &therm_crit[i].dev_attr);
> +			add_tothe_group(dev, &therm_status[i].dev_attr);
>  		}
>  	}
>  
>  	for (i = 0; i < data->fannr; i++) {
>  		if (FAN_CONFIG_MONITOR(data->fan_conf, i)) {
> -			device_create_file(dev, &fan_input[i].dev_attr);
> -			device_create_file(dev, &fan_min[i].dev_attr);
> -			device_create_file(dev, &fan_div[i].dev_attr);
> -			device_create_file(dev, &fan_status[i].dev_attr);
> +			add_tothe_group(dev, &fan_input[i].dev_attr);
> +			add_tothe_group(dev, &fan_min[i].dev_attr);
> +			add_tothe_group(dev, &fan_div[i].dev_attr);
> +			add_tothe_group(dev, &fan_status[i].dev_attr);
>  		}
>  		if (FAN_CONFIG_CONTROL(data->fan_conf, i))
> -			device_create_file(dev, &pwm[i].dev_attr);
> +			add_tothe_group(dev, &pwm[i].dev_attr);
>  	}
>  
> +	/* Register sysfs hooks for the group */
> +	err = sysfs_create_group(&client->dev.kobj, &my_group);
> +	if (err) {
> +		dev_err(&client->dev, "group-create failed: %d, %d members\n",
> +			err, next_member);
> +		goto ERROR3;
> +	}
> +	
>  	return 0;
>  
> +	/* ERROR4:
> +	   sysfs_remove_group(&client->dev.kobj, &my_group);
> +	*/
>  ERROR3:
>  	i2c_detach_client(client);
>  ERROR2:
> @@ -1006,6 +1094,7 @@ static int pc87360_detach_client(struct 
>  	struct pc87360_data *data = i2c_get_clientdata(client);
>  	int i;
>  
> +	sysfs_remove_group(&client->dev.kobj, &my_group);
>  	hwmon_device_unregister(data->class_dev);
>  
>  	if ((i = i2c_detach_client(client)))

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


