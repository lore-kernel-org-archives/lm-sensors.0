From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Thu, 03 Jan 2008 22:43:56 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] hwmon: (asb100) Add individual alarm
Message-Id: <477D652C.2000304@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080103232424.103f2346@hyperion.delvare>
In-Reply-To: <20080103232424.103f2346@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Looks good,

Acked-by: Hans de Goede <j.w.r.degoede@hhs.nl>

Regards,

Hans


Jean Delvare wrote:
> The new libsensors needs these individual alarm files.
> 
> I did not create alarm files for in5 and in6 as these alarms are documented
> as not working.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Mark M. Hoffman <mhoffman@lightlink.com>
> ---
>  drivers/hwmon/asb100.c |   31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> --- linux-2.6.24-rc6.orig/drivers/hwmon/asb100.c	2007-12-31 14:20:32.000000000 +0100
> +++ linux-2.6.24-rc6/drivers/hwmon/asb100.c	2007-12-31 14:42:29.000000000 +0100
> @@ -480,6 +480,25 @@ static ssize_t show_alarms(struct device
>  
>  static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
>  
> +static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
> +		char *buf)
> +{
> +	int bitnr = to_sensor_dev_attr(attr)->index;
> +	struct asb100_data *data = asb100_update_device(dev);
> +	return sprintf(buf, "%u\n", (data->alarms >> bitnr) & 1);
> +}
> +static SENSOR_DEVICE_ATTR(in0_alarm, S_IRUGO, show_alarm, NULL, 0);
> +static SENSOR_DEVICE_ATTR(in1_alarm, S_IRUGO, show_alarm, NULL, 1);
> +static SENSOR_DEVICE_ATTR(in2_alarm, S_IRUGO, show_alarm, NULL, 2);
> +static SENSOR_DEVICE_ATTR(in3_alarm, S_IRUGO, show_alarm, NULL, 3);
> +static SENSOR_DEVICE_ATTR(in4_alarm, S_IRUGO, show_alarm, NULL, 8);
> +static SENSOR_DEVICE_ATTR(fan1_alarm, S_IRUGO, show_alarm, NULL, 6);
> +static SENSOR_DEVICE_ATTR(fan2_alarm, S_IRUGO, show_alarm, NULL, 7);
> +static SENSOR_DEVICE_ATTR(fan3_alarm, S_IRUGO, show_alarm, NULL, 11);
> +static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO, show_alarm, NULL, 4);
> +static SENSOR_DEVICE_ATTR(temp2_alarm, S_IRUGO, show_alarm, NULL, 5);
> +static SENSOR_DEVICE_ATTR(temp3_alarm, S_IRUGO, show_alarm, NULL, 13);
> +
>  /* 1 PWM */
>  static ssize_t show_pwm1(struct device *dev, struct device_attribute *attr,
>  		char *buf)
> @@ -575,6 +594,18 @@ static struct attribute *asb100_attribut
>  	&sensor_dev_attr_temp4_max.dev_attr.attr,
>  	&sensor_dev_attr_temp4_max_hyst.dev_attr.attr,
>  
> +	&sensor_dev_attr_in0_alarm.dev_attr.attr,
> +	&sensor_dev_attr_in1_alarm.dev_attr.attr,
> +	&sensor_dev_attr_in2_alarm.dev_attr.attr,
> +	&sensor_dev_attr_in3_alarm.dev_attr.attr,
> +	&sensor_dev_attr_in4_alarm.dev_attr.attr,
> +	&sensor_dev_attr_fan1_alarm.dev_attr.attr,
> +	&sensor_dev_attr_fan2_alarm.dev_attr.attr,
> +	&sensor_dev_attr_fan3_alarm.dev_attr.attr,
> +	&sensor_dev_attr_temp1_alarm.dev_attr.attr,
> +	&sensor_dev_attr_temp2_alarm.dev_attr.attr,
> +	&sensor_dev_attr_temp3_alarm.dev_attr.attr,
> +
>  	&dev_attr_cpu0_vid.attr,
>  	&dev_attr_vrm.attr,
>  	&dev_attr_alarms.attr,
> 
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
