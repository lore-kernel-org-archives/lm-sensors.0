From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 09 Sep 2007 16:41:51 +0000
Subject: Re: [lm-sensors] [PATCH] adm1021: dynamic sysfs callbacks
Message-Id: <20070909184151.5abc783a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Krzysztof,

I'm reviewing this patch as I would like to see the adm1021 individual
alarm patch upstream as soon as possible, and it applies on top of this
one.

On Sun, 2 Sep 2007 13:37:41 +0200, Krzysztof Helt wrote:
> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> This is conversion of the driver  to the dynamic sysfs callbacks.
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> ---
> 
> This is the patch I posted some time ago. 
> This revision is redone after applying the patch which fixes negative
> value writes.
> 
> Regards,
> Krzysztof
> 
> --- linux-2.6.23.orig/drivers/hwmon/adm1021.c	2007-09-02 13:11:35.000000000 +0200
> +++ linux-2.6.23/drivers/hwmon/adm1021.c	2007-09-02 13:17:32.878031937 +0200
> @@ -25,6 +25,7 @@
>  #include <linux/jiffies.h>
>  #include <linux/i2c.h>
>  #include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
>  #include <linux/err.h>
>  #include <linux/mutex.h>
>  
> @@ -73,14 +74,6 @@ I2C_CLIENT_INSMOD_8(adm1021, adm1023, ma
>  /* write-only */
>  #define ADM1021_REG_ONESHOT		0x0F
>  
> -
> -/* Conversions. Rounding and limit checking is only done on the TO_REG
> -   variants. Note that you should be a bit careful with which arguments
> -   these macros are called: arguments may be evaluated more than once.
> -   Fixing this is just not worth it. */
> -/* Conversions  note: 1021 uses normal integer signed-byte format*/
> -#define TEMP_TO_REG(val)	SENSORS_LIMIT((val) / 1000, -128, 127)
> -
>  /* Initial values */
>  
>  /* Note: Even though I left the low and high limits named os and hyst,
> @@ -98,19 +91,16 @@ struct adm1021_data {
>  	char valid;		/* !=0 if following fields are valid */
>  	unsigned long last_updated;	/* In jiffies */
>  
> -	s8	temp_max;	/* Register values */
> -	s8	temp_hyst;
> -	s8	temp_input;
> -	s8	remote_temp_max;
> -	s8	remote_temp_hyst;
> -	s8	remote_temp_input;
> -	u8	alarms;
> -        /* Special values for ADM1023 only */
> -	u8	remote_temp_prec;
> -	u8	remote_temp_os_prec;
> -	u8	remote_temp_hyst_prec;
> -	u8	remote_temp_offset;
> -	u8	remote_temp_offset_prec;
> +	s8 temp_max[2];		/* Register values */
> +	s8 temp_min[2];
> +	s8 temp[2];
> +	u8 alarms;
> +	/* Special values for ADM1023 only */
> +	u8 remote_temp_prec;
> +	u8 remote_temp_os_prec;
> +	u8 remote_temp_hyst_prec;
> +	u8 remote_temp_offset;
> +	u8 remote_temp_offset_prec;
>  };
>  
>  static int adm1021_attach_adapter(struct i2c_adapter *adapter);
> @@ -133,19 +123,32 @@ static struct i2c_driver adm1021_driver 
>  	.detach_client	= adm1021_detach_client,
>  };
>  
> -#define show(value)							\
> -static ssize_t show_##value(struct device *dev,				\
> -			    struct device_attribute *attr, char *buf)	\
> -{									\
> -	struct adm1021_data *data = adm1021_update_device(dev);		\
> -	return sprintf(buf, "%d\n", 1000 * data->value);		\
> -}
> -show(temp_max);
> -show(temp_hyst);
> -show(temp_input);
> -show(remote_temp_max);
> -show(remote_temp_hyst);
> -show(remote_temp_input);
> +static ssize_t show_temp(struct device *dev,
> +			 struct device_attribute *devattr, char *buf)
> +{
> +	int index = to_sensor_dev_attr(devattr)->index;
> +	struct adm1021_data *data = adm1021_update_device(dev);
> +
> +	return sprintf(buf, "%d\n", 1000 * data->temp[index]);
> +}
> +
> +static ssize_t show_temp_max(struct device *dev,
> +			     struct device_attribute *devattr, char *buf)
> +{
> +	int index = to_sensor_dev_attr(devattr)->index;
> +	struct adm1021_data *data = adm1021_update_device(dev);
> +
> +	return sprintf(buf, "%d\n", 1000 * data->temp_max[index]);
> +}
> +
> +static ssize_t show_temp_min(struct device *dev,
> +			     struct device_attribute *devattr, char *buf)
> +{
> +	int index = to_sensor_dev_attr(devattr)->index;
> +	struct adm1021_data *data = adm1021_update_device(dev);
> +
> +	return sprintf(buf, "%d\n", 1000 * data->temp_min[index]);
> +}
>  
>  static ssize_t show_alarms(struct device *dev,
>  			   struct device_attribute *attr,
> @@ -155,35 +158,52 @@ static ssize_t show_alarms(struct device
>  	return sprintf(buf, "%u\n", data->alarms);
>  }
>  
> -#define set(value, reg)							\
> -static ssize_t set_##value(struct device *dev,				\
> -			   struct device_attribute *attr,		\
> -			   const char *buf, size_t count)		\
> -{									\
> -	struct i2c_client *client = to_i2c_client(dev);			\
> -	struct adm1021_data *data = i2c_get_clientdata(client);		\
> -	long temp = simple_strtol(buf, NULL, 10);			\
> -									\
> -	mutex_lock(&data->update_lock);					\
> -	data->value = TEMP_TO_REG(temp);				\
> -	if (!read_only)							\
> -		i2c_smbus_write_byte_data(client, reg, data->value);	\
> -	mutex_unlock(&data->update_lock);				\
> -	return count;							\
> -}
> -set(temp_max, ADM1021_REG_TOS_W);
> -set(temp_hyst, ADM1021_REG_THYST_W);
> -set(remote_temp_max, ADM1021_REG_REMOTE_TOS_W);
> -set(remote_temp_hyst, ADM1021_REG_REMOTE_THYST_W);
> -
> -static DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_max, set_temp_max);
> -static DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO, show_temp_hyst, set_temp_hyst);
> -static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_input, NULL);
> -static DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_remote_temp_max, set_remote_temp_max);
> -static DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_remote_temp_hyst, set_remote_temp_hyst);
> -static DEVICE_ATTR(temp2_input, S_IRUGO, show_remote_temp_input, NULL);
> -static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
> +static ssize_t set_temp_max(struct device *dev,
> +			    struct device_attribute *devattr,
> +			    const char *buf, size_t count)
> +{
> +	int index = to_sensor_dev_attr(devattr)->index;
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct adm1021_data *data = i2c_get_clientdata(client);
> +	long temp = simple_strtol(buf, NULL, 10) / 1000;
>  
> +	mutex_lock(&data->update_lock);
> +	data->temp_max[index] = SENSORS_LIMIT(temp, -128, 127);

The !read_only test was lost in the process.

> +	i2c_smbus_write_byte_data(client, ADM1021_REG_TOS_W + 2 * index, temp);

This construct is dangerous, you silently rely on the fact that
ADM1021_REG_REMOTE_TOS_R = ADM1021_REG_TOS_W + 2. It would be much
cleaner to replace:

#define ADM1021_REG_TOS_W		0x0B
#define ADM1021_REG_REMOTE_TOS_W	0x0D

with:

/* For nr in 0-1 */
#define ADM1021_REG_TOS_W(nr)		(0x0B + (nr * 2))

That way it is explicit and this less error-prone. And of course, same
for all the other register pairs.

Also, you must write data->temp_max[index], not temp, otherwise the
call to SENSORS_LIMIT() is bypassed.

> +	mutex_unlock(&data->update_lock);
> +
> +	return count;
> +}
> +
> +static ssize_t set_temp_min(struct device *dev,
> +			    struct device_attribute *devattr,
> +			    const char *buf, size_t count)
> +{
> +	int index = to_sensor_dev_attr(devattr)->index;
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct adm1021_data *data = i2c_get_clientdata(client);
> +	long temp = simple_strtol(buf, NULL, 10) / 1000;
> +
> +	mutex_lock(&data->update_lock);
> +	data->temp_max[index] = SENSORS_LIMIT(temp, -128, 127);

Same here, !read_only got lost.

> +	i2c_smbus_write_byte_data(client,
> +				  ADM1021_REG_THYST_W + 2 * index, temp);

And write data->temp_max[index] instead of temp.

> +	mutex_unlock(&data->update_lock);
> +
> +	return count;
> +}
> +
> +static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);
> +static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_max,
> +			  set_temp_max, 0);
> +static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO, show_temp_min,
> +			  set_temp_min, 0);
> +static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 1);
> +static SENSOR_DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_temp_max,
> +			  set_temp_max, 1);
> +static SENSOR_DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_temp_min,
> +			  set_temp_min, 1);
> +static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
>  
>  static int adm1021_attach_adapter(struct i2c_adapter *adapter)
>  {
> @@ -193,12 +213,12 @@ static int adm1021_attach_adapter(struct
>  }
>  
>  static struct attribute *adm1021_attributes[] = {
> -	&dev_attr_temp1_max.attr,
> -	&dev_attr_temp1_min.attr,
> -	&dev_attr_temp1_input.attr,
> -	&dev_attr_temp2_max.attr,
> -	&dev_attr_temp2_min.attr,
> -	&dev_attr_temp2_input.attr,
> +	&sensor_dev_attr_temp1_max.dev_attr.attr,
> +	&sensor_dev_attr_temp1_min.dev_attr.attr,
> +	&sensor_dev_attr_temp1_input.dev_attr.attr,
> +	&sensor_dev_attr_temp2_max.dev_attr.attr,
> +	&sensor_dev_attr_temp2_min.dev_attr.attr,
> +	&sensor_dev_attr_temp2_input.dev_attr.attr,
>  	&dev_attr_alarms.attr,
>  	NULL
>  };
> @@ -370,21 +390,22 @@ static struct adm1021_data *adm1021_upda
>  
>  	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
>  	    || !data->valid) {
> +		int i;
> +
>  		dev_dbg(&client->dev, "Starting adm1021 update\n");
>  
> -		data->temp_input = i2c_smbus_read_byte_data(client,
> -						ADM1021_REG_TEMP);
> -		data->temp_max = i2c_smbus_read_byte_data(client,
> -						ADM1021_REG_TOS_R);
> -		data->temp_hyst = i2c_smbus_read_byte_data(client,
> -						ADM1021_REG_THYST_R);
> -		data->remote_temp_input = i2c_smbus_read_byte_data(client,
> -						ADM1021_REG_REMOTE_TEMP);
> -		data->remote_temp_max = i2c_smbus_read_byte_data(client,
> -						ADM1021_REG_REMOTE_TOS_R);
> -		data->remote_temp_hyst = i2c_smbus_read_byte_data(client,
> -						ADM1021_REG_REMOTE_THYST_R);
> -		data->alarms = i2c_smbus_read_byte_data(client,
> +		for (i = 0; i < 2; i++) {
> +			data->temp[i] = i2c_smbus_read_byte_data(client,
> +						ADM1021_REG_TEMP + i);
> +			data->temp_max[i] > +				i2c_smbus_read_byte_data(client,
> +						ADM1021_REG_TOS_R + 2 * i);
> +			data->temp_min[i] > +				i2c_smbus_read_byte_data(client,
> +						ADM1021_REG_THYST_R + 2 * i);
> +		}
> +		data->alarms > +			i2c_smbus_read_byte_data(client,
>  						ADM1021_REG_STATUS) & 0x7c;

This last coding-style change is not welcome. I prefer the original
way, and anyway coding-style cleanups shouldn't be mixed with real code
changes.

>  		if (data->type = adm1023) {
>  			data->remote_temp_prec > 

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
