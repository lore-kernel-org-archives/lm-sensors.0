From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 12 Oct 2007 20:26:44 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/sis5595: Add individual alarm files
Message-Id: <20071012222644.7c860677@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <470E6494.7000408@gmail.com>
In-Reply-To: <470E6494.7000408@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ivo,

On Fri, 12 Oct 2007 17:12:50 +0200, Ivo Manca wrote:
> Jean Delvare wrote:
> > Your mailer destroyed the patch formatting :( Can you please fix it or
> > resend the patch as an attachment?
> >
> > Thanks,
> 
> Sure. It's attached now, hope that works better.

Yes, it's better but now there's another problem: you based your patch
on 2.6.22.9, but the sis5595 driver changed a lot in 2.6.23, so I still
can't apply it. Would you be so kind and send a new patch that would
apply on top of 2.6.23?

Still, I can review the patch:

> diff -ubrN linux-2.6.22.9.orig/drivers/hwmon/sis5595.c linux-2.6.22.9/drivers/hwmon/sis5595.c
> --- linux-2.6.22.9.orig/drivers/hwmon/sis5595.c	2007-10-11 19:38:11.000000000 +0200
> +++ linux-2.6.22.9/drivers/hwmon/sis5595.c	2007-10-11 19:41:56.000000000 +0200
> @@ -62,6 +62,7 @@
>  #include <linux/jiffies.h>
>  #include <linux/mutex.h>
>  #include <linux/sysfs.h>
> +#include <linux/hwmon-sysfs.h>
>  #include <asm/io.h>
>  
>  
> @@ -473,26 +474,47 @@
>  }
>  static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
>  
> +static ssize_t show_alarm(struct device *dev, struct device_attribute *da, char *buf)

Remember that line length should never exceed 80 columns.

> +{
> +	struct sis5595_data *data = sis5595_update_device(dev);
> +	int nr = to_sensor_dev_attr(da)->index;
> +	return sprintf(buf, "%u\n", (data->alarms >> nr) & 1);
> +}
> +	static SENSOR_DEVICE_ATTR(in0_alarm, S_IRUGO, show_alarm, NULL, 0);
> +	static SENSOR_DEVICE_ATTR(in1_alarm, S_IRUGO, show_alarm, NULL, 1);
> +	static SENSOR_DEVICE_ATTR(in2_alarm, S_IRUGO, show_alarm, NULL, 2);
> +	static SENSOR_DEVICE_ATTR(in3_alarm, S_IRUGO, show_alarm, NULL, 3);
> +	static SENSOR_DEVICE_ATTR(in4_alarm, S_IRUGO, show_alarm, NULL, 15);
> +	static SENSOR_DEVICE_ATTR(fan1_alarm, S_IRUGO, show_alarm, NULL, 6);
> +	static SENSOR_DEVICE_ATTR(fan2_alarm, S_IRUGO, show_alarm, NULL, 7);
> +	static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO, show_alarm, NULL, 15);

Bad indentation, all these "static SENSOR_DEVICE_ATTR" lines shouldn't
be indented.

> +
>  static struct attribute *sis5595_attributes[] = {
>  	&dev_attr_in0_input.attr,
>  	&dev_attr_in0_min.attr,
>  	&dev_attr_in0_max.attr,
> +	&sensor_dev_attr_in0_alarm.dev_attr.attr,
>  	&dev_attr_in1_input.attr,
>  	&dev_attr_in1_min.attr,
>  	&dev_attr_in1_max.attr,
> +	&sensor_dev_attr_in1_alarm.dev_attr.attr,
>  	&dev_attr_in2_input.attr,
>  	&dev_attr_in2_min.attr,
>  	&dev_attr_in2_max.attr,
> +	&sensor_dev_attr_in2_alarm.dev_attr.attr,
>  	&dev_attr_in3_input.attr,
>  	&dev_attr_in3_min.attr,
>  	&dev_attr_in3_max.attr,
> +	&sensor_dev_attr_in3_alarm.dev_attr.attr,
>  
>  	&dev_attr_fan1_input.attr,
>  	&dev_attr_fan1_min.attr,
>  	&dev_attr_fan1_div.attr,
> +	&sensor_dev_attr_fan1_alarm.dev_attr.attr,
>  	&dev_attr_fan2_input.attr,
>  	&dev_attr_fan2_min.attr,
>  	&dev_attr_fan2_div.attr,
> +	&sensor_dev_attr_fan2_alarm.dev_attr.attr,
>  
>  	&dev_attr_alarms.attr,
>  	NULL
> @@ -506,10 +528,12 @@
>  	&dev_attr_in4_input.attr,
>  	&dev_attr_in4_min.attr,
>  	&dev_attr_in4_max.attr,
> +	&sensor_dev_attr_in4_alarm.dev_attr.attr,
>  
>  	&dev_attr_temp1_input.attr,
>  	&dev_attr_temp1_max.attr,
>  	&dev_attr_temp1_max_hyst.attr,
> +	&sensor_dev_attr_temp1_alarm.dev_attr.attr,
>  	NULL
>  };
>  
> @@ -617,7 +641,9 @@
>  		 || (err = device_create_file(&new_client->dev,
>  					      &dev_attr_in4_min))
>  		 || (err = device_create_file(&new_client->dev,
> -					      &dev_attr_in4_max)))
> +					      &dev_attr_in4_max))
> +		 || (err = device_create_file(&new_client->dev,
> +					      &sensor_dev_attr_in4_alarm.dev_attr)))
>  			goto exit_remove_files;
>  	} else {
>  		if ((err = device_create_file(&new_client->dev,
> @@ -625,7 +651,9 @@
>  		 || (err = device_create_file(&new_client->dev,
>  					      &dev_attr_temp1_max))
>  		 || (err = device_create_file(&new_client->dev,
> -					      &dev_attr_temp1_max_hyst)))
> +					      &dev_attr_temp1_max_hyst))
> +		 || (err = device_create_file(&new_client->dev,
> +					      &sensor_dev_attr_temp1_alarm.dev_attr)))
>  			goto exit_remove_files;
>  	}
>  

Other than that, your patch looks good.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
