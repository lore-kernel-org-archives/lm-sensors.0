From: Riku Voipio <riku.voipio@iki.fi>
Date: Mon, 28 Jan 2008 12:27:06 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (it87) Add individual alarm
Message-Id: <479DCA1A.7060102@iki.fi>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> The new libsensors needs this.
>
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
> Riku, you said you have a chip to test the it87 driver, maybe you can
> test this patch? Thanks.
>
>   
Sorry, forgot about this. Reviewed, fine. Tested by applying to
2.6.24, adds correctly the alarm sysfs nodes and new lm-sensors
parses them fine. full ack.

>  drivers/hwmon/it87.c |   75 ++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 66 insertions(+), 9 deletions(-)
>
> --- linux-2.6.24-rc3.orig/drivers/hwmon/it87.c	2007-11-25 14:30:26.000000000 +0100
> +++ linux-2.6.24-rc3/drivers/hwmon/it87.c	2007-11-25 14:47:37.000000000 +0100
> @@ -10,7 +10,7 @@
>                Sis950   A clone of the IT8705F
>  
>      Copyright (C) 2001 Chris Gauthron
> -    Copyright (C) 2005-2006 Jean Delvare <khali@linux-fr.org>
> +    Copyright (C) 2005-2007 Jean Delvare <khali@linux-fr.org>
>  
>      This program is free software; you can redistribute it and/or modify
>      it under the terms of the GNU General Public License as published by
> @@ -767,6 +767,30 @@ static ssize_t show_alarms(struct device
>  }
>  static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
>  
> +static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
> +		char *buf)
> +{
> +	int bitnr = to_sensor_dev_attr(attr)->index;
> +	struct it87_data *data = it87_update_device(dev);
> +	return sprintf(buf, "%u\n", (data->alarms >> bitnr) & 1);
> +}
> +static SENSOR_DEVICE_ATTR(in0_alarm, S_IRUGO, show_alarm, NULL, 8);
> +static SENSOR_DEVICE_ATTR(in1_alarm, S_IRUGO, show_alarm, NULL, 9);
> +static SENSOR_DEVICE_ATTR(in2_alarm, S_IRUGO, show_alarm, NULL, 10);
> +static SENSOR_DEVICE_ATTR(in3_alarm, S_IRUGO, show_alarm, NULL, 11);
> +static SENSOR_DEVICE_ATTR(in4_alarm, S_IRUGO, show_alarm, NULL, 12);
> +static SENSOR_DEVICE_ATTR(in5_alarm, S_IRUGO, show_alarm, NULL, 13);
> +static SENSOR_DEVICE_ATTR(in6_alarm, S_IRUGO, show_alarm, NULL, 14);
> +static SENSOR_DEVICE_ATTR(in7_alarm, S_IRUGO, show_alarm, NULL, 15);
> +static SENSOR_DEVICE_ATTR(fan1_alarm, S_IRUGO, show_alarm, NULL, 0);
> +static SENSOR_DEVICE_ATTR(fan2_alarm, S_IRUGO, show_alarm, NULL, 1);
> +static SENSOR_DEVICE_ATTR(fan3_alarm, S_IRUGO, show_alarm, NULL, 2);
> +static SENSOR_DEVICE_ATTR(fan4_alarm, S_IRUGO, show_alarm, NULL, 3);
> +static SENSOR_DEVICE_ATTR(fan5_alarm, S_IRUGO, show_alarm, NULL, 6);
> +static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO, show_alarm, NULL, 16);
> +static SENSOR_DEVICE_ATTR(temp2_alarm, S_IRUGO, show_alarm, NULL, 17);
> +static SENSOR_DEVICE_ATTR(temp3_alarm, S_IRUGO, show_alarm, NULL, 18);
> +
>  static ssize_t
>  show_vrm_reg(struct device *dev, struct device_attribute *attr, char *buf)
>  {
> @@ -828,6 +852,14 @@ static struct attribute *it87_attributes
>  	&sensor_dev_attr_in5_max.dev_attr.attr,
>  	&sensor_dev_attr_in6_max.dev_attr.attr,
>  	&sensor_dev_attr_in7_max.dev_attr.attr,
> +	&sensor_dev_attr_in0_alarm.dev_attr.attr,
> +	&sensor_dev_attr_in1_alarm.dev_attr.attr,
> +	&sensor_dev_attr_in2_alarm.dev_attr.attr,
> +	&sensor_dev_attr_in3_alarm.dev_attr.attr,
> +	&sensor_dev_attr_in4_alarm.dev_attr.attr,
> +	&sensor_dev_attr_in5_alarm.dev_attr.attr,
> +	&sensor_dev_attr_in6_alarm.dev_attr.attr,
> +	&sensor_dev_attr_in7_alarm.dev_attr.attr,
>  
>  	&sensor_dev_attr_temp1_input.dev_attr.attr,
>  	&sensor_dev_attr_temp2_input.dev_attr.attr,
> @@ -841,6 +873,9 @@ static struct attribute *it87_attributes
>  	&sensor_dev_attr_temp1_type.dev_attr.attr,
>  	&sensor_dev_attr_temp2_type.dev_attr.attr,
>  	&sensor_dev_attr_temp3_type.dev_attr.attr,
> +	&sensor_dev_attr_temp1_alarm.dev_attr.attr,
> +	&sensor_dev_attr_temp2_alarm.dev_attr.attr,
> +	&sensor_dev_attr_temp3_alarm.dev_attr.attr,
>  
>  	&dev_attr_alarms.attr,
>  	&dev_attr_name.attr,
> @@ -873,6 +908,12 @@ static struct attribute *it87_attributes
>  	&sensor_dev_attr_fan3_min.dev_attr.attr,
>  	&sensor_dev_attr_fan3_div.dev_attr.attr,
>  
> +	&sensor_dev_attr_fan1_alarm.dev_attr.attr,
> +	&sensor_dev_attr_fan2_alarm.dev_attr.attr,
> +	&sensor_dev_attr_fan3_alarm.dev_attr.attr,
> +	&sensor_dev_attr_fan4_alarm.dev_attr.attr,
> +	&sensor_dev_attr_fan5_alarm.dev_attr.attr,
> +
>  	&sensor_dev_attr_pwm1_enable.dev_attr.attr,
>  	&sensor_dev_attr_pwm2_enable.dev_attr.attr,
>  	&sensor_dev_attr_pwm3_enable.dev_attr.attr,
> @@ -1018,35 +1059,45 @@ static int __devinit it87_probe(struct p
>  			if ((err = device_create_file(dev,
>  			     &sensor_dev_attr_fan1_input16.dev_attr))
>  			 || (err = device_create_file(dev,
> -			     &sensor_dev_attr_fan1_min16.dev_attr)))
> +			     &sensor_dev_attr_fan1_min16.dev_attr))
> +			 || (err = device_create_file(dev,
> +			     &sensor_dev_attr_fan1_alarm.dev_attr)))
>  				goto ERROR4;
>  		}
>  		if (data->has_fan & (1 << 1)) {
>  			if ((err = device_create_file(dev,
>  			     &sensor_dev_attr_fan2_input16.dev_attr))
>  			 || (err = device_create_file(dev,
> -			     &sensor_dev_attr_fan2_min16.dev_attr)))
> +			     &sensor_dev_attr_fan2_min16.dev_attr))
> +			 || (err = device_create_file(dev,
> +			     &sensor_dev_attr_fan2_alarm.dev_attr)))
>  				goto ERROR4;
>  		}
>  		if (data->has_fan & (1 << 2)) {
>  			if ((err = device_create_file(dev,
>  			     &sensor_dev_attr_fan3_input16.dev_attr))
>  			 || (err = device_create_file(dev,
> -			     &sensor_dev_attr_fan3_min16.dev_attr)))
> +			     &sensor_dev_attr_fan3_min16.dev_attr))
> +			 || (err = device_create_file(dev,
> +			     &sensor_dev_attr_fan3_alarm.dev_attr)))
>  				goto ERROR4;
>  		}
>  		if (data->has_fan & (1 << 3)) {
>  			if ((err = device_create_file(dev,
>  			     &sensor_dev_attr_fan4_input16.dev_attr))
>  			 || (err = device_create_file(dev,
> -			     &sensor_dev_attr_fan4_min16.dev_attr)))
> +			     &sensor_dev_attr_fan4_min16.dev_attr))
> +			 || (err = device_create_file(dev,
> +			     &sensor_dev_attr_fan4_alarm.dev_attr)))
>  				goto ERROR4;
>  		}
>  		if (data->has_fan & (1 << 4)) {
>  			if ((err = device_create_file(dev,
>  			     &sensor_dev_attr_fan5_input16.dev_attr))
>  			 || (err = device_create_file(dev,
> -			     &sensor_dev_attr_fan5_min16.dev_attr)))
> +			     &sensor_dev_attr_fan5_min16.dev_attr))
> +			 || (err = device_create_file(dev,
> +			     &sensor_dev_attr_fan5_alarm.dev_attr)))
>  				goto ERROR4;
>  		}
>  	} else {
> @@ -1057,7 +1108,9 @@ static int __devinit it87_probe(struct p
>  			 || (err = device_create_file(dev,
>  			     &sensor_dev_attr_fan1_min.dev_attr))
>  			 || (err = device_create_file(dev,
> -			     &sensor_dev_attr_fan1_div.dev_attr)))
> +			     &sensor_dev_attr_fan1_div.dev_attr))
> +			 || (err = device_create_file(dev,
> +			     &sensor_dev_attr_fan1_alarm.dev_attr)))
>  				goto ERROR4;
>  		}
>  		if (data->has_fan & (1 << 1)) {
> @@ -1066,7 +1119,9 @@ static int __devinit it87_probe(struct p
>  			 || (err = device_create_file(dev,
>  			     &sensor_dev_attr_fan2_min.dev_attr))
>  			 || (err = device_create_file(dev,
> -			     &sensor_dev_attr_fan2_div.dev_attr)))
> +			     &sensor_dev_attr_fan2_div.dev_attr))
> +			 || (err = device_create_file(dev,
> +			     &sensor_dev_attr_fan2_alarm.dev_attr)))
>  				goto ERROR4;
>  		}
>  		if (data->has_fan & (1 << 2)) {
> @@ -1075,7 +1130,9 @@ static int __devinit it87_probe(struct p
>  			 || (err = device_create_file(dev,
>  			     &sensor_dev_attr_fan3_min.dev_attr))
>  			 || (err = device_create_file(dev,
> -			     &sensor_dev_attr_fan3_div.dev_attr)))
> +			     &sensor_dev_attr_fan3_div.dev_attr))
> +			 || (err = device_create_file(dev,
> +			     &sensor_dev_attr_fan3_alarm.dev_attr)))
>  				goto ERROR4;
>  		}
>  	}
>
>
>   


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
