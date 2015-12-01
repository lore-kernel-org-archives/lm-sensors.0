From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 01 Dec 2015 15:09:57 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (tmp102) Force wait for conversion time for the first valid data
Message-Id: <565DB845.4050709@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1448943955-2385-1-git-send-email-nm@ti.com>
 <565D3513.7050905@roeck-us.net> <565DA504.4060600@ti.com>
 <20151201142152.GA10891@ogun.home>
In-Reply-To: <20151201142152.GA10891@ogun.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nishanth Menon <nm@ti.com>, Jean Delvare <jdelvare@suse.com>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, linux-omap@vger.kernel.org, beagleboard-x15@googlegroups.com, Eduardo Valentin <edubezval@gmail.com>

On 12/01/2015 06:21 AM, Nishanth Menon wrote:
[ ... ]

>
> Hint about how the patch will look like:

Looks ok (and better).

Guenter

> diff --git a/drivers/hwmon/tmp102.c b/drivers/hwmon/tmp102.c
> index 65482624ea2c..5289aa0980a8 100644
> --- a/drivers/hwmon/tmp102.c
> +++ b/drivers/hwmon/tmp102.c
> @@ -58,6 +58,7 @@ struct tmp102 {
>   	u16 config_orig;
>   	unsigned long last_update;
>   	int temp[3];
> +	bool first_time;
>   };
>
>   /* convert left adjusted 13-bit TMP102 register value to milliCelsius */
> @@ -93,6 +94,7 @@ static struct tmp102 *tmp102_update_device(struct device *dev)
>   				tmp102->temp[i] = tmp102_reg_to_mC(status);
>   		}
>   		tmp102->last_update = jiffies;
> +		tmp102->first_time = false;
>   	}
>   	mutex_unlock(&tmp102->lock);
>   	return tmp102;
> @@ -102,6 +104,12 @@ static int tmp102_read_temp(void *dev, int *temp)
>   {
>   	struct tmp102 *tmp102 = tmp102_update_device(dev);
>
> +	/* Is it too early even to return a conversion? */
> +	if (tmp102->first_time) {
> +		dev_dbg(dev, "%s: Conversion not ready yet..\n", __func__);
> +		return -EAGAIN;
> +	}
> +
>   	*temp = tmp102->temp[0];
>
>   	return 0;
> @@ -114,6 +122,10 @@ static ssize_t tmp102_show_temp(struct device *dev,
>   	struct sensor_device_attribute *sda = to_sensor_dev_attr(attr);
>   	struct tmp102 *tmp102 = tmp102_update_device(dev);
>
> +	/* Is it too early even to return a read? */
> +	if (tmp102->first_time)
> +		return -EAGAIN;
> +
>   	return sprintf(buf, "%d\n", tmp102->temp[sda->index]);
>   }
>
> @@ -207,7 +219,9 @@ static int tmp102_probe(struct i2c_client *client,
>   		status = -ENODEV;
>   		goto fail_restore_config;
>   	}
> -	tmp102->last_update = jiffies - HZ;
> +	tmp102->last_update = jiffies;
> +	/* Mark that we are not ready with data until conversion is complete */
> +	tmp102->first_time = true;
>   	mutex_init(&tmp102->lock);
>
>   	hwmon_dev = hwmon_device_register_with_groups(dev, client->name,
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
