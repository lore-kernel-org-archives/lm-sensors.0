From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 29 Oct 2012 07:38:27 +0000
Subject: Re: [lm-sensors] [PATCH 3/9] hwmon: (it87) Replace macro defining tempX_type sensors with direct def
Message-Id: <20121029083827.665e199a@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1351448401-13985-4-git-send-email-linux@roeck-us.net>
In-Reply-To: <1351448401-13985-4-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 28 Oct 2012 11:19:55 -0700, Guenter Roeck wrote:
> The macro name show_sensor_offset is confusing since it related to the sensor
> type, not an offset - even more so when we introduce offset attributes later on.
> Replace it with direct definitions,

I like it. Macro-generated code is evil.

> and replace the show_sensor/set_sensor
> function names with show_type/set_type. This also resolves a checkpatch error.

"show_type" and "set_type" are confusing name, it's not clear you're
talking about temperature sensors. What about the more explicit names
"show_temp_type" and "set_temp_type"? Yes I know, 80-column limit...

> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/it87.c |   18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
> index d211c2b..82f7924 100644
> --- a/drivers/hwmon/it87.c
> +++ b/drivers/hwmon/it87.c
> @@ -556,8 +556,8 @@ static SENSOR_DEVICE_ATTR_2(temp3_input, S_IRUGO, show_temp, NULL, 2, 0);
>  static SENSOR_DEVICE_ATTR_2(temp3_min, S_IRUGOWU, show_temp, set_temp, 2, 1);
>  static SENSOR_DEVICE_ATTR_2(temp3_max, S_IRUGOWU, show_temp, set_temp, 2, 2);
>  
> -static ssize_t show_sensor(struct device *dev, struct device_attribute *attr,
> -		char *buf)
> +static ssize_t show_type(struct device *dev, struct device_attribute *attr,
> +			 char *buf)
>  {
>  	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
>  	int nr = sensor_attr->index;
> @@ -570,8 +570,9 @@ static ssize_t show_sensor(struct device *dev, struct device_attribute *attr,
>  		return sprintf(buf, "4\n");  /* thermistor */
>  	return sprintf(buf, "0\n");      /* disabled */
>  }
> -static ssize_t set_sensor(struct device *dev, struct device_attribute *attr,
> -		const char *buf, size_t count)
> +
> +static ssize_t set_type(struct device *dev, struct device_attribute *attr,
> +			const char *buf, size_t count)
>  {
>  	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
>  	int nr = sensor_attr->index;
> @@ -606,13 +607,10 @@ static ssize_t set_sensor(struct device *dev, struct device_attribute *attr,
>  	mutex_unlock(&data->update_lock);
>  	return count;
>  }
> -#define show_sensor_offset(offset)					\
> -static SENSOR_DEVICE_ATTR(temp##offset##_type, S_IRUGO | S_IWUSR,	\
> -		show_sensor, set_sensor, offset - 1);
>  
> -show_sensor_offset(1);
> -show_sensor_offset(2);
> -show_sensor_offset(3);
> +static SENSOR_DEVICE_ATTR(temp1_type, S_IRUGOWU, show_type, set_type, 0);
> +static SENSOR_DEVICE_ATTR(temp2_type, S_IRUGOWU, show_type, set_type, 1);
> +static SENSOR_DEVICE_ATTR(temp3_type, S_IRUGOWU, show_type, set_type, 2);
>  
>  /* 3 Fans */
>  


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
