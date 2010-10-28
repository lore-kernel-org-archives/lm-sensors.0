From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 28 Oct 2010 18:27:43 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (w83795) Use standard attributes
Message-Id: <1288290463.9690.466.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101028201038.2af524a6@endymion.delvare>
In-Reply-To: <20101028201038.2af524a6@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 2010-10-28 at 14:10 -0400, Jean Delvare wrote:
> Follow the standard attribute naming for the chassis intrusion
> feature. I couldn't test the beeping (my board apparently doesn't do
> that) but the alarm works fine.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
>  w83795.c |   11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> --- a/drivers/hwmon/w83795.c	2010-10-28 17:41:07.000000000 +0200
> +++ a/drivers/hwmon/w83795.c	2010-10-28 18:06:27.000000000 +0200
> @@ -713,7 +713,7 @@ store_beep(struct device *dev, struct de
>  	return count;
>  }
>  
> -/* Write any value to clear chassis alarm */
> +/* Write 0 to clear chassis alarm */
>  static ssize_t
>  store_chassis_clear(struct device *dev,
>  		    struct device_attribute *attr, const char *buf,
> @@ -721,7 +721,10 @@ store_chassis_clear(struct device *dev,
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct w83795_data *data = i2c_get_clientdata(client);
> -	u8 val;
> +	unsigned long val;
> +
> +	if (strict_strtoul(buf, 10, &val) < 0 || val != 0)
> +		return -EINVAL;
>  
>  	mutex_lock(&data->update_lock);
>  	val = w83795_read(client, W83795_REG_CLR_CHASSIS);
> @@ -1709,8 +1712,10 @@ static const struct sensor_device_attrib
>  };
>  
>  static const struct sensor_device_attribute_2 sda_single_files[] = {
> -	SENSOR_ATTR_2(chassis, S_IWUSR | S_IRUGO, show_alarm_beep,
> +	SENSOR_ATTR_2(intrusion0_alarm, S_IWUSR | S_IRUGO, show_alarm_beep,
>  		      store_chassis_clear, ALARM_STATUS, 46),
> +	SENSOR_ATTR_2(intrusion0_beep, S_IWUSR | S_IRUGO, show_alarm_beep,
> +		      store_beep, BEEP_ENABLE, 46),
>  	SENSOR_ATTR_2(beep_enable, S_IWUSR | S_IRUGO, show_alarm_beep,
>  		      store_beep, BEEP_ENABLE, 47),

Assuming the above alarm/beep function and register/bit combinations are
correct,
	Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
