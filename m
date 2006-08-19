From: jim.cromie@gmail.com (Jim Cromie)
Date: Sat, 19 Aug 2006 15:04:33 +0000
Subject: [lm-sensors] [PATCH] f75383 /f75384 driver
Message-Id: <44E72881.705@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1155997256.19938.6.camel@rapsure.rapsure.net>
In-Reply-To: <1155997256.19938.6.camel@rapsure.rapsure.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Brian Beardall wrote:
> This is the patch for the f75383/4 driver. The f75383.diff applies to
> the kernel, and the lm_sensors-f75383.diff applies to lm_sensors. I
> would just like to have the code reviewed so that changes can be made.
> Hopefully within this week because school starts again on Aug. 28th, and
> that will make the schedule tight for hacking on this driver. Both
> patches are -p1 patches. If you have an ECS mainboard that is only about
> 2 years old it will most likely have this temperature sensor chip.
>   
>   


These and other repeated callbacks can be folded down to 1 copy -
theyre already extracting the index, which you can pre-initialize below..

> +
> +static ssize_t show_temp1(struct device *dev, struct device_attribute *devattr,
> +			   char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct f75383_data *data = f75383_update_device(dev);
> +	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp1[attr->index]));
> +}
> +
> +static ssize_t show_temp2(struct device *dev, struct device_attribute *devattr,
> +			   char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	struct f75383_data *data = f75383_update_device(dev);
> +	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp2[attr->index]));
> +}
>   

Youre already taking care of indexing in declarations too !

> +static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp1, NULL, 0);
> +static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO, show_temp1,
> +	set_temp1, 1);
> +static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp1,
> +	set_temp1, 2);
>   


> +static SENSOR_DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_temp2,
> +	set_temp2, 1);
> +static SENSOR_DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_temp2,
> +	set_temp2, 2);
>   

Unless Ive missed something, above should be following:   dropped 1,2 on 
function-names


> +static SENSOR_DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_temp,
> +	set_temp, 1);
> +static SENSOR_DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_temp,
> +	set_temp, 2);
>   


Maybe I'll be able to take another look later..

hth
jimc

