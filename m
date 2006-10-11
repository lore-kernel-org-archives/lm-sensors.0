From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 11 Oct 2006 13:28:19 +0000
Subject: [lm-sensors] [patch 1.6.19-rc1+] hwmon/pc87360: separate {min,
Message-Id: <20061011152819.b0e6002d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4529A56C.1030507@gmail.com>
In-Reply-To: <4529A56C.1030507@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

> implement separate min, max, alarms for each voltage input,
> and min, max, crit alarms for temps.
> 
> Signed-off-by:  Jim Cromie <jim.cromie at gmail.com>
> ---
> 
> $ diffstat pc-set/hwmon-pc87360-separate-alarms.patch
>  pc87360.c |  144 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 files changed, 139 insertions(+), 5 deletions(-)
> 
> > What about the fans?
>
> Current driver has no existing alarms on the fans, and my mobo has no 
> fans either.

"sensors" display alarms for the fans for all the PC87360 family chips,
so they must exist.

> So adding them is a- more risky cuz its untestable here, b - a new feature.
> I'll look at it later.

This shouldn't be that risky, and we need it anyway. We can't switch
libsensors to the new model until it offers a functionality level
equivalent to the current code for all supported devices.

> diff -ruNp -X dontdiff -X exclude-diffs 19rc1-0/drivers/hwmon/pc87360.c 19rc1-1/drivers/hwmon/pc87360.c
> --- 19rc1-0/drivers/hwmon/pc87360.c	2006-10-05 20:17:51.000000000 -0600
> +++ 19rc1-1/drivers/hwmon/pc87360.c	2006-10-10 09:00:29.000000000 -0600
> @@ -495,7 +495,9 @@ static struct sensor_device_attribute in
>  	&in_input[X].dev_attr.attr,	\
>  	&in_status[X].dev_attr.attr,	\
>  	&in_min[X].dev_attr.attr,	\
> -	&in_max[X].dev_attr.attr
> +	&in_max[X].dev_attr.attr,	\
> +	&in_min_alarm[X].dev_attr.attr,	\
> +	&in_max_alarm[X].dev_attr.attr
>  
>  static ssize_t show_vid(struct device *dev, struct device_attribute *attr, char *buf)
>  {
> @@ -525,6 +527,46 @@ static ssize_t show_in_alarms(struct dev
>  }
>  static DEVICE_ATTR(alarms_in, S_IRUGO, show_in_alarms, NULL);
>  
> +static ssize_t show_in_max_alarm(struct device *dev, struct device_attribute *devattr, char *buf)

Line too long, please fold. Same for all other callbacks you introduced.

> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct pc87360_data *data = pc87360_update_device(dev);
> +	return sprintf(buf, "%u\n", (data->in_status[attr->index] & 4) >> 2); 
> +}
> +static struct sensor_device_attribute in_max_alarm[] = {
> +	SENSOR_ATTR(in0_max_alarm, S_IRUGO, show_in_max_alarm, NULL, 0),
> +	SENSOR_ATTR(in1_max_alarm, S_IRUGO, show_in_max_alarm, NULL, 1),
> +	SENSOR_ATTR(in2_max_alarm, S_IRUGO, show_in_max_alarm, NULL, 2),
> +	SENSOR_ATTR(in3_max_alarm, S_IRUGO, show_in_max_alarm, NULL, 3),
> +	SENSOR_ATTR(in4_max_alarm, S_IRUGO, show_in_max_alarm, NULL, 4),
> +	SENSOR_ATTR(in5_max_alarm, S_IRUGO, show_in_max_alarm, NULL, 5),
> +	SENSOR_ATTR(in6_max_alarm, S_IRUGO, show_in_max_alarm, NULL, 6),
> +	SENSOR_ATTR(in7_max_alarm, S_IRUGO, show_in_max_alarm, NULL, 7),
> +	SENSOR_ATTR(in8_max_alarm, S_IRUGO, show_in_max_alarm, NULL, 8),
> +	SENSOR_ATTR(in9_max_alarm, S_IRUGO, show_in_max_alarm, NULL, 9),
> +	SENSOR_ATTR(in10_max_alarm, S_IRUGO, show_in_max_alarm, NULL, 10),
> +};
> +
> +static ssize_t show_in_min_alarm(struct device *dev, struct device_attribute *devattr, char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct pc87360_data *data = pc87360_update_device(dev);
> +	return sprintf(buf, "%u\n", (data->in_status[attr->index] & 2) >> 1);
> +}
> +static struct sensor_device_attribute in_min_alarm[] = {
> +	SENSOR_ATTR(in0_min_alarm, S_IRUGO, show_in_min_alarm, NULL, 0),
> +	SENSOR_ATTR(in1_min_alarm, S_IRUGO, show_in_min_alarm, NULL, 1),
> +	SENSOR_ATTR(in2_min_alarm, S_IRUGO, show_in_min_alarm, NULL, 2),
> +	SENSOR_ATTR(in3_min_alarm, S_IRUGO, show_in_min_alarm, NULL, 2),
> +	SENSOR_ATTR(in4_min_alarm, S_IRUGO, show_in_min_alarm, NULL, 4),
> +	SENSOR_ATTR(in5_min_alarm, S_IRUGO, show_in_min_alarm, NULL, 5),
> +	SENSOR_ATTR(in6_min_alarm, S_IRUGO, show_in_min_alarm, NULL, 6),
> +	SENSOR_ATTR(in7_min_alarm, S_IRUGO, show_in_min_alarm, NULL, 7),
> +	SENSOR_ATTR(in8_min_alarm, S_IRUGO, show_in_min_alarm, NULL, 8),
> +	SENSOR_ATTR(in9_min_alarm, S_IRUGO, show_in_min_alarm, NULL, 9),
> +	SENSOR_ATTR(in10_min_alarm, S_IRUGO, show_in_min_alarm, NULL, 10),
> +};
> +
>  static struct attribute *pc8736x_vin_attr_array[] = {
>  	VIN_UNIT_ATTRS(0),
>  	VIN_UNIT_ATTRS(1),
> @@ -664,12 +706,60 @@ static struct sensor_device_attribute th
>  		    show_therm_crit, set_therm_crit, 2+11),
>  };
>  
> +static ssize_t show_therm_min_alarm(struct device *dev, struct device_attribute *devattr, char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct pc87360_data *data = pc87360_update_device(dev);
> +	return sprintf(buf, "%u\n", (data->in_status[attr->index] & 2) >> 1); 
> +}

This callback is exactly the same as show_in_min_alarm above, so why
don't you just reuse it? Same for show_therm_max_alarm below and
show_in_max_alarm.

Which made me check the current code, and it appears that
show_therm_input, show_therm_min and show_therm_max are redundant with
show_in_input, show_in_min and show_in_max, respectively, so the code
could be simplified. And this is again true of "set" callbacks, unless
I am overlooking something? The benefit is even bigger here as these
callbacks are larger. Care to submit a patch?

> +static struct sensor_device_attribute therm_min_alarm[] = {
> +	SENSOR_ATTR(temp4_min_alarm, S_IRUGO,
> +		    show_therm_min_alarm, NULL, 0+11),
> +	SENSOR_ATTR(temp5_min_alarm, S_IRUGO,
> +		    show_therm_min_alarm, NULL, 1+11),
> +	SENSOR_ATTR(temp6_min_alarm, S_IRUGO,
> +		    show_therm_min_alarm, NULL, 2+11),
> +};
> +
> +static ssize_t show_therm_max_alarm(struct device *dev, struct device_attribute *devattr, char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct pc87360_data *data = pc87360_update_device(dev);
> +	return sprintf(buf, "%u\n", (data->in_status[attr->index] & 4) >> 2); 
> +}
> +static struct sensor_device_attribute therm_max_alarm[] = {
> +	SENSOR_ATTR(temp4_max_alarm, S_IRUGO,
> +		    show_therm_max_alarm, NULL, 0+11),
> +	SENSOR_ATTR(temp5_max_alarm, S_IRUGO,
> +		    show_therm_max_alarm, NULL, 1+11),
> +	SENSOR_ATTR(temp6_max_alarm, S_IRUGO,
> +		    show_therm_max_alarm, NULL, 2+11),
> +};
> +
> +static ssize_t show_therm_crit_alarm(struct device *dev, struct device_attribute *devattr, char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct pc87360_data *data = pc87360_update_device(dev);
> +	return sprintf(buf, "%u\n", (data->in_status[attr->index] & 8) >> 3); 
> +}
> +static struct sensor_device_attribute therm_crit_alarm[] = {
> +	SENSOR_ATTR(temp4_crit_alarm, S_IRUGO,
> +		    show_therm_crit_alarm, NULL, 0+11),
> +	SENSOR_ATTR(temp5_crit_alarm, S_IRUGO,
> +		    show_therm_crit_alarm, NULL, 1+11),
> +	SENSOR_ATTR(temp6_crit_alarm, S_IRUGO,
> +		    show_therm_crit_alarm, NULL, 2+11),
> +};
> +
>  #define THERM_UNIT_ATTRS(X) \
>  	&therm_input[X].dev_attr.attr,	\
>  	&therm_status[X].dev_attr.attr,	\
>  	&therm_min[X].dev_attr.attr,	\
>  	&therm_max[X].dev_attr.attr,	\
> -	&therm_crit[X].dev_attr.attr
> +	&therm_crit[X].dev_attr.attr,	\
> +	&therm_min_alarm[X].dev_attr.attr, \
> +	&therm_max_alarm[X].dev_attr.attr, \
> +	&therm_crit_alarm[X].dev_attr.attr
>  
>  static struct attribute * pc8736x_therm_attr_array[] = {
>  	THERM_UNIT_ATTRS(0),
> @@ -799,18 +889,56 @@ static ssize_t show_temp_alarms(struct d
>  }
>  static DEVICE_ATTR(alarms_temp, S_IRUGO, show_temp_alarms, NULL);
>  
> +static ssize_t show_temp_min_alarm(struct device *dev, struct device_attribute *devattr, char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct pc87360_data *data = pc87360_update_device(dev);
> +	return sprintf(buf, "%u\n", (data->temp_status[attr->index] & 2) >> 1);
> +}
> +static struct sensor_device_attribute temp_min_alarm[] = {
> +	SENSOR_ATTR(temp1_min_alarm, S_IRUGO, show_temp_min_alarm, NULL, 0),
> +	SENSOR_ATTR(temp2_min_alarm, S_IRUGO, show_temp_min_alarm, NULL, 1),
> +	SENSOR_ATTR(temp3_min_alarm, S_IRUGO, show_temp_min_alarm, NULL, 2),
> +};
> +
> +static ssize_t show_temp_max_alarm(struct device *dev, struct device_attribute *devattr, char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct pc87360_data *data = pc87360_update_device(dev);
> +	return sprintf(buf, "%u\n", (data->temp_status[attr->index] & 4) >> 2);
> +}
> +static struct sensor_device_attribute temp_max_alarm[] = {
> +	SENSOR_ATTR(temp1_max_alarm, S_IRUGO, show_temp_max_alarm, NULL, 0),
> +	SENSOR_ATTR(temp2_max_alarm, S_IRUGO, show_temp_max_alarm, NULL, 1),
> +	SENSOR_ATTR(temp3_max_alarm, S_IRUGO, show_temp_max_alarm, NULL, 2),
> +};
> +
> +static ssize_t show_temp_crit_alarm(struct device *dev, struct device_attribute *devattr, char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct pc87360_data *data = pc87360_update_device(dev);
> +	return sprintf(buf, "%u\n", (data->temp_status[attr->index] & 8) >> 3);
> +}
> +static struct sensor_device_attribute temp_crit_alarm[] = {
> +	SENSOR_ATTR(temp1_crit_alarm, S_IRUGO, show_temp_crit_alarm, NULL, 0),
> +	SENSOR_ATTR(temp2_crit_alarm, S_IRUGO, show_temp_crit_alarm, NULL, 1),
> +	SENSOR_ATTR(temp3_crit_alarm, S_IRUGO, show_temp_crit_alarm, NULL, 2),
> +};
> +
>  #define TEMP_UNIT_ATTRS(X) \
>  	&temp_input[X].dev_attr.attr,	\
>  	&temp_status[X].dev_attr.attr,	\
>  	&temp_min[X].dev_attr.attr,	\
>  	&temp_max[X].dev_attr.attr,	\
> -	&temp_crit[X].dev_attr.attr
> +	&temp_crit[X].dev_attr.attr,	\
> +	&temp_min_alarm[X].dev_attr.attr, \
> +	&temp_max_alarm[X].dev_attr.attr, \
> +	&temp_crit_alarm[X].dev_attr.attr
>  
>  static struct attribute * pc8736x_temp_attr_array[] = {
>  	TEMP_UNIT_ATTRS(0),
>  	TEMP_UNIT_ATTRS(1),
>  	TEMP_UNIT_ATTRS(2),
> -	/* include the few miscellaneous atts here */

This comment can stay for now?

>  	&dev_attr_alarms_temp.attr,
>  	NULL
>  };
> @@ -1043,7 +1171,13 @@ static int pc87360_detect(struct i2c_ada
>  			    || (err = device_create_file(dev,
>  					&temp_crit[i].dev_attr))
>  			    || (err = device_create_file(dev,
> -					&temp_status[i].dev_attr)))
> +					&temp_status[i].dev_attr))
> +			    || (err = device_create_file(dev,
> +					&temp_min_alarm[i].dev_attr))
> +			    || (err = device_create_file(dev,
> +					&temp_max_alarm[i].dev_attr))
> +			    || (err = device_create_file(dev,
> +					&temp_crit_alarm[i].dev_attr)))
>  				goto ERROR3;
>  		}
>  		if ((err = device_create_file(dev, &dev_attr_alarms_temp)))
> 

Otherwise it looks OK to me, thanks for working on this. Please
resubmit with the minor issues above addressed and the fan alarms when
you're done with that.

Thanks,
-- 
Jean Delvare

