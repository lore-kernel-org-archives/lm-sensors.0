From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 02 Jan 2012 16:48:22 +0000
Subject: Re: [lm-sensors] [PATCH 3/4] drivers/hwmon/lm80.c: added error
Message-Id: <20120102164822.GC17788@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1325502203-10525-3-git-send-email-fransmeulenbroeks@gmail.com>
In-Reply-To: <1325502203-10525-3-git-send-email-fransmeulenbroeks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Frans,

On Mon, Jan 02, 2012 at 06:03:22AM -0500, Frans Meulenbroeks wrote:
> added error handling so if lm80_update_device fails
> an error is returned when reading the value through sysfs
> This is closely modeled after the way this is handled in ltc4261
> 
> Note: if update gets an error, this error is returned for all
> registers and no further reads are done.
> If a register is not accessible most likely the whole device
> is broken or disconnected and it is definitely interesting to know.
> 
> Note2: I added a macro to read and handle errors. This was felt to
> be the simplest. If someone feels it should be done using a
> subroutine, be my guest.
> 
Ok, I'll be your guest ;). See below for reasons.

> Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
> ---
> patch is against the hwmon staging tree
> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
> as retrieved on jan 2, 2012
> 
>  drivers/hwmon/lm80.c |   97 ++++++++++++++++++++++++++++++++++---------------
>  1 files changed, 67 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/hwmon/lm80.c b/drivers/hwmon/lm80.c
> index 18a0e6c..5283b27 100644
> --- a/drivers/hwmon/lm80.c
> +++ b/drivers/hwmon/lm80.c
> @@ -168,6 +168,8 @@ static ssize_t show_in_##suffix(struct device *dev, struct device_attribute *att
>  { \
>  	int nr = to_sensor_dev_attr(attr)->index; \
>  	struct lm80_data *data = lm80_update_device(dev); \
> +	if (IS_ERR(data)) \
> +		return PTR_ERR(data); \
>  	return sprintf(buf, "%d\n", IN_FROM_REG(data->value[nr])); \
>  }
>  show_in(min, in_min)
> @@ -197,6 +199,8 @@ static ssize_t show_fan_##suffix(struct device *dev, struct device_attribute *at
>  { \
>  	int nr = to_sensor_dev_attr(attr)->index; \
>  	struct lm80_data *data = lm80_update_device(dev); \
> +	if (IS_ERR(data)) \
> +		return PTR_ERR(data); \
>  	return sprintf(buf, "%d\n", FAN_FROM_REG(data->value[nr], \
>  		       DIV_FROM_REG(data->fan_div[nr]))); \
>  }
> @@ -208,6 +212,8 @@ static ssize_t show_fan_div(struct device *dev, struct device_attribute *attr,
>  {
>  	int nr = to_sensor_dev_attr(attr)->index;
>  	struct lm80_data *data = lm80_update_device(dev);
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
>  	return sprintf(buf, "%d\n", DIV_FROM_REG(data->fan_div[nr]));
>  }
>  
> @@ -271,6 +277,8 @@ static ssize_t set_fan_div(struct device *dev, struct device_attribute *attr,
>  static ssize_t show_temp_input1(struct device *dev, struct device_attribute *attr, char *buf)
>  {
>  	struct lm80_data *data = lm80_update_device(dev);
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
>  	return sprintf(buf, "%ld\n", TEMP_FROM_REG(data->temp));
>  }
>  
> @@ -278,6 +286,8 @@ static ssize_t show_temp_input1(struct device *dev, struct device_attribute *att
>  static ssize_t show_temp_##suffix(struct device *dev, struct device_attribute *attr, char *buf) \
>  { \
>  	struct lm80_data *data = lm80_update_device(dev); \
> +	if (IS_ERR(data)) \
> +		return PTR_ERR(data); \
>  	return sprintf(buf, "%d\n", TEMP_LIMIT_FROM_REG(data->value)); \
>  }
>  show_temp(hot_max, temp_hot_max);
> @@ -308,6 +318,8 @@ static ssize_t show_alarms(struct device *dev, struct device_attribute *attr,
>  			   char *buf)
>  {
>  	struct lm80_data *data = lm80_update_device(dev);
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
>  	return sprintf(buf, "%u\n", data->alarms);
>  }
>  
> @@ -316,6 +328,8 @@ static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
>  {
>  	int bitnr = to_sensor_dev_attr(attr)->index;
>  	struct lm80_data *data = lm80_update_device(dev);
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
>  	return sprintf(buf, "%u\n", (data->alarms >> bitnr) & 1);
>  }
>  
> @@ -544,55 +558,78 @@ static void lm80_init_client(struct i2c_client *client)
>  	lm80_write_value(client, LM80_REG_CONFIG, 0x01);
>  }
>  
> +/*
> +   Note: safe_lm80_read_value is a helper macro for lm80_update_device
> +	 It reads a value using lm80_read_value and jumps to abort
> +	 in case of an error.
> +	 Due to this jump and because it modifies the first arguement

s/arguement/argument/

> +	 it has to be a macro

This is exactly the reason why it should not be a macro: It uses two variables
defined outside the macro, it depends on a label defined outside the macro,
and it modifies a variable passed to it. Way too many side effects for a macro,
and just asking for trouble later on.

Sure, I understand you want to limit the changes to lm80_update_device, but you'll have
to bite the bullet here. Just make it

	reg = lm80_read_value(client, <reg>);
	if (reg < 0) {
		ret = ERR_PTR(reg);
		data->valid = 0;
		goto abort;
	}
	data-><regstore> = reg;

I don't think the dev_dbg is really needed, since the error will now be returned
to the user anyway.

> +*/
> +#define safe_lm80_read_value(var, client, reg) \
> +	{ \
> +		status = lm80_read_value(client, reg); \
> +		if (unlikely(status < 0)) { \
> +			dev_dbg(dev, \
> +				"LM80: Failed to read value: reg %d, error %d\n", \
> +				reg, status); \
> +			ret = ERR_PTR(status); \
> +			data->valid = 0; \
> +			goto abort; \
> +		} \
> +		else \
> +			var = status; \

else statement is not needed.
 
> +	} 
> +
>  static struct lm80_data *lm80_update_device(struct device *dev)
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct lm80_data *data = i2c_get_clientdata(client);
> +	struct lm80_data *ret = data;
>  	int i;
> +	int status;
> +	int tmp1, tmp2;
>  
>  	mutex_lock(&data->update_lock);
>  
> +	if (!data->valid)
> +	{
> +		/* last time failed: re-initialize the LM80 chip */
> +		lm80_init_client(client);
> +	}

{ } not needed, and at wrong location anyway (CodingStyle, chapter 3). This also duplicates
2st-time initialization. One way to avoid that would be to add a second state variable
(such as "error") to cover this case. Might be worth thinking about. Also, please add
an explanation (from your followup e-mail) describing why you do this.

On a side note, this means the chip will only get (re-)initialized if polled again.
Is that ok for your application ? Not that any alternatives would be easy to implement - a cleaner
solution would be for your system to detect that the device was pulled, unload the driver if that
happens, and reload it once the device is re-inserted. At least this is how we handle it in our
systems.

>  	if (time_after(jiffies, data->last_updated + 2 * HZ) || !data->valid) {
>  		dev_dbg(&client->dev, "Starting lm80 update\n");
>  		for (i = 0; i <= 6; i++) {
> -			data->in[i] > -			    lm80_read_value(client, LM80_REG_IN(i));
> -			data->in_min[i] > -			    lm80_read_value(client, LM80_REG_IN_MIN(i));
> -			data->in_max[i] > -			    lm80_read_value(client, LM80_REG_IN_MAX(i));
> +			safe_lm80_read_value(data->in[i], client, LM80_REG_IN(i));
> +			safe_lm80_read_value(data->in_min[i], client, LM80_REG_IN_MIN(i));
> +			safe_lm80_read_value(data->in_max[i], client, LM80_REG_IN_MAX(i));
>  		}
> -		data->fan[0] = lm80_read_value(client, LM80_REG_FAN1);
> -		data->fan_min[0] > -		    lm80_read_value(client, LM80_REG_FAN_MIN(1));
> -		data->fan[1] = lm80_read_value(client, LM80_REG_FAN2);
> -		data->fan_min[1] > -		    lm80_read_value(client, LM80_REG_FAN_MIN(2));
> -
> -		data->temp > -		    (lm80_read_value(client, LM80_REG_TEMP) << 8) |
> -		    (lm80_read_value(client, LM80_REG_RES) & 0xf0);
> -		data->temp_os_max > -		    lm80_read_value(client, LM80_REG_TEMP_OS_MAX);
> -		data->temp_os_hyst > -		    lm80_read_value(client, LM80_REG_TEMP_OS_HYST);
> -		data->temp_hot_max > -		    lm80_read_value(client, LM80_REG_TEMP_HOT_MAX);
> -		data->temp_hot_hyst > -		    lm80_read_value(client, LM80_REG_TEMP_HOT_HYST);
> -
> -		i = lm80_read_value(client, LM80_REG_FANDIV);
> +		safe_lm80_read_value(data->fan[0], client, LM80_REG_FAN1);
> +		safe_lm80_read_value(data->fan_min[0], client, LM80_REG_FAN_MIN(1));
> +		safe_lm80_read_value(data->fan[1], client, LM80_REG_FAN2);
> +		safe_lm80_read_value(data->fan_min[1], client, LM80_REG_FAN_MIN(2));
> +
> +		safe_lm80_read_value(tmp1, client, LM80_REG_TEMP);
> +		safe_lm80_read_value(tmp2, client, LM80_REG_RES);
> +		data->temp = (tmp1 << 8) | (tmp2 ^ 0xf0);
> +
> +		safe_lm80_read_value(data->temp_os_max, client, LM80_REG_TEMP_OS_MAX);
> +		safe_lm80_read_value(data->temp_os_hyst, client, LM80_REG_TEMP_OS_HYST);
> +		safe_lm80_read_value(data->temp_hot_max, client, LM80_REG_TEMP_HOT_MAX);
> +		safe_lm80_read_value(data->temp_hot_hyst, client, LM80_REG_TEMP_HOT_HYST);
> +
> +		safe_lm80_read_value(i, client, LM80_REG_FANDIV);
>  		data->fan_div[0] = (i >> 2) & 0x03;
>  		data->fan_div[1] = (i >> 4) & 0x03;
> -		data->alarms = lm80_read_value(client, LM80_REG_ALARM1) +
> -		    (lm80_read_value(client, LM80_REG_ALARM2) << 8);
> +		safe_lm80_read_value(tmp1, client, LM80_REG_ALARM1);
> +		safe_lm80_read_value(tmp2, client, LM80_REG_ALARM2);
> +		data->alarms = tmp1 + (tmp2 << 8);
>  		data->last_updated = jiffies;
>  		data->valid = 1;
>  	}
>  
> +abort:
>  	mutex_unlock(&data->update_lock);
> -
> -	return data;
> +	return ret;
>  }
>  
>  static int __init sensors_lm80_init(void)
> -- 
> 1.7.0.4
> 
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
