From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 21 Sep 2006 08:54:52 +0000
Subject: [lm-sensors] [patch] hwmon: w83781d - check return code of
Message-Id: <20060921105452.b32bc488.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44F70D89.30409@gmail.com>
In-Reply-To: <44F70D89.30409@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

> add 2 attr-file groups (for base and model-specific attrs respectively),
> create the base group with single call to sysfs_create_group,
> check the return code on individual calls to device_create_file for each
> of the model-specific attr-files.
> 
> Signed-off-by:  Jim Cromie <jim.cromie at gmail.com>
> 
> This is compile-tested only, needs validation on hardware, or
> very thorough inspection.

Thanks for working on this. I don't have a compatible chip either, but
I'll look for a tester (unless someone on the list can test?)

Can you set the mime-type of the attachement to text/plain rather than
plain/text next time? ;)

> diff -ruNp -X dontdiff -X exclude-diffs w83-1/drivers/hwmon/w83781d.c w83-rconly/drivers/hwmon/w83781d.c
> --- w83-1/drivers/hwmon/w83781d.c	2006-08-07 15:37:19.000000000 -0600
> +++ w83-rconly/drivers/hwmon/w83781d.c	2006-08-31 07:47:08.000000000 -0600
> @@ -40,6 +40,8 @@
>  #include <linux/i2c.h>
>  #include <linux/i2c-isa.h>
>  #include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/sysfs.h>
>  #include <linux/hwmon-vid.h>
>  #include <linux/err.h>
>  #include <linux/mutex.h>
> @@ -360,11 +362,9 @@ sysfs_in_offsets(7);
>  sysfs_in_offsets(8);
>  
>  #define device_create_file_in(client, offset) \
> -do { \
> -device_create_file(&client->dev, &dev_attr_in##offset##_input); \
> -device_create_file(&client->dev, &dev_attr_in##offset##_min); \
> -device_create_file(&client->dev, &dev_attr_in##offset##_max); \
> -} while (0)
> +	device_create_file(&client->dev, &dev_attr_in##offset##_input)	\
> +	|| device_create_file(&client->dev, &dev_attr_in##offset##_min) \
> +	|| device_create_file(&client->dev, &dev_attr_in##offset##_max) \

Can you please get rid of all these macros while you're here? I didn't
like them much before, but now it's even worse as they are never
functions not constants but random code exerpts, which is quite
misleading and could cause a lot of confusion later. This would also
let you return the error values properly.

>  
>  #define show_fan_reg(reg) \
>  static ssize_t show_##reg (struct device *dev, char *buf, int nr) \
> @@ -421,10 +421,8 @@ sysfs_fan_offset(3);
>  sysfs_fan_min_offset(3);
>  
>  #define device_create_file_fan(client, offset) \
> -do { \
> -device_create_file(&client->dev, &dev_attr_fan##offset##_input); \
> -device_create_file(&client->dev, &dev_attr_fan##offset##_min); \
> -} while (0)
> +	device_create_file(&client->dev, &dev_attr_fan##offset##_input) \
> +	|| device_create_file(&client->dev, &dev_attr_fan##offset##_min)
>  
>  #define show_temp_reg(reg) \
>  static ssize_t show_##reg (struct device *dev, char *buf, int nr) \
> @@ -497,11 +495,9 @@ sysfs_temp_offsets(2);
>  sysfs_temp_offsets(3);
>  
>  #define device_create_file_temp(client, offset) \
> -do { \
> -device_create_file(&client->dev, &dev_attr_temp##offset##_input); \
> -device_create_file(&client->dev, &dev_attr_temp##offset##_max); \
> -device_create_file(&client->dev, &dev_attr_temp##offset##_max_hyst); \
> -} while (0)
> +	device_create_file(&client->dev, &dev_attr_temp##offset##_input) \
> +	|| device_create_file(&client->dev, &dev_attr_temp##offset##_max) \
> +	|| device_create_file(&client->dev, &dev_attr_temp##offset##_max_hyst)
>  
>  static ssize_t
>  show_vid_reg(struct device *dev, struct device_attribute *attr, char *buf)
> @@ -513,7 +509,7 @@ show_vid_reg(struct device *dev, struct 
>  static
>  DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid_reg, NULL);
>  #define device_create_file_vid(client) \
> -device_create_file(&client->dev, &dev_attr_cpu0_vid);
> +device_create_file(&client->dev, &dev_attr_cpu0_vid)
>  static ssize_t
>  show_vrm_reg(struct device *dev, struct device_attribute *attr, char *buf)
>  {
> @@ -537,7 +533,7 @@ store_vrm_reg(struct device *dev, struct
>  static
>  DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm_reg, store_vrm_reg);
>  #define device_create_file_vrm(client) \
> -device_create_file(&client->dev, &dev_attr_vrm);
> +device_create_file(&client->dev, &dev_attr_vrm)
>  static ssize_t
>  show_alarms_reg(struct device *dev, struct device_attribute *attr, char *buf)
>  {
> @@ -548,7 +544,7 @@ show_alarms_reg(struct device *dev, stru
>  static
>  DEVICE_ATTR(alarms, S_IRUGO, show_alarms_reg, NULL);
>  #define device_create_file_alarms(client) \
> -device_create_file(&client->dev, &dev_attr_alarms);
> +device_create_file(&client->dev, &dev_attr_alarms)
>  static ssize_t show_beep_mask (struct device *dev, struct device_attribute *attr, char *buf)
>  {
>  	struct w83781d_data *data = w83781d_update_device(dev);
> @@ -615,10 +611,8 @@ sysfs_beep(ENABLE, enable);
>  sysfs_beep(MASK, mask);
>  
>  #define device_create_file_beep(client) \
> -do { \
> -device_create_file(&client->dev, &dev_attr_beep_enable); \
> -device_create_file(&client->dev, &dev_attr_beep_mask); \
> -} while (0)
> +	device_create_file(&client->dev, &dev_attr_beep_enable) \
> +	|| device_create_file(&client->dev, &dev_attr_beep_mask)
>  
>  static ssize_t
>  show_fan_div_reg(struct device *dev, char *buf, int nr)
> @@ -686,9 +680,7 @@ sysfs_fan_div(2);
>  sysfs_fan_div(3);
>  
>  #define device_create_file_fan_div(client, offset) \
> -do { \
> -device_create_file(&client->dev, &dev_attr_fan##offset##_div); \
> -} while (0)
> +	device_create_file(&client->dev, &dev_attr_fan##offset##_div)
>  
>  static ssize_t
>  show_pwm_reg(struct device *dev, char *buf, int nr)
> @@ -787,14 +779,10 @@ sysfs_pwm(3);
>  sysfs_pwm(4);
>  
>  #define device_create_file_pwm(client, offset) \
> -do { \
> -device_create_file(&client->dev, &dev_attr_pwm##offset); \
> -} while (0)
> +device_create_file(&client->dev, &dev_attr_pwm##offset)
>  
>  #define device_create_file_pwmenable(client, offset) \
> -do { \
> -device_create_file(&client->dev, &dev_attr_pwm##offset##_enable); \
> -} while (0)
> +device_create_file(&client->dev, &dev_attr_pwm##offset##_enable)
>  
>  static ssize_t
>  show_sensor_reg(struct device *dev, char *buf, int nr)
> @@ -865,9 +853,7 @@ sysfs_sensor(2);
>  sysfs_sensor(3);
>  
>  #define device_create_file_sensor(client, offset) \
> -do { \
> -device_create_file(&client->dev, &dev_attr_temp##offset##_type); \
> -} while (0)
> +device_create_file(&client->dev, &dev_attr_temp##offset##_type)
>  
>  /* This function is called when:
>       * w83781d_driver is inserted (when this module is loaded), for each
> @@ -993,6 +979,70 @@ ERROR_SC_0:
>  	return err;
>  }
>  
> +#define IN_UNIT_ATTRS(X)			\
> +	&dev_attr_in##X##_input.attr,		\
> +	&dev_attr_in##X##_min.attr,		\
> +	&dev_attr_in##X##_max.attr
> +
> +#define FAN_UNIT_ATTRS(X)			\
> +	&dev_attr_fan##X##_input.attr,		\
> +	&dev_attr_fan##X##_min.attr,		\
> +	&dev_attr_fan##X##_div.attr
> +
> +#define TEMP_UNIT_ATTRS(X)			\
> +	&dev_attr_temp##X##_input.attr,		\
> +	&dev_attr_temp##X##_max.attr,		\
> +	&dev_attr_temp##X##_max_hyst.attr
> +
> +static struct attribute *w83781d_attributes[] = {
> +

No blank line here please.

> +	IN_UNIT_ATTRS(0),
> +	IN_UNIT_ATTRS(2),
> +	IN_UNIT_ATTRS(3),
> +	IN_UNIT_ATTRS(4),
> +	IN_UNIT_ATTRS(5),
> +	IN_UNIT_ATTRS(6),
> +	
> +	FAN_UNIT_ATTRS(1),
> +	FAN_UNIT_ATTRS(2),
> +	FAN_UNIT_ATTRS(3),
> +	
> +	TEMP_UNIT_ATTRS(1),
> +	TEMP_UNIT_ATTRS(2),
> +	
> +	&dev_attr_cpu0_vid.attr,
> +	&dev_attr_vrm.attr,
> +	&dev_attr_alarms.attr,
> +	&dev_attr_beep_mask.attr,
> +	&dev_attr_beep_enable.attr,
> +	

Nor here.

> +	NULL,

And no comma here.
> +};
> +static struct attribute_group w83781d_group = {
> +	.attrs = w83781d_attributes,
> +};
> +
> +static struct attribute *w83781d_opt_attributes[] = {
> +	IN_UNIT_ATTRS(1),
> +	IN_UNIT_ATTRS(7),
> +	IN_UNIT_ATTRS(8),
> +	TEMP_UNIT_ATTRS(3),
> +
> +	&dev_attr_pwm1.attr,
> +	&dev_attr_pwm2.attr,
> +	&dev_attr_pwm2_enable.attr,
> +	&dev_attr_pwm3.attr,
> +	&dev_attr_pwm4.attr,
> +
> +	&dev_attr_temp1_type.attr,	/* for sensor */
> +	&dev_attr_temp2_type.attr,
> +	&dev_attr_temp3_type.attr,
> +	NULL,
> +};
> +static struct attribute_group w83781d_opt_group = {
> +	.attrs = w83781d_opt_attributes,
> +};

Mark and I went for _group_opt and _attributes_opt suffixes. It's of
course arbitrary, but maybe you can do the same for consistency?

> +
>  static int
>  w83781d_detect(struct i2c_adapter *adapter, int address, int kind)
>  {
> @@ -1211,64 +1261,57 @@ w83781d_detect(struct i2c_adapter *adapt
>  			data->pwmenable[i] = 1;
>  
>  	/* Register sysfs hooks */
> -	data->class_dev = hwmon_device_register(&new_client->dev);
> -	if (IS_ERR(data->class_dev)) {
> -		err = PTR_ERR(data->class_dev);
> -		goto ERROR4;
> -	}
> +	if ((err = sysfs_create_group(&new_client->dev.kobj,
> +				      &w83781d_group)))
> +		goto ERROR5;
>  
> -	device_create_file_in(new_client, 0);
>  	if (kind != w83783s)
> -		device_create_file_in(new_client, 1);
> -	device_create_file_in(new_client, 2);
> -	device_create_file_in(new_client, 3);
> -	device_create_file_in(new_client, 4);
> -	device_create_file_in(new_client, 5);
> -	device_create_file_in(new_client, 6);
> +		if (device_create_file_in(new_client, 1))
> +			goto ERROR5;
> +
>  	if (kind != as99127f && kind != w83781d && kind != w83783s) {
> -		device_create_file_in(new_client, 7);
> -		device_create_file_in(new_client, 8);
> +		if (device_create_file_in(new_client, 7)
> +		    || device_create_file_in(new_client, 8))
> +			goto ERROR5;
>  	}
>  
> -	device_create_file_fan(new_client, 1);
> -	device_create_file_fan(new_client, 2);
> -	device_create_file_fan(new_client, 3);
> -
> -	device_create_file_temp(new_client, 1);
> -	device_create_file_temp(new_client, 2);
>  	if (kind != w83783s)
> -		device_create_file_temp(new_client, 3);
> -
> -	device_create_file_vid(new_client);
> -	device_create_file_vrm(new_client);
> -
> -	device_create_file_fan_div(new_client, 1);
> -	device_create_file_fan_div(new_client, 2);
> -	device_create_file_fan_div(new_client, 3);
> -
> -	device_create_file_alarms(new_client);
> -
> -	device_create_file_beep(new_client);
> +		if (device_create_file_temp(new_client, 3))
> +			goto ERROR5;
>  
>  	if (kind != w83781d && kind != as99127f) {
> -		device_create_file_pwm(new_client, 1);
> -		device_create_file_pwm(new_client, 2);
> -		device_create_file_pwmenable(new_client, 2);
> +		if (device_create_file_pwm(new_client, 1)
> +		    || device_create_file_pwm(new_client, 2)
> +		    || device_create_file_pwmenable(new_client, 2))
> +			goto ERROR5;
>  	}
>  	if (kind = w83782d && !is_isa) {
> -		device_create_file_pwm(new_client, 3);
> -		device_create_file_pwm(new_client, 4);
> +		if (device_create_file_pwm(new_client, 3)
> +		    || device_create_file_pwm(new_client, 4))
> +			goto ERROR5;
>  	}
>  
>  	if (kind != as99127f && kind != w83781d) {
> -		device_create_file_sensor(new_client, 1);
> -		device_create_file_sensor(new_client, 2);
> +		if (device_create_file_sensor(new_client, 1)
> +		    || device_create_file_sensor(new_client, 2))
> +			goto ERROR5;
>  		if (kind != w83783s)
> -			device_create_file_sensor(new_client, 3);
> +			if (device_create_file_sensor(new_client, 3))
> +				goto ERROR5;
> +	}
> +
> +	data->class_dev = hwmon_device_register(&new_client->dev);
> +	if (IS_ERR(data->class_dev)) {
> +		err = PTR_ERR(data->class_dev);
> +		goto ERROR5;
>  	}
>  
>  	return 0;
>  
> +ERROR5:
> +	sysfs_remove_group(&new_client->dev.kobj, &w83781d_group);
> +	sysfs_remove_group(&new_client->dev.kobj, &w83781d_opt_group);
> +
>  ERROR4:
>  	if (data->lm75[1]) {
>  		i2c_detach_client(data->lm75[1]);
> @@ -1299,6 +1342,9 @@ w83781d_detach_client(struct i2c_client 
>  	if (data)
>  		hwmon_device_unregister(data->class_dev);
>  
> +	sysfs_remove_group(&client->dev.kobj, &w83781d_group);
> +	sysfs_remove_group(&client->dev.kobj, &w83781d_opt_group);
> +

This should be inside the if (data) conditional - subclients have no
sysfs files.

>  	if (i2c_is_isa_client(client))
>  		release_region(client->addr, W83781D_EXTENT);
>  
> 

Care to respin a patch? I'd like to have all these fixes in -mm soon.

Thanks,
-- 
Jean Delvare

