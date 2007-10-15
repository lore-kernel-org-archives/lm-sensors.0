From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 15 Oct 2007 18:34:40 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon/sis5595: Add individual alarm
Message-Id: <20071015203440.6a7fc46e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <47134E7D.7030703@gmail.com>
In-Reply-To: <47134E7D.7030703@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Ivo,

On Mon, 15 Oct 2007 13:26:53 +0200, Ivo Manca wrote:
> From: Ivo Manca <pinkel@gmail.com>
> 
> Add individual alarm files needed by the new libsensors.
> 
> Signed-off-by: Ivo Manca <pinkel@gmail.com>
> ---
>  sis5595.c |   31 +++++++++++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
> 
> --- linux-2.6.23.1.orig/drivers/hwmon/sis5595.c	2007-10-12 18:43:44.000000000 +0200
> +++ linux-2.6.23.1/drivers/hwmon/sis5595.c	2007-10-15 12:36:53.562500000 +0200
> @@ -435,6 +435,22 @@ static ssize_t show_alarms(struct device
>  }
>  static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
>  
> +static ssize_t show_alarm(struct device *dev, struct device_attribute *da,
> +			  char *buf)
> +{
> +	struct sis5595_data *data = sis5595_update_device(dev);
> +	int nr = to_sensor_dev_attr(da)->index;
> +	return sprintf(buf, "%u\n", (data->alarms >> nr) & 1);
> +}
> +static SENSOR_DEVICE_ATTR(in0_alarm, S_IRUGO, show_alarm, NULL, 0);
> +static SENSOR_DEVICE_ATTR(in1_alarm, S_IRUGO, show_alarm, NULL, 1);
> +static SENSOR_DEVICE_ATTR(in2_alarm, S_IRUGO, show_alarm, NULL, 2);
> +static SENSOR_DEVICE_ATTR(in3_alarm, S_IRUGO, show_alarm, NULL, 3);
> +static SENSOR_DEVICE_ATTR(in4_alarm, S_IRUGO, show_alarm, NULL, 15);
> +static SENSOR_DEVICE_ATTR(fan1_alarm, S_IRUGO, show_alarm, NULL, 6);
> +static SENSOR_DEVICE_ATTR(fan2_alarm, S_IRUGO, show_alarm, NULL, 7);
> +static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO, show_alarm, NULL, 15);
> +
>  static ssize_t show_name(struct device *dev, struct device_attribute *attr,
>  			 char *buf)
>  {
> @@ -447,22 +463,27 @@ static struct attribute *sis5595_attribu
>  	&sensor_dev_attr_in0_input.dev_attr.attr,
>  	&sensor_dev_attr_in0_min.dev_attr.attr,
>  	&sensor_dev_attr_in0_max.dev_attr.attr,
> +	&sensor_dev_attr_in0_alarm.dev_attr.attr,
>  	&sensor_dev_attr_in1_input.dev_attr.attr,
>  	&sensor_dev_attr_in1_min.dev_attr.attr,
>  	&sensor_dev_attr_in1_max.dev_attr.attr,
> +	&sensor_dev_attr_in1_alarm.dev_attr.attr,
>  	&sensor_dev_attr_in2_input.dev_attr.attr,
>  	&sensor_dev_attr_in2_min.dev_attr.attr,
>  	&sensor_dev_attr_in2_max.dev_attr.attr,

  CC [M]  drivers/hwmon/sis5595.o
drivers/hwmon/sis5595.c:447: warning: ‘sensor_dev_attr_in2_alarm’ defined but not used

>  	&sensor_dev_attr_in3_input.dev_attr.attr,
>  	&sensor_dev_attr_in3_min.dev_attr.attr,
>  	&sensor_dev_attr_in3_max.dev_attr.attr,
> +	&sensor_dev_attr_in3_alarm.dev_attr.attr,
>  
>  	&sensor_dev_attr_fan1_input.dev_attr.attr,
>  	&sensor_dev_attr_fan1_min.dev_attr.attr,
>  	&sensor_dev_attr_fan1_div.dev_attr.attr,
> +	&sensor_dev_attr_fan1_alarm.dev_attr.attr,
>  	&sensor_dev_attr_fan2_input.dev_attr.attr,
>  	&sensor_dev_attr_fan2_min.dev_attr.attr,
>  	&sensor_dev_attr_fan2_div.dev_attr.attr,
> +	&sensor_dev_attr_fan2_alarm.dev_attr.attr,
>  
>  	&dev_attr_alarms.attr,
>  	&dev_attr_name.attr,
> @@ -477,10 +498,12 @@ static struct attribute *sis5595_attribu
>  	&sensor_dev_attr_in4_input.dev_attr.attr,
>  	&sensor_dev_attr_in4_min.dev_attr.attr,
>  	&sensor_dev_attr_in4_max.dev_attr.attr,
> +	&sensor_dev_attr_in4_alarm.dev_attr.attr,
>  
>  	&dev_attr_temp1_input.attr,
>  	&dev_attr_temp1_max.attr,
>  	&dev_attr_temp1_max_hyst.attr,
> +	&sensor_dev_attr_temp1_alarm.dev_attr.attr,
>  	NULL
>  };
>  
> @@ -545,7 +568,9 @@ static int __devinit sis5595_probe(struc
>  		 || (err = device_create_file(&pdev->dev,
>  					&sensor_dev_attr_in4_min.dev_attr))
>  		 || (err = device_create_file(&pdev->dev,
> -					&sensor_dev_attr_in4_max.dev_attr)))
> +					&sensor_dev_attr_in4_max.dev_attr))
> +		 || (err = device_create_file(&pdev->dev,
> +					&sensor_dev_attr_in4_alarm.dev_attr)))
>  			goto exit_remove_files;
>  	} else {
>  		if ((err = device_create_file(&pdev->dev,
> @@ -553,7 +578,9 @@ static int __devinit sis5595_probe(struc
>  		 || (err = device_create_file(&pdev->dev,
>  					      &dev_attr_temp1_max))
>  		 || (err = device_create_file(&pdev->dev,
> -					      &dev_attr_temp1_max_hyst)))
> +					      &dev_attr_temp1_max_hyst))
> +		 || (err = device_create_file(&pdev->dev,
> +				&sensor_dev_attr_temp1_alarm.dev_attr)))
>  			goto exit_remove_files;
>  	}

All the rest looks OK.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
