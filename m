From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 03 Sep 2007 18:30:20 +0000
Subject: Re: [lm-sensors] [PATCH] update w83791d driver with new sysfs
Message-Id: <20070903203020.545f4864@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <5bfe43f80709021541p381974dftc4f725e65d2b8189@mail.gmail.com>
In-Reply-To: <5bfe43f80709021541p381974dftc4f725e65d2b8189@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Charles,

On Sun, 2 Sep 2007 15:41:16 -0700, Charles Spirakis wrote:
> This patch was made against the 2.6.23.rc1-git10 tree. Please review
> at your leisure and also please let me know if you would like the
> patch updated for a newer version of the kernel.

Thanks for working on this. Here's my review:

> Signed-off by: Charles Spirakis <bezaur@gmail.com>

Note: should be "Signed-off-by" with two dashes.

> diff -urpN linux-2.6.23-rc1-git10/Documentation/hwmon/w83791d linux-2.6.23-rc1-git10_w83791d/Documentation/hwmon/w83791d
> --- linux-2.6.23-rc1-git10/Documentation/hwmon/w83791d	2007-07-22 13:41:00.000000000 -0700
> +++ linux-2.6.23-rc1-git10_w83791d/Documentation/hwmon/w83791d	2007-08-28 17:04:44.000000000 -0700
> @@ -115,6 +115,4 @@ often will do no harm, but will return '
>  
>  W83791D TODO:
>  ---------------
> -Provide a patch for per-file alarms and beep enables as defined in the hwmon
> -	documentation (Documentation/hwmon/sysfs-interface)
>  Provide a patch for smart-fan control (still need appropriate motherboard/fans)

A few lines above in this document, is written:

*** NOTE: It is the responsibility of user-space code to handle the fact
that the beep enable and alarm bits are in different positions when using that
feature of the chip.

Maybe it would be good to mention that this problem doesn't exist when
using the new individual alarm and beep files?

> diff -urpN linux-2.6.23-rc1-git10/MAINTAINERS linux-2.6.23-rc1-git10_w83791d/MAINTAINERS
> --- linux-2.6.23-rc1-git10/MAINTAINERS	2007-08-05 23:18:27.000000000 -0700
> +++ linux-2.6.23-rc1-git10_w83791d/MAINTAINERS	2007-08-31 15:48:41.000000000 -0700
> @@ -4070,7 +4070,7 @@ W83791D HARDWARE MONITORING DRIVER
>  P:	Charles Spirakis
>  M:	bezaur@gmail.com
>  L:	lm-sensors@lm-sensors.org
> -S:	Maintained
> +S:	Odd Fixes

Thank you for maintaining this driver for a year, BTW. This was very
much appreciated.

> diff -urpN linux-2.6.23-rc1-git10/drivers/hwmon/w83791d.c linux-2.6.23-rc1-git10_w83791d/drivers/hwmon/w83791d.c
> --- linux-2.6.23-rc1-git10/drivers/hwmon/w83791d.c	2007-07-22 13:41:00.000000000 -0700
> +++ linux-2.6.23-rc1-git10_w83791d/drivers/hwmon/w83791d.c	2007-09-01 17:10:32.000000000 -0700
> @@ -2,7 +2,7 @@
>      w83791d.c - Part of lm_sensors, Linux kernel modules for hardware
>                  monitoring
>  
> -    Copyright (C) 2006 Charles Spirakis <bezaur@gmail.com>
> +    Copyright (C) 2006-2007 Charles Spirakis <bezaur@gmail.com>
>  
>      This program is free software; you can redistribute it and/or modify
>      it under the terms of the GNU General Public License as published by
> @@ -384,6 +384,88 @@ static struct sensor_device_attribute sd
>  	SENSOR_ATTR(in9_max, S_IWUSR | S_IRUGO, show_in_max, store_in_max, 9),
>  };
>  
> +
> +static ssize_t show_beep(struct device *dev, struct device_attribute *attr,
> +			char *buf)
> +{
> +	struct sensor_device_attribute *sensor_attr > +						to_sensor_dev_attr(attr);
> +	struct w83791d_data *data = w83791d_update_device(dev);
> +	int bitnr = sensor_attr->index;
> +
> +	return sprintf(buf, "%d\n", (data->beep_mask >> bitnr) & 1);
> +}

Some times ago, Mark M. Hoffman proposed a more compact alternative to
retrieve the index value:

	int bitnr = to_sensor_dev_attr(attr)->index;

You may want to use this.

> +static ssize_t store_beep(struct device *dev, struct device_attribute *attr,
> +			const char *buf, size_t count)
> +{
> +	struct sensor_device_attribute *sensor_attr > +						to_sensor_dev_attr(attr);
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct w83791d_data *data = w83791d_update_device(dev);

We normally don't call the big update function in write callbacks. This
function reads dozens of register values which you don't need here,
this will make the write very slow. The preferred way is to read just
the register(s) you need. This should be fairly easy in your case.

> +	int bitnr = sensor_attr->index;
> +	long val = simple_strtol(buf, NULL, 10) ? 1 : 0;
> +	long beep_bit = val ? (1 << bitnr) : 0;

More simply written val << bitnr.

> +	int i;
> +
> +	mutex_lock(&data->update_lock);
> +
> +	data->beep_mask &= ~(1 << bitnr);
> +	data->beep_mask |= (beep_bit);
> +
> +	val = data->beep_mask;
> +
> +	/* In theory, based on the bit we changed we only need to update
> +	   one register, but why bother, this isn't time critical code... */
> +	for (i = 0; i < 3; i++) {
> +		w83791d_write(client, W83791D_REG_BEEP_CTRL[i], (val & 0xff));
> +		val >>= 8;
> +	}

I agree that this isn't time critical, but I2C transactions can be slow
and selecting the right byte is really easy:

	int bytenr = bitnr / 8;
	w83791d_write(client, W83791D_REG_BEEP_CTRL[bytenr],
		      (data->beep_mask >> (bytenr * 8)) & 0xff);

So maybe you can do it after all?

> +
> +	mutex_unlock(&data->update_lock);
> +
> +	return count;
> +}
> +
> +static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
> +			char *buf)
> +{
> +	struct sensor_device_attribute *sensor_attr > +						to_sensor_dev_attr(attr);
> +	struct w83791d_data *data = w83791d_update_device(dev);
> +	int bitnr = sensor_attr->index;
> +
> +	return sprintf(buf, "%d\n", (data->alarms >> bitnr) & 1);
> +}
> +
> +/* Note: The bitmask for the beep enable/disable is different than
> +   the bitmask for the alarm. */
> +static struct sensor_device_attribute sda_in_beep[] = {
> +	SENSOR_ATTR(in0_beep, S_IWUSR | S_IRUGO, show_beep, store_beep, 0),
> +	SENSOR_ATTR(in1_beep, S_IWUSR | S_IRUGO, show_beep, store_beep, 13),
> +	SENSOR_ATTR(in2_beep, S_IWUSR | S_IRUGO, show_beep, store_beep, 2),
> +	SENSOR_ATTR(in3_beep, S_IWUSR | S_IRUGO, show_beep, store_beep, 3),
> +	SENSOR_ATTR(in4_beep, S_IWUSR | S_IRUGO, show_beep, store_beep, 8),
> +	SENSOR_ATTR(in5_beep, S_IWUSR | S_IRUGO, show_beep, store_beep, 9),
> +	SENSOR_ATTR(in6_beep, S_IWUSR | S_IRUGO, show_beep, store_beep, 10),
> +	SENSOR_ATTR(in7_beep, S_IWUSR | S_IRUGO, show_beep, store_beep, 16),
> +	SENSOR_ATTR(in8_beep, S_IWUSR | S_IRUGO, show_beep, store_beep, 17),
> +	SENSOR_ATTR(in9_beep, S_IWUSR | S_IRUGO, show_beep, store_beep, 14),
> +};
> +
> +static struct sensor_device_attribute sda_in_alarm[] = {
> +	SENSOR_ATTR(in0_alarm, S_IRUGO, show_alarm, NULL, 0),
> +	SENSOR_ATTR(in1_alarm, S_IRUGO, show_alarm, NULL, 1),
> +	SENSOR_ATTR(in2_alarm, S_IRUGO, show_alarm, NULL, 2),
> +	SENSOR_ATTR(in3_alarm, S_IRUGO, show_alarm, NULL, 3),
> +	SENSOR_ATTR(in4_alarm, S_IRUGO, show_alarm, NULL, 8),
> +	SENSOR_ATTR(in5_alarm, S_IRUGO, show_alarm, NULL, 9),
> +	SENSOR_ATTR(in6_alarm, S_IRUGO, show_alarm, NULL, 10),
> +	SENSOR_ATTR(in7_alarm, S_IRUGO, show_alarm, NULL, 19),
> +	SENSOR_ATTR(in8_alarm, S_IRUGO, show_alarm, NULL, 20),
> +	SENSOR_ATTR(in9_alarm, S_IRUGO, show_alarm, NULL, 14),
> +};
> +
>  #define show_fan_reg(reg) \
>  static ssize_t show_##reg(struct device *dev, struct device_attribute *attr, \
>  				char *buf) \
> @@ -536,6 +618,22 @@ static struct sensor_device_attribute sd
>  			show_fan_div, store_fan_div, 4),
>  };
>  
> +static struct sensor_device_attribute sda_fan_beep[] = {
> +	SENSOR_ATTR(fan1_beep, S_IWUSR | S_IRUGO, show_beep, store_beep, 6),
> +	SENSOR_ATTR(fan2_beep, S_IWUSR | S_IRUGO, show_beep, store_beep, 7),
> +	SENSOR_ATTR(fan3_beep, S_IWUSR | S_IRUGO, show_beep, store_beep, 11),
> +	SENSOR_ATTR(fan4_beep, S_IWUSR | S_IRUGO, show_beep, store_beep, 21),
> +	SENSOR_ATTR(fan5_beep, S_IWUSR | S_IRUGO, show_beep, store_beep, 22)

Please add a trailing comma, and below too (4 times total.)

> +};
> +
> +static struct sensor_device_attribute sda_fan_alarm[] = {
> +	SENSOR_ATTR(fan1_alarm, S_IRUGO, show_alarm, NULL, 6),
> +	SENSOR_ATTR(fan2_alarm, S_IRUGO, show_alarm, NULL, 7),
> +	SENSOR_ATTR(fan3_alarm, S_IRUGO, show_alarm, NULL, 11),
> +	SENSOR_ATTR(fan4_alarm, S_IRUGO, show_alarm, NULL, 21),
> +	SENSOR_ATTR(fan5_alarm, S_IRUGO, show_alarm, NULL, 22)
> +};
> +
>  /* read/write the temperature1, includes measured value and limits */
>  static ssize_t show_temp1(struct device *dev, struct device_attribute *devattr,
>  				char *buf)
> @@ -618,6 +716,19 @@ static struct sensor_device_attribute_2 
>  			show_temp23, store_temp23, 1, 2),
>  };
>  
> +/* Note: The bitmask for the beep enable/disable is different than
> +   the bitmask for the alarm. */
> +static struct sensor_device_attribute sda_temp_beep[] = {
> +	SENSOR_ATTR(temp1_beep, S_IWUSR | S_IRUGO, show_beep, store_beep, 4),
> +	SENSOR_ATTR(temp2_beep, S_IWUSR | S_IRUGO, show_beep, store_beep, 5),
> +	SENSOR_ATTR(temp3_beep, S_IWUSR | S_IRUGO, show_beep, store_beep, 1)
> +};
> +
> +static struct sensor_device_attribute sda_temp_alarm[] = {
> +	SENSOR_ATTR(temp1_alarm, S_IRUGO, show_alarm, NULL, 4),
> +	SENSOR_ATTR(temp2_alarm, S_IRUGO, show_alarm, NULL, 5),
> +	SENSOR_ATTR(temp3_alarm, S_IRUGO, show_alarm, NULL, 13)
> +};
>  
>  /* get reatime status of all sensors items: voltage, temp, fan */
>  static ssize_t show_alarms_reg(struct device *dev,
> @@ -749,17 +860,23 @@ static DEVICE_ATTR(vrm, S_IRUGO | S_IWUS
>  #define IN_UNIT_ATTRS(X) \
>  	&sda_in_input[X].dev_attr.attr, \
>  	&sda_in_min[X].dev_attr.attr,   \
> -	&sda_in_max[X].dev_attr.attr
> +	&sda_in_max[X].dev_attr.attr,   \
> +	&sda_in_beep[X].dev_attr.attr,  \
> +	&sda_in_alarm[X].dev_attr.attr
>  
>  #define FAN_UNIT_ATTRS(X) \
>  	&sda_fan_input[X].dev_attr.attr,        \
>  	&sda_fan_min[X].dev_attr.attr,          \
> -	&sda_fan_div[X].dev_attr.attr
> +	&sda_fan_div[X].dev_attr.attr,          \
> +	&sda_fan_beep[X].dev_attr.attr,         \
> +	&sda_fan_alarm[X].dev_attr.attr
>  
>  #define TEMP_UNIT_ATTRS(X) \
>  	&sda_temp_input[X].dev_attr.attr,       \
>  	&sda_temp_max[X].dev_attr.attr,         \
> -	&sda_temp_max_hyst[X].dev_attr.attr
> +	&sda_temp_max_hyst[X].dev_attr.attr,    \
> +	&sda_temp_beep[X].dev_attr.attr,        \
> +	&sda_temp_alarm[X].dev_attr.attr
>  
>  static struct attribute *w83791d_attributes[] = {
>  	IN_UNIT_ATTRS(0),
> @@ -1280,3 +1397,5 @@ MODULE_LICENSE("GPL");
>  
>  module_init(sensors_w83791d_init);
>  module_exit(sensors_w83791d_exit);
> +
> +/* vim: set ts=8 sw=8 twx sts=0 noet ai cin cino= formatoptions=croql: */

I'd venture that you did not really want this to be part of your patch?

Overall it looks good, can you generate an updated patch based on my
comments? Then Mark can apply it.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
