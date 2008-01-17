From: "Roger Lucas" <roger@hiddenengine.co.uk>
Date: Thu, 17 Jan 2008 00:05:28 +0000
Subject: Re: [lm-sensors] hwmon: (vt8231) Add individual alarm files
Message-Id: <006a01c8589c$ab0604e0$8001a8c0@wolverine>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080106154602.3f81ae40@hyperion.delvare>
In-Reply-To: <20080106154602.3f81ae40@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Sorry for the slow reply - I have finally had a chance to test your changes on the most recent 2.6.24-rc8 kernel.

I have checked all the voltage, fan and temperature alarms and they work as expected.  I only have one temperature
sensor on my motherboard so I was not able to test the alarms for temperatures 2 through 6, but the code looks correct
so I would be very surprised if they did not work properly.

My mail address is changing soon so I have a patch below to correct my e-mail addresses in the source code.  I have a
special address for the vt8231 kernel development so that I can filter the spam on it more aggressively - it does seem
to get heavily harvested...

Thanks for your work preparing this patch - 100% right first time :-)

Best regards,

Roger Lucas


Signed-off-by: Roger Lucas <vt8231@hiddenengine.co.uk>

--- linux-2.6.24-rc8-orig/drivers/hwmon/vt8231.c        2008-01-16 22:59:25.000000000 +0000
+++ linux-2.6.24-rc8/drivers/hwmon/vt8231.c     2008-01-16 23:57:27.000000000 +0000
@@ -2,7 +2,7 @@
        vt8231.c - Part of lm_sensors, Linux kernel modules
                                for hardware monitoring

-       Copyright (c) 2005 Roger Lucas <roger@planbit.co.uk>
+       Copyright (c) 2005 Roger Lucas <vt8231@hiddenengine.co.uk>
        Copyright (c) 2002 Mark D. Studebaker <mdsxyz123@yahoo.com>
                           Aaron M. Marsh <amarsh@sdf.lonestar.org>

@@ -999,7 +999,7 @@
        }
 }

-MODULE_AUTHOR("Roger Lucas <roger@planbit.co.uk>");
+MODULE_AUTHOR("Roger Lucas <vt8231@hiddenengine.co.uk>");
 MODULE_DESCRIPTION("VT8231 sensors");
 MODULE_LICENSE("GPL");



> -----Original Message-----
> From: Jean Delvare [mailto:khali@linux-fr.org]
> Sent: 06 January 2008 14:46
> To: LM Sensors; Roger Lucas
> Subject: hwmon: (vt8231) Add individual alarm files
> 
> The new libsensors needs these individual alarm files.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Roger Lucas <roger@planbit.co.uk>
> ---
> Roger, can you please test and/or review this patch?
> 
>  drivers/hwmon/vt8231.c |   40 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 38 insertions(+), 2 deletions(-)
> 
> --- linux-2.6.24-rc6.orig/drivers/hwmon/vt8231.c	2007-12-26 14:39:06.000000000 +0100
> +++ linux-2.6.24-rc6/drivers/hwmon/vt8231.c	2008-01-01 19:22:37.000000000 +0100
> @@ -541,6 +541,28 @@ static ssize_t show_alarms(struct device
>  }
>  static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
> 
> +static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
> +			  char *buf)
> +{
> +	int bitnr = to_sensor_dev_attr(attr)->index;
> +	struct vt8231_data *data = vt8231_update_device(dev);
> +	return sprintf(buf, "%u\n", (data->alarms >> bitnr) & 1);
> +}
> +static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO, show_alarm, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp2_alarm, S_IRUGO, show_alarm, NULL, 11);
> +static SENSOR_DEVICE_ATTR(temp3_alarm, S_IRUGO, show_alarm, NULL, 0);
> +static SENSOR_DEVICE_ATTR(temp4_alarm, S_IRUGO, show_alarm, NULL, 1);
> +static SENSOR_DEVICE_ATTR(temp5_alarm, S_IRUGO, show_alarm, NULL, 3);
> +static SENSOR_DEVICE_ATTR(temp6_alarm, S_IRUGO, show_alarm, NULL, 8);
> +static SENSOR_DEVICE_ATTR(in0_alarm, S_IRUGO, show_alarm, NULL, 11);
> +static SENSOR_DEVICE_ATTR(in1_alarm, S_IRUGO, show_alarm, NULL, 0);
> +static SENSOR_DEVICE_ATTR(in2_alarm, S_IRUGO, show_alarm, NULL, 1);
> +static SENSOR_DEVICE_ATTR(in3_alarm, S_IRUGO, show_alarm, NULL, 3);
> +static SENSOR_DEVICE_ATTR(in4_alarm, S_IRUGO, show_alarm, NULL, 8);
> +static SENSOR_DEVICE_ATTR(in5_alarm, S_IRUGO, show_alarm, NULL, 2);
> +static SENSOR_DEVICE_ATTR(fan1_alarm, S_IRUGO, show_alarm, NULL, 6);
> +static SENSOR_DEVICE_ATTR(fan2_alarm, S_IRUGO, show_alarm, NULL, 7);
> +
>  static ssize_t show_name(struct device *dev, struct device_attribute
>  			 *devattr, char *buf)
>  {
> @@ -549,36 +571,42 @@ static ssize_t show_name(struct device *
>  }
>  static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
> 
> -static struct attribute *vt8231_attributes_temps[6][4] = {
> +static struct attribute *vt8231_attributes_temps[6][5] = {
>  	{
>  		&dev_attr_temp1_input.attr,
>  		&dev_attr_temp1_max_hyst.attr,
>  		&dev_attr_temp1_max.attr,
> +		&sensor_dev_attr_temp1_alarm.dev_attr.attr,
>  		NULL
>  	}, {
>  		&sensor_dev_attr_temp2_input.dev_attr.attr,
>  		&sensor_dev_attr_temp2_max_hyst.dev_attr.attr,
>  		&sensor_dev_attr_temp2_max.dev_attr.attr,
> +		&sensor_dev_attr_temp2_alarm.dev_attr.attr,
>  		NULL
>  	}, {
>  		&sensor_dev_attr_temp3_input.dev_attr.attr,
>  		&sensor_dev_attr_temp3_max_hyst.dev_attr.attr,
>  		&sensor_dev_attr_temp3_max.dev_attr.attr,
> +		&sensor_dev_attr_temp3_alarm.dev_attr.attr,
>  		NULL
>  	}, {
>  		&sensor_dev_attr_temp4_input.dev_attr.attr,
>  		&sensor_dev_attr_temp4_max_hyst.dev_attr.attr,
>  		&sensor_dev_attr_temp4_max.dev_attr.attr,
> +		&sensor_dev_attr_temp4_alarm.dev_attr.attr,
>  		NULL
>  	}, {
>  		&sensor_dev_attr_temp5_input.dev_attr.attr,
>  		&sensor_dev_attr_temp5_max_hyst.dev_attr.attr,
>  		&sensor_dev_attr_temp5_max.dev_attr.attr,
> +		&sensor_dev_attr_temp5_alarm.dev_attr.attr,
>  		NULL
>  	}, {
>  		&sensor_dev_attr_temp6_input.dev_attr.attr,
>  		&sensor_dev_attr_temp6_max_hyst.dev_attr.attr,
>  		&sensor_dev_attr_temp6_max.dev_attr.attr,
> +		&sensor_dev_attr_temp6_alarm.dev_attr.attr,
>  		NULL
>  	}
>  };
> @@ -592,36 +620,42 @@ static const struct attribute_group vt82
>  	{ .attrs = vt8231_attributes_temps[5] },
>  };
> 
> -static struct attribute *vt8231_attributes_volts[6][4] = {
> +static struct attribute *vt8231_attributes_volts[6][5] = {
>  	{
>  		&sensor_dev_attr_in0_input.dev_attr.attr,
>  		&sensor_dev_attr_in0_min.dev_attr.attr,
>  		&sensor_dev_attr_in0_max.dev_attr.attr,
> +		&sensor_dev_attr_in0_alarm.dev_attr.attr,
>  		NULL
>  	}, {
>  		&sensor_dev_attr_in1_input.dev_attr.attr,
>  		&sensor_dev_attr_in1_min.dev_attr.attr,
>  		&sensor_dev_attr_in1_max.dev_attr.attr,
> +		&sensor_dev_attr_in1_alarm.dev_attr.attr,
>  		NULL
>  	}, {
>  		&sensor_dev_attr_in2_input.dev_attr.attr,
>  		&sensor_dev_attr_in2_min.dev_attr.attr,
>  		&sensor_dev_attr_in2_max.dev_attr.attr,
> +		&sensor_dev_attr_in2_alarm.dev_attr.attr,
>  		NULL
>  	}, {
>  		&sensor_dev_attr_in3_input.dev_attr.attr,
>  		&sensor_dev_attr_in3_min.dev_attr.attr,
>  		&sensor_dev_attr_in3_max.dev_attr.attr,
> +		&sensor_dev_attr_in3_alarm.dev_attr.attr,
>  		NULL
>  	}, {
>  		&sensor_dev_attr_in4_input.dev_attr.attr,
>  		&sensor_dev_attr_in4_min.dev_attr.attr,
>  		&sensor_dev_attr_in4_max.dev_attr.attr,
> +		&sensor_dev_attr_in4_alarm.dev_attr.attr,
>  		NULL
>  	}, {
>  		&dev_attr_in5_input.attr,
>  		&dev_attr_in5_min.attr,
>  		&dev_attr_in5_max.attr,
> +		&sensor_dev_attr_in5_alarm.dev_attr.attr,
>  		NULL
>  	}
>  };
> @@ -642,6 +676,8 @@ static struct attribute *vt8231_attribut
>  	&sensor_dev_attr_fan2_min.dev_attr.attr,
>  	&sensor_dev_attr_fan1_div.dev_attr.attr,
>  	&sensor_dev_attr_fan2_div.dev_attr.attr,
> +	&sensor_dev_attr_fan1_alarm.dev_attr.attr,
> +	&sensor_dev_attr_fan2_alarm.dev_attr.attr,
>  	&dev_attr_alarms.attr,
>  	&dev_attr_name.attr,
>  	NULL
> 
> 
> --
> Jean Delvare


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
